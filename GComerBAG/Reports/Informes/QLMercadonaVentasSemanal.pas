unit QLMercadonaVentasSemanal;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DBClient, Provider, DB,
  DBTables, kbmMemTable;

type
  TQRLMercadonaVentasSemanal = class(TQuickRep)
    Query1: TQuery;
    Query2: TQuery;
    ColumnHeaderBand1: TQRBand;
    QRLabel3: TQRLabel;
    QRSysData1: TQRSysData;
    PageFooterBand1: TQRBand;
    QRSysData2: TQRSysData;
    QRLabel25: TQRLabel;
    lblCliente: TQRLabel;
    ChildBand3: TQRChildBand;
    QRLabel17: TQRLabel;
    SemanaAnterior: TQRLabel;
    QRLabel19: TQRLabel;
    SemanaActual: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel20: TQRLabel;
    mtListado: TkbmMemTable;
    bnddeatlle: TQRBand;
    QRLblDescripcion: TQRDBText;
    qreantkilos: TQRDBText;
    qreantprecio: TQRDBText;
    qreactkilos: TQRDBText;
    qreactprecio: TQRDBText;
    qredifkilos: TQRDBText;
    qreporcenkilos: TQRDBText;
    qredifprecio: TQRDBText;
    qreporcenprecio: TQRDBText;
    qrgCabUnidad: TQRGroup;
    bndPieUnidad: TQRBand;
    qrs2: TQRShape;
    qreTotaLabel: TQRDBText;
    qrxAntKilos: TQRExpr;
    qrxActPrecio: TQRExpr;
    qrxDifKilos: TQRExpr;
    qrlAntPrecio: TQRLabel;
    qrlActPrecio: TQRLabel;
    qrlPorcenKilos: TQRLabel;
    qrlDifPrecio: TQRLabel;
    qrlPorcenPrecio: TQRLabel;
    qrlSemana: TQRLabel;
    procedure QRExpr1Print(sender: TObject; var Value: String);
    procedure qreTotaLabelPrint(sender: TObject; var Value: String);
    procedure QRLblDescripcionPrint(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure bndPieUnidadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qreporcenkilosPrint(sender: TObject; var Value: String);
    procedure qreantkilosPrint(sender: TObject; var Value: String);
  private
    antKilos, antImporte: real;
    actKilos, actImporte: real;

    procedure DatosQuery1;
    procedure DatosQuery2;
  public

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function DatosListado( const ACliente: string; const AFechaIniAct, AFechaFinAct, AFechaIniAnt, AFechaFinAnt: TDateTime ): boolean;
  end;

var
  QRLMercadonaVentasSemanal: TQRLMercadonaVentasSemanal;

implementation

{$R *.DFM}

uses UDMbaseDatos, UDMAuxDB, CVariables, bMath, UDMConfig, Variants;

constructor TQRLMercadonaVentasSemanal.Create(AOwner: TComponent);
begin
  inherited;

  with Query1 do
  begin
    SQL.Clear;
    SQL.Add(' select  ');
    SQL.Add('        case when empresa_sl = ''073'' or empresa_sl = ''F18'' then ''U'' else ''K'' end unidad, ');
    SQL.Add('        descripcion_p nproducto, ');
    SQL.Add('        sum( case when empresa_sl = ''073'' or empresa_sl = ''F18'' then cajas_sl * unidades_caja_sl ');
    SQL.Add('                  else kilos_sl end ) kilos, ');
    SQL.Add('        sum(importe_neto_sl) importe ');
    SQL.Add(' from frf_salidas_c, frf_salidas_l, frf_productos ');
    SQL.Add(' where cliente_sl = :cliente ');
    SQL.Add(' and fecha_sl between :fechaini and :fechafin ');
    SQL.Add(' and producto_p = producto_sl ');
    SQL.Add(' and empresa_sc = empresa_sl ');
    SQL.Add(' and centro_salida_sc = centro_salida_sl ');
    SQL.Add(' and n_albaran_sc = n_albaran_sl ');
    SQL.Add(' and fecha_sc = fecha_sl ');
    SQL.Add(' and es_transito_sc <> 2 ');           //Tipo Salida: Devolucion
    SQL.Add(' group by 1, 2 ');
    SQL.Add(' order by 1, 2 ');
  end;

  with Query2 do
  begin
    SQL.Clear;
    SQL.Add(Query1.SQL.Text);
  end;

  with mtListado do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('unidad', ftString, 1, False);
    FieldDefs.Add('nproducto', ftString, 30, False);
    FieldDefs.Add('actKilos', ftFloat, 0, False);
    FieldDefs.Add('actImporte', ftFloat, 0, False);
    FieldDefs.Add('actPrecio', ftFloat, 0, False);
    FieldDefs.Add('antKilos', ftFloat, 0, False);
    FieldDefs.Add('antImporte', ftFloat, 0, False);
    FieldDefs.Add('antPrecio', ftFloat, 0, False);
    FieldDefs.Add('difKilos', ftFloat, 0, False);
    FieldDefs.Add('porcenKilos', ftFloat, 0, False);
    FieldDefs.Add('difImporte', ftFloat, 0, False);
    FieldDefs.Add('porcenImporte', ftFloat, 0, False);
    FieldDefs.Add('difPrecio', ftFloat, 0, False);
    FieldDefs.Add('porcenPrecio', ftFloat, 0, False);
    CreateTable;
    Open;
  end;

end;

destructor TQRLMercadonaVentasSemanal.Destroy;
begin
  Query1.Close;
  Query2.Close;
  mtListado.Close;
  inherited;
end;

function TQRLMercadonaVentasSemanal.DatosListado( const ACliente: string;
            const AFechaIniAct, AFechaFinAct, AFechaIniAnt, AFechaFinAnt: TDateTime ): boolean;
begin
  Query1.ParamByName('cliente').AsString := ACliente;
  Query1.ParamByName('fechaini').AsDate := AFechaIniAct;
  Query1.ParamByName('fechafin').AsDate := AFechaFinAct;
  Query1.Open;
  Query2.ParamByName('cliente').AsString := ACliente;
  Query2.ParamByName('fechaini').AsDate := AFechaIniAnt;
  Query2.ParamByName('fechafin').AsDate := AFechaFinAnt;
  Query2.Open;
  result:= not Query1.IsEmpty or  not Query2.IsEmpty;
  if result then
  begin
    DatosQuery1;
    DatosQuery2;
  end;
  mtListado.SortFields:= 'unidad;nproducto';
  mtListado.Sort([]);
end;

procedure TQRLMercadonaVentasSemanal.DatosQuery1;
begin
  while not query1.Eof do
  begin
    mtListado.Insert;

    mtListado.FieldByName('unidad').AsString:= Query1.FieldByName('unidad').AsString;
    mtListado.FieldByName('nproducto').AsString:= Query1.FieldByName('nproducto').AsString;

    mtListado.FieldByName('actKilos').AsFloat:= Query1.FieldByName('kilos').AsFloat;
    mtListado.FieldByName('actImporte').AsFloat:= Query1.FieldByName('importe').AsFloat;
    if mtListado.FieldByName('actKilos').AsFloat <> 0 then
      mtListado.FieldByName('actPrecio').AsFloat:= bRoundTo( Query1.FieldByName('importe').AsFloat / Query1.FieldByName('kilos').AsFloat, 3)
    else
      mtListado.FieldByName('actPrecio').AsFloat:= 0;

    mtListado.FieldByName('antKilos').AsFloat:= 0;
    mtListado.FieldByName('antImporte').AsFloat:= 0;
    mtListado.FieldByName('antPrecio').AsFloat:= 0;

    mtListado.FieldByName('difKilos').AsFloat:= Query1.FieldByName('kilos').AsFloat;
    mtListado.FieldByName('difImporte').AsFloat:= Query1.FieldByName('importe').AsFloat;
    mtListado.FieldByName('difPrecio').AsFloat:= mtListado.FieldByName('actPrecio').AsFloat;

    mtListado.FieldByName('porcenKilos').AsFloat:= 100;
    mtListado.FieldByName('porcenImporte').AsFloat:= 100;
    mtListado.FieldByName('porcenPrecio').AsFloat:= 100;

    mtListado.Post;
    Query1.Next;
  end;
end;

procedure TQRLMercadonaVentasSemanal.DatosQuery2;
begin
  while not query2.Eof do
  begin
    if mtListado.Locate( 'unidad;nproducto',VarArrayOf( [Query2.FieldByName('unidad').AsString,
                                                        Query2.FieldByName('nproducto').AsString] ), [] ) then
    begin
      mtListado.Edit;


      mtListado.FieldByName('antKilos').AsFloat:= Query2.FieldByName('kilos').AsFloat;
      mtListado.FieldByName('antImporte').AsFloat:= Query2.FieldByName('importe').AsFloat;
      if mtListado.FieldByName('antKilos').AsFloat <> 0 then
        mtListado.FieldByName('antPrecio').AsFloat:= bRoundTo( Query2.FieldByName('importe').AsFloat / Query2.FieldByName('kilos').AsFloat, 3)
      else
        mtListado.FieldByName('antPrecio').AsFloat:= 0;



      mtListado.FieldByName('difKilos').AsFloat:= mtListado.FieldByName('difKilos').AsFloat - Query2.FieldByName('kilos').AsFloat;
      mtListado.FieldByName('difImporte').AsFloat:= mtListado.FieldByName('difImporte').AsFloat - Query2.FieldByName('importe').AsFloat;
      mtListado.FieldByName('difPrecio').AsFloat:= mtListado.FieldByName('difPrecio').AsFloat - mtListado.FieldByName('antPrecio').AsFloat;

      if  mtListado.FieldByName('antKilos').AsFloat <> 0 then
        mtListado.FieldByName('porcenKilos').AsFloat:= bRoundto( 100 * ( ( mtListado.FieldByName('actKilos').AsFloat/ mtListado.FieldByName('antKilos').AsFloat ) - 1), 2 );
      if  mtListado.FieldByName('antImporte').AsFloat <> 0 then
        mtListado.FieldByName('porcenImporte').AsFloat:= bRoundto( 100 * ( ( mtListado.FieldByName('actImporte').AsFloat/ mtListado.FieldByName('antImporte').AsFloat ) - 1), 2 );
      if  mtListado.FieldByName('antPrecio').AsFloat <> 0 then
        mtListado.FieldByName('porcenPrecio').AsFloat:= bRoundto( 100 * ( ( mtListado.FieldByName('actPrecio').AsFloat/ mtListado.FieldByName('antPrecio').AsFloat ) - 1), 2 );

      mtListado.Post;
    end
    else
    begin
      mtListado.Insert;

      mtListado.FieldByName('unidad').AsString:= Query2.FieldByName('unidad').AsString;
      mtListado.FieldByName('nproducto').AsString:= Query2.FieldByName('nproducto').AsString;

      mtListado.FieldByName('actKilos').AsFloat:= 0;
      mtListado.FieldByName('actImporte').AsFloat:= 0;
      mtListado.FieldByName('actPrecio').AsFloat:= 0;

      mtListado.FieldByName('antKilos').AsFloat:= Query2.FieldByName('kilos').AsFloat;
      mtListado.FieldByName('antImporte').AsFloat:= Query2.FieldByName('importe').AsFloat;
      if mtListado.FieldByName('antKilos').AsFloat <> 0 then
        mtListado.FieldByName('antPrecio').AsFloat:= bRoundTo( Query2.FieldByName('importe').AsFloat / Query2.FieldByName('kilos').AsFloat, 3)
      else
        mtListado.FieldByName('antPrecio').AsFloat:= 0;

      mtListado.FieldByName('difKilos').AsFloat:= Query2.FieldByName('kilos').AsFloat * -1;
      mtListado.FieldByName('difImporte').AsFloat:= Query2.FieldByName('importe').AsFloat * -1;
      mtListado.FieldByName('difPrecio').AsFloat:= mtListado.FieldByName('antPrecio').AsFloat * -1;

      mtListado.FieldByName('porcenKilos').AsFloat:= -100;
      mtListado.FieldByName('porcenImporte').AsFloat:= -100;
      mtListado.FieldByName('porcenPrecio').AsFloat:= -100;

      mtListado.Post;
    end;
    Query2.Next;
  end;
end;

procedure TQRLMercadonaVentasSemanal.QRExpr1Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + DesEmpresa( value );
end;

procedure TQRLMercadonaVentasSemanal.qreTotaLabelPrint(sender: TObject;
  var Value: String);
begin
   if Value = 'K' then
     Value:= 'POR KILOS'
   else
     Value:= 'POR UNIDADES';
end;

procedure TQRLMercadonaVentasSemanal.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  antKilos:= 0;
  antImporte:= 0;
  actKilos:= 0;
  actImporte:= 0;
end;

procedure TQRLMercadonaVentasSemanal.QRLblDescripcionPrint(sender: TObject;
  var Value: String);
begin
  antKilos:= antKilos + DataSet.FieldByName('antKilos').AsFloat;
  antImporte:= antImporte + DataSet.FieldByName('antImporte').AsFloat;
  actKilos:= actKilos + DataSet.FieldByName('actKilos').AsFloat;
  actImporte:= actImporte + DataSet.FieldByName('actImporte').AsFloat;
end;

procedure TQRLMercadonaVentasSemanal.bndPieUnidadBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  difPrecio: real;
  antPrecio, actPrecio: real;
  porcenKilos, porcenPrecio: real;
begin
  if antKilos <> 0 then
    antPrecio:= bRoundTo( antImporte / antKilos, 3 )
  else
    antPrecio:= 0;
  if actKilos <> 0 then
    actPrecio:= bRoundTo( actImporte / actKilos, 3 )
  else
    actPrecio:= 0;
  difPrecio:= actPrecio - antPrecio;

  if antKilos <> 0 then
    porcenKilos:= bRoundto( 100 * ( ( actKilos / antKilos )  - 1 ), 2 )
  else
    porcenKilos:= 100;
  if antPrecio <> 0 then
    porcenPrecio:= bRoundto( 100 * ( ( actPrecio / antPrecio ) - 1 ), 2 )
  else
    porcenPrecio:= 100;

  qrlAntPrecio.Caption:= FormatFloat('#,##0.000', AntPrecio );
  qrlActPrecio.Caption:= FormatFloat('#,##0.000', ActPrecio );
  qrlDifPrecio.Caption:= FormatFloat('#,##0.000', DifPrecio );
  qrlPorcenKilos.Caption:= FormatFloat('#,##0.00', porcenKilos );
  qrlPorcenPrecio.Caption:= FormatFloat('#,##0.00', PorcenPrecio );

  antKilos:= 0;
  antImporte:= 0;
  actKilos:= 0;
  actImporte:= 0;
end;

procedure TQRLMercadonaVentasSemanal.qreporcenkilosPrint(sender: TObject;
  var Value: String);
begin
   Value:= Value + '%';
end;

procedure TQRLMercadonaVentasSemanal.qreantkilosPrint(sender: TObject;
  var Value: String);
begin
  if ( Value = '0,00' ) or ( Value = '0,000' ) then
    Value:= '';
end;

end.
