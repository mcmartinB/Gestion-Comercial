unit UActualizar;

interface

procedure Actualizar;

implementation
 (*ACTUALIZAR*)

uses
  IniFiles, SysUtils, Windows;

procedure Actualizar;
var
  sDirActual, sDirActualiza: string;
begin
  sDirActual := ExtractFilePath(ParamStr(0));
  sDirActualiza:= '\\nas093\informatica\Comercializacion\Updates\';

  //MIDAS
  if not FileExists( sDirActual + 'midas.dll' ) then
  begin
    if FileExists( sDirActualiza + 'midas.dll' ) then
      try
        CopyFile( Pchar( sDirActualiza + 'midas.dll' ), Pchar( sDirActual + 'midas.dll' ), True );
      except
        //
      end;
  end;

  if not FileExists( 'c:\comercializacion\midas.dll' ) then
  begin
    if FileExists( sDirActualiza + 'midas.dll' ) then
      try
       CopyFile( Pchar( sDirActualiza + 'midas.dll' ), Pchar( 'c:\comercializacion\midas.dll' ), True );
      except
        //
      end;
  end;

  //Plantilla BAG
  if not FileExists( sDirActual + 'recursos\BAGpage.wmf' ) then
  begin
    if FileExists( sDirActualiza + 'BAGpage.wmf' ) then
      try
        CopyFile( Pchar( sDirActualiza + 'BAGpage.wmf' ), Pchar( sDirActual + 'recursos\BAGpage.wmf' ), True );
      except
        //
      end;
  end;
end;


end.
