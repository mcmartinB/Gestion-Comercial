unit StockFrutaConfeccionadaFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits;

type
  TFLStockFrutaConfeccionada = class(TForm)
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
    cbxClientesNumericos: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    function centroGetSQL: String;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure empresaChange(Sender: TObject);
    procedure centroChange(Sender: TObject);
    procedure clienteChange(Sender: TObject);
    function clienteGetSQL: String;
  private
    { Private declarations }
    procedure ValidarCampos;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB, DPreview, UDMBaseDatos,
     UDMConfig, StockFrutaConfeccionadaQL;

procedure TFLStockFrutaConfeccionada.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  empresa.Text:= gsDefEmpresa;
  centro.Text:= gsDefCentro;
  cliente.Text:= gsDefCliente;

  cbxClientesNumericos.Visible:= True;
  cbxClientesNumericos.Checked:= True;
end;

procedure TFLStockFrutaConfeccionada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLStockFrutaConfeccionada.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLStockFrutaConfeccionada.ValidarCampos;
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

  if Trim(stCliente.Caption) = '' then
  begin
    cliente.SetFocus;
    raise Exception.Create('Código de cliente incorrecto.');
  end;
end;


procedure TFLStockFrutaConfeccionada.btnImprimirClick(Sender: TObject);
begin
  ValidarCampos;
  if not StockFrutaConfeccionadaQL.VerListadoStockConfeccionado( self, Trim(empresa.Text),
           Trim(centro.Text), Trim(cliente.Text), not cbxClientesNumericos.Checked ) then
    ShowMEssage('Sin Stock para los parametros usados.');
end;

function TFLStockFrutaConfeccionada.centroGetSQL: String;
begin
  if Empresa.Text <> '' then
    result:= 'select centro_c, descripcion_c from frf_centros where empresa_c = ' +
             Empresa.GetSQLText + ' order by centro_c'
  else
    result:= 'select centro_c, descripcion_c from frf_centros order by centro_c';
end;

procedure TFLStockFrutaConfeccionada.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImprimir.Click;
  end;
end;

procedure TFLStockFrutaConfeccionada.empresaChange(Sender: TObject);
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

procedure TFLStockFrutaConfeccionada.centroChange(Sender: TObject);
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

procedure TFLStockFrutaConfeccionada.clienteChange(Sender: TObject);
var
  sAux: string;
begin
  sAux:= desCliente( cliente.Text );
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

function TFLStockFrutaConfeccionada.clienteGetSQL: String;
begin
  result:= 'select cliente_c, nombre_c from frf_clientes order by cliente_c';
end;

end.
