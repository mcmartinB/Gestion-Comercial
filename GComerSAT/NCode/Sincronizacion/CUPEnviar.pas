unit CUPEnviar;

interface

uses Classes, SysUtils, DB, ComCtrls, Forms;


implementation

Type
  RSincroResumen = record
    titulo, usuario, hora: String;
    registros, pasados, erroneos, duplicados: integer;
    msgPasados, msgErrores, msgDuplicados: TStringList;
  end;

procedure InicializarResumenSincronizar( var ASincroResumen: RSincroResumen );
begin
  ASincroResumen.registros:= 0;
  ASincroResumen.pasados:= 0;
  ASincroResumen.erroneos:= 0;
  ASincroResumen.duplicados:= 0;
  ASincroResumen.msgPasados:= TStringList.Create;
  ASincroResumen.msgErrores:= TStringList.Create;
  ASincroResumen.msgDuplicados:= TStringList.Create;
end;

procedure LiberarResumenSincronizar( var ASincroResumen: RSincroResumen );
begin
  if ASincroResumen.msgPasados <> nil then
    FreeAndNil( ASincroResumen.msgPasados );
  if ASincroResumen.msgErrores <> nil then
    FreeAndNil( ASincroResumen.msgErrores );
  if ASincroResumen.msgDuplicados <> nil then
    FreeAndNil( ASincroResumen.msgDuplicados );
end;

procedure CopiarResumen( var ADestino: RSincroResumen; const AOrigen: RSincroResumen );
begin
  ADestino.registros:= AOrigen.registros;
  ADestino.pasados:= AOrigen.pasados;
  ADestino.erroneos:= AOrigen.erroneos;
  ADestino.duplicados:= AOrigen.duplicados;
  ADestino.msgPasados.AddStrings( AOrigen.msgPasados );
  ADestino.msgErrores.AddStrings( AOrigen.msgErrores );
  ADestino.msgDuplicados.AddStrings( AOrigen.msgDuplicados );
end;

end.
