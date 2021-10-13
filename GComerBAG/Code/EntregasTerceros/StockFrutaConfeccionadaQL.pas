unit StockFrutaConfeccionadaQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLStockFrutaConfeccionada = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblCentro: TQRLabel;
    PageFooterBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText8: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRSysData1: TQRSysData;
    QRDBText3: TQRDBText;
    QRDBText7: TQRDBText;
    lblClientes: TQRLabel;
    procedure QRDBText7Print(sender: TObject; var Value: String);
  private
    sEmpresa: String;
  public
    procedure PreparaListado( const AEmpresa, ACentro, ACliente, AFechaDesde, AFechaHasta: string );
  end;

  function VerListadoStockConfeccionado( const AOwner: TComponent;
                            const AEmpresa, ACentro, ACliente: string; const ANumericos: Boolean ): Boolean;
  function VerListadoPaletsConfeccionados( const AOwner: TComponent;
                               const AEmpresa, ACentro, ACliente: string;
                               const AFechaDesde, AFechaHasta: TDateTime; const ANumericos: Boolean ): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, StockFrutaConfeccionadaDL, DPreview, UDMAuxDB;

var
  QLStockFrutaConfeccionada: TQLStockFrutaConfeccionada;
  DLStockFrutaConfeccionada: TDLStockFrutaConfeccionada;

procedure VerListadoStockConfeccionadoEx( const AOwner: TComponent; const AEmpresa, ACentro, ACliente: string );
begin
  QLStockFrutaConfeccionada:= TQLStockFrutaConfeccionada.Create( AOwner );
  try
    QLStockFrutaConfeccionada.PreparaListado( AEmpresa, ACentro, ACliente, '', '' );
    Previsualiza( QLStockFrutaConfeccionada );
  finally
    FreeAndNil( QLStockFrutaConfeccionada );
  end;
end;

function VerListadoStockConfeccionado( const AOwner: TComponent; const AEmpresa, ACentro, ACliente: string; const ANumericos: Boolean ): Boolean;
begin
  DLStockFrutaConfeccionada:= TDLStockFrutaConfeccionada.Create( AOwner );
  try
    result:= DLStockFrutaConfeccionada.DatosQueryStock( AEmpresa, ACentro, ACliente, ANumericos );
    if result then
    begin
      VerListadoStockConfeccionadoEx( AOwner, AEmpresa, ACentro, ACliente );
    end;
  finally
    FreeAndNil( DLStockFrutaConfeccionada );
  end;
end;

procedure VerListadoPaletsConfeccionadosEx( const AOwner: TComponent;
                                const AEmpresa, ACentro, ACliente: string;
                                const AFechaDesde, AFechaHasta: TDateTime );
begin
  QLStockFrutaConfeccionada:= TQLStockFrutaConfeccionada.Create( AOwner );
  try
    QLStockFrutaConfeccionada.PreparaListado( AEmpresa, ACentro, ACliente, DateToStr( AFechaDesde) , DateToStr( AFechaHasta ) );
    Previsualiza( QLStockFrutaConfeccionada );
  finally
    FreeAndNil( QLStockFrutaConfeccionada );
  end;
end;

function VerListadoPaletsConfeccionados( const AOwner: TComponent;
                             const AEmpresa, ACentro, ACliente: string;
                             const AFechaDesde, AFechaHasta: TDateTime; const ANumericos: Boolean ): Boolean;
begin
  DLStockFrutaConfeccionada:= TDLStockFrutaConfeccionada.Create( AOwner );
  try
    result:= DLStockFrutaConfeccionada.DatosQueryConfeccionado( AEmpresa, ACentro, ACliente, AFechaDesde, AFechaHasta, ANumericos );
    if result then
    begin
      VerListadoPaletsConfeccionadosEx( AOwner, AEmpresa, ACentro, ACliente, AFechaDesde, AFechaHasta );
    end;
  finally
    FreeAndNil( DLStockFrutaConfeccionada );
  end;
end;

procedure TQLStockFrutaConfeccionada.PreparaListado( const AEmpresa, ACentro, ACliente, AFechaDesde, AFechaHasta: string );
begin
  PonLogoGrupoBonnysa( self, AEmpresa );
  lblCentro.Caption:= DesCentro( AEmpresa, ACentro );
  if ACliente <> '' then
    lblClientes.Caption:= DesCliente( ACliente )
  else
    lblClientes.Caption:= 'TODOS LOS CLIENTES';
  sEmpresa:= AEmpresa;
  if AFechaDesde <> '' then
  begin
    if AFechaDesde <> AFechaHasta then
      lblTitulo.Caption:= 'PALETS CONFECCIONADOS DEL "' + AFechadesde + '" AL "'  + AFechaHasta + '"'
    else
      lblTitulo.Caption:= 'PALETS CONFECCIONADOS EL "' + AFechadesde + '"';
  end
  else
    lblTitulo.Caption:= 'STOCK FRUTA CONFECCIONADA';
end;

procedure TQLStockFrutaConfeccionada.QRDBText7Print(sender: TObject;
  var Value: String);
begin
  Value:= desProductoBase( sEmpresa, Value );
end;

end.
