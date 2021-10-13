unit UTransitosList_MD;

interface

uses
  SysUtils, Classes, DB, Provider, DBClient, DBTables, kbmMemTable, MidasLib;

type
  TTransitosList_MD = class(TDataModule)
    QTransitos: TQuery;
    DSPTransitos: TDataSetProvider;
    CDSTransitos: TClientDataSet;
    DSTransitos: TDataSource;
    QSalidasTransito: TQuery;
    QTransitosTransitos: TQuery;
    CDSTransitosempresa: TStringField;
    CDSTransitoscentro: TStringField;
    CDSTransitosfecha: TDateField;
    CDSTransitosreferencia: TIntegerField;
    CDSTransitosproducto: TStringField;
    CDSTransitoskilos: TFloatField;
    CDSTransitosvendidos: TFloatField;
    QDesgloseSalidas: TQuery;
    mtSalidasIndirectas: TkbmMemTable;
    mtSalidasIndirectasempresa: TStringField;
    mtSalidasIndirectasorigen: TStringField;
    mtSalidasIndirectastransito: TIntegerField;
    mtSalidasIndirectasfecha_transito: TDateField;
    mtSalidasIndirectassalida: TStringField;
    mtSalidasIndirectasalbaran: TIntegerField;
    mtSalidasIndirectasfecha_albaran: TDateField;
    mtSalidasIndirectasproducto: TStringField;
    mtSalidasIndirectascliente: TStringField;
    mtSalidasIndirectascategoria: TStringField;
    mtSalidasIndirectaskilos: TFloatField;
    QTransitosIndirectos: TQuery;
    QTransitosEnTransitosIndirectos: TQuery;
    QSalidasTransitosIndirectos: TQuery;
    QDesgloseTransitos: TQuery;
    QDesgloseTransitoscentro: TStringField;
    QDesgloseTransitosreferencia: TIntegerField;
    QDesgloseTransitosfecha_tl: TDateField;
    QDesgloseTransitoscategoria: TStringField;
    QDesgloseTransitoskilos: TFloatField;
    QDesgloseTransitosdestino: TStringField;
  private
    { Private declarations }
    bProducto: boolean;
    procedure RecorrerTransitos;
    function  KilosSalidas: Real;
    function  KilosTransitos: Real;
    procedure KilosVendidos(const AKilos: Real);

    //procedure PrepararTablas(const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string;
    //                         const ACategorias: Integer);
    procedure PrepararTablas(const AEmpresa, ACentro, AProducto, AAgrupacion: string; const AFechaIni, AFechaFin: TDateTime );

  public
    { Public declarations }
    destructor Destroy; override;

    //procedure RellenaTablas(const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string;
    //                       const ACategorias: Integer);
    procedure RellenaTablas(const AEmpresa, ACentro, AProducto, AAgrupacion: string; const AFechaIni, AFechaFin: TDateTime );

    //procedure RellenarSalidasIndirectas( const ACategorias: Integer );
    procedure RellenarSalidasIndirectas;
  end;

var
  TransitosList_MD: TTransitosList_MD;

implementation

uses Variants, bDialogs, Dialogs;

{$R *.dfm}

