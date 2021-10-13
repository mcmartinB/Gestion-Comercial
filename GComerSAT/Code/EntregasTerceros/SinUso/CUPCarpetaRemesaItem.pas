unit CUPCarpetaRemesaItem;

interface

procedure CrearSenyal( const AEmpresa, ARemesa, AFecha: string );

implementation

uses
  Classes, SysUtils;

procedure CrearSenyal( const AEmpresa, ARemesa, AFecha: string );
var
  sFich: TStringList;
  iAnyo, iMes, iDia: word;
begin
  Exit;
  
  if AEmpresa = '037' then
  begin
    DecodeDate( StrToDateDef( AFecha, Date ), iAnyo, iMes, iDia );
    sFich:= TStringList.Create;
    sFich.Add( 'REMESAS' );
    sFich.Add( ARemesa );
    sFich.Add( IntToStr( iAnyo ) );
    sFich.Add( 'MDS' );
    try
      try
        sFich.SaveToFile( '\\192.168.1.125\itemdoc$\gencar\' + ARemesa + '.txt' );
      except
        //Si no podemos grabar no hacemos nada
      end;
    finally
      FreeAndNil( sFich );
    end;
  end;
end;

end.
