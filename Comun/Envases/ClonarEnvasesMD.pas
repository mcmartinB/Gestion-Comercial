unit ClonarEnvasesMD;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMClonarEnvases = class(TDataModule)
    qryCabRemoto: TQuery;
    qryCabLocal: TQuery;
    qryDetRemoto: TQuery;
    qryDetLocal: TQuery;
    qryAux: TQuery;
  private
    { Private declarations }
    sMessage: string;
    sEmpresa, sProducto, sEnvase, sNewProducto, sNewEnvase: string;
    bBaja: Boolean;

    procedure LoadQuerysEnvases;
    procedure LoadQuerysClientes;
    procedure LoadQuerysEan13;
    function  OpenQuerys: Boolean;
    procedure CloseQuerys;



    (*TODO EAN unidad de consumo*)

    function  SincronizaEnvase: Boolean;

    procedure SincronizarClientes;
    procedure SincronizaClientes;
    procedure SincronizarEan;
    procedure SincronizaEan;
    procedure LoadQueryLocalEan;

    function CambiarProductoUndConsumo: integer;

    function  GetMessage: string;

  public
    { Public declarations }
    function ClonarEnvase( const AEmpresa, AProducto, AEnvase, ANewProducto, ANewEnvase: string; const ABaja: boolean ): Boolean;
  end;


  function ClonarEnvase( const AEmpresa, AProducto, AEnvase, ANewProducto, ANewEnvase: string; const ABaja: boolean; var VMsg: string ): Boolean;



implementation

{$R *.dfm}

uses
  Variants, USincronizarTablas, Forms, ClonarUndConsumoFD;

var
  DMClonarEnvases: TDMClonarEnvases;

function ClonarEnvase( const AEmpresa, AProducto, AEnvase, ANewProducto, ANewEnvase: string; const ABaja: boolean; var VMsg: string ): Boolean;
begin
  Application.CreateForm(TDMClonarEnvases, DMClonarEnvases);
  try
    Result:= DMClonarEnvases.ClonarEnvase( AEmpresa, AProducto, AEnvase, ANewProducto, ANewEnvase, ABaja );
    VMsg:=  DMClonarEnvases.GetMessage;
  finally
    FreeAndNil( DMClonarEnvases );
  end;
end;

function  TDMClonarEnvases.GetMessage: string;
begin
  Result:= sMessage;
end;


function TDMClonarEnvases.ClonarEnvase( const AEmpresa, AProducto, AEnvase, ANewProducto, ANewEnvase: string; const ABaja: boolean ): Boolean;
begin
  sMessage:= '';
  sEmpresa:= AEmpresa;
  sProducto:= AProducto;
  sEnvase:= AEnvase;
  sNewProducto:= ANewProducto;
  sNewEnvase:= ANewEnvase;
  bBaja:= ABaja;

  if OpenQuerys then
  begin
    Result:= SincronizaEnvase;
  end
  else
  begin
    sMessage:= 'No se ha encontrado el artículo ' + AEmpresa + ' - ' + AProducto  + ' - ' +  AEnvase  + ' en la base de datos origen.';
    result:= False;
  end;
  CloseQuerys;
end;


procedure TDMClonarEnvases.LoadQuerysEnvases;
begin
  with qryCabRemoto do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_envases');
    SQL.Add('where envase_e = :envase ');
    if sProducto <> '' then
      SQL.Add('and producto_e = :producto ');
  end;
  with qryCabLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryCabRemoto.SQL );
  end;
end;

procedure TDMClonarEnvases.LoadQuerysClientes;
begin
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_clientes_env');
    SQL.Add('where empresa_ce = :empresa ');
    SQL.Add('and envase_ce = :envase ');
    if sProducto <> '' then
      SQL.Add('and producto_ce = :producto ');
  end;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryDetRemoto.SQL );
    SQL.Add('and cliente_ce = :cliente ');
  end;
end;

procedure TDMClonarEnvases.LoadQuerysEan13;
begin
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_ean13');
    SQL.Add('where empresa_e = :empresa ');
    SQL.Add('and envase_e = :envase ');
    if sProducto <> '' then
      SQL.Add('and ( producto_e =  :producto or producto_e is null ) ');
  end;
end;

