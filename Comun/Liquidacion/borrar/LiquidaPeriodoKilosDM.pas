unit LiquidaPeriodoKilosDM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMLiquidaPeriodoKilos = class(TDataModule)
    qryEntradasCos: TQuery;
    qryAux: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    kilos_pri, kilos_seg, kilos_ter, kilos_des, kilos_mer: Real;

    //TOTAL
    tkilos_ini, tkilos_fin, tkilos_ent, tkilos_sal, tkilos_mer, rPorcenMerma: Real;
    tkilos_pri_sal, tkilos_seg_sal, tkilos_ter_sal, tkilos_des_sal: Real;
    tkilos_pri_stran, tkilos_seg_stran, tkilos_ter_stran, tkilos_des_stran: Real;
    kilos_ent_alm, kilos_ent_dir, kilos_ent_ind, kilos_ent_com: Real;
    tkilos_pri_etran, tkilos_seg_etran, tkilos_ter_etran, tkilos_des_etran: Real;
    tkilos_ent_campo, tkilos_ent_transito, tkilos_sal_venta, tkilos_sal_transito:real;

    //TOTALES SEMANA
    sSemanaKey: string;
    tkilos_pri_ent, tkilos_seg_ent, tkilos_ter_ent, tkilos_des_ent, tkilos_mer_ent: Real;

    //COSECHERO
    sCosechero, sCosecheroAux: string;
    ckilos_pri_ent, ckilos_seg_ent, ckilos_ter_ent, ckilos_des_ent, ckilos_mer_ent: Real;

    //PLANTACION
    sPlantacion, sAnyoSemana, sPlantacionAux: string;
    pkilos_pri_ent, pkilos_seg_ent, pkilos_ter_ent, pkilos_des_ent, pkilos_mer_ent: Real;


    //Parametros de entrada
    sEmpresa, sCentro, sProducto, sSemana: string;
    dFechaIni, dFechaFin: TDateTime;


    procedure InsertarEntradas;
    procedure KilosLinea;
    procedure LimpiaKilosEntTotales;
    procedure IncKilosEntTotales;
    procedure LimpiaKilosEntCosechero;
    procedure IncKilosEntCosechero;
    procedure LimpiaKilosEntPlantacion;
    procedure IncKilosEntPlantacion;


    procedure InicializarVariables;
    procedure PutKilosSalidas( var VKilos1, VKilos2, VKilos3, VKilosD: real );
    procedure PutKilosTransitosSal( var VKilos1, VKilos2, VKilos3, VKilosD: real );
    procedure PutKilosTransitosEnt( var VKilos1, VKilos2, VKilos3, VKilosD: real );
    procedure PutKilosEntradas( var VKilosAlmacen, VKilosDirectos, VKilosIndustria, VKilosCompra: real );
    procedure GrabarKilosEntCosechero;
    procedure GrabarKilosEntPlantacion;
    procedure GrabarKilosEntrada;

    function GetCosecheroAux: string;
    function PutCosecheroAux: string;
    function GetPlantacionAux: string;
    function PutPlantacionAux: string;

  public
    { Public declarations }
     procedure KilosSemana(const AKey, AEmpresa, ACentro, AProducto, ASemana: string;
                             const ADesde, AHasta: TDateTime);
  end;

var
  DMLiquidaPeriodoKilos: TDMLiquidaPeriodoKilos;

implementation

{$R *.dfm}

uses
  bMath, bTimeUtils, LiquidaPeriodoDM, LiquidaPeriodoInventariosDM;

procedure TDMLiquidaPeriodoKilos.DataModuleDestroy(Sender: TObject);
begin
  //
end;

