unit MSincronizacionWeb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TFMSincronizacionWeb = class(TForm)
    btnCerrar: TBitBtn;
    pb: TProgressBar;
    lblProgreso: TLabel;
    btnSincronizar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnSincronizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

    procedure ProgressUpdate(Sender: Tobject; Index: Integer; Total: Integer);
    procedure WorkDone(Sender: TObject);

  public
    { Public declarations }
  end;

var
  FMSincronizacionWeb: TFMSincronizacionWeb;

implementation

uses
  CVariables,
  CGestionPrincipal,
  Principal,
  SincronizacionBonny;

{$R *.dfm}

procedure TFMSincronizacionWeb.btnCerrarClick(Sender: TObject);
begin
  Close
end;

procedure TFMSincronizacionWeb.btnSincronizarClick(Sender: TObject);
begin
  btnSincronizar.Enabled := False;
  btnCerrar.Enabled := False;

  SincroBonnyAurora.CargarPendientes;
  SincroBonnyAurora.OnProgressUpdate := ProgressUpdate;
  SincroBonnyAurora.OnWorkDone := WorkDone;
  SincroBonnyAurora.Sincronizar;
end;

procedure TFMSincronizacionWeb.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  SincroBonnyAurora.OnProgressUpdate := nil;
  SincroBonnyAurora.OnWorkDone := nil;

  Action := caFree;
end;

procedure TFMSincronizacionWeb.FormCreate(Sender: TObject);
begin
  M := nil;
  MD := nil;

  FormType := tfOther;
  BHFormulario;
end;

procedure TFMSincronizacionWeb.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  case key of
    vk_Return, vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
  end;
end;

procedure TFMSincronizacionWeb.FormShow(Sender: TObject);
begin
  lblProgreso.Caption := ''; 
end;

procedure TFMSincronizacionWeb.ProgressUpdate(Sender: Tobject; Index, Total: Integer);
begin
  pb.Max := Total;
  pb.Position := Index;
  lblProgreso.Caption := Format('Procesados %d de %d', [ Index, Total ]);
end;

procedure TFMSincronizacionWeb.WorkDone(Sender: TObject);
begin
  btnSincronizar.Enabled := True;
  btnCerrar.Enabled := True;
end;

end.
