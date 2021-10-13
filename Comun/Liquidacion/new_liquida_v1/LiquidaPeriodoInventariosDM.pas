unit LiquidaPeriodoInventariosDM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMLiquidaPeriodoInventarios = class(TDataModule)
    qryAux: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
     //Parametros de entrada
    sEmpresa, sCentro, sProducto, sSemana, sSemanaKey, sPriorKey: string;
    dFechaIni, dFechaFin: TDateTime;

    rKilosIni, rKilosIniPrimera, rKilosIniSegunda, rKilosIniTercera, rKilosIniDestrio,
    rKilosFin, rKilosFinPrimera, rKilosFinSegunda, rKilosFinTercera, rKilosFinDestrio: real;
    rNetoIni, rNetoIniPrimera, rNetoIniSegunda, rNetoIniTercera, rNetoIniDestrio,
    rNetoFin, rNetoFinPrimera, rNetoFinSegunda, rNetoFinTercera, rNetoFinDestrio: real;
    rAjuste, rAjustePrimera, rAjusteSegunda, rAjusteTercera, rAjusteDestrio: real;

    procedure PutKilosInventario;
    procedure GrabarKilosInventario;
    procedure ValorarInventarioIni;
    procedure ValorarInventarioFin;
    procedure ValorarInventario;
    procedure AjusteInventario;

  public
    { Public declarations }
    procedure InventariosSemana(const AKey, AEmpresa, ACentro, AProducto, ASemana: string;
                             const ADesde, AHasta: TDateTime; var AIni, AFin: Real);
  end;

var
  DMLiquidaPeriodoInventarios: TDMLiquidaPeriodoInventarios;

implementation

{$R *.dfm}

uses
  LiquidaPeriodoDM, bMath, bTimeUtils;

procedure TDMLiquidaPeriodoInventarios.DataModuleDestroy(Sender: TObject);
begin
  //
end;

procedure TDMLiquidaPeriodoInventarios.DataModuleCreate(Sender: TObject);
begin
  //
end;


procedure TDMLiquidaPeriodoInventarios.InventariosSemana(const AKey, AEmpresa, ACentro, AProducto, ASemana: string;
                             const ADesde, AHasta: TDateTime; var AIni, AFin: Real );
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  sProducto:= AProducto;
  dFechaIni:= ADesde;
  dFechaFin:= AHasta;
  sSemana:= ASemana;
  sSemanaKey:= AKey;
  sPriorKey:= AEmpresa + ACentro + AProducto + AnyoSemana( dFechaIni - 1 );;

  PutKilosInventario;
  ValorarInventario;
  GrabarKilosInventario;
  
  AIni:= rKilosIni;
  AFin:= rKilosFin;
end;


procedure TDMLiquidaPeriodoInventarios.PutKilosInventario;
var
  rAux: Real;
