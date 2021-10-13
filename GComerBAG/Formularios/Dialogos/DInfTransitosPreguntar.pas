unit DInfTransitosPreguntar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFDInfTransitosPreguntar = class(TForm)
    lblMsg: TLabel;
    btnSi: TButton;
    btnNo: TButton;
    procedure btnSiClick(Sender: TObject);
    procedure btnNoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    bResult: Boolean;
  end;

  function Preguntar( const AMsg: string ): boolean;

implementation

uses UDMConfig;

{$R *.dfm}

function Preguntar( const AMsg: string ): boolean;
var
  FDInfTransitosPreguntar: TFDInfTransitosPreguntar;
begin
  FDInfTransitosPreguntar:= TFDInfTransitosPreguntar.Create( Nil );
  FDInfTransitosPreguntar.lblMsg.Caption:= AMsg;
  with FDInfTransitosPreguntar do
  begin
    bResult:= False;
    ShowModal;
    result:= bResult;
  end;
  FreeAndNil( FDInfTransitosPreguntar );
end;

procedure TFDInfTransitosPreguntar.btnSiClick(Sender: TObject);
begin
  bResult:= True;
  Close;
end;

procedure TFDInfTransitosPreguntar.btnNoClick(Sender: TObject);
begin
  bResult:= False;
  Close;
end;

procedure TFDInfTransitosPreguntar.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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