//procedure TTransitosList_MD.PrepararTablas(const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string;
//                                           const ACategorias: Integer);
procedure TTransitosList_MD.PrepararTablas(const AEmpresa, ACentro, AProducto, AAgrupacion: string; const AFechaIni, AFechaFin: TDateTime );
begin
  bProducto:= AProducto <> '';

  //TARNSITOS DIRECTOS
  QTransitos.SQL.Clear;
  QTransitos.SQL.Add(' select empresa_tl empresa, centro_origen_tl centro, fecha_tl fecha, referencia_tl referencia,');
  if AProducto = '' then
    QTransitos.SQL.Add('        ''X'' producto, ')
  else
    QTransitos.SQL.Add('        producto_tl producto, ');
  QTransitos.SQL.Add('        sum(kilos_tl) kilos, 0.0 vendidos ');
  QTransitos.SQL.Add(' from frf_transitos_l ');
  QTransitos.SQL.Add(' where empresa_tl = ' + QuotedStr(AEmpresa));
  QTransitos.SQL.Add(' and centro_tl = ' + QuotedStr(ACentro));
  QTransitos.SQL.Add(' and fecha_tl between ' + QuotedStr(DateToStr( AFechaIni )) + ' and ' + QuotedStr(DateToStr( AFechaFin)));

  if AProducto <> '' then
    QTransitos.SQL.Add(' and producto_tl = ' + QuotedStr(AProducto));
  if AAgrupacion <> '' then
    QTransitos.SQL.Add(' and producto_tl in (select producto_a from frf_agrupacion where codigo_a = ' + AAgrupacion + ' )' );
  QTransitos.SQL.Add(' group by empresa_tl, centro_origen_tl, fecha_tl, referencia_tl ');
  if AProducto <> '' then
    QTransitos.SQL.Add('          , producto_tl ');

  //INTENTA LOCALIZAR LAS SALIDAS QUE TIENEN FRUTA DE UN TRANSITO, DESGLOSE
  if QDesgloseSalidas.Prepared then
    QDesgloseSalidas.UnPrepare;
  QDesgloseSalidas.SQL.Clear;
  QDesgloseSalidas.SQL.Add(' select empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, ');
  QDesgloseSalidas.SQL.Add('        cliente_sl, categoria_sl, n_factura_sc, fecha_factura_sc, ');
  QDesgloseSalidas.SQL.Add('        sum(kilos_sl) kilos_sl ');
  QDesgloseSalidas.SQL.Add(' from frf_salidas_c, frf_salidas_l ');
  QDesgloseSalidas.SQL.Add(' where empresa_sl = ' + QuotedStr(AEmpresa));
  //QDesgloseSalidas.SQL.Add(' and centro_origen_sl = ' + QuotedStr(ACentro));
  QDesgloseSalidas.SQL.Add(' and centro_origen_sl = :centro ');
  QDesgloseSalidas.SQL.Add(' and ref_transitos_sl = :referencia ');
  QDesgloseSalidas.SQL.Add(' and fecha_sl between :fecha - 15 and :fecha + 90 ');

  if AProducto <> '' then
    QDesgloseSalidas.SQL.Add(' and producto_sl = ' + QuotedStr(AProducto));
  if AAgrupacion <> '' then
    QDesgloseSalidas.SQL.Add(' and producto_sl in (select producto_a from frf_agrupacion where codigo_a = ' + AAgrupacion + ' )' );

  (*
  if ACategorias = 0 then
    QDesgloseSalidas.SQL.Add(' and categoria_sl in (''1'', ''2'', ''3'') ');
  *)

  QDesgloseSalidas.SQL.Add(' and empresa_sc = ' + QuotedStr(AEmpresa));
  QDesgloseSalidas.SQL.Add(' and centro_salida_sc = centro_salida_sl ');
  QDesgloseSalidas.SQL.Add(' and n_albaran_sc = n_albaran_sl ');
  QDesgloseSalidas.SQL.Add(' and fecha_sc = fecha_sl ');

  QDesgloseSalidas.SQL.Add(' group by empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, ');
  QDesgloseSalidas.SQL.Add('          cliente_sl, categoria_sl, n_factura_sc, fecha_factura_sc ');
  QDesgloseSalidas.SQL.Add(' order by empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, ');
  QDesgloseSalidas.SQL.Add('          cliente_sl, categoria_sl ');
  QDesgloseSalidas.Prepare;

  //INTENTA LOCALIZAR LOS TRANSITOS QUE TIENEN FRUTA DE UN TRANSITO, DESGLOSE
  if QDesgloseTransitos.Prepared then
    QDesgloseTransitos.UnPrepare;
  QDesgloseTransitos.SQL.Clear;
  QDesgloseTransitos.SQL.Add(' select centro_tl centro, referencia_tl referencia, fecha_tl fecha_tl,');
  QDesgloseTransitos.SQL.Add('        centro_destino_tl destino, categoria_tl categoria, sum(kilos_tl) kilos ');
  QDesgloseTransitos.SQL.Add(' from frf_transitos_l ');
  QDesgloseTransitos.SQL.Add(' where empresa_tl = ' + QuotedStr(AEmpresa));
  QDesgloseTransitos.SQL.Add(' and centro_origen_tl = :centro ');
  QDesgloseTransitos.SQL.Add(' and ref_origen_tl = :referencia ');
  QDesgloseTransitos.SQL.Add(' and fecha_origen_tl = :fecha ');

  if AProducto <> '' then
    QDesgloseTransitos.SQL.Add(' and producto_tl = ' + QuotedStr(AProducto));
  if AAgrupacion <> '' then
    QDesgloseTransitos.SQL.Add(' and producto_tl in (select producto_a from frf_agrupacion where codigo_a = ' + AAgrupacion + ' )' );

  QDesgloseTransitos.SQL.Add(' group by centro_tl, referencia_tl, fecha_tl, categoria_tl, centro_destino_tl ');
  QDesgloseTransitos.Prepare;

  //INTENTA LOCALIZAR LAS SALIDAS QUE TIENEN FRUTA DE UN TRANSITO
  if QSalidasTransito.Prepared then
    QSalidasTransito.UnPrepare;
  QSalidasTransito.SQL.Clear;
  QSalidasTransito.SQL.Add(' select sum(kilos_sl) kilos ');
  QSalidasTransito.SQL.Add(' from frf_salidas_l ');
  QSalidasTransito.SQL.Add(' where empresa_sl = :empresa ');
  QSalidasTransito.SQL.Add(' and centro_origen_sl = :centro');
  QSalidasTransito.SQL.Add(' and ref_transitos_sl = :referencia ');
  QSalidasTransito.SQL.Add(' and fecha_sl between :fecha - 15 and :fecha + 90');

  if AProducto <> '' then
    QSalidasTransito.SQL.Add(' and producto_sl = :producto ');
  if AAgrupacion <> '' then
    QSalidasTransito.SQL.Add(' and producto_sl in (select producto_a from frf_agrupacion where codigo_a = ' + AAgrupacion + ' )' );

  QSalidasTransito.Prepare;

  //INTENTA LOCALIZAR LOS TRANSITOS QUE TIENEN FRUTA DE UN TRANSITO
  if QTransitosTransitos.Prepared then
    QTransitosTransitos.UnPrepare;
  QTransitosTransitos.SQL.Clear;
  QTransitosTransitos.SQL.Add(' select sum(kilos_tl) kilos ');
  QTransitosTransitos.SQL.Add(' from frf_transitos_l ');
  QTransitosTransitos.SQL.Add(' where empresa_tl = :empresa ');
  QTransitosTransitos.SQL.Add(' and centro_origen_tl = :centro ');
  QTransitosTransitos.SQL.Add(' and fecha_origen_tl = :fecha ');
  QTransitosTransitos.SQL.Add(' and ref_origen_tl = :referencia ');

  if AProducto <> '' then
    QTransitosTransitos.SQL.Add(' and producto_tl = :producto ');
  if AAgrupacion <> '' then
    QTransitosTransitos.SQL.Add(' and producto_tl in (select producto_a from frf_agrupacion where codigo_a = ' + AAgrupacion + ' )' );

  QTransitosTransitos.Prepare;

