unit UDMCambioMoneda;

interface

uses
  SysUtils, Classes, DB, DBTables, bMath, ADODB;

const
  sAliasName= 'BDProyecto';

type
  TDMCambioMoneda = class(TDataModule)
    QChangeAux_Borrar: TQuery;
    QChange: TQuery;
    QAlbaran: TQuery;
    QFactura: TQuery;
    QRemesa: TQuery;
    QCambioFactura: TQuery;
    qryX3Cambio: TADOQuery;
    qryGrabarCambio: TQuery;
    qryX3FacturaOrigen: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

(*TODO*)(*Optimizar lo que se pueda*)
(*Borrar monedas con cambio fijo*)
(*Grabar en cambio a EUROS (y no el inverso como ahora)*)
function ChangeExist( AMonedaDestino, AFechaCambio: String): Boolean; overload;
function ChangeExist( AMonedaDestino: string; AFechaCambio: TdateTime): Boolean; overload;
function ChangeExist( AMonedaDestino, AFechaCambio: String; var AFactorToEuro: real ): Boolean; overload;
function ChangeExist( AMonedaDestino: string; AFechaCambio: TdateTime; var AFactorToEuro: real): Boolean; overload;

function ToEuro( AMonedaOrigen: string; AFechaCambio: TdateTime): Real; overload;
function ToEuro( AMonedaOrigen, AFechaCambio: string): Real; overload;
function FromEuro( AMonedaDestino: string; AFechaCambio: TdateTime): Real; overload;
function FromEuro( AMonedaDestino, AFechaCambio: string): Real; overload;

function ChangeToEuro( AMonedaOrigen, AFechaCambio: string; AValor: real; ADecimales: integer = 2 ): Real; overload;
function ChangeToEuro( AMonedaOrigen: string; AFechaCambio: TDateTime; AValor: real; ADecimales: integer = 2 ): Real; overload;
function ChangeFromEuro( AMonedaDestino, AFechaCambio: string; AValor: real; ADecimales: integer = 2 ): Real; overload;
function ChangeFromEuro( AMonedaDestino: string; AFechaCambio: TDateTime; AValor: real; ADecimales: integer = 2 ): Real; overload;
function ChangeMoney( AMonedaOrigen, AMonedaDestino, AFechaCambio: string; AValor: real; ADecimales: integer = 2 ): real; overload;
function ChangeMoney( AMonedaOrigen, AMonedaDestino: string; AFechaCambio: TDateTime; AValor: real; ADecimales: integer = 2 ): real; overload;

(*TODO*)(*Ver a ver cual de las dos esta bien*)
function FactorCambioFOB(const AEmpresa, ACentro, AFecha, AAlbaran, AMoneda: string): Real;
function FactorCambioLIQ(const AEmpresa, AFacturaNum, AFacturaFecha, AMoneda, AFechaCambio: string): real;

implementation

uses
  UDMBaseDatos;

var
  DMCambioMoneda: TDMCambioMoneda;

function ChangeExist( AMonedaDestino, AFechaCambio: String ): Boolean;
var
  dFechaCambio: TDateTime;
begin
  if TryStrToDate( AFechaCambio, dFechaCambio ) then
  begin
    result:= ChangeExist( AMonedaDestino, dFechaCambio );
  end
  else
  begin
    raise Exception.Create('Fecha para el cambio incorrecta.');
  end;
end;

function ChangeExist( AMonedaDestino, AFechaCambio: String; var AFactorToEuro: real ): Boolean;
var
  dFechaCambio: TDateTime;
begin
  if TryStrToDate( AFechaCambio, dFechaCambio ) then
  begin
    result:= ChangeExist( AMonedaDestino, dFechaCambio, AFactorToEuro );
  end
  else
  begin
    raise Exception.Create('Fecha para el cambio incorrecta.');
  end;
end;


function ChangeExist( AMonedaDestino: string; AFechaCambio: TdateTime): Boolean;
var
  rAux: real;
