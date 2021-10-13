unit PedidosResumenFL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, StrUtils;

type
  TFLPedidosResumen = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    Label1: TLabel;
    eEmpresa: TBEdit;
    btnEmpresa: TBGridButton;
    lEmpresa: TStaticText;
    Desde: TLabel;
    eFechaDesde: TBEdit;
    btnFechaDesde: TBCalendarButton;
    Label14: TLabel;
    eFechaHasta: TBEdit;
    btnFechaHasta: TBCalendarButton;
    Label3: TLabel;
    eProducto: TBEdit;
    btnProducto: TBGridButton;
    lProducto: TStaticText;
    Label4: TLabel;
    eCliente: TBEdit;
    btnCliente: TBGridButton;
    lCliente: TStaticText;
    Label5: TLabel;
    eSuministro: TBEdit;
    btnSuministro: TBGridButton;
    lSuministro: TStaticText;
    Bevel1: TBevel;
    Label2: TLabel;
    eCentro: TBEdit;
    btnCentro: TBGridButton;
    lCentro: TStaticText;
    lblInformacion: TLabel;
    Label7: TLabel;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    function CamposVacios: boolean;

  private

  public
    procedure InformarProgreso(const ADesRegistro: string; const ARegistro, ARegistros: integer );
  end;

var
  Autorizado: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, DPreview,
  CAuxiliarDB, UDMBaseDatos, bTimeUtils,
  PedidosResumenDL, PedidosResumenQL, CReportes;

{$R *.DFM}

//                         ****  BOTONES  ****
procedure TFLPedidosResumen.BBAceptarClick(Sender: TObject);
var
  QLPedidosResumen: TQLPedidosResumen;
  bSinPedidos: boolean;
begin
  if not CerrarForm(true) then
    Exit;

  if CamposVacios then
    Exit;

  //Consegir datos
  DLPedidosResumen.QueryListado( eEmpresa.Text, eCentro.Text, eCliente.Text, eSuministro.Text, eProducto.Text,
    StrToDate( eFechaDesde.Text), StrToDate( eFechaHasta.Text), bSinPedidos, InformarProgreso );

  //Comprobar que no este vacia la tabla
  if DLPedidosResumen.tListado.IsEmpty then
  begin
    ShowError('No se han encontrado datos para los valores introducidos.');
    EEmpresa.SetFocus;
    Exit;
  end;

  //Llamamos al QReport
  QLPedidosResumen := TQLPedidosResumen.Create(Application);
  QLPedidosResumen.ReportTitle:= 'RESUMEN PEDIDOS POR ENVASE.';
  QLPedidosResumen.sEmpresa:= eEmpresa.Text;
  if eCentro.Text <> '' then
  begin
    QLPedidosResumen.lCentro.Caption:= desCentro( eEmpresa.Text, eCentro.Text );
  end
  else
  begin
    QLPedidosResumen.lCentro.Caption:= 'Todos los Centros.';
  end;
  if eSuministro.Text <> '' then
  begin
    QLPedidosResumen.lSuministro.Caption:= desSuministro( eEmpresa.Text, eCliente.Text, eSuministro.Text );
  end
  else
  begin
    QLPedidosResumen.lSuministro.Caption:= 'Todas las Direcciones de Suministro.';
  end;
  QLPedidosResumen.lCliente.Caption:= eCliente.Text + '-' + desCliente( eEmpresa.Text, eCliente.Text );
  QLPedidosResumen.lFechas.Caption:= 'Del ' + eFechaDesde.Text + ' al ' + eFechaHasta.Text;


  PonLogoGrupoBonnysa( QLPedidosResumen, eEmpresa.Text );
  Preview(QLPedidosResumen);

end;

procedure TFLPedidosResumen.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then
    Close;
end;

//                          **** FORMULARIO ****

procedure TFLPedidosResumen.FormCreate(Sender: TObject);
var
  fecha: tDate;
