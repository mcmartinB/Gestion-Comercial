unit FormatoPaletsFM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, Buttons, ActnList, BGrid,
  BSpeedButton, Grids, DBGrids, BGridButton, BDEdit, BCalendarButton, ComCtrls,
  BCalendario, BEdit, dbTables, DError, ToolWin, Menus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlue, dxSkinBlueprint, dxSkinFoggy, dxSkinMoneyTwins, cxButtons,
  SimpleSearch, cxTextEdit, cxDBEdit, dxSkinBlack, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue;

const
  kConjuntoResultado = 1;
  kLocalizando = 2;
  kModificandoCab = 3;
  kInsertandoCab = 4;
  kBorrandoCab = 5;
  kModificandoDet = 6;
  kInsertandoDet = 7;
  kBorrandoDet = 8;

type
  TFMFormatoPalets = class(TForm)
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    TBBarraMaestroDetalle: TToolBar;
    btnLocalizar: TToolButton;
    btnModificarCab: TToolButton;
    btnBorrarCab: TToolButton;
    btnInsertarCab: TToolButton;
    TBMaestroDetalleSeparador3: TToolButton;
    btnModificarDet: TToolButton;
    btnBorrarDet: TToolButton;
    btnInsertarDet: TToolButton;
    TBMaestroDetalleSeparador1: TToolButton;
    btnImprimir: TToolButton;
    ToolButton4: TToolButton;
    btnPrimero: TToolButton;
    btnAnterior: TToolButton;
    btnSiguiente: TToolButton;
    btnUltimo: TToolButton;
    TBMaestroDetalleSeparador2: TToolButton;
    btnAceptar: TToolButton;
    btnCancelar: TToolButton;
    TBMaestroDetalleSeparador5: TToolButton;
    btnSalir: TToolButton;
    DSDetalle: TDataSource;
    ALocalizar: TAction;
    ASalir: TAction;
    AAceptar: TAction;
    ACancelar: TAction;
    AInsertarCab: TAction;
    AModificarCab: TAction;
    ABorrarCab: TAction;
    AInsertarDet: TAction;
    AModificarDet: TAction;
    ABorrarDet: TAction;
    APrimero: TAction;
    AAnterior: TAction;
    ASiguiente: TAction;
    AUltimo: TAction;
    ADespegable: TAction;
    AImprimir: TAction;
    pgControl: TPageControl;
    tsFicha: TTabSheet;
    tsBusqueda: TTabSheet;
    PMaestro: TPanel;
    LEmpresa_p: TLabel;
    btnEmpresa: TBGridButton;
    LAno_semana_p: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnProducto: TBGridButton;
    btnPalet: TBGridButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    empresa_f: TBDEdit;
    stEmpresa: TStaticText;
    codigo_f: TBDEdit;
    productop_f: TBDEdit;
    nombre_f: TBDEdit;
    palet_f: TBDEdit;
    stProducto: TStaticText;
    stTipoPalet: TStaticText;
    fecha_alta_f: TBDEdit;
    fecha_baja_f: TBDEdit;
    n_cajas_f: TBDEdit;
    PDetalle: TPanel;
    PDatosDetalle: TPanel;
    gridDetalle: TDBGrid;
    DBGrid1: TDBGrid;
    Label8: TLabel;
    n_palets_pie_f: TBDEdit;
    Label9: TLabel;
    descripcion_f: TDBMemo;
    ean13_f: TBDEdit;
    Label4: TLabel;
    stEnvase: TStaticText;
    Label10: TLabel;
    notas_f: TDBMemo;
    Label11: TLabel;
    formato_cliente_fc: TBDEdit;
    descripcion_fc: TBDEdit;
    Label12: TLabel;
    cliente_fc: TBDEdit;
    btnCliente: TBGridButton;
    stCliente: TStaticText;
    Label13: TLabel;
    suministro_fc: TBDEdit;
    btnSuministro: TBGridButton;
    stSuministro: TStaticText;
    Label14: TLabel;
    unidad_pedido_fc: TBDEdit;
    Label15: TLabel;
    RejillaFlotante: TBGrid;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    btnMarca: TBGridButton;
    btnColor: TBGridButton;
    Label19: TLabel;
    btnCategoria: TBGridButton;
    marca_f: TBDEdit;
    color_f: TBDEdit;
    stMarca: TStaticText;
    stColor: TStaticText;
    calibre_f: TBDEdit;
    categoria_f: TBDEdit;
    stCategoria: TStaticText;
    btnCalibre: TBGridButton;
    envase_f: TcxDBTextEdit;
    ssEnvase: TSimpleSearch;
    procedure ALocalizarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ASalirExecute(Sender: TObject);
    procedure AAceptarExecute(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure AInsertarCabExecute(Sender: TObject);
    procedure ABorrarCabExecute(Sender: TObject);
    procedure ABorrarDetExecute(Sender: TObject);
    procedure APrimeroExecute(Sender: TObject);
    procedure AAnteriorExecute(Sender: TObject);
    procedure ASiguienteExecute(Sender: TObject);
    procedure AUltimoExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADespegableExecute(Sender: TObject);
    procedure AImprimirExecute(Sender: TObject);
    procedure DescripcionMaestro(Sender: TObject);
    procedure AInsertarDetExecute(Sender: TObject);
    procedure AModificarDetExecute(Sender: TObject);
    procedure AModificarCabExecute(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure tsBusquedaShow(Sender: TObject);
    procedure tsFichaShow(Sender: TObject);
    procedure descripcion_fEnter(Sender: TObject);
    procedure descripcion_fExit(Sender: TObject);
    procedure descripcionDetalle(Sender: TObject);
    procedure suministro_fcChange(Sender: TObject);
    procedure codigo_fEnter(Sender: TObject);
    procedure edtEnvaseExit(Sender: TObject);
    procedure envase_fExit(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
  private
    { Private declarations }
    iEstado: integer;
    bFicha: Boolean;

    sClienteAux, sDirSum, sFormato, sDescripcion, sUnidad: string;

    procedure PonEstado(const AEstado: Integer);
    procedure EstadoBotones(const AEnabled: boolean);
    procedure BotonesDesplazamiento(const AEnabled: boolean);

    procedure AceptarModificarCab;
    procedure CancelarModificarCab;

    procedure AceptarInsertarCab;
    procedure CancelarInsertarCab;

    procedure AceptarModificarDet;
    procedure CancelarModificarDet;

    procedure AceptarInsertarDet;
    procedure CancelarInsertarDet;

    procedure LimpiarDescripcionMaestro;
    procedure LimpiarDescripcionDetalle;

    function  DesSuministroOp( const AEmpresa, ACliente, ASuministro: string ): string;
    procedure ValoresPorDefectoCliente;

  public
    { Public declarations }

    //Listado

  end;

implementation

uses Principal, CGestionPrincipal, UDMBaseDatos, UDMAuxDB, CAuxiliarDB,
    CReportes, bSQLUtils, FormatoPaletsDM, GetFiltroFM, CVariables, bTextUtils;

{$R *.DFM}

var
  FMGetFiltro: TFMGetFiltro;

procedure TFMFormatoPalets.FormCreate(Sender: TObject);
begin
  bFicha:= True;
  pgControl.ActivePage := tsFicha;
  DMFormatoPalets := TDMFormatoPalets.Create(self);
  DSMaestro.DataSet:= DMFormatoPalets.QMaestro;
  DSDetalle.DataSet:= DMFormatoPalets.QDetalle;
  DSMaestro.DataSet.Open;

  PonEstado(kConjuntoResultado);
  BHDeshabilitar;
  FPrincipal.HabilitarMenu(false);

  empresa_f.Tag:= kEmpresa;
  productop_f.Tag:= kProducto;
  envase_f.Tag:= kEnvaseProducto;
  palet_f.Tag:= kTipoPalet;
  cliente_fc.Tag:= kCliente;
  suministro_fc.Tag:= kSuministro;
  marca_f.Tag:= kMarca;
  categoria_f.Tag:= kCategoria;
  calibre_f.Tag:= kCalibre;
  color_f.Tag:= kColor;

  FMGetFiltro := InicializarFiltro(self);
  FMGetFiltro.Configurar('Filtrar formatos palet', 0);
  FMGetFiltro.AddChar('empresa_f', 'Empresa', 3, True);
  FMGetFiltro.AddChar('codigo_f', 'Código', 5, False);
  FMGetFiltro.AddChar('nombre_f', 'Formato', 50, False);
  FMGetFiltro.AddChar('productop_f', 'Producto', 3, False);
  FMGetFiltro.AddChar('envase_f', 'Envase', 9, False);

end;

procedure TFMFormatoPalets.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DSMaestro.DataSet.Open;
  FreeAndNil(DMFormatoPalets);
  BHRestaurar;
  FPrincipal.HabilitarMenu(True);
  FinalizarFiltro(FMGetFiltro);

  Action := CaFree;
end;

procedure TFMFormatoPalets.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := iEstado = kConjuntoResultado;
end;

procedure TFMFormatoPalets.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
  //               y entre los Campos de Búsqueda en la localización
  if not descripcion_f.Focused and not notas_f.Focused then
    case key of
      vk_Return, vk_down:
        begin
          Key := 0;
          PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        end;
      vk_up:
        begin
          Key := 0;
          PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        end;
    end;
end;

procedure TFMFormatoPalets.ADespegableExecute(Sender: TObject);
begin

  if envase_f.Focused then
    ssEnvase.Execute;

  if empresa_f.Focused then
    DespliegaRejilla(btnEmpresa)
  else if productop_f.Focused then
    DespliegaRejilla(btnProducto, [empresa_f.Text])
  else if palet_f.Focused then
    DespliegaRejilla(btnPalet)
//  else if envase_f.Focused then
//    DespliegaRejilla(btnEnvase, [empresa_f.Text])
  else if cliente_fc.Focused then
    DespliegaRejilla(btnCliente, [empresa_f.Text])
  else if suministro_fc.Focused then
    DespliegaRejilla(btnSuministro, [cliente_fc.Text])
  else if marca_f.Focused then
    DespliegaRejilla(btnMarca)
  else if categoria_f.Focused then
    DespliegaRejilla(btnCategoria, [empresa_f.Text, productop_f.Text])
  else if calibre_f.Focused then
    DespliegaRejilla(btnCalibre, [empresa_f.Text, productop_f.Text])
  else if color_f.Focused then
    DespliegaRejilla(btnColor, [empresa_f.Text, productop_f.Text]);
end;

procedure TFMFormatoPalets.DescripcionMaestro(Sender: TObject);
begin
  if (DSMaestro.DataSet.State = dsInsert) or (DSMaestro.DataSet.State = dsEdit)
    then
  begin
    if TBDEdit( Sender ) = empresa_f then
    begin
      stEmpresa.Caption := desEmpresa(empresa_f.Text);
      stProducto.Caption := desProducto(empresa_f.Text, productop_f.Text);
      stEnvase.Caption := desEnvaseProducto( empresa_f.Text, envase_f.Text, productop_f.Text);
    end
    else if TBDEdit( Sender ) = productop_f then
    begin
      stProducto.Caption := desProducto(empresa_f.Text, productop_f.Text);
    end
    else if TcxDBTextEdit( Sender ) = envase_f then
    begin
      stEnvase.Caption := desEnvaseProducto(empresa_f.Text, envase_f.Text, productop_f.Text);
    end
    else if TBDEdit( Sender ) = palet_f then
    begin
      stTipoPalet.Caption := desTipoPalet(palet_f.Text);
    end
    else if TBDEdit( Sender ) = categoria_f then
    begin
      stCategoria.Caption := desCategoria( empresa_f.Text, productop_f.Text, categoria_f.Text);
    end
    else if TBDEdit( Sender ) = color_f then
    begin
      stColor.Caption := desColor( empresa_f.Text, productop_f.Text, color_f.Text);
    end
    else if TBDEdit( Sender ) = marca_f then
    begin
      stMarca.Caption := desMarca(marca_f.Text);
    end;
  end
  else
  begin
    stEmpresa.Caption := desEmpresa(empresa_f.Text);
    stProducto.Caption := desProducto(empresa_f.Text, productop_f.Text);
    stTipoPalet.Caption := desTipoPalet(palet_f.Text);
    stEnvase.Caption := desEnvaseProducto(empresa_f.Text, envase_f.Text, productop_f.Text);
    stColor.Caption := desColor( empresa_f.Text, productop_f.Text, color_f.Text);
    stCategoria.Caption := desCategoria( empresa_f.Text, productop_f.Text, categoria_f.Text);
    stMarca.Caption := desMarca(marca_f.Text);
  end;
end;

procedure TFMFormatoPalets.LimpiarDescripcionMaestro;
begin
  stEmpresa.Caption := '';
  stProducto.Caption := '';
  stTipoPalet.Caption := '';
end;

procedure TFMFormatoPalets.LimpiarDescripcionDetalle;
begin
  stCliente.Caption := '';
  stSuministro.Caption := '';
end;

procedure TFMFormatoPalets.EstadoBotones(const AEnabled: boolean);
var
  bDecision, bEnabled: boolean;
begin
  bEnabled := AEnabled;
  bDecision := (iEstado = kConjuntoResultado);

  ALocalizar.Enabled := bEnabled and bDecision;
  AInsertarCab.Enabled := bEnabled and bDecision;
  AModificarCab.Enabled := bEnabled and bDecision and not
    DSMaestro.DataSet.IsEmpty;
  ABorrarCab.Enabled := bEnabled and bDecision and not
    DSMaestro.DataSet.IsEmpty;
  AInsertarDet.Enabled := bEnabled and bDecision and not
    DSMaestro.DataSet.IsEmpty and bFicha;
  AModificarDet.Enabled := bEnabled and bDecision and not
    DSDetalle.DataSet.IsEmpty and bFicha;
  ABorrarDet.Enabled := bEnabled and bDecision and not
    DSDetalle.DataSet.IsEmpty and bFicha;

  AImprimir.Enabled := bEnabled and bDecision and not DSMaestro.DataSet.IsEmpty;

  BotonesDesplazamiento(bEnabled and bDecision and bFicha);

  AAceptar.Enabled := bEnabled and not bDecision;
  ACancelar.Enabled := bEnabled and not bDecision;
  ASalir.Enabled := bEnabled and bDecision;
  if bDecision then
  begin
    ACancelar.ShortCut := 0;
    ASalir.ShortCut := vk_escape;
  end
  else
  begin
    ACancelar.ShortCut := vk_escape;
    ASalir.ShortCut := 0;
  end;

  tsBusqueda.TabVisible := bDecision;
end;

procedure TFMFormatoPalets.BotonesDesplazamiento(const AEnabled: boolean);
begin
  APrimero.Enabled := AEnabled and not DSMaestro.DataSet.IsEmpty and not
    DSMaestro.DataSet.BOF;
  AAnterior.Enabled := AEnabled and not DSMaestro.DataSet.IsEmpty and not
    DSMaestro.DataSet.BOF;
  ASiguiente.Enabled := AEnabled and not DSMaestro.DataSet.IsEmpty and not
    DSMaestro.DataSet.EOF;
  AUltimo.Enabled := AEnabled and not DSMaestro.DataSet.IsEmpty and not
    DSMaestro.DataSet.EOF;
end;

procedure TFMFormatoPalets.tsBusquedaShow(Sender: TObject);
begin
  bFicha:= False;
  EstadoBotones(True);
end;

procedure TFMFormatoPalets.tsFichaShow(Sender: TObject);
begin
  bFicha:= True;
  EstadoBotones(True);
end;

procedure TFMFormatoPalets.APrimeroExecute(Sender: TObject);
begin
  DSMaestro.DataSet.First;
  BotonesDesplazamiento(True);
end;

procedure TFMFormatoPalets.AAnteriorExecute(Sender: TObject);
begin
  DSMaestro.DataSet.Prior;
  BotonesDesplazamiento(True);
end;

procedure TFMFormatoPalets.ASiguienteExecute(Sender: TObject);
begin
  DSMaestro.DataSet.Next;
  BotonesDesplazamiento(True);
end;

procedure TFMFormatoPalets.AUltimoExecute(Sender: TObject);
begin
  DSMaestro.DataSet.Last;
  BotonesDesplazamiento(True);
end;

procedure TFMFormatoPalets.PonEstado(const AEstado: Integer);
begin
  case AEstado of
    kConjuntoResultado:
      begin
        PMaestro.Enabled := False;
        PMaestro.Height:= 281;
        gridDetalle.Enabled := True;
        PDatosDetalle.Visible := False;
        codigo_f.Enabled := True;
        empresa_f.Enabled := True;
      end;
    kLocalizando, kInsertandoCab:
      begin
        PMaestro.Enabled := True;
        PMaestro.Height:= 281;
        gridDetalle.Enabled := False;
        PDatosDetalle.Visible := False;

        codigo_f.Enabled := True;
        empresa_f.Enabled := True;
        empresa_f.SetFocus;
      end;
    kModificandoCab:
      begin
        PMaestro.Enabled := True;
        PMaestro.Height:= 281;
        gridDetalle.Enabled := False;
        PDatosDetalle.Visible := False;

        codigo_f.Enabled := False;
        empresa_f.Enabled := False;
        nombre_f.SetFocus;
      end;
    kBorrandoCab, kBorrandoDet:
      begin
        //Nada
      end;
    kInsertandoDet:
      begin
        PMaestro.Enabled := False;
        PMaestro.Height:= 144;
        gridDetalle.Enabled := False;
        PDatosDetalle.Visible := True;
        cliente_fc.SetFocus;
      end;
    kModificandoDet:
      begin
        PMaestro.Enabled := False;
        PMaestro.Height:= 144;
        gridDetalle.Enabled := False;
        PDatosDetalle.Visible := True;
        cliente_fc.SetFocus;
      end;
  end;
  iEstado := AEstado;
  EstadoBotones(true);
end;

procedure TFMFormatoPalets.ValoresPorDefectoCliente;
begin
  formato_cliente_fc.Text:= codigo_f.Text;
  descripcion_fc.Text:= nombre_f.Text;
  unidad_pedido_fc.Text:= 'C';
end;

function TFMFormatoPalets.desSuministroOp( const AEmpresa, ACliente, ASuministro: string ): string;
begin
  if ASuministro = '' then
  begin
    result:= 'Vacio se aplica a todos los sumnistros.';
  end
  else
  begin
    result:= desSuministro( AEmpresa, ACliente, ASuministro );
  end;
end;

procedure TFMFormatoPalets.edtEnvaseExit(Sender: TObject);
begin
  if EsNumerico(envase_f.Text) and (Length(envase_f.Text) <= 5) then
    if (envase_f.Text <> '' ) and (Length(envase_f.Text) < 9) then
      envase_f.Text := 'COM-' + Rellena( envase_f.Text, 5, '0');
end;

procedure TFMFormatoPalets.envase_fExit(Sender: TObject);
begin
  if EsNumerico(envase_f.Text) and (Length(envase_f.Text) <= 5) then
    if (envase_f.Text <> '' ) and (Length(envase_f.Text) < 9) then
      envase_f.Text := 'COM-' + Rellena( envase_f.Text, 5, '0');
end;

procedure TFMFormatoPalets.ASalirExecute(Sender: TObject);
begin
  if RejillaFlotante.Visible then
  begin
    RejillaFlotante.Hide;
  end
  else
  begin
    Close;
  end;
end;

procedure TFMFormatoPalets.AAceptarExecute(Sender: TObject);
begin
  if RejillaFlotante.Visible then
  begin
    RejillaFlotante.DblClick;
  end
  else
  case iEstado of
    kLocalizando, kBorrandoCab, kBorrandoDet:
      begin
        //Nada
      end;
    kModificandoCab:
      begin
        AceptarModificarCab;
      end;
    kInsertandoCab:
      begin
        AceptarInsertarCab;
      end;
    kModificandoDet:
      begin
        AceptarModificarDet;
      end;
    kInsertandoDet:
      begin
        AceptarInsertarDet;
      end;
  end;
end;

procedure TFMFormatoPalets.ACancelarExecute(Sender: TObject);
begin
  if RejillaFlotante.Visible then
  begin
    RejillaFlotante.Hide;
  end
  else
  case iEstado of
    kLocalizando, kBorrandoCab, kBorrandoDet:
      begin
        //Nada
      end;
    kModificandoCab:
      begin
        CancelarModificarCab;
      end;
    kInsertandoCab:
      begin
        CancelarInsertarCab;
      end;
    kModificandoDet:
      begin
        CancelarModificarDet;
      end;
    kInsertandoDet:
      begin
        CancelarInsertarDet;
      end;
  end;
end;

procedure TFMFormatoPalets.ALocalizarExecute(Sender: TObject);
var
  sFiltro: string;
begin
  sFiltro := '';
  if FMGetFiltro.Filtro(sFiltro) then
  begin
    DMFormatoPalets.Localizar( sFiltro );
    PonEstado( kConjuntoResultado );
    pgControl.ActivePage:= tsBusqueda;
  end;
end;

procedure TFMFormatoPalets.ABorrarCabExecute(Sender: TObject);
begin
  if MessageDlg('¿Desea borrar la ficha seleccionada?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    with DSDetalle.DataSet do
    begin
      First;
      while not Eof do
      begin
        Delete;
      end;
    end;
    DSMaestro.DataSet.Delete;
    PonEstado(kConjuntoResultado);
  end;
end;

procedure TFMFormatoPalets.AModificarCabExecute(Sender: TObject);
begin
  try
    pgControl.ActivePage:= tsFicha;
    DSMaestro.DataSet.Edit;
    PonEstado(kModificandoCab);
  except
    DSMaestro.DataSet.Cancel;
    PonEstado(kConjuntoResultado);
    raise;
  end;
end;

procedure TFMFormatoPalets.AceptarModificarCab;
begin
  DSMaestro.DataSet.Post;
  PonEstado(kConjuntoResultado);
end;

procedure TFMFormatoPalets.CancelarModificarCab;
begin
  DSMaestro.DataSet.Cancel;
  PonEstado(kConjuntoResultado);
end;

procedure TFMFormatoPalets.AInsertarCabExecute(Sender: TObject);
begin
  try
    pgControl.ActivePage:= tsFicha;
    DSMaestro.DataSet.Insert;
    PonEstado(kInsertandoCab);
    LimpiarDescripcionMaestro;
  except
    DSMaestro.DataSet.Cancel;
    PonEstado(kConjuntoResultado);
    raise;
  end;
end;

procedure TFMFormatoPalets.AceptarInsertarCab;
begin
  DSMaestro.DataSet.Post;
  PonEstado(kConjuntoResultado);
end;

procedure TFMFormatoPalets.CancelarInsertarCab;
begin
  DSMaestro.DataSet.Cancel;
  PonEstado(kConjuntoResultado);
end;

procedure TFMFormatoPalets.ABorrarDetExecute(Sender: TObject);
begin
  if MessageDlg('¿Desea borrar la linea seleccionada?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DSDetalle.DataSet.Delete;
    PonEstado(kConjuntoResultado);
  end;
end;

procedure TFMFormatoPalets.AModificarDetExecute(Sender: TObject);
begin
  try
    PonEstado(kModificandoDet);
    DSDetalle.DataSet.Edit;
    stCliente.Caption := desCliente(cliente_fc.Text);
    stSuministro.Caption := DesSuministroOp(empresa_f.Text, cliente_fc.Text, suministro_fc.Text );
  except
    DSDetalle.DataSet.Cancel;
    PonEstado(kConjuntoResultado);
    raise;
  end;
end;

procedure TFMFormatoPalets.AceptarModificarDet;
begin
  DSDetalle.DataSet.Post;
  PonEstado(kConjuntoResultado);
end;

procedure TFMFormatoPalets.CancelarModificarDet;
begin
  DSDetalle.DataSet.Cancel;
  PonEstado(kConjuntoResultado);
end;

procedure TFMFormatoPalets.AInsertarDetExecute(Sender: TObject);
begin
  try
    if iEstado <> kInsertandoDet then
    begin
      PonEstado(kInsertandoDet);
      DSDetalle.DataSet.Insert;
      ValoresPorDefectoCliente;
      LimpiarDescripcionDetalle;
    end
    else
    begin
      DSDetalle.DataSet.Insert;

      cliente_fc.Text:= sClienteAux;
      suministro_fc.Text:= sDirSum;
      formato_cliente_fc.Text:= sFormato;
      descripcion_fc.Text:= sDescripcion;
      unidad_pedido_fc.Text:= sUnidad;
      cliente_fc.SetFocus;
    end;
  except
    DSDetalle.DataSet.Cancel;
    PonEstado(kConjuntoResultado);
    raise;
  end;
end;

procedure TFMFormatoPalets.AceptarInsertarDet;
begin
  sClienteAux:= cliente_fc.Text;
  sDirSum:= suministro_fc.Text;
  sFormato:= formato_cliente_fc.Text;
  sDescripcion:= descripcion_fc.Text;
  sUnidad:= unidad_pedido_fc.Text;

  DSDetalle.DataSet.Post;
  //PonEstado(kConjuntoResultado);

  AInsertarDetExecute( btnInsertarDet );
end;

procedure TFMFormatoPalets.CancelarInsertarDet;
begin
  DSDetalle.DataSet.Cancel;
  PonEstado(kConjuntoResultado);
end;

procedure TFMFormatoPalets.AImprimirExecute(Sender: TObject);
begin
  DMFormatoPalets.VisualizarListado( pgControl.ActivePage = tsFicha );
end;

procedure TFMFormatoPalets.DBGrid1DblClick(Sender: TObject);
begin
  pgControl.ActivePage := tsFicha;
  (*
  if not DSMaestro.DataSet.IsEmpty then
  begin
    AModificarCab.Execute;
  end;
  *)
end;

procedure TFMFormatoPalets.descripcion_fEnter(Sender: TObject);
begin
  TEdit(Sender).Color := clMoneyGreen;
end;

procedure TFMFormatoPalets.descripcion_fExit(Sender: TObject);
begin
  TEdit(Sender).Color := clWhite;
end;

procedure TFMFormatoPalets.descripcionDetalle(Sender: TObject);
begin
  if ( DSDetalle.DataSet.State = dsInsert ) or
     ( DSDetalle.DataSet.State = dsEdit ) then
  begin
    stCliente.Caption := desCliente(cliente_fc.Text);
    stSuministro.Caption := DesSuministroOp(empresa_f.Text, cliente_fc.Text, suministro_fc.Text );
  end;
end;

procedure TFMFormatoPalets.ssEnvaseAntesEjecutar(Sender: TObject);
begin
    ssEnvase.SQLAdi := '';
    if productop_f.Text <> '' then
      ssEnvase.SQLAdi := ' producto_e = ' +  QuotedStr(productop_f.Text);
end;

procedure TFMFormatoPalets.suministro_fcChange(Sender: TObject);
begin
  if ( DSDetalle.DataSet.State = dsInsert ) or
     ( DSDetalle.DataSet.State = dsEdit ) then
  begin
    stSuministro.Caption := DesSuministroOp(empresa_f.Text, cliente_fc.Text, suministro_fc.Text );
  end;
end;

procedure TFMFormatoPalets.codigo_fEnter(Sender: TObject);
begin
  if codigo_f.Text = '' then
  begin
    if ( DSMaestro.State = dsInsert ) and ( iEstado =  kInsertandoCab ) then
    begin
      DMAuxDB.QAux.SQL.Clear;
      DMAuxDB.QAux.SQL.Add('select max(cast (codigo_f as integer ) ) formato from frf_formatos where empresa_f = :empresa ');
      DMAuxDB.QAux.ParamByName('EMPRESA').AsString:= empresa_f.Text;
      try
        DMAuxDB.QAux.Open;
        codigo_f.Text:= IntToStr( DMAuxDB.QAux.FieldByname('formato').AsInteger + 1 );
        DMAuxDB.QAux.Close;
      except
        DMAuxDB.QAux.Close;
      end

    end;
  end;
end;

end.
