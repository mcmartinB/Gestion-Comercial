unit SincronizarProductosFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFDSincronizarProductos = class(TForm)
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
    procedure SincronizarProductos;
    procedure BorrarProductos;
    procedure InsertarProductos;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses WEBDM, bSQLUtils;

procedure TFDSincronizarProductos.BorrarProductos;
begin
  DMWEB.QProductosWEBRemoto.Open;
  DMWEB.QProductosWEBRemoto.First;
  while not DMWEB.QProductosWEBRemoto.Eof do
  begin
    DMWEB.QProductosWEBRemoto.Delete;
  end;
  DMWEB.QProductosWEBRemoto.Close;
end;

procedure TFDSincronizarProductos.InsertarProductos;
begin
  DMWEB.QProductosWEBRemoto.Open;
  DMWEB.QProductosWEBLocal.Open;
  DMWEB.QProductosWEBLocal.First;
  while not DMWEB.QProductosWEBLocal.Eof do
  begin
    DMWEB.QProductosWEBRemoto.Insert;

    DMWEB.QProductosWEBRemotoproducto_pw.AsString:= DMWEB.QProductosWEBLocalproducto_wpd.AsString;
    DMWEB.QProductosWEBRemotoidioma_pw.AsString:= DMWEB.QProductosWEBLocalidioma_wpd.AsString;
    DMWEB.QProductosWEBRemotodescripcion_pw.AsString:= DMWEB.QProductosWEBLocaldescripcion_wpd.AsString;

    DMWEB.QProductosWEBRemoto.Post;
    DMWEB.QProductosWEBLocal.Next;
  end;
  DMWEB.QProductosWEBLocal.Close;
  DMWEB.QProductosWEBRemoto.Close;

end;

procedure TFDSincronizarProductos.SincronizarProductos;
begin
  lblMensaje.Caption:= 'Borrando Productos web de internet ...';
  Application.ProcessMessages;
  BorrarProductos;
  lblMensaje.Caption:= 'Insertando Productos web de internet ...';
  Application.ProcessMessages;
  InsertarProductos;
end;

procedure TFDSincronizarProductos.btnBajarClick(Sender: TObject);
begin
  try
    SincronizarProductos;
    lblMensaje.Caption:= 'Sincronización finalizada con éxito.';
  except
    lblMensaje.Caption:= 'Sincronización finalizada con errores.';
    raise;
  end;
end;

procedure TFDSincronizarProductos.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFDSincronizarProductos.FormActivate(Sender: TObject);
begin
  if bPrimeraVez then
  begin
    bPrimeraVez:= False;
    if DMWEB = nil then
    begin
      DMWEB:= TDMWEB.Create( self );
      bLiberarDMWEB:= True;
    end
    else
    begin
      bLiberarDMWEB:= False;
    end;
    try
      DMWEB.BDWeb.Connected:= true;
    except
      ShowMessage('ERROR: No puedo conectar con la Base de Datos Remota.');
    end;
    btnBajar.Enabled:= True;
  end;
end;

procedure TFDSincronizarProductos.FormCreate(Sender: TObject);
begin
  bPrimeraVez:= true;
end;

procedure TFDSincronizarProductos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ( DMWEB <> nil ) and bLiberarDMWEB then
  begin
    FreeAndNil( DMWEB );
  end;
end;

end.

