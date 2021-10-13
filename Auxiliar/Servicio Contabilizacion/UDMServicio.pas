unit UDMServicio;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMServicio = class(TDataModule)
    DataBase: TDatabase;
    dbMaster: TDatabase;
  private
    { Private declarations }
    sDataBase: String;
    
  public
    Host, User, Pass, Mail, Dir: String;
    Port: integer;
    sRuta: String;

    procedure EjecutarConta;
    function  TipoContabilizacion: integer;
    procedure ProcesoFacturacion( const ATipo: integer );
    procedure ContabilizarFacturacion;

    procedure Contabilizar(ADataBase: TDatabase);
    procedure CreaQGrupoT( const ATipo: integer );
    function  EjecutaQGrupoT: boolean;
    procedure CreaQEmpresas;
    function  EjecutaQEmpresas: Boolean;
    procedure EnviarCorreo(ARuta: String);
    procedure GetParametros;
    procedure GetDestinatario;

    procedure Marca;
  end;

var
  DMServicio: TDMServicio;

implementation

{$R *.dfm}

uses
  CContabilizacion, BonnyQuery, IdSMTP, IdMessage, IdAttachmentFile;

procedure TDMServicio.EjecutarConta;
begin
  try
    dbMaster.Params.Values['DATABASE NAME'] := 'comermaster';
    dbMaster.Open;

    Marca;

    try
      case TipoContabilizacion of
        1: //facturas
          ProcesoFacturacion( 1 );
        2: //abonos
          ProcesoFacturacion( 2 );
      end;
    finally
      dbMaster.Close;
    end;

  except
    //Mensaje de errror
  end;
end;

function TDMServicio.TipoContabilizacion: integer;
var
  QFechaConta: TBonnyQuery;
begin
  result:= 0;
  QFechaConta := TBonnyQuery.Create(Self);
  QFechaConta.DatabaseName:= dbMaster.DatabaseName;
  QFechaConta.RequestLive:= True;
  QFechaConta.SQL.Add(' select fecha_factura_fuc, fecha_abono_fuc, hora_factura_fuc,hora_abono_fuc from rfecha_ultima_conta  ');
  try
    with QFechaConta do
    begin
      Open;

      //Primero las facturas
      if FieldByName('fecha_factura_fuc').AsDateTime < Date then
      begin
        //Es la hora
        if FormatDateTime('hhnn', Now) > FieldByName('hora_factura_fuc').AsString   then
        begin
          Edit;
          FieldByName('fecha_factura_fuc').AsDateTime:= Now;
          Post;
          result:= 1;
        end;
      end
      else
      if FieldByName('fecha_abono_fuc').AsDateTime < Date then
      begin
        //Es la hora
        if FormatDateTime('hhnn', Now) > FieldByName('hora_abono_fuc').AsString then
        begin
          Edit;
          FieldByName('fecha_abono_fuc').AsDateTime:= Now;
          Post;
          result:= 2;
        end;
      end;
    end;
  finally
    QFechaConta.Close;
    QFechaConta.Free;
  end;
end;


procedure TDMServicio.ProcesoFacturacion( const ATipo: integer );
begin
  iFacturas := 0;
  iErrores := 0;

  //ComerSAT
  try
    try
      DataBase.Params.Values['DATABASE NAME'] := 'comersat';
      DataBase.Open;
      sDataBase := 'comersat';

      CrearBuffers;
      CreaQEmpresas;
      CreaQGrupoT( ATipo );
      Crearconsultas;
      GetParametros;
      GetDestinatario;
      sRuta := ObtenerRuta;

      ContabilizarFacturacion;
    finally
      QEmpresas.Close;
      DataBase.Close;
    end;
  except
    //Mensaje de error
  end;


  //ComerBag
  try
    try
      DataBase.Params.Values['DATABASE NAME'] := 'comerbag';
      DataBase.Open;
      sDataBase := 'comerbag';

      CreaQEmpresas;

      ContabilizarFacturacion;
    finally
      DataBase.Close;
    end;
  except
    //Mensaje de error
  end;
 
  EnviarCorreo(sRuta);
  BorrarListas;
  CerrarTablas;
end;

