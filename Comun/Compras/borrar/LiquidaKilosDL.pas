unit LiquidaKilosDL;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DBTables;

type
  TDLLiquidaKilos = class(TDataModule)
    qryAux: TQuery;
    qryLocal: TQuery;
    qryRemoto: TQuery;
    kmtKilos: TkbmMemTable;
    qryEnvase: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    strEmpresa, sProducto, sCategoria, sSemana, sProveedor, sEntrega: string;
    bPlanta, bPorCategoria, bVerEntregas, bPorVariedad: boolean;

    function  ConectarRemoto: boolean;
    procedure DesconectarRemoto;

    procedure AnyadirKilos;
    procedure AnyadirKilosLocal;

    procedure AnyadirLineaKilosLocal;
    procedure AnyadirKilosRemoto;

    procedure AnyadirKilosAlmacen;
    procedure AnyadirLineaKilosAlmacen;

    procedure AnyadirKilosRf;
    procedure AnyadirLineaKilosRF;

    procedure AnyadirKilosSalidasVerde;
    procedure AnyadirLineaKilosSalidasVerde;
  public
    { Public declarations }
    procedure KilosEntregasPlatano( const AEmpresa, AProducto, ACategoria, ASemana, AProveedor, AEntrega: string; const APlanta, APorCategoria, APorVariedad, AVerEntregas: boolean );
  end;

implementation

{$R *.dfm}

uses
  Variants, Dialogs, LiquidaIncidenciasQL, LiquidaKilosQL, UDMBaseDatos, bMath;

procedure TDLLiquidaKilos.DataModuleCreate(Sender: TObject);
begin
  //
  kmtKilos.FieldDefs.Clear;
  kmtKilos.FieldDefs.Add('empresa', ftString, 3, False);
  kmtKilos.FieldDefs.Add('producto', ftString, 3, False);
  kmtKilos.FieldDefs.Add('categoria', ftString, 12, False);
  kmtKilos.FieldDefs.Add('proveedor', ftString, 3, False);
  kmtKilos.FieldDefs.Add('productor', ftString, 3, False);
  kmtKilos.FieldDefs.Add('entrega', ftString, 12, False);
  kmtKilos.FieldDefs.Add('variedad', ftString,6, False);
  kmtKilos.FieldDefs.Add('cajas_local', ftFloat, 0, False);
  kmtKilos.FieldDefs.Add('kilos_local', ftFloat, 0, False);
  kmtKilos.FieldDefs.Add('almacen', ftFloat, 0, False);
  kmtKilos.FieldDefs.Add('cajas_almacen', ftFloat, 0, False);
  kmtKilos.FieldDefs.Add('kilos_almacen', ftFloat, 0, False);
  kmtKilos.FieldDefs.Add('diff_calmacen', ftFloat, 0, False);
  kmtKilos.FieldDefs.Add('diff_kalmacen', ftFloat, 0, False);
  kmtKilos.FieldDefs.Add('cajas_rf', ftFloat, 0, False);
  kmtKilos.FieldDefs.Add('kilos_rf', ftFloat, 0, False);
  kmtKilos.FieldDefs.Add('diff_crf', ftFloat, 0, False);
  kmtKilos.FieldDefs.Add('diff_krf', ftFloat, 0, False);
  kmtKilos.FieldDefs.Add('porcen_diff_krf', ftFloat, 0, False);

  kmtKilos.CreateTable;
  kmtKilos.Open;

  qryEnvase.sql.clear;
  qryEnvase.sql.Add(' select first 1 envase_e ');
  qryEnvase.sql.Add(' from frf_productos_proveedor, frf_ean13 ');
  qryEnvase.sql.Add(' where empresa_pp = :empresa ');
  qryEnvase.sql.Add(' and variedad_pp = :variedad ');
  qryEnvase.sql.Add(' and producto_pp = :producto ');
  qryEnvase.sql.Add(' and proveedor_pp = :proveedor ');
  qryEnvase.sql.Add(' and  empresa_pp = empresa_e ');
  qryEnvase.sql.Add(' and codigo_ean_pp = codigo_e ');

end;

procedure TDLLiquidaKilos.DataModuleDestroy(Sender: TObject);
begin
  //
  kmtKilos.Close;
end;

function TDLLiquidaKilos.ConectarRemoto: boolean;
var
  sBD: string;
  bAux1: Boolean;
