unit SincroTodoResumenFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdMessage, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdMessageClient, IdSMTP, SincroVarUNT, ExtCtrls,
  IdExplicitTLSClientServerBase, IdSMTPBase;

type
  TFDSincroTodoResumen = class(TForm)
    mmoResumen: TMemo;
    btnCerrar: TButton;
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
    btnEnviar: TButton;
    lblEstado: TLabel;
    btnImprimir: TButton;
    cbxPasados: TCheckBox;
    cbxErroneos: TCheckBox;
    cbxDuplicados: TCheckBox;
    cbxEntradas: TCheckBox;
    cbxEscandallos: TCheckBox;
    cbxSalidas: TCheckBox;
    cbxTransitos: TCheckBox;
    cbxInventarios: TCheckBox;
    cbxConfeccionado: TCheckBox;
    Bevel1: TBevel;
    procedure btnCerrarClick(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure cbxPasadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    AResumen: RSincroTodoResumen;
    registros, pasados, erroneos, duplicados: integer;

    bSalir: Boolean;

    procedure MostrarResultado;
    procedure Configurar;
    procedure Totales;
    procedure TablaCruzada( var ACuerpo: TStringList );
    procedure PasadosMsg( var ACuerpo: TStringList );
    procedure ErroneosMsg( var ACuerpo: TStringList );
    procedure DuplicadosMsg( var ACuerpo: TStringList );

  public
    { Public declarations }
  end;

  procedure Ejecutar( const AForm: TComponent; const ASincroTodoResult: RSincroTodoResumen );

implementation

{$R *.dfm}

uses CVariables, SincroResumenQD, bTextUtils, UDMConfig;

procedure Ejecutar( const AForm: TComponent; const ASincroTodoResult: RSincroTodoResumen );
var
  FDSincroTodoResumen: TFDSincroTodoResumen;
begin
  FDSincroTodoResumen:= TFDSincroTodoResumen.Create( AForm );
  FDSincroTodoResumen.AResumen:= ASincroTodoResult;
  FDSincroTodoResumen.Configurar;
  FDSincroTodoResumen.MostrarResultado;
  FDSincroTodoResumen.bSalir:= true;
  try
    FDSincroTodoResumen.ShowModal;
  finally
    FreeAndNil( FDSincroTodoResumen );
  end;
end;

procedure TFDSincroTodoResumen.Configurar;
begin
  cbxEntradas.Checked:=  ( AResumen.REntrada.registros > 0 );
  cbxEscandallos.Checked:=  ( AResumen.REscandallo.registros > 0 );
  cbxSalidas.Checked:=  ( AResumen.RSalidas.registros > 0 );
  cbxTransitos.Checked:=  ( AResumen.RTransitos.registros > 0 );
  cbxInventarios.Checked:=  ( AResumen.RInventarios.registros > 0 );
  cbxConfeccionado.Checked:=  ( AResumen.RConfeccionado.registros > 0 );

  cbxEntradas.Enabled:= cbxEntradas.Checked;
  cbxEscandallos.Enabled:= cbxEscandallos.Checked;
  cbxSalidas.Enabled:= cbxSalidas.Checked;
  cbxTransitos.Enabled:= cbxTransitos.Checked;
  cbxInventarios.Enabled:= cbxInventarios.Checked;
  cbxConfeccionado.Enabled:= cbxConfeccionado.Checked;
end;

procedure TFDSincroTodoResumen.Totales;
begin
  registros:= 0;
  pasados:= 0;
  erroneos:= 0;
  duplicados:= 0;

  if cbxEntradas.Checked then
  begin
    registros:= registros + AResumen.REntrada.registros;
    pasados:= pasados + AResumen.REntrada.pasados;
    erroneos:= erroneos + AResumen.REntrada.erroneos;
    duplicados:= duplicados + AResumen.REntrada.duplicados;
  end;

  if cbxEscandallos.Checked then
  begin
    registros:= registros + AResumen.REscandallo.registros;
    pasados:= pasados + AResumen.REscandallo.pasados;
    erroneos:= erroneos + AResumen.REscandallo.erroneos;
    duplicados:= duplicados + AResumen.REscandallo.duplicados;
  end;

  if cbxSalidas.Checked then
  begin
    registros:= registros + AResumen.RSalidas.registros;
    pasados:= pasados + AResumen.RSalidas.pasados;
    erroneos:= erroneos + AResumen.RSalidas.erroneos;
    duplicados:= duplicados + AResumen.RSalidas.duplicados;
  end;

  if cbxTransitos.Checked then
  begin
    registros:= registros + AResumen.RTransitos.registros;
    pasados:= pasados + AResumen.RTransitos.pasados;
    erroneos:= erroneos + AResumen.RTransitos.erroneos;
    duplicados:= duplicados + AResumen.RTransitos.duplicados;
  end;

  if cbxInventarios.Checked then
  begin
    registros:= registros + AResumen.RInventarios.registros;
    pasados:= pasados + AResumen.RInventarios.pasados;
    erroneos:= erroneos + AResumen.RInventarios.erroneos;
    duplicados:= duplicados + AResumen.RInventarios.duplicados;
  end;

  if cbxConfeccionado.Checked then
  begin
    registros:= registros + AResumen.RConfeccionado.registros;
    pasados:= pasados + AResumen.RConfeccionado.pasados;
    erroneos:= erroneos + AResumen.RConfeccionado.erroneos;
    duplicados:= duplicados + AResumen.RConfeccionado.duplicados;
  end;
end;

procedure TFDSincroTodoResumen.TablaCruzada( var ACuerpo: TStringList );
var
  slAux: TStringList;
  sAux: String;
begin
  slAux:= TStringList.Create;
  sAux:='';

  if cbxEntradas.Checked then
  begin
    sAux:= RellenaDer('ENTRADAS',15);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.REntrada.pasados ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.REntrada.erroneos ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.REntrada.duplicados ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.REntrada.registros ), 10);
    slAux.Add( sAux );
  end;

  if cbxEscandallos.Checked then
  begin
    sAux:= RellenaDer('ESCANDALLO',15);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.REscandallo.pasados ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.REscandallo.erroneos ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.REscandallo.duplicados ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.REscandallo.registros ), 10);
    slAux.Add( sAux );
  end;

  if cbxSalidas.Checked then
  begin
    sAux:= RellenaDer('SALIDAS',15);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.RSalidas.pasados ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.RSalidas.erroneos ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.RSalidas.duplicados ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.RSalidas.registros ), 10);
    slAux.Add( sAux );
  end;

  if cbxTransitos.Checked then
  begin
    sAux:= RellenaDer('TRÁNSITOS',15);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.RTransitos.pasados ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.RTransitos.erroneos ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.RTransitos.duplicados ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.RTransitos.registros ), 10);
    slAux.Add( sAux );
  end;

  if cbxInventarios.Checked then
  begin
    sAux:= RellenaDer('INVENTARIOS',15);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.RInventarios.pasados ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.RInventarios.erroneos ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.RInventarios.duplicados ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.RInventarios.registros ), 10);
    slAux.Add( sAux );
  end;

  if cbxConfeccionado.Checked then
  begin
    sAux:= RellenaDer('CONFECCIONADO',15);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.RConfeccionado.pasados ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.RConfeccionado.erroneos ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.RConfeccionado.duplicados ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( AResumen.RConfeccionado.registros ), 10);
    slAux.Add( sAux );
  end;

  if slAux.Count > 2 then
  begin
    ACuerpo.AddStrings( slAux );
  end;
  FreeAndNil( slAux );
