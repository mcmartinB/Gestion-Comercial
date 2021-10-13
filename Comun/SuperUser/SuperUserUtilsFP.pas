unit SuperUserUtilsFP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, Grids, DBGrids;

type
  TFPSuperUserUtils = class(TForm)
    btnCerrar: TButton;
    lblEmpresa: TLabel;
    edtEmpresa: TEdit;
    lblDesEmpresa: TLabel;
    pgcMain: TPageControl;
    tsRFSinAlmacen: TTabSheet;
    btnRFSinAlmacen: TButton;
    tsPesoBrutoTan: TTabSheet;
    lbl1: TLabel;
    btn1: TButton;
    tsPaletInSinLineaIn: TTabSheet;
    btn2: TButton;
    tsFacturaX3Origen: TTabSheet;
    edtAbono: TEdit;
    btnFacturaX3Origen: TButton;
    edtFactura: TEdit;
    lblAbono: TLabel;
    lblFacturaX3: TLabel;
    tsTransitos: TTabSheet;
    btn3: TButton;
    dtpAsignaKilosTransitos: TDateTimePicker;
    lbl2: TLabel;
    btn4: TButton;
    edtProdLiq: TEdit;
    edTCentroLiq: TEdit;
    edtLiqIni: TEdit;
    edtLiqFin: TEdit;
    edtEmpresaLiq: TEdit;
    procedure btnCerrarClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRFSinAlmacenClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btnFacturaX3OrigenClick(Sender: TObject);
    procedure pgcMainChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
  private
    { Private declarations }

    procedure PonerAlmacen( const AEntrega: string );
    procedure NuevaTercera;
    procedure NuevaTerceraAux( const ACode, ALine: integer );
  public
    { Public declarations }
  end;


  procedure UtilidadesAdministrador( const AOwner: TComponent );


implementation

uses
  SuperUserUtilsDP, SuperUserUtilsQP, UDMAuxDB, QRExport, UDMCambioMoneda,
  LiqAsignaTransitosMD, DBTables, UDMBaseDatos;

{$R *.dfm}

var
  FPSuperUserUtils: TFPSuperUserUtils;
  DPSuperUserUtils: TDPSuperUserUtils;
  DMCambioMoneda2: TDMCambioMoneda;


procedure UtilidadesAdministrador( const AOwner: TComponent );
begin
  try
    FPSuperUserUtils:= TFPSuperUserUtils.Create( AOwner );
    DPSuperUserUtils:= TDPSuperUserUtils.Create( FPSuperUserUtils );

    FPSuperUserUtils.ShowModal;
  finally
    FreeAndNil( DPSuperUserUtils );
    FreeAndNil( FPSuperUserUtils );
  end;
end;


procedure TFPSuperUserUtils.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFPSuperUserUtils.FormCreate(Sender: TObject);
begin
  edtEmpresa.Text:= '';
  lblDesEmpresa.Caption:=  desEmpresa( edtEmpresa.Text );
  DMCambioMoneda2:= TDMCambioMoneda.Create( nil );
  pgcMainChange(pgcMain);
  dtpAsignaKilosTransitos.DateTime:= now;
end;

procedure TFPSuperUserUtils.edtEmpresaChange(Sender: TObject);
begin
  lblDesEmpresa.Caption:=  desEmpresa( edtEmpresa.Text );
end;


procedure TFPSuperUserUtils.PonerAlmacen( const AEntrega: string );
begin
  with DPSuperUserUtils.qryAux do
  begin
    if ( Copy( AEntrega, 1, 3) = '505' ) or ( Copy( AEntrega, 1, 3) = 'F42' ) then
      DatabaseName:= 'dbaBAG'
    else
      DatabaseName:= 'dba' + Copy( AEntrega, 1, 3);
    SQL.Clear;
    SQL.Add(' select max(almacen_el) almacen from frf_entregas_l where codigo_el = :codigo ');
    ParamByName('codigo').AsString:= AEntrega;
    Open;
    if not IsEmpty then
    begin
      DPSuperUserUtils.qryUpdate.ParamByName('entrega').AsString:=  AEntrega;
      DPSuperUserUtils.qryUpdate.ParamByName('almacen').AsString:=  FieldByName('almacen').AsString;
      DPSuperUserUtils.qryUpdate.ExecSQL;
    end;
    Close;
    DatabaseName:= 'BDProyecto';
  end;
end;

