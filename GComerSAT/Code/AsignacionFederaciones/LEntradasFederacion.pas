unit LEntradasFederacion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList,
  ComCtrls, CGestionPrincipal, BCalendario, Grids,
  DBGrids, BGrid, BCalendarButton, BEdit, BSpeedButton, BGridButton,
  DBTables;

type
  TFLLEntradasFederacion = class(TForm)
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
    EEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    Lunes: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label2: TLabel;
    lblAnyoSemana: TLabel;
    Label1: TLabel;
    eProducto: TBEdit;
    btnProducto: TBGridButton;
    stProducto: TStaticText;
    Label3: TLabel;
    eCentro: TBEdit;
    btnCentro: TBGridButton;
    stCentro: TStaticText;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure EEmpresaChange(Sender: TObject);
    procedure MEDesdeChange(Sender: TObject);
    procedure eProductoChange(Sender: TObject);
    procedure eCentroChange(Sender: TObject);

  private
    { Private declarations }
    sEmpresa, sCentro, sProducto: string;
    dLunes: TDateTime;

    function  ValidarParametros: boolean;
    function  ObtenerDatos: boolean;
    procedure VerListado;
    procedure CerrarTablas;
    procedure DesProductoOptativo;
  public
    { Public declarations }
  end;

implementation

uses UDMAuxDB, CVariables, Principal, CReportes, DLEntradasFederacion,
  CAuxiliarDB, QLEntradasFederacion, DPreview, bTimeUtils, DateUtils,
  UDMBaseDatos;


{$R *.DFM}

procedure TFLLEntradasFederacion.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then
    Close;
end;


function TFLLEntradasFederacion.ValidarParametros: boolean;
var
  dFechaIni: TDateTime;
begin
  result:= False;
  //Comprobar parametros de entrada
  if STEmpresa.Caption = '' then
  begin
    MessageDlg('Falta o código de empresa incorrecto', mtError, [mbOk], 0);
    EEmpresa.SetFocus;
    Exit;
  end;

  if STCentro.Caption = '' then
  begin
    MessageDlg('Falta o código de centro incorrecto', mtError, [mbOk], 0);
    ECentro.SetFocus;
    Exit;
  end;

  if not TryStrToDate( MEDesde.Text, dFechaIni ) then
  begin
    MessageDlg('Fecha de inicio incorrecta ...', mtError, [mbOk], 0);
    MEDesde.SetFocus;
    Exit;
  end;

  if STProducto.Caption = '' then
  begin
    MessageDlg('Código de producto incorrecto', mtError, [mbOk], 0);
    EProducto.SetFocus;
    Exit;
  end;

  sEmpresa:= eEmpresa.Text;
  sCentro:= eCentro.Text;
  sProducto:= eProducto.Text;
  dLunes:= LunesAnterior( dFechaIni );
  result:= True;
end;

function TFLLEntradasFederacion.ObtenerDatos: boolean;
begin
  result:= False;

  with DMLEntradasFederacion do
  begin
    QListado.SQL.Clear;
    QListado.SQL.Add(' select empresa_p, producto_p, nvl(federacion_p,0) federacion_p, cosechero_p, ');
    QListado.SQL.Add('        plantacion_p, ano_semana_p, sum( total_kgs_e2l ) kilos_p ');
    QListado.SQL.Add(' from frf_entradas2_l, frf_plantaciones ');
    QListado.SQL.Add(' where empresa_e2l = :empresa ');
    QListado.SQL.Add(' and centro_e2l = :centro ');
    QListado.SQL.Add(' and fecha_e2l between :fechaini and :fechafin ');
    QListado.SQL.Add(' and empresa_p = :empresa ');
    QListado.SQL.Add(' and cosechero_p = cosechero_e2l ');
    QListado.SQL.Add(' and plantacion_p = plantacion_e2l ');
    QListado.SQL.Add(' and ano_semana_p = ano_sem_planta_e2l ');
    if sProducto <> '' then
    begin
      QListado.SQL.Add(' and producto_p = :producto ');
      QListado.SQL.Add(' and producto_e2l = :producto ');
    end
    else
    begin
      QListado.SQL.Add(' and producto_p = producto_e2l ');
    end;
    QListado.SQL.Add(' group by empresa_p, producto_p, federacion_p, cosechero_p, plantacion_p, ano_semana_p ');
    QListado.SQL.Add(' order by empresa_p, producto_p, federacion_p, cosechero_p, plantacion_p, ano_semana_p ');

    QListado.ParamByName('empresa').AsString:= sEmpresa;
    QListado.ParamByName('centro').AsString:= sCentro;
    QListado.ParamByName('fechaini').AsDate:= dLunes;
    QListado.ParamByName('fechafin').AsDate:= dLunes + 6;
    if sProducto <> '' then
    begin
      QListado.ParamByName('producto').AsString:= sProducto;
    end;

    try
      QListado.Open;
      result:= not QListado.IsEmpty;
    except
      on E: Exception do
      begin
        MessageDlg('Error al abrir la consulta del Listado...', mtError, [mbOk], 0);
        Exit;
      end;
    end;
  end;

  if result then
    DMLEntradasFederacion.PorcentajesEntregas( sEmpresa, sCentro, sProducto, dLunes );
