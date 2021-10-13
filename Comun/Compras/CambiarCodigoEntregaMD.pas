unit CambiarCodigoEntregaMD;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMCambiarCodigoEntrega = class(TDataModule)
    qryDestino: TQuery;
    qryOrigen: TQuery;
    qryAux: TQuery;
  private
    { Private declarations }
    sOldCode, sPlanta, sCentro, sNewCode: string;

    function  CambiarCodigo: Boolean;
    function  HayDatos: boolean;
    procedure NuevoCodigo;

    procedure CambiarLineas;
    procedure QuerysLineas;
    procedure ClonarLinea;

    procedure CambiarGastos;
    function  TieneGastosIdirectos: booleAn;
    procedure QuerysGastos;
    procedure ClonarGasto;

    procedure CambiarFacturaPlatano;

    procedure CambiarCabecera;
    procedure QuerysCabecera;
    procedure Clonarcabecera;
    procedure BorrarCabecera;
    procedure CerrarTablas;

  public
    { Public declarations }
    function CambiarCodigoEntrega( const AOldCode, APlanta, ACentro: string; var VNewCode: string ): Boolean;
  end;

  function CambiarCodigoEntrega( const AOwner: TComponent;  const AOldCode, APlanta, ACentro: string; var VNewCode: string ): boolean;

implementation

{$R *.dfm}

uses
  Variants, Dialogs, UDMBaseDatos;

var
  DMCambiarCodigoEntrega: TDMCambiarCodigoEntrega;

function CambiarCodigoEntrega( const AOwner: TComponent;  const AOldCode, APlanta, ACentro: string; var VNewCode: string ): boolean;
begin
  DMCambiarCodigoEntrega:= TDMCambiarCodigoEntrega.Create( AOwner );
  try
    Result:= DMCambiarCodigoEntrega.CambiarCodigoEntrega( AOldCode, APlanta, ACentro, VNewCode );
  finally
    FreeAndNil( DMCambiarCodigoEntrega );
  end;
end;


function TDMCambiarCodigoEntrega.CambiarCodigoEntrega( const AOldCode, APlanta, ACentro: string; var VNewCode: string ): Boolean;
begin
  sOldCode:= AOldCode;
  sPlanta:= APlanta;
  sCentro:= ACentro;
  sNewCode:= '';
  if not DMBaseDatos.DBBaseDatos.InTransaction then
  begin
    DMBaseDatos.DBBaseDatos.StartTransaction;
    try
      Result:= CambiarCodigo;
      if Result then
      begin
        DMBaseDatos.DBBaseDatos.Commit;
        VNewCode:= sNewCode;
      end
      else
      begin
        DMBaseDatos.DBBaseDatos.Rollback;
      end;
    except
      DMBaseDatos.DBBaseDatos.Rollback;
      raise;
    end;
  end
  else
  begin
    Result:= False;
    ShowMessage('Transacción abierta, cierre el programa y vuelva a intentarlo.');
  end;
end;

function TDMCambiarCodigoEntrega.CambiarCodigo: boolean;
begin
  if HayDatos then
  begin
    NuevoCodigo;
    CambiarCabecera;
    CambiarFacturaPlatano;
    CambiarGastos;
    CambiarLineas;
    BorrarCabecera;
    Result:= True;
  end
  else
  begin
    Result:= False;
  end;
end;

function TDMCambiarCodigoEntrega.HayDatos: boolean;
begin
  qryAux.SQL.Clear;
  qryAux.SQL.Add('select *');
  qryAux.SQL.Add('from frf_entregas_c');
  qryAux.SQL.Add('where codigo_ec = :entrega');
  qryAux.ParamByName('entrega').AsString:= sOldCode;
  qryAux.Open;
  Result:= not qryAux.IsEmpty;
  qryAux.Close;
end;

procedure TDMCambiarCodigoEntrega.NuevoCodigo;
var
  iCount: Integer;
