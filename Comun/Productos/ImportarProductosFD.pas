unit ImportarProductosFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBTables, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit, BGrid;

type
  TFDImportarProductos = class(TForm)
    btnImportar: TButton;
    btnAceptar: TButton;
    qryProductos: TQuery;
    btnCancelar: TButton;
    bgrdRejillaFlotante: TBGrid;
    lblNombre7: TLabel;
    producto_p: TBEdit;
    btnProducto: TBGridButton;
    txtProducto: TStaticText;
    dbgrcategorias: TDBGrid;
    qryCategorias: TQuery;
    dsCategorias: TDataSource;
    mmoIzq: TMemo;
    mmoDer: TMemo;
    dbgrdCalibres: TDBGrid;
    qryCalibres: TQuery;
    dsCalibres: TDataSource;
    procedure btnImportarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure producto_pChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnProductoClick(Sender: TObject);
  private
    { Private declarations }
    bAlta: boolean;
    sEmpresa, sProducto: string;
    sBDRemota: string;

    procedure PutBaseDatosRemota( const BDRemota: string );
    procedure ParamToEdit( const AProducto: string; const AAlta: boolean );
    function  EditToVar: Boolean;
    procedure VarToParam( var VProducto: string; var VAlta: boolean );
    procedure PreparaEntorno;
    function  ImportarProducto: boolean;
    procedure LoadQuerys;
    function  CambioDeEstado( const ANew: Boolean ): Boolean;
    procedure LoadMemos;


  public
    { Public declarations }
  end;

  function ImportarProducto( const AOwner: TComponent;  const BDRemota: string; var VProducto: string; var VAlta: boolean ): Integer;



implementation

{$R *.dfm}

uses
  CVariables, CAuxiliarDB, UDMAuxDB, AdvertenciaFD, ImportarProductosMD;

var
  FDImportarProductos: TFDImportarProductos;

(*
   RESULT
   -1 -> no quiero importar ningun envase, cancelar
   0  -> envase importado correctamente
   >0 -> error en la importacion
*)
function ImportarProducto( const AOwner: TComponent; const BDRemota: string; var VProducto: string; var VAlta: Boolean ): Integer;
begin

  FDImportarProductos:= TFDImportarProductos.Create( AOwner );
  try
    FDImportarProductos.PutBaseDatosRemota( BDRemota );
    FDImportarProductos.ParamToEdit( VProducto, VAlta );
    FDImportarProductos.PreparaEntorno;
    Result:= FDImportarProductos.ShowModal;
    FDImportarProductos.VarToParam( VProducto, VAlta );
  finally
    FreeAndNil( FDImportarProductos );
  end;
end;

procedure TFDImportarProductos.FormCreate(Sender: TObject);
begin
  Producto_p.Tag := kProducto;
end;

procedure TFDImportarProductos.PutBaseDatosRemota( const BDRemota: string );
begin
  sBDRemota:= BDRemota;
  qryProductos.DatabaseName:= sBDRemota;
  qryCategorias.DatabaseName:= sBDRemota;
  qryCalibres.DatabaseName:= sBDRemota;
end;

procedure TFDImportarProductos.ParamToEdit( const AProducto: string; const AAlta: boolean );
begin
  Producto_p.Text:= AProducto;
  bAlta:= AAlta;
end;

procedure TFDImportarProductos.VarToParam( var VProducto: string; var VAlta: boolean );
begin
  VProducto:= sProducto;
  VAlta:= bAlta;
end;

function  TFDImportarProductos.EditToVar: Boolean;
var
  bAux: Boolean;
begin
  (*
  else
  if ( Producto_p.Text <> '' ) and ( txtProducto.Caption = '' ) then
  begin
    ShowMessage('Código de Producto base incorrecto.');
    Result:= False;
  end
  else
  if ( Producto_p.Text = '' )  then
  begin
    ShowMessage('Falta el código del Producto.');
    Result:= False;
  end
  *)

    //Hay cambio de estado

    bAux:= txtProducto.Caption = '';
    if bAux <> bAlta then
      Result:= CambioDeEstado( bAux )
    else
      Result:= True;
    if Result then
    begin
      sProducto:= Trim( Producto_p.Text );
    end;
end;

