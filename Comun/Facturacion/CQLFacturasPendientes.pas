unit CQLFacturasPendientes;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, WideStrings, SqlExpr;

type
  TDQLFacturasPendientes = class(TQuickRep)
    bndCabeceraListado: TQRBand;
    bndResumen: TQRBand;
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
    qrxpr_acobrar_f2: TQRExpr;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    qrdbtxtimporte_cobrado_f: TQRDBText;
    qrdbtxtimporte_remesado_f: TQRDBText;
    QRDBText10: TQRDBText;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    qrdbtxtfecha_acobrar_f: TQRDBText;
    QRLabel5: TQRLabel;
    qrxpr_remesado_f: TQRExpr;
    qrxpr_cobrado_f: TQRExpr;
    QRDBText7: TQRDBText;
    qrLabel98: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    lblFechaCobro: TQRLabel;
    qreplanta_fr: TQRDBText;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrxpr_acobrar_f: TQRExpr;
    qrdbtxteuros_acobrar_f: TQRDBText;
    qrgrp1: TQRGroup;
    QRDBText1: TQRDBText;
    QRDBText6: TQRDBText;
    qrdbtxtcliente_fac_f: TQRDBText;
    QRBand1: TQRBand;
    qrxpr_factura_f1: TQRExpr;
    QRLabel8: TQRLabel;
    qrxpr_remesado_f1: TQRExpr;
    qrxpr_cobrado_f1: TQRExpr;
    QRDBText5: TQRDBText;
    QRLabel16: TQRLabel;
    qrxpr_acobrar_f1: TQRExpr;
    qrdbtxtfecha_cobro_f: TQRDBText;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl11: TQRLabel;
    qrlbl12: TQRLabel;
    qrdbtxtcliente_fac_f1: TQRDBText;
    qrdbtxtcliente_fac_f2: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText8: TQRDBText;
    QRLabel7: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRDBText9: TQRDBText;
    SQLConnection1: TSQLConnection;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    procedure QRDBText6Print(sender: TObject; var Value: String);
    procedure qrdbtxtfecha_acobrar_fPrint(sender: TObject; var Value: String);
    procedure QRLabel15Print(sender: TObject; var Value: String);
    procedure qrdbtxtcliente_fac_fPrint(sender: TObject;
      var Value: String);
    procedure QRLabel16Print(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure qrdbtxtfecha_cobro_fPrint(sender: TObject;
      var Value: String);
    procedure QRLabel5Print(sender: TObject; var Value: String);
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
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure bndCabeceraGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText10Print(sender: TObject; var Value: String);
    procedure QRLabel17Print(sender: TObject; var Value: string);
    procedure QRLabel18Print(sender: TObject; var Value: string);
  private
    bFechaCobro: Boolean;


  public
    bEuros: Boolean;
    procedure SetFechaCobro( const AFechaCobro:Boolean );
    procedure PonerDataSet( const ADataSet: TDataSet );
  end;

  procedure Listado( const AComponent: TComponent; const ADataSet: TDataSet; const AEmpresa, AFechaCobroIni, AFechaCobroFin: string; const AFechaCobro, AEuros:Boolean );
  function EnviarListado( const AComponent: TComponent; const ADataSet: TDataSet; const AEmpresa, ACliente, AFechaCobroIni, AFechaCobroFin: string;
                          const AFechaCobro:Boolean; const AAsunto, ACuerpo: String; var VCancelar: boolean  ): Boolean;

implementation

{$R *.DFM}

uses DPreview, CReportes, CMLFacturasPendientes, UDMAuxDB, Variants, DConfigMail, TypInfo;


procedure Listado( const AComponent: TComponent; const ADataSet: TDataSet; const AEmpresa, AFechaCobroIni, AFechaCobroFin: string; const AFechaCobro, AEuros:Boolean );
var
  DQLFacturasPendientes: TDQLFacturasPendientes;
begin
  DQLFacturasPendientes:= TDQLFacturasPendientes.Create( AComponent );
  try
    DQLFacturasPendientes.PonerDataSet( ADataSet );
    DQLFacturasPendientes.bEuros:= AEuros;
    DQLFacturasPendientes.SetFechaCobro( AFechaCobro );
    PonLogoGrupoBonnysa(DQLFacturasPendientes, AEmpresa);
    (*BAG*)
    if ( AFechaCobroIni <> '' ) and ( AFechaCobroIni <> '' ) then
      DQLFacturasPendientes.lblFechaCobro.Caption:= 'Cobro desde ' + AFechaCobroIni + ' hasta ' + AFechaCobroFin
    else
    if AFechaCobroIni <> ''  then
      DQLFacturasPendientes.lblFechaCobro.Caption:= 'Cobro desde ' + AFechaCobroIni
    else
    if  AFechaCobroIni <> '' then
      DQLFacturasPendientes.lblFechaCobro.Caption:= 'Cobro hasta ' + AFechaCobroFin
    else
      DQLFacturasPendientes.lblFechaCobro.Caption:= '';

    if AEuros then
    begin
      DQLFacturasPendientes.bndCabeceraGrupo.Expression := '';
      DQLFacturasPendientes.qrgrp1.Expression := '[cliente_fac_f]';
    end
    else
    begin
      DQLFacturasPendientes.bndCabeceraGrupo.Expression := '[moneda_f]';
      DQLFacturasPendientes.qrgrp1.Expression := '[moneda_f]+[cliente_fac_f]';
    end;

    Preview( DQLFacturasPendientes );
  except
    FreeAndNil(DQLFacturasPendientes);
  end;
end;

function EnviarListado( const AComponent: TComponent; const ADataSet: TDataSet;
                        const AEmpresa, ACliente, AFechaCobroIni, AFechaCobroFin: string;
                        const AFechaCobro:Boolean; const AAsunto, ACuerpo: String; var VCancelar: boolean ): Boolean;
var
  DQLFacturasPendientes: TDQLFacturasPendientes;
begin
  DQLFacturasPendientes:= TDQLFacturasPendientes.Create( AComponent );
  try
    DQLFacturasPendientes.PonerDataSet( ADataSet );
    DQLFacturasPendientes.bEuros:= False;
    DQLFacturasPendientes.SetFechaCobro( AFechaCobro );
    PonLogoGrupoBonnysa(DQLFacturasPendientes, AEmpresa);
    (*BAG*)
    if ( AFechaCobroIni <> '' ) and ( AFechaCobroIni <> '' ) then
      DQLFacturasPendientes.lblFechaCobro.Caption:= 'Cobro desde ' + AFechaCobroIni + ' hasta ' + AFechaCobroFin
    else
    if AFechaCobroIni <> ''  then
      DQLFacturasPendientes.lblFechaCobro.Caption:= 'Cobro desde ' + AFechaCobroIni
    else
    if  AFechaCobroIni <> '' then
      DQLFacturasPendientes.lblFechaCobro.Caption:= 'Cobro hasta ' + AFechaCobroFin
    else
      DQLFacturasPendientes.lblFechaCobro.Caption:= '';
    DQLFacturasPendientes.ReportTitle:='listfac';
    result:= EnviarInformeACliente( DQLFacturasPendientes, AEmpresa, ACliente, AAsunto, ACuerpo, VCancelar );

  finally
    FreeAndNil(DQLFacturasPendientes);
  end;
end;

procedure TDQLFacturasPendientes.PonerDataSet( const ADataSet: TDataSet );
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


procedure TDQLFacturasPendientes.SetFechaCobro( const AFechaCobro:Boolean );
begin
  bFechaCobro:= AFechaCobro;
end;

procedure TDQLFacturasPendientes.QRDBText6Print(sender: TObject;
  var Value: String);
begin
  Value:= desCliente( Value );
end;

procedure TDQLFacturasPendientes.qrdbtxtfecha_acobrar_fPrint(sender: TObject;
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
      if DataSet.Fieldbyname('fecha_remesado_f').AsString <> '' then
        Value := ''
      else
        Value:= FormatDateTime( 'dd/mm/yy', DataSet.FieldByName('fecha_acobrar_f').AsDateTime );
    end;
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TDQLFacturasPendientes.QRLabel5Print(sender: TObject;
  var Value: String);
begin
  if not bFechaCobro then
  begin
    Value:= '';
  end;
end;

procedure TDQLFacturasPendientes.QRLabel15Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL CLIENTE ' +  DataSet.FieldByName('cliente_fac_f').AsString;
end;

procedure TDQLFacturasPendientes.qrdbtxtcliente_fac_fPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desMoneda( value );
end;

procedure TDQLFacturasPendientes.QRLabel16Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL MONEDA ' +  DataSet.FieldByName('moneda_f').AsString;
end;

procedure TDQLFacturasPendientes.QRLabel17Print(sender: TObject;
  var Value: string);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
  begin
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add(' select cta_cliente_c from frf_clientes ');
      SQL.Add(' where cliente_c = ' + QuotedStr(DataSet.FieldByName('cliente_fac_f').Value));
      Open;
      if not IsEmpty then
      begin
        value := Fields[0].AsString;
      end
      else
      begin
        value := '';
      end;
      Close;
    end;
  end;
end;

procedure TDQLFacturasPendientes.QRLabel18Print(sender: TObject;
  var Value: string);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value:= 'CÓDIGO X3';
end;

procedure TDQLFacturasPendientes.QRDBText2Print(sender: TObject;
  var Value: String);
begin
  Value:= FormatDateTime( 'dd/mm/yy', DataSet.FieldByName('fecha_factura_f').AsDateTime );
end;

procedure TDQLFacturasPendientes.qrdbtxtfecha_cobro_fPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('fecha_remesado_f').Value = null then
  begin
    Value:= '';
  end
  else
  if DataSet.FieldByName('fecha_remesado_f').AsString = '30/12/1899' then
  begin
    Value:= '';
  end
  else
  begin
  Value:= FormatDateTime( 'dd/mm/yy', DataSet.FieldByName('fecha_remesado_f').AsDateTime );
  end;
end;

procedure TDQLFacturasPendientes.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) and ( not bEuros );
end;

procedure TDQLFacturasPendientes.bndPieGrupoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TDQLFacturasPendientes.bndResumenBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) and ( bEuros );
end;

