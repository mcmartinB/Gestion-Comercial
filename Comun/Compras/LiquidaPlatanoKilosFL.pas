unit LiquidaPlatanoKilosFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, ExtCtrls, nbButtons,
  nbEdits, nbCombos, BSpeedButton, BCalendarButton, ComCtrls, BCalendario,
  Grids, DBGrids, DB, DBTables, kbmMemTable;

type
  TFLLiquidaPlatanoKilos = class(TForm)
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
    chkVerEntrega: TCheckBox;
    lblDesPlanta: TLabel;
    rbProveedor: TRadioButton;
    rbCategorias: TRadioButton;
    lblCodigo3: TnbLabel;
    lblProducto: TnbLabel;
    edtProducto: TBEdit;
    lblCategoria: TnbLabel;
    edtCategoria: TBEdit;
    lblDesProducto: TLabel;
    lblDesProveedor: TLabel;
    lblDesCategoria: TLabel;
    chkPlantas: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnValorarPaletsClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
    procedure edtProveedorChange(Sender: TObject);
    procedure edtCategoriaChange(Sender: TObject);

  private
     function ValidarParametros: Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, UDMBaseDatos, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     CAuxiliarDB, LiquidaKilosDL, bMath;

var
  DLLiquidaKilos: TDLLiquidaKilos;

procedure TFLLiquidaPlatanoKilos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  FreeAndNil(DLLiquidaKilos);
  Action := caFree;
end;

procedure TFLLiquidaPlatanoKilos.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;


  DLLiquidaKilos := TDLLiquidaKilos.Create(self);



  edtEmpresa.Text:= 'BAG';
  edtProducto.Text:= 'P';
  edtAnyoSem.Text := AnyoSemana( Date );
  edtProveedor.Text:= '';
  edtCategoria.Text:= '';
  edtEntrega.Text:= '';
end;

procedure TFLLiquidaPlatanoKilos.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLLiquidaPlatanoKilos.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLLiquidaPlatanoKilos.FormKeyDown(Sender: TObject; var Key: Word;
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


function TFLLiquidaPlatanoKilos.ValidarParametros: Boolean;
var
  sAux: string;
begin
  result:= True;
  if ( Trim(edtEmpresa.Text )  = '' ) or ( lblDesPlanta.Caption = '' ) then
  begin
    sAux:= 'ERROR: Falta el código de la empresa o es incorrecto.';
    result:= False;
  end;
  if ( Trim(edtProducto.Text )  = '' ) or ( lblDesProducto.Caption = '' ) then
  begin
    sAux:= 'ERROR: Falta el código del producto o es incorrecto.';
    result:= False;
  end;
  if ( lblDesProveedor.Caption = '' ) then
  begin
    sAux:= 'ERROR: El código del proveedor es incorrecto.';
    result:= False;
  end;
  if ( lblDesCategoria.Caption = '' ) then
  begin
    sAux:= 'ERROR: El código de la categoría es incorrecto.';
    result:= False;
  end;

  if (edtAnyoSem.Text = '' ) and ( edtEntrega.Text = '' ) then
  begin
    if sAux <> '' then
      sAux:= sAux + #13 + #10;
    sAux:= sAux + 'ERROR: El código de la entrega o el Año/Semana es obligatorio.';
    result:= False;
  end;
  if not Result then
    ShowMessage( sAux );
end;

procedure TFLLiquidaPlatanoKilos.btnValorarPaletsClick(Sender: TObject);
begin
  if ValidarParametros then
    DLLiquidaKilos.KilosEntregasPlatano( edtEmpresa.Text, edtProducto.Text, edtCategoria.Text,
                                         edtAnyoSem.Text, edtProveedor.Text, edtEntrega.Text,
                                         chkPlantas.Checked, rbCategorias.Checked, rbCategorias.Checked, chkVerEntrega.Checked  );
end;

procedure TFLLiquidaPlatanoKilos.edtEmpresaChange(Sender: TObject);
begin
  if Trim( edtEmpresa.Text ) = '' then
  begin
    lblDesPlanta.Caption:= 'FALTA EMPRESA';
  end
  else
  begin
    if Trim( edtEmpresa.Text ) = 'BAG' then
    begin
      lblDesPlanta.Caption:= 'Plantas  F17, F23, F24, F42';
    end
    else
    begin
      lblDesPlanta.Caption:= desEmpresa( edtEmpresa.Text );
    end;
  end;
  edtProductoChange( edtProducto );
  edtProveedorChange( edtProveedor );
end;

procedure TFLLiquidaPlatanoKilos.edtProductoChange(Sender: TObject);
begin
  if Trim( edtProducto.Text ) = '' then
  begin
    lblDesProducto.Caption:= 'FALTA PRODUCTO';
  end
  else
  begin
    if  Trim( edtEmpresa.Text ) = 'BAG'  then
      lblDesProducto.Caption:= desProducto( 'F17', edtProducto.Text )
    else
      lblDesProducto.Caption:= desProducto( edtEmpresa.Text, edtProducto.Text );
  end;
  edtCategoriaChange( edtCategoria );
end;

procedure TFLLiquidaPlatanoKilos.edtProveedorChange(Sender: TObject);
begin
  if Trim( edtProveedor.Text ) = '' then
  begin
    lblDesProveedor.Caption:= 'TODOS LOS PROVEDORES';
  end
  else
  begin
    if  Trim( edtEmpresa.Text ) = 'BAG'  then
      lblDesProveedor.Caption:= desProveedor( 'F17', edtProveedor.Text )
    else
      lblDesProveedor.Caption:= desProveedor( edtEmpresa.Text, edtProveedor.Text );
  end;
end;

procedure TFLLiquidaPlatanoKilos.edtCategoriaChange(Sender: TObject);
begin
  if Trim( edtCategoria.Text ) = '' then
  begin
    lblDesCategoria.Caption:= 'TODAS LAS CATEGORIAS';
  end
  else
  begin
    if  Trim( edtEmpresa.Text ) = 'BAG'  then
      lblDesCategoria.Caption:= desCategoria( 'F17', edtProducto.Text, edtCategoria.Text )
    else
      lblDesCategoria.Caption:= desCategoria( edtEmpresa.Text, edtProducto.Text, edtCategoria.Text );
  end;
end;

end.
