unit LiqProdVendidoTransitosDM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMLiqProdVendidoTransitos = class(TDataModule)
    qryTransitos: TQuery;
    qryTransitoEntra: TQuery;
    dsTransitos: TDataSource;
    qryKilosTransito: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure qryTransitosAfterOpen(DataSet: TDataSet);
    procedure qryTransitosBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }
    rkilos_tran, rkilos_ent, rimporte_liq, rdescuentos_fac_liq, rgastos_fac_liq, rdescuentos_nofac_liq,
    rgastos_nofac_liq, rcostes_envasado_liq, rcostes_financiero_liq, rcostes_abonos_liq: real;
    iFacturado: Integer;

    procedure AjustarTransitosEx;
    function  GetCodeTran: string;
    procedure PutImportesSal;
  public
    { Public declarations }
    procedure AjustarTransitos( const AEmpresa, AProducto: string; const ADesde, AHasta: TDateTime );
  end;

var
  DMLiqProdVendidoTransitos: TDMLiqProdVendidoTransitos;

implementation

uses DateUtils, Math, Dialogs, LiqProdVendidoDM;

{$R *.dfm}

procedure TDMLiqProdVendidoTransitos.DataModuleCreate(Sender: TObject);
begin
  qryKilosTransito.sql.Clear;
  qryKilosTransito.sql.Add('select sum(kilos_tl) kilos ');
  qryKilosTransito.sql.Add('from frf_transitos_l ');
  qryKilosTransito.sql.Add('where empresa_tl = :empresa_tra ');
  qryKilosTransito.sql.Add('and centro_tl = :centro_tra ');
  qryKilosTransito.sql.Add('and fecha_tl = :fecha_tra ');
  qryKilosTransito.sql.Add('and referencia_tl = :n_transito ');
  //qryKilosTransito.sql.Add('and producto_tl = :producto_ent ');
  //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
  qryKilosTransito.sql.Add('and ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) = :producto_ent ');

  qryTransitoEntra.sql.Clear;
  qryTransitoEntra.sql.Add('select                          ');
  qryTransitoEntra.sql.Add('      min(facturado_sal) facturado_sal, sum(kilos_ent) kilos_ent, sum(kilos_liq) kilos_liq,  ');
  qryTransitoEntra.sql.Add('      sum(importe_liq) importe_liq, sum(descuentos_fac_liq) descuentos_fac_liq,  ');
  qryTransitoEntra.sql.Add('      sum(gastos_fac_liq) gastos_fac_liq,  sum(descuentos_nofac_liq) descuentos_nofac_liq,  ');
  qryTransitoEntra.sql.Add('      sum(gastos_nofac_liq) gastos_nofac_liq,  sum(costes_envasado_liq) costes_envasado_liq,  ');
  qryTransitoEntra.sql.Add('      sum(costes_abonos_liq) costes_abonos_liq, sum(costes_financiero_liq) costes_financiero_liq  ');
  qryTransitoEntra.sql.Add('from tliq_liquida_det  ');
  qryTransitoEntra.sql.Add('where empresa_ent = :empresa_tra ');
  qryTransitoEntra.sql.Add('and centro_origen_ent = :centro_tra ');
  qryTransitoEntra.sql.Add('and fecha_origen_ent = :fecha_tra ');
  qryTransitoEntra.sql.Add('and n_entrada = :n_transito ');
  qryTransitoEntra.sql.Add('and producto_ent = :producto_ent ');
//  qryTransitoEntra.sql.Add('and origen_sal <> ''T''  ');        // a partir del Nov 2020 (aprox) se empiezan a realizar transitos a centro 3 (P4H), no filtramos estas porque factural_sal = 0

  rimporte_liq:= 0;
  rdescuentos_fac_liq:= 0;
  rgastos_fac_liq:= 0;
  rdescuentos_nofac_liq:= 0;
  rgastos_nofac_liq:= 0;
  rcostes_envasado_liq:= 0;
  rcostes_financiero_liq:= 0;
  rcostes_abonos_liq:= 0;
  iFacturado:= 0;
end;

procedure TDMLiqProdVendidoTransitos.qryTransitosAfterOpen(
  DataSet: TDataSet);
begin
  //qryTransitoSale.Open;
  //qryTransitoEntra.Open;
end;

procedure TDMLiqProdVendidoTransitos.qryTransitosBeforeClose(
  DataSet: TDataSet);
begin
  //qryTransitoSale.Close;
  //qryTransitoEntra.Close;
end;

function TDMLiqProdVendidoTransitos.GetCodeTran: string;
begin
  result:= qryTransitos.FieldByName('empresa_tra').AsString +
           qryTransitos.FieldByName('centro_tra').AsString +
           qryTransitos.FieldByName('fecha_tra').AsString +
           qryTransitos.FieldByName('n_transito').AsString +
           qryTransitos.FieldByName('producto_ent').AsString;
end;

procedure TDMLiqProdVendidoTransitos.PutImportesSal;
begin
  qryKilosTransito.Open;
  rkilos_tran:= qryKilosTransito.FieldByName('kilos').AsFloat;
  qryKilosTransito.Close;

  qryTransitoEntra.Open;
  rkilos_ent:= qryTransitoEntra.FieldByName('kilos_ent').AsFloat;
  rimporte_liq:= qryTransitoEntra.FieldByName('importe_liq').AsFloat;
  rdescuentos_fac_liq:= qryTransitoEntra.FieldByName('descuentos_fac_liq').AsFloat;
  rgastos_fac_liq:= qryTransitoEntra.FieldByName('gastos_fac_liq').AsFloat;
  rdescuentos_nofac_liq:= qryTransitoEntra.FieldByName('descuentos_nofac_liq').AsFloat;
  rgastos_nofac_liq:= qryTransitoEntra.FieldByName('gastos_nofac_liq').AsFloat;
  rcostes_envasado_liq:= qryTransitoEntra.FieldByName('costes_envasado_liq').AsFloat;
  rcostes_financiero_liq:= qryTransitoEntra.FieldByName('costes_financiero_liq').AsFloat;
  rcostes_abonos_liq:= qryTransitoEntra.FieldByName('costes_abonos_liq').AsFloat;
  iFacturado:= qryTransitoEntra.FieldByName('facturado_sal').AsInteger;
  qryTransitoEntra.Close;