begin
  qryAux.SQL.Clear;
  qryAux.SQL.Add('select cont_entregas_e');
  qryAux.SQL.Add('from frf_empresas');
  qryAux.SQL.Add('where empresa_e = :planta');
  qryAux.ParamByName('planta').AsString:= sPlanta;
  qryAux.Open;
  iCount:= qryAux.FieldByname('cont_entregas_e').AsInteger + 1;
  qryAux.Close;

  qryAux.SQL.Clear;
  qryAux.SQL.Add('update frf_empresas set cont_entregas_e = cont_entregas_e + 1 ');
  qryAux.SQL.Add('where empresa_e = :planta');
  qryAux.ParamByName('planta').AsString:= sPlanta;
  qryAux.ExecSQL;


  sNewCode:= sPlanta + sCentro + Copy( sOldCode, 5, 2 ) + '-';
  if iCount > 9999 then
    sNewCode:= sNewCode + IntToStr( iCount )
  else
  if iCount > 999 then
    sNewCode:= sNewCode + '0' + IntToStr( iCount )
  else
  if iCount > 99 then
    sNewCode:= sNewCode + '00' + IntToStr( iCount )
  else
  if iCount > 9 then
    sNewCode:= sNewCode + '000' + IntToStr( iCount )
  else
    sNewCode:= sNewCode + '0000' + IntToStr( iCount );
end;


function TDMCambiarCodigoEntrega.TieneGastosIdirectos: boolean;
begin
  qryAux.SQL.Clear;
  qryAux.SQL.Add('select * ');
  qryAux.SQL.Add('  from frf_gastos_entregas ');
  qryAux.SQL.Add('  where codigo_ge = :entrega ');
  qryAux.SQL.Add('  and solo_lectura_ge = ''1'' ');
  qryAux.ParamByName('entrega').AsString:= sOldCode;
  qryAux.Open;
  Result:= not qryAux.IsEmpty;
  qryAux.Close;
end;

procedure TDMCambiarCodigoEntrega.CerrarTablas;
begin
  qryAux.Close;
  qryDestino.Close;
end;


procedure TDMCambiarCodigoEntrega.QuerysGastos;
begin
  qryOrigen.SQL.Clear;
  qryOrigen.SQL.Add('select * ');
  qryOrigen.SQL.Add('  from frf_gastos_entregas ');
  qryOrigen.SQL.Add('  where codigo_ge = :entrega ');
  qryOrigen.ParamByName('entrega').AsString:= sOldCode;
  qryOrigen.Open;

  qryDestino.SQL.Clear;
  qryDestino.SQL.Add('select * ');
  qryDestino.SQL.Add('  from frf_gastos_entregas ');
  qryDestino.Open;
end;

procedure TDMCambiarCodigoEntrega.ClonarGasto;
var
  i: Integer;
  campo: TField;
begin
  qryDestino.Insert;
  i:= 0;
  while i < qryDestino.Fields.Count do
  begin
    campo:= qryOrigen.FindField(qryDestino.Fields[i].FieldName);
    if campo <> nil then
    begin
      qryDestino.Fields[i].Value:= campo.Value;
    end;
    inc( i );
  end;
  qryDestino.FieldByName('codigo_ge').AsString:= sNewCode;
  qryDestino.Post;
end;

procedure TDMCambiarCodigoEntrega.CambiarGastos;
begin
  if TieneGastosIdirectos then
  begin
    raise Exception.Create('NO se puede cambiar de planta una entrega con gastos de compra o portes asignados.');
  end
  else
  begin
    QuerysGastos;
    while not qryOrigen.Eof do
    begin
      ClonarGasto;
      qryOrigen.Delete;
    end;
    CerrarTablas;
  end;
end;


