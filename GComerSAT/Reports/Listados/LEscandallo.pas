unit LEscandallo;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQRLEscandallo = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PsQRLabel4: TQRLabel;
    QRGroup1: TQRGroup;
    PsQRExpr1: TQRExpr;
    QRGroup2: TQRGroup;
    PsQRExpr4: TQRExpr;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRExpr5: TQRExpr;
    PsQRExpr6: TQRExpr;
    PsQRExpr7: TQRExpr;
    PsQRExpr9: TQRExpr;
    PsQRSysData1: TQRSysData;
    PsQRExpr10: TQRExpr;
    PsQRExpr11: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRExpr3: TQRExpr;
    PsQRExpr12: TQRExpr;
    PsQRExpr13: TQRExpr;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRExpr14: TQRExpr;
    qrlTipo: TQRLabel;
    qrxtipo_entrada: TQRExpr;
    qrxpr1: TQRExpr;
    qrlbl1: TQRLabel;
    procedure PsQRExpr9Print(sender: TObject; var Value: string);
  private

  public

  end;

var
  QRLEscandallo: TQRLEscandallo;

implementation

{$R *.DFM}

uses UDMBaseDatos, UDMAuxDB;

procedure TQRLEscandallo.PsQRExpr9Print(sender: TObject;
  var Value: string);
begin
  Value := desCentro(DataSet.fieldbyname('empresa_e').AsString, Value);
end;

end.
