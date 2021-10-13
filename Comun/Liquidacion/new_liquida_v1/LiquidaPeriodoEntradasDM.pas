unit LiquidaPeriodoEntradasDM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMLiquidaPeriodoEntradas = class(TDataModule)
    qryEntradasCos: TQuery;
    qryAux: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    kilos_pri, kilos_seg, kilos_ter, kilos_des, kilos_mer: Real;
    kilos_ini_pri, kilos_ini_seg, kilos_ini_ter, kilos_ini_des: Real;

    //TOTAL
    //tkilos_ini, tkilos_fin, tkilos_sal,
    //tkilos_pri_sal, tkilos_seg_sal, tkilos_ter_sal, tkilos_des_sal: Real;
    //tkilos_pri_stran, tkilos_seg_stran, tkilos_ter_stran, tkilos_des_stran: Real;
    //tkilos_pri_etran, tkilos_seg_etran, tkilos_ter_etran, tkilos_des_etran: Real;
    //tkilos_ent_transito, tkilos_sal_venta, tkilos_sal_transito:real;

    tkilos_ent, tkilos_mer, rPorcenMerma, tkilos_entrada : Real;
    kilos_ent_alm, kilos_ent_dir, kilos_ent_ind, kilos_ent_com: Real;

    //TOTALES SEMANA
    sSemanaKey: string;
    tkilos_pri_ent, tkilos_seg_ent, tkilos_ter_ent, tkilos_des_ent, tkilos_mer_ent: Real;
    tkilos_ini_pri_ent, tkilos_ini_seg_ent, tkilos_ini_ter_ent, tkilos_ini_des_ent: Real;

    //COSECHERO
    sCosechero, sCosecheroAux: string;
    ckilos_pri_ent, ckilos_seg_ent, ckilos_ter_ent, ckilos_des_ent, ckilos_mer_ent: Real;

    //PLANTACION
    sPlantacion, sAnyoSemana, sPlantacionAux: string;
    pkilos_pri_ent, pkilos_seg_ent, pkilos_ter_ent, pkilos_des_ent, pkilos_mer_ent: Real;


    //Parametros de entrada
    sEmpresa, sCentro, sProducto, sSemana: string;
    dFechaIni, dFechaFin: TDateTime;
    sKilos_Ini, sKilos_Fin, skilos_ent_transito, skilos_sal_venta, skilos_sal_transito: Real;


    procedure InsertarEntradas;
    procedure KilosLinea;
    procedure LimpiaKilosEntTotales;
    procedure IncKilosEntTotales;
    procedure LimpiaKilosEntCosechero;
    procedure IncKilosEntCosechero;
    procedure LimpiaKilosEntPlantacion;
    procedure IncKilosEntPlantacion;


    procedure InicializarVariables;
    //procedure PutKilosSalidas( var VKilos1, VKilos2, VKilos3, VKilosD: real );
    //procedure PutKilosTransitosSal( var VKilos1, VKilos2, VKilos3, VKilosD: real );
    //procedure PutKilosTransitosEnt( var VKilos1, VKilos2, VKilos3, VKilosD: real );
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
     procedure EntradasSemana(const AKey, AEmpresa, ACentro, AProducto, ASemana: string;
                             const ADesde, AHasta: TDateTime;
                             const AKilosVenta, AKilosTranIn, AKilosTranOut, AKilosIni, AKilosFin: Real;
                             var VKilosEntrada: Real );
  end;

var
  DMLiquidaPeriodoEntradas: TDMLiquidaPeriodoEntradas;

implementation

{$R *.dfm}

uses
  bMath, bTimeUtils, LiquidaPeriodoDM;

procedure TDMLiquidaPeriodoEntradas.DataModuleDestroy(Sender: TObject);
begin
  //
end;

procedure TDMLiquidaPeriodoEntradas.DataModuleCreate(Sender: TObject);
begin
  with qryEntradasCos do
  begin
    SQL.Clear;
    SQL.Add('select empresa_ec, centro_Ec, numero_entrada_ec, fecha_ec, peso_neto_ec, ');
    SQL.Add('       producto_e2l, cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l, total_kgs_e2l, ');
    SQL.Add('       nvl(tipo_entrada_e,0) tipo, porcen_primera_e, porcen_segunda_e, porcen_tercera_e, porcen_destrio_e, ');
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

procedure TDMLiquidaPeriodoEntradas.EntradasSemana(const AKey, AEmpresa, ACentro, AProducto, ASemana: string;
                             const ADesde, AHasta: TDateTime;
                             const AKilosVenta, AKilosTranIn, AKilosTranOut, AKilosIni, AKilosFin: Real;
                             var VKilosEntrada: Real );
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  sProducto:= AProducto;
  dFechaIni:= ADesde;
  dFechaFin:= AHasta;
  sSemana:= ASemana;
  sSemanaKey:= AKey;

  sKilos_Ini:= AKilosIni;
  sKilos_Fin:= AKilosFin;
  skilos_ent_transito:= AKilosTranIn;
  skilos_sal_venta:= AKilosVenta;
  skilos_sal_transito:= AKilosTranOut;

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
  VKilosEntrada:= tkilos_ent;
