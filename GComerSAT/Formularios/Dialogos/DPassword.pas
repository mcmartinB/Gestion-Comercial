unit DPassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TFDPassword = class(TForm)
    Image1: TImage;
    cbAlias: TComboBox;
    LUsuario: TLabel;
    EUsuario: TEdit;
    EClave: TEdit;
    LClave: TLabel;
    BBevel2: TBevel;
    BAceptar: TButton;
    BCancelar: TButton;
    procedure BAceptarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbAliasChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure CreateParams(var Params: TCreateParams); Override;
  end;

var
  FDPassword: TFDPassword;

implementation

{$R *.dfm}

uses
  CVariables;

procedure TFDPassword.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do begin
    ExStyle := ExStyle or WS_EX_TOPMOST;
    WndParent := GetDesktopwindow;
  end;
end;

procedure TFDPassword.BAceptarClick(Sender: TObject);
begin
  // Cierre del Form
  Close;
  ModalResult:= mrOk;
end;

procedure TFDPassword.BCancelarClick(Sender: TObject);
begin
  Close;
  ModalResult:= mrCancel;
end;

procedure TFDPassword.cbAliasChange(Sender: TObject);
begin
  EUsuario.Text:= arDataConexion[cbAlias.ItemIndex].sBDUser;
  EClave.Text:= arDataConexion[cbAlias.ItemIndex].sBDPass;
end;

procedure TFDPassword.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  if FileExists( 'recursos\ComerPassword.emf' ) then
    Image1.Picture.LoadFromFile('recursos\ComerPassword.emf');

  cbAlias.Sorted:= False;
  for i:= 0 to iBDCount - 1 do
  begin
    cbAlias.Items.Add( arDataConexion[i].sDescripcion );
  end;

  cbAlias.ItemIndex := 0;
  EUsuario.Text:= arDataConexion[0].sBDUser;
  EClave.Text:= arDataConexion[0].sBDPass;
end;

procedure TFDPassword.FormKeyPress(Sender: TObject; var Key: Char);
begin
  //Tecla ENTER - Salta a otro campo de edición
  //Excepto cuando estamos sobre un boton
  if Key = #$0D then //vk_return
  begin
    //Si los campos de texto estan completos pulsamos sobre el boton
    if (Trim(EUsuario.Text) <> '') and
      (Trim(EClave.Text) <> '') then
    begin
      BAceptarClick(BAceptar);
      Exit;
    end;
    Key := #0;
    PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
  end
  else
    if Key = #$1B then //vk_escape
    begin
      BCancelarClick(BCancelar);
    end;
end;

procedure TFDPassword.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_f1 then
  begin
    BAceptarClick(BAceptar);
  end;
end;

end.
