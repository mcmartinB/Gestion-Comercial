unit SeleccionarFechaFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TFDSeleccionarFecha = class(TForm)
    btnOk: TButton;
    btnCancelar: TButton;
    dtpFecha: TDateTimePicker;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

function SeleccionarFecha( const AOwner: TComponent; var VFecha: TDateTime ): boolean;

implementation

{$R *.dfm}

uses
  CGlobal;

var
  FDSeleccionarFecha: TFDSeleccionarFecha;

function SeleccionarFecha( const AOwner: TComponent; var VFecha: TDateTime ): boolean;
begin
  FDSeleccionarFecha:= TFDSeleccionarFecha.Create( AOwner );
  try
    FDSeleccionarFecha.dtpFecha.DateTime:= VFecha;
    result:= FDSeleccionarFecha.ShowModal = mrOk;
    if result then
      VFecha:= FDSeleccionarFecha.dtpFecha.DateTime;
  finally
    FreeAndNil( FDSeleccionarFecha );
  end;
end;

procedure TFDSeleccionarFecha.btnOkClick(Sender: TObject);
var
  dFecha: TDateTime;
begin
  ModalResult:= mrOk;
end;

procedure TFDSeleccionarFecha.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;


end.
