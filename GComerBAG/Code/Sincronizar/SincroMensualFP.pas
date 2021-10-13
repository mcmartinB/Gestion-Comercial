unit SincroMensualFP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, ExtCtrls;

type
  TFPSincroMensual = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    pSincronizar: TPanel;
    lblEmpresa: TnbLabel;
    edtEmpresa: TBEdit;
    etqEmpresa: TnbStaticText;
    edtAnyo: TBEdit;
    lblFechaDesde: TnbLabel;
    lblFechaHasta: TnbLabel;
    edtMes: TBEdit;
    lblEtiqueta: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    iTipo: integer;
  public
    { Public declarations }
    constructor NewCreate( AOwner: TComponent; const ATipo: integer );

    procedure Ejecutar;
    function  ValidarEntrada: Boolean;
  end;

  procedure CrearVentana(const AForm: TForm; const ATipo: integer );

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils, DB,
     SincroVarUNT, SincroMensualMasterUNT, SincroResumenFD;

procedure CrearVentana(const AForm: TForm; const ATipo: integer );
var
  i: Integer;
begin
  for i := AForm.MDIChildCount - 1 downto 0 do
  begin
    if AForm.MDIChildren[i].ClassType = TFPSincroMensual then
    begin
      AForm.MDIChildren[i].Show;
      Exit;
    end;
  end;

  //Para que los form maximizados aparezcan desde el inicio maximizados
  LockWindowUpdate(AForm.Handle);
  try
    TFPSincroMensual.NewCreate(Application, ATipo);
  finally
    LockWindowUpdate(0);
  end;
end;

constructor TFPSincroMensual.NewCreate( AOwner: TComponent; const ATipo: integer );
begin
  inherited Create( AOwner );
  iTipo:= ATipo;
  case iTipo of
    kSCostesEnvase:
    begin
      Caption:= 'COSTES ENVASE';
      lblEtiqueta.Caption:= 'Sincronizar Costes del artículo ...';
    end;
  end;
end;

procedure TFPSincroMensual.FormCreate(Sender: TObject);
var
  anyo, mes, dia: word;
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Text:= gsDefEmpresa;
  DecodeDate( Date, anyo, mes, dia );
  edtAnyo.Text := IntToStr( anyo );
  edtMes.Text := IntToStr( mes );
end;

procedure TFPSincroMensual.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFPSincroMensual.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFPSincroMensual.FormShow(Sender: TObject);
var SAux: String;
begin
  sAux := Valortmensajes;
  if sAux <> '' then
  begin
    ShowMessage(SAux);
    btnAceptar.Enabled := false;
  end
  else
    btnAceptar.enabled := true;
end;

procedure TFPSincroMensual.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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
    vk_escape:
      begin
        btnCancelar.Click;
      end;
    vk_f1:
      begin
        btnAceptar.Click;
      end;
  end;
end;

procedure TFPSincroMensual.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

function TFPSincroMensual.ValidarEntrada: Boolean;
var
  iMes: integer;
begin
  result := false;

  //El codigo de empresa es obligatorio
  if Trim( etqEmpresa.Caption ) = '' then
  begin
    edtEmpresa.SetFocus;
    ShowMessage('Falta código de empresa o es incorrecto.');
    Exit;
  end;

  if Trim( edtAnyo.Text ) = '' then
  begin
    edtAnyo.SetFocus;
    ShowMessage('El año es de obligada inserción.');
    Exit;
  end;

  if Trim( edtMes.Text ) = '' then
  begin
    edtMes.SetFocus;
    ShowMessage('El mes es de obligada inserción.');
    Exit;
  end;
  iMes:= StrToInt( edtMes.Text );
  if ( iMes < 1 ) or ( iMes > 12 ) then
  begin
    edtMes.SetFocus;
    ShowMessage('Mes incorrecto.');
    Exit;
  end;
  result := true;
end;

procedure TFPSincroMensual.Ejecutar;
var
  SincroResult: RSincroResumen;
begin
  if ValidarEntrada then
  begin
    InicializarResumenSincronizar( sincroresult );
    sincroresult.usuario:= UpperCase( gsCodigo ) + ' - ' + gsNombre;
    sincroresult.hora:= DateTimeToStr( Now );

    SincroResult:= SincroMensualMasterUNT.SincronizarRegistros( edtEmpresa.Text, StrToInt( edtAnyo.Text ), StrToInt( edtMes.Text ),
                                 lblEtiqueta.Caption, iTipo );

    SincroResumenFD.Ejecutar( self, SincroResult );
    LiberarResumenSincronizar( sincroresult );
  end;
end;

procedure TFPSincroMensual.btnAceptarClick(Sender: TObject);
begin
  Ejecutar;
end;

procedure TFPSincroMensual.edtEmpresaChange(Sender: TObject);
begin
  etqEmpresa.Caption:= desEmpresa(edtEmpresa.Text);
end;

end.


