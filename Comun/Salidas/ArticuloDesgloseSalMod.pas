unit ArticuloDesgloseSalMod;

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
  cxGridDBTableView, cxGridCustomView, cxGrid, ExtCtrls, BonnyClientDataSet,

  dxSkinsCore, dxSkinscxPCPainter, dxSkinBlue, dxSkinFoggy, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter,
  dxSkinBlueprint, dxSkinMoneyTwins;

type
  TFArticuloDesgloseSalMod = class(TForm)
    pnl2: TPanel;
    cxGrid: TcxGrid;
    tvArticuloDesgloseSal: TcxGridDBTableView;
    tvProductoDesglose: TcxGridDBColumn;
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
    lvArticuloDesgloseSal: TcxGridLevel;
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
    gbCriterio: TcxGroupBox;
    lb7: TcxLabel;
    txtEmpresa: TcxTextEdit;
    txtDesEmpresa: TcxTextEdit;
    lb8: TcxLabel;
    txtArticulo: TcxTextEdit;
    txtDesArticulo: TcxTextEdit;
    lb9: TcxLabel;
    txtKilosTotal: TcxTextEdit;
    lb10: TcxLabel;
    tvPorcentajeDesglose: TcxGridDBColumn;
    tvKilosDesglose: TcxGridDBColumn;
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
    actPrevisualizar: TAction;
    actCancelar: TAction;
    txtCentro: TcxTextEdit;
    txtDesCentro: TcxTextEdit;
    cxLabel1: TcxLabel;
    txtAlbaran: TcxTextEdit;
    cxLabel2: TcxLabel;
    txtFechaAlb: TcxTextEdit;
    cxLabel3: TcxLabel;
    txtProducto: TcxTextEdit;
    txtDesProducto: TcxTextEdit;
    tvDesProductoDes: TcxGridDBColumn;
    dsQSalidasL2: TDataSource;
    cxLabel4: TcxLabel;
    txtIdAlbaran: TcxTextEdit;
    tvSalidasL2: TcxGridDBTableView;
    tvSalidasL2Column1: TcxGridDBColumn;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExpandirClick(Sender: TObject);
    procedure btnContraerClick(Sender: TObject);
    procedure actExpandirExecute(Sender: TObject);
    procedure actContraerExecute(Sender: TObject);
    procedure actPrevisualizarExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure tvDesProductoDesGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tvPorcentajeDesglosePropertiesEditValueChanged(Sender: TObject);
    procedure dsQSalidasL2DataChange(Sender: TObject; Field: TField);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    QSalidasL2: TBonnyClientDataSet;
    procedure CreaQSalidasL2;
    function EjecutaQSalidasL2: boolean;
    function DesgloseCompleto:boolean;

  public
    { Public declarations }
  end;

type
  TcxCustomEditAccess = class(TcxCustomEdit);

var
  FArticuloDesgloseSalMod: TFArticuloDesgloseSalMod;

implementation

uses UDMBaseDatos, CAuxiliarDB, UDMAuxDB;

{$R *.dfm}

