unit LiquidaPeriodoTransitosDM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMLiquidaPeriodoTransitos = class(TDataModule)
    qryCosteSeccion: TQuery;
    qryTransitos: TQuery;
    qryAux: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    sSemanaKey: string;
    sEmpresa, sCentro, sProducto, sSemana, sOrigen, sDestino: string;
    dFechaIni, dFechaFin: TDateTime;
    iProductoBase: Integer;

    rKilos1, rKilos2, rKilos3, rKilosD, rTotal: real;
    rImporte1, rImporte2, rImporte3, rImporteD, rImporte: real;
    rCoste1, rCoste2, rCoste3, rCosteD, rCoste: real;
    rGasto1, rGasto2, rGasto3, rGastoD, rGasto: real;
    rNeto1, rNeto2, rNeto3, rNetoD, rNeto: real;


    procedure PutKilosTransitosSal;
    procedure AltaTransitosSal;
    procedure PutKilosTransitosEnt;
    procedure AltaTransitosEnt;
    function  GetCosteEnvasado: real;

    procedure ValorarTransitosSalida;
    procedure ValorarTransitosEntrada;
    function  GetGastoTransito: Real;
  public
    { Public declarations }
     procedure TransitosSemana(const AKey, AEmpresa, ACentro, AProducto, ASemana: string;
                             const ADesde, AHasta: TDateTime; var VKilosIn, VKilosOut: Real );
     procedure ValorarTransitos;
  end;

var
  DMLiquidaPeriodoTransitos: TDMLiquidaPeriodoTransitos;

implementation

{$R *.dfm}

uses
  LiquidaPeriodoDM, CGlobal, UDMAuxDB, bMath;

procedure TDMLiquidaPeriodoTransitos.DataModuleDestroy(Sender: TObject);
begin
  //
end;

procedure TDMLiquidaPeriodoTransitos.DataModuleCreate(Sender: TObject);
begin
  with qryCosteSeccion do
  begin
    SQL.Clear;
    if CGlobal.gProgramVersion = CGlobal.pvBAG then
    begin
      SQL.Add('select first 1 anyo_ec, mes_ec, envase_ec, general_ec secciones_ec, general_ec psecciones_ec ');
    end
    else
    begin
      SQL.Add('select first 1 anyo_ec, mes_ec, envase_ec, secciones_ec, psecciones_ec ');
    end;
    SQL.Add('from frf_env_costes ');
    SQL.Add('where empresa_Ec = :empresa ');
    SQL.Add('and centro_ec = :centro ');
    SQL.Add('and envase_ec = :envase ');
    SQL.Add('and producto_base_ec = :producto ');
    SQL.Add('and ( ( anyo_ec = :anyo and mes_ec <= :mes ) or ( anyo_ec < :anyo) )');
    SQL.Add('order by anyo_ec desc, mes_ec desc ');
    Prepare;
  end;
end;

procedure TDMLiquidaPeriodoTransitos.TransitosSemana(const AKey, AEmpresa, ACentro, AProducto, ASemana: string;
                             const ADesde, AHasta: TDateTime; var VKilosIn, VKilosOut: Real);
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  sProducto:= AProducto;
  dFechaIni:= ADesde;
  dFechaFin:= AHasta;
  sSemana:= ASemana;
  sSemanaKey:= AKey;
  iProductoBase:= StrToInt( GetProductoBase( sEmpresa, sProducto ) );


  PutKilosTransitosSal;
  VKilosOut:= rTotal;
  PutKilosTransitosEnt;
  VKilosIn:= rTotal;
end;

function EsCategoriaPrimera( const AEmpresa, AProducto, ACategoria: string ): boolean;
begin
  (*TODO*)
  result:= ACategoria = '1';
end;

function EsCategoriaSegunda( const AEmpresa, AProducto, ACategoria: string ): boolean;
begin
  (*TODO*)
  result:= ACategoria = '2';
end;

function EsCategoriaTercera( const AEmpresa, AProducto, ACategoria: string ): boolean;
begin
  (*TODO*)
  result:= ACategoria = '3';
