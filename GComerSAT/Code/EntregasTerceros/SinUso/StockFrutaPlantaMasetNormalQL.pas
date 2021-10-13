unit StockFrutaPlantaMasetNormalQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLStockFrutaPlantaMasetNormal = class(TQuickRep)
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
    lblMatricula: TQRDBText;
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
    albaran: TQRDBText;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    lblFecha_llegada: TQRDBText;
    qrgSemana: TQRGroup;
    bndPieSemana: TQRBand;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    qrgVariedad: TQRGroup;
    bndPieVariedad: TQRBand;
    lblFecha_carga: TQRDBText;
    lblPalets: TQRDBText;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    QRExpr12: TQRExpr;
    lblFacturaConduce: TQRLabel;
    factura_conduce: TQRDBText;
    QRLabel3: TQRLabel;
    status: TQRDBText;
    lblRangoFechas: TQRLabel;
    peso_teorico: TQRDBText;
    QRLabel8: TQRLabel;
    QRExpr14: TQRExpr;
    QRExpr15: TQRExpr;
    QRExpr16: TQRExpr;
    qrlUnidades: TQRLabel;
    qrgVariedadCalibre: TQRGroup;
    bndPieVariedadCalibre: TQRBand;
    QRLabel13: TQRLabel;
    qrl1: TQRLabel;
    QRDBText3: TQRDBText;
    QRExpr7: TQRExpr;
    QRExpr1: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr13: TQRExpr;
    QRDBText4: TQRDBText;
    QRExpr17: TQRExpr;
    QRExpr18: TQRExpr;
    QRExpr19: TQRExpr;
    QRExpr20: TQRExpr;
    qrlAgrupaSemana: TQRLabel;
    qreAlbaran: TQRDBText;
    qreUnidades: TQRDBText;
    qreUnidadesCalibre: TQRDBText;
    qreUnidadesVariedad: TQRDBText;
    qreSemana: TQRDBText;
    qreProducto: TQRDBText;
    qreUnidadesTotal: TQRDBText;
    procedure QRDBText10Print(sender: TObject; var Value: String);
    procedure lblFecha_llegadaPrint(sender: TObject; var Value: String);
    procedure QRDBText11Print(sender: TObject; var Value: String);
    procedure qrgSemanaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRDBText3Print(sender: TObject; var Value: String);
    procedure lblFecha_cargaPrint(sender: TObject; var Value: String);
    procedure albaranPrint(sender: TObject; var Value: String);
    procedure statusPrint(sender: TObject; var Value: String);
    procedure bndPieVariedadCalibreBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgVariedadCalibreBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPieVariedadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qreAlbaranPrint(sender: TObject; var Value: String);
    procedure qreUnidadesPrint(sender: TObject; var Value: String);
    procedure qreUnidadesCalibrePrint(sender: TObject; var Value: String);
    procedure qreUnidadesVariedadPrint(sender: TObject; var Value: String);
    procedure qreSemanaPrint(sender: TObject; var Value: String);
    procedure qreProductoPrint(sender: TObject; var Value: String);
    procedure qreUnidadesTotalPrint(sender: TObject; var Value: String);
  private
    iUnidadesCalibre, iUnidadesVariedad, iUnidadesSemana, iUnidadesProducto, iUnidadesTotal: Integer;

  public
    bAgruparVariedad, bAgruparCalibre: Boolean;
    procedure PreparaListado( const AEmpresa, ACentro, AProducto, ASemana, AEntrega, AFecha: string;
                              const AProveedor, Variedad, ACalibre, APais, AFechaIni, AFechaFin: string );
  end;

  function VerListadoStock( const AOwner: TComponent;
                            const AEmpresa, ACentro, AProducto, ASemana, AEntrega: string;
                            const AProveedor, AVariedad, ACalibre, APais: string;
                            const AFEchaIni, AFechaFin: String;
                            const AAgruparVariedad, AAgruparCalibre, AIgnorarPlatano: Boolean ): Boolean;
  function VerListadoVolcados( const AOwner: TComponent;
                               const AEmpresa, ACentro, AProducto: string;
                               const AFechaIni, AFechaFin: TDateTime ): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, StockFrutaPlantaMasetDL, DPreview, UDMAuxDB, bMath;

var
  QLStockFrutaPlantaMasetNorma: TQLStockFrutaPlantaMasetNormal;
  DLStockFrutaPlantaMaset: TDLStockFrutaPlantaMaset;

procedure VerListadoStockEx( const AOwner: TComponent;
                             const AEmpresa, ACentro, AProducto, ASemana, AEntrega: string;
                             const AProveedor, Variedad, ACalibre, APais: string;
                             const AFEchaIni, AFechaFin: String;
                             const AAgruparVariedad, AAgruparCalibre: Boolean  );