begin
  bAux1:= qryRemoto.Active;
  if qryRemoto.Active then
    qryRemoto.Close;

  //DesconectarRemoto;
  sBD:= '';
  if strEmpresa = 'F17' then
  begin
   if not DMBaseDatos.dbF17.Connected then
     DMBaseDatos.dbF17.Connected:= True;
   sBD:= 'dbF17';
  end
  else
  begin
    if DMBaseDatos.dbF17.Connected then
      DMBaseDatos.dbF17.Connected:= False;
  end;

  if strEmpresa = 'F18' then
  begin
   if not DMBaseDatos.dbF18.Connected then
     DMBaseDatos.dbF18.Connected:= True;
   sBD:= 'dbF18';
  end
  else
  begin
    if DMBaseDatos.dbF18.Connected then
      DMBaseDatos.dbF18.Connected:= False;
  end;

  if strEmpresa = 'F21' then
  begin
   if not DMBaseDatos.dbF21.Connected then
     DMBaseDatos.dbF21.Connected:= True;
   sBD:= 'dbF21';
  end
  else
  begin
    if DMBaseDatos.dbF21.Connected then
      DMBaseDatos.dbF21.Connected:= False;
  end;

  if strEmpresa = 'F23' then
  begin
   if not DMBaseDatos.dbF23.Connected then
     DMBaseDatos.dbF23.Connected:= True;
   sBD:= 'dbF23';
  end
  else
  begin
    if DMBaseDatos.dbF23.Connected then
      DMBaseDatos.dbF23.Connected:= False;
  end;

  if strEmpresa = 'F24' then
  begin
   if not DMBaseDatos.dbF24.Connected then
     DMBaseDatos.dbF24.Connected:= True;
   sBD:= 'dbF24';
  end
  else
  begin
    if DMBaseDatos.dbF24.Connected then
      DMBaseDatos.dbF24.Connected:= False;
  end;

  if sBD <> '' then
  begin
    result:= True;
    qryRemoto.DatabaseName:= sBD;
    if bAux1 then
      qryRemoto.Open;
  end
  else
  begin
    result:= false;
  end;
end;

procedure TDLLiquidaKilos.DesconectarRemoto;
begin
  if DMBaseDatos.dbF17.Connected then
    DMBaseDatos.dbF17.Connected:= False;
  if DMBaseDatos.dbF18.Connected then
    DMBaseDatos.dbF18.Connected:= False;
  if DMBaseDatos.dbF21.Connected then
    DMBaseDatos.dbF21.Connected:= False;
  if DMBaseDatos.dbF23.Connected then
    DMBaseDatos.dbF23.Connected:= False;
  if DMBaseDatos.dbF24.Connected then
    DMBaseDatos.dbF24.Connected:= False;
end;

procedure TDLLiquidaKilos.AnyadirKilosRemoto;
begin
  if ConectarRemoto then
  begin
    try
      AnyadirKilosAlmacen;
      AnyadirKilosRF;
    finally
      DesconectarRemoto;
    end;
  end
  else
  begin
    AnyadirKilosSalidasVerde;
  end;
end;

procedure TDLLiquidaKilos.AnyadirKilosSalidasVerde;
var
  sqlProveedor, sqlCategoria, sqlEntrega, sqlVariedad: string;
begin
  with qryLocal do
  begin
    Sql.Clear;
    if bPorVariedad then
    begin
      sqlVariedad:=' envase_sl variedad,';
      sqlProveedor:=' proveedor_ec proveedor,  '''' productor, ';
    end
    else
    begin
      sqlVariedad:=' '''' variedad,';
      sqlProveedor:=' '''' proveedor, '''' productor, ';
    end;

    if bPorCategoria then
    begin
      sqlCategoria:=' categoria_sl categoria,';
    end
    else
    begin
      sqlCategoria:=' '''' categoria,';
      sqlProveedor:=' proveedor_ec proveedor, ( select max(almacen_el) from frf_entregas_l where codigo_Ec = codigo_el ) productor,';
    end;

    if bVerEntregas then
    begin
      sqlEntrega:=' codigo_ec entrega,';
      sqlProveedor:=' proveedor_ec proveedor, ( select max(almacen_el) from frf_entregas_l where codigo_Ec = codigo_el ) productor,';
    end
    else
    begin
      sqlEntrega:=' '''' entrega,';
    end;


    Sql.Add('select empresa_ec empresa, producto_ec producto, ' + sqlCategoria +  sqlVariedad + sqlProveedor + sqlEntrega );
    Sql.Add('  sum(cajas_sl) cajas, sum(kilos_sl) kilos');
    Sql.Add(' from frf_entregas_c,frf_salidas_l');
    Sql.Add(' where empresa_ec = :empresa ');
    Sql.Add(' and producto_ec = :producto ');
    if sEntrega <> '' then
    begin
      Sql.Add(' and codigo_ec = :entrega ' );
    end
    else
    begin
      Sql.Add(' and anyo_Semana_ec = :semana ' );
    end;
    Sql.Add(' and codigo_Ec = entrega_sl');

    if sCategoria <> '' then
    begin
      Sql.Add(' and categoria_sl = :categoria ' );
    end;

    if sProveedor <> '' then
    begin
      Sql.Add(' and proveedor_ec = :proveedor ' );
    end;

    Sql.Add(' group by 1,2,3,4,5,6,7 ');
    Sql.Add(' order by 1,2,3,4,5,6,7 ');

    ParamByName('empresa').AsString:= strEmpresa;
    ParamByName('producto').AsString:= sProducto;
    if sCategoria <> '' then
    begin
      ParamByName('categoria').AsString:= sCategoria;
    end;
    if sProveedor <> '' then
    begin
      ParamByName('proveedor').AsString:= sProveedor;
    end;
    if sEntrega <> '' then
    begin
      ParamByName('entrega').AsString:= sEntrega;
    end
    else
    begin
      ParamByName('semana').AsString:= sSemana;
    end;

    Open;
    while not Eof do
    begin
      AnyadirLineaKilosSalidasVerde;
      Next;
    end;
    Close;
  end;
