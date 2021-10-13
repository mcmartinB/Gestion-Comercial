unit LoadAlmacenProveedorlFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, BGrid, StdCtrls, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit;

type
  TFDLoadAlmacenProveedor = class(TForm)
    lbl2: TLabel;
    bgrdRejillaFlotante: TBGrid;
    btnAceptar: TButton;
    btnCancelar: TButton;
    txtProveedor: TStaticText;
    edtCodigo: TBEdit;
    lbl3: TLabel;
    lblAlmacen: TLabel;
    edtAlmacen: TBEdit;
    txtAlmacen: TStaticText;
    btnProveedor: TBGridButton;
    lbl4: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodigoChange(Sender: TObject);
    procedure edtAlmacenChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGridClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    function ValidadParametos( var VMsg: string ): boolean;
  public
    { Public declarations }
  end;

  function LoadAlmacenProveedor( const AOwner: TComponent; var VCodigo, VAlmacen: string ): Boolean;


implementation

{$R *.dfm}

uses
  LoadAlmacenProveedorDM, UDMAuxDB, CVariables, CAuxiliarDB;

var
  FDLoadAlmacenProveedor: TFDLoadAlmacenProveedor;
  DMLoadAlmacenProveedor: TDMLoadAlmacenProveedor;

function LoadAlmacenProveedor( const AOwner: TComponent; var VCodigo, VAlmacen: string ): Boolean;
var
  sMsg: string;
begin
  FDLoadAlmacenProveedor:= TFDLoadAlmacenProveedor.Create( AOwner );
  DMLoadAlmacenProveedor:= TDMLoadAlmacenProveedor.Create( AOwner );
  try
    FDLoadAlmacenProveedor.edtCodigo.Text:= VCodigo;
    FDLoadAlmacenProveedor.edtAlmacen.Text:= VAlmacen;
    if FDLoadAlmacenProveedor.ShowModal = mrYes then
    begin
      VCodigo:= FDLoadAlmacenProveedor.edtCodigo.Text;
      VAlmacen:= FDLoadAlmacenProveedor.edtAlmacen.Text;
      if DMLoadAlmacenProveedor.LoadAlmacenesProveedor( VCodigo, VAlmacen,  sMsg ) then
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
    FreeAndNil( DMLoadAlmacenProveedor );
    FreeAndNil( FDLoadAlmacenProveedor );
  end;
end;

procedure AddText( var VMsg: string; const AMsg: string );
begin
  if VMsg <> '' then
    VMsg:= VMsg + #13 + #10 + AMsg
  else
    VMsg:= AMsg;
end;


function TFDLoadAlmacenProveedor.ValidadParametos( var VMsg: string ): boolean;
begin
  VMsg:= '';
  if txtProveedor.Caption = '' then
  begin
    AddText( VMsg,'Falta el código de proveedor o es incorrecto.');
  end;
  if txtAlmacen.Caption = '' then
  begin
    AddText( VMsg,'Código de almacén de proveedor en la central incorrecto.' + #13 + #10 +
                    'Por favor compruebe que este almacén de proveedor ya este dado de alta en la central.');
  end;
  result:= VMsg = '';
end;

procedure TFDLoadAlmacenProveedor.FormClose(Sender: TObject;
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

procedure TFDLoadAlmacenProveedor.edtCodigoChange(Sender: TObject);
begin
  txtProveedor.Caption:= desProveedor( '', edtCodigo.Text );
  edtAlmacenChange( edtAlmacen );
end;

procedure TFDLoadAlmacenProveedor.edtAlmacenChange(Sender: TObject);
begin
  if edtAlmacen.Text <> '' then
    txtAlmacen.Caption:= DMLoadAlmacenProveedor.desAlmacenProveedor( edtCodigo.Text, edtAlmacen.Text )
  else
    txtAlmacen.Caption:= 'TODOS LOS ALMACENES PROVEEDOR';
end;

procedure TFDLoadAlmacenProveedor.FormCreate(Sender: TObject);
begin
  edtCodigo.Tag:= kProveedor;
end;

procedure TFDLoadAlmacenProveedor.FormKeyDown(Sender: TObject;
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

procedure TFDLoadAlmacenProveedor.btnGridClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kProveedor: DespliegaRejilla(btnProveedor);
  end;
end;


end.
