unit UDLCertificadoLame;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLCertificadoLame = class(TDataModule)
    QDepositoAduana: TQuery;
    QTotalAlbaran: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sModuloOrigen: String;
    procedure AbrirQuerys( const AEmpresa, ACentro: string; const AAlbaran: integer; const AFecha: TDateTime );
    procedure CerrarQuerys;

  public
    { Public declarations }
  end;


  procedure Ejecutar( const AOwner: TComponent; const AEmpresa, ACentro: string;
                      const AAlbaran: integer; const AFecha: TDateTime );


implementation

uses LCertificadoLame;
{$R *.dfm}

var
  DLCertificadoLame: TDLCertificadoLame;

procedure Ejecutar( const AOwner: TComponent; const AEmpresa, ACentro: string;
                    const AAlbaran: integer; const AFecha: TDateTime );
begin

  DLCertificadoLame:= TDLCertificadoLame.Create( AOwner );
  try
    DLCertificadoLame.sModuloOrigen := AOwner.name;
    DLCertificadoLame.AbrirQuerys( AEmpresa, ACentro, AAlbaran, AFecha );
    LCertificadoLame.Previsualizar(AOwner, DLCertificadoLame );
    DLCertificadoLame.CerrarQuerys;
  finally
    FreeAndNil( DLCertificadoLame );
  end;
end;


{ TDLCertificadoLame }

procedure TDLCertificadoLame.AbrirQuerys(const AEmpresa, ACentro: string;  const AAlbaran: integer; const AFecha: TDateTime);
begin
  with QDepositoAduana do
  begin
    SQL.Clear;
    if sModuloOrigen = 'FMSalidas' then
    begin
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
    end
    else
    begin
      SQL.Add('   select empresa_dac, centro_dac, referencia_dac, fecha_dac, cont_lame_dac,   ');
      SQL.Add('          descripcion_c, direccion_c, poblacion_c, cod_postal_c,  nombre_p,    ');
      SQL.Add('          producto_tl producto, descripcion_p, sum(cajas_tl) cajas, sum(kilos_tl) kilos ');
      SQL.Add('   from frf_depositos_aduana_c, frf_transitos_l, frf_productos, frf_centros, frf_provincias ');
      SQL.Add('   where empresa_tl = :empresa   ');
      SQL.Add('     and centro_tl = :centro ');
      SQL.Add('     and referencia_tl = :albaran ');
      SQL.Add('     and fecha_tl = :fecha ');
      SQL.Add('     and empresa_dac = empresa_tl  ');
      SQL.Add('     and centro_dac = centro_tl  ');
      SQL.Add('     and referencia_dac = referencia_tl  ');
      SQL.Add('     and fecha_dac = fecha_tl           ');
      SQL.Add('     and producto_p = producto_tl       ');
      SQL.Add('     and centro_c = centro_dac          ');
      SQL.Add('     and empresa_c = empresa_dac        ');
      SQL.Add('     and codigo_p = cod_postal_c[1,2]   ');
      SQL.Add('   group by 1,2,3,4,5,6,7, 8, 9, 10, 11, 12 ');
    end;
    Prepare;
  end;

  with QTotalAlbaran do
  begin
    SQL.Clear;
    if sModuloOrigen = 'FMSalidas' then
    begin
      SQL.Add(' select sum(cajas_sl) cajas, sum(kilos_sl)kilos ');
      SQL.Add(' from frf_salidas_l  ');
      SQL.Add(' where empresa_sl = :empresa ');
      SQL.Add('   and centro_salida_sl = :centro ');
      SQL.Add('   and n_albaran_sl = :albaran ');
      SQL.Add('   and fecha_sl = :fecha ');
    end
    else
    begin
      SQL.Add(' select sum(cajas_tl) cajas, sum(kilos_tl)kilos ');
      SQL.Add(' from frf_transitos_l  ');
      SQL.Add(' where empresa_tl = :empresa ');
      SQL.Add('   and centro_tl = :centro ');
      SQL.Add('   and referencia_tl = :albaran ');
      SQL.Add('   and fecha_tl = :fecha ');
    end;
    Prepare;
  end;

  with QDepositoAduana do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('albaran').AsInteger:= AAlbaran;
    ParamByName('fecha').AsDate:= AFecha;
    Open;
  end;
  with QTotalAlbaran do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('albaran').AsInteger:= AAlbaran;
    ParamByName('fecha').AsDate:= AFecha;
    Open;
  end;

end;

procedure TDLCertificadoLame.CerrarQuerys;
begin
  QDepositoAduana.Close;
end;

procedure TDLCertificadoLame.DataModuleCreate(Sender: TObject);
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

procedure TDLCertificadoLame.DataModuleDestroy(Sender: TObject);
begin
  QDepositoAduana.Close;
  if QDepositoAduana.Prepared then
    QDepositoAduana.UnPrepare;
  QTotalAlbaran.Close;
  if QTotalAlbaran.Prepared then
    QTotalAlbaran.UnPrepare;
end;

end.
