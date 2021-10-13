unit StockFrutaConfeccionadaMasetFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits;

type
  TFLStockFrutaConfeccionadaMaset = class(TForm)
    btnCerrar: TBitBtn;
    btnImprimir: TBitBtn;
    lblEmpresa: TnbLabel;
    nbLabel2: TnbLabel;
    stEmpresa: TLabel;
    stCentro: TLabel;
    empresa: TnbDBSQLCombo;
    centro: TnbDBSQLCombo;
    lblMsg: TLabel;
    nbLabel1: TnbLabel;
    cliente: TnbDBSQLCombo;
    stCliente: TLabel;
    cbxAgruparProducto: TCheckBox;
    rbtResumen: TRadioButton;
    rbtDetalle: TRadioButton;
    eFechaCarga: TnbDBCalendarCombo;
    nbLabel3: TnbLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    function productoGetSQL: String;
    function centroGetSQL: String;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure empresaChange(Sender: TObject);
    procedure centroChange(Sender: TObject);
    procedure clienteChange(Sender: TObject);
    function clienteGetSQL: String;
    procedure rbtDetalleClick(Sender: TObject);
  private
    { Private declarations }
    procedure ValidarCampos;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB, DPreview, UDMBaseDatos,
     UDMConfig, StockFrutaConfeccionadaMasetQL;

procedure TFLStockFrutaConfeccionadaMaset.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  empresa.Text:= gsDefEmpresa;
  centro.Text:= gsDefCentro;
  cliente.Text:= gsDefCliente;
  eFechaCarga.AsDate:= IncMonth( Date, -3 );
end;

procedure TFLStockFrutaConfeccionadaMaset.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLStockFrutaConfeccionadaMaset.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLStockFrutaConfeccionadaMaset.ValidarCampos;
var
  dFecha: TDateTime;
begin
  if Trim(empresa.Text) = '' then
  begin
    empresa.SetFocus;
    raise Exception.Create('Falta el codigo de la empresa que es de obligada inserción.');
  end
  else
  if Trim(stEmpresa.Caption) = '' then
  begin
    empresa.SetFocus;
    raise Exception.Create('Código de empresa incorrecto.');
  end;

  if Trim(centro.Text) = '' then
  begin
    centro.SetFocus;
    raise Exception.Create('Falta el codigo del centro que es de obligada inserción.');
  end
  else
  if Trim(stCentro.Caption) = '' then
  begin
    centro.SetFocus;
    raise Exception.Create('Código de centro incorrecto.');
  end;

  if not TryStrToDate(eFechaCarga.AsString, dFecha ) then
  begin
    eFechaCarga.SetFocus;
    raise Exception.Create('Falta fecha de carga o es incorrecta.');
  end;

  if Trim(stCliente.Caption) = '' then
  begin
    cliente.SetFocus;
    raise Exception.Create('Código de cliente incorrecto.');
  end;
end;


procedure TFLStockFrutaConfeccionadaMaset.btnImprimirClick(Sender: TObject);
begin
  ValidarCampos;
  if not StockFrutaConfeccionadaMasetQL.VerListadoStockConfeccionado( self, Trim(empresa.Text),
           Trim(centro.Text), Trim(cliente.Text), TDateTime(eFechaCarga.AsDate),
           rbtResumen.Checked, cbxAgruparProducto.Checked ) then
    ShowMEssage('Sin Stock para los parametros usados.');
end;

function TFLStockFrutaConfeccionadaMaset.productoGetSQL: String;
begin
  if Empresa.Text <> '' then
    result:= 'select producto_p, descripcion_p from frf_productos where empresa_p = ' +
             Empresa.GetSQLText + ' order by producto_p'
  else
    result:= 'select producto_p, descripcion_p from frf_productos order by producto_p';
end;



function TFLStockFrutaConfeccionadaMaset.centroGetSQL: String;
begin
  if Empresa.Text <> '' then
    result:= 'select centro_c, descripcion_c from frf_centros where empresa_c = ' +
             Empresa.GetSQLText + ' order by centro_c'
  else
    result:= 'select centro_c, descripcion_c from frf_centros order by centro_c';
end;

procedure TFLStockFrutaConfeccionadaMaset.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImprimir.Click;
  end;
end;

procedure TFLStockFrutaConfeccionadaMaset.empresaChange(Sender: TObject);
var
  sAux: string;
begin
  sAux:= desEmpresa( empresa.Text );
  if sAux <> '' then
  begin
    stEmpresa.Caption:= sAux;
  end
  else
  begin
    if Trim(empresa.Text) = '' then
      stEmpresa.Caption:= '(Falta código de la empresa)'
    else
      stEmpresa.Caption:= '';
  end;
  centroChange( centro );
end;

procedure TFLStockFrutaConfeccionadaMaset.centroChange(Sender: TObject);
var
  sAux: string;
begin
  sAux:= desCentro( empresa.Text, centro.Text );
  if sAux <> '' then
  begin
    stCentro.Caption:= sAux;
  end
  else
  begin
    if Trim(centro.Text) = '' then
      stCentro.Caption:= '(Falta código del centro)'
    else
      stCentro.Caption:= '';
  end;
end;

procedure TFLStockFrutaConfeccionadaMaset.clienteChange(Sender: TObject);
var
  sAux: string;
begin
  sAux:= desCliente( empresa.Text, cliente.Text );
  if sAux <> '' then
  begin
    stCliente.Caption:= sAux;
  end
  else
  begin
    if Trim(cliente.Text) = '' then
      stCliente.Caption:= '(Vacio = Todos los clientes)'
    else
      stCliente.Caption:= '';
  end;
end;

function TFLStockFrutaConfeccionadaMaset.clienteGetSQL: String;
begin
  if Empresa.Text <> '' then
    result:= 'select cliente_c, nombre_c from frf_clientes where empresa_c = ' +
             Empresa.GetSQLText + ' order by cliente_c'
  else
    result:= 'select cliente_c, nombre_c from frf_clientes order by cliente_c';
end;

procedure TFLStockFrutaConfeccionadaMaset.rbtDetalleClick(Sender: TObject);
begin
  if rbtDetalle.Checked then
  begin
    cbxAgruparProducto.Enabled:= True;
  end
  else
  begin
    cbxAgruparProducto.Enabled:= False;
    cbxAgruparProducto.Checked:= False;
  end;
end;

end.
