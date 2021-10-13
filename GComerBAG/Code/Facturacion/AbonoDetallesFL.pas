unit AbonoDetallesFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, dxSkinsCore, dxSkinBlue,
  dxSkinBlueprint, dxSkinFoggy, dxSkinMoneyTwins, cxButtons, SimpleSearch,
  cxControls, cxContainer, cxEdit, cxTextEdit;

type
  TFLAbonoDetalles = class(TForm)
    btnCerrar: TBitBtn;
    btnImprimir: TBitBtn;
    lblEmpresa: TnbLabel;
    nbLabel2: TnbLabel;
    stEmpresa: TLabel;
    stEnvase: TLabel;
    eEmpresa: TnbDBSQLCombo;
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
    cbxdAnulaciones: TCheckBox;
    lblNombre1: TLabel;
    ssEnvase: TSimpleSearch;
    eEnvase: TcxTextEdit;
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
    procedure eEnvaseExit(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    dFechaIni, dFechaFin: TDateTime;

    procedure ValidarCampos;
    procedure CanAnulaciones;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB,
     DPreview, UDMBaseDatos, UDMConfig, AbonoDetallesQL, bTextUtils;

procedure TFLAbonoDetalles.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  eEmpresa.Text:= gsDefEmpresa;
  eFechaDesde.Text:= DateToStr( Date );
  eFechaHasta.Text:= eFechaDesde.Text;

  eEmpresa.ReadOnly:= not DMConfig.EsLaFont;
  if eEmpresa.Enabled then
    eEmpresa.Text:= gsDefEmpresa;
end;

procedure TFLAbonoDetalles.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLAbonoDetalles.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLAbonoDetalles.ValidarCampos;
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


procedure TFLAbonoDetalles.btnImprimirClick(Sender: TObject);
begin
  ValidarCampos;
  if not AbonoDetallesQL.VerListadoOrden( self, Trim(eEmpresa.Text), Trim(eProducto.Text),
           Trim(eEnvase.Text), Trim(eCliente.Text), dFechaIni, dFechaFin, cbxdAnulaciones.Checked ) then
    ShowMEssage('Sin datos para los parametros usados.');
end;


function TFLAbonoDetalles.eEnvaseGetSQL: String;
begin
  if eProducto.Text <> '' then
  begin
    result:= 'select envase_e, descripcion_e from frf_envases ' +
             ' where producto_e = ' + eProducto.GetSQLText + ' ) ' +
             ' order by envase_e ';
  end
  else
  begin
    result:= 'select envase_e, descripcion_e from frf_envases order by envase_e';
  end;
end;

function TFLAbonoDetalles.eClienteGetSQL: String;
begin
  result:= 'select cliente_c, nombre_c from frf_clientes order by cliente_c';
end;

function TFLAbonoDetalles.eProductoGetSQL: String;
begin
  result:= 'select producto_p, descripcion_p from frf_productos order by 1';
end;

procedure TFLAbonoDetalles.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{
  case key of
    $0D, $28: //vk_return,vk_down
    begin
      Key := 0;
      PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      Exit;
    end;
    vk_ESCAPE:
    begin
//      if ssEnvase.Enabled then ssEnvaseExit(Self);
    end;
  end;
  }
end;

procedure TFLAbonoDetalles.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  {
  case Key of
    Vk_escape:
      begin
        Key := 0;
        btnCerrar.Click;
      end;

    vk_f1: btnImprimir.Click;
  end;
  }
end;

procedure TFLAbonoDetalles.ssEnvaseAntesEjecutar(Sender: TObject);
begin
    ssEnvase.SQLAdi := '';
    if eProducto.GetSQLText <> '' then
      ssEnvase.SQLAdi := ' producto_e = ' + eProducto.GetSQLText;
end;

procedure TFLAbonoDetalles.eEmpresaChange(Sender: TObject);
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

procedure TFLAbonoDetalles.eEnvaseChange(Sender: TObject);
begin
  if Trim(eEnvase.Text) = '' then
  begin
    stEnvase.Caption:= '(Vacio muestra todos los artículos)';;
  end
  else
  begin
    stEnvase.Caption:= desEnvaseP( eEmpresa.Text, eEnvase.Text, eProducto.Text );
  end;
  CanAnulaciones;
end;

procedure TFLAbonoDetalles.eEnvaseExit(Sender: TObject);
begin
  if EsNumerico(eEnvase.Text) and (Length(eEnvase.Text) <= 5) then
    if (eEnvase.Text <> '' ) and (Length(eEnvase.Text) < 9) then
      eEnvase.Text := 'COM-' + Rellena( eEnvase.Text, 5, '0');
end;

procedure TFLAbonoDetalles.eClienteChange(Sender: TObject);
begin
  if Trim(eCliente.Text) = '' then
  begin
    stCliente.Caption:= '(Vacio muestra todos los clientes)';;
  end
  else
  begin
    stCliente.Caption:= desCliente( eCliente.Text );
  end;
end;

procedure TFLAbonoDetalles.eProductoChange(Sender: TObject);
begin
  if Trim(eProducto.Text) = '' then
  begin
    lblProducto.Caption:= '(Vacio muestra todos los productos)';;
  end
  else
  begin
    lblProducto.Caption:= desProducto( eEmpresa.Text, eProducto.Text );
  end;
  CanAnulaciones;
end;

procedure TFLAbonoDetalles.CanAnulaciones;
begin
  if ( Trim( eProducto.Text ) = '' ) and ( Trim( eEnvase.Text ) = '' ) then
  begin
    cbxdAnulaciones.Enabled:= True;
  end
  else
  begin
    cbxdAnulaciones.Enabled:= False;
    cbxdAnulaciones.Checked:= False;
  end;
end;

end.
