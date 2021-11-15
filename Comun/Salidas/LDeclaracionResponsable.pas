unit LDeclaracionResponsable;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, UDLDeclaracionResponsable,
  SOAPHTTPTrans, dxGDIPlusClasses;

type
  TQLDeclaracionResponsable = class(TQuickRep)
    DetailBand1: TQRBand;
    ChildBand1: TQRChildBand;
    QRLabel1: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRDBText4: TQRDBText;
    QRLabel29: TQRLabel;
    QRShape1: TQRShape;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel33: TQRLabel;
    QRDBText6: TQRDBText;
    QRLabel36: TQRLabel;
    QRLabel38: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    QRLabel41: TQRLabel;
    QRDBText7: TQRDBText;
    QRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel8: TQRLabel;
    QRLabel11: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel12: TQRLabel;
    QRDBText5: TQRDBText;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel37: TQRLabel;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRLabel18: TQRLabel;
    QRLabel44: TQRLabel;
    QRLabel7: TQRLabel;
    shape: TQRLabel;
    QRShape4: TQRShape;
    QRShape2: TQRShape;
    QRLabel32: TQRLabel;
    QRImage2: TQRImage;
    QRShape3: TQRShape;
    QRLabel2: TQRLabel;
    QRImage1: TQRImage;
  private
    dmDatos: TDLDeclaracionResponsable;
  public
    sEmpresa: String;
  end;

  procedure Previsualizar( const AOwner: TComponent; const ADatos: TDLDeclaracionResponsable);

implementation

uses UDMAuxDB, UDMConfig, DPreview;

{$R *.DFM}

procedure Previsualizar( const AOwner: TComponent; const ADatos: TDLDeclaracionResponsable);
var
  QLDeclaracionResponsable: TQLDeclaracionResponsable;
begin
  QLDeclaracionResponsable:= TQLDeclaracionResponsable.Create( AOwner );
  try
//    QLCertificadoLame.sFirma:= AFirma;
      QLDeclaracionResponsable.dmDatos:= ADatos;
//    QLCertificadoLame.CargaProductos;
      Previsualiza( QLDeclaracionResponsable );
  finally
    FreeAndNil( QLDeclaracionResponsable );
  end;
end;


end.