end;

procedure TDLLiquidaKilos.AnyadirLineaKilosSalidasVerde;
var
  sEmpresa: string;
begin
  if bPlanta then
  begin
    sEmpresa:= qryLocal.FieldByName('empresa').AsString;
  end
  else
  begin
    if qryLocal.FieldByName('empresa').AsString = 'F42' then
      sEmpresa:= 'F42'
    else
      sEmpresa:= '';
  end;

  if kmtKilos.Locate( 'empresa;producto;categoria;variedad;proveedor;productor;entrega',
       VarArrayOf([sEmpresa,
                   qryLocal.fieldByName('producto').AsString,
                   qryLocal.fieldByName('categoria').AsString,
                   qryLocal.fieldByName('variedad').AsString,
                   qryLocal.fieldByName('proveedor').AsString,
                   qryLocal.fieldByName('productor').AsString,
                   qryLocal.fieldByName('entrega').AsString]),[]) then
  begin
    kmtKilos.Edit;
    kmtKilos.FieldByName('cajas_almacen').AsFloat:= kmtKilos.FieldByName('cajas_almacen').AsFloat + qryLocal.FieldByName('cajas').AsFloat;
    kmtKilos.FieldByName('kilos_almacen').AsFloat:= kmtKilos.FieldByName('kilos_almacen').AsFloat + qryLocal.FieldByName('kilos').AsFloat;

    if ( kmtKilos.FieldByName('cajas_almacen').AsFloat <> kmtKilos.FieldByName('cajas_local').AsFloat )  then
      kmtKilos.FieldByName('diff_calmacen').AsFloat:= 1
    else
      kmtKilos.FieldByName('diff_calmacen').AsFloat:= 0;

    if ( kmtKilos.FieldByName('kilos_almacen').AsFloat <> kmtKilos.FieldByName('kilos_local').AsFloat ) then
      kmtKilos.FieldByName('diff_kalmacen').AsFloat:= 1
    else
      kmtKilos.FieldByName('diff_kalmacen').AsFloat:= 0;
    kmtKilos.Post;
  end
  else
  begin
    kmtKilos.Insert;
    kmtKilos.FieldByName('empresa').AsString:= sEmpresa;
    kmtKilos.FieldByName('producto').AsString:= qryLocal.FieldByName('producto').AsString;
    kmtKilos.FieldByName('categoria').AsString:= qryLocal.FieldByName('categoria').AsString;
    kmtKilos.FieldByName('variedad').AsString:= qryLocal.FieldByName('variedad').AsString;
    kmtKilos.FieldByName('proveedor').AsString:= qryLocal.FieldByName('proveedor').AsString;
    kmtKilos.FieldByName('productor').AsString:= qryLocal.FieldByName('productor').AsString;
    kmtKilos.FieldByName('entrega').AsString:= qryLocal.FieldByName('entrega').AsString;
    kmtKilos.FieldByName('cajas_local').AsFloat:= 0;
    kmtKilos.FieldByName('kilos_local').AsFloat:= 0;
    kmtKilos.FieldByName('cajas_almacen').AsFloat:= qryLocal.FieldByName('cajas').AsFloat;
    kmtKilos.FieldByName('kilos_almacen').AsFloat:= qryLocal.FieldByName('kilos').AsFloat;
    kmtKilos.FieldByName('cajas_rf').AsFloat:= 0;
    kmtKilos.FieldByName('kilos_rf').AsFloat:= 0;
    kmtKilos.FieldByName('diff_calmacen').AsFloat:= 1;
    kmtKilos.FieldByName('diff_kalmacen').AsFloat:= 1;
    kmtKilos.FieldByName('almacen').AsFloat:= 0;
    kmtKilos.Post;
  end;
end;

procedure TDLLiquidaKilos.AnyadirKilosAlmacen;
var
  sqlProveedor, sqlCategoria, sqlEntrega, sqlVariedad: string;
