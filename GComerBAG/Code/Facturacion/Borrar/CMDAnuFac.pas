unit CMDAnuFac;

interface

uses
  Windows, SysUtils, Classes, DB, DBTables;

type
  TDMDAnuFac = class(TDataModule)
    QFactura: TQuery;
    QFacturaAbono: TQuery;
    QContAbonos: TQuery;
    QTipoIva: TQuery;
    QInsertAbono: TQuery;
    QInsertAbonoTexto: TQuery;
    QInsertFacturaAbono: TQuery;
    QSalidasFactura: TQuery;
    QInsertSalidasFactura: TQuery;
    QCabeceraEDI: TQuery;
    QInsertCabeceraEDI: TQuery;
    QLineaEDI: TQuery;
    QInsertLineaEDI: TQuery;
    QCabIvaEDI: TQuery;
    QInsertCabIvaEDI: TQuery;
    QClienteEDI: TQuery;
    QLinIvaEDI: TQuery;
    QInsertLinIvaEDI: TQuery;
    qryUpdateContador: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCliente, sMsg: string;
    iFactura, iAbono: integer;
    dFechaFactura, dFechaAbono: TDateTime;

    function  PuedoAnularFactura: Boolean;
    function  AnularFactura: Boolean;
    function  ObtenerNumeroAbono: boolean;
    procedure CrearAbono;
    procedure LineasAbono;
    procedure RelacionAlbaranes;
    procedure  FacturacionEDI;
    function  TieneFacturacionEDI: boolean;
    function  InsertCabeceraEDI: boolean;
    procedure InsertLineasEDI;
    procedure InsertCabIvaEDI;
    procedure InsertLinIvaEDI;
  public
    { Public declarations }
    function  Anular( const AEmpresa: string; const AFactura: Integer;
                      const AFechaFactura, AFechaAbono: TDateTime;
                      var AMsgError: string ): Boolean;
    function  NumeroAbono( const AEmpresa: string; const AFactura: Integer;
                           const AFecha: TDateTime; var AFechaMin: TDateTime ): Integer;
  end;

var
  DMDAnuFac: TDMDAnuFac;

implementation

{$R *.dfm}

uses UDMBaseDatos, Variants, UDMFacturacion;

