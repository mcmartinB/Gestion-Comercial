unit LiquidacionEntregaDL;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDLLiquidacionEntrega = class(TDataModule)
    QEntrega: TQuery;
    TMemGastos: TkbmMemTable;
    QPacking: TQuery;
    QTiposDeGastos: TQuery;
    QCosteCompra: TQuery;
    QAlbaranesVenta: TQuery;
    QDestrio: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure QEntregaBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }
    procedure CrearTablaEnMemoria;
    procedure BorrarTablaEnMemoria;

    procedure KilosLiquidar( const AEntrega, AProducto, AVariedad, ACalibre: string;
                             var VKilosTotal, VKilosProducto, VKilosLiquidar: real );
    procedure LineaLiquidacion( const AEntrega, AProducto, AVariedad, ACalibre, AProveedor: string;
                                const AKilosAjusteVentas, AKilosAjusteDestrio,
                                      AImportePteVta, AImporteDestrio : real );
    procedure CosteCompra( const AEntrega, AProducto: string;
                          const AKilosTotal, AKilosProducto, AKilosLiquidar: Real );
    procedure ImporteVenta( const AEntrega, AProducto, AVariedad, ACalibre: string );
    function  GetFob( var AAbonos: Real ): real;

    procedure KilosEntrega( const AEntrega, AProducto, AVariedad, ACalibre: string;
                                             var VKilosEntrega, VKilosDestrio: real );

  public
    { Public declarations }
    iTipoGastos: integer;
    aTipoGastos: array of string;

    function DatosEntrega( const ACodigo: string ): boolean;
    function DatosLiquidacion( const AEntrega, AProducto, AVariedad, ACalibre, AProveedor: string;
                               const AKilosAjusteVentas, AKilosAjusteDestrio,
                                     AImportePteVta, AImporteDestrio: real  ): boolean;
  end;

var
  DLLiquidacionEntrega: TDLLiquidacionEntrega;

implementation

{$R *.dfm}

uses variants, bMath, PreciosFOBVentaDL;

var
  DLPreciosFOBVenta: TDLPreciosFOBVenta;

procedure TDLLiquidacionEntrega.DataModuleCreate(Sender: TObject);
begin
  with QEntrega do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_ec, centro_llegada_ec, proveedor_ec, producto_el, variedad_el, calibre_el, kilos_el ');
    SQL.Add(' from frf_entregas_c, frf_entregas_l ');
    SQL.Add(' where codigo_ec = :codigo ');
    SQL.Add(' and codigo_el = codigo_ec ');
    SQL.Add(' order by empresa_ec, centro_llegada_ec, proveedor_ec, producto_el, variedad_el, calibre_el ');
    Prepare;
  end;

  with QPacking do
  begin
    SQL.Clear;
    SQL.Add(' select sscc, ean128_pl, empresa, entrega, centro, proveedor, ');
    SQL.Add('        ( select cliente_sal_occ from frf_orden_carga_c where orden_occ = orden_pl ) cliente, ');
    SQL.Add('        producto, producto_pl, variedad, envase_pl, calibre, calibre_pl, ');
    SQL.Add('        peso_bruto, peso, peso_pl, cajas, cajas_pl, status ');
    SQL.Add(' from rf_palet_pb, outer frf_packing_list ');
    SQL.Add(' where entrega = :codigo ');
    SQL.Add('   and orden_pl = orden_carga ');
    SQL.Add('   and sscc = ean128_pl ');
    //SQL.Add('   and orden_carga = orden_pl ');

    Prepare;
  end;

  with QCosteCompra do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_gastos_entregas ');
    SQL.Add(' where codigo_ge = :codigo ');

    Prepare;
  end;

  with QAlbaranesVenta do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_occ, centro_salida_occ, n_albaran_occ, fecha_occ, ');
    SQL.Add('        producto, variedad, envase_pl, calibre, sum( peso_pl ) kilos_pl ');
    SQL.Add('  from rf_palet_pb, frf_packing_list, frf_orden_carga_c ');
    SQL.Add('  where entrega = :codigo ');
    SQL.Add('    and ean128_pl = sscc ');
    SQL.Add('    and orden_pl = orden_carga ');
    SQL.Add('    and orden_occ = orden_pl ');
    SQL.Add('  group by empresa_occ, centro_salida_occ, n_albaran_occ, fecha_occ, ');
    SQL.Add('           producto, variedad, envase_pl, calibre ');
    SQL.Add('  order by empresa_occ, centro_salida_occ, n_albaran_occ, fecha_occ, ');
    SQL.Add('           producto, variedad, envase_pl, calibre ');

    Prepare;
  end;

  CrearTablaEnMemoria;
  DLPreciosFOBVenta:= TDLPreciosFOBVenta.Create( self );
