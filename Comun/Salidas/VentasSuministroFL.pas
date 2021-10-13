unit VentasSuministroFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, ComCtrls, ExtCtrls,
  BSpeedButton, BGridButton, Grids, DBGrids, BGrid, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, dxSkinsCore, dxSkinBlue, dxSkinBlueprint,
  dxSkinFoggy, dxSkinMoneyTwins, cxButtons, SimpleSearch, cxControls,
  cxContainer, cxEdit, cxTextEdit, dxSkinBlack, dxSkinCaramel, dxSkinCoffee,
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

type
  TFLVentasSuministro = class(TForm)
    edtEmpresa: TBEdit;
    lblEmpresa: TnbLabel;
    etqEmpresa: TnbStaticText;
    lblSumnistro: TnbLabel;
    edtSuministro: TBEdit;
    etqSuministro: TnbStaticText;
    lblCliente: TnbLabel;
    edtCliente: TBEdit;
    etqCliente: TnbStaticText;
    lblEspere: TLabel;
    lblProducto: TnbLabel;
    edtProducto: TBEdit;
    etqProducto: TnbStaticText;
    RejillaFlotante: TBGrid;
    BGBEmpresa: TBGridButton;
    BGBCliente: TBGridButton;
    BGBProducto: TBGridButton;
    btnSuministro: TBGridButton;
    lblEnvases: TnbLabel;
    etqEnvases: TnbStaticText;
    chkCentro: TCheckBox;
    chkEnvase: TCheckBox;
    lblDDesde: TnbLabel;
    edtDDesde: TBEdit;
    lblDHasta: TnbLabel;
    edtDHasta: TBEdit;
    lblADesde: TnbLabel;
    edtADesde: TBEdit;
    lblAHasta: TnbLabel;
    edtAHasta: TBEdit;
    lblMDesde: TnbLabel;
    edtMDesde: TBEdit;
    lblMHasta: TnbLabel;
    edtMHasta: TBEdit;
    lblSDesde: TnbLabel;
    edtSDesde: TBEdit;
    lblSHasta: TnbLabel;
    edtSHasta: TBEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    rbFechas: TRadioButton;
    rbSemanas: TRadioButton;
    rbMeses: TRadioButton;
    rbAnyos: TRadioButton;
    cbxComparativo: TCheckBox;
    chkCompactar: TCheckBox;
    btnAExcel: TSpeedButton;
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    lblDatosPor: TnbLabel;
    rgDatosPor: TRadioGroup;
    ssEnvase: TSimpleSearch;
    edtEnvase: TcxTextEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
    procedure edtSuministroChange(Sender: TObject);
    procedure btnAExcelClick(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
    procedure btnClick(Sender: TObject);
    procedure edtEnvaseChange(Sender: TObject);
    procedure rbFechasClick(Sender: TObject);
    procedure edtDDesdeChange(Sender: TObject);
    procedure edtDHastaChange(Sender: TObject);
    procedure edtSDesdeChange(Sender: TObject);
    procedure edtSHastaChange(Sender: TObject);
    procedure edtMDesdeChange(Sender: TObject);
    procedure edtMHastaChange(Sender: TObject);
    procedure edtADesdeChange(Sender: TObject);
    procedure edtAHastaChange(Sender: TObject);
    procedure edtEnvaseExit(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
    procedure cxTextEdit1PropertiesChange(Sender: TObject);
  private
    { Private declarations }
    dDesde, dHasta: TDateTime;
    
    function ValidarEntrada: Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     VentasSuministroQL, VentasSuministroDL, DB, DateUtils, CAuxiliarDB,
  UDMBaseDatos, CGlobal, bTextUtils;
var
  Parametros: RParametrosVentasSuministro;

procedure TFLVentasSuministro.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag := kEmpresa;
  edtCliente.Tag := kCliente;
  edtSuministro.Tag := kSuministro;
  edtProducto.Tag := kProducto;
  edtEnvase.Tag := kEnvase;
  //PonNombre( edtLinea );

  if  CGlobal.gProgramVersion = CGlobal.pvBAG then
    edtEmpresa.Text := 'BAG'
  else
    edtEmpresa.Text := 'SAT';

  edtClienteChange( edtCliente );
  edtEnvaseChange( edtEnvase );
  edtProductoChange( edtProducto );
 
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

  VentasSuministroQL.LoadReport( Self );

  rbFechasClick( rbFechas );
  edtDDesde.Text := DateToStr(date - 7);
  edtDHasta.Text := DateToStr(date - 1);
end;

procedure TFLVentasSuministro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;

  VentasSuministroQL.UnloadReport;
end;

procedure TFLVentasSuministro.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
    vk_f2:
      begin
        btnClick( ActiveControl );
      end;
  end;
end;

procedure TFLVentasSuministro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
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
    vk_escape:
      begin
        btnCancelar.Click;
      end;
    vk_f1:
      begin
        btnAceptar.Click;
      end;
  end;
end;

function TFLVentasSuministro.ValidarEntrada: Boolean;
begin
  result := false;

  //El codigo del cliente es obligatorio
  if Trim( edtEmpresa.Text ) = '' then
  begin
    edtEmpresa.SetFocus;
    ShowMessage('El código de la empresa es obligatorio.');
    Exit;
  end;

  if Trim( etqCliente.Caption ) = '' then
  begin
    edtCliente.SetFocus;
    ShowMessage('El código del cliente es incorrecto.');
    Exit;
  end;
  if Trim( etqSuministro.Caption ) = '' then
  begin
    edtSuministro.SetFocus;
    ShowMessage('El código del centro de suministro es incorrecto.');
    Exit;
  end;

  if Trim( etqProducto.Caption ) = '' then
  begin
    edtProducto.SetFocus;
    ShowMessage('El código del producto es incorrecto.');
    Exit;
  end;

  if Trim( etqEnvases.Caption ) = '' then
  begin
    edtEnvase.SetFocus;
    ShowMessage('El código del artículo es incorrecto.');
    Exit;
  end;

  if not TryStrToDate( edtDDesde.Text, dDesde ) then
  begin
    edtDDesde.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;
  if not TryStrToDate(edtDHasta.Text, dHasta ) then
  begin
    edtDHasta.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
    end;
  if dDesde > dHasta then
  begin
    edtDDesde.SetFocus;
    ShowMessage('Rango de fechas incorrecto.');
    Exit;
  end;

  result := true;
end;

procedure TFLVentasSuministro.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLVentasSuministro.btnAceptarClick(Sender: TObject);
begin
  if ValidarEntrada then
  begin
    Parametros.sEmpresa:= Trim( edtEmpresa.Text );
    Parametros.sCliente:= Trim( edtCliente.Text );
    Parametros.sSuministro:= Trim( edtSuministro.Text );
    Parametros.bCentro:= chkCentro.Checked;
    Parametros.sProducto:= Trim( edtProducto.Text );
    Parametros.sEnvase:= Trim( edtEnvase.Text );
    Parametros.bEnvase:= chkEnvase.Checked;


    // 1-total, 2-anual, 3-mensual, 4-semanal, 5-diaria, 6-albaran
    Parametros.iAgrupar:= rgDatosPor.ItemIndex + 1;

    //Fechas rango actual
    Parametros.dFechaDesde:= dDesde;
    Parametros.dFechaHasta:= dHasta;

    //Fechas rango año anterior
    Parametros.dFechaDesdeAnt:= IncYear( Parametros.dFechaDesde, -1 );
    if ( Parametros.iAgrupar = 1 ) or ( Parametros.iAgrupar = 4 ) or ( Parametros.iAgrupar = 5 ) then
    begin
      while DayOfTheWeek( Parametros.dFechaDesdeAnt ) <> DayOfTheWeek( Parametros.dFechaDesde ) do
      begin
        Parametros.dFechaDesdeAnt:= Parametros.dFechaDesdeAnt + 1;
      end;
      Parametros.dFechaHastaAnt:= Parametros.dFechaDesdeAnt + ( Parametros.dFechaHasta - Parametros.dFechaDesde );
    end
    else
    begin
      Parametros.dFechaHastaAnt:= IncYear( Parametros.dFechaHasta, -1 );
    end;

    Parametros.bComparar:= cbxComparativo.Checked;
    Parametros.bCompactar:= chkCompactar.Checked;

    VentasSuministroQL.ExecuteReport( Self, Parametros );
  end;
end;

procedure TFLVentasSuministro.btnAExcelClick(Sender: TObject);
begin
  lblEspere.Visible:= True;
  Application.ProcessMessages;

  if ValidarEntrada then
  begin
    Parametros.sEmpresa:= Trim( edtEmpresa.Text );
    Parametros.sCliente:= Trim( edtCliente.Text );
    Parametros.sSuministro:= Trim( edtSuministro.Text );
    Parametros.bCentro:= chkCentro.Checked;
    Parametros.sProducto:= Trim( edtProducto.Text );
    Parametros.sEnvase:= Trim( edtEnvase.Text );
    Parametros.bEnvase:= chkEnvase.Checked;

    // 1-total, 2-anual, 3-mensual, 4-semanal, 5-diaria, 6-albaran
    Parametros.iAgrupar:= rgDatosPor.ItemIndex + 1;

    //Fechas rango actual
    Parametros.dFechaDesde:= dDesde;
    Parametros.dFechaHasta:= dHasta;

    //Fechas rango año anterior
    Parametros.dFechaDesdeAnt:= IncYear( Parametros.dFechaDesde, -1 );
    if ( Parametros.iAgrupar = 1 ) or ( Parametros.iAgrupar = 4 ) or ( Parametros.iAgrupar = 5 ) then
    begin
      while DayOfTheWeek( Parametros.dFechaDesdeAnt ) <> DayOfTheWeek( Parametros.dFechaDesde ) do
      begin
        Parametros.dFechaDesdeAnt:= Parametros.dFechaDesdeAnt + 1;
      end;
      Parametros.dFechaHastaAnt:= Parametros.dFechaDesdeAnt + ( Parametros.dFechaHasta - Parametros.dFechaDesde );
    end
    else
    begin
      Parametros.dFechaHastaAnt:= IncYear( Parametros.dFechaHasta, -1 );
    end;

    Parametros.bComparar:= cbxComparativo.Checked;
    Parametros.bCompactar:= chkCompactar.Checked;

    VentasSuministroDL.GuardarCsv( Self, Parametros )
  end;

  lblEspere.Visible:= False;
end;

procedure TFLVentasSuministro.edtEmpresaChange(Sender: TObject);
begin
  etqEmpresa.Caption:= desEmpresa( edtEmpresa.Text );
  edtClienteChange( edtCliente );
  edtEnvaseChange( edtEnvase );
  edtProductoChange( edtProducto );
end;

procedure TFLVentasSuministro.edtClienteChange(Sender: TObject);
begin
  if edtCliente.Text = '' then
    etqCliente.Caption:= 'TODOS LOS CLIENTES'
  else
    etqCliente.Caption:= desCliente( edtCliente.Text );
  edtSuministroChange( edtSuministro );
end;

procedure TFLVentasSuministro.edtSuministroChange(Sender: TObject);
begin
  if edtSuministro.Text = '' then
    etqSuministro.Caption:= 'TODOS LOS CENTROS'
  else
    etqSuministro.Caption:= desSuministro( edtEmpresa.Text, edtCliente.Text, edtSuministro.Text );
end;

procedure TFLVentasSuministro.edtProductoChange(Sender: TObject);
begin
  if edtProducto.Text = '' then
    etqProducto.Caption:= 'TODOS LOS PRODUCTOS'
  else
    etqProducto.Caption:= desProducto( edtEmpresa.Text, edtProducto.Text );
end;







procedure TFLVentasSuministro.btnClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCliente: DespliegaRejilla(BGBCliente, [edtEmpresa.Text]);
    kProducto: DespliegaRejilla(BGBProducto, [edtEmpresa.Text]);
    kSuministro: DespliegaRejilla(btnSuministro, [edtCliente.Text]);
//    kEnvase: DespliegaRejilla(btnEnvases, [edtEmpresa.Text]);
  end;
end;

procedure TFLVentasSuministro.cxTextEdit1PropertiesChange(Sender: TObject);
begin
  if edtEnvase.Text = '' then
    etqEnvases.Caption:= 'TODOS LOS ARTICULOS'
  else
    etqEnvases.Caption := desEnvase(edtEmpresa.Text, edtEnvase.Text);
end;

procedure TFLVentasSuministro.edtEnvaseChange(Sender: TObject);
begin
  if edtEnvase.Text = '' then
    etqEnvases.Caption:= 'TODOS LOS ARTICULOS'
  else
    etqEnvases.Caption := desEnvase(edtEmpresa.Text, edtEnvase.Text);
end;

procedure TFLVentasSuministro.edtEnvaseExit(Sender: TObject);
begin
  if EsNumerico(edtEnvase.Text) and (Length(edtEnvase.Text) <= 5) then
    if (edtEnvase.Text <> '' ) and (Length(edtEnvase.Text) < 9) then
      edtEnvase.Text := 'COM-' + Rellena( edtEnvase.Text, 5, '0');
end;

procedure TFLVentasSuministro.rbFechasClick(Sender: TObject);
begin
  ActiveControl:= edtEmpresa;
  edtDDesde.Enabled:= rbFechas.Checked;
  edtDHasta.Enabled:= rbFechas.Checked;
  edtSDesde.Enabled:= rbSemanas.Checked;
  edtSHasta.Enabled:= rbSemanas.Checked;
  edtMDesde.Enabled:= rbMeses.Checked;
  edtMHasta.Enabled:= rbMeses.Checked;
  edtADesde.Enabled:= rbAnyos.Checked;
  edtAHasta.Enabled:= rbAnyos.Checked;
  if edtDDesde.Enabled then
  begin
    ActiveControl:= edtDDesde;
    edtDDesdeChange(edtDDesde);
    edtDHastaChange(edtDHasta);
  end;
  if edtSDesde.Enabled then
  begin
    ActiveControl:= edtSDesde;
    edtSDesdeChange(edtSDesde);
    edtSHastaChange(edtSHasta);
  end;
  if edtMDesde.Enabled then
  begin
    ActiveControl:= edtMDesde;
    edtMDesdeChange(edtMDesde);
    edtMHastaChange(edtMHasta);
  end;
  if edtADesde.Enabled then
  begin
    ActiveControl:= edtADesde;
    edtADesdeChange(edtADesde);
    edtAHastaChange(edtAHasta);
  end;
end;

procedure TFLVentasSuministro.ssEnvaseAntesEjecutar(Sender: TObject);
begin
    ssEnvase.SQLAdi := '';
    if edtProducto.Text <> '' then
      ssEnvase.SQLAdi := ' producto_e = ' +  QuotedStr(edtProducto.Text);
end;

procedure TFLVentasSuministro.edtDDesdeChange(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if edtDDesde.Enabled then
  begin
    if TryStrToDate( edtDDesde.Text, dFecha ) then
    begin
      edtADesde.Text:= IntToStr( YearOf( dFecha ) );
      edtMDesde.Text:= IntToStr( YearOf( dFecha ) * 100 + MonthOfTheYear( dFecha ) );
      edtSDesde.Text:= IntToStr( YearOf( dFecha ) * 100 + WeekOfTheYear( dFecha ) );
    end
    else
    begin
      edtADesde.Text:= '';
      edtMDesde.Text:= '';
      edtSDesde.Text:= '';
    end;
  end;
end;


procedure TFLVentasSuministro.edtDHastaChange(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if edtDHasta.Enabled then
  begin
    if TryStrToDate( edtDHasta.Text, dFecha ) then
    begin
      edtAHasta.Text:= IntToStr( YearOf( dFecha ) );
      edtMHasta.Text:= IntToStr( YearOf( dFecha ) * 100 + MonthOfTheYear( dFecha ) );
      edtSHasta.Text:= IntToStr( YearOf( dFecha ) * 100 + WeekOfTheYear( dFecha ) );
    end
    else
    begin
      edtAHasta.Text:= '';
      edtMHasta.Text:= '';
      edtSHasta.Text:= '';
    end;
  end;
end;

procedure TFLVentasSuministro.edtSDesdeChange(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if edtSDesde.Enabled then
  begin
    if Length( Trim( edtSDesde.Text ) ) = 6 then
    begin
      dFecha:= LunesAnyoSemana( edtSDesde.Text );
      edtDDesde.Text:= DateToStr( dFecha );
      edtADesde.Text:= IntToStr( YearOf( dFecha ) );
      edtMDesde.Text:= IntToStr( YearOf( dFecha ) * 100 + MonthOfTheYear( dFecha ) );
      //edtSDesde.Text:= IntToStr( YearOf( dFecha ) * 100 + WeekOfTheYear( dFecha ) );
    end
    else
    begin
      edtDDesde.Text:= '';
      edtADesde.Text:= '';
      edtMDesde.Text:= '';
      //edtSDesde.Text:= '';
    end;
  end;
end;

procedure TFLVentasSuministro.edtSHastaChange(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if edtSHasta.Enabled then
  begin
    if Length( Trim( edtSHasta.Text ) ) = 6 then
    begin
      dFecha:= LunesAnyoSemana( edtSHasta.Text ) + 6;
      edtDHasta.Text:= DateToStr( dFecha );
      edtAHasta.Text:= IntToStr( YearOf( dFecha ) );
      edtMHasta.Text:= IntToStr( YearOf( dFecha ) * 100 + MonthOfTheYear( dFecha ) );
      //edtSHasta.Text:= IntToStr( YearOf( dFecha ) * 100 + WeekOfTheYear( dFecha ) );
    end
    else
    begin
      edtDHasta.Text:= '';
      edtAHasta.Text:= '';
      edtMHasta.Text:= '';
      //edtSHasta.Text:= '';
    end;
  end;
end;

procedure TFLVentasSuministro.edtMDesdeChange(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if edtMDesde.Enabled then
  begin
    if Length( Trim( edtMDesde.Text ) ) = 6 then
    begin
      dFecha:= PrimerDiaAnyoMes( edtMDesde.Text );
      edtDDesde.Text:= DateToStr( dFecha );
      edtADesde.Text:= IntToStr( YearOf( dFecha ) );
      //edtMDesde.Text:= IntToStr( YearOf( dFecha ) * 100 + MonthOfTheYear( dFecha ) );
      edtSDesde.Text:= IntToStr( YearOf( dFecha ) * 100 + WeekOfTheYear( dFecha ) );
    end
    else
    begin
      edtDDesde.Text:= '';
      edtADesde.Text:= '';
      //edtMDesde.Text:= '';
      edtSDesde.Text:= '';
    end;
  end;
end;

procedure TFLVentasSuministro.edtMHastaChange(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if edtMHasta.Enabled then
  begin
    if Length( Trim( edtMHasta.Text ) ) = 6 then
    begin
      dFecha:= UltimoDiaAnyoMes( edtMHasta.Text );
      edtDHasta.Text:= DateToStr( dFecha );
      edtAHasta.Text:= IntToStr( YearOf( dFecha ) );
      //edtMHasta.Text:= IntToStr( YearOf( dFecha ) * 100 + MonthOfTheYear( dFecha ) );
      edtSHasta.Text:= IntToStr( YearOf( dFecha ) * 100 + WeekOfTheYear( dFecha ) );
    end
    else
    begin
      edtDHasta.Text:= '';
      edtAHasta.Text:= '';
      //edtMHasta.Text:= '';
      edtSHasta.Text:= '';
    end;
  end;
end;

procedure TFLVentasSuministro.edtADesdeChange(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if edtADesde.Enabled then
  begin
    if Length( Trim( edtADesde.Text ) ) = 4 then
    begin
      dFecha:= EncodeDate( StrToInt(edtADesde.Text), 1, 1 );
      edtDDesde.Text:= DateToStr( dFecha );
      //edtADesde.Text:= IntToStr( YearOf( dFecha ) );
      edtMDesde.Text:= IntToStr( YearOf( dFecha ) * 100 + MonthOfTheYear( dFecha ) );
      edtSDesde.Text:= IntToStr( YearOf( dFecha ) * 100 + WeekOfTheYear( dFecha ) );
    end
    else
    begin
      edtDDesde.Text:= '';
      //edtADesde.Text:= '';
      edtMDesde.Text:= '';
      edtSDesde.Text:= '';
    end;
  end;
end;


procedure TFLVentasSuministro.edtAHastaChange(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if edtAHasta.Enabled then
  begin
    if Length( Trim( edtAHasta.Text ) ) = 4 then
    begin
      dFecha:= EncodeDate( StrToInt(edtAHasta.Text), 12, 31 );
      edtDHasta.Text:= DateToStr( dFecha );
      //edtAHasta.Text:= IntToStr( YearOf( dFecha ) );
      edtMHasta.Text:= IntToStr( YearOf( dFecha ) * 100 + MonthOfTheYear( dFecha ) );
      edtSHasta.Text:= IntToStr( YearOf( dFecha ) * 100 + WeekOfTheYear( dFecha ) );
    end
    else
    begin
      edtDHasta.Text:= '';
      //edtAHasta.Text:= '';
      edtMHasta.Text:= '';
      edtSHasta.Text:= '';
    end;
  end;
end;
end.

