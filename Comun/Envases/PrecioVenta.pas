unit PrecioVenta;

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
  dxSkinBlueprint, nbLabels, DBTables, bTextUtils ;

type
  TFPrecioVenta = class(TForm)
    pnlConsulta: TPanel;
    gbCriterios: TcxGroupBox;
    lbEmpresa: TcxLabel;
    lbCliente: TcxLabel;
    cxGrid: TcxGrid;
    tvPrecioVenta: TcxGridDBTableView;
    lvPrecioVenta: TcxGridLevel;
    dsQPrecioVenta: TDataSource;
    tvFecha: TcxGridDBColumn;
    tvCliente: TcxGridDBColumn;
    bmxBarManager: TdxBarManager;
    bmxPrincipal: TdxBar;
    dxLocalizar: TdxBarLargeButton;
    dxSalir: TdxBarLargeButton;
    cxTabControl: TcxTabControl;
    btnSeleccionar: TcxButton;
    btnCancelar: TcxButton;
    dxAlta: TdxBarLargeButton;
    tvDesCliente: TcxGridDBColumn;
    tvMoneda: TcxGridDBColumn;
    tvPrecio: TcxGridDBColumn;
    lbImporteNeto: TcxLabel;
    lbFecConta: TcxLabel;
    ssCliente: TSimpleSearch;
    cxFechaIni: TcxDateEdit;
    cxFechaFin: TcxDateEdit;
    cxCliente: TcxTextEdit;
    stCliente: TnbStaticText;
    cxArticulo: TcxTextEdit;
    ssArticulo: TSimpleSearch;
    stArticulo: TnbStaticText;
    tvArticulo: TcxGridDBColumn;
    tvDesArticulo: TcxGridDBColumn;
    dxBaja: TdxBarLargeButton;
    tvMarca: TcxGridDBColumn;
    tvUnidadPrecio: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure dxLocalizarClick(Sender: TObject);
    procedure dxSalirClick(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure tvMarcaPropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dxAltaClick(Sender: TObject);
    procedure tvDesClienteGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: String);
    procedure tvDesArticuloGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure dxBajaClick(Sender: TObject);
    procedure tvPrecioVentaDblClick(Sender: TObject);
    procedure cxArticuloExit(Sender: TObject);
    procedure cxArticuloPropertiesChange(Sender: TObject);
    procedure cxClientePropertiesChange(Sender: TObject);
  private
    QPrecioVenta: TBonnyClientDataSet;
    dFechaIni, dFechaFin: TDateTime;

    procedure CreaQPrecioVenta;
    function EjecutaQPrecioVenta: boolean;
    procedure MontarConsulta;
    procedure ActivarConsulta(AValor: boolean);
    procedure VaciarConsulta;
    procedure ActualizarFactura;
    function ExisteFiltros: boolean;
    procedure BajaPrecios;
    function ExisteEnAlbaran: boolean;

  public
    AFechaIni, AFechaFin: TDateTime;
    { Public declarations }
  end;

var
  FPrecioVenta: TFPrecioVenta;

implementation

{$R *.dfm}
uses UDFactura, CGestionPrincipal, CVariables, Principal, UDMAuxDB,
  PrecioVentaAsignacion;

procedure TFPrecioVenta.CreaQPrecioVenta;
begin
  QPrecioVenta := TBonnyClientDataSet.Create(Self);
  dsQPrecioVenta.DataSet := QPrecioVenta;

  with QPrecioVenta do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_precio_venta ');
  end;
end;

procedure TFPrecioVenta.cxArticuloExit(Sender: TObject);
begin
  if EsNumerico(cxArticulo.Text) and (Length(cxArticulo.Text) <= 5) then
    if (cxArticulo.Text <> '' ) and (Length(cxArticulo.Text) < 9) then
      cxArticulo.Text := 'COM-' + Rellena( cxArticulo.Text, 5, '0');
end;

procedure TFPrecioVenta.cxArticuloPropertiesChange(Sender: TObject);
begin
  stArticulo.Caption := desEnvase('', cxArticulo.Text);
end;

procedure TFPrecioVenta.cxClientePropertiesChange(Sender: TObject);
begin
  stCliente.Caption := desCliente(cxCliente.Text);
end;

function TFPrecioVenta.EjecutaQPrecioVenta: boolean;
begin
  with QPrecioVenta do
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

procedure TFPrecioVenta.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  CreaQPrecioVenta;
end;

