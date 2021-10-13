unit DetalleEntradasQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLDetalleEntradas = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblProducto: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRLabel2: TQRLabel;
    DIFF: TQRLabel;
    bndEntrega: TQRBand;
    qrefecha_alta: TQRDBText;
    QRBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    lblRango: TQRLabel;
    lblCentro: TQRLabel;
    QRLabel9: TQRLabel;
    lblVar: TQRLabel;
    lblCal: TQRLabel;
    qrgPlantacion: TQRGroup;
    qreproducto: TQRDBText;
    qrecosechero: TQRDBText;
    qreplantacion: TQRDBText;
    qralbaran_entrada: TQRDBText;
    qreformato: TQRDBText;
    qrsscc: TQRDBText;
    qrecategoria: TQRDBText;
    qrecalibre: TQRDBText;
    qrcajas: TQRDBText;
    bndTotalcos: TQRBand;
    qrxCajasPlantacion: TQRExpr;
    qrgEntrega: TQRGroup;
    bndPieEntrega: TQRBand;
    qrxCajasEntrega: TQRExpr;
    qrs1: TQRShape;
    qrkilos: TQRDBText;
    qrlbl1: TQRLabel;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    procedure qrecategoriaPrint(sender: TObject; var Value: String);
    procedure qrecalibrePrint(sender: TObject; var Value: String);
    procedure qreformatoPrint(sender: TObject; var Value: String);
    procedure qrecosecheroPrint(sender: TObject; var Value: String);
    procedure qreplantacionPrint(sender: TObject; var Value: String);
    procedure qreproductoPrint(sender: TObject; var Value: String);
    procedure bndEntregaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrefecha_altaPrint(sender: TObject; var Value: String);
    procedure qralbaran_entradaPrint(sender: TObject;
      var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrgEntregaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    bFlag: boolean;
    sEntrada: string;

  public

    procedure PreparaListado( const AEmpresa, ACentro, AProducto: string; const AFechaIni, AFechaFin: TDateTime;
                              const ACosechero, APlantacion, AFormato, ALogifruit, ACategoria, ACalibre: integer );
  end;

  function VerDetalleEntradas( const AOwner: TComponent; const AEmpresa, ACentro, AProducto: string;
                               const AFechaIni, AFechaFin: TDateTime;
                               const ACosechero, APlantacion, AFormato, ALogifruit, ACategoria, ACalibre: integer ): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, DetalleEntradasDL, DPreview, UDMAuxDB, bMath;

var
  QLDetalleEntradas: TQLDetalleEntradas;


function VerDetalleEntradas( const AOwner: TComponent; const AEmpresa, ACentro, AProducto: string;
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
    result:= DetalleEntradasDL.ObtenerDatosDetalle( AOwner, AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin,
                                 ACosechero, APlantacion, AFormato, ALogifruit, ACategoria, ACalibre );
    if result then
    begin
      QLDetalleEntradas:= TQLDetalleEntradas.Create( AOwner );
      try
        QLDetalleEntradas.PreparaListado( AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin,
                                          ACosechero, APlantacion, AFormato, ALogifruit, ACategoria, ACalibre );
        Previsualiza( QLDetalleEntradas );
      finally
        FreeAndNil( QLDetalleEntradas );
      end;
    end;
  finally                                       
    DetalleEntradasDL.CerrarTablas;
  end;
end;

procedure TQLDetalleEntradas.PreparaListado( const AEmpresa, ACentro, AProducto: string; const AFechaIni, AFechaFin: TDateTime;
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

procedure TQLDetalleEntradas.qrecategoriaPrint(sender: TObject;
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

procedure TQLDetalleEntradas.qrecalibrePrint(sender: TObject;
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

procedure TQLDetalleEntradas.qreformatoPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desFormatoEntrada( DataSet.FieldByName('empresa').AsString,
                             DataSet.FieldByName('centro').AsString,
                             DataSet.FieldByName('producto').AsString, Value );
end;

procedure TQLDetalleEntradas.qrecosecheroPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desCosechero( DataSet.FieldByName('empresa').AsString,  Value );
end;

procedure TQLDetalleEntradas.qreplantacionPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desPlantacion( DataSet.FieldByName('empresa').AsString,
                         DataSet.FieldByName('producto').AsString,
                         DataSet.FieldByName('cosechero').AsString,
                         Value, DataSet.FieldByName('anyo_semana').AsString );
end;

procedure TQLDetalleEntradas.qreproductoPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProducto( DataSet.FieldByName('empresa').AsString,  Value );
end;

procedure TQLDetalleEntradas.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  sEntrada:= '';
end;

procedure TQLDetalleEntradas.bndEntregaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  bFlag:= sEntrada <> ( DataSet.FieldByName('fecha_alta').AsString +
                        DataSet.FieldByName('albaran_entrada').AsString );
  if bFlag then
  begin
    sEntrada := ( DataSet.FieldByName('fecha_alta').AsString +
                  DataSet.FieldByName('albaran_entrada').AsString );
  end; 
end;

procedure TQLDetalleEntradas.qrefecha_altaPrint(sender: TObject;
  var Value: String);
begin
  if not bFlag then
    Value:= '';
end;

procedure TQLDetalleEntradas.qralbaran_entradaPrint(sender: TObject;
  var Value: String);
begin
  if not bFlag then
    Value:= '';
end;

procedure TQLDetalleEntradas.qrgEntregaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrgEntrega.Height:= 0;
end;

end.
