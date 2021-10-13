unit LFFobTransitos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, DBTables, ExtCtrls, DBCtrls;

type
  TFFobTransitos = class(TForm)
    Panel1: TPanel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    GBEmpresa: TGroupBox;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    BGBEmpresa: TBGridButton;
    BGBDestino: TBGridButton;
    BGBProducto: TBGridButton;
    eProducto: TBEdit;
    eDestino: TBEdit;
    eEmpresa: TBEdit;
    STEmpresa: TStaticText;
    STDestino: TStaticText;
    STProducto: TStaticText;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    TTemporal: TTable;
    QTemporal: TQuery;
    Desde: TLabel;
    eFDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label14: TLabel;
    eFHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    Label6: TLabel;
    cbxGastos: TCheckBox;
    cbxEnvase: TCheckBox;
    cbxSecciones: TCheckBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    cbxExcluir036: TCheckBox;
    Label11: TLabel;
    eSalida: TBEdit;
    BGBSalida: TBGridButton;
    STSalida: TStaticText;
    Label4: TLabel;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure eFHastaExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function CamposVacios: boolean;
  private
    {private declarations}
    dFechaDesde, dFechaHasta: TDateTime;

  public
    { Public declarations }

  end;

var
  FFobTransitos: TFFobTransitos;
  Autorizado: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, DPreview, CReportes, LFFobTransitosData,
     CAuxiliarDB, UDMBaseDatos, UDMCambioMoneda, LFFobTransitosReport;

{$R *.DFM}

//                         ****  BOTONES  ****

procedure TFFobTransitos.BBAceptarClick(Sender: TObject);
var
  FFobTransitosReport: TFFobTransitosReport;
begin
  if not CerrarForm(true) or CamposVacios then Exit;
  Self.ActiveControl := nil;

  FFobTransitosData:= TFFobTransitosData.Create( self );
  try
    if FFobTransitosData.ObtenerDatosListado( eEmpresa.Text, eSalida.Text, eDestino.Text,
      eProducto.Text, dFechaDesde, dFechaHasta, cbxGastos.Checked,
      cbxExcluir036.Checked, cbxEnvase.Checked, cbxSecciones.Checked ) then
    begin
      FFobTransitosReport:= TFFobTransitosReport.Create( self );
      try
        FFobTransitosData.RellenarTablaListadoAnyoSemana;
        try
          FFobTransitosReport.lblEmpresa.Caption:= 'EMPRESA: '+ eEmpresa.Text;
          FFobTransitosReport.lblOrigen.Caption:= 'SALIDA: '+ eSalida.Text;
          FFobTransitosReport.lblDestino.Caption:= 'DESTINO: '+ eDestino.Text;
          FFobTransitosReport.lblProducto.Caption:= 'PRODUCTO: '+ eProducto.Text;
          FFobTransitosReport.lblRango.Caption:= 'DEL '+ eFDesde.Text + ' AL ' + eFHasta.Text;
          FFobTransitosData.kbmListadoAnyoSemana.First;
          Preview(FFobTransitosReport);
        finally
          FFobTransitosData.CerrarTablasListado;
        end;
      except
        FreeAndNil(FFobTransitosReport);
        Raise;
      end;
    end;
  finally
    FreeAndNil( FFobTransitosData );
  end;
end;

procedure TFFobTransitos.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then
    Close;
end;

//                          **** FORMULARIO ****

procedure TFFobTransitos.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  Esalida.Tag := kCentro;
  EDestino.Tag := kCentro;
  EProducto.Tag := kProducto;
  eFDesde.Tag := kCalendar;
  eFHasta.Tag := kCalendar;

  eEmpresa.Text:= gsDefEmpresa;
  eSalida.Text:= gsDefCentro;
  STsalida.Caption := desCentro(Eempresa.Text, esalida.Text);
  eDestino.Text:= 'P';//gsDefCentro;
  eProducto.Text:= gsDefProducto;
  eFDesde.Text := DateTostr(Date - 6);
  eFHasta.Text := DateTostr(Date);
  CalendarioFlotante.Date := Date;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

end;

procedure TFFobTransitos.FormActivate(Sender: TObject);
begin
  Top := 1;
  ActiveControl := EEmpresa;
end;

procedure TFFobTransitos.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFFobTransitos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
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

//                     ****  CAMPOS DE EDICION  ****

procedure TFFobTransitos.eFHastaExit(Sender: TObject);
begin
  if StrToDate(EFHasta.Text) < StrToDate(EFDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    EFDesde.SetFocus;
  end;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFFobTransitos.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kCentro:
    begin
      if esalida.Focused then
        DespliegaRejilla(BGBsalida, [EEmpresa.Text])
      else
        DespliegaRejilla(BGBDestino, [EEmpresa.Text]);
    end;
    kCalendar:
      begin
        if EFDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFFobTransitos.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(Eempresa.Text);
    kProducto: STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
    kCentro:
    begin
      if esalida.Focused then
        STsalida.Caption := desCentro(Eempresa.Text, esalida.Text)
      else
        STDestino.Caption := desCentro(Eempresa.Text, eDestino.Text);
    end;
  end;
end;

function TFFobTransitos.CamposVacios: boolean;
begin
        //Comprobamos que los campos esten todos con datos
  if EEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if EProducto.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EProducto.SetFocus;
    Result := True;
    Exit;
  end;

  if esalida.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    esalida.SetFocus;
    Result := True;
    Exit;
  end;

  if eDestino.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    eDestino.SetFocus;
    Result := True;
    Exit;
  end
  else
  begin
    if ( eDestino.Text >= '1' ) and ( eDestino.Text <= '9' ) then
    begin
      ShowError('Es necesario el centro de detino este en el extranjero.');
      eDestino.SetFocus;
      Result := True;
      Exit;
    end;
  end;

  if not TryStrToDate( eFDesde.Text, dFechaDesde ) then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EFDesde.SetFocus;
    Result := True;
    Exit;
  end;

  if not TryStrToDate( eFHasta.Text, dFechaHasta ) then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EFHasta.SetFocus;
    Result := True;
    Exit;
  end;

  Result := False;
end;


end.