end;

procedure TDLLiquidacionEntrega.CrearTablaEnMemoria;
begin
  TMemGastos.FieldDefs.Clear;
  TMemGastos.FieldDefs.Add('entrega', ftString, 12, False);
  TMemGastos.FieldDefs.Add('producto', ftString, 3, False);
  TMemGastos.FieldDefs.Add('variedad', ftString, 3, False);
  TMemGastos.FieldDefs.Add('calibre', ftString, 6, False);
  TMemGastos.FieldDefs.Add('proveedor', ftString, 3, False);

  with QTiposDeGastos do
  begin
    SQL.Clear;
    SQL.Add(' select tipo_tg ');
    SQL.Add(' from frf_tipo_gastos ');
    SQL.Add(' where gasto_transito_tg = 2 ');
    SQL.Add(' order by tipo_tg ');
    Open;

    while not EOF do
    begin
      iTipoGastos:= iTipoGastos + 1;
      SetLength( aTipoGastos, iTipoGastos );
      aTipoGastos[ iTipoGastos - 1]:= FieldByName('tipo_tg').AsString;
      TMemGastos.FieldDefs.Add('g' + FieldByName('tipo_tg').AsString, ftFloat, 0, False);
      Next;
    end;
    Close;
  end;

  TMemGastos.FieldDefs.Add('totalCompra', ftFloat, 0, False);
  TMemGastos.FieldDefs.Add('totalVenta', ftFloat, 0, False);
  TMemGastos.FieldDefs.Add('totalDestrio', ftFloat, 0, False);
  TMemGastos.FieldDefs.Add('totalAbonos', ftFloat, 0, False);
  TMemGastos.FieldDefs.Add('pendienteVenta', ftFloat, 0, False);

  TMemGastos.FieldDefs.Add('totalKgCompra', ftFloat, 0, False);
  TMemGastos.FieldDefs.Add('totalKgVenta', ftFloat, 0, False);
  TMemGastos.FieldDefs.Add('totalKgDestrio', ftFloat, 0, False);
  TMemGastos.FieldDefs.Add('ajusteKgVenta', ftFloat, 0, False);
  TMemGastos.FieldDefs.Add('ajusteKgDestrio', ftFloat, 0, False);

  TMemGastos.IndexFieldNames:= 'entrega;producto;variedad;calibre';
  TMemGastos.CreateTable;
  TMemGastos.Open;
end;

procedure TDLLiquidacionEntrega.BorrarTablaEnMemoria;
begin
  TMemGastos.Close;
  FreeAndNil( TMemGastos );
end;

procedure TDLLiquidacionEntrega.DataModuleDestroy(Sender: TObject);
begin
  QEntrega.Close;
  if QEntrega.Prepared then
    QEntrega.UnPrepare;

  QPacking.Close;
  if QPacking.Prepared then
    QPacking.UnPrepare;

  QCosteCompra.Close;
  if QCosteCompra.Prepared then
    QCosteCompra.UnPrepare;

  QAlbaranesVenta.Close;
  if QAlbaranesVenta.Prepared then
    QAlbaranesVenta.UnPrepare;

  BorrarTablaEnMemoria;
  FreeAndNil( DLPreciosFOBVenta );
end;

