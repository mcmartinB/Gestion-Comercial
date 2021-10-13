unit FichaListadoFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFDFichaListado = class(TForm)
    lblImprimir: TLabel;
    btnFicha: TButton;
    btnListado: TButton;
    btnCancelar: TButton;
    chkVerClientes: TCheckBox;
    procedure btnFichaClick(Sender: TObject);
    procedure btnListadoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function FichaOrListado( const AOwner: TComponent ): Integer;

implementation

{$R *.dfm}

function FichaOrListado( const AOwner: TComponent ): Integer;
var
  FDFichaListado: TFDFichaListado;
begin
  FDFichaListado:= TFDFichaListado.Create( AOwner );
  try
    Result:= FDFichaListado.ShowModal;
  finally
    FreeAndNil( FDFichaListado );
  end;
end;

procedure TFDFichaListado.btnFichaClick(Sender: TObject);
begin
  ModalResult:= 1;
end;

procedure TFDFichaListado.btnListadoClick(Sender: TObject);
begin
  if chkVerClientes.Checked then
    ModalResult:= 3  
  else
    ModalResult:= 2;
end;

procedure TFDFichaListado.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= -1;
end;

end.
