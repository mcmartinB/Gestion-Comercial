unit DInfSalidasSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFDInfSalidasSelect = class(TForm)
    PanelCompleto: TPanel;
    PanelBotones: TPanel;
    btnSi: TButton;
    btnNo: TButton;
    cbxFirma: TCheckBox;
    cbxAlbaran: TCheckBox;
    cbxCartaPorte: TCheckBox;
    cbxCMR: TCheckBox;
    cbxProforma: TCheckBox;
    cbxOriginalEmpresa: TCheckBox;
    cbbIdiomaAlbaran: TComboBox;
    rbProforma: TRadioButton;
    rbDespacho: TRadioButton;
    cbxDeclaracion: TCheckBox;
    procedure btnSiClick(Sender: TObject);
    procedure btnNoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    iResult: Integer;
  end;



function Seleccionar( var AImpresora, AIdioma: Integer; var APedirFirma, AOriginal: boolean ): Integer;

implementation

{$R *.dfm}

uses
  UDMConfig;

function Seleccionar( var AImpresora, AIdioma: Integer; var APedirFirma, AOriginal: boolean  ): Integer;
var
  FDInfSalidasSelect: TFDInfSalidasSelect;
begin
  FDInfSalidasSelect:= TFDInfSalidasSelect.Create( nil );
  with FDInfSalidasSelect do
  begin
    cbxAlbaran.Checked:= True;
    cbxCartaPorte.Checked:= DMConfig.sCentroInstalacion = '6';

    cbxFirma.Visible:= APedirFirma;
    cbxFirma.Checked:= False;
    cbxOriginalEmpresa.Visible:= DMConfig.EsChanita;
    cbxOriginalEmpresa.Checked:= not cbxOriginalEmpresa.Visible;
    if not cbxFirma.Visible then
    begin
      cbxOriginalEmpresa.Top:= cbxFirma.Top;
    end;

    //cbxCMR.Visible:= DMConfig.EsFrutibon;
    //xProforma.Visible:= not ( DMConfig.EsValenciaBonde or DMConfig.EsTenerifeBonde );

    if AIdioma = 3 then
      cbbIdiomaAlbaran.ItemIndex:= 2
    else if AIdioma = 2 then
      cbbIdiomaAlbaran.ItemIndex:= 1
    else
      cbbIdiomaAlbaran.ItemIndex:= 0;    

    iResult:= 0;
    ShowModal;
    result:= iResult;
    APedirFirma:= cbxFirma.Checked;
    AOriginal:= cbxOriginalEmpresa.Checked;
    //AImpresora:= cbxImpresora.ItemIndex;
    AIdioma:= cbbIdiomaAlbaran.ItemIndex;
  end;
  FreeAndNil( FDInfSalidasSelect );
end;


procedure TFDInfSalidasSelect.btnSiClick(Sender: TObject);
begin
  iResult:= 0;
  if cbxDeclaracion.Checked then
    iResult := iResult + 10000;
  if cbxAlbaran.Checked then
    iResult:= iResult + 1000;
  if cbxCartaPorte.Checked then
    iResult:= iResult + 100;
  if cbxCMR.Checked then
    iResult:= iResult + 10;
  if cbxProforma.Checked then
      if rbProforma.Checked then
      iResult:= iResult + 1
    else
      iResult:= iResult + 2;
  Close;
end;

procedure TFDInfSalidasSelect.btnNoClick(Sender: TObject);
begin
  iResult:= 0;
  Close;
end;

procedure TFDInfSalidasSelect.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F1 then
  begin
    key:= 0;
    btnSi.Click;
  end
  else
  if key = VK_ESCAPE then
  begin
    key:= 0;
    btnNo.Click;
  end;
end;

end.

