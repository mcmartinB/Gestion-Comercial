unit LServiciosTransporteTransitos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList,
  ComCtrls, CGestionPrincipal, BCalendario, Grids,
  DBGrids, BGrid, BCalendarButton, BEdit, BSpeedButton, BGridButton,
  DBTables, CheckLst;

type
  TFLServiciosTransporteTransitos = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    LEmpresa: TLabel;
    eEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    lblDesde: TLabel;
    eDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label2: TLabel;
    Label1: TLabel;
    eProducto: TBEdit;
    btnProducto: TBGridButton;
    stProducto: TStaticText;
    lblCentroSalida: TLabel;
    eCentroSalida: TBEdit;
    btnCentroSalida: TBGridButton;
    stCentroSalida: TStaticText;
    eHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    cbxPortes: TComboBox;
    Label4: TLabel;
    Label6: TLabel;
    cbxAgrupacion: TComboBox;
    cbxVehiculo: TCheckBox;
    Label7: TLabel;
    Label8: TLabel;
    lblTransportista: TLabel;
    eTransportista: TBEdit;
    btnTransportista: TBGridButton;
    stTransportista: TStaticText;
    lblCentroLlegada: TLabel;
    eCentroLlegada: TBEdit;
    btnCentroLlegada: TBGridButton;
    stCentroLlegada: TStaticText;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure eEmpresaChange(Sender: TObject);
    procedure eProductoChange(Sender: TObject);
    procedure eCentroSalidaChange(Sender: TObject);
    procedure eTransportistaChange(Sender: TObject);
    procedure eCentroLlegadaChange(Sender: TObject);

  private
    { Private declarations }
    sEmpresa, sCentroSalida, sCentroLlegada, sTransportista, sProducto: string;
    dFechaIni, dFechaFin: TDateTime;

    function  ValidarParametros: boolean;
    procedure VerListado;
    procedure DesProductoOptativo;
    procedure DesCentroSalidaOptativo;
    procedure DesCentroLlegadaOptativo;
    procedure DesTransportistaOptativo;
  public
    { Public declarations }
  end;

implementation

uses UDMAuxDB, CVariables, Principal, CReportes, DLServiciosTransporteTransitos,
  CAuxiliarDB, QLServiciosTransporteTransitos, DPreview, bTimeUtils, DateUtils,
  UDMBaseDatos, UFTransportistas;


{$R *.DFM}

procedure TFLServiciosTransporteTransitos.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then
    Close;
end;


function TFLServiciosTransporteTransitos.ValidarParametros: boolean;
begin
  result:= False;
  //Comprobar parametros de entrada
  if STEmpresa.Caption = '' then
  begin
    MessageDlg('Falta o código de empresa incorrecto', mtError, [mbOk], 0);
    EEmpresa.SetFocus;
    Exit;
  end;

  if not TryStrToDate( eDesde.Text, dFechaIni ) then
  begin
    MessageDlg('Fecha de inicio incorrecta ...', mtError, [mbOk], 0);
    eDesde.SetFocus;
    Exit;
  end;
  if not TryStrToDate( eHasta.Text, dFechaFin ) then
  begin
    MessageDlg('Fecha de fin incorrecta ...', mtError, [mbOk], 0);
    eHasta.SetFocus;
    Exit;
  end;
  if dFechaIni > dFechaFin then
  begin
    MessageDlg('Rango de fechas incorrecto ...', mtError, [mbOk], 0);
    eDesde.SetFocus;
    Exit;
  end;

  if STCentroSalida.Caption = '' then
  begin
    MessageDlg('El código del centro de salida es incorrecto', mtError, [mbOk], 0);
    eCentroSalida.SetFocus;
    Exit;
  end;

  if stCentroLlegada.Caption = '' then
  begin
    MessageDlg('El código del centro de llegada es incorrecto', mtError, [mbOk], 0);
    eCentroLlegada.SetFocus;
    Exit;
  end;

  if stTransportista.Caption = '' then
  begin
    MessageDlg('Código de transportista incorrecto', mtError, [mbOk], 0);
    eTransportista.SetFocus;
    Exit;
  end;

  if STProducto.Caption = '' then
  begin
    MessageDlg('Código de producto incorrecto', mtError, [mbOk], 0);
    EProducto.SetFocus;
    Exit;
  end;

  sEmpresa:= eEmpresa.Text;
  sCentroSalida:= eCentroSalida.Text;
  sCentroLlegada:= eCentroLlegada.Text;
  sTransportista:= eTransportista.Text;
  sProducto:= eProducto.Text;
  result:= True;
