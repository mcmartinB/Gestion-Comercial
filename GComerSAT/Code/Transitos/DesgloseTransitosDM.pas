unit DesgloseTransitosDM;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DBTables;

type
  TDMDesgloseTransitos = class(TDataModule)
    mtTransito: TkbmMemTable;
    mtTransitoempresa: TStringField;
    mtTransitocentro_salida: TStringField;
    mtTransitocentro_destino: TStringField;
    mtKilosTransitotransito: TIntegerField;
    mtTransitofecha: TDateField;
    mtTransitoproducto: TStringField;
    mtTransitokilos_transito: TFloatField;
    mtTransitokilos_salidos: TFloatField;
    mtTransitokilos_pendientes: TFloatField;
    mtSalidasTransito: TkbmMemTable;
    mtSalidasTransitoempresa_sl: TStringField;
    mtSalidasTransitocentro_salida_sl: TStringField;
    mtSalidasTransiton_albaran_sl: TIntegerField;
    mtSalidasTransitofecha_sl: TDateField;
    mtSalidasTransitocliente_sal_sc: TStringField;
    mtSalidasTransitodir_sum_sc: TStringField;
    mtSalidasTransitoproducto_sl: TStringField;
    mtSalidasTransitoenvase_sl: TStringField;
    mtSalidasTransitocategoria_sl: TStringField;
    mtSalidasTransitocalibre_sl: TStringField;
    mtSalidasTransiton_factura_sc: TIntegerField;
    mtSalidasTransitofecha_factura_sc: TDateField;
    mtSalidasTransitokilos_sl: TFloatField;
    mtTransitosTransito: TkbmMemTable;
    mtTransitosTransitoempresa_tl: TStringField;
    mtTransitosTransitocentro_tl: TStringField;
    mtTransitosTransitoreferencia_tl: TIntegerField;
    mtTransitosTransitofecha_tl: TDateField;
    mtTransitosTransitoproducto_tl: TStringField;
    mtTransitosTransitokilos_tl: TFloatField;
    QAux: TQuery;
    mtTransitoAux: TkbmMemTable;
    mtTransitoAuxempresa: TStringField;
    mtTransitoAuxcentro_salida: TStringField;
    mtTransitoAuxcentro_destino: TStringField;
    mtTransitoAuxtransito: TIntegerField;
    mtTransitoAuxfecha: TDateField;
    mtTransitoAuxproducto: TStringField;
    mtTransitoAuxkilos_transito: TFloatField;
    mtTransitoAuxkilos_salidos: TFloatField;
    mtTransitoAuxkilos_pendientes: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure mtTransitoCalcFields(DataSet: TDataSet);
    procedure mtTransitoAuxCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    sEmpresa, sCentroSalida: string;
    iReferencia: integer;
    dFecha: TDateTime;
    bDatosCargados: boolean;

    //procedure ConsultaTransito( const AEmpresa, ACentro: string; const AReferencia: Integer; const AFecha: TDateTime );
      procedure RellenaKilosTransitos;
        procedure KilosSalidosTransito;
        procedure TotalesKilosTransito;
        procedure CopiarProductos;
      procedure DetalleTransito;

  public
    { Public declarations }
    function ConsultaTransito( const AEmpresa, ACentro: string; const AReferencia: Integer; const AFecha: TDateTime ): boolean;
    //  procedure RellenaKilosTransitos;
    //    procedure KilosSalidosTransito;
    //    procedure TotalesKilosTransito;
    //  procedure DetalleTransito;

    procedure ListaProductos( var ALista: TStringList );
    procedure Filtro( const AFiltro: string );

    procedure Previsualizar;
  end;



implementation

{$R *.dfm}

uses Variants, Dialogs, DesgloseTransitosQR, UDMBaseDatos, UDMAuxDB;

procedure TDMDesgloseTransitos.DataModuleCreate(Sender: TObject);
begin
  bDatosCargados:= false;
end;

procedure TDMDesgloseTransitos.DataModuleDestroy(Sender: TObject);
begin
  mtTransito.Close;
  mtSalidasTransito.Close;
  mtTransitosTransito.Close;
end;

procedure TDMDesgloseTransitos.mtTransitoCalcFields(DataSet: TDataSet);
begin
  mtTransitokilos_pendientes.AsFloat:= mtTransitokilos_transito.AsFloat -
    mtTransitokilos_salidos.AsFloat;
