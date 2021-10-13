unit CMDFacturaManual;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMDFacturaManual = class(TDataModule)
    QContadores: TQuery;
    QCliente: TQuery;
    QImpuesto: TQuery;
    QFactura: TQuery;
    QFacturaManual: TQuery;
    QDetalleFactura: TQuery;
    QExisteFactura: TQuery;
    QFechaInferior: TQuery;
    QFechaSuperior: TQuery;
    QRecargo: TQuery;
    qryUpdateContador: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure CambiarAlias( const AAlias: string );

  public
    function ClaveFactura( const AEmpresa, AImpuesto: string; const AAbono: boolean;
                           const AFecha: TDateTime; var ANumero: integer ): boolean;
    function ClaveFacturaValida( const AEmpresa, AImpuesto: string; const AAbono: boolean;
                           var ANumero: integer; var AFecha: TDateTime; var AMsg: String ): boolean;
    function NuevaFactura( const AEmpresa, AImpuesto: string;  const AAbono: boolean;
                           var ANumero: integer; const AFecha: TDateTime ): boolean;
    function GetImpuestoMoneda( const AEmpresa, ACliente: string; var AImpuesto, AMoneda: string ): boolean;
    function GetPorcentajeIva( const AEmpresa, ACliente, AImpuesto: string; const AFecha: TDateTime; var AIva: real ): boolean;

    function InsertarFacturaManual(
           const AEmpresa, ACliente, AImpuesto, AMoneda: string;
           const AFactura: Integer; const AFechaFactura, APrevisionCobro: TDateTime;
           const AImporte, APorcIva, AIva, ATotal, AEuros: Real;
           const ATexto: string;
           const ACentroSalida: string; const AAlbaran: Integer; const AFechaAlb: TDateTime;
           const AProducto, ACentroOrigen, ACategoria, AEnvase: string;
           const AUnidad: integer; const AUnidades, APrecio, AImporteAlb: Real;
           const ACosechero: string): boolean;
    procedure InsertarDetalleManual(
           const AEmpresa: string; const AFactura: Integer; const AFechaFac: TDateTime;
           const ACentroSalida: string; const AAlbaran: Integer; const AFechaAlb: TDateTime;
           const AProducto, ACentroOrigen, ACategoria, AEnvase: string;
           const AUnidad: integer; const AUnidades, APrecio, AImporte: Real;
           const ACosechero: string );

  end;

  procedure UsarModuloDeDatos( const AComponent: TComponent; const AAlias: string );
  procedure LiberarModuloDeDatos;

var
  DMDFacturaManual: TDMDFacturaManual;

implementation

{$R *.dfm}

uses UDMBaseDatos;

var
  instancias: integer = 0;

procedure UsarModuloDeDatos( const AComponent: TComponent; const AAlias: string );
begin
  Inc( instancias );
  if instancias = 1 then
  begin
    DMDFacturaManual:= TDMDFacturaManual.Create( AComponent );
    DMDFacturaManual.CambiarAlias( AAlias );
  end;
end;

procedure LiberarModuloDeDatos;
begin
  Dec( instancias );
  if instancias = 0 then
    FreeAndNil( DMDFacturaManual );
end;

procedure TDMDFacturaManual.CambiarAlias( const AAlias: string );
  procedure NuevoAlias( const AQuery: TQuery );
  begin
    AQuery.Close;
    AQuery.DatabaseName:= AAlias;
  end;
begin
  NuevoAlias( QContadores );
  NuevoAlias( qryUpdateContador );
  NuevoAlias( QCliente );
  NuevoAlias( QImpuesto );
  NuevoAlias( QRecargo );
end;


