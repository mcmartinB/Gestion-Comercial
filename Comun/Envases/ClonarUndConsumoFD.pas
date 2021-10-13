unit ClonarUndConsumoFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, BEdit;

type
  TFDClonarUndConsumo = class(TForm)
    btnAceptar: TButton;
    rbCambiar: TRadioButton;
    rbBorrar: TRadioButton;
    lblNombre6: TLabel;
    lblNombre7: TLabel;
    LEnvase_e: TLabel;
    empresa_e: TBEdit;
    producto_e: TBEdit;
    envase_e: TBEdit;
    txtEmpresa: TStaticText;
    txtProducto: TStaticText;
    txtEnvase: TStaticText;
    txtDesEnvase: TStaticText;
    edt_envase: TBEdit;
    lbl1: TLabel;
    rbNoPasar: TRadioButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


function ClonarUndConsumo( var VEmpresa, VUnidad, VProducto, VNewProducto: string ): Integer;


implementation

{$R *.dfm}

var
  FDClonarUndConsumo: TFDClonarUndConsumo;

function ClonarUndConsumo( var VEmpresa, VUnidad, VProducto, VNewProducto: string ): Integer;
begin
  Application.CreateForm(TFDClonarUndConsumo, FDClonarUndConsumo);
  try
    Result:= FDClonarUndConsumo.ShowModal;
  finally
    FreeAndNil( FDClonarUndConsumo );
  end;
end;

procedure TFDClonarUndConsumo.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= -1;
end;

procedure TFDClonarUndConsumo.btnAceptarClick(Sender: TObject);
begin
  Close;
end;

procedure TFDClonarUndConsumo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  (*
  if rbCambiarProducto.Checked then
  begin
    ModalResult:= 1;
  end
  else
  begin
    ModalResult:= 0;
  end;
  *)
end;

end.
