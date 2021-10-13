unit CQLFacturasPendientesCarrefour;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLFacturasPendientesCarrefour = class(TQuickRep)
    bndCabeceraListado: TQRBand;
    bndDetalle: TQRBand;
    lblTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    bndCabeceraColumnas: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    qrdbtxtimporte_factura_f: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    qrdbtxtfecha_acobrar_f: TQRDBText;
    QRLabel5: TQRLabel;
    qrLabel98: TQRLabel;
    lblFechaCobro: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrdbtxtpendiente_remesar_f: TQRDBText;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrdbtxtpedidod: TQRDBText;
    qrdbtxtsuministro: TQRDBText;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl11: TQRLabel;
    qrlblEmpresa: TQRLabel;
    qrdbtxtcliente_fac_f: TQRDBText;
    bndCabeceraGrupo: TQRGroup;
    QRDBText4: TQRDBText;
    QRBand1: TQRBand;
    QRLabel16: TQRLabel;
    qrgrp1: TQRGroup;
    QRDBText1: TQRDBText;
    QRDBText6: TQRDBText;
    bndPieGrupo: TQRBand;
    QRExpr1: TQRExpr;
    QRLabel15: TQRLabel;
    qrxpr1: TQRExpr;
    bndResumen: TQRBand;
    QRExpr2: TQRExpr;
    QRLabel14: TQRLabel;
    bndPieListado: TQRBand;
    QRDBText7: TQRDBText;
    QRExpr4: TQRExpr;
    QRDBText5: TQRDBText;
    QRDBText8: TQRDBText;
    QRSysData2: TQRSysData;
    QRExpr3: TQRExpr;
    procedure QRDBText6Print(sender: TObject; var Value: String);
    procedure qrdbtxtfecha_acobrar_fPrint(sender: TObject; var Value: String);
    procedure QRLabel15Print(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure qrdbtxtfecha_cobro_fPrint(sender: TObject;
      var Value: String);
    procedure QRLabel5Print(sender: TObject; var Value: String);
    procedure qrdbtxtsuministroPrint(sender: TObject; var Value: String);
    procedure QRDBText3Print(sender: TObject; var Value: String);
    procedure bndPieListadoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndResumenBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPieGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtcliente_fac_fPrint(sender: TObject;
      var Value: String);
    procedure qrdbtxtcliente_fac_f1Print(sender: TObject;
      var Value: String);
    procedure qrgrp1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndCabeceraGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRDBText5Print(sender: TObject; var Value: string);
    procedure QRDBText8Print(sender: TObject; var Value: string);
    procedure QRDBText7Print(sender: TObject; var Value: string);
    procedure QRLabel16Print(sender: TObject; var Value: string);
    procedure QRDBText4Print(sender: TObject; var Value: string);
  private
    bFechaCobro: Boolean;

  public
    bEuros: Boolean;
    procedure SetFechaCobro( const AFechaCobro:Boolean );
  end;

  procedure Listado( const AComponent: TComponent; const AEmpresa, AFechaCobroIni, AFechaCobroFin: string; const AFechaCobro, AEuros:Boolean );
  function EnviarListado( const AComponent: TComponent; const AEmpresa, ACliente,AFechaCobroIni, AFechaCobroFin: string;
                          const AFechaCobro:Boolean; const AAsunto, ACuerpo: String; var VCancelar: boolean  ): Boolean;

implementation

{$R *.DFM}



uses DPreview, CReportes, CMLFacturasPendientes, UDMAuxDB, Variants,
     DConfigMail, UDFactura;

procedure Listado( const AComponent: TComponent; const AEmpresa, AFechaCobroIni, AFechaCobroFin: string; const AFechaCobro, AEuros:Boolean );
var
  DQLFacturasPendientesCarrefour: TQLFacturasPendientesCarrefour;
begin
  DQLFacturasPendientesCarrefour:= TQLFacturasPendientesCarrefour.Create( AComponent );
  try
    DQLFacturasPendientesCarrefour.qrlblEmpresa.Caption:= desEmpresaNif( AEmpresa );
    DQLFacturasPendientesCarrefour.bEuros:=AEuros;
    DQLFacturasPendientesCarrefour.SetFechaCobro( AFechaCobro );
    //PonLogoGrupoBonnysa(DQLFacturasPendientesCarrefour, AEmpresa);
    (*BAG*)
    if ( AFechaCobroIni <> '' ) and ( AFechaCobroFin <> '' ) then
      DQLFacturasPendientesCarrefour.lblFechaCobro.Caption:= 'Cobro desde ' + AFechaCobroIni + ' hasta ' + AFechaCobroFin
    else
    if AFechaCobroIni <> ''  then
      DQLFacturasPendientesCarrefour.lblFechaCobro.Caption:= 'Cobro desde ' + AFechaCobroIni
    else
    if  AFechaCobroFin <> '' then
      DQLFacturasPendientesCarrefour.lblFechaCobro.Caption:= 'Cobro hasta ' + AFechaCobroFin
    else
      DQLFacturasPendientesCarrefour.lblFechaCobro.Caption:= '';

    if AEuros then
    begin
      DQLFacturasPendientesCarrefour.bndCabeceraGrupo.Expression := '';
      DQLFacturasPendientesCarrefour.qrgrp1.Expression := '[cliente_fac_f]';
    end
    else
    begin
      DQLFacturasPendientesCarrefour.bndCabeceraGrupo.Expression := '[moneda_f]';
      DQLFacturasPendientesCarrefour.qrgrp1.Expression := '[moneda_f]+[cliente_fac_f]';
    end;

    Preview( DQLFacturasPendientesCarrefour );
  except
    FreeAndNil(DQLFacturasPendientesCarrefour);
  end;
end;

function EnviarListado( const AComponent: TComponent; const AEmpresa, ACliente,AFechaCobroIni, AFechaCobroFin: string;
                        const AFechaCobro:Boolean; const AAsunto, ACuerpo: String; var VCancelar: boolean  ): Boolean;
var
  DQLFacturasPendientesCarrefour: TQLFacturasPendientesCarrefour;
begin
  DQLFacturasPendientesCarrefour:= TQLFacturasPendientesCarrefour.Create( AComponent );
  try
    DQLFacturasPendientesCarrefour.qrlblEmpresa.Caption:= desEmpresaNif( AEmpresa );
    DQLFacturasPendientesCarrefour.SetFechaCobro( AFechaCobro );
    //PonLogoGrupoBonnysa(DQLFacturasPendientesCarrefour, AEmpresa);
    (*BAG*)
    if ( AFechaCobroIni <> '' ) and ( AFechaCobroFin <> '' ) then
      DQLFacturasPendientesCarrefour.lblFechaCobro.Caption:= 'Cobro desde ' + AFechaCobroIni + ' hasta ' + AFechaCobroFin
    else
    if AFechaCobroIni <> ''  then
      DQLFacturasPendientesCarrefour.lblFechaCobro.Caption:= 'Cobro desde ' + AFechaCobroIni
    else
    if  AFechaCobroFin <> '' then
      DQLFacturasPendientesCarrefour.lblFechaCobro.Caption:= 'Cobro hasta ' + AFechaCobroFin
    else
      DQLFacturasPendientesCarrefour.lblFechaCobro.Caption:= '';
    DQLFacturasPendientesCarrefour.ReportTitle:='listfac';
    result:= EnviarInformeACliente( DQLFacturasPendientesCarrefour, AEmpresa, ACliente, AAsunto, ACuerpo, VCancelar );

  finally
    FreeAndNil(DQLFacturasPendientesCarrefour);
  end;
end;

procedure TQLFacturasPendientesCarrefour.SetFechaCobro( const AFechaCobro:Boolean );
begin
  bFechaCobro:= AFechaCobro;
end;

procedure TQLFacturasPendientesCarrefour.QRDBText6Print(sender: TObject;
  var Value: String);
begin
  Value:= desCliente( Value );
end;

procedure TQLFacturasPendientesCarrefour.QRDBText7Print(sender: TObject;
  var Value: string);
begin
  if bEuros then
    Value:= 'EUR';
end;

procedure TQLFacturasPendientesCarrefour.QRDBText8Print(sender: TObject;
  var Value: string);
begin
  if bEuros then
    Value:= 'EUR';
end;

procedure TQLFacturasPendientesCarrefour.qrdbtxtfecha_acobrar_fPrint(sender: TObject;
  var Value: String);
begin
  if bFechaCobro then
  begin
    if DataSet.FieldByName('fecha_acobrar_f').AsString = '' then
    begin
      Value:= '';
    end
    else
    begin
      Value:= FormatDateTime( 'dd/mm/yy', DataSet.FieldByName('fecha_acobrar_f').AsDateTime );
    end;
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQLFacturasPendientesCarrefour.QRLabel5Print(sender: TObject;
  var Value: String);
begin
  if not bFechaCobro then
  begin
    Value:= '';
  end;
end;

procedure TQLFacturasPendientesCarrefour.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  if bEuros then
  begin
    qrdbtxtimporte_factura_f.DataField:= 'euros_factura_f';
    qrdbtxtpendiente_remesar_f.DataField:='euros_pendiente_f';
    QRExpr1.Expression:= 'sum([euros_factura_f])';
    QRExpr4.Expression:= 'sum([euros_factura_f])';
    qrxpr1.Expression:='sum([euros_pendiente_f])';
    QRExpr3.Expression:= 'sum([euros_pendiente_f])';
    QRExpr2.Expression:='sum([euros_pendiente_f])';
  end
  else
  begin
    qrdbtxtimporte_factura_f.DataField:= 'importe_factura_f';
    qrdbtxtpendiente_remesar_f.DataField:='importe_pendiente_f';
    QRExpr1.Expression:= 'sum([importe_factura_f])';
    QRExpr4.Expression:= 'sum([importe_factura_f])';
    qrxpr1.Expression:='sum([importe_pendiente_f])';
    QRExpr3.Expression:= 'sum([importe_pendiente_f])';
    QRExpr2.Expression:='sum([importe_pendiente_f])';
  end;

end;

procedure TQLFacturasPendientesCarrefour.QRLabel15Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL CLIENTE ' +  DataSet.FieldByName('cliente_fac_f').AsString;
end;


procedure TQLFacturasPendientesCarrefour.QRLabel16Print(sender: TObject;
  var Value: string);
begin
  Value:= 'TOTAL MONEDA ' +  DataSet.FieldByName('moneda_f').AsString;
end;

procedure TQLFacturasPendientesCarrefour.QRBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) and ( not bEuros );
end;