end;

function EsCategoriaDestrio( const AEmpresa, AProducto, ACategoria: string ): boolean;
begin
  RESULT:= not  EsCategoriaPrimera( AEmpresa, AProducto, ACategoria ) and
           not  EsCategoriaSegunda( AEmpresa, AProducto, ACategoria ) and
           not  EsCategoriaTercera( AEmpresa, AProducto, ACategoria );
end;

function TDMLiquidaPeriodoTransitos.GetCosteEnvasado: real;
begin
  qryCosteSeccion.ParamByName('empresa').AsString:= sEmpresa;
  qryCosteSeccion.ParamByName('centro').AsString:= sCentro;
  qryCosteSeccion.ParamByName('envase').AsString:=  qryTransitos.FieldByName('envase').AsString;
  qryCosteSeccion.ParamByName('producto').AsInteger:= iProductoBase;
  qryCosteSeccion.ParamByName('anyo').AsInteger:= qryTransitos.FieldByName('anyo').AsInteger;
  qryCosteSeccion.ParamByName('mes').AsInteger:= qryTransitos.FieldByName('mes').AsInteger;
  qryCosteSeccion.Open;
  Result:=  qryCosteSeccion.FieldByName('secciones_ec').AsFloat;
  qryCosteSeccion.Close;
end;

procedure TDMLiquidaPeriodoTransitos.PutKilosTransitosSal;
var
 raux: real;
begin
  rKilos1:= 0;
  rKilos2:= 0;
  rKilos3:= 0;
  rKilosD:= 0;
  rCoste1:= 0;
  rCoste2:= 0;
  rCoste3:= 0;
  rCosteD:= 0;

  with qryTransitos  do
  begin
    Sql.Clear;
    Sql.Add('select empresa_tl empresa, centro_tl centro_sal, centro_destino_tl destino, month(fecha_tl) mes, year(fecha_tl) anyo, ');
    Sql.Add('       producto_tl producto, categoria_tl categoria, envase_tl envase, sum(kilos_tl) kilos ');
    Sql.Add('from frf_transitos_l ');
    Sql.Add('where empresa_tl = :empresa ');
    Sql.Add('and centro_tl = :centro ');
    Sql.Add('and producto_tl = :producto ');
    Sql.Add('and fecha_tl between :fechaini and :fechafin ');
    Sql.Add('group by empresa, centro_sal, destino, mes, anyo, producto, categoria,  envase ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fechaini').AsDateTime:= dFechaIni;
    ParamByName('fechafin').AsDateTime:= dFechaFin;
    Open;
    while not Eof do
    begin
      sDestino:= FieldByName('destino').AsString;
      raux:= GetCosteEnvasado;
      if EsCategoriaPrimera( FieldByName('empresa').AsString, FieldByName('producto').AsString, FieldByName('categoria').AsString ) then
      begin
        rKilos1:= rKilos1 +  FieldByName('kilos').AsFloat;
        rCoste1:= rCoste1 + ( FieldByName('kilos').AsFloat * raux );
      end
      else
      if EsCategoriaSegunda( FieldByName('empresa').AsString, FieldByName('producto').AsString, FieldByName('categoria').AsString ) then
      begin
        rKilos2:= rKilos2 +  FieldByName('kilos').AsFloat;
        rCoste2:= rCoste2 + ( FieldByName('kilos').AsFloat * raux );
      end
      else
      if EsCategoriaSegunda( FieldByName('empresa').AsString, FieldByName('producto').AsString, FieldByName('categoria').AsString ) then
      begin
        rKilos3:= rKilos3 +  FieldByName('kilos').AsFloat;
        rCoste3:= rCoste3 + ( FieldByName('kilos').AsFloat * raux );
      end
      else
      begin
        rKilosD:= rKilosD +  FieldByName('kilos').AsFloat;
        rCosteD:= rCoste3 + ( FieldByName('kilos').AsFloat * raux );
      end;
      Next;
    end;
    Close;
  end;

  AltaTransitosSal;