end;

procedure TFLLEntradasFederacion.CerrarTablas;
begin
  DMLEntradasFederacion.QListado.Close;
end;

procedure TFLLEntradasFederacion.VerListado;
begin
  QRLLEntradasFederacion := TQRLLEntradasFederacion.Create(Application);
  QRLLEntradasFederacion.lblFecha.Caption:= 'SEMANA ' + AnyoSemana( dLunes ) + ', DEL ' +
                                  DateToStr( dLunes ) + ' AL ' + DateToStr( dLunes + 6);
  QRLLEntradasFederacion.lblCentro.Caption:=  'CENTRO: ' + eCentro.Text + ' ' + stCentro.Caption;
  PonLogoGrupoBonnysa(QRLLEntradasFederacion, EEmpresa.Text);
  try
    Preview(QRLLEntradasFederacion);
  except
    FreeAndNil( QRLLEntradasFederacion );
    raise;
  end;
end;

procedure TFLLEntradasFederacion.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;

  if ValidarParametros then
  begin
    try
      if ObtenerDatos then
        VerListado;
    finally
      CerrarTablas;
    end;
  end;
end;

procedure TFLLEntradasFederacion.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  FreeAndNIl( DMLEntradasFederacion );
  Action := caFree;
end;

procedure TFLLEntradasFederacion.FormCreate(Sender: TObject);
var
  dFecha: TDateTime;
begin
  FormType := tfOther;
  BHFormulario;

  eEmpresa.Tag := kEmpresa;
  eCentro.Tag := kCentro;
  eProducto.Tag := kProducto;
  MEDesde.Tag := kCalendar;

  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := CalendarioFlotante;

  EEmpresa.Text := '050';
  eCentro.Text:= '1';
  //eProducto.Text:= 'T';

  dFecha:= LunesAnterior( Date ) - 7;
  CalendarioFlotante.Date := dFecha;
  MEDesde.Text:= DateToStr( dFEcha );

  DMLEntradasFederacion:= TDMLEntradasFederacion.Create( self );
end;

procedure TFLLEntradasFederacion.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLLEntradasFederacion.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro: DespliegaRejilla(btnCentro);
    kProducto: DespliegaRejilla(btnProducto,[eEmpresa.Text]);
    kCalendar: DespliegaCalendario(BCBDesde)
  end;
end;

procedure TFLLEntradasFederacion.DesProductoOptativo;
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

procedure TFLLEntradasFederacion.EEmpresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(Eempresa.Text);
  stCentro.Caption := desCentro(Eempresa.Text, eCentro.Text);
  DesProductoOptativo;
end;

procedure TFLLEntradasFederacion.eCentroChange(Sender: TObject);
begin
  stCentro.Caption := desCentro(Eempresa.Text, eCentro.Text);
end;

procedure TFLLEntradasFederacion.eProductoChange(Sender: TObject);
begin
  DesProductoOptativo;
end;

procedure TFLLEntradasFederacion.MEDesdeChange(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if TryStrToDate( MEDesde.text, dFEcha ) then
  begin
    dFecha:= LunesAnterior( dFecha );
    lblAnyoSemana.Caption:= AnyoSemana( StrToDateTime(MEDesde.text) ) + ' del ' +
                            DateToStr( dFecha ) + ' al ' + DateToStr( dFecha + 6 );;
  end
  else
  begin
    lblAnyoSemana.Caption:= '';
  end;
end;

end.
