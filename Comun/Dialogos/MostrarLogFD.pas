unit MostrarLogFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFDMostrarLog = class(TForm)
    mmoLog: TMemo;
    btnExit: TButton;
    procedure btnExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure MostrarLog( const AOwner: TComponent; const AMessage: string;
                        const ATitle: string = '  MOSTRAR LOG'  );

implementation

{$R *.dfm}

var
  FDMostrarLog: TFDMostrarLog;

procedure MostrarLog( const AOwner: TComponent; const AMessage: string;
                      const ATitle: string = '  MOSTRAR LOG'  );
begin
  FDMostrarLog:= TFDMostrarLog.Create( AOwner );
  try
    FDMostrarLog.Caption:= ATitle;
    FDMostrarLog.mmoLog.Clear;
    FDMostrarLog.mmoLog.Lines.Add( AMessage );
    FDMostrarLog.ShowModal;
  finally
    FreeAndNil( FDMostrarLog );
  end;
end;

procedure TFDMostrarLog.btnExitClick(Sender: TObject);
begin
  ModalResult:= mrOk;
end;

end.