end;

destructor TTransitosList_MD.Destroy;
begin
  if QTransitos.Prepared then
    QTransitos.UnPrepare;
  if QDesgloseSalidas.Prepared then
    QDesgloseSalidas.UnPrepare;
  if QDesgloseTransitos.Prepared then
    QDesgloseTransitos.UnPrepare;
  if QTransitosTransitos.Prepared then
    QTransitosTransitos.UnPrepare;
  if QSalidasTransito.Prepared then
    QSalidasTransito.UnPrepare;

  inherited;
end;

//procedure TTransitosList_MD.RellenaTablas(const AEmpresa, ACentro, AProducto,
//  AFechaIni, AFechaFin: string; const ACategorias: Integer);
procedure TTransitosList_MD.RellenaTablas(const AEmpresa, ACentro, AProducto, AAgrupacion: string; const AFechaIni, AFechaFin: TDateTime );
begin
  PrepararTablas(AEmpresa, ACentro, Trim(AProducto), Trim(AAgrupacion), AFechaIni, AFechaFin );

  CDSTransitos.Close;
  CDSTransitos.Filter := '';
  CDSTransitos.Filtered := false;
  CDSTransitos.Open;
  if CDSTransitos.RecordCount <> 0 then
  begin
    RecorrerTransitos;
  end;
end;

procedure TTransitosList_MD.RecorrerTransitos;
var
  kilosSal, kilosTran: real;