procedure TDMLiquidaPeriodoKilos.DataModuleCreate(Sender: TObject);
begin
  with qryEntradasCos do
  begin
    SQL.Clear;
    SQL.Add('select empresa_ec, centro_Ec, numero_entrada_ec, fecha_ec, peso_neto_ec, ');
    SQL.Add('       producto_e2l, cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l, total_kgs_e2l, ');
    SQL.Add('       nvl(tipo_entrada_e,0) tipo_entrada_e, porcen_primera_e, porcen_segunda_e, porcen_tercera_e, porcen_destrio_e, ');
    SQL.Add('       aporcen_primera_e, aporcen_segunda_e, aporcen_tercera_e, aporcen_destrio_e, aporcen_merma_e ');
    SQL.Add('from frf_entradas_c ');
    SQL.Add('     join frf_entradas2_l on empresa_ec = empresa_e2l and centro_Ec = centro_E2l ');
    SQL.Add('                          and numero_entrada_ec = numero_entrada_e2l and fecha_ec = fecha_e2l ');
    SQL.Add('     left join frf_escandallo on empresa_ec = empresa_e and centro_Ec = centro_E ');
    SQL.Add('                          and numero_entrada_ec = numero_entrada_e and fecha_ec = fecha_e ');
    SQL.Add('                          and producto_e2l = producto_e and cosechero_e2l = cosechero_e ');
    SQL.Add('                          and plantacion_e2l = plantacion_e and ano_sem_planta_e2l = anyo_semana_e ');
    SQL.Add('where empresa_Ec = :empresa ');
    SQL.Add('and centro_ec = :centro ');
    SQL.Add('and fecha_ec between :fechaini and :fechafin ');
    SQL.Add('and producto_e2l = :producto ');
    SQL.Add('order by  empresa_ec, producto_e2l, cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l, centro_Ec, fecha_ec, numero_entrada_ec  ');
  end;
end;

procedure TDMLiquidaPeriodoKilos.KilosSemana(const AKey, AEmpresa, ACentro, AProducto, ASemana: string;
                             const ADesde, AHasta: TDateTime);
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  sProducto:= AProducto;
  dFechaIni:= ADesde;
  dFechaFin:= AHasta;
  sSemana:= ASemana;
  sSemanaKey:= AKey;
  with qryEntradasCos do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('fechaini').AsDateTime:= dFechaIni;
    ParamByName('fechafin').AsDateTime:= dFechaFin;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;

    Open;
    if not IsEmpty then
    begin
      try
        InsertarEntradas;
      finally
        Close;
      end ;
    end
    else
    begin
      DMLiquidaPeriodo.AddWarning('Sin entradas');
    end;
  end;
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

procedure TDMLiquidaPeriodoKilos.PutKilosSalidas( var VKilos1, VKilos2, VKilos3, VKilosD: real );
begin
  VKilos1:= 0;
  VKilos2:= 0;
  VKilos3:= 0;
  VKilosD:= 0;

  with qryAux  do
  begin
    Sql.Clear;
    Sql.Add('select empresa_sl empresa, centro_salida_sl centro_sal, producto_sl producto, categoria_sl categoria, sum(kilos_sl) kilos ');
    Sql.Add('from frf_salidas_l ');
    Sql.Add('where empresa_sl = :empresa ');
    Sql.Add('and centro_salida_sl = :centro ');
    Sql.Add('and producto_sl =  :producto');
    Sql.Add('and fecha_sl between :fechaini and :fechafin ');
    Sql.Add('group by empresa, centro_sal, producto, categoria ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fechaini').AsDateTime:= dFechaIni;
    ParamByName('fechafin').AsDateTime:= dFechaFin;
    Open;
    if IsEmpty then
      DMLiquidaPeriodo.AddWarning( 'No hay ventas' )
    else
    while not Eof do
    begin
      if EsCategoriaPrimera( FieldByName('empresa').AsString, FieldByName('producto').AsString, FieldByName('categoria').AsString ) then
        VKilos1:= VKilos1 +  FieldByName('kilos').AsFloat
      else
      if EsCategoriaSegunda( FieldByName('empresa').AsString, FieldByName('producto').AsString, FieldByName('categoria').AsString ) then
        VKilos2:= VKilos2 +  FieldByName('kilos').AsFloat
      else
      if EsCategoriaSegunda( FieldByName('empresa').AsString, FieldByName('producto').AsString, FieldByName('categoria').AsString ) then
        VKilos3:= VKilos3 +  FieldByName('kilos').AsFloat
      else
        VKilosD:= VKilosD +  FieldByName('kilos').AsFloat;
      Next;
    end;
    Close;
  end;
