unit AsignarKilosTransitosDL;

interface

uses
  SysUtils, Classes, kbmMemTable, DB, DBTables;

type
  TDLAsignarKilosTransitos = class(TDataModule)
    QTransitosPendientes: TQuery;
    tProductoPendiente: TkbmMemTable;
    DSTransitosPendientes: TDataSource;
    QDetalleTransito: TQuery;
    DSDetalleTransito: TDataSource;
    QSalidasTransito: TQuery;
    DSSalidasTransito: TDataSource;
    QSalidasPendiente: TQuery;
    DSSalidasPendiente: TDataSource;
    QTransitoPendiente: TQuery;
    DSTransitoPendiente: TDataSource;
    QMarcarTransito: TQuery;
    QSalidasCabecera: TQuery;
    QSalidasDetalle: TQuery;
    QDetalleTransitoAux: TQuery;
    DataSource1: TDataSource;
    QNuevoDetalleSalidas: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }

    procedure AsignarKilosDetalle( const AOrigen, AProducto: String; const AReferencia: Integer;
                                   var VKilos: Real );
    procedure AsignarKilosDetalleAux( const AOrigen, AProducto: String; const AReferencia: Integer;
                                      var VKilos: Real );
    procedure RepartirKilosDetalleLinea( const AOrigen, AProducto: String;
                                      const AReferencia: Integer; var VKilos: Real );

  public
    { Public declarations }
   procedure QueryListado( const AEmpresa, ACentro, AReferencia:string;
                           const AFechaIni, AFechaFin: TDateTime );
   procedure MarcarTransito( const AEmpresa, ACentro: string;
                             const AFecha: TDateTime; const AReferencia: integer );
   function  AsignarKilosTransito( const AEmpresa, ACentro, ADestino, AOrigen: string;
                             const AFecha: TDateTime; const AReferencia: integer;
                             const AProducto: string; Var VKilos: real ): boolean;
  end;

  procedure CrearModuloDatos( const AParent: TComponent );
  procedure DestruirModuloDatos;

var
  DLAsignarKilosTransitos: TDLAsignarKilosTransitos = nil;

implementation

{$R *.dfm}

uses
  bMath, CAuxiliarDB;

var
  Conexiones: integer = 0;

procedure CrearModuloDatos( const AParent: TComponent );
begin
  if Conexiones = 0 then
  begin
    DLAsignarKilosTransitos:= TDLAsignarKilosTransitos.Create( AParent );
  end;
  Inc( Conexiones );
end;

procedure DestruirModuloDatos;
begin
  if Conexiones > 0 then
  begin
    Dec( Conexiones );
    if Conexiones = 0 then
    begin
      if DLAsignarKilosTransitos <> nil then
        FreeAndNil( DLAsignarKilosTransitos );
    end;
  end;
end;

// ****************************************************************************
// The following code illustrates an example on creating a TkbmMemTable
// on the fly in runtime code.
//
//
//  // Create the memorytable object, and set a few optionel stuff.
//  kbmMemTable1 := TkbmMemTable.Create(Self); //Owner is Self. It will be auto-destroyed.
//  kbmMemTable1.SortOptions := [];                                           // Optional.
//  kbmMemTable1.PersistentFile := 'testfil.txt';                             // Optional.
//  kbmMemTable1.OnCompressSave := kbmMemTable1CompressSave;                  // Optional.
//  kbmMemTable1.OnDecompressLoad := kbmMemTable1DecompressLoad;              // Optional.
//  kbmMemTable1.OnCompressBlobStream := kbmMemTable1CompressBlobStream;      // Optional.
//  kbmMemTable1.OnDecompressBlobStream := kbmMemTable1DecompressBlobStream;  // Optional.
//  kbmMemTable1.OnCalcFields := MemTable1CalcFields;                         // Optional.
//  kbmMemTable1.OnFilterRecord := kbmMemTable1FilterRecord;                  // Optional.
//  kbmMemTable1.MasterSource := Nil;                                         // Optional.
//
//  //Now, creating the field defs.                                           // Similar required.
//  kbmMemTable1.FieldDefs.Clear; //We dont need this line, but it does not hurt either.
//  kbmMemTable1.FieldDefs.Add('Period', ftInteger, 0, False);
//  kbmMemTable1.FieldDefs.Add('Value', ftInteger, 0, False);
//  kbmMemTable1.FieldDefs.Add('Color', ftInteger, 0, False);
//  kbmMemTable1.FieldDefs.Add('Calc', FtString, 20, False);
//  kbmMemTable1.FieldDefs.Add('Date', ftDate, 0, False);
//
//  // Define index fields.                                                   // Optional.
//  kbmMemTable1.IndexDefs.Add('Index1','Value',[]);
//
//  // Finally create the table according to definitions.                     // Required.
//  kbmMemTable1.CreateTable;
//
//  //Since this is a run-time created one, we have to assign the following here.
//  DataSource1.DataSet := kbmMemTable1;
//
//  // Optionel. IndexFields and SortFields must be assigned AFTER CreateTable
//  kbmMemTable1.IndexFields := 'Value';
//  kbmMemTable1.SortFields := 'Value';
//

