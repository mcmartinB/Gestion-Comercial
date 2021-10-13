unit EntradasSalidasDM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMEntradasSalidas = class(TDataModule)
    qrySalidas: TQuery;
    qryAux: TQuery;
    qryRemoto: TQuery;
    qryAuxRemoto: TQuery;
    qryListado: TQuery;
  private
    { Private declarations }
    bError: Boolean;
    sMsg: string;

    sRefEntrada: string;
    sEmpresa, sCentro, sProducto: string;
    dFecha: TDateTime;
    iEntrada: Integer;
    bDefinitivo, bCostesAnteriores: Boolean;

    function  GetCodeSalida: string;
    procedure ClearError;
    procedure AddError( const AMsg: string; const AlFinal: boolean = True );
    function  GetError: string;

    procedure CerrarQuerys;

    function  NoHaSidoEnviado: Boolean;
    function  ComprobarDestino( const ABorrar: Boolean ): Boolean;
    function  CopiarDatos( var AMsg: string ): boolean;
    function  PuedoCopiarLinea( var AMsg: string ): boolean;
    function  PuedoCopiarSalida( var AMsg: string ): boolean;
    function  PuedoCopiarTransito( var AMsg: string ): boolean;
    procedure MarcarEnvio;

    function  EstaEntradaAsignada_: Boolean;
    function  KilosEntrada: real;
    function  KilosAsignados: real;

    function  EstanSalidasFacturadas: Boolean;
    function  EstaSalidaFacturada( var VMsg: string ): Boolean;

    procedure ValorarLineas;
    procedure ActualizarValorLiquida( const AKilos, AImporte, ADescuento, AGastos, AAbonos, AEnvasado, AOtros: Real );
    procedure ActualizarCabeceraLiquida( const AKilos, AImporte: real ) ;

  public
    { Public declarations }
    procedure VerError( const AVerOK: Boolean = false );

    function ValorarEntrada( const AEmpresa, ACentro: string; const AFecha: TDateTime;
                             const AEntrada: Integer; const ADefinitivo, ACosteAnteriores: boolean  ): boolean;

    function EstaEntradaAsignada( const AEmpresa, ACentro: string; const AFecha: TDateTime;
                              const AEntrada: Integer ): boolean;

    function EnviarEntradaSalidas( const AEmpresa, ACentro: string; const AFecha: TDateTime;
                                   const AEntrada: Integer ): boolean;

    function BorrarSalidaAsignada(
                          const AEmpresa, ACentroEntrada: string;
                          const AFechaEntrada: TDateTime;
                          const AEntrada: Integer;
                          const ACentroSalida: string;
                          const AFechaSalida: TDateTime;
                          const ASalida, ATransito: Integer;
                          const AProducto: string;
                          const AKilos: real ): boolean;

    procedure InsertarSalidaAsignada(
                          const AEmpresa, ACentroEntrada: string;
                          const AFechaEntrada: TDateTime;
                          const AEntrada: Integer;
                          const ACentroSalida: string;
                          const AFechaSalida: TDateTime;
                          const ASalida: Integer;
                          const AProducto, ATipo: string;
                          const AKilos: real );

    function  HayEntradasSinAsignar( const AEmpresa, ACentro, AProducto, ANumero: string;
                                     const AFechaIni, AFechaFin: TDateTime; const ATipo: integer ): Boolean;

    function  HaySalidasSinAsignar( const AEmpresa, ACentroOrigen, AProducto, ANumero: string;
                                    const AFechaIni, AFechaFin: TDateTime; const ATipo, ATipoSalida: integer ): Boolean;
  end;

function EnviarSalidasAsignadas( const AOwner: TComponent;
                                 const AEmpresa, ACentro: string;
                                 const AFecha: TDateTime;
                                 const AEntrada: Integer ): boolean;

function BorrarSalidaAsignada( const AOwner: TComponent;
                          const AEmpresa, ACentroEntrada: string;
                          const AFechaEntrada: TDateTime;
                          const AEntrada: Integer;
                          const ACentroSalida: string;
                          const AFechaSalida: TDateTime;
                          const ASalida, ATransito: Integer;
                          const AProducto: string;
                          const AKilos: real ): boolean;

procedure InsertarSalidaAsignada( const AOwner: TComponent;
                          const AEmpresa, ACentroEntrada: string;
                          const AFechaEntrada: TDateTime;
                          const AEntrada: Integer;
                          const ACentroSalida: string;
                          const AFechaSalida: TDateTime;
                          const ASalida: Integer;
                          const AProducto, ATipo: string;
                          const AKilos: real );

function ValorarEntrada( const AOwner: TComponent; const AEmpresa, ACentro: string; const AFecha: TDateTime;
                         const AEntrada: Integer; const ADefinitivo, ACosteAnteriores: boolean ): boolean;
function ValorarEntradaEx( const AEmpresa, ACentro: string; const AFecha: TDateTime;
                           const AEntrada: Integer; const ADefinitivo: boolean; var VMsg: string ): boolean;

implementation

{$R *.dfm}

uses
  UDMBaseDatos, SincroVarUNT, Forms, Dialogs, Windows, UDMValorarSal, bMath;
//  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
//Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, BEdit;

(*
CREATE TABLE informix.frf_entradas_sal (
  empresa_es CHAR(3) NOT NULL,
  centro_entrada_es CHAR(1) NOT NULL,
  n_entrada_es INTEGER NOT NULL,
  fecha_entrada_es DATE NOT NULL,
  centro_salida_es CHAR(1),
  n_salida_es INTEGER,
  fecha_salida_es DATE,
  producto_es CHAR(1) NOT NULL,
  kilos_es DECIMAL(12,2) NOT NULL,
  importe_neto_es DECIMAL(12,2) NOT NULL,
  gasto_salida_es DECIMAL(12,2) NOT NULL,
  coste_envasado_es DECIMAL(12,2) NOT NULL,
  coste_otros_es DECIMAL(12,2) NOT NULL
)
*)

function TDMEntradasSalidas.GetCodeSalida: string;
begin
  with qrySalidas do
  begin
    result:=FieldByName('empresa_es').AsString + '-' +
                FieldByName('centro_salida_es').AsString + '-(' +
                FieldByName('fecha_salida_es').AsString + ')-' +
                FieldByName('n_salida_es').AsString;
  end;
end;

procedure TDMEntradasSalidas.ClearError;
begin
  bError:= False;
  sMsg:= '';
end;

procedure TDMEntradasSalidas.AddError( const AMsg: string; const AlFinal: boolean = True );
begin
  bError:= true;
  if sMsg = '' then
    sMsg:= AMsg
  else
  begin
    if AlFinal then
      sMsg:= sMsg + #13 + #10 + AMsg
    else
      sMsg:= AMsg + #13 + #10 + sMsg;
  end;

end;

function TDMEntradasSalidas.GetError: string;
begin
  if ( not bError ) and ( sMsg = '' ) then
    result:= 'Proceso finalizado correctamente.'
  else
    result:= sMsg;