function  TFDImportarProductos.CambioDeEstado( const ANew: Boolean ): Boolean;
begin
  //Pasa a alta
  if ANew then
  begin
    Result:= AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: El p elegido no esta en la Base de Datos de origen', 'CAMBIO DE ESTADO A ALTA',
                                       'Confirmo que quiero dar de alta el nuevo envase', 'Cambiar a ALTA') = mrIgnore;
    if Result then
    begin
      bAlta:= ANew;
      btnAceptar.Caption:= 'Insertar';
    end;
  end
  else
  //Pasa a modificar
  begin
    Result:= AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: El artículo elegido ya existe en la Base de Datos de origen', 'CAMBIO DE ESTADO A ACTUALIZAR',
                                       'Confirmo que quiero actualizar el artículo existente', 'Cambiar a ACTUALIZAR')  = mrIgnore;
    if Result then
    begin
      bAlta:= ANew;
      btnAceptar.Caption:= 'Actualizar';
    end;
  end;
end;


procedure TFDImportarProductos.PreparaEntorno;
begin
  btnImportar.Enabled:= True;

  Producto_p.Enabled:= bAlta;
  btnProducto.Enabled:= bAlta;

  if bAlta then
  begin
    btnAceptar.Caption:= 'Insertar';
    btnAceptar.Enabled:= False;
  end
  else
  begin
    btnAceptar.Caption:= 'Actualizar';
    btnAceptar.Enabled:= False;
  end;
end;

procedure TFDImportarProductos.btnImportarClick(Sender: TObject);
begin
  if EditToVar then
  begin
    btnAceptar.Enabled:= ImportarProducto;
  end
  else
  begin
    btnAceptar.Enabled:= False;
  end;
end;

procedure TFDImportarProductos.btnProductoClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kProducto: DespliegaRejilla(btnProducto);
  end;
end;

procedure TFDImportarProductos.btnAceptarClick(Sender: TObject);
var
  sMsg: string;
begin
  ModalResult:= 1;
  if ImportarProductosMD.SincronizarProducto( Self, sBDRemota, sEmpresa, sProducto, bAlta, sMsg ) then
  begin
    ModalResult:= 1;
  end
  else
  begin
    ShowMessage( sMsg );
  end;
end;

procedure TFDImportarProductos.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= -1;
end;

procedure TFDImportarProductos.LoadQuerys;
begin
  with qryProductos do
  begin
    SQL.Clear;
    SQL.Add(' select Producto_p cod_Producto, producto_base_p base, descripcion_p des_Producto, ');
    SQL.Add('        descripcion2_p ingles, des_aleman_p aleman, estomate_p es_tomate ');
    SQL.Add(' from frf_Productos ');
    SQL.Add(' where Producto_p = :Producto ');
  end;
  with qryCategorias do
  begin
    SQL.Clear;
    SQL.Add(' select  categoria_c codigo, descripcion_c categoria ');
    SQL.Add(' from frf_categorias ');
    SQL.Add(' where Producto_c = :Producto ');
  end;
  with qryCalibres do
  begin
    SQL.Clear;
    SQL.Add('select  calibre_c calibre ');
    SQL.Add('from frf_calibres ');
    SQL.Add('where Producto_c = :Producto ');
  end;
end;

function TFDImportarProductos.ImportarProducto: Boolean;
begin
  LoadQuerys;
  qryProductos.ParamByName('Producto').AsString:= sProducto;
  qryProductos.Open;
  if qryProductos.IsEmpty then
  begin
    Result:= False;
    ShowMessage('NO encontrado Producto en la BD Remota');
  end
  else
  begin
    LoadMemos;
    qryCategorias.ParamByName('Producto').AsString:= sProducto;
    qryCategorias.Open;

    qryCalibres.ParamByName('Producto').AsString:= sProducto;
    qryCalibres.Open;

    Result:= True;
  end;
end;

procedure TFDImportarProductos.LoadMemos;
var
  i: Integer;
begin
  mmoIzq.Clear;
  mmoDer.Clear;
  mmoIzq.Font.Style:= mmoIzq.Font.Style + [fsBold];
  i:= 0;
  while i < qryProductos.Fields.Count do
  begin
    mmoIzq.Lines.Add( UpperCase(qryProductos.Fields[i].FieldName) );
    mmoDer.Lines.Add( qryProductos.Fields[i].AsString );
    inc( i );
  end;
end;


procedure TFDImportarProductos.producto_pChange(Sender: TObject);
begin
  txtProducto.Caption := desProducto('', Producto_p.Text);
end;

procedure TFDImportarProductos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (bgrdRejillaFlotante.Visible) then
           //No hacemos nada
     Exit;

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

procedure TFDImportarProductos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryProductos.Close;
  qryCategorias.Close;
  qryCalibres.Close;
end;

end.