procedure TDLAsignarKilosTransitos.DataModuleCreate(Sender: TObject);
begin
  with QTransitoPendiente do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_transitos_c ');
    SQL.Add(' where empresa_tc = :empresa_tc ');
    SQL.Add(' and centro_tc = :centro_tc ');
    SQL.Add(' and fecha_tc = :fecha_tc ');
    SQL.Add(' and referencia_tc = :referencia_tc ');

    Prepare;
  end;

  with QMarcarTransito do
  begin
    SQL.Clear;
    SQL.Add(' update frf_transitos_c ');
    SQL.Add(' set status_kilos_tc = 1 ');
    SQL.Add(' where empresa_tc = :empresa_tc ');
    SQL.Add(' and centro_tc = :centro_tc ');
    SQL.Add(' and fecha_tc = :fecha_tc ');
    SQL.Add(' and referencia_tc = :referencia_tc ');

    Prepare;
  end;

  with QDetalleTransito do
  begin
    SQL.Clear;
    //SQL.Add(' select case when producto_tl = ''E'' then ''T'' else producto_tl end producto, ');
    //SQL.Add('        producto_tl producto_real, ');
    SQL.Add(' select producto_tl producto, ');
    SQL.Add('        ( select descripcion_p from frf_productos ');
    SQL.Add('          where empresa_p = empresa_tl and producto_p = producto_tl ) des_producto, ');
    //SQL.Add('        categoria_tl, ');
    SQL.Add('        sum(cajas_tl) cajas, sum(kilos_tl) kilos ');
    SQL.Add(' from frf_transitos_l ');
    SQL.Add(' where empresa_tl = :empresa_tc ');
    SQL.Add(' and centro_tl = :centro_tc ');
    SQL.Add(' and fecha_tl = :fecha_tc ');
    SQL.Add(' and referencia_tl = :referencia_tc ');
    SQL.Add(' group by 1,2 ');
    SQL.Add(' order by 1 ');

    Prepare;
  end;

  with QSalidasTransito do
  begin
    SQL.Clear;
    //SQL.Add(' select case when producto_sl = ''E'' then ''T'' else producto_sl end producto, ');
    //SQL.Add('        producto_sl producto_real, ');
    SQL.Add(' select producto_sl producto, ');
    SQL.Add('        ( select descripcion_p from frf_productos ');
    SQL.Add('          where empresa_p = empresa_sl and producto_p = producto_sl ) des_producto, ');
    //SQL.Add('        categoria_sl, ');
    SQL.Add('        sum(cajas_sl) cajas, sum(kilos_sl) kilos ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa_tc ');
    SQL.Add(' and centro_salida_sl = :centro_tc ');
    SQL.Add(' and fecha_sl >= :fecha_tc ');
    SQL.Add(' and ref_transitos_sl = :referencia_tc ');
    SQL.Add(' group by 1,2 ');
    SQL.Add(' order by 1 ');

    Prepare;
  end;

  with QSalidasPendiente do
  begin
    SQL.Clear;
    //SQL.Add(' select case when producto_sl = ''E'' then ''T'' else producto_sl end producto, ');
    //SQL.Add('        producto_sl producto_real, ');
    SQL.Add(' select producto_sl producto, ');
    SQL.Add('        ( select descripcion_p from frf_productos ');
    SQL.Add('          where empresa_p = empresa_sl and producto_p = producto_sl ) des_producto, ');
    //SQL.Add('        categoria_sl, ');
    SQL.Add('        sum(cajas_sl) cajas, sum(kilos_sl) kilos ');
    SQL.Add(' from frf_salidas_c, frf_salidas_l ');
    SQL.Add(' where empresa_sc = :empresa_tc ');
    SQL.Add(' and centro_salida_sc = :centro_tc ');
    SQL.Add(' and fecha_sc >= :fecha_tc ');
    SQL.Add(' and es_transito_sc = 1 ');
    SQL.Add(' and centro_transito_sc = :centro_destino_tc ');

    SQL.Add(' and empresa_sl = :empresa_tc ');
    SQL.Add(' and centro_salida_sl = :centro_tc ');
    SQL.Add(' and fecha_sl = fecha_sc ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');
    SQL.Add(' and ref_transitos_sl is null ');
    SQL.Add(' group by 1,2 ');
    SQL.Add(' order by 1 ');

    Prepare;
  end;

  with QSalidasCabecera do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sc, centro_salida_sc, fecha_sc, n_albaran_sc, producto_sl ');
    SQL.Add(' from frf_salidas_c, frf_salidas_l ');
    SQL.Add(' where empresa_sc = :empresa_tc ');
    SQL.Add(' and centro_salida_sc = :centro_tc ');
    SQL.Add(' and fecha_sc >= :fecha_tc ');
    SQL.Add(' and es_transito_sc = 1 ');
    SQL.Add(' and centro_transito_sc = :centro_destino_tc ');

    SQL.Add(' and empresa_sl = :empresa_tc ');
    SQL.Add(' and centro_salida_sl = :centro_tc ');
    SQL.Add(' and fecha_sl = fecha_sc ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');
    SQL.Add(' and producto_sl = :producto ');
    SQL.Add(' and ref_transitos_sl is null ');
    SQL.Add(' order by empresa_sc, centro_salida_sc, fecha_sc ');

    Prepare;
  end;

  with QSalidasDetalle do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa_sc ');
    SQL.Add(' and centro_salida_sl = :centro_salida_sc ');
    SQL.Add(' and fecha_sl = :fecha_sc ');
    SQL.Add(' and n_albaran_sl = :n_albaran_sc ');
    SQL.Add(' and producto_sl = :producto_sl ');
    SQL.Add(' and ref_transitos_sl is null ');

    RequestLive:= True;
    Prepare;
  end;

  with QNuevoDetalleSalidas do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where empresa_sl = ''PEP'' ');

    RequestLive:= True;
    Prepare;
  end;

  tProductoPendiente.FieldDefs.Clear;
  tProductoPendiente.FieldDefs.Add('producto', ftString, 3, False);
  tProductoPendiente.FieldDefs.Add('kilos', ftFloat, 0, False);
  tProductoPendiente.IndexFieldNames := 'producto';
  tProductoPendiente.CreateTable;
