unit ExtractoCobroQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQLExtractoCobro = class(TQuickRep)
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRDBText4: TQRDBText;
    DBCobros: TQRDBText;
    PsQRDBText7: TQRDBText;
    PsQRSysData1: TQRSysData;
    lblTitulo: TQRLabel;
    PsQRLabel12: TQRLabel;
    CabCliente: TQRGroup;
    PieCliente: TQRBand;
    PsQRLabel14: TQRLabel;
    PsQRLabel15: TQRLabel;
    LPVencimiento: TQRLabel;
    LPRemesadas: TQRLabel;
    LPendientes: TQRLabel;
    QRGroup1: TQRGroup;
    PsQRDBText11: TQRDBText;
    lCliente_: TQRLabel;
    PiePais: TQRBand;
    LPVencimientoPais: TQRLabel;
    LPRemesadasPais: TQRLabel;
    LPendientesPais: TQRLabel;
    PsQRDBText12: TQRDBText;
    lPaisTotal: TQRLabel;
    PsQRDBText13: TQRDBText;
    PsQRLabel31: TQRLabel;
    ChildBand1: TQRChildBand;
    PsQRDBText10: TQRDBText;
    lPais: TQRLabel;
    lSigue: TQRLabel;
    ChildBand2: TQRChildBand;
    LPVencimientoTotal: TQRLabel;
    LPRemesadasTotal: TQRLabel;
    LPendientesTotal: TQRLabel;
    LImporte: TQRLabel;
    LImportePais: TQRLabel;
    LImporteTotal: TQRLabel;
    PageFooterBand1: TQRBand;
    PsQRSysData2: TQRSysData;
    lblPeriodo: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRExpr1: TQRExpr;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    prevision_cobro_f: TQRDBText;
    QRLabel10: TQRLabel;
    lblFechaCobro: TQRLabel;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    qrl6: TQRLabel;
    qrl7: TQRLabel;
    qrefecha_afp_f: TQRDBText;
    qrl8: TQRLabel;
    expcliente_fac_f: TQRDBText;
    expnombre_c: TQRDBText;
    qrdbtxtcliente_fac_f: TQRDBText;
    des_banco: TQRDBText;
    dias_pago: TQRDBText;
    qrdbtxtforma_pago: TQRDBText;
    qrlbl1: TQRLabel;
    exppais_c: TQRDBText;
    expdes_pais: TQRDBText;
    expcod_banco: TQRDBText;
    expdes_banco: TQRDBText;
    expdias_pago: TQRDBText;
    expforma_pago: TQRDBText;
    lexppais_c: TQRLabel;
    lexpdes_pais: TQRLabel;
    lexpcliente_fac_f: TQRLabel;
    lexpnombre_c: TQRLabel;
    lexpcod_banco: TQRLabel;
    lexpdes_banco: TQRLabel;
    lexpforma_pago: TQRLabel;
    lexpdias_pago: TQRLabel;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure CabClienteBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLEstadoCobrosBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure lClientePrint(sender: TObject; var Value: string);
    procedure PsQRDBText10Print(sender: TObject; var Value: string);
    procedure PieClienteBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRDBText11Print(sender: TObject; var Value: string);
    procedure PsQRLabel31Print(sender: TObject; var Value: string);
    procedure PiePaisBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure lPaisTotalPrint(sender: TObject; var Value: string);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRDBText3Print(sender: TObject; var Value: String);
    procedure DBCobrosPrint(sender: TObject; var Value: String);
    procedure QRExpr1Print(sender: TObject; var Value: String);
    procedure PsQRDBText4Print(sender: TObject; var Value: String);
    procedure PageFooterBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure lSiguePrint(sender: TObject; var Value: String);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PieClienteAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure PiePaisAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure expdes_paisPrint(sender: TObject; var Value: String);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    bFlag: boolean;
    rImporteTotal, rImporteCobrado: Real;
    totalesCli, pendientesCli, pvencimientoCli, premesarCli: real;
    totalesPais, pendientesPais, pvencimientoPais, premesarPais: real;
    totalesTotal, pendientesTotal, pvencimientoTotal, premesarTotal: real;
    Clave: string;

    cliente, clienteAux, nomCliente: string;
    contaClientes: integer;

    pais, paisAux, nomPais: string;
    contaPaises: integer;

  public
    bPasarAEuros: boolean;

  end;

