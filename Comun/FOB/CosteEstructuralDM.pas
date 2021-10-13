unit CosteEstructuralDM;

interface

uses
  SysUtils, Classes, DB, DBClient, DBTables;

type
  TDMCosteEstructural = class(TDataModule)
    qryCostes: TQuery;
    cdsCostesEstructurales: TClientDataSet;
    strngfldCostesEstructuralesempresa: TStringField;
    strngfldCostesEstructuralescentro: TStringField;
    fltfldCostesEstructuralescomercial: TFloatField;
    fltfldCostesEstructuralesproduccion: TFloatField;
    fltfldCostesEstructuralesadministracion: TFloatField;
    fltfldCostesEstructuralesestructura: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsCostesEstructuralesBeforePost(DataSet: TDataSet);
  private
    { Private declarations }

    procedure PutCosteEstructura( const AEmpresa, ACentro: string );
    procedure GuardarCostes(const  AEmpresa, ACentro: string );
  public
    { Public declarations }
    function GetCosteEstructura( const AEmpresa, ACentro: string ): real;
  end;


  procedure InicializaModulo;
  procedure FinalizaModulo;
  function GetCosteEstructura( const AEmpresa, ACentro: string ): real;


implementation

{$R *.dfm}

uses
  Forms, CGlobal, Math, Variants;

var
  DMCosteEstructural: TDMCosteEstructural;
  bFlag: boolean = false;


function GetCosteEstructura( const AEmpresa, ACentro: string ): real;
begin
  if bFlag then
  begin
    result:=  DMCosteEstructural.GetCosteEstructura( AEmpresa, ACentro );
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
    Application.CreateForm( TDMCosteEstructural, DMCosteEstructural) ;
    bFlag:= True;
  end;
end;

procedure FinalizaModulo;
begin
  if bFlag then
  begin
    FreeAndNil( DMCosteEstructural );
    bFlag:= False;
  end;
end;


procedure TDMCosteEstructural.DataModuleCreate(Sender: TObject);
begin
  //cdsCostesEstructurales.CreateDataSet;

  with qryCostes do
  begin
    Sql.Clear;
    //sql.add('select empresa_ci, centro_origen_ci, fecha_ini_ci, fecha_fin_ci, comercial_ci, produccion_ci, administracion_ci ');
    sql.add('select comercial_ci, produccion_ci, administracion_ci ');
    sql.add('from frf_costes_indirectos ');
    sql.add('where empresa_ci = :empresa ');
    sql.add('and centro_origen_ci = :centro ');
    //sql.add('and '1/1/2012' between fecha_ini_ci and nvl(fecha_fin_ci,today) ');
    sql.add('and fecha_fin_ci is null ');
  end;
end;

procedure TDMCosteEstructural.DataModuleDestroy(Sender: TObject);
begin
  cdsCostesEstructurales.close;
end;

function TDMCosteEstructural.GetCosteEstructura( const AEmpresa, ACentro: string ): real;
begin
  if not cdsCostesEstructurales.Locate('empresa;centro',vararrayof([AEmpresa, ACentro]),[] ) then
  begin
    PutCosteEstructura( AEmpresa, ACentro );
  end;
  result:= fltfldCostesEstructuralesestructura.AsFloat;
end;


procedure TDMCosteEstructural.PutCosteEstructura( const AEmpresa, ACentro: string );
var
  dFecha: TDateTime;
begin
  with qryCostes do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;

    Open;
    if not isEmpty then
    begin
      GuardarCostes( AEmpresa, ACentro );
    end
    else
    begin
      raise Exception.Create('No existe el coste de estructura para la planta ' + QuotedStr(Aempresa) + ' centro ' + QuotedStr(ACentro) + '.');
    end;
    Close;
  end;
end;


procedure TDMCosteEstructural.GuardarCostes(const  AEmpresa, ACentro: string );
begin
  cdsCostesEstructurales.Insert;
  cdsCostesEstructurales.FieldByName('empresa').AsString:= AEmpresa;
  cdsCostesEstructurales.FieldByName('centro').AsString:= ACentro;

  fltfldCostesEstructuralescomercial.AsFloat:= qryCostes.FieldByName('comercial_ci').AsFloat;
  fltfldCostesEstructuralesproduccion.AsFloat:= qryCostes.FieldByName('produccion_ci').AsFloat;
  fltfldCostesEstructuralesadministracion.AsFloat:= qryCostes.FieldByName('administracion_ci').AsFloat;
  cdsCostesEstructurales.Post;
end;

procedure TDMCosteEstructural.cdsCostesEstructuralesBeforePost(
  DataSet: TDataSet);
begin
  fltfldCostesEstructuralesestructura.AsFloat:= fltfldCostesEstructuralescomercial.AsFloat +
                                             fltfldCostesEstructuralesproduccion.AsFloat +
                                             fltfldCostesEstructuralesadministracion.AsFloat;
end;

end.
