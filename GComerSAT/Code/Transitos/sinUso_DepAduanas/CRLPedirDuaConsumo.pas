unit CRLPedirDuaConsumo;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TRLPedirDuaConsumo = class(TQuickRep)
    bndTitulo: TQRBand;
    bndDetalle: TQRBand;
    QRLabel1: TQRLabel;
    lblPeriodo: TQRLabel;
    qrefecha_tc: TQRDBText;
    qrereferencia_tc: TQRDBText;
    qrekilos_das: TQRDBText;
    qretransporte_tc: TQRDBText;
    qrepais_c: TQRDBText;
    qredes_puerto_tc: TQRDBText;
    qrgCabTransito: TQRGroup;
    bndPie: TQRBand;
    qrldua_consumo_izq: TQRLabel;
    qrldua_consumo_der: TQRLabel;
    qrenombre_c: TQRDBText;
    bndcChildBand2: TQRChildBand;
    qretransito: TQRDBText;
    qredvd: TQRDBText;
    qrl4: TQRLabel;
    qrl6: TQRLabel;
    qrebuque: TQRDBText;
    qrl8: TQRLabel;
    qredua_exporta: TQRDBText;
    qrl11: TQRLabel;
    qrekilos_tc: TQRDBText;
    qrl12: TQRLabel;
    qrl3: TQRLabel;
    qrl2: TQRLabel;
    qrlBuque: TQRLabel;
    qrl1: TQRLabel;
    qrl5: TQRLabel;
    bndBandaSep: TQRChildBand;
    qrlSep1: TQRLabel;
    procedure qrepais_cPrint(sender: TObject; var Value: String);
    procedure qredes_puerto_tcPrint(sender: TObject; var Value: String);
    procedure qrldua_consumo_izqPrint(sender: TObject; var Value: String);
    procedure qrldua_consumo_derPrint(sender: TObject; var Value: String);
    procedure qrenombre_cPrint(sender: TObject; var Value: String);
    procedure qrgCabTransitoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    bFlag: boolean;
  public

  end;

  procedure Previsualizar( const AEmpresa, ACentro: string;
                           const AFechainicio, AFechafin: TDateTime );

implementation

{$R *.DFM}

uses
  CDLPedirDuaConsumo, UDMAUXDB, CReportes, DPreview;

var
  RLPedirDuaConsumo: TRLPedirDuaConsumo;
  (*
  empresa_dac empresa, referencia_dac transito, dvd_dac dvd, fecha_entrada_dda_dac fecha_dda, dua_exporta_dac dua_exporta, ');
    SQL.Add('        fecha_dal fecha_consumo, ');
    SQL.Add('        cliente_dal cliente, nombre_c, domicilio_c, poblacion_c, cod_postal_c, pais_c, ');
    SQL.Add('        dir_sum_dal suministro, domicilio_ds, poblacion_ds, cod_postal_ds, provincia_ds, ');
    SQL.Add('        dua_consumo_dal dua_consumo, kilos_dal kilos_consumo, ');
    SQL.Add('        ( select sum(kilos_tl) from frf_transitos_l ');
    SQL.Add('          where empresa_tl = empresa_dac and centro_tl = centro_dac ');
    SQL.Add('          and fecha_tl = fecha_dac and referencia_tl = referencia_dac ) kilos_transito
  *)
procedure Previsualizar( const AEmpresa, ACentro: string;
                         const AFechainicio, AFechafin: TDateTime );
begin
  RLPedirDuaConsumo:= TRLPedirDuaConsumo.Create( nil );
  with RLPedirDuaConsumo do
  begin
    PonLogoGrupoBonnysa( RLPedirDuaConsumo, AEmpresa );
    lblPeriodo.Caption:= 'Del ' + DateToStr( AFechainicio ) + ' al ' + DateToStr( AFechafin ) + '.';
  end;
  try
    Preview( RLPedirDuaConsumo );
  except
    FreeAndNil( RLPedirDuaConsumo );
  end;
end;


procedure TRLPedirDuaConsumo.qrepais_cPrint(sender: TObject;
  var Value: String);
begin
  Value:= DesPais( Value );
end;

procedure TRLPedirDuaConsumo.qredes_puerto_tcPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('suministro').AsString = '' then
  begin
    Value:= Trim( DataSet.FieldByName('domicilio_c').AsString );
  end
  else
  begin
    Value:= Trim( DataSet.FieldByName('domicilio_ds').AsString );
  end;
end;

procedure TRLPedirDuaConsumo.qrenombre_cPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('suministro').AsString = '' then
  begin
    Value:= Trim( DataSet.FieldByName('poblacion_c').AsString );
    if DataSet.FieldByName('cod_postal_c').AsString <> '' then
    begin
      Value:= Value + ' [' + Trim( DataSet.FieldByName('cod_postal_c').AsString ) + ']';
    end;
  end
  else
  begin
    Value:= Trim( DataSet.FieldByName('poblacion_ds').AsString );
    if DataSet.FieldByName('cod_postal_ds').AsString <> '' then
    begin
      Value:= Value + ' [' + Trim( DataSet.FieldByName('cod_postal_ds').AsString  ) + ']';
    end;
    if DataSet.FieldByName('provincia_ds').AsString <> '' then
    begin
      Value:= Value + ' - ' +  Trim( DataSet.FieldByName('provincia_ds').AsString );
    end;
  end;
end;

procedure TRLPedirDuaConsumo.qrldua_consumo_izqPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('dua_consumo').AsString = '' then
    Value:= '['
  else
    Value:= '';
end;

procedure TRLPedirDuaConsumo.qrldua_consumo_derPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('dua_consumo').AsString = '' then
    Value:= ']'
  else
    Value:= '';
end;

procedure TRLPedirDuaConsumo.qrgCabTransitoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if bFlag then
     ForceNewPage
  else
    bFlag:= True;
end;

procedure TRLPedirDuaConsumo.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  bFlag:= False;
end;

end.