function TDLLiquidacionEntrega.DatosEntrega( const ACodigo: string ): boolean;
begin
  QEntrega.Close;
  with QEntrega do
  begin
    ParamByName('codigo').AsString:= ACodigo;
    Open;
    result:= not IsEmpty;
  end;
  if result then
  with QPacking do
  begin
    ParamByName('codigo').AsString:= ACodigo;
    Open;
  end;
end;

procedure TDLLiquidacionEntrega.QEntregaBeforeClose(DataSet: TDataSet);
begin
  QPacking.Close;
end;

function TDLLiquidacionEntrega.DatosLiquidacion( const AEntrega, AProducto, AVariedad, ACalibre, AProveedor: string;
                                                 const AKilosAjusteVentas, AKilosAjusteDestrio,
                                                       AImportePteVta, AImporteDestrio: real  ): boolean;
var
  rKilosTotal, rKilosProducto, rKilosLiquidar: real;
begin
  KilosLiquidar( AEntrega, AProducto, AVariedad, ACalibre, rKilosTotal, rKilosProducto, rKilosLiquidar );
  result:= 0 <> rKilosLiquidar;
  if result then
  begin
    TMemGastos.Close;
    TMemGastos.Open;
    LineaLiquidacion( AEntrega, AProducto, AVariedad, ACalibre, AProveedor,
                      AKilosAjusteVentas, AKilosAjusteDestrio, AImportePteVta, AImporteDestrio );
    CosteCompra( AEntrega, AProducto, rKilosTotal, rKilosProducto, rKilosLiquidar );
    ImporteVenta( AEntrega, AProducto, AVariedad, ACalibre );
  end;
end;

procedure TDLLiquidacionEntrega.LineaLiquidacion( const AEntrega, AProducto, AVariedad, ACalibre, AProveedor: string;
                                                  const AKilosAjusteVentas, AKilosAjusteDestrio,
                                                        AImportePteVta, AImporteDestrio: real  );
begin
  TMemGastos.Insert;
  TMemGastos.FieldByname('entrega').AsString:= AEntrega;
  TMemGastos.FieldByname('producto').AsString:= AProducto;
  TMemGastos.FieldByname('variedad').AsString:= AVariedad;
  TMemGastos.FieldByname('calibre').AsString:= ACalibre;
  TMemGastos.FieldByname('proveedor').AsString:= AProveedor;

  TMemGastos.FieldByname('totalDestrio').AsFloat:= AImportePteVta;
  TMemGastos.FieldByname('pendienteVenta').AsFloat:= AImporteDestrio;
  TMemGastos.FieldByname('ajusteKgVenta').AsFloat:= AKilosAjusteVentas;
  TMemGastos.FieldByname('ajusteKgDestrio').AsFloat:= AKilosAjusteDestrio;

  TMemGastos.Post;
  TMemGastos.Locate('entrega;producto;variedad;calibre',
        VarArrayOf([AEntrega,AProducto,AVariedad,ACalibre]),[]);
end;

procedure TDLLiquidacionEntrega.KilosLiquidar( const AEntrega, AProducto, AVariedad, ACalibre: string;
                                              var VKilosTotal, VKilosProducto, VKilosLiquidar: real );
begin
  with QEntrega do
  begin
    VKilosTotal:= 0;
    VKilosProducto:= 0;
    VKilosLiquidar:= 0;
    First;
    while not Eof do
    begin
      VKilosTotal:= VKilosTotal + FieldByname('kilos_el').AsFloat;
      if AProducto = '' then
      begin
        VKilosProducto:= VKilosTotal;
        VKilosLiquidar:= VKilosTotal;
      end
      else
      begin
        if AProducto = FieldByname('producto_el').AsString then
        begin
          VKilosProducto:= VKilosProducto + FieldByname('kilos_el').AsFloat;
          if AVariedad = '' then
          begin
            if ( ACalibre = '' ) or ( ACalibre = FieldByname('calibre_el').AsString ) then
            begin
              VKilosLiquidar:= VKilosLiquidar + FieldByname('kilos_el').AsFloat;
            end;
          end
          else
          begin
            if ( AVariedad = FieldByname('variedad_el').AsString ) and
               ( ( ACalibre = '' ) or ( ACalibre = FieldByname('calibre_el').AsString ) ) then
            begin
              VKilosLiquidar:= VKilosLiquidar + FieldByname('kilos_el').AsFloat;
            end;
          end;
        end;
      end;
      Next;
    end;
  end;