begin
  result:= ChangeExist( AMonedaDestino, AFechaCambio, rAux );
end;

procedure GrabarCambio( const AMonedaDestino: string; AFechaCambio: TdateTime; var AFactorToEuro: real );
begin
  DMCambioMoneda.qryGrabarCambio.ParamByName('moneda').AsString:= AMonedaDestino;
  DMCambioMoneda.qryGrabarCambio.ParamByName('fecha').AsDateTime:= AFechaCambio;
  DMCambioMoneda.qryGrabarCambio.ParamByName('cambio').AsFloat:= AFactorToEuro;
  DMCambioMoneda.qryGrabarCambio.ExecSQL;
end;

function CambioX3( AMonedaDestino: string; AFechaCambio: TdateTime; var AFactorToEuro: real): Boolean;
begin
  DMBaseDatos.conX3.Open;
  DMCambioMoneda.qryX3Cambio.Parameters.ParamByName('moneda').Value:= AMonedaDestino;
  DMCambioMoneda.qryX3Cambio.Parameters.ParamByName('fecha').Value:= AFechaCambio;
  DMCambioMoneda.qryX3Cambio.Open;
  if DMCambioMoneda.qryX3Cambio.IsEmpty then
  begin
    AFactorToEuro:= -1;
    result:= False;
  end
  else
  begin
    AFactorToEuro:= DMCambioMoneda.qryX3Cambio.FieldByname('cambio').AsFloat;
    GrabarCambio( AMonedaDestino, AFechaCambio, AFactorToEuro );
    result:= True;
  end;
  DMCambioMoneda.qryX3Cambio.Close;
  DMBaseDatos.conX3.Close;
end;

function VarChangeExist( AMonedaDestino: string; AFechaCambio: TdateTime; var AFactorToEuro: real): Boolean;
begin
  with DMCambioMoneda.QChange do
  begin
    if not Prepared then
      Prepare;

    ParamByName('moneda').AsString:= AMonedaDestino;
    ParamByName('fecha').AsDateTime:= AFechaCambio;
    Open;
    result:= not IsEmpty;
    if result then
    begin
      AFactorToEuro:= bRoundTo( 1 /FieldByName('factor').AsFloat, -5);
    end
    else
    begin
      //Traer de Adonix
      result:= CambioX3( AMonedaDestino, AFechaCambio, AFactorToEuro );
    end;
    Close;
  end;
end;

function ChangeExist( AMonedaDestino: string; AFechaCambio: TdateTime; var AFactorToEuro: real): Boolean;
begin
  if ( AMonedaDestino = 'EUR' ) or ( AMonedaDestino = 'DEM' ) or ( AMonedaDestino = 'ESP' ) or ( AMonedaDestino = 'FRF' ) then
  begin
    result:= true;
    if AMonedaDestino = 'EUR' then
      AFactorToEuro:= 1
    else
    if AMonedaDestino = 'DEM' then
      AFactorToEuro:= 1.95583
    else
    if AMonedaDestino = 'ESP' then
      AFactorToEuro:= 166.386
    else
    //if AMonedaDestino = 'FRF' then
      AFactorToEuro:= 6.55957;
  end
  else
  begin
    result:= VarChangeExist( AMonedaDestino, AFechaCambio, AFactorToEuro );
  end;
end;

function ToEuro( AMonedaOrigen, AFechaCambio: string): Real;
var
  dFechaCambio: TDateTime;
begin
  if TryStrToDate( AFechaCambio, dFechaCambio ) then
  begin
    result:= ToEuro( AMonedaOrigen, dFechaCambio );
  end
  else
  begin
    raise Exception.Create('Fecha para el cambio incorrecta.');
  end;
end;

function ToEuro( AMonedaOrigen: string; AFechaCambio: TdateTime): Real;
begin
  result := FromEuro( AMonedaOrigen, AFechaCambio );
  if result > 0 then
    result:= bRoundTo( 1 /result, -5);
end;

