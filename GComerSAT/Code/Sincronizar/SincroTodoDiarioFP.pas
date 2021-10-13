(* CAMBIAR
   SincroDiarioFP, FLSincronizarDiario
   RParametrosSincronizarDiario
*)
unit SincroTodoDiarioFP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, ExtCtrls, ComCtrls, DB,
  DBTables;

type
  TFPSincroTodoDiario = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    pSincronizar: TPanel;
    lblEmpresa: TnbLabel;
    edtEmpresa: TBEdit;
    etqEmpresa: TnbStaticText;
    edtFechaDesde: TBEdit;
    lblFechaDesde: TnbLabel;
    lblEtiqueta: TLabel;
    cbxEntradas: TCheckBox;
    cbxEscandallo: TCheckBox;
    cbxSalidas: TCheckBox;
    cbxTransitos: TCheckBox;
    cbxInventarios: TCheckBox;
    lblMsg01: TLabel;
    lblMsg02: TLabel;
    Bevel1: TBevel;
    BarraProgreso: TProgressBar;
    lblCentro: TnbLabel;
    edtCentro: TBEdit;
    etqCentro: TnbStaticText;
    QLocal: TQuery;
    QCentral: TQuery;
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
  private
    { Private declarations }

  public
    { Public declarations }

    procedure Ejecutar;
    procedure EjecutarEx( const ATipo: integer );
    function  ValidarEntrada: Boolean;
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, UDMBaseDatos, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     SincroVarUNT, SincroDiarioMasterUNT, SincroDiarioMDetailUNT,
     SincroTodoResumenFD, UDMConfig;

var
  SincroTodoResult: RSincroTodoResumen;

procedure TFPSincroTodoDiario.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  //edtEmpresa.Text := '050';
  etqEmpresa.Caption:= 'TODAS LAS EMPRESAS';
  etqCentro.Caption:= 'TODOS LOS CENTROS';
  edtFechaDesde.Text := DateToStr(Date - 1);

  lblMsg01.Caption:= 'Esperando orden. ';
  lblMsg02.Caption:= '';

  if not DMConfig.EsLaFont then
  begin
    if DMConfig.EsLasMoradas then
    begin
      cbxEscandallo.Visible:= True;
    end
    else
    begin
      cbxEscandallo.Visible:= False;
    end;
  end
  else
  begin
    cbxInventarios.Visible:= False;
    cbxEscandallo.Visible:= False;
  end;
end;

