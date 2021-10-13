unit DInfSalidasSelectSimple;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFDInfSalidasSelectSimple = class(TForm)
    btnSi: TButton;
    btnNo: TButton;
    cbxAlbaran: TCheckBox;
    cbxCarta: TCheckBox;
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



function SeleccionarSimple( var AAlbaran, ACarta: Boolean ): Boolean;

implementation

{$R *.dfm}

function SeleccionarSimple( var AAlbaran, ACarta: Boolean ): Boolean;
var
  FDInfSalidasSelectSimple: TFDInfSalidasSelectSimple;
begin
  FDInfSalidasSelectSimple:= TFDInfSalidasSelectSimple.Create( nil );
  with FDInfSalidasSelectSimple do
  begin
    ShowModal;
    result:= iResult <> 0;
    AAlbaran:= ( iResult = 1 ) or ( iResult = 3 );
    ACarta:= ( iResult = 2 ) or ( iResult = 3 );
  end;
  FreeAndNil( FDInfSalidasSelectSimple );
end;


procedure TFDInfSalidasSelectSimple.btnSiClick(Sender: TObject);
begin
  if cbxAlbaran.Checked then
  begin
    if cbxCarta.Checked then
      iResult:= 3
    else
      iResult:= 1
  end
  else
  begin
    if cbxCarta.Checked then
      iResult:= 2;
  end;
  Close;
end;

procedure TFDInfSalidasSelectSimple.btnNoClick(Sender: TObject);
begin
  iResult:= 0;
  Close;
end;

procedure TFDInfSalidasSelectSimple.FormKeyDown(Sender: TObject; var Key: Word;
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
