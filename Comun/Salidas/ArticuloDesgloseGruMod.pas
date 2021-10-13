unit ArticuloDesgloseGruMod;

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
  dxSkinBlueprint, dxSkinMoneyTwins, dxmdaset, dError, dbTables, kbmMemTable;

type
  TFArticuloDesgloseGruMod = class(TForm)
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
    lb8: TcxLabel;
    txtArticulo: TcxTextEdit;
    txtDesArticulo: TcxTextEdit;
    tvPorcentajeDesglose: TcxGridDBColumn;
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
    cxLabel3: TcxLabel;
    txtProducto: TcxTextEdit;
    txtDesProducto: TcxTextEdit;
    tvDesProductoDes: TcxGridDBColumn;
    dsArticuloDesglose: TDataSource;
    tvSalidasL2: TcxGridDBTableView;
    tvSalidasL2Column1: TcxGridDBColumn;
    kMemArtDesglose: TkbmMemTable;
    kMemArtDesgloseempresa_sl2: TStringField;
    kMemArtDesglosecentro_salida_sl2: TStringField;
    kMemArtDesglosen_albaran_sl2: TIntegerField;
    kMemArtDesglosefecha_sl2: TDateField;
    kMemArtDesgloseid_linea_albaran_sl2: TIntegerField;
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
    procedure dsArticuloDesgloseDataChange(Sender: TObject; Field: TField);
    procedure tvPorcentajeDesglosePropertiesEditValueChanged(Sender: TObject);
  private
    { Private declarations }
    QArticuloDesglose: TBonnyClientDataSet;
    procedure CreaQArticuloDesglose;
    function EjecutaQArticuloDesglose: boolean;
    function DesgloseCompleto:boolean;
    procedure ModificarAlbaranes;

  public
    { Public declarations }
  end;

type
  TcxCustomEditAccess = class(TcxCustomEdit);

var
  FArticuloDesgloseGruMod: TFArticuloDesgloseGruMod;

implementation

uses UDMBaseDatos, CAuxiliarDB, UDMAuxDB;

{$R *.dfm}

