unit CosteFrutaProveedorFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit;

type
  TFLCosteFrutaProveedor = class(TForm)
    btnCerrar: TBitBtn;
    btnImprimir: TBitBtn;
    lblEmpresa: TnbLabel;
    lblCentro: TnbLabel;
    stEmpresa: TLabel;
    stCentro: TLabel;
    eEmpresa: TnbDBSQLCombo;
    eCentro: TnbDBSQLCombo;
    cbxVariedad: TCheckBox;
    lblMsg1: TLabel;
    cbxCalibre: TCheckBox;
    lblProducto: TnbLabel;
    eProducto: TnbDBSQLCombo;
    stProducto: TLabel;
    lblFechaDesde: TnbLabel;
    lblFechaHasta: TnbLabel;
    lblProveedor: TnbLabel;
    eProveedor: TnbDBSQLCombo;
    stProveedor: TLabel;
    eFechaDesde: TnbDBCalendarCombo;
    eFechaHasta: TnbDBCalendarCombo;
    lblEntrega: TnbLabel;
    eEntrega: TnbDBAlfa;
    lblNombre1: TLabel;
    lblMsg2: TLabel;
    cbbDetalle: TComboBox;
    nbLabel1: TnbLabel;
    eTipoGasto: TnbDBSQLCombo;
    lblTipos: TLabel;
    chkImporteFruta: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    function  eProductoGetSQL: String;
    function  eCentroGetSQL: String;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure eEmpresaChange(Sender: TObject);
    procedure eCentroChange(Sender: TObject);
    procedure cbxVariedadClick(Sender: TObject);
    procedure eProductoChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function eProveedorGetSQL: String;
    procedure eProveedorChange(Sender: TObject);
    procedure eTipoGastoChange(Sender: TObject);
  private
    { Private declarations }
    procedure ValidarCampos;
    procedure ConfigurarFormulario;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB,
     DPreview, UDMBaseDatos, UDMConfig, CosteFrutaProveedorQL;


procedure TFLCosteFrutaProveedor.ConfigurarFormulario;
begin
  (*CODIGO VARIABLE*)
  eEmpresa.Text:= gsDefEmpresa;
  eFechaDesde.AsDate:= Date;
  eFechaHasta.AsDate:= Date;

  lblCentro.Caption:= 'Centro Llegada';
  lblFechaDesde.Caption:= 'Fecha Llegada Desde';
end;

procedure TFLCosteFrutaProveedor.FormCreate(Sender: TObject);
begin
  (*CODIGO FIJO*)
  FormType:=tfOther;
  BHFormulario;
  ConfigurarFormulario;
end;

procedure TFLCosteFrutaProveedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLCosteFrutaProveedor.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLCosteFrutaProveedor.ValidarCampos;
var
  dFechaIni, dFechaFin: TDatetime;
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

  if eProveedor.Text = '' then
  begin
    eProveedor.SetFocus;
    raise Exception.Create('Falta el código del proveedor.');
  end
  else
  if stProveedor.Caption = '' then
  begin
    eProveedor.SetFocus;
    raise Exception.Create('El codigo del proveedor es incorrecto.');
  end;

  if stCentro.Caption = '' then
  begin
    eCentro.SetFocus;
    raise Exception.Create('El codigo del centro es incorrecto.');
  end;

  if stProducto.Caption = '' then
  begin
    eProducto.SetFocus;
    raise Exception.Create('El codigo del producto es incorrecto.');
  end;

  (*
  if Trim(eCentro.Text) = '' then
  begin
    eCentro.SetFocus;
    raise Exception.Create('Falta el codigo del centro que es de obligada inserción.');
  end
  else
  begin
    if stCentro.Caption = '' then
    begin
      eCentro.SetFocus;
      raise Exception.Create('El codigo del centro es incorrecto.');
    end;
  end;
  *)

  if not TryStrToDate( eFechaDesde.Text, dFechaIni ) then
  begin
    eFechaDesde.SetFocus;
    raise Exception.Create('Falta la fecha de inicio o es incorrecta.');
  end;

  if not TryStrToDate( eFechaHasta.Text, dFechaFin ) then
  begin
    eFechaHasta.SetFocus;
    raise Exception.Create('Falta la fecha de fin o es incorrecta.');
  end;

  if dFechaFin < dFechaIni then
  begin
    eFechaDesde.SetFocus;
    raise Exception.Create('Rango de fechas incorrecto.');
  end;
end;


