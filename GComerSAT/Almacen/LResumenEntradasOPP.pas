unit LResumenEntradasOPP;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLResumenEntradasOPP = class(TQuickRep)
    QRBCabecera: TQRBand;
    QRBDetalle: TQRBand;
    QRBSumario: TQRBand;
    QRBGrupo: TQRGroup;
    QRLabel6: TQRLabel;
    QRLCosechero: TQRLabel;
    QRLKilos: TQRLabel;
    QRLCajas: TQRLabel;
    QRDBTCosechero: TQRDBText;
    QRDBTPlantacion: TQRDBText;
    QRDBTCajas: TQRDBText;
    QRDBTKilos: TQRDBText;
    QRBTitulo: TQRBand;
    QRLabel1: TQRLabel;
    QRLDesde: TQRLabel;
    QRLHasta: TQRLabel;
    psCentro: TQRLabel;
    psProducto: TQRLabel;
    QListado: TQuery;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRBPieGrupo: TQRBand;
    QRLTotalParcial: TQRLabel;
    QRShape1: TQRShape;
    QRShape5: TQRShape;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    procedure QRLTotalParcialPrint(sender: TObject; var Value: String);
  private

  public
  end;

var
  QLResumenEntradasOPP: TQLResumenEntradasOPP;

implementation

{$R *.DFM}


procedure TQLResumenEntradasOPP.QRLTotalParcialPrint(sender: TObject;
  var Value: String);
begin
  Value:= 'Total OPP ' + QListado.fieldbyname('cos').AsString + ' ...'
end;

end.