procedure TFPSuperUserUtils.btnRFSinAlmacenClick(Sender: TObject);
begin
  DPSuperUserUtils.qryUpdate.DatabaseName:= 'dba' + edtEmpresa.Text;
  DPSuperUserUtils.qryUpdate.SQL.Clear;
  DPSuperUserUtils.qryUpdate.SQL.Add('update rf_palet_pb set proveedor_almacen = :almacen   where entrega > :entrega and proveedor_almacen is null ');

  with DPSuperUserUtils.qryTempo do
  begin
    DatabaseName:= 'dba' + edtEmpresa.Text;
    SQL.Clear;
    SQL.Add(' select entrega from rf_palet_pb  where date(fecha_alta) > ''1/1/2013'' and proveedor_almacen is null ');
    Open;
    while not Eof do
    begin
      PonerAlmacen( FieldByname('entrega').AsString );
      Next;
    end;
    Close;
    DatabaseName:= 'BDProyecto';
  end;

  DPSuperUserUtils.qryUpdate.DatabaseName:= 'BDProyecto';
end;

procedure TFPSuperUserUtils.btn1Click(Sender: TObject);
var
  QPSuperUserUtils: TQPSuperUserUtils;
begin
  if DPSuperUserUtils.BrutoTransitos then
  begin
    QPSuperUserUtils:= TQPSuperUserUtils.Create( Self );
    try

      QPSuperUserUtils.ExportToFilter( TQRXLSFilter.Create( 'c:\pepe.xls' ) );
      //QPSuperUserUtils.Preview;
    finally
      FreeAndNil( QPSuperUserUtils );
      DPSuperUserUtils.qryAux.Close;
    end;
  end
  else
  begin
    DPSuperUserUtils.qryAux.Close;
  end;
end;

procedure TFPSuperUserUtils.btn2Click(Sender: TObject);
begin

  DPSuperUserUtils.qryTempo.Sql.Clear;
  DPSuperUserUtils.qryTempo.Sql.Add(' select empresa_e2l, numero_entrada_e2l, centro_e2l, fecha_e2l, ');
  DPSuperUserUtils.qryTempo.Sql.Add('         producto_e2l, cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l, ');
  DPSuperUserUtils.qryTempo.Sql.Add('         total_cajas_e2l - nvl(sum( total_cajas_e1l ),0) cajas ');
  DPSuperUserUtils.qryTempo.Sql.Add('  from frf_entradas2_l ');
  DPSuperUserUtils.qryTempo.Sql.Add('       left join frf_entradas1_l on empresa_e2l = empresa_e1l ');
  DPSuperUserUtils.qryTempo.Sql.Add('                                 and numero_entrada_e2l = numero_entrada_e1l ');
  DPSuperUserUtils.qryTempo.Sql.Add('                                 and centro_e2l = centro_e1l ');
  DPSuperUserUtils.qryTempo.Sql.Add('                                 and fecha_e2l = fecha_e1l ');
  DPSuperUserUtils.qryTempo.Sql.Add('                                 and producto_e2l = producto_e1l ');
  DPSuperUserUtils.qryTempo.Sql.Add('                                 and cosechero_e2l = cosechero_e1l ');
  DPSuperUserUtils.qryTempo.Sql.Add('                                 and plantacion_e2l = plantacion_e1l ');
  DPSuperUserUtils.qryTempo.Sql.Add('                                 and ano_sem_planta_e2l = ano_sem_planta_e1l ');
  DPSuperUserUtils.qryTempo.Sql.Add(' where empresa_e2l = :empresa ');
  DPSuperUserUtils.qryTempo.Sql.Add('    and numero_entrada_e2l = :numero ');
  DPSuperUserUtils.qryTempo.Sql.Add('    and centro_e2l = :centro ');
  DPSuperUserUtils.qryTempo.Sql.Add('    and fecha_e2l = :fecha ');
  DPSuperUserUtils.qryTempo.Sql.Add('    and producto_e2l = :producto ');
  DPSuperUserUtils.qryTempo.Sql.Add('    and cosechero_e2l = :cosechero ');
