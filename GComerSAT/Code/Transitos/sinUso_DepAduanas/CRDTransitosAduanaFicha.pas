unit CRDTransitosAduanaFicha;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TRDTransitosAduanaFicha = class(TQuickRep)
    DetailBand1: TQRBand;
    ChildBand1: TQRChildBand;
    ChildBand2: TQRChildBand;
    QRDBText1: TQRDBText;
    n_cmr_tc: TQRDBText;
    embarque_dac: TQRDBText;
    ChildBand3: TQRChildBand;
    ChildBand4: TQRChildBand;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    dua_exporta_dac: TQRDBText;
    fact_val_estadistico_dac: TQRDBText;
    dvd_dac: TQRDBText;
    kilos_tl: TQRDBText;
    fecha_entrada_dda_dac: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRSubDetail1: TQRSubDetail;
    QRBand1: TQRBand;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    fecha_dal: TQRDBText;
    dvd_dac_2: TQRDBText;
    kilos_dal: TQRDBText;
    cliente_dal: TQRDBText;
    dua_consumo_dal: TQRDBText;
    QRShape22: TQRShape;
    QRShape23: TQRShape;
    QRShape24: TQRShape;
    QRShape25: TQRShape;
    QRShape26: TQRShape;
    QRSubDetail3: TQRSubDetail;
    QRBand5: TQRBand;
    fecha_das: TQRDBText;
    n_albaran_das: TQRDBText;
    qretransporte_das: TQRDBText;
    vehiculo_das: TQRDBText;
    kilos_das: TQRDBText;
    QRShape43: TQRShape;
    QRShape44: TQRShape;
    QRShape45: TQRShape;
    QRShape46: TQRShape;
    QRShape47: TQRShape;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRShape48: TQRShape;
    QRLabel25: TQRLabel;
    QRShape38: TQRShape;
    QRShape39: TQRShape;
    QRShape40: TQRShape;
    QRShape41: TQRShape;
    QRShape42: TQRShape;
    QRShape49: TQRShape;
    logoTitle: TQRImage;
    QRShape50: TQRShape;
    QRLabel26: TQRLabel;
    QRShape51: TQRShape;
    observaciones_dal: TQRDBText;
    lblLinea2: TQRLabel;
    ChildBand8: TQRChildBand;
    QRShape27: TQRShape;
    QRShape28: TQRShape;
    QRShape29: TQRShape;
    QRShape30: TQRShape;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRShape35: TQRShape;
    QRShape34: TQRShape;
    QRShape33: TQRShape;
    QRShape32: TQRShape;
    factura_dac: TQRDBText;
    buque_tc: TQRDBText;
    vehiculo_tc: TQRDBText;
    transporte_tc: TQRDBText;
    QRShape36: TQRShape;
    QRLabel28: TQRLabel;
    QRShape53: TQRShape;
    QRShape55: TQRShape;
    QRShape58: TQRShape;
    qremanipulacion_dac: TQRDBText;
    qremercancia_dac: TQRDBText;
    qreseguridad_dac: TQRDBText;
    QRShape31: TQRShape;
    QRShape37: TQRShape;
    QRLabel27: TQRLabel;
    QRLabel29: TQRLabel;
    bndPieDetalle: TQRBand;
    QRExpr1: TQRExpr;
    bndPieSalidas: TQRBand;
    QRExpr2: TQRExpr;
    sum_kilos_dal: TQRDBText;
    qrs1: TQRShape;
    qrs2: TQRShape;
    qrs3: TQRShape;
    qrs4: TQRShape;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrs5: TQRShape;
    qrl5: TQRLabel;
    qrs6: TQRShape;
    qrs7: TQRShape;
    qrs8: TQRShape;
    qrs9: TQRShape;
    qrs10: TQRShape;
    qrefrigorifico_dac: TQRDBText;
    qrecombustible_dac: TQRDBText;
    qrerappel_dac: TQRDBText;
    qreflete_dac: TQRDBText;
    qrxTotal: TQRExpr;
    qrsPlataformaSal: TQRShape;
    qrlPlataformaSal: TQRLabel;
    qrsPlataformaSal_: TQRShape;
    n_factura_das: TQRLabel;
    frigorifico_das: TQRLabel;
    qrlCostePlataforma: TQRLabel;
    procedure transporte_tcPrint(sender: TObject; var Value: String);
    procedure cliente_dalPrint(sender: TObject; var Value: String);
    procedure n_cmr_tcPrint(sender: TObject; var Value: String);
    procedure QRExpr1Print(sender: TObject; var Value: String);
    procedure sum_kilos_dalPrint(sender: TObject; var Value: String);
    procedure QRSubDetail3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure bndPieSalidasBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    rCostePlataforma: real;
  public
    sEmpresa: string;
  end;

