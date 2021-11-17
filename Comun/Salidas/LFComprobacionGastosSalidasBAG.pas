unit LFComprobacionGastosSalidasBAG;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, DBtables, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Derror, Grids,
  DBGrids, BGrid, CheckLst;

type
  TFLComprobacionGastosSalidasBAG = class(TForm)
    Panel1: TPanel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    Label3: TLabel;
    eEmpresa: TBEdit;
    STEmpresa: TStaticText;
    clbGastosTransito: TCheckListBox;
    Label1: TLabel;
    EDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label2: TLabel;
    EHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    Label4: TLabel;
    eCliente: TBEdit;
    STCliente: TStaticText;
    QLCompGastosSalidas: TQuery;
    lbl1: TLabel;
    cbbPortes: TComboBox;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure EHastaExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure eEmpresaChange(Sender: TObject);
    procedure eClienteChange(Sender: TObject);

  private
    {private declarations}
    function  ConsultaGastosSalidas: boolean;
    function  ConfiguraGastosSalidas: boolean;

    function  ParametrosCorrectos: boolean;
    procedure VerTiposDeGastos;
    function  TipoDeGastos( var ATipos: string ): integer;

  public
    { Public declarations }
  end;

implementation

uses Principal, CVariables, CAuxiliarDB, CReportes,
  DPreview, UDMAuxDB, LComprobacionGastosSalidasBAG;

{$R *.DFM}

//                          **** FORMULARIO ****

function TFLComprobacionGastosSalidasBAG.TipoDeGastos( var ATipos: string ): integer;
var
  i, cont: integer;
