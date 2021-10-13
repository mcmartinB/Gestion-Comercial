(* CAMBIAR
   SincroDiarioFP, FLSincronizarDiario
   RParametrosSincronizarDiario
*)
unit CFPEnviarEntregas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, ExtCtrls, ComCtrls, DB,
  DBTables, nbEdits, nbCombos;

type
  TFPEnviarEntregas = class(TForm)
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
    iTipo: integer;

    procedure Configurar( const ATipo: integer );

  public
    { Public declarations }

    procedure Ejecutar;
    function  ValidarEntrada: Boolean;
  end;

  procedure CrearVentana(const AForm: TForm; const ATipo: integer );

implementation

{$R *.dfm}

uses UDMAuxDB, UDMBaseDatos, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     CUPEnviarEntregas, CUPEnviarEntregasAux, UDMConfig;
     //CUPEnviar, CFDResultadoEnvio

procedure CrearVentana(const AForm: TForm; const ATipo: integer );
var
  i: Integer;
begin
  for i := AForm.MDIChildCount - 1 downto 0 do
  begin
    if AForm.MDIChildren[i].ClassType = TFPEnviarEntregas then
    begin
      AForm.MDIChildren[i].Show;
      Exit;
    end;
  end;

  //Para que los form maximizados aparezcan desde el inicio maximizados
  LockWindowUpdate(AForm.Handle);
  try
    with TFPEnviarEntregas.Create( AForm ) do
      Configurar( ATipo);
  finally
    LockWindowUpdate(0);
  end;
end;

procedure TFPEnviarEntregas.Configurar( const ATipo: integer );
begin
  iTipo:= ATipo;
  case iTipo of
    1://Entregas a mi almacen
    begin
        Caption:= '    ENVIAR ENTREGAS PROVEEDOR';
      eEmpresa.Text := DMConfig.sEmpresaInstalacion;
      cbxCentro.ItemIndex:= 1;
      begin
        eCentro.Text:= DMConfig.sCentroInstalacion;
      end;
      cbxFecha.ItemIndex:= 1;
      eFechaDesde.AsDate := Date - 7;
      eFechaHasta.AsDate := Date - 1;
      chbFinalizadas.Checked:= True;
      chbFinalizadas.Visible:= False;
      lblMensajes.Caption:= '';
    end;
    2://Las entregas a otro almacen
    begin
      begin
        Caption:= '    ENVIAR ENTREGAS PROVEEDOR';
      end;

      eEmpresa.Text := DMConfig.sEmpresaInstalacion;

      cbxCentro.ItemIndex:= 1;
      cbxCentro.Enabled:= False;
      if DMConfig.sCentroInstalacion = '1' then
        eCentro.Text:= '6'
      else
      if DMConfig.sCentroInstalacion = '6' then
        eCentro.Text:= '1'
      else
        eCentro.Text:= '';

      cbxFecha.ItemIndex:= 0;
      eFechaDesde.AsDate := Date - 7;
      eFechaHasta.AsDate := Date - 1;

      chbFinalizadas.Checked:= False;
      chbFinalizadas.Visible:= False;

      lblMensajes.Caption:= '';
    end;
  end;
end;

procedure TFPEnviarEntregas.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;
end;

procedure TFPEnviarEntregas.FormClose(Sender: TObject;
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

procedure TFPEnviarEntregas.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFPEnviarEntregas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFPEnviarEntregas.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

function TFPEnviarEntregas.ValidarEntrada: Boolean;
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

procedure TFPEnviarEntregas.Ejecutar;
var
  iRegistros, iPasados: integer;
  sMsg: string;
begin
  if ValidarEntrada then
  begin
    if iTipo = 1 then
    begin
      iRegistros:= CUPEnviarEntregas.SincronizarEntregas( eEmpresa.Text,
        cbxCentro.ItemIndex, eCentro.Text, cbxFecha.ItemIndex, eFechaDesde.AsDate, eFechaHasta.AsDate,
        cbxCodigo.ItemIndex, eCodigo.Text, chbFinalizadas.Checked, BarraProgreso, sMsg, iPasados );
    end
    else
    begin
      iRegistros:= CUPEnviarEntregasAux.SincronizarEntregas( eEmpresa.Text,
        eCentro.Text, cbxFecha.ItemIndex, eFechaDesde.AsDate, eFechaHasta.AsDate,
        cbxCodigo.ItemIndex, eCodigo.Text, chbFinalizadas.Checked,BarraProgreso, sMsg, iPasados );
    end;
    if iRegistros > 0 then
    begin
      ShowMessage( 'Pasadas ' + IntToStr(iPasados) + ' de ' + IntToStr(iRegistros) + ' entregas.' +
             #13 + #10 + '*********************************************************' + #13 + #10 + sMsg );
    end
    else
    begin
      ShowMessage('Sin entregas por enviar.');
    end;
  end;
end;

procedure TFPEnviarEntregas.btnAceptarClick(Sender: TObject);
begin
  Ejecutar;
end;

procedure TFPEnviarEntregas.eEmpresaChange(Sender: TObject);
begin
  etqEmpresa.Caption:= desEmpresa(eEmpresa.Text);
end;

procedure TFPEnviarEntregas.eCentroChange(Sender: TObject);
begin
  etqCentro.Caption:= desCentro(eEmpresa.Text, eCentro.Text);
end;


function TFPEnviarEntregas.eCentroGetSQL: String;
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