//--   and plantacion_e2l = 28
//--   and ano_sem_planta_e2l = 200137

  DPSuperUserUtils.qryTempo.Sql.Add(' group by empresa_e2l, numero_entrada_e2l, centro_e2l, fecha_e2l, ');
  DPSuperUserUtils.qryTempo.Sql.Add('         producto_e2l, cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l, ');
  DPSuperUserUtils.qryTempo.Sql.Add('         total_cajas_e2l ');

  DPSuperUserUtils.qryTempo.Sql.Add('  having nvl(sum( total_cajas_e1l ),0) < total_cajas_e2l ');
  DPSuperUserUtils.qryTempo.Prepare;


  DPSuperUserUtils.qryUpdate.Sql.Clear;
  DPSuperUserUtils.qryUpdate.Sql.Add(' update frf_entradas1_l ');
  DPSuperUserUtils.qryUpdate.Sql.Add('  set plantacion_e1l = :plantacion, ');
  DPSuperUserUtils.qryUpdate.Sql.Add('    ano_sem_planta_e1l = :ano_sem_planta ');
  DPSuperUserUtils.qryUpdate.Sql.Add('  where empresa_e1l = :empresa_e1l ');
  DPSuperUserUtils.qryUpdate.Sql.Add('    and numero_entrada_e1l = :numero_entrada_e1l ');
  DPSuperUserUtils.qryUpdate.Sql.Add('    and centro_e1l = :centro_e1l ');
  DPSuperUserUtils.qryUpdate.Sql.Add('    and fecha_e1l = :fecha_e1l ');
  DPSuperUserUtils.qryUpdate.Sql.Add('    and producto_e1l = :producto_e1l ');
  DPSuperUserUtils.qryUpdate.Sql.Add('    and cosechero_e1l = :cosechero_e1l ');
  DPSuperUserUtils.qryUpdate.Sql.Add('    and plantacion_e1l = :plantacion_e1l ');
  DPSuperUserUtils.qryUpdate.Sql.Add('    and ano_sem_planta_e1l = :ano_sem_planta_e1l ');
  DPSuperUserUtils.qryUpdate.Prepare;




  DPSuperUserUtils.qryAux.Sql.Clear;
  DPSuperUserUtils.qryAux.Sql.Add('  select empresa_e1l, numero_entrada_e1l, centro_e1l, fecha_e1l, ');
  DPSuperUserUtils.qryAux.Sql.Add('          producto_e1l, cosechero_e1l, plantacion_e1l, ano_sem_planta_e1l, ');
  DPSuperUserUtils.qryAux.Sql.Add('          sum( total_cajas_e1l ) total_cajas_e1l ');
  DPSuperUserUtils.qryAux.Sql.Add('  from frf_entradas1_l ');
  DPSuperUserUtils.qryAux.Sql.Add(' where not exists ');
  DPSuperUserUtils.qryAux.Sql.Add(' ( ');
  DPSuperUserUtils.qryAux.Sql.Add('  select * from frf_entradas2_l ');
  DPSuperUserUtils.qryAux.Sql.Add('  where empresa_e2l = empresa_e1l ');
  DPSuperUserUtils.qryAux.Sql.Add('    and numero_entrada_e2l = numero_entrada_e1l ');
  DPSuperUserUtils.qryAux.Sql.Add('    and centro_e2l = centro_e1l ');
  DPSuperUserUtils.qryAux.Sql.Add('    and fecha_e2l = fecha_e1l ');
  DPSuperUserUtils.qryAux.Sql.Add('    and producto_e2l = producto_e1l ');
  DPSuperUserUtils.qryAux.Sql.Add('    and cosechero_e2l = cosechero_e1l ');
  DPSuperUserUtils.qryAux.Sql.Add('    and plantacion_e2l = plantacion_e1l ');
  DPSuperUserUtils.qryAux.Sql.Add('    and ano_sem_planta_e2l = ano_sem_planta_e1l ) ');
  DPSuperUserUtils.qryAux.Sql.Add(' group by empresa_e1l, numero_entrada_e1l, centro_e1l, fecha_e1l, ');
  DPSuperUserUtils.qryAux.Sql.Add('         producto_e1l, cosechero_e1l, plantacion_e1l, ano_sem_planta_e1l ');
  DPSuperUserUtils.qryAux.Open;
  while not DPSuperUserUtils.qryAux.Eof do
  begin
    DPSuperUserUtils.qryTempo.ParamByName('empresa').AsString:= DPSuperUserUtils.qryAux.FieldByName('empresa_e1l').AsString;
    DPSuperUserUtils.qryTempo.ParamByName('numero').AsInteger:= DPSuperUserUtils.qryAux.FieldByName('numero_entrada_e1l').AsInteger;
    DPSuperUserUtils.qryTempo.ParamByName('centro').AsString:= DPSuperUserUtils.qryAux.FieldByName('centro_e1l').AsString;
    DPSuperUserUtils.qryTempo.ParamByName('fecha').AsDateTime:= DPSuperUserUtils.qryAux.FieldByName('fecha_e1l').AsDateTime;
    DPSuperUserUtils.qryTempo.ParamByName('producto').AsString:= DPSuperUserUtils.qryAux.FieldByName('producto_e1l').AsString;
    DPSuperUserUtils.qryTempo.ParamByName('cosechero').AsString:= DPSuperUserUtils.qryAux.FieldByName('cosechero_e1l').AsString;
    DPSuperUserUtils.qryTempo.Open;
    if not DPSuperUserUtils.qryTempo.IsEmpty then
    begin
      if DPSuperUserUtils.qryTempo.FieldByName('cajas').AsInteger >= DPSuperUserUtils.qryAux.FieldByName('total_cajas_e1l').AsInteger then
      begin
        DPSuperUserUtils.qryUpdate.ParamByName('plantacion').AsString:= DPSuperUserUtils.qryTempo.FieldByName('plantacion_e2l').AsString;
        DPSuperUserUtils.qryUpdate.ParamByName('ano_sem_planta').AsString:= DPSuperUserUtils.qryTempo.FieldByName('ano_sem_planta_e2l').AsString;
        DPSuperUserUtils.qryUpdate.ParamByName('empresa_e1l').AsString:= DPSuperUserUtils.qryAux.FieldByName('empresa_e1l').AsString;
        DPSuperUserUtils.qryUpdate.ParamByName('numero_entrada_e1l').AsInteger:= DPSuperUserUtils.qryAux.FieldByName('numero_entrada_e1l').AsInteger;
        DPSuperUserUtils.qryUpdate.ParamByName('centro_e1l').AsString:= DPSuperUserUtils.qryAux.FieldByName('centro_e1l').AsString;
        DPSuperUserUtils.qryUpdate.ParamByName('fecha_e1l').AsDateTime:= DPSuperUserUtils.qryAux.FieldByName('fecha_e1l').AsDateTime;
        DPSuperUserUtils.qryUpdate.ParamByName('producto_e1l').AsString:= DPSuperUserUtils.qryAux.FieldByName('producto_e1l').AsString;
        DPSuperUserUtils.qryUpdate.ParamByName('cosechero_e1l').AsString:= DPSuperUserUtils.qryAux.FieldByName('cosechero_e1l').AsString;
        DPSuperUserUtils.qryUpdate.ParamByName('plantacion_e1l').AsString:= DPSuperUserUtils.qryAux.FieldByName('plantacion_e1l').AsString;
        DPSuperUserUtils.qryUpdate.ParamByName('ano_sem_planta_e1l').AsString:= DPSuperUserUtils.qryAux.FieldByName('ano_sem_planta_e1l').AsString;
        DPSuperUserUtils.qryUpdate.ExecSQL;
      end;
    end;
    DPSuperUserUtils.qryTempo.Close;
    DPSuperUserUtils.qryAux.Next;
  end;
  DPSuperUserUtils.qryAux.Close;
  DPSuperUserUtils.qryAux.RequestLive:= False;