procedure TDMCambiarCodigoEntrega.CambiarFacturaPlatano;
begin
  qryOrigen.SQL.Clear;
  qryOrigen.SQL.Add('update frf_facturas_platano_l ');
  qryOrigen.SQL.Add('set entrega_fpl = :newCode ');
  qryOrigen.SQL.Add('where entrega_fpl = :oldCode ');
  qryOrigen.ParamByName('newCode').AsString:= sNewCode;
  qryOrigen.ParamByName('oldCode').AsString:= sOldCode;
  qryOrigen.ExecSQL;
end;


procedure TDMCambiarCodigoEntrega.QuerysLineas;
begin
  qryOrigen.SQL.Clear;
  qryOrigen.SQL.Add('select * ');
  qryOrigen.SQL.Add('from frf_entregas_l ');
  qryOrigen.SQL.Add('where codigo_el = :entrega ');
  qryOrigen.ParamByName('entrega').AsString:= sOldCode;
  qryOrigen.Open;

  qryDestino.SQL.Clear;
  qryDestino.SQL.Add('select * ');
  qryDestino.SQL.Add('from frf_entregas_l ');
  qryDestino.Open;
end;

procedure TDMCambiarCodigoEntrega.ClonarLinea;
var
  i: Integer;
  campo: TField;
begin
  qryDestino.Insert;
  i:= 0;
  while i < qryDestino.Fields.Count do
  begin
    campo:= qryOrigen.FindField(qryDestino.Fields[i].FieldName);
    if campo <> nil then
    begin
      qryDestino.Fields[i].Value:= campo.Value;
    end;
    inc( i );
  end;
  qryDestino.FieldByName('codigo_el').AsString:= sNewCode;
  qryDestino.FieldByName('empresa_el').AsString:= sPlanta;
  qryDestino.Post;
end;

procedure TDMCambiarCodigoEntrega.CambiarLineas;
begin
  QuerysLineas;
  while not qryOrigen.Eof do
  begin
    ClonarLinea;
    qryOrigen.Delete;
  end;
  CerrarTablas;
end;

procedure TDMCambiarCodigoEntrega.QuerysCabecera;
begin
  qryOrigen.SQL.Clear;
  qryOrigen.SQL.Add('select * ');
  qryOrigen.SQL.Add('from frf_entregas_c ');
  qryOrigen.SQL.Add('where codigo_ec = :entrega ');
  qryOrigen.ParamByName('entrega').AsString:= sOldCode;
  qryOrigen.Open;

  qryDestino.SQL.Clear;
  qryDestino.SQL.Add('select * ');
  qryDestino.SQL.Add('from frf_entregas_c ');
  qryDestino.Open;
end;

procedure TDMCambiarCodigoEntrega.Clonarcabecera;
var
  i: Integer;
  campo: TField;
begin
  qryDestino.Insert;
  i:= 0;
  while i < qryDestino.Fields.Count do
  begin
    campo:= qryOrigen.FindField(qryDestino.Fields[i].FieldName);
    if campo <> nil then
    begin
      qryDestino.Fields[i].Value:= campo.Value;
    end;
    inc( i );
  end;
  qryDestino.FieldByName('codigo_ec').AsString:= sNewCode;
  qryDestino.FieldByName('empresa_ec').AsString:= sPlanta;
  qryDestino.FieldByName('centro_origen_ec').AsString:= sCentro;
  qryDestino.FieldByName('centro_llegada_ec').AsString:= sCentro;
  qryDestino.Post;
end;


procedure TDMCambiarCodigoEntrega.BorrarCabecera;
begin
  qryOrigen.SQL.Clear;
  qryOrigen.SQL.Add('delete ');
  qryOrigen.SQL.Add('from frf_entregas_c ');
  qryOrigen.SQL.Add('where codigo_ec = :entrega ');
  qryOrigen.ParamByName('entrega').AsString:= sOldCode;
  qryOrigen.ExecSql;
end;


procedure TDMCambiarCodigoEntrega.CambiarCabecera;
begin
  QuerysCabecera;
  ClonarCabecera;
  CerrarTablas;
end;

end.


