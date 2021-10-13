unit dlgAcercaDe;

interface

uses
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, jpeg, {mini} Windows, OleCtrls;

type
  TDAcercaDe = class(TForm)
    Image1: TImage;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses CVariables, Principal;

procedure TDAcercaDe.FormCreate(Sender: TObject);
begin
  if FileExists( 'recursos\ComerPassword.emf' ) then
    Image1.Picture.LoadFromFile('recursos\ComerPassword.emf');
end;

procedure TDAcercaDe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TDAcercaDe.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape, vk_f1, vk_return:
      begin
        Close;
      end;
  end;
end;

procedure TDAcercaDe.Image1Click(Sender: TObject);
begin
  Close;
end;

end.
