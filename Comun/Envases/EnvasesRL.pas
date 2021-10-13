unit EnvasesRL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TRLEnvases = class(TQuickRep)
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    TitleBand1: TQRBand;
    QRDBText1: TQRDBText;
    descripcion_e: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRDBText5: TQRDBText;
    QRGroup1: TQRGroup;
    ChildBand2: TQRChildBand;
    notas_e: TQRDBText;
    fecha_baja_e: TQRDBText;
    PsQRDBText1: TQRDBText;
    peso_variable_e: TQRDBText;
    QRLabel13: TQRLabel;
    envase_comercial_e: TQRDBText;
    QRSubDetail1: TQRSubDetail;
    qrdbtxtcliente_ce: TQRDBText;
    qrdbtxtdescripcion_ce: TQRDBText;
    unidad_fac_ce: TQRDBText;
    qrdbtxtkgs_palet_ce: TQRDBText;
    qrdbtxtn_palets_ce: TQRDBText;
    tipo_iva_e: TQRDBText;
    qrlbl1: TQRLabel;
    qrdbtxt_comer_operador_e: TQRDBText;
    qrdbtxt_comer_producto_e: TQRDBText;
    qrdbtxt_caja_e: TQRDBText;
    qrlbl3: TQRLabel;
    qrlbl5: TQRLabel;
    qrdbtxtempresa: TQRDBText;
    qrdbtxtempresa1: TQRDBText;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrdbtxtagrupacion: TQRDBText;
    qrlblTipoIva: TQRLabel;
    qrdbtxtcod_iva: TQRDBText;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    QRLabel15: TQRLabel;
    qrlbl11: TQRLabel;
    qrlbl16: TQRLabel;
    qrshp1: TQRShape;
    qrlbl17: TQRLabel;
    qrdbtxtneto_unidad: TQRDBText;
    qrlbl19: TQRLabel;
    qrdbtxtcod_envase1: TQRDBText;
    qrdbtxtdes_envase1: TQRDBText;
    qrlbl20: TQRLabel;
    qrdbtxtean13_e: TQRDBText;
    qrdbtxtcod_tipo_caja: TQRDBText;
    qrdbtxtcod_operador: TQRDBText;
    qrchldbndChildBand1: TQRChildBand;
    qrdbtxtcod_unidad1: TQRDBText;
    qrdbtxtdes_unidad: TQRDBText;
    qrlbl21: TQRLabel;
    qrdbtxtcod_unidad: TQRDBText;
    qrlbl14: TQRLabel;
    qrdbtxtneto_envase: TQRDBText;
    qrlbl15: TQRLabel;
    qrdbtxtpeso_variable1: TQRDBText;
    qrlbl18: TQRLabel;
    qrdbtxtpeso_unidad: TQRDBText;
    qrlbl22: TQRLabel;
    qrlbl23: TQRLabel;
    qrlbl24: TQRLabel;
    qrdbtxtpeso_variable: TQRDBText;
    qrlbl13: TQRLabel;
    qrdbtxtunidades: TQRDBText;
    qrlbl12: TQRLabel;
    qrbndCabClientes: TQRBand;
    qrdbtxtcaducidad_cliente_ce1: TQRDBText;
    qrdbtxtcaducidad_cliente_ce: TQRDBText;
    qrdbtxtmax_vida_cliente_ce: TQRDBText;
    qrlbl25: TQRLabel;
    qrlbl27: TQRLabel;
    qrlbl28: TQRLabel;
    qrlbl29: TQRLabel;
    qrlbl30: TQRLabel;
    qrlbl31: TQRLabel;
    qrlbl32: TQRLabel;
    qrlbl33: TQRLabel;
    qrlbl34: TQRLabel;
    qrlbl35: TQRLabel;
    qrlbl36: TQRLabel;
    QRBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel12: TQRLabel;
    QRSubDetail2: TQRSubDetail;
    QRDBText2: TQRDBText;
    qrdbtxtean14_e: TQRDBText;
    qrdbtxtdescripcion_e: TQRDBText;
    QRDBText8: TQRDBText;
    qrdbtxtmarca_e: TQRDBText;
    QRDBText11: TQRDBText;
    qrdbtxtcalibre_e: TQRDBText;
    qrbndPieClientes: TQRBand;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure peso_variable_ePrint(sender: TObject; var Value: String);
    procedure envase_comercial_ePrint(sender: TObject; var Value: String);
  private

  public

  end;

var
  RLEnvases: TRLEnvases;

implementation

uses
  CVariables, UDMAuxDB, EnvasesDL;

{$R *.DFM}

(*
    SQL.Add('   notas_e notas, ');

*)

procedure TRLEnvases.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TRLEnvases.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  ReportTitle:= 'FichaEnvase_' + DataSet.fieldByName('cod_envase').AsString;
end;

procedure TRLEnvases.peso_variable_ePrint(sender: TObject;
  var Value: String);
begin
  if Value = '0' then
    Value:= 'NO'
  else
    Value:= 'SI';
end;

procedure TRLEnvases.envase_comercial_ePrint(sender: TObject;
  var Value: String);
begin
  if Value = 'N' then
    Value:= 'NO'
  else
    Value:= 'SI';
end;
(*
    qryEan13.SQL.Clear;
    qryEan13.SQL.Add(' select ');
    qryEan13.SQL.Add('   , ');
    qryEan13.SQL.Add('   , ');
    qryEan13.SQL.Add('   , ');
    qryEan13.SQL.Add('   , ');
    qryEan13.SQL.Add('   , ');
    qryEan13.SQL.Add('   , ');
    qryEan13.SQL.Add('   , ');
    qryEan13.SQL.Add('   descripcion2_e ');

    qryEan13.SQL.Add(' from frf_ean13 ');
    qryEan13.SQL.Add(' where empresa_e = :empresa ');
    qryEan13.SQL.Add(' and envase_e = :envase ');
    qryEan13.SQL.Add(' and agrupacion_e = 2 ');
    qryEan13.ParamByName('empresa').AsString:= AEmpresa;
    qryEan13.ParamByName('envase').AsString:= AEnvase;
    qryEan13.Open;
*)

end.
