unit StockFrutaPlantaQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLStockFrutaPlanta = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblCentro: TQRLabel;
    PageFooterBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRGroup1: TQRGroup;
    QRDBText9: TQRDBText;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRBand1: TQRBand;
    QRDBText10: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    SummaryBand1: TQRBand;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRLabel9: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRSysData1: TQRSysData;
    pais: TQRDBText;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    fecha: TQRDBText;
    QRGroupCabVariedad: TQRGroup;
    QRLabel12: TQRLabel;
    QRGroupPieVariedad: TQRBand;
    QRDBText11: TQRDBText;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRLabel3: TQRLabel;
    lblAcumVariedad: TQRLabel;
    lblAcumProducto: TQRLabel;
    lblAcumTotal: TQRLabel;
    QRLabel8: TQRLabel;
    lblPrecioVariedad: TQRLabel;
    lblPrecioProducto: TQRLabel;
    lblPrecioTotal: TQRLabel;
    lblImporte: TQRLabel;
    lblPrecio: TQRLabel;
    QRGroup2: TQRGroup;
    QRLabel13: TQRLabel;
    QRGroupPieCalibre: TQRBand;
    QRDBText3: TQRDBText;
    QRExpr1: TQRExpr;
    QRExpr4: TQRExpr;
    lblAcumCalibre: TQRLabel;
    lblPrecioCalibre: TQRLabel;
    lblRangoFechas: TQRLabel;
    procedure QRDBText10Print(sender: TObject; var Value: String);
    procedure fechaPrint(sender: TObject; var Value: String);
    procedure QRDBText11Print(sender: TObject; var Value: String);
    procedure QRGroupCabVariedadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroupPieVariedadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRLabel3Print(sender: TObject; var Value: String);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLabel8Print(sender: TObject; var Value: String);
    procedure QRDBText3Print(sender: TObject; var Value: String);
    procedure QRGroupPieCalibreBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    rAcumCalibre, rAcumVariedad, rAcumProducto, rAcumTotal: Real;
    rKilosCalibre, rKilosVariedad, rKilosProducto, rKilosTotal: Real;

  public
    bAgruparVariedad, bAgruparCalibre, bValorar: Boolean;
    procedure PreparaListado( const AEmpresa, ACentro, AProducto, AEntrega, AFecha: string;
                              const AProveedor, AVariedad, ACalibre, APais: string;
                              const AFEchaIni, AFechaFin: String );
  end;

  function VerListadoStock( const AOwner: TComponent;
                            const AEmpresa, ACentro, AProducto, AEntrega: string;
                            const AProveedor, AVariedad, ACalibre, APais: string;
                            const AFEchaIni, AFechaFin: String;
                            const AAgruparVariedad, AAgruparCalibre, AValorar: Boolean; const APlaceros: Integer ): Boolean;

  function VerListadoVolcados( const AOwner: TComponent;
                               const AEmpresa, ACentro, AProducto: string;
                               const AFechaIni, AFechaFin: TDateTime ): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, StockFrutaPlantaDL, DPreview, UDMAuxDB, bMath;

var
  QLStockFrutaPlanta: TQLStockFrutaPlanta;
  DLStockFrutaPlanta: TDLStockFrutaPlanta;

procedure VerListadoStockEx( const AOwner: TComponent;
                             const AEmpresa, ACentro, AProducto, AEntrega: string;
                             const AProveedor, AVariedad, ACalibre, APais: string;
                             const AFEchaIni, AFechaFin: String;
                             const AAgruparVariedad, AAgruparCalibre, AValorar: Boolean  );
begin
  QLStockFrutaPlanta:= TQLStockFrutaPlanta.Create( AOwner );
  try
    QLStockFrutaPlanta.PreparaListado( AEmpresa, ACentro, AProducto, AEntrega, '',
                         AProveedor, AVariedad, ACalibre, APais, AFEchaIni, AFechaFin );

    QLStockFrutaPlanta.bAgruparVariedad:= AAgruparVariedad;
    QLStockFrutaPlanta.bAgruparCalibre:= AAgruparCalibre;
    QLStockFrutaPlanta.bValorar:= AValorar;
    Previsualiza( QLStockFrutaPlanta );
  finally
    FreeAndNil( QLStockFrutaPlanta );
  end;
end;

function VerListadoStock( const AOwner: TComponent;
                          const AEmpresa, ACentro, AProducto, AEntrega: string ;
                          const AProveedor, AVariedad, ACalibre, APais: string;
                          const AFEchaIni, AFechaFin: String;
                          const AAgruparVariedad, AAgruparCalibre, AValorar: Boolean; const APlaceros: Integer ): Boolean;
begin
  DLStockFrutaPlanta:= TDLStockFrutaPlanta.Create( AOwner );
  try
    result:= DLStockFrutaPlanta.DatosQueryStock( AEmpresa, ACentro, AProducto, AEntrega,
                                   AProveedor, AVariedad, ACalibre, APais, AFEchaIni, AFechaFin, AValorar, APlaceros );
    if result then
    begin
      VerListadoStockEx( AOwner, AEmpresa, ACentro, AProducto, AEntrega,
                         AProveedor, AVariedad, ACalibre, APais, AFEchaIni, AFechaFin,
                         AAgruparVariedad, AAgruparCalibre, AValorar );
    end;
  finally
    FreeAndNil( DLStockFrutaPlanta );
  end;
