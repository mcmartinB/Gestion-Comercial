unit CQREntradaTransitos;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQREntradaTransitos = class(TQuickRep)
    CabPagina: TQRBand;
    lblRango: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    lblProducto: TQRLabel;
    lblCentro: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel19: TQRLabel;
    qrbndDetailBand1: TQRBand;
    qrdbtxtfecha_tc: TQRDBText;
    qrdbtxtreferencia_tc: TQRDBText;
    qrdbtxtfecha_entrada_dda_dac: TQRDBText;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    qrdbtxtbuque_tc: TQRDBText;
    qrdbtxtfecha_entrada_dda_dac1: TQRDBText;
    qrdbtxtpuerto_tc: TQRDBText;
    qrdbtxtproducto_tl: TQRDBText;
    qrdbtxttipo_palet_tl: TQRDBText;
    qrdbtxtenvase_tl: TQRDBText;
    qrdbtxtcajas_tl: TQRDBText;
    qrdbtxtkilos_tl: TQRDBText;
    qrdbtxtpalets_tl: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel13: TQRLabel;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrdbtxttransporte_tc: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    procedure qrdbtxttransporte_tcPrint(sender: TObject;
      var Value: String);
    procedure qrdbtxtpuerto_tcPrint(sender: TObject; var Value: String);
    procedure QRDBText5Print(sender: TObject; var Value: String);
    procedure QRDBText6Print(sender: TObject; var Value: String);
    procedure qrdbtxtfecha_entrada_dda_dacPrint(sender: TObject;
      var Value: String);
  private

  public
    sEmpresa: string;
  end;

implementation

{$R *.DFM}

uses
  CFLEntradaTransitos, UDMAuxDB;


procedure TQREntradaTransitos.qrdbtxttransporte_tcPrint(sender: TObject;
  var Value: String);
begin
  Value:= desTransporte( sEmpresa, Value );
end;

procedure TQREntradaTransitos.qrdbtxtpuerto_tcPrint(sender: TObject;
  var Value: String);
begin
  Value:= desAduana( Value );
end;

procedure TQREntradaTransitos.QRDBText5Print(sender: TObject;
  var Value: String);
begin
  Value:= desTipoPalet( Value );
end;

procedure TQREntradaTransitos.QRDBText6Print(sender: TObject;
  var Value: String);
begin
  Value:= desEnvase( sEmpresa, Value );
end;

procedure TQREntradaTransitos.qrdbtxtfecha_entrada_dda_dacPrint(
  sender: TObject; var Value: String);
begin
  if Value <> '' then
    Value:= FormatDateTime( 'dd/mm/yy', DataSet.FieldByName('fecha_entrada_dda_dac').AsDateTime );
end;

end.
