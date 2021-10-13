unit UCAlbaran;

interface

uses
  classes;

  function  GetFirmaFileName( const AEmpresa, ACentro, ACliente: String; const AAlbaran: Integer; const AFecha: TDateTime ): string;
  procedure PutPalets( const AEmpresa, ACentro: String; const AAlbaran: Integer; const AFecha: TDateTime;var APalets: TStrings );
  procedure PutLogifruit( const AEmpresa, ACentro: String; const AAlbaran: Integer; const AFecha: TDateTime; var ALogifruit: TStrings );
  function NumeroCopias( const AEmpresa, ACliente : string ): Integer;
  function DNITransporte(const AEmpresa, ATransporte: string): string;
  function Dir1Transporte(const AEmpresa, ATransporte: string): string;
  function Dir2Transporte(const AEmpresa, ATransporte: string): string;

var
  giCopias: Integer = 0;

implementation

uses
  SysUtils, UDMBaseDatos, CVariables, CAuxiliarDB, bSQLUtils;

function  GetFirmaFileName( const AEmpresa, ACentro, ACliente: String; const AAlbaran: Integer; const AFecha: TDateTime ): string;
var
  sFilename: string;
  iAnyo, iMes, iDia: word;
begin
  result:= '';
  if gsDirFirmasGlobal <> '' then
  begin
    if DirectoryExists( gsDirFirmasGlobal ) then
      result:=  gsDirFirmasGlobal;
  end;
  if result = '' then
  begin
    if gsDirFirmasLocal <> '' then
    begin
      if DirectoryExists( gsDirFirmasLocal ) then
        result:=  gsDirFirmasLocal;
    end;
  end;

  if result <> '' then
  begin
    DecodeDate( AFecha, iAnyo, iMes, iDia );
    sFilename:= intToStr( iAnyo ) + AEmpresa + ACentro + ACliente + '-' + IntToStr( AAlbaran );
    result:= result + '\' + sFileName + '.jpg';
  end;
end;

procedure PutPalets( const AEmpresa, ACentro: String; const AAlbaran: Integer; const AFecha: TDateTime;var APalets: TStrings );
begin
  with DMBaseDatos.QAux do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    with SQL do
    begin
      Clear;
      Add(' SELECT descripcion_tp, SUM(n_palets_sl) as n_palets_sl ');
      Add(' FROM frf_salidas_l , frf_tipo_palets ');
      Add(' WHERE   (tipo_palets_sl = codigo_tp) ');
      Add('    AND  (empresa_sl = :empresa) ');
      Add('    AND  (centro_salida_sl = :centro) ');
      Add('    AND  (n_albaran_sl = :albaran) ');
      Add('    AND  (fecha_sl = :fecha) ');
      Add(' GROUP BY descripcion_tp  ');
      Add(' ORDER BY descripcion_tp ');
    end;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('albaran').AsInteger := AAlbaran;
    ParamByName('fecha').AsDateTime := AFecha;
    try
      Open;
      First;
      while not Eof do
      begin
        APalets.add(FieldByName('descripcion_tp').AsString + ' : ' +
          FieldByName('n_palets_sl').AsString);
        Next;
      end;
    finally
      Close;
    end;
  end;
end;

procedure PutLogifruit( const AEmpresa, ACentro: String; const AAlbaran: Integer; const AFecha: TDateTime; var ALogifruit: TStrings );
begin
  with DMBaseDatos.QAux do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    with SQL do
    begin
      Clear;
      (*LOGI*)
      Add(' SELECT env_comer_producto_e codigo_caja_e, ');
      Add('        ( Select des_producto_ecp From frf_env_comer_productos ');
      Add('           Where cod_operador_ecp = env_comer_operador_e ');
      Add('             and cod_producto_ecp = env_comer_producto_e ) texto_caja_e, ');
      Add('        SUM(cajas_sl ) as cajas_sl ');
      Add(' FROM frf_salidas_l, frf_envases ');
      Add(' WHERE empresa_sl = :empresa ');
      Add('   AND centro_salida_sl = :centro ');
      Add('   AND n_albaran_sl = :albaran ');
      Add('   AND fecha_sl = :fecha ');
      Add('   and envase_e = envase_sl ');
      Add('   and producto_e = producto_sl');
      (*LOGI*)
      //Add(' group by 1 ');
      Add(' group by 1, 2 ');
      Add(' order by 1 ');

    end;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('albaran').AsInteger := AAlbaran;
    ParamByName('fecha').AsDateTime := AFecha;
    try
      Open;
      First;
      while not Eof do
      begin
        if Trim(FieldByName('codigo_caja_e').AsString) <> '' then
          ALogifruit.add(FieldByName('texto_caja_e').AsString + ' : ' + FieldByName('cajas_sl').AsString );
        Next;
      end;
    finally
      Close;
    end;
  end;
end;

function NumeroCopias( const AEmpresa, ACliente : string ): Integer;
begin
  if giCopias = 0 then
  begin
    with DMBaseDatos.QAux do
    begin
      SQL.Clear;
      SQL.Add('SELECT Frf_clientes.n_copias_alb_c ');
      SQL.Add('FROM frf_clientes Frf_clientes ');
      SQL.Add('WHERE  Frf_clientes.cliente_c=' + quotedstr(ACliente));
      try
        AbrirConsulta(DMBaseDatos.QAux);
        result := Fields[0].AsInteger;
      finally
        Close;
      end;
    end;
  end
  else
  begin
    result:= giCopias;
  end;
end;

function DNITransporte(const AEmpresa, ATransporte: string): string;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select cif_t from frf_transportistas ');
    SQL.Add(' where transporte_t ' + SQLEqualS(ATransporte));
    Open;
    if Trim( Fields[0].AsString ) <> '' then
    begin
      result := ' C.I.F.: ' + Fields[0].AsString;
    end
    else
    begin
      result := '';
    end;
    Close;
  end;
end;

function Dir1Transporte(const AEmpresa, ATransporte: string): string;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select direccion1_t from frf_transportistas ');
    SQL.Add(' where transporte_t ' + SQLEqualS(ATransporte));
    Open;
    if not IsEmpty then
    begin
      result := Fields[0].AsString;
    end
    else
    begin
      result := '';
    end;
    Close;
  end;
end;

function Dir2Transporte(const AEmpresa, ATransporte: string): string;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select direccion2_t from frf_transportistas ');
    SQL.Add(' where transporte_t ' + SQLEqualS(ATransporte));
    Open;
    if not IsEmpty then
    begin
      result := Fields[0].AsString;
    end
    else
    begin
      result := '';
    end;
    Close;
  end;
end;

end.