procedure TFArticuloDesgloseGruMod.btnAceptarClick(Sender: TObject);
begin
  if MessageDlg('¿Desea Actualizar Cambios? ( Albaranes Seleccionados: ' + IntToStr(kMemArtDesglose.RecordCount) + ' )', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
//    QArticuloDesglose.ApplyUpdates(0);
    ModificarAlbaranes;
    ModalResult:= mrOk;
  end;
end;

procedure TFArticuloDesgloseGruMod.btnCancelarClick(Sender: TObject);
begin
  if MessageDlg('¿Desea salir del Desglose de Producto?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    ModalResult:= mrCancel;
end;

procedure TFArticuloDesgloseGruMod.btnExpandirClick(Sender: TObject);
begin
 tvArticuloDesgloseSal.ViewData.Expand(True);
end;

procedure TFArticuloDesgloseGruMod.CreaQArticuloDesglose;
begin
  QArticuloDesglose := TBonnyClientDataSet.Create(Self);
  dsArticuloDesglose.DataSet := QArticuloDesglose;

  with QArticuloDesglose do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_articulos_desglose ');
    SQL.Add('  where articulo_ad = :articulo ');
    SQL.Add(' order by producto_desglose_ad ');
  end;
end;

function TFArticuloDesgloseGruMod.DesgloseCompleto: boolean;
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

procedure TFArticuloDesgloseGruMod.dsArticuloDesgloseDataChange(Sender: TObject;
  Field: TField);
begin
  if DesgloseCompleto then
    btnAceptar.Enabled := true
  else
    btnAceptar.Enabled := false;
end;

function TFArticuloDesgloseGruMod.EjecutaQArticuloDesglose: boolean;
begin
  with QArticuloDesglose do
  begin
    if Active then
      Close;
    ParamByName('articulo').AsString := txtArticulo.Text;

    Open;
    Result := not IsEmpty;
  end;
end;

procedure TFArticuloDesgloseGruMod.FormCreate(Sender: TObject);
begin
  CreaQArticuloDesglose;
end;

procedure TFArticuloDesgloseGruMod.FormShow(Sender: TObject);
var columncIndex : integer;
    b: boolean;
begin
  if not EjecutaQArticuloDesglose then
  begin
    ShowMessage(' ATENCION! No existe desglose para la linea de albaran. Consultar con Informatica ');
    exit;
  end;

  b := True;
  cxGrid.Setfocus;
  columncIndex := tvArticuloDesgloseSal.GetColumnByFieldName('porcentaje_ad').index;
  tvArticuloDesgloseSal.DataController.FocusControl(columncIndex, b);

end;

procedure TFArticuloDesgloseGruMod.ModificarAlbaranes;
var i,j: integer;
    rKilosTotal: Currency;
    AField: TField;
    AMemField: TdxMemField;
    sEmpresa, sCentro: String;
    iAlbaran, iLinea: Integer;
    dFecha: TDateTime;
begin

  //Abrir transaccion
  if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
  begin
    ShowError(' En este momento no se puede modificar el desglose para los Albaranes seleccionados, por favor intentelo mas tarde.');
    exit;
  end;

  try
    kMemArtDesglose.Open;
    while not kMemArtDesglose.Eof do
    begin
      with DMBaseDatos.QAux do
      begin
        SQL.Clear;
        SQL.Add(' delete from frf_salidas_l2 ');
        SQL.Add('  where empresa_sl2 = :empresa ');
        SQL.Add('    and centro_salida_sl2 = :centro ');
        SQL.Add('    and n_albaran_sl2 = :albaran ');
        SQL.Add('    and fecha_sl2 = :fecha ');
        SQL.Add('    and id_linea_albaran_sl2 = :id_linea ');

        ParamByName('empresa').AsString := kMemArtDesglose.FieldByName('empresa_sl2').AsString;
        ParamByName('centro').AsString := kMemArtDesglose.FieldByName('centro_salida_sl2').AsString;
        ParamByName('albaran').AsInteger := kMemArtDesglose.FieldByName('n_albaran_sl2').AsInteger;
        ParamByName('fecha').AsString := kMemArtDesglose.FieldByName('fecha_sl2').AsString;
        ParamByName('id_linea').AsInteger := kMemArtDesglose.FieldByName('id_linea_albaran_sl2').AsInteger;
        ExecSQL;

        SQL.Clear;
        SQL.Add(' select NVL(kilos_sl,0) kilos_sl from frf_salidas_l ');
        SQL.Add('  where empresa_sl = :empresa ');
        SQL.Add('    and centro_salida_sl = :centro ');
        SQL.Add('    and n_albaran_sl = :albaran ');
        SQL.Add('    and fecha_sl = :fecha ');
        SQL.Add('    and id_linea_albaran_sl = :id_linea ');

        ParamByName('empresa').AsString := kMemArtDesglose.FieldByName('empresa_sl2').AsString;
        ParamByName('centro').AsString := kMemArtDesglose.FieldByName('centro_salida_sl2').AsString;
        ParamByName('albaran').AsInteger := kMemArtDesglose.FieldByName('n_albaran_sl2').AsInteger;
        ParamByName('fecha').AsString := kMemArtDesglose.FieldByName('fecha_sl2').AsString;
        ParamByName('id_linea').AsInteger := kMemArtDesglose.FieldByName('id_linea_albaran_sl2').AsInteger;

        Open;
        rKilosTotal := FieldByName('kilos_sl').AsFloat;

        //Cargamos el nuevo desglose
        for j := 0 to tvArticuloDesgloseSal.DataController.RecordCount - 1 do
        begin
          with DMBaseDatos.QTemp do
          begin
            SQL.Clear;
            SQL.Add(' insert into frf_salidas_l2 (empresa_sl2, centro_salida_sl2, n_albaran_sl2, fecha_sl2, id_linea_albaran_sl2, articulo_sl2, ');
            SQL.Add('                              producto_sl2, producto_desglose_sl2, porcentaje_sl2, kilos_desglose_sl2 ) ');
            SQL.Add('                      values (:empresa, :centro, :albaran, :fecha, :id_linea, :articulo, :producto, :producto_desglose, :porcentaje, :kilos) ');

            ParamByName('empresa').AsString := kMemArtDesglose.FieldByName('empresa_sl2').AsString;
            ParamByName('centro').AsString := kMemArtDesglose.FieldByName('centro_salida_sl2').AsString;
            ParamByName('albaran').AsInteger := kMemArtDesglose.FieldByName('n_albaran_sl2').AsInteger;
            ParamByName('fecha').AsString := kMemArtDesglose.FieldByName('fecha_sl2').AsString;
            ParamByName('id_linea').AsInteger := kMemArtDesglose.FieldByName('id_linea_albaran_sl2').AsInteger;
            ParamByName('articulo').AsString := txtArticulo.Text;
            ParamByName('producto').AsString := txtProducto.Text;
            ParamByName('producto_desglose').AsString := tvArticuloDesgloseSal.DataController.GetValue(j, tvProductoDesglose.Index);
            ParamByName('porcentaje').AsFloat := tvArticuloDesgloseSal.DataController.GetValue(j, tvPorcentajeDesglose.Index);
            ParamByName('kilos').AsFloat := rKilosTotal * tvArticuloDesgloseSal.DataController.GetValue(j, tvPorcentajeDesglose.Index) / 100;
            ExecSQL;
          end;
        end;
      end;
      kMemArtDesglose.Next;
    end;
  except
  on e: EDBEngineError do
    begin
      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
      ShowError(e);
      Exit;
    end;
  end;
  AceptarTransaccion(DMBaseDatos.DBBaseDatos);

end;

procedure TFArticuloDesgloseGruMod.btnContraerClick(Sender: TObject);
begin
  tvArticuloDesgloseSal.ViewData.Collapse(True);
end;

procedure TFArticuloDesgloseGruMod.actExpandirExecute(Sender: TObject);
begin
 tvArticuloDesgloseSal.ViewData.Expand(True);
end;

procedure TFArticuloDesgloseGruMod.actContraerExecute(Sender: TObject);
begin
  tvArticuloDesgloseSal.ViewData.Collapse(True);
end;

procedure TFArticuloDesgloseGruMod.tvDesProductoDesGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
  var AProducto: Variant;
begin
  if tvArticuloDesgloseSal.GetColumnByFieldName('producto_desglose_ad') <> nil then
    AProducto := ARecord.Values[tvArticuloDesgloseSal.GetColumnByFieldName('producto_desglose_ad').Index]
  else
    AProducto := null;

  AText := DesProducto('', AProducto);
end;

procedure TFArticuloDesgloseGruMod.tvPorcentajeDesglosePropertiesEditValueChanged(
  Sender: TObject);
var sPorcentaje: String;
    rPorcentaje: Currency;
begin
  tvArticuloDesgloseSal.BeginUpdate;
  sPorcentaje := VarToStr(TcxCustomEditAccess(Sender).EditValue);
  rPorcentaje := StrToFloat(sPorcentaje);

  if not (tvArticuloDesgloseSal.DataController.DataSet.State in dsEditModes) then
    tvArticuloDesgloseSal.DataController.DataSet.Edit;
  tvArticuloDesgloseSal.DataController.DataSet.FieldByName('porcentaje_ad').AsFloat := rPorcentaje;
  tvArticuloDesgloseSal.DataController.DataSet.Post;
  tvArticuloDesgloseSal.EndUpdate;
end;

procedure TFArticuloDesgloseGruMod.actPrevisualizarExecute(Sender: TObject);
begin
  btnAceptar.Click;
end;

procedure TFArticuloDesgloseGruMod.actCancelarExecute(Sender: TObject);
begin
  btnCancelar.Click;
end;

end.
