unit DatosExcelFOB;

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
  TFDatosExcelFOB = class(TForm)
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
    subPanel1: TPanel;
    Label13: TLabel;
    chkEnvase: TCheckBox;
    chkSecciones: TCheckBox;
    Label15: TLabel;
    cbxAlb6Digitos: TCheckBox;
    stCliente: TStaticText;
    stOrigen: TStaticText;
    stSalida: TStaticText;
    stEnvase: TStaticText;
    lblFacturados: TLabel;
    rbTodos: TRadioButton;
    rbFacturados: TRadioButton;
    rbSinFacturar: TRadioButton;
    lblDesCalibre: TLabel;
    Calibre: TBEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    chkAbonos: TCheckBox;
    chkSoloManuales: TCheckBox;
    lbl4: TLabel;
    pnlTipoFactura: TPanel;
    rbFechaSalidas: TRadioButton;
    rbFechaFacturas: TRadioButton;
    cbbProcedencia: TComboBox;
    cbbEsHortaliza: TComboBox;
    pnlSup: TPanel;
    rbImportes: TRadioButton;
    rbPrecios: TRadioButton;
    lblPrecio: TLabel;
    cbbCompPrecio: TComboBox;
    edtPrecio: TBEdit;
    chkDesgloseCostes: TCheckBox;
    chkPromedios: TCheckBox;
    lblComercial: TLabel;
    edtComercial: TnbDBSQLCombo;
    txtComercial: TStaticText;
    cbbClienteFac: TComboBox;
    chkComisiones: TCheckBox;
    chkDescuentos: TCheckBox;
    chkGastosFac: TCheckBox;
    chkGastosNoFac: TCheckBox;
    chkSuministro: TCheckBox;
    btn1: TButton;
    lblTipoCliente: TLabel;
    edtTipoCliente: TnbDBSQLCombo;
    txtTipoCliente: TStaticText;
    chkExcluirTipoCliente: TCheckBox;
    chkNoP4H: TCheckBox;
    chkExcluirInterplanta: TCheckBox;
    edtEnvase: TcxTextEdit;
    ssEnvase: TSimpleSearch;
    ActionList1: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    chkGastosFijos: TCheckBox;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    grupoGasto: TnbDBAlfa;
    lblTipoGasto: TLabel;
    eTipoGasto: TnbDBSQLCombo;
    txtTipoGasto: TStaticText;
    cbxNoGasto: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    function productoGetSQL: string;
    function edtCentroOrigenGetSQL: string;
    function edtClienteGetSQL: string;
    procedure cbxNacionalidadChange(Sender: TObject);
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
    procedure cbxNoGastoClick(Sender: TObject);
    procedure chkDesgloseCostesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtComercialChange(Sender: TObject);
    function edtComercialGetSQL: String;
    procedure btn1Click(Sender: TObject);
    function edtTipoClienteGetSQL: String;
    procedure edtTipoClienteChange(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
    procedure edtEnvaseExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    sEmpresa, sOrigen, sSalida, sFechaDesde, sFechaHasta, sEnvase, sCliente, sTipoCliente, sComercial,
      sProducto, sPais, sCategoria, sCalibre, sTipoGasto, sGrupoGasto: string;
    bFechaSalida, bFactManuales, bSoloManuales, bComisiones , bDescuentos, bNoP4H, bGastosFijos,
      bExcluirTipoCliente, bExcluirInterplanta, bGastosNoFac, bGastosFac, bNoGasto, bCosteEnvase, bCosteSecciones, bPromedio,  bAlb6Digitos: boolean;
    iClienteFac, iAlbFacturado, iProcedencia, iEsHortaliza, iCondicionPrecio: integer;
    rPrecio: Extended;


    function  ValidarEntrada: boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


uses DatosExcelFOBReport, DatosExcelFOBReportEx, UDMConfig, DPreview, Principal,
     CVariables, CGestionPrincipal, UDMAuxDB, CReportes, bTimeUtils,
     CosteEnvasadoPromedioDM, UDMMaster, TablaListFobDM, CGlobal, MakeFOBData, bTextUtils;


procedure TFDatosExcelFOB.FormShow(Sender: TObject);
var
  iRegistros: integer;
begin
  //calculando promedios
  if CGlobal.gProgramVersion = pvSAT then
  begin
    if CosteEnvasadoPromedioDM.PromedioPendientes( iRegistros ) then
    begin
      //ShowMessage( 'Actualizado el coste promedio de ' + IntToStr( iRegistros ) + ' envases.' )
    end
  end;
end;


procedure TFDatosExcelFOB.FormCreate(Sender: TObject);

begin
  FormType := tfOther;
  BHFormulario;
  DMTablaListFob := TDMTablaListFob.Create(self);

  empresa.Text := gsDefEmpresa;
  if empresa.Text = '050' then
  begin
    eTipoGasto.Text:= '039';
    cbxNoGasto.Checked:= True;
  end
  else
  begin
    eTipoGasto.Text:= '';
    cbxNoGasto.Checked:= False;
  end;
  eTipoGastoChange( eTipoGasto );
  edtTipoCliente.Text:= '';
  edtTipoClientechange( edtTipoCliente );



  fechaDesde.AsDate := LunesAnterior( Date - 7 );
  fechaHasta.AsDate := fechaDesde.AsDate + 6;

  if pais.Enabled then
    TEdit(pais).Color := clWhite
  else
    TEdit(pais).Color := clSilver;

  Calibre.Text:= '';

  btn1.Visible:= Copy( UpperCase( gsCodigo ), 1, 4 ) = 'INFO';
end;

procedure TFDatosExcelFOB.FormActivate(Sender: TObject);
begin
  Top:= 1;
end;

procedure TFDatosExcelFOB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');

  //Liberamos memoria
  FreeAndNil(DMTablaListFob);
  Action := caFree;
end;

function UnidadDist( const AIndex: Integer ): string;
begin
  case AIndex of
  (*
    0: Result:= '';  //grabado en tipo gastos
    1: Result:= 'P'; //Forzar por Palets
    2: Result:= 'C'; //Forzar por Cajas
    3: Result:= 'K'; //Forzar por Kilos
    4: Result:= 'I'; //Forzar por Importe
  *)
    0: Result:= '';  //grabado en tipo gastos
    1: Result:= 'K'; //Forzar por Kilos
  end;
end;

function TFDatosExcelFOB.ValidarEntrada: boolean;
var
  sAux: string;
  dIni, dFin: TDateTime;
begin
  result:= True;
  sAux:= '';
  if STEmpresa.Caption = '' then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'Falta o es incorrecto el código de la empresa.';
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
  if txtComercial.Caption = '' then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'El código del comercial es incorrecto.';
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
    bNoGasto:= cbxNoGasto.checked;
    if bNoGasto  and ( (sTipoGasto = '') and (sGrupoGasto = '') ) then
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
  end;

  if result then
  begin
    sEmpresa:= empresa.Text;
    iProcedencia:= cbbProcedencia.ItemIndex;
    sOrigen:= edtCentroOrigen.Text;
    sSalida:= edtCentroSalida.Text;
    sFechaDesde:= fechaDesde.Text;
    sFechaHasta:= fechaHasta.Text;
    sEnvase:= edtEnvase.Text;
    sCliente:= edtCliente.Text;
    sTipoCliente:= edtTipoCliente.Text;
    bExcluirTipoCliente:= chkExcluirTipoCliente.Checked;
    bExcluirInterplanta:= chkExcluirInterPlanta.Checked;
    sComercial:= edtComercial.Text;
    sProducto := producto.Text;
    iEsHortaliza:= cbbEsHortaliza.ItemIndex;
    bNoP4H:= chkNoP4H.checked;
    case cbxNacionalidad.ItemIndex of
      1: sPais := 'NACIONAL';
      2: sPais := 'EXTRANJERO';
      3: sPais := pais.Text;
      else sPais := '';
    end;
    sCategoria:= Trim(categoria.Text);
    sCalibre:= Trim(Calibre.Text);
    sGrupoGasto:=Trim(grupoGasto.Text);


    bFechaSalida:= rbFechaSalidas.Checked;
    bComisiones:= chkComisiones.checked;
    bDescuentos:= chkDescuentos.checked;
    bCosteEnvase:= chkEnvase.checked;
    bCosteSecciones:= chkSecciones.checked;
    bPromedio:= chkPromedios.checked;
    bAlb6Digitos:= cbxAlb6Digitos.checked;
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

    if TryStrToFloat( edtPrecio.Text, rPrecio ) then
    begin
      iCondicionPrecio:= cbbCompPrecio.ItemIndex + 1;
    end
    else
    begin
      iCondicionPrecio:= 0;
    end;
  end
  else
  begin
    ShowMessage( sAux );
  end;
end;

procedure TFDatosExcelFOB.btnOkClick(Sender: TObject);
var
  AAlbaran: string;
  ASuministro, ADesglose, ACosteFruta, ACosteEstructura: boolean;

 begin
  AAlbaran:= '';
  ASuministro:= False;
  ADesglose:= chkDesgloseCostes.Checked;
  ACosteFruta:= False;
  ACosteEstructura:= False;

  if ValidarEntrada then
  begin
    if not DMTablaListFob.ListResumenFobExec(
                           bFactManuales, bSoloManuales, iCondicionPrecio, rPrecio, sEmpresa, sOrigen, sSalida, AALbaran, sFechaDesde, sFechaHasta,
                            sEnvase, sCliente, sTipoCliente, sProducto, sPais, sCategoria, sCalibre, sTipoGasto, sGrupoGasto, ASuministro,  bFechaSalida,
                            bComisiones, bDescuentos, bGastosNoFac, bGastosFac, bGastosFijos, ADesglose, bAlb6Digitos, bNoGasto, bCosteEnvase, bCosteSecciones,
                            bPromedio, ACosteFruta, ACosteEstructura, bExcluirTipoCliente, bExcluirInterplanta, rbImportes.Checked, bNoP4H, iProcedencia, iEsHortaliza,  iClienteFac, iAlbFacturado ) then
    begin
      ShowMessage('Sin Datos.');
    end;
  end;
end;


procedure TFDatosExcelFOB.btnCancelClick(Sender: TObject);
begin
  Close;
end;

function TFDatosExcelFOB.productoGetSQL: string;
begin
  result := 'select producto_p, descripcion_p from frf_productos order by producto_p ';
end;

function TFDatosExcelFOB.edtCentroOrigenGetSQL: string;
begin
  if empresa.Text <> '' then
    result := 'select centro_c, descripcion_c from frf_centros where empresa_c = ' +
      empresa.GetSQLText + ' order by centro_c '
  else
    result := 'select centro_c, descripcion_c from frf_centros order by centro_c ';
end;

function TFDatosExcelFOB.edtEnvaseGetSQL: String;
begin
  result := 'select envase_e, descripcion_e from frf_envases order by envase_e ';
end;

function TFDatosExcelFOB.edtClienteGetSQL: string;
begin
  result := 'select cliente_c, nombre_c from frf_clientes order by cliente_c ';
end;

function TFDatosExcelFOB.edtComercialGetSQL: String;
begin
  Result := ' select codigo_c, descripcion_c from frf_comerciales order by codigo_c ';
end;

procedure TFDatosExcelFOB.cbxNacionalidadChange(Sender: TObject);
begin
  pais.Enabled := TComboBox(sender).ItemIndex = 3;
  if pais.Enabled then
    TEdit(pais).Color := clWhite
  else
    TEdit(pais).Color := clSilver;
end;

procedure TFDatosExcelFOB.cbxNacionalidadKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_return then PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
end;

procedure TFDatosExcelFOB.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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

procedure TFDatosExcelFOB.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  if Key = vk_f1 then btnOk.Click else
//    if Key = vk_escape then btnCancel.Click;
end;

procedure TFDatosExcelFOB.empresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(empresa.Text);
  productoChange( producto );
  edtCentroOrigenChange( edtCentroOrigen );
  edtCentroSalidaChange( edtCentroSalida );
  edtClienteChange( edtCliente  );
  edtComercialChange( edtComercial  );
  edtEnvaseChange( edtEnvase );
end;

procedure TFDatosExcelFOB.productoChange(Sender: TObject);
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

procedure TFDatosExcelFOB.edtCentroOrigenChange(Sender: TObject);
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

procedure TFDatosExcelFOB.edtCentroSalidaChange(Sender: TObject);
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

procedure TFDatosExcelFOB.edtClienteChange(Sender: TObject);
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

procedure TFDatosExcelFOB.edtComercialChange(Sender: TObject);
begin
  if edtComercial.Text = '' then
  begin
    txtComercial.Caption:= 'Vacio todos los comerciales';
  end
  else
  begin
    txtComercial.Caption:= desComercial( edtComercial.Text);
  end;
end;

procedure TFDatosExcelFOB.edtEnvaseChange(Sender: TObject);
begin
  if edtEnvase.Text = '' then
  begin
    stEnvase.Caption:= 'Vacio todos los artículos';
  end
  else
  begin
    stEnvase.Caption:= desEnvase( empresa.Text, edtEnvase.Text);
  end;
end;

procedure TFDatosExcelFOB.edtEnvaseExit(Sender: TObject);
begin
  if EsNumerico(edtEnvase.Text) and (Length(edtEnvase.Text) <= 5) then
    if (edtEnvase.Text <> '' ) and (Length(edtEnvase.Text) < 9) then
      edtEnvase.Text := 'COM-' + Rellena( edtEnvase.Text, 5, '0');
end;

procedure TFDatosExcelFOB.eTipoGastoChange(Sender: TObject);
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

procedure TFDatosExcelFOB.chkAbonosClick(Sender: TObject);
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

procedure TFDatosExcelFOB.rbFechaSalidasClick(Sender: TObject);
begin
  if rbFechaSalidas.Checked then
  begin
    rbTodos.Enabled:= True;
    rbFacturados.Enabled:= True;
    rbSinFacturar.Enabled:= True;
  end
  else
  begin
    rbTodos.Enabled:= False;
    rbFacturados.Enabled:= True;
    rbSinFacturar.Enabled:= False;
  end;
end;

procedure TFDatosExcelFOB.ssEnvaseAntesEjecutar(Sender: TObject);
begin
    ssEnvase.SQLAdi := '';
    if Producto.Text <> '' then
      ssEnvase.SQLAdi := ' producto_e = ' +  QuotedStr(Producto.Text);
end;

procedure TFDatosExcelFOB.cbxNoGastoClick(Sender: TObject);
begin
  if not cbxNoGasto.Checked then
  begin
    eTipoGasto.Text:= '';
  end;
end;

procedure TFDatosExcelFOB.chkDesgloseCostesClick(Sender: TObject);
begin
  if chkDesgloseCostes.Checked then
  begin
    chkDescuentos.Caption:= 'Descuentos no facturables';
  end
  else
  begin
    chkDescuentos.Caption:= 'Descuentos no facturables (Se aplica en columna de importes bruto)';
  end;
end;

procedure TFDatosExcelFOB.btn1Click(Sender: TObject);
begin
  Application.CreateForm( TDMMakeFOBData, DMMakeFOBData );
  try
    MakeFOBData.DMMakeFOBData.ObtenerDatosComunFob( 7 );
  finally
    FreeAndNil( DMMakeFOBData );
  end;
end;

function TFDatosExcelFOB.edtTipoClienteGetSQL: String;
begin
  result := 'select * from frf_cliente_tipos order by codigo_ctp';
end;

procedure TFDatosExcelFOB.edtTipoClienteChange(Sender: TObject);
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

end.
