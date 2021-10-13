unit UFMarcaContable;

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
  dxSkinBlueprint ;

type
  TFMarcaContable = class(TForm)
    pnlConsulta: TPanel;
    gbCriterios: TcxGroupBox;
    lbEmpresa: TcxLabel;
    lbCliente: TcxLabel;
    lbFecFactura: TcxLabel;
    lbNumFactura: TcxLabel;
    cxGrid: TcxGrid;
    tvFacturas: TcxGridDBTableView;
    lvFacturas: TcxGridLevel;
    dsQFacturas: TDataSource;
    tvEmpresa: TcxGridDBColumn;
    tvFecha: TcxGridDBColumn;
    tvNumero: TcxGridDBColumn;
    tvCodigo: TcxGridDBColumn;
    tvCliente: TcxGridDBColumn;
    tvImporteTotal: TcxGridDBColumn;
    bmxBarManager: TdxBarManager;
    bmxPrincipal: TdxBar;
    dxLocalizar: TdxBarLargeButton;
    rgMarca: TcxRadioGroup;
    tvMarca: TcxGridDBColumn;
    dxSalir: TdxBarLargeButton;
    cxTabControl: TcxTabControl;
    btnSeleccionar: TcxButton;
    btnCancelar: TcxButton;
    dxMarca: TdxBarLargeButton;
    tvDesCliente: TcxGridDBColumn;
    tvMoneda: TcxGridDBColumn;
    tvTipoFactura: TcxGridDBColumn;
    tvTipo: TcxGridDBColumn;
    tvImpuesto: TcxGridDBColumn;
    tvDesImpuesto: TcxGridDBColumn;
    tvImporteNeto: TcxGridDBColumn;
    tvImporteImpuesto: TcxGridDBColumn;
    lbImporteNeto: TcxLabel;
    lbImporteTotal: TcxLabel;
    lbFecConta: TcxLabel;
    ssCliente: TSimpleSearch;
    SEEmpresa: TSQLExprStrEdit;
    SENumFactura: TSQLExprIntEdit;
    SECliente: TSQLExprStrEdit;
    SEFecFactura: TSQLExprDateEdit;
    SEImporteNeto: TSQLExprIntEdit;
    SEImporteTotal: TSQLExprIntEdit;
    SEFecConta: TSQLExprDateEdit;
    cxLabel1: TcxLabel;
    SESerie: TSQLExprStrEdit;
    tvSerie: TcxGridDBColumn;
    cxLabel40: TcxLabel;
    SECodFactura: TSQLExprStrEdit;
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
    procedure dxMarcaClick(Sender: TObject);
    procedure tvDesClienteGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: String);
    procedure tvTipoFacturaGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: String);
    procedure tvDesImpuestoGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: String);
    procedure ssClienteAntesEjecutar(Sender: TObject);
  private
    QFacturas: TBonnyClientDataSet;
    iMarca: integer;

    procedure CreaQFacturas;
    function EjecutaQFacturas: boolean;
    procedure MontarConsulta;
    procedure ActivarConsulta(AValor: boolean);
    procedure VaciarConsulta;
    procedure ActualizarFactura;
    function ExisteFiltros: boolean;

  public
    { Public declarations }
  end;

var
  FMarcaContable: TFMarcaContable;

implementation

{$R *.dfm}
uses UDFactura, CGestionPrincipal, CVariables, Principal, UDMAuxDB;

procedure TFMarcaContable.CreaQFacturas;
begin
  QFacturas := TBonnyClientDataSet.Create(Self);
  dsQFacturas.DataSet := QFacturas;                                                                                                                                                  

  with QFacturas do
  begin
    SQL.Add(' select cod_empresa_fac_fc, cod_cliente_fc, des_cliente_fc, fecha_factura_fc, ');
    SQL.Add('        n_factura_fc, cod_factura_fc, tipo_factura_fc, impuesto_fc, moneda_fc, ');
    SQL.Add('        importe_neto_fc, importe_impuesto_fc, importe_total_fc');
    SQL.Add('   from tfacturas_cab ');
    SQL.Add('  where contabilizado_fc = :valor ');

//    ParamByName('valor').DataType := ftString;
  end;
end;

function TFMarcaContable.EjecutaQFacturas: boolean;
begin
  with QFacturas do
  begin
    if Active then
      Close;

    ParamByName('valor').AsString := rgMarca.Properties.Items[rgMarca.ItemIndex].Value;

    Open;
    Result := not IsEmpty;
  end;

