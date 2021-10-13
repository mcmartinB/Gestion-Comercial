
unit LDPromedioVentasNetoProduccion;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDLPromedioVentasNetoProduccion = class(TDataModule)
    QSalidas: TQuery;
    mtPromedioVenta: TkbmMemTable;
    mtPromedioClientes: TkbmMemTable;
    mtPromedioProductos: TkbmMemTable;
    mtPromedioPaises: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }

    bDesgloseProductos, bDesgloseClientes, bDesglosePaises: Boolean;

    procedure PreparaQuerySalidas( const AOrigen, ASalida, AProducto, ACliente, APais: string );

    procedure DesgloseProductos( const AEmpresa, AProducto: String; const AKilos, AImporte: Real );
    procedure DesgloseClientes( const AEmpresa, ACliente: String; const AKilos, AImporte: Real );
    procedure DesglosePaises( const APais: String; const AKilos, AImporte: Real );

    // Cambiada Gregorio
    procedure CalcularPrecios(const KilosSinFacturar: Real);

  public
    { Public declarations }

    function  PromedioVentasNetoProduccion(
             const AEmpresa, AOrigen, ASalida, AProducto, ACliente, APais: string;
             const AFechaIni, AFechaFin: TDateTime; var VKgsSinFacturar: real;
             const ADescuento, AGastosSalidas, AGastosTransitos, AEnvasado, ASecciones, AIndirecto, AAbonos,
                   ADesgloseProductos, ADesgloseClientes, ADesglosePaises: boolean ): boolean;
    function CargaTabla( const ADescuento,  AGastosSalidas, AGastosTransitos,
                                AEnvasado, ASecciones, AIndirecto, AAbonos: boolean ): real;
    procedure AnyadirDatosFobALaTabla;
  end;

  function PromedioVentasNetoProduccionExecute( const AOwner: TComponent;
             const AEmpresa, AOrigen, ASalida, AProducto, ACliente, APais: string;
             const AFechaIni, AFechaFin: TDateTime; 
             const ADescuento,  AGastosSalidas, AGastosTransitos, AEnvasado, ASecciones, AIndirecto, AAbonos,
                   ADesgloseProductos, ADesgloseClientes, ADesglosePaises: boolean ): boolean;

implementation

{$R *.dfm}

uses
  Dialogs, Variants, PreciosFOBVentaDL, LQPromedioVentasNetoProduccion, bMath;

var
  DLPromedioVentasNetoProduccion: TDLPromedioVentasNetoProduccion;

function PromedioVentasNetoProduccionExecute( const AOwner: TComponent;
             const AEmpresa, AOrigen, ASalida, AProducto, ACliente, APais: string;
             const AFechaIni, AFechaFin: TDateTime;
             const ADescuento,  AGastosSalidas, AGastosTransitos, AEnvasado,ASecciones, AIndirecto, AAbonos,
                   ADesgloseProductos, ADesgloseClientes, ADesglosePaises: boolean ): boolean;
var
  rKgsSinFacturar: real;
begin
  DLPromedioVentasNetoProduccion:= TDLPromedioVentasNetoProduccion.Create( AOwner );
  try
    result:= DLPromedioVentasNetoProduccion.PromedioVentasNetoProduccion(
               AEmpresa, AOrigen, ASalida, AProducto, ACliente, APais, AFechaIni, AFechaFin, rKgsSinFacturar,
               ADescuento, AGastosSalidas, AGastosTransitos, AEnvasado, ASecciones, AIndirecto, AAbonos,
               ADesgloseProductos, ADesgloseClientes, ADesglosePaises );
    if result then
    begin
      PromedioVentasNetoProduccionReport( AOwner, rKgsSinFacturar ,ADesgloseProductos, ADesgloseClientes, ADesglosePaises );
    end;
  finally
    FreeAndNil( DLPromedioVentasNetoProduccion );
  end;
end;

procedure TDLPromedioVentasNetoProduccion.DataModuleCreate(
  Sender: TObject);
