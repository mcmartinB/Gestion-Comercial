unit LVentasLineaProductoCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Provider, DB, DBClient, DBTables, Grids,
  DBGrids,  ActnList, ComCtrls, BCalendario, BGrid, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, nbEdits, nbCombos, nbButtons,
  ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlue, dxSkinBlueprint, dxSkinFoggy,
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
  TFLVentasLineaProductoCliente = class(TForm)
    btnCancel: TBitBtn;
    btnOk: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label14: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    STEmpresa: TStaticText;
    STProducto: TStaticText;
    cbxNacionalidad: TComboBox;
    empresa: TnbDBSQLCombo;
    producto: TnbDBSQLCombo;
    edtCentroOrigen: TnbDBSQLCombo;
    edtCentroSalida: TnbDBSQLCombo;
    edtCliente: TnbDBSQLCombo;
    fechaDesde: TnbDBCalendarCombo;
    fechaHasta: TnbDBCalendarCombo;
    pais: TnbDBSQLCombo;
    categoria: TnbDBAlfa;
    Label9: TLabel;
    Label15: TLabel;
    stCliente: TStaticText;
    stOrigen: TStaticText;
    stSalida: TStaticText;
    stEnvase: TStaticText;
    lblDesCalibre: TLabel;
    Calibre: TBEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    pnlTipoFactura: TPanel;
    rbFechaSalidas: TRadioButton;
    rbFechaFacturas: TRadioButton;
    cbbUno: TComboBox;
    cbbDos: TComboBox;
    cbbTres: TComboBox;
    lbl1: TLabel;
    chkAbonos: TCheckBox;
    chkSoloManuales: TCheckBox;
    chkEnvase: TCheckBox;
    chkSecciones: TCheckBox;
    rbTodos: TRadioButton;
    rbFacturados: TRadioButton;
    rbSinFacturar: TRadioButton;
    lbl5: TLabel;
    cbbClienteFac: TComboBox;
    chkComisiones: TCheckBox;
    chkDescuentos: TCheckBox;
    chkGastosFac: TCheckBox;
    chkGastosNoFac: TCheckBox;
    lbl6: TLabel;
    btnAddProducto: TSpeedButton;
    btnSubProducto: TSpeedButton;
    btnClearProducto: TSpeedButton;
    txtLista: TStaticText;
    lblTipoCliente: TLabel;
    edtTipoCliente: TnbDBSQLCombo;
    txtTipoCliente: TStaticText;
    chkExcluirTipoCliente: TCheckBox;
    chkPromedios: TCheckBox;
    btnComer: TButton;
    cbbFuente: TComboBox;
    lbl7: TLabel;
    rgTipoProducto: TRadioGroup;
    chkNoP4h: TCheckBox;
    chkAgrupar1: TCheckBox;
    chkAgrupar2: TCheckBox;
    chkTotal: TCheckBox;
    chkVerTotalesXLS: TCheckBox;
    chkCosteFruta: TCheckBox;
    chkAddEstructura: TCheckBox;
    chkExcluirInterplanta: TCheckBox;
    chkAyudas: TCheckBox;
    chkVerFecha: TCheckBox;
    edtEnvase: TcxTextEdit;
    ssEnvase: TSimpleSearch;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    chkGastosFijos: TCheckBox;
    GroupBox1: TGroupBox;
    lblTipoGasto: TLabel;
    eTipoGasto: TnbDBSQLCombo;
    txtTipoGasto: TStaticText;
    chkExcluirGasto: TCheckBox;
    grupoGasto: TnbDBAlfa;
    Label6: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    function productoGetSQL: string;
    function edtCentroOrigenGetSQL: string;
    function edtClienteGetSQL: string;
    procedure cbxNacionalidadKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure empresaChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
    function edtEnvaseGetSQL: String;
    procedure edtCentroOrigenChange(Sender: TObject);
    procedure edtCentroSalidaChange(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
    procedure edtEnvaseChange(Sender: TObject);
    procedure chkAbonosClick(Sender: TObject);
    procedure rbFechaSalidasClick(Sender: TObject);
    procedure eTipoGastoChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure chkExcluirGastoClick(Sender: TObject);
    procedure btnAddProductoClick(Sender: TObject);
    procedure btnSubProductoClick(Sender: TObject);
    procedure btnClearProductoClick(Sender: TObject);
    function edtTipoClienteGetSQL: String;
    procedure edtTipoClienteChange(Sender: TObject);
    procedure btnComerClick(Sender: TObject);
    procedure cbbFuenteChange(Sender: TObject);
    procedure cbbUnoChange(Sender: TObject);
    procedure cbbDosChange(Sender: TObject);
    procedure cbbTresChange(Sender: TObject);
    procedure edtEnvaseExit(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    bFlagProductos: Boolean;
    sProductos: string;

    sEmpresa, sOrigen, sSalida, sFechaDesde, sFechaHasta, sEnvase, sCliente, sTipoCliente, 
      sProducto, sPais, sCategoria, sCalibre, sTipoGasto, sGrupoGasto: string;
    bExcluirTipoCliente, bExcluirInterplanta, bFechaSalida, bFactManuales, bSoloManuales, bComisiones , bDescuentos ,
      bGastosNoFac, bGastosFac, bExcluirGasto, bCosteEnvase, bCosteSecciones, bGastosFijos: boolean;
    iClienteFac, iAlbFacturado: integer;

    sUno, sDos, sTres: string;
    bTotalNivel1, bTotalNivel2, bTotal, bVerTotales: boolean;


    function  ValidarEntrada: boolean;
    procedure AddProducto( const AOperator: string );
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


uses UDMConfig, DPreview, Principal,
     CVariables, CGestionPrincipal, UDMAuxDB, CReportes, bTimeUtils,
     ResumenListFobDM, CGlobal, UDMMaster, bTextUtils;

procedure TFLVentasLineaProductoCliente.FormCreate(Sender: TObject);

begin
  FormType := tfOther;
  BHFormulario;
  DMResumenListFob := TDMResumenListFob.Create(self);

  if CGlobal.gProgramVersion = CGlobal.pvSAT then
  begin
    empresa.Text := 'SAT';
    cbbFuente.Items.Clear;
    cbbFuente.Items.Add('Gestión Comercial SAT');
    cbbFuente.Items.Add('Comercial SAT + BAG');
  end
  else
  begin
    empresa.Text := 'BAG';
    cbbFuente.Items.Clear;
    cbbFuente.Items.Add('Gestión Comercial BAG');
    cbbFuente.Items.Add('Comercial BAG + SAT');
  end;
  cbbFuente.ItemIndex:= 0;

  eTipoGastoChange( eTipoGasto );

  fechaDesde.AsDate := LunesAnterior( Date - 7 );
  fechaHasta.AsDate := fechaDesde.AsDate + 6;

  Calibre.Text:= '';
  bFlagProductos:= false;
  sProductos:= '';
  edtTipoCliente.Text:= '';
  edtTipoClientechange( edtTipoCliente );

  cbbUno.ItemIndex:= 2;
  cbbUnoChange( cbbUno );
  cbbDos.ItemIndex:= 3;
  cbbDosChange( cbbDos );
end;

procedure TFLVentasLineaProductoCliente.FormActivate(Sender: TObject);
begin
  Top:= 1;
end;

procedure TFLVentasLineaProductoCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');

  //Liberamos memoria
  FreeAndNil(DMResumenListFob);
  Action := caFree;
end;


function TFLVentasLineaProductoCliente.ValidarEntrada: boolean;
var
  sAux: string;
  dIni, dFin: TDateTime;
begin
  result:= True;
  sAux:= '';
  if cbbfuente.ItemIndex = 0 then
  begin
    if STEmpresa.Caption = '' then
    begin
      result:= False;
      sAux:= sAux + #13 + #10 + 'Falta o es incorrecto el código de la empresa.';
    end;
  end;
  if STProducto.Caption = '' then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'El código del producto es incorrecto.';
  end;
  if stOrigen.Caption = '' then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'El código del centro origen es incorrecto.';
  end;
  if stSalida.Caption = '' then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'El código del centro salida es incorrecto.';
  end;
  if stEnvase.Caption = '' then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'El código del artículo es incorrecto.';
  end;
  if stCliente.Caption = '' then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'El código del cliente es incorrecto.';
  end;
  if txtTipoCliente.Caption = '' then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'El código del tipo cliente es incorrecto.';
  end;
  if txtTipoGasto.Caption = '' then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'El código del tipo de gasto es incorrecto.';
  end;
  dini:= date;
  dfin:= date;
  if not TryStrTodate( fechaDesde.Text, dIni ) then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'Fecha de inicio incorrecta.';
  end;
  if not TryStrTodate( fechaHasta.Text, dFin ) then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'Fecha de fin incorrecta.';
  end;
  if dIni > dFin then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'Rango de fechas incorrecto.';
  end;

  bGastosNoFac:= chkGastosNoFac.checked;
  bGastosFac:= chkGastosFac.checked;

  if bGastosNoFac or bGastosFac then
  begin
    sTipoGasto:= eTipoGasto.Text;
    sGrupoGasto:= GrupoGasto.Text;
    bExcluirGasto:= chkExcluirGasto.checked;
    if bExcluirGasto and ( (sTipoGasto = '') and (sGrupoGasto = '') ) then
    begin
      result:= False;
      sAux:= sAux + #13 + #10 + 'Falta tipo de de gasto a ignorar.';
    end;
    if (sTipoGasto <> '') and (sGrupoGasto <> '') then
    begin
      result:= False;
      sAux:= sAux + #13 + #10 + 'ATENCION! En Tipo Gasto solo puede seleccionar un tipo de filtro.';
    end;
  end
  else
  begin
    sTipoGasto:= '';
    sGrupoGasto:='';
    bExcluirGasto:= False;
  end;

  if result then
  begin
    sEmpresa:= empresa.Text;
    sOrigen:= edtCentroOrigen.Text;
    sSalida:= edtCentroSalida.Text;
    sFechaDesde:= fechaDesde.Text;
    sFechaHasta:= fechaHasta.Text;
    sEnvase:= edtEnvase.Text;
    sCliente:= edtCliente.Text;
    sTipoCliente:= edtTipoCliente.Text;
    bExcluirTipoCliente:= chkExcluirTipoCliente.checked;
    bExcluirInterplanta:= chkExcluirInterplanta.checked;
    if sProductos <> '' then
      sProducto:= txtLista.Caption
    else
      sProducto := producto.Text;
    sPais := pais.Text;
    if sPais = '' then
    begin
      case cbxNacionalidad.ItemIndex of
        1: sPais := 'NACIONAL';
        2: sPais := 'EXTRANJERO';
      end;
    end;

    sCategoria:= Trim(categoria.Text);
    sCalibre:= Trim(Calibre.Text);
    sGrupoGasto:=Trim(grupoGasto.Text);


    bFechaSalida:= rbFechaSalidas.Checked;
    bDescuentos:= chkDescuentos.checked;
    bComisiones:= chkComisiones.checked;
    bCosteEnvase:= chkEnvase.checked;
    bCosteSecciones:= chkSecciones.checked;
    bFactManuales:= chkAbonos.Checked;
    bSoloManuales:= chkSoloManuales.Checked;
    bGastosFijos:=chkGastosFijos.Checked;

    if rbTodos.Checked then
      iAlbFacturado:= -1
    else
    if rbSinFacturar.Checked then
      iAlbFacturado:= 0
    else
    if rbFacturados.Checked then
      iAlbFacturado:= 1;

    iClienteFac:= cbbClienteFac.ItemIndex;
  end
  else
  begin
    ShowMessage( sAux );
  end;


  bTotalNivel1:= chkAgrupar1.Checked and chkAgrupar1.Enabled;
  bTotalNivel2:= chkAgrupar2.Checked and chkAgrupar2.Enabled;
  bTotal:= chkTotal.Checked;
  bVerTotales:= chkVerTotalesXLS.Checked;

  if cbbUno.ItemIndex <> 0 then
  begin
    sUno:= cbbUno.Items[cbbUno.ItemIndex];
    if cbbDos.ItemIndex <> 0 then
    begin
      sDos:= cbbDos.Items[cbbDos.ItemIndex];
      if cbbTres.ItemIndex <> 0 then
      begin
        sTres:= cbbTres.Items[cbbTres.ItemIndex];
      end
      else
      begin
        sTres:= '';
      end;
    end
    else
    begin
      sDos:= '';
      sTres:= '';
    end;
  end
  else
  begin
    sUno:= '';
    sDos:= '';
    sTres:= '';
  end;
end;

procedure TFLVentasLineaProductoCliente.btnOkClick(Sender: TObject);
var
  AAlbaran, ACalibre: string;
  ANoP4H: boolean;
  AProcedencia, AEsHortaliza, ACondicionPrecio: Integer;
  APromedio, ACosteFruta, AAyudas, ACosteEstructura, AAlb6Digitos, ASuministro, AVerFecha : Boolean;
  APrecio: real;
begin
  AProcedencia:= 0;//Indiferente
  AEsHortaliza:= rgTipoProducto.itemindex;
  ANoP4H:= chkNoP4h.checked;
  APromedio:= chkPromedios.Checked;
  AAlb6Digitos:= False;
  ASuministro:= False;
  AAlbaran:= '';
  ACalibre:= '';
  ACondicionPrecio:= 0;
  APrecio:= 0;
  ACosteFruta:= chkCosteFruta.checked;
  AAyudas:= chkAyudas.checked;
  ACosteEstructura:= chkAddEstructura.checked;
  AVerFecha:= chkVerFecha.Checked;

  if ValidarEntrada then
  begin
    if not DMResumenListFob.ListResumenFobExec( cbbFuente.ItemIndex,
                           bFactManuales, bSoloManuales, ACondicionPrecio, APrecio,
                           sUno, sDos, sTres, bTotalNivel1, bTotalNivel2, bTotal, bVerTotales,
                           sEmpresa, sOrigen, sSalida, AAlbaran, sFechaDesde, sFechaHasta,
                           sEnvase, sCliente, sTipoCliente, sProducto, sPais, sCategoria, ACalibre, sTipoGasto, sGrupoGasto, bExcluirTipoCliente, bExcluirInterplanta,
                           ASuministro, bFechaSalida, bComisiones, bDescuentos, bGastosNoFac, bGastosFac, bGastosFijos,
                           AAlb6Digitos, bExcluirGasto, bCosteEnvase, bCosteSecciones, APromedio, ACosteFruta, AAyudas, ACosteEstructura, ANoP4H, AVerFecha,
                           AProcedencia, AEsHortaliza,  iClienteFac, iAlbFacturado ) then
    begin
      ShowMessage('Sin Datos.');
    end;
  end;
end;

procedure TFLVentasLineaProductoCliente.btnCancelClick(Sender: TObject);
begin
  Close;
end;

function TFLVentasLineaProductoCliente.productoGetSQL: string;
begin
  result := 'select producto_p, descripcion_p from frf_productos order by producto_p ';
end;

function TFLVentasLineaProductoCliente.edtCentroOrigenGetSQL: string;
begin
  if empresa.Text <> '' then
    result := 'select centro_c, descripcion_c from frf_centros where empresa_c = ' +
      empresa.GetSQLText + ' order by centro_c '
  else
    result := 'select centro_c, descripcion_c from frf_centros order by centro_c ';
end;

function TFLVentasLineaProductoCliente.edtEnvaseGetSQL: String;
begin
  result := 'select envase_e, descripcion_e from frf_envases order by envase_e ';
end;

function TFLVentasLineaProductoCliente.edtClienteGetSQL: string;
begin
  result := 'select cliente_c, nombre_c from frf_clientes order by cliente_c ';
end;

procedure TFLVentasLineaProductoCliente.cbxNacionalidadKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_return then PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
end;

procedure TFLVentasLineaProductoCliente.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if edtEnvase.Focused then
  begin
    case key of
      vk_Return, vk_down:
        begin
          Key := 0;
          PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        end;
    end;
  end;
end;

procedure TFLVentasLineaProductoCliente.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  if Key = vk_f1 then btnOk.Click else
//    if Key = vk_escape then btnCancel.Click;
end;

procedure TFLVentasLineaProductoCliente.empresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(empresa.Text);
  productoChange( producto );
  edtCentroOrigenChange( edtCentroOrigen );
  edtCentroSalidaChange( edtCentroSalida );
  edtClienteChange( edtCliente  );
  edtEnvaseChange( edtEnvase );
end;

procedure TFLVentasLineaProductoCliente.productoChange(Sender: TObject);
begin

  if producto.Text = '' then
  begin
    STProducto.Caption := 'Vacio todos los productos';
  end
  else
  begin
    STProducto.Caption := desProducto(empresa.Text, producto.Text);
  end;
end;

procedure TFLVentasLineaProductoCliente.edtCentroOrigenChange(Sender: TObject);
begin
  if edtCentroOrigen.Text = '' then
  begin
    stOrigen.Caption:= 'Vacio todos los centros';
  end
  else
  begin
    stOrigen.Caption:= desCentro( empresa.Text, edtCentroOrigen.Text);
  end;
end;

procedure TFLVentasLineaProductoCliente.edtCentroSalidaChange(Sender: TObject);
begin
  if edtCentroSalida.Text = '' then
  begin
    stSalida.Caption:= 'Vacio todos los centros';
  end
  else
  begin
    stSalida.Caption:= desCentro( empresa.Text, edtCentroSalida.Text);
  end;
end;

procedure TFLVentasLineaProductoCliente.edtClienteChange(Sender: TObject);
begin
  if edtCliente.Text = '' then
  begin
    stCliente.Caption:= 'Vacio todos los clientes';
  end
  else
  begin
    stCliente.Caption:= desCliente( edtCliente.Text);
  end;
end;

procedure TFLVentasLineaProductoCliente.edtEnvaseChange(Sender: TObject);
begin
  if edtEnvase.Text = '' then
  begin
    stEnvase.Caption:= 'Vacio todos los articulos';
  end
  else
  begin
    stEnvase.Caption:= desEnvase( empresa.Text, edtEnvase.Text);
  end;
end;

procedure TFLVentasLineaProductoCliente.eTipoGastoChange(Sender: TObject);
begin
  if eTipoGasto.Text = '' then
  begin
    txtTipoGasto.Caption:= 'Vacio todos los tipos de gasto';
  end
  else
  begin
    txtTipoGasto.Caption:= desTipoGastos( eTipoGasto.Text);
  end;
end;

procedure TFLVentasLineaProductoCliente.chkAbonosClick(Sender: TObject);
begin
  if chkAbonos.Checked then
  begin
    chkSoloManuales.Enabled:= True;
  end
  else
  begin
    chkSoloManuales.Enabled:= False;
    chkSoloManuales.Checked:= False;
  end;
end;

procedure TFLVentasLineaProductoCliente.rbFechaSalidasClick(Sender: TObject);
begin
  if rbFechaSalidas.Checked then
  begin
    rbTodos.Enabled:= True;
    rbFacturados.Enabled:= True;
    rbSinFacturar.Enabled:= True;
  end
  else
  begin
    if not rbFacturados.Checked then
      rbFacturados.Checked:= True;
    rbTodos.Enabled:= False;
    rbFacturados.Enabled:= True;
    rbSinFacturar.Enabled:= False;
  end;
end;

procedure TFLVentasLineaProductoCliente.ssEnvaseAntesEjecutar(Sender: TObject);
begin
    ssEnvase.SQLAdi := '';
    if Producto.Text <> '' then
      ssEnvase.SQLAdi := ' producto_e = ' +  QuotedStr(Producto.Text);
end;

procedure TFLVentasLineaProductoCliente.chkExcluirGastoClick(Sender: TObject);
begin
  if not chkExcluirGasto.Checked then
  begin
    eTipoGasto.Text:= '';
    grupoGasto.Text:= '';
  end;
end;

procedure TFLVentasLineaProductoCliente.edtEnvaseExit(Sender: TObject);
begin
  if EsNumerico(edtEnvase.Text) and (Length(edtEnvase.Text) <= 5) then
    if (edtEnvase.Text <> '' ) and (Length(edtEnvase.Text) < 9) then
      edtEnvase.Text := 'COM-' + Rellena( edtEnvase.Text, 5, '0');
end;

procedure TFLVentasLineaProductoCliente.btnAddProductoClick(
  Sender: TObject);
begin
  bFlagProductos:= True;
  AddProducto( '+' );
end;

procedure TFLVentasLineaProductoCliente.btnSubProductoClick(
  Sender: TObject);
begin
  bFlagProductos:= True;
  AddProducto( '-' );
end;

procedure TFLVentasLineaProductoCliente.btnClearProductoClick(
  Sender: TObject);
begin
  bFlagProductos:= False;
  txtLista.Caption:= '';
  sProductos:= '';
end;

function AddValor( const ALista, AValor: string ): string;
begin
  if ALista = '' then
  begin
     Result:= QuotedStr( AValor );
  end
  else
  begin
    if Pos( AValor, ALista ) = 0 then
    begin
      Result:= ALista + ', ' + QuotedStr( AValor );
    end
    else
    begin
      Result:= ALista;
    end;
  end;
end;

procedure TFLVentasLineaProductoCliente.AddProducto( const AOperator: string );
begin
  if ( STProducto.Caption = '' ) and ( producto.Text = '' ) then
  begin
    ShowMessage('Seleccione un cliente valido');
  end
  else
  begin
    sProductos:= AddValor( sProductos, producto.Text );
    txtLista.Caption:= AOperator + ' ( ' + sProductos +' )';
  end;
end;

function TFLVentasLineaProductoCliente.edtTipoClienteGetSQL: String;
begin
    result := 'select * from frf_cliente_tipos order by codigo_ctp';
end;

procedure TFLVentasLineaProductoCliente.edtTipoClienteChange(
  Sender: TObject);
begin
  if edtTipoCliente.Text = '' then
  begin
    txtTipoCliente.Caption:= 'Vacio todos los tipos de cliente';
  end
  else
  begin
    txtTipoCliente.Caption:= desTipoCliente( edtTipoCliente.Text );
  end;
end;

procedure TFLVentasLineaProductoCliente.btnComerClick(Sender: TObject);
begin
  categoria.Text:= '1,2,3';
end;

procedure TFLVentasLineaProductoCliente.cbbFuenteChange(Sender: TObject);
begin
  if cbbFuente.ItemIndex = 0 then
  begin
    empresa.enabled:= true;
    if CGlobal.gProgramVersion = CGlobal.pvSAT then
    begin
      empresa.Text := 'SAT';
    end
    else
    begin
      empresa.Text := 'BAG';
    end;
  end
  else
  begin
    empresa.enabled:= False;
    empresa.Text:= '';
  end;
end;

procedure TFLVentasLineaProductoCliente.cbbUnoChange(Sender: TObject);
begin
  if cbbUno.ItemIndex = 0 then
  begin
    if cbbDos.ItemIndex <> 0 then
    begin
      cbbDos.ItemIndex:= 0;
      cbbDosChange( cbbDos );
    end;
    chkAgrupar1.Caption:= 'Sin totalizar ';
  end
  else
  begin
    chkAgrupar1.Caption:= 'Totalizar ' +  cbbUno.Items[cbbUno.ItemIndex];
  end;
end;

procedure TFLVentasLineaProductoCliente.cbbDosChange(Sender: TObject);
begin
  if cbbUno.ItemIndex = 0 then
  begin
    cbbDos.ItemIndex:= 0;
  end;

  if cbbDos.ItemIndex = 0 then
  begin
    if cbbTres.ItemIndex <> 0 then
    begin
      cbbTres.ItemIndex:= 0;
      cbbTresChange( cbbTres );
    end;
    chkAgrupar1.Enabled:= false;
    chkAgrupar2.Caption:= 'Sin totalizar ';
  end
  else
  begin
    chkAgrupar1.Enabled:= True;
    chkAgrupar2.Caption:= 'Totalizar ' +  cbbDos.Items[cbbDos.ItemIndex];
  end;
end;

procedure TFLVentasLineaProductoCliente.cbbTresChange(Sender: TObject);
begin
  if cbbDos.ItemIndex = 0 then
  begin
    cbbTres.ItemIndex:= 0;
  end;

  if cbbTres.ItemIndex = 0 then
  begin
    chkAgrupar2.Enabled:= false;
  end
  else
  begin
    chkAgrupar2.Enabled:= True;
  end;
end;

end.