begin
  rKilosIniPrimera:= 0;
  rKilosIniSegunda:= 0;
  rKilosIniTercera:= 0;
  rKilosIniDestrio:= 0;
  rKilosFinPrimera:= 0;
  rKilosFinSegunda:= 0;
  rKilosFinTercera:= 0;
  rKilosFinDestrio:= 0;

  (*TODO*)//Faltan los ajustes
  with qryAux  do
  begin
    Sql.Clear;
    Sql.Add('select nvl(kilos_cec_ic,0) stock_cam, ');
    Sql.Add('       nvl(kilos_cim_c1_ic,0) + nvl(kilos_cia_c1_ic,0) stock_pri, ');
    Sql.Add('       nvl(kilos_cim_c2_ic,0) + nvl(kilos_cia_c2_ic,0) stock_seg, ');
    Sql.Add('       nvl(kilos_zd_c3_ic,0) stock_ter, ');
    Sql.Add('       nvl(kilos_zd_d_ic,0) stock_des, ');
    Sql.Add('       nvl(kilos_ajuste_c1_ic,0) ajuste_pri, ');
    Sql.Add('       nvl(kilos_ajuste_c2_ic,0) ajuste_seg, ');
    Sql.Add('       nvl(kilos_ajuste_c3_ic,0) ajuste_ter, ');
    Sql.Add('       nvl(kilos_ajuste_cd_ic,0) ajuste_des, ');
    Sql.Add('       nvl(kilos_ajuste_campo_ic,0) ajuste_cam ');
    Sql.Add('from frf_inventarios_c ');
    Sql.Add('where empresa_ic = :empresa ');
    Sql.Add('and centro_ic = :centro  ');
    Sql.Add('and producto_ic = :producto ');
    Sql.Add('and fecha_ic = :fecha ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fecha').AsDateTime:= ( dFechaIni - 1 );
    Open;
    if IsEmpty then
      DMLiquidaPeriodo.AddWarning( 'Falta inventario de inico' )
    else
    begin
      (*TODO*) //usar ajustes semana anterior
      (*
      rAux:= tkilos_pri_sal + tkilos_seg_sal +  tkilos_ter_sal + tkilos_des_sal;
      if rAux <> 0 then
      begin
        rKilosIniPrimera:= FieldByName('stock_pri').AsFloat + bRoundTo( ( FieldByName('stock_cam').AsFloat * tkilos_pri_sal ) / rAux, 2) ;
        rKilosIniSegunda:= FieldByName('stock_seg').AsFloat + bRoundTo( ( FieldByName('stock_cam').AsFloat * tkilos_seg_sal ) / rAux, 2) ;
        rKilosIniTercera:= FieldByName('stock_ter').AsFloat + bRoundTo( ( FieldByName('stock_cam').AsFloat * tkilos_ter_sal ) / rAux, 2) ;
        rKilosIniDestrio:= FieldByName('stock_des').AsFloat + bRoundTo( ( FieldByName('stock_cam').AsFloat * tkilos_des_sal ) / rAux, 2) ;
      end
      else*)
      begin
        rAux:= FieldByName('stock_pri').AsFloat + FieldByName('stock_seg').AsFloat +  FieldByName('stock_ter').AsFloat + FieldByName('stock_des').AsFloat;
        if rAux <> 0 then
        begin
          rKilosIniPrimera:= FieldByName('stock_pri').AsFloat + bRoundTo( ( FieldByName('stock_cam').AsFloat * FieldByName('stock_pri').AsFloat ) / rAux, 2) ;
          rKilosIniSegunda:= FieldByName('stock_seg').AsFloat + bRoundTo( ( FieldByName('stock_cam').AsFloat * FieldByName('stock_seg').AsFloat ) / rAux, 2) ;
          rKilosIniTercera:= FieldByName('stock_ter').AsFloat + bRoundTo( ( FieldByName('stock_cam').AsFloat * FieldByName('stock_ter').AsFloat ) / rAux, 2) ;
          rKilosIniDestrio:= FieldByName('stock_des').AsFloat + bRoundTo( ( FieldByName('stock_cam').AsFloat * FieldByName('stock_des').AsFloat ) / rAux, 2) ;
        end;
      end;
    end;

    Close;

    ParamByName('fecha').AsDateTime:= ( dFechaFin );
    Open;
    if IsEmpty then
      DMLiquidaPeriodo.AddWarning( 'Falta inventario de fin' )
    else
    if IsEmpty then
      DMLiquidaPeriodo.AddWarning( 'Falta inventario de inico' )
    else
    begin
      (*TODO*) //activar semana anterior para stock ini
      (*
      rAux:= tkilos_pri_sal + tkilos_seg_sal +  tkilos_ter_sal + tkilos_des_sal;
      if rAux <> 0 then
      begin
        rKilosFinPrimera:= FieldByName('stock_pri').AsFloat + bRoundTo( ( FieldByName('stock_cam').AsFloat * tkilos_pri_sal ) / rAux, 2) ;
        rKilosFinSegunda:= FieldByName('stock_seg').AsFloat + bRoundTo( ( FieldByName('stock_cam').AsFloat * tkilos_seg_sal ) / rAux, 2) ;
        rKilosFinTercera:= FieldByName('stock_ter').AsFloat + bRoundTo( ( FieldByName('stock_cam').AsFloat * tkilos_ter_sal ) / rAux, 2) ;
        rKilosFinDestrio:= FieldByName('stock_des').AsFloat + bRoundTo( ( FieldByName('stock_cam').AsFloat * tkilos_des_sal ) / rAux, 2) ;
      end
      else*)
      begin
        rAux:= FieldByName('stock_pri').AsFloat + FieldByName('stock_seg').AsFloat +  FieldByName('stock_ter').AsFloat + FieldByName('stock_des').AsFloat;
        if rAux <> 0 then
        begin
          rKilosFinPrimera:= FieldByName('stock_pri').AsFloat + bRoundTo( ( FieldByName('stock_cam').AsFloat * FieldByName('stock_pri').AsFloat ) / rAux, 2) ;
          rKilosFinSegunda:= FieldByName('stock_seg').AsFloat + bRoundTo( ( FieldByName('stock_cam').AsFloat * FieldByName('stock_seg').AsFloat ) / rAux, 2) ;
          rKilosFinTercera:= FieldByName('stock_ter').AsFloat + bRoundTo( ( FieldByName('stock_cam').AsFloat * FieldByName('stock_ter').AsFloat ) / rAux, 2) ;
          rKilosFinDestrio:= FieldByName('stock_des').AsFloat + bRoundTo( ( FieldByName('stock_cam').AsFloat * FieldByName('stock_des').AsFloat ) / rAux, 2) ;
        end;
      end;
    end;

    Close;

    Sql.Clear;
    Sql.Add('select sum(nvl(kilos_ce_c1_il,0)) confeccionado_pri, sum(nvl(kilos_ce_c2_il,0)) confeccionado_seg ');
    Sql.Add('from frf_inventarios_l ');
    Sql.Add('where empresa_il = :empresa ');
    Sql.Add('and centro_il = :centro  ');
    Sql.Add('and producto_il = :producto ');
    Sql.Add('and fecha_il = :fecha ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fecha').AsDateTime:= ( dFechaIni - 1 );
    Open;
    if not IsEmpty then
    begin
       rKilosIniPrimera:= rKilosIniPrimera +  FieldByName('confeccionado_pri').AsFloat;
       rKilosIniSegunda:= rKilosIniSegunda +  FieldByName('confeccionado_seg').AsFloat;
    end;
    Close;

    ParamByName('fecha').AsDateTime:= ( dFechaFin );
    Open;
    if not IsEmpty then
    begin
      rKilosFinPrimera:= rKilosFinPrimera +  FieldByName('confeccionado_pri').AsFloat;
      rKilosFinSegunda:= rKilosFinSegunda +  FieldByName('confeccionado_seg').AsFloat;
    end;
    Close;
  end;

  rKilosIni:= rKilosIniPrimera + rKilosIniSegunda + rKilosIniTercera + rKilosIniDestrio;
  rKilosFin:= rKilosFinPrimera + rKilosFinSegunda + rKilosFinTercera + rKilosFinDestrio;
