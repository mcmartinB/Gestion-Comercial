unit ImportarProveedorFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBTables, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit, BGrid;

type
  TFDImportarProveedor = class(TForm)
    btnImportar: TButton;
    btnAceptar: TButton;
    btnCancelar: TButton;
    lblNombre7: TLabel;
    codigo_tp: TBEdit;
    qryProveedor: TQuery;
    dsProveedor: TDataSource;
    mmoIzq: TMemo;
    mmoDer: TMemo;
    btnProveedor: TBGridButton;
    txtProveedor: TStaticText;
    dbgrcategorias: TDBGrid;
    qryProveedoresAlmacen: TQuery;
    dsProveedoresAlmacen: TDataSource;
    DBGrid1: TDBGrid;
    qryProveedoresCostes: TQuery;
    dsProveedoresCostes: TDataSource;
    DBGrid2: TDBGrid;
    qryProductosProveedor: TQuery;
    dsProductosProveedor: TDataSource;
    procedure btnImportarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure codigo_tpChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    sProveedor: string;
    sBDRemota: string;

    procedure PutBaseDatosRemota( const BDRemota: string );
    procedure ParamToEdit( const AProveedor: string );
    function  EditToVar: Boolean;
    procedure VarToParam( var VProveedor: string );
    procedure PreparaEntorno;
    function  ImportarProveedor: boolean;
    procedure LoadQuerys;
    procedure LoadMemos;


  public
    { Public declarations }
  end;

  function ImportarProveedor( const AOwner: TComponent;  const BDRemota: string; var VProveedor: string ): Integer;



implementation

{$R *.dfm}

uses
  CVariables, CAuxiliarDB, UDMAuxDB, AdvertenciaFD, ImportarProveedorMD, bCodeUtils;

var
  FDImportarProveedor: TFDImportarProveedor;

(*
   RESULT
   -1 -> no quiero importar ningun proveedor, cancelar
   0  -> proveedor importado correctamente
   >0 -> error en la importacion
*)

function ImportarProveedor( const AOwner: TComponent;  const BDRemota: string; var VProveedor: string ): Integer;
begin

  FDImportarProveedor:= TFDImportarProveedor.Create( AOwner );
  try
    FDImportarProveedor.PutBaseDatosRemota( BDRemota );
    FDImportarProveedor.ParamToEdit( VProveedor );
    FDImportarProveedor.PreparaEntorno;
    Result:= FDImportarProveedor.ShowModal;
    FDImportarProveedor.VarToParam( VProveedor );
  finally
    FreeAndNil( FDImportarProveedor );
  end;
end;

procedure TFDImportarProveedor.FormCreate(Sender: TObject);
begin
  //empresa_e.Tag := kEmpresa;
end;

procedure TFDImportarProveedor.PutBaseDatosRemota( const BDRemota: string );
begin
  sBDRemota:= BDRemota;
  qryProveedor.DatabaseName:= sBDRemota;
  qryProveedoresAlmacen.DatabaseName:= sBDRemota;
  qryProveedoresCostes.DatabaseName:= sBDRemota;
  qryProductosProveedor.DatabaseName:= sBDRemota;
end;

procedure TFDImportarProveedor.ParamToEdit( const AProveedor: string );
begin
  codigo_tp.Text:= AProveedor;
end;

procedure TFDImportarProveedor.VarToParam( var VProveedor: string );
begin
  VProveedor:= sProveedor;
end;

function  TFDImportarProveedor.EditToVar: Boolean;
begin
  //Hay cambio de estado
  Result:= True;
  sProveedor:= Trim( codigo_tp.Text );
end;


procedure TFDImportarProveedor.PreparaEntorno;
begin
  codigo_tpChange( codigo_tp );
  if txtProveedor.Caption <> '' then
    btnAceptar.Caption:= 'Actualizar'
  else
    btnAceptar.Caption:= 'Insertar';

  btnImportar.Enabled:= True;
  btnAceptar.Enabled:= False;
end;

