(*TODO Semana 53*)
(*TODO Que imnprima hasta la ultima semana aunque no tenga valores*)
unit CQLComSemVen;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, DBTables;

type
  TDQLComSemVen = class(TQuickRep)
    QRSubDetail1: TQRSubDetail;
    SummaryBand1: TQRBand;
    QVentas1: TQuery;
    QVentas2: TQuery;
    QVentas3: TQuery;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    TitleBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsProducto: TQRLabel;
    PsCliente: TQRLabel;
    psMoneda: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    kilos1: TQRLabel;
    importe1: TQRLabel;
    kilos2: TQRLabel;
    importe2: TQRLabel;
    kilos3: TQRLabel;
    importe3: TQRLabel;
    difkilos: TQRLabel;
    difimporte: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    PsQRLabel6: TQRLabel;
    Periodo1: TQRLabel;
    Periodo2: TQRLabel;
    Periodo3: TQRLabel;
    Diferencia: TQRLabel;
    LUnidad3: TQRLabel;
    LUnidad1: TQRLabel;
    LUnidad2: TQRLabel;
    LUnidad4: TQRLabel;
    PsQRLabel15: TQRLabel;
    PsQRLabel16: TQRLabel;
    PsQRLabel17: TQRLabel;
    PsQRLabel18: TQRLabel;
    PsQRLabel13: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel11: TQRLabel;
    PsQRLabel9: TQRLabel;
    PsQRShape5: TQRShape;
    PsQRShape4: TQRShape;
    PsQRShape1: TQRShape;
    PsQRShape2: TQRShape;
    PsQRShape3: TQRShape;
    lblCentro: TQRLabel;
    lblEnvase: TQRLabel;
    procedure QRSubDetail1NeedData(Sender: TObject; var MoreData: Boolean);
    procedure QRLabel1Print(sender: TObject; var Value: string);
    procedure QRLabel4Print(sender: TObject; var Value: string);
    procedure QRLabel5Print(sender: TObject; var Value: string);
    procedure QRLabel2Print(sender: TObject; var Value: string);
    procedure QRLabel3Print(sender: TObject; var Value: string);
    procedure QRLabel6Print(sender: TObject; var Value: string);
    procedure QRLabel7Print(sender: TObject; var Value: string);
    procedure QRSubDetail1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLabel8Print(sender: TObject; var Value: string);
    procedure QRLabel9Print(sender: TObject; var Value: string);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure difkilosPrint(sender: TObject; var Value: string);
    procedure difimportePrint(sender: TObject; var Value: string);
  private
    iAnySem1, iAnySem2, iAnySem3: Integer;
    iAnySemGuia: Integer;
    sAnySemActual: string;

    fAKilos1, fAKilos2, fAKilos3: Real;
    fAImporte1, fAImporte2, fAImporte3: Real;

  public
    iAnySemInicial: Integer;

  end;

implementation

{$R *.DFM}

uses DateUtils;

procedure AnyoSemanaActual(var AAnyActual, AAnySem1, AAnySem2, AAnySem3: Integer);
var
  sAux: Integer;
(*
  anyo, mes, dia: word;
*)
begin

  AAnySem1 := AAnySem1 + 200;
  AAnySem2 := AAnySem2 + 100;
  if AAnySem1 <= AAnySem2 then
  begin
    if AAnySem1 <= AAnySem3 then
      sAux := AAnySem1
    else
      sAux := AAnySem3;
  end
  else
  begin
    if AAnySem2 <= AAnySem3 then
      sAux := AAnySem2
    else
      sAux := AAnySem3;
  end;

  if sAux > AAnyActual then
  begin
    AAnySem1 := 0;
    AAnySem2 := 0;
    AAnySem3 := 0;
    //sAux:= AAnyActual;
  end
  else
  begin
    if AAnySem1 > sAux then
      AAnySem1 := 0;
    if AAnySem2 > sAux then
      AAnySem2 := 0;
    if AAnySem3 > sAux then
      AAnySem3 := 0;
  end;
  Inc(AAnyActual);
  (*TODO Puede haber semana 53*)
  if WeekOfTheYear(EncodeDate(Trunc(AAnyActual / 100), 12, 31)) = 53 then
  begin
    if Copy(IntToStr(AAnyActual), 5, 2) = '54' then
      AAnyActual := (AAnyActual - 53) + 100;
  end
  else
  begin
    if Copy(IntToStr(AAnyActual), 5, 2) = '53' then
      AAnyActual := (AAnyActual - 52) + 100;
  end;
end;

procedure TDQLComSemVen.QRSubDetail1NeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData := not (QVentas1.Eof and QVentas2.Eof and QVentas3.Eof);
end;

