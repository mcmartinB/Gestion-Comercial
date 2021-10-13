unit SalidasSuperForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, DB, Grids, DBGrids,
  BSpeedButton, BCalendarButton, ComCtrls, BCalendario, ActnList,
  BGridButton, BGrid;

type
  TFSalidasSuper = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    edtEmpresa: TBEdit;
    nbLabel1: TnbLabel;
    des_empresa: TnbStaticText;
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
    lblCliente: TnbLabel;
    edtCliente: TBEdit;
    btnCliente: TBGridButton;
    des_cliente: TnbStaticText;
    nbLabel2: TnbLabel;
    edtTipoCliente: TBEdit;
    btnTipoCliente: TBGridButton;
    des_TipoCliente: TnbStaticText;
    chkExcluir: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtProductoChange(Sender: TObject);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
    procedure edtTipoClienteChange(Sender: TObject);
  private
    { Private declarations }
    { Private declarations }
    sEmpresa,  sCliente, sTipoCliente, sProducto: string;
    dFechaIni, dFechaFin: TDateTime;
    bExcluir: Boolean;
    //iAnyo, iMes: Integer;

    function ValidarParametros: Boolean;
    procedure PrevisualizarListado;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CAuxiliarDB, UDMAuxDB, Principal, CGestionPrincipal, CVariables,
     bTimeUtils, UDMBaseDatos, SalidasSuperReport, CGlobal, UDMMaster;

procedure TFSalidasSuper.FormClose(Sender: TObject;
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

procedure TFSalidasSuper.FormCreate(Sender: TObject);
var
  year, month, day: word;
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag:= kEmpresa;
  edtCliente.Tag:= kCliente;
  edtProducto.Tag:= kProducto;
  edtTipoCliente.Tag:= kTipoCliente;

  //edtEmpresa.Text := gsDefEmpresa;
  if CGlobal.gProgramVersion = CGlobal.pvBAG then
  begin
    edtEmpresa.Text := 'BAG';
  end
  else
  begin
    edtEmpresa.Text := 'SAT';
  end;

  edtTipoCliente.Text:= 'SM';

  edtFechaIni.Tag := kCalendar;
  edtFechaFin.Tag := kCalendar;
  edtFechaIni.Text := DateTostr(Date-7);
  edtFechaFin.Text := DateTostr(Date-1);
  CalendarioFlotante.Date := Date;
  gCF := calendarioFlotante;

  gRF := rejillaFlotante;

  DecodeDate(Date, year, month, day);
  if month = 1 then
  begin
    year := year - 1;
    month := 12;
  end
  else
  begin
    Dec(month);
  end;
end;

procedure TFSalidasSuper.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFSalidasSuper.btnAceptarClick(Sender: TObject);
begin
  if ValidarParametros then
    PrevisualizarListado;
end;

function TFSalidasSuper.ValidarParametros: Boolean;
begin
  Result:= False;
  if des_empresa.Caption = '' then
  begin
        ShowMessage('Falta el código de la empresa o es incorrecto.');
        edtEmpresa.SetFocus;
  end
  else
  if des_producto.Caption = '' then
  begin
        ShowMessage('Falta el código del producto o es incorrecto.');
        edtProducto.SetFocus;
  end
  else
  if des_cliente.Caption = '' then
  begin
        ShowMessage('Falta el código del cliente o es incorrecto.');
        edtCliente.SetFocus;
  end
  else
  if des_TipoCliente.Caption = '' then
  begin
      ShowMessage('Falta el tipo de cliente o es incorrecto.');
        edtTipoCliente.SetFocus;
  end
  else
  begin
        if not TryStrToDate( edtFechaIni.Text, dFechaIni ) then
        begin
          ShowMessage('Falta la fecha de inicio o es incorrecta.');
          edtFechaIni.SetFocus;
        end
        else
        if not TryStrToDate( edtFechaFin.Text, dFechaFin ) then
        begin
          ShowMessage('Falta la fecha de fin o es incorrecta.');
          edtFechaFin.SetFocus;
        end
        else
        if dFechaIni > dFechaFin then
        begin
          ShowMessage('rango de fechas incorrecto.');
          edtFechaIni.SetFocus;
        end
        else
        begin
          sEmpresa:= edtEmpresa.Text;
          sProducto:= edtProducto.Text;
          sCliente:= edtCliente.Text;
          sTipoCliente:= edtTipoCliente.Text;
          bExcluir:= chkExcluir.Checked;
          Result:= True;
        end;
  end;
end;

procedure TFSalidasSuper.PrevisualizarListado;
begin
  SalidasSuperReport.PreviewSalidasSuper( sEmpresa, sCliente, sTipoCliente, sProducto, dFechaIni, dFechaFin, bExcluir );
end;

procedure TFSalidasSuper.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFSalidasSuper.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFSalidasSuper.ADesplegarRejillaExecute(Sender: TObject);
begin
    RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kProducto: DespliegaRejilla(btnProducto, [edtEmpresa.Text]);
    kCalendar:
      begin
        if edtFechaIni.Focused then
          DespliegaCalendario(btnFechaIni)
        else
          DespliegaCalendario(btnFechaFin);
      end;
    kTipoCliente:
    begin
      RejillaFlotante.DataSource := UDMMaster.DMMaster.dsDespegables;
      UDMMaster.DMMaster.DespliegaRejilla(btnTipoCliente, ['']);
    end;
  end;
end;

procedure TFSalidasSuper.edtEmpresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(edtEmpresa.Text);
  edtProducto.OnChange( edtProducto );
  edtCliente.OnChange( edtCliente );
end;

procedure TFSalidasSuper.edtProductoChange(Sender: TObject);
begin
  if edtProducto.Text = '' then
    des_producto.Caption := 'TODOS LOS PRODUCTOS'
  else
    des_producto.Caption := desProducto(edtEmpresa.Text, edtProducto.Text);
end;

procedure TFSalidasSuper.edtClienteChange(Sender: TObject);
begin
  if edtCliente.Text = '' then
    des_cliente.Caption := 'TODOS LOS CLIENTES'
  else
    des_cliente.Caption := desCliente(edtEmpresa.Text,  edtCliente.Text);
end;

procedure TFSalidasSuper.edtTipoClienteChange(Sender: TObject);
begin
  if edtTipoCliente.Text = '' then
    des_TipoCliente.Caption := ''
  else
    des_TipoCliente.Caption := UDMMaster.DMMaster.desTipoCliente(edtTipoCliente.Text );
end;

end.