begin
  QLStockFrutaPlantaMasetNorma:= TQLStockFrutaPlantaMasetNormal.Create( AOwner );
  try
    QLStockFrutaPlantaMasetNorma.PreparaListado( AEmpresa, ACentro, AProducto, ASemana, AEntrega, '',
                                            AProveedor, Variedad, ACalibre, APais,
                                            AFechaIni, AFechaFin );
    QLStockFrutaPlantaMasetNorma.bAgruparVariedad:= AAgruparVariedad;
    QLStockFrutaPlantaMasetNorma.bAgruparCalibre:= AAgruparCalibre;

    Previsualiza( QLStockFrutaPlantaMasetNorma );
  finally
    FreeAndNil( QLStockFrutaPlantaMasetNorma );
  end;
end;

function VerListadoStock( const AOwner: TComponent;
                          const AEmpresa, ACentro, AProducto, ASemana, AEntrega: string ;
                          const AProveedor, AVariedad, ACalibre, APais: string;
                          const AFEchaIni, AFechaFin: String;
                          const AAgruparVariedad, AAgruparCalibre, AIgnorarPlatano: Boolean ): Boolean;
begin
  DLStockFrutaPlantaMaset:= TDLStockFrutaPlantaMaset.Create( AOwner );
  try
    result:= DLStockFrutaPlantaMaset.DatosQueryStock( AEmpresa, ACentro, AProducto, ASemana, AEntrega,
               AProveedor, AVariedad, ACalibre, APais, AFEchaIni, AFechaFin, AAgruparVariedad, AIgnorarPlatano );
    if result then
    begin
      VerListadoStockEx( AOwner, AEmpresa, ACentro, AProducto, ASemana, AEntrega, AProveedor,
                                 AVariedad, ACalibre, APais, AFEchaIni, AFechaFin,
                                 AAgruparVariedad, AAgruparCalibre );
    end;
  finally
    FreeAndNil( DLStockFrutaPlantaMaset );
  end;
end;

procedure VerListadoVolcadosEx( const AOwner: TComponent;
                                const AEmpresa, ACentro: string;
                                const AFechaIni, AFechaFin: TDateTime );
begin
  QLStockFrutaPlantaMasetNorma:= TQLStockFrutaPlantaMasetNormal.Create( AOwner );
  try
    QLStockFrutaPlantaMasetNorma.PreparaListado( AEmpresa, ACentro, '', '', '', DateToStr( AFechaIni ),
                                            '', '', '', '', DateToStr( AFechaIni ), DateToStr( AFechaFin ) );

    Previsualiza( QLStockFrutaPlantaMasetNorma );
  finally
    FreeAndNil( QLStockFrutaPlantaMasetNorma );
  end;
end;

function VerListadoVolcados( const AOwner: TComponent;
                             const AEmpresa, ACentro, AProducto: string;
                             const AFechaIni, AFechaFin: TDateTime ): Boolean;
begin
  DLStockFrutaPlantaMaset:= TDLStockFrutaPlantaMaset.Create( AOwner );
  try
    result:= DLStockFrutaPlantaMaset.DatosQueryVolcados( AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin );
    if result then
    begin
      VerListadoVolcadosEx( AOwner, AEmpresa, ACentro, AFechaIni, AFechaFin );
    end;
  finally
    FreeAndNil( DLStockFrutaPlantaMaset );
  end;
end;

procedure TQLStockFrutaPlantaMasetNormal.PreparaListado( const AEmpresa, ACentro, AProducto, ASemana, AEntrega, AFecha: string;
                                                   const AProveedor, Variedad, ACalibre, APais, AFechaIni, AFechaFin: string );
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
    if ( AProveedor <> '' ) or ( Variedad <> '' ) or
       ( ACalibre <> '' ) or (  APais <> '' ) or
       ( AFEchaIni <> '' ) or  ( AFechaFin <> '' ) or
       ( ASemana <> '' ) then
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
    if ASemana <> '' then
    begin
      lblRangoFechas.Caption:= 'SEMANA: ' + ASemana;
    end
    else
    begin
      lblRangoFechas.Caption:= '';
    end;
  end;

  if ( AEmpresa = '037' ) and ( AProducto = 'P' ) then
  begin
    qrgSemana.Expression:=  '[descripcion_p] + [albaran]';
    qrgSemana.Enabled:= True;
    bndPieSemana.Enabled:= True;
    qrgVariedad.Expression:=  '[descripcion_p] + [albaran] + [descripcion_breve_pp]';
    qrgVariedadCalibre.Expression:=  ' [descripcion_p] + [albaran] + [descripcion_breve_pp]+ [calibre]';
  end
  else
  begin
    qrgSemana.Expression:=  '';
    qrgSemana.Enabled:= False;
    bndPieSemana.Enabled:= False;
    qrgVariedad.Expression:=  '[descripcion_p]+ [descripcion_breve_pp]';
    qrgVariedadCalibre.Expression:=  ' [descripcion_p]+ [descripcion_breve_pp]+ [calibre]';
  end;
