unit UInstruccionCargaQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQRInstruccionCarga = class(TQuickRep)
    bndDetalle: TQRBand;
    bndTitulo: TQRBand;
    PageFooterBand1: TQRBand;
    PsQRSysData1: TQRSysData;
    QRSysData1: TQRSysData;
    QRDBText2: TQRDBText;
    QRSysData2: TQRSysData;
    bndLineas: TQRSubDetail;
    bndCabLineas: TQRBand;
    qrdbtxtproducto_al: TQRDBText;
    qrdbtxtproducto_al1: TQRDBText;
    qrdbtxtpalets_al: TQRDBText;
    QRDBText13: TQRDBText;
    qrdbtxtprecio_caja_al: TQRDBText;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel14: TQRLabel;
    bndPieLineas: TQRBand;
    QRLabel26: TQRLabel;
    qrdbtxtcalibre_al: TQRDBText;
    QRLabel33: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRShape6: TQRShape;
    Desproveedor_ec: TQRDBText;
    qrlblImporte: TQRLabel;
    qrlblImporteLinea: TQRLabel;
    qrlblImporteLineas: TQRLabel;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    qrdbtxt_ec: TQRDBText;
    qrdbtxt_llegada_ec: TQRDBText;
    QRLabel25: TQRLabel;
    qrdbtxtobservaciones_ec: TQRDBText;
    qrlbl3: TQRLabel;
    qrdbtxtempresa_ac: TQRDBText;
    qrdbtxtempresa_ac1: TQRDBText;
    qrlbl4: TQRLabel;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl5: TQRLabel;
    qrdbtxt1: TQRDBText;
    procedure QRLabel25Print(sender: TObject; var Value: String);
    procedure bndLineasBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPieLineasBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Desproveedor_ecPrint(sender: TObject; var Value: String);
    procedure QRDBText8Print(sender: TObject; var Value: String);
    procedure qrdbtxtempresa_ac1Print(sender: TObject; var Value: String);
    procedure qrdbtxtproducto_al1Print(sender: TObject; var Value: String);
  private
    rImporte: Real;
  public
    //procedure PonBarCode( const ACodigo: String);
  end;

implementation

{$R *.DFM}

uses UAsignacionFrutaFM, UDMAuxDB, UDMConfig;

(*
CREATE TABLE frf_asignacion_c (
   INTEGER NOT NULL,
   CHAR(3) NOT NULL,

   CHAR(3) NOT NULL,
   INTEGER NOT NULL,
   CHAR(12) NOT NULL,
   DATE NOT NULL,

  producto_ac CHAR(1) NOT NULL,
   CHAR(255),
  status_ac INTEGER DEFAULT 0 NOT NULL
)

CREATE TABLE frf_asignacion_l (
  contador_al INTEGER NOT NULL,
  linea_al INTEGER NOT NULL,
  empresa_al CHAR(3) NOT NULL,
   CHAR(1) NOT NULL,
   CHAR(6)NOT NULL,
   DECIMAL(9,5),
   INTEGER NOT NULL,
   INTEGER NOT NULL
)

*)


procedure TQRInstruccionCarga.QRLabel25Print(sender: TObject;
  var Value: String);
begin
  if Trim( DataSet.FieldByName('observaciones_ac').AsString ) = '' then
    Value:= ''
  else
    Value:= 'NOTAS:';
end;

procedure TQRInstruccionCarga.bndDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  rImporte:= 0;
end;

procedure TQRInstruccionCarga.bndLineasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  rAux: Real;
begin
  rAux:= bndLineas.DataSet.FieldByName('precio_caja_al').AsFloat * bndLineas.DataSet.FieldByName('cajas_al').AsFloat;
  rImporte:= rImporte + rAux;
  qrlblImporteLinea.Caption:= FormatFloat( '#,##0.00', rAux );
end;

procedure TQRInstruccionCarga.bndPieLineasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrlblImporteLineas.Caption:= FormatFloat( '#,##0.00', rImporte );
end;

procedure TQRInstruccionCarga.Desproveedor_ecPrint(sender: TObject;
  var Value: String);
begin
  Value:= desProveedor( DataSet.FieldByName('empresa_ac').AsString, Value );
end;

procedure TQRInstruccionCarga.QRDBText8Print(sender: TObject;
  var Value: String);
begin
  Value:= desProveedorAlmacen( DataSet.FieldByName('empresa_ac').AsString, DataSet.FieldByName('proveedor_ac').AsString, Value );
end;

procedure TQRInstruccionCarga.qrdbtxtempresa_ac1Print(sender: TObject;
  var Value: String);
begin
    Value:= desEmpresa( Value );
end;

procedure TQRInstruccionCarga.qrdbtxtproducto_al1Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( DataSet.FieldByName('empresa_ac').AsString, Value );
end;

end.
