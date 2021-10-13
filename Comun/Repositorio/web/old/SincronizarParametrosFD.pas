unit SincronizarParametrosFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, BEdit;

type
  TFDSincronizarParametros = class(TForm)
    btnBajar: TButton;
    btnCerrar: TButton;
    edtEMail: TEdit;
    lblEmpresa: TLabel;
    lblCliente: TLabel;
    lblReclamacion: TLabel;
    Label1: TLabel;
    cbxInicializarContador: TCheckBox;
    edtDirLocal: TEdit;
    edtDirRemoto: TEdit;
    edtContador: TBEdit;
    procedure btnBajarClick(Sender: TObject);
    procedure btnCerrarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbxInicializarContadorClick(Sender: TObject);
  private
    { Private declarations }
    bPrimeraVez, bLiberarDMWEB: Boolean;
    procedure SincronizarValores;
    procedure CargarValores;
  public
    { Public declarations }
  end;

  procedure WEBParametrosExecute;

implementation

{$R *.dfm}

uses WEBDM, bSQLUtils, DB;

procedure WEBParametrosExecute;
var
  FDSincronizarParametros: TFDSincronizarParametros;
begin
  try
    FDSincronizarParametros:= TFDSincronizarParametros.Create( Application );
    FDSincronizarParametros.ShowModal;
  finally
    FreeAndNil( FDSincronizarParametros );
  end;
end;

procedure TFDSincronizarParametros.SincronizarValores;
begin
  with DMWEB do
  begin
    QParamLocal.Open;
    if QParamLocal.IsEmpty then
      QParamLocal.Insert
    else
      QParamLocal.Edit;
    QParamLocalemail_wpr.AsString:= edtEMail.Text;
    if Trim( edtContador.Text ) = '' then
      QParamLocalcontador_wpr.AsString:= ''
    else
      QParamLocalcontador_wpr.AsString:= edtContador.Text;
    QParamLocal.Post;
    QParamLocal.Close;

    QParamRemoto.Open;
    if QParamRemoto.IsEmpty then
      QParamRemoto.Insert
    else
      QParamRemoto.Edit;
    QParamRemotoemail_p.AsString:=  edtEMail.Text;
    if cbxInicializarContador.Checked then
    begin
      if Trim( edtContador.Text ) = '' then
        QParamRemotocontador_p.AsString:= ''
      else
        QParamRemotocontador_p.AsString:= edtContador.Text;
    end;
    QParamRemoto.Post;
    QParamRemoto.Close;
  end;
  cbxInicializarContador.Checked:= False;
  ShowMessage('Proceso de sincronizacion finalizado con éxito.');
end;

procedure TFDSincronizarParametros.btnBajarClick(Sender: TObject);
begin
  SincronizarValores;
end;

procedure TFDSincronizarParametros.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFDSincronizarParametros.FormActivate(Sender: TObject);
begin
  if bPrimeraVez then
  begin
    bPrimeraVez:= False;
    if DMWEB = nil then
    begin
      DMWEB:= TDMWEB.Create( self );
      bLiberarDMWEB:= true;
      CargarValores;
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

procedure TFDSincronizarParametros.FormCreate(Sender: TObject);
begin
  bPrimeraVez:= true;
end;

procedure TFDSincronizarParametros.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ( DMWEB <> nil ) and ( bLiberarDMWEB ) then
  begin
    FreeAndNil( DMWEB );
  end;
end;

procedure TFDSincronizarParametros.cbxInicializarContadorClick(
  Sender: TObject);
begin
  edtContador.Enabled:= cbxInicializarContador.Checked;
end;

procedure TFDSincronizarParametros.CargarValores;
begin
  edtDirLocal.Text:= kLocalDir;
  edtDirRemoto.Text:= kRemoteDir;
  with DMWEB do
  begin
    QParamLocal.Open;
    if not QParamLocal.IsEmpty then
    begin
      edtEMail.Text:= QParamLocalemail_wpr.AsString;
    end;
    QParamLocal.Close;

    QParamRemoto.Open;
    if not QParamRemoto.IsEmpty then
    begin
      if edtEMail.Text = '' then
        edtEMail.Text:= QParamRemotoemail_p.AsString;
      edtContador.Text:= QParamRemotocontador_p.AsString;
    end;
    QParamRemoto.Close;
  end;
end;

end.