procedure TDMDAnuFac.DataModuleCreate(Sender: TObject);
begin
  with QFactura do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_facturas ');
    SQL.Add(' where empresa_f = :empresa ');
    SQL.Add(' and fecha_factura_f = :fecha ');
    SQL.Add(' and n_factura_f = :factura ');
    RequestLive:= True;
    Prepare;
  end;
  with QContAbonos do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_facturas_serie ');
    SQL.Add(' where exists ');
    SQL.Add(' ( ');
    SQL.Add('   select *  from frf_empresas_serie ');
    SQL.Add('   where cod_empresa_es = :empresa ');
    SQL.Add('   and anyo_es = :anyo ');
    SQL.Add('   and cod_serie_es = cod_serie_fs ');
    SQL.Add('   and anyo_es = anyo_fs ');
    SQL.Add(' ) ');
    Prepare;
  end;
  with qryUpdateContador do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_facturas_serie ');
    SQL.Add(' where anyo_fs = :anyo ');
    SQL.Add(' and cod_serie_fs = :serie ');
    Prepare;
  end;
  with QTipoIva do
  begin
    SQL.Clear;
    SQL.Add(' select tipo_impuesto_f ');
    SQL.Add(' from frf_facturas ');
    SQL.Add(' where empresa_f = :empresa ');
    SQL.Add(' and fecha_factura_f = :fecha ');
    SQL.Add(' and n_factura_f = :factura ');
    RequestLive:= False;
    Prepare;
  end;

  with QFacturaAbono do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_facturas_abono ');
    SQL.Add(' where empresa_fa = :empresa ');
    SQL.Add(' and fecha_factura_fa = :fecha ');
    SQL.Add(' and n_factura_fa = :factura ');
    RequestLive:= False;
    Prepare;
  end;
  with QInsertFacturaAbono do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_facturas_abono ');
    RequestLive:= True;
    Prepare;
  end;

  with QInsertAbono do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_facturas ');
    RequestLive:= True;
    Prepare;
  end;
  with QInsertAbonoTexto do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_fac_manual ');
    RequestLive:= True;
    Prepare;
  end;

  with QSalidasFactura do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_salidas_c ');
    SQL.Add(' where empresa_fac_sc = :empresa ');
    SQL.Add(' and fecha_factura_sc = :fecha ');
    SQL.Add(' and n_factura_sc = :factura ');
    RequestLive:= True;
    Prepare;
  end;
  with QInsertSalidasFactura do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_facturas_sal ');
    RequestLive:= True;
    Prepare;
  end;

  with QClienteEDI do
  begin
    SQL.Clear;
    SQL.Add(' select NVL(edi_c, ''N'') edi_c');
    SQL.Add(' from frf_clientes ');
    SQL.Add(' where empresa_c = :empresa ');
    SQL.Add(' and cliente_c = :cliente ');
    RequestLive:= False;
    Prepare;
  end;
  with QCabeceraEDI do
  begin
    SQL.Add(' select * ');
    SQL.Add(' from frf_facturas_edi_c ');
    SQL.Add(' where empresa_fec = :empresa ');
    SQL.Add(' and fecha_factura_fec = :fecha ');
    SQL.Add(' and factura_fec = :factura ');
    RequestLive:= False;
    Prepare;
  end;
  with QInsertCabeceraEDI do
  begin
    SQL.Add(' select * ');
    SQL.Add(' from frf_facturas_edi_c ');
    RequestLive:= True;
    Prepare;
  end;
  with QLineaEDI do
  begin
    SQL.Add(' select * ');
    SQL.Add(' from frf_facturas_edi_l ');
    SQL.Add(' where empresa_fel = :empresa ');
    SQL.Add(' and fecha_factura_fel = :fecha ');
    SQL.Add(' and factura_fel = :factura ');
    RequestLive:= False;
    Prepare;
  end;
  with QInsertLineaEDI do
  begin
    SQL.Add(' select * ');
    SQL.Add(' from frf_facturas_edi_l ');
    RequestLive:= True;
    Prepare;
  end;
  with QCabIvaEDI do
  begin
    SQL.Add(' select * ');
    SQL.Add(' from frf_impues_edi_c ');
    SQL.Add(' where empresa_iec = :empresa ');
    SQL.Add(' and fecha_factura_iec = :fecha ');
    SQL.Add(' and factura_iec = :factura ');
    RequestLive:= False;
    Prepare;
  end;
  with QInsertCabIvaEDI do
  begin
    SQL.Add(' select * ');
    SQL.Add(' from frf_impues_edi_c ');
    RequestLive:= True;
    Prepare;
  end;
  with QLinIvaEDI do
  begin
    SQL.Add(' select * ');
    SQL.Add(' from frf_impues_edi_l ');
    SQL.Add(' where empresa_iel = :empresa ');
    SQL.Add(' and fecha_factura_iel = :fecha ');
    SQL.Add(' and factura_iel = :factura ');
    RequestLive:= False;
    Prepare;
  end;
  with QInsertLinIvaEDI do
  begin
    SQL.Add(' select * ');
    SQL.Add(' from frf_impues_edi_l ');
    RequestLive:= True;
    Prepare;
  end;
end;

