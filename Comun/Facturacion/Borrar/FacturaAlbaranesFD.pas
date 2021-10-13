unit FacturaAlbaranesFD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, dbtables;

type
  TFDFacturaAlbaranes = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    QFacturas: TQuery;
    Label1: TLabel;
    btnEmpresa: TBGridButton;
    edtEmpresa: TBEdit;
    STEmpresa: TStaticText;
    lblDesde: TLabel;
    edtFecha: TBEdit;
    btnFecha: TBCalendarButton;
    lbl1: TLabel;
    edtFactura: TBEdit;
    lblCodigo: TLabel;
    edtCodFactura: TBEdit;
    rbCodigo: TRadioButton;
    rbNumero: TRadioButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);

    procedure rbCodigoClick(Sender: TObject);
  private
    sEmpresa, sCodigo: string;
    dFecha: TDateTime;
    iFactura: Integer;

    function  CamposOk: boolean;
    procedure CargarQuery;
    function  AbrirTabla: Boolean;
    procedure Imprimir;

  public
    { Public declarations }

  end;

implementation

uses UDMAuxDB, Principal, CVariables, CAuxiliarDB, CReportes,
  ListadoFacturasQR, DPreview, UDMBaseDatos, CGlobal, UDMMaster;

{$R *.DFM}

//                         ****  BOTONES  ****

procedure TFDFacturaAlbaranes.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;

  if CamposOk then
  begin
    if AbrirTabla then
      Imprimir;
  end;
end;

procedure TFDFacturaAlbaranes.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then
    Close;
end;

//                          **** FORMULARIO ****

procedure TFDFacturaAlbaranes.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag := kEmpresa;
  edtFecha.Tag := kCalendar;
  if gProgramVersion = pvBAG then
  begin
    edtEmpresa.Text := 'F17';
  end
  else
  begin
    edtEmpresa.Text := '050';
  end;
  STEmpresa.Caption := desEmpresa(edtEmpresa.Text);
  edtFecha.Text := DateTostr(Date);
  edtFactura.Text := '';
  edtCodFactura.Text := '';

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;
end;

procedure TFDFacturaAlbaranes.FormActivate(Sender: TObject);
begin
  Top := 1;
  ActiveControl := edtCodFactura;
end;

procedure TFDFacturaAlbaranes.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDFacturaAlbaranes.FormClose(Sender: TObject;
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
  Action := caFree;
end;

procedure TFDFacturaAlbaranes.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCalendar: DespliegaCalendario(btnFecha);
  end;
end;

procedure TFDFacturaAlbaranes.PonNombre(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(edtEmpresa.text);
end;

function TFDFacturaAlbaranes.CamposOk: boolean;
begin
  if  rbNumero.Checked then
  begin
    if STEmpresa.Caption = '' then
    begin
      ShowError('Falta el código de la empresa o es incorrecto.');
      Result := False;
    end
    else
    if not TryStrToDate( edtFecha.Text, dFecha) then
    begin
      ShowError('Falta la fecha o es incorrecta.');
      Result := False;
    end
    else
    if not TryStrToInt(edtFactura.Text, iFactura ) then
    begin
      ShowError('Falta el número de la factura.');
      Result := False;
    end
    else
    begin
      sEmpresa:= edtEmpresa.Text;
      Result:= True;
    end;
  end
  else
  begin
    if Length( Trim(edtCodFactura.Text )) < 15 then
    begin
      ShowError('El codigo de la factura debe de ser de 15 caracteres (TTT-EEEAA-00000)');
      Result := False;
    end
    else
    begin
      sCodigo:= edtCodFactura.Text;
      Result := True;
    end;
  end;


end;

procedure TFDFacturaAlbaranes.CargarQuery;
begin
  (*
  select cod_empresa_fac_fc, fecha_factura_fc, n_factura_fc 
from tfacturas_cab
--where cod_empresa_fac_fc = '050'
--and fecha_factura_fc = '21/12/2016'
--and n_factura_fc = 7761
where cod_factura_fc = 'FCP-05016-07761'
*)
(*
select *
from frf_salidas_c
where empresa_fac_sc = '050'
and n_factura_sc = 7761
and fecha_factura_sc = '21/12/2016'
*)

  UDMMaster.DMMaster.qryAux.SQL.Clear;
  UDMMaster.DMMaster.qryAux.SQL.Add(' select * from tfacturas_cab ');
  if rbCodigo.Checked then
  begin
    UDMMaster.DMMaster.qryAux.SQL.Add(' where cod_factura_fc = :codigo ');
    UDMMaster.DMMaster.qryAux.ParamByName('codigo').AsString:= sCodigo;
  end
  else
  begin
    UDMMaster.DMMaster.qryAux.SQL.Add(' where cod_empresa_fac_fc = :empresa ');
    UDMMaster.DMMaster.qryAux.SQL.Add(' and fecha_factura_fc = :fecha ');
    UDMMaster.DMMaster.qryAux.SQL.Add(' and n_factura_fc = :factura ');
    UDMMaster.DMMaster.qryAux.ParamByName('empresa').AsString:= sEmpresa;
    UDMMaster.DMMaster.qryAux.ParamByName('fecha').AsDateTime:= dFecha;
    UDMMaster.DMMaster.qryAux.ParamByName('factura').AsInteger:= iFactura;
  end;
end;

function TFDFacturaAlbaranes.AbrirTabla: boolean;
begin
  try
    QFacturas.Open;
  except
    on E: EDBEngineError do
    begin
      ShowError(e);
    end;
  end;
end;

procedure TFDFacturaAlbaranes.Imprimir;
var
  QRListadoFacturas: TQRListadoFacturas;
begin
(*
  try
    QRListadoFacturas:= TQRListadoFacturas.Create( self );
    try
      QRListadoFacturas.lblFechas.Caption := 'Del ' + MEDesde.Text + ' al ' + MEHasta.Text;
      QRListadoFacturas.lblClientes.Caption := 'Cliente de ' + DCliente.Text + ' a ' + HCliente.Text;
      QRListadoFacturas.lblFacturas.Caption := 'Facturas de ' + DFactura.Text + ' a ' + HFactura.Text;
      case cbxNacionalidad.ItemIndex of
        1: QRListadoFacturas.lblClientes.Caption := QRListadoFacturas.lblClientes.Caption + ', nacionales';
        2: QRListadoFacturas.lblClientes.Caption := QRListadoFacturas.lblClientes.Caption + ', extranjeros';
        3: QRListadoFacturas.lblClientes.Caption := QRListadoFacturas.lblClientes.Caption + ', ' + desPais(ePais.Text);
      end;
      case RGImpuesto.ItemIndex of
        0: QRListadoFacturas.lblTitulo.Caption := 'LISTADO DE FACTURAS (IVA).';
        1: QRListadoFacturas.lblTitulo.Caption := 'LISTADO DE FACTURAS (IGIC).';
        2: QRListadoFacturas.lblTitulo.Caption := 'LISTADO DE FACTURAS.';
      end;
      PonLogoGrupoBonnysa(QRListadoFacturas, EEmpresa.Text);
      QRListadoFacturas.DataSet := QFacturas;
      Preview(QRListadoFacturas);
    except
      FreeAndNil( QRListadoFacturas );
    end;
  finally
    QFacturas.Close;
  end;
*)
end;

procedure TFDFacturaAlbaranes.rbCodigoClick(Sender: TObject);
begin
  //edtCodigo.
end;

end.

