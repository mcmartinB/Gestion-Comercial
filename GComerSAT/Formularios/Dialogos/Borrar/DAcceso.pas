//  CONEXIÓN CON LA BASE DE DATOS CALIDAD y CICA

unit DAcceso;

interface

uses
  Windows, Messages, Forms, Dialogs, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Buttons, Db, DBTables, SysUtils, DError;


type
  TFDAcceso = class(TForm)
    BBevel2: TBevel;
    LUsuario: TLabel;
    LClave: TLabel;
    EUsuario: TEdit;
    EClave: TEdit;
    Image1: TImage;
    BAceptar: TButton;
    BCancelar: TButton;
    QExisteUsuario: TQuery;
    cbAlias: TComboBox;
    Bevel1: TBevel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    // Botones
    procedure BBAceptar2Click(Sender: TObject);
    procedure BBCancelar2Click(Sender: TObject);
    procedure EEntrar(Sender: TObject);
    procedure ESalir(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure cbAliasChange(Sender: TObject);

  private

  protected
    procedure CreateParams(var Params: TCreateParams); Override;
  end;

implementation

uses UDMConfig, CVariables, CAuxiliarDB, bDialogs, IniFiles;

{$R *.DFM}

// ==================================  FORM  ==================================

procedure TFDAcceso.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do begin
    ExStyle := ExStyle or WS_EX_TOPMOST;
    WndParent := GetDesktopwindow;
  end;
end;

procedure TFDAcceso.FormKeyPress(Sender: TObject; var Key: Char);
begin
  //Tecla ENTER - Salta a otro campo de edición
  //Excepto cuando estamos sobre un boton
  if Key = #$0D then //vk_return
  begin
    //Si los campos de texto estan completos pulsamos sobre el boton
    if (Trim(EUsuario.Text) <> '') and
      (Trim(EClave.Text) <> '') then
    begin
      BBAceptar2Click(BAceptar);
      Exit;
    end;
    Key := #0;
    PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
  end
  else
    if Key = #$1B then //vk_escape
    begin
      BBCancelar2Click(BCancelar);
    end;
end;

procedure TFDAcceso.BBAceptar2Click(Sender: TObject);
begin
  // Cierre del Form
  Close;
  ModalResult:= mrOk;
end;

procedure TFDAcceso.BBCancelar2Click(Sender: TObject);
begin
  Close;
  ModalResult:= mrCancel;
end;

procedure TFDAcceso.EEntrar(Sender: TObject);
begin
  TEdit(Sender).Color := clInfoBk;
end;

procedure TFDAcceso.ESalir(Sender: TObject);
begin
  TEdit(Sender).Color := clWhite;
end;

procedure TFDAcceso.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_f1 then
  begin
    BBAceptar2Click(BAceptar);
  end;
end;

procedure TFDAcceso.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  if FileExists( 'recursos\cabecera_final.bmp' ) then
  begin
    Image1.Height:= 163;
    Image1.Picture.LoadFromFile('recursos\cabecera_final.bmp');
  end
  else
  begin
    if FileExists( 'recursos\ComerPassword.emf' ) then
    begin
      Image1.Height:= 277;
      Image1.Picture.LoadFromFile('recursos\ComerPassword.emf');
    end
  end;

  cbAlias.Sorted:= False;
  for i:= 0 to iBDCount - 1 do
  begin
    cbAlias.Items.Add( arDataConexion[i].sDescripcion );
  end;
  cbAlias.ItemIndex := 0;
  EUsuario.Text:= arDataConexion[0].sBDUser;
  EClave.Text:= arDataConexion[0].sBDPass;
end;

procedure TFDAcceso.cbAliasChange(Sender: TObject);
var
  IniFile: TIniFile;
  sAux: string;
begin
  EUsuario.Text:= arDataConexion[cbAlias.ItemIndex].sBDUser;
  EClave.Text:= arDataConexion[cbAlias.ItemIndex].sBDPass;
end;

end.