end;

procedure TDMLiquidaPeriodoKilos.PutKilosTransitosSal( var VKilos1, VKilos2, VKilos3, VKilosD: real );
begin
  VKilos1:= 0;
  VKilos2:= 0;
  VKilos3:= 0;
  VKilosD:= 0;

  with qryAux  do
  begin
    Sql.Clear;
    Sql.Add('select empresa_tl empresa, centro_tl centro_sal, producto_tl producto, categoria_tl categoria, sum(kilos_tl) kilos ');
    Sql.Add('from frf_transitos_l ');
    Sql.Add('where empresa_tl = :empresa ');
    Sql.Add('and centro_tl = :centro ');
    Sql.Add('and producto_tl = :producto ');
    Sql.Add('and fecha_tl between :fechaini and :fechafin ');
    Sql.Add('group by empresa, centro_sal, producto, categoria ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fechaini').AsDateTime:= dFechaIni;
    ParamByName('fechafin').AsDateTime:= dFechaFin;
    Open;
    while not Eof do
    begin
      if EsCategoriaPrimera( FieldByName('empresa').AsString, FieldByName('producto').AsString, FieldByName('categoria').AsString ) then
        VKilos1:= VKilos1 +  FieldByName('kilos').AsFloat
      else
      if EsCategoriaSegunda( FieldByName('empresa').AsString, FieldByName('producto').AsString, FieldByName('categoria').AsString ) then
        VKilos2:= VKilos2 +  FieldByName('kilos').AsFloat
      else
      if EsCategoriaSegunda( FieldByName('empresa').AsString, FieldByName('producto').AsString, FieldByName('categoria').AsString ) then
        VKilos3:= VKilos3 +  FieldByName('kilos').AsFloat
      else
        VKilosD:= VKilosD +  FieldByName('kilos').AsFloat;
      Next;
    end;
    Close;
  end;
end;

procedure TDMLiquidaPeriodoKilos.PutKilosTransitosEnt( var VKilos1, VKilos2, VKilos3, VKilosD: real );
begin
  VKilos1:= 0;
  VKilos2:= 0;
  VKilos3:= 0;
  VKilosD:= 0;

  with qryAux  do
  begin
    Sql.Clear;
    Sql.Add('select empresa_tl empresa, centro_tl centro_sal, producto_tl producto, categoria_tl categoria, sum(kilos_tl) kilos ');
    Sql.Add('from frf_transitos_c ');
    Sql.Add('     join frf_transitos_l on empresa_tc = empresa_tl and centro_tc = centro_tl ');
    Sql.Add('                          and referencia_tc = referencia_tl and fecha_tc = fecha_tl ');
    Sql.Add('where empresa_tl = :empresa ');
    Sql.Add(' and centro_destino_tl = :centro ');
    Sql.Add(' and producto_tl = :producto ');
    Sql.Add(' and nvl(fecha_entrada_tc,fecha_tl) between :fechaini and :fechafin ');
    Sql.Add('group by empresa, centro_sal, producto, categoria ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fechaini').AsDateTime:= dFechaIni;
    ParamByName('fechafin').AsDateTime:= dFechaFin;
    Open;
    while not Eof do
    begin
      if EsCategoriaPrimera( FieldByName('empresa').AsString, FieldByName('producto').AsString, FieldByName('categoria').AsString ) then
        VKilos1:= VKilos1 +  FieldByName('kilos').AsFloat
      else
      if EsCategoriaSegunda( FieldByName('empresa').AsString, FieldByName('producto').AsString, FieldByName('categoria').AsString ) then
        VKilos2:= VKilos2 +  FieldByName('kilos').AsFloat
      else
      if EsCategoriaSegunda( FieldByName('empresa').AsString, FieldByName('producto').AsString, FieldByName('categoria').AsString ) then
        VKilos3:= VKilos3 +  FieldByName('kilos').AsFloat
      else
        VKilosD:= VKilosD +  FieldByName('kilos').AsFloat;
      Next;
    end;
    Close;
  end;
