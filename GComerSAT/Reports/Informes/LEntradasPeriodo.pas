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
    QRDBText9: TQRDBText;
    LSubTotal: TQRLabel;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
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
    PsQRDBText3: TQRDBText;
    PsQRLabel1: TQRLabel;
    LTitulo: TQRLabel;
    LProducto: TQRLabel;
    LCentro: TQRLabel;
    LPeriodo: TQRLabel;
    LSemana: TQRLabel;
    LCampo: TQRLabel;
    QRBand2: TQRBand;
    msgTipoAcumulado: TQRLabel;
    LCosecheros: TQRLabel;
    LPlantaciones: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    qrgrpProducto: TQRGroup;
    qrlbl1: TQRLabel;
    qrdbtxt1: TQRDBText;
    QRDBAgrupar2: TQRDBText;
    qrdbtxtproducto: TQRDBText;
    qrdbtxtproducto1: TQRDBText;
    qrbndPieProducto: TQRBand;
    QRLabel1: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrdbtxtcos: TQRDBText;
    qrdbtxtpla: TQRDBText;
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
    procedure PsQRExpr10Print(sender: TObject; var Value: string);
    procedure PsQRExpr11Print(sender: TObject; var Value: string);
    procedure PsQRExpr13Print(sender: TObject; var Value: string);
    procedure PsQRExpr14Print(sender: TObject; var Value: string);
    procedure qrdbtxt1Print(sender: TObject; var Value: String);
    procedure QRDBAgrupar2Print(sender: TObject; var Value: String);
    procedure qrdbtxtproductoPrint(sender: TObject; var Value: String);
    procedure qrgrpProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndPieProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndPieProductoAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRExpr6Print(sender: TObject; var Value: String);
    procedure QRExpr7Print(sender: TObject; var Value: String);
    procedure QRExpr9Print(sender: TObject; var Value: String);
    procedure QRExpr10Print(sender: TObject; var Value: String);
    procedure QRLabel1Print(sender: TObject; var Value: String);
    procedure qrdbtxtproducto1Print(sender: TObject; var Value: String);
    procedure qrdbtxtcosPrint(sender: TObject; var Value: String);
    procedure qrdbtxtplaPrint(sender: TObject; var Value: String);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
   // provincia: string;
    kilos, kilos_p, kilos_tot: Real;
    kilos_acu, kilos_acu_p, kilos_acu_tot: Real;
    has, has_p, has_tot: real;
    plt, plt_p, plt_tot: real;

  public
    bSoloUnProducto: Boolean;

  end;

var
  QRLEntradasPeriodo: TQRLEntradasPeriodo;

implementation

{$R *.DFM}

uses UDMAuxDB, UDMBaseDatos;

procedure TQRLEntradasPeriodo.QRLEntradasPeriodoBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
     //**********
    kilos := 0;
    kilos_p := 0;
    kilos_tot := 0;
    kilos_acu := 0;
    kilos_acu_p := 0;
    kilos_acu_tot := 0;
    has := 0;
    has_p := 0;
    has_tot := 0;
    plt := 0;
    plt_p := 0;
    plt_tot := 0;


  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) and not bSoloUnProducto then
  begin
    LTitulo.Alignment:= taLeftJustify;
    LTitulo.AlignToBand:= False;
    LTitulo.Left:= 5;

    LProducto.Alignment:= taLeftJustify;
    LProducto.AlignToBand:= False;
    LProducto.Left:= 5;

    LCentro.Alignment:= taLeftJustify;
    LCentro.AlignToBand:= False;
    LCentro.Left:= 5;
  end
  else
  begin
    LTitulo.Alignment:= taCenter;
    LTitulo.AlignToBand:= True;

    LProducto.Alignment:= taCenter;
    LProducto.AlignToBand:= True;

    LCentro.Alignment:= taCenter;
    LCentro.AlignToBand:= True;
  end;
end;


//coger el nombre de la plantacion

procedure TQRLEntradasPeriodo.QRDBText2Print(sender: TObject;
  var Value: string);
begin
end;

//*********************  BANDA PIE DE GRUPO  **********************************
//hago el acumulado de los kilos de cada linea a mano

procedure TQRLEntradasPeriodo.QRDBText8Print(sender: TObject;
  var Value: string);
begin
end;

//hago el acumulado de los kilos de cada linea a mano

procedure TQRLEntradasPeriodo.QRDBText9Print(sender: TObject;
  var Value: string);
begin
end;

//suma de las hectareas

procedure TQRLEntradasPeriodo.QRExpr3Print(sender: TObject;
  var Value: string);
begin
end;

//suma de las plantas

procedure TQRLEntradasPeriodo.QRExpr4Print(sender: TObject;
  var Value: string);
begin
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
  kilos := 0;
  kilos_acu := 0;
end;

//****************************  BANDA SUMARIO  ********************************

procedure TQRLEntradasPeriodo.PsQRExpr10Print(sender: TObject;
  var Value: string);
begin
  if has_tot = 0 then
    Value := '0,0'
  else
    Value := FormatFloat('#,##0.0', (kilos_tot / has_tot));
end;

