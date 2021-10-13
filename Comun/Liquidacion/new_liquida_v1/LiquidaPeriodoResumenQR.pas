unit LiquidaPeriodoResumenQR;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables, grimgctrl;
type
  TQRLiquidaPeriodoResumen = class(TQuickRep)
    PageFooterBand1: TQRBand;
    qrbndBandaDetalle: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRSysData1: TQRSysData;
    QRBand1: TQRBand;
    PsQRLabel4: TQRLabel;
    PsQRSysData1: TQRSysData;
    QRLabel6: TQRLabel;
    qrdbtxtkilos_out1: TQRDBText;
    qrdbtxtkilos_out2: TQRDBText;
    qrdbtxtkilos_out3: TQRDBText;
    qrsbdtlCosecheros: TQRSubDetail;
    qrsbdtlPlantaciones: TQRSubDetail;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    qrdbtxtcosechero: TQRDBText;
    QRDBText9: TQRDBText;
    qrdbtxtcosechero1: TQRDBText;
    qrdbtxtcosechero2: TQRDBText;
    qrdbtxtcosechero3: TQRDBText;
    qrdbtxtcosechero4: TQRDBText;
    qrdbtxtcosteEnvase: TQRDBText;
    qrdbtxtcosteProduccion: TQRDBText;
    qrdbtxtcosteComercial: TQRDBText;
    qrdbtxtprecioLiquidar2: TQRDBText;
    qrdbtxtcosteSecciones1: TQRDBText;
    qrdbtxtpesoPrimera: TQRDBText;
    qrdbtxtpesoSegunda: TQRDBText;
    qrdbtxtpesoTercera: TQRDBText;
    qrdbtxtpesoDestrio: TQRDBText;
    qrdbtxtpesoPrimera1: TQRDBText;
    qrdbtxtpesoSegunda1: TQRDBText;
    qrdbtxtpesoTercera1: TQRDBText;
    qrdbtxtpesoDestrio1: TQRDBText;
    qrdbtxtpesoPrimera2: TQRDBText;
    qrdbtxtpesoSegunda2: TQRDBText;
    qrdbtxtpesoTercera2: TQRDBText;
    qrdbtxtpesoDestrio2: TQRDBText;
    qrdbtxtpesoPrimera3: TQRDBText;
    qrdbtxtpesoSegunda3: TQRDBText;
    qrdbtxtpesoTercera3: TQRDBText;
    qrdbtxtpesoDestrio3: TQRDBText;
    qrdbtxtpesoPrimera5: TQRDBText;
    qrdbtxtpesoSegunda5: TQRDBText;
    qrdbtxtpesoTercera5: TQRDBText;
    qrdbtxtpesoDestrio5: TQRDBText;
    qrdbtxtdescuentoPrimera: TQRDBText;
    qrdbtxtpesoSegunda6: TQRDBText;
    qrdbtxtpesoTercera6: TQRDBText;
    qrdbtxtpesoDestrio6: TQRDBText;
    qrdbtxtgastosFacPrimerapesoPrimera: TQRDBText;
    qrdbtxtpesoSegunda7: TQRDBText;
    qrdbtxtpesoTercera7: TQRDBText;
    qrdbtxtpesoDestrio7: TQRDBText;
    qrdbtxtgastosNoFacPrimera: TQRDBText;
    qrdbtxtpesoSegunda8: TQRDBText;
    qrdbtxtpesoTercera8: TQRDBText;
    qrdbtxtpesoDestrio8: TQRDBText;
    qrdbtxtgastosTranPrimera: TQRDBText;
    qrdbtxtpesoSegunda9: TQRDBText;
    qrdbtxtpesoTercera9: TQRDBText;
    qrdbtxtpesoDestrio9: TQRDBText;
    qrdbtxtpesoDestrio10: TQRDBText;
    qrdbtxtbrutoDestrio: TQRDBText;
    qrdbtxtdescuentoDestrio: TQRDBText;
    qrdbtxtgastosTranDestrio: TQRDBText;
    qrdbtxtcosteEnvaseDestrio: TQRDBText;
    qrdbtxtcosteSeccionesDestrio: TQRDBText;
    qrdbtxtnetoDestrio: TQRDBText;
    qrdbtxtprecioDestrio: TQRDBText;
    qrlbl16: TQRLabel;
    qrlbl17: TQRLabel;
    qrlbl19: TQRLabel;
    qrlbl20: TQRLabel;
    qrlbl21: TQRLabel;
    qrlbl22: TQRLabel;
    qrlbl23: TQRLabel;
    qrlbl24: TQRLabel;
    qrlbl26: TQRLabel;
    qrdbtxtkilos_pri1: TQRDBText;
    qrdbtxtkilos_des1: TQRDBText;
    qrdbtxtkilos_ter1: TQRDBText;
    qrdbtxtkilos_seg1: TQRDBText;
    qrdbtxtkilos_des2: TQRDBText;
    qrdbtxtkilos_mer1: TQRDBText;
    qrdbtxtkilos_ini_primera: TQRDBText;
    qrdbtxtkilos_ini_destrio: TQRDBText;
    qrdbtxtkilos_ini_tercera: TQRDBText;
    qrdbtxtkilos_ini_segunda: TQRDBText;
    qrdbtxtkilos_ini: TQRDBText;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl31: TQRLabel;
    qrdbtxtkilos_fin_primera: TQRDBText;
    qrdbtxtkilos_fin_segunda: TQRDBText;
    qrdbtxtkilos_fin_tercera: TQRDBText;
    qrdbtxtkilos_fin_destrio: TQRDBText;
    qrdbtxtkilos_fin: TQRDBText;
    qrlbl32: TQRLabel;
    qrdbtxtkilos_fin_primera1: TQRDBText;
    qrdbtxtkilos_fin_segunda1: TQRDBText;
    qrdbtxtkilos_fin_tercera1: TQRDBText;
    qrdbtxtkilos_fin_destrio1: TQRDBText;
    qrdbtxtkilos_fin1: TQRDBText;
    qrdbtxtkilos_primera: TQRDBText;
    qrdbtxtkilos_segunda: TQRDBText;
    qrdbtxtkilos_tercera: TQRDBText;
    qrdbtxtkilos_destrio: TQRDBText;
    qrdbtxtkilos_total: TQRDBText;
    qrlbl33: TQRLabel;
    qrdbtxtkilos_pri2: TQRDBText;
    qrdbtxtkilos_seg2: TQRDBText;
    qrdbtxtkilos_ter2: TQRDBText;
    qrdbtxtkilos_des3: TQRDBText;
    qrdbtxtkilos_mer2: TQRDBText;
    qrdbtxtkilos_ini_pri: TQRDBText;
    qrdbtxtkilos_ini_seg: TQRDBText;
    qrdbtxtkilos_ini_ter: TQRDBText;
    qrdbtxtkilos_ini_des: TQRDBText;
    qrdbtxtkilos_ini1: TQRDBText;
    qrdbtxtkilos_fin_pri: TQRDBText;
    qrdbtxtkilos_fin_seg: TQRDBText;
    qrdbtxtkilos_fin_ter: TQRDBText;
    qrdbtxtkilos_fin_des: TQRDBText;
    qrdbtxtkilos_fin2: TQRDBText;
    qrlbl15: TQRLabel;
    qrdbtxtproducto: TQRDBText;
    qrdbtxtfecha_ini: TQRDBText;
    qrdbtxtfecha_fin: TQRDBText;
    qrlbl25: TQRLabel;
    qrdbtxtprecio_Pri: TQRDBText;
    qrdbtxtprecio_Seg: TQRDBText;
    qrdbtxtprecio_Ter: TQRDBText;
    qrdbtxtprecio_Des: TQRDBText;
    qrdbtxtprecio_Sal: TQRDBText;
    qrdbtxtkilos_pri3: TQRDBText;
    qrdbtxtkilos_seg3: TQRDBText;
    qrdbtxtkilos_ter3: TQRDBText;
    qrdbtxtkilos_des4: TQRDBText;
    qrdbtxtkilos_total1: TQRDBText;
    qrdbtxtimporte_pri: TQRDBText;
    qrdbtxtimporte_seg: TQRDBText;
    qrdbtxtimporte_ter: TQRDBText;
    qrdbtxtimporte_des: TQRDBText;
    qrdbtxtimporte_total: TQRDBText;
    qrdbtxtkilos_mer3: TQRDBText;
    qrbndResumenCos: TQRBand;
    qrdbtxtkilos_pri: TQRDBText;
    qrdbtxtkilos_seg: TQRDBText;
    qrdbtxtkilos_ter: TQRDBText;
    qrdbtxtkilos_des: TQRDBText;
    qrdbtxtkilos_mer: TQRDBText;
    qrdbtxtkilos_mer4: TQRDBText;
    qrdbtxtcosechero5: TQRDBText;
    qrdbtxtkilos_pri4: TQRDBText;
    qrdbtxtkilos_seg4: TQRDBText;
    qrdbtxtkilos_ter4: TQRDBText;
    qrdbtxtkilos_des5: TQRDBText;
    qrdbtxtkilos_total2: TQRDBText;
    QRGroup1: TQRGroup;
    qrbndPieHoja: TQRBand;
    qrlbl34: TQRLabel;
    qrlbl35: TQRLabel;
    qrlbl27: TQRLabel;
    qrlbl28: TQRLabel;
    qrlbl29: TQRLabel;
    qrlbl30: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl36: TQRLabel;
    qrdbtxtneto_fin_pri: TQRDBText;
    qrdbtxtneto_fin_seg: TQRDBText;
    qrdbtxtneto_fin_ter: TQRDBText;
    qrdbtxtneto_fin_des: TQRDBText;
    qrdbtxtneto_fin: TQRDBText;
    qrlbl37: TQRLabel;
    qrlbl38: TQRLabel;
    qrlbl39: TQRLabel;
    qrlbl18: TQRLabel;
    qrlbl40: TQRLabel;
    qrlbl41: TQRLabel;
    qrdbtxtgastosTran_Pri: TQRDBText;
    qrdbtxtgastosTran_Seg: TQRDBText;
    qrdbtxtgastosTran_Ter: TQRDBText;
    qrdbtxtgastosTran_Des: TQRDBText;
    qrdbtxtgastosTran_Sal: TQRDBText;
    qrlbl42: TQRLabel;
    qrdbtxtkilos_pri5: TQRDBText;
    qrdbtxtkilos_seg5: TQRDBText;
    qrdbtxtkilos_ter5: TQRDBText;
    qrdbtxtkilos_des6: TQRDBText;
    qrdbtxtkilos_ent_campo: TQRDBText;
    qrdbtxtkilos_pri6: TQRDBText;
    qrdbtxtkilos_seg6: TQRDBText;
    qrdbtxtkilos_ter6: TQRDBText;
    qrdbtxtkilos_des7: TQRDBText;
    qrdbtxtkilos_ent_campo1: TQRDBText;
    qrlbl1: TQRLabel;
    qrdbtxtkilos_pri7: TQRDBText;
    qrdbtxtkilos_seg7: TQRDBText;
    qrdbtxtkilos_ter7: TQRDBText;
    qrdbtxtkilos_des8: TQRDBText;
    qrdbtxtkilos_ent_campo2: TQRDBText;
    qrlbl5: TQRLabel;
    qrdbtxtkilos_mer6: TQRDBText;
    procedure qrdbtxtkilos_out1Print(sender: TObject; var Value: String);
    procedure qrdbtxtkilos_out2Print(sender: TObject; var Value: String);
    procedure qrdbtxtkilos_out3Print(sender: TObject; var Value: String);
    procedure QRDBText9Print(sender: TObject; var Value: String);
    procedure qrdbtxtcosechero2Print(sender: TObject; var Value: String);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public

  end;

  procedure Imprimir;