end;

procedure TDMEntradasSalidas.VerError( const AVerOK: Boolean = false );
begin
  if bError or AVerOK then
  begin
    showMessage( GetError );
  end;
end;


function TDMEntradasSalidas.KilosEntrada: real;
begin
  with qryAux do
  begin
    SQL.Clear;
    SQL.Add(' select producto_e2l, sum(total_kgs_e2l) kilos_el ');
    SQL.Add(' from frf_entradas2_l ');
    SQL.Add(' where empresa_e2l = :empresa ');
    SQL.Add(' and centro_e2l = :centro ');
    SQL.Add(' and numero_entrada_e2l = :entrada ');
    SQL.Add(' and fecha_e2l = :fecha ');
    SQL.Add(' group by 1 ');


    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('entrada').AsInteger:= iEntrada;
    ParamByName('fecha').Asdate:= dFecha;
    Open;
    sProducto:= FieldByName('producto_e2l').AsString;
    Result:= FieldByName('kilos_el').AsFloat;
    Close;
  end;
end;

function TDMEntradasSalidas.KilosAsignados: Real;
begin
  with qrySalidas do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_entradas_sal ');
    SQL.Add(' where empresa_es = :empresa ');
    SQL.Add(' and centro_entrada_es = :centro ');
    SQL.Add(' and n_entrada_es = :entrada ');
    SQL.Add(' and fecha_entrada_es = :fecha ');

    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('entrada').AsInteger:= iEntrada;
    ParamByName('fecha').Asdate:= dFecha;
    Open;
    Result:= 0;
    while not Eof do
    begin
      Result:= Result + FieldByName('kilos_es').AsFloat;
      Next;
    end;
  end;
end;

function TDMEntradasSalidas.EstaEntradaAsignada_: Boolean;
var
  rIn, rOut: Currency;
begin
  Result:= False;
  rIn:= KilosEntrada;
  if rIn = 0 then
  begin
    AddError('NO EXISTE ENTRADA o ENTRADA SIN KILOS.');
  end
  else
  begin
    rOut:= KilosAsignados;
    if rOut = 0 then
    begin
      AddError( 'ENTRADA SIN NINGUN KILO ASIGNADO.');
    end
    else
    if rOut > rIn then
    begin
      AddError( 'ENTRADA CON MAS KILOS ASIGNADOS DE LOS QUE TIENE.');
    end
    else
    if ( rOut < rIn ) then
    begin
      AddError( 'ENTRADA CON MENOS KILOS ASIGNADOS DE LOS QUE TIENE.');
    end
    else
    begin
      Result:= True;
    end;
  end;
end;

function TDMEntradasSalidas.EstaEntradaAsignada( const AEmpresa, ACentro: string; const AFecha: TDateTime; const AEntrada: Integer ): boolean;
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  dFecha:= AFecha;
  iEntrada:= AEntrada;
  bDefinitivo:= False;
  bCostesAnteriores:= False;
  sRefEntrada:=sEmpresa + '-' + sCentro + '-(' + DateToStr(dFecha) + ')-' + IntToStr(iEntrada);

  ClearError;
  try
    Result:= EstaEntradaAsignada_;
  finally
    qrySalidas.Close;
  end;
end;

function ClienteFacturable( const ACodCliente: string ): boolean;
begin
  result:= Copy( Trim( ACodCliente ), 1, 1 ) <> '0';
end;


function TDMEntradasSalidas.EstaSalidaFacturada( var VMsg: string ): Boolean;
var
  rKilosAux: Real;
  bFlag: Boolean;
  sMsgAux: string;