function FromEuro( AMonedaDestino, AFechaCambio: string): Real;
var
  dFechaCambio: TDateTime;
begin
  if TryStrToDate( AFechaCambio, dFechaCambio ) then
  begin
    result:= FromEuro( AMonedaDestino, dFechaCambio );
  end
  else
  begin
    raise Exception.Create('Fecha para el cambio incorrecta.');
  end;
end;

function VarChangeFromEuro( AMonedaDestino: string; AFechaCambio: TdateTime): Real;
begin
  with DMCambioMoneda.QChange do
  begin
    if not Prepared then
      Prepare;

    ParamByName('moneda').AsString:= AMonedaDestino;
    ParamByName('fecha').AsDateTime:= AFechaCambio;
    Open;
    if not IsEmpty then
    begin
      result:= FieldByName('factor').AsFloat;
    end
    else
    begin
      result:= -1;
    end;
    Close;
  end;
  if result = -1 then
  begin
    //Traer de Adonix
    CambioX3( AMonedaDestino, AFechaCambio, result );
  end;
  (*
  if result = -1 then
  begin
    with DMCambioMoneda.QChangeAux do
    begin
      if not Prepared then
        Prepare;

      ParamByName('moneda').AsString:= AMonedaDestino;
      ParamByName('fecha').AsDateTime:= AFechaCambio;
      Open;
      if not IsEmpty then
      begin
        result:= FieldByName('factor').AsFloat;
      end
      else
      begin
        result:= -1;
      end;
      Close;
    end;
  end;
  *)
end;

//Los unicas monedas europeas com cambio fijo utilizadas fueron ESP, DEM, FRF
function FromEuro( AMonedaDestino: string; AFechaCambio: TdateTime): Real;
begin
  if ( AMonedaDestino = 'EUR' ) or ( AMonedaDestino = 'DEM' ) or
     ( AMonedaDestino = 'ESP' ) or ( AMonedaDestino = 'FRF' ) or
     ( AMonedaDestino = '' ) then
  begin
    if ( AMonedaDestino = 'EUR' ) or  ( AMonedaDestino = '' )then
      result:= 1
    else
    if AMonedaDestino = 'DEM' then
      result:= 1.95583
    else
    if AMonedaDestino = 'ESP' then
      result:= 166.386
    else
    //if AMonedaDestino = 'FRF' then
      result:= 6.55957;
  end
  else
  begin
    result:= VarChangeFromEuro( AMonedaDestino, AFechaCambio );
    if result = -1 then
    begin
      raise Exception.Create('No existe el cambio de "' + AMonedaDestino + '" para el "' + DateToStr( AFechaCambio) + '".' );
    end;
  end;
end;


function ChangeToEuro( AMonedaOrigen, AFechaCambio: string; AValor: real; ADecimales: integer = 2 ): Real;
var
  dFechaCambio: TDateTime;
begin
  if TryStrToDate( AFechaCambio, dFechaCambio ) then
  begin
    result:=  ChangeToEuro( AMonedaOrigen, dFechaCambio, AValor, ADecimales );
  end
  else
  begin
    raise Exception.Create('Fecha para el cambio incorrecta.');
  end;
end;

function ChangeFromEuro( AMonedaDestino, AFechaCambio: string; AValor: real; ADecimales: integer = 2 ): Real;
var
  dFechaCambio: TDateTime;
begin
  if TryStrToDate( AFechaCambio, dFechaCambio ) then
  begin
    result:=  ChangeFromEuro( AMonedaDestino, dFechaCambio, AValor, ADecimales );
  end
  else
  begin
    raise Exception.Create('Fecha para el cambio incorrecta.');
  end;
end;

function ChangeMoney( AMonedaOrigen, AMonedaDestino, AFechaCambio: string; AValor: real; ADecimales: integer = 2 ): real;
var
  dFechaCambio: TDateTime;