end;


procedure TDMLiquidaPeriodoKilos.PutKilosEntradas( var VKilosAlmacen, VKilosDirectos, VKilosIndustria, VKilosCompra: real );
begin
  VKilosAlmacen:= 0;
  VKilosDirectos:= 0;
  VKilosIndustria:= 0;
  VKilosCompra:= 0;

  with qryAux  do
  begin
    Sql.Clear;
    Sql.Add('select nvl(tipo_entrada_e,0) tipo,  sum( total_kgs_e2l ) kilos ');
    Sql.Add('from frf_entradas2_l ');
    Sql.Add('     left join frf_escandallo on empresa_e2l = empresa_e and centro_e2l = centro_E ');
    Sql.Add('                          and numero_entrada_e2l = numero_entrada_e and fecha_e2l = fecha_e ');
    Sql.Add('                          and producto_e2l = producto_e and cosechero_e2l = cosechero_e ');
    Sql.Add('                          and plantacion_e2l = plantacion_e and ano_sem_planta_e2l = anyo_semana_e ');
    Sql.Add('where empresa_e2l = :empresa ');
    Sql.Add('and centro_e2l = :centro ');
    Sql.Add('and producto_e2l = :producto ');
    Sql.Add('and fecha_e2l between :fechaini and :fechafin ');
    Sql.Add('group by tipo_entrada_e ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fechaini').AsDateTime:= dFechaIni;
    ParamByName('fechafin').AsDateTime:= dFechaFin;
    Open;
    while not Eof do
    begin
      if FieldByName('tipo').AsString = '1' then
        VKilosDirectos:= VKilosDirectos +  FieldByName('kilos').AsFloat
      else
      if FieldByName('tipo').AsString = '2' then
        VKilosIndustria:= VKilosIndustria +  FieldByName('kilos').AsFloat
      else
      if FieldByName('tipo').AsString = '3' then
        VKilosCompra:= VKilosCompra +  FieldByName('kilos').AsFloat
      else
        VKilosAlmacen:= VKilosAlmacen +  FieldByName('kilos').AsFloat;
      Next;
    end;
    Close;
  end;
end;

procedure TDMLiquidaPeriodoKilos.InicializarVariables;
begin
  //Primero las salidas, necesitamos distribucion de categorias para el stock de campo
  PutKilosSalidas( tkilos_pri_sal, tkilos_seg_sal, tkilos_ter_sal, tkilos_des_sal );

  //Utilizamos la distribucion salidas para el stock de campo (que no esta categorizado)
  DMLiquidaPeriodoInventarios.InventariosSemana( sSemanaKey, sEmpresa, sCentro, sProducto, sSemana, dFechaIni, dFechaFin, tkilos_ini, tkilos_fin );


  PutKilosTransitosSal( tkilos_pri_stran, tkilos_seg_stran, tkilos_ter_stran, tkilos_des_stran );
  PutKilosEntradas( kilos_ent_alm, kilos_ent_dir, kilos_ent_ind, kilos_ent_com );
  PutKilosTransitosEnt( tkilos_pri_etran, tkilos_seg_etran, tkilos_ter_etran, tkilos_des_etran );

  tkilos_ent_campo:= kilos_ent_alm + kilos_ent_dir + kilos_ent_ind + kilos_ent_com;
  tkilos_ent_transito:= tkilos_pri_etran + tkilos_seg_etran + tkilos_ter_etran + tkilos_des_etran;
  tkilos_sal_venta:= tkilos_pri_sal + tkilos_seg_sal + tkilos_ter_sal + tkilos_des_sal;
  tkilos_sal_transito:=  tkilos_pri_stran + tkilos_seg_stran + tkilos_ter_stran + tkilos_des_stran;
  tkilos_ent:= tkilos_ent_campo + tkilos_ent_transito;
  tkilos_sal:= tkilos_sal_venta + tkilos_sal_transito;
  tkilos_mer:= ( tkilos_ini + tkilos_ent ) - ( tkilos_fin + tkilos_sal );

  if tkilos_mer < 0 then
  begin
    DMLiquidaPeriodo.AddError( 'Merma Negativa, hay mas salidas que entradas de fruta.');
    tkilos_mer:= 0;
    rPorcenMerma:= 0;
  end
  else
  if tkilos_mer > 0 then
  begin
    if kilos_ent_alm < tkilos_mer then
    begin
      DMLiquidaPeriodo.AddError( 'Hay mas merma que entradas en el almacen.');
      tkilos_mer:= kilos_ent_alm;
      rPorcenMerma:= 100;
    end
    else
    begin
      //Porcentaje merma sobre kilos almacen/compra
      rPorcenMerma:= tkilos_mer / kilos_ent_alm;
    end;
  end
  else
  begin
    rPorcenMerma:= 0;
  end;

  LimpiaKilosEntTotales;

  sCosecheroAux:= '';
  sCosechero:= '';
  LimpiaKilosEntCosechero;

  sPlantacionAux:= '';
  sPlantacion:= '';
  sAnyoSemana:= '';
  LimpiaKilosEntPlantacion;
