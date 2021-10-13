unit LoadProductosProveedorlFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, BGrid, StdCtrls, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit;

type
  TFDLoadProductosProveedor = class(TForm)
    lbl2: TLabel;
    bgrdRejillaFlotante: TBGrid;
    btnAceptar: TButton;
    btnCancelar: TButton;
    txtProveedor: TStaticText;
    edtCodigo: TBEdit;
    lbl3: TLabel;
    lblVariedad: TLabel;
    edtVariedad: TBEdit;
    txtVariedad: TStaticText;
    btnProveedor: TBGridButton;
    lbl4: TLabel;
    lblProducto: TLabel;
    edtProducto: TBEdit;
    btnProducto: TBGridButton;
    txtProducto: TStaticText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodigoChange(Sender: TObject);
    procedure edtVariedadChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGridClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
  private
    { Private declarations }

    function ValidadParametos( var VMsg: string ): boolean;
  public
    { Public declarations }
  end;

  function LoadProductosProveedor( const AOwner: TComponent; var VCodigo, VProducto, VVariedad: string ): Boolean;


implementation

{$R *.dfm}

uses
  LoadProductosProveedorDM, UDMAuxDB, CVariables, CAuxiliarDB;

var
  FDLoadProductosProveedor: TFDLoadProductosProveedor;
  DMLoadProductosProveedor: TDMLoadProductosProveedor;

function LoadProductosProveedor( const AOwner: TComponent; var VCodigo, VProducto, VVariedad: string ): Boolean;
var
  sMsg: string;
begin
  FDLoadProductosProveedor:= TFDLoadProductosProveedor.Create( AOwner );
  DMLoadProductosProveedor:= TDMLoadProductosProveedor.Create( AOwner );
  try
    FDLoadProductosProveedor.edtCodigo.Text:= VCodigo;
    FDLoadProductosProveedor.edtProducto.Text:= VProducto;
    FDLoadProductosProveedor.edtVariedad.Text:= VVariedad;
    if FDLoadProductosProveedor.ShowModal = mrYes then
    begin
      VCodigo:= FDLoadProductosProveedor.edtCodigo.Text;
      VProducto:= FDLoadProductosProveedor.edtProducto.Text;
      VVariedad:= FDLoadProductosProveedor.edtVariedad.Text;
      if DMLoadProductosProveedor.LoadProductosProveedor( VCodigo, VProducto, VVariedad, sMsg ) then
      begin
        Result:= True;
      end
      else
      begin
        Result:= False;
        ShowMessage( sMsg );
      end;
    end
    else
    begin
      Result:= False;
      ShowMessage('Operación cancelada por el usuario.');
    end;
  finally
    FreeAndNil( DMLoadProductosProveedor );
    FreeAndNil( FDLoadProductosProveedor );
  end;
end;

procedure AddText( var VMsg: string; const AMsg: string );
begin
  if VMsg <> '' then
    VMsg:= VMsg + #13 + #10 + AMsg
  else
    VMsg:= AMsg;
end;


function TFDLoadProductosProveedor.ValidadParametos( var VMsg: string ): boolean;
begin
  VMsg:= '';
  if txtProveedor.Caption = '' then
  begin
    AddText( VMsg,'Falta el código de proveedor o es incorrecto.');
  end;
  if txtProducto.Caption = '' then
  begin
    AddText( VMsg,'Falta el código de producto o es incorrecto.');
  end;
  if txtVariedad.Caption = '' then
  begin
    AddText( VMsg,'Código de variedad de proveedor en la central incorrecto.' + #13 + #10 +
                    'Por favor compruebe que esta variedad de proveedor ya este dado de alta en la central.');
  end;
  result:= VMsg = '';
end;

procedure TFDLoadProductosProveedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  sMsg: string;
begin
  Action:= caHide;
  if ModalResult = mrYes then
  begin
    if not ValidadParametos( sMsg ) then
    begin
      ShowMessage( sMsg );
      Action:= caNone;
    end;
  end;
end;

procedure TFDLoadProductosProveedor.edtCodigoChange(Sender: TObject);
begin
  txtProveedor.Caption:= desProveedor( '', edtCodigo.Text );
  edtVariedadChange( edtVariedad );
end;

procedure TFDLoadProductosProveedor.edtProductoChange(Sender: TObject);
begin
  txtProducto.Caption:= desProducto( '', edtProducto.Text );
  edtVariedadChange( edtVariedad );
end;

procedure TFDLoadProductosProveedor.edtVariedadChange(Sender: TObject);
begin
  if edtVariedad.Text <> '' then
    txtVariedad.Caption:= DMLoadProductosProveedor.desProductoProveedor( edtCodigo.Text, edtProducto.Text, edtVariedad.Text )
  else
    txtVariedad.Caption:= 'TODOS LAS VARIEDADES PRODUCTO';
end;

procedure TFDLoadProductosProveedor.FormCreate(Sender: TObject);
begin
  edtCodigo.Tag:= kProveedor;
  edtProducto.Tag:= kProducto;
end;

procedure TFDLoadProductosProveedor.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    //Si la rejilla esta desplegada no hacemos nada
  if (bgrdRejillaFlotante <> nil) then
    if (bgrdRejillaFlotante.Visible) then
           //No hacemos nada
      Exit;

    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
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
    VK_F1:
      begin
        Key := 0;
        btnAceptar.Click
      end;
    VK_F2:
      begin
        Key := 0;
        btnGridClick( nil );
      end;
    VK_ESCAPE:
      begin
        Key := 0;
        btnCancelar.Click
      end;
  end;
end;

procedure TFDLoadProductosProveedor.btnGridClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kProveedor: DespliegaRejilla(btnProveedor);
    kProducto: DespliegaRejilla(btnProducto);
  end;
end;

end.