begin
  with qryRemoto do
  begin
    Sql.Clear;

    if bPorVariedad then
    begin
      sqlVariedad:=' variedad_el variedad,';
      sqlProveedor:=' proveedor_el proveedor,  '''' productor, ';
    end
    else
    begin
      sqlVariedad:=' '''' variedad,';
      sqlProveedor:=' '''' proveedor, '''' productor, ';
    end;


    if bPorCategoria then
    begin
      sqlCategoria:=' categoria_el categoria,';
    end
    else
    begin
      sqlCategoria:=' '''' categoria,';
      sqlProveedor:=' proveedor_el proveedor, almacen_el productor, ';
    end;

    if bVerEntregas then
    begin
      sqlEntrega:=' codigo_ec entrega,';
      sqlProveedor:=' proveedor_el proveedor, almacen_el productor, ';
    end
    else
      sqlEntrega:=' '''' entrega,';

    Sql.Add(' select empresa_ec empresa, producto_el producto, ' + sqlCategoria +  sqlVariedad + sqlProveedor + sqlEntrega );
    Sql.Add('        sum(cajas_el) cajas, sum(kilos_el) kilos');

    Sql.Add(' from frf_entregas_c,frf_entregas_l');
    Sql.Add(' where empresa_ec = :empresa ');
    Sql.Add(' and producto_ec = :producto ');
    if sEntrega <> '' then
    begin
      Sql.Add(' and codigo_ec = :entrega ' );
    end
    else
    begin
      Sql.Add(' and anyo_Semana_ec = :semana ' );
    end;
    Sql.Add(' and codigo_Ec = codigo_el');
    if sCategoria <> '' then
    begin
      Sql.Add(' and categoria_el = :categoria ' );
    end;
    if sProveedor <> '' then
    begin
      Sql.Add(' and proveedor_ec = :proveedor ' );
    end;
    Sql.Add(' group by 1,2,3,4,5,6,7 ');
    Sql.Add(' order by 1,2,3,4,5,6,7 ');

    ParamByName('empresa').AsString:= strEmpresa;
    ParamByName('producto').AsString:= sProducto;
    if sCategoria <> '' then
    begin
      ParamByName('categoria').AsString:= sCategoria;
    end;
    if sProveedor <> '' then
    begin
      ParamByName('proveedor').AsString:= sProveedor;
    end;
    if sEntrega <> '' then
    begin
      ParamByName('entrega').AsString:=sEntrega;
    end
    else
    begin
      ParamByName('semana').AsString:= sSemana;
    end;

    Open;
    while not Eof do
    begin
      AnyadirLineaKilosAlmacen;
      Next;
    end;
    Close;
  end;
end;

procedure TDLLiquidaKilos.AnyadirLineaKilosAlmacen;
var
  sEmpresa: string;
begin
  if bPlanta then
    sEmpresa:= qryRemoto.FieldByName('empresa').AsString
  else
    sEmpresa:= '';

  if kmtKilos.Locate( 'empresa;producto;categoria;variedad;proveedor;productor;entrega',
       VarArrayOf([sEmpresa,
                   qryRemoto.fieldByName('producto').AsString,
                   qryRemoto.fieldByName('categoria').AsString,
                   qryRemoto.fieldByName('variedad').AsString,
                   qryRemoto.fieldByName('proveedor').AsString,
                   qryRemoto.fieldByName('productor').AsString,
                   qryRemoto.fieldByName('entrega').AsString]),[]) then
  begin
    kmtKilos.Edit;
    kmtKilos.FieldByName('almacen').AsFloat:= 1;
    kmtKilos.FieldByName('cajas_almacen').AsFloat:= kmtKilos.FieldByName('cajas_almacen').AsFloat + qryRemoto.FieldByName('cajas').AsFloat;
    kmtKilos.FieldByName('kilos_almacen').AsFloat:= kmtKilos.FieldByName('kilos_almacen').AsFloat + qryRemoto.FieldByName('kilos').AsFloat;

    if ( kmtKilos.FieldByName('cajas_almacen').AsFloat <> kmtKilos.FieldByName('cajas_local').AsFloat )  then
      kmtKilos.FieldByName('diff_calmacen').AsFloat:= 1
    else
      kmtKilos.FieldByName('diff_calmacen').AsFloat:= 0;

    if ( kmtKilos.FieldByName('kilos_almacen').AsFloat <> kmtKilos.FieldByName('kilos_local').AsFloat ) then
      kmtKilos.FieldByName('diff_kalmacen').AsFloat:= 1
    else
      kmtKilos.FieldByName('diff_kalmacen').AsFloat:= 0;
    kmtKilos.Post;
  end
  else
  begin
    kmtKilos.Insert;
    kmtKilos.FieldByName('empresa').AsString:=  sEmpresa;
    kmtKilos.FieldByName('producto').AsString:= qryRemoto.FieldByName('producto').AsString;
    kmtKilos.FieldByName('categoria').AsString:= qryRemoto.FieldByName('categoria').AsString;
    kmtKilos.FieldByName('variedad').AsString:= qryRemoto.FieldByName('variedad').AsString;
    kmtKilos.FieldByName('proveedor').AsString:= qryRemoto.FieldByName('proveedor').AsString;
    kmtKilos.FieldByName('productor').AsString:= qryRemoto.FieldByName('productor').AsString;
    kmtKilos.FieldByName('entrega').AsString:= qryRemoto.FieldByName('entrega').AsString;
    kmtKilos.FieldByName('cajas_local').AsFloat:= 0;
    kmtKilos.FieldByName('kilos_local').AsFloat:= 0;
    kmtKilos.FieldByName('cajas_almacen').AsFloat:= qryRemoto.FieldByName('cajas').AsFloat;
    kmtKilos.FieldByName('kilos_almacen').AsFloat:= qryRemoto.FieldByName('kilos').AsFloat;
    kmtKilos.FieldByName('cajas_rf').AsFloat:= 0;
    kmtKilos.FieldByName('kilos_rf').AsFloat:= 0;
    kmtKilos.FieldByName('diff_calmacen').AsFloat:= 1;
    kmtKilos.FieldByName('diff_kalmacen').AsFloat:= 1;
    kmtKilos.FieldByName('almacen').AsFloat:= 1;
    kmtKilos.Post;
  end;
