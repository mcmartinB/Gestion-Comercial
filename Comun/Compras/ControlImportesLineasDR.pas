unit ControlImportesLineasDR;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DBTables;

type
  TDRControlImportesLineas = class(TDataModule)
    kmtListado: TkbmMemTable;
    qryDatos: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    iTipo: Integer;
    rMax: Real;

    function  OpenDataReporte(const AEmpresa, AProducto, AProveedor, AAlmacen, AAnyoSemana, AEntrega: string;
                              const AFechaIni, AFechaFin: TDateTime; const ATipo: Integer; const AMaxRiesgo: Real; const AVerAlmacen: boolean ): Boolean;
    function  LoadData: boolean;
    procedure LoadRegister;
  public
    { Public declarations }
  end;

  function OpenDataReporte(const AEmpresa, AProducto, AProveedor, AAlmacen, AAnyoSemana, AEntrega: string;
                                  const AFechaIni, AFechaFin: TDateTime; const ATipo: Integer; const AMaxRiesgo: Real; const AVerAlmacen: boolean ): Boolean;
  procedure CloseDataReporte;



implementation

{$R *.dfm}

uses
  UDMAuxDB, bMath;

var
  DRControlImportesLineas: TDRControlImportesLineas;

function OpenDataReporte(const AEmpresa, AProducto, AProveedor, AAlmacen, AAnyoSemana, AEntrega: string;
                                  const AFechaIni, AFechaFin: TDateTime; const ATipo: Integer; const AMaxRiesgo: Real; const AVerAlmacen: boolean ): Boolean;
begin
  DRControlImportesLineas:= TDRControlImportesLineas.Create( nil );
  result:= DRControlImportesLineas.OpenDataReporte(AEmpresa, AProducto, AProveedor, AAlmacen, AAnyoSemana, AEntrega, AFechaIni, AFechaFin, ATipo, AMaxRiesgo, AVerAlmacen );
end;

procedure CloseDataReporte;
begin
  FreeAndNil( DRControlImportesLineas );
end;

procedure TDRControlImportesLineas.DataModuleCreate(Sender: TObject);
begin
  with kmtListado do
  begin
    FieldDefs.Clear;

    FieldDefs.Add('entrega', ftString, 12, False);
    FieldDefs.Add('empresa', ftString, 3, False);
    FieldDefs.Add('producto', ftString, 3, False);
    FieldDefs.Add('proveedor', ftString, 3, False);
    FieldDefs.Add('almacen', ftString, 3, False);
    FieldDefs.Add('anyosemana', ftString, 6, False);

    FieldDefs.Add('des_empresa', ftString, 30, False);
    FieldDefs.Add('des_proveedor', ftString, 30, False);
    FieldDefs.Add('des_almacen', ftString, 30, False);
    FieldDefs.Add('des_producto', ftString, 30, False);

    FieldDefs.Add('kilos', ftFloat, 0, False);
    FieldDefs.Add('importe_linea', ftFloat, 0, False);
    FieldDefs.Add('importe_factura', ftFloat, 0, False);
    FieldDefs.Add('diferencia', ftFloat, 0, False);
    FieldDefs.Add('precio', ftFloat, 0, False);

    IndexFieldNames:= 'entrega';
    CreateTable;
    Open;
  end;
end;

procedure TDRControlImportesLineas.DataModuleDestroy(Sender: TObject);
begin
  kmtListado.Close;
end;

function TDRControlImportesLineas.OpenDataReporte(const AEmpresa, AProducto, AProveedor, AAlmacen, AAnyoSemana, AEntrega: string;
                                                  const AFechaIni, AFechaFin: TDateTime; const ATipo: Integer; const AMaxRiesgo: Real; const AVerAlmacen: boolean ): Boolean;
