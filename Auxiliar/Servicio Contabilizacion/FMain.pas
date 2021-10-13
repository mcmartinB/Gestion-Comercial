unit FMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TMainF = class(TForm)
    btnConta: TButton;
    procedure btnContaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainF: TMainF;

implementation

uses UDMServicio;

{$R *.dfm}

procedure TMainF.btnContaClick(Sender: TObject);
begin
  DMServicio.EjecutarConta;
end;

end.
