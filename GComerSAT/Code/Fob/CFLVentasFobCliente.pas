unit CFLVentasFobCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Provider, DB, DBClient, DBTables, Grids,
  DBGrids, CDLVentasFobCliente, ActnList, ComCtrls, BCalendario, BGrid, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, nbEdits, nbCombos, nbButtons,
  ExtCtrls;

type
  TFLVentasFobCliente = class(TForm)
    btnCancel: TBitBtn;
    btnOk: TBitBtn;
    Lcategoria: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Desde: TLabel;
    Label14: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    STEmpresa: TStaticText;
    STProducto: TStaticText;
    empresa: TnbDBSQLCombo;
    producto: TnbDBSQLCombo;
    edtCentroOrigen: TnbDBSQLCombo;
    edtCentroSalida: TnbDBSQLCombo;
    edtCliente: TnbDBSQLCombo;
    fechaDesde: TnbDBCalendarCombo;
    fechaHasta: TnbDBCalendarCombo;
    categoria: TnbDBAlfa;
    subPanel1: TPanel;
    Bevel1: TBevel;
    Label13: TLabel;
    chkEnvase: TCheckBox;
    cbxGasto: TCheckBox;
    stCliente: TStaticText;
    stOrigen: TStaticText;
    stSalida: TStaticText;
    chkDescuento: TCheckBox;
    cbbCliente: TComboBox;
    lbl1: TLabel;
    lblFechaFactura: TLabel;
    FechaFacturaDesde: TnbDBCalendarCombo;
    lblFechaFacturaHasta: TLabel;
    FechaFacturaHasta: TnbDBCalendarCombo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    function productoGetSQL: string;
    function edtCentroOrigenGetSQL: string;
    function edtClienteGetSQL: string;
    procedure cbxNacionalidadKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure empresaChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
    function edtEnvaseGetSQL: String;
    procedure edtCentroOrigenChange(Sender: TObject);
    procedure edtCentroSalidaChange(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
  private
    { Private declarations }
    DLVentasFobCliente: TDLVentasFobCliente;
    sEmpresa, sOrigen, sSalida, sFechaDesde, sFechaHasta, sFechaFacturaDesde, sFechaFacturaHasta, sCliente, sProducto, sCategoria: string;
    bClienteIgual, bDescuento ,bGastoAlbaran, bCosteEnvase: boolean;


    function  ValidarEntrada: boolean;
    procedure Previsualizar;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


uses CQLVentasFobCliente, UDMConfig, DPreview, Principal,
     CVariables, CGestionPrincipal, UDMAuxDB, CReportes, bTimeUtils;

procedure TFLVentasFobCliente.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;
  DLVentasFobCliente := TDLVentasFobCliente.Create(self);

  empresa.Text := gsDefEmpresa;

  fechaDesde.AsDate := LunesAnterior( Date - 7 );
  fechaHasta.AsDate := fechaDesde.AsDate + 6;
  fechaFacturaDesde.AsDate := LunesAnterior( Date - 7 );
  fechaFacturaHasta.AsDate := fechaFacturaDesde.AsDate + 6;
end;

procedure TFLVentasFobCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');

  //Liberamos memoria
  FreeAndNil(DLVentasFobCliente);
  Action := caFree;
end;

function TFLVentasFobCliente.ValidarEntrada: boolean;
var
  sAux: string;
  dIni, dFin: TDateTime;
begin
  result:= True;
  sAux:= '';
  if STEmpresa.Caption = '' then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'Falta o es incorrecto el código de la empresa.';
  end;
  if STProducto.Caption = '' then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'El código del producto es incorrecto.';
  end;
  if stOrigen.Caption = '' then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'El código del centro origen es incorrecto.';
  end;
  if stSalida.Caption = '' then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'El código del centro salida es incorrecto.';
  end;
  if stCliente.Caption = '' then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'El código del cliente es incorrecto.';
  end;
  dini:= date;
  dfin:= date;
  if not TryStrTodate( fechaDesde.Text, dIni ) then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'Fecha de inicio salida incorrecta.';
  end;
  if not TryStrTodate( fechaHasta.Text, dFin ) then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'Fecha de fin salida incorrecta.';
  end;
  if dIni > dFin then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'Rango de fechas de sailda incorrecto.';
  end;

  if not TryStrTodate( fechaFacturaDesde.Text, dIni ) then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'Fecha de inicio factura incorrecta.';
  end;
  if not TryStrTodate( fechaFacturaHasta.Text, dFin ) then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'Fecha de fin factura incorrecta.';
  end;
  if dIni > dFin then
  begin
    result:= False;
    sAux:= sAux + #13 + #10 + 'Rango de fechas de facturacion incorrecto.';
  end;

  if result then
  begin
    sEmpresa:= empresa.Text;
    sOrigen:= edtCentroOrigen.Text;
    sSalida:= edtCentroSalida.Text;
    sFechaDesde:= fechaDesde.Text;
    sFechaHasta:= fechaHasta.Text;
    sFechaFacturaDesde:= fechaFacturaDesde.Text;
    sFechaFacturaHasta:= fechaFacturaHasta.Text;
    sCliente:= edtCliente.Text;
    sProducto := producto.Text;
    sCategoria:= categoria.Text;

    bClienteIgual:= cbbCliente.ItemIndex = 0;
    bDescuento:= chkDescuento.checked;
    bGastoAlbaran:= cbxGasto.checked;
    bCosteEnvase:= chkEnvase.checked;

  end
  else
  begin
    ShowMessage( sAux );
  end;
end;

procedure TFLVentasFobCliente.btnOkClick(Sender: TObject);
begin
  if ValidarEntrada then
  begin
    if DLVentasFobCliente.ObtenerDatos(sEmpresa, sOrigen, sSalida, sFechaDesde, sFechaHasta, sFechaFacturaDesde, sFechaFacturaHasta, '', sCliente,
       sProducto, '', sCategoria, bClienteIgual, bDescuento, bGastoAlbaran, False, bCosteEnvase, bCosteEnvase, False, False, True ) then
    begin
      DLVentasFobCliente.ListadoFOB;
      Previsualizar;
    end
    else
    begin
      ShowMessage('Sin Datos.');
    end;
  end;
end;


procedure TFLVentasFobCliente.Previsualizar;
var
  QLVentasFobCliente: TQLVentasFobCliente;
begin
  QLVentasFobCliente := TQLVentasFobCliente.Create(Application);
  PonLogoGrupoBonnysa(QLVentasFobCliente, empresa.Text);
  QLVentasFobCliente.sEmpresa := empresa.Text;
  QLVentasFobCliente.bDescuentos:= chkDescuento.Checked;
  QLVentasFobCliente.bGasto:= cbxGasto.Checked;
  QLVentasFobCliente.bEnvase:= chkEnvase.Checked;

  if edtCentroOrigen.Text = '' then
    QLVentasFobCliente.qrlOrigen.Caption := 'ORIGEN TODOS LOS CENTROS'
  else
    QLVentasFobCliente.qrlOrigen.Caption := 'ORIGEN ' + stOrigen.Caption;

  if edtCentroSalida.Text = '' then
    QLVentasFobCliente.qrlDestino.Caption := 'SALIDA TODOS LOS CENTROS'
  else
    QLVentasFobCliente.qrlDestino.Caption := 'DESTINO ' + stSalida.Caption;

  QLVentasFobCliente.LPeriodo.Caption := 'SALIDAS DEL ' + fechaDesde.Text + ' AL ' + fechaHasta.Text;
  QLVentasFobCliente.LPeriodoFacturas.Caption := 'FACTURADO DEL ' + fechaFacturaDesde.Text + ' AL ' + fechaFacturaHasta.Text;
  if categoria.Text <> '' then
  begin
    case StrToInt(Categoria.Text) of
      1: QLVentasFobCliente.LCategoria.Caption := 'CATEGORÍA: PRIMERA';
      2: QLVentasFobCliente.LCategoria.Caption := 'CATEGORÍA: SEGUNDA';
      3: QLVentasFobCliente.LCategoria.Caption := 'CATEGORÍA: TERCERA';
    else QLVentasFobCliente.LCategoria.Caption := 'CATEGORÍA: ' + Trim(Categoria.Text);
    end;
  end
  else
  begin
    QLVentasFobCliente.LCategoria.Caption := 'CATEGORÍA: TODAS';
  end;
  Preview(QLVentasFobCliente);
end;

procedure TFLVentasFobCliente.btnCancelClick(Sender: TObject);
begin
  Close;
end;

function TFLVentasFobCliente.productoGetSQL: string;
begin
  result := 'select producto_p, descripcion_p from frf_productos order by producto_p ';
end;

function TFLVentasFobCliente.edtCentroOrigenGetSQL: string;
begin
  if empresa.Text <> '' then
    result := 'select centro_c, descripcion_c from frf_centros where empresa_c = ' +
      empresa.GetSQLText + ' order by centro_c '
  else
    result := 'select centro_c, descripcion_c from frf_centros order by centro_c ';
end;

function TFLVentasFobCliente.edtEnvaseGetSQL: String;
begin
  result := 'select envase_e, descripcion_e from frf_envases order by envase_e ';
end;

function TFLVentasFobCliente.edtClienteGetSQL: string;
begin
    result := 'select cliente_c, nombre_c from frf_clientes order by cliente_c ';
end;

procedure TFLVentasFobCliente.cbxNacionalidadKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_return then PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
end;

procedure TFLVentasFobCliente.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_f1 then btnOk.Click else
    if Key = vk_escape then btnCancel.Click;
end;

procedure TFLVentasFobCliente.empresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(empresa.Text);
  productoChange( producto );
  edtCentroOrigenChange( edtCentroOrigen );
  edtCentroSalidaChange( edtCentroSalida );
  edtClienteChange( edtCliente  );
end;

procedure TFLVentasFobCliente.productoChange(Sender: TObject);
begin

  if producto.Text = '' then
  begin
    STProducto.Caption := 'Vacio todos los productos';
  end
  else
  begin
    STProducto.Caption := desProducto(empresa.Text, producto.Text);
  end;
end;

procedure TFLVentasFobCliente.edtCentroOrigenChange(Sender: TObject);
begin
  if edtCentroOrigen.Text = '' then
  begin
    stOrigen.Caption:= 'Vacio todos los centros';
  end
  else
  begin
    stOrigen.Caption:= desCentro( empresa.Text, edtCentroOrigen.Text);
  end;
end;

procedure TFLVentasFobCliente.edtCentroSalidaChange(Sender: TObject);
begin
  if edtCentroSalida.Text = '' then
  begin
    stSalida.Caption:= 'Vacio todos los centros';
  end
  else
  begin
    stSalida.Caption:= desCentro( empresa.Text, edtCentroSalida.Text);
  end;
end;

procedure TFLVentasFobCliente.edtClienteChange(Sender: TObject);
begin
  if edtCliente.Text = '' then
  begin
    stCliente.Caption:= 'Vacio todos los clientes';
  end
  else
  begin
    stCliente.Caption:= desCliente( edtCliente.Text);
  end;
end;

end.
