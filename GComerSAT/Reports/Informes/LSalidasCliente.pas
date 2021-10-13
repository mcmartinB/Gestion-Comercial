unit LSalidasCliente;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables, grimgctrl;

type
  TQRLSalidasCliente = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    LPeriodo: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText4: TQRDBText;
    PsQRDBText5: TQRDBText;
    PsQRDBText6: TQRDBText;
    PsQRDBText7: TQRDBText;
    PsQRDBText8: TQRDBText;
    PsQRDBText9: TQRDBText;
    PsQRDBText10: TQRDBText;
    LCliente: TQRLabel;
    LSeparador: TQRLabel;
    QListado: TQuery;
    BSumario: TQRBand;
    PsQRLabel9: TQRLabel;
    Memo: TQRMemo;
    bndProducto: TQRChildBand;
    LProducto: TQRLabel;
    LEnvase: TQRLabel;
    bndGroupCliente: TQRGroup;
    cliente_sal_sc: TQRDBText;
    qrlImporte: TQRLabel;
    qreImporte: TQRDBText;
    qrlPrecioKg: TQRLabel;
    qrlPrecioCaj: TQRLabel;
    qrePrecioKg: TQRLabel;
    qrePrecioCaj: TQRLabel;
    qrbndPieCliente: TQRBand;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrgrpProducto: TQRGroup;
    qrbndPieProducto: TQRBand;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrdbtxtproducto_sl: TQRDBText;
    qrpdfshp1: TQRPDFShape;
    qrdbtxtproducto_sl1: TQRDBText;
    qrshp1: TQRShape;
    qrlblFecha: TQRLabel;
    qrlblImporte: TQRLabel;
    qrlblDesImporte: TQRLabel;
    procedure PsQRDBText2Print(sender: TObject; var Value: string);
    procedure QRLSalidasClienteBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure PsQRDBText1Print(sender: TObject; var Value: string);
    procedure PsQRDBText4Print(sender: TObject; var Value: string);
    procedure QRLSalidasClienteStartPage(Sender: TCustomQuickRep);
    procedure PsQRDBText9Print(sender: TObject; var Value: string);
    procedure PsQRDBText10Print(sender: TObject; var Value: string);
    procedure BSumarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRDBText7Print(sender: TObject; var Value: String);
    procedure cliente_sal_scPrint(sender: TObject; var Value: String);
    procedure qreImportePrint(sender: TObject; var Value: String);
    procedure qrgrpProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtproducto_slPrint(sender: TObject; var Value: String);
    procedure qrdbtxtproducto_sl1Print(sender: TObject; var Value: String);
    procedure qrxpr6Print(sender: TObject; var Value: String);
    procedure qrxpr3Print(sender: TObject; var Value: String);
  private
    albaran: string;
    fecha, dir: boolean;
    cajas, kilos, importes: TStringList;
    faltaCajas, faltaKilos, faltaImportes: boolean;
    rTotalProducto, rTotalCliente, rTotal: Real;

  public
    imprimido: Boolean;
    bValorar: boolean;
    constructor Create( AOwner: TComponent ); Override;
    destructor Destroy; Override;
  end;

var
  QRLSalidasCliente: TQRLSalidasCliente;

implementation

uses LFSalidasCliente, bTextUtils, UDMAuxDB, UDMCambioMoneda;


{$R *.DFM}
//*******************************  REPORT  *************************************

constructor TQRLSalidasCliente.Create( AOwner: TComponent );
begin
  inherited;
  cajas:= nil;
  kilos:= nil;
  importes:= nil;
end;

destructor TQRLSalidasCliente.Destroy;
begin
  if cajas <> nil then
    FreeAndNil( cajas );
  if kilos <> nil then
    FreeAndNil( kilos );
  if importes <> nil then
    FreeAndNil( importes );
  inherited;
end;

procedure TQRLSalidasCliente.QRLSalidasClienteStartPage(
  Sender: TCustomQuickRep);
begin
     //inicializamos las variables para que se vuelva a mostrar el nº albaran etc
  fecha := true;
  dir := true;
  albaran := '';
end;

