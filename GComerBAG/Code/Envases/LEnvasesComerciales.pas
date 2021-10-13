unit LEnvasesComerciales;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, CVariables, DB, DBTables;

type
  TQRLEnvasesComerciales = class(TQuickRep)
    QRBand3: TQRBand;
    QRBand2: TQRBand;
    PsQRLabel1: TQRLabel;
    QRSysData3: TQRSysData;
    qrdbtxtcod_operador_eco: TQRDBText;
    domicilio_c: TQRDBText;
    PageFooterBand1: TQRBand;
    QRSysData4: TQRSysData;
    QOperadores: TQuery;
    DataSource: TDataSource;
    QProductos: TQuery;
    bndsdEnvase: TQRSubDetail;
    qrdbtxtcod_producto_ecp: TQRDBText;
    qrdbtxtde_producto_ecp: TQRDBText;
    qrbndEnvase: TQRBand;
    QRLabel5: TQRLabel;
    bndcChildBand1: TQRChildBand;
    qrlbl1: TQRLabel;
    qrbndAlmacen: TQRBand;
    qrlblAlmacen: TQRLabel;
    bndsdAlmacen: TQRSubDetail;
    cod_almacen_eca: TQRDBText;
    qrdbtxtcod_producto_ecp1: TQRDBText;
    dsAlmacenes: TDataSource;
    qryAlmacenes: TQuery;
    procedure QRSysData2Print(sender: TObject; var Value: string);
    procedure QOperadoresAfterOpen(DataSet: TDataSet);
    procedure QOperadoresBeforeClose(DataSet: TDataSet);
  private
    sEmpresa: string;

  public

    procedure  MontarListado( const AWhere: string );
    Destructor Destroy; Override;
  end;


implementation

{$R *.DFM}

uses UDMBaseDatos, UDMAuxDB;

procedure TQRLEnvasesComerciales.QRSysData2Print(sender: TObject;
  var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLEnvasesComerciales.MontarListado( const AWhere: string );
begin
  with QProductos do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_env_comer_productos' );
    SQL.Add('where cod_operador_ecp = :cod_operador_eco' );
    SQL.Add('order by cod_producto_ecp' );
  end;
  with qryAlmacenes do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_env_comer_almacenes' );
    SQL.Add('where cod_operador_eca = :cod_operador_eco' );
    SQL.Add('order by cod_almacen_eca' );
  end;
  with QOperadores do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_env_comer_operadores');
    SQL.Add( AWhere );
    SQL.Add('order by cod_operador_eco' );
    Open;
  end;
end;

procedure TQRLEnvasesComerciales.QOperadoresAfterOpen(DataSet: TDataSet);
begin
  QProductos.Open;
  qryAlmacenes.Open;
end;

procedure TQRLEnvasesComerciales.QOperadoresBeforeClose(DataSet: TDataSet);
begin
  QProductos.Close;
  qryAlmacenes.Close;
end;

Destructor TQRLEnvasesComerciales.Destroy;
begin
  QOperadores.Close;
  Inherited;
end;

end.

