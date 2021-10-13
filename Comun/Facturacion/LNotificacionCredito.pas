unit LNotificacionCredito;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, kbmMemTable, DB, DBTables;

type
  TQRLNotifcacionCredito = class(TQuickRep)
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    qrecod_cliente: TQRDBText;
    qrecod_pago: TQRDBText;
    qretipo_pago: TQRDBText;
    qredias_pago: TQRDBText;
    qreneto: TQRDBText;
    TitleBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblFechas: TQRLabel;
    qrenom_cliente: TQRDBText;
    QListado: TQuery;
    mtListado: TkbmMemTable;
    qretotal: TQRDBText;
    qrepais: TQRDBText;
    qretipo_exporta: TQRDBText;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    bndSumario: TQRBand;
    qrxNeto: TQRExpr;
    qrxTotal: TQRExpr;
    qrgrpExporta: TQRGroup;
    qrbndPiePais: TQRBand;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrdbtxtpais: TQRDBText;
    qrgrpPais: TQRGroup;
    qrbndPieExporta: TQRBand;
    qrlbl1: TQRLabel;
    qrdbtxttipo_exporta: TQRDBText;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    qrshp1: TQRShape;
    procedure qrdbtxtpaisPrint(sender: TObject; var Value: String);
    procedure qrgrpExportaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxttipo_exportaPrint(sender: TObject; var Value: String);
  private

    function HayDatos( const AEmpresa, ACliente, APais, ATipoCliente: string ; const AExcluirTipoCliente: Boolean;
                       const AFechaIni, AFechaFin: TDateTime;
                       const ASeguro: integer ): boolean;
    procedure CrearListado;
    procedure VerListado;
    procedure Importes( var VNeto, VTotal: Real );

  public
    sEmpresa: String;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  function VisualizarInforme( const AEmpresa, ACliente, APais, ATipoCliente: string ; const AExcluirTipoCliente: Boolean;
                              const AFechaIni, AFechaFin: TDateTime;
                              const ASeguro: integer ): boolean;

implementation

uses UDMAuxDB, DPreview, CReportes, Math, CGlobal, bMath;

{$R *.DFM}

var
  QRLNotifcacionCredito: TQRLNotifcacionCredito;

function VisualizarInforme( const AEmpresa, ACliente, APais, ATipoCliente: string ; const AExcluirTipoCliente: Boolean;
                            const AFechaIni, AFechaFin: TDateTime;
                            const ASeguro: integer ): boolean;
begin
  QRLNotifcacionCredito:= TQRLNotifcacionCredito.Create( nil );
  try
    with QRLNotifcacionCredito do
    begin
      if HayDatos( AEmpresa, ACliente, APais, ATipoCliente, AExcluirTipoCliente, AFechaIni, AFechaFin, ASeguro ) then
      begin
        sEmpresa:= AEmpresa;
        lblFechas.Caption := 'Del ' + DateToStr( AFechaIni ) + ' al ' + DateToStr( AFechaFin );
        PonLogoGrupoBonnysa(QRLNotifcacionCredito, sEmpresa );

        VerListado;
        result:= True;
      end
      else
      begin
        result:= False;
      end;
    end;
  except
    FreeAndNil( QRLNotifcacionCredito );
    raise;
  end;
end;

constructor TQRLNotifcacionCredito.Create(AOwner: TComponent);
begin
  inherited;

  with mtListado do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('tipo_exporta', ftString, 12, False);
    FieldDefs.Add('pais', ftString, 30, False);
    FieldDefs.Add('cod_cliente', ftString, 3, False);
    FieldDefs.Add('nom_cliente', ftString, 35, False);
    FieldDefs.Add('cod_pago', ftString, 3, False);
    FieldDefs.Add('tipo_pago', ftString, 3, False);
    FieldDefs.Add('dias_pago', ftInteger, 0, False);
    FieldDefs.Add('neto', ftFloat, 0, False);
    FieldDefs.Add('total', ftFloat, 0, False);
    CreateTable;
    Open;
  end;
end;

destructor TQRLNotifcacionCredito.Destroy;
begin

  with mtListado do
  begin
    Close;
    DeleteTable;
  end;
  inherited;
end;

function TQRLNotifcacionCredito.HayDatos( const AEmpresa, ACliente, APais, ATipoCliente: string ; const AExcluirTipoCliente: Boolean;
                       const AFechaIni, AFechaFin: TDateTime;
                       const ASeguro: integer ): boolean;
