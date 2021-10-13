unit StockFrutaConfeccionadaMasetDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLStockFrutaConfeccionadaMaset = class(TDataModule)
    QListadoConfeccionado: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure DesPreparaQuery;
    procedure PreparaQueryStockConfeccionado( const ACliente: string;
                                              const AResumen, AAgruparProducto: Boolean  );
    procedure PreparaQueryPaletsConfeccionados( const ACliente: string;
                                                const AResumen, AAgruparProducto: Boolean  );
  public
    { Public declarations }
    function  DatosQueryStock( const AEmpresa, ACentro, ACliente: string;
                               const AFechaCarga: TDateTime;
                               const AResumen, AAgruparProducto: Boolean  ): boolean;
    function  DatosQueryConfeccionado( const AEmpresa, ACentro, ACliente: string;
                                       const AFechaDesde, AFechaHasta: TDateTime;
                                       const AResumen, AAgruparProducto: Boolean  ): boolean;
  end;

implementation

{$R *.dfm}

uses UDMConfig;

procedure TDLStockFrutaConfeccionadaMaset.DesPreparaQuery;
begin
  QListadoConfeccionado.Close;
  if QListadoConfeccionado.Prepared then
    QListadoConfeccionado.UnPrepare;
end;

procedure TDLStockFrutaConfeccionadaMaset.PreparaQueryStockConfeccionado(
  const ACliente: string; const AResumen, AAgruparProducto: Boolean );
begin
  DesPreparaQuery;
  with QListadoConfeccionado do
  begin
      SQL.Clear;
      SQL.Add(' select ');
      if not AResumen then
      begin
        if AAgruparProducto then
        begin
          SQL.Add('        x3.producto_base_e producto, ');
          SQL.Add('        x0.previsto_carga fecha_carga, ');
          SQL.Add('        x1.formato_det formato, ');
          SQL.Add('        DATE( x1.fecha_alta_det ) fecha_alta, ');
        end
        else
        begin
          SQL.Add('        x0.previsto_carga fecha_carga, ');
          SQL.Add('        x3.producto_base_e producto, ');
          SQL.Add('        x1.formato_det formato, ');
          SQL.Add('        DATE( x1.fecha_alta_det ) fecha_alta, ');
        end;
      end
      else
      begin
        if AAgruparProducto then
        begin
          SQL.Add('        x3.producto_base_e producto, ');
          SQL.Add('        ''1/1/2001'' fecha_carga, ');
          SQL.Add('        x1.formato_det formato, ');
          SQL.Add('        ''1/1/2001'' fecha_alta, ');
        end
        else
        begin
          SQL.Add('        ''1/1/2001'' fecha_carga, ');
          SQL.Add('        x3.producto_base_e producto, ');
          SQL.Add('        x1.formato_det formato, ');
          SQL.Add('        ''1/1/2001'' fecha_alta, ');
        end;
      end;

      SQL.Add('        x2.nombre_f des_formato, ');
      SQL.Add('        x1.envase_det envase, ');
      SQL.Add('        x3.descripcion_e des_envase, ');
      SQL.Add('        count(distinct x0.ean128_cab) palets, ');
      SQL.Add('        sum(x1.unidades_det) cajas, ');
      SQL.Add('        sum( case when nvl( x1.peso_det, 0 ) = 0 ');
      SQL.Add('                       then round ( x1.unidades_det * x3.peso_neto_e,2 ) ');
      SQL.Add('                       else x1.peso_det end ) peso ');

      SQL.Add(' from   rf_Palet_Pc_Cab x0, ');
      SQL.Add('        rf_Palet_Pc_Det x1, ');
      SQL.Add('        frf_formatos x2, ');
      SQL.Add('        frf_envases x3 ');

      SQL.Add(' Where  x0.empresa_cab = :empresa ');
      SQL.Add('   and  x0.centro_cab = :centro ');
      SQL.Add('   and  x0.status_cab in (''S'',''P'') ');

      if ACliente <> '' then
        SQL.Add('   and  x0.cliente_cab = :cliente ');
      SQL.Add('   and  x1.ean128_det = x0.ean128_cab ');
      SQL.Add('   and  x2.empresa_f = :empresa ');
      SQL.Add('   and  x2.codigo_f = x1.formato_det ');
      SQL.Add('   and  x3.empresa_e = :empresa ');
      SQL.Add('   and  x3.envase_e = x1.envase_det ');

      //Modificado por informacion dada por Juan el 27/4/2009
      SQL.Add('   and  x0.previsto_carga >= :fecha ');

      SQL.Add(' group by 1, 2, 3, 4, 5, 6, 7 ');

      if AAgruparProducto then
        SQL.Add(' order by producto, fecha_carga, formato ')
      else
        SQL.Add(' order by fecha_carga, producto, formato ');

      Prepare;
  end;
end;

procedure TDLStockFrutaConfeccionadaMaset.PreparaQueryPaletsConfeccionados( const ACliente: string;
  const AResumen, AAgruparProducto: Boolean );
