unit AsignarKilosTransitosFL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, StrUtils;

type
  TFLAsignarKilosTransitos = class(TForm)
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    pSuperior: TPanel;
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    pCentral: TPanel;
    lblNombre1: TLabel;
    btnEmpresa: TBGridButton;
    Desde: TLabel;
    btnFechaDesde: TBCalendarButton;
    lblNombre2: TLabel;
    btnFechaHasta: TBCalendarButton;
    lblNombre3: TLabel;
    lblNombre4: TLabel;
    btnCentro: TBGridButton;
    eEmpresa: TBEdit;
    lEmpresa: TStaticText;
    eFechaDesde: TBEdit;
    eFechaHasta: TBEdit;
    eReferencia: TBEdit;
    eCentro: TBEdit;
    lCentro: TStaticText;
    pInferior: TPanel;
    btnAsignar: TSpeedButton;
    btnCerrar: TSpeedButton;
    btnLocalizar: TSpeedButton;
    gridTransitosPendientes: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    function CamposVacios: boolean;
    procedure btnLocalizarClick(Sender: TObject);
    procedure btnAsignarClick(Sender: TObject);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure gridTransitosPendientesDblClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    sEmpresa, sCentro, sReferencia, sFechaIni, sFechaFin: String;
  public

  end;

var
  Autorizado: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, DPreview,
  CAuxiliarDB, QLIntrastat, UDMBaseDatos, bTimeUtils,
  AsignarKilosTransitosDL, AsignarKilosTransitosQL, CReportes,
  AsignarKilosTransitosAuxFL, DesgloseTransitosFC;

{$R *.DFM}

//                          **** FORMULARIO ****

procedure TFLAsignarKilosTransitos.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;
  CalendarioFlotante.Date := Date - 1;

  eEmpresa.Tag := kEmpresa;
  eCentro.Tag := kCentro;
  eFechaDesde.Tag := kCalendar;
  eFechaHasta.Tag := kCalendar;

  AsignarKilosTransitosDL.CrearModuloDatos( self );
end;

procedure TFLAsignarKilosTransitos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  AsignarKilosTransitosDL.DestruirModuloDatos;

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

procedure TFLAsignarKilosTransitos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    $0D, $28: //vk_return,vk_down
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    $26: //vk_up
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
    vk_f1:
      begin
        Key := 0;
        if btnAceptar.Visible then
        begin
          btnAceptar.Click;
        end
        else
        begin
          btnAsignar.Click;
        end;
      end;
    Ord('L'):
      begin
        Key := 0;
        btnLocalizar.Click;
      end;
  end;
end;

procedure TFLAsignarKilosTransitos.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        Key := 0;
        if btnCancelar.Visible then
        begin
          btnCancelar.Click;
        end
        else
        begin
          btnCerrar.Click;
        end;
      end;
  end;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLAsignarKilosTransitos.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCentro: DespliegaRejilla(btnCentro,[eEmpresa.Text]);
    kCalendar:
      begin
        if eFechaDesde.Focused then
          DespliegaCalendario(btnFechaDesde)
        else
          DespliegaCalendario(btnFechaHasta);
      end;
  end;
end;

procedure TFLAsignarKilosTransitos.PonNombre(Sender: TObject);
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
  end;
end;

function TFLAsignarKilosTransitos.CamposVacios: boolean;
var
  dIni, dFin: TDateTime;
begin
        //Comprobamos que los campos esten todos con datos
  if lEmpresa.Caption = '' then
  begin
    ShowError('Falta el código de la empresa o es incorrecto');
    EEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if ECentro.Text = '' then
  begin
    ShowError('Falta el código del centro o es incorrecto');
    ECentro.SetFocus;
    Result := True;
    Exit;
  end;


  if not TryStrToDate( eFechaDesde.Text, dIni ) then
  begin
    ShowError('Falta la fecha de incio o es incorrecta.');
    eFechaDesde.SetFocus;
    Result := True;
    Exit;
  end;

  if not TryStrToDate( eFechaHasta.Text, dFin )  then
  begin
    ShowError('Falta la fecha de incio o es incorrecta.');
    eFechaHasta.SetFocus;
    Result := True;
    Exit;
  end;

  if dFin < dIni then
  begin
    ShowError('Rango de fechas incorrecto.');
    eFechadesde.SetFocus;
    Result := True;
    Exit;
  end;

  Result := False;
