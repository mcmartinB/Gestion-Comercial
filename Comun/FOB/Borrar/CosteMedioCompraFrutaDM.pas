unit CosteMedioCompraFrutaDM;

interface

uses
  SysUtils, Classes, DB, DBClient, DBTables;

type
  TDMCosteMedioCompraFruta = class(TDataModule)
    cdsCosteMedioCompra: TClientDataSet;
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
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    iKilos: integer;
    rImporte, rGastos: Real;
    dFechaIni: TDateTime;
    sCodigoMateriaPrima: string;

    procedure PutCosteMedio( const AEmpresa, AProducto: string );
    function  GetFechaUltimaCompra( const AEmpresa, AProducto: string; var VFecha: TDateTime ): Boolean;
    procedure AltaProductoSinCompra(const  AEmpresa, AProducto: string );
    procedure AltaProductoConCompra(const  AEmpresa, AProducto: string; const AFecha: TDateTime );
    procedure InicializaAcumulados(  const AFecha: TDateTime );
    procedure Acumulados;
    procedure GuardarAcumulados(const  AEmpresa, AProducto: string; const AFecha: TDateTime );
  public
    { Public declarations }

    function GetCosteMedio( const AEmpresa, AProducto: string ): real;
  end;


  procedure InicializaModulo;
  procedure FinalizaModulo;
  function GetCosteMedio( const AEmpresa, AProducto: string ): real;


implementation

{$R *.dfm}

uses
  Forms, CGlobal, Math, Variants, Dialogs;

var
  DMCosteMedioCompraFruta: TDMCosteMedioCompraFruta;
  bFlag: boolean = false;


function GetCosteMedio( const AEmpresa, AProducto: string ): real;
begin
  if bFlag then
  begin
    result:=  DMCosteMedioCompraFruta.GetCosteMedio( AEmpresa, AProducto );
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
    Application.CreateForm( TDMCosteMedioCompraFruta, DMCosteMedioCompraFruta) ;
    bFlag:= True;
  end;
end;

procedure FinalizaModulo;
begin
  if bFlag then
  begin
    FreeAndNil( DMCosteMedioCompraFruta );
    bFlag:= False;
  end;
end;


procedure TDMCosteMedioCompraFruta.DataModuleCreate(Sender: TObject);
begin
  cdsCosteMedioCompra.CreateDataSet;

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
end;

procedure TDMCosteMedioCompraFruta.DataModuleDestroy(Sender: TObject);
begin
  cdsCosteMedioCompra.close;
end;

function TDMCosteMedioCompraFruta.GetCosteMedio( const AEmpresa, AProducto: string ): real;
begin
  if not cdsCosteMedioCompra.Locate('empresa;producto',vararrayof([AEmpresa, AProducto]),[] ) then
  begin
    PutCosteMedio( AEmpresa, AProducto );
  end;
  result:= cdsCosteMedioCompra.FieldByName('precio').AsFloat;
end;

procedure TDMCosteMedioCompraFruta.PutCosteMedio( const AEmpresa, AProducto: string );
var
  dFecha: TDateTime;
begin
  if CGlobal.gProgramVersion = CGlobal.pvSAT then
  begin
    if ( AEmpresa <> '050' ) and ( AEmpresa <> '080') then
    begin
      qryFechaIni.DatabaseName:= 'dbBAG';
      qryEntregas.DatabaseName:= 'dbBAG';
      qryGastos.DatabaseName:= 'dbBAG';
      sCodigoMateriaPrima:= '010';
    end
    else
    begin
      qryFechaIni.DatabaseName:= 'BDProyecto';
      qryEntregas.DatabaseName:= 'BDProyecto';
      qryGastos.DatabaseName:= 'BDProyecto';
      sCodigoMateriaPrima:= '110';
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
    end
    else
    begin
      qryFechaIni.DatabaseName:= 'dbSAT';
      qryEntregas.DatabaseName:= 'dbSAT';
      qryGastos.DatabaseName:= 'dbSAT';
      sCodigoMateriaPrima:= '110';
    end;
  end;

  if GetFechaUltimaCompra( AEmpresa, AProducto, dFecha ) then
  begin
    AltaProductoConCompra( AEmpresa, AProducto, dFecha );
  end
  else
  begin
    AltaProductoSinCompra( AEmpresa, AProducto );
  end
end;

function  TDMCosteMedioCompraFruta.GetFechaUltimaCompra( const AEmpresa, AProducto: string; var VFecha: TDateTime ): Boolean;
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

procedure TDMCosteMedioCompraFruta.AltaProductoSinCompra(const  AEmpresa, AProducto: string );
begin
  cdsCosteMedioCompra.Insert;
  cdsCosteMedioCompra.FieldByName('empresa').AsString:= AEmpresa;
  cdsCosteMedioCompra.FieldByName('producto').AsString:= AProducto;
  //dtfldCosteMedioComprafecha_ini: TDateField;
  //dtfldCosteMedioComprafecha_fin: TDateField;
  cdsCosteMedioCompra.FieldByName('kilos').AsInteger:= 0;
  cdsCosteMedioCompra.FieldByName('importe').AsFloat:= 0;
  cdsCosteMedioCompra.FieldByName('gastos').AsFloat:= 0;
  cdsCosteMedioCompra.FieldByName('precio').AsFloat:= 0;
  cdsCosteMedioCompra.Post;
end;

procedure TDMCosteMedioCompraFruta.AltaProductoConCompra(const  AEmpresa, AProducto: string; const AFecha: TDateTime );
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
    GuardarAcumulados( AEmpresa, AProducto, AFecha );
  end;
end;


procedure TDMCosteMedioCompraFruta.InicializaAcumulados( const AFecha: TDateTime );
begin
  iKilos:= 0;
  rImporte:= 0;
  rGastos:= 0;
  dFechaIni:= AFecha;
end;

procedure TDMCosteMedioCompraFruta.Acumulados;
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

procedure TDMCosteMedioCompraFruta.GuardarAcumulados(const  AEmpresa, AProducto: string; const AFecha: TDateTime );
begin
  cdsCosteMedioCompra.Insert;
  cdsCosteMedioCompra.FieldByName('empresa').AsString:= AEmpresa;
  cdsCosteMedioCompra.FieldByName('producto').AsString:= AProducto;

  dtfldCosteMedioComprafecha_ini.asDateTime:= dFechaIni;
  dtfldCosteMedioComprafecha_fin.asDateTime:= AFecha;

  cdsCosteMedioCompra.FieldByName('kilos').AsInteger:= iKilos;
  cdsCosteMedioCompra.FieldByName('importe').AsFloat:= rImporte;
  cdsCosteMedioCompra.FieldByName('gastos').AsFloat:= rGastos;
  if iKilos > 0 then
    cdsCosteMedioCompra.FieldByName('precio').AsFloat:= roundTo( ( rImporte + rGastos ) / iKilos, -4 )
  else
    cdsCosteMedioCompra.FieldByName('precio').AsFloat:= 0;
  cdsCosteMedioCompra.Post;
end;

end.