function TDMClonarEnvases.OpenQuerys: Boolean;
begin
  LoadQuerysEnvases;

  //Abrir origen
  qryCabRemoto.ParamByName('envase').AsString:= sEnvase;
  if sProducto <> '' then
    qryCabRemoto.ParamByName('producto').AsString:= sProducto;
  qryCabRemoto.Open;
  if qryCabRemoto.IsEmpty then
  begin
    Result:= False;
  end
  else
  begin
    Result:= True;
  end;

  //Abrir destino
  if Result then
  begin
    qryCabLocal.ParamByName('envase').AsString:= sEnvase;
    if sProducto <> '' then
      qryCabLocal.ParamByName('producto').AsString:= sProducto;
    qryCabLocal.Open;
  end;
end;

procedure TDMClonarEnvases.CloseQuerys;
begin
  qryCabRemoto.Close;
  qryCabLocal.Close;
end;

function TDMClonarEnvases.SincronizaEnvase: Boolean;
var
  iResult: Integer;
begin
  ClonarRegistro( qryCabRemoto, qryCabLocal );
  qryCabLocal.FieldByName('producto_e').AsString:= sNewProducto;
  qryCabLocal.FieldByName('envase_e').AsString:= sNewEnvase;
  if CambiarProductoUndConsumo = -1 then
  begin
    //qryCabLocal.FieldByName('tipo_unidad_e').Value:= Null;
  end;
  qryCabLocal.Post;

  if bBaja then
  begin
    qryCabRemoto.Edit;
    qryCabRemoto.FieldByName('fecha_baja_E').AsDateTime:= Now;
    qryCabRemoto.Post;
  end;

  Result:= True;
  if Result then
  begin
    LoadQuerysClientes;
    SincronizarClientes;
    LoadQuerysEan13;
    SincronizarEan;

  end;
end;


procedure TDMClonarEnvases.SincronizarClientes;
begin
  qryDetRemoto.ParamByName('empresa').AsString:= sEmpresa;
  qryDetRemoto.ParamByName('envase').AsString:= sEnvase;
  if sProducto <> '' then
    qryDetRemoto.ParamByName('producto').AsString:= sProducto;
  qryDetRemoto.Open;
  if not qryDetRemoto.IsEmpty then
  begin
    while not qryDetRemoto.Eof do
    begin
      SincronizaClientes;
      qryDetRemoto.Next;
    end;
    qryDetRemoto.Close;
  end;
end;

procedure TDMClonarEnvases.SincronizaClientes;
begin
  //Abrir destino solo si existe el cliente, si no dara error al grabar
  qryDetLocal.ParamByName('empresa').AsString:= sEmpresa;
  qryDetLocal.ParamByName('envase').AsString:= sEnvase;
  if sProducto <> '' then
    qryDetLocal.ParamByName('producto').AsString:= sProducto;
  qryDetLocal.ParamByName('cliente').AsString:= qryDetRemoto.FieldByname('cliente_ce').AsString;
  qryDetLocal.Open;

  ClonarRegistro( qryDetRemoto, qryDetLocal );
  qryDetLocal.FieldByName('producto_ce').AsString:= sNewProducto;
  qryDetLocal.FieldByName('envase_ce').AsString:= sNewEnvase;
  qryDetLocal.Post;

  qryDetLocal.Close;
end;

procedure TDMClonarEnvases.SincronizarEan;
begin
  qryDetRemoto.ParamByName('empresa').AsString:= sEmpresa;
  qryDetRemoto.ParamByName('envase').AsString:= sEnvase;
  if sProducto <> '' then
    qryDetRemoto.ParamByName('producto').AsString:= sProducto;
  qryDetRemoto.Open;
  if not qryDetRemoto.IsEmpty then
  begin
    while not qryDetRemoto.Eof do
    begin
      SincronizaEan;
      qryDetRemoto.Next;
    end;
    qryDetRemoto.Close;
  end;
end;

procedure TDMClonarEnvases.LoadQueryLocalEan;
begin
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_ean13');
    SQL.Add('where empresa_e = :empresa ');
    SQL.Add('and envase_e = :envase ');

    if qryDetRemoto.FieldByname('producto_e').Value <> Null then
      SQL.Add('and producto_e =  :producto_e ');
    if qryDetRemoto.FieldByname('codigo_e').Value <> Null then
      SQL.Add('and codigo_e = :codigo_e ');
    if qryDetRemoto.FieldByname('marca_e').Value  <> Null then
      SQL.Add('and marca_e = :marca_e ');
    if qryDetRemoto.FieldByname('categoria_e').Value  <> Null then
      SQL.Add('and categoria_e = :categoria_e ');
    if qryDetRemoto.FieldByname('calibre_e').Value  <> Null then
      SQL.Add('and calibre_e = :calibre_e ');
    if qryDetRemoto.FieldByname('agrupacion_e').Value  <> Null then
      SQL.Add('and agrupacion_e = :agrupacion_e ');
  end;