procedure TDMServicio.ContabilizarFacturacion;
begin
  EjecutaQEmpresas;
  QEmpresas.First;
  while not QEmpresas.eof do
  begin
    LimpiarBuffers;
    NombresFicheros(sRuta, QEmpresas.FieldByName('cod_empresa_fac_fc').AsString);

    Contabilizar(DataBase);
    GrabarFichero(sRuta);

    QEmpresas.Next;
  end;
end;

procedure TDMServicio.Contabilizar(ADataBase: TDataBase);
begin
  try
    EjecutaQGrupoT;
    ContabilizarFacturas(ADataBase, True);
  except
    //raise
  end;
end;

procedure TDMServicio.CreaQGrupoT( const ATipo: integer );
begin
  QGrupoT := TBonnyQuery.Create(Self);
  with QGrupoT do
  begin
    SQL.Add(' select * from tfacturas_cab, frf_empresas ');
    SQL.Add('  where fecha_factura_fc between (Today - 365) and (Today - 1) ');
    SQL.Add('    and contabilizado_fc = 0 ');
    SQL.Add('    and empresa_e = cod_empresa_fac_fc ');
    SQL.Add('    and contabilizar_e <> 0 ');
    SQL.Add('    and cod_empresa_fac_fc = :empresa ');

    if ATipo = 1 then
      SQL.Add('   and tipo_factura_fc = 380 ')
    else
    if ATipo = 2 then
      SQL.Add('   and tipo_factura_fc = 381 ');

    SQL.Add('  order by cod_empresa_fac_fc, YEAR(fecha_factura_fc), n_factura_fc, fecha_factura_fc ');

    Prepare;
  end;
end;

function TDMServicio.EjecutaQGrupoT: boolean;
begin
  with QGrupoT do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := QEmpresas.FieldByName('cod_empresa_fac_fc').AsString;

    Open;
    Result := not IsEmpty;
  end;                                        

end;

procedure TDMServicio.CreaQEmpresas;
begin
  QEmpresas := TBonnyQuery.Create(Self);
  with QEmpresas do
  begin
    SQL.Clear;
    SQL.Add(' select DISTINCT cod_empresa_fac_fc from tfacturas_cab, frf_empresas ');
    SQL.Add('  where fecha_factura_fc between (Today -365) and (Today -1) ');
    SQL.Add('    and contabilizado_fc = 0 ');
    SQL.Add('    and empresa_e = cod_empresa_fac_fc ');
    SQL.Add('    and contabilizar_e <> 0 ');
    if sDataBase = 'comersat' then
      SQL.Add(' and cod_empresa_fac_fc in (''050'', ''080'') ')
    else
      SQL.Add(' and (cod_empresa_fac_fc[1] = ''F'' or cod_empresa_fac_fc = ''086'') ');

    SQL.Add('  order by cod_empresa_fac_fc ');

    Prepare;
  end;
end;

function TDMServicio.EjecutaQEmpresas: boolean;
begin
  with QEmpresas do
  begin
    if Active then
      Close;

    Open;
    Result := not IsEmpty;
  end;
end;

procedure TDMServicio.EnviarCorreo(ARuta: String);
var SMTP: TidSMTP;
    MESS: TidMessage;
    sTexto: string;
    i: integer;
