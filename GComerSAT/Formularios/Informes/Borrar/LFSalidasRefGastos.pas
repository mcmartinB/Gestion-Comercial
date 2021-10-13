unit LFSalidasRefGastos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, DbTables, ActnList,
  ComCtrls, CGestionPrincipal, BEdit, Grids, DBGrids,
  BGrid, BSpeedButton, BGridButton, BCalendarButton, BCalendario, DError,
  QuickRpt, BDEdit;

type
  TFLSalidasRefGastos = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    ERef: TBEdit;
    ComboBox: TComboBox;
    DBGrid: TDBGrid;
    DesplegarLista: TAction;
    Table: TTable;
    DataSource: TDataSource;
    SpeedButton3: TSpeedButton;
    AImprimir: TAction;
    ComboBoxOrden: TComboBox;
    Label1: TLabel;
    Tablereferencia_rg: TStringField;
    Tablealbaran_rg: TIntegerField;
    Tablefecha_rg: TDateField;
    Tablematricula_rg: TStringField;
    Tabletipo_rg: TStringField;
    Tabledes_tipo_rg: TStringField;
    TableTipoGastos: TTable;
    LRegistros: TLabel;
    Tableimporte_rg: TFloatField;
    Bevel1: TBevel;
    Periodo: TCheckBox;
    Panel1: TPanel;
    BCBHasta: TBCalendarButton;
    BCBDesde: TBCalendarButton;
    StaticText3: TStaticText;
    Desde: TBDEdit;
    StaticText4: TStaticText;
    Hasta: TBDEdit;
    BCalendario1: TBCalendario;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DesplegarListaExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBoxChange(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridCellClick(Column: TColumn);
    procedure AImprimirExecute(Sender: TObject);
    procedure ComboBoxOrdenChange(Sender: TObject);
    procedure PeriodoClick(Sender: TObject);
    procedure PeriodoKeyPress(Sender: TObject; var Key: Char);
    procedure MuestraCalendario(Sender: TObject);
    procedure EventoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
      {private declarations}
    tablaTemporal: string;

    function CamposVacios: boolean;
    function CrearTablaTemporal: Boolean;
    procedure BorrarTablaTemporal;
    procedure LimpiarTablaTemporal;
    function RellenarTablaTemporal: Boolean;

    function RefGastos: Integer;
    function RefTransitos: Integer;
    function AlbGastos: Integer;
    function AlbTransitos: Integer;

  public
    { Public declarations }
  end;

//var
  //FLSalidasRefGastos: TFLSalidasRefGastos;

implementation

uses CVariables, Principal, CReportes, UDMAuxDB, LSelecRefGastos, DPreview, CauxiliarDB;

{$R *.DFM}

procedure TFLSalidasRefGastos.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  gRF := nil;
  gCF := nil;

  ComboBox.ItemIndex := 0;
  ComboBoxOrden.ItemIndex := 1;
  tablaTemporal := gsCodigo + '_ref_gastos';

  if not CrearTablaTemporal then Close
  else
  begin
    Table.TableName := tablaTemporal;
    Self.WindowState := wsMaximized;
    DBGrid.Top := 88;
  end;

end;

procedure TFLSalidasRefGastos.FormActivate(Sender: TObject);
begin
  if Table.Active then
  begin
    Self.WindowState := wsMaximized;
    DBGrid.Top := 88;
    Exit;
  end;

end;

procedure TFLSalidasRefGastos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

    //Borramos tabla temporal
  BorrarTablaTemporal;

  Action := caFree;
end;

procedure TFLSalidasRefGastos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ComboBox.DroppedDown then Exit;
  case key of
    $0D: //vk_return
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;
    $26: //vk_up
      begin
        if Table.Active then
          Table.Prior;
        Key := 0;
      end;
    $28: //vk_down
      begin
        if Table.Active then
          Table.Next;
        Key := 0;
      end;
  end;
end;

procedure TFLSalidasRefGastos.BBCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLSalidasRefGastos.BBAceptarClick(Sender: TObject);
begin
  if CamposVacios then Exit;
  LimpiarTablaTemporal;
  RellenarTablaTemporal;
end;

function TFLSalidasRefGastos.CamposVacios: boolean;
begin
  //Comprobar si los campos se han rellenado correctamente
  if Trim(ERef.Text) = '' then
  begin
    ShowMessage('Falta Albarán o Referencia.');
    ERef.SetFocus;
    Result := True;
    Exit;
  end;
  if ComboBox.ItemIndex = 1 then
  try
    StrToInt(ERef.Text);
  except
    ShowMessage('El número de albarán sólo puede contener dígitos numéricos.');
    ERef.SetFocus;
    Result := True;
    Exit;
  end;

  if (ComboBox.ItemIndex <> 0) and (ComboBox.ItemIndex <> 1) then
  begin
    ShowMessage('Valor seleccionado incorrecto.');
    ComboBox.SetFocus;
    Result := True;
    Exit;
  end;

  //Tenemos que introducir rango de fechas
  if Periodo.Checked then
  begin
    //Son fechas correctas
    try
      StrToDate(Desde.Text);
    except
      ShowMessage('Fecha incorrecta.');
      Desde.SetFocus;
      Result := True;
      Exit;
    end;
    try
      StrToDate(Hasta.Text);
    except
      ShowMessage('Fecha incorrecta.');
      Hasta.SetFocus;
      Result := True;
      Exit;
    end;
    //Rango correcto
    if StrToDate(Desde.Text) > StrToDate(Hasta.Text) then
    begin
      ShowMessage('Rango de fechas incorrecto.');
      if not Hasta.Focused and not Desde.Focused then
        Desde.SetFocus;
      Result := True;
      Exit;
    end;
  end;

  //Todo OK
  Result := False;
end;

function TFLSalidasRefGastos.CrearTablaTemporal: boolean;
var
  auxSql: string;
begin
  auxSql := ' CREATE TEMP TABLE ' + tablaTemporal +
    ' (referencia_rg CHAR(10), ' +
    ' albaran_rg INTEGER, ' +
    ' fecha_rg DATE, ' +
    ' matricula_rg CHAR(15), ' +
    ' tipo_rg CHAR(3), ' +
    ' importe_rg DECIMAL(10,2)) ';
  if ConsultaExec(auxSql, False, false) = -1 then
  begin
    Beep;
    ShowMessage('ERROR: No se puede crear tabla temporal');
    CrearTablaTemporal := False;
    Exit;
  end;
  CrearTablaTemporal := True;
end;

procedure TFLSalidasRefGastos.BorrarTablaTemporal;
begin
  ConsultaExec(' DROP TABLE ' + tablaTemporal, False, False);
  Table.Active := False;
end;

procedure TFLSalidasRefGastos.LimpiarTablaTemporal;
begin
  Table.Active := False;
  ConsultaExec(' DELETE FROM ' + TablaTemporal, False, False);
end;

function TFLSalidasRefGastos.RellenarTablaTemporal: boolean;
var
  cont: integer;
begin
  cont := 0;
  if ComboBox.ItemIndex = 0 then
  begin
    cont := RefGastos;
    if cont = -1 then cont := 0;
    //cont:=cont+RefTransitos;
  end
  else
    if ComboBox.ItemIndex = 1 then
    begin
      cont := AlbGastos;
      if cont = -1 then cont := 0;
    //cont:=cont+AlbTransitos;
    end;

  if cont > 0 then
  begin
    Table.Active := True;
    if cont = 0 then
      LRegistros.Caption := IntToStr(cont) + ' registro.'
    else
      LRegistros.Caption := IntToStr(cont) + ' registros.'
  end
  else
    LRegistros.Caption := '0 registros.';

  Result := Table.Active;
end;

procedure TFLSalidasRefGastos.DesplegarListaExecute(Sender: TObject);
begin
  if ActiveControl = ComboBox then
    ComboBox.DroppedDown := not ComboBox.DroppedDown;
end;

function TFLSalidasRefGastos.RefGastos: Integer;
var
  auxSql: string;
begin
  auxSQl := ' INSERT INTO ' + tablaTemporal +
    ' select ref_fac_g,n_albaran_sc,fecha_sc,vehiculo_sc,tipo_g,importe_g ' +
    ' from frf_gastos,frf_salidas_c ' +
    ' where ref_fac_g MATCHES :ref ' +
    '   and empresa_g=empresa_sc ' +
    '   and centro_salida_g=centro_salida_sc ' +
    '   and n_albaran_g=n_albaran_sc ' +
    '   and fecha_g=fecha_sc ';
  if Periodo.Checked then
  begin
    auxSQl := auxSQl + ' and fecha_sc between :desde and :hasta ';
  end;

  with DMAuxDB do
  begin
    ConsultaPrepara(QAux, auxSql);
    QAux.ParamByName('ref').AsString := ERef.Text;
    if Periodo.Checked then
    begin
      QAux.ParamByName('desde').AsDateTime := StrToDate(Desde.Text);
      QAux.ParamByName('hasta').AsDateTime := StrToDate(Hasta.Text);
    end;
    RefGastos := ConsultaExec(QAux, False, False);
  end;
end;

function TFLSalidasRefGastos.RefTransitos: Integer;
var
  auxSql: string;
begin
  auxSQl := ' INSERT INTO ' + tablaTemporal +
    ' select unique ref_fac_gt,n_albaran_sc,fecha_sc,vehiculo_sc,tipo_gt,importe_gt ' +
    ' from frf_gastos_trans,frf_salidas_l,frf_salidas_c ' +
    ' where ref_fac_gt MATCHES :ref ' +
    ' and empresa_gt=empresa_sl ' +
    ' and centro_gt=centro_origen_sl ' +
    ' and referencia_gt=ref_transitos_sl ' +
    ' and empresa_sl=empresa_sc ' +
    ' and centro_salida_sl=centro_salida_sc ' +
    ' and fecha_sl=fecha_sc ' +
    ' and n_albaran_sl=n_albaran_sc ';
  with DMAuxDB do
  begin
    ConsultaPrepara(QAux, auxSql);
    QAux.ParamByName('ref').AsString := ERef.Text;
    RefTransitos := ConsultaExec(QAux, False, False);
  end;
end;

function TFLSalidasRefGastos.AlbGastos: Integer;
var
  auxSql: string;
begin
  auxSQl := ' INSERT INTO ' + tablaTemporal +
    ' select ref_fac_g,n_albaran_sc,fecha_sc,vehiculo_sc,tipo_g, importe_g ' +
    ' from frf_salidas_c,frf_gastos ' +
    ' where n_albaran_sc = :alb ' +
    ' and empresa_sc=empresa_g ' +
    ' and centro_salida_sc=centro_salida_g ' +
    ' and n_albaran_sc=n_albaran_g ' +
    ' and fecha_sc=fecha_g ' +
    ' and ref_fac_g is not null ' +
    ' and ref_fac_g<>"" ';

  if Periodo.Checked then
  begin
    auxSQl := auxSQl + ' and fecha_sc between :desde and :hasta ';
  end;

  with DMAuxDB do
  begin
    ConsultaPrepara(QAux, auxSql);
    if Periodo.Checked then
    begin
      QAux.ParamByName('desde').AsDateTime := StrToDate(Desde.Text);
      QAux.ParamByName('hasta').AsDateTime := StrToDate(Hasta.Text);
    end;
    QAux.ParamByName('alb').AsInteger := StrToInt(ERef.Text);
    AlbGastos := ConsultaExec(QAux, False, False);
  end;
end;

function TFLSalidasRefGastos.AlbTransitos: Integer;
var
  auxSql: string;
begin
  auxSQl := ' INSERT INTO ' + tablaTemporal +
    ' select unique ref_fac_gt,n_albaran_sc,fecha_sc,vehiculo_sc,tipo_gt,importe_gt  ' +
    ' from frf_salidas_l,frf_salidas_c,frf_gastos_trans ' +
    ' where n_albaran_sl= :alb ' +
    ' and ref_transitos_sl is not null ' +

  ' and empresa_sc=empresa_sl ' +
    ' and centro_salida_sc=centro_salida_sl ' +
    ' and fecha_sc=fecha_sl ' +
    ' and n_albaran_sc=n_albaran_sl ' +

  ' and empresa_sl=empresa_gt ' +
    ' and centro_origen_sl=centro_gt ' +
    ' and ref_transitos_sl=referencia_gt ' +
    ' and ref_fac_gt is not null ' +
    ' and ref_fac_gt <> "" ';
  with DMAuxDB do
  begin
    ConsultaPrepara(QAux, auxSql);
    try
      QAux.ParamByName('alb').AsInteger := StrToInt(ERef.Text);
    except
      ShowMessage('El número de albarán sólo puede contener dígitos numéricos.');
      AlbTransitos := -1;
      Exit;
    end;
    AlbTransitos := ConsultaExec(QAux, False, False);
  end;
end;

procedure TFLSalidasRefGastos.ComboBoxChange(Sender: TObject);
begin
  ERef.Text := '';
  if ComboBox.ItemIndex = 0 then begin
    ERef.InputType := itChar;
    Periodo.Enabled := True;
  end
  else begin
    ERef.InputType := itInteger;
    Periodo.Checked := False;
    Periodo.Enabled := False;
  end;
end;

procedure TFLSalidasRefGastos.DBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if (gdSelected in State) then
  begin
    DBGrid.Canvas.Font.Color := clWhite;
    DBGrid.Canvas.Font.Style := [fsBold];
    DBGrid.Canvas.Brush.Color := clNavy;
  end;
  DBGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFLSalidasRefGastos.DBGridCellClick(Column: TColumn);
begin
  ERef.SetFocus;
end;

procedure TFLSalidasRefGastos.AImprimirExecute(Sender: TObject);
var
  enclave: TBookMark;
begin
  if Table.Active then
  begin
    enclave := Table.GetBookmark;
    Table.First;
    QRLSelectRefGastos := TQRLSelectRefGastos.Create(Application);
    PonLogoGrupoBonnysa(QRLSelectRefGastos, '050');
    Preview(QRLSelectRefGastos);
    Table.GotoBookmark(enclave);
    Table.FreeBookmark(enclave);
  end;
end;

procedure TFLSalidasRefGastos.ComboBoxOrdenChange(Sender: TObject);
begin
  case ComboBoxOrden.ItemIndex of
    0: Table.IndexFieldNames := 'fecha_rg';
    1: Table.IndexFieldNames := 'albaran_rg;fecha_rg';
    2: Table.IndexFieldNames := 'referencia_rg;fecha_rg';
    3: Table.IndexFieldNames := 'matricula_rg;fecha_rg';
    4: Table.IndexFieldNames := 'tipo_rg;fecha_rg';
  end;
end;

procedure TFLSalidasRefGastos.PeriodoClick(Sender: TObject);
begin
  if Periodo.Checked then
  begin
    Desde.Enabled := True;
    Hasta.Enabled := true;
    BCBDesde.Enabled := True;
    BCBHasta.Enabled := true;
  end
  else
  begin
    Desde.Enabled := false;
    Desde.Text := '';
    Hasta.Enabled := False;
    Hasta.text := '';
    BCBDesde.Enabled := false;
    BCBHasta.Enabled := false;
  end;
end;

procedure TFLSalidasRefGastos.PeriodoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Periodo.Checked then
  begin
    Desde.Enabled := True;
    Hasta.Enabled := true;
    BCBDesde.Enabled := True;
    BCBHasta.Enabled := true;
  end
  else
  begin
    Desde.Enabled := false;
    Desde.Text := '';
    Hasta.Enabled := False;
    Hasta.text := '';
    BCBDesde.Enabled := false;
    BCBHasta.Enabled := false;
  end;
end;

procedure TFLSalidasRefGastos.MuestraCalendario(Sender: TObject);
begin
  DespliegaCalendario(TBCalendarButton(Sender));
end;

procedure TFLSalidasRefGastos.EventoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_f2 then MuestraCalendario(Self);
end;

end.