begin
  mtPromedioVenta.FieldDefs.Clear;
  mtPromedioVenta.FieldDefs.Add('empresa', ftString, 3, False);
  mtPromedioVenta.FieldDefs.Add('producto', ftString, 3, False);
  mtPromedioVenta.FieldDefs.Add('centro_salida', ftString, 1, False);
  mtPromedioVenta.FieldDefs.Add('centro_origen', ftString, 1, False);
  mtPromedioVenta.FieldDefs.Add('cliente', ftString, 3, False);
  mtPromedioVenta.FieldDefs.Add('pais', ftString, 2, False);
  mtPromedioVenta.FieldDefs.Add('fecha_ini', ftDate, 0, False);
  mtPromedioVenta.FieldDefs.Add('fecha_fin', ftDate, 0, False);

  mtPromedioVenta.FieldDefs.Add('kilos', ftFloat, 0, False);
  mtPromedioVenta.FieldDefs.Add('kilos_facturacion', ftFloat, 0, False);
  mtPromedioVenta.FieldDefs.Add('importe_facturacion', ftFloat, 0, False);

  mtPromedioVenta.FieldDefs.Add('precio_importe_facturacion', ftFloat, 0, False);

  mtPromedioVenta.FieldDefs.Add('descuento', ftFloat, 0, False);
  mtPromedioVenta.FieldDefs.Add('gasto_salidas', ftFloat, 0, False);
  mtPromedioVenta.FieldDefs.Add('coste_envasado', ftFloat, 0, False);
  mtPromedioVenta.FieldDefs.Add('coste_indirecto', ftFloat, 0, False);
  mtPromedioVenta.FieldDefs.Add('neto_campo', ftFloat, 0, False);

  mtPromedioVenta.FieldDefs.Add('precio_descuento', ftFloat, 0, False);
  mtPromedioVenta.FieldDefs.Add('precio_gasto_salidas', ftFloat, 0, False);
  mtPromedioVenta.FieldDefs.Add('precio_coste_envasado', ftFloat, 0, False);
  mtPromedioVenta.FieldDefs.Add('precio_coste_indirecto', ftFloat, 0, False);
  mtPromedioVenta.FieldDefs.Add('precio_neto_campo', ftFloat, 0, False);

  mtPromedioVenta.FieldDefs.Add('gasto_transitos', ftFloat, 0, False);
  mtPromedioVenta.FieldDefs.Add('neto_produccion', ftFloat, 0, False);

  mtPromedioVenta.FieldDefs.Add('precio_gasto_transitos', ftFloat, 0, False);
  mtPromedioVenta.FieldDefs.Add('precio_neto_produccion', ftFloat, 0, False);
  // Ernesto y Gregorio 09/09/2009
  mtPromedioVenta.FieldDefs.Add('precio_neto_producido', ftFloat, 0, False);

  mtPromedioVenta.CreateTable;
  mtPromedioVenta.Open;

  // PRODUCTOS------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  mtPromedioProductos.FieldDefs.Clear;
  mtPromedioProductos.FieldDefs.Add('empresa_pro', ftString, 3, False);
  mtPromedioProductos.FieldDefs.Add('producto_pro', ftString, 3, False);

  mtPromedioProductos.FieldDefs.Add('kilos_pro', ftFloat, 0, False);
  mtPromedioProductos.FieldDefs.Add('importe_pro', ftFloat, 0, False);
  mtPromedioProductos.FieldDefs.Add('precio_pro', ftFloat, 0, False);

  mtPromedioProductos.IndexFieldNames:= 'empresa_pro;producto_pro';
  mtPromedioProductos.CreateTable;
  mtPromedioProductos.Open;

  // CLIENTES ------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  mtPromedioClientes.FieldDefs.Clear;
  mtPromedioClientes.FieldDefs.Add('empresa_cli', ftString, 3, False);
  mtPromedioClientes.FieldDefs.Add('cliente_cli', ftString, 3, False);

  mtPromedioClientes.FieldDefs.Add('kilos_cli', ftFloat, 0, False);
  mtPromedioClientes.FieldDefs.Add('importe_cli', ftFloat, 0, False);
  mtPromedioClientes.FieldDefs.Add('precio_cli', ftFloat, 0, False);

  mtPromedioClientes.IndexFieldNames:= 'empresa_cli;cliente_cli';
  mtPromedioClientes.CreateTable;
  mtPromedioClientes.Open;

  // PAISES ------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  mtPromedioPaises.FieldDefs.Clear;
  mtPromedioPaises.FieldDefs.Add('pais_pai', ftString, 2, False);

  mtPromedioPaises.FieldDefs.Add('kilos_pai', ftFloat, 0, False);
  mtPromedioPaises.FieldDefs.Add('importe_pai', ftFloat, 0, False);
  mtPromedioPaises.FieldDefs.Add('precio_pai', ftFloat, 0, False);

  mtPromedioPaises.IndexFieldNames:= 'pais_pai';
  mtPromedioPaises.CreateTable;
  mtPromedioPaises.Open;

  DLPreciosFOBVenta:= TDLPreciosFOBVenta.Create( self );
