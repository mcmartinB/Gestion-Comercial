unit ValorarStockProveedorFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit, ExtCtrls;

type
  TFLValorarStockProveedor = class(TForm)
    btnCerrar: TBitBtn;
    btnImprimir: TBitBtn;
    lblEmpresa: TnbLabel;
    nbLabel2: TnbLabel;
    stEmpresa: TLabel;
    stCentro: TLabel;
    eEmpresa: TnbDBSQLCombo;
    eCentro: TnbDBSQLCombo;
    Label3: TLabel;
    nbLabel1: TnbLabel;
    eProducto: TnbDBSQLCombo;
    stProducto: TLabel;
    nbLabel3: TnbLabel;
    eEntrega: TBEdit;
    Label5: TLabel;
    lblProveedor: TnbLabel;
    lblVariedad: TnbLabel;
    lblCalibre: TnbLabel;
    eCalibre: TnbDBSQLCombo;
    eVariedad: TnbDBSQLCombo;
    eProveedor: TnbDBSQLCombo;
    stProveedor: TLabel;
    stVariedad: TLabel;
    stCalibre: TLabel;
    lblFechaStock: TnbLabel;
    eFechaStock: TnbDBCalendarCombo;
    lbl2: TLabel;
    lbl3: TLabel;
    chkVerDetalle: TCheckBox;
    lbl1: TLabel;
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
    procedure eProductoChange(Sender: TObject);
    function eProveedorGetSQL: String;
    function eVariedadGetSQL: String;
    function eCalibreGetSQL: String;
    procedure eProveedorChange(Sender: TObject);
    procedure eVariedadChange(Sender: TObject);
  private
    { Private declarations }
    dFecha: TDateTime;
    sEmpresa, sCentro,  sProducto, sEntrega, sProveedor, sVariedad, sCalibre: string;

    procedure ValidarCampos;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB,
     DPreview, UDMBaseDatos, ValorarStockProveedorQL;

procedure TFLValorarStockProveedor.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  eFechaStock.Text:= FormatDateTime( 'dd/mm/yyyy', Date - 1 );
end;

procedure TFLValorarStockProveedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLValorarStockProveedor.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLValorarStockProveedor.ValidarCampos;
begin
  //validar fechas
  if not tryStrTodate( eFechaStock.Text, dFecha ) then
  begin
    eFechaStock.SetFocus;
    raise Exception.Create('Fecha de stock incorrecta.');
  end;

  if Trim(eEmpresa.Text) <> '' then
  begin
    if stEmpresa.Caption = '' then
    begin
      eEmpresa.SetFocus;
      raise Exception.Create('El codigo de la empresa es incorrecto.');
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

    if stProveedor.Caption = '' then
    begin
      eProveedor.SetFocus;
      raise Exception.Create('El codigo del proveedor es incorrecto.');
    end;
  end;

  sEmpresa:= eEmpresa.Text;
  sCentro:= eCentro.Text;
  sProducto:= eProducto.Text;
  sProveedor:= eProveedor.Text;

  sEntrega:= eEntrega.Text;
  sVariedad:= eVariedad.Text;
  sCalibre:= eCalibre.Text;
end;


procedure TFLValorarStockProveedor.btnImprimirClick(Sender: TObject);
begin
  Label3.Visible:= True;
  Application.ProcessMessages;
  try
    ValidarCampos;
    if not ValorarStockProveedorQL.VerListadoStock( self, sEmpresa, sCentro, dFecha,
      sProducto, sEntrega, sProveedor, sVariedad, sCalibre, chkVerDetalle.Checked ) then
        ShowMEssage('Sin Stock para los parametros usados.');
  finally
    Label3.Visible:= False;
    Application.ProcessMessages;
  end;
end;

function TFLValorarStockProveedor.eProductoGetSQL: String;
begin
  result:= 'select producto_p, descripcion_p from frf_productos order by producto_p';
  eVariedadChange( eVariedad );
end;

function TFLValorarStockProveedor.eCentroGetSQL: String;
begin
  if eEmpresa.Text <> '' then
    result:= 'select centro_c, descripcion_c from frf_centros where empresa_c = ' +
             eEmpresa.GetSQLText + ' order by centro_c'
  else
    result:= 'select centro_c, descripcion_c from frf_centros order by centro_c';
end;

function TFLValorarStockProveedor.eProveedorGetSQL: String;
begin
  result:= 'select proveedor_p, nombre_p from frf_proveedores order by proveedor_p';
end;

function TFLValorarStockProveedor.eVariedadGetSQL: String;
var
  bFlag: boolean;
begin
  bFlag:= False;
  result:= ' select variedad_pp, proveedor_pp, producto_pp, descripcion_pp ';
  result:= result + ' from frf_productos_proveedor ';
  if eProducto.Text <> '' then
  begin
    if bFlag then
      result:= result + ' and  producto_pp = ' + eProducto.GetSQLText + ' '
    else
      result:= result + ' where producto_pp = ' + eProducto.GetSQLText + ' ';
    bFlag:= True;
  end;
  if eProveedor.Text <> '' then
  begin
    if bFlag then
      result:= result + ' and  proveedor_pp = ' + eProveedor.GetSQLText + ' '
    else
      result:= result + ' where proveedor_pp = ' + eProveedor.GetSQLText + ' ';
  end;
  result:= result + ' order by proveedor_pp, producto_pp, variedad_pp ';
end;

function TFLValorarStockProveedor.eCalibreGetSQL: String;
var
  bFlag: boolean;
begin
  bFlag:= False;
  result:= ' select calibre_c, producto_c from frf_calibres ';

  if eProducto.Text <> '' then
    result:= result + ' where producto_c = ' + eProducto.GetSQLText + ' ';

  result:= result + ' order by producto_c, calibre_c ';
end;

procedure TFLValorarStockProveedor.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImprimir.Click;
  end;
end;

procedure TFLValorarStockProveedor.eEmpresaChange(Sender: TObject);
begin
  if Trim(eEmpresa.Text) = '' then
  begin
    stEmpresa.Caption:= '(Vacio =Todas las plantas)';
  end
  else
  begin
    stEmpresa.Caption:= desEmpresa( eEmpresa.Text );
  end;

  eCentroChange( eCentro );
  eProductoChange(eProducto);
  eProveedorChange(eProveedor);
end;

procedure TFLValorarStockProveedor.eCentroChange(Sender: TObject);
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

procedure TFLValorarStockProveedor.eProductoChange(Sender: TObject);
begin
  if Trim(eProducto.Text) = '' then
  begin
    stProducto.Caption:= '(Vacio =Todos los productos)';
  end
  else
  begin
    stProducto.Caption:= desProducto( eEmpresa.Text, eProducto.Text );
  end;
  eVariedadChange( eVariedad );
end;

procedure TFLValorarStockProveedor.eProveedorChange(Sender: TObject);
begin
  if Trim(eProveedor.Text) = '' then
  begin
    stProveedor.Caption:= '(Vacio =Todas los proveedores)';
  end
  else
  begin
    stProveedor.Caption:= desProveedor( eEmpresa.Text, eProveedor.Text );
  end;
  eVariedadChange( eVariedad );
end;

procedure TFLValorarStockProveedor.eVariedadChange(Sender: TObject);
begin
  if Trim(eVariedad.Text) = '' then
  begin
    stVariedad.Caption:= '(Vacio =Todas las variedades)';
  end
  else
  begin
    stVariedad.Caption:= desVariedad( eEmpresa.Text, eProveedor.Text, eProducto.Text, eVariedad.Text );
  end;
end;


end.
