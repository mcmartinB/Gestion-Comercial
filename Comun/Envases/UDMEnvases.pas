unit UDMEnvases;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMEnvases = class(TDataModule)
    QPesoEnvase: TQuery;
    QPesoPalet: TQuery;
  private
    { Private declarations }
  public
    { Public declarations }


    function GetPesoEnvase(const AEmpresa, AEnvase: string; const AFecha: TDateTime): Extended;
    function GetPesoPalet(const APalet: string): Extended;
  end;

  procedure CreateDMEnvase( AOwner: TComponent );
  procedure DestroyDMEnvase;

var
  DMEnvases: TDMEnvases;

implementation

{$R *.dfm}

var
  i: integer = 0;

procedure CreateDMEnvase( AOwner: TComponent );
begin
  if i = 0 then
    DMEnvases:= TDMEnvases.Create( AOwner );
  inc( i );
end;

procedure DestroyDMEnvase;
begin
  Dec( i );
  if i = 0 then
    FreeAndNil( DMEnvases );
end;



function TDMEnvases.GetPesoEnvase(const AEmpresa, AEnvase: string; const AFecha: TDateTime ): Extended;
var peso, unidades, pesounidad, pesoenvase: Extended;
begin
  if ( AEmpresa = '080' ) and ( AEnvase = '885' ) and ( AFecha <= strToDate('13/3/2017') ) then
  begin
    result:= 0.71;
  end
  else
  if ( AEmpresa = '080' ) and ( AEnvase = '886' ) and ( AFecha <= strToDate('9/4/2017') ) then
  begin
    result:= 0.65;
  end
  else
  begin
    with QPesoEnvase.SQL do
    begin
      Clear;
      Add(' SELECT DISTINCT unidades_e, peso_envase_e, 0 peso_envase_uc');     //peso_envase_uc ');   // Quitar unidades de consumo al unificar 050 y 080
      Add(' FROM frf_envases, OUTER frf_und_consumo ');
      Add(' WHERE envase_e = :envase ');
      Add('    AND empresa_uc = :empresa ');
      Add('    AND codigo_uc = tipo_unidad_e ');

    end;

    peso := 0;
    QPesoEnvase.ParamByName('envase').AsString := AEnvase;
    QPesoEnvase.ParamByName('empresa').AsString := AEmpresa;
    if not QPesoEnvase.Active then
      QPesoEnvase.Open;

    QPesoEnvase.First;
    if (QPesoEnvase.FieldByName('unidades_e').AsString = '') then
      unidades := 0
    else unidades := QPesoEnvase.FieldByName('unidades_e').AsFloat;

    if (QPesoEnvase.FieldByName('peso_envase_uc').AsString = '') then
      pesounidad := 0
    else pesounidad := QPesoEnvase.FieldByName('peso_envase_uc').AsFloat;

    if (QPesoEnvase.FieldByName('peso_envase_e').AsString <> '') then
      pesoenvase := QPesoEnvase.FieldByName('peso_envase_e').AsFloat
    else pesoenvase := 0;

    if (unidades > 1) and (pesounidad > 0) then
      peso := peso + unidades * pesounidad + pesoenvase
    else peso := peso + pesoenvase;

    result := peso;
    QPesoEnvase.Close;
  end;
end;

function TDMEnvases.GetPesoPalet(const APalet: string): Extended;
var
  sAux: String;
begin
  with QPesoPalet do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(kilos_tp,-1) kilos, descripcion_tp from frf_tipo_palets where codigo_tp = :palet ');
    ParamByName('palet').AsString := APalet;
    Open;
    if FieldByName('kilos').AsFloat = -1 then
    begin
      sAux:= 'Falta grabar el peso del palet ' + APalet + ' - ' + FieldByName('descripcion_tp').AsString;
      Close;
      raise Exception.Create( sAux );
    end;
    result:= FieldByName('kilos').AsFloat;
    Close;
  end;
end;

end.
