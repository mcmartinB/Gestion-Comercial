unit ValorarFrutaPlantaQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLValorarFrutaPlanta = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
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
    procedure QRDBText10Print(sender: TObject; var Value: String);
    procedure fechaPrint(sender: TObject; var Value: String);
    procedure QRDBText11Print(sender: TObject; var Value: String);
    procedure QRGroupCabVariedadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroupPieVariedadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText3Print(sender: TObject; var Value: String);
    procedure QRGroupPieCalibreBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    rAcumCalibre, rAcumVariedad, rAcumProducto, rAcumTotal: Real;
    rKilosCalibre, rKilosVariedad, rKilosProducto, rKilosTotal: Real;

  public
    bAgruparVariedad, bAgruparCalibre: Boolean;
    procedure PreparaListado( const AEmpresa, AProducto, AEntregaDesde, AEntregaHasta: string );
  end;

  function VerListadoStock( const AOwner: TComponent;
                            const AEmpresa, AProducto, AEntregaDesde, AEntregaHasta: string;
                            const AAgruparVariedad, AAgruparCalibre: Boolean ): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, ValorarFrutaPlantaDL, DPreview, UDMAuxDB, bMath;

var
  QLValorarFrutaPlanta: TQLValorarFrutaPlanta;
  DLValorarFrutaPlanta: TDLValorarFrutaPlanta;

procedure VerListadoStockEx( const AOwner: TComponent;
                             const AEmpresa, AProducto, AEntregaDesde, AEntregaHasta: string;
                             const AAgruparVariedad, AAgruparCalibre: Boolean  );
begin
  QLValorarFrutaPlanta:= TQLValorarFrutaPlanta.Create( AOwner );
  try
    QLValorarFrutaPlanta.PreparaListado( AEmpresa, AProducto, AEntregaDesde, AEntregaHasta );
    QLValorarFrutaPlanta.bAgruparVariedad:= AAgruparVariedad;
    QLValorarFrutaPlanta.bAgruparCalibre:= AAgruparCalibre;
    Previsualiza( QLValorarFrutaPlanta );
  finally
    FreeAndNil( QLValorarFrutaPlanta );
  end;
end;

function VerListadoStock( const AOwner: TComponent;
                          const AEmpresa, AProducto, AEntregaDesde, AEntregaHasta: string;
                          const AAgruparVariedad, AAgruparCalibre: Boolean ): Boolean;
begin
  DLValorarFrutaPlanta:= TDLValorarFrutaPlanta.Create( AOwner );
  try
    result:= DLValorarFrutaPlanta.DatosQueryStock( AEmpresa, AProducto, AEntregaDesde, AEntregaHasta );
    if result then
    begin
      VerListadoStockEx( AOwner, AEmpresa, AProducto, AEntregaDesde, AEntregaHasta, AAgruparVariedad, AAgruparCalibre );
    end;
  finally
    FreeAndNil( DLValorarFrutaPlanta );
  end;
end;

procedure TQLValorarFrutaPlanta.PreparaListado( const AEmpresa, AProducto, AEntregaDesde, AEntregaHasta: string );
begin
  PonLogoGrupoBonnysa( self, AEmpresa );
  lblTitulo.Caption:= 'VALORAR FRUTA PLANTA';
end;

