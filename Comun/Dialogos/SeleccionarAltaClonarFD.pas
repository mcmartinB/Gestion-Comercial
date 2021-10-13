unit SeleccionarAltaClonarFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFDSeleccionarAltaClonar = class(TForm)
    btnOk: TButton;
    rbNuevo: TRadioButton;
    rbImportar: TRadioButton;
    btnCancelar: TButton;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

function SeleccionarTipoAlta( const AOwner: TComponent; var VTipo: integer;
                              const ATitle: string = '     SELECCIONAR TIPO ALTA'; const ATextLocal: string = 'Nuevo' ): integer;

implementation

{$R *.dfm}

uses
  CGlobal;

var
  FDSeleccionarTipoAlta: TFDSeleccionarAltaClonar;

function SeleccionarTipoAlta( const AOwner: TComponent; var VTipo: integer;
                              const ATitle: string = '     SELECCIONAR TIPO ALTA'; const ATextLocal: string = 'Nuevo' ): integer;
begin
  FDSeleccionarTipoAlta:= TFDSeleccionarAltaClonar.Create( AOwner );
  try
    FDSeleccionarTipoAlta.Caption:= ATitle;
    FDSeleccionarTipoAlta.rbNuevo.Caption:= ATextLocal;
    result:= FDSeleccionarTipoAlta.ShowModal;
    if FDSeleccionarTipoAlta.rbNuevo.checked then
      VTipo:= 0
    else
      VTipo:= 1;
  finally
    FreeAndNil( FDSeleccionarTipoAlta );
  end;
end;

procedure TFDSeleccionarAltaClonar.btnOkClick(Sender: TObject);
begin
  ModalResult:= mrOk;
end;

procedure TFDSeleccionarAltaClonar.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;


procedure TFDSeleccionarAltaClonar.FormCreate(Sender: TObject);
begin
  rbNuevo.Checked:= True;
end;

end.