procedure TDMDFacturaManual.DataModuleCreate(Sender: TObject);
begin
  with QContadores do
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

    RequestLive:= False;
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
  with QCliente do
  begin
    SQL.Clear;
    SQL.Add(' select moneda_c, es_comunitario_c, pais_c, cod_postal_c[1,2] provincia_c from frf_clientes ');
    SQL.Add(' where empresa_c = :empresa ');
    SQL.Add('   and cliente_c = :cliente ');
    Prepare;
  end;
  with QImpuesto do
  begin
    SQL.Clear;
    SQL.add(' select tipo_i, descripcion_i, general_il, reducido_il, super_il, recargo_general_il, recargo_reducido_il, recargo_super_il ');
    SQL.add(' from frf_impuestos, frf_impuestos_l ');
    SQL.add(' where codigo_i = :impuesto ');
    SQL.add(' and codigo_il = :impuesto ');
    SQL.add(' and :fecha  between fecha_ini_il and case when fecha_fin_il is null then :fecha else fecha_fin_il end ');
    Prepare;
  end;
  with QRecargo do
  begin
    SQL.Clear;
    SQL.add(' select * ');
    SQL.add(' from frf_impuestos_recargo_cli ');
    SQL.add(' where empresa_irc = :empresa ');
    SQL.add(' and cliente_irc = :cliente ');
    SQL.add(' and :fecha  between fecha_ini_irc and case when fecha_fin_irc is null then :fecha else fecha_fin_irc end ');
    Prepare;
  end;
  with QFactura do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_facturas ');
    Prepare;
  end;
  with QFacturaManual do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_fac_manual ');
    Prepare;
  end;
  with QDetalleFactura do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_fac_abonos_l ');
    Prepare;
  end;
  With QExisteFactura do
  begin
    SQL.Clear;
    SQL.Add(' select *');
    SQL.Add(' from frf_facturas ');
    SQL.Add(' where empresa_f = :empresa ');
    SQL.Add(' and n_factura_f = :factura ');
    SQL.Add(' and tipo_factura_f = :tipo ');
    SQL.Add(' and tipo_impuesto_f like :iva ');
    SQL.Add(' and fecha_factura_f between :fechaini and :fechafin ');
  end;
  With QFechaInferior do
  begin
    SQL.Clear;
    SQL.Add(' select max(fecha_factura_f) fecha, count(*) facturas ');
    SQL.Add(' from frf_facturas ');
    SQL.Add(' where empresa_f = :empresa ');
    SQL.Add(' and n_factura_f < :factura ');
    SQL.Add(' and tipo_factura_f = :tipo ');
    SQL.Add(' and tipo_impuesto_f like :iva ');
    SQL.Add(' and fecha_factura_f between :fechaini and :fechafin ');
  end;
  With QFechaSuperior do
  begin
    SQL.Clear;
    SQL.Add(' select min(fecha_factura_f) fecha, count(*) facturas ');
    SQL.Add(' from frf_facturas ');
    SQL.Add(' where empresa_f = :empresa ');
    SQL.Add(' and n_factura_f > :factura ');
    SQL.Add(' and tipo_factura_f = :tipo ');
    SQL.Add(' and tipo_impuesto_f like :iva ');
    SQL.Add(' and fecha_factura_f between :fechaini and :fechafin ');
  end;
end;

procedure TDMDFacturaManual.DataModuleDestroy(Sender: TObject);
  procedure Desprepara( AQuery: TQuery );
  begin
    AQuery.Close;
    if AQuery.Prepared then
      AQuery.UnPrepare;
  end;
begin
  Desprepara( QContadores );
  Desprepara( qryUpdateContador );
  Desprepara( QCliente );
  Desprepara( QImpuesto );
  Desprepara( QRecargo );
  Desprepara( QFactura );
  Desprepara( QFacturaManual );
  Desprepara( QDetalleFactura );
end;

(*FACTAÑOS*)
function TDMDFacturaManual.ClaveFactura( const AEmpresa, AImpuesto: string; const AAbono: boolean;
                                         const AFecha: TDateTime; var ANumero: integer ): boolean;
var
  iYear, iMonth, iDay: Word;
begin
  with QContadores do
  begin
    DecodeDate( AFecha, iYear, iMonth, iDay );
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('anyo').AsInteger:= iYear;
    Open;
    if not IsEmpty then
    begin
      if AAbono then
      begin
        if UpperCase( Copy( AImpuesto, 1, 1 ) ) = 'I' then
        begin
          ANumero:= FieldByName('abn_iva_fs').AsInteger + 1;
          //AFecha:= FieldByName('fecha_abn_iva_fs').AsDateTime;
          result:= True;
        end
        else
        if UpperCase( Copy( AImpuesto, 1, 1 ) ) = 'G' then
        begin
          ANumero:= FieldByName('abn_igic_fs').AsInteger + 1;
          //AFecha:= FieldByName('fecha_abn_igic_fs').AsDateTime;
          result:= True;
        end
        else
        begin
          result:= False;
        end;
      end
      else
      begin
        if UpperCase( Copy( AImpuesto, 1, 1 ) ) = 'I' then
        begin
          ANumero:= FieldByName('fac_iva_fs').AsInteger + 1;
          //AFecha:= FieldByName('fecha_fac_iva_fs').AsDateTime;
          result:= True;
        end
        else
        if UpperCase( Copy( AImpuesto, 1, 1 ) ) = 'G' then
        begin
          ANumero:= FieldByName('fac_igic_fs').AsInteger + 1;
          //AFecha:= FieldByName('fecha_fac_igic_fs').AsDateTime;
          result:= True;
        end
        else
        begin
          result:= False;
        end;
      end;
    end
    else
    begin
      result:= False;
    end;
    Close;
  end;