procedure TDMDAnuFac.DataModuleDestroy(Sender: TObject);
begin
  QFactura.Close;
  if QFactura.Prepared then
    QFactura.UnPrepare;

  QContAbonos.Close;
  if QContAbonos.Prepared then
    QContAbonos.UnPrepare;

  QTipoIva.Close;
  if QTipoIva.Prepared then
    QTipoIva.UnPrepare;

  QFacturaAbono.Close;
  if QFacturaAbono.Prepared then
    QFacturaAbono.UnPrepare;

  QInsertFacturaAbono.Close;
  if QInsertFacturaAbono.Prepared then
    QInsertFacturaAbono.UnPrepare;

  QInsertAbono.Close;
  if QInsertAbono.Prepared then
    QInsertAbono.UnPrepare;
  QInsertAbonoTexto.Close;
  if QInsertAbonoTexto.Prepared then
    QInsertAbonoTexto.UnPrepare;

  QSalidasFactura.Close;
  if QSalidasFactura.Prepared then
    QSalidasFactura.UnPrepare;
  QInsertSalidasFactura.Close;
  if QInsertSalidasFactura.Prepared then
    QInsertSalidasFactura.UnPrepare;

  QCabeceraEDI.Close;
  if QCabeceraEDI.Prepared then
    QCabeceraEDI.UnPrepare;
  QInsertCabeceraEDI.Close;
  if QInsertCabeceraEDI.Prepared then
    QInsertCabeceraEDI.UnPrepare;
  QLineaEDI.Close;
  if QLineaEDI.Prepared then
    QLineaEDI.UnPrepare;
  QInsertLineaEDI.Close;
  if QInsertLineaEDI.Prepared then
    QInsertLineaEDI.UnPrepare;
  QCabIvaEDI.Close;
  if QCabIvaEDI.Prepared then
    QCabIvaEDI.UnPrepare;
  QInsertCabIvaEDI.Close;
  if QInsertCabIvaEDI.Prepared then
    QInsertCabIvaEDI.UnPrepare;
  QLinIvaEDI.Close;
  if QLinIvaEDI.Prepared then
    QLinIvaEDI.UnPrepare;
  QInsertLinIvaEDI.Close;
  if QInsertLinIvaEDI.Prepared then
    QInsertLinIvaEDI.UnPrepare;
end;

function TDMDAnuFac.NumeroAbono( const AEmpresa: string; const AFactura: Integer;
                                 const AFecha: TDateTime; var AFechaMin: TDateTime ): Integer;
var
  bPeninsula: boolean;
  iYear, iMOnth, iDay: Word;
begin
  AFechaMin:= Date;
  DecodeDate( AFecha, iYear, iMOnth, iDay );
  with QTipoIva do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('factura').AsInteger:= AFactura;
    ParamByName('fecha').AsDate:= AFecha;
    Open;
    if fields[0].AsString <> '' then
    begin
      bPeninsula:= UpperCase( Copy( fields[0].AsString, 1 ,1 ) ) = 'I';
    end
    else
    begin
      Close;
      result:= -1;
      exit;
    end;
    Close;
  end;
  with QContAbonos do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('anyo').AsInteger:= iYear;
    Open;
    if IsEmpty then
    begin
      Close;
      result:= -1;
      exit;
    end
    else
    begin
      if bPeninsula then
      begin
        result:= FieldByName('abn_iva_fs').AsInteger + 1;
        AFechaMin:= FieldByName('fecha_abn_iva_fs').AsDateTime;
      end
      else
      begin
        result:= FieldByName('abn_igic_fs').AsInteger + 1;
        AFechaMin:= FieldByName('fecha_abn_igic_fs').AsDateTime;
      end;
    end;
    Close;
  end;
end;

function TDMDAnuFac.PuedoAnularFactura: Boolean;
begin
  result:= False;
  with QFactura do
  begin
    Close;
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('factura').AsInteger:= iFactura;
    ParamByName('fecha').AsDate:= dFechaFactura;
    Open;
    if IsEmpty then
    begin
      Close;
      sMsg:= 'No existe la factura.';
      Exit;
    end;
    if FieldByName('tipo_factura_f').AsString <> '380' then
    begin
      Close;
      sMsg:= 'Solo podemos anular facturas.' + #13 + #10 +
                  'No podemos anular un abono.';
      Exit;
    end;
    if FieldByName('concepto_f').AsString <> 'A' then
    begin
      Close;
      sMsg:= 'Solo podemos anular facturas automaticas.' + #13 + #10 +
                  'No podemos anular una factura manual.';
      Exit;
    end;
  end;
  with QFacturaAbono do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('factura').AsInteger:= iFactura;
    ParamByName('fecha').AsDate:= dFechaFactura;
    OPen;
    if not IsEmpty then
    begin
      Close;
      sMsg:= 'La factura ya ha sido anulada.';
      Exit;
    end;
    Close;
  end;
  sCliente:= QFactura.FieldByName('cliente_fac_f').AsString;

  sMsg:= 'OK, sin errores.';
  result:= True;
