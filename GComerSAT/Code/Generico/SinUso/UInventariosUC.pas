{*
  Codigo comun para el tratamiento de los inventarios de fruta
  INICIO: 17/3/2005

  @author Departamento de Informática Horvesa
  @version V.0.1
}
unit UInventariosUC;

interface

function KgsInventario(const AEmpresa, ACentro, AProducto, AFecha: string): Real;
function KgsInventarioAjuste(const AEmpresa, ACentro, AProducto, AFecha: string): Real;

function KgsInventarioCampo(const AEmpresa, ACentro, AProducto, AFecha: string): Real;
function KgsInventarioCampoAjuste(const AEmpresa, ACentro, AProducto, AFecha: string): Real;
function KgsInventarioIntermedia(const AEmpresa, ACentro, AProducto, AFecha: string): Real;
function KgsInventarioIntermediaAjuste(const AEmpresa, ACentro, AProducto, AFecha: string): Real;
function KgsInventarioExpedicion(const AEmpresa, ACentro, AProducto, AFecha: string): Real;


implementation

uses UDMBaseDatos, bSQLUtils, DB;

function KgsInventario(const AEmpresa, ACentro, AProducto, AFecha: string ): Real;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(kilos_cec_ic,0) + nvl(kilos_cim_c1_ic,0) + nvl(kilos_cim_c2_ic,0) + ' +
      '        nvl(kilos_cia_c1_ic,0) + nvl(kilos_cia_c2_ic,0) + ' +
      '        nvl(kilos_zd_c3_ic,0) + nvl(kilos_zd_d_ic,0) kilos  ' +
      ' from frf_inventarios_c ' +
      ' where empresa_ic ' + SQLEqualS(AEmpresa) +
      ' and centro_ic ' + SQLEqualS(ACentro) +
      ' and producto_ic ' + SQLEqualS(AProducto) +
      ' and fecha_ic ' + SQLEqualD(AFecha));
    Open;
    result := Fields[0].AsFloat;
    Close;

    SQL.Clear;
    SQL.Add(' select sum( nvl(kilos_ce_c1_il,0) + nvl(kilos_ce_c2_il,0) ) ' +
      '       from frf_inventarios_l ' +
      '       where empresa_il ' + SQLEqualS(AEmpresa) +
      '         and centro_il ' + SQLEqualS(ACentro) +
      '         and producto_il ' + SQLEqualS(AProducto) +
      '         and fecha_il ' + SQLEqualD(AFecha)  );
    Open;
    if not IsEmpty then
      result := result + Fields[0].AsFloat;
    Close;
  end;
end;

function KgsInventarioCampo(const AEmpresa, ACentro, AProducto, AFecha: string): Real;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(kilos_cec_ic,0) ' +
      ' from frf_inventarios_c ' +
      ' where empresa_ic ' + SQLEqualS(AEmpresa) +
      ' and centro_ic ' + SQLEqualS(ACentro) +
      ' and producto_ic ' + SQLEqualS(AProducto) +
      ' and fecha_ic ' + SQLEqualD(AFecha) +
      ' and kilos_cec_ic is not null ');

    Open;
    result := Fields[0].AsFloat;
    Close;
  end;
end;

function KgsInventarioCampoAjuste(const AEmpresa, ACentro, AProducto, AFecha: string): Real;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(kilos_ajuste_campo_ic,0) ' +
      ' from frf_inventarios_c ' +
      ' where empresa_ic ' + SQLEqualS(AEmpresa) +
      ' and centro_ic ' + SQLEqualS(ACentro) +
      ' and producto_ic ' + SQLEqualS(AProducto) +
      ' and fecha_ic ' + SQLEqualD(AFecha) +
      ' and kilos_cec_ic is not null ');

    Open;
    result := Fields[0].AsFloat;
    Close;
  end;
end;

function KgsInventarioIntermedia(const AEmpresa, ACentro, AProducto, AFecha: string): Real;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(kilos_cim_c1_ic,0) + nvl(kilos_cim_c2_ic,0) + ' +
      '        nvl(kilos_cia_c1_ic,0) + nvl(kilos_cia_c2_ic,0)  ' +
      ' from frf_inventarios_c ' +
      ' where empresa_ic ' + SQLEqualS(AEmpresa) +
      ' and centro_ic ' + SQLEqualS(ACentro) +
      ' and producto_ic ' + SQLEqualS(AProducto) +
      ' and fecha_ic ' + SQLEqualD(AFecha));
    Open;
    result := Fields[0].AsFloat;
    Close;
  end;
end;

function KgsInventarioIntermediaAjuste(const AEmpresa, ACentro, AProducto, AFecha: string): Real;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(kilos_ajuste_c1_ic,0) + nvl(kilos_ajuste_c2_ic,0) ' +
      ' from frf_inventarios_c ' +
      ' where empresa_ic ' + SQLEqualS(AEmpresa) +
      ' and centro_ic ' + SQLEqualS(ACentro) +
      ' and producto_ic ' + SQLEqualS(AProducto) +
      ' and fecha_ic ' + SQLEqualD(AFecha));
    Open;
    result := Fields[0].AsFloat;
    Close;
  end;
end;

function KgsInventarioExpedicion(const AEmpresa, ACentro, AProducto, AFecha: string): Real;
begin
  result:= 0;
  with DMBaseDatos.QAux do
  begin

    SQL.Clear;
    SQL.Add(' select sum( nvl(kilos_ce_c1_il,0) + nvl(kilos_ce_c2_il,0) ) ' +
      '       from frf_inventarios_l ' +
      '       where empresa_il ' + SQLEqualS(AEmpresa) +
      '         and centro_il ' + SQLEqualS(ACentro) +
      '         and producto_il ' + SQLEqualS(AProducto) +
      '         and fecha_il ' + SQLEqualD(AFecha)  );
    Open;
    if not IsEmpty then
      result := Fields[0].AsFloat;
    Close;
  end;
end;

function KgsInventarioAjuste(const AEmpresa, ACentro, AProducto, AFecha: string): Real;
begin
  result:= 0;
  with DMBaseDatos.QAux do
  begin

    SQL.Clear;
    SQL.Add(' select nvl(kilos_ajuste_campo_ic,0) + nvl(kilos_ajuste_c1_ic,0)  + nvl(kilos_ajuste_c2_ic,0)  + nvl(kilos_ajuste_cd_ic,0)  ' +
      ' from frf_inventarios_c ' +
      ' where empresa_ic ' + SQLEqualS(AEmpresa) +
      ' and centro_ic ' + SQLEqualS(ACentro) +
      ' and producto_ic ' + SQLEqualS(AProducto) +
      ' and fecha_ic ' + SQLEqualD(AFecha));
    Open;
    if not IsEmpty then
      result := Fields[0].AsFloat;
    Close;
  end;
end;

end.

