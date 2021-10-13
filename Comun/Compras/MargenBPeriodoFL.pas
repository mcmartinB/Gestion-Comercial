unit MargenBPeriodoFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit, ExtCtrls,
  BCalendarButton, BSpeedButton, BGridButton, Grids, DBGrids, BGrid,
  ComCtrls, BCalendario;

type
  TFLMargenBPeriodo = class(TForm)
    btnCerrar: TBitBtn;
    btnAceptar: TBitBtn;
    lblNombre1: TLabel;
    eEmpresa: TBEdit;
    btnEmpresa: TBGridButton;
    lEmpresa: TStaticText;
    Desde: TLabel;
    eFechaDesde: TBEdit;
    btnFechaDesde: TBCalendarButton;
    lblNombre2: TLabel;
    eFechaHasta: TBEdit;
    btnFechaHasta: TBCalendarButton;
    lblNombre3: TLabel;
    eProducto: TBEdit;
    btnProducto: TBGridButton;
    lProducto: TStaticText;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    lblCliente: TLabel;
    edtCliente: TBEdit;
    btnCliente: TBGridButton;
    txtCliente: TStaticText;
    chkCompra: TCheckBox;
    chkTransporte: TCheckBox;
    chkMaterial: TCheckBox;
    chkPersonal: TCheckBox;
    chkGeneral: TCheckBox;
    chkFinanciero: TCheckBox;
    chkTransito: TCheckBox;
    chkGastoVenta: TCheckBox;
    btnPaletsVolcados: TButton;
    btnPaletsConfeccionados: TButton;
    btnPaletsCargados: TButton;
    btnVentas: TButton;
    btnCargaConfeccionada: TButton;
    btnAdelantadoAnterior: TButton;
    btnAdelantadoSiguiente: TButton;
    btnSockIni: TButton;
    btnStockFin: TButton;
    btnStockProveedorIni: TButton;
    btnStockProveedorFin: TButton;
    chkImporteAbonos: TCheckBox;
    chkImporteVentas: TCheckBox;
    bvl1: TBevel;
    bvl2: TBevel;
    bvl3: TBevel;
    btConfTransitos: TButton;
    txt1: TStaticText;
    txt2: TStaticText;
    txt3: TStaticText;
    btnConfTransitos: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure botonClick(Sender: TObject);
    procedure PonNombreEmpresa(Sender: TObject);
    procedure PonNombreProducto(Sender: TObject);
    procedure PonNombreCliente(Sender: TObject);
    procedure btnPaletsVolcadosClick(Sender: TObject);
    procedure btnPaletsConfeccionadosClick(Sender: TObject);
    procedure btnPaletsCargadosClick(Sender: TObject);
    procedure btnVentasClick(Sender: TObject);
    procedure btnCargaConfeccionadaClick(Sender: TObject);
    procedure btnAdelantadoAnteriorClick(Sender: TObject);
    procedure btnAdelantadoSiguienteClick(Sender: TObject);
    procedure btnStockFinClick(Sender: TObject);
    procedure btnSockIniClick(Sender: TObject);
    procedure btnStockProveedorIniClick(Sender: TObject);
    procedure btnStockProveedorFinClick(Sender: TObject);
    procedure btnConfTransitosClick(Sender: TObject);
    procedure btConfTransitosClick(Sender: TObject);
  private
    { Private declarations }
    bCentral: Boolean;
    sEmpresa, sProducto, sCliente: string;
    dFechaIni, dFechaFin: TDateTime;

    procedure ValidarCampos;
    procedure ChecksActivos( const AFlag: Boolean );
    procedure ConfiguraVersion( const ACentral: Boolean );

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  MargenBProveedorDL, MargenBConfeccionDL, MargenBVentasDL,
  CVariables, Principal, CGestionPrincipal, UDMAuxDB, UDMBaseDatos, UDMConfig,
  bTimeUtils, CAuxiliarDB, MargenBCodeComunDL;


var
  CostesAplicar: RCostesAplicar;

procedure TFLMargenBPeriodo.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  eEmpresa.Tag := kEmpresa;
  eProducto.Tag := kProducto;
  edtCliente.Tag := kCliente;
  eFechaDesde.Tag := kCalendar;
  eFechaHasta.Tag := kCalendar;

  eFechaDesde.Text := DateToStr( LunesAnterior( date ) - 7 );
  eFechaHasta.Text := DateToStr( LunesAnterior( date ) - 1 );

  eEmpresa.Text:= gsDefEmpresa;
  eProducto.Text:= 'D';
  edtCliente.Text:= '';

  CalendarioFlotante.Date := Date - 1;
  PonNombreEmpresa( eEmpresa );

  ConfiguraVersion( DMConfig.iInstalacion = 10 );
end;

procedure TFLMargenBPeriodo.ConfiguraVersion( const ACentral: Boolean );
begin
  bCentral:= ACentral;
  ChecksActivos( ACentral );
  if ACentral then
  begin
    Caption:= 'MARGEN DE BENEFICIOS';
  end
  else
  begin
    Caption:= 'PARTE DE CONFECCIÓN';
  end;
