unit SincronizarClientesFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFDSincronizarClientes = class(TForm)
    btnBajar: TButton;
    btnCerrar: TButton;
    lblMensaje: TLabel;
    procedure btnBajarClick(Sender: TObject);
    procedure btnCerrarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    bPrimeraVez, bLiberarDMWEB: Boolean;
    procedure SincronizarClientes;
    procedure BorrarClientes;
    procedure InsertarClientes;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses WEBDM, bSQLUtils;

procedure TFDSincronizarClientes.BorrarClientes;
begin
  DMWEB.QClientesWEBRemoto.Open;
  DMWEB.QClientesWEBRemoto.First;
  while not DMWEB.QClientesWEBRemoto.Eof do
  begin
    DMWEB.QClientesWEBRemoto.Delete;
  end;
  DMWEB.QClientesWEBRemoto.Close;
end;

procedure TFDSincronizarClientes.InsertarClientes;
begin
  DMWEB.QClientesWEBRemoto.Open;
  DMWEB.QClientesWEBLocal.Open;
  DMWEB.QClientesWEBLocal.First;
  while not DMWEB.QClientesWEBLocal.Eof do
  begin
    DMWEB.QClientesWEBRemoto.Insert;

    DMWEB.QClientesWEBRemotousuario_cw.AsString:= DMWEB.QClientesWEBLocalusuario_wcl.AsString;
    DMWEB.QClientesWEBRemotopassword_cw.AsString:= DMWEB.QClientesWEBLocalpassword_wcl.AsString;
    DMWEB.QClientesWEBRemotocliente_cw.AsString:= DMWEB.QClientesWEBLocalcliente_wcl.AsString;
    DMWEB.QClientesWEBRemotonombre_cliente_cw.AsString:= DMWEB.QClientesWEBLocalnombre_cliente_wcl.AsString;
    DMWEB.QClientesWEBRemotonombre_usuario_cw.AsString:= DMWEB.QClientesWEBLocalnombre_usuario_wcl.AsString;
    DMWEB.QClientesWEBRemotoemail_cw.AsString:= DMWEB.QClientesWEBLocalemail_wcl.AsString;
    DMWEB.QClientesWEBRemotoidioma_cw.AsString:= DMWEB.QClientesWEBLocalidioma_wcl.AsString;

    DMWEB.QClientesWEBRemoto.Post;
    DMWEB.QClientesWEBLocal.Next;
  end;
  DMWEB.QClientesWEBLocal.Close;
  DMWEB.QClientesWEBRemoto.Close;
end;

procedure TFDSincronizarClientes.SincronizarClientes;
begin
  lblMensaje.Caption:= 'Borrando clientes web de internet ...';
  Application.ProcessMessages;
  BorrarClientes;
  lblMensaje.Caption:= 'Insertando clientes web de internet ...';
  Application.ProcessMessages;
  InsertarClientes;
end;

procedure TFDSincronizarClientes.btnBajarClick(Sender: TObject);
begin
  try
    SincronizarClientes;
    lblMensaje.Caption:= 'Sincronización finalizada con éxito.';
  except
    lblMensaje.Caption:= 'Sincronización finalizada con errores.';
    raise;
  end;
end;

procedure TFDSincronizarClientes.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFDSincronizarClientes.FormActivate(Sender: TObject);
begin
  if bPrimeraVez then
  begin
    bPrimeraVez:= False;
    if DMWEB = nil then
    begin
      DMWEB:= TDMWEB.Create( self );
      bLiberarDMWEB:= true;
    end
    else
    begin
      bLiberarDMWEB:= false;
    end;
    try
      DMWEB.BDWeb.Connected:= true;
    except
      ShowMessage('ERROR: No puedo conectar con la Base de Datos Remota.');
    end;
    btnBajar.Enabled:= True;
  end;
end;

procedure TFDSincronizarClientes.FormCreate(Sender: TObject);
begin
  bPrimeraVez:= true;
end;

procedure TFDSincronizarClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ( DMWEB <> nil ) and ( bLiberarDMWEB ) then
  begin
    FreeAndNil( DMWEB );
  end;
end;

end.