end;

procedure TFDSincroTodoResumen.PasadosMsg( var ACuerpo: TStringList );
begin
  if ( pasados > 0 ) and cbxPasados.Checked then
  begin
    ACuerpo.Add('');
    ACuerpo.Add('REGISTROS PASADOS');
    ACuerpo.Add('-----------------');

    if cbxEntradas.Checked and ( AResumen.REntrada.pasados > 0 )then
    begin
      ACuerpo.Add('** ENTRADAS PASADAS **');
      ACuerpo.AddStrings(AResumen.REntrada.msgPasados);
      ACuerpo.Add('');
    end;

    if cbxEscandallos.Checked and ( AResumen.REscandallo.pasados > 0 )then
    begin
      ACuerpo.Add('** ESCANDALLOS PASADOS **');
      ACuerpo.AddStrings(AResumen.REscandallo.msgPasados);
      ACuerpo.Add('');
    end;

    if cbxSalidas.Checked and ( AResumen.RSalidas.pasados > 0 )then
    begin
      ACuerpo.Add('** SALIDAS PASADAS **');
      ACuerpo.AddStrings(AResumen.RSalidas.msgPasados);
      ACuerpo.Add('');
    end;

    if cbxTransitos.Checked and ( AResumen.RTransitos.pasados > 0 )then
    begin
      ACuerpo.Add('** TRÁNSITOS PASADOS **');
      ACuerpo.AddStrings(AResumen.RTransitos.msgPasados);
      ACuerpo.Add('');
    end;

    if cbxInventarios.Checked and ( AResumen.RInventarios.pasados > 0 )then
    begin
      ACuerpo.Add('** INVENTARIOS PASADOS **');
      ACuerpo.AddStrings(AResumen.RInventarios.msgPasados);
      ACuerpo.Add('');
    end;

    if cbxConfeccionado.Checked and ( AResumen.RConfeccionado.pasados > 0 )then
    begin
      ACuerpo.Add('** CONFECCIONADO PASADO **');
      ACuerpo.AddStrings(AResumen.RConfeccionado.msgPasados);
      ACuerpo.Add('');
    end;
  end;