end;

procedure TDLLiquidacionEntrega.CosteCompra( const AEntrega, AProducto: string;
                                            const AKilosTotal, AKilosProducto, AKilosLiquidar: Real );
var
  sProducto: string;
  rCoste, rAcum: Real;
begin
  rAcum:= 0;
  with QCosteCompra do
  begin
    ParamByName('codigo').AsString:= AEntrega;
    Open;
    while not Eof do
    begin
      sProducto:= FieldByName('producto_ge').AsString;
      rCoste:= 0;
      if sProducto = '' then
      begin
        rCoste:= bRoundTo ( ( FieldByName('importe_ge').AsFloat * AKilosLiquidar ) / AKilosTotal, -2 );
      end
      else
      if sProducto = AProducto then
      begin
        rCoste:= bRoundTo ( ( FieldByName('importe_ge').AsFloat * AKilosLiquidar ) / AKilosProducto, -2 );
      end;

      if TMemGastos.FindField( 'g' + FieldByName('tipo_ge').AsString ) <> nil then
      begin
        rAcum:= rAcum + rCoste;
        TMemGastos.Edit;
        TMemGastos.FieldByName( 'g' + FieldByName('tipo_ge').AsString ).AsFloat:= rCoste;
        TMemGastos.Post;
      end;
      Next;
    end;
    Close;
  end;
  TMemGastos.Edit;
  TMemGastos.FieldByName( 'totalCompra' ).AsFloat:= rAcum * -1;
  TMemGastos.FieldByName( 'totalKgCompra' ).AsFloat:= AKilosLiquidar * -1;
  TMemGastos.Post;
end;

function TDLLiquidacionEntrega.GetFob( var AAbonos: Real ): real;
var
  AKilos, AImporte, AComision, ADescuento, AGastos, AEnvasado, ASecciones: real;
begin
  with QAlbaranesVenta do
  begin
    AAbonos:= 0;
    result:= 0;
    DLPreciosFOBVenta.ConfigFOB( True, True, False, True, false, False, False, False );
    if DLPreciosFOBVenta.GetFobCalibre( FieldByname('empresa_occ').AsString,
         FieldByname('centro_salida_occ').AsString, FieldByname('n_albaran_occ').AsInteger,
         FieldByname('fecha_occ').AsDateTime, FieldByname('producto').AsString,
         FieldByname('envase_pl').AsString, FieldByname('calibre').AsString,
         AKilos, AImporte, AComision, ADescuento, AGastos, AEnvasado, ASecciones, AAbonos, result ) then
    begin
      if AKilos <> 0 then
      begin
       AAbonos:= bRoundTo( AAbonos / AKilos, -3 );
      end;
    end;
  end;
end;

procedure TDLLiquidacionEntrega.KilosEntrega( const AEntrega, AProducto, AVariedad, ACalibre: string;
                                             var VKilosEntrega, VKilosDestrio: real );