begin
  with QListado do
  begin
    SQL.Clear;
    SQL.Add(' select case when pais_c = ''ES'' then ''INTERNO'' else ''EXPORTACION'' end tipo, descripcion_p, ');
    SQL.Add('        cliente_fac_f, nombre_c, forma_pago_ct forma_pago_c, forma_pago_adonix_fp, dias_cobro_fp, ');
    SQL.Add('        importe_neto_f, porc_impuesto_f, importe_total_f, moneda_f, importe_euros_f ');

    SQL.Add(' from frf_facturas, frf_clientes, frf_paises, outer(frf_clientes_tes, frf_forma_pago), frf_clientes_rie ');

    SQL.Add(' where fecha_factura_f between :fechaini and :fechafin ');


    if AEmpresa <> '' then
    begin
      if ( AEmpresa = 'BAG' ) and ( CGlobal.gProgramVersion = CGlobal.pvBAG ) then
      begin
        SQL.Add(' and empresa_f[1,1] = ''F'' ');
      end
      else
      if ( AEmpresa = 'SAT' ) and ( CGlobal.gProgramVersion = CGlobal.pvSAT ) then
      begin
        SQL.Add(' and ( empresa_f = ''050'' or  empresa_f = ''080'' )');
      end
      else
        SQL.Add(' and empresa_f = :empresa ');
    end;


    if ACliente <> '' then
    begin
      SQL.Add(' and cliente_fac_f = :cliente ');
    end
    else
    begin
      if APais <> '' then
        SQL.Add(' and pais_c = :pais ');
    end;
    if ATipoCliente <> '' then
    begin
      if AExcluirTipoCliente then
        SQL.Add(' and tipo_cliente_c <> :tipocliente ')
      else
        SQL.Add(' and tipo_cliente_c = :tipocliente ');
    end;

    SQL.Add(' and cliente_c = cliente_fac_f ');

    SQL.Add(' and empresa_ct = empresa_f ');
    SQL.Add(' and cliente_ct = cliente_fac_f ');

    SQL.Add(' and empresa_cr = empresa_f ');
    SQL.Add(' and cliente_cr = cliente_fac_f ');
    SQL.Add(' and fecha_fin_cr is null ');

    case ASeguro of
      1: SQL.Add(' and seguro_cr <> 0 ');
      2: SQL.Add(' and seguro_cr = 0 ');
    end;

    SQL.Add(' and codigo_fp = forma_pago_ct ');

    SQL.Add(' and pais_p = pais_c ');

    SQL.Add(' order by 1 desc, 2, 3 ');

    ParamByName('fechaini').AsDateTime:= AFechaIni;
    ParamByName('fechafin').AsDateTime:= AFechaFin;
    if AEmpresa <> '' then
    begin
      if not ( ( AEmpresa = 'BAG' ) and ( CGlobal.gProgramVersion = CGlobal.pvBAG ) ) and
         not ( ( AEmpresa = 'SAT' ) and ( CGlobal.gProgramVersion = CGlobal.pvSAT ) ) then
      begin
        ParamByName('empresa').AsString:= AEmpresa;
      end;
    end;

    if ACliente <> '' then
    begin
      ParamByName('cliente').AsString:= ACliente;
    end
    else
    begin
      if APais <> '' then
        ParamByName('pais').AsString:= APais;
    end;
    if ATipoCliente <> '' then
      ParamByName('tipocliente').AsString:= ATipoCliente;

    Open;
    result:= not IsEmpty;
    if result then
      CrearListado;
    Close;
  end;


end;

procedure TQRLNotifcacionCredito.Importes( var VNeto, VTotal: Real );
var
  rChange: real;
begin
  with QListado do
  begin
    if FieldByName('importe_total_f').AsFloat = FieldByName('importe_euros_f').AsFloat then
    begin
      //la moneda esta en euros
      VNeto:= FieldByName('importe_neto_f').AsFloat;
      VTotal:= FieldByName('importe_total_f').AsFloat;
    end
    else
    if FieldByName('porc_impuesto_f').AsFloat = 0 then
    begin
      //sin iva, total igual que neto
      VNeto:= FieldByName('importe_euros_f').AsFloat;
      VTotal:= FieldByName('importe_euros_f').AsFloat;
    end
    else
    begin
      rChange:= ( FieldByName('importe_euros_f').AsFloat / FieldByName('importe_total_f').AsFloat );
      VNeto:= bRoundTo( FieldByName('importe_neto_f').AsFloat * rChange, 2 );
      VTotal:= FieldByName('importe_euros_f').AsFloat;
    end;
  end;
