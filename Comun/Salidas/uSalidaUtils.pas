unit uSalidaUtils;

interface


uses UDMBaseDatos, Db;


type
  TGGN  = record
    tiene_ggn : boolean;
    descri : string;
    descri_esp : string;
    descri_eng : string;
    imprimir_garantia : boolean;
    cantidad_lineas : integer;
    numero_registros : integer;
    poner_arterisco : boolean;
    producto_sl : string;
    arterisco : string;
    ggn_code : string;
    sat : boolean;
  end;

function ConfigurarGGN(conn : string; empresa, centro : string; albaran : integer; fecha : TDateTime; factura : string = ''; producto : string = 'PLA'; esEspanyol : boolean = true) : TGGN;
function ArreglaProductoGGN(rGGN : TGGN; empresa, codigo_producto, descri_producto : string) : string;
function TieneGGN ( empresa, producto: string ) : boolean;


implementation



uses
  sysutils, dialogs, CGlobal, dbtables;




function ArreglaProductoGGN(rGGN : TGGN; empresa, codigo_producto, descri_producto: string) : string;
var
  producto_alb : string;
begin
  if TieneGGN(empresa, codigo_producto)  then producto_alb := rggn.arterisco+descri_producto
  else producto_alb := descri_producto;

  producto_alb := trim(producto_alb);

  result := producto_alb;

end;

function ConfigurarGGN(conn : string; empresa, centro : string; albaran : integer; fecha : TDateTime; factura : String = ''; producto : string = 'PLA'; esEspanyol : boolean = true) : TGGN;
var
  rConfigurarGGN : TGGN;
  qlineas, qfactura : TQuery;
  dia, mes, anyo : word;
  noimprimir : boolean;
  FechaCambioGGN: TDateTime;


begin
  FechaCambioGGN := encodedate(2021,8,23);
  noimprimir := false;
  rConfigurarGGN.tiene_ggn := false;
  rConfigurarGGN.imprimir_garantia := false;
  rConfigurarGGN.descri_esp := '';
  rConfigurarGGN.descri_eng := '';
  rConfigurarGGN.numero_registros := 0;
  rConfigurarGGN.cantidad_lineas := 0;
  rConfigurarGGN.poner_arterisco := false;
  rConfigurarGGN.producto_sl := producto;
  rConfigurarGGN.arterisco := '';
  rConfigurarGGN.sat := false;


  try
  try
 //     dm1 := TDMBaseDatos.Create(nil);
      decodedate(fecha, anyo, mes, dia);



      qlineas := TQuery.Create(nil);
      qlineas.DatabaseName := 'BDProyecto';
      qlineas.SQL.Add('select * from frf_salidas_l');
      qlineas.sql.add('where N_ALBARAN_SL = :p1');
      qlineas.sql.add('and EMPRESA_SL = :p2');
      qlineas.sql.add('and centro_salida_sl = :p3');
      qlineas.sql.add('and fecha_sl = :p4');

      qlineas.Params[0].asinteger := albaran;
      qlineas.Params[1].asstring := empresa;
      qlineas.params[2].asstring := centro;
      qlineas.Params[3].asdatetime := fecha;

      qlineas.prepare;

      if factura <> '' then
      begin
        qfactura := TQuery.Create(nil);
        qfactura.DatabaseName := 'BDProyecto';
        qfactura.SQL.Add('select * from tfacturas_cab');
        qfactura.sql.add('where cod_factura_fc = :factura ');

        qfactura.Params[0].asstring := factura;

        qfactura.Open;
        fecha := qfactura.fieldbyname('fecha_factura_fc').AsDateTime;
      end;


      if CGlobal.gProgramVersion = CGlobal.pvSAT then
      begin
          rConfigurarGGN.SAT := true;
          rConfigurarGGN.descri_eng := 'Certified product GLOBALG.A.P.  GGN: ';
          rConfigurarGGN.descri_esp := 'Producto Certificado GLOBALG.A.P.  GGN: ';

          if fecha >= FechaCambioGGN then
            rConfigurarGGN.GGN_Code := '8430543000007'
          else
          begin
            rConfigurarGGN.GGN_Code := '4049928415684';
            rConfigurarGGN.tiene_ggn := true;
          end;
      end
      else
      begin
        rConfigurarGGN.GGN_Code := '8437003114007';
        rConfigurarGGN.descri_eng := 'Certified product GLOBALG.A.P.  GGN: ';
        rConfigurarGGN.descri_esp := 'Producto Certificado GLOBALG.A.P.  GGN: ';

        if fecha < FechaCambioGGN then noimprimir:=true;
      end;


      qlineas.Open;
      qlineas.first;


      while not qlineas.eof do
      begin
        if ( TieneGGN(qlineas.fieldbyname('empresa_sl').AsString, qlineas.fieldbyname('producto_sl').AsString) ) then
        begin
          rConfigurarGGN.tiene_ggn := true;
          inc(rConfigurarGGN.cantidad_lineas);
        end;

        inc(rConfigurarGGN.numero_registros);

        qlineas.next;
      end;

      qlineas.close;
  except
    On E: Exception do
    begin
     // ShowMessage('Error en función ConfigurarGGN: '+e.message);
    end;

  end;
  finally
    freeandnil(qlineas);
    if factura <> '' then
     freeandnil(qfactura);
  end;

  if  rConfigurarGGN.tiene_ggn then
  begin
    rConfigurarGGN.imprimir_garantia := true;
  end;

  if fecha >= FechaCambioGGN then
  begin
    if rConfigurarGGN.tiene_ggn = true then
    begin
      if (rConfigurarGGN.numero_registros > 1) then
      begin
          if (rConfigurarGGN.numero_registros = rConfigurarGGN.cantidad_lineas)   then  rConfigurarGGN.poner_arterisco := false
          else rConfigurarGGN.poner_arterisco := true;
      end;
    end;
  end;

  if rConfigurarGGN.poner_arterisco = true then
  begin
    rConfigurarGGN.arterisco := '*';
    rConfigurarGGN.descri_eng := rConfigurarGGN.arterisco + rConfigurarGGN.descri_eng;
    rConfigurarGGN.descri_esp := rConfigurarGGN.arterisco + rConfigurarGGN.descri_esp;
  end;


  if esEspanyol = true then rConfigurarGGN.descri := rConfigurarGGN.descri_esp
  else rConfigurarGGN.descri := rConfigurarGGN.descri_eng;

  if noimprimir = true then rConfigurarGGN.imprimir_garantia := false;
  

  result := rConfigurarGGN;
end;

function TieneGGN ( empresa, producto: string) :boolean;
var QAux: TQuery;
begin

  QAux := TQuery.Create(nil);
  QAux.DatabaseName := 'BDProyecto';
  QAux.SQL.Add('select * from frf_productos_ggn');
  QAux.sql.add('where empresa_pg = :empresa ');
  QAux.sql.add('and producto_pg = :producto ');

  QAux.Params[0].AsString := empresa;
  QAux.Params[1].AsString := producto;

  QAux.Open;

  result := not QAux.IsEmpty;

end;


end.