end;

procedure TDLLiquidaKilos.AnyadirKilosRf;
var
  sqlProveedor, sqlCategoria, sqlEntrega, sqlVariedad: string;
begin
  with qryRemoto do
  begin
    Sql.Clear;
    if bPorVariedad then
    begin
      sqlVariedad:=' variedad,';
      sqlProveedor:=' proveedor proveedor,  '''' productor, ';
    end
    else
    begin
      sqlVariedad:=' '''' variedad,';
      sqlProveedor:=' '''' proveedor, '''' productor, ';
    end;

    if bPorCategoria then
    begin
      sqlCategoria:=' categoria categoria,';
    end
    else
    begin
      sqlCategoria:=' '''' categoria,';
      sqlProveedor:=' proveedor proveedor, proveedor_almacen productor, ';
    end;

    if bVerEntregas then
    begin
      sqlEntrega:=' codigo_ec entrega,';
      sqlProveedor:=' proveedor proveedor, proveedor_almacen productor, ';
    end
    else
      sqlEntrega:=' '''' entrega,';

    Sql.Add(' select empresa_ec empresa, producto_ec producto, ' + sqlCategoria + sqlVariedad +  sqlProveedor + sqlEntrega );
    Sql.Add('        sum(cajas) cajas, sum(peso) kilos');

    Sql.Add(' from frf_entregas_c,rf_palet_pb');
    Sql.Add(' where empresa_ec = :empresa ');
    Sql.Add(' and producto_ec = :producto ');
    if sEntrega <> '' then
    begin
      Sql.Add(' and codigo_ec = :entrega ' );
    end
    else
    begin
      Sql.Add(' and anyo_Semana_ec = :semana ' );
    end;
    Sql.Add(' and codigo_Ec = entrega');
    Sql.Add(' and status <> ''B'' ');
    if sCategoria <> '' then
    begin
      Sql.Add(' and categoria = :categoria ' );
    end;
    if sProveedor <> '' then
    begin
      Sql.Add(' and proveedor_ec = :proveedor ' );
    end;
    Sql.Add(' group by 1,2,3,4,5,6,7 ');
    Sql.Add(' order by 1,2,3,4,5,6,7 ');

    ParamByName('empresa').AsString:= strEmpresa;
    ParamByName('producto').AsString:= sProducto;
    if sCategoria <> '' then
    begin
      ParamByName('categoria').AsString:= sCategoria;
    end;
    if sProveedor <> '' then
    begin
      ParamByName('proveedor').AsString:= sProveedor;
    end;
    if sEntrega <> '' then
    begin
      ParamByName('entrega').AsString:= sEntrega;
    end
    else
    begin
      ParamByName('semana').AsString:= sSemana;
    end;

    Open;
    while not Eof do
    begin
      AnyadirLineaKilosRF;
      Next;
    end;
    Close;
  end;
end;

procedure TDLLiquidaKilos.AnyadirLineaKilosRF;
var
  sEmpresa: string;