implementation

uses
  LiquidaPeriodoDM, UDMAuxDB, DPreview;

{$R *.DFM}

(*

*)



procedure Imprimir;
var
  QRLiquidaPeriodoResumen: TQRLiquidaPeriodoResumen;
begin
  QRLiquidaPeriodoResumen:= TQRLiquidaPeriodoResumen.Create( nil );
  try
  
    LiquidaPeriodoDM.DMLiquidaPeriodo.kmtSemana.SortFields:='keysem';
    LiquidaPeriodoDM.DMLiquidaPeriodo.kmtSemana.Sort([]);
    LiquidaPeriodoDM.DMLiquidaPeriodo.kmtCosechero.IndexFieldNames:= 'keySem;cosechero';
    LiquidaPeriodoDM.DMLiquidaPeriodo.kmtCosechero.Sort([]);
    LiquidaPeriodoDM.DMLiquidaPeriodo.kmtPlantacion.IndexFieldNames:= 'keySem;cosechero;plantacion;semana_planta';
    LiquidaPeriodoDM.DMLiquidaPeriodo.kmtPlantacion.Sort([]);

    Preview( QRLiquidaPeriodoResumen );
  except
    FreeAndNil( QRLiquidaPeriodoResumen );
  end;
end;

procedure TQRLiquidaPeriodoResumen.qrdbtxtkilos_out1Print(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - '  + desEmpresa( Value );
end;

procedure TQRLiquidaPeriodoResumen.qrdbtxtkilos_out2Print(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - '  + descentro( DataSet.FieldByName('empresa').AsString, Value );
end;
        procedure TQRLiquidaPeriodoResumen.qrdbtxtkilos_out3Print(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - '  + desProducto( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRLiquidaPeriodoResumen.QRDBText9Print(sender: TObject;
  var Value: String);
begin
  Value:= desCosechero( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRLiquidaPeriodoResumen.qrdbtxtcosechero2Print(sender: TObject;
  var Value: String);
begin
  Value:= desPlantacion( DataSet.FieldByName('empresa').AsString,
                         DataSet.FieldByName('producto').AsString,
                         qrsbdtlPlantaciones.DataSet.FieldByName('cosechero').AsString,
                         qrsbdtlPlantaciones.DataSet.FieldByName('plantacion').AsString,
                         Value );
end;

procedure TQRLiquidaPeriodoResumen.QRGroup1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  Sender.Height:= 0;
end;

end.
