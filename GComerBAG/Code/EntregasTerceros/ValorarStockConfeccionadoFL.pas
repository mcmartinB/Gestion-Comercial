unit ValorarStockConfeccionadoFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit, ExtCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinBlue, dxSkinBlueprint, dxSkinFoggy,
  dxSkinMoneyTwins, Menus, cxButtons, SimpleSearch, cxTextEdit, dxSkinBlack,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue;

type
  TFLValorarStockConfeccionado = class(TForm)
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
    stCliente: TLabel;
    lblProveedor: TnbLabel;
    lblVariedad: TnbLabel;
    eCliente: TnbDBSQLCombo;
    stEnvase: TLabel;
    lblFechaStock: TnbLabel;
    eFechaStock: TnbDBCalendarCombo;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl1: TLabel;
    chkVerDetalle: TCheckBox;
    lbl4: TLabel;
    eEnvase: TcxTextEdit;
    ssEnvase: TSimpleSearch;
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
    function eClienteGetSQL: String;
    function eEnvaseGetSQL: String;
    procedure eClienteChange(Sender: TObject);
    procedure eEnvaseChange(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
    procedure eEnvaseExit(Sender: TObject);
  private
    { Private declarations }
    dFecha: TDateTime;
    sEmpresa, sCentro,  sProducto, sCliente, sEnvase: string;

    procedure ValidarCampos;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB,
     DPreview, UDMBaseDatos, ValorarStockConfeccionadoQL, bTextUtils;

procedure TFLValorarStockConfeccionado.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  eFechaStock.Text:= FormatDateTime( 'dd/mm/yyyy', Date - 1 );
end;

procedure TFLValorarStockConfeccionado.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLValorarStockConfeccionado.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLValorarStockConfeccionado.ValidarCampos;
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
      raise Exception.Create('El código de la empresa es incorrecto.');
    end;
    if eEmpresa.Text <> '' then
    begin
      if stCentro.Caption = '' then
      begin
        eCentro.SetFocus;
        raise Exception.Create('El código del centro es incorrecto.');
      end;

      if stProducto.Caption = '' then
      begin
        eProducto.SetFocus;
        raise Exception.Create('El código del producto es incorrecto.');
      end;

      if stCliente.Caption = '' then
      begin
        eCliente.SetFocus;
        raise Exception.Create('El código del cliente es incorrecto.');
      end;

      if eProducto.Text <> '' then
      begin
        if stProducto.Caption = '' then
        begin
          eProducto.SetFocus;
          raise Exception.Create('El código del producto es incorrecto.');
        end;
      end;
    end;
  end;

  sEmpresa:= eEmpresa.Text;
  sCentro:= eCentro.Text;
  sProducto:= eProducto.Text;
  sCliente:= eCliente.Text;
  sEnvase:= eEnvase.Text;
end;


procedure TFLValorarStockConfeccionado.btnImprimirClick(Sender: TObject);
begin
  Label3.Visible:= True;
  Application.ProcessMessages;
  try
    ValidarCampos;
    if not ValorarStockConfeccionadoQL.VerListadoStock( self, sEmpresa, sCentro, dFecha,
             sProducto, sCliente, sEnvase, chkVerDetalle.Checked ) then
        ShowMEssage('Sin Stock para los parametros usados.');
  finally
    Label3.Visible:= False;
    Application.ProcessMessages;
  end;
end;

procedure TFLValorarStockConfeccionado.eEnvaseExit(Sender: TObject);
begin
  if EsNumerico(eEnvase.Text) and (Length(eEnvase.Text) <= 5) then
    if (eEnvase.Text <> '' ) and (Length(eEnvase.Text) < 9) then
      eEnvase.Text := 'COM-' + Rellena( eEnvase.Text, 5, '0');
end;

function TFLValorarStockConfeccionado.eProductoGetSQL: String;
begin
  result:= 'select producto_p, descripcion_p from frf_productos order by descripcion_p ';
end;

function TFLValorarStockConfeccionado.eCentroGetSQL: String;
begin
  if eEmpresa.Text <> '' then
    result:= 'select centro_c, descripcion_c from frf_centros where empresa_c = ' +
             eEmpresa.GetSQLText + ' order by centro_c'
  else
    result:= 'select centro_c, descripcion_c from frf_centros order by centro_c';
end;

function TFLValorarStockConfeccionado.eClienteGetSQL: String;
begin
  result:= 'select cliente_c, nombre_c from frf_clientes order by cliente_c';
end;

function TFLValorarStockConfeccionado.eEnvaseGetSQL: String;
begin
  if eProducto.Text <> '' then
  begin
    result:= 'select envase_e, descripcion_e from frf_envases ' +
             'where producto_e in ( select producto_p from frf_productos where producto_p = ' + eProducto.GetSQLText + ' ) ' +
             ' order by 1,2'
  end
  else
  begin
    result:= 'select envase_e, descripcion_e from frf_envases order by 1,2';
  end;
end;

procedure TFLValorarStockConfeccionado.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImprimir.Click;
  end;
end;

procedure TFLValorarStockConfeccionado.ssEnvaseAntesEjecutar(Sender: TObject);
begin
    ssEnvase.SQLAdi := '';
    if eProducto.GetSQLText <> '' then
      ssEnvase.SQLAdi := ' producto_e = ' + eProducto.GetSQLText;
end;

procedure TFLValorarStockConfeccionado.eEmpresaChange(Sender: TObject);
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
  eClienteChange(eCliente);
end;

procedure TFLValorarStockConfeccionado.eCentroChange(Sender: TObject);
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

procedure TFLValorarStockConfeccionado.eProductoChange(Sender: TObject);
begin
  if Trim(eProducto.Text) = '' then
  begin
    stProducto.Caption:= '(Vacio =Todos los productos)';
  end
  else
  begin
    stProducto.Caption:= desProducto( eEmpresa.Text, eProducto.Text );
  end;
  eEnvaseChange( eEnvase );
end;

procedure TFLValorarStockConfeccionado.eClienteChange(Sender: TObject);
begin
  if Trim(eCliente.Text) = '' then
  begin
    stCliente.Caption:= '(Vacio =Todos los clientes)';
  end
  else
  begin
    stCliente.Caption:= desCliente( eCliente.Text );
  end;
end;

procedure TFLValorarStockConfeccionado.eEnvaseChange(Sender: TObject);
begin
  if Trim(eEnvase.Text) = '' then
  begin
    stEnvase.Caption:= '(Vacio =Todos los articulos)';
  end
  else
  begin
    stEnvase.Caption:= desEnvaseP( eEmpresa.Text, eEnvase.Text, eProducto.Text );
  end;
end;


end.
