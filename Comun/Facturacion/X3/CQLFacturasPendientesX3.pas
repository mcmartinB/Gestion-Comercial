unit CQLFacturasPendientesX3;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB;

type
  TDQLFacturasPendientesX3 = class(TQuickRep)
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
    qrxpr_cobrado_f1: TQRExpr;
    QRDBText5: TQRDBText;
    QRLabel16: TQRLabel;
    qrdbtxtfecha_pendiente_f: TQRDBText;
    qrlbl4: TQRLabel;
    qrlblFechaVencimiento: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl11: TQRLabel;
    qrlbl12: TQRLabel;
    qrdbtxtcliente_fac_f1: TQRDBText;
    qrdbtxtcliente_fac_f2: TQRDBText;
    qrdbtxtempresa_f: TQRDBText;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrdbtxtpais: TQRDBText;
    qrdbtxtcliente_fac_f: TQRDBText;
    qrdbtxtcliente_fac_f3: TQRDBText;
    qrdbtxtdias_tesoreria: TQRDBText;
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
    procedure QRDBText10Print(sender: TObject; var Value: String);
    procedure qrdbtxtpaisPrint(sender: TObject; var Value: String);
    procedure qrdbtxtcliente_fac_f3Print(sender: TObject;
      var Value: String);
    procedure qrdbtxtcliente_fac_fPrint(sender: TObject;
      var Value: String);
    procedure qrdbtxtdias_tesoreriaPrint(sender: TObject;
      var Value: String);
  private
    bEuros, bPorPais: Boolean;
    sTipoDias: string;
  public
    procedure PonerDataSet( const ADataSet: TDataSet );
    procedure ImportesEnEuro;
    procedure ConfBandaCab( const AEnEuros, APorPais, ATesoreria: Boolean );
  end;

  procedure Listado( const AComponent: TComponent; const ADataSet: TDataSet;
                     const AEmpresa, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string;
                     const ATesoreria, AEnEuros, APorPais: Boolean );
  function EnviarListado( const AComponent: TComponent; const ADataSet: TDataSet; const AEmpresa, ACliente, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string;
                          const ATesoreria, AEnEuros, APorPais: Boolean; const AAsunto, ACuerpo: String; var VCancelar: boolean  ): Boolean;

implementation

{$R *.DFM}

uses DPreview, CReportes, CMLFacturasPendientes, UDMAuxDB, Variants, DConfigMail, TypInfo;


procedure Listado( const AComponent: TComponent; const ADataSet: TDataSet; const AEmpresa, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string;
                   const ATesoreria, AEnEuros, APorPais: Boolean );
var
  DQLFacturasPendientesX3: TDQLFacturasPendientesX3;
begin
  DQLFacturasPendientesX3:= TDQLFacturasPendientesX3.Create( AComponent );
  try
    DQLFacturasPendientesX3.ConfBandaCab( AEnEuros, APorPais, ATesoreria );


    DQLFacturasPendientesX3.PonerDataSet( ADataSet );
    PonLogoGrupoBonnysa(DQLFacturasPendientesX3, AEmpresa);
    (*BAG*)
    if ( AFechaCobroIni <> '' ) and ( AFechaCobroIni <> '' ) then
      DQLFacturasPendientesX3.lblFechaCobro.Caption:= 'Cobro desde ' + AFechaCobroIni + ' hasta ' + AFechaCobroFin
    else
    if AFechaCobroIni <> ''  then
      DQLFacturasPendientesX3.lblFechaCobro.Caption:= 'Cobro desde ' + AFechaCobroIni
    else
    if  AFechaCobroIni <> '' then
      DQLFacturasPendientesX3.lblFechaCobro.Caption:= 'Cobro hasta ' + AFechaCobroFin
    else
      DQLFacturasPendientesX3.lblFechaCobro.Caption:= '';

    Preview( DQLFacturasPendientesX3 );
  except
    FreeAndNil(DQLFacturasPendientesX3);
  end;
end;

function EnviarListado( const AComponent: TComponent; const ADataSet: TDataSet; 
                        const AEmpresa, ACliente, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string;
                        const ATesoreria, AEnEuros, APorPais: Boolean; const AAsunto, ACuerpo: String; var VCancelar: boolean ): Boolean;
var
  DQLFacturasPendientesX3: TDQLFacturasPendientesX3;