var
  QLExtractoCobro: TQLExtractoCobro;

implementation

uses ExtractoCobroFL, UDMAuxDB, Variants, UDMCambioMoneda, bMath;

{$R *.DFM}

//******************************  REPORT  **************************************

procedure TQLExtractoCobro.QRLEstadoCobrosBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
     //inicializa variables
  totalesTotal := 0;
  pendientesTotal := 0;
  pvencimientoTotal := 0;
  premesarTotal := 0;

  ColumnHeaderBand1.Frame.DrawTop := False;

  cliente := '###';
  contaClientes := 0;
  pais := '##';
  contaPaises := 0;
  bFlag:= False;


  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    exppais_c.Enabled:= False;
    expdes_pais.Enabled:= False;
    expcliente_fac_f.Enabled:= False;
    expnombre_c.Enabled:= False;

    expcod_banco.Enabled:= False;
    expdes_banco.Enabled:= False;
    expforma_pago.Enabled:= False;
    expdias_pago.Enabled:= False;

    lexppais_c.Enabled:= False;
    lexpdes_pais.Enabled:= False;
    lexpcliente_fac_f.Enabled:= False;
    lexpnombre_c.Enabled:= False;

    lexpcod_banco.Enabled:= False;
    lexpdes_banco.Enabled:= False;
    lexpforma_pago.Enabled:= False;
    lexpdias_pago.Enabled:= False;
  end
  else
  begin
    exppais_c.Enabled:= True;
    expdes_pais.Enabled:= True;
    expcliente_fac_f.Enabled:= True;
    expnombre_c.Enabled:= True;

    expcod_banco.Enabled:= True;
    expdes_banco.Enabled:= True;
    expforma_pago.Enabled:= True;
    expdias_pago.Enabled:= True;

    exppais_c.AutoSize:= True;
    expdes_pais.AutoSize:= True;
    expcliente_fac_f.AutoSize:= True;
    expnombre_c.AutoSize:= True;

    expcod_banco.AutoSize:= True;
    expdes_banco.AutoSize:= True;
    expforma_pago.AutoSize:= True;
    expdias_pago.AutoSize:= True;

    lexppais_c.Enabled:= True;
    lexpdes_pais.Enabled:= True;
    lexpcliente_fac_f.Enabled:= True;
    lexpnombre_c.Enabled:= True;

    lexpcod_banco.Enabled:= True;
    lexpdes_banco.Enabled:= True;
    lexpforma_pago.Enabled:= True;
    lexpdias_pago.Enabled:= True;

    lexppais_c.AutoSize:= True;
    lexpdes_pais.AutoSize:= True;
    lexpcliente_fac_f.AutoSize:= True;
    lexpnombre_c.AutoSize:= True;

    lexpcod_banco.AutoSize:= True;
    lexpdes_banco.AutoSize:= True;
    lexpforma_pago.AutoSize:= True;
    lexpdias_pago.AutoSize:= True;
  end;
end;

procedure TQLExtractoCobro.CabClienteBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //TFLEstadoCobro(Owner).QEstadoCobros
  lSigue.Enabled := Clave = DataSet.FieldByName('cliente_fac_f').AsString;
  Clave := DataSet.FieldByName('cliente_fac_f').AsString;
end;

procedure TQLExtractoCobro.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
  //PARA IMPRIMIR LOS TOTALES POR PAIS SI EL PAIS TIENE MAS DE UN CLIENTE
  if pais <> paisAux then
  begin
    pais := paisAux;
    contaPaises := 1;

    totalesPais := 0;
    pendientesPais := 0;
    pvencimientoPais := 0;
    premesarPais := 0;
  end
  else
  begin
    Inc(contaPaises);
  end;
