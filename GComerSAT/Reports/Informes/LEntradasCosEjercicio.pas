unit LEntradasCosEjercicio;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQRLEntradasCosEjercicio = class(TQuickRep)
    QRBCabecera: TQRBand;
    QRBDetalle: TQRBand;
    QRBSumario: TQRBand;
    QRBCentro: TQRGroup;
    QRBPieGrupo: TQRBand;
    QRLabel6: TQRLabel;
    QRLCosechero: TQRLabel;
    QRLKilos: TQRLabel;
    QRLCajas: TQRLabel;
    QRLAcumulado: TQRLabel;
    QRLKilos_Has: TQRLabel;
    QRLKilos_plt: TQRLabel;
    QRDBTPlantacion: TQRDBText;
    QRDBTCajas: TQRDBText;
    QRDBTKilos: TQRDBText;
    QRDBTAcumulado: TQRDBText;
    QRLTotalParcial: TQRLabel;
    QRBTitulo: TQRBand;
    QRLabel1: TQRLabel;
    QRLDesde: TQRLabel;
    QRLHasta: TQRLabel;
    PsQRShape1: TQRShape;
    PsQRShape2: TQRShape;
    PsQRShape3: TQRShape;
    PsQRShape4: TQRShape;
    PsQRShape5: TQRShape;
    QListado: TQuery;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText4: TQRDBText;
    PsQRExpr1: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRExpr3: TQRExpr;
    PsQRExpr6: TQRExpr;
    PsQRExpr7: TQRExpr;
    PsQRExpr8: TQRExpr;
    LKilosHas: TQRLabel;
    LKilosPlt: TQRLabel;
    LTotKilosHas: TQRLabel;
    LTotKilosPlt: TQRLabel;
    PageFooterBand1: TQRBand;
    PsQRSysData1: TQRSysData;
    PsQRLabel2: TQRLabel;
    lblProducto: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRSysData1: TQRSysData;
    QRBGrupo: TQRGroup;
    qrgrp1: TQRGroup;
    QRDBTCosechero: TQRDBText;
    PsQRDBText3: TQRDBText;
    qrdbtxtproducto1: TQRDBText;
    qrdbtxtproducto: TQRDBText;
    qrlCentro: TQRLabel;
    qrdbCentro: TQRDBText;
    qrPieCentro: TQRBand;
    qrl1: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    LKilosCenHas: TQRLabel;
    LKilosCenPlt: TQRLabel;
    procedure QRLEntradasCosBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRExpr8Print(sender: TObject; var Value: string);
    procedure LKilosHasPrint(sender: TObject; var Value: string);
    procedure LKilosPltPrint(sender: TObject; var Value: string);
    procedure LTotKilosPltPrint(sender: TObject; var Value: string);
    procedure LTotKilosHasPrint(sender: TObject; var Value: string);
    procedure PsQRExpr3Print(sender: TObject; var Value: string);
    procedure QRDBTPlantacionPrint(sender: TObject; var Value: string);
    procedure QRBPieGrupoAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure qrdbtxtproductooldPrint(sender: TObject; var Value: String);
    procedure qrdbCentroPrint(sender: TObject; var Value: string);
    procedure qrPieCentroAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure LKilosCenHasPrint(sender: TObject; var Value: string);
    procedure LKilosCenPltPrint(sender: TObject; var Value: string);
    procedure QRExpr3Print(sender: TObject; var Value: string);
  private

  public
    sEmpresa: string;
    kilos, plantas, kilos_cen, plantas_cen, tot_kilos, tot_plantas: integer;
    has, has_cen, tot_has: real;
  end;

var
  QRLEntradasCosEjercicio: TQRLEntradasCosEjercicio;
implementation

uses LEntregasCosechero, UDMAuxDB;

{$R *.DFM}

//****************************** QuickReport **********************************
//Antes de imprimir inicializo las variables

procedure TQRLEntradasCosEjercicio.QRExpr3Print(sender: TObject;
  var Value: string);
begin
  kilos_cen := Trunc(StrToFloat(value));
  Value := FormatFloat('#,##0', kilos_cen);
end;

