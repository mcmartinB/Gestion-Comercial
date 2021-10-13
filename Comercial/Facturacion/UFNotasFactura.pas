unit UFNotasFactura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  CMaestroDetalle, Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxBar, cxClasses, cxTextEdit, cxMemo,
  cxGroupBox,

  dxSkinsCore, dxSkinBlue,  dxSkinFoggy, dxSkinsdxBarPainter, dxSkinMoneyTwins;

type
  TFNotasFactura = class(TForm)
    bmxBarManager: TdxBarManager;
    bmx1Bar1: TdxBar;
    btnAceptar: TdxBarButton;
    b1: TdxBarButton;
    gb1: TcxGroupBox;
    mmxNotas: TcxMemo;
    procedure btnAceptarClick(Sender: TObject);
    procedure b1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNotasFactura: TFNotasFactura;

implementation

{$R *.dfm}

uses UDFactura;

procedure TFNotasFactura.btnAceptarClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFNotasFactura.b1Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