end;

procedure VerListadoVolcadosEx( const AOwner: TComponent;
                                const AEmpresa, ACentro: string;
                                const AFechaIni, AFechaFin: TDateTime );
begin
  QLStockFrutaPlanta:= TQLStockFrutaPlanta.Create( AOwner );
  try
    QLStockFrutaPlanta.PreparaListado( AEmpresa, ACentro, '', '',  DateToStr( AFechaIni ),
                                       '', '', '', '', DateToStr( AFechaIni ), DateToStr( AFechaFin ) );
    Previsualiza( QLStockFrutaPlanta );
  finally
    FreeAndNil( QLStockFrutaPlanta );
  end;
end;

function VerListadoVolcados( const AOwner: TComponent;
                             const AEmpresa, ACentro, AProducto: string;
                             const AFechaIni, AFechaFin: TDateTime ): Boolean;
begin
  DLStockFrutaPlanta:= TDLStockFrutaPlanta.Create( AOwner );
  try
    result:= DLStockFrutaPlanta.DatosQueryVolcados( AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin );
    if result then
    begin
      VerListadoVolcadosEx( AOwner, AEmpresa, ACentro, AFEchaIni, AFechaFin );
    end;
  finally
    FreeAndNil( DLStockFrutaPlanta );
  end;
end;

procedure TQLStockFrutaPlanta.PreparaListado( const AEmpresa, ACentro, AProducto,AEntrega, AFecha: string;
                                              const AProveedor, AVariedad, ACalibre, APais: string;
                                              const AFEchaIni, AFechaFin: String );
begin
  PonLogoGrupoBonnysa( self, AEmpresa );
  lblCentro.Caption:= DesCentro( AEmpresa, ACentro );
  if AFecha <> '' then
  begin
    if AFechaIni <> AFechaFin then
      lblTitulo.Caption:= 'PALETS VOLCADOS DEL "' + AFechaIni + '" AL "' + AFechaFin + '"'
    else
      lblTitulo.Caption:= 'PALETS VOLCADOS EL "' + AFecha + '"';
  end
  else
  begin
    if ( AProveedor <> '' ) or ( AVariedad <> '' ) or
       ( ACalibre <> '' ) or (  APais <> '' ) or
       ( AFEchaIni <> '' ) or  ( AFechaFin <> '' ) then
    begin
      lblTitulo.Caption:= 'STOCK PARCIAL FRUTA PROVEEDOR';
    end
    else
    begin
      lblTitulo.Caption:= 'STOCK ACTUAL FRUTA PROVEEDOR';
    end;
  end;

  if ( AFEchaIni <> '' ) and  ( AFechaFin <> '' ) then
  begin
    lblRangoFechas.Caption:= 'ALTA DEL ' + AFEchaIni + ' AL ' + AFEchaFin;
  end
  else
  if ( AFEchaIni <> '' ) then
  begin
    lblRangoFechas.Caption:= 'ALTA DESDE EL ' + AFEchaIni;
  end
  else
  if ( AFechaFin <> '' ) then
  begin
    lblRangoFechas.Caption:= 'ALTA HASTA EL ' + AFEchaFin;
  end
  else
  begin
    lblRangoFechas.Caption:= '';
  end
end;

