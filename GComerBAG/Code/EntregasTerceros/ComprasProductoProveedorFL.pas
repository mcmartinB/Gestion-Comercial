unit ComprasProductoProveedorFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit, ExtCtrls;

type
  TFLComprasProductoProveedor = class(TForm)
    btnCerrar: TBitBtn;
    btnImprimir: TBitBtn;
    lblEmpresa: TnbLabel;
    stEmpresa: TLabel;
    eEmpresa: TnbDBSQLCombo;
    lblMsg1: TLabel;
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
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    bvl1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    function  eProductoGetSQL: String;
    function  eCentroGetSQL: String;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure eEmpresaChange(Sender: TObject);
    procedure eProductoChange(Sender: TObject);
    function eProveedorGetSQL: String;
    procedure eProveedorChange(Sender: TObject);
  private
    { Private declarations }
    procedure ValidarCampos;
    procedure ConfigurarFormulario;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB, bTimeUtils,
     DPreview, UDMBaseDatos, UDMConfig, ComprasProductoProveedorQL;


procedure TFLComprasProductoProveedor.ConfigurarFormulario;
begin
  (*CODIGO VARIABLE*)
  eFechaDesde.AsDate:= LunesAnterior( Date ) - 7;
  eFechaHasta.AsDate:= eFechaDesde.AsDate + 6;
end;

procedure TFLComprasProductoProveedor.FormCreate(Sender: TObject);
begin
  (*CODIGO FIJO*)
  FormType:=tfOther;
  BHFormulario;
  ConfigurarFormulario;
end;

procedure TFLComprasProductoProveedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLComprasProductoProveedor.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLComprasProductoProveedor.ValidarCampos;
var
  dFechaIni, dFechaFin: TDatetime;
begin
  if stEmpresa.Caption = '' then
  begin
    eEmpresa.SetFocus;
    raise Exception.Create('El código de la planta es incorrecto.');
  end
  else

  if stProducto.Caption = '' then
  begin
    eProducto.SetFocus;
    raise Exception.Create('El código del producto es incorrecto.');
  end;

  if stProveedor.Caption = '' then
  begin
    eProveedor.SetFocus;
    raise Exception.Create('El código del proveedor es incorrecto.');
  end;

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


procedure TFLComprasProductoProveedor.btnImprimirClick(Sender: TObject);
begin
  lblMsg1.Visible:= True;
  lblMsg2.Caption:= 'SELECCIONADO ENTREGAS';
  lblMsg2.Visible:= True;
  Application.ProcessMessages;

  Application.ProcessMessages;
  try
    ValidarCampos;
    if not ComprasProductoProveedorQL.ListadoComprasProductoProveedor( self, Trim(eEmpresa.Text),
      Trim(eProducto.Text), Trim(eProveedor.Text), Trim(eEntrega.Text), Trim(eFechaDesde.Text),
      Trim(eFechaHasta.Text), lblMsg2 ) then
      ShowMEssage('Sin datos para los parametros usados.');
  finally
    lblMsg1.Visible:= False;
    lblMsg2.Visible:= False;
    Application.ProcessMessages;
  end;
end;

function TFLComprasProductoProveedor.eProductoGetSQL: String;
begin
  result:= 'select producto_p, descripcion_p from frf_productos order by producto_p';
end;

function TFLComprasProductoProveedor.eProveedorGetSQL: String;
begin
  result:= ' select proveedor_p, nombre_p ' +
           ' from frf_proveedores ' +
           ' order by proveedor_p';
end;

function TFLComprasProductoProveedor.eCentroGetSQL: String;
begin
  if eEmpresa.Text <> '' then
    result:= 'select centro_c, descripcion_c from frf_centros where empresa_c = ' +
             eEmpresa.GetSQLText + ' order by centro_c'
  else
    result:= 'select centro_c, descripcion_c from frf_centros order by centro_c';
end;

procedure TFLComprasProductoProveedor.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImprimir.Click;
  end;
end;

procedure TFLComprasProductoProveedor.eEmpresaChange(Sender: TObject);
begin
  if Trim(eEmpresa.Text) = '' then
  begin
    stEmpresa.Caption:= '(Vacio = Todas las plantas)';
  end
  else
  begin
    stEmpresa.Caption:= desEmpresa( eEmpresa.Text );
  end;
  eProductoChange( eProducto );
  eProveedorChange( eProveedor );
end;

procedure TFLComprasProductoProveedor.eProductoChange(Sender: TObject);
begin
  if Trim(eProducto.Text) = '' then
  begin
    stProducto.Caption:= '(Vacio =Todos los productos)';
  end
  else
  begin
    if eEmpresa.Text = '' then
      stProducto.Caption:= desProducto( 'F21', eProducto.Text )
    else
      stProducto.Caption:= desProducto( eEmpresa.Text, eProducto.Text );
  end;
end;

procedure TFLComprasProductoProveedor.eProveedorChange(Sender: TObject);
begin
  if Trim(eProveedor.Text) = '' then
  begin
    stProveedor.Caption:= '(Vacio =Todos los proveedores)';
  end
  else
  begin
    if eEmpresa.Text = '' then
      stProveedor.Caption:= desProveedor( 'F21', eProveedor.Text )
    else
      stProveedor.Caption:= desProveedor( eEmpresa.Text, eProveedor.Text );
  end;
end;

end.