end;

procedure TDMLiquidaPeriodoTransitos.AltaTransitosSal;
begin
  with DMLiquidaPeriodo do
  begin
    kmtTransitosOut.Insert;
    kmtTransitosOut.FieldByName('keySem').AsString:= sSemanaKey;
    kmtTransitosOut.FieldByName('destino').AsString:= sDestino;
    kmtTransitosOut.FieldByName('kilos_pri').AsFloat:= rKilos1;
    kmtTransitosOut.FieldByName('kilos_seg').AsFloat:= rKilos2;
    kmtTransitosOut.FieldByName('kilos_ter').AsFloat:= rKilos3;
    kmtTransitosOut.FieldByName('kilos_des').AsFloat:= rKilosD;
    rTotal:= rKilos1+rKilos2+rKilos3+rKilosD;
    kmtTransitosOut.FieldByName('kilos_total').AsFloat:= rTotal;

    kmtTransitosOut.FieldByName('coste_pri').AsFloat:= rCoste1;
    kmtTransitosOut.FieldByName('coste_seg').AsFloat:= rCoste2;
    kmtTransitosOut.FieldByName('coste_ter').AsFloat:= rCoste3;
    kmtTransitosOut.FieldByName('coste_des').AsFloat:= rCosteD;
    rCoste:= rCoste1+rCoste2+rCoste3+rCosteD;
    kmtTransitosOut.FieldByName('coste_total').AsFloat:= rCoste;

    kmtTransitosOut.Post;
  end;
end;


procedure TDMLiquidaPeriodoTransitos.PutKilosTransitosEnt;
begin
  rKilos1:= 0;
  rKilos2:= 0;
  rKilos3:= 0;
  rKilosD:= 0;

  with qryTransitos  do
  begin
    Sql.Clear;
    Sql.Add('select empresa_tl empresa, centro_tl centro_sal, month(fecha_tl) mes, year(fecha_tl) anyo, ');
    Sql.Add('       producto_tl producto, categoria_tl categoria, envase_tl envase, sum(kilos_tl) kilos ');
    Sql.Add('from frf_transitos_c ');
    Sql.Add('     join frf_transitos_l on empresa_tc = empresa_tl and centro_tc = centro_tl ');
    Sql.Add('                          and referencia_tc = referencia_tl and fecha_tc = fecha_tl ');
    Sql.Add('where empresa_tl = :empresa ');
    Sql.Add(' and centro_destino_tl = :centro ');
    Sql.Add(' and producto_tl = :producto ');
    Sql.Add(' and nvl(fecha_entrada_tc,fecha_tl) between :fechaini and :fechafin ');
    Sql.Add('group by empresa, centro_sal,  mes, anyo, producto, categoria,  envase ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fechaini').AsDateTime:= dFechaIni;
    ParamByName('fechafin').AsDateTime:= dFechaFin;
    Open;
    while not Eof do
    begin
      sOrigen:= FieldByName('centro_sal').AsString;
      if EsCategoriaPrimera( FieldByName('empresa').AsString, FieldByName('producto').AsString, FieldByName('categoria').AsString ) then
      begin
        rKilos1:= rKilos1 +  FieldByName('kilos').AsFloat;
        //rImporte1:= rImporte1 * ( FieldByName('kilos').AsFloat * GetCosteEnvasado );
      end
      else
      if EsCategoriaSegunda( FieldByName('empresa').AsString, FieldByName('producto').AsString, FieldByName('categoria').AsString ) then
      begin
        rKilos2:= rKilos2 +  FieldByName('kilos').AsFloat;
        //rImporte2:= rImporte2 * ( FieldByName('kilos').AsFloat * GetCosteEnvasado );
      end
      else
      if EsCategoriaSegunda( FieldByName('empresa').AsString, FieldByName('producto').AsString, FieldByName('categoria').AsString ) then
      begin
        rKilos3:= rKilos3 +  FieldByName('kilos').AsFloat;
        //rImporte3:= rImporte3 * ( FieldByName('kilos').AsFloat * GetCosteEnvasado );
      end
      else
      begin
        rKilosD:= rKilosD +  FieldByName('kilos').AsFloat;
        //rImporte3:= rImporte3 * ( FieldByName('kilos').AsFloat * GetCosteEnvasado );
      end;
      Next;
    end;
    Close;
  end;
  AltaTransitosEnt;
