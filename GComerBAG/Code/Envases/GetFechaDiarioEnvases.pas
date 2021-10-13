unit GetFechaDiarioEnvases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, nbEdits, nbCombos;

type
  TFDGetFechaDiarioEnvases = class(TForm)
    lblMsg: TLabel;
    btnSi: TButton;
    btnNo: TButton;
    edtFecha: TnbDBCalendarCombo;
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


  function Preguntar( const ACaption, AMsg: string; var ADate: TDateTime ): boolean;

implementation

{$R *.dfm}

uses UDMConfig, CVariables;

function Preguntar( const ACaption, AMsg: string; var ADate: TDateTime ): boolean;
var
  FDGetFechaDiarioEnvases: TFDGetFechaDiarioEnvases;
begin
  FDGetFechaDiarioEnvases:= TFDGetFechaDiarioEnvases.Create( Nil );
  try
    with FDGetFechaDiarioEnvases do
    begin
      bResult:= False;
      lblMsg.Caption:= AMsg;
      Caption:= ACaption;
      edtFecha.AsDate:= ADate;
      ShowModal;
      result:= bResult;
      if result then
        ADate:= edtFecha.AsDate;
    end;
  finally
    FreeAndNil( FDGetFechaDiarioEnvases );
  end;
end;

procedure TFDGetFechaDiarioEnvases.btnSiClick(Sender: TObject);
begin
  bResult:= True;
  Close;
end;

procedure TFDGetFechaDiarioEnvases.btnNoClick(Sender: TObject);
begin
  bResult:= False;
  Close;
end;

procedure TFDGetFechaDiarioEnvases.FormKeyDown(Sender: TObject;
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
