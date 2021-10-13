unit ListadoSalidasPaletsReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQRListadoSalidasPaletsReport = class(TQuickRep)
    QRGroup1: TQRGroup;
    QRGroup2: TQRGroup;
    QRBand1: TQRBand;
    PsQRExpr3: TQRExpr;
    PsQRExpr4: TQRExpr;
    PsQRExpr1: TQRExpr;
    PsQRExpr5: TQRExpr;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    PsQRExpr6: TQRExpr;
    PsQRExpr7: TQRExpr;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    QRBand4: TQRBand;
    PsQRLabel3: TQRLabel;
    PsQRExpr8: TQRExpr;
    PsQRExpr9: TQRExpr;
    PsQRExpr10: TQRExpr;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    TitleBand1: TQRBand;
    LCentro: TQRLabel;
    LProducto: TQRLabel;
    LPeriodo: TQRLabel;
    PsQRLabel25: TQRLabel;
    QRBand6: TQRBand;
    PsQRLabel12: TQRLabel;
    PsQRLabel14: TQRLabel;
    PsQRLabel15: TQRLabel;
    qbndCabResumen: TQRChildBand;
    qbndDetResumen: TQRChildBand;
    qmmoCodigo: TQRMemo;
    qmmoDescripcion: TQRMemo;
    qmmoPalets: TQRMemo;
    QRLabel1: TQRLabel;
    qrsRectangle2: TQRShape;
    qrsRectangle1: TQRShape;
    PsQRSysData3: TQRSysData;
    PageFooterBand1: TQRBand;
    PsQRSysData2: TQRSysData;
    qrlblTransporte: TQRLabel;
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRLabel4Print(sender: TObject; var Value: String);
    procedure PsQRLabel5Print(sender: TObject; var Value: String);
    procedure PsQRLabel6Print(sender: TObject; var Value: String);
    procedure PsQRLabel12Print(sender: TObject; var Value: String);
    procedure PsQRExpr1Print(sender: TObject; var Value: String);
  private

  public
    bDesglosar: Boolean; 
    procedure PutResumen( const ANPalets: integer; const ACodigo, ADescripcion, APalets: TStringList );
  end;


implementation

{$R *.DFM}

uses UDMBaseDatos, UDMAuxDB;


procedure TQRListadoSalidasPaletsReport.PutResumen( const ANPalets: integer; const ACodigo, ADescripcion, APalets: TStringList );
begin
  qmmoCodigo.Lines.Clear;
  qmmoCodigo.Lines.AddStrings( ACodigo );
  qmmoDescripcion.Lines.Clear;
  qmmoDescripcion.Lines.AddStrings( ADescripcion );
  qmmoPalets.Lines.Clear;
  qmmoPalets.Lines.AddStrings( APalets );

  qmmoDescripcion.Height:= 17 + ( ( ANPalets - 1 ) * 16 );
  qmmoPalets.Height:= qmmoDescripcion.Height;
  qmmoCodigo.Height:= qmmoDescripcion.Height;
  qbndDetResumen.Height:= qmmoDescripcion.Height;
  qrsRectangle1.Height:= qmmoDescripcion.Height;
end;

procedure TQRListadoSalidasPaletsReport.QRGroup2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= ( DataSet.FieldByName('destino').Value <>
              DataSet.FieldByName('suministro').Value ) and
              ( DataSet.FieldByName('Tipo').Value = 'A' );
end;

procedure TQRListadoSalidasPaletsReport.QRBand3BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= ( DataSet.FieldByName('destino').Value <>
              DataSet.FieldByName('suministro').Value ) and
              ( DataSet.FieldByName('Tipo').Value = 'A' );
  if not PrintBand then
    PsQRExpr6.Reset;
end;

procedure TQRListadoSalidasPaletsReport.PsQRLabel4Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('tipo').AsString = 'A' then
  begin
    Value:= desCliente( DataSet.FieldByName('destino').AsString );
  end
  else
  begin
    Value:= desCentro( DataSet.FieldByName('empresa').AsString,
                      DataSet.FieldByName('destino').AsString );
  end;
end;

procedure TQRListadoSalidasPaletsReport.PsQRLabel5Print(sender: TObject;
  var Value: String);
begin
  Value:= desSuministro( DataSet.FieldByName('empresa').AsString,
                      DataSet.FieldByName('destino').Value,
                      DataSet.FieldByName('suministro').Value );
end;

procedure TQRListadoSalidasPaletsReport.PsQRLabel6Print(sender: TObject;
  var Value: String);
begin
  Value:= desTipoPalet( DataSet.FieldByName('palet').AsString );
end;

procedure TQRListadoSalidasPaletsReport.PsQRLabel12Print(sender: TObject;
  var Value: String);
begin
  if not bDesglosar then
    Value:= '';
end;

procedure TQRListadoSalidasPaletsReport.PsQRExpr1Print(sender: TObject;
  var Value: String);
begin
  if not bDesglosar then
    Value:= '';
end;

end.