end;

procedure TDMLiquidaPeriodoInventarios.GrabarKilosInventario;
begin
  with DMLiquidaPeriodo do
  begin
    kmtInventarios.Insert;
    kmtInventarios.FieldByName('keySem').AsString:= sSemanaKey;

    kmtInventarios.FieldByName('kilos_ini').AsFloat:= rKilosIni;
    kmtInventarios.FieldByName('kilos_fin').AsFloat:= rKilosFin;

    kmtInventarios.FieldByName('kilos_ini_pri').AsFloat:= rKilosIniPrimera;
    kmtInventarios.FieldByName('kilos_fin_pri').AsFloat:= rKilosFinPrimera;
    kmtInventarios.FieldByName('kilos_ini_seg').AsFloat:= rKilosIniSegunda;
    kmtInventarios.FieldByName('kilos_fin_seg').AsFloat:= rKilosFinSegunda;
    kmtInventarios.FieldByName('kilos_ini_ter').AsFloat:= rKilosIniTercera;
    kmtInventarios.FieldByName('kilos_fin_ter').AsFloat:= rKilosFinTercera;
    kmtInventarios.FieldByName('kilos_ini_des').AsFloat:= rKilosIniDestrio;
    kmtInventarios.FieldByName('kilos_fin_des').AsFloat:= rKilosFinDestrio;

    kmtInventarios.FieldByName('neto_ini_pri').AsFloat:= rNetoIniPrimera;
    kmtInventarios.FieldByName('neto_fin_pri').AsFloat:= rNetoFinPrimera;
    kmtInventarios.FieldByName('neto_ini_seg').AsFloat:= rNetoIniSegunda;
    kmtInventarios.FieldByName('neto_fin_seg').AsFloat:= rNetoFinSegunda;
    kmtInventarios.FieldByName('neto_ini_ter').AsFloat:= rNetoIniTercera;
    kmtInventarios.FieldByName('neto_fin_ter').AsFloat:= rNetoFinTercera;
    kmtInventarios.FieldByName('neto_ini_des').AsFloat:= rNetoIniDestrio;
    kmtInventarios.FieldByName('neto_fin_des').AsFloat:= rNetoFinDestrio;
    kmtInventarios.FieldByName('neto_ini').AsFloat:= rNetoIniPrimera + rNetoIniSegunda +  rNetoIniTercera +  rNetoIniDestrio;
    kmtInventarios.FieldByName('neto_fin').AsFloat:= rNetoFinPrimera + rNetoFinSegunda +  rNetoFinTercera +  rNetofinDestrio;

    kmtInventarios.FieldByName('ajuste').AsFloat:= kmtInventarios.FieldByName('neto_fin').AsFloat - kmtInventarios.FieldByName('neto_ini').AsFloat;
    kmtInventarios.FieldByName('ajuste_pri').AsFloat:= rNetoFinPrimera - rNetoIniPrimera;
    kmtInventarios.FieldByName('ajuste_seg').AsFloat:= rNetoFinSegunda - rNetoIniSegunda;
    kmtInventarios.FieldByName('ajuste_ter').AsFloat:= rNetoFinTercera - rNetoIniTercera;
    kmtInventarios.FieldByName('ajuste_des').AsFloat:= rNetoFinDestrio - rNetoIniDestrio;

    kmtInventarios.Post;
  end;