begin
  if TryStrToDate( AFechaCambio, dFechaCambio ) then
  begin
    result:=  ChangeMoney( AMonedaOrigen, AMonedaDestino, dFechaCambio, AValor, ADecimales );
  end
  else
  begin
    raise Exception.Create('Fecha para el cambio incorrecta.');
  end;
end;

function ChangeToEuro( AMonedaOrigen: string; AFechaCambio: TDateTime; AValor: real; ADecimales: integer = 2 ): Real;
begin
  if AValor < 0 then
    result:= -1 * bRoundTo( ABS(AValor) * ToEuro( AMonedaOrigen, AFechaCambio ), -ADecimales)
  else
    result:= bRoundTo( AValor * ToEuro( AMonedaOrigen, AFechaCambio ), -ADecimales);
end;

function ChangeFromEuro( AMonedaDestino: string; AFechaCambio: TDateTime; AValor: real; ADecimales: integer = 2 ): Real;
begin
  result:= bRoundTo( AValor * FromEuro( AMonedaDestino, AFechaCambio ), -ADecimales);
end;

function ChangeMoney( AMonedaOrigen, AMonedaDestino: string; AFechaCambio: TDateTime; AValor: real; ADecimales: integer = 2 ): real;
begin
  if AMonedaOrigen <> AMonedaDestino then
  begin
    result:= bRoundTo( AValor * ToEuro( AMonedaOrigen, AFechaCambio ), -ADecimales);
    result:= bRoundTo( result * FromEuro( AMonedaDestino, AFechaCambio ), -ADecimales);
  end
  else
  begin
    result:= AValor;
  end;
end;

(*
function FechaRemesa(const AEmpresa, ABanco: string; const AReferencia: integer; const AFechaFactura: TDateTime ): TDateTime;
begin
  result := AFechaFactura;
  with DMCambioMoneda.QRemesa do
  begin
    if not Prepared then
      Prepare;
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('banco').AsString:= ABanco;
    ParamByName('remesa').AsInteger:= AReferencia;
    ParamByName('fecha').AsDateTime:= AFechaFactura;
    Open;
    if not isEmpty then
    begin
      result := FieldByName('fecha_r').AsDateTime;
    end;
    Close;
  end;
end;
*)

function FactorCambioFOB(const AEmpresa, ACentro, AFecha, AAlbaran, AMoneda: string): Real;
var
  iFactura: Integer;
  dFechaFactura: TDateTime;
begin
  //Orden de busqueda cambio
  //1.- REMESA
  //2.- FACTURA
  //3.- ALBARAN
  if AMoneda <> 'EUR' then
  begin
    //Buscamos albaran para sacar factura
    with DMCambioMoneda.QAlbaran do
    begin
      If not Prepared then
        Prepare;
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('centro').AsString:= ACentro ;
      ParamByName('albaran').AsInteger:= StrToIntDef( AAlbaran, 0 );
      ParamByName('fecha').AsDateTime:= StrToDateDef( AFecha, Date );
      Open;
      iFactura := FieldByName('n_factura_sc').AsInteger;
      dFechaFactura := FieldByName('fecha_factura_sc').AsDateTime;
      Close;
    end;
    //Si existe la factura
    if iFactura <> 0 then
    begin
      result := ToEuro(AMoneda, dFechaFactura );
    end
    else
    begin
      //Cambio del albaran
      result := ToEuro(AMoneda, AFecha );
    end;
  end
  else
  begin
    result := 1;
  end;
end;

function FactorCambioLIQ(const AEmpresa, AFacturaNum, AFacturaFecha, AMoneda, AFechaCambio: string): real;
begin
  with DMCambioMoneda.QCambioFactura do
  begin
    if (AFacturaNum <> '') and (AFacturaFecha <> '') then
    begin
      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('factura').AsString := AFacturaNum;
      ParamByName('fecha').AsDate := StrToDate(AFacturaFecha);
      Open;
    end;

    if Active and not IsEmpty and (FieldByName('importe_total_f').AsFloat <> 0) then
    begin
      //ESTA FACTURADO, COGE CAMBIO DE LAS CANTIDADES FACTURADAS
      result := bRoundTo(FieldByName('importe_euros_f').AsFloat / FieldByName('importe_total_f').AsFloat, -6);
    end
    else
    begin
      result:= ToEuro( AMoneda, AFechaCambio );
    end;
    Close;
  end;
