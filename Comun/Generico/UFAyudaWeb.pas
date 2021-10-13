unit UFAyudaWeb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw;

type
  TFAyudaWeb = class(TForm)
    WebBrowser: TWebBrowser;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ExecuteAyudaWeb( const AOwner: TComponent; Const ARuta: string );

implementation

{$R *.dfm}

procedure ExecuteAyudaWeb( const AOwner: TComponent; Const ARuta: string );
begin
  if FileExists( ARuta ) then
  begin
    with TFAyudaWeb.Create( AOwner ) do
    begin
      WebBrowser.Navigate( 'file:///' + ARuta );
      ShowModal;
    end;
  end
  else
  begin
    ShowMessage('No se encuentra el fichero de ayuda.' + #13 + #10 + '-> ' + ARuta );
  end;
end;

procedure TFAyudaWeb.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_escape then
    Close;
end;

end.
