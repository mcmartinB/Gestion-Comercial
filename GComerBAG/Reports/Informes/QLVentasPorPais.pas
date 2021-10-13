unit QLVentasPorPais;

interface

uses Classes, Controls, StdCtrls, ExtCtrls,
  Quickrpt, Graphics, Qrctrls;
type
  TQRLVentasPorPais = class(TQuickRep)
    tituloInforme: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData2: TQRSysData;
    cabGrupo: TQRGroup;
    pieGrupo: TQRBand;
    LTotalCliente: TQRLabel;
    cliente_sal_sc: TQRDBText;
    LPunto: TQRLabel;
    LCliente: TQRLabel;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    selecc: TQRMemo;
    QRBand1: TQRBand;
    PsQRDBText1: TQRDBText;
    n_albaran_sc: TQRDBText;
    importetotal: TQRDBText;
    moneda_sc: TQRDBText;
    n_factura_sc: TQRDBText;
    LGuion: TQRLabel;
    fecha_factura_sc: TQRDBText;
    nombre_c: TQRDBText;
    cliente: TQRDBText;
    QRBand2: TQRBand;
    QRSysData1: TQRSysData;
    LabTOTAL: TQRLabel;
    SummaryBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRExpr1: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRLabel9: TQRLabel;
    QRLabel2: TQRLabel;
    lblProducto: TQRLabel;
    procedure cabGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure pieGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure PsQRLabel8Print(sender: TObject; var Value: string);
  private

  public

  end;

var
  QRLVentasPorPais: TQRLVentasPorPais;
  tot, total: Real;
implementation

uses SysUtils, UDMBaseDatos;

{$R *.DFM}

procedure TQRLVentasPorPais.cabGrupoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  tot := 0;
end;

procedure TQRLVentasPorPais.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  tot := tot + importetotal.DataSet.FieldByName('importetotal').AsFloat;
  total := total + importetotal.DataSet.FieldByName('importetotal').AsFloat;
end;

procedure TQRLVentasPorPais.pieGrupoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  LabTOTAL.Caption := FormatFloat('###,###,###,##0.00;-###,###,###,##0.00;0.00', tot);
end;

procedure TQRLVentasPorPais.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  total := 0;
end;

procedure TQRLVentasPorPais.PsQRLabel8Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('###,###,###,##0.00;-###,###,###,##0.00;0.00', total);
end;

end.