end;

procedure TDMDAnuFac.LineasAbono;
begin
  (*TODO*)
  (*Cuando se guarden las lineas de la factura*)
end;

procedure TDMDAnuFac.CrearAbono;
//var
  //dFechaAbono: TDateTime;
begin
  with QInsertAbono do
  begin
    Open;
    Insert;

    FieldByName('empresa_f').AsString:= QFactura.FieldByName('empresa_f').AsString;
    FieldByName('n_factura_f').AsInteger:= iAbono;
    FieldByName('fecha_factura_f').AsDateTime:= dFechaAbono;

    FieldByName('tipo_factura_f').AsString:= '381';
    FieldByName('concepto_f').AsString:= 'A';
    FieldByName('anulacion_f').AsInteger:= 1;

    FieldByName('cliente_sal_f').AsString:= QFactura.FieldByName('cliente_sal_f').AsString;
    FieldByName('cliente_fac_f').AsString:= QFactura.FieldByName('cliente_fac_f').AsString;
    FieldByName('moneda_f').AsString:= QFactura.FieldByName('moneda_f').AsString;
    FieldByName('tipo_impuesto_f').AsString:= QFactura.FieldByName('tipo_impuesto_f').AsString;
    FieldByName('porc_impuesto_f').AsFloat:= QFactura.FieldByName('porc_impuesto_f').AsFloat;

    FieldByName('importe_neto_f').AsFloat:= -1 * QFactura.FieldByName('importe_neto_f').AsFloat;
    FieldByName('total_impuesto_f').AsFloat:= -1 * QFactura.FieldByName('total_impuesto_f').AsFloat;
    FieldByName('importe_total_f').AsFloat:= -1 * QFactura.FieldByName('importe_total_f').AsFloat;
    FieldByName('importe_euros_f').AsFloat:= -1 * QFactura.FieldByName('importe_euros_f').AsFloat;
    FieldByName('prevision_cobro_f').AsDateTime:= FieldByName('fecha_factura_f').AsDateTime;

    FieldByName('contabilizado_f').AsString:= 'N';
    FieldByName('contab_cobro_f').AsString:= 'N';

    Post;
  end;

  //Texto del abono
  with QInsertAbonoTexto do
  begin
    Open;
    Insert;

    FieldByName('empresa_fm').AsString:= QFactura.FieldByName('empresa_f').AsString;
    FieldByName('factura_fm').AsInteger:= iAbono;
    FieldByName('fecha_fm').AsDateTime:= dFechaAbono;
    FieldByName('texto_fm').AsString:= 'Anulacion factura ' +
      NewCodigoFactura( QFactura.FieldByName('empresa_f').AsString,
                        QFactura.FieldByName('tipo_factura_f').AsString,
                        QFactura.FieldByName('tipo_impuesto_f').AsString,
                        QFactura.FieldByName('fecha_factura_f').AsDateTime,
                        QFactura.FieldByName('n_factura_f').AsInteger ) +
      ' de fecha ' +  QFactura.FieldByName('fecha_factura_f').AsString +
      ' por no corresponder.';

    Post;
  end;

  with QInsertFacturaAbono do
  begin
    Open;
    Insert;

    FieldByName('empresa_fa').AsString:= sEmpresa;
    FieldByName('n_factura_fa').AsInteger:= iFactura;
    FieldByName('fecha_factura_fa').AsDateTime:= dFechaFactura;
    FieldByName('n_abono_fa').AsInteger:= iAbono;
    FieldByName('fecha_abono_fa').AsDateTime:= dFechaAbono;

    Post;
  end;

  //Marcar la factura como anulada
  with QFactura do
  begin
    Edit;
    FieldByName('anulacion_f').AsInteger:= 1;
    FieldByName('concepto_f').AsString:= 'M';
    FieldByName('prevision_cobro_f').AsDateTime:= dFechaAbono;//FieldByName('fecha_factura_f').AsDateTime;
    Post;
  end;

  //Texto de la factura
  with QInsertAbonoTexto do
  begin
    Open;
    Insert;
    FieldByName('empresa_fm').AsString:= QFactura.FieldByName('empresa_f').AsString;
    FieldByName('factura_fm').AsInteger:= iFactura;
    FieldByName('fecha_fm').AsDateTime:= dFechaFactura;

    FieldByName('texto_fm').AsString:= 'Factura anulada por el abono  ' +
      NewCodigoFactura( QFactura.FieldByName('empresa_f').AsString, '381',
                        QFactura.FieldByName('tipo_impuesto_f').AsString,
                        dFechaAbono, iAbono ) +
      ' de fecha ' +  DateToStr( dFechaAbono ) +
      ' por no corresponder.';

    Post;
  end;

  LineasAbono;
