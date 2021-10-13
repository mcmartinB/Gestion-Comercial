unit SeleccionarCentroProductoFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, BGrid, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit;

type
  TFDSeleccionarCentroProducto = class(TForm)
    lblempresa: TLabel;
    edtEmpresa: TBEdit;
    btnEmpresa: TBGridButton;
    txtEmpresa: TStaticText;
    RejillaFlotante: TBGrid;
    btnCancelar: TButton;
    btnOk: TButton;
    lblProducto: TLabel;
    edtProducto: TBEdit;
    btnProducto: TBGridButton;
    txtProducto: TStaticText;
    lblCentro: TLabel;
    edtCentro: TBEdit;
    btnCentro: TBGridButton;
    txtCentro: TStaticText;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnProductoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure btnEmpresaClick(Sender: TObject);
    procedure btnCentroClick(Sender: TObject);
    procedure edtCentroChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function SeleccionarCentroProducto( var AEmpresa, ACentro, AProducto: string;  ATitle: string = '     SELECCIONAR PRODUCTO' ): boolean;


implementation

{$R *.dfm}

uses
  UDMAuxDB, CAuxiliarDB, UDMBaseDatos, CVariables;

var
  FDSeleccionarProducto: TFDSeleccionarCentroProducto;

function  SeleccionarCentroProducto( var AEmpresa, ACentro, AProducto: string;  ATitle: string = '     SELECCIONAR PRODUCTO' ): boolean;
begin
  Application.CreateForm(TFDSeleccionarCentroProducto, FDSeleccionarProducto);
  try
    FDSeleccionarProducto.Caption:= ATitle;
    FDSeleccionarProducto.edtEmpresa.Text:= AEmpresa;
    FDSeleccionarProducto.edtCentro.Text:= ACentro;
    FDSeleccionarProducto.edtProducto.Text:= AProducto;
    result:= ( FDSeleccionarProducto.ShowModal = mrOk );
    AEmpresa:= FDSeleccionarProducto.edtEmpresa.Text;
    ACentro:= FDSeleccionarProducto.edtCentro.Text;
    AProducto:= FDSeleccionarProducto.edtProducto.Text;
  finally
    FreeAndNil( FDSeleccionarProducto );
  end;
end;

procedure TFDSeleccionarCentroProducto.btnOkClick(Sender: TObject);
begin
  if ( txtProducto.Caption <> '' ) and ( txtCentro.Caption <> '' ) then
    ModalResult:= mrOk
  else
    ShowMessage('Falta el codigo del centro / producto o es incorecto.');
end;

procedure TFDSeleccionarCentroProducto.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TFDSeleccionarCentroProducto.btnProductoClick(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  DespliegaRejilla(btnProducto, [edtEmpresa.Text]);
end;

procedure TFDSeleccionarCentroProducto.FormCreate(Sender: TObject);
begin
  edtProducto.tag:= kProducto;
  edtEmpresa.tag:= kEmpresa;
  edtCentro.tag:= kCentro;
end;

procedure TFDSeleccionarCentroProducto.edtProductoChange(Sender: TObject);
begin
  txtProducto.Caption:= desProducto( edtEmpresa.Text, edtProducto.Text );
end;

procedure TFDSeleccionarCentroProducto.edtEmpresaChange(Sender: TObject);
begin
  txtEmpresa.Caption:= desEmpresa( edtEmpresa.Text );
  edtProductoChange( edtProducto );
  edtCentroChange( edtCentro );
end;

procedure TFDSeleccionarCentroProducto.btnEmpresaClick(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  DespliegaRejilla(btnEmpresa, ['']);
end;

procedure TFDSeleccionarCentroProducto.btnCentroClick(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  DespliegaRejilla(btnCentro, [edtEmpresa.Text]);
end;

procedure TFDSeleccionarCentroProducto.edtCentroChange(Sender: TObject);
begin
  txtCentro.Caption:= desCentro( edtEmpresa.Text, edtCentro.Text );
end;

end.
