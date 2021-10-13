unit RecadvDM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMRecadv = class(TDataModule)
    QMaestro: TQuery;
    DSMaestro: TDataSource;
    QDetalle: TQuery;
    QCantidades: TQuery;
    QObservaciones: TQuery;
    DSDetalle: TDataSource;
    QDetalleidcab_elr: TStringField;
    QDetalleidemb_elr: TStringField;
    QDetalleidlin_elr: TStringField;
    QDetalleean_elr: TStringField;
    QDetallerefprov_elr: TStringField;
    QDetallerefcli_elr: TStringField;
    QDetallecantace_elr: TFloatField;
    QDetallecantue_elr: TFloatField;
    QCantidadescalif_enr: TStringField;
    QCantidadescantidad_enr: TFloatField;
    QCantidadesdiscrep_enr: TStringField;
    QCantidadesrazon_enr: TStringField;
    QObservacionesidobs_eor: TStringField;
    QObservacionestexto1_eor: TStringField;
    QObservacionestexto2_eor: TStringField;
    QObservacionestexto3_eor: TStringField;
    QObservacionestexto4_eor: TStringField;
    QObservacionestexto5_eor: TStringField;
    QOrigen: TQuery;
    QFacturarA: TQuery;
    QProveedor: TQuery;
    QDetalleunidad_fac: TStringField;
    QDetalleenvase: TStringField;
    QEnvase: TQuery;
    QEnvasedescripcion: TStringField;
    QEnvaseunidad_fac: TStringField;
    QEnvaseunidades_fac: TFloatField;
    QCantidadescalificador: TStringField;
    QCantidadesdiscrepancia: TStringField;
    QCantidadesrazon: TStringField;
    QAlbaranDet: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure QMaestroAfterOpen(DataSet: TDataSet);
    procedure QMaestroBeforeClose(DataSet: TDataSet);
    procedure QDetalleCalcFields(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure QCantidadesCalcFields(DataSet: TDataSet);
    procedure QDetalleFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    sSelect, sFrom, sWhere, sOrder: string;
    iVerDetalle: Integer;
    iPage: Integer;

    //function ContadorRecadv: string;
    procedure AbrirSubDetalle;
  public
    { Public declarations }
    procedure Localizar(const AFiltro: string);

    function  DesOrigen( const AOrigen: string ): string;
    function  DesFacturarA( const AFacturarA: string ): string;
    function  DesProveedor( const AProveedor: string ): string;
    function  DesEnvaseCliente( const ACodigo: string; var AUnidad: string ): string;

    procedure AplicaFiltroDetalle( const AVerDetalle: integer );
    procedure CambiarSubDetalle( const APage: integer );
  end;

  function GetTipo( const ATipo: string ): string;
  function GetFuncion( const AFuncion: string ): string;
  function GetCalificador( const ACalificador: string ): string;
  function GetDiscrepancia( const ADiscrepancia: string ): string;
  function GetRazon( const ARazon: string ): string;


var
  DMRecadv: TDMRecadv;

implementation

{$R *.dfm}

uses bTextUtils, UDMAuxDB, RecadvQM;

function GetTipo( const ATipo: string ): string;
begin
  if ATipo = '352' then
    result:= 'Confirmación de recepción'
  else
    result:= '';
end;

function GetFuncion( const AFuncion: string ): string;
begin
  if AFuncion = '9' then
    result:= 'Original'
  else
  if AFuncion = '5' then
    result:= 'Reemplazar'
  else
    result:= '';
end;

function GetCalificador( const ACalificador: string ): string;
begin
  if ACalificador = '' then result:= ''
  else if ACalificador = '12' then result:= ACalificador + ' - Enviado'
  else if ACalificador = '21' then result:= ACalificador + ' - Pedido'
  else if ACalificador = '46' then result:= ACalificador + ' - Entregado'
  else if ACalificador = '59' then result:= ACalificador + ' - Unds. Caja'
  else if ACalificador = '66' then result:= ACalificador + ' - Comprometido'
  else if ACalificador = '194' then result:= ACalificador + ' - Aceptado'
  else if ACalificador = '195' then result:= ACalificador + ' - A Devolver'
  else if ACalificador = '196' then result:= ACalificador + ' - A Destruir'
  else if ACalificador = 'CDF' then result:= ACalificador + ' - Con Diferencias'
  else if ACalificador = '59' then result:= ACalificador + ' - UConsumo x Und'
  else result:= ACalificador + ' ¿?';
end;

function GetDiscrepancia( const ADiscrepancia: string ): string;
begin
  if ADiscrepancia = '' then result:= ''
  else if ADiscrepancia = 'AC' then result:= ADiscrepancia + ' - Excesivo'
  else if ADiscrepancia = 'AE' then result:= ADiscrepancia + ' - Sin Aviso'
  else if ADiscrepancia = 'AF' then result:= ADiscrepancia + ' - Dañada'
  else if ADiscrepancia = 'AG' then result:= ADiscrepancia + ' - Tarde'
  else if ADiscrepancia = 'BP' then result:= ADiscrepancia + ' - Parcial/Sigue'
  else if ADiscrepancia = 'CP' then result:= ADiscrepancia + ' - Parcial/Fin'
  else result:= ADiscrepancia + ' ¿?';
end;

function GetRazon( const ARazon: string ): string;
begin
  if ARazon = '' then result:= ''
  else if ARazon = 'AT' then result:= ARazon + ' - No Pedido'
  else if ARazon = 'AUE' then result:= ARazon + ' - EAN Desconocido'
  else if ARazon = 'BM' then result:= ARazon + ' - EAN No Legible'
  else if ARazon = 'DME' then result:= ARazon + ' - EAN Dañado'
  else if ARazon = 'IS' then result:= ARazon + ' - Sustitucion EAN'
  else if ARazon = 'PC' then result:= ARazon + ' - Diferencia Bulto'
  else if ARazon = 'PE' then result:= ARazon + ' - Fecha Caducidad'
  else result:= ARazon + ' ¿?';
end;

procedure TDMRecadv.DataModuleCreate(Sender: TObject);
begin
  iVerDetalle:= 0;
  iPage:= 0;

  with QFacturarA do
  begin
    SQL.Clear;
    SQL.Add('select cliente_ce, ');
    SQL.Add('       Max( (select nombre_c from frf_clientes where cliente_c = cliente_ce) ) nombre_ce ');
    SQL.Add('from frf_clientes_edi ');
    SQL.Add('where aquiensefactura_ce = :facturaa');
    SQL.Add('group by cliente_ce');
    Prepare;
  end;

  with QOrigen do
  begin
    SQL.Clear;
    SQL.Add(' select cliente_ce, dir_sum_ce, ');
    SQL.Add('        Max( ( select nombre_ds from frf_dir_sum where cliente_ds = cliente_ce ');
    SQL.Add('                                            and dir_sum_ds = dir_sum_ce) ) suministro_ce ');
    SQL.Add(' from frf_clientes_edi ');
    SQL.Add(' where quienrecibe_ce = :origen ');
    SQL.Add('group by cliente_ce, dir_sum_ce');
    Prepare;
  end;

  with QProveedor do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_e, nombre_e ');

    SQL.Add(' from frf_empresas ');
    SQL.Add(' where codigo_ean_e = :proveedor ');
    SQL.Add('group by empresa_e, nombre_e');
    Prepare;
  end;

  with QEnvase do
  begin
    SQL.Clear;
    SQL.Add('select max(descripcion_ce) descripcion, ');
    SQL.Add('       max(unidad_fac_ce) unidad_fac, ');
    SQL.Add('       count(distinct unidad_fac_ce) unidades_fac ');
    SQL.Add('from frf_clientes_env, frf_envases ');
    SQL.Add('where :refcli_elr = SubStr(Trim(descripcion_ce),1,5) ');
    SQL.Add('and producto_ce = producto_e ');
    SQL.Add('and envase_ce = envase_e ');
    SQL.Add('and fecha_baja_e is null ');
    Prepare;
  end;


  with QMaestro do
  begin
    SQL.Clear;
    SQL.Add(' select * from edi_cabcre where idcab_ecr = -1');
  (*
  idcab_ecr CHAR(10) NOT NULL,
  numcon_ecr CHAR(35),
  tipo_ecr CHAR(3),
  funcion_ecr CHAR(3),
  fecdoc_ecr DATE,
  fecrec_ecr DATE,
  numalb_ecr CHAR(35),
  numped_ecr CHAR(35),
  origen_ecr CHAR(17),
  destino_ecr CHAR(17),
  proveedor_ecr CHAR(17),
  * empresa_ecr CHAR(3),
  * centro_salida_ecr CHAR(1),
  matric_ecr CHAR(35),
  fcarga_ecr DATE,
  aqsfac_ecr CHAR(17)
  *)
  end;

  with QDetalle do
  begin
    SQL.Clear;
    SQL.Add(' select idcab_elr, idemb_elr, idlin_elr, ean_elr, refprov_elr, refcli_elr, cantace_elr, cantue_elr ');
    SQL.Add(' from edi_lincre where idcab_elr = :idcab_ecr ');
    SQL.Add(' order by idcab_elr, idemb_elr, idlin_elr ');
    Prepare;
  end;
  with QCantidades do
  begin
    SQL.Clear;
    SQL.Add(' select calif_enr, cantidad_enr, discrep_enr, razon_enr ');
    SQL.Add(' from edi_cantcre where idcab_enr = :idcab_elr and idemb_enr = :idemb_elr and idlin_enr = :idlin_elr  ');
    SQL.Add(' order by idcab_enr, idemb_enr, idlin_enr, calif_enr ');
    Prepare;
  end;
  with QObservaciones do
  begin
    SQL.Clear;
    SQL.Add(' select idobs_eor, texto1_eor, texto2_eor, texto3_eor, texto4_eor, texto5_eor ');
    SQL.Add(' from edi_obscabre where idcab_eor = :idcab_ecr ');
    SQL.Add(' order by idcab_eor, idobs_eor ');
    Prepare;
  end;

  //Mantenimiento cab
  sSelect := 'select empresa_ecr, idcab_ecr, numcon_ecr, tipo_ecr, ' +
             '       funcion_ecr, fecdoc_ecr, fecrec_ecr, numalb_ecr, numped_ecr, ' +
             '       origen_ecr, matric_ecr, destino_ecr, proveedor_ecr, fcarga_ecr ,' +
             '       aqsfac_ecr ';
  sFrom := 'From edi_cabcre ';
  sWhere := '';
  sOrder := 'order by idcab_ecr';

  with QAlbaranDet do
  begin
    Sql.Clear;

    SQL.Add(' select ');
    SQL.Add('         envase_sl envase, ');

    SQL.Add('         nvl( ( select descripcion_ce from frf_clientes_env ');
    SQL.Add('           where empresa_ce = :empresa_ecr and cliente_ce = cliente_sl ');
    SQL.Add('             and envase_ce = envase_sl and producto_ce = producto_sl ), ');
    SQL.Add('            ( select descripcion_e from frf_envases ');
    SQL.Add('              where envase_e = envase_sl and producto_e = producto_sl ) )descripcion, ');

    SQL.Add('         nvl( ( select unidad_fac_ce from frf_clientes_env ');
    SQL.Add('           where empresa_ce = :empresa_ecr and cliente_ce = cliente_sl ');
    SQL.Add('             and envase_ce = envase_sl and producto_ce = producto_sl ), ''K'' ) unidad_factura, ');

    SQL.Add('         sum(n_palets_sl) palets, ');
    SQL.Add('         sum(cajas_sl) cajas, ');
    SQL.Add('         sum(cajas_sl * unidades_caja_sl) unidades, ');
    SQL.Add('         sum( kilos_sl ) kilos ');

    SQL.Add('  from frf_salidas_l ');

    SQL.Add('  where empresa_sl = :empresa_ecr ');
    SQL.Add('  and n_albaran_sl = :numalb_ecr ');
    SQL.Add('  and fecha_sl = :fcarga_ecr ');

    SQL.Add('  group by 1,2,3 ');
    SQL.Add('  order by descripcion ');

    Prepare;
  end;

end;

procedure TDMRecadv.DataModuleDestroy(Sender: TObject);
begin
  with QFacturarA do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
  with QOrigen do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
  with QProveedor do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
  with QEnvase do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
  with QDetalle do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
  with QCantidades do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
  with QObservaciones do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
  with QAlbaranDet do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
end;

procedure TDMRecadv.QMaestroAfterOpen(DataSet: TDataSet);
begin
  QDetalle.Open;
  AbrirSubDetalle;
end;

procedure TDMRecadv.QMaestroBeforeClose(DataSet: TDataSet);
begin
  QAlbaranDet.Close;
  QObservaciones.Close;
  QCantidades.Close;
  QDetalle.Close;
end;

procedure TDMRecadv.Localizar(const AFiltro: string);
begin
  sWhere := AFiltro;
  with QMaestro do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sSelect);
    SQL.Add(sFrom);
    SQL.Add(sWhere);
    SQL.Add(sOrder);
    try
      Open;
    except
      raise Exception.Create('Error a aplicar el filtro.');
    end;
  end;