procedure TFArticuloDesgloseSalMod.btnAceptarClick(Sender: TObject);
begin
  if MessageDlg('¿Desea Actualizar Cambios?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    QSalidasL2.ApplyUpdates(0);
    ModalResult:= mrOk;
  end;
end;

procedure TFArticuloDesgloseSalMod.btnCancelarClick(Sender: TObject);
begin
  if MessageDlg('¿Desea salir del Desglose de Producto?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    ModalResult:= mrCancel;
end;

procedure TFArticuloDesgloseSalMod.btnExpandirClick(Sender: TObject);
begin
 tvArticuloDesgloseSal.ViewData.Expand(True);
end;

procedure TFArticuloDesgloseSalMod.CreaQSalidasL2;
begin
  QSalidasL2 := TBonnyClientDataSet.Create(Self);
  dsQSalidasL2.DataSet := QSalidasL2;

  with QSalidasL2 do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_salidas_l2 ');
    SQL.Add('  where empresa_sl2 = :empresa ');
    SQL.Add('    and centro_salida_sl2 = :centro ');
    SQL.Add('    and n_albaran_sl2 = :albaran ');
    SQL.Add('    and fecha_sl2 = :fecha ');
    SQL.Add('    and id_linea_albaran_sl2 = :idlinea ');
    SQL.Add(' order by  empresa_sl2, centro_salida_sl2, n_albaran_sl2, fecha_sl2, id_linea_albaran_sl2, articulo_sl2, producto_desglose_sl2 ');
  end;
end;

function TFArticuloDesgloseSalMod.DesgloseCompleto: boolean;
var i:integer;
    rPorcentaje: Real;
begin
  rPorcentaje := 0;
  for i := 0 to tvArticuloDesgloseSal.DataController.RecordCount - 1 do
  begin
    rPorcentaje := rPorcentaje + tvArticuloDesgloseSal.DataController.Values[i,tvPorcentajeDesglose.index];
  end;
  if rPorcentaje = 100 then
    result := true
  else
    result := false;

end;

procedure TFArticuloDesgloseSalMod.dsQSalidasL2DataChange(Sender: TObject;
  Field: TField);
begin
  if DesgloseCompleto then
    btnAceptar.Enabled := true
  else
    btnAceptar.Enabled := false;
end;

function TFArticuloDesgloseSalMod.EjecutaQSalidasL2: boolean;
begin
  with QSalidasL2 do
  begin
    if Active then
      Close;
    ParamByName('empresa').AsString := txtEmpresa.Text;
    ParamByName('centro').AsString := txtCentro.Text;
    ParamByName('albaran').AsString := txtAlbaran.Text;
    ParamByName('fecha').AsString := txtFechaAlb.Text;
    ParamByName('idlinea').AsString := txtIdAlbaran.Text;

    Open;
    Result := not IsEmpty;
  end;
end;

procedure TFArticuloDesgloseSalMod.FormCreate(Sender: TObject);
begin
  CreaQSalidasL2;
end;

procedure TFArticuloDesgloseSalMod.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{
  if key = VK_RETURN then //vk_return,vk_down
  begin
    if tvArticuloDesgloseSal.Focused then
      tvArticuloDesgloseSal.DataController.
    end;
  end;
}
end;

procedure TFArticuloDesgloseSalMod.FormShow(Sender: TObject);
var columncIndex : integer;
    b: boolean;
begin
  if not EjecutaQSalidasL2 then
  begin
    ShowMessage(' ATENCION! No existe desglose para la linea de albaran. Consultar con Informatica ');
    exit;
  end;

  b := True;
  cxGrid.Setfocus;
  columncIndex := tvArticuloDesgloseSal.GetColumnByFieldName('porcentaje_sl2').index;
  tvArticuloDesgloseSal.DataController.FocusControl(columncIndex, b);

end;

procedure TFArticuloDesgloseSalMod.btnContraerClick(Sender: TObject);
begin
  tvArticuloDesgloseSal.ViewData.Collapse(True);
end;

procedure TFArticuloDesgloseSalMod.actExpandirExecute(Sender: TObject);
begin
 tvArticuloDesgloseSal.ViewData.Expand(True);
end;

procedure TFArticuloDesgloseSalMod.actContraerExecute(Sender: TObject);
begin
  tvArticuloDesgloseSal.ViewData.Collapse(True);
end;

procedure TFArticuloDesgloseSalMod.tvDesProductoDesGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
  var AProducto: Variant;
begin
  if tvArticuloDesgloseSal.GetColumnByFieldName('producto_desglose_sl2') <> nil then
    AProducto := ARecord.Values[tvArticuloDesgloseSal.GetColumnByFieldName('producto_desglose_sl2').Index]
  else
    AProducto := null;

  AText := DesProducto('', AProducto);
end;

procedure TFArticuloDesgloseSalMod.tvPorcentajeDesglosePropertiesEditValueChanged(
  Sender: TObject);
var rKilosTotal, rKilosDesglose, rPorcentaje: Currency;
    sPorcentaje: String;
begin
  tvArticuloDesgloseSal.BeginUpdate;
  rKilosTotal := StrToFloat(txtKilosTotal.Text);
  sPorcentaje := VarToStr(TcxCustomEditAccess(Sender).EditValue);
  rPorcentaje := StrToFloat(sPorcentaje);
  rKilosDesglose := rKilosTotal * rPorcentaje/100;

  if not (tvArticuloDesgloseSal.DataController.DataSet.State in dsEditModes) then
    tvArticuloDesgloseSal.DataController.DataSet.Edit;
  tvArticuloDesgloseSal.DataController.DataSet.FieldByName('porcentaje_sl2').AsFloat := rPorcentaje;
  tvArticuloDesgloseSal.DataController.DataSet.FieldByName('kilos_desglose_sl2').AsFloat := rKilosDesglose;
  tvArticuloDesgloseSal.DataController.DataSet.Post;
  tvArticuloDesgloseSal.EndUpdate;
end;

procedure TFArticuloDesgloseSalMod.actPrevisualizarExecute(Sender: TObject);
begin
  btnAceptar.Click;
end;

procedure TFArticuloDesgloseSalMod.actCancelarExecute(Sender: TObject);
begin
  btnCancelar.Click;
end;

end.
