unit CUAMenuUtils;

interface

uses Forms, Classes, Windows;

procedure CrearVentana( const AForm: TForm; Tipo: TComponentClass );

implementation

procedure CrearVentana( const AForm: TForm; Tipo: TComponentClass );
var
  i: Integer;
begin
  for i := AForm.MDIChildCount - 1 downto 0 do
  begin
    if AForm.MDIChildren[i].ClassType = Tipo then
    begin
      AForm.MDIChildren[i].Show;
      Exit;
    end;
  end;

  //Para que los form maximizados aparezcan desde el inicio maximizados
  LockWindowUpdate(AForm.Handle);
  try
    Tipo.Create(Application);
  finally
    LockWindowUpdate(0);
  end;
end;

end.
