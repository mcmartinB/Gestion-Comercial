unit VerificarCosteEnvasadoData;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DBTables;

type
  TDMVerificarCosteEnvasado = class(TDataModule)
    MemTable: TkbmMemTable;
    qrySalidas: TQuery;
    qryCostes: TQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    iAnyo, iMes: integer;
    sEmpresa, sCentro: string;
    procedure FillTable;
  public
    { Public declarations }
    function  OpenData( const AEmpresa, ACentro: string; const AAnyo, AMes: integer ): boolean;
  end;

  function  LoadData( const AEmpresa, ACentro: string; const AAnyo, AMes: integer ): boolean;
  procedure FreeData;


var
  DMVerificarCosteEnvasado: TDMVerificarCosteEnvasado;

implementation

{$R *.dfm}

uses
  Variants, Forms, CGlobal;

function  LoadData( const AEmpresa, ACentro: string; const AAnyo, AMes: integer ): boolean;
begin
  Application.CreateForm(TDMVerificarCosteEnvasado, DMVerificarCosteEnvasado);
  Result:= DMVerificarCosteEnvasado.OpenData(  AEmpresa, ACentro, AAnyo, AMes );
end;

procedure FreeData;
begin
  DMVerificarCosteEnvasado.MemTable.Close;
  FreeAndNil( DMVerificarCosteEnvasado );
end;

procedure TDMVerificarCosteEnvasado.DataModuleCreate(Sender: TObject);
begin
  MemTable.FieldDefs.Clear;
  MemTable.FieldDefs.Add('empresa', ftString, 3, False);
  MemTable.FieldDefs.Add('centro', ftString, 3, False);
  MemTable.FieldDefs.Add('producto', ftString, 3, False);
  MemTable.FieldDefs.Add('envase', ftString, 9, False);
  MemTable.FieldDefs.Add('tipo', ftString, 3, False);
  MemTable.FieldDefs.Add('kilos_venta', ftFloat, 0, False);
  MemTable.FieldDefs.Add('kilos_transito', ftFloat, 0, False);
  MemTable.FieldDefs.Add('envasado', ftFloat, 0, False);
  MemTable.FieldDefs.Add('material', ftFloat, 0, False);
  MemTable.FieldDefs.Add('secciones', ftFloat, 0, False);
  MemTable.IndexFieldNames := 'empresa;centro;producto;envase';
  MemTable.CreateTable;

  qrySalidas.SQL.Clear;
  qrySalidas.SQL.Add(' select ''S'' tipo, empresa_sl empresa, centro_salida_sl centro, producto_sl producto, producto_base_p producto_base, ');
  qrySalidas.SQL.Add('        envase_sl envase, sum(kilos_sl) kilos ');
  qrySalidas.SQL.Add(' from   frf_salidas_l join frf_productos on producto_p = producto_sl ');
  qrySalidas.SQL.Add(' where empresa_sl = :empresa ');
  qrySalidas.SQL.Add(' and centro_salida_sl = :centro ');
  qrySalidas.SQL.Add(' and YEAR(fecha_sl) = :anyo ');
  qrySalidas.SQL.Add(' and MONTH(fecha_sl) = :mes ');
  qrySalidas.SQL.Add(' group by tipo, empresa_sl, centro_salida_sl, producto_sl, envase_sl, producto_base_p ');
  qrySalidas.SQL.Add('union ');
  qrySalidas.SQL.Add('  select ''T'' tipo, empresa_tl empresa, centro_tl centro, producto_tl producto, producto_base_p producto_base, ');
  qrySalidas.SQL.Add('        envase_tl envase, sum(kilos_tl) kilos ');
  qrySalidas.SQL.Add(' from   frf_transitos_l join frf_productos on producto_p = producto_tl');
  qrySalidas.SQL.Add(' where empresa_tl = :empresa ');
  qrySalidas.SQL.Add(' and centro_tl = :centro ');
  qrySalidas.SQL.Add(' and YEAR(fecha_tl) = :anyo ');
  qrySalidas.SQL.Add(' and MONTH(fecha_tl) = :mes ');
  qrySalidas.SQL.Add(' group by tipo, empresa_tl, centro_tl, producto_tl, envase_tl, producto_base_p ');
  qrySalidas.SQL.Add(' order by empresa, centro, producto, envase, tipo ');

  qryCostes.SQL.Clear;

  if CGlobal.gProgramVersion = CGlobal.pvBAG then
    qryCostes.SQL.Add(' select personal_ec envasado, material_ec material, general_ec secciones')
  else
    qryCostes.SQL.Add(' select coste_ec envasado, material_ec material, secciones_ec secciones');

  qryCostes.SQL.Add(' from frf_env_costes ');
  qryCostes.SQL.Add(' where anyo_ec = :anyo ');
  qryCostes.SQL.Add(' and mes_ec = :mes ');
  qryCostes.SQL.Add(' and empresa_ec = :empresa ');
  qryCostes.SQL.Add(' and centro_ec = :centro ');
  qryCostes.SQL.Add(' and producto_ec = :producto ');
  qryCostes.SQL.Add(' and envase_ec = :envase ');