end;

procedure TFLAsignarKilosTransitos.btnLocalizarClick(Sender: TObject);
begin
  btnLocalizar.Visible:= False;
  btnAsignar.Visible:= False;
  btnCerrar.Visible:= False;
  btnAceptar.Visible:= True;
  btnCancelar.Visible:= True;
  pCentral.Visible:= True;
  pInferior.Enabled:= False;

  sEmpresa:= eEmpresa.Text;
  sCentro:= eCentro.Text;
  sReferencia:= eReferencia.Text;
  sFechaIni:= eFechaDesde.Text;
  sFechaFin:= eFechaHasta.Text;

  eEmpresa.SetFocus;

  eEmpresa.Text:= '050';
  eCentro.Text:= 'P';
  eReferencia.Text:= '';
  eFechaDesde.Text:= DateToStr( Date - 30 );
  eFechaHasta.Text:= DateToStr( Date );
end;

procedure TFLAsignarKilosTransitos.btnAsignarClick(Sender: TObject);
begin
  if not DLAsignarKilosTransitos.QTransitosPendientes.IsEmpty then
  begin
    with DLAsignarKilosTransitos.QTransitosPendientes do
    begin
      if AsignarKilosTransitosAuxFL.ExecuteAsignarKilos( self,
            FieldByname('empresa_tc').AsString, FieldByname('centro_tc').AsString,
            FieldByname('fecha_tc').AsDateTime, FieldByname('referencia_tc').AsInteger  ) then
      begin
        //Marcar como asignado
        DLAsignarKilosTransitos.MarcarTransito(
            FieldByname('empresa_tc').AsString, FieldByname('centro_tc').AsString,
            FieldByname('fecha_tc').AsDateTime, FieldByname('referencia_tc').AsInteger );

        //Visualizar resultado
        DesgloseTransitosFC.ConsultaTransito( self, FieldByname('empresa_tc').AsString, FieldByname('centro_tc').AsString,
            FieldByname('referencia_tc').AsInteger, FieldByname('fecha_tc').AsDateTime );

        DLAsignarKilosTransitos.QTransitosPendientes.Close;
        DLAsignarKilosTransitos.QTransitosPendientes.Open;

      end;
    end;
  end;
end;

procedure TFLAsignarKilosTransitos.btnCerrarClick(Sender: TObject);
begin
  if CerrarForm(false) then
    Close;
end;

procedure TFLAsignarKilosTransitos.btnAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;

  if CamposVacios then
    Exit;

  //Consegir datos
  DLAsignarKilosTransitos.QueryListado( eEmpresa.Text, eCentro.Text, eReferencia.Text,
                            StrToDate( eFechaDesde.Text), StrToDate( eFechaHasta.Text) );

  btnLocalizar.Visible:= True;
  btnAsignar.Visible:= True;
  btnCerrar.Visible:= True;
  btnAceptar.Visible:= False;
  btnCancelar.Visible:= False;
  pCentral.Visible:= False;
  pInferior.Enabled:= True;
end;

procedure TFLAsignarKilosTransitos.btnCancelarClick(Sender: TObject);
begin
  btnLocalizar.Visible:= True;
  btnAsignar.Visible:= True;
  btnCerrar.Visible:= True;
  btnAceptar.Visible:= False;
  btnCancelar.Visible:= False;
  pCentral.Visible:= False;
  pInferior.Enabled:= True;

  eEmpresa.Text:= sEmpresa;
  eCentro.Text:= sCentro;
  eReferencia.Text:= sReferencia;
  eFechaDesde.Text:= sFechaFin;
  eFechaHasta.Text:= sFechaFin;
end;

procedure TFLAsignarKilosTransitos.gridTransitosPendientesDblClick(
  Sender: TObject);
begin
  btnAsignar.Click;
end;

end.