begin
  DQLFacturasPendientesX3:= TDQLFacturasPendientesX3.Create( AComponent );
  try
    DQLFacturasPendientesX3.ConfBandaCab( AEnEuros, APorPais, ATesoreria );
    
    DQLFacturasPendientesX3.PonerDataSet( ADataSet );
    PonLogoGrupoBonnysa(DQLFacturasPendientesX3, AEmpresa);
    (*BAG*)
    if ( AFechaCobroIni <> '' ) and ( AFechaCobroIni <> '' ) then
      DQLFacturasPendientesX3.lblFechaCobro.Caption:= 'Cobro desde ' + AFechaCobroIni + ' hasta ' + AFechaCobroFin
    else
    if AFechaCobroIni <> ''  then
      DQLFacturasPendientesX3.lblFechaCobro.Caption:= 'Cobro desde ' + AFechaCobroIni
    else
    if  AFechaCobroIni <> '' then
      DQLFacturasPendientesX3.lblFechaCobro.Caption:= 'Cobro hasta ' + AFechaCobroFin
    else
      DQLFacturasPendientesX3.lblFechaCobro.Caption:= '';
    DQLFacturasPendientesX3.ReportTitle:='listfac';
    result:= EnviarInformeACliente( DQLFacturasPendientesX3, AEmpresa, ACliente, AAsunto, ACuerpo, VCancelar );

  finally
    FreeAndNil(DQLFacturasPendientesX3);
  end;
end;

procedure TDQLFacturasPendientesX3.PonerDataSet( const ADataSet: TDataSet );
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

procedure TDQLFacturasPendientesX3.ConfBandaCab( const AEnEuros, APorPais, ATesoreria: Boolean );
begin
  bEuros:= AEnEuros;
  bPorPais:= APorPais;


  if ATesoreria then
  begin
    sTipoDias:= ' dias previstos';
    lblTitulo.Caption:= 'FACTURAS PENDIENTES DE COBRO PREVISTO';
    ReportTitle:= 'FactPendientesCobroPrevisto_' + FormatDateTime('yyyymmdd_hhMM', Now );
    qrdbtxtdias_tesoreria.DataField:= 'dias_tesoreria';
    qrlblFechaVencimiento.Caption:= 'PREVISTA';
    qrdbtxtfecha_pendiente_f.DataField:= 'fecha_prevista_f';
  end
  else
  begin
    sTipoDias:= ' dias vencimiemto';
    lblTitulo.Caption:= 'FACTURAS PENDIENTES DE COBRO VENCIMIENTO';
    ReportTitle:= 'FactPendientesCobroVencimiento_'+ FormatDateTime('yyyymmdd_hhMM', Now );
    qrdbtxtdias_tesoreria.DataField:= 'dias_vencimiento';
    qrlblFechaVencimiento.Caption:= 'VENCIMIENTO';
    qrdbtxtfecha_pendiente_f.DataField:= 'fecha_vencimiento_f';
  end;

  ImportesEnEuro;

  if ( not AEnEuros ) or APorPais then
  begin
    if ( not AEnEuros ) and APorPais then
    begin
      bndCabeceraGrupo.Expression:= '[cod_pais]+[moneda_f]';
      qrdbtxtmoneda_f.Enabled:= True;
      qrdbtxtpais.Enabled:= True;
      qrdbtxtmoneda_f.Left:= 301;
      qrdbtxtpais.Left:= 1;
    end
    else
    if APorPais then
    begin
      bndCabeceraGrupo.Expression:= '[cod_pais]';
      qrdbtxtmoneda_f.Enabled:= False;
      qrdbtxtpais.Enabled:= True;
      qrdbtxtpais.Left:= 1;
    end
    else
    begin
      bndCabeceraGrupo.Expression:= '[moneda_f]';
      qrdbtxtmoneda_f.Enabled:= True;
      qrdbtxtpais.Enabled:= False;
      qrdbtxtmoneda_f.Left:= 1;
    end;
    bndCabeceraGrupo.Height:= 24;
  end
  else
  begin
    bndCabeceraGrupo.Expression:= '';
    qrdbtxtmoneda_f.Enabled:= False;
    qrdbtxtpais.Enabled:= False;
    bndCabeceraGrupo.Height:= 0;
  end;
end;

