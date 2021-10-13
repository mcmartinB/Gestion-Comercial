(* CAMBIAR
   SincroDiarioFP, FLSincronizarDiario
   RParametrosSincronizarDiario
*)
unit CFPEnviarGastosEntregas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, ExtCtrls, ComCtrls, DB,
  DBTables, nbEdits, nbCombos;

type
  TFPEnviarGastosEntregas = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    lblEmpresa: TnbLabel;
    etqEmpresa: TnbStaticText;
    lblFechaHasta: TnbLabel;
    etqCentro: TnbStaticText;
    BarraProgreso: TProgressBar;
    cbxCentro: TComboBox;
    cbxCodigo: TComboBox;
    cbxFecha: TComboBox;
    eCodigo: TBEdit;
    eEmpresa: TnbDBSQLCombo;
    eCentro: TnbDBSQLCombo;
    eFechaDesde: TnbDBCalendarCombo;
    eFechaHasta: TnbDBCalendarCombo;
    lblNombre1: TLabel;
    chbFinalizadas: TCheckBox;
    lblMensajes: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure eEmpresaChange(Sender: TObject);
    procedure eCentroChange(Sender: TObject);
    function eCentroGetSQL: String;
  private
    { Private declarations }

    procedure Ejecutar;
    function  ValidarEntrada: Boolean;
  public
    { Public declarations }

  end;


implementation

{$R *.dfm}

uses UDMAuxDB, UDMBaseDatos, Principal, CGestionPrincipal, CVariables,
     bTimeUtils, UDMConfig, CUPEnviarGastosEntregas;


procedure TFPEnviarGastosEntregas.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  eEmpresa.Text := DMConfig.sEmpresaInstalacion;
  cbxCentro.ItemIndex:= 0;
  eCentro.Text:= DMConfig.sCentroInstalacion;
  cbxFecha.ItemIndex:= 0;
  eFechaDesde.AsDate := Date - 30;
  eFechaHasta.AsDate := Date - 1;
  chbFinalizadas.Checked:= False;
  lblMensajes.Caption:= '';
end;

procedure TFPEnviarGastosEntregas.FormClose(Sender: TObject;
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

procedure TFPEnviarGastosEntregas.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFPEnviarGastosEntregas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFPEnviarGastosEntregas.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

function TFPEnviarGastosEntregas.ValidarEntrada: Boolean;
begin
  result := false;

  //El codigo de empresa es obligatorio
  if Trim( etqEmpresa.Caption ) = '' then
  begin
    eEmpresa.SetFocus;
    ShowMessage('Falta código de empresa o es incorrecto.');
    Exit;
  end;

  //El codigo de centro es obligatorio
  if Trim( etqCentro.Caption ) = '' then
  begin
    eCentro.SetFocus;
    ShowMessage('Falta código de centro o es incorrecto.');
    Exit;
  end;

  //Comprobar que las fechas sean correctas
  if eFechaDesde.AsDate > eFechaHasta.AsDate then
  begin
    eFechaDesde.SetFocus;
    ShowMessage('Rango de fechas incorrecto.');
    Exit;
  end;
  result := true;
end;

procedure TFPEnviarGastosEntregas.Ejecutar;
var
  iRegistros, iPasados: integer;
  sMsg: string;
begin

  if ValidarEntrada then
  begin
    iRegistros:= CUPEnviarGastosEntregas.SincronizarGastosEntregas( eEmpresa.Text,
      cbxCentro.ItemIndex, eCentro.Text, cbxFecha.ItemIndex, eFechaDesde.AsDate, eFechaHasta.AsDate,
      cbxCodigo.ItemIndex, eCodigo.Text, chbFinalizadas.Checked, BarraProgreso, sMsg, iPasados );
    if iRegistros > 0 then
    begin
      ShowMessage( 'Pasados ' + IntToStr(iPasados) + ' de ' + IntToStr(iRegistros) + ' gastos de entregas.' +
             #13 + #10 + '*********************************************************' + #13 + #10 + sMsg );
    end
    else
    begin
      ShowMessage('Sin gastos de entregas por enviar.');
    end;
  end;
end;

procedure TFPEnviarGastosEntregas.btnAceptarClick(Sender: TObject);
begin
  Ejecutar;
end;

procedure TFPEnviarGastosEntregas.eEmpresaChange(Sender: TObject);
begin
  etqEmpresa.Caption:= desEmpresa(eEmpresa.Text);
end;

procedure TFPEnviarGastosEntregas.eCentroChange(Sender: TObject);
begin
  etqCentro.Caption:= desCentro(eEmpresa.Text, eCentro.Text);
end;


function TFPEnviarGastosEntregas.eCentroGetSQL: String;
begin
  if eEmpresa.Text <> '' then
    result:= ' select centro_c, descripcion_c ' +
             ' from frf_centros ' +
             ' where empresa_c = ' + QuotedStr( eEmpresa.Text )
  else
    result:= ' select centro_c, descripcion_c ' +
             ' from frf_centros ';
end;

end.