begin
  if bPlanta then
    sEmpresa:= qryRemoto.FieldByName('empresa').AsString
  else
    sEmpresa:= '';

  if kmtKilos.Locate( 'empresa;producto;categoria;variedad;proveedor;productor;entrega',
       VarArrayOf([sEmpresa,
                   qryRemoto.fieldByName('producto').AsString,
                   qryRemoto.fieldByName('categoria').AsString,
                   qryRemoto.fieldByName('variedad').AsString,
                   qryRemoto.fieldByName('proveedor').AsString,
                   qryRemoto.fieldByName('productor').AsString,
                   qryRemoto.fieldByName('entrega').AsString]),[]) then
  begin
    kmtKilos.Edit;
    kmtKilos.FieldByName('almacen').AsFloat:= 1;
    kmtKilos.FieldByName('cajas_rf').AsFloat:= kmtKilos.FieldByName('cajas_rf').AsFloat + qryRemoto.FieldByName('cajas').AsFloat;
    kmtKilos.FieldByName('kilos_rf').AsFloat:= kmtKilos.FieldByName('kilos_rf').AsFloat + qryRemoto.FieldByName('kilos').AsFloat;
    if ( kmtKilos.FieldByName('cajas_almacen').AsFloat <> kmtKilos.FieldByName('cajas_rf').AsFloat ) then
      kmtKilos.FieldByName('diff_crf').AsFloat:= 1
    else
      kmtKilos.FieldByName('diff_crf').AsFloat:= 0;

    if kmtKilos.FieldByName('kilos_almacen').AsFloat = 0 then
      kmtKilos.FieldByName('porcen_diff_krf').AsFloat:= 100
    else
      kmtKilos.FieldByName('porcen_diff_krf').AsFloat:=  bRoundTo( ( (  ( kmtKilos.FieldByName('kilos_rf').AsFloat / kmtKilos.FieldByName('kilos_almacen').AsFloat ) - 1 ) ) * 100, 2 );
    if Abs( kmtKilos.FieldByName('porcen_diff_krf').AsFloat  ) > 5 then
      kmtKilos.FieldByName('diff_krf').AsFloat:= 1
    else
      kmtKilos.FieldByName('diff_krf').AsFloat:= 0;
    kmtKilos.Post;

  end
  else
  begin
    kmtKilos.Insert;
    kmtKilos.FieldByName('empresa').AsString:= sEmpresa;
    kmtKilos.FieldByName('producto').AsString:= qryRemoto.FieldByName('producto').AsString;
    kmtKilos.FieldByName('categoria').AsString:= qryRemoto.FieldByName('categoria').AsString;
    kmtKilos.FieldByName('variedad').AsString:= qryRemoto.FieldByName('variedad').AsString;
    kmtKilos.FieldByName('proveedor').AsString:= qryRemoto.FieldByName('proveedor').AsString;
    kmtKilos.FieldByName('productor').AsString:= qryRemoto.FieldByName('productor').AsString;
    kmtKilos.FieldByName('entrega').AsString:= qryRemoto.FieldByName('entrega').AsString;
    kmtKilos.FieldByName('cajas_local').AsFloat:= 0;
    kmtKilos.FieldByName('kilos_local').AsFloat:= 0;
    kmtKilos.FieldByName('cajas_almacen').AsFloat:= 0;
    kmtKilos.FieldByName('kilos_almacen').AsFloat:= 0;
    kmtKilos.FieldByName('cajas_rf').AsFloat:= qryRemoto.FieldByName('cajas').AsFloat;
    kmtKilos.FieldByName('kilos_rf').AsFloat:= qryRemoto.FieldByName('kilos').AsFloat;
    kmtKilos.FieldByName('diff_crf').AsFloat:= 1;
    kmtKilos.FieldByName('diff_krf').AsFloat:= 1;
    kmtKilos.FieldByName('porcen_diff_krf').AsFloat:= 100;
    kmtKilos.FieldByName('almacen').AsFloat:= 1;
    kmtKilos.Post;
  end;
end;

procedure TDLLiquidaKilos.AnyadirLineaKilosLocal;
var
  sEmpresa, sVariedad: string;