end;

procedure TFMarcaContable.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  CreaQFacturas;
end;

procedure TFMarcaContable.dxLocalizarClick(Sender: TObject);
begin
 
  if not ExisteFiltros then
  begin
    ShowMessage(' ATENCION! No se puede ejecutar una consulta sin filtros.');
    Exit;
  end;
  MontarConsulta;
  if EjecutaQFacturas then
  begin
    ActivarConsulta(False);
    if rgMarca.Properties.Items[rgMarca.ItemIndex].Value = 0 then
      iMarca := 1
    else
      iMarca := 0;
    cxGrid.SetFocus;
  end
  else
  begin
    ShowMessage('No existen datos con el criterio seleccionado.') ;
    ActivarConsulta(True);
    VaciarConsulta;
    SEEmpresa.SetFocus;
  end;
end;

procedure TFMarcaContable.MontarConsulta;
begin
  with QFacturas do
  begin
    SQL.Clear;
    SQL.Add(' select * from tfacturas_cab ');
    SQL.Add('  where contabilizado_fc = :valor ');


    if SEEmpresa.Text <> '' then
      SQL.Add(Format(' and %s', [ SEEmpresa.SQLExpr ]));
    if SESerie.Text <> '' then
      SQL.Add(Format(' and %s', [ SESerie.SQLExpr ]));
    if SECodFactura.Text <> '' then
      SQL.Add(Format(' and %s', [ SECodFactura.SQLExpr ]));
    if SECliente.Text <> '' then
      SQL.Add(Format(' and %s', [ SECliente.SQLExpr ]));
    if SENumFactura.Text <> '' then
      SQL.Add(Format(' and %s', [ SENumFactura.SQLExpr ]));
    if SEFecFactura.Text <> '' then
      SQL.Add(Format(' and %s', [ SEFecFactura.SQLExpr ]));
    if SEImporteNeto.Text <> '' then
      SQL.Add(Format(' and %s', [ SEImporteNeto.SQLExpr ]));
    if SEImporteTotal.Text <> '' then
      SQL.Add(Format(' and %s', [ SEImporteTotal.SQLExpr ]));
    if SEFecConta.Text <> '' then
      SQL.Add(Format(' and %s', [ SEFecConta.SQLExpr ]));

    SQL.Add(' order by cod_empresa_fac_fc, cod_serie_fac_fc, n_factura_fc, fecha_factura_fc ');
//    ParamByName('valor').DataType := ftString;
  end;
end;


procedure TFMarcaContable.dxSalirClick(Sender: TObject);
var sAux: String;
begin
  if cxGrid.Enabled then
  begin
    if dxMarca.Enabled then
    begin
      sAux := 'El proceso no se ejecutará. ¿Desea salir del Mantenimiento?';
      case MessageDlg(sAux, mtInformation, [mbNo,mbYes],0) of
      mryes:
      begin
        ActivarConsulta(True);
        VaciarConsulta;
        tvFacturas.DataController.Filter.Root.Clear;
        QFacturas.Close;
        SEEmpresa.SetFocus;
      end;
      mrno:
      begin
        Exit;
      end;
      end;
    end
    else
    begin
      ActivarConsulta(True);
      VaciarConsulta;
      tvFacturas.DataController.Filter.Root.Clear;
      QFacturas.Close;
      SEEmpresa.SetFocus;
    end;
  end
  else
    Close;
end;

procedure TFMarcaContable.ActivarConsulta(AValor: boolean);
begin
  pnlConsulta.Enabled := AValor;
  dxLocalizar.Enabled := AValor;
  dxMarca.Enabled := False;

  cxTabControl.Enabled := not AValor;
  cxGrid.Enabled := not AValor;
  btnSeleccionar.Enabled := not AValor;
  btnCancelar.Enabled := not AValor;
end;

procedure TFMarcaContable.VaciarConsulta;
begin
  SEEmpresa.Text := '';
  SESerie.Text := '';
  SECodFactura.Text := '';
  SECliente.Text := '';
  SENumFactura.Text := '';
  SEFecFactura.Text := '';
  SEImporteNeto.Text := '';
  SEImporteTotal.Text := '';
  SEFecConta.Text := '';
end;

procedure TFMarcaContable.btnSeleccionarClick(Sender: TObject);
var i: Integer;
begin
  tvFacturas.BeginUpdate;
  for i:=0 to tvFacturas.DataController.RecordCount-1 do
    tvFacturas.DataController.SetValue(i,tvMarca.Index, True);
  tvFacturas.EndUpdate;
  dxMarca.Enabled := True;
