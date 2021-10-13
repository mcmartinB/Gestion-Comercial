unit SeleccionarAgrupacionFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, BGrid, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit;

type
  TFDSeleccionarAgrupacion = class(TForm)
    lblempresa: TLabel;
    edtAgrupacion: TBEdit;
    btnAgrupacion: TBGridButton;
    RejillaFlotante: TBGrid;
    btnCancelar: TButton;
    btnOk: TButton;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAgrupacionClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function SeleccionarAgrupacion( var AAgrupacion: string;  ATitle: string = '     SELECCIONAR AGRUPACION' ): boolean;


implementation

{$R *.dfm}

uses
  UDMAuxDB, CAuxiliarDB, UDMBaseDatos, CVariables;

var
  FDSeleccionarAgrupacion: TFDSeleccionarAgrupacion;

function  SeleccionarAgrupacion( var AAgrupacion: string;  ATitle: string = '     SELECCIONAR AGRUPACION' ): boolean;
begin
  Application.CreateForm(TFDSeleccionarAgrupacion, FDSeleccionarAgrupacion);
  try
    FDSeleccionarAgrupacion.Caption:= ATitle;
    FDSeleccionarAgrupacion.edtAgrupacion.Text:= AAgrupacion;
    result:= ( FDSeleccionarAgrupacion.ShowModal = mrOk );
    AAgrupacion:= FDSeleccionarAgrupacion.edtAgrupacion.Text;
  finally
    FreeAndNil( FDSeleccionarAgrupacion );
  end;
end;

procedure TFDSeleccionarAgrupacion.btnOkClick(Sender: TObject);
begin
  if edtAgrupacion.Text <> '' then
    ModalResult:= mrOk
  else
    ShowMessage('Falta el codigo de la agrupación.');
end;

procedure TFDSeleccionarAgrupacion.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TFDSeleccionarAgrupacion.FormCreate(Sender: TObject);
begin
  edtAgrupacion.tag:= kAgrupacionEnvase;
end;

procedure TFDSeleccionarAgrupacion.btnAgrupacionClick(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  DespliegaRejilla(btnAgrupacion, ['']);
end;

end.
