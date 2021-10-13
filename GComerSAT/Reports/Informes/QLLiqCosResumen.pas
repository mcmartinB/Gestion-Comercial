unit QLLiqCosResumen;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLLiqCosResumen = class(TQuickRep)
    bndCab: TQRBand;
    bndDetalle: TQRSubDetail;
    PsQRSysData1: TQRSysData;
    PsQRDBText3: TQRDBText;
    PsQRDBText5: TQRDBText;
    PsQRDBText11: TQRDBText;
    PsQRDBText12: TQRDBText;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRSysData2: TQRSysData;
    PageFooterBand1: TQRBand;
    PsQRSysData3: TQRSysData;
    ChildBand2: TQRChildBand;
    PsQRLabel9: TQRLabel;
    PsQRLabel10: TQRLabel;
    PsQRLabel12: TQRLabel;
    PsQRLabel16: TQRLabel;
    PsQRLabel25: TQRLabel;
    PsQRLabel26: TQRLabel;
    QRBand1: TQRBand;
    PsQRExpr8: TQRExpr;
    PsQRExpr7: TQRExpr;
    PsQRExpr6: TQRExpr;
    PsQRExpr1: TQRExpr;
    PsQRExpr4: TQRExpr;
    PsQRExpr5: TQRExpr;
    PsQRLabel4: TQRLabel;
    PsQRDBText20: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRLabel5: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRLabel11: TQRLabel;
    PsQRLabel13: TQRLabel;
    PsQRLabel14: TQRLabel;
    lblEnvasado: TQRLabel;
    lblProduccion: TQRLabel;
    lblAdministracion: TQRLabel;
    lblLiquido: TQRLabel;
    lblTEnvasado: TQRLabel;
    lblTProduccion: TQRLabel;
    lblTAdministracion: TQRLabel;
    lblTLiquido: TQRLabel;
    ChildBand1: TQRChildBand;
    lblPAprovechado: TQRLabel;
    lblPBruto: TQRLabel;
    lblPCoste: TQRLabel;
    lblPNeto: TQRLabel;
    lblPEnvasado: TQRLabel;
    lblPProduccion: TQRLabel;
    lblPAdministracion: TQRLabel;
    lblPLiquido: TQRLabel;
    PsQRLabel24: TQRLabel;
    PsQRLabel27: TQRLabel;
    lblPGastos: TQRLabel;
    procedure PsQRDBText2Print(sender: TObject; var Value: string);
    procedure PsQRLabel1Print(sender: TObject; var Value: string);
    procedure PsQRLabel3Print(sender: TObject; var Value: string);
    procedure PsQRLabel2Print(sender: TObject; var Value: string);
    procedure PsQRLabel6Print(sender: TObject; var Value: string);
    procedure PsQRLabel7Print(sender: TObject; var Value: string);
    procedure bndDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRExpr1Print(sender: TObject; var Value: string);
    procedure PsQRExpr4Print(sender: TObject; var Value: string);
    procedure PsQRExpr7Print(sender: TObject; var Value: string);
    procedure PsQRExpr6Print(sender: TObject; var Value: string);
    procedure PsQRExpr8Print(sender: TObject; var Value: string);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    totalCosechado, totalAprovechado, totalBruto, totalNeto, totalCoste: Real;
    totalEnvasado, totalProduccion, totalAdministracion: Real;
    totalNetoLiquido: Real;
  public
    empresa, producto, centro, rango: string;
    costeEnvasado, costeProduccion, costeAdministracion: Real;

    cEnvasado: Real;

    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses UDMBaseDatos, UDMAuxDB, bNumericUtils;

{$R *.DFM}


constructor TQRLLiqCosResumen.Create(AOwner: TComponent);
begin
  inherited;
  cEnvasado := 0.012;
end;

procedure TQRLLiqCosResumen.PsQRDBText2Print(sender: TObject;
  var Value: string);
begin
  Value := desCosechero(empresa, value);
end;

procedure TQRLLiqCosResumen.PsQRLabel1Print(sender: TObject;
  var Value: string);
begin
  value := rango;
end;

procedure TQRLLiqCosResumen.PsQRLabel3Print(sender: TObject;
  var Value: string);
begin
  Value := desCentro(empresa, centro);
end;

