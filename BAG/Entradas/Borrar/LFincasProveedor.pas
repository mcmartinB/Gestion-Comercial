unit LFincasProveedor;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, CVariables, DB, DBTables;

type
  TQRLFincasProveedor = class(TQuickRep)
    QRBand3: TQRBand;
    QRBand2: TQRBand;
    PsQRLabel1: TQRLabel;
    QRSysData3: TQRSysData;
    QRGroup1: TQRGroup;
    empresa_p: TQRDBText;
    ChildBand3: TQRChildBand;
    QRLabel10: TQRLabel;
    ld: TQRLabel;
    Lp: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel3: TQRLabel;
    QRBand1: TQRBand;
    tipo_via_c: TQRDBText;
    domicilio_c: TQRDBText;
    nombre_c: TQRDBText;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    cta_contable_p: TQRDBText;
    cod_postal_c: TQRDBText;
    poblacion_c: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    PageFooterBand1: TQRBand;
    QRSysData4: TQRSysData;
    QRSubDetail1: TQRSubDetail;
    almacen_pa: TQRDBText;
    nombre_pa: TQRDBText;
    QRBand4: TQRBand;
    QRLabel1: TQRLabel;
    QProveedores: TQuery;
    QAlmacenes: TQuery;
    DataSource: TDataSource;
    QProductos: TQuery;
    QRSubDetail2: TQRSubDetail;
    producto_pp: TQRDBText;
    desProducto_pp: TQRDBText;
    descripcion_pp: TQRDBText;
    descripcion_breve_pp: TQRDBText;
    marca_pp: TQRDBText;
    presentacion_pp: TQRDBText;
    codigo_ean_pp: TQRDBText;
    pais_pp: TQRDBText;
    peso_paleta_pp: TQRDBText;
    QRBand5: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    variedad_pp: TQRDBText;
    desPais_pp: TQRDBText;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    peso_cajas_pp: TQRDBText;
    QRLabel14: TQRLabel;
    cajas_paleta_pp: TQRDBText;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRBand6: TQRBand;
    QRShape3: TQRShape;
    QRBand7: TQRBand;
    QRShape4: TQRShape;
    procedure QRSysData2Print(sender: TObject; var Value: string);
    procedure empresa_pPrint(sender: TObject; var Value: String);
    procedure QRDBText6Print(sender: TObject; var Value: String);
    procedure QProveedoresAfterOpen(DataSet: TDataSet);
    procedure QProveedoresBeforeClose(DataSet: TDataSet);
    procedure desPais_ppPrint(sender: TObject; var Value: String);
    procedure desProducto_ppPrint(sender: TObject; var Value: String);
  private
    sEmpresa: string;

  public
    procedure  MontarListado( const AWhere: string );
    Destructor Destroy; Override;
  end;


implementation

{$R *.DFM}

uses UDMBaseDatos, UDMAuxDB;

procedure TQRLFincasProveedor.QRSysData2Print(sender: TObject;
  var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLFincasProveedor.empresa_pPrint(sender: TObject;
  var Value: String);
begin
  sEmpresa:= Value;
  value:= DesEmpresa( Value );
end;

procedure TQRLFincasProveedor.QRDBText6Print(sender: TObject;
  var Value: String);
begin
  if value <> '' then
    Value:= 'FP: ' + Value;
end;

procedure TQRLFincasProveedor.MontarListado( const AWhere: string );
begin
  with QProveedores do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_proveedores_fincas ');
    SQL.Add( AWhere );
    SQL.Add(' ORDER BY proveedor_pf, almacen_pf, finca_pf ');
    Open;
  end;
end;

procedure TQRLFincasProveedor.QProveedoresAfterOpen(DataSet: TDataSet);
begin
  QAlmacenes.Open;
  QProductos.Open;
end;

procedure TQRLFincasProveedor.QProveedoresBeforeClose(DataSet: TDataSet);
begin
  QAlmacenes.Close;
  QProductos.Close;
end;

Destructor TQRLFincasProveedor.Destroy;
begin
  QProductos.Close;
  Inherited;
end;

procedure TQRLFincasProveedor.desPais_ppPrint(sender: TObject;
  var Value: String);
begin
  Value:= DesPais( Value );
end;

procedure TQRLFincasProveedor.desProducto_ppPrint(sender: TObject;
  var Value: String);
begin
  Value:= DesProducto( sEmpresa, Value );
end;

end.
