unit UFRejillaFacturacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  CMaestroDetalle, Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles,
   cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, DB, cxDBData, cxTextEdit, cxCurrencyEdit, Menus,
  cxContainer, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap,
  dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils, dxPSPrVwStd,
  dxPSPrVwAdv, dxPSPrVwRibbon, dxPScxPageControlProducer, dxPScxGridLnk,
  dxPScxGridLayoutViewLnk, dxPScxEditorProducers, dxPScxExtEditorProducers,
   dxBar, cxClasses, ActnList,
  dxPScxCommon, dxPSCore, dxPSContainerLnk, cxLabel, cxGroupBox, StdCtrls,
  cxButtons, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCustomView, cxGrid, ExtCtrls,

  dxSkinsCore, dxSkinscxPCPainter, dxSkinMoneyTwins, dxSkinBlue, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, dxSkinFoggy,
  dxSkinBlueprint;

type
  TFRejillaFacturacion = class(TForm)
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
    btnAceptar: TcxButton;
    btnCancelar: TcxButton;
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
    gbCriterio: TcxGroupBox;
    lb7: TcxLabel;
    txEmpresa: TcxTextEdit;
    txDesEmpresa: TcxTextEdit;
    lb8: TcxLabel;
    txCliente: TcxTextEdit;
    txDesCliente: TcxTextEdit;
    lb9: TcxLabel;
    txFechaFactura: TcxTextEdit;
    lb10: TcxLabel;
    txDesdeAlbaran: TcxTextEdit;
    lb11: TcxLabel;
    txHastaAlbaran: TcxTextEdit;
    lb12: TcxLabel;
    txFechaDesde: TcxTextEdit;
    lb13: TcxLabel;
    txPedido: TcxTextEdit;
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
    cxLabel1: TcxLabel;
    txFactura: TcxTextEdit;
    txFechaHasta: TcxTextEdit;
    cxlbl1: TcxLabel;
    cxLabel2: TcxLabel;
    txSerie: TcxTextEdit;
    tvDirSuministro: TcxGridDBColumn;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure btnExpandirClick(Sender: TObject);
    procedure btnContraerClick(Sender: TObject);
    procedure actExpandirExecute(Sender: TObject);
    procedure actContraerExecute(Sender: TObject);
    procedure cxGridEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRejillaFacturacion: TFRejillaFacturacion;

implementation

uses UDMBaseDatos, CAuxiliarDB, UDFactura;

{$R *.dfm}

procedure TFRejillaFacturacion.btnAceptarClick(Sender: TObject);
begin
    ModalResult:= mrOk;
end;

procedure TFRejillaFacturacion.btnCancelarClick(Sender: TObject);
begin
    ModalResult:= mrCancel;
end;

procedure TFRejillaFacturacion.actPreviewExecute(Sender: TObject);
begin
    dxComponentPrinter.Preview(True, nil);
end;

procedure TFRejillaFacturacion.actPrintExecute(Sender: TObject);
begin
    dxComponentPrinter.Print(True, nil, nil);
end;

procedure TFRejillaFacturacion.btnExpandirClick(Sender: TObject);
begin
 tvFacturas.ViewData.Expand(True);
end;

procedure TFRejillaFacturacion.btnContraerClick(Sender: TObject);
begin
  tvFacturas.ViewData.Collapse(True);
end;

procedure TFRejillaFacturacion.actExpandirExecute(Sender: TObject);
begin
 tvFacturas.ViewData.Expand(True);
end;

procedure TFRejillaFacturacion.actContraerExecute(Sender: TObject);
begin
  tvFacturas.ViewData.Collapse(True);
end;

procedure TFRejillaFacturacion.cxGridEnter(Sender: TObject);
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

    tvFacturas.DataController.SetValue(i,tvImpuesto.Index,sDesImpuesto);
  end;
  tvFacturas.EndUpdate;

end;
end.
