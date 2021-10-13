unit LFPromedioVentasNetoProduccion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, DBTables;

type
  TFLPromedioVentasNetoProduccion = class(TForm)
    Panel1: TPanel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    lblNombre1: TLabel;
    lblNombre2: TLabel;
    btnEmpresa: TBGridButton;
    btnFechaDesde: TBCalendarButton;
    btnFechaHasta: TBCalendarButton;
    lblNombre3: TLabel;
    eProducto: TBEdit;
    eEmpresa: TBEdit;
    STEmpresa: TStaticText;
    eCentroSalida: TBEdit;
    eFechaDesde: TBEdit;
    eFechaHasta: TBEdit;
    ePais: TBEdit;
    btnProducto: TBGridButton;
    STProducto: TStaticText;
    btnCentroSalida: TBGridButton;
    stCentroSalida: TStaticText;
    btnPais: TBGridButton;
    stPais: TStaticText;
    cbxDescuentos: TCheckBox;
    cbxGastosSalidas: TCheckBox;
    cbxEnvasado: TCheckBox;
    cbxSecciones: TCheckBox;
    cbxAbonos: TCheckBox;
    eCentroOrigen: TBEdit;
    btnCentroOrigen: TBGridButton;
    stCentroOrigen: TStaticText;
    lblNombre4: TLabel;
    lblNombre5: TLabel;
    eCliente: TBEdit;
    btnCliente: TBGridButton;
    stCliente: TStaticText;
    lblNombre6: TLabel;
    lblNombre7: TLabel;
    cbxGastosTransitos: TCheckBox;
    lblNombre8: TLabel;
    cbxDesgloseProductos: TCheckBox;
    cbxDesgloseCliente: TCheckBox;
    cbxDesglosePaises: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BAceptarExecute(Sender: TObject);
    procedure BCancelarExecute(Sender: TObject);

    {Private declarations}
  private
    sEmpresa, sOrigen, sSalida, sProducto, sCliente, sPais: string;
    dFechaIni, dFechaFin: TDateTime;

    function  ValidarDatosOk: boolean;

  public
    { Public declarations }


  end;

var
  Autorizado: boolean;

implementation

uses
  Principal, CVariables, CAuxiliarDB, UDMAuxDB, UDMBaseDatos,
  LDPromedioVentasNetoProduccion;

{$R *.DFM}

//                          **** FORMULARIO ****
procedure TFLPromedioVentasNetoProduccion.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  ECentroOrigen.Tag := kCentro;
  ECentroSalida.Tag := kCentro;
  EProducto.Tag := kProducto;
  ECliente.Tag := kCliente;
  EPais.Tag := kPais;
  eFechaDesde.Tag := kCalendar;
  eFechaHasta.Tag := kCalendar;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;
  CalendarioFlotante.Date := Date;

  eEmpresa.Text:= gsDefEmpresa;
  eFechaDesde.Text := DateTostr(Date-6);
  eFechaHasta.Text := DateTostr(Date);
  eCentroOrigen.Text:= '';
  PonNombre(eCentroOrigen);
  eCentroSalida.Text:= '';
  PonNombre(eCentroSalida);
  eProducto.Text:= '';
  PonNombre(eProducto);
  ePais.Text:= '';
  PonNombre(ePais);
  eCliente.Text:= '';
  PonNombre(eCliente);


  cbxDescuentos.Visible:= UpperCase( Copy( gsCodigo, 1, 4 ) ) = 'INFO';
  cbxGastosSalidas.Visible:= cbxDescuentos.Visible;
  cbxGastosTransitos.Visible:= cbxDescuentos.Visible;
  cbxEnvasado.Visible:= cbxDescuentos.Visible;
  cbxSecciones.Visible:= cbxDescuentos.Visible;
  cbxAbonos.Visible:= cbxDescuentos.Visible;
end;

procedure TFLPromedioVentasNetoProduccion.FormActivate(Sender: TObject);
begin
  Top := 1;
    //Hoja de ayuda
  ActiveControl := EEmpresa;
end;

procedure TFLPromedioVentasNetoProduccion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');

     //Liberamos memoria
  Action := caFree;
end;

procedure TFLPromedioVentasNetoProduccion.BAceptarExecute(Sender: TObject);
begin
  if ValidarDatosOk then
  begin
    if not PromedioVentasNetoProduccionExecute( self, sEmpresa, sOrigen, sSalida,
             sProducto, sCliente, sPais, dFechaIni, dFechaFin, cbxDescuentos.Checked,
             cbxGastosSalidas.Checked, cbxGastosTransitos.Checked, cbxEnvasado.Checked,
             cbxSecciones.Checked, cbxAbonos.Checked,
             cbxDesgloseProductos.Checked, cbxDesgloseCliente.Checked, cbxDesglosePaises.Checked ) then
    begin
      ShowMessage('Sin datos para los parametros introducidos.');
    end;
  end;
end;

procedure TFLPromedioVentasNetoProduccion.BCancelarExecute(Sender: TObject);
begin
  if CerrarForm(false) then
    Close;
end;

procedure TFLPromedioVentasNetoProduccion.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    $0D, $28: //vk_return,vk_down
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;
    $26: //vk_up
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        Exit;
      end;
  end;
end;

