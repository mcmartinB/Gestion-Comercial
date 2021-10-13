unit LInformeEntradas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, ActnList, ComCtrls, Db,
  CGestionPrincipal, BEdit, BCalendarButton, BSpeedButton, BGridButton,
  BCalendario, BGrid, DError, QuickRpt, Grids, DBGrids;

type
  TFLInformeEntradas = class(TForm)
    Panel1: TPanel;
    GBCosechero: TGroupBox;
    Label4: TLabel;
    Label7: TLabel;
    GBFecha: TGroupBox;
    Desde: TLabel;
    Label14: TLabel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    GBEmpresa: TGroupBox;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    BGBEmpresa: TBGridButton;
    BGBCentro: TBGridButton;
    BGBProducto: TBGridButton;
    EProducto: TBEdit;
    ECentro: TBEdit;
    EEmpresa: TBEdit;
    STEmpresa: TStaticText;
    STCentro: TStaticText;
    STProducto: TStaticText;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    EDesde: TBEdit;
    EHasta: TBEdit;
    EDesde2: TBEdit;
    EHasta2: TBEdit;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    ACancelar: TAction;
    cmbPunto: TComboBox;
    Label8: TLabel;
    eAgrupacion: TBEdit;
    BGBAgrupacion: TBGridButton;
    STAgrupacion: TStaticText;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure MEHastaExit(Sender: TObject);
    procedure EHastaExit(Sender: TObject);
    procedure EHasta2Exit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure eAgrupacionChange(Sender: TObject);

  public
    { Public declarations }

  end;

var
  Autorizado: boolean;

implementation

uses Principal, CVariables, CAuxiliarDB, UDMAuxDB, CReportes, bSQLUtils,
  DPreview, UDMBaseDatos, RInformeEntradas, DBTables, UDMConfig;

{$R *.DFM}

procedure TFLInformeEntradas.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;
        //Comprobamos que los campos esten todos con datos
  if stEmpresa.Caption = '' then
  begin
    ShowError('El codigo de la empresa es incorrecto');
    EEmpresa.SetFocus;
    Exit;
  end;

  if stCentro.Caption = '' then
  begin
    ShowError('El codigo del centro es incorrecto');
    ECentro.SetFocus;
    Exit;
  end;

  if Trim( STAgrupacion.Caption ) = '' then
  begin
    ShowError('El código de agrupación es incorrecto');
    EAgrupacion.SetFocus;
    Exit;
  end;

  if stProducto.Caption = '' then
  begin
    ShowError('El codigo del producto es incorrecto');
    ECentro.SetFocus;
    Exit;
  end;

  if EDesde.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EDesde.SetFocus;
    Exit;
  end;

  if EHasta.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EHasta.SetFocus;
    Exit;
  end;

  if EDesde2.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EDesde2.SetFocus;
    Exit;
  end;

  if EHasta2.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EHasta2.SetFocus;
    Exit;
  end;


    //Llamamos al QReport
  QRInformeEntradas := TQRInformeEntradas.Create(Application);

  PonLogoGrupoBonnysa(QRInformeEntradas, '');
  QRInformeEntradas.lblRangoFecha1.Caption := 'Desde el ' + MEDesde.Text +
    ' al ' + MEHasta.Text;

  QRInformeEntradas.LoadQuery( cmbPunto.ItemIndex, EEmpresa.Text, ECentro.Text, EProducto.Text, EAgrupacion.Text );
  with QRInformeEntradas.QListado do
  begin
    if EEmpresa.Text <> '' then
      ParamByName('empresa').AsString := EEmpresa.Text;
    if ECentro.Text <> '' then
      ParamByName('centro').AsString := ECentro.Text;
    if EProducto.Text <> '' then
      ParamByName('producto').AsString := EProducto.Text;
    if EAgrupacion.Text <> '' then
      ParamByName('agrupacion').AsString := EAgrupacion.Text;

    ParamByName('fechaini').AsString := MEDesde.Text;
    ParamByName('fechafin').AsString := MEHasta.Text;
    ParamByName('cosecheroini').AsString := EDesde.Text;
    ParamByName('cosecherofin').AsString := EHasta.Text;
    ParamByName('plantacionini').AsString := EDesde2.Text;
    ParamByName('plantacionfin').AsString := EHasta2.Text;
  end;

  QRInformeEntradas.QListado.Open;
  if QRInformeEntradas.QListado.isEmpty then
  begin
    FreeAndNil( QRInformeEntradas );
    ShowMessage('Sin Datos.');
  end
  else
  begin
    Preview(QRInformeEntradas);
  end;