procedure TDQLFacturasPendientesX3.QRLabel16Print(sender: TObject;
  var Value: String);
begin
  if ( not bEuros ) or bPorPais then
  begin
    if ( not bEuros ) and bPorPais then
    begin
      Value:= 'TOTAL PAIS / MONEDA ' +  DataSet.FieldByName('cod_pais').AsString + ' / ' + DataSet.FieldByName('moneda_f').AsString;
    end
    else
    if bPorPais then
    begin
      Value:= 'TOTAL PAIS ' +  DataSet.FieldByName('cod_pais').AsString;
    end
    else
    begin
      Value:= 'TOTAL MONEDA ' +  DataSet.FieldByName('moneda_f').AsString;
    end;
  end
  else
  begin
    Value:= 'TOTAL INFORME EN EUROS '
  end;
end;

procedure TDQLFacturasPendientesX3.ImportesEnEuro;
begin
  if bEuros then
  begin
    bndCabeceraGrupo.Expression:= '';
    qrdbtxtmoneda_f.Enabled:= False;

    qrdbtxtimporte_factura_f.DataField:= 'euros_factura_f';
    qrxpr_factura_f.Expression:= 'sum([euros_factura_f])';
    qrxpr_factura_f1.Expression:= 'sum([euros_factura_f])';

    qrdbtxtimporte_cobrado_f.DataField:= 'euros_cobrado_f';
    qrxpr_cobrado_f.Expression:= 'sum([euros_cobrado_f])';
    qrxpr_cobrado_f1.Expression:= 'sum([euros_cobrado_f])';

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

    qrdbtxtimporte_cobrado_f.DataField:= 'importe_cobrado_f';
    qrxpr_cobrado_f.Expression:= 'sum([importe_cobrado_f])';
    qrxpr_cobrado_f1.Expression:= 'sum([importe_cobrado_f])';

    qrdbtxtimporte_remesado_f.DataField:= 'importe_pendiente_f';
    qrxpr_remesado_f.Expression:= 'sum([importe_pendiente_f])';
    qrxpr_remesado_f1.Expression:= 'sum([importe_pendiente_f])';
  end;
end;


procedure TDQLFacturasPendientesX3.QRDBText6Print(sender: TObject;
  var Value: String);
begin
  Value:= desCliente( DataSet.FieldByName('empresa_f').AsString, Value );
end;

procedure TDQLFacturasPendientesX3.QRLabel15Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL CLIENTE ' +  DataSet.FieldByName('cliente_fac_f').AsString;
end;

procedure TDQLFacturasPendientesX3.qrdbtxtmoneda_fPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desMoneda( value );
end;

procedure TDQLFacturasPendientesX3.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TDQLFacturasPendientesX3.bndPieGrupoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TDQLFacturasPendientesX3.bndResumenBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TDQLFacturasPendientesX3.bndPieListadoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TDQLFacturasPendientesX3.qrdbtxtcliente_fac_f1Print(
  sender: TObject; var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value:= desCliente( DataSet.FieldByName('empresa_f').AsString, Value );
end;

procedure TDQLFacturasPendientesX3.qrdbtxtcliente_fac_f2Print(
  sender: TObject; var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= '';
end;

procedure TDQLFacturasPendientesX3.qrgrp1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TDQLFacturasPendientesX3.QRDBText10Print(sender: TObject;
  var Value: String);
begin
  if bEuros then
    Value:= 'EUR';
end;

procedure TDQLFacturasPendientesX3.qrdbtxtpaisPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value +  ' ' + desPais( Value );
end;

procedure TDQLFacturasPendientesX3.qrdbtxtcliente_fac_f3Print(
  sender: TObject; var Value: String);
begin
  if Value = 'EF' then
    Value:= 'EF-EFECTIVO'
  else
  if Value = 'TF' then
    Value:= 'TF-TRANSFERENCIA'
  else
  if Value = 'PG' then
    Value:= 'PG-PAGARE/CHEQUE'
  else
    Value:= Value + '-SIN ASIGNAR';
end;

procedure TDQLFacturasPendientesX3.qrdbtxtcliente_fac_fPrint(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' '  + desBanco( Value );
end;

procedure TDQLFacturasPendientesX3.qrdbtxtdias_tesoreriaPrint(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' ' + sTipoDias;
end;

end.