procedure TQLValorarFrutaPlanta.QRDBText10Print(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL ' + Value;
end;

procedure TQLValorarFrutaPlanta.fechaPrint(sender: TObject;
  var Value: String);
begin
  if Value <> '' then
    Value:= FormatDateTime('dd/mm/yy', DLValorarFrutaPlanta.QListadoStock.FieldByName('fecha').AsDateTime );
end;

procedure TQLValorarFrutaPlanta.QRDBText11Print(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL ' + Value;
end;

procedure TQLValorarFrutaPlanta.QRGroupCabVariedadBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= False;
end;

procedure TQLValorarFrutaPlanta.QuickRepBeforePrint(Sender: TCustomQuickRep;
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

procedure TQLValorarFrutaPlanta.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  rKilosCal, rKilosTot, rImporteCal, rImporteGas: real;
  rKilosLin, rImporteLin: real;
begin
    rKilosLin:= DLValorarFrutaPlanta.QListadoStock.FieldByName('peso').AsFloat;

    if rKilosLin < 0 then
    begin
      lblPrecio.Caption:= '0.00';
      lblPrecio.Caption:= '0.000';
      exit
    end;

    DLValorarFrutaPlanta.ObtenerGastos(
        DLValorarFrutaPlanta.QListadoStock.FieldByName( 'entrega' ).AsString,
        DLValorarFrutaPlanta.QListadoStock.FieldByName( 'producto' ).AsString,
        DLValorarFrutaPlanta.QListadoStock.FieldByName( 'variedad' ).AsString,
        DLValorarFrutaPlanta.QListadoStock.FieldByName( 'calibre' ).AsString,
        rKilosCal, rKilosTot, rImporteCal, rImporteGas);

    if ( rImporteCal < 0 ) or ( rKilosCal < 0 )then
    begin
      lblPrecio.Caption:= '0.00';
      lblPrecio.Caption:= '0.000';
      exit;
    end;

    rImporteLin:= 0;
    if rKilosTot <> 0 then
      rImporteLin:= bRoundTo( ( rKilosCal * rImporteGas ) / rKilosTot, -2 );
    rImporteLin:= bRoundTo( rImporteLin + rImporteCal, -2 );

    (*
    if rKilosCal <> 0 then
      rImporteLin:= bRoundTo( ( rKilosLin * rImporteLin ) / rKilosCal, -2 )
    else
      rImporteLin:= 0;
    *)

    if rImporteLin = 0 then
    begin
      lblPrecio.Caption:= 'ERR';
      lblImporte.Caption:= 'ERR';
    end
    else
    begin
      if rKilosLin <> 0 then
      begin
        lblPrecio.Caption:= FormatFloat( '#,##0.000', rImporteLin / rKilosLin );
        lblImporte.Caption:= FormatFloat( '#,##0.00', rImporteLin );
      end
      else
      begin
        lblImporte.Caption:= FormatFloat( '#,##0.00', rImporteLin );
        lblPrecio.Caption:= 'ERR';
      end;
    end;

    rAcumCalibre:= rAcumCalibre + rImporteLin;
    rAcumVariedad:= rAcumVariedad + rImporteLin;
    rAcumProducto:= rAcumProducto + rImporteLin;
    rAcumTotal:= rAcumTotal + rImporteLin;

    rKilosCalibre:= rKilosCalibre + rKilosLin;
    rKilosVariedad:= rKilosVariedad + rKilosLin;
    rKilosProducto:= rKilosProducto + rKilosLin;
    rKilosTotal:= rKilosTotal + rKilosLin;
end;

procedure TQLValorarFrutaPlanta.QRGroupPieCalibreBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bAgruparCalibre;
    lblAcumCalibre.Caption:= FormatFloat( '#,##0.00', rAcumCalibre );
    if rKilosCalibre <> 0 then
      lblPrecioCalibre.Caption:= FormatFloat( '#,##0.000', rAcumCalibre / rKilosCalibre )
    else
      lblPrecioCalibre.Caption:= '0.000';

    rAcumCalibre:= 0;
    rKilosCalibre:= 0;
end;

procedure TQLValorarFrutaPlanta.QRGroupPieVariedadBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bAgruparVariedad;
    lblAcumVariedad.Caption:= FormatFloat( '#,##0.00', rAcumVariedad );
    if rKilosVariedad <> 0 then
      lblPrecioVariedad.Caption:= FormatFloat( '#,##0.000', rAcumVariedad / rKilosVariedad )
    else
      lblPrecioVariedad.Caption:= '0.000';

    rAcumVariedad:= 0;
    rKilosVariedad:= 0;
end;

procedure TQLValorarFrutaPlanta.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
    lblAcumProducto.Caption:= FormatFloat( '#,##0.00', rAcumProducto );
    if rKilosProducto <> 0 then
      lblPrecioProducto.Caption:= FormatFloat( '#,##0.000', rAcumProducto / rKilosProducto )
    else
      lblPrecioProducto.Caption:= '0.000';

    rAcumProducto:= 0;
    rKilosProducto:= 0;
end;

procedure TQLValorarFrutaPlanta.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
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

  //El precio total no tiene sentido, no mezclemos higos con platanos ....
  lblPrecioTotal.Caption:= '';
end;

procedure TQLValorarFrutaPlanta.QRDBText3Print(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL CALIBRE ' + Value;
end;

end.