end;

function  TDMVerificarCosteEnvasado.OpenData( const AEmpresa, ACentro: string; const AAnyo, AMes: integer ): boolean;
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  iAnyo:= AAnyo;
  iMes:= AMes;
  MemTable.Close;
  qrySalidas.ParamByName('empresa').AsString:= AEmpresa;
  qrySalidas.ParamByName('centro').AsString:= ACentro;
  qrySalidas.ParamByName('anyo').AsInteger:= AAnyo;
  qrySalidas.ParamByName('mes').AsInteger:= AMes;

  qrySalidas.Open;
  try
    Result:= not qrySalidas.IsEmpty;
    if Result then
      FillTable;
  finally
    qrySalidas.Close;
  end;
end;

procedure TDMVerificarCosteEnvasado.FillTable;
begin
  MemTable.Open;
  while not qrySalidas.Eof do
  begin
    if MemTable.Locate('empresa;centro;producto;envase', VarArrayOf([sEmpresa, sCentro,
                                                                       qrySalidas.FieldByName('producto').AsString,
                                                                       qrySalidas.FieldByName('envase').AsString]),[]) then
    begin
      MemTable.Edit;
      MemTable.FieldByName('tipo').AsString:= '*';
      if qrySalidas.FieldByName('tipo').AsString = 'S' then
        MemTable.FieldByName('kilos_venta').AsFloat:= qrySalidas.FieldByName('kilos').AsFloat
      else
        MemTable.FieldByName('kilos_transito').AsFloat:= qrySalidas.FieldByName('kilos').AsFloat;
      MemTable.Post;
    end
    else
    begin
      MemTable.Insert;
      MemTable.FieldByName('empresa').AsString:= sEmpresa;
      MemTable.FieldByName('centro').AsString:= sCentro;
      MemTable.FieldByName('producto').AsString:= qrySalidas.FieldByName('producto').AsString;
      MemTable.FieldByName('envase').AsString:= qrySalidas.FieldByName('envase').AsString;
      MemTable.FieldByName('tipo').AsString:= qrySalidas.FieldByName('tipo').AsString;
      if qrySalidas.FieldByName('tipo').AsString = 'S' then
        MemTable.FieldByName('kilos_venta').AsFloat:= qrySalidas.FieldByName('kilos').AsFloat
      else
        MemTable.FieldByName('kilos_transito').AsFloat:= qrySalidas.FieldByName('kilos').AsFloat;

      qryCostes.ParamByName('empresa').AsString:= sEmpresa;
      qryCostes.ParamByName('centro').AsString:= sCentro;
      qryCostes.ParamByName('anyo').AsInteger:= iAnyo;
      qryCostes.ParamByName('mes').AsInteger:= iMes;
      qryCostes.ParamByName('envase').AsString:= qrySalidas.FieldByName('envase').AsString;
      qryCostes.ParamByName('producto').AsString:= qrySalidas.FieldByName('producto').AsString;
      //producto base???
      qryCostes.Open;
      try
        if not qryCostes.IsEmpty then
        begin
          MemTable.FieldByName('envasado').AsFloat:= qryCostes.FieldByName('envasado').AsFloat;
          MemTable.FieldByName('material').AsFloat:= qryCostes.FieldByName('material').AsFloat;
          MemTable.FieldByName('secciones').AsFloat:= qryCostes.FieldByName('secciones').AsFloat;
        end;
      finally
        qryCostes.Close;
      end;
      MemTable.Post;
    end;
    qrySalidas.Next;
  end;
  MemTable.SortFields:='empresa;centro;producto;envase';
  MemTable.Sort([]);
end;

end.