end;

procedure TFMarcaContable.btnCancelarClick(Sender: TObject);
var i: integer;
begin
  tvFacturas.BeginUpdate;
  for i:=0 to tvFacturas.DataController.RecordCount-1 do
    tvFacturas.DataController.SetValue(i,tvMarca.Index, False);
  tvFacturas.EndUpdate;
  dxMarca.Enabled := False;
end;

procedure TFMarcaContable.tvMarcaPropertiesChange(Sender: TObject);
var i:Integer;
begin
  dxMarca.Enabled := false;
  for i:= 0 to tvFacturas.Datacontroller.RecordCount-1 do
    if tvFacturas.DataController.GetValue(i, tvMarca.Index) = True then
    begin
      dxMarca.Enabled := true;
      exit;
    end;
end;

procedure TFMarcaContable.FormShow(Sender: TObject);
begin
  ActivarConsulta(True);
  rgMarca.ItemIndex := 0;
  SEEmpresa.SetFocus;
end;

procedure TFMarcaContable.FormClose(Sender: TObject;
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

procedure TFMarcaContable.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F1:
    begin
      if dxLocalizar.Enabled then  dxLocalizarClick(Self)
      else if dxMarca.Enabled then dxMarcaClick(Self);
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

procedure TFMarcaContable.dxMarcaClick(Sender: TObject);
var sAux: String;
begin
  if rgMarca.Properties.Items[rgMarca.ItemIndex].Value = 0 then         //Facturas NO contabilizadas
    sAux := 'Las Facturas seleccionadas se marcarán como Contabilizadas. ¿Continuar con el proceso?'
  else
    sAux := 'Las Facturas seleccionadas se marcarán como NO Contabilizadas. ¿Continuar con el proceso?';

  case MessageDlg(sAux, mtInformation, [mbCancel,mbOk],0) of
  mrOk:
  begin
    ActualizarFactura;
    ActivarConsulta(True);
    VaciarConsulta;
    tvFacturas.DataController.Filter.Root.Clear;
    QFacturas.Close;
    SEEmpresa.SetFocus;
  end;
  mrCancel:
  begin
    Exit;
  end;
  end;
end;

procedure TFMarcaContable.ActualizarFactura;
var i:integer;
begin
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
  QFacturas.ApplyUpdates(0);

  ShowMessage('Proceso finalizado correctamente');
end;

function TFMarcaContable.ExisteFiltros: boolean;
begin
  if (SEEmpresa.Text <> '') or (SESerie.Text <> '') or (SECodFactura.Text <> '') or (SECliente.Text <> '') or (SENumFactura.Text <> '') or
     (SEFecFactura.Text <> '') or (SEImporteNeto.Text <> '') or (SEImporteTotal.Text <> '') or
     (SEFecConta.Text <> '') then
      Result := true
  else

      Result := false;
end;

procedure TFMarcaContable.tvDesClienteGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
var AEmpresa, ACliente: Variant;
begin
  if tvFacturas.GetColumnByFieldName('cod_empresa_fac_fc') <> nil then
    AEmpresa := ARecord.Values[tvFacturas.GetColumnByFieldName('cod_empresa_fac_fc').Index]
  else
    AEmpresa := null;

  if tvFacturas.GetColumnByFieldName('cod_cliente_fc') <> nil then
    ACliente := ARecord.Values[tvFacturas.GetColumnByFieldName('cod_cliente_fc').Index]
  else
    ACliente := null;

  AText := DesCliente(ACliente);
end;

procedure TFMarcaContable.tvTipoFacturaGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
var ATipo: Variant;
begin
  if tvFacturas.GetColumnByFieldName('tipo_factura_fc') <> nil then
    ATipo := ARecord.Values[tvFacturas.GetColumnByFieldName('tipo_factura_fc').Index]
  else
    ATipo := null;

  if ATipo = '380' then
    AText := 'FACTURA'
  else
    AText := 'ABONO';
end;

procedure TFMarcaContable.tvDesImpuestoGetDisplayText(
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

procedure TFMarcaContable.ssClienteAntesEjecutar(Sender: TObject);
begin
//  if SEEmpresa.Text <> '' then
//    ssCliente.SQLAdi := ' empresa_c = ' + QuotedStr(.Text);
end;

end.
