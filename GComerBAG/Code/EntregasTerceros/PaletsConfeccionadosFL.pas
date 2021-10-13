unit PaletsConfeccionadosFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits;

type
  TFLPaletsConfeccionados = class(TForm)
    btnCerrar: TBitBtn;
    btnImprimir: TBitBtn;
    lblEmpresa: TnbLabel;
    nbLabel2: TnbLabel;
    stEmpresa: TLabel;
    stCentro: TLabel;
    empresa: TnbDBSQLCombo;
    centro: TnbDBSQLCombo;
    Label1: TLabel;
    Label2: TLabel;
    fechaDesde: TnbDBCalendarCombo;
    nbLabel1: TnbLabel;
    nbLabel3: TnbLabel;
    cliente: TnbDBSQLCombo;
    stCliente: TLabel;
    cbxClientesNumericos: TCheckBox;
    nbLabel4: TnbLabel;
    fechaHasta: TnbDBCalendarCombo;
    rbtResumen: TRadioButton;
    rbtDetalle: TRadioButton;
    cbxAgruparProducto: TCheckBox;
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
    procedure rbtResumenClick(Sender: TObject);
  private
    { Private declarations }
    procedure ValidarCampos;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB, DPreview, UDMBaseDatos,
     UDMConfig, StockFrutaConfeccionadaQL, StockFrutaConfeccionadaMasetQL;

procedure TFLPaletsConfeccionados.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  empresa.Text:= gsDefEmpresa;
  centro.Text:= gsDefCentro;
  cliente.Text:= '';
  fechaDesde.AsDate:= Date;
  fechaHasta.AsDate:= Date;

  (*
  if DMConfig.EsValenciaBonde or DMConfig.EsTenerifeBonde then
  begin
    cbxClientesNumericos.Visible:= True;
    cbxClientesNumericos.Checked:= True;
  end
  else
  *)
  begin
    cbxClientesNumericos.Visible:= False;
    cbxClientesNumericos.Checked:= False;
  end;


  if DMConfig.iInstalacion = 30 then //Solo chanita
  begin
    Height:= 298;

    rbtResumen.Visible:= True;
    rbtResumen.Checked:= True;
    rbtDetalle.Visible:= True;
    cbxAgruparProducto.Visible:= True;
    cbxAgruparProducto.Checked:= False;
    label1.Top:= 183;
    label2.Top:= 195;

    cliente.Text:= '';
  end
  else
  begin
    Height:= 252;

    rbtResumen.Visible:= False;
    rbtResumen.Checked:= False;
    rbtDetalle.Visible:= False;
    cbxAgruparProducto.Visible:= False;
    cbxAgruparProducto.Checked:= False;
    label1.Top:= 145;
    label2.Top:= 157;

    cliente.Text:= gsDefCliente;
  end;
end;

procedure TFLPaletsConfeccionados.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLPaletsConfeccionados.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLPaletsConfeccionados.ValidarCampos;
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


procedure TFLPaletsConfeccionados.btnImprimirClick(Sender: TObject);
begin
  ValidarCampos;
  if DMConfig.EsMaset then
  begin
    if not StockFrutaConfeccionadaMasetQL.VerListadoPaletsConfeccionados( self, trim(empresa.Text),
      Trim(centro.Text), Trim(cliente.Text), fechaDesde.AsDate, fechaHasta.AsDate,
      rbtResumen.Checked, cbxAgruparProducto.Checked  ) then
      ShowMEssage('Sin datos para los parametros usados.');
  end
  else
  begin
    if not StockFrutaConfeccionadaQL.VerListadoPaletsConfeccionados( self, trim(empresa.Text),
      Trim(centro.Text), Trim(cliente.Text), fechaDesde.AsDate, fechaHasta.AsDate, not cbxClientesNumericos.Checked  ) then
      ShowMEssage('Sin datos para los parametros usados.');
  end;
end;

function TFLPaletsConfeccionados.centroGetSQL: String;
begin
  if Empresa.Text <> '' then
    result:= 'select centro_c, descripcion_c from frf_centros where empresa_c = ' +
             Empresa.GetSQLText + ' order by centro_c'
  else
    result:= 'select centro_c, descripcion_c from frf_centros order by centro_c';
end;

procedure TFLPaletsConfeccionados.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImprimir.Click;
  end;
end;

procedure TFLPaletsConfeccionados.empresaChange(Sender: TObject);
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

procedure TFLPaletsConfeccionados.centroChange(Sender: TObject);
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

procedure TFLPaletsConfeccionados.clienteChange(Sender: TObject);
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

function TFLPaletsConfeccionados.clienteGetSQL: String;
begin
  result:= 'select cliente_c, nombre_c from frf_clientes order by cliente_c';
end;

procedure TFLPaletsConfeccionados.rbtResumenClick(Sender: TObject);
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

