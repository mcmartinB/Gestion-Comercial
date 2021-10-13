unit LFOBLiquidaPorCalibres;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, StrUtils;

type
  TFLFOBLiquidaPorCalibres = class(TForm)
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
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure edtHastaExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function CamposVacios: boolean;
    procedure FormDestroy(Sender: TObject);

  private
    //Guardo el texto de la query original que es la agrupada
    rango: boolean;

  public
    { Public declarations }
    empresa, producto, factura, mes, anyo: string;
  end;

var
  Autorizado: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, DPreview, RFOBLiquidaPorCalibres,
  CAuxiliarDB, UDMBaseDatos, TablaTmpFob, bDialogs, bMath, bTimeUtils;

{$R *.DFM}

//                         ****  BOTONES  ****

procedure TFLFOBLiquidaPorCalibres.BBAceptarClick(Sender: TObject);
var
  //inicio: cardinal;
  registros: integer;
  QRFOBLiquidaPorCalibres: TQRFOBLiquidaPorCalibres;
begin
  if not CerrarForm(true) then Exit;
  if CamposVacios then EXit;

  //TablaTmpFob.Inicializar;
  TablaTmpFob.Configurar(true, True, true, true);
  //inicio:= GetTickCount;
  registros := TablaTmpFob.Ejecutar(gsCodigo, edtEmpresa.Text, edtCentro.Text, edtProducto.Text, edtDesde.Text, edtHasta.Text);
  case registros of
    0: begin Informar('Sin datos'); exit; end;
    -1: begin Informar('Sin Inicializar'); exit; end;
    -2: begin Informar('Sin Configurar'); exit; end;
    -3: begin Informar('ERROR'); exit; end;
     //else Informar( IntToStr( registros ) + ' registros en ' + FloatToStr( bRoundTo( ( GetTickCount - inicio ) / 1000, -2 ) ) + ' segundos');
  end;
  //TablaTmpFob.Finalizar;

  QRFOBLiquidaPorCalibres := TQRFOBLiquidaPorCalibres.Create(nil);
  try
    QRFOBLiquidaPorCalibres.Query.ParamByName('usuario').AsString := gsCodigo;
    QRFOBLiquidaPorCalibres.ConfigTitulo(edtEmpresa.Text, edtCentro.Text, edtProducto.Text,
      edtDesde.Text, edtHasta.Text);
    QRFOBLiquidaPorCalibres.Query.Open;
    Preview(QRFOBLiquidaPorCalibres);
  except
    FreeAndNil(QRFOBLiquidaPorCalibres);
  end;
end;

procedure TFLFOBLiquidaPorCalibres.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                          **** FORMULARIO ****

procedure TFLFOBLiquidaPorCalibres.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Text := '050';
  edtCentro.Text := '1';
  edtProducto.Text := 'T';
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

     //La consulta esta hecha para que se agrupe por centro y pais si se elige
     //los clientes comunitarios, si no sólo se agrupa por pais
  rango := True;

  TablaTmpFob.Inicializar;
end;

procedure TFLFOBLiquidaPorCalibres.FormActivate(Sender: TObject);
begin
  ActiveControl := edtEmpresa;
end;

procedure TFLFOBLiquidaPorCalibres.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLFOBLiquidaPorCalibres.FormClose(Sender: TObject;
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

procedure TFLFOBLiquidaPorCalibres.edtHastaExit(Sender: TObject);
begin
  if CalendarioFlotante.Visible then Exit;
  if StrToDate(edtHasta.Text) < StrToDate(edtDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    edtDesde.SetFocus;
    Rango := False;
    Exit;
  end
  else
    Rango := True;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLFOBLiquidaPorCalibres.ADesplegarRejillaExecute(Sender: TObject);
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

procedure TFLFOBLiquidaPorCalibres.PonNombre(Sender: TObject);
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

function TFLFOBLiquidaPorCalibres.CamposVacios: boolean;
begin
        //Comprobamos que los campos esten todos con datos
  if edtEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    edtEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

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

procedure TFLFOBLiquidaPorCalibres.FormDestroy(Sender: TObject);
begin
  TablaTmpFob.Finalizar;
end;

end.
