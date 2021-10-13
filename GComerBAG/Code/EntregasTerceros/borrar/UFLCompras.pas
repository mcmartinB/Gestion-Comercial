unit UFLCompras;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbtables,
  DError, DBCtrls;

type
  TFLCompras = class(TMaestro)
    PMaestro: TPanel;
    Label13: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    BGBEmpresa_c: TBGridButton;
    stEmpresa_c: TStaticText;
    RejillaFlotante: TBGrid;
    BGBCentro_c: TBGridButton;
    stCentro_c: TStaticText;
    CalendarioFlotante: TBCalendario;
    LFecha: TLabel;
    BCBFecha_c: TBCalendarButton;
    lblNombre1: TLabel;
    lblNombre2: TLabel;
    BGBProveedor_c: TBGridButton;
    stProveedor_c: TStaticText;
    lblNombre6: TLabel;
    edtempresa: TBEdit;
    edtcentro: TBEdit;
    edtfechaIni: TBEdit;
    edtnumero: TBEdit;
    edtproveedor: TBEdit;
    edtref_compra: TBEdit;
    btnOk: TSpeedButton;
    btnCancel: TSpeedButton;
    edtFechaFin: TBEdit;
    btnFechaHasta1: TBCalendarButton;
    lblFechaHasta: TLabel;
    lblNombre3: TLabel;
    cbbGastos: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure edtcentroChange(Sender: TObject);
    procedure edtproveedorChange(Sender: TObject);
    procedure edtempresaChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);


  private
    { Private declarations }
    sEmpresa, sCentro, sProveedor, sReferencia: string;
    iCompra, iGastosPagados: Integer;
    dFechaIni, dFechaFin: TDateTime;

    function  ValidarCampos: Boolean;

  public
    procedure Previsualizar; override;

  end;

implementation

uses UDMAuxDB, CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, DPreview, UQRCompras;

{$R *.DFM}

//************************** CREAMOS EL FORMULARIO ************************
procedure TFLCompras.FormCreate(Sender: TObject);


begin
  FormType := tfOther;
  BHFormulario;

  //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
  gCF := CalendarioFlotante;
  CalendarioFlotante.Date:= Date;
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

  //Asignamos constantes a los componentes que los tienen
  //para facilitar distingirlos
  edtempresa.Tag := kEmpresa;
  edtcentro.Tag:= kCentro;
  edtproveedor.Tag:= kProveedor;
  edtfechaIni.Tag:= kCalendar;

  edtempresa.Text:= gsDefEmpresa;
  edtfechaIni.Text:= FormatDateTime( 'dd/mm/yyyy', IncMonth(Date - 1, -3) );
  edtFechaFin.Text:= FormatDateTime( 'dd/mm/yyyy', Date -1 );
end;

procedure TFLCompras.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  Action:= caFree;
end;

procedure TFLCompras.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{*}//Si la rejilla esta desplegada no hacemos nada
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
           //No hacemos nada
      Exit;

    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización

  case key of
    vk_Return:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
    VK_ESCAPE:
      btnCancel.Click;
    VK_F1:
      btnOk.Click;
  end;
end;


function TFLCompras.ValidarCampos: Boolean;
begin
  Result:= False;
  if stEmpresa_c.Caption = '' then
  begin
    ShowMessage('Falta el código de la empresa o es incorrecto.');
    Exit;
  end;
  sEmpresa:= edtempresa.Text;

  if stCentro_c.Caption = '' then
  begin
    ShowMessage('El código del centro es incorrecto.');
    Exit;
  end;
  sCentro:= edtcentro.Text;

  if stProveedor_c.Caption = '' then
  begin
    ShowMessage('El código del proveedor es incorrecto.');
    Exit;
  end;
  sProveedor:= edtproveedor.Text;

  if not tryStrToDate( edtfechaIni.Text, dFechaIni ) then
  begin
    ShowMessage('Falta o es incorrecta la fecha de la inicio de la compra.');
    Exit;
  end;
  if not tryStrToDate( edtfechaFin.Text, dFechaFin ) then
  begin
    ShowMessage('Falta o es incorrecta la fecha de la inicio de la compra.');
    Exit;
  end;
  if dFechaIni > dFechaFin then
  begin
    ShowMessage('El rango de fechas es incorrecto.');
    Exit;
  end;
  Result:= True;

  sReferencia:= edtref_compra.Text;
  iCompra:= StrToIntDef( edtnumero.Text, -1 );
  iGastosPagados:= cbbGastos.ItemIndex;
