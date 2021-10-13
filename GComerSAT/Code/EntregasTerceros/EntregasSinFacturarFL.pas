unit EntregasSinFacturarFL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, DBtables, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Derror, Grids,
  DBGrids, BGrid, CheckLst;

type
  TFLEntregasSinFacturar = class(TForm)
    Panel1: TPanel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    Label3: TLabel;
    eEmpresa: TBEdit;
    STEmpresa: TStaticText;
    Label1: TLabel;
    EDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label2: TLabel;
    EHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    QEntregasSinFacturar: TQuery;
    Label4: TLabel;
    txtProveedor: TStaticText;
    lblNombre1: TLabel;
    edtProducto: TBEdit;
    txtProducto: TStaticText;
    edtProveedor: TBEdit;
    lbl1: TLabel;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure EHastaExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure eEmpresaChange(Sender: TObject);
    procedure eProveedorChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);

  private
    {private declarations}
    function  ConsultaGastosEntregas: boolean;
    procedure ConfiguraGastosEntregas;

    function  ParametrosCorrectos: boolean;
  public
    { Public declarations }
  end;

implementation

uses Principal, CVariables, CAuxiliarDB, CReportes,
  EntregasSinFacturarQL, DPreview, UDMAuxDB;

{$R *.DFM}

//                          **** FORMULARIO ****

procedure TFLEntregasSinFacturar.ConfiguraGastosEntregas;
begin
  with QEntregasSinFacturar.SQL do
  begin
    Clear;

    Add('  select proveedor_ec, codigo_ec, fecha_llegada_ec, albaran_ec, vehiculo_ec, ');
    Add('         producto_el, sum(kilos_el) kilos_el');
    Add('  from frf_entregas_c, frf_entregas_l ');
    Add('  where empresa_ec = :empresa ');
    if edtProveedor.Text <> '' then
      Add(' and proveedor_ec = :proveedor ');
    Add('  AND   fecha_llegada_ec BETWEEN :desde AND :hasta ');
    Add('  AND   NOT EXISTS ( ');
    Add('                     SELECT * FROM frf_gastos_entregas ');
    Add('                     WHERE codigo_ge = codigo_ec ');
//    Add('                     AND   tipo_ge = ''110'' ) ');
    Add('                     AND   tipo_ge = ''054'' ) ');       //Cambios 061 por 054, para unificar tipo gasto de SAT  y BAG
    Add('  and   codigo_ec = codigo_el ');
    if edtProducto.Text <> '' then
      Add(' and producto_el = :producto ');
    Add(' and fecha_llegada_ec > :fechacorte ');
    Add('  group by proveedor_ec, codigo_ec, fecha_llegada_ec, albaran_ec, vehiculo_ec, ');
    Add('         producto_el ');
    Add('  order by fecha_llegada_ec, codigo_ec, producto_el ');
  end;
end;

procedure TFLEntregasSinFacturar.FormCreate(Sender: TObject);
var
  dAux: TDateTime;
begin
  gRF := nil;
  gCF := nil;

  FormType := tfOther;
  BHFormulario;

  dAux:= IncMonth( Date-1, -12);
  if dAux < StrToDate('28/6/2009') then
    dAux:= StrToDate('28/6/2009');
  EDesde.Text := DateTostr(dAux);
  EHasta.Text := DateTostr(Date-1);
  CalendarioFlotante.Date := Date;
  eEmpresa.Text:= gsDefEmpresa;
  edtProveedor.Text:= '';
  eProveedorChange( edtProveedor );
  edtProducto.Text:= '';
  edtProductoChange( edtProducto );

  EDesde.Tag := kCalendar;
  EHasta.Tag := kCalendar;

  eEmpresa.Tag:= kEmpresa;

  gCF := calendarioFlotante;
end;

procedure TFLEntregasSinFacturar.FormActivate(Sender: TObject);
begin
  ActiveControl := eEmpresa;
end;

