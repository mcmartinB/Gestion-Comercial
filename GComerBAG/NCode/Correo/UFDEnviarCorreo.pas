unit UFDEnviarCorreo;
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, quickrpt, Printers,
  ImgList, ActnList, Grids, Db, DBTables, IdComponent,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP, IdBaseComponent,
  IdMessage, IdExplicitTLSClientServerBase, IdSMTPBase, IdUserPassProvider,
  IdSASL, IdSASLUserPass, IdSASLLogin, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL;

type
  TFDEnviarCorreo = class(TForm)
    Panel1: TPanel;
    MMensaje: TMemo;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    EDireccion: TEdit;
    EAsunto: TEdit;
    SBEnviar: TSpeedButton;
    SBSalir: TSpeedButton;
    SBEstado: TStatusBar;
    Panel3: TPanel;
    ListView1: TListView;
    ILImages: TImageList;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    ActionList1: TActionList;
    AEnvio: TAction;
    ASalir: TAction;
    AHistorico: TAction;
    SGEnviados: TStringGrid;
    IdMessage: TIdMessage;
    IdSMTP: TIdSMTP;
    QGuardarEnviados: TQuery;
    lblCopia: TLabel;
    edtCopia: TEdit;
    btn1: TButton;
    dlgOpen: TOpenDialog;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdSASLLogin1: TIdSASLLogin;
    IdUserPassProvider1: TIdUserPassProvider;
    procedure SBEnviarClick(Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure AHistoricoExecute(Sender: TObject);
    procedure GuardarAlbaranEnviado;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
    procedure BorrarFicheros(borrar: boolean);
    procedure ConvertirMensaje(msg: string);
    function  CrearPDF(rep: TQuickRep): boolean;
    procedure RellenarDirecciones(direcciones: string);
    procedure RellenarCopias(direcciones: string);
  public
    { Public declarations }
    adjuntos: TStringList;
    enviado: boolean;
  end;

var
  FDEnviarCorreo: TFDEnviarCorreo;

function
  EnviarCorreo( Report: TQuickRep ): boolean;

implementation

uses DPreview, CVariables, DError, ShellApi, Principal,
     UDMBaseDatos, UDMAuxDB, UDMConfig, DConfigMail, ShlObj,
     IdAttachmentFile;

{$R *.DFM}


function EnviarCorreo( Report: TQuickRep ): boolean;
var
  aux: string;
begin

  //Creo el formulario
  with TFDEnviarCorreo.Create(Application) do
  begin
    aux := Report.ReportTitle;

    //le quito los puntos para que no hayan problemas con el nombre del fichero
    aux := StringReplace(aux, '.', '', [rfReplaceAll, rfIgnoreCase]);
    Report.ReportTitle := Trim(Aux);
    Adjuntos.Add(gsDirActual + '\..\temp'  + '\' + Report.ReportTitle + '.pdf');

    if not CrearPDF(Report) then
    begin
      ShowError('Existe un problema al crear el informe en PDF.' + #13#10 +
                'Cierre el programa, reinicie el ordenador y vuelva a lanzarlo.');
      Result := False;
      Free;
      Exit;
    end;

    //Rellenamos los campos de la pantalla de envío de correo
    EDireccion.Text := '';
    edtCopia.Text:= gsDirCorreo;//gsCuentaCorreo;
    EAsunto.Text := 'Envío PDF Gestión Comercial.';

    //mostrar la pantalla de envio de correo
    ShowModal;

    if ( LowerCase(Report.Name) = 'qralbaransalida' ) or
       ( LowerCase(Report.Name) = 'qralbaransalidaweb' )  or
       ( LowerCase(Report.Name) = 'qralbaransinvalorar' ) or
       ( LowerCase(Report.Name) = 'qralbaranvalorado' ) or
       ( LowerCase(Report.Name) = 'qralbaranentrecentrosmercadona' ) or
       ( LowerCase(Report.Name) = 'qrlalboutput' ) then

    begin
      if enviado then
        GuardarAlbaranEnviadO;
    end;
    Result := enviado;
  end;
end;

procedure TFDEnviarCorreo.GuardarAlbaranEnviado;
var dia, hora: string;
begin
  dia := DateToStr(Date);
  hora := TimeToStr(Time);
  with QGuardarEnviados do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO frf_alb_enviados ' +
      'SELECT empresa_sc, cliente_sal_sc, n_albaran_sc, fecha_sc, ' +
      QuotedStr(hora) + ',' + QuotedStr(dia) + ',' + QuotedStr(gsCodigo) +
      ',' + QuotedStr(gsMaquina) + ',' + QuotedStr(EDireccion.Text) + ',' + QuotedStr(edtCopia.Text) +
      ' FROM frf_salidas_c ' +
      ' WHERE empresa_sc = ' + QuotedStr(sEmpresaConfig) +
      ' AND cliente_fac_sc = ' + QuotedStr(sClienteConfig) +
      ' AND n_albaran_sc = ' + sAlbaranConfig +
      ' AND fecha_sc = ' + QuotedStr(sFechaConfig));
    try
      ExecSQL;
    except
      on E: EDBEngineError do
      begin
        ShowError(e);
      end;
    end;
  end;
     //ImprimirReporteAlbaranes;
end;


function AlbaranesSendMail(const AAdjuntos: TStrings; var ADireccion: string): boolean;
begin
  //Creo el formulario
  with TFDEnviarCorreo.Create(Application) do
  begin
    Adjuntos.AddStrings(AAdjuntos);
    Edireccion.Text := ADireccion;
    edtCopia.Text:= gsDirCorreo;//gsCuentaCorreo;
    EAsunto.Text := 'Envío de albaranes';

    //mostrar la pantalla de envio
    ShowModal;
    ADireccion := Edireccion.Text;
    Result := enviado;
  end;
end;

procedure TFDEnviarCorreo.FormCreate(Sender: TObject);
begin
     //inicializar variables
  Application.BringToFront;
  SBEstado.SimpleText := '';
  enviado := false;
  Adjuntos := TStringList.Create;
  Adjuntos.Clear;

  IdSMTP.Host:= gsHostCorreo;
  IdSMTP.UserName:= gsUsarioCorreo;
  IdSMTP.Password:= gsClaveCorreo;
//    IdSMTP.Port:= 25;
    IdSMTP.Port:= 587;
  idUserPassProvider1.Username :=gsUsarioCorreo;
  idUserPassProvider1.Password := gsClaveCorreo;

end;

procedure TFDEnviarCorreo.FormShow(Sender: TObject);
var imagen: integer;
  i: integer;
begin
     //Cargar los ficheros el TListView
  if Adjuntos.Count > 0 then
  begin
    for i := 0 to Adjuntos.Count - 1 do
    begin
             //comprobar si es .doc o .pdf
      if Copy(Adjuntos[i], (Length(Adjuntos[i]) - 2), 3) = 'doc' then
        imagen := 3 //se le pone el icono de Word
      else
        imagen := 1; //se le pone el icono de PDF
      ListView1.Items.Add;
      ListView1.Items[ListView1.Items.Count - 1].Caption := Adjuntos[i];
      ListView1.Items[ListView1.Items.Count - 1].ImageIndex := imagen;
    end;
  end;
  if EDireccion.Text = '' then
    EDireccion.SetFocus
  else
    MMensaje.SetFocus;
end;

procedure TFDEnviarCorreo.SBEnviarClick(Sender: TObject);
var i: integer;
begin
  if Enviado then
  begin
    ShowMessage('El mensaje ya ha sido enviado, salga de esta pantalla para enviar otro mensaje');
    Exit;
  end;

  if SGEnviados.Visible then
  begin
    SGEnviados.Visible := false;
  end;

  SBEstado.SimpleText := '';
     //Correo.ClearParameters;

     //Intentamos conectar
  SBEstado.SimpleText := 'Conectando con el servidor de correo';
  Sleep(1500);
  if not IdSMTP.Connected then
  begin
    try
      IdSMTP.Connect;
    except
      ShowMessage('No se puede conectar');
      SBEstado.SimpleText := 'Operación abortada';
      BorrarFicheros( true );
      Exit;
    end;
  end;

  SBEstado.SimpleText := 'Conexión con el servidor de correo realizada';
  Screen.Cursor := crHourGlass;
     //rellenamos parametros para el envio
     //Correo.ClearParameters;
  IdMessage.From.Name := gsNombre;
  IdMessage.From.Address := gsCuentaCorreo;
  IdMessage.ReplyTo.EMailAddresses:= gsDirCorreo;
  if pos(';', Edireccion.Text) > 0 then
    RellenarDirecciones(Edireccion.Text)
  else
    IdMessage.Recipients.Add.Address := EDireccion.Text;
  RellenarCopias(edtCopia.Text);
  IdMessage.Subject := EAsunto.Text;
     //Correo.PostMessage.Attachments.Add(Adjuntos);
  for i := 0 to Adjuntos.Count - 1 do
    TIdAttachmentFile.Create(IdMessage.MessageParts, Adjuntos[i]);

  for i := 0 to (MMensaje.Lines.Count - 1) do
    IdMessage.Body.Add(MMensaje.Lines[i]);

     //Intentamos  enviar
  SBEstado.SimpleText := 'Enviando mensaje';
  try
    IdSMTP.Send(IdMessage);
  except
    on E: Exception do
    begin
      ConvertirMensaje(E.Message);
      Screen.Cursor := crDefault;
      SBEstado.SimpleText := 'Operación abortada';
      BorrarFicheros(true);
      Enviado := False;
      try
        IdSMTP.Disconnect;
      except
      end;
      Exit;
    end;
  end;

  screen.Cursor := crDefault;
  Enviado := True;
  SBEstado.SimpleText := 'Mensaje enviado';
  BorrarFicheros(true);
end;

procedure TFDEnviarCorreo.RellenarCopias(direcciones: string);
var aux: integer;
begin
  IdMessage.BccList.Clear;
  while direcciones <> '' do
  begin
    if pos(';', direcciones) > 0 then
    begin
      IdMessage.BccList.Add.Address := Trim(Copy(direcciones, 0, (pos(';', direcciones) - 1)));
      aux := pos(';', direcciones) + 1;
      direcciones := Copy(direcciones, aux, Length(direcciones));
    end
    else
    begin
      IdMessage.BccList.Add.Address := trim(Copy(direcciones, 0, Length(direcciones)));
      direcciones := '';
    end;
  end;
end;

procedure TFDEnviarCorreo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Adjuntos <> nil then begin
    Adjuntos.Free;
    Adjuntos := nil;
  end;
  Action := caFree;
end;

procedure TFDEnviarCorreo.SBSalirClick(Sender: TObject);
begin
  if SGEnviados.Visible then
  begin
    SGEnviados.Visible := False;
    Exit;
  end;
  if IdSMTP.Connected then
    IdSMTP.Disconnect;
  if not Enviado then
  begin
         //mensaje de aviso de que no ha sido enviado
    if MessageDlg('El e-mail no ha sido enviado, ¿desea salir?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      BorrarFicheros(true);
      Close;
    end
  end
  else
    Close;
end;

function TFDEnviarCorreo.CrearPDF(rep: TQuickRep): boolean;
var
  old_impresora: integer;
begin
  //Escoger impresora de PDF y crear el fichero
  old_impresora := Rep.PrinterSettings.PrinterIndex;

  if giPrintPDF > -1 then begin
    Rep.PrinterSettings.PrinterIndex := giPrintPDF;
    Rep.tag := Tag;
    Rep.ShowProgress := False;
    Screen.Cursor := crHourGlass;
    try
      //Rep.ReportTitle:= StringReplace(Trim(Rep.ReportTitle), ' ', '_', [rfReplaceAll]);
      Rep.ReportTitle:= Trim(Rep.ReportTitle);
      Rep.print;
    except
      Rep.PrinterSettings.PrinterIndex := old_impresora;
      Screen.Cursor := crDefault;
      Result := False;
      Application.ProcessMessages;
      Exit;
    end;
    Rep.PrinterSettings.PrinterIndex := old_impresora;
    Screen.Cursor := crDefault;
    Result := True;
    Application.ProcessMessages;

  end else begin
    Result := False;
  end;
end;

procedure TFDEnviarCorreo.BorrarFicheros(borrar: boolean);
var i: integer;
begin
  if (borrar) and (Adjuntos.count > 0) then
  try
    for i := 0 to Adjuntos.Count - 1 do
      DeleteFile(Adjuntos[i])
  except
  end;
end;

//RECOGER LOS POSIBLES ERRORES TANTO AL CONECTARSE COMO AL ENVIAR EL CORREO

procedure TFDEnviarCorreo.ConvertirMensaje(msg: string);
begin
  if msg = '503 No recipients specified' + #$D#$A then
    ShowError('Falta la dirección de destino')
  else
    if msg = 'Incomplete Header' then
      ShowError('Falta la dirección del remitente')
    else
      if pos('No se puede abrir el archivo', msg) > 0 then
        ShowError(msg)
      else
        ShowError('No se puede enviar el mensaje' + #13 + #10 + '[' + msg + ']');
end;

procedure TFDEnviarCorreo.RellenarDirecciones(direcciones: string);
var aux: integer;
begin
  while direcciones <> '' do
  begin
    if pos(';', direcciones) > 0 then
    begin
      IdMessage.Recipients.Add.Address := Trim(Copy(direcciones, 0, (pos(';', direcciones) - 1)));
      aux := pos(';', direcciones) + 1;
      direcciones := Copy(direcciones, aux, Length(direcciones));
    end
    else
    begin
      IdMessage.Recipients.Add.Address := trim(Copy(direcciones, 0, Length(direcciones)));
      direcciones := '';
    end;
  end;
end;

procedure TFDEnviarCorreo.ListView1DblClick(Sender: TObject);
begin
  if ListView1.Selected <> nil then
    ShellExecute(Handle, nil, PChar(ListView1.Selected.Caption),
      nil, nil, SW_NORMAL);
end;

procedure TFDEnviarCorreo.AHistoricoExecute(Sender: TObject);
var fichero: TStringList;
  i, j, col, fil: integer;
begin

  if not FileExists(gsDirActual + '\MensajesEnviados.txt') then
  begin
    ShowError('No se ha enviado ningún correo electrónico todavia');
    Exit;
  end;
  fichero := TStringList.Create;
  fichero.LoadFromFile(gsDirActual + '\MensajesEnviados.txt');
  //rellenar titulos de columnas
  SGEnviados.Cells[0, 0] := 'Fecha';
  SGEnviados.Cells[1, 0] := 'Hora';
  SGEnviados.Cells[2, 0] := 'Para';
  SGEnviados.Cells[3, 0] := 'Asunto';
  SGEnviados.Cells[4, 0] := 'Adjuntos';
  //rellenar celdas
  fil := 1;
  if Fichero.Count > 10 then
  begin
    for i := (Fichero.Count - 1) downto (Fichero.Count - 10) do
    begin
      col := 0;
      while (pos('|', fichero[i])) > 0 do
      begin
        SGEnviados.Cells[col, fil] := (Trim(Copy(fichero[i], 0, (pos('|', fichero[i]) - 1))));
        j := pos('|', fichero[i]) + 1;
        fichero[i] := Copy(fichero[i], j, Length(fichero[i]));
        inc(col);
      end;
      SGEnviados.Cells[col, fil] := Trim(fichero[i]);
      inc(fil);
    end;
  end
  else
  begin
    for i := (Fichero.Count - 1) downto 0 do
    begin
      col := 0;
      while (pos('|', fichero[i])) > 0 do
      begin
        SGEnviados.Cells[col, fil] := (Trim(Copy(fichero[i], 0, (pos('|', fichero[i]) - 1))));
        j := pos('|', fichero[i]) + 1;
        fichero[i] := Copy(fichero[i], j, Length(fichero[i]));
        inc(col);
      end;
      SGEnviados.Cells[col, fil] := Trim(fichero[i]);
      inc(fil);
    end;
  end;
  SGEnviados.Align := alClient;
  SGEnviados.Visible := True;
  fichero.Free;
end;

(*
const
  CSIDL_DESKTOP    = $0000;
  CSIDL_PERSONAL   = $0005;
  CSIDL_MYPICTURES = $0027;
  CSIDL_MYMUSIC    = $000d;
  CSIDL_MYVIDEO    = $000e;
  CSIDL_WINDOWS    = $0024;
  CSIDL_SYSTEM     = $0025;
*)

function GetSpecialFolderPath(Folder: Integer; ForceDir: Boolean): string;
// Uses ShlObj
var
  Path: array [0..255] of char;
begin
  SHGetSpecialFolderPath(0, @Path[0], Folder, ForceDir);
  Result := Path;
end;

procedure TFDEnviarCorreo.btn1Click(Sender: TObject);
var
  sRuta: string;
  imagen: Integer;
begin
  sRuta:= GetSpecialFolderPath( $0005, false );
  dlgOpen.InitialDir:= sRuta;
  if dlgOpen.Execute then
  begin
    if FileExists(dlgOpen.FileName) then
    begin
      Adjuntos.Add( dlgOpen.FileName );

      if Copy(dlgOpen.FileName, (Length(dlgOpen.FileName)) - 2, 3) = 'pdf' then
        imagen := 1 //se le pone el icono de PDF
      else
        imagen := 0;
      ListView1.Items.Add;
      ListView1.Items[ListView1.Items.Count-1].Caption := dlgOpen.FileName;
      ListView1.Items[ListView1.Items.Count-1].ImageIndex := imagen;
    end;
  end;


end;

end.


