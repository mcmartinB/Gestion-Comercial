unit USincronizarTablas;

interface

uses
   DB, Variants, SysUtils;

function  SincronizarRegistro( const AFuente, ADestino: TDataSet; var VLog: string; const ATable: string = ''  ) : integer;
function  SincronizarRegistroArtDesglosados( const AFuente, ADestino: TDataSet; var VLog: string; const ATable: string = '' ) : Integer;
procedure ClonarRegistro( const AFuente, ADestino: TDataSet  );

implementation

//-1 -> error
// 0 -> no es necesario hacer nada
// 1 -> alta
// 2 -> modificacion
function  SincronizarRegistro( const AFuente, ADestino: TDataSet; var VLog: string; const ATable: string = ''  ) : integer;
var
  i: integer;
  campo: TField;
  bAlta, bModificado : Boolean;
  sLog: string;
begin
  bAlta:= ADestino.IsEmpty;
  bModificado:= False;
  sLog:= #13 + #10;

  if bAlta then
    ADestino.Insert
  else
    ADestino.Edit;

  i:= 0;
  while i < ADestino.Fields.Count do
  begin
    campo:= AFuente.FindField(ADestino.Fields[i].FieldName);
    if campo <> nil then
    begin
      if bAlta then
      begin
        ADestino.Fields[i].Value:= campo.Value;
        if ADestino.Fields[i].Value <> null then
        begin
          sLog:= sLog + '    ' + UpperCase( ADestino.Fields[i].FieldName ) + '= ' + campo.AsString + #13 + #10
        end;
      end
    else
      begin
        if ADestino.Fields[i].Value <> campo.Value then
        begin
          sLog:= sLog + '    ' +  UpperCase( ADestino.Fields[i].FieldName ) + ': ' + ADestino.Fields[i].AsString + ' -> ' + campo.AsString + #13 + #10;
          bModificado:= True;
          ADestino.Fields[i].Value:= campo.Value;
        end;
      end;
    end;
    inc( i );
  end;

  try
    if bAlta or bModificado then
    begin
      ADestino.Post;
      if bAlta then
      begin
        VLog:= VLog + #13 + #10 + '+ INSERTADO NUEVO REGISTRO [' + ATable + ']:'   + #13 + #10 + sLog;
        Result:= 1;
      end
      else
      if bModificado then
      begin
        VLog:= VLog + #13 + #10 + '* MODIFICADO REGISTRO EXISTENTE [' + ATable + ']:'  + #13 + #10 + sLog;
        Result:= 2;
      end
    end
    else
    begin
      VLog:= VLog + #13 + #10 + '= REGISTRO SIN CAMBIOS [' + ATable + ']' + #13 + #10;
      ADestino.Cancel;
      Result:= 0;
    end;
  except
    on E: Exception do
    begin
      VLog:= VLog + #13 + #10 + '= ERROR AL SINCRONIZAR [' + ATable + ']' + #13 + #10;
      VLog:= VLog + e.Message + #13 + #10;
      ADestino.Cancel;
      Result:= -1;
    end;
  end;
end;


function  SincronizarRegistroArtDesglosados( const AFuente, ADestino: TDataSet; var VLog: string; const ATable: string = ''  ) : integer;
var
  i: integer;
  campo: TField;
  sLog: string;
begin
  sLog:= #13 + #10;

  ADestino.Insert;

  i:= 0;
  while i < ADestino.Fields.Count do
  begin
    campo:= AFuente.FindField(ADestino.Fields[i].FieldName);
    if campo <> nil then
      begin
        ADestino.Fields[i].Value:= campo.Value;
        if ADestino.Fields[i].Value <> null then
        begin
          sLog:= sLog + '    ' + UpperCase( ADestino.Fields[i].FieldName ) + ' => ' + campo.AsString + #13 + #10
        end;
      end;
    inc( i );
  end;

  try
      ADestino.Post;
      VLog:= VLog + #13 + #10 + '+ CAMBIOS APLICADOS CORRECTAMENTE [' + ATable + ']:'   + #13 + #10 + sLog;
      Result:= 1;
  except
    on E: Exception do
    begin
      VLog:= VLog + #13 + #10 + '= ERROR AL SINCRONIZAR [' + ATable + ']' + #13 + #10;
      VLog:= VLog + e.Message + #13 + #10;
      ADestino.Cancel;
      Result:= -1;
    end;
  end;
end;

procedure  ClonarRegistro( const AFuente, ADestino: TDataSet  );
var
  i: integer;
  campo: TField;
begin
  ADestino.Insert;
  i:= 0;
  while i < ADestino.Fields.Count do
  begin
    campo:= AFuente.FindField(ADestino.Fields[i].FieldName);
    if campo <> nil then
    begin
      ADestino.Fields[i].Value:= campo.Value;
    end;
    inc( i );
  end;
end;
end.
