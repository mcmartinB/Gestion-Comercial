unit StockFrutaPlantaFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit, ExtCtrls;

type
  TFLStockFrutaPlanta = class(TForm)
    btnCerrar: TBitBtn;
    btnImprimir: TBitBtn;
    lblEmpresa: TnbLabel;
    nbLabel2: TnbLabel;
    stEmpresa: TLabel;
    stCentro: TLabel;
    eEmpresa: TnbDBSQLCombo;
    eCentro: TnbDBSQLCombo;
    Label1: TLabel;
    Label2: TLabel;
    cbxVariedad: TCheckBox;
    cbxValorar: TCheckBox;
    Label3: TLabel;
    cbxCalibre: TCheckBox;
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
    lblPais: TnbLabel;
    ePais: TnbDBSQLCombo;
    stPais: TLabel;
    stCalibre: TLabel;
    nbLabel4: TnbLabel;
    eDesde: TnbDBCalendarCombo;
    nbLabel5: TnbLabel;
    eHasta: TnbDBCalendarCombo;
    nbLabel6: TnbLabel;
    eSemana: TBEdit;
    lblSemana: TLabel;
    chkIgnorarPlatano: TCheckBox;
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
    function eProveedorGetSQL: String;
    function eVariedadGetSQL: String;
    function eCalibreGetSQL: String;
    procedure eProveedorChange(Sender: TObject);
    procedure eVariedadChange(Sender: TObject);
    procedure ePaisChange(Sender: TObject);
  private
    { Private declarations }
    procedure ValidarCampos;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB,
     DPreview, UDMBaseDatos, UDMConfig, StockFrutaPlantaQL,
     StockFrutaPlantaMasetNormalQL, StockFrutaPlantaMasetApaisadoQL;

procedure TFLStockFrutaPlanta.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  eEmpresa.Text:= gsDefEmpresa;
  eCentro.Text:= gsDefCentro;
  eDesde.Text:= '';
  eHasta.Text:= '';

  cbxValorar.Visible:= False;
  chkIgnorarPlatano.Visible:= false;
  eSemana.Enabled:= DMConfig.EsLaFont;
  lblSemana.Visible:= eSemana.Enabled;
end;

procedure TFLStockFrutaPlanta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLStockFrutaPlanta.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLStockFrutaPlanta.ValidarCampos;
var
  dIni, dFin: TDateTime;
begin
  if Trim(eEmpresa.Text) = '' then
  begin
    eEmpresa.SetFocus;
    raise Exception.Create('Falta el codigo de la empresa que es de obligada inserción.');
  end
  else
  begin
    if stEmpresa.Caption = '' then
    begin
      eEmpresa.SetFocus;
      raise Exception.Create('El codigo de la empresa es incorrecto.');
    end;
  end;


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

  if stPais.Caption = '' then
  begin
    ePais.SetFocus;
    raise Exception.Create('El codigo del pais es incorrecto.');
  end;

  //validar fechas
  if ( Trim(eDesde.Text) <> '' ) and not tryStrTodate( eDesde.Text, dIni ) then
  begin
    eDesde.SetFocus;
    raise Exception.Create('Fecha de inicio incorrecta.');
  end;
  if ( Trim(eHasta.Text) <> '' ) and not tryStrTodate( eHasta.Text, dFin ) then
  begin
    eHasta.SetFocus;
    raise Exception.Create('Fecha de fin incorrecta.');
  end;
  if ( eDesde.Text <> '' ) and ( eHasta.Text <> '' ) then
  begin
    if dIni > dFin then
    begin
      eDesde.SetFocus;
      raise Exception.Create('Rango de fechas incorrecto.');
    end;
  end;
end;


procedure TFLStockFrutaPlanta.btnImprimirClick(Sender: TObject);
begin
  Label1.Visible:= False;
  Label2.Visible:= False;
  Label3.Visible:= True;
  Application.ProcessMessages;
  try
    ValidarCampos;
    begin
      if not StockFrutaPlantaQL.VerListadoStock( self, Trim(eEmpresa.Text), Trim(eCentro.Text),
        Trim(eProducto.Text), Trim(eEntrega.Text), Trim( eProveedor.Text ), Trim( eVariedad.Text ),
        Trim(eCalibre.Text), Trim(ePais.Text), Trim(eDesde.Text), Trim(eHasta.Text),
        cbxVariedad.Checked, cbxCalibre.Checked, cbxValorar.Checked ) then
        ShowMEssage('Sin Stock para los parametros usados.');
    end;
  finally
    Label1.Visible:= True;
    Label2.Visible:= True;
    Label3.Visible:= False;
    Application.ProcessMessages;
  end;
