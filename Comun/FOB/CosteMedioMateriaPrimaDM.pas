unit CosteMedioMateriaPrimaDM;

interface

uses
  SysUtils, Classes, DB, DBClient, DBTables;

type
  TDMCosteMedioMateriaPrima = class(TDataModule)
    cdsCosteMedioMateriaPrima: TClientDataSet;
    strngfldCosteMedioCompraempresa: TStringField;
    strngfldCosteMedioCompraproducto: TStringField;
    dtfldCosteMedioComprafecha_ini: TDateField;
    dtfldCosteMedioComprafecha_fin: TDateField;
    intgrfldCosteMedioComprakilos: TIntegerField;
    fltfldCosteMedioCompraimporte: TFloatField;
    fltfldCosteMedioCompragastos: TFloatField;
    fltfldCosteMedioCompraprecio: TFloatField;
    qryEntregas: TQuery;
    qryGastos: TQuery;
    qryFechaIni: TQuery;
    qryCampoOrigen: TQuery;
    qryCosteCampo: TQuery;
    strngfldCosteMedioMateriaPrimacentro: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    bSat: boolean;
    iKilos: integer;
    rImporte, rGastos: Real;
    dFechaIni: TDateTime;
    sCodigoMateriaPrima: string;

    procedure ConfiguarBDQuerys( const AEmpresa: string );

    procedure PutCosteCampo( const AEmpresa, ACentro, AProducto: string );
    function  GetCosteCampo( const AEmpresa, ACentro, AProducto: string ): real;
    procedure AltaProductoCampo(const  AEmpresa, ACentro, AProducto: string; const ACoste: real );

    procedure PutCosteCompra( const AEmpresa, ACentro, AProducto: string );
    function  GetFechaUltimaCompra( const AEmpresa, AProducto: string; var VFecha: TDateTime ): Boolean;
    procedure AltaProductoSinCompra(const  AEmpresa, ACentro, AProducto: string );
    procedure AltaProductoConCompra(const  AEmpresa, ACentro, AProducto: string; const AFecha: TDateTime );
    procedure InicializaAcumulados(  const AFecha: TDateTime );
    procedure Acumulados;
    procedure GuardarAcumulados(const  AEmpresa, ACentro, AProducto: string; const AFecha: TDateTime );
  public
    { Public declarations }

    function GetCosteMateriaPrima( const AEmpresa, ACentro, AProducto, ACategoria: string ): real;
  end;


  procedure InicializaModulo;
  procedure FinalizaModulo;
  function GetCosteMedioMateriaPrima( const AEmpresa, ACEntro, AProducto, ACategoria: string ): real;


implementation

{$R *.dfm}

uses
  Forms, CGlobal, Math, Variants, Dialogs;

var
  DMCosteMedioMateriaPrima: TDMCosteMedioMateriaPrima;
  bFlag: boolean = false;


function GetCosteMedioMateriaPrima( const AEmpresa, ACentro, AProducto, ACategoria: string ): real;
begin
  if bFlag then
  begin
    result:=  DMCosteMedioMateriaPrima.GetCosteMateriaPrima( AEmpresa, ACentro, AProducto, ACategoria );
  end
  else
  begin
    Raise Exception.Create('Modulo para el cálculo del precio medio de compra de la fruta no inicializado.');
  end;
end;

procedure InicializaModulo;
begin
  if not bFlag then
  begin
    Application.CreateForm( TDMCosteMedioMateriaPrima, DMCosteMedioMateriaPrima) ;
    bFlag:= True;
  end;
end;

procedure FinalizaModulo;
begin
  if bFlag then
  begin
    FreeAndNil( DMCosteMedioMateriaPrima );
    bFlag:= False;
  end;
end;