begin
  VKilosEntrega:= 0;
  VKilosDestrio:= 0;
  with QPacking do
  begin
    First;
    while not eof do
    begin
      if AProducto = '' then
      begin
        if ( FieldByName('cliente').AsString = '003' ) or ( FieldByName('status').AsString = 'D' ) then
          VKilosDestrio:= VKilosDestrio + FieldByName('peso').AsFloat
        else
          VKilosEntrega:= VKilosEntrega + FieldByName('peso').AsFloat;
      end
      else
      begin
        if FieldByName('producto').AsString = AProducto then
        begin
          if AVariedad = '' then
          begin
            if ( FieldByName('cliente').AsString = '003' ) or ( FieldByName('status').AsString = 'D' ) then
              VKilosDestrio:= VKilosDestrio + FieldByName('peso').AsFloat
            else
              VKilosEntrega:= VKilosEntrega + FieldByName('peso').AsFloat;
          end
          else
          begin
            if FieldByName('variedad').AsString = AVariedad then
            begin
              if ACalibre = '' then
              begin
                if ( FieldByName('cliente').AsString = '003' ) or ( FieldByName('status').AsString = 'D' ) then
                  VKilosDestrio:= VKilosDestrio + FieldByName('peso').AsFloat
                else
                  VKilosEntrega:= VKilosEntrega + FieldByName('peso').AsFloat;
              end
              else
              begin
                if FieldByName('calibre').AsString = ACalibre then
                begin
                  if ( FieldByName('cliente').AsString = '003' ) or ( FieldByName('status').AsString = 'D' ) then
                    VKilosDestrio:= VKilosDestrio + FieldByName('peso').AsFloat
                  else
                    VKilosEntrega:= VKilosEntrega + FieldByName('peso').AsFloat;
                end;
              end;
            end;
          end;
        end;
      end;
      Next;
    end;
  end;
end;

procedure TDLLiquidacionEntrega.ImporteVenta( const AEntrega, AProducto, AVariedad, ACalibre: string );
var
  rFob, rAcumImporte, rAcumKilos, rAcumDestrio, AAbonos, rAcumAbonos: real;
begin
  rAcumAbonos:= 0;
  rAcumImporte:= 0;
  rAcumKilos:= 0;
  with QAlbaranesVenta do
  begin
    ParamByName('codigo').AsString:= AEntrega;
    Open;
    while not Eof do
    begin
      rFob:= 0;
      if AProducto <> '' then
      begin
        if AProducto = FieldByname('producto').AsString then
        begin
          if AVariedad <> '' then
          begin
            if AVariedad = FieldByname('variedad').AsString then
            begin
              if ACalibre <> '' then
              begin
                if ACalibre = FieldByname('calibre').AsString then
                begin
                  rFob:= GetFob( AAbonos );
                  //if FieldByName('cliente_sal_occ').AsString <> '003' then
                  //  rAcumKilos:= rAcumKilos + FieldByname('kilos_pl').AsFloat;
                end;
              end
              else
              begin
                rFob:= GetFob( AAbonos );
                //if FieldByName('cliente_sal_occ').AsString <> '003' then
                //  rAcumKilos:= rAcumKilos + FieldByname('kilos_pl').AsFloat;
              end;
            end;
          end
          else
          begin
            rFob:= GetFob( AAbonos );
            //if FieldByName('cliente_sal_occ').AsString <> '003' then
            //  rAcumKilos:= rAcumKilos + FieldByname('kilos_pl').AsFloat;
          end;
        end;
      end
      else
      begin
        rFob:= GetFob( AAbonos );
        //if FieldByName('cliente_sal_occ,').AsString <> '003' then
        //  rAcumKilos:= rAcumKilos + FieldByname('kilos_pl').AsFloat;
      end;
      if rFob <> 0 then
      begin
        rAcumImporte:= rAcumImporte + bRoundTo( ( FieldByname('kilos_pl').AsFloat * rFob ), -2 );
        rAcumAbonos:= rAcumAbonos + bRoundTo( ( FieldByname('kilos_pl').AsFloat * AAbonos ), -2 );
      end;
      Next;
    end;
    Close;
  end;
  TMemGastos.Edit;
  TMemGastos.FieldByName( 'totalVenta' ).AsFloat:= rAcumImporte;
  TMemGastos.FieldByName( 'totalAbonos' ).AsFloat:= rAcumAbonos;

  KilosEntrega( AEntrega, AProducto, AVariedad, ACalibre, rAcumKilos, rAcumDestrio );
  TMemGastos.FieldByName( 'totalKgVenta' ).AsFloat:= rAcumKilos;
  TMemGastos.FieldByname( 'totalKgDestrio' ).AsFloat:= rAcumDestrio;
  TMemGastos.Post;
end;

end.