begin
  DesPreparaQuery;
  with QListadoConfeccionado do
  begin
      SQL.Clear;
      SQL.Add(' select ');
      if not AResumen then
      begin
        if AAgruparProducto then
        begin
          SQL.Add('        x3.producto_base_e producto, ');
          SQL.Add('        x0.previsto_carga fecha_carga, ');
          SQL.Add('        x1.formato_det formato, ');
          SQL.Add('        DATE( x1.fecha_alta_det ) fecha_alta, ');
        end
        else
        begin
          SQL.Add('        x0.previsto_carga fecha_carga, ');
          SQL.Add('        x3.producto_base_e producto, ');
          SQL.Add('        x1.formato_det formato, ');
          SQL.Add('        DATE( x1.fecha_alta_det ) fecha_alta, ');
        end;
      end
      else
      begin
        if AAgruparProducto then
        begin
          SQL.Add('        x3.producto_base_e producto, ');
          SQL.Add('        ''1/1/2001'' fecha_carga, ');
          SQL.Add('        x1.formato_det formato, ');
          SQL.Add('        ''1/1/2001'' fecha_alta, ');
        end
        else
        begin
          SQL.Add('        ''1/1/2001'' fecha_carga, ');
          SQL.Add('        x3.producto_base_e producto, ');
          SQL.Add('        x1.formato_det formato, ');
          SQL.Add('        ''1/1/2001'' fecha_alta, ');
        end;
      end;

      SQL.Add('        x2.nombre_f des_formato, ');
      SQL.Add('        x1.envase_det envase, ');
      SQL.Add('        x3.descripcion_e des_envase, ');
      SQL.Add('        count(distinct x0.ean128_cab) palets, ');
      SQL.Add('        sum(x1.unidades_det) cajas, ');
      SQL.Add('        sum( case when nvl( x1.peso_det, 0 ) = 0 ');
      SQL.Add('                       then round ( x1.unidades_det * x3.peso_neto_e,2 ) ');
      SQL.Add('                       else x1.peso_det end ) peso ');

      SQL.Add(' from   rf_Palet_Pc_Cab x0, ');
      SQL.Add('        rf_Palet_Pc_Det x1, ');
      SQL.Add('        frf_formatos x2, ');
      SQL.Add('        frf_envases x3 ');

      SQL.Add(' Where  x0.empresa_cab = :empresa ');
      SQL.Add('   and  x0.centro_cab = :centro ');
      //SQL.Add('   and  x0.status_cab in (''S'',''P'') ');
      SQL.Add('   and  x0.status_cab <> ''B'' ');

      if ACliente <> '' then
        SQL.Add('   and  x0.cliente_cab = :cliente ');

      SQL.Add('   and  x1.fecha_alta_det >= :fechaini and x1.fecha_alta_det < :fechafin ');
      SQL.Add('   and  x1.ean128_det = x0.ean128_cab ');
      SQL.Add('   and  x2.empresa_f = :empresa ');
      SQL.Add('   and  x2.codigo_f = x1.formato_det ');
      SQL.Add('   and  x3.empresa_e = :empresa ');
      SQL.Add('   and  x3.envase_e = x1.envase_det ');

      SQL.Add(' group by 1, 2, 3, 4, 5, 6, 7 ');

      if AAgruparProducto then
        SQL.Add(' order by producto, fecha_carga, formato ')
      else
        SQL.Add(' order by fecha_carga, producto, formato ');

      Prepare;
  end;

end;

procedure TDLStockFrutaConfeccionadaMaset.DataModuleDestroy(Sender: TObject);
begin
  DesPreparaQuery;
end;

function TDLStockFrutaConfeccionadaMaset.DatosQueryStock( const AEmpresa, ACentro, ACliente: string;
                                                          const AFechaCarga: TDateTime;
                                                          const AResumen, AAgruparProducto: Boolean  ): boolean;
begin
  PreparaQueryStockConfeccionado( ACliente, AResumen, AAgruparProducto );
  with QListadoConfeccionado do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    if ACliente <> '' then
      ParamByName('cliente').AsString:= ACliente;
    ParamByName('fecha').AsDate:= AFechaCarga;
    Open;
    result:= not IsEmpty;
  end;
end;

function TDLStockFrutaConfeccionadaMaset.DatosQueryConfeccionado( const AEmpresa, ACentro, ACliente: string;
  const AFechaDesde, AFechaHasta: TDateTime; const AResumen, AAgruparProducto: Boolean  ): boolean;
begin
  PreparaQueryPaletsConfeccionados( ACliente, AResumen, AAgruparProducto );
  with QListadoConfeccionado do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    if ACliente <> '' then
      ParamByName('cliente').AsString:= ACliente;
    //Como el campo de la BD contine la informacion de la hora no vale con una simple igualdad
    ParamByName('fechaIni').AsDateTime:= AFechaDesde;
    ParamByName('fechaFin').AsDateTime:= AFechaHasta + 1;

    Open;
    result:= not IsEmpty;
  end;
end;

end.