end;

procedure TDLAsignarKilosTransitos.DataModuleDestroy(Sender: TObject);
begin
  with QTransitoPendiente do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QMarcarTransito do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QDetalleTransito do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QSalidasTransito do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QSalidasPendiente do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QSalidasCabecera do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QSalidasDetalle do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QNuevoDetalleSalidas do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  QTransitosPendientes.Close;
end;

procedure TDLAsignarKilosTransitos.QueryListado( const AEmpresa, ACentro, AReferencia:string;
                                                 const AFechaIni, AFechaFin: TDateTime );
begin
  with QTransitosPendientes do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' select empresa_tc, centro_tc, fecha_tc, referencia_tc, ');
    SQL.Add('        centro_destino_tc, transporte_tc, vehiculo_tc ');
    SQL.Add(' from frf_transitos_c ');
    SQL.Add(' where empresa_tc = :empresa ');
    SQL.Add(' and centro_destino_tc = :centro ');
    SQL.Add(' and fecha_tc between :fecha_ini and :fecha_fin ');
    if AReferencia <> '' then
      SQL.Add(' and referencia_tc = :referencia ');
    SQL.Add(' and status_kilos_tc = 0  ');
    SQL.Add(' order by empresa_tc, centro_tc, fecha_tc, referencia_tc ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fecha_ini').AsDateTime:= AFechaIni;
    ParamByName('fecha_fin').AsDateTime:= AFechaFin;
    if AReferencia <> '' then
      ParamByName('referencia').AsString:= AReferencia;

    Open;
 end;
