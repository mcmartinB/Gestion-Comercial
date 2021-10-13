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
    lblSuministro: TLabel;
    edtSuministro: TnbDBSQLCombo;
    txtSuministro: TnbStaticText;
    lblProducto: TLabel;
    edtProducto: TnbDBSQLCombo;
    txtProducto: TnbStaticText;
    chkUnirTyE: TCheckBox;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtClienteChange(Sender: TObject);
    procedure edtSuministroChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
    function edtSuministroGetSQL: String;
    function edtProductoGetSQL: String;


  private
     { Private declarations}
    bSemana53: boolean;

    function CamposVacios: boolean;
    procedure Imprimir;
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
  edtProducto.Change;

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
  if not CerrarForm(true) then Exit;
  if CamposVacios then Exit;
  //Llamamos al QReport
  case pgRangos.TabIndex of
    0: Imprimir;
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

procedure TFLMercadonaVentasSemanal.Imprimir;
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




  QRLMercadonaVentasSemanal := TQRLMercadonaVentasSemanal.Create(self);

  QRLMercadonaVentasSemanal.PreparaQuery( edtSuministro.Text, edtProducto.Text, chkUnirTyE.Checked );
  QRLMercadonaVentasSemanal.AbrirQuery1( edtCliente.Text, edtSuministro.Text, edtProducto.Text, FechaIniAct, FechaFinAct );
  try
    QRLMercadonaVentasSemanal.Query1.Open;
  except
    FreeAndNil( QRLMercadonaVentasSemanal );
    raise;
  end;
  QRLMercadonaVentasSemanal.SemanaACtual.caption := DateToStr(FechaIniAct) + ' - ' + DateToStr(FechaFinAct);

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

    QRLMercadonaVentasSemanal.AbrirQuery2( edtCliente.Text, edtSuministro.Text, edtProducto.Text, FechaIniAnt, FechaFinAnt );
    QRLMercadonaVentasSemanal.Query2.Open;

    QRLMercadonaVentasSemanal.SemanaAnterior.caption := DateToStr(FechaIniAnt) + ' - ' + DateToStr(FechaFinAnt);

  end
  else
  begin
    //Esta query no dev valores
    QRLMercadonaVentasSemanal.AbrirQuery2( edtCliente.Text, edtSuministro.Text, edtProducto.Text, FechaFinAct, FechaIniAct );
    QRLMercadonaVentasSemanal.Query2.Open;

    QRLMercadonaVentasSemanal.SemanaAnterior.caption := 'Semana inexistente.';
  end;

  if QRLMercadonaVentasSemanal.Query1.IsEmpty then
  begin
    if QRLMercadonaVentasSemanal.Query2.IsEmpty then
    begin
      SHowMessage('Consulta sin datos.');
      FreeAndNil(QRLMercadonaVentasSemanal);
      Exit;
    end
    else
    begin
      QRLMercadonaVentasSemanal.QRLblDescripcion.DataSet := QRLMercadonaVentasSemanal.Query2;
    end;
  end;

  QRLMercadonaVentasSemanal.lblCliente.Caption := stCliente.Caption;
  if (edtSemanaIni.Text = edtSemanaFin.Text) and (edtAnyoIni.Text = edtAnyoFin.Text) then
  begin
    QRLMercadonaVentasSemanal.lblSemana.Caption := 'AÑO/SEMANA: ' + edtAnyoIni.Text + '/' + edtSemanaIni.Text;
  end
  else
  begin
    QRLMercadonaVentasSemanal.lblSemana.Caption := 'AÑO/SEMANA: ' + edtAnyoIni.Text + '/' + edtSemanaIni.Text +
      ' - ' + edtAnyoFin.Text + '/' + edtSemanaFin.Text;
  end;

  Preview(QRLMercadonaVentasSemanal);
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

  QRLMercadonaVentasSemanal.PreparaQuery( edtSuministro.Text, edtProducto.Text, chkUnirTyE.Checked );
  QRLMercadonaVentasSemanal.AbrirQuery1( edtCliente.Text, edtSuministro.Text, edtProducto.Text, AFechaIni, AFechaFin );
  try
    QRLMercadonaVentasSemanal.Query1.Open;
  except
    FreeAndNil( QRLMercadonaVentasSemanal );
    raise;
  end;
  QRLMercadonaVentasSemanal.SemanaACtual.caption := DateToStr(AFechaIni) + ' - ' + DateToStr(AFechaFin);

  QRLMercadonaVentasSemanal.AbrirQuery2( edtCliente.Text, edtSuministro.Text, edtProducto.Text, FechaAuxIni, FechaAuxFin );
  QRLMercadonaVentasSemanal.Query2.Open;

  QRLMercadonaVentasSemanal.SemanaAnterior.caption := DateToStr(FechaAuxIni) + ' - ' + DateToStr(FechaAuxFin);


  if QRLMercadonaVentasSemanal.Query1.IsEmpty then
  begin
    if QRLMercadonaVentasSemanal.Query2.IsEmpty then
    begin
      SHowMessage('Consulta sin datos.');
      FreeAndNil(QRLMercadonaVentasSemanal);
      Exit;
    end
    else
    begin
      QRLMercadonaVentasSemanal.QRLblDescripcion.DataSet := QRLMercadonaVentasSemanal.Query2;
    end;
  end;

  QRLMercadonaVentasSemanal.lblCliente.Caption := stCliente.Caption;
  QRLMercadonaVentasSemanal.lblSemana.Caption := '';
  Preview(QRLMercadonaVentasSemanal);
end;

procedure TFLMercadonaVentasSemanal.edtClienteChange(Sender: TObject);
begin
  stCliente.Caption := DEsCliente(edtCliente.Text);
  edtSuministro.Change;
end;

procedure TFLMercadonaVentasSemanal.edtSuministroChange(Sender: TObject);
begin
  if edtSuministro.Text = '' then
    txtSuministro.Caption:= 'TODOS LOS SUMINISTROS'
  else
    txtSuministro.Caption := desSuministro('050', edtCliente.Text, edtSuministro.Text);
end;

procedure TFLMercadonaVentasSemanal.edtProductoChange(Sender: TObject);
begin
  if edtProducto.Text = '' then
    txtProducto.Caption:= 'TODOS LOS PRODUCTOS'
  else
    txtProducto.Caption := desProducto('050', edtProducto.Text);
  chkUnirTyE.Enabled:= edtProducto.Text = '';
end;

function TFLMercadonaVentasSemanal.edtSuministroGetSQL: String;
begin
  if edtCliente.Text <> '' then
  begin
    Result:= ' select dir_sum_ds, nombre_ds from frf_dir_sum ' +
             ' where cliente_ds = ' + QuotedStr( edtCliente.Text );
  end
  else
  begin
    raise Exception.Create('Seleccione primero un cliente.');
  end;
end;

function TFLMercadonaVentasSemanal.edtProductoGetSQL: String;
begin
    Result:= ' select producto_p, descripcion_p ' +
             ' from frf_productos ';

end;

end.
