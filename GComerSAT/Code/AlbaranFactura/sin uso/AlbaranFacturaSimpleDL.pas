unit AlbaranFacturaSimpleDL;

interface

uses
  SysUtils, Classes, AlbaranFacturaSimpleCB, DB, DBTables;

type
  TDLAlbaranFacturaSimple = class(TDataModule)
    QAlbaranFactura: TQuery;
    QAlbaranFacturafecha_sc: TDateField;
    QAlbaranFacturan_albaran_sc: TIntegerField;
    QAlbaranFacturafecha_factura_sc: TDateField;
    QAlbaranFacturan_factura_sc: TIntegerField;
    QAlbaranFacturaproducto_sl: TStringField;
    QAlbaranFacturakilos_sl: TFloatField;
    QAlbaranFacturaimporte_neto_f: TFloatField;
    QAlbaranFacturamoneda_sc: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ObtenerDatos( AParametros: RAlbaranFacturaSimpleQL );
  end;

procedure LoadModule( APadre: TComponent );
procedure UnloadModule;
function  OpenData( APadre: TComponent; AParametros: RAlbaranFacturaSimpleQL ): integer;


implementation

{$R *.dfm}

var
  DLAlbaranFacturaSimple: TDLAlbaranFacturaSimple;
  iContadorUso: integer = 0;

function GetTextoSQL: String;
begin
  result:= ' select moneda_sc, fecha_sc, n_albaran_sc, fecha_factura_sc, n_factura_sc, importe_neto_f, producto_sl, sum(kilos_sl) kilos_sl ';
  result:= result + ' from frf_salidas_c, outer frf_facturas, frf_salidas_l ';
  result:= result + ' where empresa_sc = :empresa ';
  result:= result + ' and cliente_sal_sc = :cliente ';
  result:= result + ' and fecha_sc between :fechaini and :fechafin ';
  result:= result + ' and empresa_f = :empresa ';
  result:= result + ' and n_factura_f = n_factura_sc ';
  result:= result + ' and fecha_factura_f = fecha_factura_sc ';
  result:= result + ' and empresa_sl = :empresa ';
  result:= result + ' and centro_salida_sl = centro_salida_sc ';
  result:= result + ' and fecha_sl = fecha_sc ';
  result:= result + ' and n_albaran_sl = n_albaran_sc ';
  result:= result + ' group by moneda_sc, fecha_sc, n_albaran_sc, fecha_factura_sc, n_factura_sc, importe_neto_f, producto_sl ';
  result:= result + ' order by moneda_sc, fecha_sc, n_albaran_sc, producto_sl ';
end;

procedure LoadModule( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      DLAlbaranFacturaSimple:= TDLAlbaranFacturaSimple.Create( APadre );
      DLAlbaranFacturaSimple.QAlbaranFactura.SQL.Text:= GetTextoSQL;
      DLAlbaranFacturaSimple.QAlbaranFactura.Prepare;
    except
      iContadorUso:= 0;
      raise;
    end;
  end;
end;

procedure UnloadModule;
begin
  if iContadorUso > 0  then
  begin
    Dec( iContadorUso );
    if iContadorUso = 0 then
    begin
      if DLAlbaranFacturaSimple <> nil then
      begin
        DLAlbaranFacturaSimple.QAlbaranFactura.Close;
        if DLAlbaranFacturaSimple.QAlbaranFactura.Prepared then
          DLAlbaranFacturaSimple.QAlbaranFactura.UnPrepare;
        FreeAndNil( DLAlbaranFacturaSimple );
      end;
    end;
  end;
end;

procedure TDLAlbaranFacturaSimple.ObtenerDatos( AParametros: RAlbaranFacturaSimpleQL );
begin
  QAlbaranFactura.Close;
  QAlbaranFactura.ParamByName('empresa').AsString:= AParametros.sEmpresa;
  QAlbaranFactura.ParamByName('cliente').AsString:= AParametros.sCliente;
  QAlbaranFactura.ParamByName('fechaini').AsDate:= AParametros.dFechaDesde;
  QAlbaranFactura.ParamByName('fechafin').AsDate:= AParametros.dFechaHasta;
  QAlbaranFactura.Open;
end;

function OpenData( APadre: TComponent; AParametros: RAlbaranFacturaSimpleQL ): integer;
begin
  LoadModule( APadre );
  DLAlbaranFacturaSimple.ObtenerDatos( AParametros );
  result:= DLAlbaranFacturaSimple.QAlbaranFactura.RecordCount;
  UnLoadModule;
end;


end.
