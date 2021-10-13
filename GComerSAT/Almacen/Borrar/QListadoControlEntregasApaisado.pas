unit QListadoControlEntregasApaisado;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQRListadoControlEntregasApaisado = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    termografo: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText11: TQRDBText;
    lblProducto: TQRLabel;
    PsQRLabel1: TQRLabel;
    lblFechas: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblCentro: TQRLabel;
    QRSysData1: TQRSysData;
    ChildBand1: TQRChildBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    SummaryBand1: TQRBand;
    QRLabel8: TQRLabel;
    QRExpr1: TQRExpr;
    lblDatosVar: TQRLabel;
    QRDBText9: TQRDBText;
    QRLabel9: TQRLabel;
    QRExpr2: TQRExpr;
    QRLabel10: TQRLabel;
    centroLlegada: TQRDBText;
    puerto: TQRDBText;
    nomPuerto: TQRDBText;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    matricula: TQRDBText;
    QRLabel13: TQRLabel;
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure QRDBText10Print(sender: TObject; var Value: String);
    procedure nomPuertoPrint(sender: TObject; var Value: String);
  private

  public

  end;

implementation

{$R *.DFM}

uses DMListadoControlEntregas, UDMAuxDB;

procedure TQRListadoControlEntregasApaisado.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= FormatDateTime( 'dd/mm/yy', DataSet.FieldByName('fechaCarga').AsDateTime );
end;

procedure TQRListadoControlEntregasApaisado.QRDBText10Print(sender: TObject;
  var Value: String);
begin
  Value:= FormatDateTime( 'dd/mm/yy', DataSet.FieldByName('fechaLlegada').AsDateTime );
end;

procedure TQRListadoControlEntregasApaisado.nomPuertoPrint(sender: TObject;
  var Value: String);
begin
  Value:= desAduana( Value );
end;

end.