begin
  if bPlanta then
  begin
    sEmpresa:= qryLocal.FieldByName('empresa').AsString;
  end
  else
  begin
    if qryLocal.FieldByName('empresa').AsString = 'F42' then
      sEmpresa:= 'F42'
    else
      sEmpresa:= '';
  end;

  if qryLocal.FieldByName('empresa').AsString = 'F42' then
  begin
    qryEnvase.ParamByName('empresa').AsString:= qryLocal.FieldByName('empresa').AsString;
    qryEnvase.ParamByName('variedad').AsString:= qryLocal.FieldByName('variedad').AsString;
    qryEnvase.ParamByName('producto').AsString:= qryLocal.FieldByName('producto').AsString;
    qryEnvase.ParamByName('proveedor').AsString:= qryLocal.FieldByName('proveedor').AsString;
    qryEnvase.Open;
    if qryEnvase.FieldByname('envase_e').AsString <> '' then
      sVariedad:= qryEnvase.FieldByname('envase_e').AsString
    else
      sVariedad:= qryLocal.FieldByName('variedad').AsString;
    qryEnvase.Close;
  end
  else
  begin
    sVariedad:= qryLocal.FieldByName('variedad').AsString;
  end;


  if kmtKilos.Locate( 'empresa;producto;categoria;variedad;proveedor;productor;entrega',
       VarArrayOf([sEmpresa,
                   qryLocal.fieldByName('producto').AsString,
                   qryLocal.fieldByName('categoria').AsString,
                   sVariedad,//qryLocal.fieldByName('variedad').AsString,
                   qryLocal.fieldByName('proveedor').AsString,
                   qryLocal.fieldByName('productor').AsString,
                   qryLocal.fieldByName('entrega').AsString]),[]) then
  begin
    kmtKilos.Edit;
    kmtKilos.FieldByName('cajas_local').AsFloat:= kmtKilos.FieldByName('cajas_local').AsFloat + qryLocal.FieldByName('cajas').AsFloat;
    kmtKilos.FieldByName('kilos_local').AsFloat:= kmtKilos.FieldByName('kilos_local').AsFloat + qryLocal.FieldByName('kilos').AsFloat;
    kmtKilos.Post;
  end
  else
  begin
    kmtKilos.Insert;
    kmtKilos.FieldByName('empresa').AsString:= sEmpresa;
    kmtKilos.FieldByName('producto').AsString:= qryLocal.FieldByName('producto').AsString;
    kmtKilos.FieldByName('categoria').AsString:= qryLocal.FieldByName('categoria').AsString;
    kmtKilos.FieldByName('variedad').AsString:= sVariedad;//qryLocal.FieldByName('variedad').AsString;
    kmtKilos.FieldByName('proveedor').AsString:= qryLocal.FieldByName('proveedor').AsString;
    kmtKilos.FieldByName('productor').AsString:= qryLocal.FieldByName('productor').AsString;
    kmtKilos.FieldByName('entrega').AsString:= qryLocal.FieldByName('entrega').AsString;
    kmtKilos.FieldByName('cajas_local').AsFloat:= qryLocal.FieldByName('cajas').AsFloat;
    kmtKilos.FieldByName('kilos_local').AsFloat:= qryLocal.FieldByName('kilos').AsFloat;
    kmtKilos.FieldByName('cajas_almacen').AsFloat:= 0;
    kmtKilos.FieldByName('kilos_almacen').AsFloat:= 0;
    kmtKilos.FieldByName('cajas_rf').AsFloat:= 0;
    kmtKilos.FieldByName('kilos_rf').AsFloat:= 0;
    kmtKilos.FieldByName('diff_calmacen').AsFloat:= 0;
    kmtKilos.FieldByName('diff_kalmacen').AsFloat:= 0;
    kmtKilos.FieldByName('diff_crf').AsFloat:= 0;
    kmtKilos.FieldByName('diff_krf').AsFloat:= 0;
    kmtKilos.FieldByName('porcen_diff_krf').AsFloat:= 0;
    kmtKilos.FieldByName('almacen').AsFloat:= 0;
    kmtKilos.Post;
  end;
end;

procedure TDLLiquidaKilos.AnyadirKilosLocal;
var
  sqlProveedor, sqlCategoria, sqlEntrega, sqlVariedad: string;
begin
  with qryLocal do
  begin
    Sql.Clear;
    if bPorVariedad then
    begin
      sqlVariedad:=' variedad_el variedad,';
      sqlProveedor:=' proveedor_el proveedor,  '''' productor, ';
    end
    else
    begin
      sqlVariedad:=' '''' variedad,';
      sqlProveedor:=' '''' proveedor, '''' productor, ';
    end;

    if bPorCategoria then
    begin
      sqlCategoria:=' categoria_el categoria,';
    end
    else
    begin
      sqlCategoria:=' '''' categoria,';
      sqlProveedor:=' proveedor_el proveedor, almacen_el productor,';
    end;

    if bVerEntregas then
    begin
      sqlEntrega:=' codigo_ec entrega,';
      sqlProveedor:=' proveedor_el proveedor, almacen_el productor,';
    end
    else
      sqlEntrega:=' '''' entrega,';

    Sql.Add(' select empresa_ec empresa, producto_ec producto, ' + sqlCategoria +  sqlVariedad + sqlProveedor + sqlEntrega );
    Sql.Add('        sum(cajas_el) cajas, sum(kilos_el) kilos');

    Sql.Add(' from frf_entregas_c,frf_entregas_l');
    Sql.Add(' where empresa_ec = :empresa ');
    Sql.Add(' and producto_ec = :producto ');
    if sEntrega <> '' then
    begin
      Sql.Add(' and codigo_ec = :entrega ' );
    end
    else
    begin
      Sql.Add(' and anyo_Semana_ec = :semana ' );
    end;
    Sql.Add(' and codigo_Ec = codigo_el');
    if sCategoria <> '' then
    begin
      Sql.Add(' and categoria_el = :categoria ' );
    end;
    if sProveedor <> '' then
    begin
      Sql.Add(' and proveedor_ec = :proveedor ' );
    end;
    Sql.Add(' group by 1,2,3,4,5,6,7 ');
    Sql.Add(' order by 1,2,3,4,5,6,7 ');

    ParamByName('empresa').AsString:= strEmpresa;
    ParamByName('producto').AsString:= sProducto;
    if sCategoria <> '' then
    begin
      ParamByName('categoria').AsString:= sCategoria;
    end;
    if sProveedor <> '' then
    begin
      ParamByName('proveedor').AsString:= sProveedor;
    end;
    if sEntrega <> '' then
    begin
      ParamByName('entrega').AsString:= sEntrega;
    end
    else
    begin
      ParamByName('semana').AsString:= sSemana;
    end;

    Open;
    while not Eof do
    begin
      AnyadirLineaKilosLocal;
      Next;
    end;
    Close;
  end;
