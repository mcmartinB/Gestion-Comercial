unit LRemesas;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls;
type
  TQRLRemesas = class(TQuickRep)
    TitleBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    BandaOtros: TQRBand;
    PsQRLabel16: TQRLabel;
    PsQRLabel15: TQRLabel;
    QRDetalle: TQRSubDetail;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    moneda_cobro_r: TQRDBText;
    PsQRLabel3: TQRLabel;
    PsQRShape1: TQRShape;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    PsQRLabel17: TQRLabel;
    PsQRLabel21: TQRLabel;
    QRDBText8: TQRDBText;
    QRLabel10: TQRLabel;
    QRDBText10: TQRDBText;
    PsQRLabel9: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel19: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRLabel5: TQRLabel;
    QRDBText9: TQRDBText;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    lblDescuadre: TQRLabel;
    lblTotalRemesa: TQRLabel;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    lblTotalRemesaEuros: TQRLabel;
    QRLabel8: TQRLabel;
    QRShape1: TQRShape;
    QRLabel9: TQRLabel;
    lblCobrado: TQRLabel;
    qlDiasCobro: TQRDBText;
    qreplanta_fr: TQRDBText;
    qrlNotas: TQRLabel;
    qregastos_euros_r: TQRDBText;
    procedure PsQRLabel16Print(sender: TObject; var Value: string);
    procedure moneda_cobro_rPrint(sender: TObject; var Value: String);
    procedure QRLabel1Print(sender: TObject; var Value: String);
    procedure lblTotalRemesaPrint(sender: TObject; var Value: String);
    procedure QRDBText3Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure lblDescuadrePrint(sender: TObject; var Value: String);
    procedure PsQRDBText3Print(sender: TObject; var Value: String);
    procedure QRDBText8Print(sender: TObject; var Value: String);
    procedure QRDBText10Print(sender: TObject; var Value: String);
    procedure lblTotalRemesaEurosPrint(sender: TObject; var Value: String);
    procedure QRExpr2Print(sender: TObject; var Value: String);
    procedure QRDBText11Print(sender: TObject; var Value: String);
    procedure qlDiasCobroPrint(sender: TObject; var Value: String);
    procedure qrlNotasPrint(sender: TObject; var Value: String);
  private
    rAcum, rDif: Real;
  public

  end;

var
  QRLRemesas: TQRLRemesas;

implementation

uses MRemesas, bNumericUtils, UDMAuxDB, DB;

{$R *.DFM}

procedure TQRLRemesas.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rAcum:= 0;
  RdIF:= 0;
end;

procedure TQRLRemesas.QRLabel1Print(sender: TObject; var Value: String);
begin
  Value:= 'REMESA = ' + moneda_cobro_r.DataSet.FieldByname('referencia_r').AsString + ' (' +
                        moneda_cobro_r.DataSet.FieldByname('fecha_r').AsString + ')';
end;

procedure TQRLRemesas.moneda_cobro_rPrint(sender: TObject; var Value: String);
begin
  Value:= 'MONEDA REMESA = ' + DesMoneda( Value );
end;

procedure TQRLRemesas.QRDBText11Print(sender: TObject; var Value: String);
begin
  Value:= DesMoneda( Value );
end;

procedure TQRLRemesas.PsQRLabel16Print(sender: TObject; var Value: string);
begin
  Value:= 'BANCO = ' + moneda_cobro_r.DataSet.FieldByname('banco_r').AsString + ' ' +
          desBanco( moneda_cobro_r.DataSet.FieldByname('banco_r').AsString );
end;

procedure TQRLRemesas.PsQRDBText3Print(sender: TObject; var Value: String);
begin
  Value:= desCliente( QRDetalle.DataSet.FieldByname('planta_fr').AsString,
                    QRDetalle.DataSet.FieldByname('cliente_fr').AsString );
end;

procedure TQRLRemesas.QRDBText3Print(sender: TObject; var Value: String);
begin
  rAcum:= rAcum + QRDetalle.DataSet.FieldByName('importe_cobrado_fr').AsFloat;
end;

procedure TQRLRemesas.lblTotalRemesaPrint(sender: TObject;
  var Value: String);
var
  rAux: Real;
begin
  rAux:= moneda_cobro_r.DataSet.FieldByName('importe_cobro_r').AsFloat +
         moneda_cobro_r.DataSet.FieldByName('otros_r').AsFloat;
  Value:= FormatFloat( '#0.00', rAux );
end;


procedure TQRLRemesas.lblDescuadrePrint(sender: TObject;
  var Value: String);
var
  rAux: Real;
begin
  rAux:= ( moneda_cobro_r.DataSet.FieldByName('importe_cobro_r').AsFloat +
           moneda_cobro_r.DataSet.FieldByName('otros_r').AsFloat ) -
           rAcum;
  Value:= FormatFloat( '#0.00', rAux );
end;

procedure TQRLRemesas.QRDBText8Print(sender: TObject; var Value: String);
var
  rAux: real;
begin
  rAux:= QRDetalle.DataSet.FieldByName('importe_factura_fr').AsFloat -
         QRDetalle.DataSet.FieldByName('importe_cobrado_fr').AsFloat;
  rDif:= rDif + rAux;
  Value:= FormatFloat( '#0.00', rAux );
end;

procedure TQRLRemesas.QRDBText10Print(sender: TObject; var Value: String);
begin
  Value:= FormatFloat( '#0.00', rDif );
end;

procedure TQRLRemesas.lblTotalRemesaEurosPrint(sender: TObject;
  var Value: String);
var
  rAux: real;
begin
  rAux:= moneda_cobro_r.DataSet.FieldByName('bruto_euros_r').AsFloat +
         moneda_cobro_r.DataSet.FieldByName('otros_euros_r').AsFloat;
  Value:= FormatFloat( '#0.00', rAux );
end;

procedure TQRLRemesas.QRExpr2Print(sender: TObject; var Value: String);
begin
  lblCobrado.Caption:= Value;
end;

procedure TQRLRemesas.qlDiasCobroPrint(sender: TObject; var Value: String);
begin
  if Value = '0' then
    Value:= ''
  else
  begin
    if qlDiasCobro.DataSet.FieldByName('cobrado').AsFloat <> 0 then
      Value:= 'Dias Cobro ' + FormatFloat('#,##0.00', qlDiasCobro.DataSet.FieldByName('dias_cobro').AsFloat /
                             qlDiasCobro.DataSet.FieldByName('cobrado').AsFloat )
    else
      Value:= '';
  end;
end;

procedure TQRLRemesas.qrlNotasPrint(sender: TObject; var Value: String);
begin
  if trim( qregastos_euros_r.DataSet.FieldByName('notas_r').AsString ) = '' then
    Value:= '';
end;

end.