begin
  FormType := tfOther;
  BHFormulario;

  fecha:= LunesAnterior( Date );
  eFechaDesde.Text := DateToStr(fecha - 7);
  eFechaHasta.Text := DateToStr(fecha - 1);
  eEmpresa.Text:= '050';
  eCentro.Text:= '1';
  eCliente.Text:= 'MER';

  CalendarioFlotante.Date := Date - 1;
  eEmpresa.Tag := kEmpresa;
  eCentro.Tag := kCentro;
  eProducto.Tag := kProducto;
  eCliente.Tag := kCliente;
  eSuministro.Tag := kSuministro;

  eFechaDesde.Tag := kCalendar;
  eFechaHasta.Tag := kCalendar;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  PonNombre( eEmpresa );
  PonNombre( eCentro );
  PonNombre( eProducto );
  PonNombre( eCliente );
  PonNombre( eSuministro );

  PedidosResumenDL.CrearModuloDatos( self );
  lblInformacion.Caption:= '';
end;

procedure TFLPedidosResumen.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    $0D, $28: //vk_return,vk_down
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;
    $26: //vk_up
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        Exit;
      end;
  end;
end;

procedure TFLPedidosResumen.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PedidosResumenDL.DestruirModuloDatos;

  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');
  Action := caFree;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLPedidosResumen.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCentro: DespliegaRejilla(btnCentro,[eEmpresa.Text]);
    kProducto: DespliegaRejilla(btnProducto,[eEmpresa.Text]);
    kCliente: DespliegaRejilla(btnCliente,[eEmpresa.Text]);
    kSuministro: DespliegaRejilla(btnSuministro,[eEmpresa.Text, eCliente.Text]);
    kCalendar:
      begin
        if eFechaDesde.Focused then
          DespliegaCalendario(btnFechaDesde)
        else
          DespliegaCalendario(btnFechaHasta);
      end;
  end;
end;

procedure TFLPedidosResumen.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa:
    begin
      lEmpresa.Caption := desEmpresa(eEmpresa.Text);
    end;
    kCentro:
    begin
      lCentro.Caption := desCentro(eEmpresa.Text, eCentro.Text );
    end;
    kProducto:
    begin
      if eProducto.Text = '' then
        lProducto.Caption := 'TODOS LOS PRODUCTOS'
      else
        lProducto.Caption := desProducto(eEmpresa.Text, eProducto.Text );
    end;
    kCliente:
    begin
      lCliente.Caption := desCliente(eEmpresa.Text, eCliente.Text );
    end;
    kSuministro:
    begin
      if eSuministro.Text = '' then
        lSuministro.Caption := 'TODAS LAS DIRECCIONES SUMINISTRO'
      else
        lSuministro.Caption := desSuministro(eEmpresa.Text, eCliente.Text, eSuministro.Text );
    end;
  end;
end;

function TFLPedidosResumen.CamposVacios: boolean;
begin
        //Comprobamos que los campos esten todos con datos
  if EEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene el código de la empresa');
    EEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if ECentro.Text = '' then
  begin
    ShowError('Es necesario que rellene el código del centro.');
    ECentro.SetFocus;
    Result := True;
    Exit;
  end;

  if ECliente.Text = '' then
  begin
    ShowError('Es necesario que rellene el código del cliente.');
    ECliente.SetFocus;
    Result := True;
    Exit;
  end;

  if eFechaDesde.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    eFechaDesde.SetFocus;
    Result := True;
    Exit;
  end;

  if eFechaHasta.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    eFechaHasta.SetFocus;
    Result := True;
    Exit;
  end;

  Result := False;
end;

procedure TFLPedidosResumen.InformarProgreso(const ADesRegistro: string; const ARegistro, ARegistros: integer );
begin
  if ADesRegistro = 'FIN' then
  begin
    lblInformacion.Caption:= '';
  end
  else
  begin
    lblInformacion.Caption:= 'Pedido número [' + ADesRegistro + '].' + #13 + #10 +
      'Procesando pedido ' + IntToStr(ARegistro) + ' de ' + IntToStr(ARegistros) + '.';
  end;
  Application.ProcessMessages;
end;

end.
