unit RInformeEntradas;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, DBTables;

type
  TQRInformeEntradas = class(TQuickRep)
    QListado: TQuery;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    SummaryBand1: TQRBand;
    TitleBand1: TQRBand;
    QRLabel3: TQRLabel;
    QRSysData3: TQRSysData;
    QRGroup1: TQRGroup;
    QRGroup2: TQRGroup;
    QRBandPieCosechero: TQRBand;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    QRExpr14: TQRExpr;
    QRExpr15: TQRExpr;
    QRExpr18: TQRExpr;
    QRExpr19: TQRExpr;
    QRExpr25: TQRExpr;
    QRLabel5: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel8: TQRLabel;
    lblRangoFecha1: TQRLabel;
    QRSysData1: TQRSysData;
    QRGroupProducto: TQRGroup;
    QRExpr9: TQRExpr;
    QRExpr8: TQRExpr;
    ChildBand1: TQRChildBand;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRPieGroupPlantacion: TQRBand;
    QRExpr3: TQRExpr;
    QRLabel4: TQRLabel;
    QRLabel15: TQRLabel;
    QRExpr17: TQRExpr;
    QRExpr20: TQRExpr;
    QRExpr21: TQRExpr;
    QRExpr22: TQRExpr;
    QRExpr23: TQRExpr;
    QRExpr24: TQRExpr;
    QRExpr26: TQRExpr;
    QRExpr27: TQRExpr;
    qrxpr1: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrxpr8: TQRExpr;
    qrxpr9: TQRExpr;
    qrxpr10: TQRExpr;
    qrlbl2: TQRLabel;
    qrlbl1: TQRLabel;
    qrlbl3: TQRLabel;
    BandaPieProducto: TQRBand;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
    qrxprEmpresa: TQRExpr;
    qrxprCentro: TQRExpr;
    qrxpr11: TQRExpr;
    qrxpr12: TQRExpr;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrxpr13: TQRExpr;
    qrxpr14: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr16: TQRExpr;
    procedure QRLabel8Print(sender: TObject; var Value: string);
    procedure QRLabel16Print(sender: TObject; var Value: string);
    procedure QRExpr25Print(sender: TObject; var Value: String);
    procedure QRExpr9Print(sender: TObject; var Value: String);
    procedure QRExpr8Print(sender: TObject; var Value: String);
    procedure QRGroupProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRPieGroupProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRExpr1Print(sender: TObject; var Value: String);
    procedure QRExpr2Print(sender: TObject; var Value: String);
    procedure QRLabel14Print(sender: TObject; var Value: String);
    procedure ExportarAExcel(sender: TObject; var Value: String);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRPieGroupPlantacionBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBandPieCosecheroBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PageFooterBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrxpr5Print(sender: TObject; var Value: String);
    procedure qrxpr11Print(sender: TObject; var Value: String);
    procedure qrxpr12Print(sender: TObject; var Value: String);
    procedure qrlbl5Print(sender: TObject; var Value: String);
    procedure qrlbl6Print(sender: TObject; var Value: String);
    procedure qrlbl4Print(sender: TObject; var Value: String);
    procedure qrxpr16Print(sender: TObject; var Value: String);
    procedure qrxpr13Print(sender: TObject; var Value: String);
    procedure qrxpr14Print(sender: TObject; var Value: String);
    procedure qrxpr15Print(sender: TObject; var Value: String);
  private

  public
    destructor destroy; override;
    constructor Create( AOwner: TComponent ); override;

    function LoadQuery( const APunto: Integer; const AEmpresa,ACentro,AProducto, AAgrupacion: string ): string;
  end;

var
  QRInformeEntradas: TQRInformeEntradas;

implementation

{$R *.DFM}

uses UDMAuxDB, UDMConfig;

function TQRInformeEntradas.LoadQuery( const APunto: Integer; const AEmpresa,ACentro,AProducto, AAgrupacion: string ): string;
begin
  begin
    QListado.SQL.Clear;
    QListado.SQL.Add('select empresa_e2l empresa, centro_e2l centro, producto_e2l producto, cosechero_e2l cosechero, ');
    QListado.SQL.Add('       plantacion_e2l plantacion, ano_sem_planta_e2l anyoSemana, fecha_e2l fecha, numero_entrada_e2l entrada, ');
    QListado.SQL.Add('       max(total_palets_ec) palets, sum( total_cajas_e2l ) cajas, sum( total_kgs_e2l ) kilos, max(peso_bruto_ec) bruto ');

    QListado.SQL.Add('from frf_entradas_c ');
    QListado.SQL.Add('     join frf_entradas2_l on empresa_e2l = empresa_ec and centro_e2l = centro_ec');
    QListado.SQL.Add('                          and numero_entrada_e2l = numero_entrada_ec  and fecha_e2l = fecha_ec ');
    QListado.SQL.Add('where fecha_ec between :fechaini and :fechafin ');

    if AEmpresa <> '' then
    begin
      QListado.SQL.Add('and  empresa_ec = :empresa');
    end;
    if ACentro <> '' then
    begin
      QListado.SQL.Add('and centro_ec = :centro ');
    end;
    if AProducto <> ''then
    begin
      QListado.SQL.Add('and producto_e2l = :producto ');
    end;

    if AAgrupacion <> '' then
      QListado.SQL.Add('  and producto_e2l in (select producto_a from frf_agrupacion where codigo_a = :agrupacion) ');

    QListado.SQL.Add('and cosechero_e2l between :cosecheroini and :cosecherofin ');
    QListado.SQL.Add('and plantacion_e2l between :plantacionini and :plantacionfin ');
    case APunto of
      1: QListado.SQL.Add(' and ( not trim(sectores_e2l) like ''.%'' or sectores_e2l is null ) ');
      2: QListado.SQL.Add(' and ( trim(sectores_e2l) like ''.%'' and not sectores_e2l is null ) ');
    end;
    QListado.SQL.Add('group by 1,2,3,4,5,6,7,8 ');
    QListado.SQL.Add('order by 1,2,3,4,5,6,7,8 ');
  end;