end;

procedure TDMLiquidaPeriodoInventarios.ValorarInventario;
begin
  ValorarInventarioIni;
  ValorarInventarioFin;
  AjusteInventario;
end;

procedure TDMLiquidaPeriodoInventarios.ValorarInventarioIni;
begin
  //localizar grabado semana anterior (fin de la semana anterior)
  qryAux.SQL.Clear;
  qryAux.SQL.Add('select neto_fin, neto_fin_pri, neto_fin_seg, neto_fin_ter, neto_fin_des from liq_inventarios where keysem = :keysem ');
  qryAux.ParamByName('keysem').AsString:= sPriorKey;
  qryAux.Open;
  if not qryAux.IsEmpty then
  begin
    rNetoIniPrimera:= qryAux.FieldByname('neto_fin_pri').Asfloat;
    rNetoIniSegunda:= qryAux.FieldByname('neto_fin_seg').Asfloat;
    rNetoIniTercera:= qryAux.FieldByname('neto_fin_ter').Asfloat;
    rNetoIniDestrio:= qryAux.FieldByname('neto_fin_des').Asfloat;
    rNetoIni:= qryAux.FieldByname('neto_fin').Asfloat;
    qryAux.Close;
  end
  else
  begin
    qryAux.Close;
    //Si no existe valorar a precio de esta semana
    rNetoIniPrimera:= bRoundTo( rKilosIniPrimera * DMLiquidaPeriodo.kmtVentas.FieldByname('precio_pri').Asfloat, 2);
    rNetoIniSegunda:= bRoundTo( rKilosIniSegunda * DMLiquidaPeriodo.kmtVentas.FieldByname('precio_seg').Asfloat, 2);
    rNetoIniTercera:= bRoundTo( rKilosIniTercera * DMLiquidaPeriodo.kmtVentas.FieldByname('precio_ter').Asfloat, 2);
    rNetoIniDestrio:= bRoundTo( rKilosIniDestrio * DMLiquidaPeriodo.kmtVentas.FieldByname('precio_des').Asfloat, 2);
    rNetoIni:= rNetoIniPrimera + rNetoIniSegunda + rNetoIniTercera + rNetoIniDestrio;
  end;
end;

procedure TDMLiquidaPeriodoInventarios.ValorarInventarioFin;
begin
  //Con los valores de venta de esta semana
  rNetoFinPrimera:= bRoundTo( rKilosFinPrimera * DMLiquidaPeriodo.kmtVentas.FieldByname('precio_pri').Asfloat, 2);
  rNetoFinSegunda:= bRoundTo( rKilosFinSegunda * DMLiquidaPeriodo.kmtVentas.FieldByname('precio_seg').Asfloat, 2);
  rNetoFinTercera:= bRoundTo( rKilosFinTercera * DMLiquidaPeriodo.kmtVentas.FieldByname('precio_ter').Asfloat, 2);
  rNetoFinDestrio:= bRoundTo( rKilosFinDestrio * DMLiquidaPeriodo.kmtVentas.FieldByname('precio_des').Asfloat, 2);
  rNetoFin:= rNetoFinPrimera + rNetoFinSegunda + rNetoFinTercera + rNetoFinDestrio;
end;

procedure TDMLiquidaPeriodoInventarios.AjusteInventario;
begin
  //Con los valores de venta de esta semana
  rAjuste:= rNetoFin - rNetoIni;
  rAjustePrimera:= rNetoFinPrimera - rNetoIniPrimera;
  rAjusteSegunda:= rNetoFinSegunda - rNetoIniSegunda;
  rAjusteTercera:= rNetoFinTercera - rNetoIniTercera;
  rAjusteDestrio:= rNetoFinDestrio - rNetoIniDestrio;
end;

end.
