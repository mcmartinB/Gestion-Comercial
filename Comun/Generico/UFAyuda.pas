unit UFAyuda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFAyuda = class(TForm)
    mmoTexto: TMemo;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure ExecuteAyuda( const AOwner: TComponent; Const ATexto: string );

implementation

{$R *.dfm}

procedure ExecuteAyuda( const AOwner: TComponent; Const ATexto: string );
begin
  with TFAyuda.Create( AOwner ) do
  begin
    mmoTexto.Lines.Add( ATexto );
    ShowModal;
  end;
end;

procedure TFAyuda.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_escape then
    Close;
end;

end.
