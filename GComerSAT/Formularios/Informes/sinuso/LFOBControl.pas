unit LFOBControl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, StrUtils, DBCtrls;

type
  TFLFOBControl = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    Label1: TLabel;
    edtEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    STCentro: TStaticText;
    BGBCentro: TBGridButton;
    edtCentro: TBEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtProducto: TBEdit;
    BGBProducto: TBGridButton;
    STProducto: TStaticText;
    BCBDesde: TBCalendarButton;
    edtDesde: TBEdit;
    Desde: TLabel;
    Label14: TLabel;
    edtHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    cbxTipoListado: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    lblEspere1: TLabel;
    lblEspere2: TLabel;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function CamposVacios: boolean;
    procedure FormDestroy(Sender: TObject);

  private
    empresa, centro, producto, fechainicio, fechafin: string;

  public

  end;

var
  Autorizado: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, DPreview, UDMControlFob, QRControlFob,
  CAuxiliarDB, UDMBaseDatos, bDialogs, bMath, bTimeUtils;

{$R *.DFM}

//                         ****  BOTONES  ****

procedure TFLFOBControl.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;
  if CamposVacios then EXit;

  //inicio:= GetTickCount;
  if (empresa <> edtEmpresa.Text) or (centro <> edtCentro.Text) or (producto <> edtProducto.Text) or
    (fechainicio <> edtDesde.Text) or (fechafin <> edtHasta.Text) then
  begin
    empresa := edtEmpresa.Text;
    centro := edtCentro.Text;
    producto := Trim(edtProducto.Text);
    fechainicio := edtDesde.Text;
    fechafin := edtHasta.Text;

    lblEspere1.Visible := true;
    if (centro = '6') and (StrToDate(fechaFin) - StrToDate(fechainicio) >= 15) then
    begin
      lblEspere2.Visible := true;
    end;
    Application.ProcessMessages;

    DMControlFob.RellenaTablas(empresa, centro, producto, fechainicio, fechafin);

    lblEspere1.Visible := false;
    lblEspere2.Visible := false;
    Application.ProcessMessages;
  end;
  //Informar( intToStr( insertados ) + ':' + IntToStr( Trunc( ( GetTickCount - inicio ) / 1000 ) ) );
  QRControlFob.Previsualizar(empresa, centro, producto, fechainicio, fechafin,
    cbxTipoListado.ItemIndex, cbxTipoListado.Text);
end;

procedure TFLFOBControl.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                          **** FORMULARIO ****

procedure TFLFOBControl.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Text := '050';
  edtCentro.Text := '1';
     //edtProducto.Text:= 'T';
  STEmpresa.Caption := desEmpresa(edtEmpresa.Text);
  STCentro.Caption := desCentro(edtEmpresa.Text, edtCentro.Text);
  STProducto.Caption := desProducto(edtEmpresa.Text, edtProducto.Text);
  edtDesde.Text := DateTostr(LunesAnterior(Date) - 7);
  edtHasta.Text := DateTostr(LunesAnterior(Date) - 1);
  CalendarioFlotante.Date := Date;
  edtEmpresa.Tag := kEmpresa;
  edtCentro.Tag := kCentro;
  edtProducto.Tag := kProducto;
  edtDesde.Tag := kCalendar;
  edtHasta.Tag := kCalendar;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  DMControlFob := TDMControlFob.Create(nil);

  empresa := '';
  centro := '';
  producto := '';
  fechainicio := '';
  fechafin := '';
end;

procedure TFLFOBControl.FormDestroy(Sender: TObject);
begin
  FreeAndNil(DMControlFob);
end;

procedure TFLFOBControl.FormActivate(Sender: TObject);
begin
  ActiveControl := edtEmpresa;
end;

procedure TFLFOBControl.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLFOBControl.FormClose(Sender: TObject;
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

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLFOBControl.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro: DespliegaRejilla(BGBCentro, [edtEmpresa.Text]);
    kProducto: DespliegaRejilla(BGBProducto, [edtEmpresa.Text]);
    kCalendar:
      begin
        if edtDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLFOBControl.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(edtEmpresa.Text);
    kCentro: STCentro.Caption := desCentro(edtEmpresa.Text, edtCentro.Text);
    kProducto: STProducto.Caption := desProducto(edtEmpresa.Text, edtProducto.Text);
  end;
end;

function TFLFOBControl.CamposVacios: boolean;
begin
        //Comprobamos que los campos esten todos con datos
  if edtEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    edtEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if edtCentro.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    edtCentro.SetFocus;
    Result := True;
    Exit;
  end;

(*
        if edtProducto.Text = '' then
          begin
           ShowError('Es necesario que rellene todos los campos de edición');
           edtProducto.SetFocus;
           Result:=True;
           Exit;
          end;
*)

  if edtDesde.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    edtDesde.SetFocus;
    Result := True;
    Exit;
  end;

  if edtHasta.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    edtHasta.SetFocus;
    Result := True;
    Exit;
  end;

  Result := False;
end;

end.