procedure TFLEntregasSinFacturar.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLEntregasSinFacturar.FormClose(Sender: TObject;
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

//                         ****  BOTONES  ****

procedure TFLEntregasSinFacturar.BBAceptarClick(Sender: TObject);
var
  bMostrarReport: boolean;
  sAux: string;
  iTiposdeGastos: integer;
begin
  if not CerrarForm(true) then
    Exit;
  if not ParametrosCorrectos then
    Exit;

  //Llamamos al QReport
  QLEntregasSinFacturar := TQLEntregasSinFacturar.Create(Application);
  try
    bMostrarReport:= ConsultaGastosEntregas;
    if bMostrarReport then
    begin
      QLEntregasSinFacturar.sEmpresa:= eEmpresa.Text;
      QLEntregasSinFacturar.LPeriodo.Caption := EDesde.Text + ' a ' + EHasta.Text;
      PonLogoGrupoBonnysa(QLEntregasSinFacturar, eEmpresa.Text );

      QLEntregasSinFacturar.lblTipoGastos.Caption:= 'Facturas Seleccionadas: ' + sAux;
      if edtProveedor.Text <> '' then
        QLEntregasSinFacturar.lblCliente.Caption:= edtProveedor.Text + ' ' + txtProveedor.Caption
      else
        QLEntregasSinFacturar.lblCliente.Caption:= '';
      QLEntregasSinFacturar.bndCabecera.Height:= 90;

      Preview(QLEntregasSinFacturar);
    end
    else
    begin
      FreeAndNil(QLEntregasSinFacturar);
    end;
  except
    FreeAndNil(QLEntregasSinFacturar);
    Raise;
  end;
end;

procedure TFLEntregasSinFacturar.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                     ****  CAMPOS DE EDICION  ****

procedure TFLEntregasSinFacturar.EHastaExit(Sender: TObject);
begin
  if StrToDate(EHasta.Text) < StrToDate(EDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    EDesde.SetFocus;
  end;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLEntregasSinFacturar.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kCalendar:
      begin
        if EDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

//                     *** PROCEDIMIENTOS PRIVADOS ***


function TFLEntregasSinFacturar.ConsultaGastosEntregas: Boolean;
begin
  ConfiguraGastosEntregas;
  with QEntregasSinFacturar do
  begin
    Close;
    ParamByName('empresa').AsString := eEmpresa.Text;
    if edtProveedor.Text <> '' then
      ParamByName('proveedor').AsString := edtProveedor.Text;
    ParamByName('desde').AsDate := StrToDate(EDesde.Text);
    ParamByName('hasta').AsDate := StrToDate(EHasta.Text);
    ParamByName('fechacorte').AsDateTime := StrTodate( '28/6/2009' );    
    if edtProducto.Text <> '' then
      ParamByName('producto').AsString := edtProducto.Text;
    try
      Open;
    except
      on E: EDBEngineError do
      begin
        ShowError(E);
        raise;
      end;
    end;
  end;

  if QEntregasSinFacturar.IsEmpty then
  begin
    ShowMessage('Sin datos para los parametros seleccionados.');
    result:= False;
  end
  else
  begin
    result:= True;
  end;
end;

function TFLEntregasSinFacturar.ParametrosCorrectos: boolean;
var
  dIni, dFin: TDateTime;
begin
  result:= False;
  if Trim( eEmpresa.Text ) = '' then
  begin
    ShowMessage('El código de la empresa es de obligada inserción.');
    eEmpresa.SetFocus;
  end
  else
  if not TryStrToDate( EDesde.Text, dIni ) then
  begin
    ShowMessage('Fecha de incio incorrecta.');
    EDesde.SetFocus;
  end
  else
  if not TryStrToDate( EHasta.Text, dFin ) then
  begin
    ShowMessage('Fecha de fin incorrecta.');
    EHasta.SetFocus;
  end
  else
  if dIni > dFin then
  begin
    ShowMessage('Rango de fechas incorrecto.');
    EDesde.SetFocus;
  end
  else
  if txtProveedor.Caption = '' then
  begin
    ShowMessage('Proveedor incorrecto.');
    edtProveedor.SetFocus;
  end
  else
  if txtProducto.Caption = '' then
  begin
    ShowMessage('Producto incorrecto.');
    edtProducto.SetFocus;
  end
  else
  begin
    result:= true;
  end;
end;

procedure TFLEntregasSinFacturar.eEmpresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(eEmpresa.Text);
end;

procedure TFLEntregasSinFacturar.eProveedorChange(Sender: TObject);
begin
  if edtProveedor.Text <> '' then
    txtProveedor.Caption := desProveedor(eEmpresa.Text, edtProveedor.Text)
  else
    txtProveedor.Caption := 'Vacio todos los proveedores.';
end;

procedure TFLEntregasSinFacturar.edtProductoChange(Sender: TObject);
begin
  if edtProducto.Text <> '' then
    txtProducto.Caption := desProducto(eEmpresa.Text, edtProducto.Text)
  else
    txtProducto.Caption := 'Vacio todos los productos.';
end;

end.