end;

procedure TDLAsignarKilosTransitos.MarcarTransito( const AEmpresa, ACentro: string;
                             const AFecha: TDateTime; const AReferencia: integer );
begin
  with QMarcarTransito do
  begin
    ParamByName('empresa_tc').AsString:= AEmpresa;
    ParamByName('centro_tc').AsString:= ACentro;
    ParamByName('fecha_tc').AsDateTime:= AFecha;
    ParamByName('referencia_tc').AsInteger:= AReferencia;
    ExecSQL;
  end;
end;

function TDLAsignarKilosTransitos.AsignarKilosTransito(
                             const AEmpresa, ACentro, ADestino, AOrigen: string;
                             const AFecha: TDateTime; const AReferencia: integer;
                             const AProducto: string; var VKilos: real ): boolean;
begin
  with QSalidasCabecera do
  begin
    ParamByName('empresa_tc').AsString:= AEmpresa;
    ParamByName('centro_tc').AsString:= ACentro;
    ParamByName('centro_destino_tc').AsString:= ADestino;
    ParamByName('fecha_tc').AsDateTime:= AFecha;
    ParamByName('producto').AsString:= AProducto;

    Open;

    if not IsEmpty then
    begin
      while ( not Eof ) and ( VKilos > 0 ) do
      begin
        (*TODO*)//Centro origen
        //AsignarKilosDetalle( AOrigen, AProducto, AReferencia, VKilos );
        AsignarKilosDetalle( ACentro, AProducto, AReferencia, VKilos );
        Next;
      end;
      result:= VKilos = 0;
    end
    else
    begin
      result:= False;
    end;
    Close;
  end;
end;

procedure  TDLAsignarKilosTransitos.AsignarKilosDetalle( const AOrigen, AProducto: String;
                                      const AReferencia: Integer; var VKilos: Real );
begin
  with QSalidasDetalle do
  begin
    ParamByName('empresa_sc').AsString:= QSalidasCabecera.FieldByName('empresa_sc').AsString;
    ParamByName('centro_salida_sc').AsString:= QSalidasCabecera.FieldByName('centro_salida_sc').AsString;
    ParamByName('fecha_sc').AsDateTime:= QSalidasCabecera.FieldByName('fecha_sc').AsDateTime;
    ParamByName('n_albaran_sc').AsInteger:= QSalidasCabecera.FieldByName('n_albaran_sc').AsInteger;
    ParamByName('producto_sl').AsString:= QSalidasCabecera.FieldByName('producto_sl').AsString;
    Open;
    if not IsEmpty then
    begin
      while ( not Eof ) and ( VKilos > 0 ) do
      begin
        AsignarKilosDetalleAux( AOrigen, AProducto, AReferencia, VKilos );
        Next;
      end;
    end;
    Close;
  end;
end;

procedure TDLAsignarKilosTransitos.AsignarKilosDetalleAux( const AOrigen, AProducto: String;
                                      const AReferencia: Integer; var VKilos: Real );
begin
  with QSalidasDetalle do
  begin
    //Asignar la linea completa
    if FieldByName('kilos_sl').AsFloat <= VKilos then
    begin
      Edit;
      FieldByName('centro_origen_sl').AsString:= AOrigen;
      FieldByName('producto_sl').AsString:= AProducto;
      FieldByName('ref_transitos_sl').AsInteger:= AReferencia;
      Post;
      VKilos:= VKilos - FieldByName('kilos_sl').AsFloat;
    end
    else
    begin
      RepartirKilosDetalleLinea( AOrigen, AProducto, AReferencia, VKilos );
      (*
      if EnvasePesoVariable( FieldByName('empresa_sl').AsString,
                             FieldByName('envase_sl').AsString ) then
        AsignarKilosDetallePesoVariable( AOrigen, AProducto, AReferencia, VKilos )
      else
        AsignarKilosDetallePesoFijo( AOrigen, AProducto, AReferencia, VKilos );
      *)
    end;
  end
end;

procedure TDLAsignarKilosTransitos.RepartirKilosDetalleLinea( const AOrigen, AProducto: String;
                                      const AReferencia: Integer; var VKilos: Real );