end;

function TDMRecadv.DesFacturarA( const AFacturarA: string ): string;
var
  i: Integer;
begin
  Result:= '';
  with QFacturarA do
  begin
    ParamByName('facturaa').AsString:= AFacturarA;
    Open;
    i:= 0;
    while not Eof do
    begin
      Result:= Result + FieldByName('cliente_ce').AsString + ' ';
      Next;
      Inc( i );
    end;
    if i = 1 then
      Result:= FieldByName('nombre_ce').AsString;
    Close;
  end;
end;

function TDMRecadv.DesOrigen( const AOrigen: string ): string;
var
  i: Integer;
begin
  Result:= '';
  with QOrigen do
  begin
    ParamByName('origen').AsString:= AOrigen;
    Open;
    i:= 0;
    while not Eof do
    begin
      Result:= Result + FieldByName('cliente_ce').AsString + '-' + FieldByName('dir_sum_ce').AsString + ' ';
      Next;
      Inc( i );
    end;
    if i = 1 then
      Result:= FieldByName('suministro_ce').AsString;
    Close;
  end;
end;

function TDMRecadv.DesProveedor( const AProveedor: string ): string;
var
  i: Integer;
begin
  Result:= '';
  with QProveedor do
  begin
    ParamByName('proveedor').AsString:= AProveedor;
    Open;
    i:= 0;
    while not Eof do
    begin
      Result:= Result + FieldByName('empresa_e').AsString + ' ';
      Next;
      Inc( i );
    end;
    if i = 1 then
      Result:= FieldByName('empresa_e').AsString + '-' + FieldByName('nombre_e').AsString;
    Close;
  end;
