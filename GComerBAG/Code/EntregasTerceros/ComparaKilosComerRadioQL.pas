unit ComparaKilosComerRadioQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLComparaKilosComerRadio = class(TQuickRep)
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
    lblVar: TQRLabel;
    lblCal: TQRLabel;
    variedad_el: TQRDBText;
    calibre_el: TQRDBText;
    qrlMatricula: TQRLabel;
    qrlAlbaran: TQRLabel;
    qrlKilos: TQRLabel;
    qrevehiculo_ec: TQRDBText;
    qrealbaran_ec: TQRDBText;
    qreproveedor: TQRDBText;
    qrlProveedor2: TQRLabel;
    qrgCab1: TQRGroup;
    qrgCab2: TQRGroup;
    bndPie1: TQRBand;
    bndPie2: TQRBand;
    qrefecha_ec: TQRDBText;
    qrlFecha: TQRLabel;
    unidades_comer: TQRDBText;
    unidades_rf: TQRDBText;
    qrx1: TQRExpr;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    procedure qreproveedorPrint(sender: TObject; var Value: String);
    procedure producto_elPrint(sender: TObject; var Value: String);
    procedure qrgCabAntesDeImprimir(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPie2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public

    procedure PreparaListado( const AEmpresa, ACentro, AProducto, AProveedor: string;
                              const AFechaIni, AFechaFin: TDateTime;
                              const AOrdenProducto, AAgruparCalibre: boolean );
  end;

   function VerComparaComerRadio( const AOwner: TComponent;
                                  const AEntrega, AEmpresa, ACentro, AProducto, AProveedor: string;
                                  const AFechaIni, AFechaFin: TDateTime;
                                  const ADifCajas, ADifUnidades, ADifKilos: Boolean;
                                  const AStock: integer;
                                  const AOrdenProducto, ADesglosarCalibre: Boolean): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, ComparaKilosComerRadioDL, DPreview, UDMAuxDB, bMath;

var
  QLComparaKilosComerRadio: TQLComparaKilosComerRadio;


function VerComparaComerRadio( const AOwner: TComponent; const AEntrega, AEmpresa, ACentro, AProducto, AProveedor : string;
                               const AFechaIni, AFechaFin: TDateTime;
                               const ADifCajas, ADifUnidades, ADifKilos: Boolean;
                               const AStock: integer;
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
    result:= ComparaKilosComerRadioDL.ObtenerDatos( AOwner, AEntrega, AProducto, AProveedor, sEmpresa, sCentro,
               dFechaIni, dFechaFin, ADifCajas, ADifUnidades, ADifKilos, AStock, AOrdenProducto, ADesglosarCalibre );
    if result then
    begin
      QLComparaKilosComerRadio:= TQLComparaKilosComerRadio.Create( AOwner );
      try
        QLComparaKilosComerRadio.PreparaListado( sEmpresa, sCentro, AProducto, AProveedor, dFechaIni, dFechaFin, AOrdenProducto, ADesglosarCalibre );
        Previsualiza( QLComparaKilosComerRadio );
      finally
        FreeAndNil( QLComparaKilosComerRadio );
      end;
    end;
  finally
    ComparaKilosComerRadioDL.CerrarTablas;
  end;
end;

procedure TQLComparaKilosComerRadio.PreparaListado( const AEmpresa, ACentro, AProducto, AProveedor: string;
                                               const AFechaIni, AFechaFin: TDateTime;
                                               const AOrdenProducto, AAgruparCalibre: boolean );
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

  if AOrdenProducto then
  begin
    qrgCab1.Expression:= '[producto_el]';
    qrgCab2.Expression:= '[producto_el]+[proveedor_ec]';
  end
  else
  begin
    qrgCab1.Expression:= '[proveedor_ec]';
    qrgCab2.Expression:= '[proveedor_ec]+[producto_el]';
  end;

end;

procedure TQLComparaKilosComerRadio.qreproveedorPrint(sender: TObject;
  var Value: String);
begin
  Value:= desProveedor( DataSet.FieldByname('empresa_ec').AsString, DataSet.FieldByname('proveedor_ec').AsString );
end;

procedure TQLComparaKilosComerRadio.producto_elPrint(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( DataSet.FieldByname('empresa_ec').AsString, DataSet.FieldByname('producto_el').AsString )
end;

procedure TQLComparaKilosComerRadio.qrgCabAntesDeImprimir(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  Sender.Height:= 0;
end;

procedure TQLComparaKilosComerRadio.bndPie2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  Sender.Height:= 0;
end;

end.
