unit EnvasesSinCosteEnvasadoData;

interface

uses
  SysUtils, Classes, DB, kbmMemTable;

type
  TDMEnvasesSinCosteEnvasado = class(TDataModule)
    kmtCostesEnvasado: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    function PreparaQuery(const AEmpresa, ACentro, AAnyo, AMes: string ): Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  UDMbaseDatos, bSQLUtils;

procedure TDMEnvasesSinCosteEnvasado.DataModuleCreate(Sender: TObject);
begin
  with kmtCostesEnvasado do
  begin
    FieldDefs.Clear;

    FieldDefs.Add('empresa', ftString, 3, False);
    FieldDefs.Add('centro', ftString, 1, False);
    FieldDefs.Add('producto', ftString, 3, False);
    FieldDefs.Add('agrupacion', ftString, 20, False);
    FieldDefs.Add('envase', ftString, 9, False);

    FieldDefs.Add('des_centro', ftString, 30, False);
    FieldDefs.Add('des_producto', ftString, 30, False);
    FieldDefs.Add('des_envase', ftString, 30, False);

    FieldDefs.Add('envase01', ftFloat, 0, False);
    FieldDefs.Add('envase02', ftFloat, 0, False);
    FieldDefs.Add('envase03', ftFloat, 0, False);
    FieldDefs.Add('envase04', ftFloat, 0, False);
    FieldDefs.Add('envase05', ftFloat, 0, False);
    FieldDefs.Add('envase06', ftFloat, 0, False);
    FieldDefs.Add('envase07', ftFloat, 0, False);
    FieldDefs.Add('envase08', ftFloat, 0, False);
    FieldDefs.Add('envase09', ftFloat, 0, False);
    FieldDefs.Add('envase10', ftFloat, 0, False);
    FieldDefs.Add('envase11', ftFloat, 0, False);
    FieldDefs.Add('envase12', ftFloat, 0, False);
    FieldDefs.Add('meses_envase', ftInteger, 0, False);
    FieldDefs.Add('media_envase', ftFloat, 0, False);

    FieldDefs.Add('seccion01', ftFloat, 0, False);
    FieldDefs.Add('seccion02', ftFloat, 0, False);
    FieldDefs.Add('seccion03', ftFloat, 0, False);
    FieldDefs.Add('seccion04', ftFloat, 0, False);
    FieldDefs.Add('seccion05', ftFloat, 0, False);
    FieldDefs.Add('seccion06', ftFloat, 0, False);
    FieldDefs.Add('seccion07', ftFloat, 0, False);
    FieldDefs.Add('seccion08', ftFloat, 0, False);
    FieldDefs.Add('seccion09', ftFloat, 0, False);
    FieldDefs.Add('seccion10', ftFloat, 0, False);
    FieldDefs.Add('seccion11', ftFloat, 0, False);
    FieldDefs.Add('seccion12', ftFloat, 0, False);
    FieldDefs.Add('meses_seccion', ftInteger, 0, False);
    FieldDefs.Add('media_seccion', ftFloat, 0, False);

    FieldDefs.Add('meses_total', ftInteger, 0, False);
    FieldDefs.Add('media_total', ftFloat, 0, False);

    IndexFieldNames:= 'empresa;centro;producto;envase';
    CreateTable;
    //Open;
  end;
end;

procedure TDMEnvasesSinCosteEnvasado.DataModuleDestroy(Sender: TObject);
begin
  //kmtCostesEnvasado.Close;
end;


function TDMEnvasesSinCosteEnvasado.PreparaQuery(const AEmpresa, ACentro, AAnyo, AMes: string ): Boolean;
begin
  with DMBaseDatos.QListado do
  begin
    SQL.Clear;
    SQL.Add(' select distinct producto_p, envase_sl, ');
    SQL.Add('        (select material_ec ');
    SQL.Add('         from frf_env_costes ');
    SQL.Add('         where anyo_ec ' + SQLEqualN(AAnyo));
    SQL.Add('         and mes_ec ' + SQLEqualN(AMes));
    SQL.Add('         and empresa_ec ' + SQLEqualS(AEmpresa));
    SQL.Add('         and centro_ec ' + SQLEqualS(ACentro));
    SQL.Add('         and producto_ec = producto_p ');
    SQL.Add('         and envase_ec = envase_sl) material, ');
    SQL.Add('        (select personal_ec ');
    SQL.Add('         from frf_env_costes ');
    SQL.Add('         where anyo_ec ' + SQLEqualN(AAnyo));
    SQL.Add('         and mes_ec ' + SQLEqualN(AMes));
    SQL.Add('         and empresa_ec ' + SQLEqualS(AEmpresa));
    SQL.Add('         and centro_ec ' + SQLEqualS(ACentro));
    SQL.Add('         and producto_ec = producto_p ');
    SQL.Add('         and envase_ec = envase_sl) personal, ');
    SQL.Add('        (select general_ec ');
    SQL.Add('         from frf_env_costes ');
    SQL.Add('         where anyo_ec ' + SQLEqualN(AAnyo));
    SQL.Add('         and mes_ec ' + SQLEqualN(AMes));
    SQL.Add('         and empresa_ec ' + SQLEqualS(AEmpresa));
    SQL.Add('         and centro_ec ' + SQLEqualS(ACentro));
    SQL.Add('         and producto_ec = producto_p ');
    SQL.Add('         and envase_ec = envase_sl) general ');
    SQL.Add(' from   frf_salidas_l, frf_productos ');
    SQL.Add(' where empresa_sl ' + SQLEqualS(AEmpresa));
    SQL.Add(' and centro_origen_sl ' + SQLEqualS(ACentro));
    SQL.Add(' and YEAR(fecha_sl) ' + SQLEqualN(AAnyo));
    SQL.Add(' and MONTH(fecha_sl) ' + SQLEqualN(AMes));
    SQL.Add(' and producto_p = producto_sl ');
    SQL.Add(' order by 1,2,3 ');

    Open;
    result := not IsEmpty;
    if not Result then Close
  end;
end;

end.