end;

procedure TDMLiquidaPeriodoTransitos.AltaTransitosEnt;
begin
  with DMLiquidaPeriodo do
  begin
    kmtTransitosIn.Insert;
    kmtTransitosIn.FieldByName('keySem').AsString:= sSemanaKey;
    kmtTransitosIn.FieldByName('origen').AsString:= sOrigen;
    kmtTransitosIn.FieldByName('kilos_pri').AsFloat:= rKilos1;
    kmtTransitosIn.FieldByName('kilos_seg').AsFloat:= rKilos2;
    kmtTransitosIn.FieldByName('kilos_ter').AsFloat:= rKilos3;
    kmtTransitosIn.FieldByName('kilos_des').AsFloat:= rKilosD;
    rTotal:= rKilos1+rKilos2+rKilos3+rKilosD;
    kmtTransitosIn.FieldByName('kilos_total').AsFloat:= rTotal;

    (*
    kmtTransitosIn.FieldByName('importe_primera').AsFloat:= rImporte1;
    kmtTransitosIn.FieldByName('importe_segunda').AsFloat:= rImporte2;
    kmtTransitosIn.FieldByName('importe_tercera').AsFloat:= rImporte3;
    kmtTransitosIn.FieldByName('importe_destrio').AsFloat:= rImporteD;
    rImporte:= rImporte1+rImporte2+rImporte3+rImporteD;
    kmtTransitosIn.FieldByName('importe_total').AsFloat:= rImporte;
    *)

    kmtTransitosIn.Post;
  end;
end;

procedure TDMLiquidaPeriodoTransitos.ValorarTransitos;
begin
  DMLiquidaPeriodo.kmtCentros.First;
  while not DMLiquidaPeriodo.kmtCentros.Eof do
  begin
    if DMLiquidaPeriodo.kmtSemana.Locate('keysem', DMLiquidaPeriodo.kmtCentros.FieldByName('keysem').AsString, [] ) then
    begin
      ValorarTransitosSalida;
      ValorarTransitosEntrada;
    end;
    DMLiquidaPeriodo.kmtCentros.Next;
  end;
end;

procedure TDMLiquidaPeriodoTransitos.ValorarTransitosSalida;
var
  sAux: string;
  rPrecioGastos:  Real;
