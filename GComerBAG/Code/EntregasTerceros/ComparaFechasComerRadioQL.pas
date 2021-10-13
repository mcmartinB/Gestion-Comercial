unit ComparaFechasComerRadioQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLComparaFechasComerRadio = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    bndEntrega: TQRBand;
    codigo_ec: TQRDBText;
    QRBand1: TQRBand;
    QRSysData1: TQRSysData;
    fecha_entrega: TQRDBText;
    fecha_palet: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    lblRango: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    producto: TQRDBText;
    qrgCentro: TQRGroup;
    qrecentro_llegada_ec: TQRDBText;
    qrlCentro: TQRLabel;
    lblProducto: TQRLabel;
    procedure qrecentro_llegada_ecPrint(sender: TObject;
      var Value: String);
    procedure productoPrint(sender: TObject; var Value: String);
  private

  public

    procedure PreparaListado( const AEmpresa, AProducto: string;
                              const AFechaIni, AFechaFin: TDateTime );
  end;

function VerComparaComerRadio( const AOwner: TComponent; const AEntrega, AEmpresa, AProducto: string;
                               const AFechaIni, AFechaFin: TDateTime; const AStock: integer;
                               const AOrdenProducto: Boolean): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, ComparaFechasComerRadioDL, DPreview, UDMAuxDB, bMath;

var
  QLComparaFechasComerRadio: TQLComparaFechasComerRadio;


function VerComparaComerRadio( const AOwner: TComponent; const AEntrega, AEmpresa, AProducto: string;
                               const AFechaIni, AFechaFin: TDateTime; const AStock: integer;
                               const AOrdenProducto: Boolean): Boolean;
var
  sEmpresa: string;
  dFechaIni, dFechaFin: TDateTime;
begin
  try
    sEmpresa:= AEmpresa;
    dFechaIni:= AFechaIni;
    dFechaFin:= AFechaFin;
    result:= ComparaFechasComerRadioDL.ObtenerDatos( AOwner, AEntrega, AProducto, sEmpresa,
                                     dFechaIni, dFechaFin, AStock, AOrdenProducto );
    if result then
    begin
      QLComparaFechasComerRadio:= TQLComparaFechasComerRadio.Create( AOwner );
      try
        QLComparaFechasComerRadio.PreparaListado( sEmpresa, AProducto, dFechaIni, dFechaFin );
        Previsualiza( QLComparaFechasComerRadio );
      finally
        FreeAndNil( QLComparaFechasComerRadio );
      end;
    end;
  finally
    ComparaFechasComerRadioDL.CerrarTablas;
  end;
end;

procedure TQLComparaFechasComerRadio.PreparaListado( const AEmpresa, AProducto: string;
                                               const AFechaIni, AFechaFin: TDateTime );
begin
  PonLogoGrupoBonnysa( self, AEmpresa );

  if AProducto <> '' then
    lblProducto.Caption:= AProducto + ' ' + desProducto( AEmpresa, AProducto )
  else
    lblProducto.Caption:= 'TODOS LOS PRODUCTOS';

  lblRango.Caption:= 'Del ' + DateToStr( AFechaIni ) + ' al ' + DateToStr( AFechaFin );

end;

procedure TQLComparaFechasComerRadio.qrecentro_llegada_ecPrint(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' '  + desCentro( DataSet.fieldbyname('empresa_Ec').AsString, Value );
end;

procedure TQLComparaFechasComerRadio.productoPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' '  + desProducto( DataSet.fieldbyname('empresa_Ec').AsString, Value );
end;

end.