end;

procedure TDLLiquidaKilos.AnyadirKilos;
begin
  AnyadirKilosLocal;
  AnyadirKilosRemoto;
end;

procedure TDLLiquidaKilos.KilosEntregasPlatano( const AEmpresa, AProducto, ACategoria, ASemana, AProveedor, AEntrega: string; const APlanta, APorCategoria, APorVariedad, AVerEntregas: boolean );
begin
  sProducto:= AProducto;
  sCategoria:= ACategoria;
  sSemana:= ASemana;
  sEntrega:= AEntrega;
  sProveedor:= AProveedor;

  bPlanta:= APlanta;
  bPorCategoria:= APorCategoria;
  bPorVariedad:= APorVariedad;
  bVerEntregas:= AVerEntregas;

  with qryAux do
  begin
    Sql.Clear;
    Sql.Add(' select empresa_ec empresa');
    Sql.Add(' from frf_entregas_c,frf_entregas_l');
    Sql.Add(' where producto_ec = :producto ');
    if AEntrega <> '' then
    begin
      Sql.Add(' and codigo_ec = :entrega ' );
    end
    else
    begin
      Sql.Add(' and anyo_Semana_ec = :semana ' );
    end;
    if AEmpresa <> '' then
    begin
      if AEmpresa = 'BAG' then
      begin
        Sql.Add(' and empresa_ec in (''F17'',''F23'',''F24'',''F42'') ');
      end
      else
      begin
        Sql.Add(' and empresa_ec = :empresa ');
      end;
    end;
    Sql.Add(' and codigo_Ec = codigo_el');
    if sCategoria <> '' then
    begin
      Sql.Add(' and categoria_el = :categoria ' );
    end;
    if sProveedor <> '' then
    begin
      Sql.Add(' and proveedor_ec = :proveedor ' );
    end;
    Sql.Add(' group by 1 ');
    Sql.Add(' order by 1 ');

    if ( AEmpresa <> '' ) and ( AEmpresa<> 'BAG' ) then
    begin
      ParamByName('empresa').AsString:= AEmpresa;
    end;
    ParamByName('producto').AsString:= AProducto;
    if sCategoria <> '' then
    begin
      ParamByName('categoria').AsString:= sCategoria;
    end;
    if sProveedor <> '' then
    begin
      ParamByName('proveedor').AsString:= sProveedor;
    end;
    if AEntrega <> '' then
    begin
      ParamByName('entrega').AsString:= AEntrega;
    end
    else
    begin
      ParamByName('semana').AsString:= ASemana;
    end;

    Open;
    if not isEmpty then
    begin

      if kmtKilos.Active then
        kmtKilos.Close;
      kmtKilos.Open;

      while Not Eof do
      begin
        strEmpresa:= FieldByName('empresa').AsString;
        AnyadirKilos;
        Next;
      end;
      Close;

      try
        kmtKilos.SortFields:='empresa;producto;categoria;proveedor;productor;entrega';
        kmtKilos.Sort([]);
        LiquidaKilosQL.PrevisualizarKilos( AEmpresa, AProducto, ACategoria, ASemana, AEntrega, APorCategoria, AVerEntregas );
      finally
        kmtKilos.Close;
      end;
    end;
  end;

(*
  select empresa_pp, codigo_ean_pp, envase_e
from frf_productos_proveedor, frf_ean13
where empresa_pp = 'F42'
and variedad_pp = 49
and  empresa_pp = empresa_e
and codigo_ean_pp = codigo_e
*)

  (*
select empresa_ec, proveedor, proveedor_almacen cosechero,
       ( select nombre_pa from frf_proveedores_almacen
         where empresa_pa = empresa_ec
           and proveedor_pa = proveedor
           and almacen_pa = proveedor_almacen ) nom_cosechero,
       codigo_ec, sum(cajas) cajas, sum(peso) kilos

from frf_entregas_c,rf_palet_pb
where anyo_Semana_ec = '201420'
and producto_ec = 'P'
and empresa_ec <> 'F18'
and codigo_Ec = entrega
group by 1,2,3,4,5
order by 1,2,3,5
  *)

end;

end.