end;

procedure TDLPromedioVentasNetoProduccion.DataModuleDestroy(
  Sender: TObject);
begin
  mtPromedioVenta.Close;
  mtPromedioProductos.Close;
  mtPromedioClientes.Close;
  mtPromedioPaises.Close;
  FreeAndNil( DLPreciosFOBVenta );
end;

function TDLPromedioVentasNetoProduccion.PromedioVentasNetoProduccion(
             const AEmpresa, AOrigen, ASalida, AProducto, ACliente, APais: string;
             const AFechaIni, AFechaFin: TDateTime; var VKgsSinFacturar: real;
             const ADescuento, AGastosSalidas, AGastosTransitos, AEnvasado, ASecciones, AIndirecto, AAbonos,
                   ADesgloseProductos, ADesgloseClientes, ADesglosePaises: boolean ): boolean;
begin
  with mtPromedioVenta do
  begin
    Close;
    Open;
    Insert;

    FieldByName('empresa').AsString:= AEmpresa;
    FieldByName('producto').AsString:= AProducto;
    FieldByName('centro_origen').AsString:= AOrigen;
    FieldByName('centro_salida').AsString:= ASalida;
    FieldByName('pais').AsString:= APais;
    FieldByName('cliente').AsString:= ACliente;

    FieldByName('fecha_ini').AsDateTime:= AFechaIni;
    FieldByName('fecha_fin').AsDateTime:= AFechaFin;

    FieldByName('kilos').AsFloat:= 0;
    FieldByName('kilos_facturacion').AsFloat:= 0;
    FieldByName('importe_facturacion').AsFloat := 0;
    FieldByName('descuento').AsFloat := 0;
    FieldByName('gasto_salidas').AsFloat := 0;
    FieldByName('coste_envasado').AsFloat := 0;
    FieldByName('coste_indirecto').AsFloat := 0;
    FieldByName('neto_campo').AsFloat:= 0;
    FieldByName('gasto_transitos').AsFloat:= 0;
    FieldByName('neto_produccion').AsFloat := 0;
    FieldByName('precio_importe_facturacion').AsFloat := 0;
    FieldByName('precio_descuento').AsFloat := 0;
    FieldByName('precio_gasto_salidas').AsFloat := 0;
    FieldByName('precio_coste_envasado').AsFloat := 0;
    FieldByName('precio_coste_indirecto').AsFloat := 0;
    FieldByName('precio_neto_campo').AsFloat:= 0;
    FieldByName('precio_gasto_transitos').AsFloat:= 0;
    FieldByName('precio_neto_produccion').AsFloat := 0;
      // Ernesto y Gregorio 09/09/2009
    FieldByName('precio_neto_producido').AsFloat := 0;

    Post;
  end;



  PreparaQuerySalidas( AOrigen, ASalida, AProducto, ACliente, APais );
  QSalidas.ParamByName('empresa').AsString:= AEmpresa;
  QSalidas.ParamByName('fechaini').AsDateTime:= AFechaIni;
  QSalidas.ParamByName('fechafin').AsDateTime:= AFechaFin;
  if AOrigen <> '' then
    QSalidas.ParamByName('origen').AsString:= AOrigen;
  if ASalida <> '' then
    QSalidas.ParamByName('salida').AsString:= ASalida;
  if AProducto <> '' then
    QSalidas.ParamByName('producto').AsString:= AProducto;
  if ACliente <> '' then
    QSalidas.ParamByName('cliente').AsString:= ACliente;
  if APais <> '' then
    QSalidas.ParamByName('pais').AsString:= APais;
  QSalidas.Open;
  result:= not QSalidas.IsEmpty;
  if result then
  begin
    bDesgloseProductos:= ADesgloseProductos;
    bDesgloseClientes:= ADesgloseClientes;
    bDesglosePaises:= ADesglosePaises;
    VKgsSinFacturar:= CargaTabla( ADescuento, AGastosSalidas, AGastosTransitos,
                                  AEnvasado, ASecciones, AIndirecto, AAbonos );
  end;
  QSalidas.Close;
end;

procedure TDLPromedioVentasNetoProduccion.PreparaQuerySalidas(
            const AOrigen, ASalida, AProducto, ACliente, APais: string );
