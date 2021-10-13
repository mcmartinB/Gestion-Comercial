unit DEnvioAlbSal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, DbTables, ActnList,
  ComCtrls, CGestionPrincipal, BEdit, Grids, DBGrids, QuickRpt,
  BGrid, BSpeedButton, BGridButton, BCalendarButton, BCalendario, DError;

type
  TFDEnvioAlbSal = class(TForm)
    Panel2: TPanel;
    SBAceptar: TSpeedButton;
    SBCancelar: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    BGBEmpresa: TBGridButton;
    LEmpresa: TLabel;
    LCliente: TLabel;
    BGBCliente: TBGridButton;
    STCliente: TStaticText;
    STEmpresa: TStaticText;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ADesplegarRejilla: TAction;
    EEmpresa: TBEdit;
    ECliente: TBEdit;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    BCBHasta: TBCalendarButton;
    MEHasta: TBEdit;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    GBDatos: TGroupBox;
    LAviso: TLabel;
    Query1: TQuery;
    lbl1: TLabel;
    rbPendientes: TRadioButton;
    rbTodos: TRadioButton;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure MEHastaExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
  private
      {private declarations}
    slReporte: TStringList;
    function CamposVacios: boolean;
    procedure Report;
    procedure BorrarFicheros;
    procedure DatosReporte;
    procedure ReporteEnvio;
    procedure GuardarAlbaranesEnviados;
    //procedure BuscarProforma;

  public
    { Public declarations }
    //adjunto: string;
    adjunto: TStringList;
    direcciones, copias: string;
  end;

var
  FDEnvioAlbSal: TFDEnvioAlbSal;

implementation

uses DPreview, CVariables, Principal, CAuxiliarDB, Printers,
  UDMAuxDB, DConfigMail, LAlbaranesSalida, LReporteEnvio, FileCtrl, StrUtils,
  UDMBaseDatos, bSQLUtils;

{$R *.DFM}

procedure TFDEnvioAlbSal.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  MEDesde.Text := DateToStr(Date-6);
  MEHasta.Text := DateTostr(Date);
  CalendarioFlotante.Date := Date;

  EEmpresa.Tag := kEmpresa;
  ECliente.Tag := kCliente;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;

  EEmpresa.Text := gsDefEmpresa;
  ECliente.Text := '';

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  adjunto := TSTringList.Create;
  slReporte:= TSTringList.Create;
end;

procedure TFDEnvioAlbSal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  FreeAndNil( Adjunto );
  FreeAndNil( slReporte );

  Action := caFree;
end;

procedure TFDEnvioAlbSal.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDEnvioAlbSal.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFDEnvioAlbSal.BBAceptarClick(Sender: TObject);
begin
  if CamposVacios then
    Exit;
      //Buscamos las facturas proforma que han sido enviadas desde el almacen o
      //creadas en las oficinas, y que han sido convertidas a PDF.

  adjunto.Clear;
  //BuscarProforma;
      //llamada para la creacion de albaranes
  Report;
  BorrarFicheros;

  //el reporte si ya han sido enviados una vez si se vuelve no se imprimen
end;

