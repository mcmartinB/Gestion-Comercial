unit DetalleResumenEntradasQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLDetalleResumenEntradas = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblProducto: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRLabel2: TQRLabel;
    bndEntrega: TQRBand;
    QRBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    lblRango: TQRLabel;
    lblCentro: TQRLabel;
    QRLabel9: TQRLabel;
    lblVar: TQRLabel;
    qrgPlantacion: TQRGroup;
    qtxtproducto_e2l: TQRDBText;
    qtxtcosechero_e2l: TQRDBText;
    qrecategoria: TQRDBText;
    qrecalibre: TQRDBText;
    qtxtcajas: TQRDBText;
    bndTotalcos: TQRBand;
    qrxCajasPlantacion: TQRExpr;
    qrs1: TQRShape;
    qtxtplantacion_e2l: TQRDBText;
    qpeso: TQRDBText;
    qrxpr1: TQRExpr;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qtxtcajas_e1l1: TQRDBText;
    qrlbl3: TQRLabel;
    qrlblFlag: TQRLabel;
    procedure qrecategoriaPrint(sender: TObject; var Value: String);
    procedure qrecalibrePrint(sender: TObject; var Value: String);
    procedure qreformato_e1lPrint(sender: TObject; var Value: String);
    procedure qtxtcosechero_e2lPrint(sender: TObject; var Value: String);
    procedure qtxtplantacion_e2lPrint(sender: TObject; var Value: String);
    procedure qtxtproducto_e2lPrint(sender: TObject; var Value: String);
    procedure bndEntregaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qtxtcajas_e1l1Print(sender: TObject; var Value: String);
    procedure qrlbl3Print(sender: TObject; var Value: String);
    procedure qrxCajasPlantacionPrint(sender: TObject; var Value: String);
    procedure bndTotalcosAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
  private
    bFlag: boolean;
    sEntrada: string;
    rKilosLin: Real;
    rCajasLin: Integer;
  public

    procedure PreparaListado( const AEmpresa, ACentro, AProducto: string; const AFechaIni, AFechaFin: TDateTime;
                              const ACosechero, APlantacion, AFormato, ALogifruit, ACategoria, ACalibre: integer );
  end;

  function VerDetalleResumenEntradas( const AOwner: TComponent; const AEmpresa, ACentro, AProducto: string;
                               const AFechaIni, AFechaFin: TDateTime;
                               const ACosechero, APlantacion, AFormato, ALogifruit, ACategoria, ACalibre: integer ): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, DetalleEntradasDL, DPreview, UDMAuxDB, bMath;

var
  QLDetalleResumenEntradas: TQLDetalleResumenEntradas;


function VerDetalleResumenEntradas( const AOwner: TComponent; const AEmpresa, ACentro, AProducto: string;
                             const AFechaIni, AFechaFin: TDateTime;
                             const ACosechero, APlantacion, AFormato, ALogifruit, ACategoria, ACalibre: integer ): Boolean;
var
  sEmpresa, sCentro: string;
  dFechaIni, dFechaFin: TDateTime;
begin
  try
    sEmpresa:= AEmpresa;
    sCentro:= ACentro;
    dFechaIni:= AFechaIni;
    dFechaFin:= AFechaFin;
    result:= DetalleEntradasDL.ObtenerDatosResumen( AOwner, AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin,
                                 ACosechero, APlantacion, AFormato, ALogifruit, ACategoria, ACalibre );
    if result then
    begin
      QLDetalleResumenEntradas:= TQLDetalleResumenEntradas.Create( AOwner );
      try
        QLDetalleResumenEntradas.PreparaListado( AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin,
                                          ACosechero, APlantacion, AFormato, ALogifruit, ACategoria, ACalibre );
        Previsualiza( QLDetalleResumenEntradas );
      finally
        FreeAndNil( QLDetalleResumenEntradas );
      end;
    end;
  finally
    DetalleEntradasDL.CerrarTablas;
  end;
end;

procedure TQLDetalleResumenEntradas.PreparaListado( const AEmpresa, ACentro, AProducto: string; const AFechaIni, AFechaFin: TDateTime;
                              const ACosechero, APlantacion, AFormato, ALogifruit, ACategoria, ACalibre: integer );