end;

procedure TDMDesgloseTransitos.KilosSalidosTransito;
begin
  with QAux do
  begin
    SQL.Clear;
    SQL.Add(' select producto_sl, sum(kilos_sl) kilos_sl ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add(' and ref_transitos_sl = :transito ');
    SQL.Add(' and fecha_sl between :fecha and :fechafin ');
    SQL.Add(' group by 1 ');
    SQL.Add(' order by 1 ');

    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('transito').AsInteger:= iReferencia;
    ParamByName('fecha').AsDateTime:= dFecha - 10;
    ParamByName('fechafin').AsDateTime:= dFecha + 90;
    Open;

    while not Eof do
    begin
      if mtTransito.Locate('empresa;centro_salida;transito;fecha;producto',
        VarArrayOf([sEmpresa,sCentroSalida,iReferencia,dFecha,
          FieldByName('producto_sl').AsString]),[]) then
      begin
        mtTransito.Edit;
        mtTransito.FieldByName('kilos_salidos').AsFloat:= FieldByName('kilos_sl').AsFloat;
        try
          mtTransito.Post;
        except
          mtTransito.Cancel;
          raise;
        end;
      end;
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add(' select producto_tl, sum( kilos_tl ) kilos_tl ');
    SQL.Add(' from frf_transitos_l ');
    SQL.Add(' where empresa_tl = :empresa ');
    SQL.Add(' and ref_origen_tl = :transito ');
    SQL.Add(' and fecha_origen_tl = :fecha ');
    SQL.Add(' group by 1 ');
    SQL.Add(' order by 1 ');

    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('transito').AsInteger:= iReferencia;
    ParamByName('fecha').AsDateTime:= dFecha;
    Open;

    while not Eof do
    begin
      if mtTransito.Locate('empresa;centro_salida;transito;fecha;producto',
        VarArrayOf([sEmpresa,sCentroSalida,iReferencia,dFecha,
          FieldByName('producto_tl').AsString]),[]) then
      begin
        mtTransito.Edit;
        mtTransito.FieldByName('kilos_salidos').AsFloat:=
          mtTransito.FieldByName('kilos_salidos').AsFloat + FieldByName('kilos_tl').AsFloat;
        try
          mtTransito.Post;
        except
          mtTransito.Cancel;
          raise;
        end;
      end;
      Next;
    end;
    Close;
  end;
end;

procedure TDMDesgloseTransitos.TotalesKilosTransito;
var
  rKilos, rSalidos: real;
begin
  rKilos:= 0;
  rSalidos:= 0;
  with mtTransito do
  begin
    if Locate('empresa;centro_salida;transito;fecha',
      VarArrayOf([sEmpresa,sCentroSalida,iReferencia,dFecha]),[]) then
    begin
      First;
      while not Eof do
      begin
        rKilos:= rKilos + FieldByName('kilos_transito').AsFloat;
        rSalidos:= rSalidos + FieldByName('kilos_salidos').AsFloat;
        next;
      end;

      Insert;
      FieldByName('empresa').AsString:= sEmpresa;
      FieldByName('centro_salida').AsString:= sCentroSalida;
      FieldByName('transito').AsInteger:= iReferencia;
      FieldByName('fecha').AsDateTime:= dFecha;
      FieldByName('producto').AsString:= '@';
      FieldByName('kilos_transito').AsFloat:= rKilos;
      FieldByName('kilos_salidos').AsFloat:= rSalidos;
      try
        Post;
      except
        Cancel;
        raise;
      end;
    end;
  end;
end;

procedure TDMDesgloseTransitos.RellenaKilosTransitos;
begin
  with QAux do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' select producto_tl, sum( kilos_tl ) kilos ');
    SQL.Add(' from frf_transitos_l ');
    SQL.Add(' where empresa_tl = :empresa ');
    SQL.Add(' and centro_tl = :csalida ');
    SQL.Add(' and referencia_tl = :transito ');
    SQL.Add(' and fecha_tl = :fecha ');
    SQL.Add(' group by 1 ');
    SQL.Add(' order by 1 ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('csalida').AsString:= sCentroSalida;
    ParamByName('transito').AsInteger:= iReferencia;
    ParamByName('fecha').AsDateTime:= dFecha;

    Open;
    mtTransito.Open;
    while not Eof do
    begin
      mtTransito.Insert;
      mtTransito.FieldByName('empresa').AsString:= sEmpresa;
      mtTransito.FieldByName('centro_salida').AsString:= sCentroSalida;
      mtTransito.FieldByName('transito').AsInteger:= iReferencia;
      mtTransito.FieldByName('fecha').AsDateTime:= dFecha;
      mtTransito.FieldByName('producto').AsString:= FieldByName('producto_tl').AsString;
      mtTransito.FieldByName('kilos_transito').AsFloat:= FieldByName('kilos').AsFloat;
      mtTransito.FieldByName('kilos_salidos').AsFloat:= 0;
      try
        mtTransito.Post;
      except
        mtTransito.Cancel;
        raise;
      end;
      Next;
    end;
    Close;
  end;
  KilosSalidosTransito;
  TotalesKilosTransito;
  CopiarProductos;
end;

procedure TDMDesgloseTransitos.CopiarProductos;
var
  iCampos: integer;
begin
  mtTransitoAux.Close;
  mtTransitoAux.Open;
  mtTransito.First;
  while not mtTransito.Eof do
  begin
    if mtTransitoproducto.AsString <> '@' then
    begin
      mtTransitoAux.Insert;
      iCampos:= 0;
      while iCampos < mtTransito.Fields.Count do
      begin
        mtTransitoAux.Fields[iCampos].Value:=  mtTransito.Fields[iCampos].Value;
        Inc( iCampos );
      end ;
      try
        mtTransitoAux.Post;
      except
        mtTransitoAux.Cancel;
      end;
    end;
    mtTransito.Next;
  end;
  mtTransito.First;
  mtTransitoAux.First;
end;

procedure TDMDesgloseTransitos.DetalleTransito;
var
  i: integer;
begin
  with QAux do
  begin
    Close;

    SQL.Clear;
    SQL.Add(' select empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, cliente_sal_sc, ');
    SQL.Add('        dir_sum_sc,  producto_sl, envase_sl, categoria_sl, calibre_sl, ');
    SQL.Add('        n_factura_sc, fecha_factura_sc, sum(kilos_sl) kilos_sl ');
    SQL.Add(' from frf_salidas_l, frf_salidas_c ');
    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add(' and ref_transitos_sl = :transito ');
    SQL.Add(' and fecha_sl between :fecha and :fechafin ');
    SQL.Add(' and empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = centro_salida_sl ');
    SQL.Add(' and n_albaran_sc = n_albaran_sl ');
    SQL.Add(' and fecha_sc = fecha_sl ');
    SQL.Add(' group by empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, cliente_sal_sc, ');
    SQL.Add('        dir_sum_sc,  producto_sl, envase_sl, categoria_sl, calibre_sl, ');
    SQL.Add('        n_factura_sc, fecha_factura_sc ');

    ParamByName('empresa').AsString:= mtTransito.fieldByName('empresa').AsString;
    ParamByName('transito').AsInteger:= mtTransito.fieldByName('transito').AsInteger;
    ParamByName('fecha').AsDateTime:= mtTransito.fieldByName('fecha').AsDateTime - 10;
    ParamByName('fechafin').AsDateTime:= mtTransito.fieldByName('fecha').AsDateTime + 60;

    Open;

    if not IsEmpty then
    begin
      mtSalidasTransito.Open;
      while not Eof do
      begin
        mtSalidasTransito.Insert;
        try
          for i:= 0 to mtSalidasTransito.FieldCount - 1 do
            mtSalidasTransito.Fields[i].Value:= Fields[i].Value;
          mtSalidasTransito.Post;
        except
          mtSalidasTransito.Cancel;
          raise;
        end;
        Next;
      end;
    end;
    Close;

    SQL.Clear;
    SQL.Add(' select empresa_tl, centro_tl, referencia_tl, fecha_tl, producto_tl, ');
    SQL.Add('        sum( kilos_tl ) kilos_tl ');
    SQL.Add(' from frf_transitos_l ');
    SQL.Add(' where empresa_tl = :empresa ');
    SQL.Add(' and ref_origen_tl = :transito ');
    SQL.Add(' and fecha_origen_tl = :fecha ');
    SQL.Add(' group by empresa_tl, centro_tl, referencia_tl, fecha_tl, producto_tl ');

    ParamByName('empresa').AsString:= mtTransito.fieldByName('empresa').AsString;
    ParamByName('transito').AsInteger:= mtTransito.fieldByName('transito').AsInteger;
    ParamByName('fecha').AsDateTime:= mtTransito.fieldByName('fecha').AsDateTime;

    Open;

    if not IsEmpty then
    begin
      mtTransitosTransito.Open;
      while not Eof do
      begin
        mtTransitosTransito.Insert;
        try
          for i:= 0 to mtTransitosTransito.FieldCount - 1 do
            mtTransitosTransito.Fields[i].Value:= Fields[i].Value;
          mtTransitosTransito.Post;
        except
          mtTransitosTransito.Cancel;
          raise;
        end;
        Next;
      end;
    end;
    Close;
  end;
end;

function TDMDesgloseTransitos.ConsultaTransito( const AEmpresa, ACentro: string;
  const AReferencia: Integer; const AFecha: TDateTime ): boolean;
begin
  mtTransito.Close;
  mtSalidasTransito.Close;
  mtTransitosTransito.Close;

  sEmpresa:= AEmpresa;
  sCentroSalida:= ACentro;
  iReferencia:= AReferencia;
  dFecha:= AFecha;

  bDatosCargados:= false;

  try
    RellenaKilosTransitos;
    if mtTransito.Locate('empresa;centro_salida;transito;fecha;producto',
      VarArrayOf([sEmpresa, sCentroSalida, iReferencia, dFecha,'@']),[]) then
    begin
      DetalleTransito;

      mtTransito.Sort([]);
      mtSalidasTransito.Sort([]);
      mtTransitosTransito.Sort([]);

      bDatosCargados:= true;
    end;
  except
    FreeAndNil( QAux );
  end;
  result:= bDatosCargados;
end;

procedure TDMDesgloseTransitos.Previsualizar;
begin
  if bDatosCargados then
    DesgloseTransitosQR.Previsualizar( self.Owner, mtTransito, mtSalidasTransito, mtTransitosTransito );
end;

procedure  TDMDesgloseTransitos.ListaProductos( var ALista: TStringList);
var
  sAux: string;
begin
  if bDatosCargados then
  begin
    with QAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add(' select producto_tl ');
      SQL.Add(' from frf_transitos_l ');
      SQL.Add(' where empresa_tl = :empresa ');
      SQL.Add(' and centro_tl = :csalida ');
      SQL.Add(' and referencia_tl = :transito ');
      SQL.Add(' and fecha_tl = :fecha ');
      SQL.Add(' group by 1 ');
      SQL.Add(' order by 1 ');
      ParamByName('empresa').AsString:= sEmpresa;
      ParamByName('csalida').AsString:= sCentroSalida;
      ParamByName('transito').AsInteger:= iReferencia;
      ParamByName('fecha').AsDateTime:= dFecha;
      Open;
      sAux:= Fields[0].AsString + ') ' + desProducto( sEmpresa, Fields[0].AsString );
      Next;
      if not Eof then
      begin
        ALista.Add( 'Todos los productos' );
        ALista.Add( sAux );
        while not EOF do
        begin
          ALista.Add( Fields[0].AsString + ') ' + desProducto( sEmpresa, Fields[0].AsString ) );
          Next;
        end;
      end
      else
      begin
        ALista.Add( sAux );
      end;
      Close;
    end;
  end;
end;

procedure TDMDesgloseTransitos.Filtro( const AFiltro: string );
begin
  if Trim( AFiltro ) = '' then
  begin
    mtTransito.Filter:= 'producto = ''@''';
    mtTransito.Filtered:= True;
    mtTransitosTransito.Filter:= '';
    mtTransitosTransito.Filtered:= False;
    mtSalidasTransito.Filter:= '';
    mtSalidasTransito.Filtered:= False;
  end
  else
  begin
    mtTransito.Filter:= 'producto = ''' + AFiltro + '''';
    mtTransito.Filtered:= True;
    mtTransitosTransito.Filter:= 'producto_tl = ''' + AFiltro + '''';
    mtTransitosTransito.Filtered:= True;
    mtSalidasTransito.Filter:= 'producto_sl = ''' + AFiltro + '''';
    mtSalidasTransito.Filtered:= True;
  end;
end;

procedure TDMDesgloseTransitos.mtTransitoAuxCalcFields(DataSet: TDataSet);
begin
  mtTransitoAuxkilos_pendientes.AsFloat:= mtTransitoAuxkilos_transito.AsFloat -
    mtTransitoAuxkilos_salidos.AsFloat;
end;

end.