end;

procedure TFDSincroTodoResumen.ErroneosMsg( var ACuerpo: TStringList );
begin
  if ( erroneos > 0 ) and cbxErroneos.Checked then
  begin
    ACuerpo.Add('');
    ACuerpo.Add('REGISTROS ERRONEOS');
    ACuerpo.Add('------------------');

    if cbxEntradas.Checked and ( AResumen.REntrada.erroneos > 0 )then
    begin
      ACuerpo.Add('** ENTRADAS ERRONEAS **');
      ACuerpo.AddStrings(AResumen.REntrada.msgErrores);
      ACuerpo.Add('');
    end;

    if cbxEscandallos.Checked and ( AResumen.REscandallo.erroneos > 0 )then
    begin
      ACuerpo.Add('** ESCANDALLOS ERRONEOS **');
      ACuerpo.AddStrings(AResumen.REscandallo.msgErrores);
      ACuerpo.Add('');
    end;

    if cbxSalidas.Checked and ( AResumen.RSalidas.erroneos > 0 )then
    begin
      ACuerpo.Add('** SALIDAS ERRONEAS **');
      ACuerpo.AddStrings(AResumen.RSalidas.msgErrores);
      ACuerpo.Add('');
    end;

    if cbxTransitos.Checked and ( AResumen.RTransitos.erroneos > 0 )then
    begin
      ACuerpo.Add('** TRÁNSITOS ERRONEOS **');
      ACuerpo.AddStrings(AResumen.RTransitos.msgErrores);
      ACuerpo.Add('');
    end;

    if cbxInventarios.Checked and ( AResumen.RInventarios.erroneos > 0 )then
    begin
      ACuerpo.Add('** INVENTARIOS ERRONEOS **');
      ACuerpo.AddStrings(AResumen.RInventarios.msgErrores);
      ACuerpo.Add('');
    end;

    if cbxConfeccionado.Checked and ( AResumen.RConfeccionado.erroneos > 0 )then
    begin
      ACuerpo.Add('** CONFECCIONADO ERRONEO **');
      ACuerpo.AddStrings(AResumen.RConfeccionado.msgErrores);
      ACuerpo.Add('');
    end;
  end;
end;

procedure TFDSincroTodoResumen.DuplicadosMsg( var ACuerpo: TStringList );
begin
  if ( duplicados > 0 ) and cbxDuplicados.Checked then
  begin
    ACuerpo.Add('');
    ACuerpo.Add('REGISTROS DUPLICADOS');
    ACuerpo.Add('--------------------');

    if cbxEntradas.Checked and ( AResumen.REntrada.duplicados > 0 )then
    begin
      ACuerpo.Add('** ENTRADAS DUPLICADAS **');
      ACuerpo.AddStrings(AResumen.REntrada.msgDuplicados);
      ACuerpo.Add('');
    end;

    if cbxEscandallos.Checked and ( AResumen.REscandallo.duplicados > 0 )then
    begin
      ACuerpo.Add('** ESCANDALLOS DUPLICADOS **');
      ACuerpo.AddStrings(AResumen.REscandallo.msgDuplicados);
      ACuerpo.Add('');
    end;

    if cbxSalidas.Checked and ( AResumen.RSalidas.duplicados > 0 )then
    begin
      ACuerpo.Add('** SALIDAS DUPLICADAS **');
      ACuerpo.AddStrings(AResumen.RSalidas.msgDuplicados);
      ACuerpo.Add('');
    end;

    if cbxTransitos.Checked and ( AResumen.RTransitos.duplicados > 0 )then
    begin
      ACuerpo.Add('** TRÁNSITOS DUPLICADOS **');
      ACuerpo.AddStrings(AResumen.RTransitos.msgDuplicados);
      ACuerpo.Add('');
    end;

    if cbxInventarios.Checked and ( AResumen.RInventarios.duplicados > 0 )then
    begin
      ACuerpo.Add('** INVENTARIOS DUPLICADOS **');
      ACuerpo.AddStrings(AResumen.RInventarios.msgDuplicados);
      ACuerpo.Add('');
    end;

    if cbxConfeccionado.Checked and ( AResumen.RConfeccionado.duplicados > 0 )then
    begin
      ACuerpo.Add('** CONFECCIONADO DUPLICADO **');
      ACuerpo.AddStrings(AResumen.RConfeccionado.msgDuplicados);
      ACuerpo.Add('');
    end;
  end;