begin
  with DMLiquidaPeriodo do
  begin
    sAux:= sEmpresa + kmtTransitosOut.FieldByName('destino').AsString + sProducto + sSemana;
    kmtTransitosOut.Edit;
    if kmtAux.Locate('keysem', sAux, [] ) then
    begin
      kmtTransitosOut.FieldByName('importe_pri').AsFloat:= kmtTransitosOut.FieldByName('kilos_pri').AsFloat * kmtAux.FieldByName('precio_pri').AsFloat;
      kmtTransitosOut.FieldByName('importe_seg').AsFloat:= kmtTransitosOut.FieldByName('kilos_seg').AsFloat * kmtAux.FieldByName('precio_seg').AsFloat;
      kmtTransitosOut.FieldByName('importe_ter').AsFloat:= kmtTransitosOut.FieldByName('kilos_ter').AsFloat * kmtAux.FieldByName('precio_ter').AsFloat;
      kmtTransitosOut.FieldByName('importe_des').AsFloat:= kmtTransitosOut.FieldByName('kilos_des').AsFloat * kmtAux.FieldByName('precio_des').AsFloat;
      kmtTransitosOut.FieldByName('importe_total').AsFloat:=
        kmtTransitosOut.FieldByName('importe_pri').AsFloat +
        kmtTransitosOut.FieldByName('importe_seg').AsFloat +
        kmtTransitosOut.FieldByName('importe_ter').AsFloat +
        kmtTransitosOut.FieldByName('importe_des').AsFloat ;
    end
    else
    begin
      kmtTransitosOut.FieldByName('importe_pri').AsFloat:= 0;
      kmtTransitosOut.FieldByName('importe_seg').AsFloat:= 0;
      kmtTransitosOut.FieldByName('importe_ter').AsFloat:= 0;
      kmtTransitosOut.FieldByName('importe_des').AsFloat:= 0;
      kmtTransitosOut.FieldByName('importe_total').AsFloat:= 0;
    end;

    rPrecioGastos:= GetGastoTransito;
    if  rPrecioGastos <> 0 then
    begin
      kmtTransitosOut.FieldByName('gastos_Pri').AsFloat:= bRoundto( kmtTransitosOut.FieldByName('kilos_pri').AsFloat * rPrecioGastos, 2);
      kmtTransitosOut.FieldByName('gastos_Seg').AsFloat:= bRoundto( kmtTransitosOut.FieldByName('kilos_seg').AsFloat * rPrecioGastos, 2);
      kmtTransitosOut.FieldByName('gastos_Ter').AsFloat:= bRoundto( kmtTransitosOut.FieldByName('kilos_ter').AsFloat * rPrecioGastos, 2);
      kmtTransitosOut.FieldByName('gastos_Des').AsFloat:= bRoundto( kmtTransitosOut.FieldByName('kilos_des').AsFloat * rPrecioGastos, 2);
      kmtTransitosOut.FieldByName('gastos_total').AsFloat:=
        kmtTransitosOut.FieldByName('importe_pri').AsFloat +
        kmtTransitosOut.FieldByName('importe_seg').AsFloat +
        kmtTransitosOut.FieldByName('importe_ter').AsFloat +
        kmtTransitosOut.FieldByName('importe_des').AsFloat ;
    end
    else
    begin
      kmtTransitosOut.FieldByName('gastos_Pri').AsFloat:= 0;
      kmtTransitosOut.FieldByName('gastos_Seg').AsFloat:= 0;
      kmtTransitosOut.FieldByName('gastos_Ter').AsFloat:= 0;
      kmtTransitosOut.FieldByName('gastos_Des').AsFloat:= 0;
      kmtTransitosOut.FieldByName('gastos_total').AsFloat:= 0;
    end;

    kmtTransitosOut.FieldByName('neto_total').AsFloat:=
        kmtTransitosOut.FieldByName('importe_total').AsFloat -
        kmtTransitosOut.FieldByName('coste_total').AsFloat -
        kmtTransitosOut.FieldByName('gastos_total').AsFloat ;
    kmtTransitosOut.FieldByName('neto_pri').AsFloat:=
        kmtTransitosOut.FieldByName('importe_pri').AsFloat -
        kmtTransitosOut.FieldByName('coste_Pri').AsFloat -
        kmtTransitosOut.FieldByName('gastos_Pri').AsFloat ;
    kmtTransitosOut.FieldByName('neto_seg').AsFloat:=
        kmtTransitosOut.FieldByName('importe_seg').AsFloat -
        kmtTransitosOut.FieldByName('coste_seg').AsFloat -
        kmtTransitosOut.FieldByName('gastos_seg').AsFloat ;
    kmtTransitosOut.FieldByName('neto_ter').AsFloat:=
        kmtTransitosOut.FieldByName('importe_ter').AsFloat -
        kmtTransitosOut.FieldByName('coste_ter').AsFloat -
        kmtTransitosOut.FieldByName('gastos_ter').AsFloat ;
    kmtTransitosOut.FieldByName('neto_des').AsFloat:=
        kmtTransitosOut.FieldByName('importe_des').AsFloat -
        kmtTransitosOut.FieldByName('coste_des').AsFloat -
        kmtTransitosOut.FieldByName('gastos_des').AsFloat ;

    kmtTransitosOut.Post;
  end;
end;

procedure TDMLiquidaPeriodoTransitos.ValorarTransitosEntrada;
var
  sAux: string;
