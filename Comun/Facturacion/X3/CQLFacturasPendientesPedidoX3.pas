unit CQLFacturasPendientesPedidoX3;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB;

type
  TDQLFacturasPendientesPedidoX3 = class(TQuickRep)
    bndCabeceraListado: TQRBand;
    bndDetalle: TQRBand;
    bndCabeceraGrupo: TQRGroup;
    bndPieGrupo: TQRBand;
    bndPieListado: TQRBand;
    lblTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    bndCabeceraColumnas: TQRBand;
    QRLabel1: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    qrdbtxtimporte_factura_f: TQRDBText;
    qrxpr_factura_f: TQRExpr;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    qrdbtxtimporte_remesado_f: TQRDBText;
    QRDBText10: TQRDBText;
    QRLabel10: TQRLabel;
    qrxpr_remesado_f: TQRExpr;
    QRDBText7: TQRDBText;
    QRLabel15: TQRLabel;
    lblFechaCobro: TQRLabel;
    qreplanta_fr: TQRDBText;
    qrgrp1: TQRGroup;
    QRDBText1: TQRDBText;
    QRDBText6: TQRDBText;
    qrdbtxtmoneda_f: TQRDBText;
    QRBand1: TQRBand;
    qrxpr_factura_f1: TQRExpr;
    qrxpr_remesado_f1: TQRExpr;
    QRDBText5: TQRDBText;
    QRLabel16: TQRLabel;
    qrdbtxtfecha_pendiente_f: TQRDBText;
    qrlbl4: TQRLabel;
    qrlblFechaVencimiento: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl12: TQRLabel;
    qrdbtxtcliente_fac_f1: TQRDBText;
    qrdbtxtcliente_fac_f2: TQRDBText;
    qrdbtxtempresa_f: TQRDBText;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrdbtxtn_factura_f: TQRDBText;
    qrlbl3: TQRLabel;
    qrlbl6: TQRLabel;
    qrdbtxtn_factura_f1: TQRDBText;
    qrlbl7: TQRLabel;
    procedure QRDBText6Print(sender: TObject; var Value: String);
    procedure QRLabel15Print(sender: TObject; var Value: String);
    procedure qrdbtxtmoneda_fPrint(sender: TObject;
      var Value: String);
    procedure QRLabel16Print(sender: TObject; var Value: String);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPieGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndResumenBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPieListadoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtcliente_fac_f1Print(sender: TObject;
      var Value: String);
    procedure qrdbtxtcliente_fac_f2Print(sender: TObject;
      var Value: String);
    procedure qrgrp1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndCabeceraGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText10Print(sender: TObject; var Value: String);
    procedure qrdbtxtn_factura_f1Print(sender: TObject; var Value: String);
  private
    bEuros: Boolean;
  public
    procedure PonerDataSet( const ADataSet: TDataSet );
    procedure ImportesEnEuro( const AEnEuros: Boolean );
    procedure FechaPendiente( const ATesoreria: Boolean );
  end;

  procedure Listado( const AComponent: TComponent; const ADataSet: TDataSet; const AEmpresa, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string;
                     const ATesoreria, AEnEuros: Boolean );
  function EnviarListado( const AComponent: TComponent; const ADataSet: TDataSet; const AEmpresa, ACliente, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string;
                          const ATesoreria, AEnEuros: Boolean; const AAsunto, ACuerpo: String; var VCancelar: boolean  ): Boolean;

implementation

{$R *.DFM}

uses DPreview, CReportes, CMLFacturasPendientes, UDMAuxDB, Variants, DConfigMail, TypInfo;


procedure Listado( const AComponent: TComponent; const ADataSet: TDataSet; const AEmpresa, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string; const ATesoreria, AEnEuros: Boolean );
var
  DQLFacturasPendientesPedidoX3: TDQLFacturasPendientesPedidoX3;
