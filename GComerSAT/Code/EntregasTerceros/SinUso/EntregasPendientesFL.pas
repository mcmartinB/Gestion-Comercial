unit EntregasPendientesFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit;

type
  TFLEntregasPendientes = class(TForm)
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
    eSemana: TBEdit;
    lblSemana: TLabel;
    lblProducto: TnbLabel;
    edtProducto: TnbDBSQLCombo;
    stProducto: TLabel;
    lblEstadoEntrega: TnbLabel;
    cbbEstadoEntrega: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    function centroGetSQL: String;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure empresaChange(Sender: TObject);
    procedure centroChange(Sender: TObject);
    function edtProductoGetSQL: String;
    procedure edtProductoChange(Sender: TObject);
  private
    { Private declarations }
    procedure ValidarCampos;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB, DPreview, UDMBaseDatos,
     UDMConfig, EntregasPendientesQL, EntregasPendientesMasetQL;

procedure TFLEntregasPendientes.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  empresa.Text:= gsDefEmpresa;
  centro.Text:= gsDefCentro;

  eDesde.Text:= '';
  eHasta.Text:= '';

  eSemana.Enabled:= DMConfig.EsLaFont;
  lblSemana.Visible:= eSemana.Enabled;
end;

procedure TFLEntregasPendientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLEntregasPendientes.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLEntregasPendientes.ValidarCampos;
var
  dIni, dFin: TDateTime;
  bRango: Boolean;
begin
  if Trim(empresa.Text) = '' then
  begin
    empresa.SetFocus;
    raise Exception.Create('Falta el codigo de la empresa que es de obligada inserción.');
  end;

  if Trim(centro.Text) = '' then
  begin
    centro.SetFocus;
    raise Exception.Create('Falta el codigo del centro que es de obligada inserción.');
  end;

  if Trim(stProducto.Caption) = '' then
  begin
    edtProducto.SetFocus;
    raise Exception.Create('El codigo del producto es incorrecto.');
  end;

  //validar fechas
  bRango:= False;
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
    bRango:= True;
  end;

  if  cbbEstadoEntrega.ItemIndex <> 0 then
  begin
    if ( eSemana.Text = '' ) and ( not bRango ) then
    begin
      eDesde.SetFocus;
      if eSemana.Enabled  then
        raise Exception.Create('En el caso de no seleccionar las entregas pendientes de descargar en necesario un rango de fechas o semana para acotar los resultados.')
      else
        raise Exception.Create('En el caso de no seleccionar las entregas pendientes de descargar en necesario un rango de fechas para acotar los resultados.');
    end;
  end;
end;


procedure TFLEntregasPendientes.btnImprimirClick(Sender: TObject);
begin
  ValidarCampos;
  begin
    if not EntregasPendientesQL.VerListadoEntregasPendientes( self, empresa.Text, centro.Text, edtProducto.Text,
                                                              eDesde.Text, eHasta.Text, cbbEstadoEntrega.ItemIndex ) then
      ShowMEssage('No hay entregas pendientes para los parametros usados.');
  end;
end;


function TFLEntregasPendientes.centroGetSQL: String;
begin
  if Empresa.Text <> '' then
    result:= 'select centro_c, descripcion_c from frf_centros where empresa_c = ' +
             Empresa.GetSQLText + ' order by centro_c'
  else
    result:= 'select centro_c, descripcion_c from frf_centros order by centro_c';
end;

procedure TFLEntregasPendientes.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImprimir.Click;
  end;
end;

procedure TFLEntregasPendientes.empresaChange(Sender: TObject);
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
    stEmpresa.Caption:= '(Falta código de la empresa)';
  end;
  centroChange( centro );
end;

procedure TFLEntregasPendientes.centroChange(Sender: TObject);
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
    stCentro.Caption:= '(Falta código del centro)';
  end;
end;

function TFLEntregasPendientes.edtProductoGetSQL: String;
begin
  if Empresa.Text <> '' then
    result:= 'select producto_p, descripcion_p from frf_productos where empresa_p = ' +
             Empresa.GetSQLText + ' order by producto_p'
  else
    result:= 'select producto_p, descripcion_p from frf_productos order by producto_p';
end;

procedure TFLEntregasPendientes.edtProductoChange(Sender: TObject);
var
  sAux: string;
begin
  sAux:= desProducto( empresa.Text, edtProducto.Text );
  if sAux <> '' then
  begin
    stProducto.Caption:= sAux;
  end
  else
  begin
    stProducto.Caption:= '(Vacio todos los productos)';
  end;
end;

end.
