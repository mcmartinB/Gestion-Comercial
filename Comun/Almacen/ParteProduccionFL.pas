unit ParteProduccionFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, DB, Grids, DBGrids,
  BSpeedButton, BCalendarButton, ComCtrls, BCalendario, ActnList,
  BGridButton, BGrid;

type
  TFLParteProduccion = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    edtEmpresa: TBEdit;
    nbLabel1: TnbLabel;
    des_empresa: TnbStaticText;
    nbLabel4: TnbLabel;
    edtCentro: TBEdit;
    des_centro: TnbStaticText;
    lblProducto: TnbLabel;
    edtProducto: TBEdit;
    des_producto: TnbStaticText;
    CalendarioFlotante: TBCalendario;
    edtFechaIni: TBEdit;
    btnFechaIni: TBCalendarButton;
    edtFechaFin: TBEdit;
    btnFechaFin: TBCalendarButton;
    lblCodigo1: TnbLabel;
    lblCodigo2: TnbLabel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    ADesplegarRejilla: TAction;
    rejillaFlotante: TBGrid;
    btnEmpresa: TBGridButton;
    btnProducto: TBGridButton;
    btnCentro: TBGridButton;
    cbbTipo: TComboBox;
    lbl1: TLabel;
    lblPlanta: TnbLabel;
    cbbBaseDatos: TComboBox;
    btnEntradas: TSpeedButton;
    btnSotckIniConfeccionado: TSpeedButton;
    chkVerCategorias: TCheckBox;
    lbl2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCentroChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure btnEntradasClick(Sender: TObject);
    procedure btnSotckIniConfeccionadoClick(Sender: TObject);
  private
    { Private declarations }
    { Private declarations }
    sEmpresa, sCentro, sProducto: string;
    dFechaIni, dFechaFin: TDateTime;
    iTipo: Integer;
    sBDReport: string;

    function ValidarParametros: Boolean;
    function RangoFechas( var VMsg: string ): Boolean;
    procedure PrevisualizarListado;
    procedure VerStockProveedorInicial;
    procedure VerStockConfeccionadoInicial;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CAuxiliarDB, UDMAuxDB, Principal, CGestionPrincipal,
     CVariables, CGlobal, bTimeUtils, UDMBaseDatos, UDMConfig,
     ParteProduccionQL, ParteProduccionDetQL,
     ParteProduccionStockProvQL, ParteProduccionStockConfQL;

procedure TFLParteProduccion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFLParteProduccion.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag:= kEmpresa;
  edtCentro.Tag:= kCentro;
  edtProducto.Tag:= kProducto;

  edtEmpresa.Text := gsDefEmpresa;
  edtFechaIni.Tag := kCalendar;
  edtFechaFin.Tag := kCalendar;
  edtFechaIni.Text := DateTostr(Date-1);
  edtFechaFin.Text := DateTostr(Date-1);
  CalendarioFlotante.Date := Date;
  gCF := calendarioFlotante;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

  if DMConfig.eslafont then
  begin
    lblPlanta.Visible:= True;
    cbbBaseDatos.Visible:= True;
    if CGlobal.gProgramVersion = CGlobal.pvSAT then
    begin
      cbbBaseDatos.Items.clear;
      cbbBaseDatos.Items.Add('Peninsula - Los LLanos');
      cbbBaseDatos.Items.Add('Tenerife - Las Moradas');
      cbbBaseDatos.Items.Add('Peninsula - Chanita');
      cbbBaseDatos.ItemIndex:= 0;
    end
    else
    begin
      cbbBaseDatos.Items.clear;
      cbbBaseDatos.Items.Add('Peninsula - F17 Chanita');
      cbbBaseDatos.Items.Add('Peninsula - F18 P4H');
      cbbBaseDatos.Items.Add('Tenerife - F23 Maset');
      cbbBaseDatos.ItemIndex:= 0;
    end;
  end
  else
  begin
    lblPlanta.Visible:= False;
    cbbBaseDatos.Visible:= False;
    if CGlobal.gProgramVersion = CGlobal.pvSAT then
    begin
      if DMConfig.EsLasMoradas then
      begin
        edtCentro.Text:= '6';
      end
      else if DMConfig.EsLosLlanos then
      begin
        edtCentro.Text:= '1';
      end
      else
        edtCentro.Text:= '4';
    end;
  end;

  if CGlobal.gProgramVersion = CGlobal.pvSAT then
  begin
    cbbTipo.Enabled:= False;
    cbbTipo.ItemIndex:= 1;
  end
  else
  begin
    cbbTipo.Enabled:= True;
    cbbTipo.ItemIndex:= 0;
  end;
end;

procedure TFLParteProduccion.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLParteProduccion.btnAceptarClick(Sender: TObject);
begin
  if ValidarParametros then
    PrevisualizarListado;
end;