begin
  ATipos:=  '';
  i:= 0;
  cont:= 0;
  while i < clbGastosTransito.Items.Count  do
  begin
    if clbGastosTransito.Checked[i] then
    begin
      if ATipos <> '' then
        ATipos:=  ATipos + ',''' + copy(clbGastosTransito.Items[i],1,3) + ''''
      else
        ATipos:=  '''' + copy(clbGastosTransito.Items[i],1,3) + '''';
      inc( cont );
    end;
    inc(i);
  end;

  result:= cont;
end;




function TFLComprobacionGastosSalidasBAG.ConfiguraGastosSalidas: boolean;
var
  sAux: string;
  cont: integer;
begin
  cont:= TipoDeGastos( sAux );
  result:= sAux <> '';

  with QLCompGastosSalidas do
  begin
    SQL.Clear;
    SQL.Add(' SELECT empresa_sc empresa, n_albaran_sc codigo, fecha_sc fecha, cliente_sal_Sc cliente, transporte_sc transporte, vehiculo_sc matricula ');
    SQL.Add(' FROM  frf_salidas_c ');
    //SQL.Add('       join frf_salidas_l on empresa_sc = empresa_sl and centro_Salida_sl = centro_Salida_sc and n_albaran_sl = n_albaran_sc and fecha_sc = fecha_sl ');
    SQL.Add(' WHERE   fecha_sc BETWEEN :desde AND :hasta ');
    if eEmpresa.Text = 'BAG' then
      SQL.Add(' AND substr(empresa_sc,1,1) = ''F'' ')
    else
      SQL.Add(' AND empresa_sc = :empresa ');

    if Trim(eCliente.Text) <> '' then
      SQL.Add(' AND   cliente_sal_sc = :cliente ');

    if cbbPortes.ItemIndex = 1 then
      SQL.Add(' AND   porte_bonny_Sc = 1 ')
    else
    if cbbPortes.ItemIndex = 0 then
      SQL.Add(' AND   porte_bonny_Sc = 0 ');


    SQL.Add(' AND   ' + IntToStr( cont ) + ' <> ');
    SQL.Add('       ( SELECT count( DISTINCT tipo_g  ) FROM frf_gastos ');
    SQL.Add('       WHERE empresa_g = empresa_Sc ');
    SQL.Add('       AND   centro_salida_g = centro_salida_sc ');
    SQL.Add('       AND   n_albaran_g = n_albaran_sc ');
    SQL.Add('       AND   fecha_g = fecha_sc ');
    SQL.Add('       AND   tipo_g IN (' + sAux + ' )) ');
    SQL.Add(' ORDER BY 1,5,2 ');

    if eEmpresa.Text <> 'BAG' then
      ParamByName('empresa').AsString := eEmpresa.Text;
    ParamByName('desde').AsDate := StrToDate(EDesde.Text);
    ParamByName('hasta').AsDate := StrToDate(EHasta.Text);
    if Trim(eCliente.Text) <> '' then
      ParamByName('cliente').AsString := eCliente.Text;
  end;
end;


procedure TFLComprobacionGastosSalidasBAG.FormCreate(Sender: TObject);
begin
  gRF := nil;
  gCF := nil;
  
  FormType := tfOther;
  BHFormulario;

  EDesde.Text := DateTostr(Date-7);
  EHasta.Text := DateTostr(Date-1);
  CalendarioFlotante.Date := Date;

  eEmpresa.Text:= 'BAG';
  eCliente.Text:= '';

  EDesde.Tag := kCalendar;
  EHasta.Tag := kCalendar;

  eEmpresa.Tag:= kEmpresa;

  gCF := calendarioFlotante;

  VerTiposDeGastos;

  //Width:= 540;
  //CheckListBox.Enabled:= False;
  //CheckListBox.Visible:= False;
end;

procedure TFLComprobacionGastosSalidasBAG.FormActivate(Sender: TObject);
begin
  ActiveControl := eEmpresa;
end;

procedure TFLComprobacionGastosSalidasBAG.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLComprobacionGastosSalidasBAG.FormClose(Sender: TObject;
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

//                         ****  BOTONES  ****

procedure TFLComprobacionGastosSalidasBAG.BBAceptarClick(Sender: TObject);
var
  bMostrarReport: boolean;
  sAux: string;
begin
  if not CerrarForm(true) then
    Exit;
  if not ParametrosCorrectos then
    Exit;
  bMostrarReport:= True;

  //Llamamos al QReport
  QRLComprobacionGastosSalidasBAG := TQRLComprobacionGastosSalidasBAG.Create(Application);
  try

    QRLComprobacionGastosSalidasBAG.LPeriodo.Caption := EDesde.Text + ' a ' + EHasta.Text;
    ConsultaGastosSalidas;

    if bMostrarReport then
    begin
      PonLogoGrupoBonnysa(QRLComprobacionGastosSalidasBAG, eEmpresa.Text );
      TipoDeGastos( sAux );
      QRLComprobacionGastosSalidasBAG.lblTipoGastos.Caption:= 'Gastos Seleccionados: ' + sAux;
      QRLComprobacionGastosSalidasBAG.lblCliente.Caption:= eCliente.Text + ' ' + stCliente.Caption;
      QRLComprobacionGastosSalidasBAG.bndCabecera.Height:= 90;

      Preview(QRLComprobacionGastosSalidasBAG);
    end
    else
    begin
      FreeAndNil(QRLComprobacionGastosSalidasBAG);
    end;
  except
    FreeAndNil(QRLComprobacionGastosSalidasBAG);
    Raise;
  end;
end;

procedure TFLComprobacionGastosSalidasBAG.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                     ****  CAMPOS DE EDICION  ****

procedure TFLComprobacionGastosSalidasBAG.EHastaExit(Sender: TObject);
begin
  if StrToDate(EHasta.Text) < StrToDate(EDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    EDesde.SetFocus;
  end;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLComprobacionGastosSalidasBAG.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kCalendar:
      begin
        if EDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

//                     *** PROCEDIMIENTOS PRIVADOS ***


function TFLComprobacionGastosSalidasBAG.ConsultaGastosSalidas: boolean;
begin
  if not clbGastosTransito.Enabled then
  begin
    result:= False;
    ShowMessage('Sin gastos de salidas. Utilice el mantenimiento de "Tipo de Gastos" para dar de alta algun gasto de salida.');
    Exit;
  end;


  QLCompGastosSalidas.Close;
  if not ConfiguraGastosSalidas then
  begin
    result:= False;
    ShowMessage('Por favor seleccione algun tipo de gasto de salida.');
    Exit;
  end;

  with QLCompGastosSalidas do
  begin
    try
      Open;
    except
      on E: EDBEngineError do
      begin
        ShowError(E);
        raise;
      end;
    end;
  end;

  if QLCompGastosSalidas.IsEmpty then
  begin
    ShowMessage('Todos los gastos grabados para los datos pasados.');
    QLCompGastosSalidas.Close;
    result:= False;
  end
  else
  begin
    result:= True;
  end;
end;




function TFLComprobacionGastosSalidasBAG.ParametrosCorrectos: boolean;
var
  dIni, dFin: TDateTime;
begin
  result:= False;
  if stEmpresa.caption = '' then
  begin
    ShowMessage('El código de la empresa es de obligada inserción.');
    eEmpresa.SetFocus;
  end
  else
  if stCliente.caption = '' then
  begin
    ShowMessage('El código del cliente es incorrecto.');
    eEmpresa.SetFocus;
  end
  else
  if not TryStrToDate( EDesde.Text, dIni ) then
  begin
    ShowMessage('Fecha de incio incorrecta.');
    EDesde.SetFocus;
  end
  else
  if not TryStrToDate( EHasta.Text, dFin ) then
  begin
    ShowMessage('Fecha de fin incorrecta.');
    EHasta.SetFocus;
  end
  else
  if dIni > dFin then
  begin
    ShowMessage('Rango de fechas incorrecto.');
    EDesde.SetFocus;
  end
  else
  begin
    result:= true;
  end;
end;

procedure TFLComprobacionGastosSalidasBAG.eEmpresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(eEmpresa.Text);
  eClienteChange( eCliente );
end;

procedure TFLComprobacionGastosSalidasBAG.eClienteChange(Sender: TObject);
begin
  if eCliente.Text = '' then
    STCliente.Caption := 'TODOS LOS CLIENTES'
  else
    STCliente.Caption := desCliente(eCliente.Text);
end;

procedure TFLComprobacionGastosSalidasBAG.VerTiposDeGastos;
var
  i: integer;
begin
  clbGastosTransito.Clear;

  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_tipo_gastos ');
    SQL.Add(' where gasto_transito_tg = 0 ');
    SQL.Add(' order by tipo_tg ');
    Open;

    clbGastosTransito.Items.Clear;
    i:= 0;
    while not EOF do
    begin
      clbGastosTransito.Items.Add(FieldByName('tipo_tg').AsString + ':' + FieldByName('descripcion_tg').AsString);
      clbGastosTransito.Checked[i]:= False;
      Inc(i);
      Next;
    end;
    Close;
    clbGastosTransito.Enabled:= clbGastosTransito.Items.Count > 0;
  end;
end;

end.