procedure TQRLLiqCosResumen.PsQRLabel2Print(sender: TObject;
  var Value: string);
begin
  Value := desProducto(empresa, producto);
end;

procedure TQRLLiqCosResumen.PsQRLabel6Print(sender: TObject;
  var Value: string);
begin
  Value := centro;
end;

procedure TQRLLiqCosResumen.PsQRLabel7Print(sender: TObject;
  var Value: string);
begin
  Value := producto;
end;

procedure TQRLLiqCosResumen.bndDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  auxEnvasado, auxProduccion, auxAdministracion: Real;
  auxKilos: Real;
  auxNetoLiquido: Real;
begin
  auxKilos := DataSet.FieldByName('aprovechado').AsFloat;

  auxEnvasado := Redondea(auxKilos * costeEnvasado, 2);
  auxProduccion := Redondea(auxKilos * costeProduccion, 2);
  auxAdministracion := Redondea(auxKilos * costeAdministracion, 2);

  totalEnvasado := totalEnvasado + auxEnvasado;
  totalProduccion := totalProduccion + auxProduccion;
  totalAdministracion := totalAdministracion + auxAdministracion;

  auxNetoLiquido := DataSet.FieldByName('neto').AsFloat -
    (auxEnvasado + auxProduccion + auxAdministracion);
  totalNetoLiquido := totalNetoLiquido + auxNetoLiquido;

  lblEnvasado.Caption := FormatFloat('#,##0.00', auxEnvasado);
  lblProduccion.Caption := FormatFloat('#,##0.00', auxProduccion);
  lblAdministracion.Caption := FormatFloat('#,##0.00', auxAdministracion);

  lblLiquido.Caption := FormatFloat('#,##0.00', auxNetoLiquido);
end;

procedure TQRLLiqCosResumen.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblTEnvasado.Caption := FormatFloat('#,##0.00', totalEnvasado);
  lblTProduccion.Caption := FormatFloat('#,##0.00', totalProduccion);
  lblTAdministracion.Caption := FormatFloat('#,##0.00', totalAdministracion);

  lblTLiquido.Caption := FormatFloat('#,##0.00', totalNetoLiquido);
end;

procedure TQRLLiqCosResumen.PsQRExpr1Print(sender: TObject;
  var Value: string);
begin
  totalCosechado := StrToFloat(Value);
  Value := FormatFloat('#,##0', totalCosechado);
end;

procedure TQRLLiqCosResumen.PsQRExpr4Print(sender: TObject;
  var Value: string);
begin
  totalAprovechado := StrToFloat(Value);
  Value := FormatFloat('#,##0', totalAprovechado);
end;

procedure TQRLLiqCosResumen.PsQRExpr7Print(sender: TObject;
  var Value: string);
begin
  totalBruto := StrToFloat(Value);
  Value := FormatFloat('#,##0.00', totalBruto);
end;

procedure TQRLLiqCosResumen.PsQRExpr6Print(sender: TObject;
  var Value: string);
begin
  totalCoste := StrToFloat(Value);
  Value := FormatFloat('#,##0.00', totalCoste);
end;

procedure TQRLLiqCosResumen.PsQRExpr8Print(sender: TObject;
  var Value: string);
begin
  totalNeto := StrToFloat(Value);
  Value := FormatFloat('#,##0.00', totalNeto);
end;

procedure TQRLLiqCosResumen.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblPAprovechado.Caption := FormatFloat('#,##0.00', totalAprovechado / totalCosechado);
  lblPBruto.Caption := FormatFloat('#,##0.000', totalBruto / totalAprovechado);
  lblPCoste.Caption := FormatFloat('#,##0.000', totalCoste / totalAprovechado);
  lblPNeto.Caption := FormatFloat('#,##0.000', totalNeto / totalAprovechado);
  lblPEnvasado.Caption := FormatFloat('#,##0.000', costeEnvasado);
  lblPProduccion.Caption := FormatFloat('#,##0.000', costeProduccion);
  lblPAdministracion.Caption := FormatFloat('#,##0.000', costeAdministracion);
  lblPGastos.Caption := FormatFloat('#,##0.000', costeEnvasado + costeProduccion + costeAdministracion);
  lblPLiquido.Caption := FormatFloat('#,##0.000', totalNetoLiquido / totalAprovechado);
end;

end.