end;


procedure TDMLiquidaPeriodoEntradas.PutKilosEntradas( var VKilosAlmacen, VKilosDirectos, VKilosIndustria, VKilosCompra: real );
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
    Sql.Add('group by tipo ');
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

procedure TDMLiquidaPeriodoEntradas.InicializarVariables;
begin
  PutKilosEntradas( kilos_ent_alm, kilos_ent_dir, kilos_ent_ind, kilos_ent_com );
  tkilos_entrada:= kilos_ent_alm + kilos_ent_dir + kilos_ent_ind + kilos_ent_com;
  tkilos_mer:= ( skilos_ini + tkilos_entrada + skilos_ent_transito ) - ( skilos_fin + skilos_sal_venta + skilos_sal_transito );

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


procedure TDMLiquidaPeriodoEntradas.KilosLinea;
var
  rKilosAux: real;
begin
  if ( qryEntradasCos.FieldByName('tipo').AsString = '0' ) then
  begin
    kilos_mer:= bRoundTo( ( rPorcenMerma * qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat ) , 2);
    rKilosAux:= qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat - kilos_mer;
  end
  else
  begin
    kilos_mer:= 0;
    rKilosAux:= qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat
  end;

  if  ( qryEntradasCos.FieldByName('porcen_primera_e').AsFloat +
      qryEntradasCos.FieldByName('porcen_segunda_e').AsFloat +
      qryEntradasCos.FieldByName('porcen_primera_e').AsFloat +
      qryEntradasCos.FieldByName('porcen_segunda_e').AsFloat ) <> 0 then
  begin
    kilos_pri:= bRoundTo( rKilosAux * ( qryEntradasCos.FieldByName('porcen_primera_e').AsFloat / 100 ), 2);
    kilos_seg:= bRoundTo( rKilosAux * ( qryEntradasCos.FieldByName('porcen_segunda_e').AsFloat / 100 ), 2);
    kilos_ter:= bRoundTo( rKilosAux * ( qryEntradasCos.FieldByName('porcen_tercera_e').AsFloat / 100 ), 2);
    kilos_des:= bRoundTo( rKilosAux * ( qryEntradasCos.FieldByName('porcen_destrio_e').AsFloat / 100 ), 2);

    kilos_ini_pri:= bRoundTo( qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat * ( qryEntradasCos.FieldByName('porcen_primera_e').AsFloat / 100 ), 2);
    kilos_ini_seg:= bRoundTo( qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat * ( qryEntradasCos.FieldByName('porcen_segunda_e').AsFloat / 100 ), 2);
    kilos_ini_ter:= bRoundTo( qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat * ( qryEntradasCos.FieldByName('porcen_tercera_e').AsFloat / 100 ), 2);
    kilos_ini_des:= bRoundTo( qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat * ( qryEntradasCos.FieldByName('porcen_destrio_e').AsFloat / 100 ), 2);
  end
  else
  begin
    kilos_pri:= rKilosAux;
    kilos_seg:= 0;
    kilos_ter:= 0;
    kilos_des:= 0;

    kilos_ini_pri:= qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat;
    kilos_ini_seg:= 0;
    kilos_ini_ter:= 0;
    kilos_ini_des:= 0;
  end;
end;

procedure TDMLiquidaPeriodoEntradas.LimpiaKilosEntTotales;
begin
  tkilos_pri_ent:= 0;
  tkilos_seg_ent:= 0;
  tkilos_ter_ent:= 0;
  tkilos_des_ent:= 0;
  tkilos_mer_ent:= 0;

  tkilos_ini_pri_ent:= 0;
  tkilos_ini_seg_ent:= 0;
  tkilos_ini_ter_ent:= 0;
  tkilos_ini_des_ent:= 0;
end;

procedure TDMLiquidaPeriodoEntradas.IncKilosEntTotales;
begin
  tkilos_pri_ent:= tkilos_pri_ent +  kilos_pri;
  tkilos_seg_ent:= tkilos_seg_ent +  kilos_seg;
  tkilos_ter_ent:= tkilos_ter_ent +  kilos_ter;
  tkilos_des_ent:= tkilos_des_ent +  kilos_des;
  tkilos_mer_ent:= tkilos_mer_ent +  kilos_mer;

  tkilos_ini_pri_ent:= tkilos_ini_pri_ent +  kilos_ini_pri;
  tkilos_ini_seg_ent:= tkilos_ini_seg_ent +  kilos_ini_seg;
  tkilos_ini_ter_ent:= tkilos_ini_ter_ent +  kilos_ini_ter;
  tkilos_ini_des_ent:= tkilos_ini_des_ent +  kilos_ini_des;
end;

procedure TDMLiquidaPeriodoEntradas.LimpiaKilosEntCosechero;
begin
  ckilos_pri_ent:= 0;
  ckilos_seg_ent:= 0;
  ckilos_ter_ent:= 0;
  ckilos_des_ent:= 0;
  ckilos_mer_ent:= 0;
end;

