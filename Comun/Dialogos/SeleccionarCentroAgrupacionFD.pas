unit SeleccionarCentroAgrupacionFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, BGrid, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit;

type
  TFDSeleccionarCentroAgrupacion = class(TForm)
    lblempresa: TLabel;
    edtAgrupacion: TBEdit;
    btnAgrupacion: TBGridButton;
    RejillaFlotante: TBGrid;
    btnCancelar: TButton;
    btnOk: TButton;
    Label1: TLabel;
    lblCentro: TLabel;
    edtEmpresa: TBEdit;
    edtCentro: TBEdit;
    btnEmpresa: TBGridButton;
    btnCentro: TBGridButton;
    txtCentro: TStaticText;
    txtEmpresa: TStaticText;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAgrupacionClick(Sender: TObject);
    procedure btnEmpresaClick(Sender: TObject);
    procedure btnCentroClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure edtCentroChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function SeleccionarCentroAgrupacion( var AEmpresa, ACentro, AAgrupacion: string;  ATitle: string = '     SELECCIONAR AGRUPACION' ): boolean;


implementation

{$R *.dfm}

uses
  UDMAuxDB, CAuxiliarDB, UDMBaseDatos, CVariables, CostesAgrupaProductoFD;

var
  FDSeleccionarAgrupacion: TFDSeleccionarCentroAgrupacion;

function  SeleccionarCentroAgrupacion( var AEmpresa, ACentro, AAgrupacion: string;  ATitle: string = '     SELECCIONAR AGRUPACION' ): boolean;
begin
  Application.CreateForm(TFDSeleccionarCentroAgrupacion, FDSeleccionarAgrupacion);
  try
    FDSeleccionarAgrupacion.Caption:= ATitle;
    FDSeleccionarAgrupacion.edtAgrupacion.Text:= AAgrupacion;
    FDSeleccionarAgrupacion.edtEmpresa.Text:= AEmpresa;
    FDSeleccionarAgrupacion.edtCentro.Text:= ACentro;
    result:= ( FDSeleccionarAgrupacion.ShowModal = mrOk );
    AAgrupacion:= FDSeleccionarAgrupacion.edtAgrupacion.Text;
    AEmpresa:= FDSeleccionarAgrupacion.edtEmpresa.Text;
    ACentro:= FDSeleccionarAgrupacion.edtCentro.Text;
  finally
    FreeAndNil( FDSeleccionarAgrupacion );
  end;
end;

procedure TFDSeleccionarCentroAgrupacion.btnOkClick(Sender: TObject);
begin
  if ( edtAgrupacion.Text <> '' ) and ( txtEmpresa.caption <> '' ) and ( txtCentro.caption <> '' ) then
  begin
    ModalResult:= mrOk;
  end
  else
    ShowMessage('Falta el codigo de la agrupación, empresa o centro.');
end;

procedure TFDSeleccionarCentroAgrupacion.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TFDSeleccionarCentroAgrupacion.FormCreate(Sender: TObject);
begin
  edtAgrupacion.tag:= kAgrupacionEnvase;
  edtEmpresa.tag:= kEmpresa;
  edtCentro.tag:= kCentro;
end;

procedure TFDSeleccionarCentroAgrupacion.btnAgrupacionClick(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  DespliegaRejilla(btnAgrupacion, ['']);
end;

procedure TFDSeleccionarCentroAgrupacion.btnEmpresaClick(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  DespliegaRejilla(btnEmpresa, ['']);
end;

procedure TFDSeleccionarCentroAgrupacion.btnCentroClick(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  DespliegaRejilla(btnCentro, [edtEmpresa.Text]);
end;

procedure TFDSeleccionarCentroAgrupacion.edtEmpresaChange(Sender: TObject);
begin
  txtEmpresa.Caption:= desEmpresa( edtEmpresa.Text );
  edtCentroChange( edtCentro );
end;

procedure TFDSeleccionarCentroAgrupacion.edtCentroChange(Sender: TObject);
begin
  txtCentro.Caption:= desCentro( edtEmpresa.Text, edtCentro.Text );
end;

end.
