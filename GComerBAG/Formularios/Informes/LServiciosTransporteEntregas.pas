unit LServiciosTransporteEntregas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList,
  ComCtrls, CGestionPrincipal, BCalendario, Grids,
  DBGrids, BGrid, BCalendarButton, BEdit, BSpeedButton, BGridButton,
  DBTables, CheckLst;

type
  TFLServiciosTransporteEntregas = class(TForm)
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
    procedure eTransportistaChange(Sender: TObject);
    procedure eCentroLlegadaChange(Sender: TObject);

  private
    { Private declarations }
    sEmpresa, sCentroLlegada, sTransportista, sProducto: string;
    dFechaIni, dFechaFin: TDateTime;

    function  ValidarParametros: boolean;
    procedure VerListado;
    procedure DesProductoOptativo;
    procedure DesCentroLlegadaOptativo;
    procedure DesTransportistaOptativo;
  public
    { Public declarations }
  end;

implementation

uses UDMAuxDB, CVariables, Principal, CReportes, DLServiciosTransporteEntregas,
  CAuxiliarDB, QLServiciosTransporteEntregas, DPreview, bTimeUtils, DateUtils,
  UDMBaseDatos, UFTransportistas;


{$R *.DFM}

procedure TFLServiciosTransporteEntregas.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then
    Close;
end;


function TFLServiciosTransporteEntregas.ValidarParametros: boolean;
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
  sCentroLlegada:= eCentroLlegada.Text;
  sTransportista:= eTransportista.Text;
  sProducto:= eProducto.Text;
  result:= True;
end;

procedure TFLServiciosTransporteEntregas.VerListado;
begin
  QRLServiciosTransporteEntregas := TQRLServiciosTransporteEntregas.Create(Application);

  PonLogoGrupoBonnysa(QRLServiciosTransporteEntregas, EEmpresa.Text);
  QRLServiciosTransporteEntregas.lblFecha.Caption:= 'DEL ' + DateToStr( dFechaIni ) + ' AL ' + DateToStr( dFechaFin );
  if eCentroLlegada.Text = '' then
    QRLServiciosTransporteEntregas.lblDestino.Caption:= 'CENTRO LLEGADA: TODOS'
  else
    QRLServiciosTransporteEntregas.lblDestino.Caption:= 'CENTRO LLEGADA: ' + eCentroLlegada.Text + ' ' + stCentroLlegada.Caption;
  if eProducto.Text = '' then
    QRLServiciosTransporteEntregas.lblProducto.Caption:=  'TODOS LOS PRODUCTOS'
  else
    QRLServiciosTransporteEntregas.lblProducto.Caption:=  'PRODUCTO: ' + eProducto.Text + ' ' + stProducto.Caption;
  QRLServiciosTransporteEntregas.lblMatricula.Enabled:= cbxVehiculo.Checked;
  case cbxAgrupacion.ItemIndex of
    0: begin
         QRLServiciosTransporteEntregas.lblAgrupa.Caption:= 'Fecha';
       end;
    1: begin
         QRLServiciosTransporteEntregas.lblAgrupa.Caption:= 'Año/Sem.';
       end;
    2: begin
         QRLServiciosTransporteEntregas.lblAgrupa.Caption:= 'Año/mes';
       end;
    3: begin
         QRLServiciosTransporteEntregas.lblAgrupa.Caption:= '';
       end;
  end;
  QRLServiciosTransporteEntregas.lblPortes.Caption:= 'PORTES: ' + UpperCase(cbxPortes.Items[cbxPortes.ItemIndex]);

  try
    Preview(QRLServiciosTransporteEntregas);
  except
    FreeAndNil( QRLServiciosTransporteEntregas );
    raise;
  end;
end;

procedure TFLServiciosTransporteEntregas.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;

  if ValidarParametros then
  begin
    try
      if DMLServiciosTransporteEntregas.ObtenerDatos( sEmpresa, sCentroLlegada,
                                                       sTransportista, sProducto, dFechaIni,
                                                       dFechaFin, cbxVehiculo.Checked,
                                                       cbxPortes.ItemIndex, cbxAgrupacion.ItemIndex ) then
        VerListado
      else
        ShowMessage('No hay datos para los parametros introducidos.');
    finally
      DMLServiciosTransporteEntregas.LimpiarDatos;
    end;
  end;
end;

procedure TFLServiciosTransporteEntregas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  FreeAndNIl( DMLServiciosTransporteEntregas );
  Action := caFree;
end;

procedure TFLServiciosTransporteEntregas.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  eEmpresa.Tag := kEmpresa;
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

  DMLServiciosTransporteEntregas:= TDMLServiciosTransporteEntregas.Create( self );
end;

procedure TFLServiciosTransporteEntregas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLServiciosTransporteEntregas.ADesplegarRejillaExecute(Sender: TObject);
var
  sAux: string;
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro:
    begin
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

procedure TFLServiciosTransporteEntregas.DesProductoOptativo;
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

procedure TFLServiciosTransporteEntregas.DesCentroLlegadaOptativo;
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

procedure TFLServiciosTransporteEntregas.DesTransportistaOptativo;
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

procedure TFLServiciosTransporteEntregas.eEmpresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(Eempresa.Text);
  DesCentroLlegadaOptativo;
  DesProductoOptativo;
  DesTransportistaOptativo;
end;

procedure TFLServiciosTransporteEntregas.eCentroLlegadaChange(Sender: TObject);
begin
  DesCentrollegadaOptativo;
end;

procedure TFLServiciosTransporteEntregas.eProductoChange(Sender: TObject);
begin
  DesProductoOptativo;
end;

procedure TFLServiciosTransporteEntregas.eTransportistaChange(
  Sender: TObject);
begin
  DesTransportistaOptativo;
end;

end.