end;

procedure TQRLNotifcacionCredito.CrearListado;
var
  sTipoExporta, sPais, sCodCliente, sNomCliente, sCodPago, sTipoPago: String;
  iDiasPago: integer;
  rNeto, rTotal: real;
  rANeto, rATotal: real;
begin
  iDiasPago:= 0;
  rNeto:= 0;
  rTotal:= 0;

  with QListado do
  begin
    sCodCliente:= '';
    while not Eof do
    begin
      if ( sCodCliente = '' ) then
      begin
        sTipoExporta:= FieldByName('tipo').AsString;
        sPais:= FieldByName('descripcion_p').AsString;
        sCodCliente:= FieldByName('cliente_fac_f').AsString;
        sNomCliente:= FieldByName('nombre_c').AsString;
        sCodPago:= FieldByName('forma_pago_c').AsString;
        sTipoPago:= FieldByName('forma_pago_adonix_fp').AsString;
        iDiasPago:= FieldByName('dias_cobro_fp').AsInteger;
        Importes( rANeto, rATotal );
        rNeto:= rANeto;
        rTotal:= rATotal;
      end
      else
      if ( sCodCliente <> FieldByname('cliente_fac_f').AsString ) then
      begin
        mtListado.Insert;
        mtListado.FieldByName('tipo_exporta').AsString:= sTipoExporta;
        mtListado.FieldByName('pais').AsString:= sPais;
        mtListado.FieldByName('cod_cliente').AsString:= sCodCliente;
        mtListado.FieldByName('nom_cliente').AsString:= sNomCliente;
        mtListado.FieldByName('cod_pago').AsString:= sCodPago;
        mtListado.FieldByName('tipo_pago').AsString:= sTipoPago;
        mtListado.FieldByName('dias_pago').AsInteger:= iDiasPago;
        mtListado.FieldByName('neto').AsFloat:= rNeto;
        mtListado.FieldByName('total').AsFloat:= rTotal;
        mtListado.Post;

        //porc_impuesto_f, , moneda_f, importe_euros_f
        sTipoExporta:= FieldByName('tipo').AsString;
        sPais:= FieldByName('descripcion_p').AsString;
        sCodCliente:= FieldByName('cliente_fac_f').AsString;
        sNomCliente:= FieldByName('nombre_c').AsString;
        sCodPago:= FieldByName('forma_pago_c').AsString;
        sTipoPago:= FieldByName('forma_pago_adonix_fp').AsString;
        iDiasPago:= FieldByName('dias_cobro_fp').AsInteger;

        Importes( rANeto, rATotal );
        rNeto:= rANeto;
        rTotal:= rATotal;
      end
      else
      begin

        Importes( rANeto, rATotal );
        rNeto:= rNeto + rANeto;
        rTotal:= rTotal + rATotal;
      end;
      Next;
    end;
    mtListado.Insert;
    mtListado.FieldByName('tipo_exporta').AsString:= sTipoExporta;
    mtListado.FieldByName('pais').AsString:= sPais;
    mtListado.FieldByName('cod_cliente').AsString:= sCodCliente;
    mtListado.FieldByName('nom_cliente').AsString:= sNomCliente;
    mtListado.FieldByName('cod_pago').AsString:= sCodPago;
    mtListado.FieldByName('tipo_pago').AsString:= sTipoPago;
    mtListado.FieldByName('dias_pago').AsInteger:= iDiasPago;
    mtListado.FieldByName('neto').AsFloat:= rNeto;
    mtListado.FieldByName('total').AsFloat:= rTotal;
    mtListado.Post;
  end;
  mtListado.SortFields:= 'tipo_exporta;pais;cod_cliente';
  mtListado.Sort([]);
end;

procedure TQRLNotifcacionCredito.VerListado;
begin
  DPreview.Preview( QRLNotifcacionCredito );
end;

procedure TQRLNotifcacionCredito.qrdbtxtpaisPrint(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + Value + ':';
end;

procedure TQRLNotifcacionCredito.qrgrpExportaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  Sender.Height:= 0;
end;

procedure TQRLNotifcacionCredito.qrdbtxttipo_exportaPrint(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + Value + ':';
end;

end.