procedure TDQLFacturasPendientes.bndPieListadoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TDQLFacturasPendientes.qrdbtxtcliente_fac_f1Print(
  sender: TObject; var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value:= desCliente( Value );
end;

procedure TDQLFacturasPendientes.qrdbtxtcliente_fac_f2Print(
  sender: TObject; var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= '';
end;

procedure TDQLFacturasPendientes.qrgrp1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TDQLFacturasPendientes.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  if bEuros then
  begin
    qrdbtxtimporte_factura_f.DataField:= 'euros_factura_f';
    qrxpr_factura_f.Expression:=  'sum([euros_factura_f])';
    qrxpr_factura_f1.Expression:=  qrxpr_factura_f.Expression;
    qrdbtxtimporte_cobrado_f.DataField:= 'euros_cobrado_f';
    qrxpr_cobrado_f.Expression:=  'sum([euros_cobrado_f])';
    qrxpr_cobrado_f1.Expression:=  qrxpr_cobrado_f.Expression;
    qrdbtxtimporte_remesado_f.DataField:= 'euros_remesado_f';
    qrxpr_remesado_f.Expression:=  'sum([euros_remesado_f]))';
    qrxpr_remesado_f1.Expression:=  qrxpr_remesado_f.Expression;
    qrdbtxteuros_acobrar_f.DataField:= 'euros_acobrar_f';
    qrxpr_acobrar_f.Expression:=  'sum([euros_acobrar_f])';
    qrxpr_acobrar_f1.Expression:=  qrxpr_acobrar_f.Expression;
    qrxpr_acobrar_f2.Expression:=  qrxpr_acobrar_f.Expression;
  end
  else
  begin
    qrdbtxtimporte_factura_f.DataField:= 'importe_factura_f';
    qrxpr_factura_f.Expression:=  'sum([importe_factura_f])';
    qrxpr_factura_f1.Expression:=  qrxpr_factura_f.Expression;
    qrdbtxtimporte_cobrado_f.DataField:= 'importe_cobrado_f';
    qrxpr_cobrado_f.Expression:=  'sum([importe_cobrado_f])';
    qrxpr_cobrado_f1.Expression:=  qrxpr_cobrado_f.Expression;
    qrdbtxtimporte_remesado_f.DataField:= 'importe_remesado_f';
    qrxpr_remesado_f.Expression:=  'sum([importe_remesado_f]))';
    qrxpr_remesado_f1.Expression:=  qrxpr_remesado_f.Expression;
    qrdbtxteuros_acobrar_f.DataField:= 'importe_acobrar_f';
    qrxpr_acobrar_f.Expression:=  'sum([importe_acobrar_f])';
    qrxpr_acobrar_f1.Expression:=  qrxpr_acobrar_f.Expression;
    qrxpr_acobrar_f2.Expression:=  qrxpr_acobrar_f.Expression;
  end;
end;

procedure TDQLFacturasPendientes.bndCabeceraGrupoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not bEuros;
end;

procedure TDQLFacturasPendientes.QRDBText10Print(sender: TObject;
  var Value: String);
begin
  if bEuros then
    Value:= 'EUR';
end;

end.
