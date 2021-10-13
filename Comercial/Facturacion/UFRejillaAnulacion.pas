unit UFRejillaAnulacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles,  ActnList, dxPScxCommon, dxPSCore,
  dxPSContainerLnk, ComCtrls, ToolWin, StdCtrls, cxButtons, cxLabel,
  cxGridLevel, cxGridBandedTableView, cxGridDBBandedTableView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, ExtCtrls, dxBar, cxImage, cxBarEditItem,
  cxGroupBox, cxCheckBox, dxBarBuiltInMenu, cxPC, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, DB, cxDBData, cxTextEdit,
  cxCurrencyEdit, Menus, cxContainer, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg,
  dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils,
  dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon, dxPScxPageControlProducer,
  dxPScxGridLnk, dxPScxGridLayoutViewLnk, dxPScxEditorProducers,
  dxPScxExtEditorProducers,

  dxSkinsCore, dxSkinBlue, dxSkinFoggy, dxSkinscxPCPainter, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter,
  dxSkinBlueprint, dxSkinMoneyTwins;

type
  TFRejillaAnulacion = class(TForm)
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
    tvMarca: TcxGridDBColumn;
    cxTabControl: TcxTabControl;
    btnMarcar: TcxButton;
    btnDesmarcar: TcxButton;
    tvFecha: TcxGridDBColumn;
    tvCodigoFac: TcxGridDBColumn;
    tvDesImpuesto: TcxGridDBColumn;
    actCancelar: TAction;
    actAceptar: TAction;
    cxLabel1: TcxLabel;
    txSerie: TcxTextEdit;
    tvSerie: TcxGridDBColumn;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure btnExpandirClick(Sender: TObject);
    procedure btnContraerClick(Sender: TObject);
    procedure actExpandirExecute(Sender: TObject);
    procedure actContraerExecute(Sender: TObject);
    procedure cxGridEnter(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure tvDesImpuestoGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: String);
    procedure tvMarcaPropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actAceptarExecute(Sender: TObject);
  private
    procedure ActTemporal;

  public

  end;

var
  FRejillaAnulacion: TFRejillaAnulacion;

implementation

uses UDMBaseDatos, CAuxiliarDB, UDFactura, UFAnuFacturas;

{$R *.dfm}

procedure TFRejillaAnulacion.btnAceptarClick(Sender: TObject);
begin
    ActTemporal;
    ModalResult:= mrOk;
end;

procedure TFRejillaAnulacion.btnCancelarClick(Sender: TObject);
begin
    ModalResult:= mrCancel;
end;

procedure TFRejillaAnulacion.actPreviewExecute(Sender: TObject);
begin
    dxComponentPrinter.Preview(True, nil);
end;

procedure TFRejillaAnulacion.actPrintExecute(Sender: TObject);
begin
    dxComponentPrinter.Print(True, nil, nil);
end;

procedure TFRejillaAnulacion.btnExpandirClick(Sender: TObject);
begin
 tvFacturas.ViewData.Expand(True);
end;

procedure TFRejillaAnulacion.btnContraerClick(Sender: TObject);
begin
  tvFacturas.ViewData.Collapse(True);
end;

procedure TFRejillaAnulacion.actExpandirExecute(Sender: TObject);
begin
 tvFacturas.ViewData.Expand(True);
end;

procedure TFRejillaAnulacion.actContraerExecute(Sender: TObject);
begin
  tvFacturas.ViewData.Collapse(True);
end;

procedure TFRejillaAnulacion.cxGridEnter(Sender: TObject);
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
procedure TFRejillaAnulacion.btnMarcarClick(Sender: TObject);
var i: integer;
begin
  tvFacturas.BeginUpdate;
  for i:=0 to tvFacturas.DataController.RecordCount-1 do
    tvFacturas.DataController.SetValue(i,tvMarca.Index, True);
  tvFacturas.EndUpdate;
  btnAceptar.Enabled := True;
end;

procedure TFRejillaAnulacion.btnDesmarcarClick(Sender: TObject);
var i:Integer;
begin
  tvFacturas.BeginUpdate;
  for i:=0 to tvFacturas.DataController.RecordCount-1 do
    tvFacturas.DataController.SetValue(i,tvMarca.Index, False);
  tvFacturas.EndUpdate;
  btnAceptar.Enabled := False;
end;

procedure TFRejillaAnulacion.tvDesImpuestoGetDisplayText(
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

procedure TFRejillaAnulacion.tvMarcaPropertiesChange(Sender: TObject);
var i: Integer;
begin
  btnAceptar.Enabled := false;
  for i:= 0 to tvFacturas.Datacontroller.RecordCount-1 do
    if tvFacturas.DataController.GetValue(i, tvMarca.Index) = True then
    begin
      btnAceptar.Enabled := true;
      exit;
    end;
end;

procedure TFRejillaAnulacion.FormShow(Sender: TObject);
begin
  btnAceptar.Enabled := False;  
end;

procedure TFRejillaAnulacion.ActTemporal;
var i: integer;
    sFactura: String;
begin
  for i:= 0 to tvFacturas.Datacontroller.RecordCount-1 do
    if tvFacturas.DataController.GetValue(i, tvMarca.Index) = True then
    begin
      sFactura := tvFacturas.Datacontroller.GetValue(i, tvCodigoFac.Index);
      if FAnuFacturas.mtFactAnula.locate('cod_factura', sFactura, [] ) then
      begin
        if not (FAnuFacturas.mtFactAnula.State in dsEditModes)then
          FAnuFacturas.mtFactAnula.Edit;
        FAnuFacturas.mtFactAnula.FieldByname('anular').AsBoolean := true;
      end
    end;

end;

procedure TFRejillaAnulacion.actCancelarExecute(Sender: TObject);
begin
  btnCancelar.Click;
end;

procedure TFRejillaAnulacion.actAceptarExecute(Sender: TObject);
begin
  if btnAceptar.Enabled then
    btnAceptar.Click;
end;

end.
