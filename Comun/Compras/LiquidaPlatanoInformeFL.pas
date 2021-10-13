unit LiquidaPlatanoInformeFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, ExtCtrls, nbButtons,
  nbEdits, nbCombos, BSpeedButton, BCalendarButton, ComCtrls, BCalendario,
  Grids, DBGrids, DB, DBTables, kbmMemTable, BGridButton, BGrid, QuickRpt;

type
  TFLLiquidaPlatanoInforme = class(TForm)
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
    lbl1: TLabel;
    lblCostesFinancieros: TLabel;
    edtMargen: TBEdit;
    edtCostesFinancierosCargados: TBEdit;
    chkProveedores: TCheckBox;
    lblDesEmpresa: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    edtMinimoTteCliente: TBEdit;
    edtMinimoTteCanario: TBEdit;
    lbl5: TLabel;
    edtMinimoCosteEnvasado: TBEdit;
    lblCodigo3: TnbLabel;
    edtProductor: TBEdit;
    chkClientes: TCheckBox;
    RejillaFlotante: TBGrid;
    btnEmpresa: TBGridButton;
    chkDestrios: TCheckBox;
    chkPlaceros: TCheckBox;
    chkCargados: TCheckBox;
    chkVolcados: TCheckBox;
    bvl1: TBevel;
    lbl2: TLabel;
    edtCostesFinancierosVolcado: TBEdit;
    chkFinancieroCarga: TCheckBox;
    chkFinancieroVolcado: TCheckBox;
    lbl6: TLabel;
    edtFlete: TBEdit;
    chkFlete: TCheckBox;
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
    procedure btnEmpresaClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);

  private
    sEmpresa, sAnyoSemana, sProveedor, sProductor, sProducto, sEntrega: string;
    bPrecios, bProveedores, bClientes, bDestrio, bPlacero, bCargado, bVolcado, bFinancierosCargados, bFinancierosVolcados, bFlete: Boolean;
    rMargen, rFinancierosCargados, rFinancierosVolcados, rFlete, rMinCliente, rMinTenerife, rMinEnvasado: Real;

    function ValidarParametros: Boolean;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, UDMBaseDatos, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     CAuxiliarDB, LiquidaEntregaDL, bMath;

var
  DLLiquidaEntrega: TDLLiquidaEntrega;

procedure TFLLiquidaPlatanoInforme.FormClose(Sender: TObject;
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

procedure TFLLiquidaPlatanoInforme.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;


  DLLiquidaEntrega := TDLLiquidaEntrega.Create(self);



  edtEmpresa.Text:= 'BAG';
  edtEmpresa.Tag:= kEmpresa;

  edtAnyoSem.Text := AnyoSemana( Date );
  edtEntrega.Text:= '';
  edtMargen.Text:= '0';
  (*30/4/2015 Amparo *)
  edtCostesFinancierosCargados.Text:= '0,100';
  edtCostesFinancierosVolcado.Text:= '0,100';
  edtFlete.Text:='0,070';
  (*
  edtCostesFinancierosCargados.Text:= '0,017';
  edtCostesFinancierosVolcado.Text:= '0,025';
  *)
  edtMinimoTteCliente.Text:= '0';//'0,03';
  edtMinimoTteCanario.Text:= '0';//'0,12';
  edtMinimoCosteEnvasado.Text:= '0';//'0,025';

end;

procedure TFLLiquidaPlatanoInforme.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLLiquidaPlatanoInforme.btnCancelarClick(Sender: TObject);
begin
  DLLiquidaEntrega.CloseEntregas;
  Close;
end;

procedure TFLLiquidaPlatanoInforme.FormKeyDown(Sender: TObject; var Key: Word;
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

function TFLLiquidaPlatanoInforme.ValidarParametros: Boolean;
begin
  if lblDesEmpresa.Caption = '' then
  begin
    ShowMessage('Falta el código de la empresa o es incorrrecto.');
    Result:= False;
  end
  else
  begin
    if edtEmpresa.Text = '' then
      sEmpresa:= 'BAG'
    else
      sEmpresa:= edtEmpresa.Text;

    if (edtProducto.Text <> 'PLA') and (edtProducto.Text <> 'PTN') then
    begin
      ShowMessage(' Falta introducir el producto o no es PLA/PTN.');
      Result := False;
      exit;
    end;
    
    sAnyoSemana:= edtAnyoSem.Text;
    sProveedor:= edtProveedor.Text;
    sProductor:= edtProductor.Text;
    sProducto := edtProducto.Text;
    sEntrega:= edtEntrega.Text;
    bPrecios:= true;
    bProveedores:= chkProveedores.Checked;
    bClientes:= chkClientes.Checked;
    rMargen:= StrToFloatDef( edtMargen.Text,0);
    rFinancierosCargados:= StrToFloatDef( edtCostesFinancierosCargados.Text,0 );
    rFinancierosVolcados:= StrToFloatDef( edtCostesFinancierosVolcado.Text,0 );
    if not chkFlete.Checked then
      rFlete:=strToFloatDef( edtFlete.Text,0)
    else
      rFlete := 0;
    rMinCliente:= StrToFloatDef( edtMinimoTteCliente.Text,0 );
    rMinTenerife:= StrToFloatDef( edtMinimoTteCanario.Text,0 );
    rMinEnvasado:= StrToFloatDef( edtMinimoCosteEnvasado.Text,0 );

    bFlete:=chkFlete.Checked;
    bFinancierosCargados:=chkFinancieroCarga.Checked;
    bFinancierosVolcados:=chkFinancieroVolcado.Checked;

    bDestrio:= chkDestrios.Checked;
    bPlacero:= chkDestrios.Checked;
    bCargado:= chkDestrios.Checked;
    bVolcado:= chkDestrios.Checked;

    if not bDestrio and not bPlacero and not bCargado and not bVolcado then
    begin
      bDestrio:= True;
      bPlacero:= True;
      bCargado:= True;
      bVolcado:= True;
    end;

    Result:= True;
  end;
end;

procedure TFLLiquidaPlatanoInforme.btnValorarPaletsClick(Sender: TObject);
begin
  if ValidarParametros then
  begin
    DLLiquidaEntrega.LiquidaEntregasPlatano( Self, sEmpresa, sAnyoSemana, sProveedor, sProductor, sProducto, sEntrega,
                                             bPrecios, bProveedores, bClientes, bDestrio, bPlacero, bCargado, bVolcado, bFinancierosCargados, bFinancierosVolcados, bFlete,
                                             rMargen, rFinancierosVolcados, rFinancierosCargados, rFlete,
                                             rMinCliente, rMinTenerife, rMinEnvasado );

  end;
end;

procedure TFLLiquidaPlatanoInforme.btnEmpresaClick(Sender: TObject);
begin
  DespliegaRejilla(btnEmpresa);
end;

procedure TFLLiquidaPlatanoInforme.edtEmpresaChange(Sender: TObject);
var
  sAux: string;
begin
  if ( edtEmpresa.Text = '' ) or ( edtEmpresa.Text = 'BAG' ) then
  begin
    lblDesEmpresa.Caption:= 'Plantas  F17, F23, F24, F42';
  end
  else
  begin
    sAux:= desEmpresa( edtEmpresa.Text );
    if sAux <> '' then
    begin
      if ( edtEmpresa.Text <> 'F17' ) and
         ( edtEmpresa.Text <> 'F23' ) and
         ( edtEmpresa.Text <> 'F24' ) and
         ( edtEmpresa.Text <> 'F42' ) then
      begin
        sAux:= '';
      end;
    end;
    lblDesEmpresa.Caption:= sAux;
  end;
end;

end.
