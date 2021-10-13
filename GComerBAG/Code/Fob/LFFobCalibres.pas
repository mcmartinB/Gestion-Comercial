unit LFFobCalibres;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, DBTables, ExtCtrls, DBCtrls;

type
  TFFobCalibres = class(TForm)
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
    BGBCentro: TBGridButton;
    BGBProducto: TBGridButton;
    eProducto: TBEdit;
    eCentro: TBEdit;
    eEmpresa: TBEdit;
    STEmpresa: TStaticText;
    STCentro: TStaticText;
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
    Label4: TLabel;
    eCategoria: TBEdit;
    Label5: TLabel;
    subPanel: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
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
  FFobCalibres: TFFobCalibres;
  Autorizado: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, DPreview, CReportes, LFFobCalibresData,
     LFFobCalibresReport2, CAuxiliarDB, UDMBaseDatos, UDMCambioMoneda,
     QuickRpt, UDMConfig;

{$R *.DFM}

//                         ****  BOTONES  ****

procedure TFFobCalibres.BBAceptarClick(Sender: TObject);
var
  FFobCalibresReport2: TFFobCalibresReport2;
begin
  if not CerrarForm(true) or CamposVacios then Exit;
  Self.ActiveControl := nil;

  FFobCalibresData:= TFFobCalibresData.Create( self );
  try
    if FFobCalibresData.ObtenerDatosListado( eEmpresa.Text, eCentro.Text, eProducto.Text,
                                          eCategoria.Text, dFechaDesde, dFechaHasta,
                                          CheckBox1.Checked, CheckBox2.Checked, CheckBox3.Checked ) then
    begin
      FFobCalibresReport2:= TFFobCalibresReport2.Create( self );
      try
        FFobCalibresData.RellenarTablaPorCalibres;
        try
          FFobCalibresReport2.lblCentro.Caption:= 'ORIGEN: '+ eCentro.Text;
          FFobCalibresReport2.lblProducto.Caption:= 'PRODUCTO: '+ eProducto.Text;
          FFobCalibresReport2.lblRango.Caption:= 'DEL '+ eFDesde.Text + ' AL ' + eFHasta.Text;
          if eCategoria.Text <> '' then
          begin
            FFobCalibresReport2.lblCategoria.Caption:= 'CATEGORIA: '+ eCategoria.Text;
          end
          else
          begin
            FFobCalibresReport2.lblCategoria.Caption:= 'TODAS LAS CATEGORIAS.';
          end;
          PonLogoGrupoBonnysa( FFobCalibresReport2, eEmpresa.Text );
          Preview(FFobCalibresReport2);
        finally
          FFobCalibresData.kbmPorCalibres.Close;
        end;
      except
        FreeAndNil(FFobCalibresReport2);
        Raise;
      end;
    end;
  finally
    FreeAndNil( FFobCalibresData );
  end;
end;

procedure TFFobCalibres.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then
    Close;
end;

//                          **** FORMULARIO ****

procedure TFFobCalibres.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  ECentro.Tag := kCentro;
  EProducto.Tag := kProducto;
  eFDesde.Tag := kCalendar;
  eFHasta.Tag := kCalendar;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  eEmpresa.Text:= gsDefEmpresa;
  eCentro.Text:= gsDefCentro;
  eProducto.Text:= gsDefProducto;
  eFDesde.Text := DateTostr(Date - 6);
  eFHasta.Text := DateTostr(Date);
  CalendarioFlotante.Date := Date;  

  if not DMConfig.EsLaFont then
  begin
    subPanel.Enabled:= False;
  end;
end;

procedure TFFobCalibres.FormActivate(Sender: TObject);
begin
  Top := 1;
  ActiveControl := EEmpresa;
end;

procedure TFFobCalibres.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFFobCalibres.FormClose(Sender: TObject;
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

procedure TFFobCalibres.eFHastaExit(Sender: TObject);
begin
  if StrToDate(EFHasta.Text) < StrToDate(EFDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    EFDesde.SetFocus;
  end;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFFobCalibres.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kCentro: DespliegaRejilla(BGBCentro, [EEmpresa.Text]);
    kCalendar:
      begin
        if EFDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFFobCalibres.PonNombre(Sender: TObject);
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
    kCentro: STCentro.Caption := desCentro(Eempresa.Text, Ecentro.Text);
  end;
end;

function TFFobCalibres.CamposVacios: boolean;
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

  if ECentro.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    ECentro.SetFocus;
    Result := True;
    Exit;
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