begin
  DQLFacturasPendientesPedidoX3:= TDQLFacturasPendientesPedidoX3.Create( AComponent );
  try
    DQLFacturasPendientesPedidoX3.ImportesEnEuro( AEnEuros );
    DQLFacturasPendientesPedidoX3.FechaPendiente( ATesoreria );
    DQLFacturasPendientesPedidoX3.PonerDataSet( ADataSet );
    PonLogoGrupoBonnysa(DQLFacturasPendientesPedidoX3, AEmpresa);
    (*BAG*)
    if ( AFechaCobroIni <> '' ) and ( AFechaCobroIni <> '' ) then
      DQLFacturasPendientesPedidoX3.lblFechaCobro.Caption:= 'Cobro desde ' + AFechaCobroIni + ' hasta ' + AFechaCobroFin
    else
    if AFechaCobroIni <> ''  then
      DQLFacturasPendientesPedidoX3.lblFechaCobro.Caption:= 'Cobro desde ' + AFechaCobroIni
    else
    if  AFechaCobroIni <> '' then
      DQLFacturasPendientesPedidoX3.lblFechaCobro.Caption:= 'Cobro hasta ' + AFechaCobroFin
    else
      DQLFacturasPendientesPedidoX3.lblFechaCobro.Caption:= '';

    Preview( DQLFacturasPendientesPedidoX3 );
  except
    FreeAndNil(DQLFacturasPendientesPedidoX3);
  end;
end;

function EnviarListado( const AComponent: TComponent; const ADataSet: TDataSet; 
                        const AEmpresa, ACliente, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string;
                        const ATesoreria, AEnEuros: Boolean; const AAsunto, ACuerpo: String; var VCancelar: boolean ): Boolean;
var
  DQLFacturasPendientesPedidoX3: TDQLFacturasPendientesPedidoX3;
begin
  DQLFacturasPendientesPedidoX3:= TDQLFacturasPendientesPedidoX3.Create( AComponent );
  try
    DQLFacturasPendientesPedidoX3.ImportesEnEuro( AEnEuros );
    DQLFacturasPendientesPedidoX3.FechaPendiente( ATesoreria );
    DQLFacturasPendientesPedidoX3.PonerDataSet( ADataSet );
    PonLogoGrupoBonnysa(DQLFacturasPendientesPedidoX3, AEmpresa);
    (*BAG*)
    if ( AFechaCobroIni <> '' ) and ( AFechaCobroIni <> '' ) then
      DQLFacturasPendientesPedidoX3.lblFechaCobro.Caption:= 'Cobro desde ' + AFechaCobroIni + ' hasta ' + AFechaCobroFin
    else
    if AFechaCobroIni <> ''  then
      DQLFacturasPendientesPedidoX3.lblFechaCobro.Caption:= 'Cobro desde ' + AFechaCobroIni
    else
    if  AFechaCobroIni <> '' then
      DQLFacturasPendientesPedidoX3.lblFechaCobro.Caption:= 'Cobro hasta ' + AFechaCobroFin
    else
      DQLFacturasPendientesPedidoX3.lblFechaCobro.Caption:= '';
    DQLFacturasPendientesPedidoX3.ReportTitle:='listfac';
    result:= EnviarInformeACliente( DQLFacturasPendientesPedidoX3, AEmpresa, ACliente, AAsunto, ACuerpo, VCancelar );

  finally
    FreeAndNil(DQLFacturasPendientesPedidoX3);
  end;
end;

procedure TDQLFacturasPendientesPedidoX3.PonerDataSet( const ADataSet: TDataSet );
var
  x : integer;
begin
  DataSet:= ADataSet;
  For x := 0 To ComponentCount - 1 Do
  begin
    If Components[x] Is TQRDBText Then
      TQRDBText(Components[x]).DataSet := ADataSet;
  end;
end;