procedure TQRLEntradasPeriodo.PsQRExpr11Print(sender: TObject;
  var Value: string);
begin
  if plt_tot = 0 then
    Value := '0,000'
  else
    Value := FormatFloat('#,##0.000', (Kilos_tot / plt_tot));
end;

procedure TQRLEntradasPeriodo.PsQRExpr13Print(sender: TObject;
  var Value: string);
begin
  if has_tot = 0 then
    Value := '0,0'
  else
    Value := FormatFloat('#,##0.0', (kilos_acu_tot / has_tot));
end;

procedure TQRLEntradasPeriodo.PsQRExpr14Print(sender: TObject;
  var Value: string);
begin
  if plt_tot = 0 then
    Value := '0,000'
  else
    Value := FormatFloat('#,##0.000', (kilos_acu_tot / plt_tot));
end;

procedure TQRLEntradasPeriodo.qrdbtxt1Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProducto( DMBaseDatos.QListado.FieldByname('empresa').AsString, Value );
end;

procedure TQRLEntradasPeriodo.QRDBAgrupar2Print(sender: TObject;
  var Value: String);
begin
  if  not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end;
end;

procedure TQRLEntradasPeriodo.qrdbtxtproductoPrint(sender: TObject;
  var Value: String);
begin
  if Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) then
  begin
    Value:= desProducto( DMBaseDatos.QListado.FieldByname('empresa').AsString, Value );
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQRLEntradasPeriodo.qrgrpProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) and not bSoloUnProducto;
end;

procedure TQRLEntradasPeriodo.BGrupoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRLEntradasPeriodo.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRLEntradasPeriodo.qrbndPieProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) and not bSoloUnProducto;;
end;

procedure TQRLEntradasPeriodo.qrbndPieProductoAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  plt_p := 0;
  has_p := 0;
  kilos_p := 0;
  kilos_acu_p := 0;
end;

procedure TQRLEntradasPeriodo.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
    kilos := kilos + DMBaseDatos.QListado.FieldByname('kilos_per').AsFloat;
    kilos_p := kilos_p + DMBaseDatos.QListado.FieldByname('kilos_per').AsFloat;
    kilos_tot := kilos_tot + DMBaseDatos.QListado.FieldByname('kilos_per').AsFloat;
    kilos_acu := kilos_acu + DMBaseDatos.QListado.FieldByname('kilos_acu').AsFloat;
    kilos_acu_p := kilos_acu_p + DMBaseDatos.QListado.FieldByname('kilos_acu').AsFloat;
    kilos_acu_tot := kilos_acu_tot + DMBaseDatos.QListado.FieldByname('kilos_acu').AsFloat;
    has := has + DMBaseDatos.QListado.FieldByname('has').AsFloat;
    has_p := has_p + DMBaseDatos.QListado.FieldByname('has').AsFloat;
    has_tot := has_tot + DMBaseDatos.QListado.FieldByname('has').AsFloat;
    plt := plt + DMBaseDatos.QListado.FieldByname('plantas').AsFloat;
    plt_p := plt_p + DMBaseDatos.QListado.FieldByname('plantas').AsFloat;
    plt_tot := plt_tot + DMBaseDatos.QListado.FieldByname('plantas').AsFloat;
end;

procedure TQRLEntradasPeriodo.SummaryBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  plt_tot := 0;
  has_tot := 0;
  kilos_tot := 0;
  kilos_acu_tot := 0;
end;

procedure TQRLEntradasPeriodo.QRExpr6Print(sender: TObject;
  var Value: String);
begin
  if has_p = 0 then
    Value := '0,0'
  else
    Value := FormatFloat('#,##0.0', (kilos_p / has_p));
end;

procedure TQRLEntradasPeriodo.QRExpr7Print(sender: TObject;
  var Value: String);
begin
  if plt_p = 0 then
    Value := '0,000'
  else
    Value := FormatFloat('#,##0.000', (kilos_p / plt_p));
end;

procedure TQRLEntradasPeriodo.QRExpr9Print(sender: TObject;
  var Value: String);
begin
  if has_p = 0 then
    Value := '0,0'
  else
    Value := FormatFloat('#,##0.0', (kilos_acu_p / has_p));
end;

procedure TQRLEntradasPeriodo.QRExpr10Print(sender: TObject;
  var Value: String);
begin
  if plt_p = 0 then
    Value := '0,000'
  else
    Value := FormatFloat('#,##0.000', (kilos_acu_p / plt_p));
end;

procedure TQRLEntradasPeriodo.QRLabel1Print(sender: TObject;
  var Value: String);
begin
  Value:= 'PRODUCTO - ' + DMBaseDatos.QListado.fieldByName('producto').AsString + ':';
end;

procedure TQRLEntradasPeriodo.qrdbtxtproducto1Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end;
end;

procedure TQRLEntradasPeriodo.qrdbtxtcosPrint(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end;
end;

procedure TQRLEntradasPeriodo.qrdbtxtplaPrint(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end;
end;

procedure TQRLEntradasPeriodo.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) and not bSoloUnProducto;;
end;

procedure TQRLEntradasPeriodo.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) and not bSoloUnProducto;;
end;

end.