end;


procedure TDMLiquidaPeriodoKilos.KilosLinea;
var
  rKilosAux: real;
begin
  if ( qryEntradasCos.FieldByName('tipo_entrada_e').AsString = '0' ) then
  begin
    kilos_mer:= bRoundTo( ( rPorcenMerma * qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat ) , 2);
    rKilosAux:= qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat - kilos_mer;
  end
  else
  begin
    rKilosAux:= qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat
  end;


  kilos_pri:= bRoundTo( rKilosAux * ( qryEntradasCos.FieldByName('porcen_primera_e').AsFloat / 100 ), 2);
  kilos_seg:= bRoundTo( rKilosAux * ( qryEntradasCos.FieldByName('porcen_segunda_e').AsFloat / 100 ), 2);
  kilos_ter:= bRoundTo( rKilosAux * ( qryEntradasCos.FieldByName('porcen_tercera_e').AsFloat / 100 ), 2);
  kilos_des:= bRoundTo( rKilosAux * ( qryEntradasCos.FieldByName('porcen_destrio_e').AsFloat / 100 ), 2);
end;

procedure TDMLiquidaPeriodoKilos.LimpiaKilosEntTotales;
begin
  tkilos_pri_ent:= 0;
  tkilos_seg_ent:= 0;
  tkilos_ter_ent:= 0;
  tkilos_des_ent:= 0;
  tkilos_mer_ent:= 0;
end;

procedure TDMLiquidaPeriodoKilos.IncKilosEntTotales;
begin
  tkilos_pri_ent:= tkilos_pri_ent +  kilos_pri;
  tkilos_seg_ent:= tkilos_seg_ent +  kilos_seg;
  tkilos_ter_ent:= tkilos_ter_ent +  kilos_ter;
  tkilos_des_ent:= tkilos_des_ent +  kilos_des;
  tkilos_mer_ent:= tkilos_mer_ent +  kilos_mer;
end;

procedure TDMLiquidaPeriodoKilos.LimpiaKilosEntCosechero;
begin
  ckilos_pri_ent:= 0;
  ckilos_seg_ent:= 0;
  ckilos_ter_ent:= 0;
  ckilos_des_ent:= 0;
  ckilos_mer_ent:= 0;
end;

procedure TDMLiquidaPeriodoKilos.IncKilosEntCosechero;
begin
  ckilos_pri_ent:= ckilos_pri_ent +  kilos_pri;
  ckilos_seg_ent:= ckilos_seg_ent +  kilos_seg;
  ckilos_ter_ent:= ckilos_ter_ent +  kilos_ter;
  ckilos_des_ent:= ckilos_des_ent +  kilos_des;
  ckilos_mer_ent:= ckilos_mer_ent +  kilos_mer;
end;

procedure TDMLiquidaPeriodoKilos.LimpiaKilosEntPlantacion;
begin
  pkilos_pri_ent:= 0;
  pkilos_seg_ent:= 0;
  pkilos_ter_ent:= 0;
  pkilos_des_ent:= 0;
  pkilos_mer_ent:= 0;
