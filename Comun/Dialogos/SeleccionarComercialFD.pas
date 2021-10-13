unit SeleccionarComercialFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, BGrid, Buttons,
  BSpeedButton, BGridButton, BEdit, BDEdit;

type
  TFDSeleccionarComercial = class(TForm)
    btnOk: TButton;
    btnCancelar: TButton;
    lblComercial: TLabel;
    edtcomercial_sl: TBDEdit;
    btnComercial: TBGridButton;
    txtDesComercial: TStaticText;
    RejillaFlotante: TBGrid;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnComercialClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtcomercial_slChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function SeleccionarComercial( var AResult: string; const ATitle: string = '     SELECCIONAR COMERCIAL' ): integer;

implementation

{$R *.dfm}

uses
  CGlobal, UDMMaster, CVariables, UDMAuxDB, CAuxiliarDB;

var
  FDSeleccionarComercial: TFDSeleccionarComercial;

function SeleccionarComercial( var AResult: string; const ATitle: string = '     SELECCIONAR COMERCIAL' ): integer;
begin
  Application.CreateForm(TFDSeleccionarComercial, FDSeleccionarComercial);
  try
    FDSeleccionarComercial.Caption:= ATitle;
    FDSeleccionarComercial.edtcomercial_sl.Text:= AResult;
    result:= FDSeleccionarComercial.ShowModal;
    AResult:= FDSeleccionarComercial.edtcomercial_sl.Text;
  finally
    FreeAndNil( FDSeleccionarComercial );
  end;
end;

procedure TFDSeleccionarComercial.btnOkClick(Sender: TObject);
begin
  if txtDesComercial.Caption <> '' then
    ModalResult:= mrOk
  else
    ShowMessage('Falta el codigo del comercial o es incorecto.');
end;

procedure TFDSeleccionarComercial.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;


procedure TFDSeleccionarComercial.btnComercialClick(Sender: TObject);
begin
  DespliegaRejilla(btnComercial, ['']);
end;

procedure TFDSeleccionarComercial.FormCreate(Sender: TObject);
begin
  edtcomercial_sl.tag:= kComercial;
end;

procedure TFDSeleccionarComercial.edtcomercial_slChange(Sender: TObject);
begin
  txtDesComercial.Caption:= desComercial( edtcomercial_sl.Text );
end;

end.