procedure TDMLiquidaPeriodoEntradas.IncKilosEntCosechero;
begin
  ckilos_pri_ent:= ckilos_pri_ent +  kilos_pri;
  ckilos_seg_ent:= ckilos_seg_ent +  kilos_seg;
  ckilos_ter_ent:= ckilos_ter_ent +  kilos_ter;
  ckilos_des_ent:= ckilos_des_ent +  kilos_des;
  ckilos_mer_ent:= ckilos_mer_ent +  kilos_mer;
end;

procedure TDMLiquidaPeriodoEntradas.LimpiaKilosEntPlantacion;
begin
  pkilos_pri_ent:= 0;
  pkilos_seg_ent:= 0;
  pkilos_ter_ent:= 0;
  pkilos_des_ent:= 0;
  pkilos_mer_ent:= 0;
end;

procedure TDMLiquidaPeriodoEntradas.IncKilosEntPlantacion;
begin
  pkilos_pri_ent:= pkilos_pri_ent +  kilos_pri;
  pkilos_seg_ent:= pkilos_seg_ent +  kilos_seg;
  pkilos_ter_ent:= pkilos_ter_ent +  kilos_ter;
  pkilos_des_ent:= pkilos_des_ent +  kilos_des;
  pkilos_mer_ent:= pkilos_mer_ent +  kilos_mer;
end;

function TDMLiquidaPeriodoEntradas.GetCosecheroAux: string;
begin
  Result:= sSemanaKey + qryEntradasCos.FieldByName('cosechero_e2l').AsString
end;

function TDMLiquidaPeriodoEntradas.PutCosecheroAux: string;
begin
  Result:= GetCosecheroAux;
  sCosechero:= qryEntradasCos.FieldByName('cosechero_e2l').AsString;
end;

function TDMLiquidaPeriodoEntradas.GetPlantacionAux: string;
begin
  Result:= GetCosecheroAux + qryEntradasCos.FieldByName('plantacion_e2l').AsString + qryEntradasCos.FieldByName('ano_sem_planta_e2l').AsString;
end;

function TDMLiquidaPeriodoEntradas.PutPlantacionAux: string;
begin
  Result:= GetPlantacionAux;
  sPlantacion:= qryEntradasCos.FieldByName('plantacion_e2l').AsString;
  sAnyoSemana:=  qryEntradasCos.FieldByName('ano_sem_planta_e2l').AsString;
end;

procedure TDMLiquidaPeriodoEntradas.InsertarEntradas;
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

procedure TDMLiquidaPeriodoEntradas.GrabarKilosEntPlantacion;
begin
  with DMLiquidaPeriodo do
  begin
    kmtPlantacion.Insert;
    kmtPlantacion.FieldByName('keySem').AsString:= sSemanaKey;
    kmtPlantacion.FieldByName('cosechero').AsString:= sCosechero;
    kmtPlantacion.FieldByName('plantacion').AsString:= sPlantacion;
    kmtPlantacion.FieldByName('semana_planta').AsString:= sAnyoSemana;

    kmtPlantacion.FieldByName('kilos_total').AsFloat:= pkilos_pri_ent+pkilos_seg_ent+pkilos_ter_ent+pkilos_des_ent+pkilos_mer_ent;
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

procedure TDMLiquidaPeriodoEntradas.GrabarKilosEntCosechero;
begin
  with DMLiquidaPeriodo do
  begin
    kmtCosechero.Insert;
    kmtCosechero.FieldByName('keySem').AsString:= sSemanaKey;
    kmtCosechero.FieldByName('cosechero').AsString:= sCosechero;

    kmtCosechero.FieldByName('kilos_total').AsFloat:= ckilos_pri_ent + ckilos_seg_ent + ckilos_ter_ent + ckilos_des_ent + ckilos_mer_ent;
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

procedure TDMLiquidaPeriodoEntradas.GrabarKilosEntrada;
begin
  with DMLiquidaPeriodo do
  begin
    kmtEntradas.Insert;
    kmtEntradas.FieldByName('keySem').AsString:= sSemanaKey;

    kmtEntradas.FieldByName('kilos_total').AsFloat:= tkilos_entrada;
    kmtEntradas.FieldByName('kilos_pri').AsFloat:= tkilos_pri_ent;
    kmtEntradas.FieldByName('kilos_seg').AsFloat:= tkilos_seg_ent;
    kmtEntradas.FieldByName('kilos_ter').AsFloat:= tkilos_ter_ent;
    kmtEntradas.FieldByName('kilos_des').AsFloat:= tkilos_des_ent;
    kmtEntradas.FieldByName('kilos_mer').AsFloat:= tkilos_mer_ent;

    kmtEntradas.FieldByName('kilos_ini_total').AsFloat:= tkilos_entrada;
    kmtEntradas.FieldByName('kilos_ini_pri').AsFloat:= tkilos_ini_pri_ent;
    kmtEntradas.FieldByName('kilos_ini_seg').AsFloat:= tkilos_ini_seg_ent;
    kmtEntradas.FieldByName('kilos_ini_ter').AsFloat:= tkilos_ini_ter_ent;
    kmtEntradas.FieldByName('kilos_ini_des').AsFloat:= tkilos_ini_des_ent;

    kmtEntradas.Post;
  end;
end;

end.