end;

function TDMDFacturaManual.ClaveFacturaValida( const AEmpresa, AImpuesto: string; const AAbono: boolean;
                                         var ANumero: integer; var AFecha: TDateTime; var AMsg: String ): boolean;
var
  iAnyo, iMes, iDia: Word;
  dFechaIni, dFechaFin: TDateTime;
  sTipo, sIva: String;
begin
  DecodeDate( AFecha, iAnyo, iMes, iDia );
  dFechaIni:= EncodeDate( iAnyo, 1, 1 );
  dFechaFin:= EncodeDate( iAnyo, 12, 31 );
  sIva:= UpperCase( Copy( AImpuesto, 1, 1 ) ) + '%';
  if AAbono then
    sTipo:= '381'
  else
    sTipo:= '380';

  with QExisteFactura do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('iva').AsString:= sIva;
    ParamByName('tipo').AsString:= sTipo;
    ParamByName('factura').AsInteger:= ANumero;
    ParamByName('fechaini').AsDate:= dFechaIni;
    ParamByName('fechaFin').AsDate:= dFechaFin;
    Open;

    if not IsEmpty then
    begin
      AMsg:= 'ERROR: Ya existe una factura en este año con este número.';
      result:= False;
      Close;
      Exit;
    end;
    Close;
  end;
  with QFechaInferior do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('iva').AsString:= sIva;
    ParamByName('tipo').AsString:= sTipo;
    ParamByName('factura').AsInteger:= ANumero;
    ParamByName('fechaini').AsDate:= dFechaIni;
    ParamByName('fechaFin').AsDate:= dFechaFin;
    Open;

    if FieldByName('facturas').AsInteger > 0 then
    begin
      if FieldByName('fecha').AsDateTime > AFecha then
      begin
        AMsg:= 'ERROR: Existen facturas con numeración inferior con fecha superior.';
        result:= False;
        Close;
        Exit;
      end;
    end;
    Close;
  end;

  with QFechaSuperior do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('iva').AsString:= sIva;
    ParamByName('tipo').AsString:= sTipo;
    ParamByName('factura').AsInteger:= ANumero;
    ParamByName('fechaini').AsDate:= dFechaIni;
    ParamByName('fechaFin').AsDate:= dFechaFin;
    Open;

    if FieldByName('facturas').AsInteger > 0 then
    begin
      if FieldByName('fecha').AsDateTime < AFecha then
      begin
        AMsg:= 'ERROR: Existen facturas con numeración superior con fecha inferior.';
        result:= False;
        Close;
        Exit;
      end;
    end;
    Close;
  end;

  result:= True;
end;

(*FACTAÑOS*)
function TDMDFacturaManual.NuevaFactura( const AEmpresa, AImpuesto: string; const AAbono: boolean;
                                         var ANumero: integer; const AFecha: TDateTime ): boolean;
var
  iYear, iMonth, iDay: Word;
