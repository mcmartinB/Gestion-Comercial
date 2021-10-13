unit LSalidasEnvases2;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQRLSalidasEnvases2 = class(TQuickRep)
    DetailBand1: TQRBand;
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    PsQRLabel3: TQRLabel;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRDBText4: TQRDBText;
    SummaryBand1: TQRBand;
    PsQRLabel5: TQRLabel;
    PsQRExpr1: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRLabel4: TQRLabel;
    PsQRSysData1: TQRSysData;
    qrlCentroSalida: TQRLabel;
    LCliente: TQRLabel;
    LPeriodo: TQRLabel;
    PsQRShape1: TQRShape;
    PsQRShape2: TQRShape;
    lblCliente: TQRLabel;
    QRGroup1: TQRGroup;
    PsQRDBText5: TQRDBText;
    PsQRDBText6: TQRDBText;
    QRBand1: TQRBand;
    PsQRExpr3: TQRExpr;
    PsQRExpr4: TQRExpr;
    PsQRDBText8: TQRDBText;
    QRGroup2: TQRGroup;
    PsQRDBText7: TQRDBText;
    QRBand2: TQRBand;
    PsQRDBText9: TQRDBText;
    PsQRExpr5: TQRExpr;
    PsQRExpr6: TQRExpr;
    PsQRDBText10: TQRDBText;
    PsQRExpr7: TQRExpr;
    PsQRDBText11: TQRDBText;
    PsQRExpr8: TQRExpr;
    PsQRExpr9: TQRExpr;
    PsQRShape3: TQRShape;
    ChildBand1: TQRChildBand;
    QRLabel1: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    lblPalet: TQRLabel;
    qrlCentroOrigen: TQRLabel;
    procedure PsQRDBText2Print(sender: TObject; var Value: string);
    procedure PsQRDBText8Print(sender: TObject; var Value: string);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRDBText10Print(sender: TObject; var Value: string);
    procedure PsQRDBText9Print(sender: TObject; var Value: string);
    procedure PsQRLabel1Print(sender: TObject; var Value: string);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure PsQRDBText6Print(sender: TObject; var Value: String);
  private

  public
    empresa: string;
  end;

var
  QRLSalidasEnvases2: TQRLSalidasEnvases2;

implementation

uses UDMBaseDatos, UDMAuxDB;

{$R *.DFM}

procedure TQRLSalidasEnvases2.PsQRDBText6Print(sender: TObject;
  var Value: String);
begin
  Value := desProducto(empresa, value);
end;

procedure TQRLSalidasEnvases2.PsQRDBText10Print(sender: TObject;
  var Value: string);
begin
  value := desCliente(value);
end;

procedure TQRLSalidasEnvases2.PsQRDBText2Print(sender: TObject;
  var Value: string);
begin
  Value := desEnvase(empresa, value);
end;

procedure TQRLSalidasEnvases2.QRDBText2Print(sender: TObject;
  var Value: String);
begin
  Value:= desTipoPalet( value );
end;

procedure TQRLSalidasEnvases2.PsQRDBText8Print(sender: TObject;
  var Value: string);
begin
  Value := 'TOTAL DE ' + desProducto(empresa, DataSet.FieldByName('producto_sl').AsString);
end;

procedure TQRLSalidasEnvases2.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := DataSet.FieldByName('cliente_sl').AsString <> '';
end;

procedure TQRLSalidasEnvases2.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := DataSet.FieldByName('cliente_sl').AsString <> '';
end;

procedure TQRLSalidasEnvases2.PsQRDBText9Print(sender: TObject;
  var Value: string);
begin
  Value := 'TOTAL DE ' + desCliente( DataSet.FieldByName('cliente_sl').AsString );
end;

procedure TQRLSalidasEnvases2.PsQRLabel1Print(sender: TObject;
  var Value: string);
begin
  if DataSet.FieldByName('cliente_sl').AsString = '' then
    Value := '';
end;

end.
