unit LEntradasPeriodo;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQRLEntradasPeriodo = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    BGrupo: TQRGroup;
    QRBand1: TQRBand;
    QRLabel6: TQRLabel;
    QRLPlantas: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLKgsPlantas: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRDBAgrupar: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    LSubTotal: TQRLabel;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRExpr1: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRExpr3: TQRExpr;
    PsQRExpr4: TQRExpr;
    PsQRExpr5: TQRExpr;
    PsQRExpr6: TQRExpr;
    PsQRExpr7: TQRExpr;
    PsQRExpr8: TQRExpr;
    PsQRExpr9: TQRExpr;
    PsQRExpr10: TQRExpr;
    PsQRExpr11: TQRExpr;
    PsQRExpr12: TQRExpr;
    PsQRExpr13: TQRExpr;
    PsQRExpr14: TQRExpr;
    QListado: TQuery;
    PsQRDBText3: TQRDBText;
    PsQRDBText4: TQRDBText;
    PsQRLabel1: TQRLabel;
    LTitulo: TQRLabel;
    LProducto: TQRLabel;
    LCentro: TQRLabel;
    LPeriodo: TQRLabel;
    LSemana: TQRLabel;
    LCampo: TQRLabel;
    PsQRLabel2: TQRLabel;
    QRBand2: TQRBand;
    msgTipoAcumulado: TQRLabel;
    LCosecheros: TQRLabel;
    LPlantaciones: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    procedure QRLEntradasPeriodoBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRDBText8Print(sender: TObject; var Value: string);
    procedure QRDBText9Print(sender: TObject; var Value: string);
    procedure QRDBText2Print(sender: TObject; var Value: string);
    procedure PsQRExpr2Print(sender: TObject; var Value: string);
    procedure QRExpr3Print(sender: TObject; var Value: string);
    procedure QRExpr4Print(sender: TObject; var Value: string);
    procedure PsQRExpr3Print(sender: TObject; var Value: string);
    procedure PsQRExpr5Print(sender: TObject; var Value: string);
    procedure PsQRExpr6Print(sender: TObject; var Value: string);
    procedure QRBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure PsQRExpr7Print(sender: TObject; var Value: string);
    procedure PsQRExpr8Print(sender: TObject; var Value: string);
    procedure PsQRExpr10Print(sender: TObject; var Value: string);
    procedure PsQRExpr11Print(sender: TObject; var Value: string);
    procedure PsQRExpr13Print(sender: TObject; var Value: string);
    procedure PsQRExpr14Print(sender: TObject; var Value: string);
  private
   // provincia: string;
    kilos, kilos_acu, has, plt: real;
    kilos_tot, kilos_tot_acu: real;
    planta: string;

  public

  end;

var
  QRLEntradasPeriodo: TQRLEntradasPeriodo;

implementation

{$R *.DFM}

procedure TQRLEntradasPeriodo.QRLEntradasPeriodoBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
     //**********
  kilos := 0;
  kilos_acu := 0;
  planta := '';
  has := 0;
  plt := 0;
  kilos_tot := 0;
  kilos_tot_acu := 0;
end;


//coger el nombre de la plantacion

procedure TQRLEntradasPeriodo.QRDBText2Print(sender: TObject;
  var Value: string);
begin
  planta := Value;
end;

//*********************  BANDA PIE DE GRUPO  **********************************
//hago el acumulado de los kilos de cada linea a mano

procedure TQRLEntradasPeriodo.QRDBText8Print(sender: TObject;
  var Value: string);
begin
  if planta <> 'FONDO CHERRY II' then
  begin
    kilos := kilos + StrToFloat(Value);
  end;
  Value := FormatFloat('#,##0', StrToFloat(Value));
end;

//hago el acumulado de los kilos de cada linea a mano

procedure TQRLEntradasPeriodo.QRDBText9Print(sender: TObject;
  var Value: string);
begin
  if planta <> 'FONDO CHERRY II' then
  begin
    kilos_acu := kilos_acu + StrToFloat(Value);
  end;
  Value := FormatFloat('#,##0', StrToFloat(Value))

end;

//suma de las hectareas

procedure TQRLEntradasPeriodo.QRExpr3Print(sender: TObject;
  var Value: string);
begin
  has := StrToFloat(Value);
  Value := FormatFloat('#,##0.00', StrToFloat(Value));
end;

//suma de las plantas

procedure TQRLEntradasPeriodo.QRExpr4Print(sender: TObject;
  var Value: string);
begin
  plt := StrToFloat(Value);
  Value := FormatFloat('#,##0', StrToFloat(Value));
end;

//promedio de los kilos por hectarea

procedure TQRLEntradasPeriodo.PsQRExpr2Print(sender: TObject;
  var Value: string);
begin
  if has = 0 then
    Value := '0,0'
  else
    Value := FormatFloat('#,##0.0', (kilos / has));
end;

//promedio de los kilos por plantas

procedure TQRLEntradasPeriodo.PsQRExpr3Print(sender: TObject;
  var Value: string);
begin
  if plt = 0 then
    Value := '0,000'
  else
    Value := FormatFloat('#,##0.000', (kilos / plt));
end;

//promedio de kilos acumulado por has

procedure TQRLEntradasPeriodo.PsQRExpr5Print(sender: TObject;
  var Value: string);
begin
  if has = 0 then
    Value := '0,0'
  else
    Value := FormatFloat('#,##0.0', (kilos_acu / has));
end;

//promedio de kilos acumulado por plantas

procedure TQRLEntradasPeriodo.PsQRExpr6Print(sender: TObject;
  var Value: string);
begin
  if plt = 0 then
    Value := '0,000'
  else
    Value := FormatFloat('#,##0.000', (kilos_acu / plt));
end;

procedure TQRLEntradasPeriodo.QRBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  plt := 0;
  has := 0;
  kilos_tot := kilos_tot + kilos;
  kilos := 0;
  kilos_tot_acu := kilos_tot_acu + kilos_acu;
  kilos_acu := 0;
end;

//****************************  BANDA SUMARIO  ********************************

procedure TQRLEntradasPeriodo.PsQRExpr7Print(sender: TObject;
  var Value: string);
begin
  has := StrToFloat(Value);
  Value := FormatFloat('#,##0.00', StrToFloat(Value));
end;

procedure TQRLEntradasPeriodo.PsQRExpr8Print(sender: TObject;
  var Value: string);
begin
  plt := StrToFloat(Value);
  Value := FormatFloat('#,##0', StrToFloat(Value));
end;

procedure TQRLEntradasPeriodo.PsQRExpr10Print(sender: TObject;
  var Value: string);
begin
  if has = 0 then
    Value := '0,0'
  else
    Value := FormatFloat('#,##0.0', (kilos_tot / has));
end;

procedure TQRLEntradasPeriodo.PsQRExpr11Print(sender: TObject;
  var Value: string);
begin
  if plt = 0 then
    Value := '0,000'
  else
    Value := FormatFloat('#,##0.000', (Kilos_tot / plt));
end;

procedure TQRLEntradasPeriodo.PsQRExpr13Print(sender: TObject;
  var Value: string);
begin
  if has = 0 then
    Value := '0,0'
  else
    Value := FormatFloat('#,##0.0', (kilos_tot_acu / has));
end;

procedure TQRLEntradasPeriodo.PsQRExpr14Print(sender: TObject;
  var Value: string);
begin
  if plt = 0 then
    Value := '0,000'
  else
    Value := FormatFloat('#,##0.000', (kilos_tot_acu / plt));
end;

end.