var
  i: integer;
  oField: TField;
  rKilosQuedan, rPesoMedio: real;
  iCajas, iCajasQuedan: Integer;
  iUnidadesCaja, iUnidades: Integer;
  iPalets, iPaletsQuedan: integer;
  rImporte, rIva, rTotal, rImporteQueda, rIvaQueda, rTotalQueda: real;
begin
  with QSalidasDetalle do
  begin
    //Kilos quedan
    rKilosQuedan:= FieldByName('kilos_sl').AsFloat - VKilos;
    rPesoMedio:= bRoundTo( FieldByName('kilos_sl').AsFloat / FieldByName('cajas_sl').AsInteger, -2 );
    iCajas:= Trunc( bRoundTo( VKilos / rPesoMedio, 0 ) );
    iCajasQuedan:= FieldByName('cajas_sl').AsInteger - iCajas;

    iPalets:= Trunc( bRoundTo( ( ( iCajas * FieldByName('n_palets_sl').AsInteger ) / FieldByName('cajas_sl').AsInteger) , 0 ) );
    iPaletsQuedan:= FieldByName('n_palets_sl').AsInteger - iPalets;

    iUnidadesCaja:= FieldByName('unidades_caja_sl').AsInteger;
    iUnidades:= iCajas * iUnidadesCaja;

    if FieldByName('unidad_precio_sl').AsString = 'KGS' then
    begin
      rImporte:= VKilos * FieldByName('precio_sl').AsFloat;
    end
    else
    if FieldByName('unidad_precio_sl').AsString = 'UND' then
    begin
      rImporte:= iUnidades * FieldByName('precio_sl').AsFloat;
    end
    else
    begin
      rImporte:= iCajas * FieldByName('precio_sl').AsFloat;
    end;
    rImporteQueda:= FieldByName('importe_neto_sl').AsFloat - rImporte;
    rIva:= bRoundTo( ( rImporteQueda * FieldByName('porc_iva_sl').AsFloat ) / 100, -2 );
    rIvaQueda:= FieldByName('iva_sl').AsFloat - rIva;
    rTotal:= rImporte + rIva;
    rTotalQueda:= FieldByName('importe_total_sl').AsFloat - rTotal;

    //Registro nuevo
    QNuevoDetalleSalidas.Open;
    QNuevoDetalleSalidas.Insert;
    for i:= 0 to QNuevoDetalleSalidas.FieldCount -1 do
    begin
      oField:= FindField( QNuevoDetalleSalidas.Fields[i].FieldName );
      if ( oField <> nil ) and ( oField.CanModify ) then
      begin
        QNuevoDetalleSalidas.Fields[i].Value:= oField.Value;
      end;
    end;
    QNuevoDetalleSalidas.FieldByName('centro_origen_sl').AsString:= AOrigen;
    QNuevoDetalleSalidas.FieldByName('producto_sl').AsString:= AProducto;
    QNuevoDetalleSalidas.FieldByName('kilos_sl').AsFloat:= rKilosQuedan;
    QNuevoDetalleSalidas.FieldByName('cajas_sl').AsInteger:= iCajasQuedan;
    QNuevoDetalleSalidas.FieldByName('n_palets_sl').AsInteger:= iPaletsQuedan;
    QNuevoDetalleSalidas.FieldByName('importe_neto_sl').AsFloat:= rImporteQueda;
    QNuevoDetalleSalidas.FieldByName('iva_sl').AsFloat:= rIvaQueda;
    QNuevoDetalleSalidas.FieldByName('importe_total_sl').AsFloat:= rTotalQueda;
    QNuevoDetalleSalidas.Post;

    //Modificacion del que habia
    Edit;
    FieldByName('centro_origen_sl').AsString:= AOrigen;
    FieldByName('producto_sl').AsString:= AProducto;
    FieldByName('ref_transitos_sl').AsInteger:= AReferencia;
    FieldByName('kilos_sl').AsFloat:= VKilos;
    FieldByName('cajas_sl').AsInteger:= iCajas;
    FieldByName('n_palets_sl').AsInteger:= iPalets;
    FieldByName('importe_neto_sl').AsFloat:= rImporte;
    FieldByName('iva_sl').AsFloat:= rIva;;
    FieldByName('importe_total_sl').AsFloat:= rTotal;
    Post;

    VKilos:= 0;
  end
end;

end.