procedure TQRLSalidasCliente.QRLSalidasClienteBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  albaran := '';
  fecha := true;
  dir := true;

  rTotalProducto:= 0;
  rTotalCliente:= 0;
  rTotal:= 0;

     //crear e inicializar las StringList
  if cajas = nil then
  begin
    cajas := TStringList.Create;
    faltacajas := false;
  end
  else
  begin
    faltacajas := True;
  end;

  if kilos = nil then
  begin
    kilos := TStringList.Create;
    faltaKilos := False;
  end
  else
  begin
    faltaKilos := true;
  end;

  if importes = nil then
  begin
    importes := TStringList.Create;
    faltaImportes := False;
  end
  else
  begin
    faltaImportes := true;
  end;
end;

//****************************  BANDA DETALLE  *********************************
//campo albaran

procedure TQRLSalidasCliente.PsQRDBText2Print(sender: TObject;
  var Value: string);
begin
{
  if albaran = value then
  begin
    value := '';
    dir := false;
    fecha := false;
    LSeparador.Caption := '';
  end
  else
  begin
    albaran := value;
    dir := true;
    fecha := true;
    LSeparador.Caption := '-';
  end;
}
end;

//campo direccion de suministro

procedure TQRLSalidasCliente.PsQRDBText1Print(sender: TObject;
  var Value: string);
begin
  if not dir then Value := '';
end;

//campo fecha

procedure TQRLSalidasCliente.PsQRDBText4Print(sender: TObject;
  var Value: string);
begin
  if not fecha then Value := '';
end;

//campos cajas

procedure TQRLSalidasCliente.PsQRDBText9Print(sender: TObject;
  var Value: string);
var encontradocajas: boolean;
  i: integer;
begin
        //acumulo los valores de las cajas
  if not faltaCajas then
  begin
    if cajas.Count = 0 then
    begin
      cajas.Values[QListado.FieldByName('producto_sl').AsString] := Value;
      Value := FormatFloat('#,##0', StrToFloat(Value));
    end
    else
    begin
      encontradocajas := false;
      for i := 0 to cajas.Count - 1 do
      begin
        if QListado.FieldByName('producto_sl').AsString = cajas.Names[i] then
        begin
          cajas.Values[QListado.FieldByName('producto_sl').AsString] :=
            FloatToStr(StrToFloat(Value) +
            StrTOFloat(cajas.Values[QListado.FieldByName('producto_sl').AsString]));
          encontradocajas := true;
          Value := FormatFloat('#,##0', StrToFloat(Value));
          Break;
        end;
      end;
      if not encontradocajas then
      begin
        cajas.Values[QListado.FieldByName('producto_sl').AsString] := Value;
        Value := FormatFloat('#,##0', StrToFloat(Value));
      end;
    end;
  end;
end;

//campo kilos

procedure TQRLSalidasCliente.PsQRDBText10Print(sender: TObject;
  var Value: string);
var encontradokilos: boolean;
  i: integer;
begin
  //acumulo los valores de las kilos
  if not faltakilos then
  begin
    if kilos.Count = 0 then
    begin
      kilos.Values[QListado.FieldByName('producto_sl').AsString] := Value;
      Value := FormatFloat('#,##0.00', StrToFloat(Value));
    end
    else
    begin
      encontradokilos := false;
      for i := 0 to kilos.Count - 1 do
      begin
        if QListado.FieldByName('producto_sl').AsString = kilos.Names[i] then
        begin
          kilos.Values[QListado.FieldByName('producto_sl').AsString] :=
            FloatToStr(StrToFloat(Value) +
            StrTOFloat(kilos.Values[QListado.FieldByName('producto_sl').AsString]));
          Value := FormatFloat('#,##0.00', StrToFloat(Value));
          encontradokilos := true;
          Break;
        end;
      end;
      if not encontradokilos then
      begin
        kilos.Values[QListado.FieldByName('producto_sl').AsString] := Value;
        Value := FormatFloat('#,##0.00', StrToFloat(Value));
      end;
    end;
  end;
end;

//******************************  BANDA DESGLOSE  ******************************

procedure TQRLSalidasCliente.BSumarioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  i: integer;
  sAux: string;
