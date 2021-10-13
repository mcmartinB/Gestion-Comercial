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
    ActionList1: TActionList;
    AEnvio: TAction;
    ASalir: TAction;
    IdMessage: TIdMessage;
    IdSMTP: TIdSMTP;
    lblCopia: TLabel;
    edtCopia: TEdit;
    QGuardarEnviados: TQuery;
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
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
    bAdjuntos: boolean;
    procedure BorrarFicheros(borrar: boolean);
    procedure ConvertirMensaje(msg: string);
    function  CrearPDF(rep: TQuickRep): boolean;
    procedure RellenarDirecciones(direcciones: string);
    procedure RellenarCopias(direcciones: string);
    procedure GuardarAlbaranEnviado;
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


function EMailCliente( var email: string): boolean;
begin
  email := '';
  Result := False;
  if DConfigMail.sClienteConfig <> '' then
  with DMBaseDatos.QGeneral do
  begin
    Close;
    SQl.Clear;
    SQl.Add('SELECT email_alb_c FROM frf_clientes ' +
      'WHERE cliente_c = ' + QuotedStr(sClienteConfig) +
      ' AND email_alb_c IS NOT NULL AND email_alb_c <> '''' ');
    try
      Open;
    except
      Result := false;
      exit
    end;

    if not IsEmpty then
    begin
      email := Trim(FieldByName('email_alb_c').AsString);
    end;
    Close;

    if DConfigMail.sSuministroConfig <> '' then
    with DMBaseDatos.QGeneral do
    begin
      Close;
      SQl.Clear;
      SQl.Add('SELECT email_ds  ');
      SQl.Add('FROM frf_dir_sum  ');
      SQl.Add('WHERE cliente_ds = ' + QuotedStr(sClienteConfig)  );
      SQl.Add(' AND dir_sum_ds = ' + QuotedStr(sSuministroConfig)  );
      SQl.Add(' AND nvl(email_ds,'''') <> ''''  ');
      try
        Open;
      except
        Result := false;
        exit
      end;

      if not IsEmpty then
      begin
        if Trim( email ) = '' then
        begin
          email := Trim(FieldByName('email_ds').AsString);
        end
        else
        begin
          if Copy( email, Length( email ), 1 ) = ';' then
            email := email + Trim(FieldByName('email_ds').AsString)
          else
            email := email + ';' + Trim(FieldByName('email_ds').AsString);
        end;
      end;
      Close;
    end;

  end;
  Result := email <> '';
end;

function EMailCentro( var email: string): boolean;
begin
  email := '';
  Result := False;
  if DConfigMail.sCentroConfig <> '' then
  with DMBaseDatos.QGeneral do
  begin
    Close;
    SQl.Clear;
    SQl.Add('select email_c from frf_centros ');
    SQl.Add('where empresa_c = ' + QuotedStr(sEmpresaConfig));
    SQl.Add('and centro_c = ' + QuotedStr(sCentroConfig) );
    SQl.Add('AND email_c IS NOT NULL AND email_c <> '''' ');
    try
      Open;
    except
      Result := false;
      exit
    end;

    if not IsEmpty then
    begin
      Result := True;
      email := FieldByName('email_c').AsString;
    end;
    Close;
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
    Report.ReportTitle := Aux;
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
    edtCopia.Text:= gsDirCorreo;//gsCuentaCorreo;

    if ( Copy( LowerCase(Report.Name), 1, 9)  = 'qralbaran' ) then
    begin
      if EMailCliente( aux ) then
        EDireccion.Text := aux
      else
        EDireccion.Text := '';
      EAsunto.Text := sAsunto;

    end
    else
    begin
      if LowerCase(Report.Name) = 'qrlalbarantransito2' then
      begin
        EAsunto.Text := 'Envío de tránsitos.';
        if EMailCentro( aux ) then
          EDireccion.Text := aux
        else
          EDireccion.Text := '';
      end
      else
        EAsunto.Text := 'Envío PDF Gestión Comercial.';
    end;

    //mostrar la pantalla de envio de correo
    ShowModal;

    if ( Copy( LowerCase(Report.Name), 1, 9)  = 'qralbaran' ) then
    begin
      if enviado then
        GuardarAlbaranEnviadO;
    end;

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
  IdSMTP.Username:= gsUsarioCorreo;
  IdSMTP.Password:= gsClaveCorreo;
//  IdSMTP.Port:= 25;
  IdSMTP.Port:= 587;

  idUserPassProvider1.Username :=gsUsarioCorreo;
  idUserPassProvider1.Password := gsClaveCorreo;

  bAdjuntos:= False;
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
  RellenarDirecciones(Edireccion.Text);
  RellenarCopias(edtCopia.Text);
  IdMessage.Subject := EAsunto.Text;

     //Correo.PostMessage.Attachments.Add(Adjuntos);
  //si da error al volver a enviar se adjunta dos veces
     //Correo.PostMessage.Attachments.Add(Adjuntos);
  if not bAdjuntos then
  begin
    for i := 0 to Adjuntos.Count - 1 do
      TIdAttachmentFile.Create(IdMessage.MessageParts, Adjuntos[i]);
    bAdjuntos:= True;
  end;

  IdMessage.Body.Clear;
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
  BorrarFicheros(true);

  //Modificado el 7/12/2011, si se ha enviado correctamente cerramos
  if IdSMTP.Connected then
    IdSMTP.Disconnect;

  SBEstado.SimpleText := 'CORREO ENVIADO OK';
  AEnvio.Enabled:= False;
  //Close;
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
  IdMessage.Recipients.Clear;
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

procedure TFDEnviarCorreo.ListView1DblClick(Sender: TObject);
begin
  if ListView1.Selected <> nil then
    ShellExecute(Handle, nil, PChar(ListView1.Selected.Caption),
      nil, nil, SW_NORMAL);
end;

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


