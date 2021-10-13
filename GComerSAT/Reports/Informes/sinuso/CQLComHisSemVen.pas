(*TODO Semana 53*)
(*TODO Que imnprima hasta la ultima semana aunque no tenga valores*)
unit CQLComHisSemVen;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, DBTables;

type
  TDQLComHisSemVen = class(TQuickRep)
    SummaryBand1: TQRBand;
    TitleBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    QRExpr4: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr10: TQRExpr;
    bndDetalle: TQRBand;
    ColumnHeaderBand2: TQRBand;
    PsQRLabel6: TQRLabel;
    lblPeriodo3: TQRLabel;
    lblPeriodo2: TQRLabel;
    lblPeriodo1: TQRLabel;
    Diferencia: TQRLabel;
    LUnidad3: TQRLabel;
    LUnidad1: TQRLabel;
    LUnidad2: TQRLabel;
    LUnidad4: TQRLabel;
    lblPrecio3: TQRLabel;
    lblPrecio2: TQRLabel;
    lblPrecio1: TQRLabel;
    lblDifPrecio: TQRLabel;
    PsQRShape5: TQRShape;
    PsQRShape4: TQRShape;
    PsQRShape1: TQRShape;
    PsQRShape2: TQRShape;
    PsQRShape3: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    QRExpr1: TQRExpr;
    dif_precio: TQRExpr;
    precio3: TQRExpr;
    precio2: TQRExpr;
    precio1: TQRExpr;
    lblDifPrecioAcum: TQRLabel;
    lblPrecioMedio3: TQRLabel;
    lblPrecioMedio2: TQRLabel;
    lblPrecioMedio1: TQRLabel;
    lblPeriodo3_: TQRLabel;
    lblPeriodo2_: TQRLabel;
    lblPeriodo1_: TQRLabel;
    PsCliente: TQRLabel;
    PsProducto: TQRLabel;
    psMoneda: TQRLabel;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure bndDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure lblDifPrecioAcumPrint(sender: TObject; var Value: String);
    procedure lblPrecioMedio3Print(sender: TObject; var Value: String);
    procedure lblPrecioMedio2Print(sender: TObject; var Value: String);
    procedure lblPrecioMedio1Print(sender: TObject; var Value: String);
  private
    iLineas: integer;
    importe1, importe2, importe3: real;
    kilos1, kilos2, kilos3: real;
  public
    bVerPrecio: boolean;

    constructor Create( AOwner: TComponent ); Override;
  end;

implementation

{$R *.DFM}

uses CMLComHisSemVen;

constructor TDQLComHisSemVen.Create( AOwner: TComponent );
begin
  inherited;
  bVerPrecio:= True;
end;

procedure TDQLComHisSemVen.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblPrecio1.Enabled:= bVerPrecio;
  lblPrecio2.Enabled:= bVerPrecio;
  lblPrecio3.Enabled:= bVerPrecio;
  lblDifPrecio.Enabled:= bVerPrecio;

  precio1.Enabled:= bVerPrecio;
  lblPrecioMedio1.Enabled:= bVerPrecio;
  precio2.Enabled:= bVerPrecio;
  lblPrecioMedio2.Enabled:= bVerPrecio;
  precio3.Enabled:= bVerPrecio;
  lblPrecioMedio3.Enabled:= bVerPrecio;
  dif_precio.Enabled:= bVerPrecio;
  lblDifPrecio.Enabled:= bVerPrecio;

  importe1:= 0;
  importe2:= 0;
  kilos1:= 0;
  kilos2:= 0;

  iLineas:= 0;
end;

procedure TDQLComHisSemVen.bndDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  importe1:= DataSet.FieldByName('importe1').asFloat + importe1;
  importe2:= DataSet.FieldByName('importe2').asFloat + importe2;
  importe3:= DataSet.FieldByName('importe3').asFloat + importe3;
  kilos1:= DataSet.FieldByName('kilos1').asFloat + kilos1;
  kilos2:= DataSet.FieldByName('kilos2').asFloat + kilos2;
  kilos3:= DataSet.FieldByName('kilos3').asFloat + kilos3;

  inc( iLineas );

  bndDetalle.Frame.DrawBottom:= ( iLineas mod 10 ) = 0;
end;

procedure TDQLComHisSemVen.lblPrecioMedio3Print(sender: TObject;
  var Value: String);
var
  rAux: real;
begin
  if bVerPrecio then
  begin
    if kilos3 = 0 then
    begin
      rAux:= 0;
    end
    else
    begin
      rAux:= importe3/kilos3;
    end;
    Value:= FormatFloat( '#,##0.000', rAux );
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TDQLComHisSemVen.lblPrecioMedio2Print(sender: TObject;
  var Value: String);
var
  rAux: real;
begin
  if bVerPrecio then
  begin
    if kilos2 = 0 then
    begin
      rAux:= 0;
    end
    else
    begin
      rAux:= importe2/kilos2;
    end;
    Value:= FormatFloat( '#,##0.000', rAux );
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TDQLComHisSemVen.lblPrecioMedio1Print(sender: TObject;
  var Value: String);
var
  rAux: real;
begin
  if bVerPrecio then
  begin
    if kilos1 = 0 then
    begin
      rAux:= 0;
    end
    else
    begin
      rAux:= importe1/kilos1;
    end;
    Value:= FormatFloat( '#,##0.000', rAux );
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TDQLComHisSemVen.lblDifPrecioAcumPrint(sender: TObject;
  var Value: String);
var
  rAux: real;
begin
  if bVerPrecio then
  begin
    if kilos1 + kilos2 = 0 then
    begin
      rAux:= 0;
    end
    else
    begin
      if kilos1  = 0 then
      begin
        rAux:= -(importe2/kilos2);
      end
      else
      begin
        if kilos2  = 0 then
        begin
          rAux:= importe1/kilos1;
        end
        else
        begin
          rAux:= (importe1/kilos1) - (importe2/kilos2);
        end;
      end;
    end;
    Value:= FormatFloat( '#,##0.000', rAux );
  end
  else
  begin
    Value:= '';
  end;
end;

end.
