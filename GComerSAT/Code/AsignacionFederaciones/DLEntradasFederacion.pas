unit DLEntradasFederacion;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDMLEntradasFederacion = class(TDataModule)
    QListado: TQuery;
    QResumen: TQuery;
    mtResumen: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure RellenarTablaTemporal( const AEmpresa, ACentro, AProducto: string; const AFecha: TDateTime );
  public
    { Public declarations }
    procedure PorcentajesEntregas( const AEmpresa, ACEntro, AProducto: string; const AFecha: TDateTime );
  end;

var
  DMLEntradasFederacion: TDMLEntradasFederacion;

implementation

{$R *.dfm}

uses UDMBaseDatos, bMath;

procedure TDMLEntradasFederacion.DataModuleCreate(Sender: TObject);
begin
  with mtResumen do
  begin
    FieldDefs.Clear;

    FieldDefs.Add('producto', ftString, 3, False);
    FieldDefs.Add('federacion', ftInteger, 0, False);
    FieldDefs.Add('kilos', ftFloat, 0, False);
    FieldDefs.Add('total', ftFloat, 0, False);
    FieldDefs.Add('porcentaje', ftFloat, 0, False);
    CreateTable;
    IndexDefs.Add('Index1','producto;federacion',[]);
    IndexName:= 'Index1';
    (*
    SortFields:= 'federacion';
    IndexFieldNames:= 'federacion';
    *)
  end;
end;

procedure TDMLEntradasFederacion.DataModuleDestroy(Sender: TObject);
begin
  mtResumen.Close;
end;

procedure TDMLEntradasFederacion.PorcentajesEntregas( const AEmpresa, ACentro, AProducto: string;
                                                      const AFecha: TDateTime );
var
  i: integer;
  slProductos: TStringList;
begin
  mtResumen.Close;
  mtResumen.Open;

  with QResumen do
  begin
    SQL.Clear;
    SQL.Add(' select producto_p ');
    SQL.Add(' from frf_entradas2_l, frf_plantaciones ');
    SQL.Add(' where empresa_e2l = :empresa ');
    SQL.Add(' and centro_e2l = :centro ');
    SQL.Add(' and fecha_e2l between :fechaini and :fechafin ');
    SQL.Add(' and empresa_p = :empresa ');
    SQL.Add(' and cosechero_p = cosechero_e2l ');
    SQL.Add(' and plantacion_p = plantacion_e2l ');
    SQL.Add(' and ano_semana_p = ano_sem_planta_e2l ');
    if AProducto <> '' then
    begin
      SQL.Add(' and producto_p = :producto ');
      SQL.Add(' and producto_e2l = :producto ');
    end
    else
    begin
      SQL.Add(' and producto_p = producto_e2l ');
    end;
    SQL.Add(' and nvl(federacion_p,0) <> 0 ');
    SQL.Add(' group by producto_p ');
    SQL.Add(' order by producto_p ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaini').AsDate:= AFecha;
    ParamByName('fechafin').AsDate:= AFecha + 6;
    if AProducto <> '' then
    begin
      ParamByName('producto').AsString:= AProducto;
    end;

    Open;

    if isEmpty  then
    begin
      Close;
      Exit;
    end;

    slProductos:= TStringList.Create;
    while not EOF do
    begin
      slProductos.Add(FieldByName('producto_p').AsString);
      Next;
    end;
    Close;

    i:= 0;
    while i < slProductos.Count do
    begin
      RellenarTablaTemporal( AEmpresa, ACentro, slProductos[i], AFecha );
      Inc(i);
    end;
    FreeAndNil(slProductos);
  end;
end;

procedure TDMLEntradasFederacion.RellenarTablaTemporal( const AEmpresa, ACentro, AProducto: string;
                                                         const AFecha: TDateTime );
var
  rAux, rTotal, rMax, rPorcentaje: real;
  iFederacion: integer;
begin
  with QResumen do
  begin
    SQL.Clear;
    SQL.Add(' select federacion_p, sum( total_kgs_e2l ) kilos_p ');
    SQL.Add(' from frf_entradas2_l, frf_plantaciones ');
    SQL.Add(' where empresa_e2l = :empresa ');
    SQL.Add(' and centro_e2l = :centro ');
    SQL.Add(' and fecha_e2l between :fechaini and :fechafin ');
    SQL.Add(' and producto_e2l = :producto ');
    SQL.Add(' and empresa_p = :empresa ');
    SQL.Add(' and cosechero_p = cosechero_e2l ');
    SQL.Add(' and plantacion_p = plantacion_e2l ');
    SQL.Add(' and ano_semana_p = ano_sem_planta_e2l ');
    SQL.Add(' and producto_p = :producto ');
    SQL.Add(' and nvl(federacion_p,0) <> 0 ');
    SQL.Add(' group by federacion_p ');
    SQL.Add(' order by federacion_p ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaini').AsDate:= AFecha;
    ParamByName('fechafin').AsDate:= AFecha + 6;
    ParamByName('producto').AsString:= AProducto;

    Open;

    iFederacion:= -1;
    rMax:= 0;
    rTotal:= 0;
    while not EOF do
    begin
      rTotal:= rTotal + FieldByName('kilos_p').AsFloat;
      if rMax < FieldByName('kilos_p').AsFloat then
      begin
        rMax:= FieldByName('kilos_p').AsFloat;
        iFederacion:= FieldByName('federacion_p').AsInteger;
      end;
      Next;
    end;

    First;
    rPorcentaje:= 0;
    while not EOF do
    begin
      mtResumen.Insert;
      mtResumen.FieldByName('producto').AsString:= AProducto;
      mtResumen.FieldByName('federacion').AsInteger:= FieldByName('federacion_p').AsInteger;
      mtResumen.FieldByName('kilos').AsFloat:= FieldByName('kilos_p').AsFloat;
      mtResumen.FieldByName('total').AsFloat:= rTotal;
      raux:= bRoundTo( ( FieldByName('kilos_p').AsFloat / rTotal ) * 100, -2 );
      mtResumen.FieldByName('porcentaje').AsFloat:= rAux;
      mtResumen.Post;
      rPorcentaje:= rPorcentaje + rAux;
      Next;
    end;

    Close;
  end;

  if rPorcentaje <> 100 then
  begin
    with mtResumen do
    begin
      First;
      while ( FieldByName('federacion').AsInteger <> iFederacion ) and not Eof do
      begin
        Next;
      end;
      Edit;
      mtResumen.FieldByName('porcentaje').AsFloat:= mtResumen.FieldByName('porcentaje').AsFloat +
                                                    (100 - rPorcentaje);
      Post;
    end;
  end;

(*
select sum(kilos_sl) 
from frf_salidas_l
where empresa_sl = '050'
and fecha_sl between '18/2/2008' and '24/2/2008' 
and 'ES' <>
(select pais_c from frf_clientes
 where empresa_c = '050' and cliente_c = cliente_sl )
and producto_sl = 'T'
*)
end;

end.