begin
  CDSTransitos.First;
  while not CDSTransitos.Eof do
  begin
    kilosSal := KilosSalidas;
    kilosTran := KilosTransitos;
    KilosVendidos(kilosSal + kilosTran);
    CDSTransitos.Next;
  end;
end;

function TTransitosList_MD.KilosSalidas: Real;
begin
  QSalidasTransito.ParamByName('empresa').AsString := CDSTransitos.FieldByName('empresa').AsString;
  QSalidasTransito.ParamByName('centro').AsString := CDSTransitos.FieldByName('centro').AsString;
  QSalidasTransito.ParamByName('referencia').AsString := CDSTransitos.FieldByName('referencia').AsString;
  QSalidasTransito.ParamByName('fecha').AsDate := CDSTransitos.FieldByName('fecha').AsDateTime;
  if bProducto then
    QSalidasTransito.ParamByName('producto').AsString := CDSTransitos.FieldByName('producto').AsString;
  QSalidasTransito.Open;
  result := QSalidasTransito.FieldByName('kilos').AsFloat;
  QSalidasTransito.Close;
end;

function TTransitosList_MD.KilosTransitos: real;
begin
  QTransitosTransitos.ParamByName('empresa').AsString := CDSTransitos.FieldByName('empresa').AsString;
  QTransitosTransitos.ParamByName('centro').AsString := CDSTransitos.FieldByName('centro').AsString;
  QTransitosTransitos.ParamByName('referencia').AsString := CDSTransitos.FieldByName('referencia').AsString;
  QTransitosTransitos.ParamByName('fecha').AsDateTime := CDSTransitos.FieldByName('fecha').AsDateTime;
  if bProducto then
    QTransitosTransitos.ParamByName('producto').AsString := CDSTransitos.FieldByName('producto').AsString;
  QTransitosTransitos.Open;
  result := QTransitosTransitos.FieldByName('kilos').AsFloat;
  QTransitosTransitos.Close;
end;

procedure TTransitosList_MD.KilosVendidos(const AKilos: Real);
begin
  CDSTransitos.Edit;
  CDSTransitos.FieldByName('vendidos').AsFloat := AKilos;
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

//procedure TTransitosList_MD.RellenarSalidasIndirectas( const ACategorias: Integer );
procedure TTransitosList_MD.RellenarSalidasIndirectas;
var
  rKilosTransito, rKilosSobran, rKilosQuedan: Real;