procedure TDQLComSemVen.QRLabel1Print(sender: TObject;
  var Value: string);
begin
  Value := '';
  if iAnySem1 > 0 then
  begin
    fAKilos1 := fAKilos1 + QVentas1.fieldByName('Kilos').AsFloat;
    Value := FormatFloat('#,##0.00', QVentas1.fieldByName('Kilos').AsFloat);
  end;
end;

procedure TDQLComSemVen.QRLabel4Print(sender: TObject;
  var Value: string);
begin
  Value := '';
  if iAnySem2 > 0 then
  begin
    fAKilos2 := fAKilos2 + QVentas2.fieldByName('Kilos').AsFloat;
    Value := FormatFloat('#,##0.00', QVentas2.fieldByName('Kilos').AsFloat);
  end;
end;

procedure TDQLComSemVen.QRLabel5Print(sender: TObject;
  var Value: string);
begin
  Value := '';
  if iAnySem3 > 0 then
  begin
    fAKilos3 := fAKilos3 + QVentas3.fieldByName('Kilos').AsFloat;
    Value := FormatFloat('#,##0.00', QVentas3.fieldByName('Kilos').AsFloat);
  end;
end;

procedure TDQLComSemVen.QRLabel2Print(sender: TObject;
  var Value: string);
begin
  Value := '';
  if iAnySem1 > 0 then
  begin
    fAImporte1 := fAImporte1 + QVentas1.fieldByName('Importe').AsFloat;
    Value := FormatFloat('#,##0.00', QVentas1.fieldByName('Importe').AsFloat /
      QVentas1.fieldByName('Kilos').AsFloat);
  end;
end;

procedure TDQLComSemVen.QRLabel3Print(sender: TObject;
  var Value: string);
begin
  Value := '';
  if iAnySem2 > 0 then
  begin
    fAImporte2 := fAImporte2 + QVentas2.fieldByName('Importe').AsFloat;
    Value := FormatFloat('#,##0.00', QVentas2.fieldByName('Importe').AsFloat /
      QVentas2.fieldByName('Kilos').AsFloat);
  end;
end;

procedure TDQLComSemVen.QRLabel6Print(sender: TObject;
  var Value: string);
begin
  Value := '';
  if iAnySem3 > 0 then
  begin
    fAImporte3 := fAImporte3 + QVentas3.fieldByName('Importe').AsFloat;
    Value := FormatFloat('#,##0.00', QVentas3.fieldByName('Importe').AsFloat /
      QVentas3.fieldByName('Kilos').AsFloat);
  end;
end;

function MaxSemana( const AAnySem1, AAnySem2, AAnySem3, AAnyGuia: integer ):string;
var
  i1, i2, i3: Integer;
begin
  if AAnySem1 = 999999 then
    i1:= 0
  else
    i1:= AAnySem1 mod 100;
  if AAnySem2 = 999999 then
    i2:= 0
  else
    i2:= AAnySem2 mod 100;
  if AAnySem3 = 999999 then
    i3:= 0
  else
    i3:= AAnySem3 mod 100;
  if i1 + i2 + i3 = 0 then
  begin
    result:= IntToStr( ( AAnyGuia mod 100 ) - 1 );
  end
  else
  begin
    if i1 > i2 then
    begin
      if i1 > i3 then
        result:= IntToStr( i1 )
      else
        result:= IntToStr( i3 );
    end
    else
    begin
      if i2 > i3 then
        result:= IntToStr( i2 )
      else
        result:= IntToStr( i3 );
    end;
  end;
  if Length( result ) = 1 then
    result:= '0' + result;

end;

procedure TDQLComSemVen.QRLabel7Print(sender: TObject;
  var Value: string);
begin
  Value := MaxSemana( iAnySem1, iAnySem2, iAnySem3, iAnySemGuia );
end;

procedure TDQLComSemVen.QRSubDetail1AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  if iAnySem1 > 0 then QVentas1.Next;
  if iAnySem2 > 0 then QVentas2.Next;
  if iAnySem3 > 0 then QVentas3.Next;
end;

procedure TDQLComSemVen.QRSubDetail1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if QVentas1.Eof then
    iAnySem1 := 999999
  else
    iAnySem1 := QVentas1.fieldByName('AnyoSemana').AsInteger;
  if QVentas2.Eof then
    iAnySem2 := 999999
  else
    iAnySem2 := QVentas2.fieldByName('AnyoSemana').AsInteger;
  if QVentas3.Eof then
    iAnySem3 := 999999
  else
    iAnySem3 := QVentas3.fieldByName('AnyoSemana').AsInteger;

  sAnySemActual := IntToStr(iAnySemGuia);
  AnyoSemanaActual(iAnySemGuia, iAnySem1, iAnySem2, iAnySem3);
