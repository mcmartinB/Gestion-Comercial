unit LInformeVentasSemanal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, DbTables, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, nbLabels, nbEdits, nbCombos;

type
  TFLInformeVentasSemanal = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    ADesplegarRejilla: TAction;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label2: TLabel;
    edtCategoria: TBEdit;
    stCliente: TnbStaticText;
    edtCliente: TnbDBSQLCombo;
    pcRangoTiempo: TPageControl;
    tsSemanas: TTabSheet;
    tsFechas: TTabSheet;
    Semana: TLabel;
    Label3: TLabel;
    edtSemanaIni: TBEdit;
    edtSemanaFin: TBEdit;
    Label1: TLabel;
    edtAnyoIni: TBEdit;
    edtAnyoFin: TBEdit;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    fechaIni: TnbDBCalendarCombo;
    fechaFin: TnbDBCalendarCombo;
    Label8: TLabel;
    edtEmpresa: TnbDBSQLCombo;
    stEmpresa: TnbStaticText;
    Label9: TLabel;
    Label10: TLabel;
    lbl1: TLabel;
    rbEnvase: TRadioButton;
    rbAgrupacion: TRadioButton;
    lblroducto: TLabel;
    edtCentroVenta: TnbDBSQLCombo;
    lblCentroVenta: TnbStaticText;
    lblCentroOrigen: TLabel;
    edtCentroOrigen: TnbDBSQLCombo;
    desCentroOrigen: TnbStaticText;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtClienteChange(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure edtCentroVentaChange(Sender: TObject);
    procedure edtCentroOrigenChange(Sender: TObject);


  private
     { Private declarations}
    bSemana53: boolean;
    FechaIniAct, FechaFinAct: TDate;
    FechaIniAnt, FechaFinAnt: TDate;

    function CamposVacios: boolean;
    function RangoFechas: boolean;
    procedure Imprimir;
  public
    { Public declarations }
  end;

var
  //FLSalidasEnvases: TFLSalidasEnvases;
  Autorizado: boolean;

implementation

uses UDMAuxDB, CVariables, DPreview, CReportes,
  CAuxiliarDB, Principal, QLInformeVentasSemanal,
  UDMBaseDatos, bSQLUtils, DateUtils, bTimeUtils;

{$R *.DFM}

procedure TFLInformeVentasSemanal.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtSemanaIni.Text := IntToStr(WeekOfTheYear(Date - 6));
  edtAnyoIni.Text := IntToStr(YearOf(Date - 6));
  edtSemanaFin.Text := IntToStr(WeekOfTheYear(Date - 6));
  edtAnyoFin.Text := IntToStr(YearOf(Date - 6));

  fechaIni.AsDate := LunesAnterior(Date);
  fechaIni.AsDate := fechaIni.AsDate - 7;
  fechaFin.AsDate := fechaIni.AsDate + 6;

  edtEmpresa.text:= gsDefEmpresa;
  edtCliente.Text := gsDefCliente;
  edtCliente.Tag := kCliente;
  stEmpresa.Caption:= desEmpresa( edtEmpresa.text );

  gRF := nil;
  gCF := nil;
end;

procedure TFLInformeVentasSemanal.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLInformeVentasSemanal.FormClose(Sender: TObject;
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

procedure TFLInformeVentasSemanal.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;
  if CamposVacios then Exit;
     //Llamamos al QReport
  Imprimir;
end;

procedure TFLInformeVentasSemanal.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

function TFLInformeVentasSemanal.CamposVacios: boolean;
var
  aux: integer;
begin
  bSemana53 := (edtSemanaIni.Text = '53') and (edtSemanaFin.Text = '53');
  
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

function TFLInformeVentasSemanal.RangoFechas: boolean;
var
  FechaAux: TDateTime;
begin
  RangoFechas:= False;
  if pcRangoTiempo.ActivePageIndex = tsSemanas.TabIndex then
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
    end;
  end
  else
  begin
    FechaIniAct := fechaIni.AsDate;
    FechaFinAct := fechaFin.AsDate;
    FechaIniAnt := IncYear( fechaIni.AsDate, -1);
    FechaFinAnt := IncYear( fechaFin.AsDate, -1 );
  end;

  RangoFechas:= True;
end;

procedure TFLInformeVentasSemanal.Imprimir;
var
  bCategoria, bVenta, bOrigen, bAgrupacion: Boolean;
begin
  if not RangoFechas then
    Exit;

  QRLInformeVentasSemanal := TQRLInformeVentasSemanal.Create(self);

  bVenta:= Trim( edtCentroVenta.Text ) <> '';
  bOrigen:= Trim( edtCentroOrigen.Text ) <> '';
  bCategoria:= Trim( edtCategoria.Text ) <> '';
  bAgrupacion:= rbAgrupacion.Checked;
  QRLInformeVentasSemanal.CargaSQL( bVenta, bOrigen, bCategoria, bAgrupacion  );
  QRLInformeVentasSemanal.Query1.ParamByName('empresa').AsString := edtEmpresa.Text;
  QRLInformeVentasSemanal.Query1.ParamByName('cliente').AsString := edtCliente.Text;
  if bVenta then
    QRLInformeVentasSemanal.Query1.ParamByName('venta').AsString := edtCentroVenta.Text;
  if bOrigen then
    QRLInformeVentasSemanal.Query1.ParamByName('origen').AsString := edtCentroOrigen.Text;
  if bCategoria then
    QRLInformeVentasSemanal.Query1.ParamByName('categoria').AsString := edtCategoria.Text;
  QRLInformeVentasSemanal.Query1.ParamByName('fechaini').AsDate := FechaIniAct;
  QRLInformeVentasSemanal.Query1.ParamByName('fechafin').AsDate := FechaFinAct;
  QRLInformeVentasSemanal.Query1.Open;
  QRLInformeVentasSemanal.SemanaACtual.caption := DateToStr(FechaIniAct) + ' - ' + DateToStr(FechaFinAct);

  QRLInformeVentasSemanal.Query2.ParamByName('empresa').AsString := edtEmpresa.Text;
  QRLInformeVentasSemanal.Query2.ParamByName('cliente').AsString := edtCliente.Text;
  if bVenta then
    QRLInformeVentasSemanal.Query2.ParamByName('venta').AsString := edtCentroVenta.Text;
  if bOrigen then
    QRLInformeVentasSemanal.Query2.ParamByName('origen').AsString := edtCentroOrigen.Text;
  if bCategoria then
    QRLInformeVentasSemanal.Query2.ParamByName('categoria').AsString := edtCategoria.Text;
  if not bSemana53 then
  begin
    QRLInformeVentasSemanal.Query2.ParamByName('fechaini').AsDate := FechaIniAnt;
    QRLInformeVentasSemanal.Query2.ParamByName('fechafin').AsDate := FechaFinAnt;
    QRLInformeVentasSemanal.Query2.Open;
    QRLInformeVentasSemanal.SemanaAnterior.caption := DateToStr(FechaIniAnt) + ' - ' + DateToStr(FechaFinAnt);
  end
  else
  begin
    //Esta query no dev valores
    QRLInformeVentasSemanal.Query2.ParamByName('fechaini').AsDate := FechaFinAct;
    QRLInformeVentasSemanal.Query2.ParamByName('fechafin').AsDate := FechaIniAct;
    QRLInformeVentasSemanal.Query2.Open;
    QRLInformeVentasSemanal.SemanaAnterior.caption := 'Semana inexistente.';
  end;

  if QRLInformeVentasSemanal.Query1.IsEmpty then
  begin
    if QRLInformeVentasSemanal.Query2.IsEmpty then
    begin
      SHowMessage('Consulta sin datos.');
      FreeAndNil(QRLInformeVentasSemanal);
      Exit;
    end
    else
    begin
      QRLInformeVentasSemanal.empresa.DataSet := QRLInformeVentasSemanal.Query2;
      QRLInformeVentasSemanal.producto.DataSet := QRLInformeVentasSemanal.Query2;
      QRLInformeVentasSemanal.envase.DataSet := QRLInformeVentasSemanal.Query2;
    end;
  end;

  if pcRangoTiempo.ActivePageIndex = tsSemanas.PageIndex then
  begin
    if (edtSemanaIni.Text = edtSemanaFin.Text) and (edtAnyoIni.Text = edtAnyoFin.Text) then
    begin
      QRLInformeVentasSemanal.lblSemana.Caption := 'AÑO/SEMANA: ' + edtAnyoIni.Text + '/' + edtSemanaIni.Text;
    end
    else
    begin
      QRLInformeVentasSemanal.lblSemana.Caption := 'AÑO/SEMANA: ' + edtAnyoIni.Text + '/' + edtSemanaIni.Text +
        ' - ' + edtAnyoFin.Text + '/' + edtSemanaFin.Text;
    end;
  end
  else
  begin
    QRLInformeVentasSemanal.lblSemana.Caption := '';
  end;
  if bCategoria then
    QRLInformeVentasSemanal.lblCategoria.Caption := 'CATEGORIA: ' + edtCategoria.Text
  else
    QRLInformeVentasSemanal.lblCategoria.Caption := 'CATEGORIA: TODAS';
  QRLInformeVentasSemanal.lblCliente.Caption:= DesCliente(edtEmpresa.Text, edtCliente.Text);

  if bVenta or bOrigen then
  begin
    if bVenta then
    begin
      QRLInformeVentasSemanal.qrlblCentro.Caption := 'CENTRO VENTA: ' + edtCentroVenta.Text
    end
    else
    if bOrigen then
    begin
      QRLInformeVentasSemanal.qrlblCentro.Caption := 'CENTRO ORIGEN: ' + edtCentroOrigen.Text
    end
    else
    begin
      QRLInformeVentasSemanal.qrlblCentro.Caption := 'CENTRO VENTA: ' + edtCentroVenta.Text + ' / CENTRO ORIGEN: ' + edtCentroOrigen.Text
    end;
  end
  else
  begin
    QRLInformeVentasSemanal.qrlblCentro.Caption := '';
  end;

  PonLogoGrupoBonnysa( QRLInformeVentasSemanal, edtEmpresa.Text );

  Preview(QRLInformeVentasSemanal);
end;

procedure TFLInformeVentasSemanal.edtClienteChange(Sender: TObject);
begin
  stCliente.Caption := DEsCliente(edtEmpresa.Text, edtCliente.Text);
end;

procedure TFLInformeVentasSemanal.edtCentroVentaChange(Sender: TObject);
begin
  if edtCentroVenta.Text = '' then
    lblCentroVenta.Caption:= 'TODOS LOS CENTROS'
  else
    lblCentroVenta.Caption:= desCentro( edtEmpresa.Text, edtCentroVenta.Text );
end;

procedure TFLInformeVentasSemanal.edtCentroOrigenChange(Sender: TObject);
begin
  if edtCentroOrigen.Text = '' then
    desCentroOrigen.Caption:= 'TODOS LOS CENTROS'
  else
    desCentroOrigen.Caption:= desCentro( edtEmpresa.Text, edtCentroOrigen.Text );
end;

procedure TFLInformeVentasSemanal.edtEmpresaChange(Sender: TObject);
begin
  stEmpresa.Caption := DEsEmpresa(edtEmpresa.Text);
end;

end.
