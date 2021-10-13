unit LEnvases;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLEnvases = class(TQuickRep)
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    TitleBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRDBText1: TQRDBText;
    descripcion_e: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRGroup1: TQRGroup;
    producto_base_e: TQRDBText;
    ChildBand2: TQRChildBand;
    tipo_unidad_e: TQRDBText;
    QRDBText2: TQRDBText;
    notas_e: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    fecha_baja_e: TQRDBText;
    empresa_e: TQRDBText;
    PsQRDBText1: TQRDBText;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    peso_variable_e: TQRDBText;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    envase_comercial_e: TQRDBText;
    QRLabel15: TQRLabel;
    QRSubDetail1: TQRSubDetail;
    cliente_ce: TQRDBText;
    descripcion_ce: TQRDBText;
    unidad_fac_ce: TQRDBText;
    kgs_palet_ce: TQRDBText;
    n_palets_ce: TQRDBText;
    QRLabel16: TQRLabel;
    qrlTipoIva: TQRLabel;
    tipo_iva_e: TQRDBText;
    qrlbl1: TQRLabel;
    qrdbtxt_comer_operador_e: TQRDBText;
    qrdbtxt_comer_producto_e: TQRDBText;
    qrdbtxt_caja_e: TQRDBText;
    qrlbl2: TQRLabel;
    linea_producto_e: TQRDBText;
    qrdbtxttipo_unidad_e: TQRDBText;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure PsQRDBText2Print(sender: TObject; var Value: string);
    procedure producto_base_ePrint(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure notas_ePrint(sender: TObject; var Value: String);
    procedure empresa_ePrint(sender: TObject; var Value: String);
    procedure cod_almacen_ePrint(sender: TObject; var Value: String);
    procedure QRDBText4Print(sender: TObject; var Value: String);
    procedure peso_variable_ePrint(sender: TObject; var Value: String);
    procedure envase_comercial_ePrint(sender: TObject; var Value: String);
    procedure unidad_fac_cePrint(sender: TObject; var Value: String);
    procedure n_palets_cePrint(sender: TObject; var Value: String);
    procedure kgs_palet_cePrint(sender: TObject; var Value: String);
    procedure fecha_baja_ePrint(sender: TObject; var Value: String);
    procedure tipo_iva_ePrint(sender: TObject; var Value: String);
    procedure qrdbtxt_caja_ePrint(sender: TObject; var Value: String);
    procedure qrdbtxttipo_unidad_ePrint(sender: TObject;
      var Value: String);
  private

  public

  end;

var
  QRLEnvases: TQRLEnvases;

implementation

uses CVariables, UDMAuxDB, MEnvases;

{$R *.DFM}

procedure TQRLEnvases.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLEnvases.PsQRDBText2Print(sender: TObject; var Value: string);
begin
  if Value = '0,000' then Value := '';
end;

procedure TQRLEnvases.producto_base_ePrint(sender: TObject;
  var Value: String);
begin
  if Trim( Value ) = '' then
    Value:= 'TODOS LOS PRODUCTOS.'
  else
    Value:= Value + ' - ' + desProductoBase( DataSet.fieldByName('empresa_e').AsString, Value );
end;

procedure TQRLEnvases.QRDBText2Print(sender: TObject; var Value: String);
begin
  Value:= desTipoUnidad( DataSet.fieldByName('empresa_e').AsString, Value, DataSet.fieldByName('producto_base_e').AsString );
end;

procedure TQRLEnvases.notas_ePrint(sender: TObject; var Value: String);
begin
  Value:= Trim( Value );
end;

procedure TQRLEnvases.empresa_ePrint(sender: TObject; var Value: String);
begin
  Value:= Value + ' - ' + desEmpresa( Value );
end;

procedure TQRLEnvases.cod_almacen_ePrint(sender: TObject;
  var Value: String);
begin
  If Value = 'S' then
    Value:= 'SI'
  else
    Value:= 'NO';
end;

procedure TQRLEnvases.QRDBText4Print(sender: TObject; var Value: String);
begin
  Value:= Value + ' Kgs';
end;

procedure TQRLEnvases.peso_variable_ePrint(sender: TObject; var Value: String);
begin
  if (Value = '0') or (Value = '') then
    Value:= 'NO'
  else
    Value:= 'SI';
end;

procedure TQRLEnvases.envase_comercial_ePrint(sender: TObject;
  var Value: String);
begin
  if (Value = '0') or (Value = '') then
    Value:= 'NO'
  else
    Value:= 'SI';
end;

procedure TQRLEnvases.unidad_fac_cePrint(sender: TObject;
  var Value: String);
begin
  if value = 'K' then
    value:= '[K] facturar kilos'
  else
  if value = 'C' then
    value:= '[C] facturar cajas'
  else
  if value = 'U' then
    value:= '[U] facturar unidades';
end;

procedure TQRLEnvases.n_palets_cePrint(sender: TObject; var Value: String);
begin
  Value:= 'Caj palet: ' + Value;
end;

procedure TQRLEnvases.kgs_palet_cePrint(sender: TObject;
  var Value: String);
begin
  Value:= 'Kgs palet: ' + Value;
end;

procedure TQRLEnvases.fecha_baja_ePrint(sender: TObject;
  var Value: String);
begin
  if Value <> '' then
  begin
    Value:= FormatDateTime( 'dd/mm/yy', DataSet.FieldByName('fecha_baja_e').AsDateTime );
  end;
end;

procedure TQRLEnvases.tipo_iva_ePrint(sender: TObject; var Value: String);
begin
  if Value = '0' then
    Value:= '0 Super'
  else
  if Value = '1' then
    Value:= '1 Reducido'
  else
  if Value = '2' then
    Value:= '2 General';
end;

procedure TQRLEnvases.qrdbtxt_caja_ePrint(sender: TObject;
  var Value: String);
begin
  Value:= desEnvComerProducto( DataSet.FieldbyName('env_comer_operador_e').AsString, Value );
end;

procedure TQRLEnvases.qrdbtxttipo_unidad_ePrint(sender: TObject;
  var Value: String);
begin
  Value:= desLineaProducto( Value );
end;

end.
