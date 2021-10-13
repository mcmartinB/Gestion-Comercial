unit FacturasSinContabilizarFD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, dbtables;

type
  TFDFacturasSinContabilizar = class(TForm)
    Panel1: TPanel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    Label1: TLabel;
    EEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    Desde: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label14: TLabel;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    rbPendientesComer: TRadioButton;
    rbPendientesX3: TRadioButton;
    rbDiff: TRadioButton;
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
    
  private

  public
    { Public declarations }
    sEmpresa: string;
    dIni, dFin: TDateTime;
  end;

var
  listar: boolean;

implementation

uses FacturasSinContabilizarDM, Principal, CVariables, CAuxiliarDB, 
  UDMBaseDatos, CGlobal, UDMAuxDB;

{$R *.DFM}

//                         ****  BOTONES  ****

procedure TFDFacturasSinContabilizar.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;

   if not CamposVacios then
   begin
     if rbPendientesComer.checked then
     begin
       if not FacturasSinContabilizarDM.PendienteContabilizarComer( sEmpresa, dIni, dFin ) then
       begin
         ShowError('No hay facturas para los parametros seleccionados.');
       end;
     end
     else
     if rbPendientesX3.checked then
     begin
       if not FacturasSinContabilizarDM.PendienteContabilizarX3( sEmpresa, dIni, dFin ) then
       begin
         ShowError('No hay facturas para los parametros seleccionados.');
       end;
     end
     else
     if rbDiff.checked then
     begin
       if not FacturasSinContabilizarDM.ComparaComerX3( sEmpresa, dIni, dFin ) then
       begin
         ShowError('No hay facturas para los parametros seleccionados.');
       end;
     end;
   end;
end;

procedure TFDFacturasSinContabilizar.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then
    Close;
end;

//                          **** FORMULARIO ****

procedure TFDFacturasSinContabilizar.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  if gProgramVersion = pvBAG then
  begin
    EEmpresa.Text := 'BAG';
  end
  else
  begin
    EEmpresa.Text := 'SAT';
  end;
  STEmpresa.Caption := desEmpresa(Eempresa.Text);
  MEDesde.Text := DateTostr(Date-32);
  MEHasta.Text := DateTostr(Date-2);
  CalendarioFlotante.Date := Date;

  EEmpresa.Tag := kEmpresa;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  listar := True;
end;

procedure TFDFacturasSinContabilizar.FormActivate(Sender: TObject);
begin
  Top := 1;
  ActiveControl := EEmpresa;
end;

procedure TFDFacturasSinContabilizar.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDFacturasSinContabilizar.FormClose(Sender: TObject;
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


//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFDFacturasSinContabilizar.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFDFacturasSinContabilizar.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(Eempresa.text);
  end;
end;

function TFDFacturasSinContabilizar.CamposVacios: boolean;
begin
        //Comprobamos que los campos esten todos con datos
  if EEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EEmpresa.SetFocus;
    Result := True;
    Exit;
  end;
  sEmpresa:=  EEmpresa.Text;

  if not TryStrToDate( MEDesde.Text, dIni ) then
  begin
    ShowError('Fecha de incio incorrecta.');
    MEDesde.SetFocus;
    Result := True;
    Exit;
  end;
  if not TryStrToDate( MEHasta.Text, dFin ) then
  begin
    ShowError('Fecha de fin incorrecta.');
    MEDesde.SetFocus;
    Result := True;
    Exit;
  end;
  if dIni > dFin then
  begin
    ShowError('Rango de fechas incorrecto.');
    MEDesde.SetFocus;
    Result := True;
    Exit;
  end;

  Result := False;
end;

end.
