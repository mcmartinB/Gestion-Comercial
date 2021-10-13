unit UDMMaster;

interface

uses
  SysUtils, Classes, DB, DBTables, BGridButton;

type
  TDMMaster = class(TDataModule)
    qryDescripciones: TQuery;
    qryDespegables: TQuery;
    dsDespegables: TDataSource;
    qryAux: TQuery;
    qryImporteLineas: TQuery;
    qryImportesGastos: TQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function Descripcion(const ASqlText: string): string;
    function IntValue(const ASqlText: string): integer;
    function ConsultaRejilla( const ABoton: TBGridButton; const AParams: array of string): boolean;
  public
    { Public declarations }
    procedure DespliegaRejilla(const ABoton: TBGridButton; const AParams: array of string);

    function desTipoCliente(const ATipoCliente: string): string;
    function desPlanta(const APlanta: string): string;
    function desProducto(const AEmpresa, AProducto: string): string;
//    function desEnvase(const AEmpresa, AEnvase: string): string;
    function desCliente(const ACliente: string): string;
      function PorteCliente(const AEmpresa, ACliente: string): Integer;
    function desSuministro(const AEmpresa, ACliente, ASuministro: string): string;
    function desComercial(const AComercial: string): string;
    function desProveedor(const AEmpresa, AProveedor: string): string;

    function  GetCodeComercial( const AEmpresa, ACliente: string ): string;

    function  GetImpFacAlbaran( const AEmpresa, ACentro: string; const AFecha: TDateTime; const AAlbaran: integer ): real;
  end;

var
  DMMaster: TDMMaster;

implementation

uses
  CVariables, UDMBaseDatos, BGrid, BEdit, DError;

{$R *.dfm}

function TDMMaster.Descripcion(const ASqlText: string): string;
begin
  with qryDescripciones do
  begin
    SQL.Text := ASqlText;
    try
      try
        Open;
        if IsEmpty then
          result := ''
        else
        begin

          while not Eof do
          begin
            if Result = '' then
              Result := Trim( Fields[0].AsString )
            else
            begin
              if Pos( Trim( Fields[0].AsString ), Result ) = 0 then
                Result := Result + ' / ' + Trim( Fields[0].AsString )
            end;
            Next;
          end;
          {
          next;
          if Eof then
            result := Fields[0].AsString
          else
          begin
            prior;
            result := Fields[0].AsString + ' (*)';
          end;
          }
        end;
      except
        result := '';
      end;
    finally
      Cancel;
      Close;
    end;
  end;
end;

function TDMMaster.IntValue(const ASqlText: string): integer;
begin
  with qryDescripciones do
  begin
    SQL.Text := ASqlText;
    try
      try
        Open;
        if IsEmpty then
          result := -1
        else
          result := Fields[0].AsInteger;
      except
        result := -1;
      end;
    finally
      Cancel;
      Close;
    end;
  end;
end;

function TDMMaster.desTipoCliente(const ATipoCliente: string): string;
begin
  if ATipoCliente = '' then
    Result:= ''
  else
  begin
    Result := Descripcion(' select descripcion_ctp from tcliente_tipos where codigo_ctp = ' + QuotedStr(ATipoCliente) );
  end;
end;


function TDMMaster.desComercial(const AComercial: string): string;
begin
  if (Trim(AComercial) = '') then
    result := ''
  else
    Result := Descripcion(' select descripcion_c from tcomerciales where codigo_c = ' + QuotedStr(AComercial) + ' ');
end;


function TDMMaster.desProducto(const AEmpresa, AProducto: string): string;
begin
  if (Trim(AEmpresa) = '') or (Trim(AProducto) = '') then
    result := ''
  else
    Result := Descripcion(' select descripcion from frf_productos where producto_vpd = ' + QuotedStr(AProducto) + ' ');
end;
{
function TDMMaster.desEnvase(const AEmpresa, AEnvase: string): string;
begin
  if (Trim(AEmpresa) = '') or (Trim(AEnvase) = '') then
    result := ''
  else
    Result := Descripcion(' select descripcion_e from comerbag:frf_envase where envase_e = ' + QuotedStr(AEnvase) + ' ');
end;
}
function TDMMaster.desPlanta(const APlanta: string): string;
begin
  Result := Descripcion(' select nombre_pln from tplantas where planta_pln = ' + QuotedStr(APlanta) );
end;

function TDMMaster.desCliente(const ACliente: string): string;
begin
  Result := Descripcion(' select nombre_c from frf_clientes ' +
                        ' where cliente_c=' + QuotedStr(ACliente) );
end;


function TDMMaster.desSuministro(const AEmpresa, ACliente, ASuministro: string): string;
begin
  Result := Descripcion(' select nombre_s from vsuministros ' +
    ' where empresa_s=' + QuotedStr( AEmpresa ) + ' ' +
    '   and cliente_s=' + QuotedStr( ACliente ) + ' ' +
    '   and suministro_s=' + QuotedStr( ASuministro ) + ' ');
end;

function TDMMaster.desProveedor(const AEmpresa, AProveedor: string): string;
begin
  Result :=  Descripcion(' select nombre_p from frf_proveedores ' +
                         ' where proveedor_p=' + QuotedStr(AProveedor) + ' ');