end;

procedure TDMDAnuFac.RelacionAlbaranes;
  procedure InsertarAlbaranAbono;
  begin
    With QInsertSalidasFactura do
    begin
      if not Active then
        Open;
      Insert;

      FieldByName('empresa_fs').AsString:= sEmpresa;
      FieldByName('n_factura_fs').AsInteger:= iAbono;
      FieldByName('fecha_factura_fs').AsDateTime:= dFechaAbono;
      FieldByName('centro_salida_fs').AsString:= QSalidasFactura.FieldByName('centro_salida_sc').AsString;
      FieldByName('n_albaran_fs').AsInteger:= QSalidasFactura.FieldByName('n_albaran_sc').AsInteger;
      FieldByName('fecha_albaran_fs').AsDateTime:= QSalidasFactura.FieldByName('fecha_sc').AsDateTime;

      Post;
    end;
  end;
begin
  with QSalidasFactura do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('factura').AsInteger:= iFactura;
    ParamByName('fecha').AsDate:= dFechaFactura;
    Open;
    while not Eof do
    begin
      InsertarAlbaranAbono;

      Edit;
      FieldByName('empresa_fac_sc').Value:= NULL;
      FieldByName('n_factura_sc').Value:= NULL;
      FieldByName('fecha_factura_sc').Value:= NULL;
      Post;

      Next;
    end;
    Close;
  end;
end;

function TDMDAnuFac.InsertCabeceraEDI: boolean;
var
  i: integer;
begin
  QCabeceraEDI.ParamByName('empresa').AsString:= sEmpresa;
  QCabeceraEDI.ParamByName('factura').AsInteger:= iFactura;
  QCabeceraEDI.ParamByName('fecha').AsDate:= dFechaFactura;
  QCabeceraEDI.Open;
  result:= not QCabeceraEDI.IsEmpty;
  while not QCabeceraEDI.Eof do
  begin

    if not QInsertCabeceraEDI.Active then
      QInsertCabeceraEDI.Open;
    QInsertCabeceraEDI.Insert;
    for i:= 0 to QCabeceraEDI.Fields.Count - 1 do
    begin
      QInsertCabeceraEDI.Fields[i].Value:= QCabeceraEDI.Fields[i].Value
    end;
    QInsertCabeceraEDI.FieldByName('factura_fec').AsInteger:= iAbono;
    QInsertCabeceraEDI.FieldByName('fecha_factura_fec').AsDateTime:= dFechaAbono;
    QInsertCabeceraEDI.FieldByName('nodo_fec').AsString:= '381';
    QInsertCabeceraEDI.Post;

    QCabeceraEDI.Next;
  end;
  QCabeceraEDI.Close;
end;


procedure TDMDAnuFac.InsertLineasEDI;
var
  i: integer;
