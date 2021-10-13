unit SalidasPorFacturaFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit;

type
  TFLSalidasPorFactura = class(TForm)
    btnCerrar: TBitBtn;
    btnImprimir: TBitBtn;
    lblEmpresa: TnbLabel;
    nbLabel2: TnbLabel;
    stEmpresa: TLabel;
    stCentro: TLabel;
    empresa: TnbDBSQLCombo;
    centro: TnbDBSQLCombo;
    nbLabel1: TnbLabel;
    eDesde: TnbDBCalendarCombo;
    nbLabel3: TnbLabel;
    eHasta: TnbDBCalendarCombo;
    nbLabel4: TnbLabel;
    eCliente: TnbDBSQLCombo;
    stCliente: TLabel;
    nbLabel5: TnbLabel;
    eProducto: TnbDBSQLCombo;
    stProducto: TLabel;
    nbLabel6: TnbLabel;
    cbxAgrupar: TComboBox;
    nbLabel7: TnbLabel;
    cbxVisualizar: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    function centroGetSQL: String;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure empresaChange(Sender: TObject);
    procedure centroChange(Sender: TObject);
    function eClienteGetSQL: String;
    procedure eClienteChange(Sender: TObject);
    procedure eProductoChange(Sender: TObject);
    function eProductoGetSQL: String;
  private
    { Private declarations }
    procedure ValidarCampos;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB, DPreview, UDMBaseDatos,
     UDMConfig, SalidasPorFacturaQL;

procedure TFLSalidasPorFactura.FormCreate(Sender: TObject);
begin
    Caption:= '    Listado Salidas por Número de Factura.';

  FormType:=tfOther;
  BHFormulario;

  empresa.Text:= gsDefEmpresa;
  //centro.Text:= gsDefCentro;

  eDesde.AsDate:= Date - 6;
  eHasta.AsDate:= Date;
end;

procedure TFLSalidasPorFactura.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLSalidasPorFactura.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLSalidasPorFactura.ValidarCampos;
var
  dIni, dFin: TDateTime;
begin
  if Trim(stEmpresa.Caption) = '' then
  begin
    empresa.SetFocus;
    raise Exception.Create('Falta el codigo de la empresa o es icorrecto.');
  end;

  if Trim(stCentro.Caption) = '' then
  begin
    centro.SetFocus;
    raise Exception.Create('El codigo del centro es incorrecto.');
  end;

  if Trim(stCliente.Caption) = '' then
  begin
    centro.SetFocus;
    raise Exception.Create('El codigo del cliente es incorrecto.');
  end;

  if Trim(stProducto.Caption) = '' then
  begin
    eProducto.SetFocus;
    raise Exception.Create('El codigo del producto es incorrecto.');
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


procedure TFLSalidasPorFactura.btnImprimirClick(Sender: TObject);
begin
  ValidarCampos;
  if not SalidasPorFacturaQL.VerListadoSalidasPorFactura( self, empresa.Text, centro.Text, eCliente.Text,
                                                          eProducto.Text, eDesde.Text, eHasta.Text,
                                                          cbxAgrupar.ItemIndex, cbxVisualizar.ItemIndex ) then
    ShowMEssage('No hay entregas pendientes para los parametros usados.');
end;


function TFLSalidasPorFactura.centroGetSQL: String;
begin
  if Empresa.Text <> '' then
    result:= 'select centro_c, descripcion_c from frf_centros where empresa_c = ' +
             Empresa.GetSQLText + ' group by centro_c, descripcion_c order by centro_c'
  else
    result:= 'select centro_c, descripcion_c from frf_centros group by centro_c, descripcion_c order by centro_c';
end;

procedure TFLSalidasPorFactura.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImprimir.Click;
  end;
end;

procedure TFLSalidasPorFactura.empresaChange(Sender: TObject);
var
  sAux: string;
begin
  sAux:= desEmpresa( empresa.Text );
  stEmpresa.Caption:= sAux;
end;

procedure TFLSalidasPorFactura.centroChange(Sender: TObject);
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
    stCentro.Caption:= '(Vacio todos los centros)';
  end;
end;

function TFLSalidasPorFactura.eClienteGetSQL: String;
begin
  if Empresa.Text <> '' then
  result:= 'select cliente_c, nombre_c from frf_clientes where empresa_c = ' +
            Empresa.GetSQLText + ' group by cliente_c, nombre_c order by cliente_c'
  else
    result:= 'select cliente_c, nombre_c from frf_clientes group by cliente_c, nombre_c order by cliente_c';
end;

procedure TFLSalidasPorFactura.eClienteChange(Sender: TObject);
var
  sAux: string;
begin
  sAux:= desCliente( empresa.Text, eCliente.Text );
  if sAux <> '' then
  begin
    stCliente.Caption:= sAux;
  end
  else
  begin
    stCliente.Caption:= '(Vacio todos los clientes)';
  end;
end;

procedure TFLSalidasPorFactura.eProductoChange(Sender: TObject);
var
  sAux: string;
begin
  sAux:= desProducto( empresa.Text, eproducto.Text );
  if sAux <> '' then
  begin
    stProducto.Caption:= sAux;
  end
  else
  begin
    stProducto.Caption:= '(Vacio todos los productos)';
  end;
end;

function TFLSalidasPorFactura.eProductoGetSQL: String;
begin
  if Empresa.Text <> '' then
  result:= 'select producto_p, descripcion_p from frf_productos where empresa_p = ' +
            Empresa.GetSQLText +
            ' group by producto_p, descripcion_p order by producto_p '
  else
    result:= 'select producto_p, descripcion_p from frf_productos ' +
             ' group by producto_p, descripcion_p order by producto_p ';
end;

end.