end;

function TDMRecadv.DesEnvaseCliente( const ACodigo: string; var AUnidad: string ): string;
begin
  QEnvase.ParamByName('refcli_elr').AsString:= ACodigo;
  QEnvase.Open;
  if QEnvase.FieldByName('unidades_fac').AsInteger <> 1 then
    AUnidad:= '*'
  else
    AUnidad:= QEnvase.FieldByName('unidad_fac').AsString;
  result:= QEnvase.FieldByName('descripcion').AsString;
  QEnvase.Close;
end;

procedure TDMRecadv.QDetalleCalcFields(DataSet: TDataSet);
var
  sAux: string;
begin
  QDetalleenvase.AsString:= DesEnvaseCliente( QDetallerefcli_elr.AsString, sAux );
  QDetalleunidad_fac.AsString:= sAux;
end;

procedure TDMRecadv.QCantidadesCalcFields(DataSet: TDataSet);
begin
  QCantidadescalificador.AsString:= GetCalificador( QCantidadescalif_enr.AsString );
  QCantidadesdiscrepancia.AsString:= GetDiscrepancia( QCantidadesdiscrep_enr.AsString );
  QCantidadesrazon.AsString:= GetRazon( QCantidadesrazon_enr.AsString );
end;

procedure TDMRecadv.AplicaFiltroDetalle( const AVerDetalle: integer );
begin
  iVerDetalle:= AVerDetalle;
  if QDetalle.Active then
  begin
    QCantidades.Close;
    QDetalle.Close;
    QDetalle.Open;
    QCantidades.Open;
  end;
end;

procedure TDMRecadv.QDetalleFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  case iVerDetalle of
    0: Accept:= Length( QDetallerefcli_elr.AsString ) = 5;
    1: Accept:= Length( QDetallerefcli_elr.AsString ) = 3;
    2: Accept:= Length( QDetallerefcli_elr.AsString ) = 2;
    3: Accept:= True;
  end;
end;

procedure TDMRecadv.CambiarSubDetalle( const APage: integer );
begin
  iPage:= APage;
  if QMaestro.Active then
    AbrirSubDetalle;
end;

procedure TDMRecadv.AbrirSubDetalle;
begin
  if iPage = 0 then
  begin
    QCantidades.Open;
    QObservaciones.Open;
    QAlbaranDet.Close;
  end
  else
  begin
    QCantidades.Close;
    QObservaciones.Close;
    QAlbaranDet.Open;
  end;
end;

end.
