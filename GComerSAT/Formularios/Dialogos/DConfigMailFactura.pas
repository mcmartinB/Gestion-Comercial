unit DConfigMailFactura;
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, quickrpt, Printers,
  ImgList, ActnList, Grids, Db, DBTables, IdComponent,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP, IdBaseComponent,
  IdMessage, IdExplicitTLSClientServerBase, IdSMTPBase, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdUserPassProvider,
  IdSASL, IdSASLUserPass, IdSASLLogin;

type
  TFDConfigMailFactura = class(TForm)
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
    ActionList1: TActionList;
    AEnvio: TAction;
    ASalir: TAction;
    QGuardarEnviados: TQuery;
    QPDFs: TQuery;
    QPDFsnombre_p: TStringField;
    QPDFspdf_p: TBlobField;
    IdMessage: TIdMessage;
    lblCopia: TLabel;
    edtCopia: TEdit;
    IdSMTP: TIdSMTP;
    btnACancelar: TSpeedButton;
    dlgOpen: TOpenDialog;
    Panel4: TPanel;
    Label3: TLabel;
    btn1: TButton;
    sbVerUlt: TSpeedButton;
    sbOcultarUlt: TSpeedButton;
    SGEnviados: TStringGrid;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdSASLLogin1: TIdSASLLogin;
    IdUserPassProvider1: TIdUserPassProvider;
    chkTextoFijoAsunto: TCheckBox;
    procedure SBEnviarClick(Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure EDireccionChange(Sender: TObject);
    procedure btnACancelarClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure sbVerUltClick(Sender: TObject);
    procedure sbOcultarUltClick(Sender: TObject);
    procedure chkTextoFijoAsuntoClick(Sender: TObject);
  private
    { Private declarations }
    direccion: string;
    bPregunta: Boolean;
    bAdjuntos: boolean;
    procedure BorrarFicheros(borrar: boolean);
    procedure ConvertirMensaje(msg: string);
    procedure RellenarDirecciones(direcciones: string);
    procedure RellenarCopias(direcciones: string);
    procedure GuardarAlbaranEnviado;
    procedure GuardarReporte;

  public
    { Public declarations }
    rReport: TQuickRep;
    adjuntos: TStringList;
    esFactura: boolean;
    bEnviado, bCancelar, bAlbaran: boolean;
    sEmpresa, sCliente : String;
    

    //SSLHandler: TIdSSLIOHandlerSocketOpenSSL;

    function AsuntoFactura( const AEmpresa, ACliente: string ): string;
  end;


var
  FDConfigMailFactura: TFDConfigMailFactura;
  sEmpresaConfig, sClienteConfig, sSuministroConfig, sCentroConfig, sAlbaranConfig,
  sFechaConfig, sAsunto, sCampoConfig: string;



implementation

uses MSalidas, DPreview, CVariables, DError, LReporteEnvio, ShellApi, StrUtils, Principal,
  UDMBaseDatos, UDMAuxDB, UDMConfig, CReportes, CGlobal, ShlObj, IdAttachmentFile, UDFactura;

{$R *.DFM}

//   Sacamos la direccion de email del cliente


procedure TFDConfigMailFactura.GuardarAlbaranEnviado;
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



procedure TFDConfigMailFactura.GuardarReporte;
var manejador: integer;
  archivos: string;
  i: integer;
begin
     //Comprobar si existe el fichero
  if not FileExists(gsDirActual + '\MensajesEnviados.txt') then
  begin
    try
      manejador := FileCreate(gsDirActual + '\MensajesEnviados.txt')
    except
      begin
        ShowError('No se puede grabar el mensaje en el fichero de mensajes enviados');
        Exit;
      end;
    end;
    FileClose(manejador);
  end;
     //Añadir la linea al fichero con los datos del correo enviado: fecha, hora, direccion, adjuntos
  with TStringList.Create do
  begin
    for i := 0 to Adjuntos.count - 1 do
    begin
      if i > 0 then archivos := archivos + ';';
      archivos := archivos + Adjuntos[i];
    end;
    try
      LoadFromFile(gsDirActual + '\MensajesEnviados.txt');
      Add(DateToStr(date) + '|' + TimeToStr(time) + '|' + EDireccion.Text + '|' + IdMessage.Subject + '|' + archivos);
      SaveToFile(gsDirActual + '\MensajesEnviados.txt');
    except
      begin
        ShowError('No se puede grabar el mensaje en el fichero de mensajes enviados');
        Free;
        Exit;
      end;
    end;
    Free;
  end;
end;

procedure TFDConfigMailFactura.FormCreate(Sender: TObject);
begin
  //inicializar variables
  //Application.BringToFront;
  SBEstado.SimpleText := '';
  esFactura := false;
  bEnviado := false;
  bCancelar:= False;
  Adjuntos := TStringList.Create;
  Adjuntos.Clear;
  bAdjuntos:= False;

  edtCopia.Text:= gsDirCorreo;//gsCuentaCorreo;

  IdSMTP.Host:= gsHostCorreo;
  IdSMTP.Username:= gsUsarioCorreo;
  IdSMTP.Password:= gsClaveCorreo;
//  IdSMTP.Port:= 25;
  IdSMTP.Port:= 587;
  idUserPassProvider1.Username :=gsUsarioCorreo;
  idUserPassProvider1.Password := gsClaveCorreo;

  IdSMTP.Connect;

  bPregunta:= True;
end;

procedure TFDConfigMailFactura.FormShow(Sender: TObject);
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

procedure TFDConfigMailFactura.SBEnviarClick(Sender: TObject);
var i,j: integer;
    slFacturas: TStringList;
    AFileName, sTexto, sAsuntoFijo: string;
begin

  slFacturas := TStringList.Create;

  bCancelar:= False;

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
      BorrarFicheros(not esFactura);
      Exit;
    end;
  end;

  SBEstado.SimpleText := 'Conexión con el servidor de correo realizada';

  // Creamos los PDF que vamos a enviar
  DFactura.mtFacturas_Cab.First;
  while not DFactura.mtFacturas_Cab.eof do
  begin
    slFacturas.Add(DFactura.mtFacturas_Cab.FieldByName('cod_factura_fc').AsString);
    DFactura.mtFacturas_Cab.Next;
  end;

    for i := 0 to slFacturas.Count -1 do
  begin

    DFactura.mtFacturas_Cab.Filter := 'cod_factura_fc = ''' + slFacturas[i] + '''';
    DFactura.mtFacturas_Cab.Filtered := True;

    sAsuntoFijo := EAsunto.Text;

    if CrearPDF( rReport ) then
    begin
      Sleep( 2000 );
      AFileName := gsDirActual + '\..\temp'  + '\' + rReport.ReportTitle + '.pdf';

     //Crear PDF, miro el titulo del PDF porque si acaba en punto, hay problemas para adjuntarlo
      Adjuntos.Clear;
      Adjuntos.Add(AFileName);

      MMensaje.Lines.Clear;
      MMensaje.Lines.Add( AsuntoFactura( sEmpresa, sCliente ) );

      if chkTextoFijoAsunto.Checked then
        EAsunto.Text :=  sAsuntoFijo
      else
        EAsunto.Text := 'Factura ' + slFacturas[i];

      Screen.Cursor := crHourGlass;
         //rellenamos parametros para el envio
         //Correo.ClearParameters;
      //IdMessage.From.Name := gsDescripcionCorreo;
      IdMessage.Clear;
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
      for j:=0 to Adjuntos.Count - 1 do
      begin
        if FileExists( Adjuntos[j] ) then
        begin
          TIdAttachmentFile.Create(IdMessage.MessageParts, Adjuntos[j])
        end
        else
        begin
          ShowMessage('Error al enviar el correo, no se encuentra el adjunto "' + Adjuntos[j] + '".');
          Screen.Cursor := crDefault;
          SBEstado.SimpleText := 'Operación abortada';
          BorrarFicheros(true);
          bEnviado := False;
          IdSMTP.Disconnect;
          Exit;
        end;
        //Sleep( 5000 );
      end;

        for j := 0 to (MMensaje.Lines.Count - 1) do
          IdMessage.Body.Add(MMensaje.Lines[j]);

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
          bEnviado := False;
          try
            IdSMTP.Disconnect;
          except
          end;
          Exit;
        end;
      end;

      GuardarReporte;
      screen.Cursor := crDefault;
      bEnviado := True;
      BorrarFicheros(true);
      if bPregunta then
      begin
        SBEstado.SimpleText := 'Mensaje ' + IntToStr(i+1) + ' de ' + IntToStr(slFacturas.Count) + ' enviados.';
      end
      else
      begin
        Close;
      end;
    end;
  end;

  ShowMessage('Facturas enviadas correctamente.');

  DFactura.mtFacturas_Cab.Filtered := False;
  Freeandnil(slFacturas);


{* Llamada de SAT a Enviar corrreo
  Screen.Cursor := crHourGlass;
     //rellenamos parametros para el envio
     //Correo.ClearParameters;
  IdMessage.From.Name := gsNombre;
  IdMessage.From.Address := gsCuentaCorreo;
  IdMessage.ReplyTo.EMailAddresses:= gsDirCorreo;
  RellenarDirecciones(Edireccion.Text);
  RellenarCopias(edtCopia.Text);
  IdMessage.Subject := EAsunto.Text;

  //si da error al volver a enviar se adjunta dos veces
     //Correo.PostMessage.Attachments.Add(Adjuntos);
  if not bAdjuntos then
  begin
    for i := 0 to Adjuntos.Count - 1 do
    begin
      if SysUtils.FileExists( Adjuntos[i] ) then
      begin
        TIdAttachmentFile.Create(IdMessage.MessageParts, Adjuntos[i]);
      end
      else
      begin
        ShowMessage('Error al enviar el correo, no se encuentra el adjunto "' + Adjuntos[i] + '".');
        Screen.Cursor := crDefault;
        SBEstado.SimpleText := 'Operación abortada';
        BorrarFicheros(not esFactura);
        bEnviado := False;
        IdSMTP.Disconnect;
        Exit;
      end;
    end;
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
      BorrarFicheros(not esFactura);
      bEnviado := False;
      (*
      try
        IdSMTP.Disconnect;
      except
      end;
      *)
      Exit;
    end;
  end;

  screen.Cursor := crDefault;
  bEnviado := True;
  BorrarFicheros(true and not esFactura);

  //Modificado el 7/12/2011, si se ha enviado correctamente cerramos
  if IdSMTP.Connected then
    IdSMTP.Disconnect;
  if bPregunta then
  begin
    AEnvio.Enabled:= False;
    SBEstado.SimpleText := 'CORREO ENVIADO OK';
  end
  else
  begin
    Close;
  end;
*}
end;

procedure TFDConfigMailFactura.sbOcultarUltClick(Sender: TObject);
begin
  sbVerUlt.Enabled := true;
  sbOcultarUlt.Enabled := false;
  SGEnviados.Visible := false;
end;

procedure TFDConfigMailFactura.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Adjuntos <> nil then begin
    Adjuntos.Free;
    Adjuntos := nil;
  end;
  Action := caFree;
end;

procedure TFDConfigMailFactura.SBSalirClick(Sender: TObject);
begin
  bCancelar:= False;

  if IdSMTP.Connected then
    IdSMTP.Disconnect;

  if bPregunta then
  begin
    if not bEnviado then
    begin
         //mensaje de aviso de que no ha sido enviado
      if MessageDlg('El e-mail no ha sido enviado, ¿desea salir?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        BorrarFicheros(not esFactura);
        Close;
      end
    end
    else
      Close;
  end
  else
  begin
    BorrarFicheros(not esFactura);
    Close;
  end;
end;

procedure TFDConfigMailFactura.sbVerUltClick(Sender: TObject);
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

  sbOcultarUlt.Enabled := true;
  sbVerUlt.Enabled := false;
end;

procedure TFDConfigMailFactura.BorrarFicheros(borrar: boolean);
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

procedure TFDConfigMailFactura.chkTextoFijoAsuntoClick(Sender: TObject);
begin
  EAsunto.Enabled:= chkTextoFijoAsunto.Checked;
end;

procedure TFDConfigMailFactura.ConvertirMensaje(msg: string);
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

procedure TFDConfigMailFactura.RellenarDirecciones(direcciones: string);
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

procedure TFDConfigMailFactura.RellenarCopias(direcciones: string);
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

procedure TFDConfigMailFactura.ListView1DblClick(Sender: TObject);
begin
  if ListView1.Selected <> nil then
    ShellExecute(Handle, nil, PChar(ListView1.Selected.Caption),
      nil, nil, SW_NORMAL);
end;

procedure TFDConfigMailFactura.EDireccionChange(Sender: TObject);
begin
  SBEnviar.Enabled:= Pos( '@', EDireccion.Text ) > 0;
end;

function TFDConfigMailFactura.AsuntoFactura( const AEmpresa, ACliente: string ): string;
begin
  Result:= '';
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add( 'select pais_c, banco_ct banco_c, forma_pago_ct forma_pago_c, forma_pago_adonix_fp ');
    SQL.Add( 'from frf_clientes, frf_clientes_tes ');
    SQL.Add( '     join frf_forma_pago on forma_pago_ct = codigo_fp ');
    SQL.Add( 'where cliente_c = :cliente ');
    SQL.Add('   and empresa_ct = :empresa ');
    SQL.Add('   and cliente_ct = cliente_c ');
    ParamByName('empresa').AsString:=AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    Open;

    try
      if FieldByName('pais_c').AsString = 'ES' then
      begin
        if CGlobal.gProgramVersion = pvBAG then
        begin
          if FieldByName('forma_pago_c').AsString = '64' then
          begin
            Result:= Result + #13 + #10;
            Result:= Result + 'RUEGO TENGAN EN CUENTA QUE SE HA CAMBIADO LOS DATOS BANCARIOS DONDE DEBEN EFECTUAR EL INGRESO, APARECEN DETALLADOS EN LA FACTURA - GRACIAS ' + #13 + #10;
            Result:= Result + #13 + #10;
          end;
        end
        else
        begin
          if FieldByName('forma_pago_c').AsString = '69' then
          begin
            Result:= Result + #13 + #10;
            Result:= Result + 'RUEGO TENGAN EN CUENTA QUE SE HA CAMBIADO LOS DATOS BANCARIOS DONDE DEBEN EFECTUAR EL INGRESO, APARECEN DETALLADOS EN LA FACTURA - GRACIAS ' + #13 + #10;
            Result:= Result + #13 + #10;
          end;
        end;
        Result:= Result + 'Por favor, confirme la recepción de este e-mail con otro e-mail indicando, número de factura/albarán, fecha e importe.' + #13 + #10;;
      end
      else
      begin
        if CGlobal.gProgramVersion = pvBAG then
        begin
          if FieldByName('forma_pago_c').AsString = '64' then
          begin
            Result:= Result + #13 + #10;
            Result:= Result + 'PLEASE TAKE NOTE THAT BANK DETAILS HAS BEEN CHANGED - DETAILED ON THE INVOICE - THANK YOU' + #13 + #10;
            Result:= Result + #13 + #10;
          end;
        end
        else
        begin
          if FieldByName('forma_pago_c').AsString = '69' then
          begin
            Result:= Result + #13 + #10;
            Result:= Result + 'PLEASE TAKE NOTE THAT BANK DETAILS HAS BEEN CHANGED - DETAILED ON THE INVOICE - THANK YOU' + #13 + #10;
            Result:= Result + #13 + #10;
          end;
        end;
        Result:= Result + 'Please confirm the reception of this e-mail with another e-mail indicating, invoice, date, number, and amount.' + #13 + #10;;
      end;

{
      Result:= Result + #13 + #10;
      Result:= Result + 'COMUNICACIÓN A CLIENTES' + #13 + #10;
      Result:= Result + 'Sistema de Suministro Inmediato de Información (SII)' + #13 + #10;
      Result:= Result + #13 + #10;
      Result:= Result + 'Como es sabido, el próximo 1 de julio de 2017 entrará en vigor el Sistema de Suministro Inmediato de Información,  ';
      Result:= Result + 'consistente en la obligación de llevar los libros registro de IVA a través de la Sede Electrónica de la AEAT.' + #13 + #10;
      Result:= Result + #13 + #10;
      Result:= Result + 'Este sistema de suministro de información, obligatorio para determinados sujetos pasivos (entre ellos, las entidades del Grupo Bonnysa), ';
      Result:= Result + 'implica la remisión de determinada información referida a las facturas emitidas y recibidas, así como otra información adicional de relevancia fiscal, ';
      Result:= Result + 'en un breve periodo de tiempo desde su expedición o contabilización.' + #13 + #10;
      Result:= Result + #13 + #10;
      Result:= Result + 'En el marco de este cambio normativo, nos gustaría trasmitirle nuestro interés en revisar los criterios de ';
      Result:= Result + 'facturación aplicados actualmente en el ámbito de la relación comercial que, S.a.t.';
      Result:= Result + 'Bonnysa y Bonnysa Agroalimentaria mantiene con Ustedes, y verificar que dichos criterios permitirán el cumplimiento adecuado de las obligaciones ';
      Result:= Result + 'de facturación y llevanza de los libros registro por parte de ambas Compañías.' + #13 + #10;
      Result:= Result + #13 + #10;
      Result:= Result + 'En este sentido, S.a.t. Bonnysa y Bonnysa Agroalimentaria desea que esta Comunicación sirva para recordar que todos los sujetos ';
      Result:= Result + 'pasivos deberán emitir factura por las entregas de bienes y prestaciones de servicios que realizan en el desarrollo de su actividad, ';
      Result:= Result + 'así como la obligación de emitir y remitir al destinatario facturas rectificativas en aquellos supuestos que dan lugar a la modificación ';
      Result:= Result + 'de la base imponible de las operaciones, según lo dispuesto en el artículo 80 Ley 37/1992, del Impuesto sobre el Valor Añadido ';
      Result:= Result + '(entre las que se encuentran la concesión de descuentos y otros ajustes al precio de las operaciones). Nos referimos en particular a las ';
      Result:= Result + 'modificaciones de base imponible que se ponen de manifiesto como consecuencia  la concesión de descuentos y otros ajustes al precio de las operaciones.' + #13 + #10;
      Result:= Result + #13 + #10;
      Result:= Result + 'En el ámbito de las facturas emitidas por entregas de bienes, y según lo dispuesto en el Real Decreto 1619/2012, ';
      Result:= Result + 'por el que se aprueba el Reglamento de facturación, las mismas deberán ser emitidas por, S.a.t. Bonnysa o Bonnysa Agroalimentaria ';
      Result:= Result + 'antes del día 15 del mes siguiente al que se produzca la entrega del producto, por lo que es necesario disponer de toda la ';
      Result:= Result + 'información necesaria por nuestra parte en el menor tiempo posible para poder emitir la factura en el plazo concedido al efecto.' + #13 + #10;
 }

      (*
      Result:= Result + #13 + #10;
      Result:= Result + 'El pasado 07 de julio entro en vigor la ley 15/2010 por la que se regula los plazos máximos permitidos para ';
      Result:= Result + 'los pagos a proveedores, siendo estos de 30 días a partir de la fecha de la entrega o facturación de la ';
      Result:= Result + 'mercancía (régimen especial para productos agroalimentarios perecederos), rogamos tengan a bien adecuar su ';
      Result:= Result + 'forma de pago actual a la regulada por ley. ';
      *)
    finally
      Close;
    end;
  end;
end;

procedure TFDConfigMailFactura.btnACancelarClick(Sender: TObject);
begin
  bCancelar:= True;

  if IdSMTP.Connected then
    IdSMTP.Disconnect;

  if bPregunta then
  begin
    if not bEnviado then
    begin
         //mensaje de aviso de que no ha sido enviado
      if MessageDlg('El e-mail no ha sido enviado, ¿desea salir?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        BorrarFicheros(not esFactura);
        Close;
      end
    end
    else
      Close;
  end
  else
  begin
    BorrarFicheros(not esFactura);
    Close;
  end;
end;

function GetSpecialFolderPath(Folder: Integer; ForceDir: Boolean): string;
// Uses ShlObj
var
  Path: array [0..255] of char;
begin
  SHGetSpecialFolderPath(0, @Path[0], Folder, ForceDir);
  Result := Path;
end;

procedure TFDConfigMailFactura.btn1Click(Sender: TObject);
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


