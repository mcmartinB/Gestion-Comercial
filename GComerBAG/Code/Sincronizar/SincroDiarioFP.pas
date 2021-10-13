(* CAMBIAR
   SincroDiarioFP, FLSincronizarDiario
   RParametrosSincronizarDiario
*)
unit SincroDiarioFP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, ExtCtrls, ComCtrls, DB,
  DBTables;

type
  TFPSincroDiario = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    pSincronizar: TPanel;
    lblEmpresa: TnbLabel;
    edtEmpresa: TBEdit;
    etqEmpresa: TnbStaticText;
    edtFechaDesde: TBEdit;
    lblFechaDesde: TnbLabel;
    lblFechaHasta: TnbLabel;
    edtFechaHasta: TBEdit;
    lblEtiqueta: TLabel;
    BarraProgreso: TProgressBar;
    lblCentro: TnbLabel;
    edtCentro: TBEdit;
    etqCentro: TnbStaticText;
    QCentral: TQuery;
    QLocal: TQuery;
    lblDocumento: TnbLabel;
    edtDocumento: TBEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure edtCentroChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    iTipo, iDocumento: integer;
    desde, hasta: TDate;

  public
    { Public declarations }
    constructor NewCreate( AOwner: TComponent; const ATipo: integer );

    procedure Ejecutar;
    function  ValidarEntrada: Boolean;
  end;

  procedure CrearVentana(const AForm: TForm; const ATipo: integer );

implementation

{$R *.dfm}

uses UDMAuxDB, UDMBaseDatos, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     SincroVarUNT, SincroDiarioMDetailUNT, SincroResumenFD,
     UDMConfig, SincroDiarioMasterUNT;

procedure CrearVentana(const AForm: TForm; const ATipo: integer );
var
  i: Integer;
begin
  for i := AForm.MDIChildCount - 1 downto 0 do
  begin
    if AForm.MDIChildren[i].ClassType = TFPSincroDiario then
    begin
      AForm.MDIChildren[i].Show;
      Exit;
    end;
  end;

  //Para que los form maximizados aparezcan desde el inicio maximizados
  LockWindowUpdate(AForm.Handle);
  try
    TFPSincroDiario.NewCreate(Application, ATipo);
  finally
    LockWindowUpdate(0);
  end;
end;

constructor TFPSincroDiario.NewCreate( AOwner: TComponent; const ATipo: integer );
begin
  inherited Create( AOwner );
  iTipo:= ATipo;
  case iTipo of
    kSSalidas:
    begin
      lblEtiqueta.Caption:= 'Sincronizar Salidas  ...';
      lblDocumento.Caption:= 'Num. Albarán';
    end;
    kSTransitos:
    begin
      lblEtiqueta.Caption:= 'Sincronizar Tránsitos  ...';
      lblDocumento.Caption:= 'Num. Tránsito';
    end;
    kSPedidos:
    begin
      lblEtiqueta.Caption:= 'Sincronizar Pedidos  ...';
      lblDocumento.Caption:= 'Num. Pedido';
    end;
    kSincroDesgloseSal:
    begin
      lblEtiqueta.Caption:= 'Sincronizar Desglose de Salidas  ...';
    end;
  end;
  Caption:= UpperCase( lblEtiqueta.Caption );
end;

procedure TFPSincroDiario.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Text:= gsDefEmpresa;
  etqCentro.Caption:= 'TODOS LOS CENTROS';
  edtFechaDesde.Text := DateToStr(Date - 1);
  edtFechaHasta.Text := DateToStr(Date - 1);
end;

procedure TFPSincroDiario.FormClose(Sender: TObject;
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

procedure TFPSincroDiario.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFPSincroDiario.FormShow(Sender: TObject);
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

procedure TFPSincroDiario.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFPSincroDiario.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

function TFPSincroDiario.ValidarEntrada: Boolean;
begin
  result := false;

  //El codigo de empresa es obligatorio
  //El codigo de empresa es obligatorio
  if Trim( etqEmpresa.Caption ) = '' then
  begin
    edtEmpresa.SetFocus;
    ShowMessage('Falta código de empresa o es incorrecto.');
    Exit;
  end;

  //Comprobar que las fechas sean correctas
  try
    desde := StrToDate(edtFechaDesde.Text);
  except
    edtFechaDesde.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;
  try
    hasta := StrToDate(edtFechaHasta.Text);
  except
    edtFechaHasta.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;

  //Comprobar que el rango sea correcto
  if desde > hasta then
  begin
    edtFechaDesde.SetFocus;
    ShowMessage('Rango de fechas incorrecto.');
    Exit;
  end;

  iDocumento:= StrToIntDef( edtDocumento.Text, -1 );

  result := true;
end;

procedure TFPSincroDiario.Ejecutar;
var
  SincroResult: RSincroResumen;
begin
  if ValidarEntrada then
  begin

    InicializarResumenSincronizar( sincroresult );
    AsignarBarraProgreso( BarraProgreso );

    sincroresult.usuario:= UpperCase( gsCodigo ) + ' - ' + gsNombre;
    sincroresult.hora:= DateTimeToStr( Now );

    case iTipo of
      //comprobar liquida en central;
      kSSalidas, kSTransitos,
      kSEntregas, kSPedidos:
        SincroResult:= SincroDiarioMDetailUNT.SincronizarRegistros( edtEmpresa.Text, edtCentro.Text, iDocumento, desde, hasta,
                                 lblEtiqueta.Caption, iTipo );
      kSincroDesgloseSal:
        SincroResult:= SincroDiarioMasterUNT.SincronizarDesgloseSal( edtEmpresa.Text, edtCentro.Text, '', StrToDate( edtFechaDesde.Text ), StrToDate( edtFechaHasta.Text ),  '',
                                 lblEtiqueta.Caption, iTipo );
    end;

    SincroResumenFD.Ejecutar( self, SincroResult );

    LiberarBarraProgreso;
    LiberarResumenSincronizar( sincroresult );
  end;
end;

procedure TFPSincroDiario.btnAceptarClick(Sender: TObject);
begin
  Ejecutar;
end;

procedure TFPSincroDiario.edtEmpresaChange(Sender: TObject);
begin
  etqEmpresa.Caption:= desEmpresa(edtEmpresa.Text);
end;

procedure TFPSincroDiario.edtCentroChange(Sender: TObject);
begin
  if trim( edtCentro.Text ) = '' then
    etqCentro.Caption:= 'TODOS LOS CENTROS'
  else
    etqCentro.Caption:= desCentro(edtEmpresa.Text, edtCentro.Text);
end;


end.


