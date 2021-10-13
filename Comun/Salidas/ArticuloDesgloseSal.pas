unit ArticuloDesgloseSal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, ComCtrls, dxCore,
  cxDateUtils, Menus, StdCtrls, cxButtons, SimpleSearch, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxLabel, cxGroupBox, Gauges, ExtCtrls,
  cxTextEdit, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxCheckGroup, BonnyClientDataSet, cxCurrencyEdit,
  dxBar, cxRadioGroup, cxCheckBox, dxBarBuiltInMenu,
  cxPC, ActnList, SQLExprEdit, SQLExprStrEdit, SQLExprIntEdit, SQLExprDateEdit,
  dxSkinsCore, dxSkinBlue, dxSkinFoggy, dxSkinscxPCPainter,  dxSkinsdxBarPainter, dxSkinMoneyTwins,
  dxSkinBlueprint, nbLabels, DBTables, bTextUtils, cxGridBandedTableView,
  cxGridDBBandedTableView;

type
  TFArticuloDesgloseSal = class(TForm)
    pnlConsulta: TPanel;
    gbCriterios: TcxGroupBox;
    lbFechaIni: TcxLabel;
    lbAlbaran: TcxLabel;
    cxGrid: TcxGrid;
    tvArticuloDesgloseSal: TcxGridDBTableView;
    lvArticuloDesgloseSal: TcxGridLevel;
    dsQArtDesglose: TDataSource;
    tvFecha: TcxGridDBColumn;
    tvCliente: TcxGridDBColumn;
    bmxBarManager: TdxBarManager;
    bmxPrincipal: TdxBar;
    dxLocalizar: TdxBarLargeButton;
    dxSalir: TdxBarLargeButton;
    cxTabControl: TcxTabControl;
    btnVerDesglose: TcxButton;
    btnOcultarDesglose: TcxButton;
    dxModificar: TdxBarLargeButton;
    tvDesCliente: TcxGridDBColumn;
    tvCajas: TcxGridDBColumn;
    lbArticulo: TcxLabel;
    lbFecfin: TcxLabel;
    cxFechaIni: TcxDateEdit;
    cxFechaFin: TcxDateEdit;
    cxAlbaran: TcxTextEdit;
    cxArticulo: TcxTextEdit;
    ssArticulo: TSimpleSearch;
    stArticulo: TnbStaticText;
    tvArticulo: TcxGridDBColumn;
    tvDesArticulo: TcxGridDBColumn;
    tvEmpresa: TcxGridDBColumn;
    tvCentro: TcxGridDBColumn;
    tvAlbaran: TcxGridDBColumn;
    tvProducto: TcxGridDBColumn;
    tvKilos: TcxGridDBColumn;
    dsQSalidasL2: TDataSource;
    tvIdLineaAlbaran: TcxGridDBColumn;
    lvSalidasL2: TcxGridLevel;
    tvSalidasL2: TcxGridDBTableView;
    tvPorcentajeDesglose: TcxGridDBColumn;
    tvProductoDesglose: TcxGridDBColumn;
    tvKilosDesglose: TcxGridDBColumn;
    tvDesProducto: TcxGridDBColumn;
    lbEmpresa: TcxLabel;
    cxEmpresa: TcxTextEdit;
    lbCentro: TcxLabel;
    cxCentro: TcxTextEdit;
    lbProducto: TcxLabel;
    cxProducto: TcxTextEdit;
    stProducto: TnbStaticText;
    ssProducto: TSimpleSearch;
    dxLimpiar: TdxBarLargeButton;
    dxModificarGrupo: TdxBarLargeButton;
    tvMarca: TcxGridDBColumn;
    btnSeleccionar: TcxButton;
    btnCancelar: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure dxLocalizarClick(Sender: TObject);
    procedure dxSalirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tvDesClienteGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: String);
    procedure tvDesArticuloGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxArticuloExit(Sender: TObject);
    procedure cxArticuloPropertiesChange(Sender: TObject);
    procedure tvDesProductoDesGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure btnVerDesgloseClick(Sender: TObject);
    procedure btnOcultarDesgloseClick(Sender: TObject);
    procedure tvArticuloDesgloseSalCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure dxModificarClick(Sender: TObject);
    procedure dxLimpiarClick(Sender: TObject);
    procedure cxProductoPropertiesChange(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure dxModificarGrupoClick(Sender: TObject);
    procedure tvMarcaPropertiesChange(Sender: TObject);
  private
    QArtDesglose, QSalidasL2: TBonnyClientDataSet;
    dFechaIni, dFechaFin: TDateTime;

    procedure CreaQArtDesglose;
    procedure CreaQSalidasL2;
    function EjecutaQArtDesglose: boolean;
    function EjecutaQSalidasL2: boolean;
    procedure MontarConsulta;
    procedure ActivarConsulta(AValor: boolean);
    procedure VaciarConsulta;
    function ExisteFiltros: boolean;
    procedure AbrirArticuloDesgloseSalMod;
    procedure AbrirArticuloDesgloseGruMod(const AArticulo, AProducto: string);
    function ComprobacionDatos(var AArticulo, AProducto: String): boolean;
    procedure MarcarTodo;
    procedure DesmarcarTodo;

type
  TcxCustomEditAccess = class(TcxCustomEdit);

  public
    AFechaIni, AFechaFin: TDateTime;
    { Public declarations }
  end;

var
  FArticuloDesgloseSal: TFArticuloDesgloseSal;

implementation

{$R *.dfm}                                          
uses CGestionPrincipal, CVariables, UDMAuxDB, ArticuloDesgloseSalMod, Principal, UDMBaseDatos,
  ArticuloDesgloseGruMod;


function TFArticuloDesgloseSal.ComprobacionDatos(var AArticulo, AProducto: string): boolean;
var i, iSel:integer;
begin
  AArticulo := '';
  AProducto := '';
  for i := 0 to tvArticuloDesgloseSal.Datacontroller.RecordCount-1 do
  begin
    if tvArticuloDesgloseSal.DataController.GetValue(i, tvMarca.Index) = True then
    begin
      if AArticulo = '' then
      begin
        AArticulo := tvArticuloDesgloseSal.DataController.GetValue(i, tvArticulo.Index);
        AProducto := tvArticuloDesgloseSal.DataController.GetValue(i, tvProducto.Index);
      end;
      if tvArticuloDesgloseSal.DataController.GetValue(i, tvArticulo.Index) <> AArticulo then
      begin
        Result := False;
        exit;
      end;
    end;
  end;
  result := true;
end;

procedure TFArticuloDesgloseSal.CreaQArtDesglose;
begin
  QArtDesglose := TBonnyClientDataSet.Create(Self);
  dsQArtDesglose.DataSet := QArtDesglose;
  with QArtDesglose do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_salidas_l, frf_productos ');
    SQL.Add('  where producto_sl = producto_p ');
    SQL.Add('    and producto_desglose_p = ''S'' ');
    SQL.Add(' order by  empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, id_linea_albaran_sl ');
  end;
end;

procedure TFArticuloDesgloseSal.CreaQSalidasL2;
begin
  QSalidasL2 := TBonnyClientDataSet.Create(Self);
  dsQSalidasL2.DataSet := QSalidasL2;
  with QSalidasL2 do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_salidas_l2 ');
    SQL.Add(' order by  empresa_sl2, centro_salida_sl2, n_albaran_sl2, fecha_sl2, id_linea_albaran_sl2, articulo_sl2, producto_desglose_sl2 ');

  end;
end;

procedure TFArticuloDesgloseSal.cxArticuloExit(Sender: TObject);
begin
  if EsNumerico(cxArticulo.Text) and (Length(cxArticulo.Text) <= 5) then
    if (cxArticulo.Text <> '' ) and (Length(cxArticulo.Text) < 9) then
      cxArticulo.Text := 'COM-' + Rellena( cxArticulo.Text, 5, '0');
end;

procedure TFArticuloDesgloseSal.cxArticuloPropertiesChange(Sender: TObject);
begin
  stArticulo.Caption := desEnvase('', cxArticulo.Text);
end;

procedure TFArticuloDesgloseSal.cxProductoPropertiesChange(Sender: TObject);
begin
  stProducto.Caption := desProducto('', cxProducto.Text);
end;

function TFArticuloDesgloseSal.EjecutaQArtDesglose: boolean;
begin
  with QArtDesglose do
  begin
    if Active then
      Close;

    if cxFechaIni.Text <> '' then
      ParamByName('fecha_ini').AsString := cxFechaIni.Text;
    if cxFechaFin.Text <> '' then
      ParamByName('fecha_fin').AsString := cxFechaFin.Text;

    Open;
    Result := not IsEmpty;
  end;

end;

function TFArticuloDesgloseSal.EjecutaQSalidasL2: boolean;
begin
  with QSalidasL2 do
  begin
    if Active then
      Close;

    Open;
    Result := not IsEmpty;
  end;

end;

procedure TFArticuloDesgloseSal.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  CreaQArtDesglose;
  CreaQSalidasL2;
end;

procedure TFArticuloDesgloseSal.dxLimpiarClick(Sender: TObject);
begin
  VaciarConsulta;
end;

procedure TFArticuloDesgloseSal.dxLocalizarClick(Sender: TObject);
begin

  if (cxFechaIni.Text <> '') and (cxFechaFin.Text = '') then
    cxFechaFin.Text := cxFechaIni.Text;

  if not ExisteFiltros then
  begin
    ShowMessage(' ATENCION! No se puede ejecutar una consulta sin filtros.');
    Exit;
  end;
{
  if (cxFechaIni.Text = '') or (cxFechaFin.Text = '') then
  begin
    ShowMessage(' ATENCION! Falta Introducir Fechas.');
    Exit;
  end;
}
  MontarConsulta;
  if EjecutaQArtDesglose then
  begin
    EjecutaQSalidasL2;
    ActivarConsulta(False);
    cxGrid.SetFocus;
  end
  else
  begin
    ShowMessage('No existen datos con el criterio seleccionado.') ;
    ActivarConsulta(True);
//    VaciarConsulta;
    cxFechaIni.SetFocus;
  end;
end;

procedure TFArticuloDesgloseSal.dxModificarClick(Sender: TObject);
begin
  DesmarcarTodo;
  AbrirArticuloDesgloseSalMod;
end;

procedure TFArticuloDesgloseSal.dxModificarGrupoClick(Sender: TObject);
var sArticulo, sProducto: String;
begin
  if not ComprobacionDatos(sArticulo, sProducto) then
  begin
    ShowMessage(' ATENCION! No se puede actualizar el desglose. Se necesita tener el mismo Articulo');
    Exit;
  end;
  AbrirArticuloDesgloseGruMod(sArticulo, sProducto);
  DesmarcarTodo;
end;

procedure TFArticuloDesgloseSal.MontarConsulta;
begin
  with QArtDesglose do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_salidas_l, frf_productos ');
    SQL.Add('  where producto_sl = producto_p ');
    SQL.Add('    and producto_desglose_p = ''S'' ');

    if cxFechaIni.Text <> '' then
      SQL.Add('    and fecha_sl >= :fecha_ini ');

    if cxFechaFin.Text <> '' then
      SQL.Add('    and fecha_sl <= :fecha_fin ');

//    SQL.Add('    and fecha_sl between :fecha_ini and :fecha_fin ');

    if cxEmpresa.Text <> '' then
      SQL.Add(Format(' and empresa_sl = "%s"', [ cxEmpresa.Text ]));
    if cxCentro.Text <> '' then
      SQL.Add(Format(' and centro_salida_sl = "%s"', [ cxCentro.Text ]));
    if cxAlbaran.Text <> '' then
      SQL.Add(Format(' and n_albaran_sl = "%s"', [ cxAlbaran.Text ]));
    if cxArticulo.Text <> '' then
      SQL.Add(Format(' and envase_sl = "%s"', [ cxArticulo.Text ]));
    if cxProducto.Text <> '' then
      SQL.Add(Format(' and producto_sl = "%s"', [ cxProducto.Text ]));

    SQL.Add(' order by empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, id_linea_albaran_sl, envase_sl, producto_sl ');

  end;
end;


procedure TFArticuloDesgloseSal.dxSalirClick(Sender: TObject);
var sAux: String;
begin
  if cxGrid.Enabled then
  begin
    ActivarConsulta(True);
//    VaciarConsulta;
    tvArticuloDesgloseSal.DataController.Filter.Root.Clear;
    QArtDesglose.Close;
    cxFechaIni.SetFocus;
  end
  else
    Close;
end;

procedure TFArticuloDesgloseSal.AbrirArticuloDesgloseGruMod(const AArticulo, AProducto: string);
var i: integer;
  AColumn: TcxCustomGridTableItem;
begin


  FArticuloDesgloseGruMod:= TFArticuloDesgloseGruMod.Create( self );
  try
    FArticuloDesgloseGruMod.txtArticulo.Text := AArticulo;
    FArticuloDesgloseGruMod.txtDesArticulo.Text := DesEnvase('', FArticuloDesgloseGruMod.txtArticulo.Text);
    FArticuloDesgloseGruMod.txtProducto.Text := AProducto;
    FArticuloDesgloseGruMod.txtDesProducto.Text := DesProducto('', FArticuloDesgloseGruMod.txtProducto.Text);

    FArticuloDesgloseGruMod.kMemArtDesglose.Open;
    for i:= 0 to tvArticuloDesgloseSal.Datacontroller.RecordCount-1 do
    begin
      if tvArticuloDesgloseSal.DataController.GetValue(i, tvMarca.Index) = True then
      begin
        FArticuloDesgloseGruMod.kMemArtDesglose.Insert;
        FArticuloDesgloseGruMod.kMemArtDesglose.FieldByName('empresa_sl2').AsString := tvArticuloDesgloseSal.DataController.GetValue(i, tvEmpresa.Index);
        FArticuloDesgloseGruMod.kMemArtDesglose.FieldByName('centro_salida_sl2').AsString := tvArticuloDesgloseSal.DataController.GetValue(i, tvCentro.Index);
        FArticuloDesgloseGruMod.kMemArtDesglose.FieldByName('n_albaran_sl2').AsString := tvArticuloDesgloseSal.DataController.GetValue(i, tvAlbaran.Index);
        FArticuloDesgloseGruMod.kMemArtDesglose.FieldByName('fecha_sl2').AsString := tvArticuloDesgloseSal.DataController.GetValue(i, tvFecha.Index);
        FArticuloDesgloseGruMod.kMemArtDesglose.FieldByName('id_linea_albaran_sl2').AsString := tvArticuloDesgloseSal.DataController.GetValue(i, tvIdLineaAlbaran.Index);
        FArticuloDesgloseGruMod.kMemArtDesglose.Post;
      end;
    end;

    FArticuloDesgloseGruMod.ShowModal;

  finally
    if FArticuloDesgloseGruMod.ModalResult = mrOk then
    begin
      QSalidasL2.Close;
      QSalidasL2.Open;
    end;
    FreeAndNil(FArticuloDesgloseGruMod );
  end;

  tvArticuloDesgloseSal.ViewData.Collapse(True);

end;

procedure TFArticuloDesgloseSal.AbrirArticuloDesgloseSalMod;
var
  AColumn: TcxCustomGridTableItem;
begin
  FArticuloDesgloseSalMod:= TFArticuloDesgloseSalMod.Create( self );
  try
    AColumn := tvArticuloDesgloseSal.GetColumnByFieldName('empresa_sl');
    FArticuloDesgloseSalMod.txtEmpresa.Text := tvArticuloDesgloseSal.DataController.Values[tvArticuloDesgloseSal.DataController.FocusedRecordIndex, AColumn.Index];
    FArticuloDesgloseSalMod.txtDesEmpresa.Text := DesEmpresa(FArticuloDesgloseSalMod.txtEmpresa.Text);
    AColumn := tvArticuloDesgloseSal.GetColumnByFieldName('centro_salida_sl');
    FArticuloDesgloseSalMod.txtCentro.Text := tvArticuloDesgloseSal.DataController.Values[ tvArticuloDesgloseSal.DataController.FocusedRecordIndex, AColumn.Index];
    FArticuloDesgloseSalMod.txtDesCentro.Text := DesCentro(FArticuloDesgloseSalMod.txtEmpresa.Text, FArticuloDesgloseSalMod.txtCentro.Text);
    AColumn := tvArticuloDesgloseSal.GetColumnByFieldName('n_albaran_sl');
    FArticuloDesgloseSalMod.txtAlbaran.Text := tvArticuloDesgloseSal.DataController.Values[ tvArticuloDesgloseSal.DataController.FocusedRecordIndex, AColumn.Index];
    AColumn := tvArticuloDesgloseSal.GetColumnByFieldName('id_linea_albaran_sl');
    FArticuloDesgloseSalMod.txtIdAlbaran.Text := tvArticuloDesgloseSal.DataController.Values[ tvArticuloDesgloseSal.DataController.FocusedRecordIndex, AColumn.Index];
    AColumn := tvArticuloDesgloseSal.GetColumnByFieldName('fecha_sl');
    FArticuloDesgloseSalMod.txtFechaAlb.Text := tvArticuloDesgloseSal.DataController.Values[ tvArticuloDesgloseSal.DataController.FocusedRecordIndex, AColumn.Index];
    AColumn := tvArticuloDesgloseSal.GetColumnByFieldName('envase_sl');
    FArticuloDesgloseSalMod.txtArticulo.Text := tvArticuloDesgloseSal.DataController.Values[ tvArticuloDesgloseSal.DataController.FocusedRecordIndex, AColumn.Index];
    FArticuloDesgloseSalMod.txtDesArticulo.Text := DesEnvase('', FArticuloDesgloseSalMod.txtArticulo.Text);
    AColumn := tvArticuloDesgloseSal.GetColumnByFieldName('producto_sl');
    FArticuloDesgloseSalMod.txtProducto.Text := tvArticuloDesgloseSal.DataController.Values[ tvArticuloDesgloseSal.DataController.FocusedRecordIndex, AColumn.Index];
    FArticuloDesgloseSalMod.txtDesProducto.Text := DesProducto('', FArticuloDesgloseSalMod.txtProducto.Text);
    AColumn := tvArticuloDesgloseSal.GetColumnByFieldName('kilos_sl');
    FArticuloDesgloseSalMod.txtKilosTotal.Text :=tvArticuloDesgloseSal.DataController.Values[ tvArticuloDesgloseSal.DataController.FocusedRecordIndex, AColumn.Index];

    FArticuloDesgloseSalMod.ShowModal;

  finally
    if FArticuloDesgloseSalMod.ModalResult = mrOk then
    begin
      QSalidasL2.Close;
      QSalidasL2.Open;
    end;
    FreeAndNil(FArticuloDesgloseSalMod );
  end;

  tvArticuloDesgloseSal.ViewData.Collapse(True);
end;

procedure TFArticuloDesgloseSal.ActivarConsulta(AValor: boolean);
begin
  pnlConsulta.Enabled := AValor;
  dxLocalizar.Enabled := AValor;
  dxLimpiar.Enabled := AValor;
  dxModificar.Enabled := not AValor;
  dxModificarGrupo.Enabled := false;

  cxTabControl.Enabled := not AValor;
  cxGrid.Enabled := not AValor;
  btnVerDesglose.Enabled := not AValor;
  btnOcultarDesglose.Enabled := not AValor;
end;

procedure TFArticuloDesgloseSal.VaciarConsulta;
begin
  cxFechaIni.Text := '';
  cxFechaFin.Text := '';
  cxEmpresa.Text := '';
  cxCentro.Text := '';
  cxAlbaran.Text := '';
  cxArticulo.Text := '';
  cxProducto.Text := '';

  cxFechaIni.Text := FormatDateTime('dd/mm/yyyy', Now );
end;

procedure TFArticuloDesgloseSal.FormShow(Sender: TObject);
begin
  ActivarConsulta(True);

  cxFechaIni.Text := FormatDateTime('dd/mm/yyyy', Now );
  cxFechaIni.SetFocus;
end;

procedure TFArticuloDesgloseSal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  BEMensajes('');
  Action := caFree;
end;

procedure TFArticuloDesgloseSal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F1:
    begin
      if dxLocalizar.Enabled then  dxLocalizarClick(Self)
      else if dxModificar.Enabled then dxModificarClick(Self);
    end;
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
    VK_ESCAPE:
    begin
     dxSalirClick(Self);
    end;
  end;
end;

procedure TFArticuloDesgloseSal.btnCancelarClick(Sender: TObject);
begin
  DesmarcarTodo;
end;

procedure TFArticuloDesgloseSal.MarcarTodo;
var i:integer;
begin
  tvArticuloDesgloseSal.BeginUpdate;
  for i:=0 to tvArticuloDesgloseSal.DataController.RecordCount-1 do
    tvArticuloDesgloseSal.DataController.SetValue(i,tvMarca.Index, True);
  tvArticuloDesgloseSal.EndUpdate;
  dxModificarGrupo.Enabled := True;
end;

procedure TFArticuloDesgloseSal.DesmarcarTodo;
var i:integer;
begin
  tvArticuloDesgloseSal.BeginUpdate;
  for i:=0 to tvArticuloDesgloseSal.DataController.RecordCount-1 do
    tvArticuloDesgloseSal.DataController.SetValue(i,tvMarca.Index, False);
  tvArticuloDesgloseSal.EndUpdate;
  dxModificarGrupo.Enabled := False;
end;

procedure TFArticuloDesgloseSal.btnOcultarDesgloseClick(Sender: TObject);
begin
  tvArticuloDesgloseSal.ViewData.Collapse(True);
end;

procedure TFArticuloDesgloseSal.btnSeleccionarClick(Sender: TObject);
begin
  MarcarTodo;
end;

procedure TFArticuloDesgloseSal.btnVerDesgloseClick(Sender: TObject);
begin
 tvArticuloDesgloseSal.ViewData.Expand(True);
end;

function TFArticuloDesgloseSal.ExisteFiltros: boolean;
begin
  if (cxFechaIni.Text <> '') or (cxFechaFin.Text <> '') or
     (cxEmpresa.Text <> '') or (cxCentro.Text <> '') or
     (cxAlbaran.Text <> '') or (cxArticulo.Text <> '') or
     (cxProducto.Text <> '') then
      Result := true
  else
      Result := false;
end;

procedure TFArticuloDesgloseSal.tvArticuloDesgloseSalCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
  AColumn: TcxCustomGridTableItem;
begin
  AbrirArticuloDesgloseSalMod;
end;

procedure TFArticuloDesgloseSal.tvDesArticuloGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
var AArticulo: Variant;
begin
  if tvArticuloDesgloseSal.GetColumnByFieldName('envase_sl') <> nil then
    AArticulo := ARecord.Values[tvArticuloDesgloseSal.GetColumnByFieldName('envase_sl').Index]
  else
    AArticulo := null;

  AText := DesEnvase('', AArticulo);
end;

procedure TFArticuloDesgloseSal.tvDesClienteGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
var ACliente: Variant;
begin
  if tvArticuloDesgloseSal.GetColumnByFieldName('cliente_sl') <> nil then
    ACliente := ARecord.Values[tvArticuloDesgloseSal.GetColumnByFieldName('cliente_sl').Index]
  else
    ACliente := null;

  AText := DesCliente(ACliente);
end;

procedure TFArticuloDesgloseSal.tvDesProductoDesGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
var AProducto: Variant;
begin
  if tvSalidasL2.GetColumnByFieldName('producto_desglose_sl2') <> nil then
  begin
    AProducto := ARecord.Values[tvSalidasL2.GetColumnByFieldName('producto_desglose_sl2').Index];
    AText := DesProducto('', AProducto);
  end
  else
    AProducto := null;

end;

procedure TFArticuloDesgloseSal.tvMarcaPropertiesChange(Sender: TObject);
var i:integer;
begin
  dxModificarGrupo.Enabled := false;
  for i:= 0 to tvArticuloDesgloseSal.Datacontroller.RecordCount-1 do
    if tvArticuloDesgloseSal.DataController.GetValue(i, tvMarca.Index) = True then
    begin
      dxModificarGrupo.Enabled := true;
      exit;
    end;
end;

end.
