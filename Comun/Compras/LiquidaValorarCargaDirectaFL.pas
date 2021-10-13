unit LiquidaValorarCargaDirectaFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, ExtCtrls, nbButtons,
  nbEdits, nbCombos, BSpeedButton, BCalendarButton, ComCtrls, BCalendario,
  Grids, DBGrids, DB, DBTables, kbmMemTable;

type
  TFLLiquidaValoraCargaDirecta = class(TForm)
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
    lblCodigo3: TnbLabel;
    edtProductor: TBEdit;
    dtpFechaIni: TnbDBCalendarCombo;
    dtpFechaFin: TnbDBCalendarCombo;
    lbl1: TnbLabel;
    lbl2: TnbLabel;
    rbFecha: TRadioButton;
    rbSemana: TRadioButton;
    rbEntrega: TRadioButton;
    stEmpresa: TnbStaticText;
    stProveedor: TnbStaticText;
    stProductor: TnbStaticText;
    lblProducto: TnbLabel;
    edtProducto: TBEdit;
    stProducto: TnbStaticText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnValorarPaletsClick(Sender: TObject);
    procedure rbFechaClick(Sender: TObject);
    procedure rbSemanaClick(Sender: TObject);
    procedure rbEntregaClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure edtProveedorChange(Sender: TObject);
    procedure edtProductorChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);

  private
    iTipo: Integer;
    dIni, dFin: TDateTime;
    function ParametrosOK: Boolean;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, UDMBaseDatos, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     CAuxiliarDB, CargaDirectaDL, bMath;

var
  DLCargaDirecta: TDLCargaDirecta;

procedure TFLLiquidaValoraCargaDirecta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  FreeAndNil(DLCargaDirecta);
  Action := caFree;
end;

procedure TFLLiquidaValoraCargaDirecta.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;


  DLCargaDirecta := TDLCargaDirecta.Create(self);


  edtEmpresa.Text:= 'F17';
  edtProducto.Text:= 'PLA';
  edtEntrega.Text:= '';
  edtAnyoSem.Text := AnyoSemana( Date );
  dtpFechaIni.AsDate:= Now - 6;
  dtpFechaFin.AsDate:= Now;
end;

procedure TFLLiquidaValoraCargaDirecta.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLLiquidaValoraCargaDirecta.btnCancelarClick(Sender: TObject);
begin
  //DLCargaDirecta.CloseEntregas;
  Close;
end;

procedure TFLLiquidaValoraCargaDirecta.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLLiquidaValoraCargaDirecta.btnValorarPaletsClick(Sender: TObject);
begin
  if ParametrosOK then
  begin
    if not DLCargaDirecta.PreciosVentaCargaDirecta( edtEmpresa.Text, edtProducto.Text, edtProveedor.Text, edtProductor.Text,
                                                  dtpFechaIni.Text, dtpFechaFin.Text, edtAnyoSem.Text, edtEntrega.Text, iTipo )
    then begin
      ShowMessage('Sin datos para los parametros introducidos');
    end;
  end;
end;

procedure TFLLiquidaValoraCargaDirecta.rbFechaClick(Sender: TObject);
begin
  dtpFechaIni.Enabled:= True;
  dtpFechaFin.Enabled:= True;
  edtAnyoSem.Enabled:= False;
  edtEntrega.Enabled:= False;
end;

procedure TFLLiquidaValoraCargaDirecta.rbSemanaClick(Sender: TObject);
begin
  dtpFechaIni.Enabled:= False;
  dtpFechaFin.Enabled:= False;
  edtAnyoSem.Enabled:= True;
  edtEntrega.Enabled:= False;
end;

procedure TFLLiquidaValoraCargaDirecta.rbEntregaClick(Sender: TObject);
begin
  dtpFechaIni.Enabled:= False;
  dtpFechaFin.Enabled:= False;
  edtAnyoSem.Enabled:= False;
  edtEntrega.Enabled:= True;
end;

function TFLLiquidaValoraCargaDirecta.ParametrosOK: Boolean;

begin
  Result:= False;
  if stempresa.Caption = '' then
  begin
    ShowMessage('Falta el codigo de la empresa o es incorrecto');
    Exit;
  end;
  if stProducto.Caption = '' then
  begin
    ShowMessage('Falta el codigo del producto o es incorrecto');
    Exit;
  end;

  if rbFecha.Checked then
  begin
    iTipo:= 1;
    if not TryStrToDate( dtpFechaIni.Text, dIni ) then
    begin
     ShowMessage('Falta la fecha de inicio o es incorrecta');
      Exit;
    end;
    if not TryStrToDate( dtpFechaFin.Text, dFin ) then
    begin
      ShowMessage('Falta la fecha de fin o es incorrecta');
      Exit;
    end;
    if dIni > dFin then
    begin
      ShowMessage('Rango de fechas incorrecto.');
      Exit;
    end;
  end
  else
  if rbSemana.Checked then
  begin
    iTipo:= 2;
    if Length( edtAnyoSem.Text ) <> 6 then
    begin
      ShowMessage('El Anyo/semana debe de tener 6 caracteres.');
      Exit;
    end;
  end
  else
  if rbEntrega.Checked then
  begin
    iTipo:= 3;
    if Length( edtEntrega.Text ) <> 12 then
    begin
      ShowMessage('El numero de entrega debe de tener 12 caracteres.');
      Exit;
    end;
  end;

   if stProveedor.Caption = '' then
   begin
    ShowMessage('El codigo del proveedor es incorrecto');
     Exit;
  end;
  if stProductor.Caption = '' then
  begin
    ShowMessage('El codigo del productor es incorrecto');
    Exit;
  end;
  Result:= True;
end;

procedure TFLLiquidaValoraCargaDirecta.edtEmpresaChange(Sender: TObject);
begin
  stempresa.Caption:= desEmpresa( edtEmpresa.Text );
  edtProductoChange( edtProducto );
  edtProveedorChange( edtProveedor );
end;

procedure TFLLiquidaValoraCargaDirecta.edtProductoChange(Sender: TObject);
begin
  stProducto.Caption:= desProducto( edtEmpresa.Text, edtProducto.Text );
end;

procedure TFLLiquidaValoraCargaDirecta.edtProveedorChange(Sender: TObject);
begin
  if edtProveedor.Text = '' then
  begin
    stProveedor.Caption:= 'TODOS LOS PROVEEDORES';
  end
  else
  begin
    stProveedor.Caption:= desProveedor( edtEmpresa.Text, edtProveedor.Text );
  end;
  edtProductorChange( edtProductor );
end;

procedure TFLLiquidaValoraCargaDirecta.edtProductorChange(Sender: TObject);
begin
  if edtProductor.Text = '' then
  begin
    stProductor.Caption:= 'TODOS LOS PRODUCTORES';
  end
  else
  begin
    stProductor.Caption:= desProveedorAlmacen( edtEmpresa.Text, edtProveedor.Text, edtProductor.Text );
  end;
end;


end.