procedure TFDEnvioAlbSal.MEHastaExit(Sender: TObject);
begin
  if StrToDate(MEHasta.Text) < StrToDate(MEDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    MEDesde.SetFocus;
  end;
end;

procedure TFDEnvioAlbSal.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCliente: DespliegaRejilla(BGBCliente, [EEmpresa.Text]);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFDEnvioAlbSal.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(Eempresa.Text);
    kCliente: STCliente.Caption := desCliente(Ecliente.Text);
  end;
end;

function TFDEnvioAlbSal.CamposVacios: boolean;
begin
        //Comprobar si los campos se han rellenado correctamente
  if EEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición.');
    EEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if ECliente.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición.');
    ECliente.SetFocus;
    Result := True;
    Exit;
  end;
  Result := False;
end;

function AlbaranEMail(const AEmpresa, ACliente: string; var ADireccion: string): boolean;
begin
  with DMBaseDatos.QGeneral do
  begin
    Close;
    SQl.Clear;
    SQl.Add('SELECT email_alb_c FROM frf_clientes ' +
      'WHERE cliente_c ' + SQLEqualS(ACliente) +
      ' AND email_alb_c IS NOT NULL ');
    Open;

    Result := not IsEmpty;
    if Result then
    begin
      ADireccion := FieldByName('email_alb_c').AsString;
    end
    else
    begin
      ADireccion := '';
    end;
    Close;
  end;
end;

//Creacion del report de albaranes de salida

procedure TFDEnvioAlbSal.Report;
begin
   //botones
  BAceptar.Enabled := False;
  BCancelar.Enabled := False;
   //Etiqueta de aviso
  LAviso.Visible := True;
  Repaint;
   //foco
  Self.ActiveControl := nil;
   //cursos
  Screen.Cursor := crHourGlass;
  if ExecuteAlbaranesToPdf(EEmpresa.Text, ECliente.Text, MEDesde.Text, MEHasta.Text, rbPendientes.Checked ) then
  begin
       //ActivarBotones
    BAceptar.Enabled := True;
    BCancelar.Enabled := True;
       //Poner cursor por defecto
    Screen.Cursor := crDefault;
       //Ocultar etiqueta de aviso
    LAviso.Visible := False;
       //llamada a la ventana desde donde se envia el correo
    DatosReporte;
    if AlbaranEMail(EEmpresa.Text, ECliente.Text, direcciones) then
      if AlbaranesSendMail( ECliente.Text , slReporte, adjunto, direcciones, copias) then
        ReporteEnvio; //Mostrar informe de envio

  end
  else
  begin
       //ActivarBotones
    BAceptar.Enabled := True;
    BCancelar.Enabled := True;
       //Poner cursor por defecto
    Screen.Cursor := crDefault;
       //Ocultar etiqueta de aviso
    LAviso.Visible := False;
  end;
end;

procedure TFDEnvioAlbSal.BorrarFicheros;
var i: integer;
begin
  if adjunto.Count > 0 then
  begin
    for i := 0 to Adjunto.Count - 1 do
    begin
      DeleteFile(Adjunto[i]);
    end;
  end;
end;

procedure TFDEnvioAlbSal.DatosReporte;
begin
  Repaint;
  with Query1 do
  begin
    Close;
    Sql.Clear;
    Sql.Add('SELECT empresa_sc, cliente_fac_sc, fecha_sc, n_albaran_sc ');
    Sql.Add('FROM frf_salidas_c ');
    Sql.Add('WHERE empresa_sc = :empresa ');
    Sql.Add('AND       cliente_sal_sc = :cliente ');
    Sql.Add('AND       fecha_sc BETWEEN :desde AND :hasta ');

    if rbPendientes.Checked then
    begin
      SQL.Add(' AND n_albaran_sc NOT IN (SELECT n_albaran_ae FROM frf_alb_enviados ' +
          '                          WHERE empresa_ae = empresa_sc ' +
          '                          AND cliente_sal_ae = cliente_sal_sc ' +
          '                          AND n_albaran_ae = n_albaran_sc ' +
          '                          AND fecha_ae = fecha_sc )');
    end;

    Sql.Add('ORDER BY empresa_sc, cliente_fac_sc, fecha_sc, n_albaran_sc ');

    ParamByName('empresa').AsString := EEmpresa.Text;
    ParamByName('cliente').AsString := ECliente.Text;
    ParamByName('desde').AsDate := StrToDate(MEDesde.Text);
    ParamByName('hasta').AsDate := StrToDate(MEHasta.Text);
    try
      Open;
    except
      ShowError('Fallo en la ejecución de la consulta de albaranes');
    end;

    slReporte.Clear;
    while not Query1.Eof do
    begin
      slReporte.add( Query1.FieldByName('empresa_sc').AsString + ' ' +
                                          Query1.FieldByName('cliente_fac_sc').AsString + ' ' +
                                          Query1.FieldByName('fecha_sc').AsString + ' ' +
                                          Query1.FieldByName('n_albaran_sc').AsString );
      Query1.Next;
    end;
    Query1.Close;
  end;
end;

procedure TFDEnvioAlbSal.ReporteEnvio;
begin
  //Crear reporte de envio
  try
    QRReporteEnvio := TQRReporteEnvio.Create(Application);
    QRReporteEnvio.LCliente.Caption := STCliente.Caption;
    QRReporteEnvio.LDireccion.Caption := Direcciones;
    QRReporteEnvio.MEnviados.Lines.AddStrings( slReporte );
    QRReporteEnvio.ShowProgress := False;
    QRReporteEnvio.Preview;
  finally
    QRReporteEnvio.Free;
    Application.ProcessMessages;
  end;
  GuardarAlbaranesEnviados;
end;

procedure TFDEnvioAlbSal.GuardarAlbaranesEnviados;
var dia, hora: string;
begin
  Repaint;
  dia := DateToStr(Date);
  hora := TimeToStr(Time);
     //guardo en la tabla de albaranes enviados los albranes que hemos enviados
  with DMBaseDatos.QListado do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' INSERT INTO frf_alb_enviados ' +
      ' SELECT empresa_sc, cliente_sal_sc, n_albaran_sc, fecha_sc,' +
      QuotedStr(hora) + ',' + QuotedStr(dia) + ',' + QuotedStr(gsCodigo) +
      ',' + QuotedStr(gsMaquina) + ',' + QuotedStr(direcciones) + ',' + QuotedStr(copias) +
      ' FROM frf_salidas_c ' +
      ' WHERE empresa_sc = ' + quotedstr(EEmpresa.Text) +
      ' AND cliente_fac_sc = ' + quotedstr(ECliente.Text) +
      ' AND fecha_sc BETWEEN ' + quotedstr(MEDesde.Text) + ' AND ' + quotedstr(MEHasta.Text) );
                 //añadido por Mario el 28/12/2001 para que no muestr los que estan en la tabla de enviados
      if rbPendientes.Checked then
      begin
        SQL.Add(' AND n_albaran_sc NOT IN (SELECT n_albaran_ae FROM frf_alb_enviados ' +
          '                          WHERE empresa_ae = empresa_sc ' +
          '                          AND cliente_sal_ae = cliente_sal_sc ' +
          '                          AND n_albaran_ae = n_albaran_sc ' +
          '                          AND fecha_ae = fecha_sc )');
      end;
    try
      ExecSQL;
    except
      on E: EDBEngineError do
        ShowError(e);
    end;
  end;
end;

//*****************************************************************************
//busca documentos que coincidan con el codigo de cliente y la fecha.
(*
procedure TFDEnvioAlbSal.BuscarProforma;
var ficheros: TFileListBox;
  i: integer;
  aux: string;
begin
  Aux := StringReplace(MEDesde.Text, '/', '-', [rfReplaceAll, rfIgnoreCase]);
  ficheros := TFileListBox.Create(Self);
  ficheros.Parent := Self;
  ficheros.Visible := False;
  ficheros.Height := 0;
  ficheros.SendToBack;

  ficheros.Drive := 'C';
  ficheros.Directory := gsDirActual + '\..\Documentos';
     //proformas
  ficheros.Mask := '*.pdf';
  for i := 0 to (ficheros.Items.Count - 1) do
  begin
    ficheros.ItemIndex := i;
         //comprobamos si esta el codigo de cliente
    if Copy(ficheros.items[i], 0, pos(' ', ficheros.items[i]) - 1) = ECliente.Text then
           //si esta la fecha lo cogemos
      if pos(Aux, ficheros.items[i]) > 0 then
      begin
        adjunto.add(Ficheros.FileName);
      end;
  end;
end;
*)

end.
