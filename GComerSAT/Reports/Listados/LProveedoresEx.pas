unit LProveedoresEx;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, CVariables, DB, DBTables;

type
  TQRLProveedoresEx = class(TQuickRep)
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
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand7BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand5BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetail2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand6BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    sEmpresa: string;

  public
    bAlmacenes, bProductos: boolean;
    procedure  MontarListado( const AWhere: string; const AAlmacenes, AProductos: boolean );
    Destructor Destroy; Override;
  end;


implementation

{$R *.DFM}

uses UDMBaseDatos, UDMAuxDB;

procedure TQRLProveedoresEx.QRSysData2Print(sender: TObject;
  var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLProveedoresEx.empresa_pPrint(sender: TObject;
  var Value: String);
begin
  sEmpresa:= Value;
  value:= DesEmpresa( Value );
end;

procedure TQRLProveedoresEx.QRDBText6Print(sender: TObject;
  var Value: String);
begin
  if value <> '' then
    Value:= 'FP: ' + Value;
end;

procedure TQRLProveedoresEx.MontarListado( const AWhere: string; const AAlmacenes, AProductos: boolean );
begin
  with QProveedores do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_proveedores ');
    SQL.Add( AWhere );
    SQL.Add(' order by empresa_p, proveedor_p ');
    Open;
  end;
  bAlmacenes:= AAlmacenes;
  bProductos:= AProductos;
end;

procedure TQRLProveedoresEx.QProveedoresAfterOpen(DataSet: TDataSet);
begin
  QAlmacenes.Open;
  QProductos.Open;
end;

procedure TQRLProveedoresEx.QProveedoresBeforeClose(DataSet: TDataSet);
begin
  QAlmacenes.Close;
  QProductos.Close;
end;

Destructor TQRLProveedoresEx.Destroy;
begin
  QProductos.Close;
  Inherited;
end;

procedure TQRLProveedoresEx.desPais_ppPrint(sender: TObject;
  var Value: String);
begin
  Value:= DesPais( Value );
end;

procedure TQRLProveedoresEx.desProducto_ppPrint(sender: TObject;
  var Value: String);
begin
  Value:= DesProducto( sEmpresa, Value );
end;

procedure TQRLProveedoresEx.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bAlmacenes;
end;

procedure TQRLProveedoresEx.QRSubDetail1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bAlmacenes;
end;

procedure TQRLProveedoresEx.QRBand7BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bAlmacenes and not bProductos;
end;

procedure TQRLProveedoresEx.QRBand5BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:=  bProductos;
end;

procedure TQRLProveedoresEx.QRSubDetail2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:=  bProductos;
end;

procedure TQRLProveedoresEx.QRBand6BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:=  bProductos;
end;

end.
