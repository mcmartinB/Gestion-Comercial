unit ComparaComerRadioQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLComparaComerRadio = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblProducto: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    DIFF: TQRLabel;
    bndEntrega: TQRBand;
    cajas_comer: TQRDBText;
    codigo_ec: TQRDBText;
    QRBand1: TQRBand;
    QRSysData1: TQRSysData;
    cajas_rf: TQRDBText;
    dif_cajas: TQRExpr;
    kilos_comer: TQRDBText;
    kilos_rf: TQRDBText;
    dif_kilos: TQRExpr;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    lblRango: TQRLabel;
    QRLabel7: TQRLabel;
    lblCentro: TQRLabel;
    QRLabel8: TQRLabel;
    producto_el: TQRDBText;
    QRLabel9: TQRLabel;
    stock_rf: TQRDBText;
    lblVar: TQRLabel;
    lblCal: TQRLabel;
    variedad_el: TQRDBText;
    calibre_el: TQRDBText;
  private

  public

    procedure PreparaListado( const AEmpresa, ACentro, AProducto: string;
                              const AFechaIni, AFechaFin: TDateTime;
                              const AAgruparCalibre: boolean );
  end;

   function VerComparaComerRadio( const AOwner: TComponent;
                                  const AEntrega, AEmpresa, ACentro, AProducto: string;
                                  const AFechaIni, AFechaFin: TDateTime;
                                  const ATipoDif, AStock: integer;
                                  const AOrdenProducto, ADesglosarCalibre: Boolean): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, ComparaComerRadioDL, DPreview, UDMAuxDB, bMath;

var
  QLComparaComerRadio: TQLComparaComerRadio;


function VerComparaComerRadio( const AOwner: TComponent; const AEntrega, AEmpresa, ACentro, AProducto: string;
                               const AFechaIni, AFechaFin: TDateTime;
                               const ATipoDif, AStock: integer;
                               const AOrdenProducto, ADesglosarCalibre: Boolean): Boolean;
var
  sEmpresa, sCentro: string;
  dFechaIni, dFechaFin: TDateTime;
begin
  try
    sEmpresa:= AEmpresa;
    sCentro:= ACentro;
    dFechaIni:= AFechaIni;
    dFechaFin:= AFechaFin;
    result:= ComparaComerRadioDL.ObtenerDatos( AOwner, AEntrega, AProducto, sEmpresa, sCentro,
               dFechaIni, dFechaFin, ATipoDif, AStock, AOrdenProducto, ADesglosarCalibre );
    if result then
    begin
      QLComparaComerRadio:= TQLComparaComerRadio.Create( AOwner );
      try
        QLComparaComerRadio.PreparaListado( sEmpresa, sCentro, AProducto, dFechaIni, dFechaFin, ADesglosarCalibre );
        Previsualiza( QLComparaComerRadio );
      finally
        FreeAndNil( QLComparaComerRadio );
      end;
    end;
  finally
    ComparaComerRadioDL.CerrarTablas;
  end;
end;

procedure TQLComparaComerRadio.PreparaListado( const AEmpresa, ACentro, AProducto: string;
                                               const AFechaIni, AFechaFin: TDateTime;
                                               const AAgruparCalibre: boolean );
begin
  PonLogoGrupoBonnysa( self, AEmpresa );
  lblCentro.Caption:= DesCentro( AEmpresa, ACentro );

  if AProducto <> '' then
    lblProducto.Caption:= AProducto + ' ' + desProducto( AEmpresa, AProducto )
  else
    lblProducto.Caption:= 'TODOS LOS PRODUCTOS';

  lblRango.Caption:= 'Del ' + DateToStr( AFechaIni ) + ' al ' + DateToStr( AFechaFin );

  lblCal.Enabled:= AAgruparCalibre;
  lblVar.Enabled:= AAgruparCalibre;
  calibre_el.Enabled:= AAgruparCalibre;
  variedad_el.Enabled:= AAgruparCalibre;

end;

end.