begin

  if Imprimido then exit
  else Imprimido := True;

  if bValorar then
  begin
    PsQRLabel9.Width:= 410;
    PsQRLabel9.Left:= 300;
    Memo.Width:= 410;
    Memo.Left:= 300;
  end
  else
  begin
    PsQRLabel9.Width:= 313;
    PsQRLabel9.Left:= 397;
    Memo.Width:= 313;
    Memo.Left:= 397;
  end;

  Memo.Lines.Clear;
  for i := 0 to Cajas.Count - 1 do
  begin
    sAux := cajas.Names[i] + ':  ';
    sAux := sAux + Rellena(FormatFloat('#,##0', StrToFloat(cajas.Values[cajas.Names[i]])), 10);
    sAux := sAux + ' cajas  |  ';
    sAux := sAux + Rellena( FormatFloat( '#,##0', StrToFloatDef(kilos.Values[kilos.Names[i]],0) ) , 10);
      sAux := sAux + ' kgs';
    if bValorar then
    begin
      sAux := sAux + '  |  ';
      sAux := sAux + Rellena( FormatFloat( '#,##0', StrToFloatDef(importes.Values[importes.Names[i]],0) ) , 10);
      sAux := sAux + ' €';
    end;
    Memo.Lines.Add(sAux);
  end;
end;

procedure TQRLSalidasCliente.PsQRDBText7Print(sender: TObject;
  var Value: String);
begin
  Value:= desEnvase( DataSet.FieldByName('empresa_sc').asString, Value );
end;

procedure TQRLSalidasCliente.cliente_sal_scPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - ' + desCliente( Value );
end;

//campo importes
procedure TQRLSalidasCliente.qreImportePrint(sender: TObject;
  var Value: String);

var
  rAux: real;
  encontradoImportes: boolean;
  i: integer;
begin
  if bValorar then
  begin
    rAux:= ChangeToEuro( QListado.fieldByName('moneda_sc').AsString,
                       QListado.fieldByName('fecha_sc').AsString,
                       QListado.fieldByName('importe').AsFloat );

    rTotalProducto:= rTotalProducto + rAux;
    rTotalCliente:= rTotalCliente + rAux;
    rTotal:= rTotal + rAux;



    //acumulo los valores de los importes
    if not faltaImportes then
    begin
      if importes.Count = 0 then
      begin
        importes.Values[QListado.FieldByName('producto_sl').AsString] := FloatToStr( rAux );
        Value := FormatFloat('#,##0.00', rAux );
      end
      else
      begin
        encontradoImportes := false;
        for i := 0 to importes.Count - 1 do
        begin
          if QListado.FieldByName('producto_sl').AsString = importes.Names[i] then
          begin
            importes.Values[QListado.FieldByName('producto_sl').AsString] :=
              FloatToStr(rAux +
              StrTOFloat(importes.Values[QListado.FieldByName('producto_sl').AsString]));
            Value := FormatFloat('#,##0.00', rAux);
            encontradoImportes := true;
            Break;
          end;
        end;
        if not encontradoImportes then
        begin
          importes.Values[QListado.FieldByName('producto_sl').AsString] := FloatToStr( rAux );
          Value := FormatFloat('#,##0.00', rAux);
        end;
      end;
    end;

    if QListado.fieldByName('cajas').AsInteger > 0 then
    begin
      qrePreciocaj.Caption:= FormatFloat( '#,##0.0000', rAux / QListado.fieldByName('cajas').AsFloat );
    end
    else
    begin
      qrePreciocaj.Caption:= '-';
    end;

    if QListado.fieldByName('kilos').AsInteger > 0 then
    begin
      qrePrecioKg.Caption:= FormatFloat( '#,##0.0000', rAux / QListado.fieldByName('kilos').AsFloat );
    end
    else
    begin
      qrePrecioKg.Caption:= '-';
    end;

  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQRLSalidasCliente.qrgrpProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  Sender.Height:= 0;
end;

procedure TQRLSalidasCliente.qrdbtxtproducto_slPrint(sender: TObject;
  var Value: String);
begin
  Value:= DataSet.FieldByName('cliente_sal_sc').asString + ' - ' + desProducto( DataSet.FieldByName('empresa_sc').asString, Value );
end;

procedure TQRLSalidasCliente.qrdbtxtproducto_sl1Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + desCliente( Value );
end;

procedure TQRLSalidasCliente.qrxpr6Print(sender: TObject;
  var Value: String);
begin
  if not bValorar then
  begin
    Value:= '';
  end
  else
  begin
    Value := FormatFloat('#,##0.00', rTotalProducto);
  end;
  rTotalProducto:= 0;
end;

procedure TQRLSalidasCliente.qrxpr3Print(sender: TObject;
  var Value: String);
begin
  if not bValorar then
  begin
    Value:= '';
  end
  else
  begin
    Value := FormatFloat('#,##0.00', rTotalCliente);
  end;
  rTotalCliente:= 0;
end;

end.