procedure TDMCosteMedioMateriaPrima.DataModuleCreate(Sender: TObject);
begin
  cdsCosteMedioMateriaPrima.CreateDataSet;

  with qryEntregas do
  begin
    Sql.Clear;
    sql.add('select codigo_ec, fecha_llegada_ec, sum(kilos_el) kilos ');
    sql.add('from frf_entregas_c ');
    sql.add('     join frf_entregas_l on codigo_ec = codigo_el ');
    sql.add('where empresa_ec = :empresa ');
    sql.add('  and producto_ec = :producto ');
    sql.add('  and fecha_llegada_ec between :fechaini and :fechafin ');
    sql.add('  and exists ');
    sql.add('  ( select * from frf_gastos_entregas where codigo_ec = codigo_ge and tipo_ge = :materiaprima) ');
    sql.add('group by codigo_ec, fecha_llegada_ec ');
  end;

  with qryFechaIni do
  begin
    Sql.Clear;
    sql.add('select max(fecha_llegada_ec) fecha, count(*) compras ');
    sql.add('from frf_entregas_c ');
    sql.add('     join frf_entregas_l on codigo_ec = codigo_el ');
    sql.add('where empresa_ec = :empresa ');
    sql.add('  and producto_ec = :producto ');
    sql.add('  and exists ');
    sql.add('  ( select * from frf_gastos_entregas where codigo_ec = codigo_ge and tipo_ge = :materiaprima ) ');
  end;

  qryGastos.Sql.Clear;
  qryGastos.sql.add('select sum(importe_ge) importe ');
  qryGastos.sql.add('from frf_gastos_entregas ');
  qryGastos.sql.add('where codigo_ge = :codigo ');

  qryCampoOrigen.Sql.Clear;
  qryCampoOrigen.sql.add(' select case when substr(cod_postal_c,1,2) = ''38'' then 0 else 1 end peninsula ');
  qryCampoOrigen.sql.add(' from frf_centros ');
  qryCampoOrigen.sql.add(' where empresa_c = :empresa and centro_c = :centro ');
  qryCampoOrigen.sql.add(' order by peninsula ');

  qryCosteCampo.Sql.Clear;
  qryCosteCampo.sql.add(' select coste_peninsula_p, coste_tenerife_p ');
  qryCosteCampo.sql.add(' from frf_productos ');
  qryCosteCampo.sql.add(' where producto_p = :producto ');

end;

procedure TDMCosteMedioMateriaPrima.DataModuleDestroy(Sender: TObject);
begin
  cdsCosteMedioMateriaPrima.close;
end;

function TDMCosteMedioMateriaPrima.GetCosteMateriaPrima( const AEmpresa, ACentro, AProducto, ACategoria: string ): real;
begin
  bSat:= not ( ( AEmpresa <> '050' ) and ( AEmpresa <> '080') );
  if not cdsCosteMedioMateriaPrima.Locate('empresa;centro;producto',vararrayof([AEmpresa, ACentro, AProducto]),[] ) then
  begin
    ConfiguarBDQuerys( AEmpresa );
    if bSat then
    begin
      //Coste campo
      if ( ACategoria = '1' ) or ( ACategoria = '2' ) then
        PutCosteCampo( AEmpresa, ACentro, AProducto );
    end
    else
    begin
      //Coste compra
      PutCosteCompra( AEmpresa, ACentro, AProducto );
    end;
  end;
  if bSat and  not ( ( ACategoria = '1' ) or ( ACategoria = '2' ) ) then
  begin
    result:= 0;
  end
  else
  begin
    result:= cdsCosteMedioMateriaPrima.FieldByName('precio').AsFloat;
  end;
end;

procedure TDMCosteMedioMateriaPrima.ConfiguarBDQuerys( const AEmpresa: string );
begin
  if CGlobal.gProgramVersion = CGlobal.pvSAT then
  begin
    if ( AEmpresa <> '050' ) and ( AEmpresa <> '080') then
    begin
      qryFechaIni.DatabaseName:= 'dbBAG';
      qryEntregas.DatabaseName:= 'dbBAG';
      qryGastos.DatabaseName:= 'dbBAG';
      sCodigoMateriaPrima:= '010';
      qryCampoOrigen.DatabaseName:= 'dbBAG';
      qryCosteCampo.DatabaseName:= 'dbBAG';
      //bSat:= False;
    end
    else
    begin
      qryFechaIni.DatabaseName:= 'BDProyecto';
      qryEntregas.DatabaseName:= 'BDProyecto';
      qryGastos.DatabaseName:= 'BDProyecto';
      sCodigoMateriaPrima:= '110';
      qryCampoOrigen.DatabaseName:= 'BDProyecto';
      qryCosteCampo.DatabaseName:= 'BDProyecto';
      //bSat:= True;
    end;
  end
  else
  begin
    if ( AEmpresa <> '050' ) and ( AEmpresa <> '080') then
    begin
      qryFechaIni.DatabaseName:= 'BDProyecto';
      qryEntregas.DatabaseName:= 'BDProyecto';
      qryGastos.DatabaseName:= 'BDProyecto';
      sCodigoMateriaPrima:= '010';
      qryCampoOrigen.DatabaseName:= 'BDProyecto';
      qryCosteCampo.DatabaseName:= 'BDProyecto';
      //bSat:= False;
    end
    else
    begin
      qryFechaIni.DatabaseName:= 'dbSAT';
      qryEntregas.DatabaseName:= 'dbSAT';
      qryGastos.DatabaseName:= 'dbSAT';
      sCodigoMateriaPrima:= '110';
      qryCampoOrigen.DatabaseName:= 'dbSAT';
      qryCosteCampo.DatabaseName:= 'dbSAT';
      //bSat:= True;
    end;
  end;
