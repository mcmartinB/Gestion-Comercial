unit UFLFichaSecciones;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, DB, Grids, DBGrids, nbEdits,
  nbCombos;

type
  TFLFichaSecciones = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel1: TnbLabel;
    des_empresa: TnbStaticText;
    lblCentro: TnbLabel;
    stCentro: TnbStaticText;
    lblproducto: TnbLabel;
    stProducto: TnbStaticText;
    lblProveedor: TnbLabel;
    stProveedor: TnbStaticText;
    lblFecha: TnbLabel;
    edtFecha: TnbDBCalendarCombo;
    edtTipoEntrada: TnbDBSQLCombo;
    lblTipoEntrada: TnbLabel;
    stTipoEntrada: TnbStaticText;
    edtEmpresa: TnbDBSQLCombo;
    edtCentro: TnbDBSQLCombo;
    edtProducto: TnbDBSQLCombo;
    edtProductor: TnbDBSQLCombo;
    chkProductos: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtTipoEntradaChange(Sender: TObject);
    function edtTipoEntradaGetSQL: String;
    procedure edtEmpresaChange(Sender: TObject);
    function edtEmpresaGetSQL: String;
    procedure edtCentroChange(Sender: TObject);
    function edtCentroGetSQL: String;
    procedure edtProductoChange(Sender: TObject);
    function edtProductoGetSQL: String;
    procedure edtProductorChange(Sender: TObject);
    function edtProductorGetSQL: String;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     UDMBaseDatos, bSQLUtils, CReportes, DPreview,
     UQLFichaSecciones;