end;

{$R *.dfm}

procedure TDMCambioMoneda.DataModuleCreate(Sender: TObject);
begin
  with QChange do
  begin
    DatabaseName:= sAliasName;
    SQL.Clear;
    SQL.Add(' Select cambio_ce factor ');
    SQL.Add(' from frf_cambios_euros ');
    SQL.Add(' where moneda_ce = :moneda ');
    SQL.Add(' and fecha_ce = :fecha ');
    SQL.Add(' and nvl(cambio_ce,0) <> 0 ');
  end;
  (*
  with QChangeAux do
  begin
    DatabaseName:= sAliasName;
    SQL.Clear;
    SQL.Add(' Select first 1 cambio_ce factor ');
    SQL.Add(' from frf_cambios_euros ');
    SQL.Add(' where moneda_ce= :moneda ');
    SQL.Add(' and fecha_ce < :fecha ');
    SQL.Add(' and nvl(cambio_ce,0) <> 0 ');
    SQL.Add(' order by fecha_ce desc ');
  end;
  *)
  with QAlbaran do
  begin
    DatabaseName:= sAliasName;
    SQL.Clear;
    SQL.Add(' select n_factura_sc, fecha_factura_sc ');
    SQL.Add(' from frf_salidas_c ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and n_albaran_sc = :albaran ');
    SQL.Add(' and fecha_sc = :fecha ');
  end;
  with QCambioFactura do
  begin
    DatabaseName:= sAliasName;
    SQL.Clear;
    SQL.Add(' select nvl( importe_total_f, 0 ) importe_total_f, ');
    SQL.Add('        nvl( importe_euros_f, 0 ) importe_euros_f');
    SQL.Add(' from frf_facturas ');
    SQL.Add(' where empresa_f = :empresa ');
    SQL.Add('   and n_factura_f = :factura ');
    SQL.Add('   and fecha_factura_f = :fecha ');
  end;

  with qryX3Cambio do
  begin
    Sql.Clear;
    Sql.Add('SELECT CONVERT(VARCHAR, CHGSTRDAT_0, 103) AS FECHA, ROUND(REVCOURS_0,4) AS CAMBIO ');
    Sql.Add('FROM [v6].BONNYSA.TABCHANGE ');
    Sql.Add('WHERE 1 = 1 ');
    Sql.Add('	AND CHGDIV_0= ''1'' ');
    Sql.Add('	AND CURDEN_0 = ''EUR'' ');
    Sql.Add('	AND CUR_0 = :moneda ');
    Sql.Add('	AND CHGSTRDAT_0 = :fecha ');
  end;

  with qryGrabarCambio do
  begin
    DatabaseName:= sAliasName;
    Sql.Clear;
    Sql.Add(' insert into frf_cambios_euros values ( :fecha, :moneda, :cambio ) ');
  end;

end;

procedure TDMCambioMoneda.DataModuleDestroy(Sender: TObject);
begin
  with QChange do
  begin
    if Prepared then
      UnPrepare;
  end;
  (*
  with QChangeAux do
  begin
    if Prepared then
      UnPrepare;
  end;
  *)
  with QAlbaran do
  begin
    if Prepared then
      UnPrepare;
  end;
  (*
  with QFactura do
  begin
    if Prepared then
      UnPrepare;
  end;
  with QRemesa do
  begin
    if Prepared then
      UnPrepare;
  end;
  *)
  with QCambioFactura do
  begin
    if Prepared then
      UnPrepare;
  end;
end;

initialization
  DMCambioMoneda:= TDMCambioMoneda.Create( nil );

finalization
  FreeAndNil( DMCambioMoneda );


end.