end;

procedure TFPSuperUserUtils.btnFacturaX3OrigenClick(Sender: TObject);
var
  sAux: string;
begin
  DMAuxDB.QAux.SQL.Clear;
  DMAuxDB.QAux.SQL.Add(' select cod_factura_anula_fc from tfacturas_cab where cod_factura_fc = ' + QuotedStr(edtAbono.Text ));
  DMAuxDB.QAux.Open;
  saux:= DMAuxDB.QAux.FieldByName('cod_factura_anula_fc').AsString;
  DMAuxDB.QAux.Close;
  if saux = '' then
  begin
    DMAuxDB.QAux.SQL.Clear;
    DMAuxDB.QAux.SQL.Add(' select cod_factura_fc from tfacturas_cab where cod_factura_anula_fc = ' + QuotedStr(edtAbono.Text ));
    DMAuxDB.QAux.Open;
    saux:= DMAuxDB.QAux.FieldByName('cod_factura_fc').AsString;
    DMAuxDB.QAux.Close;
  end;

  if saux <> '' then
  begin
    DMCambioMoneda2.qryX3FacturaOrigen.sql.clear;
    DMCambioMoneda2.qryX3FacturaOrigen.sql.Add(' SELECT NUM_0 FROM BONNYSA.PINVOICE WHERE BPRVCR_0= ' + QuotedStr(saux ));
    DMCambioMoneda2.qryX3FacturaOrigen.Open;
    if DMCambioMoneda2.qryX3FacturaOrigen.FieldByName('NUM_0').AsString <> '' then
      saux:= DMCambioMoneda2.qryX3FacturaOrigen.FieldByName('NUM_0').AsString
    else
      saux:= 'ERROR X3';
    DMCambioMoneda2.qryX3Cambio.Close;
  end
  else
  begin
    saux:= 'ERROR COMER';
  end;

  edtFactura.Text:=  saux;
