unit AdvertenciaFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFDAdvertencia = class(TForm)
    mmoMsg: TMemo;
    chkIgnorarErrores: TCheckBox;
    btnAceptar: TButton;
    btnIgnorar: TButton;
    procedure chkIgnorarErroresClick(Sender: TObject);
    procedure btnIgnorarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function VerAdvertencia( const AOwner: TComponent; const AMessage: string;
                         const ATitle: string = '  ADVERTENCIA';
                         const ACheck: string = 'Confirmo que no hay errores';
                         const AButton: string = 'Ignorar Advertencia'  ): integer;


implementation

{$R *.dfm}

function VerAdvertencia( const AOwner: TComponent; const AMessage: string;
                         const ATitle: string = '  ADVERTENCIA';
                         const ACheck: string = 'Confirmo que no hay errores';
                         const AButton: string = 'Ignorar Advertencia'  ): integer;
var
  FDAdvertencia: TFDAdvertencia;
begin
  FDAdvertencia:= TFDAdvertencia.Create( AOwner );
  try
    FDAdvertencia.mmoMsg.Lines.Clear;
    FDAdvertencia.mmoMsg.Lines.Add( AMessage );
    FDAdvertencia.Caption:= ATitle;
    FDAdvertencia.chkIgnorarErrores.Caption:= ACheck;
    FDAdvertencia.btnIgnorar.Caption:= AButton;
    result:= FDAdvertencia.ShowModal;
  finally
    FreeAndNil( FDAdvertencia );
  end;
end;

procedure TFDAdvertencia.chkIgnorarErroresClick(Sender: TObject);
begin
  btnIgnorar.Enabled:= chkIgnorarErrores.Checked;
end;

procedure TFDAdvertencia.btnIgnorarClick(Sender: TObject);
begin
  ModalResult:= mrIgnore;
end;

procedure TFDAdvertencia.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOk;
end;

end.