procedure TFLFichaSecciones.FormClose(Sender: TObject;
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

procedure TFLFichaSecciones.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLFichaSecciones.btnAceptarClick(Sender: TObject);
var
  dFecha: TDateTime;
  sAnyoMes: string;
begin
  if des_empresa.Caption = '' then
  begin
    ShowMessage('Falta el codigo de la empresa o es incorrecto');
    Exit;
  end;
  if stCentro.Caption = '' then
  begin
    ShowMessage('El codigo del centro es incorrecto');
    Exit;
  end;
  if stProducto.Caption = '' then
  begin
    ShowMessage('El codigo del producto es incorrecto');
    Exit;
  end;
  if stProveedor.Caption = '' then
  begin
    ShowMessage('El codigo del proveedor es incorrecto');
    Exit;
  end;
  if not TryStrToDate( edtFecha.Text, dFecha ) then
  begin
    ShowMessage('La fecha es incorrecta');
    Exit;
  end;
  sAnyoMes:= FormatDateTime( 'yyyymm', dFecha );

  //Crear el listado
  QLFichaSecciones := TQLFichaSecciones.Create(Application);
  PonLogoGrupoBonnysa(QLFichaSecciones, edtEmpresa.text);
  QLFichaSecciones.QCostesEnvasado.SQL.Clear;
  QLFichaSecciones.QCostesEnvasado.SQL.Add(' SELECT empresa_epc, productor_epc,  nombre_c,producto_epc,  descripcion_p,  centro_epc, ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add('        anyo_mes_epc, tipo_entrada_epc, descripcion_et, env_tcoste_epc, descripcion_etc, anyo_mes_emc, coste_kg_emc ');

  QLFichaSecciones.QCostesEnvasado.SQL.Add(' FROM frf_env_pcostes e1, frf_productos, frf_cosecheros, frf_env_tcostes, frf_entradas_tipo, outer frf_env_mcostes e3 ');

  QLFichaSecciones.QCostesEnvasado.SQL.Add(' WHERE empresa_epc = ' + QuotedStr( edtEmpresa.text ) );
  if edtCentro.Text <> '' then
    QLFichaSecciones.QCostesEnvasado.SQL.Add(' and centro_epc = ' + QuotedStr( edtCentro.text ) );
  if edtProducto.Text <> '' then
    QLFichaSecciones.QCostesEnvasado.SQL.Add(' and producto_epc = ' + QuotedStr( edtProducto.text ) );
  if edtProductor.Text <> '' then
    QLFichaSecciones.QCostesEnvasado.SQL.Add(' and productor_epc = ' + edtProductor.text );
  if edtTipoEntrada.Text <> '' then
    QLFichaSecciones.QCostesEnvasado.SQL.Add(' and tipo_entrada_epc = ' + edtTipoEntrada.text );

  QLFichaSecciones.QCostesEnvasado.SQL.Add(' and anyo_mes_epc = ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add(' ( ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add('   select max(e2.anyo_mes_epc) ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add('   from frf_env_pcostes e2 ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add('   where e2.empresa_epc = e1.empresa_epc ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add('   and e2.centro_epc = e1.centro_epc ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add('   and e2.producto_epc = e1.producto_epc ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add('   and e2.productor_epc = e1.productor_epc ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add('   and e2.anyo_mes_epc <= ' + QuotedStr( sAnyoMes ) );
  QLFichaSecciones.QCostesEnvasado.SQL.Add(' ) ');

  QLFichaSecciones.QCostesEnvasado.SQL.Add(' --frf_productos ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add(' and empresa_epc = empresa_p ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add(' and producto_epc = producto_p ');

  QLFichaSecciones.QCostesEnvasado.SQL.Add(' --frf_cosecheros ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add(' and empresa_epc = empresa_c ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add(' and productor_epc = cosechero_c ');

  QLFichaSecciones.QCostesEnvasado.SQL.Add(' --frf_env_tcostes ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add(' and env_tcoste_epc = env_tcoste_etc ');

  QLFichaSecciones.QCostesEnvasado.SQL.Add(' --frf_entradas_tipo ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add(' and empresa_et = empresa_epc ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add(' and tipo_et = tipo_entrada_epc ');

  QLFichaSecciones.QCostesEnvasado.SQL.Add('  -- frf_env_mcostes ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add('    and empresa_emc = ' + QuotedStr( edtEmpresa.text ) );
  QLFichaSecciones.QCostesEnvasado.SQL.Add('    and centro_emc = centro_epc ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add('    and env_tcoste_emc = env_tcoste_epc ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add('  and anyo_mes_emc = ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add('  ( ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add('    select max(e4.anyo_mes_emc) ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add('    from frf_env_mcostes e4 ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add('    where e3.empresa_emc = e4.empresa_emc ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add('    and e3.centro_emc = e4.centro_emc ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add('    and e3.env_tcoste_emc = e4.env_tcoste_emc ');
  QLFichaSecciones.QCostesEnvasado.SQL.Add('    and e3.anyo_mes_emc <= ' + QuotedStr( sAnyoMes ) );
  QLFichaSecciones.QCostesEnvasado.SQL.Add('  ) ');

  QLFichaSecciones.QCostesEnvasado.SQL.Add(' ORDER BY empresa_epc, centro_epc, producto_epc,  productor_epc, tipo_entrada_epc, env_tcoste_epc ');
  QLFichaSecciones.QCostesEnvasado.Open;
  QLFichaSecciones.qrlFecha.Caption:= ' Activas al ' + edtFecha.Text;
  if chkProductos.Checked then
  begin
    QLFichaSecciones.BandaCorte.Height := 0;
    QLFichaSecciones.BandaCorte.ForceNewPage:= True;
    QLFichaSecciones.qreCentro.Enabled:= True;
  end
  else
  begin
    QLFichaSecciones.BandaCorte.Height := 20;
    QLFichaSecciones.BandaCorte.ForceNewPage:= False;
    QLFichaSecciones.qreCentro.Enabled:= False;
  end;
  Preview(QLFichaSecciones);
end;


procedure TFLFichaSecciones.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLFichaSecciones.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLFichaSecciones.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Text := gsDefEmpresa;
  edtCentro.Text:= '';
  edtProducto.Text:= '';
  edtProductor.Text:= '';
  edtCentroChange( edtCentro );
  edtProductoChange( edtProducto);
  edtProductorChange( edtProductor );
  edtFecha.AsDate:= Date;
end;

procedure TFLFichaSecciones.edtEmpresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(edtEmpresa.Text);
  edtCentroChange( edtCentro );
  edtProductoChange( edtProducto);
  edtProductorChange( edtProductor );
  edtTipoEntradaChange( edtTipoEntrada );
end;

function TFLFichaSecciones.edtEmpresaGetSQL: String;
begin
  result:= result + 'select empresa_e empresa, nombre_e descripcion ';
  result:= result + 'from frf_empresas ';
  result:= result + 'order by empresa_e ';
end;

procedure TFLFichaSecciones.edtCentroChange(Sender: TObject);
begin
  if edtCentro.Text <> '' then
  begin
    stcentro.Caption:= desCentro( edtEmpresa.Text, edtCentro.Text );
  end
  else
  begin
    stcentro.Caption:= 'Vacio todos los centros';
  end;
end;

function TFLFichaSecciones.edtCentroGetSQL: String;
begin
  result:= '';
  if edtEmpresa.Text <> '' then
  begin
    result:= result + 'select empresa_c, centro_c, descripcion_c ';
    result:= result + 'from frf_centros ';
    result:= result + 'where empresa_c = ' + QuotedStr( edtEmpresa.Text );
    result:= result + 'order by empresa_c, centro_c ';
  end
  else
  begin
    result:= result + 'select empresa_c, centro_c, descripcion_c ';
    result:= result + 'from frf_centros ';
    result:= result + 'order by empresa_c, centro_c ';
  end;
end;

procedure TFLFichaSecciones.edtProductoChange(Sender: TObject);
begin
  if edtProducto.Text <> '' then
  begin
    stProducto.Caption:= desProducto( edtEmpresa.Text, edtProducto.Text );
  end
  else
  begin
    stProducto.Caption:= 'Vacio todos los productos';
  end;
end;

function TFLFichaSecciones.edtProductoGetSQL: String;
begin
  result:= '';
  if edtEmpresa.Text <> '' then
  begin
    result:= result + 'select empresa_p, producto_p, descripcion_p ';
    result:= result + 'from frf_productos ';
    result:= result + 'where empresa_p = ' + QuotedStr( edtEmpresa.Text );
    result:= result + 'order by empresa_p, producto_p ';
  end
  else
  begin
    result:= result + 'select empresa_p, producto_p, descripcion_p ';
    result:= result + 'from frf_productos ';
    result:= result + 'order by empresa_p, producto_p ';
  end;
end;

procedure TFLFichaSecciones.edtProductorChange(Sender: TObject);
begin
  if edtProductor.Text <> '' then
  begin
    stProveedor.Caption:= desCosechero( edtEmpresa.Text, edtProductor.Text );
  end
  else
  begin
    stProveedor.Caption:= 'Vacio todos los proveedores';
  end;
end;

function TFLFichaSecciones.edtProductorGetSQL: String;
begin
  result:= '';
  if edtEmpresa.Text <> '' then
  begin
    result:= result + 'select empresa_c, cosechero_c, nombre_c ';
    result:= result + 'from frf_cosecheros ';
    result:= result + 'where empresa_c = ' + QuotedStr( edtEmpresa.Text );
    result:= result + 'order by empresa_c, cosechero_c ';
  end
  else
  begin
    result:= result + 'select empresa_c, cosechero_c, nombre_c ';
    result:= result + 'from frf_cosecheros ';
    result:= result + 'order by empresa_c, cosechero_c ';
  end;
end;

procedure TFLFichaSecciones.edtTipoEntradaChange(Sender: TObject);
begin
  if edtTipoEntrada.Text <> '' then
  begin
    stTipoEntrada.Caption:= desTipoEntrada( edtEmpresa.Text, edtTipoEntrada.Text );
  end
  else
  begin
    stTipoEntrada.Caption:= 'Vacio todos los tipos de entrada';
  end;
end;

function TFLFichaSecciones.edtTipoEntradaGetSQL: String;
begin
  result:= '';
  if edtEmpresa.Text <> '' then
  begin
    result:= result + 'select empresa_et, tipo_et, descripcion_et ';
    result:= result + 'from frf_entradas_tipo ';
    result:= result + 'where empresa_et = ' + QuotedStr( edtEmpresa.Text );
    result:= result + 'order by empresa_et, tipo_et ';
  end
  else
  begin
    result:= result + 'select empresa_et, tipo_et, descripcion_et ';
    result:= result + 'from frf_entradas_tipo ';
    result:= result + 'order by empresa_et, tipo_et ';
  end;
end;

end.
