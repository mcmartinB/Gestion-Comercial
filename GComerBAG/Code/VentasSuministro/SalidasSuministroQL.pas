unit SalidasSuministroQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables, SalidasSuministroDL;

type
  TQLSalidasSuministro = class(TQuickRep)
    bndTitulo: TQRBand;
    bndCabeceraColumna: TQRBand;
    bndPiePagina: TQRBand;
    lblImpresoEl: TQRSysData;
    lblTitulo: TQRSysData;
    lblPaginaNum: TQRSysData;
    qrgFecha: TQRGroup;
    qrgSuministro: TQRGroup;
    bndTotalSuministro: TQRBand;
    QRLabel2: TQRLabel;
    SummaryBand1: TQRBand;
    QRLabel3: TQRLabel;
    lblGuia: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    bndTotalProducto: TQRBand;
    QRLabel1: TQRLabel;
    qredir_sum: TQRDBText;
    qrlCliente: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr14: TQRExpr;
    QRExpr18: TQRExpr;
    QRExpr19: TQRExpr;
    QRExpr20: TQRExpr;
    QRLabel4: TQRLabel;
    ChildBand1: TQRChildBand;
    ChildBand2: TQRChildBand;
    qrgProducto: TQRGroup;
    qrlRangoServido: TQRLabel;
    qrlFecha: TQRLabel;
    qreTipo: TQRDBText;
    qrxCajasProducto: TQRExpr;
    qrxCajasSuministro: TQRExpr;
    qrxCajasTotal: TQRExpr;
    bndTotalFecha: TQRBand;
    qrlTotalFecha: TQRLabel;
    qrxCajasTotalFecha: TQRExpr;
    qrxunidadesTotalFecha: TQRExpr;
    qrxKIlosTotalFecha: TQRExpr;
    qrxImporteTotalFecha: TQRExpr;
    QRBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    qreProducto: TQRDBText;
    qrsFecha: TQRShape;
    qrsSuministro: TQRShape;
    bndcFecha: TQRChildBand;
    qrlCajas: TQRLabel;
    qrlSuministro: TQRLabel;
    procedure qredir_sumPrint(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qreproductoPrint(sender: TObject; var Value: String);
    procedure QRLabel1Print(sender: TObject; var Value: String);
    procedure QRLabel2Print(sender: TObject; var Value: String);
    procedure QRLabel3Print(sender: TObject; var Value: String);
    procedure qrlGuiaPrint(sender: TObject; var Value: String);
    procedure qrlTotalFechaPrint(sender: TObject; var Value: String);
    procedure qreEnvasePrint(sender: TObject; var Value: String);
    procedure qrgProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);

  private

  public
    iAgrupar: Integer;
  end;

procedure LoadReport( APadre: TComponent );
procedure UnloadReport;
procedure ExecuteReport( APadre: TComponent; AParametros: RParametrosSalidasSuministro );

implementation

{$R *.DFM}

uses UDMAuxDB, CReportes, Dpreview, Dialogs;

var
  QLSalidasSuministro: TQLSalidasSuministro;
  iContadorUso: integer = 0;

procedure LoadReport( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      QLSalidasSuministro:= TQLSalidasSuministro.Create( APadre );
    except
      iContadorUso:= 0;
      raise;
    end;
  end;
  SalidasSuministroDL.LoadModule( APadre );
end;

procedure UnloadReport;
begin
  if iContadorUso > 0  then
  begin
    Dec( iContadorUso );
    if iContadorUso = 0 then
    begin
      if QLSalidasSuministro <> nil then
        FreeAndNil( QLSalidasSuministro );
    end;
  end;
  SalidasSuministroDL.UnloadModule;
end;

procedure ExecuteReport( APadre: TComponent; AParametros: RParametrosSalidasSuministro );
var
  sAux: string;
begin
  LoadReport( APadre );

  QLSalidasSuministro.ReportTitle:= 'SALIDAS POR CENTRO SUMINISTRO';
  QLSalidasSuministro.iAgrupar:= AParametros.iAgrupar;

  QLSalidasSuministro.qrlRangoServido.Caption:= 'Del ' + FormatDateTime( 'dd/mm/yy',  AParametros.dFechaDesde ) +
      ' al ' + FormatDateTime( 'dd/mm/yy', AParametros.dFechaHasta );

  sAux:= StringReplace(AParametros.sEmpresa, '''', '', [rfReplaceAll]);
  QLSalidasSuministro.qrlCliente.Caption:= AParametros.sCliente + ' - ' + desCliente( AParametros.sCliente );
  if AParametros.sSuministro <> '' then
  begin
    QLSalidasSuministro.qrlSuministro.Caption:= desSuministro( sAux,
                                                               AParametros.sCliente,
                                                               AParametros.sSuministro );
  end
  else
  begin
    QLSalidasSuministro.qrlSuministro.Caption:= 'TODOS LOS CENTROS';
  end;

  sAux:= StringReplace(AParametros.sEmpresa, '''', '', [rfReplaceAll]);
  PonLogoGrupoBonnysa( QLSalidasSuministro, sAux );
  Previsualiza( QLSalidasSuministro );

  UnloadReport;
end;


procedure TQLSalidasSuministro.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  case iAgrupar of
    1://Total
      lblGuia.Caption:= '';
    2://Anual
      lblGuia.Caption:= 'AÑO';
    3://Mes
      lblGuia.Caption:= 'AÑO/MES';
    4://Semanal
      lblGuia.Caption:= 'AÑO/SEMANA';
    5://Diaria
      lblGuia.Caption:= 'FECHA';
  end;
end;

procedure TQLSalidasSuministro.qreproductoPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - ' + desProducto( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQLSalidasSuministro.qredir_sumPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - ' + desSuministro( DataSet.FieldByName('empresa').AsString, DataSet.FieldByName('cliente').AsString, Value );
end;

procedure TQLSalidasSuministro.qreEnvasePrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - ' + desEnvaseP( DataSet.FieldByName('empresa').AsString, Value, DataSet.FieldByName('producto').AsString );
end;

procedure TQLSalidasSuministro.QRLabel1Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + desProducto( DataSet.FieldByName('empresa').AsString, DataSet.FieldByName('producto').AsString );
end;

procedure TQLSalidasSuministro.QRLabel2Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + desSuministro( DataSet.FieldByName('empresa').AsString, DataSet.FieldByName('cliente').AsString, DataSet.FieldByName('dir_sum').AsString );
end;

procedure TQLSalidasSuministro.qrlTotalFechaPrint(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + DataSet.FieldByName('fecha').AsString ;
end;

procedure TQLSalidasSuministro.QRLabel3Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + DataSet.FieldByName('cliente').AsString;
end;

procedure TQLSalidasSuministro.qrlGuiaPrint(sender: TObject;
  var Value: String);
begin
  case iAgrupar of
    1://Total
      Value:= '';
    2, 3, 4://Anual-Mensual-Semanal
      Value:= Dataset.FieldByName('fecha').AsString;
    5://Diaria
      Value:= FormatDateTime( 'dd/mm/yy', Dataset.FieldByName('fecha').AsDateTime );
  end;
end;

procedure TQLSalidasSuministro.qrgProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrgProducto.Height:= 0;
end;

end.

