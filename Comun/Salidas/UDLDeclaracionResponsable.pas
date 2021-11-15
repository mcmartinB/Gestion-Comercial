unit UDLDeclaracionResponsable;

interface

uses
  SysUtils, Classes, DB, DBTables, Quickrpt;

type
  TDLDeclaracionResponsable = class(TDataModule)
    QDeclaracion: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sModuloOrigen: String;
    procedure AbrirQuerys( const AEmpresa, ACentro: string; const AFecha: TDateTime; const AAlbaran: integer );
    procedure CerrarQuerys;

  public
    { Public declarations }
  end;


  procedure Ejecutar( const AOwner: TComponent; const AEmpresa, ACentro: string; const AAlbaran: integer; const AFecha: TDateTime );


implementation

uses LDeclaracionResponsable, DPreview;
{$R *.dfm}

var
  DLDeclaracionResponsable: TDLDeclaracionResponsable;

procedure Ejecutar( const AOwner: TComponent; const AEmpresa, ACentro: string; const AAlbaran: integer;
                    const AFecha: TDateTime);
var
  QLDeclaracionResponsable: TQLDeclaracionResponsable;
begin
  DLDeclaracionResponsable:= TDLDeclaracionResponsable.Create( AOwner );
  try
    DLDeclaracionResponsable.sModuloOrigen := AOwner.name;
    DLDeclaracionResponsable.AbrirQuerys( AEmpresa, ACentro, AFecha, AAlbaran);
    LDeclaracionResponsable.Previsualizar(AOwner, DLDeclaracionResponsable);
    DLDeclaracionResponsable.CerrarQuerys;
  finally
    FreeAndNil( DLDeclaracionResponsable );
  end;
end;

{ TDLDeclaracionResponsable }

procedure TDLDeclaracionResponsable.AbrirQuerys(const AEmpresa, ACentro: string; const AFecha: TDateTime;  const AAlbaran: integer );
begin
  with QDeclaracion do
  begin
    SQL.Clear;
    if sModuloOrigen = 'FMSalidas' then
    begin
      // SELECT DE DBEAVER
      SQL.Add(' select empresas.nombre_e as nombre_empresa, empresas.nif_e as nif_empresa,          ');
      SQL.Add(' CASE WHEN facturas.cod_factura_fc <> '''' THEN facturas.cod_factura_fc              ');
      SQL.Add('        ELSE empresa_sl || centro_salida_sl || ''-'' || LPAD(n_albaran_sl, 6, "0")   ');
      SQL.Add('   END as cod_factura,                                                               ');
      SQL.Add('   facturas.des_pais_fc as pais_desino,                                              ');
      SQL.Add('   salidas_c.fecha_sc as fecha_salida, agrupacion.nombre_a as producto_sl, salidas_c.vehiculo_sc as matricula, sum(salidas_l.kilos_sl) as kilos, sum(salidas_l.cajas_sl) as cajas ');
      SQL.Add(' from frf_salidas_c as salidas_c ');
      SQL.Add(' left join frf_salidas_l as salidas_l on empresa_sc = empresa_sl ');
      SQL.Add('   and centro_salida_sc = centro_salida_sl ');
      SQL.Add('   and n_albaran_sc = n_albaran_sl ');
      SQL.Add('   and fecha_sc = fecha_sl ');
      SQL.Add(' left join tfacturas_cab as facturas on n_factura_fc = n_factura_sc ');
      SQL.Add('   and facturas.fecha_factura_fc = salidas_c.fecha_factura_sc ');
      SQL.Add('   and facturas.cod_empresa_fac_fc = salidas_c.empresa_fac_sc ');
      SQL.Add('   and facturas.cod_serie_fac_fc = salidas_c.serie_fac_sc ');
      SQL.Add(' left join frf_empresas as empresas on empresa_e = empresa_sc ');
      SQL.Add(' left join frf_productos as productos on producto_p = producto_sl ');
      SQL.Add(' left join frf_agrupacion as agrupacion on producto_sl = producto_a ');
      SQL.Add(' where fecha_sc = :fecha_sc ');
      SQL.Add('   and empresa_sc = :empresa_sc ');
      SQL.Add('   and centro_salida_sc = :centro_sc ');
      SQL.Add('   and n_albaran_sc = :albaran ');
      SQL.Add(' group by 1,2,3,4,5,6,7 ');
    end;
    Prepare;
  end;

  with QDeclaracion do
  begin
    ParamByName('empresa_sc').AsString:= AEmpresa;
    ParamByName('centro_sc').AsString:= ACentro;
    ParamByName('albaran').AsInteger:= AAlbaran;
    ParamByName('fecha_sc').AsDate:= AFecha;
    Open;
  end;
end;

procedure TDLDeclaracionResponsable.CerrarQuerys;
begin
  QDeclaracion.Close;
end;

procedure TDLDeclaracionResponsable.DataModuleCreate(Sender: TObject);
begin
{
  with QDepositoAduana do
  begin
    SQL.Clear;
    SQL.Add('   select empresa_dac, centro_dac, referencia_dac, fecha_dac, cont_lame_dac,   ');
    SQL.Add('          descripcion_c, direccion_c, poblacion_c, cod_postal_c,  nombre_p,    ');
    SQL.Add('          producto_sl producto, descripcion_p, sum(cajas_sl) cajas, sum(kilos_sl) kilos ');
    SQL.Add('   from frf_depositos_aduana_c, frf_salidas_l, frf_productos, frf_centros, frf_provincias ');
    SQL.Add('   where empresa_sl = :empresa   ');
    SQL.Add('     and centro_salida_sl = :centro ');
    SQL.Add('     and n_albaran_sl = :albaran ');
    SQL.Add('     and fecha_sl = :fecha ');
    SQL.Add('     and empresa_dac = empresa_sl  ');
    SQL.Add('     and centro_dac = centro_salida_sl  ');
    SQL.Add('     and referencia_dac = n_albaran_sl  ');
    SQL.Add('     and fecha_dac = fecha_sl           ');
    SQL.Add('     and producto_p = producto_sl       ');
    SQL.Add('     and centro_c = centro_dac          ');
    SQL.Add('     and empresa_c = empresa_dac        ');
    SQL.Add('     and codigo_p = cod_postal_c[1,2]   ');
    SQL.Add('   group by 1,2,3,4,5,6,7, 8, 9, 10, 11, 12 ');
    Prepare;
  end;

  with QTotalAlbaran do
  begin
    SQL.Clear;
    SQL.Add(' select sum(cajas_sl) cajas, sum(kilos_sl)kilos ');
    SQL.Add(' from frf_salidas_l  ');
    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add('   and centro_salida_sl = :centro ');
    SQL.Add('   and n_albaran_sl = :albaran ');
    SQL.Add('   and fecha_sl = :fecha ');
    Prepare;
  end;
}
end;

procedure TDLDeclaracionResponsable.DataModuleDestroy(Sender: TObject);
begin
  QDeclaracion.Close;
  if QDeclaracion.Prepared then
    QDeclaracion.UnPrepare;
end;

end.