end;

//************************ BANDA DETALLE (ACUMULAR)  ***************************

procedure TQLExtractoCobro.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  rAux: Real;
begin
  if bPasarAEuros and ( DataSet.FieldByName('moneda_f').AsString <> 'EUR' ) then
  begin
    if DataSet.FieldByName('fecha_cobro_f').AsString <> '' then
    begin
      if ChangeExist( DataSet.FieldByName('moneda_f').AsString,
                   DataSet.FieldByName('fecha_cobro_f').AsString ) then
      begin
        rAux:= ToEuro( DataSet.FieldByName('moneda_f').AsString,
                   DataSet.FieldByName('fecha_cobro_f').AsString);
      end
      else
      begin
        rAux:= ToEuro( DataSet.FieldByName('moneda_f').AsString,
                   DataSet.FieldByName('fecha_factura_f').AsString);
      end;
    end
    else
    begin
      rAux:= ToEuro( DataSet.FieldByName('moneda_f').AsString,
                   DataSet.FieldByName('fecha_factura_f').AsString);
    end;
    rImporteTotal:= bRoundTo( DataSet.FieldByName('importe_total_f').AsFloat * rAux, -2 );
    rImporteCobrado:= bRoundTo( DataSet.FieldByName('importe_cobrado_f').AsFloat * rAux, -2 );
    bFlag:= true;
  end
  else
  begin
    rImporteTotal:= DataSet.FieldByName('importe_total_f').AsFloat;
    rImporteCobrado:= DataSet.FieldByName('importe_cobrado_f').AsFloat;
  end;

  //PARA IMPRIMIR LOS TOTALES POR CLIENTE SI EL CLIENTE TIENE MAS DE UNA LINEA
  if cliente <> clienteAux then
  begin
    Cliente := clienteAux;
    contaClientes := 1;

    totalesCli := 0;
    pendientesCli := 0;
    pvencimientoCli := 0;
    premesarCli := 0;
  end
  else
  begin
    Inc(contaClientes);
  end;
     //Si el importe es igual a cero se acumulan en pendientes
     //si hay algun valor se acumula en cobradas;
  rAux:= rImporteTotal;
  totalesCli := totalesCli + rAux;
  totalesPais := totalesPais + rAux;
  totalesTotal := totalesTotal + rAux;

  //Hay cantidades por cobrar
  if (DataSet.FieldByName('fecha_cobro_f').Value <> NULL) and
     (DataSet.FieldByName('fecha_cobro_f').AsDateTime > Date) then
  begin
    rAux:= rImporteCobrado;
    pvencimientoCli := pvencimientoCli + rAux;
    pvencimientoPais := pvencimientoPais + rAux;
    pvencimientoTotal := pvencimientoTotal + rAux;

    rAux:= ( rImporteTotal - rImporteCobrado );
    premesarCli := premesarCli + rAux;
    premesarPais := premesarPais + rAux;
    premesarTotal := premesarTotal + rAux;

    rAux:= rImporteTotal;
    pendientesCli := pendientesCli + rAux;
    pendientesPais := pendientesPais + rAux;
    pendientesTotal := pendientesTotal + rAux;
  end
  else
  if DataSet.FieldByName('fecha_cobro_f').Value = NULL then
  begin
    rAux:= rImporteTotal;
    premesarCli := premesarCli + rAux;
    premesarPais := premesarPais + rAux;
    premesarTotal := premesarTotal + rAux;

    pendientesCli := pendientesCli + rAux;
    pendientesPais := pendientesPais + rAux;
    pendientesTotal := pendientesTotal + rAux;
  end
  else
  begin
    rAux:= ( rImporteTotal - rImporteCobrado );
    if rAux <> 0 then
    begin
      pendientesCli := pendientesCli + rAux;
      pendientesPais := pendientesPais + rAux;
      pendientesTotal := pendientesTotal + rAux;
    end;
  end;