begin
  SMTP := TIdSMTP.Create(Self);
  MESS := TIdMessage.Create(Self);

  try
    SMTP.Host := Host;
    SMTP.Port := Port;
    //TIdSMTPAuthenticationType = (atNone, atDefault, atSASL);
    SMTP.AuthType := atDefault;
    //SMTP.AuthenticationType := atLogin;
    SMTP.Username := User;
    SMTP.Password := Pass;

    MESS.Recipients.EMailAddresses := Mail;
    MESS.From.Address := Format('Proceso de Contabilizacion <%s>', [ Dir ]);    {TODO: Cambiar ???}
    if iFacturas > 0 then
    begin
      if iErrores > 0 then
        MESS.Subject := 'PROCESO DE CONTABILIZACION CON ERRORES. Fecha: ' + DateToStr(Now)
      else
        MESS.Subject := 'PROCESO DE CONTABILIZACION OK. Fecha: ' + DateToStr(Now);
    end
    else
      MESS.Subject := 'PROCESO DE CONTABILIZACION. Fecha: ' + DateToStr(Now);

    sTexto := 'Inicio Proceso de Contabilización ' + DateToStr(Now) + #13#10 + #13#10;
    if iFacturas > 0 then
    begin
      if iErrores > 0 then
        sTexto := sTexto + 'Proceso Finalizado con ERRORES. Total Facturas: ' + IntToStr(iFacturas) + #13#10 +
                           '    ' + IntToStr(iFacturas - iErrores) + ' Facturas Contabilizadas.' + #13#10 +
                           '    ' + IntToStr(iErrores) + ' Facturas con Errores.' + #13#10 + #13#10
      else
        sTexto := sTexto + 'Proceso Finalizado con EXITO. Total Facturas: ' + IntToStr(iFacturas) + #13#10 + #13#10;
    end
    else
      sTexto := sTexto + 'No hay facturas para Contabilizar.' + #13#10 + #13#10;

    if (slFicGenerados.Count > 0) or (slErrGenerados.Count > 0) then
    begin
      sTexto := sTexto + 'Ficheros con Errores Generados: ' + #13#10;
{
      for i:=0 to slFicGenerados.Count-1 do
      begin
        if FileExists(ARuta + slFicGenerados[i]) then
          TIdAttachment.Create(MESS.MessageParts, ARuta + slFicGenerados[i]);
        sTexto := sTexto + slFicGenerados[i] + #13#10;
      end;
}
      for i:=0 to slErrGenerados.Count-1 do
      begin
        if FileExists(ARuta + slErrGenerados[i]) then
          TIdAttachmentFile.Create(MESS.MessageParts, ARuta + slErrGenerados[i]);
        sTexto := sTexto + slErrGenerados[i] + #13#10;
      end;
    end;

    MESS.Body.Add(sTexto);

    SMTP.Connect;
    SMTP.Send(MESS);

  finally
    SMTP.Disconnect;
    SMTP.Free;
    MESS.Free;
  end;

end;

procedure TDMServicio.GetParametros;
var QParametros: TBonnyQuery;
begin
  QParametros := TBonnyQuery.Create(Self);
  with QParametros do
  try
    SQL.Add(' select smtp_ccc, identificador_ccc, clave_ccc, cuenta_ccc ');
    SQL.Add('   from cnf_usuarios, cnf_cuentas_correo ');
    SQL.Add('  where usuario_cu = :usuario ');
    SQL.Add('    and codigo_ccc = cuenta_correo_cu ');

//    ParamByName('usuario').AsString := Database.Params.Values['USER NAME'];
    ParamByName('usuario').AsString := 'informix';
    Open;

    Host := FieldByName('smtp_ccc').AsString;
    User := FieldByName('identificador_ccc').AsString;
    Pass := FieldByName('clave_ccc').AsString;
    Dir := FieldByName('cuenta_ccc').AsString;
    Port := 25;

    Close;

  finally
    Free;
  end;
end;

procedure TDMServicio.GetDestinatario;
var QDestinatario: TBonnyQuery;
begin
  QDestinatario := TBonnyQuery.Create(Self);
  with QDestinatario do
  try
    SQL.Add(' select email_ce from cnf_emails ');
    SQL.Add('  where usuario_ce = :usuario ');
    SQL.Add('    and codigo_ce = :codigo ');

    ParamByName('usuario').AsString := 'all';
    ParamByName('codigo').AsString := 'contabilizar';
    Open;

    Mail := FieldByName('email_ce').AsString;

    Close;

  finally
    Free;
  end;
end;

procedure TDMServicio.Marca;
var
  QFechaConta: TBonnyQuery;
begin
  QFechaConta := TBonnyQuery.Create(Self);
  QFechaConta.DatabaseName:= dbMaster.DatabaseName;
  QFechaConta.RequestLive:= True;
  QFechaConta.SQL.Add(' select marca_fuc from rfecha_ultima_conta  ');
  try
    with QFechaConta do
    begin
      Open;
      Edit;
      FieldByName('marca_fuc').AsDateTime:= Now;
      Post;
    end;
  finally
    QFechaConta.Close;
    QFechaConta.Free;
  end;
end;

end.