end;

procedure TDMLiquidaPeriodoKilos.IncKilosEntPlantacion;
begin
  pkilos_pri_ent:= pkilos_pri_ent +  kilos_pri;
  pkilos_seg_ent:= pkilos_seg_ent +  kilos_seg;
  pkilos_ter_ent:= pkilos_ter_ent +  kilos_ter;
  pkilos_des_ent:= pkilos_des_ent +  kilos_des;
  pkilos_mer_ent:= pkilos_mer_ent +  kilos_mer;
end;

function TDMLiquidaPeriodoKilos.GetCosecheroAux: string;
begin
  Result:= sSemanaKey + qryEntradasCos.FieldByName('cosechero_e2l').AsString
end;

function TDMLiquidaPeriodoKilos.PutCosecheroAux: string;
begin
  Result:= GetCosecheroAux;
  sCosechero:= qryEntradasCos.FieldByName('cosechero_e2l').AsString;
end;

function TDMLiquidaPeriodoKilos.GetPlantacionAux: string;
begin
  Result:= GetCosecheroAux + qryEntradasCos.FieldByName('plantacion_e2l').AsString + qryEntradasCos.FieldByName('ano_sem_planta_e2l').AsString;
end;

function TDMLiquidaPeriodoKilos.PutPlantacionAux: string;
begin
  Result:= GetPlantacionAux;
  sPlantacion:= qryEntradasCos.FieldByName('plantacion_e2l').AsString;
  sAnyoSemana:=  qryEntradasCos.FieldByName('ano_sem_planta_e2l').AsString;
end;

procedure TDMLiquidaPeriodoKilos.InsertarEntradas;
begin
   InicializarVariables;

   //Primer registro
   if not qryEntradasCos.IsEmpty then
   begin
     KilosLinea;

     sCosecheroAux:= PutCosecheroAux;
     IncKilosEntCosechero;

     sPlantacionAux:= PutPlantacionAux;
     IncKilosEntPlantacion;

     IncKilosEntTotales;

     qryEntradasCos.Next;
   end;

   //Resto registros
   while not qryEntradasCos.Eof do
   begin
     KilosLinea;

     if GetPlantacionAux = sPlantacionAux then
     begin
       IncKilosEntPlantacion;
     end
     else
     begin
       GrabarKilosEntPlantacion;
       sPlantacionAux:= PutPlantacionAux;
       IncKilosEntPlantacion;
     end;


     if GetCosecheroAux = sCosecheroAux then
     begin
       IncKilosEntCosechero;
     end
     else
     begin
       GrabarKilosEntCosechero;
       sCosecheroAux:= PutCosecheroAux;
       IncKilosEntCosechero;
     end;

     IncKilosEntTotales;

     qryEntradasCos.Next;
   end;

   //Grabar ultima linea
   if not qryEntradasCos.IsEmpty then
   begin
     GrabarKilosEntPlantacion;
     GrabarKilosEntCosechero;
     GrabarKilosEntrada;
   end;
end;

procedure TDMLiquidaPeriodoKilos.GrabarKilosEntPlantacion;
begin
  with DMLiquidaPeriodo do
  begin
    kmtPlantacion.Insert;
    kmtPlantacion.FieldByName('keySem').AsString:= sSemanaKey;
    kmtPlantacion.FieldByName('empresa').AsString:= sEmpresa;
    kmtPlantacion.FieldByName('centro').AsString:= sCentro;
    kmtPlantacion.FieldByName('producto').AsString:= sProducto;
    kmtPlantacion.FieldByName('semana').AsString:= sSemana;
    kmtPlantacion.FieldByName('cosechero').AsString:= sCosechero;
    kmtPlantacion.FieldByName('plantacion').AsString:= sPlantacion;
    kmtPlantacion.FieldByName('semana_planta').AsString:= sAnyoSemana;

    kmtPlantacion.FieldByName('kilos_pri').AsFloat:= pkilos_pri_ent;
    kmtPlantacion.FieldByName('kilos_seg').AsFloat:= pkilos_seg_ent;
    kmtPlantacion.FieldByName('kilos_ter').AsFloat:= pkilos_ter_ent;
    kmtPlantacion.FieldByName('kilos_des').AsFloat:= pkilos_des_ent;
    kmtPlantacion.FieldByName('kilos_mer').AsFloat:= pkilos_mer_ent;
    kmtPlantacion.Post;
  end;

  pkilos_pri_ent:= 0;
  pkilos_seg_ent:= 0;
  pkilos_ter_ent:= 0;
  pkilos_des_ent:= 0;
  pkilos_mer_ent:= 0;
