unit UFConsultaRem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, dxBar, ActnList,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxTextEdit, BonnyQuery, cxCalendar, cxCurrencyEdit,

  dxSkinsCore, dxSkinBlue, dxSkinFoggy, dxSkinscxPCPainter, dxSkinsdxBarPainter,
  dxSkinBlueprint, dxSkinMoneyTwins;

type
  TFConsultaRem = class(TForm)
    ds: TDataSource;
    cxGrid: TcxGrid;
    tvRemesas: TcxGridDBTableView;
    tvEmpresa: TcxGridDBColumn;
    tvCliente: TcxGridDBColumn;
    tvFecVto: TcxGridDBColumn;
    tvRemesa: TcxGridDBColumn;
    tvBanco: TcxGridDBColumn;
    tvImporteTotal: TcxGridDBColumn;
    lvRemesas: TcxGridLevel;
    tvFecDes: TcxGridDBColumn;
    bmx1: TdxBarManager;
    bmx1Bar1: TdxBar;
    dxAceptar: TdxBarLargeButton;
    dxCancelar: TdxBarLargeButton;
    tvImporteFacturas: TcxGridDBColumn;
    tvDesCliente: TcxGridDBColumn;
    tvDesBanco: TcxGridDBColumn;
    ActionList: TActionList;
    ACancelar: TAction;
    AAceptar: TAction;
    procedure tvDesClienteOldGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: String);
    procedure FormShow(Sender: TObject);
    procedure dxAceptarClick(Sender: TObject);
    procedure dxCancelarClick(Sender: TObject);
    procedure tvRemesasDblClick(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure AAceptarExecute(Sender: TObject);
  private
    QConsulta: TBonnyQuery;

    procedure CreaQConsulta;
    function EjecutaQConsulta: boolean;
    procedure CreaCamposCon(Datos: TDataSet);
    procedure CalcCamposCon(Datos: TDataSet);

  public
    CadenaCon, CadenaResult: String;
    sEmpresa, sRemesa: String;
  end;

var
  FConsultaRem: TFConsultaRem;

implementation

{$R *.dfm}

uses UDFactura;

procedure TFConsultaRem.tvDesClienteOldGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
var QCliente : TBonnyQuery;
    AEmpresa, ACliente: String;
begin
{
  if tvRemesas.GetColumnByFieldName('empresa_remesa_rc') <> nil then
    AEmpresa := ARecord.Values[tvRemesas.GetColumnByFieldName('empresa_remesa_rc').Index];
  if tvRemesas.GetColumnByFieldName('cod_cliente_rc') <> nil then
    ACliente := ARecord.Values[tvRemesas.GetColumnByFieldName('cod_cliente_rc').Index];


  QCliente := TBonnyQuery.Create(Self);
  with QCliente do
  try
    SQL.Add(' select nombre_c from frf_clientes ');
    SQL.Add('  where empresa_c = :empresa ');
    SQL.Add('    and cliente_c = :cliente ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('cliente').AsString := ACliente;

    Open;

    AText := FieldByName('nombre_c').AsString;
  finally
    Free;
  end;
}
end;

procedure TFConsultaRem.CreaQConsulta;
begin
  QConsulta := TBonnyQuery.Create(Self);
  DS.DataSet := QConsulta;
  with QConsulta do
  begin
    SQL.Add(' select * from tremesas_cab ' + CadenaCon );

    CreaCamposCon(QConsulta);
    OnCalcFields := CalcCamposCon;
  end;

end;

function TFConsultaRem.EjecutaQConsulta: boolean;
begin
  with QConsulta do
  begin

    Open;
    result := not IsEmpty;
  end;
end;

procedure TFConsultaRem.CreaCamposCon(Datos: TDataSet);
var I: integer;
begin
  Datos.FieldDefs.Update;
  for I :=0 to Datos.FieldDefs.Count-1 do Datos.FieldDefs[I].CreateField(Datos);

  with TCurrencyField.Create(Datos) do
    begin
    Calculated:= true;
    FieldName:= 'importeFacturas';
    DataSet:= Datos;
    DisplayFormat:= ',0.00';
    EditFormat   := '#.00';
   end;
  with TStringField.Create(Datos) do
    begin
    Calculated:= true;
    FieldName:= 'desCliente';
    DataSet:= Datos;
    size := 30;
    end;

  with TStringField.Create(Datos) do
    begin
    Calculated:= true;
    FieldName:= 'desBanco';
    DataSet:= Datos;
    size := 30;
    end;

end;

procedure TFConsultaRem.CalcCamposCon(Datos: TDataSet);
var QDatos: TBonnyQuery;
begin
  QDatos := TBonnyQuery.Create(Self);
  with QDatos do
  try
          // Descripcion Cliente
    SQL.Add(' select nombre_c from frf_clientes ');
    SQL.Add('  where cliente_c = :cliente ');

    ParamByName('cliente').AsString := QConsulta.FieldByName('cod_cliente_rc').AsString;
    Open;
    Datos.FieldByName('desCliente').AsString := FieldByName('nombre_c').AsString;

          // Descripcion Banco
    if Active then
      Close;

    SQL.Clear;
    SQL.Add(' select descripcion_b from frf_bancos ');
    SQL.Add('  where banco_b = :banco ');

    ParamByName('banco').AsString := QConsulta.FieldByName('cod_banco_rc').AsString;

    Open;
    Datos.FieldByName('desBanco').AsString := FieldByName('descripcion_b').AsString;

         // Importe Facturas (tremesas_fac)
    if Active then
      Close;

    SQL.Clear;
    SQL.Add(' select NVL(SUM(importe_cobrado_rf), 0) importeFacturas');
    SQL.Add('  from tremesas_fac ');
    SQL.Add('  where empresa_remesa_rf = :empresa ');
    SQL.Add('    and n_remesa_rf = :remesa ');

    ParamByName('empresa').AsString := QConsulta.FieldByName('empresa_remesa_rc').AsString;
    ParamByName('remesa').AsString := QConsulta.FieldByName('n_remesa_rc').AsString;

    Open;
    Datos.FieldByName('importeFacturas').AsFloat := FieldByName('importeFacturas').AsFloat;

  finally
    Free;
  end;
end;


procedure TFConsultaRem.FormShow(Sender: TObject);
begin
  CreaQConsulta;
  if not EjecutaQConsulta then
    dxCancelarClick(Self);
  cxGrid.SetFocus;
end;

procedure TFConsultaRem.dxAceptarClick(Sender: TObject);
begin
  sEmpresa := tvRemesas.DataController.GetValue(tvRemesas.DataController.FocusedRecordIndex, tvEmpresa.Index);
  sRemesa := tvRemesas.DataController.GetValue(tvRemesas.DataController.FocusedRecordIndex, tvRemesa.Index);

  ModalResult := mrOK;
end;

procedure TFConsultaRem.dxCancelarClick(Sender: TObject);
begin
  ModalResult := mrCAncel;
end;

procedure TFConsultaRem.tvRemesasDblClick(Sender: TObject);
var AColumn: TcxGridDBColumn;
begin
   dxAceptarClick(Self);
end;

procedure TFConsultaRem.ACancelarExecute(Sender: TObject);
begin
  dxCancelar.Click;
end;

procedure TFConsultaRem.AAceptarExecute(Sender: TObject);
begin
  dxAceptar.Click;
end;

end.
