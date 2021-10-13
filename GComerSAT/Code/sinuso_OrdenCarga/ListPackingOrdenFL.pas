unit ListPackingOrdenFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit;

type
  TFLListPackingOrden = class(TForm)
    btnCerrar: TBitBtn;
    btnImprimir: TBitBtn;
    lblEmpresa: TnbLabel;
    nbLabel2: TnbLabel;
    stEmpresa: TLabel;
    stEnvase: TLabel;
    eEmpresa: TnbDBSQLCombo;
    eEnvase: TnbDBSQLCombo;
    Label1: TLabel;
    nbLabel3: TnbLabel;
    eFechaDesde: TnbDBCalendarCombo;
    eFechaHasta: TnbDBCalendarCombo;
    nbLabel1: TnbLabel;
    lblCliente: TnbLabel;
    eCliente: TnbDBSQLCombo;
    stCliente: TLabel;
    nbLabel4: TnbLabel;
    eProducto: TnbDBSQLCombo;
    lblProducto: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    function  eEnvaseGetSQL: String;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure eEmpresaChange(Sender: TObject);
    procedure eEnvaseChange(Sender: TObject);
    function eClienteGetSQL: String;
    procedure eClienteChange(Sender: TObject);
    function eProductoGetSQL: String;
    procedure eProductoChange(Sender: TObject);
  private
    { Private declarations }
    dFechaIni, dFechaFin: TDateTime;

    procedure ValidarCampos;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB,
     DPreview, UDMBaseDatos, UDMConfig, ListPackingOrdenQL;

procedure TFLListPackingOrden.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  eEmpresa.Text:= gsDefEmpresa;
  eFechaDesde.Text:= DateToStr( Date );
  eFechaHasta.Text:= eFechaDesde.Text;
end;

procedure TFLListPackingOrden.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLListPackingOrden.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLListPackingOrden.ValidarCampos;
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

  if Trim(lblProducto.Caption) = '' then
  begin
    eProducto.SetFocus;
    raise Exception.Create('Código de producto incorrecto.');
  end;

  if Trim(stEnvase.Caption) = '' then
  begin
    eEnvase.SetFocus;
    raise Exception.Create('Código de envase incorrecto.');
  end;

  if Trim(stCliente.Caption) = '' then
  begin
    eCliente.SetFocus;
    raise Exception.Create('Código de cliente incorrecto.');
  end;

  //Rango de fechas
  if not TryStrToDate( eFechaDesde.Text, dFechaIni ) then
  begin
    eFechaDesde.SetFocus;
    raise Exception.Create('Fecha de inicio incorrecta.');
  end;
  if not TryStrToDate( eFechaHasta.Text, dFechaFin ) then
  begin
    eFechaHasta.SetFocus;
    raise Exception.Create('Fecha de fin incorrecta.');
  end;
  if dFechaFin < dFechaIni then
  begin
    eFechaDesde.SetFocus;
    raise Exception.Create('rango de fechas incorrecto.');
  end;
end;


procedure TFLListPackingOrden.btnImprimirClick(Sender: TObject);
begin
  ValidarCampos;
  if not ListPackingOrdenQL.VerListadoOrden( self, Trim(eEmpresa.Text), Trim(eProducto.Text), 
           Trim(eEnvase.Text), Trim(eCliente.Text), dFechaIni, dFechaFin ) then
    ShowMEssage('Sin datos para los parametros usados.');
end;


function TFLListPackingOrden.eEnvaseGetSQL: String;
begin
  if eEmpresa.Text <> '' then
  begin
    if eProducto.Text <> '' then
    begin
      result:= 'select envase_e, descripcion_e from frf_envases ' +
               ' where empresa_e = ' + eEmpresa.GetSQLText +
               '   and producto_base_e = ' + eProducto.GetSQLText +
               ' order by envase_e'
    end
    else
    begin
      result:= 'select envase_e, descripcion_e from frf_envases where empresa_e = ' +
             eEmpresa.GetSQLText + ' order by envase_e'
    end;
  end
  else
  begin
    result:= 'select envase_e, descripcion_e from frf_envases order by envase_e';
  end;
end;

function TFLListPackingOrden.eClienteGetSQL: String;
begin
  if eEmpresa.Text <> '' then
    result:= 'select cliente_c, nombre_c from frf_clientes where empresa_c = ' +
             eEmpresa.GetSQLText + ' order by cliente_c'
  else
    result:= 'select cliente_c, nombre_c from frf_clientes order by envase_e';
end;

function TFLListPackingOrden.eProductoGetSQL: String;
begin
  if eEmpresa.Text <> '' then
    result:= 'select producto_base_pb, descripcion_pb from frf_productos_base where empresa_pb = ' +
             eEmpresa.GetSQLText + ' order by 1'
  else
    result:= 'select producto_base_pb, descripcion_pb from frf_productos_base order by 1';
end;

procedure TFLListPackingOrden.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImprimir.Click;
  end;
end;

procedure TFLListPackingOrden.eEmpresaChange(Sender: TObject);
begin
  if Trim(eEmpresa.Text) = '' then
  begin
    stEmpresa.Caption:= '(Falta código de la empresa)';
  end
  else
  begin
    stEmpresa.Caption:= desEmpresa( eEmpresa.Text );
  end;

  eEnvaseChange( eEnvase );
end;

procedure TFLListPackingOrden.eEnvaseChange(Sender: TObject);
begin
  if Trim(eEnvase.Text) = '' then
  begin
    stEnvase.Caption:= '(Vacio muestra todos los envases)';;
  end
  else
  begin
    stEnvase.Caption:= desEnvase( eEmpresa.Text, eEnvase.Text );
  end;
end;

procedure TFLListPackingOrden.eClienteChange(Sender: TObject);
begin
  if Trim(eCliente.Text) = '' then
  begin
    stCliente.Caption:= '(Vacio muestra todos los clientes)';;
  end
  else
  begin
    stCliente.Caption:= desCliente( eEmpresa.Text, eCliente.Text );
  end;
end;

procedure TFLListPackingOrden.eProductoChange(Sender: TObject);
begin
  if Trim(eProducto.Text) = '' then
  begin
    lblProducto.Caption:= '(Vacio muestra todos los productos)';;
  end
  else
  begin
    lblProducto.Caption:= desProductoBase( eEmpresa.Text, eProducto.Text );
  end;
end;

end.
