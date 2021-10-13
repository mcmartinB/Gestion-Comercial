unit CBancos;

interface

(* CCC *)
function FomateaCCC( const ACCC: string ): string;
function CCCCalculaDC(const ABancoSucursal, ACuenta: string):integer;
function CCCValida( const ACuenta: string; const AComprobarDigitoControl: Boolean = True  ): boolean;


(* IBAN *)
function FomateaIBAN( const AIBAN: string ): string;
function IBANValido( const AIBAN: string; const AComprobarDigitoControl: Boolean = True  ): boolean;
function DigitosControlMOD97_10( const ACodigo: string ): string;

(* CCC/IBAN *)
function IbanToCcc( const AIban: string ): string;

(* VARIOS *)
function IdentificadorAT_02 ( const ACodPais, ACodigo, ASufijo: string ): string;

implementation

uses
  SysUtils;

function FomateaCCC( const ACCC: string ): string;
begin
  Result:= Copy( ACCC, 1, 4 ) + ' ' +
           Copy( ACCC, 5, 4 ) + ' ' +
           Copy( ACCC, 9, 2 ) + ' ' +
           Copy( ACCC, 11, 10 );
end;

function CCCCalculaDC(const ABancoSucursal, ACuenta: string):integer;
const
  Pesos: array[0..9] of integer=(6,3,7,9,10,5,8,4,2,1);
var
  n      : byte;
  iTemp  : integer;
begin
  iTemp:=0;
  for n := 0 to 7 do
  begin
    iTemp := iTemp + StrToInt(Copy(ABancoSucursal, 8 - n, 1)) * Pesos[n];
  end;
  Result:=11 - iTemp Mod 11;
  if (Result > 9) then
    Result:=1-Result mod 10;
  iTemp:=0;
  For n := 0 to 9 do
  begin
    iTemp := iTemp + StrToInt(Copy(ACuenta, 10 - n, 1)) * Pesos[n];
  end;
  iTemp:=11 - iTemp mod 11;
  if (iTemp > 9) then
    iTemp:=1-iTemp mod 10;

  Result:=Result*10+iTemp;
end;

function  CCCValida( const ACuenta: string; const AComprobarDigitoControl: Boolean = True  ): boolean;
begin
  if Trim( ACuenta ) = '' then
    result:= False
  else
  begin
    if Length( Trim(ACuenta) ) = 20 then
    begin
      if AComprobarDigitoControl then
        Result:= CCCCalculaDC( Copy( ACuenta,1,8), Copy( ACuenta,11,10) ) = StrToIntDef( Copy( ACuenta,9,2), -1 )
      else
        Result:= True;
    end
    else
    begin
      Result:= False;
    end;
  end;

end;

function FomateaIBAN( const AIBAN: string ): string;
begin
  Result:= Trim( Copy( AIBAN, 1, 4 ) + ' ' +
                 Copy( AIBAN, 5, 4 ) + ' ' +
                 Copy( AIBAN, 9, 4 ) + ' ' +
                 Copy( AIBAN, 13, 4 ) + ' ' +
                 Copy( AIBAN, 17, 4 ) + ' ' +
                 Copy( AIBAN, 21, 4 ) + ' ' +
                 Copy( AIBAN, 25, 4 ) + ' ' +
                 Copy( AIBAN, 29, 4 ) );
end;

function TablaLetras(const Str: String ): string;
begin
  case Str[1] of
    'A': result:= '10';
    'B': result:= '11';
    'C': result:= '12';
    'D': result:= '13';
    'E': result:= '14';
    'F': result:= '15';
    'G': result:= '16';
    'H': result:= '17';
    'I': result:= '18';
    'J': result:= '19';
    'K': result:= '20';
    'L': result:= '21';
    'M': result:= '22';
    'N': result:= '23';
    'O': result:= '24';
    'P': result:= '25';
    'Q': result:= '26';
    'R': result:= '27';
    'S': result:= '28';
    'T': result:= '29';
    'U': result:= '30';
    'V': result:= '31';
    'W': result:= '32';
    'X': result:= '33';
    'Y': result:= '34';
    'Z': result:= '35';
  end;
end;

function QuitarCaracteres(const Str: String): String;
var
  i: Integer;
  sAux: string;
begin
  Result:= EmptyStr;
  sAux:= UpperCase( Str );
  for i:= 1 to Length(sAux) do
    if ( ( sAux[i] >= '0' ) and  ( sAux[i] <= '9' ) ) then
      Result:= Result + sAux[i]
    else
    if ( ( sAux[i] >= 'A' ) and  ( sAux[i] <= 'Z' ) ) then
      Result:= Result + TablaLetras( sAux[i] );
end;

function EliminarCerosIzq( const ACodigo: string ): string;
var
  i: Integer;
  sAux: string;
  bFlag: Boolean;
begin
  Result:= EmptyStr;
  sAux:= UpperCase( ACodigo );
  bFlag:= False;
  for i:= 1 to Length(sAux) do
  begin
    if bFlag then
    begin
      Result:= Result + sAux[i];
    end
    else
    begin
      if ( sAux[i] <> '0' )  then
      begin
        bFlag:= True;
        Result:= Result + sAux[i]
      end;
    end;
  end;
end;

function MOD97_10_parcial( const ACodigo: string ): string;
var
  i: Integer;
begin
  i:= StrToInt( ACodigo ) mod 97;
  if i < 10 then
    result:= '0' + IntToStr( i )
  else
    result:= IntToStr( i );
end;

function MOD97_10( const ACodigo: string ): string;
var
  iAux: Integer;
  sCode: string;
begin
  sCode:= EliminarCerosIzq( ACodigo );
  iAux:= Length( sCode );
  if iAux > 9 then
  begin
    iAux:= iAux - 9;
    Result:= MOD97_10_parcial( Copy( sCode, 1, 9 ) );
    Result:= MOD97_10( Result + Copy( sCode, 10, iAux ) );
  end
  else
  begin
    Result:= MOD97_10_parcial( sCode );
  end;
end;


function IBANValido( const AIBAN: string; const AComprobarDigitoControl: Boolean = True  ): boolean;
var
  sAux: string;
begin
  if AComprobarDigitoControl then
  begin
    sAux:= Trim( AIBAN );
    sAux:= Copy( sAux, 5, Length( sAux ) - 4 ) + Copy( sAux, 1, 4 );
    sAux:= QuitarCaracteres( sAux );
    sAux:= MOD97_10( sAux );
    Result:= sAux = '01';
  end
  else
  begin
    Result:= True;
  end;
end;


function DigitosControlMOD97_10( const ACodigo: string ): string;
var
  iAux: Integer;
begin
  result:= QuitarCaracteres( ACodigo );
  iAux:= 98 -  ( StrToInt( MOD97_10( result ) ) );
  if iAux < 9 then
    result:= '0' + IntToStr( iAux )
  else
    result:= IntToStr( iAux );
end;

function IdentificadorAT_02 ( const ACodPais, ACodigo, ASufijo: string ): string;
var
  sAux: string;
begin
  sAux:= DigitosControlMOD97_10( QuitarCaracteres( ACodigo + ACodPais + '00' ) );
  Result:= ACodPais +  sAux + ASufijo + Trim( ACodigo );
end;


function IbanToCcc( const AIban: string ): string;
begin
  result:= Copy( AIban, 5, 20 );
end;

end.