function ImprimirFichaDepositoAduana( const AOwner: TComponent;
                                      const ACodigo: Integer; const AEmpresa: string ): boolean;

implementation

{$R *.DFM}

uses
  CDDTransitosAduanaFicha, DPreview, Dialogs, cVariables, UDMAuxDB, bMath;

var
  RDTransitosAduanaFicha: TRDTransitosAduanaFicha;
  DDTransitosAduanaFicha: TDDTransitosAduanaFicha;

function ImprimirFichaDepositoAduana( const AOwner: TComponent;
                                      const ACodigo: Integer; const AEmpresa: string ): boolean;
begin
  result:= false;
  RDTransitosAduanaFicha:= TRDTransitosAduanaFicha.Create( AOwner );
  DDTransitosAduanaFicha:= TDDTransitosAduanaFicha.Create( AOwner );
  try
    try
      result:= DDTransitosAduanaFicha.FichaDatosAduana( ACodigo );
      if result then
      begin
        RDTransitosAduanaFicha.sEmpresa:= AEmpresa;
        if FileExists(gsDirActual + '\recursos\LogoGrupoBonnysa.emf') then
          RDTransitosAduanaFicha.logoTitle.Picture.LoadFromFile(gsDirActual + '\recursos\LogoGrupoBonnysa.emf');
        Preview( RDTransitosAduanaFicha );
        RDTransitosAduanaFicha:= nil;
      end;
    except
      FreeAndNil( RDTransitosAduanaFicha );
    end;
  finally
    FreeAndNil( DDTransitosAduanaFicha );
    if RDTransitosAduanaFicha <> nil then
      FreeAndNil( RDTransitosAduanaFicha );
  end;
end;

procedure TRDTransitosAduanaFicha.transporte_tcPrint(sender: TObject;
  var Value: String);
begin
  Value:= desTransporte( sEmpresa, Value );
end;

procedure TRDTransitosAduanaFicha.cliente_dalPrint(sender: TObject;
  var Value: String);
var
  sLinea1, sLinea2: string;
begin
  sLinea1:= '';
  sLinea2:= '';
  DDTransitosAduanaFicha.DatosCliente( sEmpresa, Value, sLinea1, sLinea2 );
  Value:= sLinea1;
  lblLinea2.Caption:= sLinea2;
end;

procedure TRDTransitosAduanaFicha.n_cmr_tcPrint(sender: TObject;
  var Value: String);
begin
  Value:= 'T' + Value;
end;

procedure TRDTransitosAduanaFicha.QRExpr1Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + Value;
end;

procedure TRDTransitosAduanaFicha.sum_kilos_dalPrint(sender: TObject;
  var Value: String);
var
  rAux: real;
begin
  rAux:= DDTransitosAduanaFicha.QKilosTransito.FieldByName('kilos_tl').AsFloat;
  rAux:= rAux - DDTransitosAduanaFicha.QKilosDetalle.FieldByName('kilos_dal').AsFloat;
  Value:= 'SOCK PENDIENTE ' + FormatFloat('#,##0.00', rAux );
end;

procedure TRDTransitosAduanaFicha.QRSubDetail3BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  iAux: Integer;
  dAux: TDateTime;
  rAux: real;
begin

  if DDTransitosAduanaFicha.QDatosDepositoSal.FieldByName('n_factura_das').AsString = '' then
  begin
    n_factura_das.Caption:= DDTransitosAduanaFicha.GetNumeroFactura( sEmpresa,
              DDTransitosAduanaFicha.QDatosDepositoSal.FieldByName('centro_salida_das').AsString,
              DDTransitosAduanaFicha.QDatosDepositoSal.FieldByName('fecha_das').AsDateTime,
              DDTransitosAduanaFicha.QDatosDepositoSal.FieldByName('n_albaran_das').AsInteger, iAux, dAux, rAux );

    rAux:= bRoundTo( rAux * DDTransitosAduanaFicha.QDatosDepositoSal.FieldByName('kilos_das').AsFloat, 2);
    frigorifico_das.Caption:= FormatFloat('#,##0.00', rAux );
  end
  else
  begin
    n_factura_das.Caption:= DDTransitosAduanaFicha.QDatosDepositoSal.FieldByName('n_factura_das').AsString;
    rAux:= DDTransitosAduanaFicha.QDatosDepositoSal.FieldByName('frigorifico_das').AsFloat;
    frigorifico_das.Caption:= FormatFloat('#,##0.00', rAux );
  end;
  rCostePlataforma:= rCostePlataforma + rAux;
end;

procedure TRDTransitosAduanaFicha.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  rCostePlataforma:= 0;
end;

procedure TRDTransitosAduanaFicha.bndPieSalidasBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrlCostePlataforma.Caption:= FormatFloat('#,##0.00', rCostePlataforma );
  rCostePlataforma:= 0;
end;

end.