end;

procedure TFDSincroTodoResumen.MostrarResultado;
var
  sResultado: TStringList;
  i: integer;
  sAux: string;
begin
  Totales;

  mmoResumen.Lines.Clear;
  lblEstado.Caption:= AResumen.titulo;
  sResultado:= TStringList.Create;
  try
    i:= length( AResumen.titulo );
    sAux:= '';
    for i:= 1 to i do
      sAux:= sAux + '-';
    sResultado.Add('- ' + AResumen.titulo + ' -');
    sResultado.Add('--' + sAux + '--');
    sResultado.Add('USUARIO      = ' + AResumen.Usuario );
    sResultado.Add('HORA         = ' + AResumen.Hora );

    sResultado.Add('');
    sResultado.Add('                  PASADOS  ERRONEOS DUPLICAD.   TOTALES');
    sResultado.Add('--------------- --------- --------- --------- ---------');

    TablaCruzada( sResultado );

    sResultado.Add('--------------- --------- --------- --------- ---------');
    sAux:= RellenaDer('TOTALES',15);
    sAux:= sAux + RellenaIzq( IntToStr( pasados ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( erroneos ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( duplicados ), 10);
    sAux:= sAux + RellenaIzq( IntToStr( registros ), 10);
    sResultado.Add( sAux );
    sResultado.Add('');

    PasadosMsg( sResultado );
    ErroneosMsg( sResultado );
    DuplicadosMsg( sResultado );

    mmoResumen.Lines.AddStrings( sResultado );
  finally
    FreeAndNil( sResultado );
  end;
end;

procedure TFDSincroTodoResumen.btnCerrarClick(Sender: TObject);
begin
  if bSalir then Close;
end;

procedure TFDSincroTodoResumen.btnEnviarClick(Sender: TObject);
var
 sAux: string;
begin
  sAux:= lblEstado.Caption;
  bSalir:= false;
  btnCerrar.Enabled:= False;
  btnEnviar.Enabled:= False;
  btnImprimir.Enabled:= False;
  try
    try
      IdSMTP.Connect;
      Screen.Cursor := crHourGlass;
      lblEstado.Caption := 'Enviando mensaje';
      IdMessage.From.Address := gsCuentaCorreo;
      IdMessage.From.Name := gsNombre;
      IdMessage.ReplyTo.EMailAddresses := gsDirCorreo;
      IdMessage.Recipients.Add.Address:= 'pepebrotons@bonnysa.es';
      IdMessage.Subject := sAux;
      IdMessage.Body.AddStrings( mmoResumen.Lines );
      IdSMTP.Send(IdMessage);
    finally
      IdSMTP.Disconnect;
      btnCerrar.Enabled:= True;
      btnImprimir.Enabled:= True;
      bSalir:= true;
      Screen.Cursor := crDefault;
    end;
    lblEstado.Caption := 'Mensaje enviado correctamente.';
  except
    lblEstado.Caption := '';
    raise;
  end;
end;

procedure TFDSincroTodoResumen.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_escape then Close;
end;

procedure TFDSincroTodoResumen.btnImprimirClick(Sender: TObject);
begin
  SincroResumenQD.Ejecutar( self, mmoResumen.Lines );
end;

procedure TFDSincroTodoResumen.cbxPasadosClick(Sender: TObject);
begin
  MostrarResultado;
end;

procedure TFDSincroTodoResumen.FormCreate(Sender: TObject);
begin
  if DMConfig.EsLasMoradas then
  begin
    cbxEscandallos.Visible:= True;
    cbxConfeccionado.Visible:= True;
  end
  else
  begin
    cbxEscandallos.Visible:= False;
    cbxConfeccionado.Visible:= False;
  end;
end;

end.