procedure TDQLFacturasPendientesPedidoX3.ImportesEnEuro( const AEnEuros: Boolean );
begin
  bEuros:= AEnEuros;
  if AEnEuros then
  begin
    bndCabeceraGrupo.Expression:= '';
    qrdbtxtmoneda_f.Enabled:= False;

    qrdbtxtimporte_factura_f.DataField:= 'euros_factura_f';
    qrxpr_factura_f.Expression:= 'sum([euros_factura_f])';
    qrxpr_factura_f1.Expression:= 'sum([euros_factura_f])';

    qrdbtxtimporte_remesado_f.DataField:= 'euros_pendiente_f';
    qrxpr_remesado_f.Expression:= 'sum([euros_pendiente_f])';
    qrxpr_remesado_f1.Expression:= 'sum([euros_pendiente_f])';
  end
  else
  begin
    bndCabeceraGrupo.Expression:= '[moneda_f]';
    qrdbtxtmoneda_f.Enabled:= True;

    qrdbtxtimporte_factura_f.DataField:= 'importe_factura_f';
    qrxpr_factura_f.Expression:= 'sum([importe_factura_f])';
    qrxpr_factura_f1.Expression:= 'sum([importe_factura_f])';

    qrdbtxtimporte_remesado_f.DataField:= 'importe_pendiente_f';
    qrxpr_remesado_f.Expression:= 'sum([importe_pendiente_f])';
    qrxpr_remesado_f1.Expression:= 'sum([importe_pendiente_f])';
  end;
end;

procedure TDQLFacturasPendientesPedidoX3.FechaPendiente( const ATesoreria: Boolean );
begin
  if ATesoreria then
  begin
    lblTitulo.Caption:= 'FACTURAS PENDIENTES DE COBRO PREVISTO';
    ReportTitle:= 'FactPendientesCobroPrevisto_' + FormatDateTime('yyyymmdd_hhMM', Now );
    //qrdbtxtdias_tesoreria.DataField:= 'dias_tesoreria';
    qrlblFechaVencimiento.Caption:= 'PREVISTA';
    qrdbtxtfecha_pendiente_f.DataField:= 'fecha_prevista_f';
  end
  else
  begin
    lblTitulo.Caption:= 'FACTURAS PENDIENTES DE COBRO VENCIMIENTO';
    ReportTitle:= 'FactPendientesCobroVencimiento_'+ FormatDateTime('yyyymmdd_hhMM', Now );
    //qrdbtxtdias_tesoreria.DataField:= 'dias_vencimiento';
    qrlblFechaVencimiento.Caption:= 'VENCIMIENTO';
    qrdbtxtfecha_pendiente_f.DataField:= 'fecha_vencimiento_f';
  end;
end;


procedure TDQLFacturasPendientesPedidoX3.QRDBText6Print(sender: TObject;
  var Value: String);
begin
  Value:= desCliente( DataSet.FieldByName('empresa_f').AsString, Value );
end;

procedure TDQLFacturasPendientesPedidoX3.QRLabel15Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL CLIENTE ' +  DataSet.FieldByName('cliente_fac_f').AsString;
end;

procedure TDQLFacturasPendientesPedidoX3.qrdbtxtmoneda_fPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desMoneda( value );
end;

procedure TDQLFacturasPendientesPedidoX3.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TDQLFacturasPendientesPedidoX3.bndPieGrupoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TDQLFacturasPendientesPedidoX3.bndResumenBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TDQLFacturasPendientesPedidoX3.bndPieListadoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TDQLFacturasPendientesPedidoX3.qrdbtxtcliente_fac_f1Print(
  sender: TObject; var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value:= desCliente( DataSet.FieldByName('empresa_f').AsString, Value );
end;

procedure TDQLFacturasPendientesPedidoX3.qrdbtxtcliente_fac_f2Print(
  sender: TObject; var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= '';
end;

procedure TDQLFacturasPendientesPedidoX3.qrgrp1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TDQLFacturasPendientesPedidoX3.bndCabeceraGrupoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if bEuros then
    Sender.Height:= 0
  else
    Sender.Height:= 24;
end;

procedure TDQLFacturasPendientesPedidoX3.QRDBText10Print(sender: TObject;
  var Value: String);
begin
  if bEuros then
    Value:= 'EUR';
end;

procedure TDQLFacturasPendientesPedidoX3.QRLabel16Print(sender: TObject;
  var Value: String);
begin
  if bEuros then
    Value:= 'TOTAL INFORME EN EUROS '
  else
    Value:= 'TOTAL MONEDA ' +  DataSet.FieldByName('moneda_f').AsString;
end;

procedure TDQLFacturasPendientesPedidoX3.qrdbtxtn_factura_f1Print(
  sender: TObject; var Value: String);
begin
  Value:= desSuministro( DataSet.fieldByName('empresa_f').AsString , DataSet.fieldByName('cliente_fac_f').AsString, Value );
end;

end.