var
  sProducto: string;
begin
  sProducto:= '';
  if AProducto <> '' then
  begin
    sProducto:= ' producto_sl = :producto ';
  end;
  if AOrigen <> ''  then
  begin
    if sProducto = '' then
      sProducto:= ' centro_origen_sl = :origen '
    else
      sProducto:= sProducto + ' and centro_origen_sl = :origen ';
  end;

  with QSalidas do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, ');
    if sProducto <> '' then
    begin
      //Debe tener kilos del producto seleccionado
      SQL.Add('        sum ( case when (' + sProducto + ') then kilos_sl else 0 end ) kilos_sl, ');
    end
    else
    begin
      SQL.Add('        sum ( kilos_sl ) kilos_sl, ');
    end;
    SQL.Add('        sum ( importe_neto_sl ) importe_neto_sl ');

    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add(' and fecha_sl between :fechaini and :fechafin ');

    if ASalida <> '' then
      SQL.Add(' and centro_salida_sl = :salida ');
    if ACliente <> '' then
    begin
      SQL.Add(' and cliente_sl = :cliente ');
    end;
    if APais <> '' then
    begin
      SQL.Add(' and ( select pais_c ');
      SQL.Add('       from frf_clientes ');
      SQL.Add('       where empresa_c = :empresa ');
      SQL.Add('       and cliente_c = cliente_sl ) = :pais ');
    end;

    SQL.Add(' group by empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl ');
    if AProducto <> '' then
    begin
      //Debe tener kilos del producto seleccionado
      SQL.Add(' having ( sum ( case when (' + sProducto + ') then kilos_sl else 0 end ) <> 0 ) ');
    end;
    SQL.Add(' order by empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl ');
  end;
end;

function TDLPromedioVentasNetoProduccion.CargaTabla(
            const ADescuento, AGastosSalidas, AGastosTransitos, AEnvasado, ASecciones,
                  AIndirecto, AAbonos: boolean ): real;
begin
  result:= 0;
  With QSalidas do
  begin
    DLPreciosFOBVenta.ConfigFOB( ADescuento, AGastosSalidas, AGastosTransitos,
                                     false, AAbonos, AEnvasado, ASecciones, AIndirecto);
    while not eof do
    begin
      if FieldByname('importe_neto_sl').AsFloat <> 0 then
      begin
        if DLPreciosFOBVenta.PreciosFob( FieldByname('empresa_sl').AsString,
                  FieldByname('centro_salida_sl').AsString,
                  FieldByname('n_albaran_sl').AsInteger,
                  FieldByname('fecha_sl').AsDateTime ) then
        begin
          AnyadirDatosFobALaTabla;
        end;
      end
      else
      begin
        result:= result + FieldByname('kilos_sl').AsFloat
      end;
      Next;
    end;
    //Cambiado Gregorio
    CalcularPrecios(result);
  end;
end;

procedure TDLPromedioVentasNetoProduccion.AnyadirDatosFobALaTabla;
var
  rKilos, rImporte, rGastoSalidas, rGastoTransitos, rCosteEnvasado,
    rCosteIndirecto, rDescuento, rNetoCampo, rNetoProduccion: real;
  rAux: real;