procedure TQRLEntradasCosEjercicio.QRLEntradasCosBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  kilos := 0;
  has := 0;
  plantas := 0;
  kilos_cen := 0;
  has_cen := 0;
  plantas_cen := 0;
  tot_kilos := 0;
  tot_has := 0;
  tot_plantas := 0;
end;


procedure TQRLEntradasCosEjercicio.qrPieCentroAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  kilos_cen := 0;
  has_cen := 0;
  plantas_cen := 0;
end;

//****************************** Banda de detalle ******************************
//Acumulo el total de plantas y de hectareas por plantacion cada vez que se imprime la banda detalle

procedure TQRLEntradasCosEjercicio.QRBDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  has := has + QListado.FieldByName('has').AsFloat;
  plantas := plantas + QListado.FieldByName('plantas').AsInteger;
  has_cen := has_cen + QListado.FieldByName('has').AsFloat;
  plantas_cen := plantas_cen + QListado.FieldByName('plantas').AsInteger;
  tot_has := tot_has + QListado.FieldByName('has').AsFloat;
  tot_plantas := tot_plantas + QListado.FieldByName('plantas').AsInteger;
end;

//************************* Banda de pie de grupo ******************************
//Guardo el acumulado de kilos para luego hallar el total kilos por superficie y por plantas

procedure TQRLEntradasCosEjercicio.PsQRExpr3Print(sender: TObject;
  var Value: string);
begin
  kilos := Trunc(StrToFloat(value));
  Value := FormatFloat('#,##0', kilos);
end;

//Se calcula los kilos por hectarea de las plantaciones por cosechero

procedure TQRLEntradasCosEjercicio.LKilosCenHasPrint(sender: TObject;
  var Value: string);
begin
  if Has_cen <> 0 then
    Value := FormatFloat('#, ##0.0', (kilos_cen / has_cen))
  else
    Value := '0,0';
end;

procedure TQRLEntradasCosEjercicio.LKilosCenPltPrint(sender: TObject;
  var Value: string);
begin
  if plantas_cen <> 0 then
    Value := FormatFloat('#, ##0.000', (kilos_cen / plantas_cen))
  else
    Value := '0,000';
end;

procedure TQRLEntradasCosEjercicio.LKilosHasPrint(sender: TObject;
  var Value: string);
begin
  if Has <> 0 then
    Value := FormatFloat('#, ##0.0', (kilos / has))
  else
    Value := '0,0';
end;

//Se calcula los kilos por planta de las plantaciones por cosechero

procedure TQRLEntradasCosEjercicio.LKilosPltPrint(sender: TObject;
  var Value: string);
begin
  if plantas <> 0 then
    Value := FormatFloat('#, ##0.000', (kilos / plantas))
  else
    Value := '0,000';
end;

//**************************** Banda de sumario ********************************

procedure TQRLEntradasCosEjercicio.PsQRExpr8Print(sender: TObject;
  var Value: string);
begin
  tot_kilos := Trunc(StrToFloat(value));
  Value := FormatFloat('#,##0', tot_kilos);
end;

procedure TQRLEntradasCosEjercicio.LTotKilosHasPrint(sender: TObject;
  var Value: string);
begin
  if tot_has <> 0 then
    Value := FormatFloat('#, ##0.0', (tot_kilos / tot_has))
  else
    Value := 'FALTA';
end;

procedure TQRLEntradasCosEjercicio.LTotKilosPltPrint(sender: TObject;
  var Value: string);
begin
  if tot_plantas <> 0 then
    Value := FormatFloat('#, ##0.000', (tot_kilos / tot_plantas))
  else
    Value := 'FALTA';
end;


procedure TQRLEntradasCosEjercicio.QRDBTPlantacionPrint(sender: TObject;
  var Value: string);
begin
  Value := '[' + QListado.FieldByName('ano_semana').asstring + '] ' + Value;
end;

procedure TQRLEntradasCosEjercicio.QRBPieGrupoAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  kilos := 0;
  has := 0;
  plantas := 0;
end;

procedure TQRLEntradasCosEjercicio.qrdbCentroPrint(sender: TObject;
  var Value: string);
begin
  Value:= Value + ' - ' + desCentro(sEmpresa, Value);
end;

procedure TQRLEntradasCosEjercicio.qrdbtxtproductooldPrint(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( sEmpresa, Value );
end;

end.
