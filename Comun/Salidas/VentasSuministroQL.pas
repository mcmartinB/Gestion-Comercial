unit VentasSuministroQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables, VentasSuministroDL;

type
  TQLVentasSuministro = class(TQuickRep)
    bndTitulo: TQRBand;
    bndDetalle: TQRBand;
    bndCabeceraColumna: TQRBand;
    bndPiePagina: TQRBand;
    lblImpresoEl: TQRSysData;
    lblTitulo: TQRSysData;
    lblPaginaNum: TQRSysData;
    QRGroup1: TQRGroup;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRGroup2: TQRGroup;
    etqCajasAnt: TQRDBText;
    etqKilosAnt: TQRDBText;
    etqImporteAnt: TQRDBText;
    shpSep11: TQRShape;
    shpSep12: TQRShape;
    QRBand2: TQRBand;
    QRLabel2: TQRLabel;
    SummaryBand1: TQRBand;
    QRLabel3: TQRLabel;
    lblGuia: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    lblCajasAnt: TQRLabel;
    lblKilosAnt: TQRLabel;
    lblImporteAnt: TQRLabel;
    QRShape4: TQRShape;
    shpAnterior: TQRShape;
    bndTotalProducto: TQRBand;
    QRLabel1: TQRLabel;
    QRDBText3: TQRDBText;
    shpDiferencia: TQRShape;
    lblKilosDif: TQRLabel;
    lblImporteDif: TQRLabel;
    lblDiferencia: TQRLabel;
    shpSep13: TQRShape;
    shpSep21: TQRShape;
    shpSep22: TQRShape;
    shpSep23: TQRShape;
    shpSep31: TQRShape;
    shpSep32: TQRShape;
    shpSep33: TQRShape;
    shpTotalAct: TQRShape;
    shpTotalAnt: TQRShape;
    shpTotalDif: TQRShape;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr14: TQRExpr;
    QRExpr15: TQRExpr;
    QRExpr16: TQRExpr;
    QRExpr17: TQRExpr;
    QRExpr18: TQRExpr;
    QRExpr19: TQRExpr;
    QRExpr20: TQRExpr;
    QRExpr26: TQRExpr;
    QRExpr27: TQRExpr;
    QRExpr21: TQRExpr;
    QRExpr22: TQRExpr;
    QRExpr23: TQRExpr;
    QRExpr24: TQRExpr;
    QRLabel4: TQRLabel;
    qrlRangoFechasAct: TQRLabel;
    qrlRangoFechasAnt: TQRLabel;
    qrlGuia: TQRLabel;
    qrdbtxtsuministro: TQRDBText;
    qrdbtxtenvase: TQRDBText;
    qrlblEnvase: TQRLabel;
    procedure qrdbtxtsuministroPrint(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText3Print(sender: TObject; var Value: String);
    procedure QRLabel1Print(sender: TObject; var Value: String);
    procedure QRLabel2Print(sender: TObject; var Value: String);
    procedure QRExpr23Print(sender: TObject; var Value: String);
    procedure QRLabel3Print(sender: TObject; var Value: String);
    procedure qrlGuiaPrint(sender: TObject; var Value: String);
    procedure qrdbtxtenvasePrint(sender: TObject; var Value: String);
    procedure qrlblEnvasePrint(sender: TObject; var Value: String);

  private

  public
    bComparar: Boolean;
    iAgrupar: Integer;
    bEnvase: Boolean;
    sCliente: string;
  end;

procedure LoadReport( APadre: TComponent );
procedure UnloadReport;
procedure ExecuteReport( APadre: TComponent; AParametros: RParametrosVentasSuministro );

implementation

{$R *.DFM}

uses UDMAuxDB, CReportes, Dpreview, Dialogs;

var
  QLVentasSuministro: TQLVentasSuministro;
  iContadorUso: integer = 0;

procedure LoadReport( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      QLVentasSuministro:= TQLVentasSuministro.Create( APadre );
    except
      iContadorUso:= 0;
      raise;
    end;
  end;
  VentasSuministroDL.LoadModule( APadre );
end;

procedure UnloadReport;
begin
  if iContadorUso > 0  then
  begin
    Dec( iContadorUso );
    if iContadorUso = 0 then
    begin
      if QLVentasSuministro <> nil then
        FreeAndNil( QLVentasSuministro );
    end;
  end;
  VentasSuministroDL.UnloadModule;
end;

procedure ExecuteReport( APadre: TComponent; AParametros: RParametrosVentasSuministro );
begin
  LoadReport( APadre );
  if VentasSuministroDL.OpenData( APadre, AParametros) <> 0 then
  begin
    QLVentasSuministro.ReportTitle:= 'INF. VENTAS CENTRO SUMINISTRO';
    QLVentasSuministro.bComparar:= AParametros.bComparar;
    QLVentasSuministro.bEnvase:= AParametros.bEnvase;
    QLVentasSuministro.iAgrupar:= AParametros.iAgrupar;
    QLVentasSuministro.qrlRangoFechasAct.Caption:= 'Del ' + FormatDateTime( 'dd/mm/yy',  AParametros.dFechaDesde ) +
      ' al ' + FormatDateTime( 'dd/mm/yy',  AParametros.dFechaHasta );
    QLVentasSuministro.qrlRangoFechasAnt.Caption:= 'Del ' + FormatDateTime( 'dd/mm/yy',  AParametros.dFechaDesdeAnt ) +
      ' al ' + FormatDateTime( 'dd/mm/yy', AParametros.dFechaHastaAnt );
    PonLogoGrupoBonnysa( QLVentasSuministro, AParametros.sEmpresa );
    QLVentasSuministro.QRGroup2.ForceNewPage:= not AParametros.bCompactar;
    Previsualiza( QLVentasSuministro );
  end
  else
  begin
    ShowMessage('Sin datos para mostrar para los parametros de selección introducidos.');
  end;
  UnloadReport;
end;


procedure TQLVentasSuministro.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  qrlRangoFechasAnt.Enabled:= bComparar;
  lblCajasAnt.Enabled:= bComparar;
  lblKilosAnt.Enabled:= bComparar;
  lblImporteAnt.Enabled:= bComparar;

  lblDiferencia.Enabled:= bComparar;
  lblKilosDif.Enabled:= bComparar;
  lblImporteDif.Enabled:= bComparar;
  shpDiferencia.Enabled:= bComparar;

  shpSep11.Enabled:= bComparar;
  shpSep12.Enabled:= bComparar;
  shpSep13.Enabled:= bComparar;

  shpSep21.Enabled:= bComparar;
  shpSep22.Enabled:= bComparar;
  shpSep23.Enabled:= bComparar;

  shpSep31.Enabled:= bComparar;
  shpSep32.Enabled:= bComparar;
  shpSep33.Enabled:= bComparar;

  shpAnterior.Enabled:= bComparar;
  shpDiferencia.Enabled:= bComparar;
  shpTotalAnt.Enabled:= bComparar;
  shpTotalDif.Enabled:= bComparar;

  etqCajasAnt.Enabled:= bComparar;
  etqKilosAnt.Enabled:= bComparar;
  etqImporteAnt.Enabled:= bComparar;

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

  if not bEnvase then
  begin
    qrlGuia.Left:= qrdbtxtenvase.Left;
    lblGuia.Left:= qrlblEnvase.Left;
  end
  else
  begin
    qrlGuia.Left:= 47;
    lblGuia.Left:= 47;
  end;
end;

procedure TQLVentasSuministro.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //TQRCustomBand( Sender ).Height:= 0;
end;

procedure TQLVentasSuministro.QRDBText3Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('linea').AsString <> '' then
    Value:= DataSet.FieldByName('linea').AsString + ' - ' + desLineaProducto( DataSet.FieldByName('linea').AsString )
  else
    Value:= Value + ' - ' + desProducto( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQLVentasSuministro.qrdbtxtsuministroPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('suministro').AsString <> '' then
  begin
    sCliente:= DataSet.FieldByName('empresa').AsString + '-' + Value + '-' + DataSet.FieldByName('suministro').AsString;
    Value:= sCliente + ' ' + desSuministro( DataSet.FieldByName('empresa').AsString, value, DataSet.FieldByName('suministro').AsString );
  end
  else
  begin
    sCliente:= DataSet.FieldByName('empresa').AsString + '-' + Value;
    Value:= sCliente + ' ' + desCliente( value );
  end;


end;

procedure TQLVentasSuministro.QRLabel1Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('linea').AsString <> '' then
    Value:= '[' + DataSet.FieldByName('linea').AsString + ' ' + sCliente+ ']'
  else
    Value:= '[' + DataSet.FieldByName('producto').AsString + ' ' + sCliente + ']';
end;

procedure TQLVentasSuministro.QRLabel2Print(sender: TObject;
  var Value: String);
begin
  Value:= 'CLIENTE ' + sCliente;
end;

procedure TQLVentasSuministro.QRExpr23Print(sender: TObject;
  var Value: String);
var
  sAux: String;
begin
  try
    sAux:= StringReplace( Value, '.', '', [rfReplaceAll, rfIgnoreCase] );
    sAux:= StringReplace( sAux, ',', '.', [rfReplaceAll, rfIgnoreCase] );
    if StrToInt( sAux ) < 0 then
      TQRExpr( Sender ).Font.Style:= TQRExpr( Sender ).Font.Style + [fsItalic]
    else
      TQRExpr( Sender ).Font.Style:= TQRExpr( Sender ).Font.Style - [fsItalic];
  except
    TQRExpr( Sender ).Font.Style:= TQRExpr( Sender ).Font.Style - [fsItalic];
  end;
end;

procedure TQLVentasSuministro.QRLabel3Print(sender: TObject;
  var Value: String);
begin
  //Value:= 'TOTAL ' + '[' + sCliente + ']';
end;

procedure TQLVentasSuministro.qrlGuiaPrint(sender: TObject;
  var Value: String);
begin
  if bComparar then
  begin
    case iAgrupar of
      1://Total
        Value:= '';
      2, 3://Anual-Mensual
        Value:= Dataset.FieldByName('guia').AsString + ' - ' + Dataset.FieldByName('guia_ant').AsString;
      4://Semanal
        if ( Dataset.FieldByName('guia').AsString <> '' ) and
           ( Dataset.FieldByName('guia_ant').AsString <> '' ) then
        begin
          Value:= Dataset.FieldByName('guia').AsString + ' - ' + Dataset.FieldByName('guia_ant').AsString;
        end
        else
        if ( Dataset.FieldByName('guia').AsString <> '' ) then
        begin
          Value:= Dataset.FieldByName('guia').AsString + ' - ------' ;
        end
        else
        if ( Dataset.FieldByName('guia_ant').AsString <> '' ) then
        begin
          Value:= '------ - ' + Dataset.FieldByName('guia_ant').AsString;
        end;
      5://Diaria
        if ( Dataset.FieldByName('guia').AsString <> '' ) and
           ( Dataset.FieldByName('guia_ant').AsString <> '' ) then
        begin
          Value:= FormatDateTime( 'dd/mm/yy', Dataset.FieldByName('guia').AsDateTime ) + ' - ' +
                FormatDateTime( 'dd/mm/yy', Dataset.FieldByName('guia_ant').AsDateTime );
        end
        else
        if ( Dataset.FieldByName('guia').AsString <> '' ) then
        begin
          Value:= FormatDateTime( 'dd/mm/yy', Dataset.FieldByName('guia').AsDateTime ) + ' - --/--/--' ;
        end
        else
        if ( Dataset.FieldByName('guia_ant').AsString <> '' ) then
        begin
          Value:= '--/--/-- - ' + FormatDateTime( 'dd/mm/yy', Dataset.FieldByName('guia_ant').AsDateTime );
        end;
    end;
  end
  else
  begin
    case iAgrupar of
      1://Total
        Value:= '';
      2, 3, 4://Anual-Mensual-Semanal
        Value:= Dataset.FieldByName('guia').AsString;
      5://Diaria
        Value:= FormatDateTime( 'dd/mm/yy', Dataset.FieldByName('guia').AsDateTime );
    end;
  end;
end;

procedure TQLVentasSuministro.qrdbtxtenvasePrint(sender: TObject;
  var Value: String);
begin
  if bEnvase then
    Value:= Value + ' ' + desEnvase( DataSet.FieldByName('empresa').AsString, Value )
  else
    Value:= '';
end;

procedure TQLVentasSuministro.qrlblEnvasePrint(sender: TObject;
  var Value: String);
begin
  if bEnvase then
    Value:= 'ENVASE'
  else
    Value:= '';
end;

end.