end;


constructor TQRInformeEntradas.Create( AOwner: TComponent );
begin
  inherited;
  LoadQuery( 0, '050', '1', 'TOM', '' );
end;


destructor TQRInformeEntradas.Destroy;
begin
  QListado.Close;
  inherited;
end;

procedure TQRInformeEntradas.QRLabel8Print(sender: TObject;
  var Value: string);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value := DataSet.FieldByName('centro').AsString + ' - ' +
      desCentro(DataSet.FieldByName('empresa').AsString, DataSet.FieldByName('centro').AsString);
end;

procedure TQRInformeEntradas.QRLabel16Print(sender: TObject;
  var Value: string);
begin
  Value := DataSet.FieldByName('empresa').AsString + ' - ' +
    desEmpresa(DataSet.FieldByName('empresa').AsString);
end;

procedure TQRInformeEntradas.QRExpr25Print(sender: TObject;
  var Value: String);
begin
  Value:=  'TOTAL ' + desCosechero(DataSet.FieldByName('empresa').AsString, Value);
end;

procedure TQRInformeEntradas.QRExpr9Print(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL ' + desProducto(DataSet.FieldByName('empresa').AsString, Value);
end;

procedure TQRInformeEntradas.QRExpr8Print(sender: TObject;
  var Value: String);
begin

  Value := 'TOTAL ' +
    desPlantacion(DataSet.FieldByName('empresa').AsString,
      DataSet.FieldByName('producto').AsString,
      DataSet.FieldByName('cosechero').AsString,
      Value, DataSet.FieldByName('anyosemana').AsString);
end;

procedure TQRInformeEntradas.QRGroupProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRInformeEntradas.QRPieGroupProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRInformeEntradas.QRExpr1Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - ' + desCosechero(DataSet.FieldByName('empresa').AsString, Value);
end;

procedure TQRInformeEntradas.QRExpr2Print(sender: TObject;
  var Value: String);
begin
  Value := DataSet.FieldByName('anyosemana').AsString + ' '  + Value + ' - ' +
    desPlantacion(DataSet.FieldByName('empresa').AsString,
      DataSet.FieldByName('producto').AsString,
      DataSet.FieldByName('cosechero').AsString,
      Value, DataSet.FieldByName('anyosemana').AsString);
end;


procedure TQRInformeEntradas.QRLabel14Print(sender: TObject;
  var Value: String);
begin
  if DMconfig.EsLaFont then
  begin
    Value:= '';
  end;
end;

procedure TQRInformeEntradas.ExportarAExcel(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= '';
end;

procedure TQRInformeEntradas.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRInformeEntradas.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRInformeEntradas.QRPieGroupPlantacionBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRInformeEntradas.QRBandPieCosecheroBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRInformeEntradas.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
    PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRInformeEntradas.PageFooterBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRInformeEntradas.qrxpr5Print(sender: TObject;
  var Value: String);
begin
  Value := Value + ' - ' +
      desProducto(DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRInformeEntradas.qrxpr11Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value:= desEmpresa( Value );
end;

procedure TQRInformeEntradas.qrxpr12Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value:= desCentro( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRInformeEntradas.qrlbl5Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value:= 'Empresa';
end;

procedure TQRInformeEntradas.qrlbl6Print(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value := DataSet.FieldByName('empresa').AsString + ' - ' + desEmpresa(DataSet.FieldByName('empresa').AsString);
end;

procedure TQRInformeEntradas.qrlbl4Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value:= 'Centro';
end;

procedure TQRInformeEntradas.qrxpr16Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value := desProducto(DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRInformeEntradas.qrxpr13Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value := desCosechero(DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRInformeEntradas.qrxpr14Print(sender: TObject;
  var Value: String);
begin
    if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value := DataSet.FieldByName('anyosemana').AsString;
end;

procedure TQRInformeEntradas.qrxpr15Print(sender: TObject;
  var Value: String);
begin
    if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value := desPlantacion(DataSet.FieldByName('empresa').AsString,
      DataSet.FieldByName('producto').AsString,
      DataSet.FieldByName('cosechero').AsString,
      Value, DataSet.FieldByName('anyosemana').AsString);
end;

end.
