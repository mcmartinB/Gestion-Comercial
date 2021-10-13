unit LSalidasResumenDinamico;

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
  TFLSalidasResumenDinamico = class(TForm)
    btnCancel: TBitBtn;
    btnOk: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label14: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    STEmpresa: TStaticText;
    STProducto: TStaticText;
    cbxNacionalidad: TComboBox;
    empresa: TnbDBSQLCombo;
    producto: TnbDBSQLCombo;
    edtCentroSalida: TnbDBSQLCombo;
    edtCliente: TnbDBSQLCombo;
    fechaDesde: TnbDBCalendarCombo;
    fechaHasta: TnbDBCalendarCombo;
    pais: TnbDBSQLCombo;
    categoria: TnbDBAlfa;
    Label9: TLabel;
    Label15: TLabel;
    stCliente: TStaticText;
    stSalida: TStaticText;
    stEnvase: TStaticText;
    lblDesCalibre: TLabel;
    Calibre: TBEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    cbbUno: TComboBox;
    cbbDos: TComboBox;
    cbbTres: TComboBox;
    lbl1: TLabel;
    btnAddProducto: TSpeedButton;
    btnSubProducto: TSpeedButton;
    btnClearProducto: TSpeedButton;
    txtLista: TStaticText;
    lblTipoCliente: TLabel;
    edtTipoCliente: TnbDBSQLCombo;
    txtTipoCliente: TStaticText;
    chkExcluirTipoCliente: TCheckBox;
    btnComer: TButton;
    rgTipoProducto: TRadioGroup;
    chkNoP4h: TCheckBox;
    chkAgrupar1: TCheckBox;
    chkAgrupar2: TCheckBox;
    chkTotal: TCheckBox;
    chkVerTotalesXLS: TCheckBox;
    chkVerImportes: TCheckBox;
    cbbCuatro: TComboBox;
    rgFacturable: TRadioGroup;
    chkInterplanta: TCheckBox;
    edtEnvase: TcxTextEdit;
    ssEnvase: TSimpleSearch;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    function productoGetSQL: string;
    function edtClienteGetSQL: string;
    procedure cbxNacionalidadKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure empresaChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
    function edtEnvaseGetSQL: String;
    procedure edtCentroSalidaChange(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
    procedure edtEnvaseChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnAddProductoClick(Sender: TObject);
    procedure btnSubProductoClick(Sender: TObject);
    procedure btnClearProductoClick(Sender: TObject);
    function edtTipoClienteGetSQL: String;
    procedure edtTipoClienteChange(Sender: TObject);
    procedure btnComerClick(Sender: TObject);
    procedure cbbUnoChange(Sender: TObject);
    procedure cbbDosChange(Sender: TObject);
    procedure cbbTresChange(Sender: TObject);
    procedure cbbCuatroChange(Sender: TObject);
    procedure edtEnvaseExit(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    sUno, sDos, sTres, sCuatro: string;
    bImportes, bVariosProductos, bIncluirProductos: Boolean;
    sProductos, sProducto: string;
    sEmpresa, sSalida, sFechaDesde, sFechaHasta, sEnvase, sCliente, sTipoCliente,
       sPais, sCategoria, sCalibre: string;
    bExcluirTipoCliente, bTotalNivel1, bTotalNivel2, bTotal, bVerTotales: boolean;
    iFacturable: integer;


    function  ValidarEntrada: boolean;
    procedure AddProducto( const AOperator: string );
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


uses UDMConfig, DPreview, Principal,
     CVariables, CGestionPrincipal, UDMAuxDB, CReportes, bTimeUtils,
     LDSalidasResumenDinamico, CGlobal, UDMMaster, bTextUtils;

procedure TFLSalidasResumenDinamico.FormCreate(Sender: TObject);

begin
  Application.CreateForm(TDMSalidasResumenDinamico, DMSalidasResumenDinamico );
  edtTipoCliente.onchange( edtTipoCliente );

  FormType := tfOther;
  BHFormulario;

  if CGlobal.gProgramVersion = CGlobal.pvSAT then
  begin
    empresa.Text := 'SAT';
  end
  else
  begin
    empresa.Text := 'BAG';
  end;
  fechaDesde.AsDate := LunesAnterior( Date - 7 );
  fechaHasta.AsDate := fechaDesde.AsDate + 6;

  Calibre.Text:= '';
  sProductos:= '';

  cbbUno.Items.Clear;
  cbbUno.Items.Add('Sin agrupar');
  cbbUno.Items.Add('Comercial Venta');
  cbbUno.Items.Add('Empresa');
  cbbUno.Items.Add('Cliente');
  cbbUno.Items.Add('Producto');
  cbbUno.Items.Add('Agrupación Comercial');
  cbbUno.Items.Add('Artículo');
  cbbUno.Items.Add('Categoría');
  cbbUno.Items.Add('Fecha');
  cbbUno.Items.Add('Mensual');
  cbbUno.Items.Add('Albarán');
  cbbUno.ItemIndex:= 4;
  cbbUnoChange( cbbUno );

  cbbDos.Items.Clear;
  cbbDos.Items.AddStrings( cbbUno.Items );
  cbbDos.ItemIndex:= 3;
  cbbDosChange( cbbDos );

  cbbTres.Items.Clear;
  cbbTres.Items.AddStrings( cbbUno.Items );
  cbbTres.ItemIndex:= 0;
  cbbTresChange( cbbTres );

  cbbCuatro.Items.Clear;
  cbbCuatro.Items.AddStrings( cbbUno.Items );
  cbbCuatro.ItemIndex:= 0;
  cbbCuatroChange( cbbCuatro );

  bVariosProductos:= False;
  bIncluirProductos:= True;
end;

procedure TFLSalidasResumenDinamico.FormActivate(Sender: TObject);
begin
  Top:= 1;
end;

procedure TFLSalidasResumenDinamico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil( DMSalidasResumenDinamico );
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');

  //Liberamos memoria
  Action := caFree;
end;


function TFLSalidasResumenDinamico.ValidarEntrada: boolean;
var
  sAux: string;
  dIni, dFin: TDateTime;
begin
  result:= True;
  sAux:= '';
  (*Pepe*)
  if STProducto.Caption = '' then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'El código del producto es incorrecto.';
  end;
  if stSalida.Caption = '' then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'El código del centro salida es incorrecto.';
  end;
  if stEnvase.Caption = '' then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'El código del Artículo es incorrecto.';
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

  if result then
  begin
    sEmpresa:= empresa.Text;
    sSalida:= edtCentroSalida.Text;
    sFechaDesde:= fechaDesde.Text;
    sFechaHasta:= fechaHasta.Text;
    sEnvase:= edtEnvase.Text;
    sCliente:= edtCliente.Text;
    sTipoCliente:= edtTipoCliente.Text;
    bExcluirTipoCliente:= chkExcluirTipoCliente.checked;


    if bVariosProductos then
      sProducto := sProductos
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
  end
  else
  begin
    ShowMessage( sAux );
  end;


  iFacturable:= rgFacturable.ItemIndex;
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
        if cbbCuatro.ItemIndex <> 0 then
        begin
          sCuatro:= cbbCuatro.Items[cbbTres.ItemIndex];
        end
        else
        begin
          sCuatro:= '';
        end;
      end
      else
      begin
        sTres:= '';
        sCuatro:= '';
      end;
    end
    else
    begin
      sDos:= '';
      sTres:= '';
      sCuatro:= '';
    end;
  end
  else
  begin
    sUno:= '';
    sDos:= '';
    sTres:= '';
    sCuatro:= '';
  end;
end;

procedure TFLSalidasResumenDinamico.btnOkClick(Sender: TObject);
var
  AAlbaran: string;
  ANoP4H, AVerInterplanta: boolean;
  AEsHortaliza: Integer;
begin
  AEsHortaliza:= rgTipoProducto.itemindex;
  ANoP4H:= chkNoP4h.checked;
  AVerInterplanta:= chkInterplanta.Checked;
  AAlbaran:= '';
  bImportes:= chkVerImportes.Checked;

  if ValidarEntrada then
  begin
    if not DMSalidasResumenDinamico.ListSalidasResumenDinamicoExec(
                           sUno, sDos, sTres, sCuatro, bTotalNivel1, bTotalNivel2, bTotal, bVerTotales,
                           sEmpresa,  sSalida, AAlbaran, sFechaDesde, sFechaHasta,
                           sEnvase, sCliente, sTipoCliente, sProducto, sPais, sCategoria, sCalibre,
                           bImportes, bVariosProductos, bIncluirProductos, bExcluirTipoCliente,  ANoP4H,
                           AVerInterplanta, iFacturable, AEsHortaliza ) then

    begin
      ShowMessage('Sin Datos.');
    end;
  end;
end;

procedure TFLSalidasResumenDinamico.btnCancelClick(Sender: TObject);
begin
  Close;
end;

function TFLSalidasResumenDinamico.productoGetSQL: string;
begin
  result := 'select producto_p, descripcion_p from frf_productos order by producto_p ';
end;

procedure TFLSalidasResumenDinamico.ssEnvaseAntesEjecutar(Sender: TObject);
begin
    ssEnvase.SQLAdi := '';
    if producto.Text <> '' then
      ssEnvase.SQLAdi := ' producto_e = ' +  QuotedStr(producto.Text);
end;

function TFLSalidasResumenDinamico.edtEnvaseGetSQL: String;
begin
  result := 'select envase_e, descripcion_e from frf_envases order by envase_e ';
end;

function TFLSalidasResumenDinamico.edtClienteGetSQL: string;
begin
  result := 'select cliente_c, nombre_c from frf_clientes order by cliente_c ';
end;

procedure TFLSalidasResumenDinamico.cbxNacionalidadKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_return then PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
end;

procedure TFLSalidasResumenDinamico.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLSalidasResumenDinamico.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  if Key = vk_f1 then btnOk.Click else
//    if Key = vk_escape then btnCancel.Click;
end;

procedure TFLSalidasResumenDinamico.empresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(empresa.Text);
  productoChange( producto );
  edtCentroSalidaChange( edtCentroSalida );
  edtClienteChange( edtCliente  );
  edtEnvaseChange( edtEnvase );
end;

procedure TFLSalidasResumenDinamico.productoChange(Sender: TObject);
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

procedure TFLSalidasResumenDinamico.edtCentroSalidaChange(Sender: TObject);
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

procedure TFLSalidasResumenDinamico.edtClienteChange(Sender: TObject);
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

procedure TFLSalidasResumenDinamico.edtEnvaseChange(Sender: TObject);
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

procedure TFLSalidasResumenDinamico.edtEnvaseExit(Sender: TObject);
begin
  if EsNumerico(edtEnvase.Text) and (Length(edtEnvase.Text) <= 5) then
    if (edtEnvase.Text <> '' ) and (Length(edtEnvase.Text) < 9) then
      edtEnvase.Text := 'COM-' + Rellena( edtEnvase.Text, 5, '0');
end;

procedure TFLSalidasResumenDinamico.btnAddProductoClick(
  Sender: TObject);
begin
  bIncluirProductos:= TRue;
  AddProducto( '+' );
end;

procedure TFLSalidasResumenDinamico.btnSubProductoClick(
  Sender: TObject);
begin
  bIncluirProductos:= False;
  AddProducto( '-' );
end;

procedure TFLSalidasResumenDinamico.btnClearProductoClick(
  Sender: TObject);
begin
  bIncluirProductos:= TRue;
  bVariosProductos:= False;
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

procedure TFLSalidasResumenDinamico.AddProducto( const AOperator: string );
begin
  if ( STProducto.Caption = '' ) and ( producto.Text = '' ) then
  begin
    ShowMessage('Seleccione un cliente valido');
  end
  else
  begin
    sProductos:= AddValor( sProductos, producto.Text );
    bVariosProductos:= Pos( ',' , sProductos ) > 0;
    txtLista.Caption:= AOperator + ' ( ' + sProductos +' )';
  end;
end;

function TFLSalidasResumenDinamico.edtTipoClienteGetSQL: String;
begin
    result := 'select * from frf_cliente_tipos order by codigo_ctp';
end;

procedure TFLSalidasResumenDinamico.edtTipoClienteChange(
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

procedure TFLSalidasResumenDinamico.btnComerClick(Sender: TObject);
begin
  categoria.Text:= '1,2,3';
end;

procedure TFLSalidasResumenDinamico.cbbUnoChange(Sender: TObject);
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

procedure TFLSalidasResumenDinamico.cbbDosChange(Sender: TObject);
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

procedure TFLSalidasResumenDinamico.cbbTresChange(Sender: TObject);
begin
  if cbbDos.ItemIndex = 0 then
  begin
    cbbTres.ItemIndex:= 0;
  end;

  if cbbTres.ItemIndex = 0 then
  begin
    if cbbTres.ItemIndex <> 0 then
    begin
      cbbTres.ItemIndex:= 0;
      cbbTresChange( cbbTres );
    end;
    chkAgrupar2.Enabled:= false;
    //chkAgrupar3.Caption:= 'Sin totalizar ';
  end
  else
  begin
    chkAgrupar2.Enabled:= True;
    //chkAgrupar3.Caption:= 'Totalizar ' +  cbbDos.Items[cbbDos.ItemIndex];
  end;
end;

procedure TFLSalidasResumenDinamico.cbbCuatroChange(Sender: TObject);
begin
  if cbbTres.ItemIndex = 0 then
  begin
    cbbCuatro.ItemIndex:= 0;
  end;

  if cbbCuatro.ItemIndex = 0 then
  begin
    //chkAgrupar3.Enabled:= false;
  end
  else
  begin
    //chkAgrupar3.Enabled:= True;
  end;
end;

end.