begin
  rKilos:= 0;
  rImporte:= 0;
  rGastoSalidas:= 0;
  rGastoTransitos:= 0;
  rCosteEnvasado:= 0;
  rCosteIndirecto:= 0;
  rDescuento:= 0;
  rNetoCampo:= 0;
  rNetoProduccion:= 0;

  with DLPreciosFOBVenta.mtDatosAlbaran do
  begin
    First;
    while Not Eof do
    begin
      if ( FieldByName('producto').AsString = mtPromedioVenta.FieldByName('producto').AsString ) or
         ( mtPromedioVenta.FieldByName('producto').AsString = '' ) then
      begin
        rKilos:= rKilos + FieldByName('kilos').AsFloat;
        rImporte:= rImporte + ( FieldByName('importe_neto').AsFloat + FieldByName('importe_abonos').AsFloat );

        rDescuento:= rDescuento + ( FieldByName('importe_descuento').AsFloat + FieldByName('importe_comision').AsFloat );

        rGastoSalidas:= rGastoSalidas +  FieldByName('importe_gastos_salidas').AsFloat;
        rGastoTransitos:= rGastoTransitos + FieldByName('importe_gastos_transitos').AsFloat;

        rCosteEnvasado:= rCosteEnvasado + ( FieldByName('importe_envasado').AsFloat + FieldByName('importe_secciones').AsFloat );
        rCosteIndirecto:= rCosteIndirecto + FieldByName('importe_indirecto').AsFloat;

        rAux:= ( FieldByName('importe_neto').AsFloat + FieldByName('importe_abonos').AsFloat ) -
                       ( FieldByName('importe_descuento').AsFloat + FieldByName('importe_comision').AsFloat ) -
                       FieldByName('importe_gastos_salidas').AsFloat -
                       ( FieldByName('importe_envasado').AsFloat + FieldByName('importe_secciones').AsFloat ) -
                       FieldByName('importe_indirecto').AsFloat;
        rNetoCampo:= rNetoCampo + rAux;

        rAux:= rAux - FieldByName('importe_gastos_transitos').AsFloat;
        rNetoProduccion:= rNetoProduccion + rAux;

        if bDesgloseProductos then
        if mtPromedioVenta.FieldByName('producto').AsString = '' then
        begin
          DesgloseProductos( FieldByName('empresa').AsString, FieldByName('producto').AsString,
                             FieldByName('kilos').AsFloat, rAux );
        end;

        if bDesgloseClientes then
        if mtPromedioVenta.FieldByName('cliente').AsString = '' then
        begin
          DesgloseClientes( FieldByName('empresa').AsString, FieldByName('cliente_fac').AsString,
                             FieldByName('kilos').AsFloat, rAux );
        end;

        if bDesglosePaises then
        if mtPromedioVenta.FieldByName('pais').AsString = '' then
        begin
          DesglosePaises( FieldByName('pais').AsString, FieldByName('kilos').AsFloat, rAux );
        end;
      end;
      Next;
    end;
  end;

  with mtPromedioVenta do
  begin
    Edit;

    FieldByName('kilos').AsFloat:= FieldByName('kilos').AsFloat + rKilos;
    FieldByName('kilos_facturacion').AsFloat:= FieldByName('kilos_facturacion').AsFloat + rKilos;

    FieldByName('importe_facturacion').AsFloat := FieldByName('importe_facturacion').AsFloat + rImporte;
    FieldByName('descuento').AsFloat := FieldByName('descuento').AsFloat + rDescuento;
    FieldByName('gasto_salidas').AsFloat := FieldByName('gasto_salidas').AsFloat + rGastoSalidas;
    FieldByName('coste_envasado').AsFloat := FieldByName('coste_envasado').AsFloat + rCosteEnvasado;
    FieldByName('coste_indirecto').AsFloat := FieldByName('coste_indirecto').AsFloat + rCosteIndirecto;
    FieldByName('neto_campo').AsFloat:= FieldByName('neto_campo').AsFloat + rNetoCampo;
    FieldByName('gasto_transitos').AsFloat:= FieldByName('gasto_transitos').AsFloat + rGastoTransitos;
    FieldByName('neto_produccion').AsFloat := FieldByName('neto_produccion').AsFloat + rNetoProduccion;

    Post;
  end;
end;

