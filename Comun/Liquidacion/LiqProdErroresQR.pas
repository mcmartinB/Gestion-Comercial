unit LiqProdErroresQR;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables, grimgctrl;
type
  TQRLiqProdErrores = class(TQuickRep)
    qrbndBandaDetalle: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRBand1: TQRBand;
    PsQRLabel4: TQRLabel;
    PsQRSysData1: TQRSysData;
    QRLabel6: TQRLabel;
    qrlbl15: TQRLabel;
    qrgrpCentro: TQRGroup;
    qtxterror: TQRDBText;
    qrlblCentro: TQRLabel;
    qrlblperiodo: TQRLabel;
    qtxtcentro: TQRDBText;
    qtxtempresa: TQRDBText;
    qtxtproducto: TQRDBText;
    qtxtsemana: TQRDBText;
    qtxtfecha_ini: TQRDBText;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
  private

  public

  end;

  procedure Imprimir( const ADIni, ADFin: TDateTime; const AQuery: TDataSet );

implementation

uses
  LiqProdVendidoDM, UDMAuxDB, DPreview;

{$R *.DFM}

procedure Imprimir( const ADIni, ADFin: TDateTime; const AQuery: TDataSet );
var
  QRLiqProdErrores: TQRLiqProdErrores;
begin
  QRLiqProdErrores:= TQRLiqProdErrores.Create( nil );
  try
    QRLiqProdErrores.qrlblperiodo.caption:= 'del ' + FormatFloat('dd/mm/yy', ADIni ) + ' al ' + FormatFloat('dd/mm/yy', ADFin );
    QRLiqProdErrores.DataSet:= AQuery;

    QRLiqProdErrores.qtxterror.DataSet:= QRLiqProdErrores.DataSet;
    QRLiqProdErrores.qtxtempresa.DataSet:= QRLiqProdErrores.DataSet;
    QRLiqProdErrores.qtxtcentro.DataSet:= QRLiqProdErrores.DataSet;
    QRLiqProdErrores.qtxtproducto.DataSet:= QRLiqProdErrores.DataSet;
    QRLiqProdErrores.qtxtsemana.DataSet:= QRLiqProdErrores.DataSet;
    QRLiqProdErrores.qtxtfecha_ini.DataSet:= QRLiqProdErrores.DataSet;
    QRLiqProdErrores.qtxterror.DataSet:= QRLiqProdErrores.DataSet;

    Preview( QRLiqProdErrores );
  except
    FreeAndNil( QRLiqProdErrores );
  end;
end;

end.
