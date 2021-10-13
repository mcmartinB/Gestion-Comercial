unit ConfirmaRecepcionFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits;

type
  TFLConfirmaRecepcion = class(TForm)
    btnCerrar: TBitBtn;
    btnImprimir: TBitBtn;
    lblEmpresa: TnbLabel;
    nbLabel2: TnbLabel;
    stEmpresa: TLabel;
    stCentro: TLabel;
    empresa: TnbDBSQLCombo;
    fechaDesde: TnbDBCalendarCombo;
    nbLabel1: TnbLabel;
    nbLabel3: TnbLabel;
    cliente: TnbDBSQLCombo;
    stCliente: TLabel;
    nbLabel4: TnbLabel;
    fechaHasta: TnbDBCalendarCombo;
    nbLabel5: TnbLabel;
    lblNombre1: TLabel;
    pedido: TnbDBAlfa;
    albaran: TnbDBNumeric;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure empresaChange(Sender: TObject);
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

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB,
     DPreview, UDMBaseDatos, UDMConfig, ConfirmaRecepcionQL;

procedure TFLConfirmaRecepcion.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  empresa.Text:= gsDefEmpresa;
  cliente.Text:= gsDefCliente;
  fechaDesde.AsDate:= Date;
  fechaHasta.AsDate:= Date;
end;

procedure TFLConfirmaRecepcion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLConfirmaRecepcion.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLConfirmaRecepcion.ValidarCampos;
var
  dIni, dFin: TDateTime;
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

  if Trim(cliente.Text) = '' then
  begin
    cliente.SetFocus;
    raise Exception.Create('Falta el codigo del cliente que es de obligada inserción.');
  end
  else
  if Trim(stCliente.Caption) = '' then
  begin
    cliente.SetFocus;
    raise Exception.Create('Código de cliente incorrecto.');
  end;

  if not TryStrToDate( fechaDesde.Text, dIni ) then
  begin
    fechaDesde.SetFocus;
    raise Exception.Create('Fecha de inicio incorrecta.');
  end;
  if not TryStrToDate( fechaHasta.Text, dFin ) then
  begin
    fechaHasta.SetFocus;
    raise Exception.Create('Fecha de fin incorrecta.');
  end;
  if dFin < dIni then
  begin
    fechaDesde.SetFocus;
    raise Exception.Create('Rango de fechas incorrecto.');
  end;
end;


procedure TFLConfirmaRecepcion.btnImprimirClick(Sender: TObject);
begin
  ValidarCampos;
  if not ConfirmaRecepcionQL.VerListadoConfirmaRecepcion( self, trim(empresa.Text),
    Trim(cliente.Text), Trim(pedido.Text), StrToIntDef( albaran.Text, -1 ), fechaDesde.AsDate, fechaHasta.AsDate  ) then
    ShowMEssage('Sin datos para los parametros usados.');
end;


procedure TFLConfirmaRecepcion.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImprimir.Click;
  end;
end;

procedure TFLConfirmaRecepcion.empresaChange(Sender: TObject);
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
  clienteChange( cliente );
end;

procedure TFLConfirmaRecepcion.clienteChange(Sender: TObject);
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

function TFLConfirmaRecepcion.clienteGetSQL: String;
begin
  result:= 'select cliente_c, nombre_c from frf_clientes order by cliente_c';
end;

end.