//Cambiado Gregorio
procedure TDLPromedioVentasNetoProduccion.CalcularPrecios(const KilosSinFacturar: Real);
begin
  with mtPromedioVenta do
  begin
    Edit;

    FieldByName('precio_importe_facturacion').AsFloat := bRoundTo( FieldByName('importe_facturacion').AsFloat / FieldByName('kilos_facturacion').AsFloat, -3 );
    FieldByName('precio_descuento').AsFloat := bRoundTo( FieldByName('descuento').AsFloat / FieldByName('kilos_facturacion').AsFloat, -3 );
    FieldByName('precio_gasto_salidas').AsFloat := bRoundTo( FieldByName('gasto_salidas').AsFloat / FieldByName('kilos_facturacion').AsFloat, -3 );
    FieldByName('precio_coste_envasado').AsFloat := bRoundTo( FieldByName('coste_envasado').AsFloat / FieldByName('kilos_facturacion').AsFloat, -3 );
    FieldByName('precio_coste_indirecto').AsFloat := bRoundTo( FieldByName('coste_indirecto').AsFloat / FieldByName('kilos_facturacion').AsFloat, -3 );
    FieldByName('precio_neto_campo').AsFloat:= bRoundTo( FieldByName('neto_campo').AsFloat / FieldByName('kilos_facturacion').AsFloat, -3 );
    FieldByName('precio_gasto_transitos').AsFloat:= bRoundTo( FieldByName('gasto_transitos').AsFloat / FieldByName('kilos_facturacion').AsFloat, -3 );
    FieldByName('precio_neto_produccion').AsFloat := bRoundTo( FieldByName('neto_produccion').AsFloat / FieldByName('kilos_facturacion').AsFloat, -3 );
      // Ernesto y Gregorio 09/09/2009
    FieldByName('precio_neto_producido').AsFloat := bRoundTo(FieldByName('neto_produccion').AsFloat / (FieldByName('kilos').AsFloat + KilosSinFacturar), -3);

    Post;
  end;

  if bDesgloseProductos then
  with mtPromedioProductos do
  begin
    SortFields:= 'producto_pro';
    Sort([]);
    First;
    while not Eof do
    begin
      Edit;
      FieldByName('precio_pro').AsFloat:= bRoundTo( FieldByName('importe_pro').AsFloat / FieldByName('kilos_pro').AsFloat, -3 );
      Post;
      Next;
    end;
  end;

  if bDesgloseClientes then
  with mtPromedioClientes do
  begin
    SortFields:= 'cliente_cli';
    Sort([]);
    First;
    while not Eof do
    begin
      Edit;
      FieldByName('precio_cli').AsFloat:= bRoundTo( FieldByName('importe_cli').AsFloat / FieldByName('kilos_cli').AsFloat, -3 );
      Post;
      Next;
    end;
  end;

                                                                                             
  if bDesglosePAises then
  with mtPromedioPaises do
  begin
    SortFields:= 'pais_pai';
    Sort([]);
    First;
    while not Eof do
    begin
      Edit;
      FieldByName('precio_pai').AsFloat:= bRoundTo( FieldByName('importe_pai').AsFloat / FieldByName('kilos_pai').AsFloat, -3 );
      Post;
      Next;
    end;
  end;
end;

procedure TDLPromedioVentasNetoProduccion.DesgloseProductos( const AEmpresa, AProducto: String;
            const AKilos, AImporte: Real );
begin
  with mtPromedioProductos do
  if Locate('empresa_pro;producto_pro', VarArrayOf([AEmpresa,AProducto]), [] ) then
  begin
    Edit;
    FieldByName('kilos_pro').AsFloat:= FieldByName('kilos_pro').AsFloat + AKilos;
    FieldByName('importe_pro').AsFloat:= FieldByName('importe_pro').AsFloat + AImporte;
    Post;
  end
  else
  begin
    Insert;
    FieldByName('empresa_pro').AsString:= AEmpresa;
    FieldByName('producto_pro').AsString:= AProducto;
    FieldByName('kilos_pro').AsFloat:= AKilos;
    FieldByName('importe_pro').AsFloat:= AImporte;
    Post;
  end;
end;

procedure TDLPromedioVentasNetoProduccion.DesgloseClientes( const AEmpresa, ACliente: String;
            const AKilos, AImporte: Real );
begin
  with mtPromedioClientes do
  if Locate('empresa_cli;cliente_cli', VarArrayOf([AEmpresa,ACliente]), [] ) then
  begin
    Edit;
    FieldByName('kilos_cli').AsFloat:= FieldByName('kilos_cli').AsFloat + AKilos;
    FieldByName('importe_cli').AsFloat:= FieldByName('importe_cli').AsFloat + AImporte;
    Post;
  end
  else
  begin
    Insert;
    FieldByName('empresa_cli').AsString:= AEmpresa;
    FieldByName('cliente_cli').AsString:= ACliente;
    FieldByName('kilos_cli').AsFloat:= AKilos;
    FieldByName('importe_cli').AsFloat:= AImporte;
    Post;
  end;
end;


procedure TDLPromedioVentasNetoProduccion.DesglosePaises( const APais: String;
            const AKilos, AImporte: Real );
begin
  with mtPromedioPaises do
  if Locate('pais_pai', VarArrayOf([APais]), [] ) then
  begin
    Edit;
    FieldByName('kilos_pai').AsFloat:= FieldByName('kilos_pai').AsFloat + AKilos;
    FieldByName('importe_pai').AsFloat:= FieldByName('importe_pai').AsFloat + AImporte;
    Post;
  end
  else
  begin
    Insert;
    FieldByName('pais_pai').AsString:= APais;
    FieldByName('kilos_pai').AsFloat:= AKilos;
    FieldByName('importe_pai').AsFloat:= AImporte;
    Post;
  end;
end;

end.