procedure TQLStockFrutaPlanta.QRDBText10Print(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL ' + Value;
end;

procedure TQLStockFrutaPlanta.fechaPrint(sender: TObject;
  var Value: String);
begin
  if Value <> '' then
    Value:= FormatDateTime('dd/mm/yy', DLStockFrutaPlanta.QListadoStock.FieldByName('fecha').AsDateTime );
end;

procedure TQLStockFrutaPlanta.QRDBText11Print(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL ' + Value;
end;

procedure TQLStockFrutaPlanta.QRGroupCabVariedadBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= False;
end;

procedure TQLStockFrutaPlanta.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rAcumCalibre:= 0;
  rAcumVariedad:= 0;
  rAcumProducto:= 0;
  rAcumTotal:= 0;

  rKilosCalibre:= 0;
  rKilosVariedad:= 0;
  rKilosProducto:= 0;
  rKilosTotal:= 0;
end;

procedure TQLStockFrutaPlanta.QRLabel3Print(sender: TObject;
  var Value: String);
begin
  if bValorar then
  begin
    Value:= 'Importe';
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQLStockFrutaPlanta.QRLabel8Print(sender: TObject;
  var Value: String);
begin
  if bValorar then
  begin
    Value:= 'Precio';
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQLStockFrutaPlanta.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  rKilosCal, rKilosTot, rImporteCal, rImporteGas: real;
  rKilosLin, rImporteLin: real;
begin
  if bValorar then
  begin
    rKilosLin:= DLStockFrutaPlanta.QListadoStock.FieldByName('peso').AsFloat;

    if rKilosLin < 0 then
    begin
      lblPrecio.Caption:= '0.00';
      lblPrecio.Caption:= '0.000';
      exit
    end;

    DLStockFrutaPlanta.ObtenerGastos(
      DLStockFrutaPlanta.QListadoStock.FieldByName( 'entrega' ).AsString,
      DLStockFrutaPlanta.QListadoStock.FieldByName( 'producto' ).AsString,
      DLStockFrutaPlanta.QListadoStock.FieldByName( 'variedad' ).AsString,
      DLStockFrutaPlanta.QListadoStock.FieldByName( 'calibre' ).AsString,
      rKilosCal, rKilosTot, rImporteCal, rImporteGas);

    if ( rImporteCal < 0 ) or ( rKilosCal < 0 )then
    begin
      lblPrecio.Caption:= '0.00';
      lblPrecio.Caption:= '0.000';
      exit
    end;


    rImporteLin:= 0;
    if rKilosTot <> 0 then
      rImporteLin:= bRoundTo( ( rKilosCal * rImporteGas ) / rKilosTot, -2 );
    rImporteLin:= bRoundTo( rImporteLin + rImporteCal, -2 );
    if rKilosCal <> 0 then
      rImporteLin:= bRoundTo( ( rKilosLin * rImporteLin ) / rKilosCal, -2 );

    lblImporte.Caption:= FormatFloat( '#,##0.00', rImporteLin );
    if rKilosLin <> 0 then
      lblPrecio.Caption:= FormatFloat( '#,##0.000', rImporteLin / rKilosLin )
    else
      lblPrecio.Caption:= '';

    rAcumCalibre:= rAcumCalibre + rImporteLin;
    rAcumVariedad:= rAcumVariedad + rImporteLin;
    rAcumProducto:= rAcumProducto + rImporteLin;
    rAcumTotal:= rAcumTotal + rImporteLin;

    rKilosCalibre:= rKilosCalibre + rKilosLin;
    rKilosVariedad:= rKilosVariedad + rKilosLin;
    rKilosProducto:= rKilosProducto + rKilosLin;
    rKilosTotal:= rKilosTotal + rKilosLin;
  end
  else
  begin
    lblImporte.Caption:= '';
    lblPrecio.Caption:= '';
  end;
end;

procedure TQLStockFrutaPlanta.QRGroupPieCalibreBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bAgruparCalibre;
  if bValorar then
  begin
    lblAcumCalibre.Caption:= FormatFloat( '#,##0.00', rAcumCalibre );
    if rKilosCalibre <> 0 then
      lblPrecioCalibre.Caption:= FormatFloat( '#,##0.000', rAcumCalibre / rKilosCalibre )
    else
      lblPrecioCalibre.Caption:= '0.000';

    rAcumCalibre:= 0;
    rKilosCalibre:= 0;
  end
  else
  begin
    lblAcumCalibre.Caption:= '';
    lblPrecioCalibre.Caption:= '';
  end;
end;

procedure TQLStockFrutaPlanta.QRGroupPieVariedadBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bAgruparVariedad;
  if bValorar then
  begin
    lblAcumVariedad.Caption:= FormatFloat( '#,##0.00', rAcumVariedad );
    if rKilosVariedad <> 0 then
      lblPrecioVariedad.Caption:= FormatFloat( '#,##0.000', rAcumVariedad / rKilosVariedad )
    else
      lblPrecioVariedad.Caption:= '0.000';

    rAcumVariedad:= 0;
    rKilosVariedad:= 0;
  end
  else
  begin
    lblAcumVariedad.Caption:= '';
    lblPrecioVariedad.Caption:= '';
  end;
end;

procedure TQLStockFrutaPlanta.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if bValorar then
  begin
    lblAcumProducto.Caption:= FormatFloat( '#,##0.00', rAcumProducto );
    if rKilosProducto <> 0 then
      lblPrecioProducto.Caption:= FormatFloat( '#,##0.000', rAcumProducto / rKilosProducto )
    else
      lblPrecioProducto.Caption:= '0.000';

    rAcumProducto:= 0;
    rKilosProducto:= 0;
  end
  else
  begin
    lblAcumProducto.Caption:= '';
    lblPrecioProducto.Caption:= '';
  end;
end;

procedure TQLStockFrutaPlanta.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if bValorar then
  begin
    lblAcumTotal.Caption:= FormatFloat( '#,##0.00', rAcumTotal );
    (*
    if rKilosTotal <> 0 then
      lblPrecioTotal.Caption:= FormatFloat( '#,##0.000', rAcumTotal / rKilosTotal )
    else
      lblPrecioTotal.Caption:= '0.000';
    *)
    rAcumTotal:= 0;
    rKilosTotal:= 0;
  end
  else
  begin
    lblAcumTotal.Caption:= '';
    (*
    lblPrecioTotal.Caption:= '';
    *)
  end;
  //El precio total no tiene sentido, no mezclemos higos con platanos ....
  lblPrecioTotal.Caption:= '';
end;

procedure TQLStockFrutaPlanta.QRDBText3Print(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL CALIBRE ' + Value;
end;

end.
