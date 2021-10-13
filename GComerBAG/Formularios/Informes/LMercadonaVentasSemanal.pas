unit LMercadonaVentasSemanal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, DbTables, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, nbLabels, nbEdits, nbCombos;

type
  TFLMercadonaVentasSemanal = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    ADesplegarRejilla: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    lblCliente: TLabel;
    edtCliente: TnbDBSQLCombo;
    stCliente: TnbStaticText;
    pgRangos: TPageControl;
    tsSemanas: TTabSheet;
    Fechas: TTabSheet;
    Semana: TLabel;
    Label2: TLabel;
    edtSemanaIni: TBEdit;
    edtSemanaFin: TBEdit;
    Label1: TLabel;
    edtAnyoIni: TBEdit;
    edtAnyoFin: TBEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    fechaIni: TnbDBCalendarCombo;
    fechaFin: TnbDBCalendarCombo;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtClienteChange(Sender: TObject);


  private
     { Private declarations}
    bSemana53: boolean;

    function CamposVacios: boolean;
    procedure Imprimir1;
    procedure Imprimir_(const AFechaIni, AFechaFin: TDate);
  public
    { Public declarations }
  end;

var
  //FLSalidasEnvases: TFLSalidasEnvases;
  Autorizado: boolean;
implementation

uses UDMAuxDB, CVariables, DPreview, CReportes, UDMConfig,
  CAuxiliarDB, Principal, QLMercadonaVentasSemanal,
  UDMBaseDatos, bSQLUtils, DateUtils, bTimeUtils;

{$R *.DFM}

procedure TFLMercadonaVentasSemanal.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtSemanaIni.Text := IntToStr(WeekOfTheYear(Date - 6));
  edtAnyoIni.Text := IntToStr(YearOf(Date - 6));
  edtSemanaFin.Text := IntToStr(WeekOfTheYear(Date - 6));
  edtAnyoFin.Text := IntToStr(YearOf(Date - 6));

  edtCliente.Text := 'MER';


  fechaIni.AsDate := LunesAnterior(Date);
  fechaIni.AsDate := fechaIni.AsDate - 7;
  fechaFin.AsDate := fechaIni.AsDate + 6;


  gRF := nil;
  gCF := nil;

end;