begin
  QLineaEDI.ParamByName('empresa').AsString:= sempresa;
  QLineaEDI.ParamByName('factura').AsInteger:= iFactura;
  QLineaEDI.ParamByName('fecha').AsDate:= dFechaFactura;
  QLineaEDI.Open;
  while not QLineaEDI.Eof do
  begin

    if not QInsertLineaEDI.Active then
      QInsertLineaEDI.Open;
    QInsertLineaEDI.Insert;
    for i:= 0 to QLineaEDI.Fields.Count - 1 do
    begin
      QInsertLineaEDI.Fields[i].Value:= QLineaEDI.Fields[i].Value
    end;
    QInsertLineaEDI.FieldByName('factura_fel').AsInteger:= iAbono;
    QInsertLineaEDI.FieldByName('fecha_factura_fel').AsDateTime:= dFechaAbono;
    QInsertLineaEDI.Post;

    QLineaEDI.Next;
  end;
  QLineaEDI.Close;
end;

procedure TDMDAnuFac.InsertCabIvaEDI;
var
  i: integer;
begin
  QCabIvaEDI.ParamByName('empresa').AsString:= sempresa;
  QCabIvaEDI.ParamByName('factura').AsInteger:= iFactura;
  QCabIvaEDI.ParamByName('fecha').AsDate:= dFechaFactura;
  QCabIvaEDI.Open;
  while not QCabIvaEDI.Eof do
  begin

    if not QInsertCabIvaEDI.Active then
      QInsertCabIvaEDI.Open;
    QInsertCabIvaEDI.Insert;
    for i:= 0 to QCabIvaEDI.Fields.Count - 1 do
    begin
      QInsertCabIvaEDI.Fields[i].Value:= QCabIvaEDI.Fields[i].Value
    end;
    QInsertCabIvaEDI.FieldByName('factura_iec').AsInteger:= iAbono;
    QInsertCabIvaEDI.FieldByName('fecha_factura_iec').AsDateTime:= dFechaAbono;
    QInsertCabIvaEDI.Post;

    QCabIvaEDI.Next;
  end;
  QCabIvaEDI.Close;
end;

procedure TDMDAnuFac.InsertLinIvaEDI;
var
  i: integer;
begin
  QLinIvaEDI.ParamByName('empresa').AsString:= sempresa;
  QLinIvaEDI.ParamByName('factura').AsInteger:= iFactura;
  QLinIvaEDI.ParamByName('fecha').AsDate:= dFechaFactura;
  QLinIvaEDI.Open;
  while not QLinIvaEDI.Eof do
  begin

    if not QInsertLinIvaEDI.Active then
      QInsertLinIvaEDI.Open;
    QInsertLinIvaEDI.Insert;
    for i:= 0 to QLinIvaEDI.Fields.Count - 1 do
    begin
      QInsertLinIvaEDI.Fields[i].Value:= QLinIvaEDI.Fields[i].Value
    end;
    QInsertLinIvaEDI.FieldByName('factura_iel').AsInteger:= iAbono;
    QInsertLinIvaEDI.FieldByName('fecha_factura_iel').AsDateTime:= dFechaAbono;
    QInsertLinIvaEDI.Post;

    QLinIvaEDI.Next;
  end;
  QLinIvaEDI.Close;
end;

function TDMDAnuFac.TieneFacturacionEDI: boolean;
begin
  with QClienteEDI do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('cliente').AsString:= sCliente;
    Open;
    result:= FieldByName('edi_c').AsString = 'S';
    Close;
  end;
end;

procedure TDMDAnuFac.FacturacionEDI;
begin
  (*TODO*)
  (*Comprobar la integridad de la facturacion EDI*)
  if TieneFacturacionEDI then
  begin
    if InsertCabeceraEDI then
    begin
      InsertLineasEDI;
      InsertCabIvaEDI;
      InsertLinIvaEDI;
    end;
  end;
end;

function TDMDAnuFac.ObtenerNumeroAbono: boolean;
var
  bPeninsula: boolean;
  iYear, iMOnth, iDay: word;
  sSerie: string;
  iAnyo: integer;