end;

procedure TFLMargenBPeriodo.ChecksActivos( const AFlag: Boolean );
begin
  chkCompra.Visible:= AFlag;
  chkCompra.Checked:= AFlag;
  chkTransporte.Visible:= AFlag;
  chkTransporte.Checked:= AFlag;
  chkTransito.Visible:= AFlag;
  chkTransito.Checked:= AFlag;
  chkGastoVenta.Visible:= AFlag;
  chkGastoVenta.Checked:= AFlag;
  chkMaterial.Visible:= AFlag;
  chkMaterial.Checked:= AFlag;
  chkPersonal.Visible:= AFlag;
  chkPersonal.Checked:= AFlag;
  chkGeneral.Visible:= AFlag;
  chkGeneral.Checked:= AFlag;
  chkFinanciero.Visible:= AFlag;
  chkFinanciero.Checked:= AFlag;
  chkImporteAbonos.Visible:= AFlag;
  chkImporteAbonos.Checked:= AFlag;
  chkImporteVentas.Visible:= AFlag;
  chkImporteVentas.Checked:= AFlag;
end;

procedure TFLMargenBPeriodo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;

  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLMargenBPeriodo.ValidarCampos;
begin
  //Comprobamos que los campos esten todos con datos
  if lEmpresa.caption = '' then
  begin
    EEmpresa.SetFocus;
    raise Exception.Create( 'Falta el código de la empresa o es incorrecto.');
  end;
  sEmpresa:= eEmpresa.Text;

  if lProducto.Caption = '' then
  begin
    eProducto.SetFocus;
    raise Exception.Create( 'Falta el código del producto o es incorrecto.');
    //raise Exception.Create( 'El código del producto es incorrecto.');
  end;
  sProducto:= eProducto.Text;

  if txtCliente.Caption = '' then
  begin
    edtCliente.SetFocus;
    raise Exception.Create( 'El código del cliente es incorrecto.');
  end;
  sCliente:= edtCliente.Text;

  if not TryStrToDate( eFechaDesde.Text, dFechaIni ) then
  begin
    eFechaDesde.SetFocus;
    raise Exception.Create( 'La fecha de inicio es incorrecta.');
  end;

  if not TryStrToDate( eFechaHasta.Text, dFechaFin ) then
  begin
    eFechaHasta.SetFocus;
    raise Exception.Create( 'La fecha de fin es incorrecta.');
  end;

  if dFechaFin < dFechaIni then
  begin
    eFechaDesde.SetFocus;
    raise Exception.Create( 'Rango de fechas incorrecto.');
  end;

  CostesAplicar.bCompra:= chkCompra.Checked;
  CostesAplicar.bTransporte:= chkTransporte.Checked;
  CostesAplicar.bTransito:= chkTransito.Checked;
  CostesAplicar.bImporteVenta:= chkImporteVentas.Checked;
  CostesAplicar.bGastosVenta:= chkGastoVenta.Checked;
  CostesAplicar.bImporteAbonos:= chkImporteAbonos.Checked;
  CostesAplicar.bMaterial:= chkMaterial.Checked;
  CostesAplicar.bPersonal:= chkPersonal.Checked;
  CostesAplicar.bGeneral:= chkGeneral.Checked;
  CostesAplicar.bFinanciero:= chkFinanciero.Checked;
  CostesAplicar.bEstadistico:= False;
end;


procedure TFLMargenBPeriodo.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLMargenBPeriodo.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnAceptar.Click;
  end;
end;

