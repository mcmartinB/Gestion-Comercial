unit SeleccionarProductoFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, BGrid, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit;

type
  TFDSeleccionarProducto = class(TForm)
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
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnProductoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure btnEmpresaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function SeleccionarProducto( var AEmpresa, AProducto: string;  ATitle: string = '     SELECCIONAR PRODUCTO' ): boolean;


implementation

{$R *.dfm}

uses
  UDMAuxDB, CAuxiliarDB, UDMBaseDatos, CVariables;

var
  FDSeleccionarProducto: TFDSeleccionarProducto;

function  SeleccionarProducto( var AEmpresa, AProducto: string;  ATitle: string = '     SELECCIONAR PRODUCTO' ): boolean;
begin
  Application.CreateForm(TFDSeleccionarProducto, FDSeleccionarProducto);
  try
    FDSeleccionarProducto.Caption:= ATitle;
    FDSeleccionarProducto.edtEmpresa.Text:= AEmpresa;
    FDSeleccionarProducto.edtProducto.Text:= AProducto;
    result:= ( FDSeleccionarProducto.ShowModal = mrOk );
    AEmpresa:= FDSeleccionarProducto.edtEmpresa.Text;
    AProducto:= FDSeleccionarProducto.edtProducto.Text;
  finally
    FreeAndNil( FDSeleccionarProducto );
  end;
end;

procedure TFDSeleccionarProducto.btnOkClick(Sender: TObject);
begin
  if txtProducto.Caption <> '' then
    ModalResult:= mrOk
  else
    ShowMessage('Falta el codigo del producto o es incorecto.');
end;

procedure TFDSeleccionarProducto.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TFDSeleccionarProducto.btnProductoClick(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  DespliegaRejilla(btnProducto, [edtEmpresa.Text]);
end;

procedure TFDSeleccionarProducto.FormCreate(Sender: TObject);
begin
  edtProducto.tag:= kProducto;
  edtEmpresa.tag:= kEmpresa;
end;

procedure TFDSeleccionarProducto.edtProductoChange(Sender: TObject);
begin
  txtProducto.Caption:= desProducto( edtEmpresa.Text, edtProducto.Text );
end;

procedure TFDSeleccionarProducto.edtEmpresaChange(Sender: TObject);
begin
  txtEmpresa.Caption:= desEmpresa( edtEmpresa.Text );
  edtProductoChange( edtProducto );
end;

procedure TFDSeleccionarProducto.btnEmpresaClick(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  DespliegaRejilla(btnEmpresa, ['']);
end;

end.