end;

procedure TFLCompras.Previsualizar;
var
  QRCompras: TQRCompras;
begin
  //Crear el listado
  DMBaseDatos.QListado.SQL.Clear;
  DMBaseDatos.QListado.SQL.Add('select *');
  DMBaseDatos.QListado.SQL.Add('from frf_compras');
  DMBaseDatos.QListado.SQL.Add('where empresa_c = :empresa ');
  if sCentro <> '' then
    DMBaseDatos.QListado.SQL.Add('and centro_c =:centro ');
  DMBaseDatos.QListado.SQL.Add('and fecha_c between :fechaini and :fechafin ');
  if sReferencia <> '' then
    DMBaseDatos.QListado.SQL.Add('and ref_compra_c = :referencia ');
  if iCompra <> -1 then
    DMBaseDatos.QListado.SQL.Add('and numero_c = :compra ');

  if iGastosPagados = 1 then
    DMBaseDatos.QListado.SQL.Add('and status_gastos_c > 0 ')
  else
  if iGastosPagados = 2 then
    DMBaseDatos.QListado.SQL.Add('and status_gastos_c < 1 ');

  DMBaseDatos.QListado.SQL.Add('order by empresa_c, centro_c, fecha_c, numero_c ');

  DMBaseDatos.QListado.ParamByName('empresa').AsString:= sEmpresa;
  DMBaseDatos.QListado.ParamByName('fechaini').AsDateTime:= dFechaIni;
  DMBaseDatos.QListado.ParamByName('fechafin').AsDateTime:= dFechaFin;
  if sCentro <> '' then
    DMBaseDatos.QListado.ParamByName('centro').AsString:= sCentro;
  if sReferencia <> '' then
    DMBaseDatos.QListado.ParamByName('referencia').AsString:= sReferencia;
  if iCompra <> -1 then
    DMBaseDatos.QListado.ParamByName('compra').AsInteger:= iCompra;

  try
    DMBaseDatos.QListado.Open;
    QRCompras:= TQRCompras.Create(Application);
    try
      PonLogoGrupoBonnysa(QRCompras);
      Preview(QRCompras);
    except
      FreeAndNil(QRCompras);
      Raise;
    end;
  finally
    DMBaseDatos.QListado.Close;
  end;
end;

procedure TFLCompras.ARejillaFlotanteExecute(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  case ActiveControl.Tag of
    kEmpresa: if edtempresa.Focused then
                DespliegaRejilla(BGBEmpresa_c);
    kCentro: DespliegaRejilla(BGBCentro_c, [edtempresa.Text]);
    kProveedor: DespliegaRejilla(BGBProveedor_c, [edtempresa.Text]);
    kCalendar:
      if edtfechaIni.Focused then
        DespliegaCalendario(BCBFecha_c)
      else
        DespliegaCalendario(btnFechaHasta1);
  end;
end;

procedure TFLCompras.edtempresaChange(Sender: TObject);
begin
  stEmpresa_c.Caption := desEmpresa(edtempresa.Text);
  edtcentroChange( edtcentro );
  edtproveedorChange( edtproveedor );
end;

procedure TFLCompras.edtcentroChange(Sender: TObject);
begin
  IF edtcentro.Text = '' then
  begin
    stCentro_c.Caption:= 'Vacio todos los centros.';
  end
  else
  begin
    stCentro_c.Caption:= desCentro( edtempresa.text, edtcentro.text );
  end;
end;

procedure TFLCompras.edtproveedorChange(Sender: TObject);
begin
  IF edtproveedor.Text = '' then
  begin
    stProveedor_c.Caption:= 'Vacio todos los proveedores.';
  end
  else
  begin
    stProveedor_c.Caption:= desProveedor( edtempresa.text, edtproveedor.text );
  end;
end;

procedure TFLCompras.btnOkClick(Sender: TObject);
begin
  if ValidarCampos then
    Previsualizar;
end;

procedure TFLCompras.btnCancelClick(Sender: TObject);
begin
  Close;
end;

end.