begin

  DecodeDate( dFechaAbono, iYear, iMOnth, iDay );
  bPeninsula:= UpperCase( Copy( QFactura.FieldByName('tipo_impuesto_f').AsString, 1 ,1 ) ) = 'I';
  result:= false;
  (*FACTAÑOS*)
  with QContAbonos do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('anyo').AsInteger:= iYear;
    Open;
    if IsEmpty then
    begin
      sMsg:= 'Problemas al obtener el número del abono.';
      Close;
      exit;
    end
    else
    begin
      if bPeninsula then
      begin
        if FieldByName('fecha_abn_iva_fs').AsDateTime > dFechaAbono then
        begin
          sMsg:= 'La fecha del abono no puede ser inferior a la del último abono grabado.';
          Close;
          exit;
        end
        else
        begin
          iAbono:= FieldByName('abn_iva_fs').AsInteger + 1;
        end;
      end
      else
      begin
        if FieldByName('fecha_abn_igic_fs').AsDateTime > dFechaAbono then
        begin
          sMsg:= 'La fecha del abono no puede ser inferior a la del último abono grabado.';
          Close;
          exit;
        end
        else
        begin
          iAbono:= FieldByName('abn_igic_fs').AsInteger + 1;
        end;
      end;
    end;
    sSerie:= QContAbonos.FieldByName('cod_serie_fs').AsString;
    iAnyo:= QContAbonos.FieldByName('anyo_fs').AsInteger;
    Close;
  end;
  result:= True;

  with qryUpdateContador do
  begin
    if Result then
    begin
      ParamByName('serie').AsString:= sSerie;
      ParamByName('anyo').AsInteger:= iAnyo;
      Open;
      Edit;
      if bPeninsula then
      begin
          Edit;
          FieldByName('abn_iva_fs').AsInteger:= iAbono;
          FieldByName('fecha_abn_iva_fs').AsDateTime:= dFechaAbono;
          Post;
      end
      else
      begin
          Edit;
          FieldByName('abn_igic_fs').AsInteger:= iAbono;
          FieldByName('fecha_abn_igic_fs').AsDateTime:= dFechaAbono;
          Post;
      end;
    end;
    Close;
  end;
end;

function TDMDAnuFac.AnularFactura: Boolean;
begin
  result:= false;
  if QFactura.Active then
  begin
    if not DMBaseDatos.DBBaseDatos.InTransaction then
    begin
      DMBaseDatos.DBBaseDatos.StartTransaction;
      try
        if ObtenerNumeroAbono then
        begin
          CrearAbono;
          RelacionAlbaranes;
          FacturacionEDI;

          DMBaseDatos.DBBaseDatos.Commit;
          sMsg:= 'Factura cancelada con éxito: ' + #13 + #10 +
                    ' EMPRESA = ' + sEmpresa + #13 + #10 +
                    ' FECHA     = ' + DateToStr( dFechaAbono ) + #13 + #10 +
                    ' ABONO     = ' + IntToStr( iAbono );
          result:= true;
        end;
      except
        on e: exception do
        begin
          sMsg:= e.Message;
          DMBaseDatos.DBBaseDatos.Rollback;
          Exit;
        end;
      end;
    end
    else
    begin
      sMsg:= 'No se puede abrir en este momento una transacción.' + #13 + #10 +
                  'Por favor intentelo mas tarde.';
      Exit;
    end;
  end
  else
  begin
    sMsg:= 'Tabla de facturas cerrada.' + #13 + #10 +
                'Por favor comuniquelo al departamento de Informática.';
    Exit;
  end;
end;

function  TDMDAnuFac.Anular( const AEmpresa: string; const AFactura: Integer;
                             const AFechaFactura, AFechaAbono: TDateTime;
                             var AMsgError: string ): Boolean;
begin
  sEmpresa:= AEmpresa;
  iFactura:= AFactura;
  dFechaFactura:= AFechaFactura;
  dFechaAbono:= AFechaAbono;

  if PuedoAnularFactura then
  begin
    result:= AnularFactura;
  end
  else
  begin
    result:= False;
  end;
  AMsgError:= sMsg;
end;

end.