function TFLParteProduccion.RangoFechas( var VMsg: string ): Boolean;
begin
  VMsg:= '';
  Result:= False;
  if not TryStrToDate( edtFechaIni.Text, dFechaini ) then
  begin
    VMsg:= 'Fecha de inicio incorrecto.'
  end
  else
  if not TryStrToDate( edtFechaFin.Text, dFechafin ) then
  begin
    VMsg:= 'Fecha de fin incorrecto.'
  end
  else
  if dFechaini > dFechaFin then
  begin
    VMsg:= 'Rango de fechas incorrecto.'  end
  else
  begin
    Result:= True;
  end;
end;

function TFLParteProduccion.ValidarParametros: Boolean;
var
  sMsg: string;
begin
  Result:= False;

{
  if ( edtProducto.Text = '' ) and ( edtEmpresa.Text = '050' ) then
  begin
    edtProducto.Text:= 'T';
  end;
}
  if des_empresa.Caption = '' then
  begin
    ShowMessage('Falta el c?digo de la empresa o es incorrecto.');
  end
  else
  if not RangoFechas( sMsg ) then
  begin
    ShowMessage( sMsg );
  end
  else
  if des_producto.Caption = '' then
  begin
    ShowMessage('El c?digo del producto es incorrecto.');
  end
  else
  if des_centro.Caption = '' then
  begin
    ShowMessage('El c?digo del centro es incorrecto.');
  end
  else
  begin
    if not DMconfig.eslafont then
    begin
      sBDReport:= 'BDProyecto';
    end
    else
    begin
      if CGlobal.gProgramVersion = CGlobal.pvSAT then
      begin
        if cbbBaseDatos.ItemIndex = 0 then
          sBDReport:= 'dbLlanos'
        else if cbbBaseDatos.ItemIndex = 1 then
          sBDReport:= 'dbMoradas'
        else
          sBDReport:='dbChanita';
      end
      else
      begin
        if cbbBaseDatos.ItemIndex = 0 then
          sBDReport:= 'dbF17'
        else
        if cbbBaseDatos.ItemIndex = 1 then
          sBDReport:= 'dbF18'
        else
          sBDReport:= 'dbF23';
      end;
    end;
    sEmpresa:= Trim( edtEmpresa.Text );
    sProducto:= Trim( edtProducto.Text );
    sCentro:= Trim( edtCentro.Text );
    iTipo:= cbbTipo.itemIndex;
    Result:= True;
  end;
end;

procedure TFLParteProduccion.PrevisualizarListado;
begin
  if chkVerCategorias.Checked then
    ParteProduccionDetQL.PreviewReporte( sBDReport, sEmpresa, sProducto, sCentro, dFechaIni, dFechaFin, iTipo,   )
  else
    ParteProduccionQL.PreviewReporte( sBDReport, sEmpresa, sProducto, sCentro, dFechaIni, dFechaFin, iTipo,   );
end;

procedure TFLParteProduccion.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edici?n
    //               y entre los Campos de B?squeda en la localizaci?n
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

procedure TFLParteProduccion.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLParteProduccion.ADesplegarRejillaExecute(Sender: TObject);
var
  sEmpresa: string;
begin
  sEmpresa:= edtEmpresa.Text;
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCentro: DespliegaRejilla(btnCentro, [sEmpresa]);
    kProducto: DespliegaRejilla(btnProducto, [sEmpresa]);
    kCalendar:
      begin
        if edtFechaIni.Focused then
          DespliegaCalendario(btnFechaIni)
        else
          DespliegaCalendario(btnFechaFin);
      end;
  end;
end;

procedure TFLParteProduccion.edtEmpresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(edtEmpresa.Text);
  edtCentro.OnChange( edtCentro );
  edtProducto.OnChange( edtProducto );
end;

procedure TFLParteProduccion.edtProductoChange(Sender: TObject);
begin
//  if ( edtProducto.Text = 'E' ) and ( edtEmpresa.Text = '050' ) then
//  begin
//    edtProducto.Text:= 'T';
//  end;
  if edtProducto.Text = '' then
    des_producto.Caption := 'TODOS LOS PRODUCTOS'
  else
    des_producto.Caption := desProducto(edtEmpresa.Text, edtProducto.Text);
end;

procedure TFLParteProduccion.edtCentroChange(Sender: TObject);
begin
  if edtCentro.Text = '' then
  begin
    des_centro.Caption := 'TODOS LOS CENTROS DE LA PLANTA';
  end
  else
  begin
    des_centro.Caption := desCentro(edtEmpresa.Text,  edtCentro.Text );
  end;
end;

procedure TFLParteProduccion.btnEntradasClick(Sender: TObject);
begin
  if ValidarParametros then
    VerStockProveedorInicial;
end;

procedure TFLParteProduccion.VerStockProveedorInicial;
begin
  ParteProduccionStockProvQL.VerStockInicial( sBDReport, sEmpresa, sProducto, sCentro, dFechaIni, iTipo  );
end;

procedure TFLParteProduccion.btnSotckIniConfeccionadoClick(
  Sender: TObject);
begin
  if ValidarParametros then
    VerStockConfeccionadoInicial;
end;

procedure TFLParteProduccion.VerStockConfeccionadoInicial;
begin
  ParteProduccionStockConfQL.VerStockInicial( sBDReport, sEmpresa, sProducto, sCentro, dFechaIni, iTipo  );
end;

end.
