unit UFConsultaExpertaRem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, ComCtrls, ToolWin,
  cxTextEdit, cxLabel, dxBar, cxClasses, Menus,
  StdCtrls, cxButtons, SimpleSearch,

  dxSkinsCore, dxSkinBlue, dxSkinFoggy, dxSkinsdxBarPainter, dxSkinMoneyTwins,
  dxSkinBlueprint;

type
  TFConsultaExpertaRem = class(TForm)
    cxEmpresa: TcxLabel;
    cx5: TcxLabel;
    txEmpresa: TcxTextEdit;
    txNumRemesa: TcxTextEdit;
    dxBarManager: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxAceptar: TdxBarButton;
    dxCancelar: TdxBarButton;
    lb1: TcxLabel;
    txCliente: TcxTextEdit;
    cxLabel1: TcxLabel;
    txFecVto: TcxTextEdit;
    cxLabel2: TcxLabel;
    txFecDes: TcxTextEdit;
    cxLabel3: TcxLabel;
    txBanco: TcxTextEdit;
    procedure dxCancelarClick(Sender: TObject);
    procedure dxAceptarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure MontarQuery;

  public
    cadena: String;
    selecEmpresa, selecRemesa: string;
  end;

var
  FConsultaExpertaRem: TFConsultaExpertaRem;

implementation

uses UDFactura, UFConsultaRem;

{$R *.dfm}

procedure TFConsultaExpertaRem.dxCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TFConsultaExpertaRem.MontarQuery;
begin
    cadena := ' WHERE 1=1 ';

  if (txEmpresa.Text <> '') or (txCliente.Text <> '') or (txNumRemesa.Text <> '') or (txFecVto.Text <> '' ) or
     (txFecDes.Text <> '') or (txBanco.Text <> '')  then
  begin
    if txEmpresa.Text <> '' then
      cadena := cadena + ' AND empresa_remesa_rc = ' + QuotedStr(txEmpresa.Text);
    if txCliente.Text <> '' then
      cadena := cadena + ' AND cod_cliente_rc = ' + QuotedStr(txCliente.Text);
    if txNumRemesa.Text <> '' then
      cadena := cadena + ' AND n_remesa_rc = ' + txNumRemesa.Text;
    if txFecVto.Text <> '' then
      cadena := cadena + ' AND fecha_vencimiento_rc = ' + QuotedStr(txFecVto.Text);
    if txFecDes.Text <> '' then
      cadena := cadena + ' AND fecha_descuento_rc = ' + txFecDes.Text;
    if txBanco.Text <> '' then
      cadena := cadena + ' AND cod_banco_rc = ' + txBanco.Text;
  end;
end;

procedure TFConsultaExpertaRem.dxAceptarClick(Sender: TObject);
begin

  MontarQuery;

  FConsultaRem:= TFConsultaRem.Create( Self );
    try
      FConsultaRem.CadenaCon := cadena;
      FConsultaRem.ShowModal;
    finally
      ModalResult := FConsultaRem.ModalResult;

      selecEmpresa := FConsultaRem.sEmpresa;
      selecRemesa := FConsultaRem.sRemesa;
      FreeAndNil(FConsultaRem);
    end;
  //ModalResult:= mrOk;
end;

procedure TFConsultaExpertaRem.FormKeyDown(Sender: TObject; var Key: Word;
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
