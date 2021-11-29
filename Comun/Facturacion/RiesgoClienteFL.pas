unit RiesgoClienteFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, ExtCtrls, nbButtons,
  nbEdits, nbCombos, BSpeedButton, BCalendarButton, ComCtrls, BCalendario,
  BGridButton, Grids, DBGrids, BGrid, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinFoggy,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, dxSkinBlue;

type
  TFLRiesgoCliente = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    edtEmpresa: TBEdit;
    lblEmpresa: TnbLabel;
    etqEmpresa: TnbStaticText;
    lblCliente: TnbLabel;
    edtCliente: TBEdit;
    etqCliente: TnbStaticText;
    Label1: TLabel;
    rbtCliente: TRadioButton;
    rbtPais: TRadioButton;
    Bevel1: TBevel;
    Label2: TLabel;
    CalendarioFlotante: TBCalendario;
    lblNombre2: TnbLabel;
    eFechaDesde: TBEdit;
    btnFechaDesde: TBCalendarButton;
    chkVer: TCheckBox;
    chkTodos: TCheckBox;
    lblTipoCliente: TLabel;
    edtTipoCliente: TBEdit;
    btnTipoCliente: TBGridButton;
    txtTipoCliente: TStaticText;
    chkTipoCliente: TCheckBox;
    RejillaFlotante: TBGrid;
    nbLabel1: TnbLabel;
    cxNacional: TcxComboBox;
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
    procedure rbtClienteClick(Sender: TObject);
    procedure btnFechaDesdeClick(Sender: TObject);
    procedure chkTodosClick(Sender: TObject);
    procedure edtTipoClienteChange(Sender: TObject);
    procedure btnTipoClienteClick(Sender: TObject);
  private
    { Private declarations }
    dFecha: TDateTime;


    function ValidarEntrada: Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
  FacturacionCB, DB, CAuxiliarDB, RiesgoTodosClienteQL, DError, UDMMaster,
  RiesgoDL, CGlobal, DateUtils, UDMBaseDatos;

procedure TFLRiesgoCliente.FormClose(Sender: TObject;
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

procedure TFLRiesgoCliente.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  if CGlobal.gProgramVersion = pvBag then
    edtEmpresa.Text := 'BAG'
  else
    edtEmpresa.Text := 'SAT';
  edtTipoCliente.Tag := kTipoCliente;
  edtTipoCliente.Text:= 'IP';

  //edtCliente.Text := gsDefCliente;
  edtCliente.Text:= '';
  CalendarioFlotante.Date := Date;
  gCF := calendarioFlotante;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;  
  eFechaDesde.Text := DateTostr(IncYear( Date,  -2 ));
end;

procedure TFLRiesgoCliente.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLRiesgoCliente.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLRiesgoCliente.edtEmpresaChange(Sender: TObject);
begin
  etqEmpresa.Caption:= desEmpresa( edtEmpresa.Text );
end;

procedure TFLRiesgoCliente.edtClienteChange(Sender: TObject);
begin
  if rbtCliente.Checked then
    etqCliente.Caption := desCliente( edtCliente.Text )
  else
    etqCliente.Caption := desPais( edtCliente.Text )
end;

procedure TFLRiesgoCliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
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

function TFLRiesgoCliente.ValidarEntrada: Boolean;
begin
  result := false;
  //El codigo de empresa es obligatorio
  if Trim( edtEmpresa.Text ) = '' then
  begin
    edtEmpresa.SetFocus;
    ShowMessage('El código de empresa es obligatorio.');
    Exit;
  end;
  if not TryStrToDate( eFechaDesde.Text, dFecha ) then
  begin
    edtEmpresa.SetFocus;
    ShowMessage('La fecha es incorrecta.');
    Exit;
  end;

  //Comprobar que el tipo cliente si tiene valor sea valido
  if (trim(edtTipoCliente.Text) <> '') then
  begin
    if txtTipoCliente.Caption = '' then
    begin
      ShowError('El código del tipo cliente no es correcto.');
      edtTipoCliente.Focused;
      Exit;
    end;
  end;

  result := true;
end;

procedure TFLRiesgoCliente.btnAceptarClick(Sender: TObject);
var
  Parametros: RClienteQL;
  bAbonos, bIVA, bConRiesgo: Boolean;
  iDiasCobroPagare, iDeficit: Integer;
  sMsg: string;
begin
  if ValidarEntrada then
  begin
    Parametros.sEmpresa:= edtEmpresa.Text;
    Parametros.dFechaDesde:= dFecha;
    if rbtCliente.Checked then
    begin
      Parametros.sCliente:= edtCliente.Text;
      Parametros.sPais:= '';
    end
    else
    begin
      Parametros.sCliente:= '';
      Parametros.sPais:= edtCliente.Text;
    end;
    Parametros.sTipoCliente:= edtTipoCliente.Text;
    Parametros.bExcluirTipoCliente:= chkTipoCliente.Checked;
    Parametros.sNacional := copy(cxNacional.Text,1,1);

    bConRiesgo:= chkVer.Checked;
    bAbonos:= True;
    bIVA:= True;
    iDiasCobroPagare:= -1;        //Antes habia 0, y al sacar el informe las remesas que se habian hecho en el mismo dia del informe se sumaba a lo pendiente facturado
    iDeficit:= 0;
    sMsg:= '';

    if chkTodos.Checked then
    begin
      if not RiesgoExecute( Self, Parametros.sEmpresa, Parametros.sCliente,Parametros.sPais, Parametros.sTipoCliente, Parametros.sNacional,
                   Parametros.bExcluirTipoCliente, Parametros.dFechaDesde, Now, iDiasCobroPagare, iDeficit,
                   bAbonos, bIVA, bConRiesgo, sMsg ) then
      begin
        ShowMessage( sMsg );
      end;
    end
    else
    begin
      RiesgoTodosClienteQL.ExecuteReport( Self, Parametros, chkVer.Checked );
    end;
  end;
end;




procedure TFLRiesgoCliente.rbtClienteClick(Sender: TObject);
begin
  if rbtCliente.Checked then
  begin
    etqCliente.Caption := desCliente( edtCliente.Text );
    edtCliente.MaxLength:= 3;
  end
  else
  begin
    etqCliente.Caption := desPais( edtCliente.Text );
    if Length( edtcliente.Text ) = 3 then
    begin
      edtcliente.Text:= copy( edtcliente.Text, 1, 2 );
    end;
    edtCliente.MaxLength:= 2;
  end;
end;

procedure TFLRiesgoCliente.btnFechaDesdeClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kCalendar:
      begin
        if eFechaDesde.Focused then
          DespliegaCalendario(btnFechaDesde);
      end;
  end;
end;

procedure TFLRiesgoCliente.chkTodosClick(Sender: TObject);
begin
  Label2.Visible:= not chkTodos.Checked;
end;

procedure TFLRiesgoCliente.edtTipoClienteChange(Sender: TObject);
begin
  IF edtTipoCliente.Text = '' then
  begin
    txtTipoCliente.Caption := 'TODOS LOS TIPOS';
  end
  else
  begin
    txtTipoCliente.Caption := desTipoCliente(edtTipoCliente.Text );
  end;
end;

procedure TFLRiesgoCliente.btnTipoClienteClick(Sender: TObject);
begin
  RejillaFlotante.DataSource := UDMMaster.DMMaster.dsDespegables;
  UDMMaster.DMMaster.DespliegaRejilla(btnTipoCliente, ['']);
end;

end.