procedure TFLCosteFrutaProveedor.btnImprimirClick(Sender: TObject);
begin
  lblMsg1.Visible:= True;
  lblMsg2.Caption:= 'SELECCIONADO ENTREGAS';
  lblMsg2.Visible:= True;
  Application.ProcessMessages;

  Application.ProcessMessages;
  try
    ValidarCampos;
    if not CosteFrutaProveedorQL.VerListadoStock( self, Trim(eEmpresa.Text), Trim(eCentro.Text),
      Trim(eProducto.Text), Trim(eProveedor.Text), Trim(eEntrega.Text), Trim(eTipoGasto.Text), chkImporteFruta.checked,
      Trim(eFechaDesde.Text), Trim(eFechaHasta.Text), cbxVariedad.Checked, cbxCalibre.Checked,
      cbbDetalle.ItemIndex = 0, lblMsg2 ) then
      ShowMEssage('Sin datos para los parametros usados.');
  finally
    lblMsg1.Visible:= False;
    lblMsg2.Visible:= False;
    Application.ProcessMessages;
  end;
end;

function TFLCosteFrutaProveedor.eProductoGetSQL: String;
begin
  if eEmpresa.Text <> '' then
    result:= 'select producto_p, descripcion_p from frf_productos where empresa_p = ' +
             eEmpresa.GetSQLText + ' order by producto_p'
  else
    result:= 'select producto_p, descripcion_p from frf_productos order by producto_p';
end;

function TFLCosteFrutaProveedor.eProveedorGetSQL: String;
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

function TFLCosteFrutaProveedor.eCentroGetSQL: String;
begin
  if eEmpresa.Text <> '' then
    result:= 'select centro_c, descripcion_c from frf_centros where empresa_c = ' +
             eEmpresa.GetSQLText + ' order by centro_c'
  else
    result:= 'select centro_c, descripcion_c from frf_centros order by centro_c';
end;

procedure TFLCosteFrutaProveedor.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImprimir.Click;
  end;
end;

procedure TFLCosteFrutaProveedor.eEmpresaChange(Sender: TObject);
begin
  if Trim(eEmpresa.Text) = '' then
  begin
    stEmpresa.Caption:= '(Falta el código de la empresa)';
  end
  else
  begin
    stEmpresa.Caption:= desEmpresa( eEmpresa.Text );
  end;
  eCentroChange( eCentro );
  eProductoChange( eProducto );
  eProveedorChange( eProveedor );
end;

procedure TFLCosteFrutaProveedor.eCentroChange(Sender: TObject);
begin
  if Trim(eCentro.Text) = '' then
  begin
    stCentro.Caption:= '(Vacio =Todos los centros)';
  end
  else
  begin
    stCentro.Caption:= desCentro( eEmpresa.Text, eCentro.Text );
  end;
end;

procedure TFLCosteFrutaProveedor.eProductoChange(Sender: TObject);
begin
  if Trim(eProducto.Text) = '' then
  begin
    stProducto.Caption:= '(Vacio =Todos los productos)';
  end
  else
  begin
    stProducto.Caption:= desProducto( eEmpresa.Text, eProducto.Text );
  end;
end;

procedure TFLCosteFrutaProveedor.eProveedorChange(Sender: TObject);
begin
  if Trim(eProveedor.Text) = '' then
  begin
    stProveedor.Caption:= '(Falta el código del proveedor)';
  end
  else
  begin
    stProveedor.Caption:= desProveedor( eEmpresa.Text, eProveedor.Text );
  end;
end;

procedure TFLCosteFrutaProveedor.cbxVariedadClick(Sender: TObject);
begin
  cbxCalibre.Enabled:= cbxVariedad.Checked;
  if not cbxCalibre.Enabled then
    cbxCalibre.Checked:= False;
end;


procedure TFLCosteFrutaProveedor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  if cbxVariedad.Focused or cbxCalibre.Focused then
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

procedure TFLCosteFrutaProveedor.eTipoGastoChange(Sender: TObject);
begin
  if eTipoGasto.Text <> '' then
    lblTipos.Caption:= desTipoGastos( eTipoGasto.Text )
  else
    lblTipos.Caption:= '(Vacio =Todos los tipos)';

  if lblTipos.Caption <> '' then
  begin
    if eTipoGasto.Text = '110' then
    begin
      chkImporteFruta.Enabled:= False;
      chkImporteFruta.Checked:= False;
    end
    else
    begin
      chkImporteFruta.Enabled:= True;
    end;
  end
  else
  begin
    chkImporteFruta.Enabled:= False;
    chkImporteFruta.Checked:= False;
  end;
end;

end.
