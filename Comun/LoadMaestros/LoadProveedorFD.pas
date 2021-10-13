unit LoadProveedorFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, BGrid, StdCtrls, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit;

type
  TFDLoadProveedor = class(TForm)
    lbl2: TLabel;
    bgrdRejillaFlotante: TBGrid;
    btnAceptar: TButton;
    btnCancelar: TButton;
    txtProveedor: TStaticText;
    edtCodigo: TBEdit;
    lbl3: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodigoChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function LoadProveedor( const AOwner: TComponent; var VCodigo: string ): Boolean;


implementation

{$R *.dfm}

uses
  LoadProveedoresDM, UDMAuxDB, CVariables, CAuxiliarDB ;

var
  FDLoadProveedor: TFDLoadProveedor;
  DMLoadProveedor: TDMLoadProveedores;

function LoadProveedor( const AOwner: TComponent; var VCodigo: string ): Boolean;
var
  sMsg: string;
begin
  FDLoadProveedor:= TFDLoadProveedor.Create( AOwner );
  DMLoadProveedor:= TDMLoadProveedores.Create( AOwner );
  try
    FDLoadProveedor.edtCodigo.Text:= VCodigo;
    if FDLoadProveedor.ShowModal = mrYes then
    begin
      VCodigo:= FDLoadProveedor.edtCodigo.Text;
      if DMLoadProveedor.LoadProveedor( VCodigo, sMsg ) then
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
    FreeAndNil( DMLoadProveedor );
    FreeAndNil( FDLoadProveedor );
  end;
end;

procedure TFDLoadProveedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caHide;
  if ModalResult = mrYes then
  begin
    if txtProveedor.Caption = '' then
    begin
      ShowMessage('Código de proveedor en la central incorrecto.' + #13 + #10 +
                  'Por favor compruebe que este proveedor ya este dado de alta en la central.' );
      Action:= caNone;
    end;
  end;
end;

procedure TFDLoadProveedor.btnAceptarClick(Sender: TObject);
begin
//
end;

procedure TFDLoadProveedor.edtCodigoChange(Sender: TObject);
begin
  txtProveedor.Caption:= DMLoadProveedor.desProveedor( edtCodigo.Text );
end;

procedure TFDLoadProveedor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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
      end;
    VK_ESCAPE:
      begin
        Key := 0;
        btnCancelar.Click
      end;
  end;
end;

end.
