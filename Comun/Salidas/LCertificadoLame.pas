unit LCertificadoLame;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, UDLCertificadoLame,
  SOAPHTTPTrans;

type
  TQLCertificadoLame = class(TQuickRep)
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    TitleBand1: TQRBand;                                                
    PageHeaderBand1: TQRBand;
    QRSysData2: TQRSysData;
    QRBand1: TQRBand;
    QRShape2: TQRShape;
    QRLabel2: TQRLabel;
    Albaran: TQRDBText;
    QRLabel3: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel4: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel5: TQRLabel;
    QRDBText4: TQRDBText;
    QRLabel8: TQRLabel;
    QRDBText1: TQRDBText;
    QRMemo1: TQRMemo;
    QRBand2: TQRBand;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    QRLabel9: TQRLabel;
    PsQRLabel1: TQRLabel;
    QRLabel1: TQRLabel;
    QRDBText7: TQRDBText;
    PsQRShape16: TQRShape;
    QRDBText9: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRDBText8: TQRDBText;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel12: TQRLabel;
    QRDBText10: TQRDBText;
    QRLabel13: TQRLabel;
  private
    dmDatos: TDLCertificadoLame;

  public
    sEmpresa: String;
  end;

  procedure Previsualizar( const AOwner: TComponent; const ADatos: TDLCertificadoLame);

implementation

uses UDMAuxDB, UDMConfig, DPreview;

{$R *.DFM}

procedure Previsualizar( const AOwner: TComponent; const ADatos: TDLCertificadoLame);
var
  QLCertificadoLame: TQLCertificadoLame;                                                          
begin
  QLCertificadoLame:= TQLCertificadoLame.Create( AOwner );
  try
//    QLCertificadoLame.sFirma:= AFirma;
    QLCertificadoLame.dmDatos:= ADatos;
//    QLCertificadoLame.CargaProductos;
      Previsualiza( QLCertificadoLame );
  finally
    FreeAndNil( QLCertificadoLame );
  end;
end;                                                                       

end.