begin
  result:= True;
  if qrySalidas.FieldByName('transito_es').AsInteger = 0 then
  begin
    with qryAux do
    begin
      SQL.Clear;
      SQL.Add(' select empresa_sc, fecha_factura_sc, n_factura_sc ');
      SQL.Add(' from frf_salidas_c ');
      SQL.Add(' where empresa_sc = :empresa ');
      SQL.Add(' and centro_salida_sc = :centro ');
      SQL.Add(' and n_albaran_sc = :salida ');
      SQL.Add(' and fecha_sc = :fecha ');
      SQL.Add(' and (fecha_factura_sc is not null or cliente_fac_sc[1,1] = ''0'') ');
      ParamByName('empresa').AsString:= qrySalidas.FieldByName('empresa_es').AsString;
      ParamByName('centro').AsString:= qrySalidas.FieldByName('centro_salida_es').AsString;
      ParamByName('salida').AsInteger:= qrySalidas.FieldByName('n_salida_es').AsInteger;
      ParamByName('fecha').Asdate:= qrySalidas.FieldByName('fecha_salida_es').AsDateTime;
      Open;
      Result:= not IsEmpty;
      Close;
      if not Result then
        VMsg:= 'Salida no facturada -> ' + GetCodeSalida;
    end;
  end
  else
  begin
    with qryAux do
    begin
      SQL.Clear;
      SQL.Add(' select empresa_sc empresa, centro_salida_sc centro, ');
      SQL.Add('        cliente_fac_sc cliente, fecha_sc fecha_salida, n_Albaran_sc n_salida, ');
      SQL.Add('        fecha_factura_sc fecha_factura, n_factura_sc n_factura,  sum(kilos_sl) kilos ');
      SQL.Add(' from frf_salidas_l, frf_salidas_c ');
      SQL.Add(' where empresa_sl = :empresa ');
      SQL.Add(' and nvl( centro_transito_sl, centro_origen_sl ) = :centro ');
      SQL.Add(' and ref_transitos_sl = :salida ');
      SQL.Add(' and ( fecha_transito_sl = :fecha or ');
      SQL.Add('       fecha_sl between :fechaini and  :fechafin ) ');
      SQL.Add(' and empresa_Sc = :empresa ');
      SQL.Add(' and centro_salida_sc = centro_salida_sl ');
      SQL.Add(' and fecha_sc = fecha_sl ');
      SQL.Add(' and n_albaran_sc = n_albaran_sl ');
      SQL.Add(' group by 1,2,3,4,5,6,7 ');

      ParamByName('empresa').AsString:= qrySalidas.FieldByName('empresa_es').AsString;
      ParamByName('centro').AsString:= qrySalidas.FieldByName('centro_salida_es').AsString;
      ParamByName('salida').AsInteger:= qrySalidas.FieldByName('n_salida_es').AsInteger;
      ParamByName('fecha').Asdate:= qrySalidas.FieldByName('fecha_salida_es').AsDateTime;
      ParamByName('fechaIni').Asdate:= qrySalidas.FieldByName('fecha_salida_es').AsDateTime - 30;
      ParamByName('fechaFin').Asdate:= qrySalidas.FieldByName('fecha_salida_es').AsDateTime + 90;
      Open;

      rKilosAux:= 0;
      bFlag:= True;
      sMsgAux:= '';
      while not Eof do
      begin
        rKilosAux:= rKilosAux + FieldByName('kilos').AsFloat;
        if ( FieldByName('n_factura').AsString = '' ) and
           ClienteFacturable( FieldByName('cliente').AsString ) then
        begin
          //Añadir entrada
          bFlag:= False;
          sMsgAux:= Trim( sMsgAux + #13 + #10 +  'Salida no facturada --> ' +  FieldByName('empresa').AsString + ' - ' +
                                                      FieldByName('centro').AsString + ' - (' +
                                                      FieldByName('fecha_salida').AsString + ') - ' +
                                                      FieldByName('n_salida').AsString );
        end;
        Next;
      end;

      Close;
    end;

    with qryAux do
    begin
      SQL.Clear;
      SQL.Add(' select  sum(kilos_tl) kilos ');
      SQL.Add(' from frf_transitos_l ');
      SQL.Add(' where empresa_tl = :empresa ');
      SQL.Add(' and centro_tl = :centro ');
      SQL.Add(' and referencia_tl = :salida ');
      SQL.Add(' and fecha_tl = :fecha ');
      ParamByName('empresa').AsString:= qrySalidas.FieldByName('empresa_es').AsString;
      ParamByName('centro').AsString:= qrySalidas.FieldByName('centro_salida_es').AsString;
      ParamByName('salida').AsInteger:= qrySalidas.FieldByName('n_salida_es').AsInteger;
      ParamByName('fecha').Asdate:= qrySalidas.FieldByName('fecha_salida_es').AsDateTime;
      Open;
      Result:= ( bRoundTo(rKilosAux,2) = bRoundTo(FieldByName('kilos').AsFloat,2) );
      Close;
    end;
    if not Result then
      VMsg:= 'Tránsito no asignado al 100% -> ' + GetCodeSalida;

    if not bFlag then
    begin
      VMsg:= Trim( VMsg + #13 + #10 + 'Tránsito con salidas no facturadas -> ' + GetCodeSalida );
      VMsg:= VMsg + #13 + #10 + sMsgAux;
    end;
    Result:= Result and bFlag;
  end;
end;

function TDMEntradasSalidas.EstanSalidasFacturadas: Boolean;
var
  sMsg: string;
begin
  Result:= True;
  with qrySalidas do
  begin
    First;
    while not Eof do
    begin
      if not EstaSalidaFacturada( sMsg ) then
      begin
        AddError( sMsg );
        Result:= False;
      end;
      Next;
    end;
  end;
end;

procedure TDMEntradasSalidas.ActualizarValorLiquida( const AKilos, AImporte, ADescuento, AGastos, AAbonos, AEnvasado, AOtros: Real );
var
  Marca: TBookmark;
begin
  if AKilos > 0 then
  begin
    with qrySalidas do
    begin
      Marca:= GetBookmark;
      Edit;
      FieldByName('importe_es').AsFloat:=  bRoundTo( (FieldByName('kilos_es').AsFloat * AImporte) / AKilos, 2 );
      FieldByName('descuento_es').AsFloat:=  bRoundTo( (FieldByName('kilos_es').AsFloat * ADescuento) / AKilos, 2 );
      FieldByName('gasto_es').AsFloat:=  bRoundTo( (FieldByName('kilos_es').AsFloat * AGastos) / AKilos, 2 );
      FieldByName('abono_es').AsFloat:=  bRoundTo( (FieldByName('kilos_es').AsFloat * AAbonos) / AKilos, 2 );
      FieldByName('envasado_es').AsFloat:=  bRoundTo( (FieldByName('kilos_es').AsFloat * AEnvasado) / AKilos, 2 );
      FieldByName('otros_es').AsFloat:=  bRoundTo( (FieldByName('kilos_es').AsFloat * AOtros) / AKilos, 2 );
      Post;
      GotoBookmark( Marca );
      FreeBookmark( Marca );
    end;
  end;
end;

procedure TDMEntradasSalidas.ActualizarCabeceraLiquida( const AKilos, AImporte: real ) ;
var
  sAux: string;
begin
  with qryAux do
  begin
    SQL.Clear;
    SQL.Add(' update frf_entradas_c ');
    SQL.Add(' set fecha_liquidacion_ec = TODAY ');
    SQL.Add(' , precio_liq_ec = :precio ');
    if bDefinitivo and ( not bError ) then
      SQL.Add(' , liquidacion_definitiva_ec = 1 ');
    sAux:= GetError;
    if sAux <> '' then
      SQL.Add(' , nota_liquidacion_ec = :nota ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and centro_ec = :centro ');
    SQL.Add(' and numero_entrada_ec = :entrada ');
    SQL.Add(' and fecha_ec = :fecha ');

    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('entrada').AsInteger:= iEntrada;
    ParamByName('fecha').Asdate:= dFecha;
    if sAux <> '' then
      ParamByName('nota').AsString:= sAux;
    if AKilos <> 0 then
      ParamByName('precio').AsFloat:= bRoundTo( AImporte / AKilos, 3 )
    else
      ParamByName('precio').AsFloat:= 0;
    ExecSQL;
  end;
end;

procedure TDMEntradasSalidas.ValorarLineas;
var
  DMValorarSal: TDMValorarSal;
  iCodError: Integer;
  sMsgError: string;
  rKilos, rImporte, rDescuento, rGastos, rAbonos, rEnvasado, rOtros: Real;
  raKilos, raImporte: Real;
begin
  raKilos:= 0;
  raImporte:= 0;

  DMValorarSal:= TDMValorarSal.Create( nil );

  try
    with qrySalidas do
    begin
      First;
      while not Eof  do
      begin
        //codigo para valorar el transito
        if qrySalidas.fieldByName('transito_es').AsInteger = 0 then
        begin
          if DMValorarSal.ValorarProductoSalida( sEmpresa, qrySalidas.fieldByName('centro_salida_es').AsString, sProducto,
                                              qrySalidas.fieldByName('fecha_salida_es').AsDateTime,
                                              qrySalidas.fieldByName('n_salida_es').AsInteger, bDefinitivo, bCostesAnteriores,
                                              rKilos, rImporte, rDescuento, rGastos, rAbonos, rEnvasado, rOtros,
                                              iCodError, sMsgError ) then
          begin
            ActualizarValorLiquida( rKilos, rImporte, rDescuento, rGastos, rAbonos, rEnvasado, rOtros );
            raKilos:= raKilos + rKilos;
            raImporte:= raImporte + ( rImporte - ( rDescuento + rGastos + rAbonos + rEnvasado + rOtros ) );
          end
          else
          begin
            AddError( sMsgError );
          end;
        end
        else
        if qrySalidas.fieldByName('transito_es').AsInteger = 1 then
        begin
          if DMValorarSal.ValorarProductoTransito( sEmpresa, qrySalidas.fieldByName('centro_salida_es').AsString, sProducto,
                                              qrySalidas.fieldByName('fecha_salida_es').AsDateTime,
                                              qrySalidas.fieldByName('n_salida_es').AsInteger, bDefinitivo, bCostesAnteriores,
                                              rKilos, rImporte, rDescuento, rGastos, rAbonos, rEnvasado, rOtros,
                                              iCodError, sMsgError ) then
          begin
            ActualizarValorLiquida( rKilos, rImporte, rDescuento, rGastos, rAbonos, rEnvasado, rOtros );
            raKilos:= raKilos + rKilos;
            raImporte:= raImporte + ( rImporte - ( rDescuento + rGastos + rAbonos + rEnvasado + rOtros ) );
          end
          else
          begin
            AddError( sMsgError );
          end;
        end
        else
        begin
          AddError( 'Tipo de salida desconocida -> ' + GetCodeSalida );
        end;
        Next;
      end;
      ActualizarCabeceraLiquida( raKilos, raImporte );
    end;
  finally
    FreeAndNil( DMValorarSal );
  end;
end;

function TDMEntradasSalidas.ValorarEntrada(
            const AEmpresa, ACentro: string; const AFecha: TDateTime;
            const AEntrada: Integer; const ADefinitivo, ACosteAnteriores: boolean ): boolean;
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  dFecha:= AFecha;
  iEntrada:= AEntrada;
  bDefinitivo:= ADefinitivo;
  bCostesAnteriores:= ACosteAnteriores;
  sRefEntrada:=sEmpresa + '-' + sCentro + '-(' + DateToStr(dFecha) + ')-' + IntToStr(iEntrada);

  try
    if EstaEntradaAsignada_ then
    begin
      if not EstanSalidasFacturadas then  //Valoradas
      begin
        if not bDefinitivo then
        begin
          AddError('ERROR: Existen albaranes sin facturar o tránsitos sin asignar. ', False );
        end
        else
        begin
          AddError('ERROR: No se puede hacer una valoracion definitiva si hay albaranes sin facturar. ', False );
          bDefinitivo:= False;
        end;
        ValorarLineas;
        Result:= True;
      end
      else
      begin
        ValorarLineas;
        Result:= True;
      end;
    end
    else
    begin
      Result:= False;
    end;
  finally
    qrySalidas.Close;
  end;
end;


function TDMEntradasSalidas.EnviarEntradaSalidas( const AEmpresa, ACentro: string;
                                                  const AFecha: TDateTime;
                                                  const AEntrada: Integer ): Boolean;
var
  sMsg: string;
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  iEntrada:= AEntrada;
  dFecha:= AFecha;

  sMsg:= '';
  if NoHaSidoEnviado then
  begin
    if ComprobarDestino( False ) then
    begin
      if CopiarDatos( sMsg ) then
      begin
        result:= True;
      end
      else
      begin
        ShowMessage( sMsg );
        result:= False;
      end;
    end
    else
    begin
      ShowMessage('No puedo copiar los datos en el destino.'  + #13 + #10 +
                  'Borre primero los datos de la central.' );
      result:= False;
    end;
  end
  else
  begin
    if ComprobarDestino( False ) then
    begin
      if CopiarDatos( sMsg ) then
      begin
        result:= True;
      end
      else
      begin
        ShowMessage( sMsg );
        result:= False;
      end;
    end
    else
    begin
      ShowMessage('Las asignacion de la entrada ya ha sido enviada.'  + #13 + #10 +
                  'Borre primero los datos de la central.' );
      result:= False;
    end;
  end;
  CerrarQuerys;
end;

procedure TDMEntradasSalidas.CerrarQuerys;
begin
  if qryAux.Active then
    qryAux.Close;
  if qryRemoto.Active then
    qryRemoto.Close;
  if qrySalidas.Active then
    qrySalidas.Close;
end;

function TDMEntradasSalidas.NoHaSidoEnviado: Boolean;
begin
  Result:= True;
  with qrySalidas do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_entradas_sal ');
    SQL.Add(' where empresa_es = :empresa ');
    SQL.Add(' and centro_entrada_es = :centro ');
    SQL.Add(' and n_entrada_es = :entrada ');
    SQL.Add(' and fecha_entrada_es = :fecha ');
    //SQL.Add(' and enviado_es is not null ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('entrada').AsInteger:= iEntrada;
    ParamByName('fecha').AsDate:= dFecha;
    Open;
    while not Eof and Result do
    begin
      Result:= FieldByName('enviado_es').AsString = '';
      Next;
    end;
  end;
end;

function  TDMEntradasSalidas.ComprobarDestino( const ABorrar: Boolean ): Boolean;
begin
  with qryRemoto do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_entradas_sal ');
    SQL.Add(' where empresa_es = :empresa ');
    SQL.Add(' and centro_entrada_es = :centro ');
    SQL.Add(' and n_entrada_es = :entrada ');
    SQL.Add(' and fecha_entrada_es = :fecha ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('entrada').AsInteger:= iEntrada;
    ParamByName('fecha').AsDate:= dFecha;
    Open;
    if ABorrar then
    begin
      while not Eof do
      begin
        Delete;
      end;
    end;
    Result:= IsEmpty;
  end;
end;

function  TDMEntradasSalidas.CopiarDatos( var AMsg: string ): Boolean;
var
  bFlag: Boolean;
begin
  bFlag:= True;
  qrySalidas.First;

  DMBaseDatos.BDCentral.StartTransaction;
  try
    while not qrySalidas.Eof and bFlag  do
    begin
      if PuedoCopiarLinea( AMsg ) then
      begin
        PasaRegistro( qrySalidas, qryRemoto );
      end
      else
      begin
        bFlag:= False;
      end;
      qrySalidas.Next;
    end;
  except
    DMBaseDatos.BDCentral.Rollback;
    raise;
  end;

  if bFlag then
  begin
    MarcarEnvio;
    DMBaseDatos.BDCentral.Commit;
  end
  else
  begin
    DMBaseDatos.BDCentral.Rollback;
  end;

  Result:= bFlag;
end;

function  TDMEntradasSalidas.PuedoCopiarLinea( var AMsg: string ): Boolean;
begin
  if qrySalidas.fieldByName('transito_es').AsInteger = 0 then
    result:= PuedoCopiarSalida( AMsg )
  else
    result:= PuedoCopiarTransito( AMsg );
end;

function  TDMEntradasSalidas.PuedoCopiarSalida( var AMsg: string ): boolean;
var
  rKilosSal, rKilosAsig: Real;
  rDif: currency;
begin
  with qryAuxRemoto do
  begin
    SQL.Clear;
    SQL.Add('select nvl(sum(kilos_sl),0) kilos_sal  from frf_salidas_l ');
    SQL.Add('where empresa_sl = :empresa ');
    SQL.Add('and centro_salida_sl = :centro ');
    SQL.Add('and fecha_sl = :fecha ');
    SQL.Add('and n_albaran_sl = :albaran ');
    SQL.Add('and producto_sl = :producto ');
    ParamByName('empresa').AsString:= qrySalidas.fieldByName('empresa_es').AsString;
    ParamByName('centro').AsString:= qrySalidas.fieldByName('centro_salida_es').AsString;
    ParamByName('producto').AsString:= qrySalidas.fieldByName('producto_es').AsString;
    ParamByName('albaran').AsInteger:= qrySalidas.fieldByName('n_salida_es').AsInteger;
    ParamByName('fecha').AsDateTime:= qrySalidas.fieldByName('fecha_salida_es').AsDateTime;
    Open;
    if FieldByname('kilos_sal').AsFloat > 0 then
    begin
      rKilosSal:= FieldByname('kilos_sal').AsFloat;
      Close;

      SQL.Clear;
      SQL.Add('select nvl(sum(kilos_es),0) kilos_asig ');
      SQL.Add('from frf_entradas_sal ');
      SQL.Add('where empresa_es = :empresa ');
      SQL.Add('and centro_salida_es = :centro ');
      SQL.Add('and fecha_salida_es = :fecha ');
      SQL.Add('and n_salida_es = :albaran ');
      SQL.Add('and producto_es = :producto ');
      SQL.Add('and transito_es = 0 ');
      ParamByName('empresa').AsString:= qrySalidas.fieldByName('empresa_es').AsString;
      ParamByName('centro').AsString:= qrySalidas.fieldByName('centro_salida_es').AsString;
      ParamByName('producto').AsString:= qrySalidas.fieldByName('producto_es').AsString;
      ParamByName('albaran').AsInteger:= qrySalidas.fieldByName('n_salida_es').AsInteger;
      ParamByName('fecha').AsDateTime:= qrySalidas.fieldByName('fecha_salida_es').AsDateTime;
      Open;
      rKilosAsig:= FieldByName('kilos_asig').AsFloat;
      Close;

      rDif:= ( rKilosSal - rKilosAsig );
      if qrySalidas.fieldByName('kilos_es').AsCurrency <=  rDif then
      begin
        Result:= True;
      end
      else
      begin
        AMsg:= 'ERROR: ' + GetCodeSalida + ' No quedan suficientes kilos en el albaran de salida del destino. Quedan ' + FloatToStr( rKilosSal - rKilosAsig ) + ' Kilos.';
        Result:= False;
      end;
    end
    else
    begin
      Close;
      AMsg:= 'ERROR: ' + GetCodeSalida + ' No existe el albaran de salida en el destino.';
      Result:= False;
    end;
  end;
end;

function  TDMEntradasSalidas.PuedoCopiarTransito( var AMsg: string ): boolean;
var
  rKilosSal, rKilosAsig: Real;
begin
  with qryAuxRemoto do
  begin
    SQL.Clear;
    SQL.Add('select nvl(sum(kilos_tl),0) kilos_sal  from frf_transitos_l ');
    SQL.Add('where empresa_tl = :empresa ');
    SQL.Add('and centro_tl = :centro ');
    SQL.Add('and fecha_tl = :fecha ');
    SQL.Add('and referencia_tl = :albaran ');
    SQL.Add('and producto_tl = :producto ');
    ParamByName('empresa').AsString:= qrySalidas.fieldByName('empresa_es').AsString;
    ParamByName('centro').AsString:= qrySalidas.fieldByName('centro_salida_es').AsString;
    ParamByName('producto').AsString:= qrySalidas.fieldByName('producto_es').AsString;
    ParamByName('albaran').AsInteger:= qrySalidas.fieldByName('n_salida_es').AsInteger;
    ParamByName('fecha').AsDateTime:= qrySalidas.fieldByName('fecha_salida_es').AsDateTime;
    Open;
    if FieldByname('kilos_sal').AsFloat > 0 then
    begin
      rKilosSal:= FieldByname('kilos_sal').AsFloat;
      Close;

      SQL.Clear;
      SQL.Add('select nvl(sum(kilos_es),0) kilos_asig ');
      SQL.Add('from frf_entradas_sal ');
      SQL.Add('where empresa_es = :empresa ');
      SQL.Add('and centro_salida_es = :centro ');
      SQL.Add('and fecha_salida_es = :fecha ');
      SQL.Add('and n_salida_es = :albaran ');
      SQL.Add('and producto_es = :producto ');
      SQL.Add('and transito_es = 1 ');
      ParamByName('empresa').AsString:= qrySalidas.fieldByName('empresa_es').AsString;
      ParamByName('centro').AsString:= qrySalidas.fieldByName('centro_salida_es').AsString;
      ParamByName('producto').AsString:= qrySalidas.fieldByName('producto_es').AsString;
      ParamByName('albaran').AsInteger:= qrySalidas.fieldByName('n_salida_es').AsInteger;
      ParamByName('fecha').AsDateTime:= qrySalidas.fieldByName('fecha_salida_es').AsDateTime;
      Open;
      rKilosAsig:= FieldByName('kilos_asig').AsFloat;
      Close;

      if qrySalidas.fieldByName('kilos_es').AsFloat <= ( rKilosSal - rKilosAsig ) then
      begin
        Result:= True;
      end
      else
      begin
        AMsg:= 'ERROR: ' + GetCodeSalida + 'No quedan suficientes kilos en el albaran de tránsito del destino. Quedan ' + FloatToStr( rKilosSal - rKilosAsig ) + ' Kilos.';
        Result:= False;
      end;
    end
    else
    begin
      Close;
      AMsg:= 'ERROR: ' + GetCodeSalida + 'No existe el albaran de tránsito en el destino.';
      Result:= False;
    end;
  end;
end;

(*

    DMBaseDatos.BDCentral.Commit;
  except
    DMBaseDatos.BDCentral.Rollback;
    raise;
  end;


*)

procedure TDMEntradasSalidas.MarcarEnvio;
var
  dMarca: TDateTime;
begin
  dMarca:= Date;
  with qryAux do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' update frf_entradas_sal ');
    SQL.Add(' set enviado_es = :marca ');
    SQL.Add(' where empresa_es = :empresa ');
    SQL.Add(' and centro_entrada_es = :centro ');
    SQL.Add(' and n_entrada_es = :entrada ');
    SQL.Add(' and fecha_entrada_es = :fecha ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('entrada').AsInteger:= iEntrada;
    ParamByName('fecha').AsDate:= dFecha;
    ParamByName('marca').AsDate:= dMarca;
    ExecSQL;
  end;
  with qryRemoto do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' update frf_entradas_sal ');
    SQL.Add(' set enviado_es = :marca ');
    SQL.Add(' where empresa_es = :empresa ');
    SQL.Add(' and centro_entrada_es = :centro ');
    SQL.Add(' and n_entrada_es = :entrada ');
    SQL.Add(' and fecha_entrada_es = :fecha ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('entrada').AsInteger:= iEntrada;
    ParamByName('fecha').AsDate:= dFecha;
    ParamByName('marca').AsDate:= dMarca;
    ExecSQL;
  end;
end;

//procedure  TDMEntradasSalidas.BorrarSalidasAsignadas( const AEmpresa, ACentro: string; const AFecha: TDateTime;
//                                     const AEntrada: Integer): boolean;;

function TDMEntradasSalidas.BorrarSalidaAsignada(
                          const AEmpresa, ACentroEntrada: string;
                          const AFechaEntrada: TDateTime;
                          const AEntrada: Integer;
                          const ACentroSalida: string;
                          const AFechaSalida: TDateTime;
                          const ASalida, ATransito: Integer;
                          const AProducto: string;
                          const AKilos: real ): boolean;
begin
  result:= False;
    if Application.MessageBox(PChar( 'Seguro que quiere borrar la línea asociada a la saliada ' +
               AEmpresa + '-' + ACentroSalida + '-' + IntToStr( ASalida ) + ' del (' + DateToStr( AFechaSalida ) +
               ') de ' + FloatToStr( AKilos ) + ' kilos?.'),
               'BORRAR SALIDA ASOCIADA', MB_YESNO ) = IDYES then
    begin
        with qryAux do
        begin
          SQL.Clear;
          SQL.Add(' delete from frf_entradas_sal ');
          SQL.Add(' where empresa_es = :empresa_es ');
          SQL.Add(' and centro_entrada_es = :centro_entrada_es ');
          SQL.Add(' and n_entrada_es = :n_entrada_es ');
          SQL.Add(' and fecha_entrada_es = :fecha_entrada_es  ');
          SQL.Add(' and centro_salida_es = :centro_salida_es  ');
          SQL.Add(' and n_salida_es = :n_salida_es ');
          SQL.Add(' and fecha_salida_es = :fecha_salida_es ');
          SQL.Add(' and producto_es = :producto_es ');
          SQL.Add(' and transito_es = :transito_es ');
          SQL.Add(' and kilos_es = :kilos_es ');

          ParamByName('empresa_es').AsString:= AEmpresa;
          ParamByName('centro_entrada_es').AsString:= ACentroEntrada;
          ParamByName('n_entrada_es').AsInteger:= AEntrada;
          ParamByName('fecha_entrada_es').AsDate:= AFechaEntrada;
          ParamByName('producto_es').AsString:= AProducto;
          ParamByName('kilos_es').AsFloat:= AKilos;
          ParamByName('centro_salida_es').AsString:= ACentroSalida;
          ParamByName('n_salida_es').AsInteger:= ASalida;
          ParamByName('transito_es').AsInteger:= ATransito;
          ParamByName('fecha_salida_es').AsDate:= AFechaSalida;
          ExecSQL;
          result:= True;
        end;
    end;
end;

procedure TDMEntradasSalidas.InsertarSalidaAsignada(
                          const AEmpresa, ACentroEntrada: string;
                          const AFechaEntrada: TDateTime;
                          const AEntrada: Integer;
                          const ACentroSalida: string;
                          const AFechaSalida: TDateTime;
                          const ASalida: Integer;
                          const AProducto, ATipo: string;
                          const AKilos: real );
begin
  with qryAux do
  begin
    SQL.Clear;
    SQL.Add(' insert into frf_entradas_sal ( empresa_es, centro_entrada_es, n_entrada_es, fecha_entrada_es, ');
    SQL.Add('                                centro_salida_es, n_salida_es, fecha_salida_es, producto_es, transito_es, kilos_es )  ');
    SQL.Add(' values ');
    SQL.Add(' ( :empresa_es, :centro_entrada_es, :n_entrada_es, :fecha_entrada_es, ');
    SQL.Add('   :centro_salida_es, :n_salida_es, :fecha_salida_es, :producto_es, :transito_es, :kilos_es  ) ');
    ParamByName('empresa_es').AsString:= AEmpresa;
    ParamByName('centro_entrada_es').AsString:= ACentroEntrada;
    ParamByName('n_entrada_es').AsInteger:= AEntrada;
    ParamByName('fecha_entrada_es').AsDate:= AFechaEntrada;
    ParamByName('centro_salida_es').AsString:= ACentroSalida;
    ParamByName('n_salida_es').AsInteger:= ASalida;
    ParamByName('fecha_salida_es').AsDate:= AFechaSalida;
    ParamByName('producto_es').AsString:= AProducto;
    ParamByName('kilos_es').AsFloat:= AKilos;
    if Copy( ATipo, 1, 1 ) = 'S' then
      ParamByName('transito_es').AsInteger:= 0
    else
      ParamByName('transito_es').AsInteger:= 1;
    ExecSQL;
  end;
end;


function  TDMEntradasSalidas.HayEntradasSinAsignar( const AEmpresa, ACentro, AProducto, ANumero: string;
                                     const AFechaIni, AFechaFin: TDateTime; const ATipo: integer ): Boolean;
begin
  with qryListado do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_ec, centro_ec,  numero_entrada_ec, fecha_ec, producto_ec, peso_neto_ec, ');
    SQL.Add('        centro_salida_es, n_salida_es, fecha_salida_es, ');
    SQL.Add('        case when transito_es = 0 then ''SALIDA'' when transito_es = 1 then ''TRANSITO'' end transito_es, ');
    SQL.Add('        sum(kilos_es) kilos_linea_es, ');
    SQL.Add('        nvl( ( select sum(kilos_es) from frf_entradas_sal where empresa_ec = empresa_es and centro_ec = centro_entrada_es ');
    SQL.Add('                               and fecha_ec = fecha_entrada_es and numero_entrada_ec = n_entrada_es and producto_es = producto_ec ), 0) kilos_total_es ');


    SQL.Add(' from ( frf_entradas_c left join frf_entradas_sal on empresa_ec = empresa_es ');
    SQL.Add('                                          and centro_ec = centro_entrada_es ');
    SQL.Add('                                          and fecha_ec = fecha_entrada_es ');
    SQL.Add('                                          and numero_entrada_ec = n_entrada_es ');
    SQL.Add('                                          and producto_es = producto_ec) ');

    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and centro_ec = :centro ');
    SQL.Add(' and producto_ec = :producto ');
    SQL.Add(' and fecha_ec between :fecha_ini and :fecha_fin ');
      if ANumero <> '' then
        SQL.Add(' and numero_entrada_ec = :numero ');

    SQL.Add(' group by empresa_ec, centro_ec,  numero_entrada_ec, fecha_ec, producto_ec, peso_neto_ec, ');
    SQL.Add('          centro_salida_es, n_salida_es, fecha_salida_es, transito_es ');

    if ATipo = 1 then
    begin
      //Sin asignar
      //SQL.Add(' having sum( total_kgs_e2l) <> ');
      SQL.Add(' having peso_neto_ec <> ');
      SQL.Add('        nvl( ( select sum(kilos_es) from frf_entradas_sal where empresa_ec = empresa_es and centro_ec = centro_entrada_es ');
      SQL.Add('                               and fecha_ec = fecha_entrada_es and numero_entrada_ec = n_entrada_es and producto_es = producto_ec ), 0) ');
    end
    else
    if ATipo = 2 then
    begin
      //Asignadas
      //SQL.Add(' having sum( total_kgs_e2l) = ');     ç
      SQL.Add(' having peso_neto_ec = ');
      SQL.Add('        nvl( ( select sum(kilos_es) from frf_entradas_sal where empresa_ec = empresa_es and centro_ec = centro_entrada_es ');
      SQL.Add('                               and fecha_ec = fecha_entrada_es and numero_entrada_ec = n_entrada_es and producto_es = producto_ec ), 0) ');
    end;
    //En otro caso todas

    SQL.Add(' order by empresa_ec, centro_ec,  numero_entrada_ec, fecha_ec ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('fecha_ini').AsDate:= AFechaIni;
    ParamByName('fecha_fin').AsDate:= AFechaFin;
    if ANumero <> '' then
      ParamByName('numero').AsString:= ANumero;
    Open;
    Result:= not IsEmpty;
    if not Result then
      qryListado.Close;
  end;
end;

function  TDMEntradasSalidas.HaySalidasSinAsignar( const AEmpresa, ACentroOrigen, AProducto, ANumero: string;
                                     const AFechaIni, AFechaFin: TDateTime; const ATipo, ATipoSalida: integer ): Boolean;
begin
  with qryListado do
  begin
    SQL.Clear;
    if ( ATipoSalida = 0 ) or ( ATipoSalida = 1 ) then
    begin
      SQL.Add(' select empresa_sc empresa, centro_salida_sc centro_salida, n_albaran_sc n_salida, fecha_sc fecha_salida, ');
      SQL.Add('        ''SALIDA'' tipo_salida, cliente_sal_sc destino, dir_sum_sc plataforma,  producto_es producto, ');
      SQL.Add('        centro_entrada_es centro_entrada,  n_entrada_es n_entrada, fecha_entrada_es fecha_entrada, kilos_es kilos_linea_entrada, ');
      SQL.Add('        nvl( (select sum(kilos_sl) from frf_salidas_l where empresa_sc = empresa_sl ');
      SQL.Add('              and centro_salida_sl = centro_salida_sc and n_albaran_sl = n_albaran_sc ');
      SQL.Add('              and fecha_sl = fecha_sc and producto_sl = :producto ), 0) kilos_total_salida, ');
      SQL.Add('        nvl( ( select sum(kilos_es) from frf_entradas_sal where empresa_sc = empresa_es and centro_salida_sc = centro_salida_es ');
      SQL.Add('                               and fecha_sc = fecha_salida_es and n_albaran_sc = n_salida_es and producto_es = :producto and transito_es = 0 ), 0) kilos_total_entrada ');


      SQL.Add(' from ( frf_salidas_c left join frf_entradas_sal on empresa_sc = empresa_es ');
      SQL.Add('                                          and centro_salida_sc = centro_salida_es ');
      SQL.Add('                                          and fecha_sc = fecha_salida_es ');
      SQL.Add('                                          and n_albaran_sc = n_salida_es ');
      SQL.Add('                                          and producto_es = :producto) ');

      SQL.Add(' where empresa_sc = :empresa ');
      SQL.Add(' and centro_salida_sc = :centro ');
      SQL.Add(' and fecha_sc between :fechaini and :fechafin ');
      if ANumero <> '' then
        SQL.Add(' and n_albaran_sc = :numero ');
      SQL.Add(' and exists ');
      SQL.Add('  ( select * from frf_salidas_l where empresa_sc = empresa_sl ');
      SQL.Add('    and centro_salida_sl = centro_salida_sc and n_albaran_sl = n_albaran_sc ');
      SQL.Add('    and fecha_sl = fecha_sc and centro_origen_sl = centro_salida_sc ');
      SQL.Add('    and producto_sl = :producto ) ');

      if ATipo = 1 then
      begin
        //Sin asignar
        SQL.Add(' and nvl( (select sum(kilos_sl) from frf_salidas_l where empresa_sc = empresa_sl ');
        SQL.Add('           and centro_salida_sl = centro_salida_sc and n_albaran_sl = n_albaran_sc ');
        SQL.Add('              and fecha_sl = fecha_sc and producto_sl = :producto ), 0) <> ');
        SQL.Add('     nvl( ( select sum(kilos_es) from frf_entradas_sal where empresa_sc = empresa_es and centro_salida_sc = centro_salida_es ');
        SQL.Add('            and fecha_sc = fecha_salida_es and n_albaran_sc = n_salida_es and producto_es = :producto ), 0) ');
      end
      else
      if ATipo = 2 then
      begin
        //Asignadas
        SQL.Add(' and nvl( (select sum(kilos_sl) from frf_salidas_l where empresa_sc = empresa_sl ');
        SQL.Add('           and centro_salida_sl = centro_salida_sc and n_albaran_sl = n_albaran_sc ');
        SQL.Add('              and fecha_sl = fecha_sc and producto_sl = :producto ), 0) = ');
        SQL.Add('     nvl( ( select sum(kilos_es) from frf_entradas_sal where empresa_sc = empresa_es and centro_salida_sc = centro_salida_es ');
        SQL.Add('            and fecha_sc = fecha_salida_es and n_albaran_sc = n_salida_es and producto_es = :producto ), 0) ');
      end;
      //En otro caso todas


    end;
    if ( ATipoSalida = 0 ) then
    begin
      SQL.Add(' UNION ');
    end;

    if ( ATipoSalida = 0 ) or ( ATipoSalida = 2 ) then
    begin
      SQL.Add(' select empresa_tc empresa, centro_tc centro_salida, referencia_tc n_salida, fecha_tc fecha_salida, ');
      SQL.Add('        ''TRANSITO'' tipo_salida, centro_destino_tc destino, centro_destino_tc plataforma, producto_es producto, ');
      SQL.Add('        centro_entrada_es centro_entrada,  n_entrada_es n_entrada, fecha_entrada_es fecha_entrada, kilos_es kilos_linea_entrada, ');
      SQL.Add('        nvl( (select sum(kilos_tl) from frf_transitos_l where empresa_tc = empresa_tl ');
      SQL.Add('              and centro_tl = centro_tc and referencia_tl = referencia_tc ');
      SQL.Add('              and fecha_tl = fecha_tc and producto_tl = :producto ), 0) kilos_total_salida, ');
      SQL.Add('        nvl( ( select sum(kilos_es) from frf_entradas_sal where empresa_tc = empresa_es and centro_tc = centro_salida_es and ');
      SQL.Add('               fecha_tc = fecha_salida_es and referencia_tc = n_salida_es and producto_es = :producto and transito_es = 1 ), 0) kilos_total_entrada ');

      SQL.Add(' from ( frf_transitos_c left join frf_entradas_sal on empresa_tc = empresa_es ');
      SQL.Add('                                          and centro_tc = centro_salida_es ');
      SQL.Add('                                          and fecha_tc = fecha_salida_es ');
      SQL.Add('                                          and referencia_tc = n_salida_es ');
      SQL.Add('                                          and producto_es = :producto) ');

      SQL.Add(' where empresa_tc = :empresa ');
      SQL.Add(' and centro_tc = :centro ');
      SQL.Add(' and fecha_tc between :fechaini and :fechafin ');
      if ANumero <> '' then
        SQL.Add(' and referencia_tc = :numero ');
      SQL.Add(' and exists ');
      SQL.Add('  ( select * from frf_transitos_l where empresa_tc = empresa_tl ');
      SQL.Add('    and centro_tl = centro_tc and referencia_tl = referencia_tc ');
      SQL.Add('    and fecha_tl = fecha_tc and centro_origen_tl = centro_tc ');
      SQL.Add('    and producto_tl = :producto ) ');

      if ATipo = 1 then
      begin
        //Sin asignar
      SQL.Add(' and nvl( (select sum(kilos_tl) from frf_transitos_l where empresa_tc = empresa_tl ');
      SQL.Add('           and centro_tl = centro_tc and referencia_tl = referencia_tc ');
      SQL.Add('              and fecha_tl = fecha_tc and producto_tl = :producto ), 0) <> ');
      SQL.Add('     nvl( ( select sum(kilos_es) from frf_entradas_sal where empresa_tc = empresa_es and centro_tc = centro_salida_es ');
      SQL.Add('            and fecha_tc = fecha_salida_es and referencia_tc = n_salida_es and producto_es = :producto ), 0) ');
      end
      else
      if ATipo = 2 then
      begin
        //Asignadas
      SQL.Add(' and nvl( (select sum(kilos_tl) from frf_transitos_l where empresa_tc = empresa_tl ');
      SQL.Add('           and centro_tl = centro_tc and referencia_tl = referencia_tc ');
      SQL.Add('              and fecha_tl = fecha_tc and producto_tl = :producto ), 0) = ');
      SQL.Add('     nvl( ( select sum(kilos_es) from frf_entradas_sal where empresa_tc = empresa_es and centro_tc = centro_salida_es ');
      SQL.Add('            and fecha_tc = fecha_salida_es and referencia_tc = n_salida_es and producto_es = :producto ), 0) ');
      end;
      //En otro caso todas

    end;
    SQL.Add(' order by empresa, centro_salida, fecha_salida, n_salida,  centro_entrada, fecha_entrada, n_entrada  ');


    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentroOrigen;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('fechaini').AsDate:= AFechaIni;
    ParamByName('fechafin').AsDate:= AFechaFin;
    if ANumero <> '' then
      ParamByName('numero').AsString:= ANumero;
    Open;
    Result:= not IsEmpty;
    if not Result then
      qryListado.Close;
  end;
end;


function EnviarSalidasAsignadas( const AOwner: TComponent; const AEmpresa, ACentro: string;
                               const AFecha: TDateTime; const AEntrada: Integer ): Boolean;
var
  DMEntradasSalidas: TDMEntradasSalidas;
begin
  result:= False;

  DMEntradasSalidas:= TDMEntradasSalidas.Create(AOwner);
  try
    if DMEntradasSalidas.EstaEntradaAsignada( AEmpresa, ACentro, AFecha, AEntrada  ) then
    begin
      result:= DMEntradasSalidas.EnviarEntradaSalidas( AEmpresa, ACentro, AFecha, AEntrada );
    end
    else
    begin
      ShowMessage('Faltan kilos por asignar.');
    end;
  finally
    FreeAndNil( DMEntradasSalidas );
  end;
end;

function BorrarSalidaAsignada( const AOwner: TComponent;
                          const AEmpresa, ACentroEntrada: string;
                          const AFechaEntrada: TDateTime;
                          const AEntrada: Integer;
                          const ACentroSalida: string;
                          const AFechaSalida: TDateTime;
                          const ASalida, ATransito: Integer;
                          const AProducto: string;
                          const AKilos: real ): boolean;
var
  DMEntradasSalidas: TDMEntradasSalidas;
begin
  DMEntradasSalidas:= TDMEntradasSalidas.Create(AOwner);
  try
    result:= DMEntradasSalidas.BorrarSalidaAsignada( AEmpresa, ACentroEntrada, AFechaEntrada, AEntrada, ACentroSalida,
                                        AFechaSalida, ASalida, ATransito, AProducto, AKilos );
    if not result then
    begin
      ShowMessage('ERROR al borrar la linea.');
    end;
  finally
    FreeAndNil( DMEntradasSalidas );
  end;
end;

procedure InsertarSalidaAsignada( const AOwner: TComponent;
                          const AEmpresa, ACentroEntrada: string;
                          const AFechaEntrada: TDateTime;
                          const AEntrada: Integer;
                          const ACentroSalida: string;
                          const AFechaSalida: TDateTime;
                          const ASalida: Integer;
                          const AProducto, ATipo: string;
                          const AKilos: real );
var
  DMEntradasSalidas: TDMEntradasSalidas;
begin
  DMEntradasSalidas:= TDMEntradasSalidas.Create(AOwner);
  try
    DMEntradasSalidas.InsertarSalidaAsignada( AEmpresa, ACentroEntrada, AFechaEntrada, AEntrada, ACentroSalida,
                                        AFechaSalida, ASalida, AProducto, ATipo, AKilos );
  finally
    FreeAndNil( DMEntradasSalidas );
  end;
end;

function ValorarEntrada( const AOwner: TComponent; const AEmpresa, ACentro: string; const AFecha: TDateTime;
                             const AEntrada: Integer; const ADefinitivo, ACosteAnteriores: boolean ): boolean;
var
  DMEntradasSalidas: TDMEntradasSalidas;
begin
  DMEntradasSalidas:= TDMEntradasSalidas.Create(AOwner);
  try
    Result:= DMEntradasSalidas.ValorarEntrada( AEmpresa, ACentro, AFecha, AEntrada, ADefinitivo, ACosteAnteriores );
  finally
    DMEntradasSalidas.VerError( True );
    FreeAndNil( DMEntradasSalidas );
  end;
end;

function ValorarEntradaEx( const AEmpresa, ACentro: string; const AFecha: TDateTime;
                           const AEntrada: Integer; const ADefinitivo: boolean; var VMsg: string ): boolean;
var
  DMEntradasSalidas: TDMEntradasSalidas;
  ACosteAnteriores: Boolean;
begin
  ACosteAnteriores:= True;

  Application.CreateForm( TDMEntradasSalidas, DMEntradasSalidas );
  try
    DMEntradasSalidas.ValorarEntrada( AEmpresa, ACentro, AFecha, AEntrada, ADefinitivo, ACosteAnteriores );
    Result:= not DMEntradasSalidas.bError;
    VMsg:= DMEntradasSalidas.GetError;
  finally
    FreeAndNil( DMEntradasSalidas );
  end;
end;

end.
