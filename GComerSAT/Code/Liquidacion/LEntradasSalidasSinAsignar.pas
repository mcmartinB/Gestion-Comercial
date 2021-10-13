{NOTAS: Los gastos de transitos sólo se restan para el centro 6 producto E}
unit LEntradasSalidasSinAsignar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList, ComCtrls,
  BEdit, Grids, DBGrids, BGrid, BSpeedButton, BGridButton, BCalendarButton,
  BCalendario, DError, dbtables, QuickRpt, nbLabels;

type
  TFLEntradasSalidasSinAsignar = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    ADesplegarRejilla: TAction;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    lblCodigoEmpresa: TnbLabel;
    lblCodigoProducto: TnbLabel;
    lblCodigoCentro: TnbLabel;
    lblCodigoFechaDesde: TnbLabel;
    btnCentro: TBGridButton;
    btnProducto: TBGridButton;
    btnEmpresa: TBGridButton;
    stEmpresa: TnbStaticText;
    stProducto: TnbStaticText;
    stCentro: TnbStaticText;
    btnHasta: TBCalendarButton;
    lblCodigo2: TnbLabel;
    btnDesde: TBCalendarButton;
    lblCodigo1: TnbLabel;
    lblCodigoNumEntrada: TnbLabel;
    lbl1: TLabel;
    edtFechaDesde: TBEdit;
    edtCentro: TBEdit;
    edtProducto: TBEdit;
    edtEmpresa: TBEdit;
    edtFechaHasta: TBEdit;
    cbbTipo: TComboBox;
    rbEntradas: TRadioButton;
    rbSalidas: TRadioButton;
    cbbTipoSalida: TComboBox;
    edtNumero: TBEdit;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);

  public
    { Public declarations }
  private
    bSalida: Boolean;
    iTipo, iTipoSalida, iSalida: Integer;
    sEmpresa, sCentro, sProducto, sNumero: string;
    dFechaIni, dFechaFin: TDateTime;

    function ValidarParametros: Boolean;

  public
  end;

implementation

uses CVariables, CAuxiliarDB, CGestionPrincipal, bSQLUtils,
  UDMAuxDB, bMath,  bDialogs, SalidasSinEntradasAsignadasQL,
  UDMBaseDatos, EntradaSinSalidasAsignadasQL;


{$R *.DFM}

procedure TFLEntradasSalidasSinAsignar.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then
    Close;
end;


function TFLEntradasSalidasSinAsignar.ValidarParametros: Boolean;
begin
  result := false;
  //El codigo de empresa es obligatorio
  if Trim( stEmpresa.Caption ) = '' then
  begin
    edtEmpresa.SetFocus;
    ShowMessage('Falta código de empresa o es incorrecto.');
    Exit;
  end;
  sEmpresa:= edtEmpresa.Text;

  if Trim( stCentro.Caption ) = '' then
  begin
    edtCentro.SetFocus;
    ShowMessage('Falta código de centro o es incorrecto.');
    Exit;
  end;
  sCentro:= edtCentro.Text;

  if Trim( stProducto.Caption ) = '' then
  begin
    edtProducto.SetFocus;
    ShowMessage('Falta código de producto o es incorrecto.');
    Exit;
  end;
  sProducto:= edtProducto.Text;


  //Comprobar que las fechas sean correctas
  if not TryStrToDate(edtFechaDesde.Text, dFechaIni ) then
  begin
    edtFechaDesde.SetFocus;
    ShowMessage('Fecha de inicio incorrecta.');
    Exit;
  end;
  if not TryStrToDate(edtFechaHasta.Text, dFechaFin ) then
  begin
    edtFechaHasta.SetFocus;
    ShowMessage('Fecha de fin incorrecta.');
    Exit;
  end;
  if dFechaIni > dFechaFin then
  begin
    edtFechaDesde.SetFocus;
    ShowMessage('Rango de fechas incorrecto.');
    Exit;
  end;

  iTipo:= cbbTipo.ItemIndex;
  iTipoSalida:= cbbTipoSalida.ItemIndex;

  bSalida:= rbSalidas.Checked;
  if bSalida then
  begin
    iSalida:= cbbTipoSalida.ItemIndex;
  end
  else
  begin
    iSalida:= 0;
  end;

  sNumero:= edtNumero.Text;

  result := true;
end;


procedure TFLEntradasSalidasSinAsignar.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;

  if ValidarParametros then
  begin
    if rbSalidas.Checked then
      SalidasSinEntradasAsignadasQL.ImprimirSalidasSinAsignar( Self, sEmpresa, sCentro, sProducto, sNumero, dFechaIni, dFechaFin, iTipo, iTipoSalida )
    else
      EntradaSinSalidasAsignadasQL.ImprimirEntradasSinAsignar( Self, sEmpresa, sCentro, sProducto, sNumero, dFechaIni, dFechaFin, iTipo );
  end;

end;


procedure TFLEntradasSalidasSinAsignar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;

  FormType := tfDirector;
  BHFormulario;

  Action := caFree;
end;

procedure TFLEntradasSalidasSinAsignar.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag := kEmpresa;
  edtProducto.Tag := kProducto;
  edtCentro.Tag := kCentro;
  edtFechaHasta.Tag := kCalendar;

  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gRF := rejillaFlotante;
  CalendarioFlotante.Date := Date;
  gCF := calendarioFlotante;

  edtEmpresa.Text := '050';
  edtCentro.Text := '6';
  edtProducto.Text := 'I';
  edtFechaDesde.Text := DateToStr(Date-1);
  edtFechaHasta.Text := DateTostr(Date-7);

  Top := 1;
end;

procedure TFLEntradasSalidasSinAsignar.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLEntradasSalidasSinAsignar.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kProducto: DespliegaRejilla(btnProducto, [edtEmpresa.Text]);
    kCentro: DespliegaRejilla(btnCentro, [edtEmpresa.Text]);
    kCalendar:
      begin
        if edtFechaDesde.Focused then
          DespliegaCalendario(btnDesde)
        else
          DespliegaCalendario(btnHasta);
      end;
  end;
end;

procedure TFLEntradasSalidasSinAsignar.PonNombre(Sender: TObject);
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
        STEmpresa.Caption := desEmpresa(edtEmpresa.Text);
        STCentro.Caption := desCentro(edtEmpresa.Text, edtCentro.Text);
        STProducto.Caption := desProducto(edtEmpresa.Text, edtProducto.Text);
      end;
    kProducto: STProducto.Caption := desProducto(edtEmpresa.Text, edtProducto.Text);
    kCentro: STCentro.Caption := desCentro(edtEmpresa.Text, edtCentro.Text);
  end;
end;

end.