begin
  with DMLiquidaPeriodo do
  begin
    //sAux:= sEmpresa + kmtTransitosIn.FieldByName('origen').AsString + sProducto + sSemana;
    sAux:= DMLiquidaPeriodo.kmtCentros.FieldByName('keysem').AsString;
    kmtTransitosIn.Edit;
    if kmtAux.Locate('keysem', sAux, [] ) then
    begin
      kmtTransitosIn.FieldByName('importe_pri').AsFloat:= kmtTransitosIn.FieldByName('kilos_pri').AsFloat * kmtAux.FieldByName('precio_pri').AsFloat;
      kmtTransitosIn.FieldByName('importe_seg').AsFloat:= kmtTransitosIn.FieldByName('kilos_seg').AsFloat * kmtAux.FieldByName('precio_seg').AsFloat;
      kmtTransitosIn.FieldByName('importe_ter').AsFloat:= kmtTransitosIn.FieldByName('kilos_ter').AsFloat * kmtAux.FieldByName('precio_ter').AsFloat;
      kmtTransitosIn.FieldByName('importe_des').AsFloat:= kmtTransitosIn.FieldByName('kilos_des').AsFloat * kmtAux.FieldByName('precio_des').AsFloat;
      kmtTransitosIn.FieldByName('importe_total').AsFloat:=
        kmtTransitosIn.FieldByName('importe_pri').AsFloat +
        kmtTransitosIn.FieldByName('importe_seg').AsFloat +
        kmtTransitosIn.FieldByName('importe_ter').AsFloat +
        kmtTransitosIn.FieldByName('importe_des').AsFloat ;
    end
    else
    begin
      kmtTransitosIn.FieldByName('importe_pri').AsFloat:= 0;
      kmtTransitosIn.FieldByName('importe_seg').AsFloat:= 0;
      kmtTransitosIn.FieldByName('importe_ter').AsFloat:= 0;
      kmtTransitosIn.FieldByName('importe_des').AsFloat:= 0;
      kmtTransitosIn.FieldByName('importe_total').AsFloat:= 0;
    end;
    kmtTransitosIn.Post;
  end;
end;


function TDMLiquidaPeriodoTransitos.GetGastoTransito: real;
var
  kilos_producto, kilos_total, importe_producto, importe_total: Real;
begin
  with qryAux do
  begin
    SQL.Clear;
    SQL.Add('select sum( case when producto_tl = :producto then kilos_tl else 0 end ) kilos_producto, sum( kilos_tl ) kilos_total   ');
    SQL.Add('from frf_transitos_l ');
    SQL.Add('where empresa_tl = :empresa ');
    SQL.Add('and centro_tl = :centro ');
    SQL.Add('and fecha_tl between :fechaini and :fechafin ');

    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fechaini').AsDateTime:= dFechaIni;
    ParamByName('fechafin').AsDateTime:= dFechaFin;

    Open;
    kilos_producto:= FieldByName('kilos_producto').AsFloat;
    kilos_total:= FieldByName('kilos_total').AsFloat;
    Close;
    SQL.Clear;
    SQL.Add('select sum( case when producto_gt= :producto then importe_gt else 0 end ) importe_producto, sum( importe_gt ) importe_total  ');
    SQL.Add('from frf_gastos_trans  ');
    SQL.Add('where empresa_gt = :empresa ');
    SQL.Add('and centro_gt = :centro  ');
    SQL.Add('and fecha_gt between :fechaini  and :fechafin  ');

    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fechaini').AsDateTime:= dFechaIni;
    ParamByName('fechafin').AsDateTime:= dFechaFin;

    Open;
    importe_producto:= FieldByName('importe_producto').AsFloat;
    importe_total:= FieldByName('importe_total').AsFloat;
    Close;

    if kilos_producto <> 0 then
    begin
      Result:= bRoundTo(  importe_producto /  kilos_producto, 5);
    end;
    if kilos_total <> 0 then
    begin
      Result:= Result + bRoundTo(  importe_total /  kilos_total, 5);
    end;
  end;

end;

end.