end;

procedure TDQLComSemVen.QRLabel8Print(sender: TObject;
  var Value: string);
var
  fKilos2, fKilos3: Real;
begin
  Value := '';
  if (iAnySem2 + iAnySem3) > 0 then
  begin
    if iAnySem2 > 0 then
      fKilos2 := QVentas2.fieldByName('Kilos').AsFloat
    else
      fKilos2 := 0;
    if iAnySem3 > 0 then
      fKilos3 := QVentas3.fieldByName('Kilos').AsFloat
    else
      fKilos3 := 0;
    Value := FormatFloat('#,##0.00', fKilos3 - fKilos2);
  end;
end;



procedure TDQLComSemVen.QRLabel9Print(sender: TObject;
  var Value: string);
var
  fImporte2, fImporte3: Real;
  fKilos2, fKilos3: Real;
begin
  Value := '';
  if (iAnySem2 + iAnySem3) > 0 then
  begin
    if iAnySem2 > 0 then
      fImporte2 := QVentas2.fieldByName('Importe').AsFloat
    else
      fImporte2 := 0;
    if iAnySem3 > 0 then
      fImporte3 := QVentas3.fieldByName('Importe').AsFloat
    else
      fImporte3 := 0;
    Value := FormatFloat('#,##0.00', fImporte3 - fImporte2);

    if iAnySem2 > 0 then
      fKilos2 := QVentas2.fieldByName('Kilos').AsFloat
    else
      fKilos2 := 0;
    if iAnySem3 > 0 then
      fKilos3 := QVentas3.fieldByName('Kilos').AsFloat
    else
      fKilos3 := 0;
    if (fKilos2 > 0) and (fKilos3 > 0) then
      Value := FormatFloat('#,##0.00', (fImporte3 / fKilos3) - (fImporte2 / fKilos2))
    else
      if (fKilos3 > 0) then
        Value := FormatFloat('#,##0.00', (fImporte3 / fKilos3))
      else
        if (fKilos2 > 0) then
          Value := FormatFloat('#,##0.00', (fImporte2 / fKilos2));
  end;
end;

procedure TDQLComSemVen.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  fAKilos1 := 0;
  fAKilos2 := 0;
  fAKilos3 := 0;
  fAImporte1 := 0;
  fAImporte2 := 0;
  fAImporte3 := 0;

  QVentas1.First;
  QVentas2.First;
  QVentas3.First;

  iAnySemGuia := iAnySemInicial;
end;

procedure TDQLComSemVen.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  kilos1.Caption := FormatFloat('#,##0.00', fAKilos1);
  kilos2.Caption := FormatFloat('#,##0.00', fAKilos2);
  kilos3.Caption := FormatFloat('#,##0.00', fAKilos3);

  if fAKilos1 > 0 then
    importe1.Caption := FormatFloat('#,##0.00', fAImporte1 / fAKilos1)
  else
    importe1.Caption := '0.00';

  if fAKilos2 > 0 then
    importe2.Caption := FormatFloat('#,##0.00', fAImporte2 / fAKilos2)
  else
    importe2.Caption := '0.00';

  if fAKilos3 > 0 then
    importe3.Caption := FormatFloat('#,##0.00', fAImporte3 / fAKilos3)
  else
    importe3.Caption := '0.00';
end;

procedure TDQLComSemVen.difkilosPrint(sender: TObject;
  var Value: string);
var
  fKilos2, fKilos3: Real;
begin
  Value := '';
  fKilos2 := fAKilos2;
  fKilos3 := fAKilos3;
  Value := FormatFloat('#,##0.00', fKilos3 - fKilos2);
end;

procedure TDQLComSemVen.difimportePrint(sender: TObject;
  var Value: string);
var
  fImporte2, fImporte3: Real;
  fKilos2, fKilos3: Real;
begin
  Value := '';
  fImporte2 := fAImporte2;
  fImporte3 := fAImporte3;
  fKilos2 := fAKilos2;
  fKilos3 := fAKilos3;

  if (fKilos2 > 0) and (fKilos3 > 0) then
    Value := FormatFloat('#,##0.00', (fImporte3 / fKilos3) - (fImporte2 / fKilos2))
  else
    if (fKilos3 > 0) then
      Value := FormatFloat('#,##0.00', (fImporte3 / fKilos3))
    else
      if (fKilos2 > 0) then
        Value := FormatFloat('#,##0.00', (fImporte2 / fKilos2));
end;

end.
