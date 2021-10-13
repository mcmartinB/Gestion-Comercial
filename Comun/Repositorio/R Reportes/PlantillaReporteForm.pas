unit PlantillaReporteForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, DB, Grids, DBGrids,
  BSpeedButton, BCalendarButton, ComCtrls, BCalendario, ActnList,
  BGridButton, BGrid;

type
  TFPlantillaReporte = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    edtEmpresa: TBEdit;
    edtAnyo: TBEdit;
    edtMes: TBEdit;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    des_empresa: TnbStaticText;
    des_mes: TnbStaticText;
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
    lblCliente: TnbLabel;
    edtCliente: TBEdit;
    btnCliente: TBGridButton;
    des_cliente: TnbStaticText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure edtMesChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCentroChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
  private
    { Private declarations }
    { Private declarations }
    sEmpresa, sCentro, sCliente, sProducto: string;
    dFechaIni, dFechaFin: TDateTime;
    iAnyo, iMes: Integer;

    function ValidarParametros: Boolean;
    procedure PrevisualizarListado;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CAuxiliarDB, UDMAuxDB, Principal, CGestionPrincipal, CVariables, CGlobal,
     bTimeUtils, UDMBaseDatos, PlantillaReporteReport;

procedure TFPlantillaReporte.FormClose(Sender: TObject;
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

procedure TFPlantillaReporte.FormCreate(Sender: TObject);
var
  year, month, day: word;
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag:= kEmpresa;
  edtCentro.Tag:= kCentro;
  edtCliente.Tag:= kCliente;
  edtProducto.Tag:= kProducto;

  //edtEmpresa.Text := gsDefEmpresa;
  if CGlobal.gProgramVersion = CGlobal.pvBAG then
  begin
    edtEmpresa.Text := 'BAG';
  end
  else
  begin
    edtEmpresa.Text := 'SAT';
  end;
  edtCentro.Text := gsDefCentro;

  edtFechaIni.Tag := kCalendar;
  edtFechaFin.Tag := kCalendar;
  edtFechaIni.Text := DateTostr(Date-7);
  edtFechaFin.Text := DateTostr(Date-1);
  CalendarioFlotante.Date := Date;
  gCF := calendarioFlotante;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

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
  edtAnyo.Text := IntToStr(year);
  edtMes.Text := IntToStr(month);
end;

procedure TFPlantillaReporte.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFPlantillaReporte.btnAceptarClick(Sender: TObject);
begin
  if ValidarParametros then
    PrevisualizarListado;
end;

function TFPlantillaReporte.ValidarParametros: Boolean;
begin
  Result:= False;
  if esMes(edtMes.Text) then
  begin
    if length(Trim(edtAnyo.Text)) = 4 then
    begin
      if des_empresa.Caption = '' then
      begin
        ShowMessage('Falta el código de la empresa o es incorrecto.');
        edtEmpresa.SetFocus;
      end
      else
      if des_centro.Caption = '' then
      begin
        ShowMessage('Falta el código del centro o es incorrecto.');
        edtCentro.SetFocus;
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
          sCentro:= edtCentro.Text;
          sProducto:= edtProducto.Text;
          sCliente:= edtCliente.Text;
          iAnyo:= StrToInt(edtAnyo.Text);
          iMes:= StrToInt( edtMes.Text);
          Result:= True;
        end;
      end;
    end
    else
    begin
      ShowMessage('El año debe tener 4 digitos.');
      edtAnyo.SetFocus;
    end;
  end
  else
  begin
    ShowMessage('Valor para el mes incorrecto.');
    edtMes.SetFocus;
  end;
end;

procedure TFPlantillaReporte.PrevisualizarListado;
begin
  PlantillaReporteReport.PreviewPlantillaReporte( sEmpresa, sCentro, sCliente, sProducto, dFechaIni, dFechaFin, iAnyo, iMes );
end;

procedure TFPlantillaReporte.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFPlantillaReporte.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFPlantillaReporte.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCentro: DespliegaRejilla(btnCentro, [edtEmpresa.Text]);
    kProducto: DespliegaRejilla(btnProducto, [edtEmpresa.Text]);
    kCalendar:
      begin
        if edtFechaIni.Focused then
          DespliegaCalendario(btnFechaIni)
        else
          DespliegaCalendario(btnFechaFin);
      end;
  end;
end;

procedure TFPlantillaReporte.edtEmpresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(edtEmpresa.Text);
  edtCentro.OnChange( edtCentro );
  edtProducto.OnChange( edtProducto );
  edtCliente.OnChange( edtCliente );
end;

procedure TFPlantillaReporte.edtCentroChange(Sender: TObject);
begin
  des_centro.Caption := desCentro(edtEmpresa.Text, edtCentro.Text);
end;

procedure TFPlantillaReporte.edtProductoChange(Sender: TObject);
begin
  if edtProducto.Text = '' then
    des_producto.Caption := 'TODOS LOS PRODUCTOS'
  else
    des_producto.Caption := desProducto(edtEmpresa.Text, edtProducto.Text);
end;

procedure TFPlantillaReporte.edtMesChange(Sender: TObject);
begin
  des_mes.Caption := desMes(edtMes.Text);
end;

procedure TFPlantillaReporte.edtClienteChange(Sender: TObject);
begin
  if edtCliente.Text = '' then
    des_cliente.Caption := 'TODOS LOS CLIENTES'
  else
    des_cliente.Caption := desCliente(edtEmpresa.Text,  edtCliente.Text);
end;

end.
