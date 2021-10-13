unit DObservaciones;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ActnList;

type
  TFDObservaciones = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Memo: TMemo;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FDObservaciones: TFDObservaciones;

implementation

{$R *.DFM}

procedure TFDObservaciones.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_F1:
      begin
        BitBtn1.Click;
      end;
    vk_escape:
      begin
        BitBtn2.Click;
      end;
  end;
end;

end.
