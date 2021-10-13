unit LEnvasesSimple;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLEnvasesSimple = class(TQuickRep)
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
    producto_e: TQRDBText;
    ChildBand2: TQRChildBand;
    tipo_unidad_e: TQRDBText;
    QRDBText2: TQRDBText;
    notas_e: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    env_comer_operador_e: TQRDBText;
    texto_caja_e: TQRDBText;
    fecha_baja_e: TQRDBText;
    empresa_e: TQRDBText;
    PsQRDBText1: TQRDBText;
    QRLabel9: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    peso_variable_e: TQRDBText;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    tipo_iva_e: TQRDBText;
    envase_comercial_e: TQRDBText;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    bndSubDetalle: TQRSubDetail;
    cliente_ce: TQRDBText;
    descripcion_ce: TQRDBText;
    unidad_fac_ce: TQRDBText;
    kgs_palet_ce: TQRDBText;
    n_palets_ce: TQRDBText;
    QRLabel16: TQRLabel;
    qrecliente_ce: TQRDBText;
    env_comer_producto_e: TQRDBText;
    tipo_caja_e: TQRDBText;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure PsQRDBText2Print(sender: TObject; var Value: string);
    procedure producto_ePrint(sender: TObject; var Value: String);
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
    procedure descripcion_cePrint(sender: TObject; var Value: String);
    procedure qrecliente_cePrint(sender: TObject; var Value: String);
    procedure tipo_iva_ePrint(sender: TObject; var Value: String);
    procedure texto_caja_ePrint(sender: TObject; var Value: String);
    procedure tipo_caja_ePrint(sender: TObject; var Value: String);
  private

  public

  end;

var
  QRLEnvasesSimple: TQRLEnvasesSimple;

implementation

uses CVariables, UDMAuxDB, MEnvases, Variants;

{$R *.DFM}

procedure TQRLEnvasesSimple.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLEnvasesSimple.PsQRDBText2Print(sender: TObject; var Value: string);
begin
  if Value = '0,000' then Value := '';
end;

procedure TQRLEnvasesSimple.producto_ePrint(sender: TObject;
  var Value: String);
begin
  if Trim( Value ) = '' then
    Value:= 'TODOS LOS PRODUCTOS.'
  else
    Value:= Value + ' - ' + desProducto( DataSet.fieldByName('empresa_e').AsString, Value );
end;

procedure TQRLEnvasesSimple.QRDBText2Print(sender: TObject; var Value: String);
begin
  Value:= desTipoUnidad( DataSet.fieldByName('empresa_e').AsString, Value,
                         DataSet.fieldByName('producto_e').AsString );
end;

procedure TQRLEnvasesSimple.notas_ePrint(sender: TObject; var Value: String);
begin
  Value:= Trim( Value );
end;

procedure TQRLEnvasesSimple.empresa_ePrint(sender: TObject; var Value: String);
begin
  Value:= Value + ' - ' + desEmpresa( Value );
end;

procedure TQRLEnvasesSimple.cod_almacen_ePrint(sender: TObject;
  var Value: String);
begin
  If Value = 'S' then
    Value:= 'SI'
  else
    Value:= 'NO';
end;

procedure TQRLEnvasesSimple.QRDBText4Print(sender: TObject; var Value: String);
begin
  Value:= Value + ' Kgs';
end;

procedure TQRLEnvasesSimple.peso_variable_ePrint(sender: TObject; var Value: String);
begin
  if (Value = '0') or (Value = '') then
    Value:= 'NO'
  else
    Value:= 'SI';
end;

procedure TQRLEnvasesSimple.envase_comercial_ePrint(sender: TObject;
  var Value: String);
begin
  if (Value = 'N') or (Value = '') then
    Value:= 'NO'
  else
    Value:= 'SI';
end;

procedure TQRLEnvasesSimple.unidad_fac_cePrint(sender: TObject;
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

procedure TQRLEnvasesSimple.n_palets_cePrint(sender: TObject; var Value: String);
begin
  Value:= 'Caj palet: ' + Value;
end;

procedure TQRLEnvasesSimple.kgs_palet_cePrint(sender: TObject;
  var Value: String);
begin
  Value:= 'Kgs palet: ' + Value;
end;

procedure TQRLEnvasesSimple.fecha_baja_ePrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('fecha_baja_e').Value <> NULL then
  begin
    Value:= FormatDateTime( 'dd/mm/yy', DataSet.FieldByName('fecha_baja_e').AsDateTime );
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQRLEnvasesSimple.descripcion_cePrint(sender: TObject;
  var Value: String);
begin
  if bndSubDetalle.DataSet.fieldByName('descripcion_ce').AsString = '' then
  begin
    Value:= 'Sin descripción cliente.';
  end
  else
  begin
    Value:= bndSubDetalle.DataSet.fieldByName('descripcion_ce').AsString;
  end;
end;

procedure TQRLEnvasesSimple.qrecliente_cePrint(sender: TObject;
  var Value: String);
begin
  Value:= desCliente( Value );
end;

procedure TQRLEnvasesSimple.tipo_iva_ePrint(sender: TObject; var Value: String);
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

procedure TQRLEnvasesSimple.texto_caja_ePrint(sender: TObject;
  var Value: String);
begin
  Value:= desEnvComerProducto( DataSet.FieldbyName('env_comer_operador_e').AsString, Value );
end;

procedure TQRLEnvasesSimple.tipo_caja_ePrint(sender: TObject; var Value: String);
begin
  Value:=  'Caja: '+ Value + ' ' + desTipoCaja(  Value );
end;

end.
