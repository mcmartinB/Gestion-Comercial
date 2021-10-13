unit LCambioDivisas;

interface

uses Classes, Controls, StdCtrls, ExtCtrls,
  Quickrpt, Graphics, Qrctrls, Db, DBTables;

type
  TQRLCambioDivisas = class(TQuickRep)
    TitleBand1: TQRBand;
    QRTitulo: TQRLabel;
    QRSysData2: TQRSysData;
    detalle: TQRBand;
    campo2: TQRLabel;
    campo3: TQRLabel;
    campo6: TQRLabel;
    campo5: TQRLabel;
    campo4: TQRLabel;
    campo7: TQRLabel;
    campo8: TQRLabel;
    campo9: TQRLabel;
    QCalculoColumnas: TQuery;
    QCalculoFecha: TQuery;
    LFec: TQRLabel;
    titol1: TQRLabel;
    titol2: TQRLabel;
    titol3: TQRLabel;
    titol4: TQRLabel;
    titol5: TQRLabel;
    titol6: TQRLabel;
    fecha_ce: TQRDBText;
    QLineas: TQuery;
    QLineasfecha_ce: TDateField;
    QLineasmoneda_ce: TStringField;
    QLineascambio_ce: TFloatField;
    campo1: TQRLabel;
    cuadro1: TQRShape;
    cuadro2: TQRShape;
    cuadroFecha: TQRShape;
    cuadro4: TQRShape;
    cuadro3: TQRShape;
    cuadro6: TQRShape;
    cuadro5: TQRShape;
    cuadro8: TQRShape;
    cuadro7: TQRShape;
    cuadro9: TQRShape;
    PsQRShape1: TQRShape;
    PsQRShape2: TQRShape;
    PsQRShape5: TQRShape;
    PsQRShape6: TQRShape;
    PsQRShape7: TQRShape;
    PsQRShape8: TQRShape;
    PsQRShape3: TQRShape;
    PageFooterBand1: TQRBand;
    PsQRSysData1: TQRSysData;
    titol7: TQRLabel;
    PsQRShape9: TQRShape;
    titol8: TQRLabel;
    PsQRShape10: TQRShape;
    titol9: TQRLabel;
    PsQRShape11: TQRShape;
    procedure QRLCambioDivisasBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure detalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);

  private

  public
    fila: Integer;
    fecha: string;
    cambio: string;
        //tipoList:Boolean;
    tipoList: Char;
  end;

var
  QRLCambioDivisas: TQRLCambioDivisas;
  numCampoXFila: Integer;

implementation
{$R *.DFM}
uses SysUtils, UDMBaseDatos, bSQLUtils;

procedure TQRLCambioDivisas.QRLCambioDivisasBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
var k: Integer;
  visi: Boolean;
  fec, tit: string;
begin
  fila := 0;
  fecha := Self.DataSet.FieldByName('fecha_ce').AsString;

  QCalculoColumnas.Open;
  numCampoXFila := QCalculoColumnas.FieldByName('cuenta').AsInteger;
  QCalculoColumnas.Close;

  QCalculoFecha.Open;
  fec := QCalculoFecha.FieldByName('fecha_ce').AsString;
  QCalculoFecha.Close;
  QCalculoFecha.SQL.Clear;
  QCalculoFecha.SQL.Add('SELECT * FROM frf_cambios_euros ');
  QCalculoFecha.SQL.Add('WHERE fecha_ce = ' + SQLDate(fec) + ' ');
     // Si es cambio a moneda no sacar el MIBOR...
{
     if tipoList Then
        QCalculoFecha.SQL.Add('And moneda_ce <> ' + QuotedStr('MIB')+ ' ');
}

  QCalculoFecha.SQL.Add('ORDER BY moneda_ce ');
  QCalculoFecha.Open;

  k := 1;
  while (k <= 9) do
  begin
    if not QCalculoFecha.Eof then
    begin
      visi := True;
      tit := QCalculoFecha.FieldByName('moneda_ce').AsString;
      QCalculoFecha.Next;
    end
    else
      visi := False;

    case k of
      1: if visi then titol1.Caption := tit
        else
        begin
          titol1.Caption := '';
          titol1.visible := False;
        end;
      2: if visi then titol2.Caption := tit
        else
        begin
          titol2.Caption := '';
          titol2.visible := False;
        end;
      3: if visi then titol3.Caption := tit
        else
        begin
          titol3.Caption := '';
          titol3.visible := False;
        end;
      4: if visi then titol4.Caption := tit
        else
        begin
          titol4.Caption := '';
          titol4.visible := False;
        end;
      5: if visi then titol5.Caption := tit
        else
        begin
          titol5.Caption := '';
          titol5.visible := False;
        end;
      6: if visi then titol6.Caption := tit
        else
        begin
          titol6.Caption := '';
          titol6.visible := False;
        end;
      7:
        if visi then titol7.Caption := tit
        else
        begin
          titol7.Caption := '';
          titol7.visible := False;
        end;
      8: if visi then titol8.Caption := tit
        else
        begin
          titol8.Caption := '';
          titol8.visible := False;
        end;
      9: if visi then titol9.Caption := tit
        else
        begin
          titol9.Caption := '';
          titol9.visible := False;
        end;

    end;
    k := k + 1;
  end;
  QCalculoFecha.Close;
end;

procedure TQRLCambioDivisas.detalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var k: Integer;
  saltar: Boolean;
  canvi: Extended;
//    vector:Array [0..11] of String;
begin
  QLineas.SQL.Clear;
  QLineas.SQL.Add('SELECT fecha_ce,moneda_ce,cambio_ce ' +
    'FROM frf_cambios_euros Frf_cambios_euros ');
  QLineas.SQL.Add('Where fecha_ce = ' +
    SQLDate(DMBaseDatos.QListado.FieldByName('fecha_ce').AsString) + ' ');

  QLineas.Open;
  while (fila <= 9) do
  begin
    if fila = 10 then fila := 0;
    fila := fila + 1;
    if not (QLineas.Eof) then
    begin
      k := 1;
      saltar := False;
      canvi := QLineas.FieldByName('cambio_ce').AsFloat;
               // tipoList = FALSE a EUROS.......
      if tipoList = 'D' then
      begin
        if QLineas.FieldByName('moneda_ce').AsString <> 'MIB' then
        begin
          if canvi = 0 then canvi := 0
          else canvi := 1 / canvi;
        end;
      end;
      if tipoList = 'P' then
      begin
        if QLineas.FieldByName('moneda_ce').AsString <> 'MIB' then
        begin
          if canvi <> 0 then
            canvi := ((1 / canvi) * 166.386);
        end;
      end;
      cambio := FormatFloat('#,###,##0.0000;-#,###,##0.0000;0.0000', canvi);
    end
    else
    begin
      saltar := True;
      cambio := '';
      k := 9 - fila + 1;
    end;
    while (k <> 0) do
    begin
      case fila of
        1: campo1.Caption := cambio;
        2: campo2.Caption := cambio;
        3: campo3.Caption := cambio;
        4: campo4.Caption := cambio;
        5: campo5.Caption := cambio;
        6: campo6.Caption := cambio;
        7: campo7.Caption := cambio;
        8: campo8.Caption := cambio;
        9: campo9.Caption := cambio;
      end;
      k := k - 1;
      if Saltar then fila := fila + 1;
    end;
    if Saltar then fila := 11;
    Qlineas.Next;
  end;
  fila := 0;
  QLineas.Close;

end;

end.
