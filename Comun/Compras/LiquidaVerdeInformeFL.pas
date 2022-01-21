unit LiquidaVerdeInformeFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, ExtCtrls, nbButtons,
  nbEdits, nbCombos, BSpeedButton, BCalendarButton, ComCtrls, BCalendario,
  Grids, DBGrids, DB, DBTables, kbmMemTable;

type
  TFLLiquidaVerdeInforme = class(TForm)
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
    lbl1: TLabel;
    edtMargen: TBEdit;
    chkProveedores: TCheckBox;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    edtMinimoTteCliente: TBEdit;
    edtMinimoTteCanario: TBEdit;
    edtMinimoCosteEnvasado: TBEdit;
    lblCodigo3: TnbLabel;
    edtProductor: TBEdit;
    lblCostesFinancieros: TLabel;
    edtCostesFinancierosC: TBEdit;
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

procedure TFLLiquidaVerdeInforme.FormClose(Sender: TObject;
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

procedure TFLLiquidaVerdeInforme.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  DLLiquidaEntrega := TDLLiquidaEntrega.Create(self);

  edtEmpresa.Text:= 'F42';
  edtAnyoSem.Text := AnyoSemana( Date );
  edtEntrega.Text:= '';
  edtMargen.Text:= '0,040';
  (*30/4/2015 Amparo *)
  edtCostesFinancierosC.Text:= '0,027';
  (*
  edtCostesFinancierosC.Text:= '0,017';
  *)
  edtMinimoTteCliente.Text:= '0';//'0,03';
  edtMinimoTteCanario.Text:= '0';//'0,12';
  edtMinimoCosteEnvasado.Text:= '0';//'0,025';

end;

procedure TFLLiquidaVerdeInforme.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLLiquidaVerdeInforme.btnCancelarClick(Sender: TObject);
begin
  DLLiquidaEntrega.CloseEntregas;
  Close;
end;

procedure TFLLiquidaVerdeInforme.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLLiquidaVerdeInforme.btnValorarPaletsClick(Sender: TObject);
var
  sAux: string;
begin
  if edtEntrega.Text <> '' then
  begin
    sAux:= Copy( edtEntrega.Text, 1, 3 );
  end
  else
  begin
    sAux:= '';
  end;
  if ( sAux = edtEmpresa.Text ) or ( sAux = '' ) then
  begin
    DLLiquidaEntrega.SelectEntregasVerde( edtEmpresa.Text, edtAnyoSem.Text, edtProveedor.Text, edtProductor.Text, edtProducto.Text, edtEntrega.Text );
    DLLiquidaEntrega.LiquidarEntregasVerdeExecute( chkVerPrecios.Checked,
                                            chkProveedores.Checked,
                                            StrToFloatDef( edtMargen.Text,0),
                                            StrToFloatDef( edtCostesFinancierosC.Text,0 ),
                                            0,
                                            False, False, False,
                                            StrToFloatDef( edtMinimoTteCliente.Text,0 ),
                                            StrToFloatDef( edtMinimoTteCanario.Text,0 ),
                                            StrToFloatDef( edtMinimoCosteEnvasado.Text,0 ) );
  end
  else
  begin
    ShowMessage('Este programa solo muestra la liquidación para las plantas que no tienen RF.' + #13 + #10 +
                'Para liquidar las entregas seleccionadas use la opción de menú de "Liquidación de entregas con RF".');
  end;
end;

end.