end;

procedure TFLInformeEntradas.eAgrupacionChange(Sender: TObject);
begin
  if Trim( eAgrupacion.Text ) = '' then
    STAgrupacion.Caption := 'TODAS LAS AGRUPACIONES'
  else
    STAgrupacion.Caption := desAgrupacion(eAgrupacion.Text);
end;

procedure TFLInformeEntradas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseAuxQuerys;
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

procedure TFLInformeEntradas.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  ECentro.Tag := kCentro;
  EAgrupacion.Tag := kAgrupacion;
  EProducto.Tag := kProducto;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  cmbPunto.Visible:= DMConfig.EsLaFont;

  EEmpresa.Text:= '';
  ECentro.Text:= '';
  EProducto.Text:= '';
  PonNombre(EEmpresa);
  EDesde.Text := '0';
  EHasta.Text := '999';
  EDesde2.Text := '0';
  EHasta2.Text := '999';
  MEDesde.Text := DateTostr(Date-7);
  MEHasta.Text := DateTostr(Date-1);
  CalendarioFlotante.Date := Date;

  eAgrupacionChange(eagrupacion);

end;

procedure TFLInformeEntradas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLInformeEntradas.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kAgrupacion: DespliegaRejilla(BGBAgrupacion);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kCentro: DespliegaRejilla(BGBCentro, [EEmpresa.Text]);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLInformeEntradas.PonNombre(Sender: TObject);
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
        if Eempresa.Text = '' then
          STEmpresa.Caption := 'TODAS LAS EMPRESAS'
        else
          STEmpresa.Caption := desEmpresa(Eempresa.Text);
        PonNombre( Ecentro );
        PonNombre( Eproducto );
      end;
    kProducto:
    begin
      if Eproducto.Text = '' then
        STProducto.Caption := 'TODOS LOS PRODUCTOS'
      else
        STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
    end;
    kAgrupacion:
    begin

      if ( EAgrupacion.Text = '' ) then
        STAgrupacion.Caption:= 'TODAS LAS AGRUPACIONES'
      else
        STAgrupacion.Caption := desAgrupacion(EAgrupacion.Text);
    end;
    kCentro:
    begin
      if ECentro.Text = '' then
        STCentro.Caption := 'TODOS LOS CENTROS'
      else
        STCentro.Caption := desCentro(Eempresa.Text, Ecentro.Text);
    end;
  end;
end;

procedure TFLInformeEntradas.MEHastaExit(Sender: TObject);
begin
  if StrToDate(MEHasta.Text) < StrToDate(MEDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    MEDesde.SetFocus;
  end;
end;

procedure TFLInformeEntradas.EHastaExit(Sender: TObject);
begin
  if StrToInt(EHasta.Text) < StrToInt(EDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de cosecheros correcto',
      mtError, [mbOk], 0);
    EDesde.SetFocus;
  end;
end;

procedure TFLInformeEntradas.EHasta2Exit(Sender: TObject);
begin
  if StrToInt(EHasta2.Text) < StrToInt(EDesde2.Text) then
  begin
    MessageDlg('Debe escribir un rango de plantaciones correcto',
      mtError, [mbOk], 0);
    EDesde2.SetFocus;
  end;
end;

procedure TFLInformeEntradas.FormActivate(Sender: TObject);
begin
  Top := 1;
  ActiveControl := EEmpresa;
end;

procedure TFLInformeEntradas.ACancelarExecute(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

end.
