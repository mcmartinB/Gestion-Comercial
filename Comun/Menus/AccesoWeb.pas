unit AccesoWeb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  dxSkinsCore, dxSkinBlue, dxSkinFoggy, cxControls, cxContainer, cxEdit,
  cxLabel, StdCtrls, cxButtons, urlMon;

type
  TFAccesoWeb = class(TForm)
    cxAcceso: TcxButton;
    cxLabel1: TcxLabel;
    procedure cxAccesoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAccesoWeb: TFAccesoWeb;

implementation

{$R *.dfm}

procedure TFAccesoWeb.cxAccesoClick(Sender: TObject);
var sDireccion : String;
begin
sDireccion := 'http://comer.bonnysa.net';
HLinkNavigateString(NIL, PWideChar(WideString(sDireccion)) );
end;

end.