end;

procedure TFPSuperUserUtils.pgcMainChange(Sender: TObject);
begin
  if pgcMain.ActivePage = tsFacturaX3Origen then
  begin
    DMBaseDatos.conX3.Open;
  end
  else
  begin
    DMBaseDatos.conX3.Close;
  end;
end;

procedure TFPSuperUserUtils.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if DMBaseDatos.conX3.Connected then
    DMBaseDatos.conX3.Close;
  FreeAndNil( DMCambioMoneda2 );
end;

procedure TFPSuperUserUtils.btn3Click(Sender: TObject);
var
  dFecha: TDateTime;
begin
  dFecha:= Trunc( dtpAsignaKilosTransitos.Date );
  LiqAsignaTransitosMD.AsignarKilosTransitos( dFecha, dFecha + 7 );
(*
//TOTALES
select empresa_ent, centro_origen_ent, producto_ent, categoria_ent, 
       sum(kilos_liq) kilos
from tliq_liquida_det
where origen_ent =  'T' 
and empresa_ent = '050'
and fecha_origen_ent between '1/2/2017' and '28/2/2017'
group by empresa_ent, centro_origen_ent, producto_ent, categoria_ent
order by empresa_ent, centro_origen_ent, producto_ent, categoria_ent

//DETALLE TRANSITO
select empresa_ent, centro_sal, n_salida, fecha_sal, producto_ent, categoria_ent, sum(kilos_liq) kilos
from tliq_liquida_det
where origen_ent =  'T' 
and empresa_ent = '050'
and fecha_origen_ent between '1/2/2017' and '28/2/2017'

and centro_origen_ent = '6'
and producto_ent = 'S'
and categoria_ent = '2'
group by empresa_ent, centro_sal, n_salida, fecha_sal, producto_ent, categoria_ent 
order by empresa_ent, centro_sal, n_salida, fecha_sal, producto_ent, categoria_ent

//SALIDAS
select *
from frf_salidas_l
where empresa_sl = '050'
and centro_salida_sl = '1'
and fecha_sl = '8/2/2017'
and n_albaran_sl = 312501
--> and categoria_sl = '2'
--> and categoria_sl not in ('1','2','3')



//KILOS ASIGNADOS
select producto_sl,
       case when categoria_sl not in ('1','2','3') then '4' else categoria_sl end categoria,
       sum(kilos_sl)

from frf_salidas_l
where empresa_sl = '050'
and centro_salida_sl = '1'
and fecha_sl >= '1/2/2017'
and centro_origen_sl = '6'
and ref_transitos_sl is null

group by producto_sl, categoria
order by producto_sl, categoria

*)

end;