end;

function TDMMaster.PorteCliente(const AEmpresa, ACliente: string): integer;
begin
  Result := IntValue(' select grabrar_transporte_c from frf_clientes ' +
                     ' where cliente_c=' + QuotedStr(ACliente) );

  //si grabrar conste transporte cliente = 1 entonces el porte lo paga bonny ->  porte cliente = 0
  if Result = 0 then
    Result:= 1
  else
    Result:= 0;
end;

function TDMMaster.GetCodeComercial( const AEmpresa, ACliente: string ): string;
begin
  qryAux.SQL.Clear;
  qryAux.SQL.Add(' select cod_comercial_cc ');
  qryAux.SQL.Add(' from tclientes_comercial ');
  qryAux.SQL.Add(' where cod_empresa_cc = :empresa ');
  qryAux.SQL.Add(' and cod_cliente_cc = :cliente ');
  qryAux.ParamByName('empresa').AsString:= AEmpresa;
  qryAux.ParamByName('cliente').AsString:= ACliente;
  qryAux.Open;
  try
    result:= qryAux.FieldByName('cod_comercial_cc').AsString;
  finally
    qryAux.Close;
  end;
end;


procedure TDMMaster.DespliegaRejilla(const ABoton: TBGridButton; const AParams: array of string);
begin
     //Realizamos consulta
  try
    if ConsultaRejilla(ABoton, AParams) then
    begin
      //Mostrar resultado
      TBGrid(ABoton.Grid).BControl := TBEdit(ABoton.Control);
      ABoton.GridShow;
    end;
  except
    on e: Exception do
    begin
      if e.Message = 'Empresa' then ShowError('Por favor, introduzca primero el código de la empresa.')
      else ShowError('Error al realizar la consulta asociada.');
    end;
  end;
end;

function TDMMaster.ConsultaRejilla( const ABoton: TBGridButton; const AParams: array of string): boolean;
begin
  Result := True;
  qryDespegables.Cancel;
  qryDespegables.Close;

  case ABoton.Control.Tag of
    kTipoCliente:
      begin
        ABoton.Grid.ColumnResult := 0;
        ABoton.Grid.ColumnFind := 1;
        qryDespegables.Sql.Clear;
        qryDespegables.Sql.Add(' select codigo_ctp, descripcion_ctp from tcliente_tipos order by  codigo_ctp ');
      end;
    kComercial:
      begin
        ABoton.Grid.ColumnResult := 0;
        ABoton.Grid.ColumnFind := 1;
        qryDespegables.Sql.Clear;
        qryDespegables.Sql.Add(' select codigo_c, descripcion_c from tcomerciales order by  codigo_c ');
      end;
  end;

     //Abre consulta
  try
    qryDespegables.Open;
  except
    ShowError('Error al mostrar los datos.');
    ConsultaRejilla := false;
    Exit;
  end;
     //Tiene valores
  if qryDespegables.IsEmpty then
  begin
    ShowError('Consulta sin datos.');
    ConsultaRejilla := False;
  end;
end;

procedure TDMMaster.DataModuleCreate(Sender: TObject);
begin
  with qryImporteLineas do
  begin
    SQL.Clear;
    SQL.Add('SELECT SUM( IMPORTE_TOTAL_FD ) TOTAL_LINEAS ');
    SQL.Add('FROM TFACTURAS_DET ');
    SQL.Add('WHERE COD_EMPRESA_ALBARAN_FD = :empresa ');
    SQL.Add('  AND COD_CENTRO_ALBARAN_FD = :centro ');
    SQL.Add('  AND N_ALBARAN_FD = :albaran ');
    SQL.Add('  AND FECHA_ALBARAN_FD = :fecha ');
  end;

  with qryImportesGastos do
  begin
    SQL.Clear;
    SQL.Add('SELECT SUM( IMPORTE_TOTAL_FG ) TOTAL_LINEAS ');
    SQL.Add('FROM TFACTURAS_GAS ');
    SQL.Add('WHERE COD_EMPRESA_ALBARAN_FG = :empresa ');
    SQL.Add('  AND COD_CENTRO_ALBARAN_FG = :centro ');
    SQL.Add('  AND N_ALBARAN_FG = :albaran ');
    SQL.Add('  AND FECHA_ALBARAN_FG = :fecha ');
  end;
end;

function  TDMMaster.GetImpFacAlbaran( const AEmpresa, ACentro: string; const AFecha: TDateTime; const AAlbaran: integer ): real;
begin
  with qryImporteLineas do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fecha').AsDatetime:= AFecha;
    ParamByName('albaran').AsInteger:= AAlbaran;
    Open;
    if IsEmpty then
    begin
      Result:= 0;
    end
    else
    begin
      Result:= FieldByName('TOTAL_LINEAS').AsFloat;
    end;
    Close;
  end;
  with qryImportesGastos do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fecha').AsDatetime:= AFecha;
    ParamByName('albaran').AsInteger:= AAlbaran;
    Open;
    if not IsEmpty then
    begin
      Result:= Result + FieldByName('TOTAL_LINEAS').AsFloat;
    end;
    Close;
  end;
end;

end.