begin
  with QContadores do
  begin
    DecodeDate( AFecha, iYear, iMonth, iDay );
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('anyo').AsInteger:= iYear;
    Open;

    if not IsEmpty then
    begin
      if AAbono then
      begin
        if UpperCase( Copy( AImpuesto, 1, 1 ) ) = 'I' then
        begin
          ANumero:= FieldByName('abn_iva_fs').AsInteger + 1;
          result:= True;
        end
        else
        if UpperCase( Copy( AImpuesto, 1, 1 ) ) = 'G' then
        begin
          ANumero:= FieldByName('abn_igic_fs').AsInteger + 1;
          result:= True;
        end
        else
        begin
          result:= False;
        end;
      end
      else
      begin
        if UpperCase( Copy( AImpuesto, 1, 1 ) ) = 'I' then
        begin
          ANumero:= FieldByName('fac_iva_fs').AsInteger + 1;
          result:= True;
        end
        else
        if UpperCase( Copy( AImpuesto, 1, 1 ) ) = 'G' then
        begin
          ANumero:= FieldByName('fac_igic_fs').AsInteger + 1;
          result:= True;
        end
        else
        begin
          result:= False;
        end;
      end;
    end
    else
    begin
      result:= False;
    end;
  end;

  with qryUpdateContador do
  begin
    if Result then
    begin
      ParamByName('serie').AsString:= QContadores.FieldByName('cod_serie_fs').AsString;
      ParamByName('anyo').AsString:= QContadores.FieldByName('anyo_fs').AsString;
      Open;
      Edit;

      if AAbono then
      begin
        if UpperCase( Copy( AImpuesto, 1, 1 ) ) = 'I' then
        begin
          FieldByName('abn_iva_fs').AsInteger:= ANumero;
          FieldByName('fecha_abn_iva_fs').AsDateTime:= AFecha;
        end
        else
        if UpperCase( Copy( AImpuesto, 1, 1 ) ) = 'G' then
        begin
          FieldByName('abn_igic_fs').AsInteger:= ANumero;
          FieldByName('fecha_abn_igic_fs').AsDateTime:= AFecha;
        end;
      end
      else
      begin
        if UpperCase( Copy( AImpuesto, 1, 1 ) ) = 'I' then
        begin
          FieldByName('fac_iva_fs').AsInteger:= ANumero;
          FieldByName('fecha_fac_iva_fs').AsDateTime:= AFecha;
        end
        else
        if UpperCase( Copy( AImpuesto, 1, 1 ) ) = 'G' then
        begin
          FieldByName('fac_igic_fs').AsInteger:= ANumero;
          FieldByName('fecha_fac_igic_fs').AsDateTime:= AFecha;
        end;
      end;
      Post;
      Close;
    end;

    Close;
  end;
end;

function TDMDFacturaManual.GetImpuestoMoneda( const AEmpresa, ACliente: string; var AImpuesto, AMoneda: string ): boolean;
begin
  with QCliente do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    Open;
    result:= not IsEmpty;
    if result then
    begin
      AMoneda:= FieldByName('moneda_c').AsString;
      if FieldByName('pais_c').AsString = 'ES' then
      begin
        if ( FieldByName('provincia_c').AsString = '38' ) or ( FieldByName('provincia_c').AsString = '35' ) then
        begin
          AImpuesto:= 'GR';
        end
        else
        begin
          AImpuesto:= 'IR';
        end;
      end
      else
      if FieldByName('es_comunitario_c').AsString = 'N' then
      begin
        AImpuesto:= 'IE';
      end
      else
      begin
        AImpuesto:= 'IC';
      end
    end;
    Close;
  end;
end;

function TDMDFacturaManual.GetPorcentajeIva( const AEmpresa, ACliente, AImpuesto: string; const AFecha: TDateTime; var AIva: real ): boolean;
var
  rRecargo: real;
begin
  with QImpuesto do
  begin
    ParamByName('impuesto').AsString:= AImpuesto;
    ParamByName('fecha').AsDate:= AFecha;
    Open;
    result:= not IsEmpty;
    if result then
    begin
      AIva:= FieldByName('super_il').AsFloat;
      rRecargo:= FieldByName('recargo_super_il').AsFloat;
    end;
    Close;
  end;
  with QRecargo do
  begin
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('cliente').AsString := ACliente;
    ParamByName('fecha').AsDate := AFecha;
    try
      Open;
      if not IsEmpty then
        AIva := AIva + rRecargo;
    finally
      Close;
    end;
  end;
end;


function TDMDFacturaManual.InsertarFacturaManual(
           const AEmpresa, ACliente, AImpuesto, AMoneda: string;
           const AFactura: Integer; const AFechaFactura, APrevisionCobro: TDateTime;
           const AImporte, APorcIva, AIva, ATotal, AEuros: Real;
           const ATexto: string;
           const ACentroSalida: string; const AAlbaran: Integer; const AFechaAlb: TDateTime;
           const AProducto, ACentroOrigen, ACategoria, AEnvase: string;
           const AUnidad: integer; const AUnidades, APrecio, AImporteAlb: Real;
           const ACosechero: string): boolean;
var
  iFactura: integer;