procedure TFPSuperUserUtils.NuevaTerceraAux( const ACode, ALine: integer );
begin
  with dmAuxDB.QGeneral do
  begin
    Insert;
    FieldByName('codigo_liq').Asinteger:=  ACode;
    FieldByName('linea_liq').Asinteger:=  ALine;
    FieldByName('fecha_ent').AsDateTime:=  dmAuxDB.QAux.FieldByName('fecha_e2l').AsDateTime;
    FieldByName('producto_ent').AsString:=  dmAuxDB.QAux.FieldByName('producto_E2l').AsString;
    FieldByName('empresa_ent').AsString:=  dmAuxDB.QAux.FieldByName('empresa_e2l').AsString;
    FieldByName('centro_ent').AsString:=  dmAuxDB.QAux.FieldByName('centro_e2l').AsString;
    FieldByName('n_entrada').AsInteger:=  dmAuxDB.QAux.FieldByName('numero_entrada_e2l').AsInteger;
    FieldByName('cosechero_ent').AsString:=  dmAuxDB.QAux.FieldByName('cosechero_e2l').AsString;
    FieldByName('plantacion_ent').AsString:=  dmAuxDB.QAux.FieldByName('plantacion_e2l').AsString;
    FieldByName('semana_planta_ent').AsString:=  dmAuxDB.QAux.FieldByName('ano_sem_planta_e2l').AsString;

    FieldByName('hora_ent').Asinteger:=  1200;
    //FieldByName('origen_ent').AsString:=  'E';
    FieldByName('fecha_origen_ent').AsDateTime:=  dmAuxDB.QAux.FieldByName('fecha_e2l').AsDateTime;
    FieldByName('centro_origen_ent').AsString:=  dmAuxDB.QAux.FieldByName('centro_e2l').AsString;
    FieldByName('tipo_ent').Asinteger:=  0;


    FieldByName('categoria_ent').Asinteger:=  3;
    FieldByName('kilos_ent').AsFloat:=  dmAuxDB.QAux.FieldByName('kilos').AsFloat;
    FieldByName('kilos_net').Asinteger:=  0;
    FieldByName('kilos_aux_ent').Asinteger:=  0;
    FieldByName('kilos_aux_net').Asinteger:=  0;
    FieldByName('kilos_aux_liq').Asinteger:=  0;
    FieldByName('cajas_liq').Asinteger:=  0;
    FieldByName('kilos_liq').Asinteger:=  0;
    FieldByName('importe_liq').Asinteger:=  0;
    FieldByName('descuentos_fac_liq').Asinteger:=  0;
    FieldByName('gastos_fac_liq').Asinteger:=  0;
    FieldByName('descuentos_nofac_liq').Asinteger:=  0;
    FieldByName('gastos_nofac_liq').Asinteger:=  0;
    FieldByName('gastos_transito_liq').Asinteger:=  0;
    FieldByName('costes_envasado_liq').Asinteger:=  0;
    FieldByName('costes_sec_transito_liq').Asinteger:=  0;
    FieldByName('costes_abonos_liq').Asinteger:=  0;
    FieldByName('costes_financiero_liq').Asinteger:=  0;
    FieldByName('liquido_liq').Asinteger:=  0;

    FieldByName('origen_sal').AsString:=  '';
    FieldByName('empresa_tra').AsString:=  '';
    FieldByName('centro_tra').AsString:=  '';
    FieldByName('n_transito').AsString:=  '';
    FieldByName('fecha_tra').AsString:=  '';
    FieldByName('hora_tra').AsString:=  '';
    FieldByName('empresa_sal').AsString:=  '';
    FieldByName('centro_sal').AsString:=  '';
    FieldByName('n_salida').AsString:=  '';
    FieldByName('fecha_sal').AsString:=  '';
    FieldByName('hora_sal').AsString:=  '';
    FieldByName('facturado_sal').AsString:=  '';
    FieldByName('envase_sal').AsString:=  '';
    Post;
  end;
end;
procedure TFPSuperUserUtils.NuevaTercera;
var
  iCode, iLine: integer;