procedure TFPrecioVenta.dxLocalizarClick(Sender: TObject);
begin

  if (cxFechaIni.Text <> '') and (cxFechaFin.Text = '') then
    cxFechaFin.Text := cxFechaIni.Text;

  if not ExisteFiltros then
  begin
    ShowMessage(' ATENCION! No se puede ejecutar una consulta sin filtros.');
    Exit;
  end;
  MontarConsulta;
  if EjecutaQPrecioVenta then
  begin
    ActivarConsulta(False);
    cxGrid.SetFocus;
  end
  else
  begin
    ShowMessage('No existen datos con el criterio seleccionado.') ;
    ActivarConsulta(True);
    VaciarConsulta;
    cxFechaIni.SetFocus;
  end;
end;

procedure TFPrecioVenta.MontarConsulta;
begin
  with QPrecioVenta do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_precio_venta ');
    SQL.Add('   where 1=1 ');

    if cxFechaIni.Text <> '' then
      SQL.Add(' and fecha_pv >= :fecha_ini ');

    if cxFechaFin.Text <> '' then
      SQL.Add(' and fecha_pv <= :fecha_fin ');

//    SQL.Add(' and fecha_pv between :fecha_ini and :fecha_fin ');

    if cxCliente.Text <> '' then
      SQL.Add(Format(' and cliente_pv = "%s"', [ cxCliente.Text ]));
    if cxArticulo.Text <> '' then
      SQL.Add(Format(' and envase_pv = "%s"', [ cxArticulo.Text ]));

    SQL.Add(' order by fecha_pv, cliente_pv, envase_pv, moneda_pv ');  

  end;
end;


procedure TFPrecioVenta.dxSalirClick(Sender: TObject);
var sAux: String;
begin
  if cxGrid.Enabled then
  begin
    ActivarConsulta(True);
    VaciarConsulta;
    tvPrecioVenta.DataController.Filter.Root.Clear;
    QPrecioVenta.Close;
    cxFechaIni.SetFocus;
  end
  else
    Close;
end;

procedure TFPrecioVenta.ActivarConsulta(AValor: boolean);
begin
  pnlConsulta.Enabled := AValor;
  dxLocalizar.Enabled := AValor;
  dxAlta.Enabled := AValor;
  dxBaja.Enabled := false;

  cxTabControl.Enabled := not AValor;
  cxGrid.Enabled := not AValor;
  btnSeleccionar.Enabled := not AValor;
  btnCancelar.Enabled := not AValor;
end;

procedure TFPrecioVenta.VaciarConsulta;
begin
  cxFechaIni.Text := '';
  cxFechaFin.Text := '';
  cxCliente.Text := '';
  cxArticulo.Text := '';

  cxFechaIni.Text := FormatDateTime('dd/mm/yyyy', Now );
end;

procedure TFPrecioVenta.btnSeleccionarClick(Sender: TObject);
var i: Integer;
begin
  tvPrecioVenta.BeginUpdate;
  for i:=0 to tvPrecioVenta.DataController.RecordCount-1 do
    tvPrecioVenta.DataController.SetValue(i,tvMarca.Index, True);
  tvPrecioVenta.EndUpdate;
  dxBaja.Enabled := True;
end;

procedure TFPrecioVenta.btnCancelarClick(Sender: TObject);
var i: integer;
begin
  tvPrecioVenta.BeginUpdate;
  for i:=0 to tvPrecioVenta.DataController.RecordCount-1 do
    tvPrecioVenta.DataController.SetValue(i,tvMarca.Index, False);
  tvPrecioVenta.EndUpdate;
  dxBaja.Enabled := False;
end;

procedure TFPrecioVenta.tvMarcaPropertiesChange(Sender: TObject);
var i:Integer;
begin
  dxBaja.Enabled := false;
  for i:= 0 to tvPrecioVenta.Datacontroller.RecordCount-1 do
    if tvPrecioVenta.DataController.GetValue(i, tvMarca.Index) = True then
    begin
      dxBaja.Enabled := true;
      exit;
    end;
end;

procedure TFPrecioVenta.tvPrecioVentaDblClick(Sender: TObject);
begin
  if ExisteEnAlbaran then
  begin
    ShowMessage('Precio insertado en linea de albaran. No se podrá modificar su valor. ');
    Exit;
  end;
end;

procedure TFPrecioVenta.FormShow(Sender: TObject);
begin
  ActivarConsulta(True);

  cxFechaIni.Text := FormatDateTime('dd/mm/yyyy', Now );
  cxFechaIni.SetFocus;
end;