procedure TFDImportarProveedor.btnImportarClick(Sender: TObject);
begin
  if EditToVar then
  begin
    btnAceptar.Enabled:= ImportarProveedor;
  end
  else
  begin
    btnAceptar.Enabled:= False;
  end;
end;

procedure TFDImportarProveedor.btnAceptarClick(Sender: TObject);
var
  sMsg: string;
begin
  if ImportarProveedorMD.SincronizarProveedor( Self, sBDRemota, sProveedor,  sMsg ) then
  begin
    ModalResult:= 1;
  end
  else
  begin
    ShowMessage( sMsg );
  end;
end;

procedure TFDImportarProveedor.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= -1;
end;

procedure TFDImportarProveedor.LoadQuerys;
begin
  with qryProveedor do
  begin
    if Active then Close;

    SQL.Clear;
    SQL.Add('select *                           ');
    SQL.Add('from frf_proveedores               ');
    SQL.Add('where proveedor_p = :proveedor     ');
  end;
  with qryProveedoresAlmacen do
  begin
    SQL.Clear;
    SQL.Add('select *                           ');
    SQL.Add('from frf_proveedores_almacen       ');
    SQL.Add('where proveedor_pa = :proveedor    ');
  end;
  with qryProveedoresCostes do
  begin
    SQL.Clear;
    SQL.Add('select *                           ');
    SQL.Add('from frf_proveedores_costes        ');
    SQL.Add('where proveedor_pc = :proveedor    ');
  end;
  with qryProductosProveedor do
  begin
    SQL.Clear;
    SQL.Add('select *                           ');
    SQL.Add('from frf_productos_proveedor       ');
    SQL.Add('where proveedor_pp = :proveedor    ');
  end;

end;

function TFDImportarProveedor.ImportarProveedor: Boolean;
begin
  //TODO
  LoadQuerys;
  qryProveedor.ParamByName('proveedor').AsString:= sProveedor;
  qryProveedor.Open;
  if qryProveedor.IsEmpty then
  begin
    Result:= False;
    ShowMessage('NO encontrado el Proveedor en la BD Remota');
  end
  else
  begin
    LoadMemos;

    qryProveedoresAlmacen.ParamByName('proveedor').AsString:= sProveedor;
    qryProveedoresAlmacen.Open;

    qryProveedoresCostes.ParamByName('proveedor').AsString:= sProveedor;
    qryProveedoresCostes.Open;

    qryProductosProveedor.ParamByName('proveedor').AsString:= sProveedor;
    qryProductosProveedor.Open;

    Result:= True;
  end;
end;

procedure TFDImportarProveedor.LoadMemos;
var
  i: Integer;
begin
  mmoIzq.Clear;
  mmoDer.Clear;
  mmoIzq.Font.Style:= mmoIzq.Font.Style + [fsBold];
  i:= 0;
  while i < qryProveedor.Fields.Count do
  begin
    mmoIzq.Lines.Add( UpperCase(qryProveedor.Fields[i].FieldName) );
    mmoDer.Lines.Add( qryProveedor.Fields[i].AsString );
    inc( i );
  end;
end;

procedure TFDImportarProveedor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  (*
  if (bgrdRejillaFlotante.Visible) then
           //No hacemos nada
     Exit;
  *)
  case key of
    vk_Return, vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
  end;
end;

procedure TFDImportarProveedor.FormShow(Sender: TObject);
begin
  codigo_tp.SetFocus;
end;

procedure TFDImportarProveedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryProveedor.Close;
  qryProveedoresAlmacen.Close;
  qryProveedoresCostes.Close;
  qryProductosProveedor.Close;
end;


procedure TFDImportarProveedor.codigo_tpChange(Sender: TObject);
begin
  txtProveedor.Caption:= desProveedor( '', codigo_tp.Text );
  if txtProveedor.Caption <> '' then
    btnAceptar.Caption:= 'Actualizar'
  else
    btnAceptar.Caption:= 'Insertar';
end;

end.