end;

procedure TQLStockFrutaPlantaMasetNormal.QRDBText10Print(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL ' + Value;
end;

procedure TQLStockFrutaPlantaMasetNormal.lblFecha_llegadaPrint(sender: TObject;
  var Value: String);
begin
  if Value <> '' then
    Value:= FormatDateTime('dd/mm/yy', DLStockFrutaPlantaMaset.QListadoStock.FieldByName('fecha_llegada').AsDateTime );
end;

procedure TQLStockFrutaPlantaMasetNormal.lblFecha_cargaPrint(sender: TObject;
  var Value: String);
begin
  if Value <> '' then
    Value:= FormatDateTime('dd/mm/yy', DLStockFrutaPlantaMaset.QListadoStock.FieldByName('fecha_carga').AsDateTime );
end;

procedure TQLStockFrutaPlantaMasetNormal.QRDBText11Print(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL ' + Value;
end;

procedure TQLStockFrutaPlantaMasetNormal.qrgSemanaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= False;
end;

procedure TQLStockFrutaPlantaMasetNormal.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  iUnidadesCalibre:= 0;
  iUnidadesVariedad:= 0;
  iUnidadesSemana:= 0;
  iUnidadesProducto:= 0;
  iUnidadesTotal:= 0;
end;


procedure TQLStockFrutaPlantaMasetNormal.QRDBText3Print(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL CALIBRE ' + Value;
end;

procedure TQLStockFrutaPlantaMasetNormal.albaranPrint(sender: TObject;
  var Value: String);
begin
  if DLStockFrutaPlantaMaset.QListadoStock.FieldByName('producto').AsString = 'P' then
  begin
    //Value:= Copy( Value, 0, 2 );
    Value:= Value;
  end
  else
  begin
    Value:= DLStockFrutaPlantaMaset.QListadoStock.FieldByName('pais').AsString;
  end;
end;

procedure TQLStockFrutaPlantaMasetNormal.statusPrint(sender: TObject;
  var Value: String);
begin
  if ( Value = 'S' ) or ( Value = 'V' ) then
  begin
    Value:= '';
  end;
end;

procedure TQLStockFrutaPlantaMasetNormal.bndPieVariedadCalibreBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bAgruparCalibre;
end;

procedure TQLStockFrutaPlantaMasetNormal.qrgVariedadCalibreBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= False;
end;

procedure TQLStockFrutaPlantaMasetNormal.bndPieVariedadBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bAgruparVariedad;
end;

procedure TQLStockFrutaPlantaMasetNormal.qreAlbaranPrint(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL SEMANA ' + Value;
end;

procedure TQLStockFrutaPlantaMasetNormal.qreUnidadesPrint(sender: TObject;
  var Value: String);
var
  iAux: Integer;
begin
  iAux:= 0;
  if TryStrToInt( DLStockFrutaPlantaMaset.QListadoStock.FieldByName('calibre').AsString, iAux ) then
  begin
    iAux:= DLStockFrutaPlantaMaset.QListadoStock.FieldByName('cajas').AsInteger * iAux;
  end;

  Value:= IntToStr( iAux );

  iUnidadesCalibre:= iUnidadesCalibre + iAux;
  iUnidadesVariedad:= iUnidadesVariedad + iAux;
  iUnidadesSemana:= iUnidadesSemana + iAux;
  iUnidadesProducto:= iUnidadesProducto + iAux;
  iUnidadesTotal:= iUnidadesTotal + iAux;
end;

procedure TQLStockFrutaPlantaMasetNormal.qreUnidadesCalibrePrint(sender: TObject;
  var Value: String);
begin
  Value:= IntToStr( iUnidadesCalibre );
  iUnidadesCalibre:= 0;
end;

procedure TQLStockFrutaPlantaMasetNormal.qreUnidadesVariedadPrint(
  sender: TObject; var Value: String);
begin
  Value:= IntToStr( iUnidadesVariedad );
  iUnidadesVariedad:= 0;
end;

procedure TQLStockFrutaPlantaMasetNormal.qreSemanaPrint(sender: TObject;
  var Value: String);
begin
  Value:= IntToStr( iUnidadesSemana );
  iUnidadesSemana:= 0;
end;

procedure TQLStockFrutaPlantaMasetNormal.qreProductoPrint(sender: TObject;
  var Value: String);
begin
  Value:= IntToStr( iUnidadesProducto );
  iUnidadesProducto:= 0;
end;

procedure TQLStockFrutaPlantaMasetNormal.qreUnidadesTotalPrint(sender: TObject;
  var Value: String);
begin
  Value:= IntToStr( iUnidadesTotal );
  iUnidadesTotal:= 0;
end;

end.