procedure TQLFacturasPendientesCarrefour.QRDBText2Print(sender: TObject;
  var Value: String);
begin
  Value:= FormatDateTime( 'dd/mm/yy', DataSet.FieldByName('fecha_factura_f').AsDateTime );
end;

procedure TQLFacturasPendientesCarrefour.qrdbtxtfecha_cobro_fPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('fecha_remesa_f').AsString = '30/12/1899' then
  begin
    Value:= '';
  end
  else
  begin
  Value:= FormatDateTime( 'dd/mm/yy', DataSet.FieldByName('fecha_remesa_f').AsDateTime );
  end;
end;

procedure TQLFacturasPendientesCarrefour.qrdbtxtsuministroPrint(
  sender: TObject; var Value: String);
begin
  Value:= desSuministro( DataSet.FieldByName('empresa_f').AsString,
                         DataSet.FieldByName('cliente_fac_f').AsString, Value );
end;



procedure TQLFacturasPendientesCarrefour.QRDBText3Print(sender: TObject;
  var Value: String);
begin
  Value:= NewCodigoFactura( DataSet.FieldByName('empresa_f').AsString,
                            DataSet.FieldByName('tipo_factura_f').AsString,
                            DataSet.FieldByName('tipo_impuesto_f').AsString,
                            DataSet.FieldByName('serie_f').AsString,
                            DataSet.FieldByName('fecha_factura_f').AsDateTime,
                            DataSet.FieldByName('n_factura_f').AsInteger );
end;

procedure TQLFacturasPendientesCarrefour.QRDBText4Print(sender: TObject;
  var Value: string);
begin
  Value:= Value + ' ' + desMoneda( value );
end;

procedure TQLFacturasPendientesCarrefour.QRDBText5Print(sender: TObject;
  var Value: string);
begin
  if bEuros then
    Value:= 'EUR';
end;

procedure TQLFacturasPendientesCarrefour.bndPieListadoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasPendientesCarrefour.bndResumenBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) and ( bEuros);
end;

procedure TQLFacturasPendientesCarrefour.bndCabeceraGrupoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not bEuros;
end;

procedure TQLFacturasPendientesCarrefour.bndPieGrupoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasPendientesCarrefour.qrdbtxtcliente_fac_fPrint(
  sender: TObject; var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value:= desCliente( Value );
end;

procedure TQLFacturasPendientesCarrefour.qrdbtxtcliente_fac_f1Print(
  sender: TObject; var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= '';
end;

procedure TQLFacturasPendientesCarrefour.qrgrp1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

end.