begin
  if not mtSalidasIndirectas.Active then
  begin
    mtSalidasIndirectas.Open;

    CDSTransitos.First;
    while not CDSTransitos.Eof do
    begin
      {
                select empresa_tl, centro_tl, centro_origen_tl, fecha_tl, referencia_tl, producto_tl, sum(kilos_tl) kilos_tl
                from frf_transitos_l
                where empresa_tl = :empresa
                and centro_origen_tl = :centro
                and ref_origen_tl = :transito
                and fecha_origen_tl = :fecha
                and producto_tl = :producto
                group by empresa_tl, centro_tl, centro_origen_tl, fecha_tl, referencia_tl, producto_tl
                order by empresa_tl, centro_tl, centro_origen_tl, fecha_tl, referencia_tl, producto_tl
      }
      QTransitosIndirectos.ParamByName('empresa').AsString:= CDSTransitosempresa.AsString;
      QTransitosIndirectos.ParamByName('centro').AsString:= CDSTransitoscentro.AsString;
      QTransitosIndirectos.ParamByName('fecha').AsDate:= CDSTransitosfecha.AsDateTime;
      QTransitosIndirectos.ParamByName('transito').AsInteger:= CDSTransitosreferencia.AsInteger;
      QTransitosIndirectos.ParamByName('producto').AsString:= CDSTransitosproducto.AsString;
      QTransitosIndirectos.Open;

      if not QTransitosIndirectos.IsEmpty then
      while not QTransitosIndirectos.Eof do
      begin
        //KILOS TENEMOS QUE ASIGNAR
        rKilostransito:= QTransitosIndirectos.FieldByName('kilos_tl').AsFloat;
        {
                select empresa_tl, centro_origen_tl, fecha_origen_tl, ref_origen_tl, producto_tl, sum(kilos_tl) kilos_tl
                from frf_transitos_l
                where empresa_tl = :empresa
                and centro_tl = :centro
                and referencia_tl = :transito
                and fecha_tl = :fecha
                and producto_tl = :producto
                and ref_origen_tl is not null
                group by empresa_tl, centro_origen_tl, fecha_origen_tl, ref_origen_tl, producto_tl
                order by empresa_tl, centro_origen_tl, fecha_origen_tl, ref_origen_tl, producto_tl
        }

        QTransitosEnTransitosIndirectos.ParamByName('empresa').AsString:= QTransitosIndirectos.FieldByName('empresa_tl').AsString;
        QTransitosEnTransitosIndirectos.ParamByName('centro').AsString:= QTransitosIndirectos.FieldByName('centro_tl').AsString;
        QTransitosEnTransitosIndirectos.ParamByName('fecha').AsDate:= QTransitosIndirectos.FieldByName('fecha_tl').AsDatetime;
        QTransitosEnTransitosIndirectos.ParamByName('transito').AsInteger:= QTransitosIndirectos.FieldByName('referencia_tl').AsInteger;
        QTransitosEnTransitosIndirectos.ParamByName('producto').AsString:= QTransitosIndirectos.FieldByName('producto_tl').AsString;
        QTransitosEnTransitosIndirectos.Open;

        //KILOS PERTENECEN A OTROS TRANSITOS
        rKilosSobran:= 0;
        if not QTransitosEnTransitosIndirectos.IsEmpty then
        begin
          while QTransitosEnTransitosIndirectos.FieldByName('ref_origen_tl').AsInteger <> CDSTransitosreferencia.AsInteger do
          begin
            rKilosSobran:= rKilosSobran + QTransitosEnTransitosIndirectos.FieldByName('kilos_tl').AsFloat;
            QTransitosEnTransitosIndirectos.Next;
          end;
        end;
        QTransitosEnTransitosIndirectos.Close;

        //ASIGNAR KILOS
        {
                select empresa_sl, centro_salida_sl, fecha_sl, n_albaran_sl, producto_sl, cliente_sl, categoria_sl, sum(kilos_sl) kilos_sl
                from frf_salidas_l
                where empresa_sl = :empresa
                and centro_origen_sl = :centro
                and ref_transitos_sl = :transito
                and fecha_sl between :fechaini and :fechafin
                and producto_sl = :producto
                group by empresa_sl, centro_salida_sl, fecha_sl, n_albaran_sl, producto_sl, cliente_sl, categoria_sl
                order by empresa_sl, centro_salida_sl, fecha_sl, n_albaran_sl, producto_sl, cliente_sl, categoria_sl
        }

        QSalidasTransitosIndirectos.ParamByName('empresa').AsString:= QTransitosIndirectos.FieldByName('empresa_tl').AsString;
        QSalidasTransitosIndirectos.ParamByName('centro').AsString:= CDSTransitoscentro.AsString;
        QSalidasTransitosIndirectos.ParamByName('fechaini').AsDate:= QTransitosIndirectos.FieldByName('fecha_tl').AsDatetime - 15;
        QSalidasTransitosIndirectos.ParamByName('fechafin').AsDate:= QTransitosIndirectos.FieldByName('fecha_tl').AsDatetime + 45;
        QSalidasTransitosIndirectos.ParamByName('transito').AsInteger:= QTransitosIndirectos.FieldByName('referencia_tl').AsInteger;
        QSalidasTransitosIndirectos.ParamByName('producto').AsString:= QTransitosIndirectos.FieldByName('producto_tl').AsString;
        QSalidasTransitosIndirectos.Open;

        if not QSalidasTransitosIndirectos.IsEmpty then
        while not QSalidasTransitosIndirectos.Eof do
        begin
          rKilosSobran:= rKilosSobran - QSalidasTransitosIndirectos.FieldByName('kilos_sl').AsFloat;
          while ( rKilosSobran > 0  ) and not QSalidasTransitosIndirectos.Eof do
          begin
            //Quitar los kilos que sobran
            QSalidasTransitosIndirectos.Next;
            rKilosSobran:= rKilosSobran - QSalidasTransitosIndirectos.FieldByName('kilos_sl').AsFloat;
          end;

          if {( ACategorias <> 0 ) or}
             ( QSalidasTransitosIndirectos.FieldByName('categoria_sl').AsString = '1' ) or
             ( QSalidasTransitosIndirectos.FieldByName('categoria_sl').AsString = '2' ) or
             ( QSalidasTransitosIndirectos.FieldByName('categoria_sl').AsString = '3' ) then
          begin
            mtSalidasIndirectas.Insert;
            mtSalidasIndirectasempresa.AsString:= CDSTransitosempresa.AsString;
            mtSalidasIndirectasorigen.AsString:= CDSTransitoscentro.AsString;
            mtSalidasIndirectastransito.AsInteger:= CDSTransitosreferencia.AsInteger;
            mtSalidasIndirectasfecha_transito.AsDateTime:= CDSTransitosfecha.AsDateTime;
            mtSalidasIndirectassalida.AsString:= QSalidasTransitosIndirectos.FieldByName('centro_salida_sl').AsString;
            mtSalidasIndirectasalbaran.AsInteger:= QSalidasTransitosIndirectos.FieldByName('n_albaran_sl').AsInteger;
            mtSalidasIndirectasfecha_albaran.AsDateTime:= QSalidasTransitosIndirectos.FieldByName('fecha_sl').AsDateTime;
            mtSalidasIndirectasproducto.AsString:= CDSTransitosproducto.AsString;
            mtSalidasIndirectascategoria.AsString:= QSalidasTransitosIndirectos.FieldByName('categoria_sl').AsString;
            if rKilosSobran * -1 > rKilosTransito then
              mtSalidasIndirectaskilos.AsFloat:= rKilosTransito
            else
              mtSalidasIndirectaskilos.AsFloat:= rKilosSobran * -1;
            mtSalidasIndirectascliente.AsString:= QSalidasTransitosIndirectos.FieldByName('cliente_sl').AsString;
            mtSalidasIndirectas.Post;
          end;

          rKilosQuedan:= rKilosTransito + rKilosSobran;
          while ( rKilosQuedan > 0 )  and not QSalidasTransitosIndirectos.Eof do
          begin
            QSalidasTransitosIndirectos.Next;
            rKilosQuedan:= rKilosQuedan - QSalidasTransitosIndirectos.FieldByName('kilos_sl').AsFloat;
            if ( QSalidasTransitosIndirectos.FieldByName('categoria_sl').AsString = '1' ) or
               ( QSalidasTransitosIndirectos.FieldByName('categoria_sl').AsString = '2' ) or
               ( QSalidasTransitosIndirectos.FieldByName('categoria_sl').AsString = '3' ) then
            begin
              mtSalidasIndirectas.Insert;
              mtSalidasIndirectasempresa.AsString:= CDSTransitosempresa.AsString;
              mtSalidasIndirectasorigen.AsString:= CDSTransitoscentro.AsString;
              mtSalidasIndirectastransito.AsInteger:= CDSTransitosreferencia.AsInteger;
              mtSalidasIndirectasfecha_transito.AsDateTime:= CDSTransitosfecha.AsDateTime;
              mtSalidasIndirectassalida.AsString:= QSalidasTransitosIndirectos.FieldByName('centro_salida_sl').AsString;
              mtSalidasIndirectasalbaran.AsInteger:= QSalidasTransitosIndirectos.FieldByName('n_albaran_sl').AsInteger;
              mtSalidasIndirectasfecha_albaran.AsDateTime:= QSalidasTransitosIndirectos.FieldByName('fecha_sl').AsDateTime;
              mtSalidasIndirectasproducto.AsString:= CDSTransitosproducto.AsString;
              mtSalidasIndirectascategoria.AsString:= QSalidasTransitosIndirectos.FieldByName('categoria_sl').AsString;
              if rKilosQuedan > 0 then
                mtSalidasIndirectaskilos.AsFloat:= QSalidasTransitosIndirectos.FieldByName('kilos_sl').AsFloat
              else
                mtSalidasIndirectaskilos.AsFloat:= QSalidasTransitosIndirectos.FieldByName('kilos_sl').AsFloat + rKilosQuedan;
              mtSalidasIndirectascliente.AsString:= QSalidasTransitosIndirectos.FieldByName('cliente_sl').AsString;
              mtSalidasIndirectas.Post;
            end;
          end;
          QSalidasTransitosIndirectos.Close;
        end;
        QTransitosIndirectos.Next;
      end;

      CDSTransitos.Next;
      QTransitosIndirectos.Close;
    end;
  end;
end;

end.