begin
  PonLogoGrupoBonnysa( self, AEmpresa );
  lblCentro.Caption:= DesCentro( AEmpresa, ACentro );

  if AProducto <> '' then
    lblProducto.Caption:= AProducto + ' ' + desProducto( AEmpresa, AProducto )
  else
    lblProducto.Caption:= 'TODOS LOS PRODUCTOS';

  lblRango.Caption:= 'Del ' + DateToStr( AFechaIni ) + ' al ' + DateToStr( AFechaFin );
end;

procedure TQLDetalleResumenEntradas.qrecategoriaPrint(sender: TObject;
  var Value: String);
begin
  if Value = '1' then
    Value:= '1ª'
  else
  if Value = '2' then
    Value:= '2ª'
  else
    Value:= '';
end;

procedure TQLDetalleResumenEntradas.qrecalibrePrint(sender: TObject;
  var Value: String);
begin
  if Value = '1' then
    Value:= 'GR'
  else
  if Value = '0' then
    Value:= 'PQ'
  else
    Value:= '';
end;

procedure TQLDetalleResumenEntradas.qreformato_e1lPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desFormatoEntrada( DataSet.FieldByName('empresa_e2l').AsString,
                             DataSet.FieldByName('centro_e2l').AsString,
                             DataSet.FieldByName('producto_e2l').AsString, Value );
end;

procedure TQLDetalleResumenEntradas.qtxtcosechero_e2lPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desCosechero( DataSet.FieldByName('empresa_e2l').AsString,  Value );
end;

procedure TQLDetalleResumenEntradas.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  sEntrada:= '';
  rKilosLin:= 0;
  rCajasLin:= 0;
end;

procedure TQLDetalleResumenEntradas.bndEntregaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  bFlag:= sEntrada <> ( DataSet.FieldByName('empresa_e2l').AsString +
                        DataSet.FieldByName('producto_e2l').AsString +
                        DataSet.FieldByName('cosechero_e2l').AsString +
                        DataSet.FieldByName('plantacion_e2l').AsString +
                        DataSet.FieldByName('ano_sem_planta_e2l').AsString );
  if bFlag then
  begin
    sEntrada := ( DataSet.FieldByName('empresa_e2l').AsString +
                  DataSet.FieldByName('producto_e2l').AsString +
                  DataSet.FieldByName('cosechero_e2l').AsString +
                  DataSet.FieldByName('plantacion_e2l').AsString +
                  DataSet.FieldByName('ano_sem_planta_e2l').AsString );

    rKilosLin:= rKilosLin + DataSet.FieldByName('kilos_e2l').AsFloat;
    rCajasLin:= rCajasLin + DataSet.FieldByName('cajas_e2l').AsInteger;
  end;
end;

procedure TQLDetalleResumenEntradas.qtxtplantacion_e2lPrint(sender: TObject;
  var Value: String);
begin
  if bFlag then
  begin
    Value:= Value + ' ' + desPlantacion( DataSet.FieldByName('empresa_e2l').AsString,
                           DataSet.FieldByName('producto_e2l').AsString,
                           DataSet.FieldByName('cosechero_e2l').AsString,
                           Value, DataSet.FieldByName('ano_sem_planta_e2l').AsString )
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQLDetalleResumenEntradas.qtxtproducto_e2lPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProducto( DataSet.FieldByName('empresa_e2l').AsString,  Value );
end;


procedure TQLDetalleResumenEntradas.qtxtcajas_e1l1Print(sender: TObject;
  var Value: String);
begin
  if not bFlag then
  begin
    Value:= '';
  end;
end;

procedure TQLDetalleResumenEntradas.qrlbl3Print(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat('#,##0', rCajasLin );
end;

procedure TQLDetalleResumenEntradas.qrxCajasPlantacionPrint(
  sender: TObject; var Value: String);
begin
  qrlblFlag.Enabled:= Value <> FormatFloat( '#,##0', rCajasLin );
end;

procedure TQLDetalleResumenEntradas.bndTotalcosAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  rCajasLin:= 0;
end;

end.
