unit CFDResultadoEnvio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdMessage, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdMessageClient, IdSMTP, CUPEnviar;

type
  TFPResultadoEnvio = class(TForm)
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
    procedure btnCerrarClick(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure cbxPasadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    AResumen: RSincroResumen;
    bSalir: Boolean;
    procedure MostrarResultado;
  public
    { Public declarations }
  end;

  procedure Ejecutar( const AForm: TComponent; const ASincroResult: RSincroResumen );

implementation

{$R *.dfm}

uses CVariables, CRDResultadoEnvio;

procedure Ejecutar( const AForm: TComponent; const ASincroResult: RSincroResumen );
var
  FPResultadoEnvio: TFPResultadoEnvio;
begin
  FPResultadoEnvio:= TFPResultadoEnvio.Create( AForm );
  FPResultadoEnvio.AResumen:= ASincroResult;
  FPResultadoEnvio.MostrarResultado;
  FPResultadoEnvio.bSalir:= true;
  try
    FPResultadoEnvio.ShowModal;
  finally
    FreeAndNil( FPResultadoEnvio );
  end;
end;

procedure TFPResultadoEnvio.MostrarResultado;
var
  sResultado: TStringList;
  i: integer;
  sAux: string;
begin
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
    sResultado.Add('REGISTROS    = ' + IntToStr( AResumen.registros ));
    sResultado.Add('');
    sResultado.Add('PASADOS      = ' + IntToStr( AResumen.pasados ));
    sResultado.Add('ERRONEOS     = ' + IntToStr( AResumen.erroneos ));
    sResultado.Add('DUPLICADOS   = ' + IntToStr( AResumen.duplicados ));

    if ( AResumen.pasados > 0 ) and cbxPasados.Checked then
    begin
      sResultado.Add('');
      sResultado.Add('REGISTROS PASADOS');
      sResultado.Add('-----------------');
      sResultado.AddStrings(AResumen.msgPasados);
    end;

    if ( AResumen.erroneos > 0 ) and cbxErroneos.Checked then
    begin
      sResultado.Add('');
      sResultado.Add('REGISTROS ERRONEOS');
      sResultado.Add('------------------');
      sResultado.AddStrings(AResumen.msgErrores);
    end;

    if ( AResumen.duplicados > 0 ) and cbxDuplicados.Checked then
    begin
      sResultado.Add('');
      sResultado.Add('REGISTROS DUPLICADOS');
      sResultado.Add('--------------------');
      sResultado.AddStrings(AResumen.msgDuplicados);
    end;

    mmoResumen.Lines.AddStrings( sResultado );
  finally
    FreeAndNil( sResultado );
  end;
end;

procedure TFPResultadoEnvio.btnCerrarClick(Sender: TObject);
begin
  if bSalir then Close;
end;

procedure TFPResultadoEnvio.btnEnviarClick(Sender: TObject);
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

procedure TFPResultadoEnvio.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_escape then Close;
end;

procedure TFPResultadoEnvio.btnImprimirClick(Sender: TObject);
begin
  CRDResultadoEnvio.Ejecutar( self, mmoResumen.Lines );
end;

procedure TFPResultadoEnvio.cbxPasadosClick(Sender: TObject);
begin
  MostrarResultado;
end;

procedure TFPResultadoEnvio.FormCreate(Sender: TObject);
begin
  IdSMTP.Host:= gsHostCorreo;
  IdSMTP.UserId:= gsUsarioCorreo;
  IdSMTP.Password:= gsClaveCorreo;
end;

end.