end;

procedure TFLServiciosTransporteTransitos.VerListado;
begin
  QRLServiciosTransporteTransitos := TQRLServiciosTransporteTransitos.Create(Application);

  PonLogoGrupoBonnysa(QRLServiciosTransporteTransitos, EEmpresa.Text);
  QRLServiciosTransporteTransitos.lblFecha.Caption:= 'DEL ' + DateToStr( dFechaIni ) + ' AL ' + DateToStr( dFechaFin );
  if eCentroSalida.Text = '' then
    QRLServiciosTransporteTransitos.lblCentro.Caption:=  'CENTRO SALIDA: TODOS'
  else
    QRLServiciosTransporteTransitos.lblCentro.Caption:=  'CENTRO SALIDA: ' + eCentroSalida.Text + ' ' + stCentroSalida.Caption;
  (*TODO*)
  if eCentroLlegada.Text = '' then
    QRLServiciosTransporteTransitos.lblDestino.Caption:= 'CENTRO LLEGADA: TODOS'
  else
    QRLServiciosTransporteTransitos.lblDestino.Caption:= 'CENTRO LLEGADA: ' + eCentroLlegada.Text + ' ' + stCentroLlegada.Caption;
  if eProducto.Text = '' then
    QRLServiciosTransporteTransitos.lblProducto.Caption:=  'TODOS LOS PRODUCTOS'
  else
    QRLServiciosTransporteTransitos.lblProducto.Caption:=  'PRODUCTO: ' + eProducto.Text + ' ' + stProducto.Caption;
  QRLServiciosTransporteTransitos.lblMatricula.Enabled:= cbxVehiculo.Checked;
  case cbxAgrupacion.ItemIndex of
    0: begin
         QRLServiciosTransporteTransitos.lblAgrupa.Caption:= 'Fecha';
       end;
    1: begin
         QRLServiciosTransporteTransitos.lblAgrupa.Caption:= 'Año/Sem.';
       end;
    2: begin
         QRLServiciosTransporteTransitos.lblAgrupa.Caption:= 'Año/mes';
       end;
    3: begin
         QRLServiciosTransporteTransitos.lblAgrupa.Caption:= '';
       end;
  end;
  QRLServiciosTransporteTransitos.lblPortes.Caption:= 'PORTES: ' + UpperCase(cbxPortes.Items[cbxPortes.ItemIndex]);

  try
    Preview(QRLServiciosTransporteTransitos);
  except
    FreeAndNil( QRLServiciosTransporteTransitos );
    raise;
  end;
end;

procedure TFLServiciosTransporteTransitos.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;

  if ValidarParametros then
  begin
    try
      if DMLServiciosTransporteTransitos.ObtenerDatos( sEmpresa, sCentroSalida, sCentroLlegada,
                                                       sTransportista, sProducto, dFechaIni,
                                                       dFechaFin, cbxVehiculo.Checked,
                                                       cbxPortes.ItemIndex, cbxAgrupacion.ItemIndex ) then
        VerListado
      else
        ShowMessage('No hay datos para los parametros introducidos.');
    finally
      DMLServiciosTransporteTransitos.LimpiarDatos;
    end;
  end;
end;

procedure TFLServiciosTransporteTransitos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  FreeAndNIl( DMLServiciosTransporteTransitos );
  Action := caFree;
end;