begin
  result:= False;
  if not DMBaseDatos.DBBaseDatos.InTransaction then
  begin
    DMBaseDatos.DBBaseDatos.StartTransaction;
    try
      NuevaFactura( AEmpresa, AImpuesto, (AImporte < 0 ), iFactura, AFechaFactura );

      with QFactura do
      begin
        Open;
        Insert;
        FieldByName('empresa_f').AsString:= AEmpresa;
        FieldByName('cliente_sal_f').AsString:= ACliente;
        FieldByName('cliente_fac_f').AsString:= ACliente;
        FieldByName('n_factura_f').AsInteger:= iFactura;
        FieldByName('fecha_factura_f').AsDateTime:= AFechaFactura;
        if AImporte > 0 then
          FieldByName('tipo_factura_f').AsString:= '380'
        else
          FieldByName('tipo_factura_f').AsString:= '381';
        FieldByName('concepto_f').AsString:= 'M';
        FieldByName('anulacion_f').AsInteger:= 0;

        FieldByName('moneda_f').AsString:= AMoneda;
        FieldByName('importe_neto_f').AsFloat:= AImporte;
        FieldByName('tipo_impuesto_f').AsString:= AImpuesto;
        FieldByName('porc_impuesto_f').AsFloat:= APorcIva;
        FieldByName('total_impuesto_f').AsFloat:= AIva;
        FieldByName('importe_total_f').AsFloat:= ATotal;
        FieldByName('importe_euros_f').AsFloat:= AEuros;
        FieldByName('prevision_cobro_f').AsDateTime:= APrevisionCobro;

        FieldByName('contabilizado_f').AsString:= 'N';
        FieldByName('contab_cobro_f').AsString:= 'N';
        Post;
        Close;
      end;

      if ATexto <> '' then
      begin
        with QFacturaManual do
        begin
          Open;
          Insert;
          FieldByName('empresa_fm').AsString:= AEmpresa;
          FieldByName('factura_fm').AsInteger:= iFactura;
          FieldByName('fecha_fm').AsDateTime:= AFechaFactura;
          FieldByName('texto_fm').AsString:= ATexto;
          Post;
          Close;
        end;
      end;

      InsertarDetalleManual(
           AEmpresa, iFactura, AFechaFactura, ACentroSalida, AAlbaran, AFechaAlb, AProducto,
           ACentroOrigen, ACategoria, AEnvase, AUnidad, AUnidades, APrecio, AImporte, ACosechero );

      DMBaseDatos.DBBaseDatos.Commit;
      result:= True;
    except
      DMBaseDatos.DBBaseDatos.Rollback;
      result:= False;
    end;
  end;
end;

function DesUnidad( const AUnidad: integer ): string;
begin
  case AUnidad of
    0: result:= 'IMP';
    1: result:= 'UND';
    2: result:= 'CAJ';
    3: result:= 'KGS';
  end;
end;

procedure TDMDFacturaManual.InsertarDetalleManual(
           const AEmpresa: string; const AFactura: Integer; const AFechaFac: TDateTime;
           const ACentroSalida: string; const AAlbaran: Integer; const AFechaAlb: TDateTime;
           const AProducto, ACentroOrigen, ACategoria, AEnvase: string;
           const AUnidad: integer; const AUnidades, APrecio, AImporte: Real;
           const ACosechero: string );
begin
  with QDetalleFactura do
  begin
    Open;
    Insert;
    FieldByName('empresa_fal').AsString:= AEmpresa;
    FieldByName('factura_fal').AsInteger:= AFactura;
    FieldByName('fecha_fal').AsDateTime:= AFechaFac;

    FieldByName('centro_salida_fal').AsString:= ACentroSalida;
    FieldByName('n_albaran_fal').AsInteger:= AAlbaran;
    FieldByName('fecha_albaran_fal').AsDateTime:= AFechaAlb;

    FieldByName('producto_fal').AsString:= AProducto;
    FieldByName('centro_origen_fal').AsString:= ACentroOrigen;
    FieldByName('categoria_fal').AsString:= ACategoria;
    FieldByName('envase_fal').AsString:= AEnvase;

    if AUnidad > 0 then
    begin
      FieldByName('unidad_fal').AsString:= DesUnidad( AUnidad );
      FieldByName('unidades_fal').AsFloat:= AUnidades;
      FieldByName('precio_fal').AsFloat:= APrecio;
    end;
    (*else NULL*)
    FieldByName('importe_fal').AsFloat:= AImporte;

    FieldByName('cosechero_fal').AsString:= ACosechero;

    Post;
    Close;
  end;
end;

end.