end;

procedure  TDMCosteMedioMateriaPrima.PutCosteCampo( const AEmpresa, ACentro, AProducto: string );
var
  rCoste: real;
begin
  rCoste:= GetCosteCampo( AEmpresa, ACentro, AProducto );
  AltaProductoCampo( AEmpresa, ACentro, AProducto, rCoste );
end;

function TDMCosteMedioMateriaPrima.GetCosteCampo( const AEmpresa, ACentro, AProducto: string ): real;
begin
  qryCampoOrigen.ParamByName('empresa').AsString:= AEmpresa;
  qryCampoOrigen.ParamByName('centro').AsString:= ACentro;
  qryCampoOrigen.Open;
  if not qryCampoOrigen.IsEmpty then
  begin
    qryCosteCampo.ParamByName('producto').AsString:= AProducto;
    qryCosteCampo.Open;
    if not qryCosteCampo.IsEmpty then
    begin
      if qryCampoOrigen.FieldByName('peninsula').AsInteger = 1 then
        result:= qryCosteCampo.FieldByName('coste_peninsula_p').AsFloat
      else
        result:= qryCosteCampo.FieldByName('coste_tenerife_p').AsFloat;
    end
    else
    begin
      result:= 0;
    end;
    qryCosteCampo.Close;
  end
  else
  begin
    result:= 0;
  end;
  qryCampoOrigen.Close;
end;

procedure TDMCosteMedioMateriaPrima.AltaProductoCampo(const  AEmpresa, ACentro, AProducto: string; const ACoste: real );
begin
  cdsCosteMedioMateriaPrima.Insert;
  cdsCosteMedioMateriaPrima.FieldByName('empresa').AsString:= AEmpresa;
  cdsCosteMedioMateriaPrima.FieldByName('centro').AsString:= ACentro;
  cdsCosteMedioMateriaPrima.FieldByName('producto').AsString:= AProducto;
  //dtfldCosteMedioComprafecha_ini: TDateField;
  //dtfldCosteMedioComprafecha_fin: TDateField;
  cdsCosteMedioMateriaPrima.FieldByName('kilos').AsInteger:= 1;
  cdsCosteMedioMateriaPrima.FieldByName('importe').AsFloat:= ACoste;
  cdsCosteMedioMateriaPrima.FieldByName('gastos').AsFloat:= 0;
  cdsCosteMedioMateriaPrima.FieldByName('precio').AsFloat:= ACoste;
  cdsCosteMedioMateriaPrima.Post;
end;

procedure TDMCosteMedioMateriaPrima.PutCosteCompra( const AEmpresa, ACentro, AProducto: string );
var
  dFecha: TDateTime;
begin
  if GetFechaUltimaCompra( AEmpresa, AProducto, dFecha ) then
  begin
    AltaProductoConCompra( AEmpresa, ACentro, AProducto, dFecha );
  end
  else
  begin
    AltaProductoSinCompra( AEmpresa, ACentro, AProducto );
  end
end;

function  TDMCosteMedioMateriaPrima.GetFechaUltimaCompra( const AEmpresa, AProducto: string; var VFecha: TDateTime ): Boolean;
begin
  //with qryFechaIni do
  begin
    qryFechaIni.ParamByName('empresa').AsString:= AEmpresa;
    qryFechaIni.ParamByName('producto').AsString:= AProducto;
    qryFechaIni.ParamByName('materiaprima').AsString:= sCodigoMateriaPrima;

    qryFechaIni.Open;
    //qryFechaIni.SQl.SaveToFile('c:\temp\pepe.sql');
    //ShowMessage(qryFechaIni.DataBaseName + ' ' + AEmpresa + ' '  +  AProducto + ' ' + qryFechaIni.ParamByName('materiaprima').AsString +  ' ' +
    //            qryFechaIni.FieldByName('compras').AsString +  ' ' + qryFechaIni.FieldByName('fecha').AsString );
    if qryFechaIni.FieldByName('compras').AsInteger > 0  then
    begin
      VFecha:= qryFechaIni.FieldByName('fecha').AsDateTime;
      result:= True;
    end
    else
    begin
      result:= False;
    end;
    qryFechaIni.Close;
  end;