procedure TFLMercadonaVentasSemanal.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLMercadonaVentasSemanal.FormClose(Sender: TObject;
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

procedure TFLMercadonaVentasSemanal.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;
  if CamposVacios then
    Exit;
  //Llamamos al QReport
  case pgRangos.TabIndex of
    0: Imprimir1;
    1: Imprimir_(fechaIni.AsDate, fechaFin.AsDate);
  end;
end;

procedure TFLMercadonaVentasSemanal.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

function TFLMercadonaVentasSemanal.CamposVacios: boolean;
var
  aux: integer;
begin
  bSemana53 := ( edtSemanaIni.Text = '53' ) and (edtSemanaFin.Text = '53');

  if edtCliente.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    edtCliente.SetFocus;
    Result := True;
    Exit;
  end;

  if edtSemanaIni.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    edtSemanaIni.SetFocus;
    Result := True;
    Exit;
  end;
  aux := StrToInt(edtSemanaIni.Text);
  if (aux < 1) or (aux > 53) then
  begin
    ShowError('El valor de la semana debe estar comprendido entre 1 a 53.');
    edtSemanaIni.SetFocus;
    Result := True;
    Exit;
  end;
  if edtSemanaFin.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    edtSemanaFin.SetFocus;
    Result := True;
    Exit;
  end;
  aux := StrToInt(edtSemanaFin.Text);
  if (aux < 1) or (aux > 53) then
  begin
    ShowError('El valor de la semana debe estar comprendido entre 1 a 53.');
    edtSemanaFin.SetFocus;
    Result := True;
    Exit;
  end;

  if edtAnyoIni.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    edtAnyoIni.SetFocus;
    Result := True;
    Exit;
  end;
  if edtAnyoFin.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    edtAnyoFin.SetFocus;
    Result := True;
    Exit;
  end;

  Result := False;

end;

procedure TFLMercadonaVentasSemanal.Imprimir1;
var
  FechaAux: TDate;
  FechaIniAct, FechaFinAct: TDate;
  FechaIniAnt, FechaFinAnt: TDate;
begin
  try
    FechaIniAct := EncodeDateWeek(StrToInt(edtAnyoIni.Text), StrToInt(edtSemanaIni.Text));
    FechaAux := EncodeDateWeek(StrToInt(edtAnyoFin.Text), StrToInt(edtSemanaFin.Text));
  except
    if bSemana53 then
      ShowMessage('El año seleccionado no tiene 53 semanas.')
    else
      ShowMessage('Año semana incorrecto.');
    Exit;
  end;
  FechaFinAct := FechaAux + 6;


  if not bSemana53 then
  begin
    if edtSemanaIni.Text = '53' then
      FechaIniAnt := EncodeDateWeek(StrToInt(edtAnyoIni.Text), 1)
    else
      FechaIniAnt := EncodeDateWeek(StrToInt(edtAnyoIni.Text) - 1, StrToInt(edtSemanaIni.Text));
    if edtSemanaFin.Text = '53' then
      FechaAux := EncodeDateWeek(StrToInt(edtAnyoFin.Text) - 1, 52)
    else
      FechaAux := EncodeDateWeek(StrToInt(edtAnyoFin.Text) - 1, StrToInt(edtSemanaFin.Text));
    FechaFinAnt := FechaAux + 6;
  end
  else
  begin
    FechaIniAnt:= FechaFinAct;
    FechaFinAnt:= FechaIniAct;
  end;

  QRLMercadonaVentasSemanal := TQRLMercadonaVentasSemanal.Create(self);

  if QRLMercadonaVentasSemanal.DatosListado( edtCliente.Text, FechaIniAct, FechaFinAct, FechaIniAnt, FechaFinAnt ) then
  begin
    QRLMercadonaVentasSemanal.SemanaACtual.caption := DateToStr(FechaIniAct) + ' - ' + DateToStr(FechaFinAct);
    if not bSemana53 then
    begin
      QRLMercadonaVentasSemanal.SemanaAnterior.caption := DateToStr(FechaIniAnt) + ' - ' + DateToStr(FechaFinAnt);
    end
    else
    begin
      QRLMercadonaVentasSemanal.SemanaAnterior.caption := 'Semana inexistente.';
    end;

    QRLMercadonaVentasSemanal.lblCliente.Caption := stCliente.Caption;
    if (edtSemanaIni.Text = edtSemanaFin.Text) and (edtAnyoIni.Text = edtAnyoFin.Text) then
    begin
      QRLMercadonaVentasSemanal.qrlSemana.Caption := 'AÑO/SEMANA: ' + edtAnyoIni.Text + '/' + edtSemanaIni.Text;
    end
    else
    begin
      QRLMercadonaVentasSemanal.qrlSemana.Caption := 'AÑO/SEMANA: ' + edtAnyoIni.Text + '/' + edtSemanaIni.Text +
        ' - ' + edtAnyoFin.Text + '/' + edtSemanaFin.Text;
    end;

    Preview(QRLMercadonaVentasSemanal);

  end
  else
  begin
    SHowMessage('Consulta sin datos.');
    FreeAndNil(QRLMercadonaVentasSemanal);
  end;
end;

procedure TFLMercadonaVentasSemanal.Imprimir_(const AFechaIni, AFechaFin: TDate);
var
  FechaAuxIni, FechaAuxFin: TDate;
  iAnyo, iMes, iDia: Word;
begin
  DecodeDate(AFechaIni, iAnyo, iMes, iDia);
  if (iMes = 2) and (iDia = 29) then
  begin
    FechaAuxIni := EncodeDate(iAnyo - 1, iMes, 28);
  end
  else
  begin
    FechaAuxIni := EncodeDate(iAnyo - 1, iMes, iDia);
  end;
  DecodeDate(AFechaFin, iAnyo, iMes, iDia);
  if (iMes = 2) and (iDia = 29) then
  begin
    FechaAuxFin := EncodeDate(iAnyo - 1, 3, 1);
  end
  else
  begin
    FechaAuxFin := EncodeDate(iAnyo - 1, iMes, iDia);
  end;

  QRLMercadonaVentasSemanal := TQRLMercadonaVentasSemanal.Create(self);
  if QRLMercadonaVentasSemanal.DatosListado( edtCliente.Text, AFechaIni, AFechaFin, FechaAuxIni, FechaAuxFin ) then
  begin
    QRLMercadonaVentasSemanal.SemanaACtual.caption := DateToStr(AFechaIni) + ' - ' + DateToStr(AFechaFin);
    QRLMercadonaVentasSemanal.SemanaAnterior.caption := DateToStr(FechaAuxIni) + ' - ' + DateToStr(FechaAuxFin);
    QRLMercadonaVentasSemanal.lblCliente.Caption := stCliente.Caption;
    QRLMercadonaVentasSemanal.qrlSemana.Caption := '';
    Preview(QRLMercadonaVentasSemanal);
  end
  else
  begin
    SHowMessage('Consulta sin datos.');
    FreeAndNil(QRLMercadonaVentasSemanal);
  end;
end;

procedure TFLMercadonaVentasSemanal.edtClienteChange(Sender: TObject);
begin
  stCliente.Caption := DEsCliente(edtCliente.Text);
end;

end.
