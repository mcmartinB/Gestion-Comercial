unit LoadProveedoresDM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMLoadProveedores = class(TDataModule)
    qryProveedorCentral: TQuery;
    qryAlmacenProveedorCentral: TQuery;
    qryProductoProveedorCentral: TQuery;
    qryProveedorLocal: TQuery;
    qryAlmacenProveedorLocal: TQuery;
    qryProductoProveedorLocal: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    function LoadProveedor( const AProveedor: string; var VMsg: string ): Boolean;
    function desProveedor( const AProveedor: string ): string;

    function LoadAlmacenesProveedor( const AProveedor: string; var VMsg: string ): Boolean;
    function LoadProductosProveedor( const AProveedor: string; var VMsg: string ): Boolean;
  end;

implementation

{$R *.dfm}

uses
  Dialogs, UDMBaseDatos, Variants, Controls;


procedure TDMLoadProveedores.DataModuleCreate(Sender: TObject);
begin
  DMBaseDatos.BDCentral.Open;

  qryProveedorCentral.SQL.Clear;
  qryProveedorCentral.SQL.Add('select * ');
  qryProveedorCentral.SQL.Add('from frf_proveedores ');
  qryProveedorCentral.SQL.Add('where proveedor_p = :proveedor ');

  qryProveedorLocal.SQL.Clear;
  qryProveedorLocal.SQL.Add(qryProveedorCentral.SQL.Text);

  qryAlmacenProveedorCentral.SQL.Clear;
  qryAlmacenProveedorCentral.SQL.Add('select * ');
  qryAlmacenProveedorCentral.SQL.Add('from frf_proveedores_almacen ');
  qryAlmacenProveedorCentral.SQL.Add('where proveedor_pa = :proveedor ');

  qryAlmacenProveedorLocal.SQL.Clear;
  qryAlmacenProveedorLocal.SQL.Add(qryAlmacenProveedorCentral.SQL.Text);
  qryAlmacenProveedorLocal.SQL.Add(' and almacen_pa = :almacen ');


  qryProductoProveedorCentral.SQL.Clear;
  qryProductoProveedorCentral.SQL.Add('select * ');
  qryProductoProveedorCentral.SQL.Add('from frf_productos_proveedor ');
  qryProductoProveedorCentral.SQL.Add('where proveedor_pp = :proveedor ');

  qryProductoProveedorLocal.SQL.Clear;
  qryProductoProveedorLocal.SQL.Add(qryProductoProveedorCentral.SQL.Text);
  qryProductoProveedorLocal.SQL.Add(' and producto_pp = :producto ');
  qryProductoProveedorLocal.SQL.Add(' and variedad_pp = :variedad ');
end;

procedure TDMLoadProveedores.DataModuleDestroy(Sender: TObject);
begin
  if qryProductoProveedorCentral.Active then
    qryProductoProveedorCentral.Close;
  if qryProductoProveedorLocal.Active then
    qryProductoProveedorLocal.Close;

  if qryAlmacenProveedorCentral.Active then
    qryAlmacenProveedorCentral.Close;
  if qryAlmacenProveedorLocal.Active then
    qryAlmacenProveedorLocal.Close;

  if qryProveedorCentral.Active then
    qryProveedorCentral.Close;
  if qryProveedorLocal.Active then
    qryProveedorLocal.Close;

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

function TDMLoadProveedores.LoadAlmacenesProveedor( const AProveedor: string; var VMsg: string ): Boolean;
begin
  if ( Length( AProveedor ) = 3 ) then
  begin
    qryAlmacenProveedorCentral.ParamByName('proveedor').AsString:= AProveedor;
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
    AddText( VMsg, 'Tanto el código de empresa como el de proveedor deben de tener 3 dígitos.');
    Result:= False;
  end;
end;

function TDMLoadProveedores.LoadProductosProveedor( const AProveedor: string; var VMsg: string ): Boolean;
begin
  if ( Length( AProveedor ) = 3 ) then
  begin
    qryProductoProveedorCentral.ParamByName('proveedor').AsString:= AProveedor;
    qryProductoProveedorCentral.Open;
    if not qryProductoProveedorCentral.IsEmpty then
    begin
      try
        while not qryProductoProveedorCentral.Eof do
        begin
          qryProductoProveedorLocal.ParamByName('proveedor').AsString:= AProveedor;
          qryProductoProveedorLocal.ParamByName('producto').AsString:= qryProductoProveedorCentral.FieldByName('producto_pp').AsString;
          qryProductoProveedorLocal.ParamByName('variedad').AsString:= qryProductoProveedorCentral.FieldByName('variedad_pp').AsString;
          qryProductoProveedorLocal.Open;
          try
            PasaRegistro( qryProductoProveedorCentral, qryProductoProveedorLocal, not qryProductoProveedorLocal.IsEmpty );
          finally
            qryProductoProveedorLocal.Close;
          end;
          qryProductoProveedorCentral.Next;
        end;
        Result:= True;
      finally
        qryProductoProveedorCentral.Close;
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
    AddText( VMsg, 'Tanto el código de empresa como el de proveedor deben de tener 3 dígitos.');
    Result:= False;
  end;
end;

function TDMLoadProveedores.LoadProveedor( const AProveedor: string; var VMsg: string ): Boolean;
begin
  if ( Length( AProveedor ) = 3 ) then
  begin
    qryProveedorCentral.ParamByName('proveedor').AsString:= AProveedor;
    qryProveedorCentral.Open;
    if not qryProveedorCentral.IsEmpty then
    begin
      try
        qryProveedorLocal.ParamByName('proveedor').AsString:= AProveedor;
        qryProveedorLocal.Open;
        try
          if qryProveedorLocal.IsEmpty then
          begin
            PasaRegistro( qryProveedorCentral, qryProveedorLocal );
            Result:= True;
          end
          else
          begin
            if MessageDlg( 'Este proveedor ya existe, ¿seguro que quiere sobreescribirlo?', mtConfirmation, [mbYes, mbNo] , 0 ) = mrYes then
            begin
              PasaRegistro( qryProveedorCentral, qryProveedorLocal, True );
              Result:= True;
            end
            else
            begin
              AddText( VMsg, 'Operación cancelada por el usuario.');
              Result:= False;
            end;
          end;
          if Result then
          begin
            LoadAlmacenesProveedor( AProveedor, VMsg );
            LoadProductosProveedor( AProveedor, VMsg );
          end;
        finally
          qryProveedorLocal.Close;
        end;
      finally
        qryProveedorCentral.Close;
      end;
    end
    else
    begin
      AddText( VMsg, 'No encontrado el proveedor en la central.');
      Result:= False;
    end;
  end
  else
  begin
    AddText( VMsg, 'Tanto el código de empresa como el de proveedor deben de tener 3 dígitos.');
    Result:= False;
  end;
end;

function TDMLoadProveedores.desProveedor( const AProveedor: string ): string;
begin
  if ( Length( AProveedor ) = 3 ) then
  begin
    qryProveedorCentral.ParamByName('proveedor').AsString:= AProveedor;
    qryProveedorCentral.Open;
    try
      Result:= qryProveedorCentral.FieldByname('nombre_p').AsString;
    finally
      qryProveedorCentral.Close;
    end;
  end
  else
  begin
    Result:= '';
  end;
end;

end.
