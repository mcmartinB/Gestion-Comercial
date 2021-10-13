unit LiquidaValorarPaletsFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, ExtCtrls, nbButtons,
  nbEdits, nbCombos, BSpeedButton, BCalendarButton, ComCtrls, BCalendario,
  Grids, DBGrids, DB, DBTables, kbmMemTable;

type
  TFLLiquidaValorarPalets = class(TForm)
    btnCancelar: TSpeedButton;
    edtAnyoSem: TBEdit;
    lblEmpresa: TnbLabel;
    lblEntrega: TnbLabel;
    edtEntrega: TBEdit;
    lblCodigo1: TnbLabel;
    edtEmpresa: TBEdit;
    lblCodigo2: TnbLabel;
    edtProveedor: TBEdit;
    btnValorarPalets: TButton;
    chkVerPrecios: TCheckBox;
    lblCodigo3: TnbLabel;
    edtProductor: TBEdit;
    nbLabel1: TnbLabel;
    edtProducto: TBEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnValorarPaletsClick(Sender: TObject);

  private

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, UDMBaseDatos, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     CAuxiliarDB, LiquidaEntregaDL, bMath;

var
  DLLiquidaEntrega: TDLLiquidaEntrega;

procedure TFLLiquidaValorarPalets.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  FreeAndNil(DLLiquidaEntrega);
  Action := caFree;
end;

procedure TFLLiquidaValorarPalets.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;


  DLLiquidaEntrega := TDLLiquidaEntrega.Create(self);


  edtEntrega.Text:= '';
  edtEmpresa.Text:= 'F17';
  edtAnyoSem.Text := AnyoSemana( Date );
end;

procedure TFLLiquidaValorarPalets.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLLiquidaValorarPalets.btnCancelarClick(Sender: TObject);
begin
  DLLiquidaEntrega.CloseEntregas;
  Close;
end;

procedure TFLLiquidaValorarPalets.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  case key of
    vk_Return, vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
    vk_escape:
      begin
        btnCancelar.Click;
      end;
    vk_f1:
      begin
        btnValorarPalets.Click;
      end;
  end;
end;

procedure TFLLiquidaValorarPalets.btnValorarPaletsClick(Sender: TObject);
begin
  DLLiquidaEntrega.SelectEntregas( edtEmpresa.Text, edtAnyoSem.Text, edtProveedor.Text, edtProductor.Text, edtProducto.Text, edtEntrega.Text );
  DLLiquidaEntrega.ValorarPaletsExecute( chkVerPrecios.Checked );
end;

end.
