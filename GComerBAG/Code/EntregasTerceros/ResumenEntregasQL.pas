unit ResumenEntregasQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLResumenEntregas = class(TQuickRep)
    QRBCabecera: TQRBand;
    QRBDetalle: TQRBand;
    QRBSumario: TQRBand;
    QRBGrupo: TQRGroup;
    QRLabel6: TQRLabel;
    QRLCosechero: TQRLabel;
    QRLKilos: TQRLabel;
    QRLCajas: TQRLabel;
    proveedor_ec: TQRDBText;
    QRDBTCajas: TQRDBText;
    QRDBTKilos: TQRDBText;
    QRBTitulo: TQRBand;
    QRLabel1: TQRLabel;
    QRLDesde: TQRLabel;
    QRLHasta: TQRLabel;
    psAgrupacion: TQRLabel;
    QListado: TQuery;
    desProveedor: TQRDBText;
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
    QRLabel2: TQRLabel;
    palets_el: TQRDBText;
    QRShape2: TQRShape;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    psCentro: TQRLabel;
    QRLabel3: TQRLabel;
    entregas_ec: TQRDBText;
    QRShape3: TQRShape;
    QRExpr5: TQRExpr;
    QRExpr8: TQRExpr;
    psSemana: TQRLabel;
    qrgrpAlmacen: TQRGroup;
    qrgrpProducto: TQRGroup;
    qrdbtxtproducto: TQRDBText;
    qrdbtxtvariedad: TQRDBText;
    qrdbtxt_el: TQRDBText;
    qrdbtxtAlmacen: TQRDBText;
    qrdbtxtalmacen_el: TQRDBText;
    qrdbtxtproducto1: TQRDBText;
    qrdbtxt1: TQRDBText;
    qrdbtxt2: TQRDBText;
    qrdbtxDestAlmacen: TQRDBText;
    qrdbtxt4: TQRDBText;
    qrbndPieProducto: TQRBand;
    qrlbl1: TQRLabel;
    qrshp1: TQRShape;
    qrshp2: TQRShape;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrshp3: TQRShape;
    qrxpr3: TQRExpr;
    qrshp4: TQRShape;
    qrxpr4: TQRExpr;
    qrbndPieAlmacen: TQRBand;
    qrlbl2: TQRLabel;
    qrshp5: TQRShape;
    qrshp6: TQRShape;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrshp7: TQRShape;
    qrxpr7: TQRExpr;
    qrshp8: TQRShape;
    qrxpr8: TQRExpr;
    psProducto: TQRLabel;
    procedure QRLTotalParcialPrint(sender: TObject; var Value: String);
    procedure qrdbtxtproducto1Print(sender: TObject; var Value: String);
    procedure qrdbtxtvariedadPrint(sender: TObject; var Value: String);
    procedure qrlbl1Print(sender: TObject; var Value: String);
    procedure qrlbl2Print(sender: TObject; var Value: String);
  private

  public
    bProductos, bVariedades: Boolean;
  end;

var
  QLResumenEntregas: TQLResumenEntregas;

implementation

{$R *.DFM}

uses
  UDMAuxDB;


procedure TQLResumenEntregas.QRLTotalParcialPrint(sender: TObject;
  var Value: String);
begin
  Value:= 'Total OPP/Proveedor ' + QListado.fieldbyname('proveedor_ec').AsString + ' ...'
end;




procedure TQLResumenEntregas.qrdbtxtproducto1Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( DataSet.fieldbyname('empresa_ec').Asstring, value );
end;

procedure TQLResumenEntregas.qrdbtxtvariedadPrint(sender: TObject;
  var Value: String);
begin
  Value:= desVariedad( DataSet.fieldbyname('empresa_ec').Asstring,
                       DataSet.fieldbyname('proveedor_ec').Asstring,
                       DataSet.fieldbyname('producto').Asstring, value );
end;

procedure TQLResumenEntregas.qrlbl1Print(sender: TObject;
  var Value: String);
begin
  Value:= 'Total producto ' + QListado.fieldbyname('proveedor_ec').AsString +'/'  +
                              QListado.fieldbyname('almacen_el').AsString + '/' +
                              QListado.fieldbyname('producto').AsString +  ' ...'
end;

procedure TQLResumenEntregas.qrlbl2Print(sender: TObject;
  var Value: String);
begin
  Value:= 'Total almacén ' + QListado.fieldbyname('proveedor_ec').AsString + '/'  +
                             QListado.fieldbyname('almacen_el').AsString +  ' ...'
end;

end.
