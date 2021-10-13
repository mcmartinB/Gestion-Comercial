unit CompraFichaQR;

interface

uses Classes, Graphics, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, QRCtrls, UDMBaseDatos;

type
  TQRCompraFicha = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    Empresa: TQRLabel;
    LCentro: TQRLabel;
    fecha_c: TQRDBText;
    numero_c: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    proveedor_c: TQRDBText;
    QRGroup1: TQRGroup;
    empresa_c: TQRDBText;
    centro_c: TQRDBText;
    ChildBand1: TQRChildBand;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel1: TQRLabel;
    ChildBand2: TQRChildBand;
    QRLabel5: TQRLabel;
    QRMemo: TQRMemo;
    ref_compra_c: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    quien_compra_c: TQRDBText;
    bnddGastos: TQRSubDetail;
    qreTipo_gc: TQRDBText;
    qreref_fac_gc: TQRDBText;
    qreFecha_fac_gc: TQRDBText;
    qreNota_gc: TQRDBText;
    qreImporte_gc: TQRDBText;
    bnddEntregas: TQRSubDetail;
    qrealbaran_ec: TQRDBText;
    qrefecha_llegada_ec: TQRDBText;
    qretransporte_ec: TQRDBText;
    qrevehiculo_ec: TQRDBText;
    qreproducto_el: TQRDBText;
    qrekilos_el: TQRDBText;
    bndCabGastos: TQRBand;
    qrlGastos: TQRLabel;
    qrltipo_gc: TQRLabel;
    qrlReferencia: TQRLabel;
    qrlfecha: TQRLabel;
    qrlnota: TQRLabel;
    qrlImporte: TQRLabel;
    bndCabEntregas: TQRBand;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    bndPieGastos: TQRBand;
    bndPieEntregas: TQRBand;
    bndcSepCompra: TQRChildBand;
    qrxAcumImporte: TQRExpr;
    qrxAcunmKilos: TQRExpr;
    bnddGastosEntregas: TQRSubDetail;
    qretipo_ge: TQRDBText;
    qreref_fac_ge: TQRDBText;
    qrefecha_fac_ge: TQRDBText;
    qrenota_g: TQRDBText;
    qreimporte_ge: TQRDBText;
    qrlCodigo_ec: TQRLabel;
    qrecodigo_ec: TQRDBText;
    qrecodigo_ge: TQRDBText;
    bndCabGastosEntregas: TQRBand;
    qrl7: TQRLabel;
    qrl1: TQRLabel;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    qrl6: TQRLabel;
    bndPieGastosEntregas: TQRBand;
    qrxAcumGastosEntregas: TQRExpr;
    qrlGastosEntregas: TQRLabel;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure empresa_cPrint(sender: TObject; var Value: String);
    procedure centro_cPrint(sender: TObject; var Value: String);
    procedure proveedor_cPrint(sender: TObject; var Value: String);
    procedure qreTipo_gcPrint(sender: TObject; var Value: String);
    procedure qretransporte_ecPrint(sender: TObject; var Value: String);
    procedure qreproducto_elPrint(sender: TObject; var Value: String);
    procedure qreFecha_fac_gcPrint(sender: TObject; var Value: String);
    procedure qrefecha_llegada_ecPrint(sender: TObject; var Value: String);
    procedure qrefecha_fac_gePrint(sender: TObject; var Value: String);
  private

  public

  end;

  procedure VerFicha( const AOwner: TComponent );


implementation

uses
  CompraFichaDL, DPreview, UDMAuxDB;

{$R *.DFM}

var
  QRCompraFicha: TQRCompraFicha;

procedure VerFicha;
begin
  QRCompraFicha:= TQRCompraFicha.Create( AOwner );
  try
   Previsualiza( QRCompraFicha );
  finally
    FreeAndNil( QRCompraFicha );
  end;
end;

procedure TQRCompraFicha.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRCompraFicha.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= Trim( DataSet.FieldByName('observaciones_c').AsString ) <> '';
  if PrintBand then
  begin
    QRMemo.Lines.Clear;
    QRMemo.Lines.Add( Trim( DataSet.FieldByName('observaciones_c').AsString ) );
  end;
end;

procedure TQRCompraFicha.empresa_cPrint(sender: TObject; var Value: String);
begin
  Value:= desEmpresa( value );
end;

procedure TQRCompraFicha.centro_cPrint(sender: TObject; var Value: String);
begin
  Value:= desCentro( DataSet.FieldByName('empresa_c').AsString, value );
end;

procedure TQRCompraFicha.proveedor_cPrint(sender: TObject; var Value: String);
begin
  Value:= value + ' ' + desProveedor( DataSet.FieldByName('empresa_c').AsString, value );
end;

procedure TQRCompraFicha.qreTipo_gcPrint(sender: TObject;
  var Value: String);
begin
  Value:= value + ' ' + desTipoGastos( value );
end;

procedure TQRCompraFicha.qretransporte_ecPrint(sender: TObject;
  var Value: String);
begin
  Value:= value + ' ' + desTransporte( DataSet.FieldByName('empresa_c').AsString, value );
end;

procedure TQRCompraFicha.qreproducto_elPrint(sender: TObject;
  var Value: String);
begin
  Value:= value + ' ' + desProducto( DataSet.FieldByName('empresa_c').AsString, value );
end;

procedure TQRCompraFicha.qreFecha_fac_gcPrint(sender: TObject;
  var Value: String);
begin
  if bnddGastos.DataSet.FieldByName('fecha_fac_gc').AsString = '' then
    Value:= '';
end;

procedure TQRCompraFicha.qrefecha_llegada_ecPrint(sender: TObject;
  var Value: String);
begin
  if bnddEntregas.DataSet.FieldByName('fecha_llegada_ec').AsString = '' then
    Value:= '';
end;

procedure TQRCompraFicha.qrefecha_fac_gePrint(sender: TObject;
  var Value: String);
begin
  if bnddGastosEntregas.DataSet.FieldByName('fecha_fac_ge').AsString = '' then
    Value:= '';
end;

end.
