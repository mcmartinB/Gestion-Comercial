unit UFRejillaAnuladas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, DB,
  cxDBData, cxTextEdit, cxCurrencyEdit, cxContainer, Menus, dxPSGlbl,
  dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport,
  cxDrawTextUtils, dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon,
  dxPScxPageControlProducer, dxPScxGridLnk, dxPScxGridLayoutViewLnk,
  dxPScxEditorProducers, dxPScxExtEditorProducers,
  ActnList, dxPScxCommon, dxPSCore,
  dxPSContainerLnk, ComCtrls, ToolWin, StdCtrls, cxButtons, cxLabel,
  cxGridLevel, cxGridBandedTableView, cxGridDBBandedTableView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, ExtCtrls, dxBar, cxImage, cxBarEditItem,
  cxGroupBox, cxCheckBox, dxBarBuiltInMenu, cxPC,

  dxSkinsCore, dxSkinBlue, dxSkinFoggy, dxSkinscxPCPainter, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter,
  dxSkinBlueprint, dxSkinMoneyTwins;

type
  TFRejillaAnuladas = class(TForm)
    pnl2: TPanel;
    cxGrid: TcxGrid;
    tvFacturas: TcxGridDBTableView;
    tvEmpresa: TcxGridDBColumn;
    tvImpuesto: TcxGridDBColumn;
    tvMoneda: TcxGridDBColumn;
    tvImporteNeto: TcxGridDBColumn;
    tvImporteImpuesto: TcxGridDBColumn;
    tvImporteTotal: TcxGridDBColumn;
    tvDetalle: TcxGridDBTableView;
    tvEmpresaAlb: TcxGridDBColumn;
    tvCentroAlb: TcxGridDBColumn;
    tvFechaAlbaran: TcxGridDBColumn;
    tvAlbaran: TcxGridDBColumn;
    tvProducto: TcxGridDBColumn;
    tvDesProducto: TcxGridDBColumn;
    tvImporteNetoDet: TcxGridDBColumn;
    tvImporteImpuestoDet: TcxGridDBColumn;
    tvImporteTotalDet: TcxGridDBColumn;
    lvFacturas: TcxGridLevel;
    lvDetalle: TcxGridLevel;
    dxComponentPrinter: TdxComponentPrinter;
    actlst1: TActionList;
    actPreview: TAction;
    actPrint: TAction;
    dxComponentPrinterLink1: TdxCustomContainerReportLink;
    dxComponentPrinterLink2: TdxGridReportLink;
    dxBarManager1: TdxBarManager;
    bmPrincipal: TdxBar;
    actExpandir: TAction;
    actContraer: TAction;
    dxPreview: TdxBarLargeButton;
    dxPrint: TdxBarLargeButton;
    dxExpandir: TdxBarLargeButton;
    dxContraer: TdxBarLargeButton;
    tvCliente: TcxGridDBColumn;
    tvDesCliente: TcxGridDBColumn;
    lvGastos: TcxGridLevel;
    tvGastos: TcxGridDBTableView;
    tvGasEmpresaAlb: TcxGridDBColumn;
    tvGasCentroAlb: TcxGridDBColumn;
    tvGasFechaAlb: TcxGridDBColumn;
    tvGasAlbaran: TcxGridDBColumn;
    tvGasTipo: TcxGridDBColumn;
    tvGasDesTipo: TcxGridDBColumn;
    tvGasImporteNeto: TcxGridDBColumn;
    tvGasImpuesto: TcxGridDBColumn;
    tvGasImporteTotal: TcxGridDBColumn;
    tvImporteLinea: TcxGridDBColumn;
    tvImpDescuento: TcxGridDBColumn;
    tvFecha: TcxGridDBColumn;
    tvCodigoFac: TcxGridDBColumn;
    tvDesImpuesto: TcxGridDBColumn;
    dxFactura: TdxBarLargeButton;
    dxSalir: TdxBarLargeButton;
    actCancelar: TAction;
    actFactura: TAction;
    tvSerie: TcxGridDBColumn;
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure btnExpandirClick(Sender: TObject);
    procedure btnContraerClick(Sender: TObject);
    procedure actExpandirExecute(Sender: TObject);
    procedure actContraerExecute(Sender: TObject);
    procedure cxGridEnter(Sender: TObject);
    procedure tvDesImpuestoGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: String);
    procedure dxSalirClick(Sender: TObject);
    procedure dxFacturaClick(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actFacturaExecute(Sender: TObject);
  private

  public

  end;

var
  FRejillaAnuladas: TFRejillaAnuladas;

implementation

uses UDMBaseDatos, CAuxiliarDB, UDFactura, UFAnuFacturas;

{$R *.dfm}

procedure TFRejillaAnuladas.actPreviewExecute(Sender: TObject);
begin
    dxComponentPrinter.Preview(True, nil);
end;

procedure TFRejillaAnuladas.actPrintExecute(Sender: TObject);
begin
    dxComponentPrinter.Print(True, nil, nil);
end;

procedure TFRejillaAnuladas.btnExpandirClick(Sender: TObject);
begin
 tvFacturas.ViewData.Expand(True);
end;

procedure TFRejillaAnuladas.btnContraerClick(Sender: TObject);
begin
  tvFacturas.ViewData.Collapse(True);
end;

procedure TFRejillaAnuladas.actExpandirExecute(Sender: TObject);
begin
 tvFacturas.ViewData.Expand(True);
end;

procedure TFRejillaAnuladas.actContraerExecute(Sender: TObject);
begin
  tvFacturas.ViewData.Collapse(True);
end;

procedure TFRejillaAnuladas.cxGridEnter(Sender: TObject);
var sImpuesto, sDesImpuesto: String;
    i: Integer;
begin
  tvFacturas.BeginUpdate;
  for i:=0 to tvFacturas.DataController.RecordCount-1 do
  begin
    sImpuesto := tvFacturas.DataController.GetValue(i, tvImpuesto.Index);
    if sImpuesto = 'I' then
      sDesImpuesto := 'IVA'
    else if sImpuesto = 'G' then
      sDesImpuesto := 'IGIC'
    else if sImpuesto = 'E' then
      sDesImpuesto := 'EXENTO'
    else sDesImpuesto := 'ERROR';

    tvFacturas.DataController.SetValue(i,tvDesImpuesto.Index,sDesImpuesto);
  end;
  tvFacturas.EndUpdate;
end;
procedure TFRejillaAnuladas.tvDesImpuestoGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
var AImpuesto: Variant;
begin
  if tvFacturas.GetColumnByFieldName('impuesto_fc') <> nil then
    AImpuesto := ARecord.Values[tvFacturas.GetColumnByFieldName('impuesto_fc').Index]
  else
    AImpuesto := null;

  if AImpuesto = 'I'then
    AText := 'IVA'
  else if AImpuesto = 'G' then
    AText := 'IGIC'
  else
    AText := 'EXENTO';
end;

procedure TFRejillaAnuladas.dxSalirClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFRejillaAnuladas.dxFacturaClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFRejillaAnuladas.actCancelarExecute(Sender: TObject);
begin
  dxSalir.Click;
end;

procedure TFRejillaAnuladas.actFacturaExecute(Sender: TObject);
begin
  dxFactura.Click;
end;

end.