end;

procedure TDMClonarEnvases.SincronizaEan;
begin
  LoadQueryLOcalEan;
  qryDetLocal.ParamByName('empresa').AsString:= sEmpresa;
  qryDetLocal.ParamByName('envase').AsString:= sEnvase;

  if qryDetRemoto.FieldByname('producto_e').Value <> Null then
    qryDetLocal.ParamByName('producto_e').AsString:= qryDetRemoto.FieldByname('producto_e').AsString;;
  if qryDetRemoto.FieldByname('codigo_e').Value <> Null then
    qryDetLocal.ParamByName('codigo_e').AsString:= qryDetRemoto.FieldByname('codigo_e').AsString;
  if qryDetRemoto.FieldByname('marca_e').Value  <> Null then
    qryDetLocal.ParamByName('marca_e').AsString:= qryDetRemoto.FieldByname('marca_e').AsString;
  if qryDetRemoto.FieldByname('categoria_e').Value  <> Null then
    qryDetLocal.ParamByName('categoria_e').AsString:= qryDetRemoto.FieldByname('categoria_e').AsString;
  if qryDetRemoto.FieldByname('calibre_e').Value  <> Null then
    qryDetLocal.ParamByName('calibre_e').AsString:= qryDetRemoto.FieldByname('calibre_e').AsString;
  if qryDetRemoto.FieldByname('agrupacion_e').Value  <> Null then
    qryDetLocal.ParamByName('agrupacion_e').AsString:= qryDetRemoto.FieldByname('agrupacion_e').AsString;

  qryDetLocal.Open;

  ClonarRegistro( qryDetRemoto, qryDetLocal );
  qryDetLocal.FieldByName('producto_e').AsString:= sNewProducto;
  qryDetLocal.FieldByName('envase_e').AsString:= sNewEnvase;
  qryDetLocal.Post;

  if bBaja then
  begin
    qryDetRemoto.Edit;
    qryDetRemoto.FieldByName('fecha_baja_E').AsDateTime:= Now;
    qryDetRemoto.Post;
  end;

  qryDetLocal.Close;
end;

//----------------------------------------------------------------------------
//DEPENDENCIAS
//----------------------------------------------------------------------------


//-1 no pasar unidad de consumo
//0 no hacer nada
//1 cambiar producto base
function TDMClonarEnvases.CambiarProductoUndConsumo: integer;
begin
  result:= 0;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_und_consumo');
    SQL.Add('where empresa_uc = :empresa_e ');
    SQL.Add('and codigo_uc = :tipo_unidad_e ');
  end;
  qryDetLocal.ParamByName('empresa_e').AsString:= qryCabRemoto.FieldByName('empresa_e').AsString;
  qryDetLocal.ParamByName('tipo_unidad_e').AsString:= qryCabRemoto.FieldByName('tipo_unidad_e').AsString;
  qryDetLocal.Open;

  if qryDetLocal.FieldByName('producto_uc').AsString <> sNewProducto then
  begin
    try
      if not qryDetLocal.IsEmpty then
      begin
        (*
        result:= ClonarUndConsumoFD.ClonarUndConsumo( sEmpresa,
                                                      qryCabRemoto.FieldByName('tipo_unidad_e').AsString,
                                                      qryDetLocal.FieldByName('producto_base_uc').AsString,
                                                      sNewProducto );
        *)
        //Clonar ean13
        result:= 1;
        if result = 1 then
        begin
          qryAux.SQL.Clear;
          qryAux.SQL.Add('update frf_ean13  ');
          qryAux.SQL.Add('set producto_e = :nuevo ');
          qryAux.SQL.Add('where empresa_e = :empresa ');
          qryAux.SQL.Add('  and envase_e = :envase ');
          qryAux.SQL.Add('  and producto_e = :viejo ');
          qryAux.SQL.Add('  and agrupacion_e = 1 ');
          qryAux.ParamByName('empresa').AsString:= qryCabRemoto.FieldByName('empresa_e').AsString;
          qryAux.ParamByName('envase').AsString:= qryCabRemoto.FieldByName('tipo_unidad_e').AsString;
          qryAux.ParamByName('viejo').AsString:= qryDetLocal.FieldByName('producto_uc').AsString;
          qryAux.ParamByName('nuevo').AsString:= sNewProducto;

          qryDetLocal.Edit;
          qryDetLocal.FieldByName('producto_uc').AsString:= sNewProducto;
          qryDetLocal.Post;
        end;
      end;
    finally
      qryDetLocal.Close;
    end;
  end;
end;

end.


