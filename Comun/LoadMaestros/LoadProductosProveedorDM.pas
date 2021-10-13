unit LoadProductosProveedorDM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMLoadProductosProveedor = class(TDataModule)
    qryProductosProveedorCentral: TQuery;
    qryProductosProveedorLocal: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure StrQuery( const AProveedor, AProducto, AVariedad: string );

  public
    { Public declarations }

    function desProductoProveedor( const AProveedor, AProducto, AVariedad: string ): string;
    function LoadProductosProveedor( const AProveedor, AProducto, AVariedad: string; var VMsg: string ): Boolean;
  end;

implementation

{$R *.dfm}

uses
  Dialogs, UDMBaseDatos, Variants, Controls;


procedure TDMLoadProductosProveedor.DataModuleCreate(Sender: TObject);
begin
  DMBaseDatos.BDCentral.Open;
end;

procedure TDMLoadProductosProveedor.StrQuery( const AProveedor, AProducto, AVariedad: string );
begin
  //**************************************************************************************
  //REMOTO
  qryProductosProveedorCentral.SQL.Clear;
  qryProductosProveedorCentral.SQL.Add('select * ');
  qryProductosProveedorCentral.SQL.Add('from frf_productos_proveedor ');
  qryProductosProveedorCentral.SQL.Add('where proveedor_pp = :proveedor ');
  if AProducto <> '' then
    qryProductosProveedorCentral.SQL.Add('and producto_pp = :producto ');
  if AVariedad <> '' then
    qryProductosProveedorCentral.SQL.Add('and variedad_pp = :variedad ');

  //**************************************************************************************
  //PARAMETROS REMOTO
  qryProductosProveedorCentral.ParamByName('proveedor').AsString:= AProveedor;
  if AProducto <> '' then
    qryProductosProveedorCentral.ParamByName('producto').AsString:= AProducto;
  if AVariedad <> '' then
    qryProductosProveedorCentral.ParamByName('variedad').AsString:= AVariedad;

  //**************************************************************************************
  //LOCAL
  qryProductosProveedorLocal.SQL.Clear;
  qryProductosProveedorLocal.SQL.Add(qryProductosProveedorCentral.SQL.Text);
  if AProducto = '' then
    qryProductosProveedorLocal.SQL.Add(' and producto_pp = :producto ');
  if AVariedad = '' then
    qryProductosProveedorLocal.SQL.Add(' and variedad_pp = :variedad ');
end;

procedure TDMLoadProductosProveedor.DataModuleDestroy(Sender: TObject);
begin
  if qryProductosProveedorCentral.Active then
    qryProductosProveedorCentral.Close;
  if qryProductosProveedorLocal.Active then
    qryProductosProveedorLocal.Close;

  if DMBaseDatos.BDCentral.Connected then
    DMBaseDatos.BDCentral.Close;
end;

procedure PasaRegistro( const AFuente, ADestino: TDataSet; const AModificar: Boolean = False );
var
  i: integer;
  //sAux: string;
  campo: TField;
begin
  if AModificar then
    ADestino.Edit
  else
    ADestino.Insert;

  i:= 0;
  while i < ADestino.Fields.Count do
  begin
    campo:= AFuente.FindField(ADestino.Fields[i].FieldName);
    if campo <> nil then
    begin
      if campo.Value <> null then
        ADestino.Fields[i].Value:= campo.Value;
    end;
    inc( i );
  end;
  try
    ADestino.Post;
  except
    ADestino.Cancel;
    Raise;
  end;
end;

procedure AddText( var VMsg: string; const AMsg: string );
begin
  if VMsg <> '' then
    VMsg:= VMsg + #13 + #10 + AMsg
  else
    VMsg:= AMsg;
end;

function TDMLoadProductosProveedor.LoadProductosProveedor( const AProveedor, AProducto, AVariedad: string; var VMsg: string ): Boolean;
begin
  if ( Length( AProveedor ) = 3 ) and ( Length( AProducto ) > 0 ) then
  begin
    StrQuery( AProveedor, AProducto, AVariedad );
    qryProductosProveedorCentral.Open;
    if not qryProductosProveedorCentral.IsEmpty then
    begin
      try
        while not qryProductosProveedorCentral.Eof do
        begin
          qryProductosProveedorLocal.ParamByName('proveedor').AsString:= AProveedor;
          qryProductosProveedorLocal.ParamByName('producto').AsString:= AProducto;
          qryProductosProveedorLocal.ParamByName('variedad').AsString:= qryProductosProveedorCentral.FieldByName('variedad_pp').AsString;
          qryProductosProveedorLocal.Open;
          try
            PasaRegistro( qryProductosProveedorCentral, qryProductosProveedorLocal, not qryProductosProveedorLocal.IsEmpty );
          finally
            qryProductosProveedorLocal.Close;
          end;
          qryProductosProveedorCentral.Next;
        end;
        Result:= True;
      finally
        qryProductosProveedorCentral.Close;
      end;
    end
    else
    begin
      AddText( VMsg, 'No encontrado productos del proveedor en la central.');
      Result:= False;
    end;
  end
  else
  begin
    AddText( VMsg, 'El código de proveedor deben de tener 3 dígitos y el producto 1.');
    Result:= False;
  end;
end;

function TDMLoadProductosProveedor.desProductoProveedor( const AProveedor, AProducto, AVariedad: string ): string;
begin
  if ( Length( AProveedor ) = 3 ) and ( Length( AProducto ) > 0 )  and ( Length( AVariedad ) > 0 ) then
  begin
    StrQuery( AProveedor, AProducto, AVariedad );
    qryProductosProveedorCentral.Open;
    try
      Result:= qryProductosProveedorCentral.FieldByname('descripcion_pp').AsString;
    finally
      qryProductosProveedorCentral.Close;
    end;
  end
  else
  begin
    Result:= '';
  end;
end;

end.
