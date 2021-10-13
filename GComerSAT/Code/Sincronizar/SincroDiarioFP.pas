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
    lblCodigo: TnbLabel;
    edtCodigo: TBEdit;
    lblDesCodigo: TLabel;
    lblProducto: TnbLabel;
    edtProducto: TBEdit;
    txtProducto: TnbStaticText;
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
    procedure edtProductoChange(Sender: TObject);
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

uses UDMAuxDB, UDMBaseDatos, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     SincroVarUNT, SincroDiarioMasterUNT, SincroDiarioMDetailUNT, SincroResumenFD,
     UDMConfig;

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

  edtProducto.Enabled:= False;
  edtProducto.Text:= '';

  case iTipo of
    kSincroTodo:
    begin
      lblEtiqueta.Caption:= 'Sincronizar Entradas, Salidas, Transitos e Inventarios ...';
    end;
    kSincroEntradas:
    begin
      lblEtiqueta.Caption:= 'Sincronizar Entradas ...';
      edtProducto.Enabled:= True;
    end;
    kSincroEscandallos:
    begin
      lblEtiqueta.Caption:= 'Sincronizar Escandallos ...';
      edtProducto.Enabled:= True;
    end;
    kSincroSalidas:
    begin
      lblEtiqueta.Caption:= 'Sincronizar Salidas  ...';
    end;
    kSincroTransitos:
    begin
      lblEtiqueta.Caption:= 'Sincronizar Tránsitos  ...';
    end;
    kSincroInventarios:
    begin
      lblEtiqueta.Caption:= 'Sincronizar Inventarios  ...';
    end;
    kSincroEntregas:
    begin
      lblEtiqueta.Caption:= 'Sincronizar Entregas Terceros  ...';
      if DMConfig.iInstalacion = 31 then
      begin
        lblFechaDesde.Caption:= 'Fecha Grabación';
      end
      else
      begin
        lblFechaDesde.Caption:=  'Fecha Llegada';
      end;
    end;
    kSincroPedidos:
    begin
      lblEtiqueta.Caption:= 'Sincronizar Pedidos  ...';
    end;
    kSincroDesgloseSal:
    begin
      lblEtiqueta.Caption:= 'Sincronizar Desglose de Salidas  ...';
      edtProducto.Enabled:= True;
    end;

  end;
  Caption:= UpperCase( lblEtiqueta.Caption );
end;

procedure TFPSincroDiario.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  //edtEmpresa.Text := '050';
  etqEmpresa.Caption:= 'TODAS LAS EMPRESAS';
  etqCentro.Caption:= 'TODOS LOS CENTROS';
  txtProducto.Caption:= 'TODOS LOS PRODUCTOS';
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
var
  desde, hasta: TDate;
begin
  result := false;

  //El codigo de empresa es obligatorio
  (*
  if Trim( edtEmpresa.Text ) = '' then
  begin
    edtEmpresa.SetFocus;
    ShowMessage('El código de empresa es obligatorio.');
    Exit;
  end;
  *)

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
      kSincroTodo:
        ShowMessage('Sin implementar. Perdone las molestias.');
      //comprobar liquida en central;
      kSincroSalidas:
        SincroResult:= SincroDiarioMDetailUNT.SincronizarSalidas( edtEmpresa.Text, edtCentro.Text, StrToDate( edtFechaDesde.Text ), StrToDate( edtFechaHasta.Text ), edtCodigo.Text,
                                 lblEtiqueta.Caption );
      kSincroEntradas, kSincroInventarios, kSincroTransitos, 
      kSincroEntregas, kSincroPedidos:
        SincroResult:= SincroDiarioMDetailUNT.SincronizarRegistros( edtEmpresa.Text, edtCentro.Text, edtProducto.Text, StrToDate( edtFechaDesde.Text ), StrToDate( edtFechaHasta.Text ),  edtCodigo.Text,
                                 lblEtiqueta.Caption, iTipo );
      kSincroEscandallos:
        SincroResult:= SincroDiarioMasterUNT.SincronizarRegistros( edtEmpresa.Text, edtCentro.Text, edtProducto.Text, StrToDate( edtFechaDesde.Text ), StrToDate( edtFechaHasta.Text ),  edtCodigo.Text,
                                 lblEtiqueta.Caption, iTipo );
      kSincroDesgloseSal:
        SincroResult:= SincroDiarioMasterUNT.SincronizarDesgloseSal( edtEmpresa.Text, edtCentro.Text, edtProducto.Text, StrToDate( edtFechaDesde.Text ), StrToDate( edtFechaHasta.Text ),  edtCodigo.Text,
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
  if trim( edtEmpresa.Text ) = '' then
    etqEmpresa.Caption:= 'TODAS LAS EMPRESAS'
  else
    etqEmpresa.Caption:= desEmpresa(edtEmpresa.Text);
  edtCentroChange( edtCentro );
  edtProductoChange( edtProducto );
end;

procedure TFPSincroDiario.edtCentroChange(Sender: TObject);
begin
  if trim( edtCentro.Text ) = '' then
    etqCentro.Caption:= 'TODOS LOS CENTROS'
  else
    etqCentro.Caption:= desCentro(edtEmpresa.Text, edtCentro.Text);
end;

procedure TFPSincroDiario.edtProductoChange(Sender: TObject);
begin
  if trim( edtProducto.Text ) = '' then
    txtProducto.Caption:= 'TODOS LOS PRODUCTOS'
  else
    txtProducto.Caption:= desProducto(edtEmpresa.Text, edtProducto.Text);
end;



end.