procedure TFLServiciosTransporteTransitos.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  eEmpresa.Tag := kEmpresa;
  eCentroSalida.Tag := kCentro;
  eCentroLlegada.Tag := kCentro;
  eTransportista.Tag:= kTransportista;
  eProducto.Tag := kProducto;
  eDesde.Tag := kCalendar;
  eHasta.Tag := kCalendar;

  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := CalendarioFlotante;

  eEmpresa.Text := gsDefEmpresa;

  dFechaIni:= LunesAnterior( Date ) - 6;
  CalendarioFlotante.Date := dFechaIni;
  eDesde.Text:= DateToStr( dFechaIni );
  dFechaFin:= Date;
  eHasta.Text:= DateToStr( dFechaFin );

  DMLServiciosTransporteTransitos:= TDMLServiciosTransporteTransitos.Create( self );
end;

procedure TFLServiciosTransporteTransitos.FormKeyDown(Sender: TObject; var Key: Word;
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
  end;
end;

procedure TFLServiciosTransporteTransitos.ADesplegarRejillaExecute(Sender: TObject);
var
  sAux: string;
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro:
    begin
      if eCentroSalida.Focused then
        DespliegaRejilla(btnCentroSalida, [eEmpresa.Text])
      else
        DespliegaRejilla(btnCentroLlegada, [eEmpresa.Text]);
    end;
    kTransportista: //DespliegaRejilla(btnTransportista);
    begin
      sAux:= eTransportista.Text;
      if SeleccionaTransportista( self, eTransportista, eEmpresa.Text, sAux ) then
      begin
        eTransportista.Text:= sAux;
      end;
    end;
    kProducto: DespliegaRejilla(btnProducto,[eEmpresa.Text]);
    kCalendar:
    begin
      if eDesde.Focused then
        DespliegaCalendario(BCBDesde)
      else
        DespliegaCalendario(BCBHasta);
    end;
  end;
end;

procedure TFLServiciosTransporteTransitos.DesProductoOptativo;
begin
  if eProducto.Text = '' then
  begin
    stProducto.Caption := 'VACIO = TODOS LOS PRODUCTOS';
  end
  else
  begin
    stProducto.Caption := desProducto(Eempresa.Text, eProducto.Text);
  end;
end;

procedure TFLServiciosTransporteTransitos.DesCentroSalidaOptativo;
begin
  if eCentroSalida.Text = '' then
  begin
    stCentroSalida.Caption := 'VACIO = TODOS LOS CENTROS';
  end
  else
  begin
    stCentroSalida.Caption := desCentro(Eempresa.Text, eCentroSalida.Text);
  end;
end;

procedure TFLServiciosTransporteTransitos.DesCentroLlegadaOptativo;
begin
  if eCentroLlegada.Text = '' then
  begin
    stCentroLlegada.Caption := 'VACIO = TODOS LOS CENTROS';
  end
  else
  begin
    stCentroLlegada.Caption := desCentro(Eempresa.Text, eCentroLlegada.Text);
  end;
end;

procedure TFLServiciosTransporteTransitos.DesTransportistaOptativo;
begin
  if eTransportista.Text = '' then
  begin
    stTransportista.Caption := 'VACIO = TODOS LOS TRANSPORTISTAS';
  end
  else
  begin
    stTransportista.Caption := desTransporte(Eempresa.Text, eTransportista.Text);
  end;
end;

procedure TFLServiciosTransporteTransitos.eEmpresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(Eempresa.Text);
  DesCentroSalidaOptativo;
  DesCentroLlegadaOptativo;
  DesProductoOptativo;
  DesTransportistaOptativo;
end;

procedure TFLServiciosTransporteTransitos.eCentroSalidaChange(Sender: TObject);
begin
  DesCentroSalidaOptativo;
end;

procedure TFLServiciosTransporteTransitos.eCentroLlegadaChange(Sender: TObject);
begin
  DesCentrollegadaOptativo;
end;

procedure TFLServiciosTransporteTransitos.eProductoChange(Sender: TObject);
begin
  DesProductoOptativo;
end;

procedure TFLServiciosTransporteTransitos.eTransportistaChange(
  Sender: TObject);
begin
  DesTransportistaOptativo;
end;

end.