end;

procedure TDMCosteMedioMateriaPrima.AltaProductoSinCompra(const  AEmpresa, ACentro, AProducto: string );
begin
  cdsCosteMedioMateriaPrima.Insert;
  cdsCosteMedioMateriaPrima.FieldByName('empresa').AsString:= AEmpresa;
  cdsCosteMedioMateriaPrima.FieldByName('centro').AsString:= ACentro;
  cdsCosteMedioMateriaPrima.FieldByName('producto').AsString:= AProducto;
  //dtfldCosteMedioComprafecha_ini: TDateField;
  //dtfldCosteMedioComprafecha_fin: TDateField;
  cdsCosteMedioMateriaPrima.FieldByName('kilos').AsInteger:= 0;
  cdsCosteMedioMateriaPrima.FieldByName('importe').AsFloat:= 0;
  cdsCosteMedioMateriaPrima.FieldByName('gastos').AsFloat:= 0;
  cdsCosteMedioMateriaPrima.FieldByName('precio').AsFloat:= 0;
  cdsCosteMedioMateriaPrima.Post;
end;

procedure TDMCosteMedioMateriaPrima.AltaProductoConCompra(const  AEmpresa, ACentro, AProducto: string; const AFecha: TDateTime );
var
  dAux: TDateTime;
begin
  with qryEntregas do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('materiaprima').AsString:= sCodigoMateriaPrima;
    ParamByName('fechafin').AsdateTime:= AFecha;
    dAux:= IncMonth( AFEcha, -3 );
    ParamByName('fechaini').AsdateTime:= dAux;

    Open;
    InicializaAcumulados( AFecha );
    while not Eof do
    begin
      Acumulados;
      Next;
    end;
    Close;
    GuardarAcumulados( AEmpresa, ACentro, AProducto, AFecha );
  end;
end;


procedure TDMCosteMedioMateriaPrima.InicializaAcumulados( const AFecha: TDateTime );
begin
  iKilos:= 0;
  rImporte:= 0;
  rGastos:= 0;
  dFechaIni:= AFecha;
end;

procedure TDMCosteMedioMateriaPrima.Acumulados;
begin
  qryGastos.ParamByName('codigo').AsString:= qryEntregas.FieldByName('codigo_ec').AsString;
  qryGastos.Open;

  iKilos:= iKilos + qryEntregas.FieldByname('kilos').AsInteger;
  rImporte:= rImporte + qryGastos.FieldByname('importe').AsInteger;
  rGastos:= 0;
  if qryEntregas.FieldByname('fecha_llegada_ec').AsDateTime < dFechaIni then
    dFechaIni:= qryEntregas.FieldByname('fecha_llegada_ec').AsDateTime;

  qryGastos.Close;
end;

procedure TDMCosteMedioMateriaPrima.GuardarAcumulados(const  AEmpresa, ACentro, AProducto: string; const AFecha: TDateTime );
begin
  cdsCosteMedioMateriaPrima.Insert;
  cdsCosteMedioMateriaPrima.FieldByName('empresa').AsString:= AEmpresa;
  cdsCosteMedioMateriaPrima.FieldByName('centro').AsString:= ACentro;
  cdsCosteMedioMateriaPrima.FieldByName('producto').AsString:= AProducto;

  dtfldCosteMedioComprafecha_ini.asDateTime:= dFechaIni;
  dtfldCosteMedioComprafecha_fin.asDateTime:= AFecha;

  cdsCosteMedioMateriaPrima.FieldByName('kilos').AsInteger:= iKilos;
  cdsCosteMedioMateriaPrima.FieldByName('importe').AsFloat:= rImporte;
  cdsCosteMedioMateriaPrima.FieldByName('gastos').AsFloat:= rGastos;
  if iKilos > 0 then
    cdsCosteMedioMateriaPrima.FieldByName('precio').AsFloat:= roundTo( ( rImporte + rGastos ) / iKilos, -4 )
  else
    cdsCosteMedioMateriaPrima.FieldByName('precio').AsFloat:= 0;
  cdsCosteMedioMateriaPrima.Post;
end;

end.
