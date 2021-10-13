unit LiquidaIncidenciasQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLLiquidaIncidencias = class(TQuickRep)
    QRBand5: TQRBand;
    PsQRSysData3: TQRSysData;
    qrlblTitulo: TQRLabel;
    bndsdStock: TQRSubDetail;
    qrbndCabStock: TQRBand;
    qrbndPieStock: TQRBand;
    qrlbl1: TQRLabel;
    qrdbtxtempresa: TQRDBText;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrdbtxtentrega: TQRDBText;
    qrdbtxtsscc: TQRDBText;
    qrbndCabVerde: TQRBand;
    qrlbl5: TQRLabel;
    qrlbl7: TQRLabel;
    bndsdVerde: TQRSubDetail;
    qrdbtxt2: TQRDBText;
    qrbndPieVerde: TQRBand;
    qrbnd1: TQRBand;
    qrlbl6: TQRLabel;
    qrlbl8: TQRLabel;
    bndsd1: TQRSubDetail;
    qrdbtxt1: TQRDBText;
    qrbnd2: TQRBand;
    qrdbtxtentrega1: TQRDBText;
    qrdbtxtentrega2: TQRDBText;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrdbtxtentrega3: TQRDBText;
    qrlbl11: TQRLabel;
    qrdbtxtentrega4: TQRDBText;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrbnd3: TQRBand;
    bndsd2: TQRSubDetail;
    qrdbtxt3: TQRDBText;
    qrdbtxtcentro: TQRDBText;
    qrdbtxtalbaran: TQRDBText;
    qrdbtxtfecha: TQRDBText;
    qrdbtxtcliente: TQRDBText;
    qrbnd4: TQRBand;
    qrlbl15: TQRLabel;
    qrlbl16: TQRLabel;
    qrlbl17: TQRLabel;
    qrlbl18: TQRLabel;
    qrlbl19: TQRLabel;
    qrlbl20: TQRLabel;
    qrdbtxtcliente1: TQRDBText;
    qrbnd5: TQRBand;
    bndsd3: TQRSubDetail;
    qrdbtxt4: TQRDBText;
    qrdbtxt5: TQRDBText;
    qrdbtxt6: TQRDBText;
    qrdbtxt7: TQRDBText;
    qrdbtxt8: TQRDBText;
    qrdbtxt9: TQRDBText;
    qrbnd6: TQRBand;
    qrlbl21: TQRLabel;
    qrlbl22: TQRLabel;
    qrlbl23: TQRLabel;
    qrlbl24: TQRLabel;
    qrlbl25: TQRLabel;
    qrlbl26: TQRLabel;
    qrbnd7: TQRBand;
    qrbnd8: TQRBand;
    bndsd4: TQRSubDetail;
    qrdbtxt10: TQRDBText;
    qrdbtxtentrega5: TQRDBText;
    qrdbtxtproveedor: TQRDBText;
    qrdbtxtnom_proveedor: TQRDBText;
    qrdbtxtproductor: TQRDBText;
    qrdbtxtnom_productor: TQRDBText;
    qrbnd9: TQRBand;
    qrlbl27: TQRLabel;
    qrlbl28: TQRLabel;
    qrlbl29: TQRLabel;
    qrlbl30: TQRLabel;
    qrlbl32: TQRLabel;
    qrlblEstimado: TQRLabel;
    qrdbtxtcategoria: TQRDBText;
    qrbnd10: TQRBand;
    qrsysdt1: TQRSysData;
    qrbndCabSinFOB: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    qrbndSinFOB: TQRSubDetail;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    qrdbtxtproducto: TQRDBText;
    qrdbtxtproducto1: TQRDBText;
    qrdbtxtproducto3: TQRDBText;
    qrdbtxtproducto4: TQRDBText;
    qrbndPieSinFOB: TQRBand;
    qrdbtxtproducto2: TQRDBText;
    qrdbtxtvariedad: TQRDBText;
    qrdbtxtenvase: TQRDBText;
    qrdbtxtsalida: TQRDBText;
    qrdbtxtcliente2: TQRDBText;
    qrdbtxtsscc1: TQRDBText;
    qrdbtxtsscc2: TQRDBText;
    qrxpr1: TQRExpr;
    qrlbl31: TQRLabel;
    qrlbl33: TQRLabel;
    qrlbl34: TQRLabel;
    qrlbl35: TQRLabel;
    qrlbl36: TQRLabel;
    qrlbl37: TQRLabel;
    qrbndSinPrecioReal: TQRSubDetail;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    qrbndCabSinPrecioReal: TQRBand;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    qrbndPieSinPrecioReal: TQRBand;
    QRLabel8: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText7: TQRDBText;
    procedure qrdbtxtproducto1Print(sender: TObject; var Value: string);

  private

  public

  end;

  procedure PrevisualizarIncidencias( const AEmpresa, AAnyoSemana, AProducto: string );


implementation

{$R *.DFM}

uses LiquidaIncidenciasDL, UDMAuxDB,  DPreview, CReportes, CVariables;


procedure PrevisualizarIncidencias( const AEmpresa, AAnyoSemana, AProducto: string );
var
  QLLiquidaIncidencias: TQLLiquidaIncidencias;
begin
  QLLiquidaIncidencias := TQLLiquidaIncidencias.Create(Application);
  PonLogoGrupoBonnysa(QLLiquidaIncidencias, AEmpresa);
  QLLiquidaIncidencias.qrlblTitulo.Caption:= 'INCIDENCIAS LIQUIDACIÓN PLATANO ( ' + AProducto + ' ) ' + AEmpresa  + ' - SEMANA ' + AAnyoSemana;
  QLLiquidaIncidencias.ReportTitle:= 'INCIDENCIAS_LIQUIDACION_PLATANO_' + AEmpresa  + '_SEMANA_' + AAnyoSemana + '_' + AProducto;
  Preview(QLLiquidaIncidencias);
end;

procedure TQLLiquidaIncidencias.qrdbtxtproducto1Print(sender: TObject;
  var Value: string);
begin
  qrdbtxtproducto1.Caption := desProducto(gsDefEmpresa, Value);
end;

end.

