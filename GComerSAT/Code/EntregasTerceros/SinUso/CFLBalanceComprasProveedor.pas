unit CFLBalanceComprasProveedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit;

type
  TFLBalanceComprasProveedor = class(TForm)
    btnCerrar: TBitBtn;
    btnImprimir: TBitBtn;
    lblEmpresa: TnbLabel;
    stEmpresa: TLabel;
    eEmpresa: TnbDBSQLCombo;
    lblFechaDesde: TnbLabel;
    lblFechaHasta: TnbLabel;
    lblProveedor: TnbLabel;
    eProveedor: TnbDBSQLCombo;
    stProveedor: TLabel;
    eFechaDesde: TnbDBCalendarCombo;
    eFechaHasta: TnbDBCalendarCombo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure eEmpresaChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function eProveedorGetSQL: String;
    procedure eProveedorChange(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sProveedor: string;
    dIni, dFin: TDateTime;
    procedure ValidarCampos;
    procedure ConfigurarFormulario;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB,
     DPreview, UDMBaseDatos, UDMConfig, CDBalanceComprasProveedor,
     CQBalanceComprasProveedor;


procedure TFLBalanceComprasProveedor.ConfigurarFormulario;
begin
  (*CODIGO VARIABLE*)
  eEmpresa.Text:= gsDefEmpresa;
  eFechaDesde.AsDate:= Date;
  eFechaHasta.AsDate:= Date;
end;

procedure TFLBalanceComprasProveedor.FormCreate(Sender: TObject);
begin
  (*CODIGO FIJO*)
  FormType:=tfOther;
  BHFormulario;
  ConfigurarFormulario;
end;

procedure TFLBalanceComprasProveedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLBalanceComprasProveedor.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLBalanceComprasProveedor.ValidarCampos;
begin
  if eEmpresa.Text = '' then
  begin
    eEmpresa.SetFocus;
    raise Exception.Create('Falta el código de la empresa.');
  end
  else
  if stEmpresa.Caption = '' then
  begin
    eEmpresa.SetFocus;
    raise Exception.Create('El código de la empresa es incorrecto.');
  end;
  sEmpresa:= eEmpresa.Text;

  if stProveedor.Caption = '' then
  begin
    eProveedor.SetFocus;
    raise Exception.Create('El código del proveedor es incorrecto.');
  end
  else
  sProveedor:= Trim(eProveedor.Text);

  if not TryStrToDate( eFechaDesde.Text, dIni ) then
  begin
    eFechaDesde.SetFocus;
    raise Exception.Create('Falta la fecha de inicio o es incorrecta.');
  end;

  if not TryStrToDate( eFechaHasta.Text, dFin ) then
  begin
    eFechaHasta.SetFocus;
    raise Exception.Create('Falta la fecha de fin o es incorrecta.');
  end;

  if dFin < dIni then
  begin
    eFechaDesde.SetFocus;
    raise Exception.Create('Rango de fechas incorrecto.');
  end;
end;


procedure TFLBalanceComprasProveedor.btnImprimirClick(Sender: TObject);
begin
  ValidarCampos;
  try
    if CDBalanceComprasProveedor.ObtenerDatosPlus( self, sEmpresa, sProveedor, dIni, dFin ) then
      CQBalanceComprasProveedor.Previsualizar( self, sEmpresa, sProveedor, dIni, dFin )
    else
      ShowMEssage('Sin datos para los parametros usados.');
  finally
    CDBalanceComprasProveedor.CerrarDatos;
  end;
end;

function TFLBalanceComprasProveedor.eProveedorGetSQL: String;
begin
  if eEmpresa.Text <> '' then
    result:= ' select proveedor_p, nombre_p ' +
             ' from frf_proveedores ' +
             ' where empresa_p = ' + eEmpresa.GetSQLText +
             ' order by proveedor_p'
  else
    result:= ' select proveedor_p, nombre_p ' +
             ' from frf_proveedores ' +
             ' order by proveedor_p';
end;

procedure TFLBalanceComprasProveedor.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImprimir.Click;
  end;
end;

procedure TFLBalanceComprasProveedor.eEmpresaChange(Sender: TObject);
begin
  if Trim(eEmpresa.Text) = '' then
  begin
    stEmpresa.Caption:= '(Falta el código de la empresa)';
  end
  else
  begin
    stEmpresa.Caption:= desEmpresa( eEmpresa.Text );
  end;
  eProveedorChange( eProveedor );
end;

procedure TFLBalanceComprasProveedor.eProveedorChange(Sender: TObject);
begin
  if Trim(eProveedor.Text) = '' then
  begin
    stProveedor.Caption:= '(Vacío todos los proveedores)';
  end
  else
  begin
    stProveedor.Caption:= desProveedor( eEmpresa.Text, eProveedor.Text );
  end;
end;

procedure TFLBalanceComprasProveedor.FormKeyDown(Sender: TObject; var Key: Word;
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
  end;
end;

end.