procedure TFPrecioVenta.FormClose(Sender: TObject;
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

procedure TFPrecioVenta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F1:
    begin
      if dxLocalizar.Enabled then  dxLocalizarClick(Self)
      else if dxAlta.Enabled then dxAltaClick(Self);
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

procedure TFPrecioVenta.dxAltaClick(Sender: TObject);
var sAux: String;
var AFechaIni, AFechaFin: string;
begin
  FPrecioVentaAsignacion.AsignarPrecios ( Self, AFechaIni, AFechaFin );
  cxFechaIni.Text := AFechaIni;
  cxFechaFin.Text := AFechaFin;

  if( AFechaIni <> '') and (AFechaFin <> '') then
    dxLocalizarClick(Self);

end;

procedure TFPrecioVenta.dxBajaClick(Sender: TObject);
var i: integer;
var sAux: String;
begin
  sAux := 'ATENCION! Se va a dar de BAJA los precios de venta seleccionados. ¿Continuar con el proceso?';

  case MessageDlg(sAux, mtInformation, [mbCancel,mbOk],0) of
  mrOk:
  begin
    BajaPrecios;
    ActivarConsulta(True);
    VaciarConsulta;
    tvPrecioVenta.DataController.Filter.Root.Clear;
    QPrecioVenta.Close;
    cxFechaIni.SetFocus;
  end;
  mrCancel:
  begin
    Exit;
  end;
  end;
end;

procedure TFPrecioVenta.ActualizarFactura;
var i:integer;
begin
{
  for i:=0 to tvFacturas.DataController.RecordCount-1 do
    if tvFacturas.DataController.GetValue(i, tvMarca.Index) = true then
    begin
      tvFacturas.DataController.FocusedRecordIndex := i;

      tvFacturas.DataController.BeginUpdate;
      if not (tvFacturas.DataController.DataSet.State in [dsEdit]) then
        tvFacturas.DataController.DataSet.Edit;
      tvFacturas.DataController.DataSet.FieldByName('contabilizado_fc').AsInteger := iMarca;
      tvFacturas.DataController.DataSet.FieldByName('fecha_conta_fc').AsDateTime := Now;
      tvFacturas.DataController.DataSet.Post;
      tvFacturas.DataController.EndUpdate;
    end;
  QPrecioVenta.ApplyUpdates(0);

  ShowMessage('Proceso finalizado correctamente');
}
end;

procedure TFPrecioVenta.BajaPrecios;
var i: integer;
begin
//BUSCAR ALBARANES CON PRECIO PARA CLIENTE Y ARTICULO ENTRE FECHAS.
  if ExisteEnAlbaran then
  begin
    ShowMessage('Precio insertado en linea de albaran. No se podrá borrar su valor. ');
    Exit;
  end;

  for i := tvPrecioVenta.DataController.RecordCount - 1 downto 0 do
    if tvPrecioVenta.DataController.GetValue(i, tvMarca.Index) = true then
    begin
      tvPrecioVenta.DataController.FocusedRecordIndex := i;

      tvPrecioVenta.DataController.BeginUpdate;
      tvPrecioVenta.DataController.DataSet.Delete;
      tvPrecioVenta.DataController.EndUpdate;
    end;
  QPrecioVenta.ApplyUpdates(0);

  ShowMessage('Proceso finalizado correctamente');
end;

function TFPrecioVenta.ExisteEnAlbaran: boolean;
var QAlbaran: TQuery;
begin

  QAlbaran := TQuery.Create(Self);
  with QAlbaran do
  try
    DatabaseName:= 'BDProyecto';

    SQL.Add(' select * from frf_salidas_l ');
    SQL.Add('  where fecha_sl = :fecha ');
    SQL.Add('    and cliente_sl = :cliente ');
    SQL.Add('    and envase_sl = :envase   ');

    ParamByName('fecha').AsString := QPrecioVenta.FieldbyName('fecha_pv').AsString;
    ParamByName('cliente').AsString := QPrecioVenta.FieldbyName('cliente_pv').AsString;
    ParamByName('envase').AsString := QPrecioVenta.FieldbyName('envase_pv').AsString;

    Open;

    Result := not IsEmpty;

  finally
    Close;
  end;


end;

function TFPrecioVenta.ExisteFiltros: boolean;
begin
  if (cxFechaIni.Text <> '') or (cxFechaFin.Text <> '') or (cxCliente.Text <> '') or
     (cxArticulo.Text <> '') then
      Result := true
  else

      Result := false;
end;

procedure TFPrecioVenta.tvDesArticuloGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
var AArticulo: Variant;
begin
  if tvPrecioVenta.GetColumnByFieldName('envase_pv') <> nil then
    AArticulo := ARecord.Values[tvPrecioVenta.GetColumnByFieldName('envase_pv').Index]
  else
    AArticulo := null;

  AText := DesEnvase('', AArticulo);
end;

procedure TFPrecioVenta.tvDesClienteGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
var ACliente: Variant;
begin
  if tvPrecioVenta.GetColumnByFieldName('cliente_pv') <> nil then
    ACliente := ARecord.Values[tvPrecioVenta.GetColumnByFieldName('cliente_pv').Index]
  else
    ACliente := null;

  AText := DesCliente(ACliente);
end;

end.