begin
  iTipo:= ATipo;
  rMax:= AMaxRiesgo;

  with qryDatos do
  begin
    SQL.Clear;
    SQL.Add(' select codigo_Ec entrega, empresa_el empresa, producto_el producto, ');
    if AVerAlmacen then
      SQL.Add('        proveedor_el proveedor, almacen_El almacen, anyo_semana_Ec anyosemana, sum(kilos_El) kilos, ')
    else
      SQL.Add('        proveedor_el proveedor, '''' almacen, anyo_semana_Ec anyosemana, sum(kilos_El) kilos, ');
    SQL.Add('        round( sum(( kilos_El * precio_kg_el )), 2 ) importe_linea, ');
//    SQL.Add('        nvl( ( select sum( importe_ge ) from frf_gastos_entregas where codigo_ge = codigo_el and tipo_ge = ''010'' ), 0) importe_factura ');
    SQL.Add('        nvl( ( select sum( importe_ge ) from frf_gastos_entregas where codigo_ge = codigo_el and tipo_ge = ''054'' ), 0) importe_factura ');

    SQL.Add(' from frf_entregas_c ');
    SQL.Add('      join frf_entregas_l on codigo_Ec = codigo_El ');

    SQL.Add(' where fecha_llegada_ec between :fechaini and :fechafin ');
    if AEmpresa = 'BAG' then
      SQL.Add(' and empresa_ec[1,1] =  "F"  ')
    else
    if AEmpresa = 'SAT' then
      SQL.Add(' and ( empresa_ec = "050" or empresa_ec = "080" ) ')
    else
      SQL.Add(' and empresa_ec =  :empresa  ');

    if AProducto <> '' then
      SQL.Add(' and producto_ec = :producto ');
    if AProveedor <> '' then
      SQL.Add(' and proveedor_ec = :proveedor ');
    if AAlmacen <> '' then
      SQL.Add(' and almacen_el = :almacen ');
    if AAnyoSemana <> '' then
      SQL.Add(' and anyo_semana_Ec = :anyosemana ');
    if AEntrega <> '' then
      SQL.Add(' and codigo_ec = :entrega ');

    SQL.Add(' group by empresa, producto, proveedor, almacen, entrega, anyosemana, importe_factura ');
  end;

  if ( AEmpresa <> 'BAG' ) and ( AEmpresa <> 'SAT' )then
    qryDatos.ParamByName('empresa').AsString:= AEmpresa;
  qryDatos.ParamByName('fechaini').AsDate:= AFechaIni;
  qryDatos.ParamByName('fechafin').AsDate:= AFechaFin;

  if AProducto <> '' then
    qryDatos.ParamByName('producto').AsString:= AProducto;
  if AProveedor <> '' then
    qryDatos.ParamByName('proveedor').AsString:= AProveedor;
  if AAlmacen <> '' then
    qryDatos.ParamByName('almacen').AsString:= AAlmacen;
  if AAnyoSemana <> '' then
    qryDatos.ParamByName('anyosemana').AsString:= AAnyoSemana;
  if AEntrega <> '' then
    qryDatos.ParamByName('entrega').AsString:= AEntrega;
  qryDatos.Open;
  try
    if not qryDatos.IsEmpty then
    begin
      Result:= LoadData;
      kmtListado.SortFields:= 'empresa;producto;proveedor;entrega;almacen';
      kmtListado.Sort([]);
    end
    else
    begin
      Result:= False;
    end;
  finally
    qryDatos.Close;
  end;
end;

function TDRControlImportesLineas.LoadData: boolean;
begin
  while not qryDatos.Eof do
  begin
    LoadRegister;
    qryDatos.Next;
  end;
  Result:= not kmtListado.IsEmpty;
end;

procedure TDRControlImportesLineas.LoadRegister;
var
  rAux: Real;
begin
  rAux:= qryDatos.FieldByName('importe_factura').AsFloat - qryDatos.FieldByName('importe_linea').AsFloat;
  if ( iTipo = 0 ) or ( ( iTipo = 1 ) and ( Abs( rAux ) >= rMax ) ) or ( ( iTipo = 2 ) and ( Abs( rAux ) < rMax ) ) then
  begin
    kmtListado.Insert;
    kmtListado.FieldByName('entrega').AsString:= qryDatos.FieldByName('entrega').AsString;
    kmtListado.FieldByName('empresa').AsString:= qryDatos.FieldByName('empresa').AsString;
    kmtListado.FieldByName('producto').AsString:= qryDatos.FieldByName('producto').AsString;
    kmtListado.FieldByName('proveedor').AsString:= qryDatos.FieldByName('proveedor').AsString;
    kmtListado.FieldByName('almacen').AsString:= qryDatos.FieldByName('almacen').AsString;
    kmtListado.FieldByName('anyosemana').AsString:= qryDatos.FieldByName('anyosemana').AsString;
  (*
     FieldDefs.Add('des_empresa', ftString, 30, False);
      FieldDefs.Add('des_proveedor', ftString, 30, False);
      FieldDefs.Add('des_almacen', ftString, 30, False);
      FieldDefs.Add('des_producto', ftString, 30, False);
  *)
    kmtListado.FieldByName('kilos').AsFloat:= qryDatos.FieldByName('kilos').AsFloat;
    kmtListado.FieldByName('importe_linea').AsFloat:= qryDatos.FieldByName('importe_linea').AsFloat;
    kmtListado.FieldByName('importe_factura').AsFloat:= qryDatos.FieldByName('importe_factura').AsFloat;
    kmtListado.FieldByName('diferencia').AsFloat:= rAux;
    if qryDatos.FieldByName('kilos').AsFloat <> 0 then
    begin
      if qryDatos.FieldByName('importe_linea').AsFloat <> 0 then
      begin
        kmtListado.FieldByName('precio').AsFloat:= broundto( qryDatos.FieldByName('importe_linea').AsFloat / qryDatos.FieldByName('kilos').AsFloat, 3 );
      end
      else
      begin
        kmtListado.FieldByName('precio').AsFloat:= broundto( qryDatos.FieldByName('importe_factura').AsFloat / qryDatos.FieldByName('kilos').AsFloat, 3 );
      end;
    end
    else
    begin
      kmtListado.FieldByName('precio').AsFloat:= 0;
    end;
    kmtListado.Post;
  end;
end;

end.