//                     ****  CAMPOS DE EDICION  ****

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLPromedioVentasNetoProduccion.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCentro:
    if eCentroSalida.Focused then
      DespliegaRejilla(btnCentroSalida, [EEmpresa.Text])
    else
      DespliegaRejilla(btnCentroOrigen, [EEmpresa.Text]);
    kProducto: DespliegaRejilla(btnProducto, [EEmpresa.Text]);
    kCliente: DespliegaRejilla(btnCliente, [EEmpresa.Text]);
    kPais: DespliegaRejilla(btnPais, [EEmpresa.Text]);
    kCalendar:
      begin
        if eFechaDesde.Focused then
          DespliegaCalendario(btnFechaDesde)
        else
          DespliegaCalendario(btnFechaHasta);
      end;
  end;
end;

procedure TFLPromedioVentasNetoProduccion.PonNombre(Sender: TObject);
begin
  case TComponent(Sender).Tag of
    kEmpresa:
    begin
      STEmpresa.Caption := desEmpresa(Eempresa.Text);
      PonNombre( eCentroOrigen );
      PonNombre( eCentroSalida );
      PonNombre( eProducto );
      PonNombre( eCliente );
    end;
    kCentro:
    begin
      if Trim( ECentroOrigen.Text ) = '' then
      begin
        STCentroOrigen.Caption := '    (Vacio todos)';
      end
      else
      begin
        STCentroOrigen.Caption := desCentro(Eempresa.Text, eCentroOrigen.Text);
      end;
      if Trim( ECentroSalida.Text ) = '' then
      begin
        STCentroSalida.Caption := '    (Vacio todos)';
      end
      else
      begin
        STCentroSalida.Caption := desCentro(Eempresa.Text, eCentroSalida.Text);
      end;
    end;
    kProducto:
    begin
      if Trim( Eproducto.Text ) = '' then
      begin
        STProducto.Caption := '    (Vacio todos)';
        cbxDesgloseProductos.Enabled:= True;
      end
      else
      begin
        STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
        cbxDesgloseProductos.Enabled:= False;
        cbxDesgloseProductos.Checked:= False;
      end;
    end;
    kCliente:
    begin
      if Trim( ECliente.Text ) = '' then
      begin
        stCliente.Caption := '    (Vacio todos)';
        cbxDesglosePaises.Enabled:= True;
        cbxDesgloseCliente.Enabled:= True;
      end
      else
      begin
        STCliente.Caption := desCliente(ECliente.Text);
        cbxDesglosePaises.Enabled:= False;
        cbxDesglosePaises.Checked:= False;
        cbxDesgloseCliente.Enabled:= False;
        cbxDesgloseCliente.Checked:= False;
      end;
    end;
    kPais:
    begin
      if Trim( Epais.Text ) = '' then
      begin
        stPais.Caption := '    (Vacio todos)';
        cbxDesglosePaises.Enabled:= True;
      end
      else
      begin
        STPais.Caption := desPais(EPais.Text);
        cbxDesglosePaises.Enabled:= False;
        cbxDesglosePaises.Checked:= False;
      end;
    end;
  end;
end;

function TFLPromedioVentasNetoProduccion.ValidarDatosOk: boolean;
begin
  Result := False;
  //Comprobamos que los campos esten todos con datos
  if STEmpresa.Caption = '' then
  begin
    ShowError('Falta el código de la empresa o es incorrecto.');
    EEmpresa.SetFocus;
    Exit;
  end;
  sEmpresa:= Trim(eEmpresa.Text);

  if stCentroOrigen.Caption = '' then
  begin
    ShowError('El código del centro de origen es incorrecto.');
    eCentroOrigen.SetFocus;
    Exit;
  end;
  sOrigen:= Trim(eCentroOrigen.Text);

  if stCentroSalida.Caption = '' then
  begin
    ShowError('El código del centro de salida es incorrecto.');
    eCentroSalida.SetFocus;
    Exit;
  end;
  sSalida:= Trim(eCentroSalida.Text);

  if STProducto.Caption = '' then
  begin
    ShowError('El código del producto es incorrecto.');
    EProducto.SetFocus;
    Exit;
  end;
  sProducto:= Trim(eProducto.Text);

  if STCliente.Caption = '' then
  begin
    ShowError('El código del cliente es incorrecto.');
    ECliente.SetFocus;
    Exit;
  end;
  sCliente:= Trim(eCliente.Text);

  if STPais.Caption = '' then
  begin
    ShowError('El código del país es incorrecto.');
    EPais.SetFocus;
    Exit;
  end;
  sPais:= Trim(ePais.Text);

  if not TryStrToDate( eFechaDesde.Text, dFechaIni ) then
  begin
    ShowError('Falta la fecha de inicio o es incorrecta.');
    eFechaDesde.SetFocus;
    Exit;
  end;

  if not TryStrToDate( eFechaHasta.Text, dFechaFin ) then
  begin
    ShowError('Falta la fecha de fin o es incorrecta.');
    eFechaHasta.SetFocus;
    Exit;
  end;

  if dFechaIni > dFechaFin then
  begin
    ShowError('Rango de fechas incorrecto.');
    eFechaDesde.SetFocus;
    Exit;
  end;

  Result := True;
end;

end.
