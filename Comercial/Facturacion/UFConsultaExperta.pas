unit UFConsultaExperta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  CMaestroDetalle, Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit,  Menus,  dxBar, cxClasses, StdCtrls,
  cxButtons, SimpleSearch, cxTextEdit, cxLabel,

  dxSkinsCore, dxSkinBlue, dxSkinFoggy, dxSkinsdxBarPainter, dxSkinMoneyTwins,
  dxSkinBlueprint;

type
  TFConsultaExperta = class(TForm)
    cxEmpresa: TcxLabel;
    cxNumFactura: TcxLabel;
    cxFecFactura: TcxLabel;
    txEmpresa: TcxTextEdit;
    txNumFactura: TcxTextEdit;
    txFecFactura: TcxTextEdit;
    dxBarManager: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxAceptar: TdxBarButton;
    dxCancelar: TdxBarButton;
    lb1: TcxLabel;
    txCliente: TcxTextEdit;
    lb2: TcxLabel;
    txAnoFactura: TcxTextEdit;
    cxLabel1: TcxLabel;
    txCodFactura: TcxTextEdit;
    procedure dxCancelarClick(Sender: TObject);
    procedure dxAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private

  public
    cadena: String;
  end;

var
  FConsultaExperta: TFConsultaExperta;

implementation

uses UDFactura;

{$R *.dfm}

procedure TFConsultaExperta.dxCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TFConsultaExperta.dxAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOk;
end;

procedure TFConsultaExperta.FormClose(Sender: TObject; var Action: TCloseAction);
var sFechaIni, sFechaFin: String;
begin
  cadena := '';

  if (txEmpresa.Text <> '') or (txNumFactura.Text <> '') or (txFecFactura.Text <> '') or (txCliente.Text <> '' ) or
     (txAnoFactura.Text <> '') or (txCodFactura.Text <> '') then
  begin
    if txEmpresa.Text <> '' then
      cadena := cadena + ' AND cod_empresa_fac_fc = ' + QuotedStr(txEmpresa.Text);
    if txNumFactura.Text <> '' then
      cadena := cadena + ' AND n_factura_fc = ' + txNumFactura.Text;
    if txFecFactura.Text <> '' then
      cadena := cadena + ' AND fecha_factura_fc = ' + QuotedStr(txFecFactura.Text);
    if txCliente.Text <> '' then
      cadena := cadena + ' AND cod_cliente_fc = ' + QuotedStr(txCliente.Text);
    if txAnoFactura.Text <> '' then
    begin
      sFechaIni := DateToStr(EncodeDate(StrToInt(txAnoFactura.Text),1,1));
      sFechaFin := DateToStr(EncodeDate(StrToInt(txAnoFactura.Text),12,31));
      cadena := cadena + ' AND fecha_factura_fc BETWEEN ' + QuotedStr(sFechaIni) + ' AND ' + QuotedStr(sFechaFin);
//      cadena := cadena + ' AND YEAR(fecha_factura_fc) = ' + txAnoFactura.Text;
    end;
    if txCodFactura.Text <> '' then
      cadena := cadena + ' AND cod_factura_fc = ' + QuotedStr(txCodFactura.Text);
  end;

end;

procedure TFConsultaExperta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    $0D, $28: //vk_return,vk_down
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;
    $26: //vk_up
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        Exit;
      end;
    VK_F1:
        if dxAceptar.Enabled then dxAceptarClick(Self);
  end;
end;

end.
