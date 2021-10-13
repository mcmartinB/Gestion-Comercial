unit UDMControlFob;

interface

uses
  SysUtils, Classes, DB, Provider, DBClient, DBTables, MidasLib;

type
  TDMControlFob = class(TDataModule)
    QSalidas: TQuery;
    CDSSalidas: TClientDataSet;
    DSSalidas: TDataSource;
    DSPSalidas: TDataSetProvider;
    QTransitos: TQuery;
    DSPTransitos: TDataSetProvider;
    CDSTransitos: TClientDataSet;
    DSTransitos: TDataSource;
    CDSTransitosempresa: TStringField;
    CDSTransitoscentro: TStringField;
    CDSTransitosfecha: TDateField;
    CDSTransitosreferencia: TIntegerField;
    CDSTransitoskilos: TFloatField;
    CDSTransitosvendidos: TFloatField;
    CDSTransitosnivel: TIntegerField;
    QSalidasTransito: TQuery;
    CDSSalidasempresa: TStringField;
    CDSSalidascentro: TStringField;
    CDSSalidasfecha: TDateField;
    CDSSalidasreferencia: TIntegerField;
    CDSSalidasproducto: TStringField;
    CDSSalidaskilos: TFloatField;
    CDSSalidasvendidos: TFloatField;
    CDSSalidasfacturado: TIntegerField;
    CDSTransitosproducto: TStringField;
    QTransitosTransitos: TQuery;
    QSalidaFacturada: TQuery;
    QKilosTransito: TQuery;
    QKilosNoComerciales: TQuery;
  private
    { Private declarations }
    procedure BorrarRecords;
    function ExisteRecord(const AEmpresa, ACentro, AFecha, AReferencia, AProducto: string): Boolean;
    procedure AnyadirRecord(const ADataSet: TDataSet;
      const AEmpresa, ACentro, AFecha, AReferencia, AProducto: string;
      const AKilos: Real);

    function DatosDeLosTransitos(const ANivel: Integer; const AFechaIni, AFechaFin: TDateTime): integer;
    function InsertarSalidas(var AKilos: Real): integer;
    function InsertarTransitos(var AKilos: Real; const AFechaIni, AFechaFin: TDateTime): integer;
    procedure KilosSalidaTransito(const AKilos: Real);
    procedure SalidasFacturadas;

    procedure PrepararTablas(const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function RellenaTablas(const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string): integer;
  end;

  PTransitos = ^RTransitos;
  RTransitos = record
    empresa: string;
    centro: string;
    fecha: TDateTime;
    referencia: integer;
    producto: string;
    kilos: real;
  end;

var
  DMControlFob: TDMControlFob;

implementation

uses Variants, bDialogs, bMath;

{$R *.dfm}

var
  ListaTransitos: TList;


procedure TDMControlFob.BorrarRecords;
var
  i: integer;
  auxTransito: PTransitos;
begin
  i := 0;
  while (i < ListaTransitos.Count) do
  begin
    auxTransito := ListaTransitos.Items[i];
    Dispose(auxTransito);
    Inc(i);
  end;
  ListaTransitos.Clear;
end;

function TDMControlFob.ExisteRecord(const AEmpresa, ACentro, AFecha, AReferencia, AProducto: string): Boolean;
var
  i: integer;
  auxTransito: PTransitos;
begin
  i := 0;
  result := False;
  while (i < ListaTransitos.Count) and not result do
  begin
    auxTransito := ListaTransitos.Items[i];
    if (auxTransito^.empresa = AEmpresa) and
      (auxTransito^.centro = ACentro) and
      (auxTransito^.fecha = StrToDate(AFecha)) and
      (auxTransito^.referencia = StrToInt(AReferencia)) and
      (auxTransito^.producto = AProducto) then
    begin
      result := True;
    end;
    Inc(i);
  end;
end;

procedure TDMControlFob.AnyadirRecord(const ADataSet: TDataSet;
  const AEmpresa, ACentro, AFecha, AReferencia, AProducto: string;
  const AKilos: Real);
var
  auxTransito: PTransitos;
begin
  New(auxTransito);
  auxTransito^.empresa := AEmpresa;
  auxTransito^.centro := ACentro;
  auxTransito^.fecha := StrToDate(AFecha);
  auxTransito^.referencia := StrToInt(AReferencia);
  auxTransito^.producto := AProducto;
  auxTransito^.kilos := AKilos;
  ListaTransitos.Add(auxTransito);

  ADataSet.Insert;
  ADataSet.FieldByName('empresa').AsString := AEmpresa;
  ADataSet.FieldByName('centro').AsString := ACentro;
  ADataSet.FieldByName('fecha').AsString := AFecha;
  ADataSet.FieldByName('referencia').AsString := AReferencia;
  ADataSet.FieldByName('producto').AsString := AProducto;
  ADataSet.FieldByName('kilos').AsFloat := AKilos;
  ADataSet.FieldByName('vendidos').AsFloat := 0;
  ADataSet.FieldByName('nivel').AsInteger := 2;
  ADataSet.Post;
end;

procedure TDMControlFob.PrepararTablas(const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string);
begin
  //SALIDAS DIRECTAS
  QSalidas.SQL.Clear;
  QSalidas.SQL.Add(' select empresa_sl empresa, centro_salida_sl centro, fecha_sl fecha, n_albaran_sl referencia, ');
  if AProducto = '' then
    QSalidas.SQL.Add('        ''X'' producto, ')
  else
    QSalidas.SQL.Add('        producto_sl producto, ');
  QSalidas.SQL.Add('        round( sum(kilos_sl), 2) kilos, ');
  QSalidas.SQL.Add('        round( sum(case when NVL(precio_sl, 0) <> 0 then kilos_sl else 0 end), 2) vendidos, ');
  QSalidas.SQL.Add('        0 facturado ');
  QSalidas.SQL.Add(' from frf_salidas_c, frf_salidas_l ');

  QSalidas.SQL.Add(' where empresa_sc = ' + QuotedStr(AEmpresa));
  QSalidas.SQL.Add(' and centro_salida_sc = ' + QuotedStr(ACentro));
  QSalidas.SQL.Add(' and fecha_sc between ' + QuotedStr(AFechaIni) + ' and ' + QuotedStr(AFechaFin));

  QSalidas.SQL.Add(' and empresa_sl = ' + QuotedStr(AEmpresa));
  QSalidas.SQL.Add(' and centro_salida_sl = ' + QuotedStr(ACentro));
  QSalidas.SQL.Add(' and fecha_sl = fecha_sc ');
  QSalidas.SQL.Add(' and n_albaran_sl = n_albaran_sc ');

  QSalidas.SQL.Add(' and centro_origen_sl = ' + QuotedStr(ACentro));
  //QSalidas.SQL.Add(' and ref_transitos_sl is null '); //Redundante Centro_salida = Centro_Origen
  QSalidas.SQL.Add(' and ( nvl(es_transito_sc,0) =  0 ) ');
  QSalidas.SQL.Add(' and categoria_sl in (''1'', ''2'',''3'' ) ');
  if AProducto <> '' then
    QSalidas.SQL.Add(' and producto_sl = ' + QuotedStr(AProducto));

  QSalidas.SQL.Add(' group by empresa_sl, centro_salida_sl, fecha_sl, n_albaran_sl ');
  if AProducto <> '' then
    QSalidas.SQL.Add('          , producto_sl ');

  //TARNSITOS DIRECTOS
  QTransitos.SQL.Clear;
  QTransitos.SQL.Add(' select empresa_tl empresa, centro_tl centro, fecha_tl fecha, referencia_tl referencia,');
  if AProducto = '' then
    QTransitos.SQL.Add('        ''X'' producto, ')
  else
    QTransitos.SQL.Add('        producto_tl producto, ');
  QTransitos.SQL.Add('        round( sum(kilos_tl), 2) kilos, 0.0 vendidos, 1 nivel ');
  QTransitos.SQL.Add(' from frf_transitos_l ');
  QTransitos.SQL.Add(' where empresa_tl = ' + QuotedStr(AEmpresa));
  QTransitos.SQL.Add(' and centro_tl = ' + QuotedStr(ACentro));
  QTransitos.SQL.Add(' and centro_origen_tl = ' + QuotedStr(ACentro));
  QTransitos.SQL.Add(' and fecha_tl between ' + QuotedStr(AFechaIni) + ' and ' + QuotedStr(AFechaFin));
  if AProducto <> '' then
    QTransitos.SQL.Add(' and producto_tl = ' + QuotedStr(AProducto));
  //QTransitos.SQL.Add(' and ref_origen_tl is null '); //Redundante Centro_salida = Centro_Origen
  QTransitos.SQL.Add(' group by empresa_tl, centro_tl, fecha_tl, referencia_tl ');
  if AProducto <> '' then
    QTransitos.SQL.Add('          , producto_tl ');

  //INTENTA LOCALIZAR LAS SALIDAS QUE TIENEN FRUTA DE UN TRANSITO
  if QSalidasTransito.Prepared then
    QSalidasTransito.UnPrepare;
  QSalidasTransito.SQL.Clear;
  QSalidasTransito.SQL.Add(' select empresa_sl empresa, centro_salida_sl centro, ');
  QSalidasTransito.SQL.Add('        fecha_sl fecha, n_albaran_sl referencia, ');
  if AProducto = '' then
    QSalidasTransito.SQL.Add('        ''X'' producto, ')
  else
    QSalidasTransito.SQL.Add('        producto_sl producto, ');
  QSalidasTransito.SQL.Add('        round( sum(kilos_sl), 2) kilos, ');
  QSalidasTransito.SQL.Add('        round( sum(case when NVL(precio_sl, 0) <> 0 then kilos_sl else 0 end), 2) vendidos, ');
  QSalidasTransito.SQL.Add('        0 facturado ');
  QSalidasTransito.SQL.Add(' from frf_salidas_l ');
  QSalidasTransito.SQL.Add(' where empresa_sl = ' + QuotedStr(AEmpresa));
  QSalidasTransito.SQL.Add(' and centro_origen_sl = ' + QuotedStr(ACentro));
  QSalidasTransito.SQL.Add(' and ref_transitos_sl = :referencia ');
  QSalidasTransito.SQL.Add(' and fecha_sl between :fecha - 30 and :fecha + 60');
  QSalidasTransito.SQL.Add(' and categoria_sl in (''1'', ''2'',''3'' ) ');
  if AProducto <> '' then
    QSalidasTransito.SQL.Add(' and producto_sl = ' + QuotedStr(AProducto));
  QSalidasTransito.SQL.Add(' group by empresa_sl, centro_salida_sl, fecha_sl, n_albaran_sl ');
  if AProducto <> '' then
    QSalidasTransito.SQL.Add('          , producto_sl ');
  QSalidasTransito.Prepare;

  //INTENTA LOCALIZAR LAS SALIDAS QUE TIENEN FRUTA NO COMERCIAL DE UN TRANSITO
  if QKilosNoComerciales.Prepared then
    QKilosNoComerciales.UnPrepare;
  QKilosNoComerciales.SQL.Clear;
  QKilosNoComerciales.SQL.Add(' select round( sum(kilos_sl), 2) kilos ');
  QKilosNoComerciales.SQL.Add(' from frf_salidas_l ');
  QKilosNoComerciales.SQL.Add(' where empresa_sl = ' + QuotedStr(AEmpresa));
  QKilosNoComerciales.SQL.Add(' and centro_origen_sl = ' + QuotedStr(ACentro));
  QKilosNoComerciales.SQL.Add(' and ref_transitos_sl = :referencia ');
  QKilosNoComerciales.SQL.Add(' and fecha_sl between :fecha - 30 and :fecha + 60');
  QKilosNoComerciales.SQL.Add(' and categoria_sl not in (''1'', ''2'',''3'' ) ');
  if AProducto <> '' then
    QKilosNoComerciales.SQL.Add(' and producto_sl = ' + QuotedStr(AProducto));
  QKilosNoComerciales.Prepare;

  //INTENTA LOCALIZAR LOS TRANSITOS QUE TIENEN FRUTA DE UN TRANSITO
  if QTransitosTransitos.Prepared then
    QTransitosTransitos.UnPrepare;
  QTransitosTransitos.SQL.Clear;
  QTransitosTransitos.SQL.Add(' select empresa_tl empresa, centro_tl centro, fecha_tl fecha, referencia_tl referencia,');
  if AProducto = '' then
    QTransitosTransitos.SQL.Add('        ''X'' producto, ')
  else
    QTransitosTransitos.SQL.Add('        producto_tl producto, ');
  QTransitosTransitos.SQL.Add('        round( sum(kilos_tl), 2) kilos, 0.0 vendidos, 2 nivel ');
  QTransitosTransitos.SQL.Add(' from frf_transitos_l ');
  QTransitosTransitos.SQL.Add(' where empresa_tl = ' + QuotedStr(AEmpresa));
  QTransitosTransitos.SQL.Add(' and centro_origen_tl = ' + QuotedStr(ACentro));
  QTransitosTransitos.SQL.Add(' and ref_origen_tl = :referencia ');
  QTransitosTransitos.SQL.Add(' and fecha_origen_tl = :fecha ');
  if AProducto <> '' then
    QTransitosTransitos.SQL.Add(' and producto_tl = ' + QuotedStr(AProducto));
  QTransitosTransitos.SQL.Add(' group by empresa_tl, centro_tl, fecha_tl, referencia_tl ');
  if AProducto <> '' then
    QTransitosTransitos.SQL.Add('          , producto_tl ');
  QTransitosTransitos.Prepare;

  //KILOS DE PRODUCTO DEL TRANSITO INDIRECTO
  if QKilosTransito.Prepared then
    QKilosTransito.UnPrepare;
  QKilosTransito.SQL.Clear;
  QKilosTransito.SQL.Add(' select round( sum(kilos_tl), 2) kilos ');
  QKilosTransito.SQL.Add(' from frf_transitos_l ');
  QKilosTransito.SQL.Add(' where empresa_tl = ' + QuotedStr(AEmpresa));
  QKilosTransito.SQL.Add(' and centro_tl = :centro ');
  QKilosTransito.SQL.Add(' and centro_origen_tl = ' + QuotedStr(ACentro));
  QKilosTransito.SQL.Add(' and referencia_tl = :referencia ');
  QKilosTransito.SQL.Add(' and fecha_tl = :fecha ');
  if AProducto <> '' then
    QKilosTransito.SQL.Add(' and producto_tl = ' + QuotedStr(AProducto));
  //QKilosTransito.SQL.Add(' and fecha_origen_tl between ' + QuotedStr( AFechaIni ) + ' and ' + QuotedStr( AFechaFin ) );
  QKilosTransito.Prepare;

  //ESTA FACTURADO EL ALBARAN
  if QSalidaFacturada.Prepared then
    QSalidaFacturada.UnPrepare;
  QSalidaFacturada.SQL.Clear;
  QSalidaFacturada.SQL.Add(' select NVL( n_factura_sc, 0 ) ');
  QSalidaFacturada.SQL.Add(' from frf_salidas_c ');
  QSalidaFacturada.SQL.Add(' where empresa_sc = ' + QuotedStr(AEmpresa));
  QSalidaFacturada.SQL.Add(' and centro_salida_sc = :centro ');
  QSalidaFacturada.SQL.Add(' and n_albaran_sc = :referencia ');
  QSalidaFacturada.SQL.Add(' and fecha_sc = :fecha ');
  QSalidaFacturada.Prepare;
end;

constructor TDMControlFob.Create(AOwner: TComponent);
begin
  inherited;
  ListaTransitos := TList.Create;
end;

destructor TDMControlFob.Destroy;
begin
  if QSalidaFacturada.Prepared then
    QSalidaFacturada.UnPrepare;
  if QKilosTransito.Prepared then
    QKilosTransito.UnPrepare;
  if QTransitosTransitos.Prepared then
    QTransitosTransitos.UnPrepare;
  if QSalidasTransito.Prepared then
    QSalidasTransito.UnPrepare;
  if QKilosNoComerciales.Prepared then
    QKilosNoComerciales.UnPrepare;


  FreeAndNil(ListaTransitos);

  inherited;
end;

function TDMControlFob.RellenaTablas(const AEmpresa, ACentro, AProducto,
  AFechaIni, AFechaFin: string): integer;
begin
  PrepararTablas(AEmpresa, ACentro, Trim(AProducto), AFechaIni, AFechaFin);

  CDSSalidas.Close;
  CDSSalidas.Filter := '';
  CDSSalidas.Filtered := false;
  CDSSalidas.Open;
  result := CDSSalidas.RecordCount;

  CDSTransitos.Close;
  CDSTransitos.Filter := '';
  CDSTransitos.Filtered := false;
  CDSTransitos.Open;
  result := result + CDSTransitos.RecordCount;

  if CDSTransitos.Active then
  begin
    result := result + DatosDeLosTransitos(1, StrToDate(AFechaIni), StrToDate(AFechaFin));
  end;

  if result > 0 then
    SalidasFacturadas;
end;

function TDMControlFob.DatosDeLosTransitos(const ANivel: Integer; const AFechaIni, AFechaFin: TDateTime): integer;
var
  kilosSal, kilosTran: real;
begin
  result := 0;
  CDSTransitos.Filter := 'nivel = ' + IntToStr(ANivel);
  CDSTransitos.Filtered := True;
  CDSTransitos.First;
  while not CDSTransitos.Eof do
  begin
    kilosSal := 0;
    kilosTran := 0;
    result := result + InsertarSalidas(kilosSal);
    if ANivel = 1 then
      result := result + InsertarTransitos(kilosTran, AFechaIni, AFechaFin);
    KilosSalidaTransito(kilosSal + kilosTran);
    CDSTransitos.Next;
  end;
  if ANivel = 1 then
    DatosDeLosTransitos(2, AFechaIni, AFechaFin);

  BorrarRecords;
end;

function TDMControlFob.InsertarSalidas(var AKilos: Real): integer;
var
  i: integer;
begin
  result := 0;

  QKilosNoComerciales.ParamByName('referencia').AsString := CDSTransitos.FieldByName('referencia').AsString;
  QKilosNoComerciales.ParamByName('fecha').AsDate := CDSTransitos.FieldByName('fecha').AsDateTime;
  QKilosNoComerciales.Open;
  AKilos := QKilosNoComerciales.FieldByName('kilos').AsFloat;
  QKilosNoComerciales.Close;

  QSalidasTransito.ParamByName('referencia').AsString := CDSTransitos.FieldByName('referencia').AsString;
  QSalidasTransito.ParamByName('fecha').AsDate := CDSTransitos.FieldByName('fecha').AsDateTime;
  QSalidasTransito.Open;

  while not QSalidasTransito.EOF do
  begin
    AKilos := AKilos + QSalidasTransito.FieldByName('kilos').AsFloat;
    if not CDSSalidas.Locate('empresa;centro;fecha;referencia',
      VarArrayof([QSalidasTransito.FieldByName('empresa').AsString,
      QSalidasTransito.FieldByName('centro').AsString,
        QSalidasTransito.FieldByName('fecha').AsString,
        QSalidasTransito.FieldByName('referencia').AsInteger]), []) then
    begin
      CDSSalidas.Insert;
      i := 0;
      while i < CDSSalidas.Fields.Count do
      begin
        CDSSalidas.Fields[i].Value := QSalidasTransito.Fields[i].Value;
        Inc(i);
      end;

      try
        CDSSalidas.Post;
        Inc(result);
      except
        on e: EDBClient do
        begin
          CDSSalidas.Cancel;
          if e.ErrorCode <> 9729 then
          begin
            ErrorGeneral(IntToStr(e.ErrorCode) + ':' + e.Message);
            raise;
          end;
        end;
      end;
    end;
    QSalidasTransito.Next;
  end;
  QSalidasTransito.Close;
end;

function TDMControlFob.InsertarTransitos(var AKilos: Real; const AFechaIni, AFechaFin: TDateTime): integer;
var
  marca: TBookMark;
begin
  AKilos := 0;
  result := 0;

  QTransitosTransitos.ParamByName('referencia').AsString := CDSTransitos.FieldByName('referencia').AsString;
  QTransitosTransitos.ParamByName('fecha').AsDateTime := CDSTransitos.FieldByName('fecha').AsDateTime;
  QTransitosTransitos.Open;

  marca := CDSTransitos.GetBookmark;
  while not QTransitosTransitos.EOF do
  begin
    AKilos := AKilos + QTransitosTransitos.FieldByName('kilos').AsFloat;

    if not ExisteRecord(QTransitosTransitos.FieldByName('empresa').AsString,
      QTransitosTransitos.FieldByName('centro').AsString,
      QTransitosTransitos.FieldByName('fecha').AsString,
      QTransitosTransitos.FieldByName('referencia').AsString,
      QTransitosTransitos.FieldByName('producto').AsString) then
    begin
      QKilosTransito.ParamByName('centro').AsString := QTransitosTransitos.FieldByName('centro').AsString;
      QKilosTransito.ParamByName('referencia').AsString := QTransitosTransitos.FieldByName('referencia').AsString;
      QKilosTransito.ParamByName('fecha').AsDate := QTransitosTransitos.FieldByName('fecha').AsDateTime;
      QKilosTransito.open;

      AnyadirRecord(CDSTransitos,
        QTransitosTransitos.FieldByName('empresa').AsString,
        QTransitosTransitos.FieldByName('centro').AsString,
        QTransitosTransitos.FieldByName('fecha').AsString,
        QTransitosTransitos.FieldByName('referencia').AsString,
        QTransitosTransitos.FieldByName('producto').AsString,
        QKilosTransito.FieldByName('kilos').AsFloat);
      QKilosTransito.Close;
      Inc(result);
    end;

    QTransitosTransitos.Next;
  end;
  CDSTransitos.GotoBookmark(marca);
  CDSTransitos.FreeBookmark(marca);
  QTransitosTransitos.Close;
end;

procedure TDMControlFob.KilosSalidaTransito(const AKilos: Real);
begin
  CDSTransitos.Edit;
  CDSTransitos.FieldByName('vendidos').AsFloat := bRoundTo(AKilos, -2);
  try
    CDSTransitos.Post;
  except
    on e: EDBClient do
    begin
      CDSTransitos.Cancel;
      ErrorGeneral(IntToStr(e.ErrorCode) + ':' + e.Message);
      raise;
    end;
  end;
end;

procedure TDMControlFob.SalidasFacturadas;
begin
  CDSSalidas.First;
  while not CDSSalidas.Eof do
  begin
    QSalidaFacturada.ParamByName('centro').AsString := CDSSalidas.FieldByName('centro').AsString;
    QSalidaFacturada.ParamByName('referencia').AsString := CDSSalidas.FieldByName('referencia').AsString;
    QSalidaFacturada.ParamByName('fecha').AsDate := CDSSalidas.FieldByName('fecha').AsDateTime;
    QSalidaFacturada.Open;
    if QSalidaFacturada.Fields[0].AsInteger <> 0 then
    begin
      CDSSalidas.Edit;
      CDSSalidas.FieldByName('facturado').ASInteger := 1;
      try
        CDSSalidas.Post;
      except
        on e: EDBClient do
        begin
          CDSTransitos.Cancel;
          ErrorGeneral(IntToStr(e.ErrorCode) + ':' + e.Message);
          raise;
        end;
      end;
    end;
    QSalidaFacturada.Close;
    CDSSalidas.Next;
  end;
end;

end.