end;

procedure TDMLiquidaPeriodoKilos.GrabarKilosEntCosechero;
begin
  with DMLiquidaPeriodo do
  begin
    kmtCosechero.Insert;
    kmtCosechero.FieldByName('keySem').AsString:= sSemanaKey;
    kmtCosechero.FieldByName('empresa').AsString:= sEmpresa;
    kmtCosechero.FieldByName('centro').AsString:= sCentro;
    kmtCosechero.FieldByName('producto').AsString:= sProducto;
    kmtCosechero.FieldByName('semana').AsString:= sSemana;
    kmtCosechero.FieldByName('cosechero').AsString:= sCosechero;

    kmtCosechero.FieldByName('kilos_pri').AsFloat:= ckilos_pri_ent;
    kmtCosechero.FieldByName('kilos_seg').AsFloat:= ckilos_seg_ent;
    kmtCosechero.FieldByName('kilos_ter').AsFloat:= ckilos_ter_ent;
    kmtCosechero.FieldByName('kilos_des').AsFloat:= ckilos_des_ent;
    kmtCosechero.FieldByName('kilos_mer').AsFloat:= ckilos_mer_ent;
    kmtCosechero.Post;
  end;

  ckilos_pri_ent:= 0;
  ckilos_seg_ent:= 0;
  ckilos_ter_ent:= 0;
  ckilos_des_ent:= 0;
  ckilos_mer_ent:= 0;
end;

procedure TDMLiquidaPeriodoKilos.GrabarKilosEntrada;
begin
  with DMLiquidaPeriodo do
  begin
    kmtSemana.Insert;
    kmtSemana.FieldByName('keySem').AsString:= sSemanaKey;
    kmtSemana.FieldByName('empresa').AsString:= sEmpresa;
    kmtSemana.FieldByName('centro').AsString:= sCentro;
    kmtSemana.FieldByName('producto').AsString:= sProducto;
    kmtSemana.FieldByName('semana').AsString:= sSemana;
    kmtSemana.FieldByName('fecha_ini').AsDateTime:= dFechaIni;
    kmtSemana.FieldByName('fecha_fin').AsDateTime:= dFechaFin;


    kmtSemana.FieldByName('kilos_ent_campo').AsFloat:= tkilos_ent_campo;
    kmtSemana.FieldByName('kilos_pri').AsFloat:= tkilos_pri_ent;
    kmtSemana.FieldByName('kilos_seg').AsFloat:= tkilos_seg_ent;
    kmtSemana.FieldByName('kilos_ter').AsFloat:= tkilos_ter_ent;
    kmtSemana.FieldByName('kilos_des').AsFloat:= tkilos_des_ent;
    kmtSemana.FieldByName('kilos_mer').AsFloat:= tkilos_mer_ent;

    kmtSemana.FieldByName('kilos_ini').AsFloat:= tkilos_ini;
    kmtSemana.FieldByName('kilos_fin').AsFloat:= tkilos_fin;

    kmtSemana.FieldByName('kilos_ent_transito').AsFloat:= tkilos_ent_transito;
    kmtSemana.FieldByName('kilos_sal_transito').AsFloat:= tkilos_sal_transito;
    kmtSemana.FieldByName('kilos_sal_venta').AsFloat:= tkilos_sal_venta;

    kmtSemana.FieldByName('kilos_merma').AsFloat:= tkilos_mer;

    kmtSemana.Post;
  end;
end;

end.
