unit LoadAlmacenProveedorDM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMLoadAlmacenProveedor = class(TDataModule)
    qryAlmacenProveedorCentral: TQuery;
    qryAlmacenProveedorLocal: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure StrQuery( const AProveedor, AAlmacen: string );

  public
    { Public declarations }

    function desAlmacenProveedor( const AProveedor, AAlmacen: string ): string;
    function LoadAlmacenesProveedor( const AProveedor, AAlmacen: string; var VMsg: string ): Boolean;
  end;

implementation

{$R *.dfm}

uses
  Dialogs, UDMBaseDatos, Variants, Controls;


procedure TDMLoadAlmacenProveedor.DataModuleCreate(Sender: TObject);
begin
  DMBaseDatos.BDCentral.Open;
end;

procedure TDMLoadAlmacenProveedor.StrQuery( const AProveedor, AAlmacen: string );
begin
  qryAlmacenProveedorCentral.SQL.Clear;
  qryAlmacenProveedorCentral.SQL.Add('select * ');
  qryAlmacenProveedorCentral.SQL.Add('from frf_proveedores_almacen ');
  qryAlmacenProveedorCentral.SQL.Add('where proveedor_pa = :proveedor ');
  if AAlmacen <> '' then
    qryAlmacenProveedorCentral.SQL.Add('and almacen_pa = :almacen ');

  qryAlmacenProveedorLocal.SQL.Clear;
  qryAlmacenProveedorLocal.SQL.Add(qryAlmacenProveedorCentral.SQL.Text);
  if AAlmacen = '' then
    qryAlmacenProveedorLocal.SQL.Add(' and almacen_pa = :almacen ');

  qryAlmacenProveedorCentral.ParamByName('proveedor').AsString:= AProveedor;
  if AAlmacen <> '' then
    qryAlmacenProveedorCentral.ParamByName('almacen').AsString:= AAlmacen;
end;

procedure TDMLoadAlmacenProveedor.DataModuleDestroy(Sender: TObject);
begin
  if qryAlmacenProveedorCentral.Active then
    qryAlmacenProveedorCentral.Close;
  if qryAlmacenProveedorLocal.Active then
    qryAlmacenProveedorLocal.Close;

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

function TDMLoadAlmacenProveedor.LoadAlmacenesProveedor( const AProveedor, AAlmacen: string; var VMsg: string ): Boolean;
begin
  if ( Length( AProveedor ) = 3 ) then
  begin
    StrQuery( AProveedor, AAlmacen );
    qryAlmacenProveedorCentral.Open;
    if not qryAlmacenProveedorCentral.IsEmpty then
    begin
      try
        while not qryAlmacenProveedorCentral.Eof do
        begin
          qryAlmacenProveedorLocal.ParamByName('proveedor').AsString:= AProveedor;
          qryAlmacenProveedorLocal.ParamByName('almacen').AsString:= qryAlmacenProveedorCentral.FieldByName('almacen_pa').AsString;
          qryAlmacenProveedorLocal.Open;
          try
            PasaRegistro( qryAlmacenProveedorCentral, qryAlmacenProveedorLocal, not qryAlmacenProveedorLocal.IsEmpty );
          finally
            qryAlmacenProveedorLocal.Close;
          end;
          qryAlmacenProveedorCentral.Next;
        end;
        Result:= True;
      finally
        qryAlmacenProveedorCentral.Close;
      end;
    end
    else
    begin
      AddText( VMsg, 'No encontrado almacenes del proveedor en la central.');
      Result:= False;
    end;
  end
  else
  begin
    AddText( VMsg, 'El código de proveedor deben de tener 3 dígitos.');
    Result:= False;
  end;
end;

function TDMLoadAlmacenProveedor.desAlmacenProveedor( const AProveedor, AAlmacen: string ): string;
begin
  if ( Length( AProveedor ) = 3 ) and ( Length( AAlmacen ) > 0 ) then
  begin
    StrQuery( AProveedor, AAlmacen );
    qryAlmacenProveedorCentral.Open;
    try
      Result:= qryAlmacenProveedorCentral.FieldByname('nombre_pa').AsString;
    finally
      qryAlmacenProveedorCentral.Close;
    end;
  end
  else
  begin
    Result:= '';
  end;
end;

end.
