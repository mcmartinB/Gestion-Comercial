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
    logoTitle: TQRImage;
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
    procedure transporte_tcPrint(sender: TObject; var Value: String);
    procedure n_cmr_tcPrint(sender: TObject; var Value: String);
    procedure QRExpr1Print(sender: TObject; var Value: String);
  private

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

end.