begin
  with dmAuxDB.QGeneral do
  begin
    Sql.Clear;
    Sql.Add('select codigo_liq ');
    Sql.Add('from tliq_liquida_det ');
    Sql.Add('where fecha_ent = :fecha ');
    Sql.Add('and producto_ent = :producto ');
    Sql.Add('and empresa_ent = :empresa ');
    Sql.Add('and centro_ent = :centro ');
    Sql.Add('and n_entrada = :entrada ');
    Sql.Add('and cosechero_ent = :cosechero ');
    Sql.Add('and plantacion_ent = :plantacion ');
    Sql.Add('and semana_planta_ent = :anosem ');

    ParamByName('fecha').AsDateTime:=  dmAuxDB.QAux.FieldByName('fecha_e2l').AsDateTime;
    ParamByName('producto').AsString:=  dmAuxDB.QAux.FieldByName('producto_E2l').AsString;
    ParamByName('empresa').AsString:=  dmAuxDB.QAux.FieldByName('empresa_e2l').AsString;
    ParamByName('centro').AsString:=  dmAuxDB.QAux.FieldByName('centro_e2l').AsString;
    ParamByName('entrada').AsInteger:=  dmAuxDB.QAux.FieldByName('numero_entrada_e2l').AsInteger;
    ParamByName('cosechero').AsString:=  dmAuxDB.QAux.FieldByName('cosechero_e2l').AsString;
    ParamByName('plantacion').AsString:=  dmAuxDB.QAux.FieldByName('plantacion_e2l').AsString;
    ParamByName('anosem').AsString:=  dmAuxDB.QAux.FieldByName('ano_sem_planta_e2l').AsString;
    Open;
    if IsEmpty  then
      raise Exception.Create('No hay liquidacion.');
    iCode:= FieldByName('codigo_liq').AsInteger;
    Close;


    Sql.Clear;
    Sql.Add('select max(linea_liq) linea ');
    Sql.Add('from tliq_liquida_det ');
    Sql.Add('where codigo_liq = :code ');
    ParamByName('code').AsInteger:=  iCode;
    Open;
    iLine:= FieldByName('linea').AsInteger + 1;
    Close;

    RequestLive:= True;
    Sql.Clear;
    Sql.Add('select * ');
    Sql.Add('from tliq_liquida_det ');
    Sql.Add('where fecha_ent = :fecha ');
    Sql.Add('and producto_ent = :producto ');
    Sql.Add('and empresa_ent = :empresa ');
    Sql.Add('and centro_ent = :centro ');
    Sql.Add('and n_entrada = :entrada ');
    Sql.Add('and cosechero_ent = :cosechero ');
    Sql.Add('and plantacion_ent = :plantacion ');
    Sql.Add('and categoria_ent = :categoria ');

    ParamByName('fecha').AsDateTime:=  dmAuxDB.QAux.FieldByName('fecha_e2l').AsDateTime;
    ParamByName('producto').AsString:=  dmAuxDB.QAux.FieldByName('producto_E2l').AsString;
    ParamByName('empresa').AsString:=  dmAuxDB.QAux.FieldByName('empresa_e2l').AsString;
    ParamByName('centro').AsString:=  dmAuxDB.QAux.FieldByName('centro_e2l').AsString;
    ParamByName('entrada').AsInteger:=  dmAuxDB.QAux.FieldByName('numero_entrada_e2l').AsInteger;
    ParamByName('cosechero').AsString:=  dmAuxDB.QAux.FieldByName('cosechero_e2l').AsString;
    ParamByName('plantacion').AsString:=  dmAuxDB.QAux.FieldByName('plantacion_e2l').AsString;
    ParamByName('categoria').AsInteger:=  3;
    Open;
    try
      if IsEmpty then
        NuevaTerceraAux( iCode, Iline );
    finally
      Close;
      RequestLive:= False;
    end;

  end;
end;

procedure TFPSuperUserUtils.btn4Click(Sender: TObject);
begin
  with dmAuxDB.QAux do
  begin
    sql.Clear;
    sql.Add('select empresa_e2l, centro_e2l, numero_entrada_e2l, fecha_e2l, producto_E2l, ');
    sql.Add('       cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l, ');
    sql.Add('       sum( round( total_kgs_e2l * porcen_tercera_e / 100, 2) ) kilos');

    sql.Add('from frf_entradas2_l ');
    sql.Add('     join frf_Escandallo on empresa_e2l = empresa_e and centro_e2l = centro_e and numero_entrada_e2l = numero_entrada_e ');
    sql.Add('                          and fecha_e2l = fecha_e and cosechero_e2l = cosechero_e and plantacion_e2l = plantacion_e ');
    sql.Add('where fecha_e2l between :ini and :fin ');
    sql.Add('and producto_e2l = :producto ');
    sql.Add('and empresa_e2l = :empresa ');
    sql.Add('and centro_e2l = :centro ');
    sql.Add('and porcen_tercera_e <> 0 ');
    sql.Add('group by empresa_e2l, centro_e2l, numero_entrada_e2l, fecha_e2l, producto_e2l, ');
    sql.Add('         cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l ');
    ParamByName('producto').AsString:= edtProdLiq.Text;
    ParamByName('centro').AsString:= edTCentroLiq.Text;
    ParamByName('empresa').AsString:= edtEmpresaLiq.Text;
    ParamByName('ini').AsString:= edtLiqIni.Text;
    ParamByName('fin').AsString:= edtLiqFin.Text;
    Open;

    try
      while not Eof do
      begin
        NuevaTercera;
        Next;
      end;
    finally
      Close;
    end;
  end;
end;

end.
