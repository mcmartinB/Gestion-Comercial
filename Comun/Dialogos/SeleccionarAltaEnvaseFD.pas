unit SeleccionarAltaEnvaseFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFDSeleccionarAltaEnvase = class(TForm)
    btnOk: TButton;
    rbNuevo: TRadioButton;
    rbImportar: TRadioButton;
    btnCancelar: TButton;
    pnlBD: TPanel;
    rbF17: TRadioButton;
    rbF18: TRadioButton;
    rbF23: TRadioButton;
    rbClonar: TRadioButton;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure rbImportarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function GetTipo( var VBD: string ): Integer;
  public
    { Public declarations }
  end;

function SeleccionarTipoAlta( const AOwner: TComponent; var VTipo: integer; var VBD: string;
                              const ATitle: string = '     SELECCIONAR TIPO ALTA'; const ATextLocal: string = 'Nuevo' ): integer;

implementation

{$R *.dfm}

uses
  CGlobal;

var
  FDSeleccionarAltaEnvase: TFDSeleccionarAltaEnvase;

function SeleccionarTipoAlta( const AOwner: TComponent; var VTipo: integer; var VBD: string;
                              const ATitle: string = '     SELECCIONAR TIPO ALTA'; const ATextLocal: string = 'Nuevo' ): integer;
begin
  FDSeleccionarAltaEnvase:= TFDSeleccionarAltaEnvase.Create( AOwner );
  try
    FDSeleccionarAltaEnvase.Caption:= ATitle;
    FDSeleccionarAltaEnvase.rbNuevo.Caption:= ATextLocal;
    result:= FDSeleccionarAltaEnvase.ShowModal;
    VTipo:= FDSeleccionarAltaEnvase.GetTipo( VBD );
  finally
    FreeAndNil( FDSeleccionarAltaEnvase );
  end;
end;

procedure TFDSeleccionarAltaEnvase.btnOkClick(Sender: TObject);
begin
  ModalResult:= mrOk;
end;

procedure TFDSeleccionarAltaEnvase.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

function TFDSeleccionarAltaEnvase.GetTipo( var VBD: string ): Integer;
begin
  if rbNuevo.Checked  then
  begin
    Result:= 0;
    VBD:= '';
  end
  else if rbClonar.Checked then
  begin
    Result := 1;
    VBD:='';
  end
  else
  begin
    Result:= 2;
    if rbF17.Checked  then
    begin
      if gProgramVersion = pvBAG then
        VBD:= 'dbF17'
      else
        VBD:= 'dbLlanos';
    end
    else
    if rbF18.Checked  then
    begin
      if gProgramVersion = pvBAG then
        VBD:= 'dbF18'
      else
        VBD:= 'dbMoradas';
    end
    else
    if rbF23.Checked  then
    begin
      VBD:= 'dbF23';
    end;
    (*
    else
    if rbF24.Checked  then
    begin
      VBD:= 'dbF24';
    end;
    *)
  end;
end;

procedure TFDSeleccionarAltaEnvase.rbImportarClick(Sender: TObject);
begin
  pnlBD.Enabled:= rbImportar.Checked;
  rbF17.Enabled:= pnlBD.Enabled;
  rbF18.Enabled:= pnlBD.Enabled;
  rbF23.Enabled:= pnlBD.Enabled;
  //rbF24.Enabled:= pnlBD.Enabled;
end;

procedure TFDSeleccionarAltaEnvase.FormCreate(Sender: TObject);
begin
  rbNuevo.Checked:= True;

  if gProgramVersion = pvBAG then
  begin
    rbF17.Caption:= 'F17 - Chanita';
    rbF18.Caption:= 'F18 - P4H';
    rbF23.Caption:= 'F23 - Tenerife';
    //rbF24.Caption:= 'F24 - Sevilla';
    rbF17.Visible:= True;
    rbF18.Visible:= True;
    rbF23.Visible:= True;
    //rbF24.Visible:= True;
    rbF17.Checked:= True;

    rbF17.Enabled:= False;
    rbF18.Enabled:= False;
    rbF23.Enabled:= False;
    //rbF24.Enabled:= False;
  end
  else
  begin
    rbF17.Caption:= 'Los LLanos - Alicante';
    rbF18.Caption:= 'Las Moradas - Tenerife';
    rbF23.Caption:= '';
    //rbF24.Caption:= '';
    rbF17.Visible:= True;
    rbF18.Visible:= True;
    rbF23.Visible:= False;
    //rbF24.Visible:= False;
    rbF17.Checked:= True;

    rbF17.Enabled:= False;
    rbF18.Enabled:= False;
    rbF23.Enabled:= False;
    //rbF24.Enabled:= False;
  end;
end;

end.