procedure TFLMargenBPeriodo.FormKeyDown(Sender: TObject; var Key: Word;
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
    vk_f2:
      begin
        Key := 0;
        botonClick( Sender );
      end;
  end;
end;

procedure TFLMargenBPeriodo.botonClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kProducto: DespliegaRejilla(btnProducto,[eEmpresa.Text]);
    kCliente: DespliegaRejilla(btnCliente,[eEmpresa.Text]);
    kCalendar:
      begin
        if eFechaDesde.Focused then
          DespliegaCalendario(btnFechaDesde)
        else
          DespliegaCalendario(btnFechaHasta);
      end;
  end;
end;

procedure TFLMargenBPeriodo.PonNombreEmpresa(Sender: TObject);
begin
  lEmpresa.Caption := desEmpresa(eEmpresa.Text );
  PonNombreProducto( eProducto );
  PonNombreCliente( edtCliente );
end;

procedure TFLMargenBPeriodo.PonNombreProducto(Sender: TObject);
begin
  lProducto.Caption := desProducto(eEmpresa.Text, eProducto.Text );
  (*
  if eProducto.Text = '' then
  begin
    lProducto.Caption := 'TODOS LOS PRODUCTOS';
  end
  else
  begin
    lProducto.Caption := desProducto(eEmpresa.Text, eProducto.Text );
  end;
  *)
end;

procedure TFLMargenBPeriodo.PonNombreCliente(Sender: TObject);
begin
  if edtCliente.Text = '' then
  begin
    txtCliente.Caption := 'TODOS LOS CLIENTES';
  end
  else
  begin
    txtCliente.Caption := desCliente( edtCliente.Text );
  end;
end;


procedure TFLMargenBPeriodo.btnPaletsCargadosClick(Sender: TObject);
begin
  ValidarCampos;
  MargenBProveedorDL.ViewPaletsProveedor( sEmpresa, sProducto, sCliente, dFechaIni, dFechaFin, CostesAplicar, tvCargados );
end;

procedure TFLMargenBPeriodo.btnConfTransitosClick(Sender: TObject);
begin
  ValidarCampos;
  MargenBProveedorDL.ViewPaletsProveedor( sEmpresa, sProducto, sCliente, dFechaIni, dFechaFin, CostesAplicar, tvVentas );
end;

procedure TFLMargenBPeriodo.btConfTransitosClick(Sender: TObject);
begin
  ValidarCampos;
  MargenBProveedorDL.ViewPaletsProveedor( sEmpresa, sProducto, sCliente, dFechaIni, dFechaFin, CostesAplicar, tvTransitos );
end;

procedure TFLMargenBPeriodo.btnPaletsVolcadosClick(Sender: TObject);
begin
  ValidarCampos;
  MargenBProveedorDL.ViewPaletsProveedor( sEmpresa, sProducto, sCliente, dFechaIni, dFechaFin, CostesAplicar, tvVolcados );
end;

procedure TFLMargenBPeriodo.btnPaletsConfeccionadosClick(Sender: TObject);
begin
  ValidarCampos;
  MargenBConfeccionDL.ViewPaletsConfeccionados( sEmpresa, sProducto, sCliente, dFechaIni, dFechaFin, CostesAplicar, tcAlta );
end;

procedure TFLMargenBPeriodo.btnVentasClick(Sender: TObject);
begin
  ValidarCampos;
  MargenBVentasDL.ViewVentas( sEmpresa, sProducto, sCliente, dFechaIni, dFechaFin, CostesAplicar );
end;

procedure TFLMargenBPeriodo.btnCargaConfeccionadaClick(Sender: TObject);
begin
  ValidarCampos;
  MargenBConfeccionDL.ViewPaletsConfeccionados( sEmpresa, sProducto, sCliente, dFechaIni, dFechaFin, CostesAplicar, TcCarga );
end;


procedure TFLMargenBPeriodo.btnAceptarClick(Sender: TObject);
begin
  ValidarCampos;
  if bCentral then
    MargenBCodeComunDL.ViewMargenOperativo( sEmpresa, sProducto, sCliente, dFechaIni, dFechaFin, CostesAplicar )
  else
    MargenBCodeComunDL.ViewParteConfeccion( sEmpresa, sProducto, sCliente, dFechaIni, dFechaFin, CostesAplicar );
end;

procedure TFLMargenBPeriodo.btnAdelantadoAnteriorClick(Sender: TObject);
begin
  ValidarCampos;
  MargenBConfeccionDL.ViewPaletsConfeccionados( sEmpresa, sProducto, sCliente, dFechaIni, dFechaFin, CostesAplicar, tcAnterior );
end;

procedure TFLMargenBPeriodo.btnAdelantadoSiguienteClick(Sender: TObject);
begin
  ValidarCampos;
  MargenBConfeccionDL.ViewPaletsConfeccionados( sEmpresa, sProducto, sCliente, dFechaIni, dFechaFin, CostesAplicar, tcSiguiente );
end;

procedure TFLMargenBPeriodo.btnSockIniClick(Sender: TObject);
begin
  ValidarCampos;
  MargenBConfeccionDL.ViewPaletsConfeccionados( sEmpresa, sProducto, sCliente, dFechaIni, dFechaIni, CostesAplicar, tcStock );
end;

procedure TFLMargenBPeriodo.btnStockFinClick(Sender: TObject);
begin
  ValidarCampos;
  MargenBConfeccionDL.ViewPaletsConfeccionados( sEmpresa, sProducto, sCliente,  dFechaFin, dFechaFin, CostesAplicar, tcStock );
end;

procedure TFLMargenBPeriodo.btnStockProveedorIniClick(Sender: TObject);
begin
  ValidarCampos;
  MargenBProveedorDL.ViewPaletsProveedor( sEmpresa, sProducto, sCliente, dFechaIni, dFechaIni, CostesAplicar, tvStock );
end;

procedure TFLMargenBPeriodo.btnStockProveedorFinClick(Sender: TObject);
begin
  ValidarCampos;
  MargenBProveedorDL.ViewPaletsProveedor( sEmpresa, sProducto, sCliente, dFechaFin, dFechaFin, CostesAplicar, tvStock );
end;

end.