end;

//***************************  BANDA SUMARIO  **********************************

procedure TQLExtractoCobro.lClientePrint(sender: TObject;
  var Value: string);
begin
  Value := DataSet.FieldByName('nombre_c').AsString;
  nomCliente := Value;
end;

procedure TQLExtractoCobro.PsQRDBText10Print(sender: TObject;
  var Value: string);
begin
  lPais.Caption := desPais(Value);
  nomPais := lPais.Caption;
  paisAux := Value;
end;

procedure TQLExtractoCobro.PieClienteBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
  LImporte.Caption := FormatFloat('#,##0.00', totalesCli);
  LPVencimiento.Caption := FormatFloat('#,##0.00', pvencimientoCli);
  LPRemesadas.Caption := FormatFloat('#,##0.00', premesarCli);
  LPendientes.Caption := FormatFloat('#,##0.00', pendientesCli);
end;

procedure TQLExtractoCobro.PsQRDBText11Print(sender: TObject;
  var Value: string);
begin
  clienteAux := Value;
end;

procedure TQLExtractoCobro.PsQRLabel31Print(sender: TObject;
  var Value: string);
begin
  Value := 'TOTALES DE ' + nomCliente;
end;

procedure TQLExtractoCobro.PiePaisBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= ( totalesPais <> totalesCli ) and ( not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) );
  LImportePais.Caption := FormatFloat('#,##0.00', totalesPais);
  LPVencimientoPais.Caption := FormatFloat('#,##0.00', pvencimientoPais);
  LPRemesadasPais.Caption := FormatFloat('#,##0.00', premesarPais);
  LPendientesPais.Caption := FormatFloat('#,##0.00', pendientesPais);
end;

procedure TQLExtractoCobro.lPaisTotalPrint(sender: TObject;
  var Value: string);
begin
  Value := 'TOTALES DE ' + nomPais;
end;

procedure TQLExtractoCobro.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bPasarAEuros and not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );;
  if PrintBand then
  begin
    LImporteTotal.Caption := FormatFloat('#,##0.00', totalesTotal);
    LPVencimientoTotal.Caption := FormatFloat('#,##0.00', pvencimientoTotal);
    LPRemesadasTotal.Caption := FormatFloat('#,##0.00', premesarTotal);
    LPendientesTotal.Caption := FormatFloat('#,##0.00', pendientesTotal);
  end;
end;

procedure TQLExtractoCobro.PageFooterBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bPasarAEuros and  not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );;
end;

procedure TQLExtractoCobro.PsQRDBText3Print(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat( '#,##0.00', rImporteTotal );
end;

procedure TQLExtractoCobro.DBCobrosPrint(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat( '#,##0.00', rImporteCobrado );
end;

procedure TQLExtractoCobro.QRExpr1Print(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat( '#,##0.00', rImporteTotal - rImporteCobrado );
end;

procedure TQLExtractoCobro.PsQRDBText4Print(sender: TObject;
  var Value: String);
begin
  if bPasarAEuros and ( Value <> 'EUR' ) then
    Value:= 'EUR*';
end;

procedure TQLExtractoCobro.lSiguePrint(sender: TObject; var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= '';
end;

procedure TQLExtractoCobro.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLExtractoCobro.expdes_paisPrint(sender: TObject;
  var Value: String);
begin
  Value:= desPais(Value);
end;

procedure TQLExtractoCobro.PieClienteAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  totalesCli := 0;
  pendientesCli := 0;
  pvencimientoCli := 0;
  premesarCli := 0;
end;

procedure TQLExtractoCobro.PiePaisAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  totalesPais := 0;
  pendientesPais := 0;
  pvencimientoPais := 0;
  premesarPais := 0;
end;

procedure TQLExtractoCobro.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

end.
