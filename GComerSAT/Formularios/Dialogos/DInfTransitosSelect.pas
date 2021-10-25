unit DInfTransitosSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFDInfTransitosSelect = class(TForm)
    btnSi: TButton;
    btnNo: TButton;
    cbxAlbaran: TCheckBox;
    cbxCMR: TCheckBox;
    cbxFacturaTransito: TCheckBox;
    cbxCertificadoLAME: TCheckBox;
    cbxCartaPorte: TCheckBox;
    procedure btnSiClick(Sender: TObject);
    procedure btnNoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    //bAlbaran: boolean;
  public
    { Public declarations }
    iResult: Integer;

  end;

procedure Seleccionar( var AAlbaran, ACartaPorte, ACMR, AFactura, ACertificado, ACertificadoLame: boolean );

implementation

uses UDMConfig;

{$R *.dfm}

procedure Seleccionar ( var AAlbaran, ACartaPorte, ACMR, AFActura, ACertificado, ACertificadoLame: boolean);
var FDInfTransitosSelect: TFDInfTransitosSelect;
begin
  FDInfTransitosSelect:= TFDInfTransitosSelect.Create( nil );
  with FDInfTransitosSelect do
  begin
    cbxCertificadoLAME.Enabled := ACertificadoLame;
    ShowModal;

    if cbxAlbaran.Checked then
      begin
        AAlbaran := true;
      end;

    if cbxCartaPorte.Checked then
    begin
      ACartaPorte := true;
    end;

    if cbxCMR.Checked then
      begin
        ACMR := true;
      end;

      if cbxFacturaTransito.Checked then
      begin
        AFActura := true;
      end;

      if cbxCertificadoLAME.Checked then
      begin
        ACertificado := true;
      end;
  end;
    FreeAndNil( FDInfTransitosSelect );
end;

procedure TFDInfTransitosSelect.btnSiClick(Sender: TObject);
begin
  Close;
end;

procedure TFDInfTransitosSelect.btnNoClick(Sender: TObject);
begin
  iResult:= 0;
  Close;
end;

procedure TFDInfTransitosSelect.FormKeyDown(Sender: TObject; var Key: Word;
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
