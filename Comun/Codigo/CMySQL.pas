unit CMySQL;

interface

function MySqlNullParam( const ASQL, AParam, AValue: string): string;
function MySqlSParam( const ASQL, AParam, AValue: string): string;
function MySqlDParam( const ASQL, AParam: string; const AValue: TDateTime): string;
function MySqlIParam( const ASQL, AParam: string; const AValue: Integer ): string;
function MySqlFParam( const ASQL, AParam: string; const AValue: Real ): string;

implementation

uses
  SysUtils;

function MySqlNullParam( const ASQL, AParam, AValue: string): string;
begin
  result:= StringReplace( ASQL, AParam, 'NULL', [] );
end;

function MySqlSParam( const ASQL, AParam, AValue: string): string;
begin
  result:= StringReplace( ASQL, AParam, QuotedStr(AValue), [] );
end;

function MySqlDParam( const ASQL, AParam: string; const AValue: TDateTime): string;
begin
  result:= StringReplace( ASQL, AParam, ' STR_TO_DATE( ' + QuotedStr( FormatDateTime('dd-mm-yyyy', AValue ) ) + ', ''%d-%m-%Y'' ) ', [] );
end;

function MySqlIParam( const ASQL, AParam: string; const AValue: Integer ): string;
begin
  result:= StringReplace( ASQL, AParam, QuotedStr( IntToStr( AValue ) ), [] );
end;

function MySqlFParam( const ASQL, AParam: string; const AValue: Real ): string;
begin
  result:= StringReplace( ASQL, AParam, QuotedStr( StringReplace(  FloatToStr( AValue ), ',', '.', [] )  ), [] );
end;

end.