procedure TFPSincroTodoDiario.FormClose(Sender: TObject;
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

procedure TFPSincroTodoDiario.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFPSincroTodoDiario.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFPSincroTodoDiario.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

function TFPSincroTodoDiario.ValidarEntrada: Boolean;
begin
  result := false;

  //Comprobar que las fechas sean correctas
  try
    StrToDate(edtFechaDesde.Text);
  except
    edtFechaDesde.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;
  result := true;
end;

procedure TFPSincroTodoDiario.EjecutarEx( const ATipo: integer );
var
  SincroResult: RSincroResumen;
begin

    InicializarResumenSincronizar( SincroResult );
    AsignarBarraProgreso( BarraProgreso );

    case ATipo of
      kSincroEntradas:
      begin
        SincroResult:= SincroDiarioMDetailUNT.SincronizarRegistros( edtEmpresa.Text, edtCentro.Text, '', StrToDate( edtFechaDesde.Text ), StrToDate( edtFechaDesde.Text ), '',
                               lblEtiqueta.Caption, ATipo );
        CopiarResumen( SincroTodoResult.REntrada, SincroResult );
      end;
      kSincroSalidas:
      begin
        SincroResult:= SincroDiarioMDetailUNT.SincronizarRegistros( edtEmpresa.Text, edtCentro.Text, '',  StrToDate( edtFechaDesde.Text ), StrToDate( edtFechaDesde.Text ), '',
                                 lblEtiqueta.Caption, ATipo );
        CopiarResumen( SincroTodoResult.RSalidas, SincroResult );
      end;
      kSincroTransitos:
      begin
        SincroResult:= SincroDiarioMDetailUNT.SincronizarRegistros( edtEmpresa.Text, edtCentro.Text, '',  StrToDate( edtFechaDesde.Text ), StrToDate( edtFechaDesde.Text ), '',
                                 lblEtiqueta.Caption, ATipo );
        CopiarResumen( SincroTodoResult.RTransitos, SincroResult );
      end;
      kSincroInventarios:
      begin
        SincroResult:= SincroDiarioMDetailUNT.SincronizarRegistros( edtEmpresa.Text, edtCentro.Text, '',  StrToDate( edtFechaDesde.Text ), StrToDate( edtFechaDesde.Text ), '',
                                 lblEtiqueta.Caption, ATipo );
        CopiarResumen( SincroTodoResult.RInventarios, SincroResult );
      end;
      kSincroEscandallos:
      begin
        SincroResult:= SincroDiarioMasterUNT.SincronizarRegistros( edtEmpresa.Text, edtCentro.Text, '', StrToDate( edtFechaDesde.Text ), StrToDate( edtFechaDesde.Text ), '',
                                 lblEtiqueta.Caption, ATipo );
        CopiarResumen( SincroTodoResult.REscandallo, SincroResult );
      end;
    end;

    LiberarBarraProgreso;
    LiberarResumenSincronizar( SincroResult );
end;

procedure TFPSincroTodoDiario.Ejecutar;
begin
  if ValidarEntrada then
  begin
    InicializarTodoResumenSincronizar( SincroTodoResult );

    SincroTodoResult.titulo:= Trim( Caption );
    SincroTodoResult.usuario:= UpperCase( gsCodigo ) + ' - ' + gsNombre;
    SincroTodoResult.hora:= DateTimeToStr( Now );

    lblMsg01.Caption:= 'Por favor, espere mientras ';
    Application.ProcessMessages;

    if cbxEntradas.Checked and cbxEntradas.Visible then
    begin
      lblMsg02.Caption:= 'se traspasan las entradas ...';
      Application.ProcessMessages;
      EjecutarEx( kSincroEntradas );
    end;
    if cbxEscandallo.Checked and cbxEscandallo.Visible then
    begin
      lblMsg02.Caption:= 'se traspasan los escandallos ...';
      Application.ProcessMessages;
      EjecutarEx( kSincroEscandallos );
    end;
    if cbxSalidas.Checked and cbxSalidas.Visible then
    begin
      lblMsg02.Caption:= 'se traspasan las salidas ...';
      Application.ProcessMessages;
      EjecutarEx( kSincroSalidas );
    end;
    if cbxTransitos.Checked and cbxTransitos.Visible then
    begin
      lblMsg02.Caption:= 'se traspasan los transitos ...';
      Application.ProcessMessages;
      EjecutarEx( kSincroTransitos );
    end;
    if cbxInventarios.Checked and cbxInventarios.Visible then
    begin
      lblMsg02.Caption:= 'se traspasan los inventarios ...';
      Application.ProcessMessages;
      EjecutarEx( kSincroInventarios );
    end;

    SincroTodoResumenFD.Ejecutar( self, SincroTodoResult );
    LiberarTodoResumenSincronizar( SincroTodoResult );
  end;

  lblMsg01.Caption:= 'Esperando orden. ';
  lblMsg02.Caption:= 'Proceso finalizado.';
  Application.ProcessMessages;
end;

procedure TFPSincroTodoDiario.btnAceptarClick(Sender: TObject);
begin
  Ejecutar;
end;

procedure TFPSincroTodoDiario.edtEmpresaChange(Sender: TObject);
begin
  if trim( edtEmpresa.Text ) = '' then
    etqEmpresa.Caption:= 'TODAS LAS EMPRESAS'
  else
    etqEmpresa.Caption:= desEmpresa(edtEmpresa.Text);
end;

procedure TFPSincroTodoDiario.edtCentroChange(Sender: TObject);
begin
  if trim( edtCentro.Text ) = '' then
    etqCentro.Caption:= 'TODOS LOS CENTROS'
  else
    etqCentro.Caption:= desCentro(edtEmpresa.Text, edtCentro.Text);
end;


end.