end;

function TFLStockFrutaPlanta.eProductoGetSQL: String;
begin
  if eEmpresa.Text <> '' then
    result:= 'select producto_p, descripcion_p from frf_productos where empresa_p = ' +
             eEmpresa.GetSQLText + ' order by producto_p'
  else
    result:= 'select producto_p, descripcion_p from frf_productos order by producto_p';
  eVariedadChange( eVariedad );
end;

function TFLStockFrutaPlanta.eCentroGetSQL: String;
begin
  if eEmpresa.Text <> '' then
    result:= 'select centro_c, descripcion_c from frf_centros where empresa_c = ' +
             eEmpresa.GetSQLText + ' order by centro_c'
  else
    result:= 'select centro_c, descripcion_c from frf_centros order by centro_c';
end;

function TFLStockFrutaPlanta.eProveedorGetSQL: String;
begin
  if eEmpresa.Text <> '' then
    result:= 'select proveedor_p, nombre_p from frf_proveedores where empresa_p = ' +
             eEmpresa.GetSQLText + ' order by proveedor_p'
  else
    result:= 'select proveedor_p, nombre_p from frf_proveedores order by proveedor_p';
end;

function TFLStockFrutaPlanta.eVariedadGetSQL: String;
var
  bFlag: boolean;
begin
  bFlag:= False;
  result:= ' select variedad_pp, proveedor_pp, producto_pp, descripcion_pp ';
  result:= result + ' from frf_productos_proveedor ';
  if eEmpresa.Text <> '' then
  begin
    result:= result + ' where empresa_pp = ' + eEmpresa.GetSQLText + ' ';
    bFlag:= True;
  end;
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

function TFLStockFrutaPlanta.eCalibreGetSQL: String;
var
  bFlag: boolean;
begin
  bFlag:= False;
  result:= ' select calibre_c, producto_c from frf_calibres ';

  if eEmpresa.Text <> '' then
  begin
    result:= result + ' where empresa_c = ' + eEmpresa.GetSQLText + ' ';
    bFlag:= True;
  end;
  if eProducto.Text <> '' then
  begin
    if bFlag then
      result:= result + ' and  producto_c = ' + eProducto.GetSQLText + ' '
    else
      result:= result + ' where producto_c = ' + eProducto.GetSQLText + ' ';
  end;
  result:= result + ' order by producto_c, calibre_c ';
end;

procedure TFLStockFrutaPlanta.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImprimir.Click;
  end;
end;

procedure TFLStockFrutaPlanta.eEmpresaChange(Sender: TObject);
begin
  if Trim(eEmpresa.Text) = '' then
  begin
    stEmpresa.Caption:= '(Falta código de la empresa)';
  end
  else
  begin
    stEmpresa.Caption:= desEmpresa( eEmpresa.Text );
  end;

  eCentroChange( eCentro );
  eProductoChange(eProducto);
  eProveedorChange(eProveedor);
end;

procedure TFLStockFrutaPlanta.eCentroChange(Sender: TObject);
begin
  if Trim(eCentro.Text) = '' then
  begin
    stCentro.Caption:= '(Falta código del centro)';
  end
  else
  begin
    stCentro.Caption:= desCentro( eEmpresa.Text, eCentro.Text );
  end;
end;

procedure TFLStockFrutaPlanta.eProductoChange(Sender: TObject);
begin
  if Trim(eProducto.Text) = '' then
  begin
    stProducto.Caption:= '(Vacio =Todos los productos)';
    chkIgnorarPlatano.Enabled:= True;
  end
  else
  begin
    stProducto.Caption:= desProducto( eEmpresa.Text, eProducto.Text );
    chkIgnorarPlatano.Enabled:= False;
    chkIgnorarPlatano.Checked:= False;
  end;
  eVariedadChange( eVariedad );
end;

procedure TFLStockFrutaPlanta.eProveedorChange(Sender: TObject);
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

procedure TFLStockFrutaPlanta.eVariedadChange(Sender: TObject);
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

procedure TFLStockFrutaPlanta.ePaisChange(Sender: TObject);
begin
  if Trim(ePais.Text) = '' then
  begin
    stPais.Caption:= '(Vacio =Todos los paises)';
  end
  else
  begin
    stPais.Caption:= desPais( ePais.Text );
  end;
end;

procedure TFLStockFrutaPlanta.cbxVariedadClick(Sender: TObject);
begin
  cbxCalibre.Enabled:= cbxVariedad.Checked;
  if not cbxCalibre.Enabled then
    cbxCalibre.Checked:= False;
end;

end.