end;

procedure TDMLiqProdVendidoTransitos.AjustarTransitos( const AEmpresa, AProducto: string; const ADesde, AHasta: TDateTime );
var
  sTran: string;
begin
  //
  qryTransitos.sql.Clear;
  qryTransitos.sql.Add(' select *   ');
  qryTransitos.sql.Add(' from tliq_liquida_det ');
  qryTransitos.sql.Add(' where empresa_tra = :empresa ');
  qryTransitos.sql.Add('   and origen_sal = ''T'' ');
  //qryTransitos.sql.Add(' and facturado_sal = 0 ');
  if AProducto <> '' then
    qryTransitos.sql.Add(' and producto_ent = :producto ');
  qryTransitos.sql.Add(' and fecha_tra between :fechaini and :fechafin ');
  qryTransitos.sql.Add(' order by empresa_tra, centro_tra, fecha_tra, n_transito, producto_ent ');


  qryTransitos.ParamByName('empresa').AsString:= AEmpresa;
  if AProducto <> '' then
    qryTransitos.ParamByName('producto').AsString:= AProducto;
  qryTransitos.ParamByName('fechaini').AsDateTime:= ADesde;
  if DMLiqProdVendido.bSoloAjuste then
    qryTransitos.ParamByName('fechafin').AsDateTime:= AHasta
  else
    qryTransitos.ParamByName('fechafin').AsDateTime:= IncYear( AHasta, 1 );   //Carmen - Buscara TODOS los transitos que necesite para asignar a albaranes

  sTran:= '';
  qryTransitos.Open;
  try
    qryTransitos.First;
    while not qryTransitos.Eof do
    begin
      if sTran <> GetCodeTran then
      begin
        sTran:= GetCodeTran;
        PutImportesSal;
      end;
      AjustarTransitosEx;
      qryTransitos.Next;
    end;
  finally
    qryTransitos.Close;
  end;
end;


procedure TDMLiqProdVendidoTransitos.AjustarTransitosEx;
var
  rkilos_liq, rFactor: real;
begin
  if ( rkilos_ent <> 0 ) and ( rkilos_tran <> 0 ) then
  begin
    qryTransitos.edit;
    qryTransitos.FieldByName('facturado_sal').AsFloat:=  iFacturado;
    rkilos_liq:= qryTransitos.FieldByName('kilos_liq').AsFloat;
    if rkilos_liq <> 0 then
    begin
      //Por si no se ha dado salida al 100 del transito, solo tenemos en cuenta el porcentaje vendido
      rFactor:= ( rkilos_ent / rkilos_tran );
      qryTransitos.FieldByName('importe_liq').AsFloat:= ( ( rkilos_liq * rimporte_liq ) / rkilos_ent ) * rFactor;
      qryTransitos.FieldByName('descuentos_fac_liq').AsFloat:=( ( rkilos_liq * rdescuentos_fac_liq ) / rkilos_ent ) * rFactor;
      qryTransitos.FieldByName('gastos_fac_liq').AsFloat:=( ( rkilos_liq * rgastos_fac_liq ) / rkilos_ent ) * rFactor;
      qryTransitos.FieldByName('descuentos_nofac_liq').AsFloat:=( ( rkilos_liq * rdescuentos_nofac_liq ) / rkilos_ent ) * rFactor;
      qryTransitos.FieldByName('gastos_nofac_liq').AsFloat:=( ( rkilos_liq * rgastos_nofac_liq ) / rkilos_ent ) * rFactor;
      qryTransitos.FieldByName('costes_envasado_liq').AsFloat:=( ( rkilos_liq * rcostes_envasado_liq ) / rkilos_ent ) * rFactor;
      qryTransitos.FieldByName('costes_abonos_liq').AsFloat:=( ( rkilos_liq * rcostes_abonos_liq ) / rkilos_ent ) * rFactor;
      qryTransitos.FieldByName('costes_financiero_liq').AsFloat:=( ( rkilos_liq * rcostes_financiero_liq ) / rkilos_ent ) * rFactor;
    end;
    qryTransitos.FieldByName('liquido_liq').AsFloat:= qryTransitos.FieldByName('importe_liq').AsFloat -
                                 ( qryTransitos.FieldByName('descuentos_fac_liq').AsFloat + qryTransitos.FieldByName('gastos_fac_liq').AsFloat +
                                   qryTransitos.FieldByName('descuentos_nofac_liq').AsFloat + qryTransitos.FieldByName('gastos_nofac_liq').AsFloat +
                                   qryTransitos.FieldByName('gastos_transito_liq').AsFloat + qryTransitos.FieldByName('costes_envasado_liq').AsFloat +
                                   qryTransitos.FieldByName('costes_sec_transito_liq').AsFloat + qryTransitos.FieldByName('costes_abonos_liq').AsFloat +
                                   qryTransitos.FieldByName('costes_financiero_liq').AsFloat );
    qryTransitos.Post;
  end;
end;



end.
