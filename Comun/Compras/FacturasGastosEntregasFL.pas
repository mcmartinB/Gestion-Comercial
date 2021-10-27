unit FacturasGastosEntregasFL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, DBtables, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Derror, Grids,
  DBGrids, BGrid, CheckLst;

type
  TFLFacturasGastosEntregas = class(TForm)
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
    EDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label2: TLabel;
    EHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    QLCompGastosEntregas: TQuery;
    Label4: TLabel;
    eCliente: TBEdit;
    STCliente: TStaticText;
    lblNombre1: TLabel;
    edtProducto: TBEdit;
    txtProducto: TStaticText;
    chkAgruparProducto: TCheckBox;
    cbbFecha: TComboBox;
    lblFacturas: TLabel;
    chkAbonos: TCheckBox;
    edtTipo: TBEdit;
    txtTipo: TStaticText;
    lbl1: TLabel;
    cbbAgrupacion: TComboBox;
    lbl2: TLabel;
    cbbFactura: TComboBox;
    chkExcluir: TCheckBox;
    lblFecha: TLabel;
    edtFecha: TBEdit;
    btnFecha: TBCalendarButton;
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
    procedure eClienteChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
    procedure edtTipoChange(Sender: TObject);
    procedure cbbFacturaChange(Sender: TObject);

  private
    {private declarations}
    function  ConsultaListadoFacturas: boolean;
    procedure ConfiguraListadoFacturas;
    function  ParametrosCorrectos: boolean;

  public
    { Public declarations }
  end;

implementation

uses Principal, CVariables, CAuxiliarDB, CReportes, DateUtils,
  FacturasGastosEntregasQL, DPreview, UDMAuxDB, CGlobal;

{$R *.DFM}

//                          **** FORMULARIO ****


procedure TFLFacturasGastosEntregas.ConfiguraListadoFacturas;
begin
  with QLCompGastosEntregas.SQL do
  begin
    Clear;


    (*TODO*)    //en comersat una compra puede tener distintos productos
    if CGlobal.gProgramVersion = CGlobal.pvBAG then
    begin
      Add(' select  empresa_ec empresa,( select distinct producto_el from frf_entregas_l where codigo_ec = codigo_el ) producto, ');
      Add('         agrupacion_tg agrupacion, tipo_ge tipo, proveedor_ec proveedor, fecha_fac_ge fecha, ref_fac_ge factura, codigo_ec entrega,  fecha_llegada_ec llegada,');
    end
    else
    begin
      Add(' select  empresa_ec empresa,( select max( producto_el ) from frf_entregas_l where codigo_ec = codigo_el ) producto, ');
      Add('         agrupacion_tg agrupacion, tipo_ge tipo, proveedor_ec proveedor, fecha_fac_ge fecha, ref_fac_ge factura, codigo_ec entrega, fecha_llegada_ec llegada, ');
    end;

    if edtProducto.Text <> '' then
    begin
      Add('        (select sum( kilos_el ) from frf_entregas_l where codigo_ec = codigo_el and producto_el = producto_ge ) kilos, ');
    end
    else
    begin
      Add('        (select sum( kilos_el ) from frf_entregas_l where codigo_ec = codigo_el  ) kilos, ');
    end;
    Add('        sum( importe_ge ) importe ');

    Add('  from frf_entregas_c, frf_gastos_entregas, frf_tipo_gastos ');

    if EEmpresa.Text <> 'BAG' then
      Add(' where empresa_ec = :empresa ' )
    else
      Add(' where substr(empresa_ec,1,1) = ''F'' ' );

    if eCliente.Text <> '' then
      Add('    and proveedor_ec = :proveedor ');
    Add('    and codigo_ge = codigo_ec ');
    if cbbFecha.ItemIndex = 0 then
    begin
      Add('    AND   fecha_llegada_ec BETWEEN :desde AND :hasta ');
    end
    else
    begin
      Add('    AND   fecha_fac_ge BETWEEN :desde AND :hasta ');
    end;

    if edtTipo.Text <> '' then
    begin
      if chkExcluir.Checked then
        Add('    and ( tipo_ge <> :tipo )')
      else
        Add('    and ( tipo_ge = :tipo )');
    end;

    Add(' and tipo_ge = tipo_tg ');
    if cbbAgrupacion.ItemIndex <> 0 then
    begin
      Add('    and ( agrupacion_tg =:agrupacion )');
    end;

    if edtProducto.Text <> '' then
    begin
      Add('    and ( producto_ge = :producto  )');
    end;

    if cbbFactura.ItemIndex = 1 then
    begin
      Add('    and nvl(ref_fac_ge,'''') = '''' ');
    end
    else
    if cbbFactura.ItemIndex = 2 then
    begin
      Add('    and nvl(ref_fac_ge,'''') <> '''' ');
    end
    else
    if cbbFactura.ItemIndex = 3 then
    begin
      Add('    and nvl(ref_fac_ge,'''') <> '''' and nvl(fecha_fac_ge,'''') = '''' ');
    end
    else
    if cbbFactura.ItemIndex = 4 then
    begin
      Add('    and nvl(ref_fac_ge,'''') <> '''' and nvl(fecha_fac_ge,'''') <> '''' ');
    end
    else
    if cbbFactura.ItemIndex = 5 then
    begin
      Add('    and ( ( nvl(ref_fac_ge,'''') = '''' ) or ( nvl(fecha_fac_ge,'''') = '''' ) or ( fecha_fac_ge > :fecha ) ) ');
    end;

    Add(' group by 1,2,3,4,5,6,7,8,9,10 ');
    if chkAbonos.Checked then
      Add(' having sum( importe_ge ) < 0 ');

    if chkAgruparProducto.Checked then
      Add(' order by empresa, producto, proveedor, llegada,  entrega,  tipo, fecha, factura ')
    else
      Add(' order by empresa, proveedor, producto, llegada,  entrega,  tipo, fecha, factura ');
  end;
end;

procedure TFLFacturasGastosEntregas.FormCreate(Sender: TObject);
var
  i,j :Integer;
begin
  gRF := nil;
  gCF := nil;

  FormType := tfOther;
  BHFormulario;

  EDesde.Text := DateTostr(Date-7);
  EHasta.Text := DateTostr(Date-1);
  CalendarioFlotante.Date := Date;

  eCliente.Text:= '';
  eClienteChange( eCliente );
  edtProducto.Text:= '';
  edtProductoChange( edtProducto );
  edtTipoChange( edtTipo );

  if CGlobal.gProgramVersion = pvBAG then
    eEmpresa.Text:= 'BAG'
  else
    eEmpresa.Text:= gsDefEmpresa;

  EDesde.Tag := kCalendar;
  EHasta.Tag := kCalendar;
  edtFecha.Tag := kCalendar;

  eEmpresa.Tag:= kEmpresa;

  gCF := calendarioFlotante;

  //Carga r agrupaciones
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select agrupacion_tg ');
    SQL.Add(' from frf_tipo_gastos ');
    SQL.Add('where gasto_transito_tg = 2 ');
    SQL.Add('group by 1 ');
    Open;
    cbbAgrupacion.Items.Clear;
    cbbAgrupacion.Items.Add('TODOS');
    i:= 1;
    j:= 0;
    while not Eof do
    begin
      cbbAgrupacion.Items.Add(fiELDbYName('agrupacion_tg').AsString);
      if fiELDbYName('agrupacion_tg').AsString = 'COMPRA' then
        j:= i;
      i:= i +1;
      Next;
    end;
    Close;
    cbbAgrupacion.ItemIndex:= j;
  end;
end;

procedure TFLFacturasGastosEntregas.FormActivate(Sender: TObject);
begin
  ActiveControl := eEmpresa;
end;

procedure TFLFacturasGastosEntregas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLFacturasGastosEntregas.FormClose(Sender: TObject;
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

procedure TFLFacturasGastosEntregas.BBAceptarClick(Sender: TObject);
var
  bMostrarReport: boolean;
begin
  if not CerrarForm(true) then
    Exit;
  if not ParametrosCorrectos then
    Exit;


  //Llamamos al QReport
  QLFacturasGastosEntregas := TQLFacturasGastosEntregas.Create(Application);
  try
    bMostrarReport:= ConsultaListadoFacturas;
    if bMostrarReport then
    begin
      QLFacturasGastosEntregas.bAgruparProducto:= chkAgruparProducto.Checked;
      QLFacturasGastosEntregas.LPeriodo.Caption := EDesde.Text + ' a ' + EHasta.Text;
      if edtProducto.Text <> '' then
        QLFacturasGastosEntregas.lblProducto.Caption := txtProducto.Caption
      else
        QLFacturasGastosEntregas.lblProducto.Caption := 'TODOS LOS PRODUCTOS.';
      PonLogoGrupoBonnysa(QLFacturasGastosEntregas, eEmpresa.Text );

      if eCliente.Text <> '' then
        QLFacturasGastosEntregas.lblCliente.Caption:= eCliente.Text + ' ' + stCliente.Caption
      else
        QLFacturasGastosEntregas.lblCliente.Caption:= '';
      QLFacturasGastosEntregas.bndCabecera.Height:= 90;

      Preview(QLFacturasGastosEntregas);
    end
    else
    begin
      FreeAndNil(QLFacturasGastosEntregas);
    end;
  except
    FreeAndNil(QLFacturasGastosEntregas);
    Raise;
  end;
end;

procedure TFLFacturasGastosEntregas.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                     ****  CAMPOS DE EDICION  ****

procedure TFLFacturasGastosEntregas.EHastaExit(Sender: TObject);
begin
  if StrToDate(EHasta.Text) < StrToDate(EDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    EDesde.SetFocus;
  end;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLFacturasGastosEntregas.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kCalendar:
      begin
        if EDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
        if EHasta.Focused then
          DespliegaCalendario(BCBHasta)
        else
          DespliegaCalendario(btnFecha);
      end;
  end;
end;

//                     *** PROCEDIMIENTOS PRIVADOS ***


function TFLFacturasGastosEntregas.ConsultaListadoFacturas: Boolean;
begin
  ConfiguraListadoFacturas;
  with QLCompGastosEntregas do
  begin
    Close;
    if EEmpresa.Text <> 'BAG' then
      ParamByName('empresa').AsString := eEmpresa.Text;
    if eCliente.Text <> '' then
      ParamByName('proveedor').AsString := eCliente.Text;
    ParamByName('desde').AsDate := StrToDate(EDesde.Text);
    ParamByName('hasta').AsDate := StrToDate(EHasta.Text);
    if edtProducto.Text <> '' then
      ParamByName('producto').AsString := edtProducto.Text;
    if edtTipo.Text <> '' then
      ParamByName('tipo').AsString := edtTipo.Text;
    if cbbAgrupacion.ItemIndex <> 0 then
      ParamByName('agrupacion').AsString := cbbAgrupacion.Items[cbbAgrupacion.ItemIndex];
    if cbbFactura.ItemIndex = 5 then
      ParamByName('fecha').AsDate := StrToDate(edtFecha.Text);      
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

  if QLCompGastosEntregas.IsEmpty then
  begin
    ShowMessage('Sin datos para los parametros seleccionados.');
    QLCompGastosEntregas.Close;
    result:= False;
  end
  else
  begin
    result:= True;
  end;
end;

function TFLFacturasGastosEntregas.ParametrosCorrectos: boolean;
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
  if STCliente.Caption = '' then
  begin
    ShowMessage('Proveedor incorrecto.');
    eCliente.SetFocus;
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

procedure TFLFacturasGastosEntregas.eEmpresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(eEmpresa.Text);
end;

procedure TFLFacturasGastosEntregas.eClienteChange(Sender: TObject);
begin
  if eCliente.Text <> '' then
    STCliente.Caption := desProveedor(eEmpresa.Text, eCliente.Text)
  else
    STCliente.Caption := 'Vacio todos los proveedores.';
end;

procedure TFLFacturasGastosEntregas.edtProductoChange(Sender: TObject);
begin
  if edtProducto.Text <> '' then
  begin
    txtProducto.Caption := desProducto(eEmpresa.Text, edtProducto.Text);
  end
  else
  begin
    txtProducto.Caption := 'Vacio todos los productos.';
  end;
end;

procedure TFLFacturasGastosEntregas.edtTipoChange(Sender: TObject);
begin
  if edtTipo.Text <> '' then
  begin
    txtTipo.Caption := desTipoGastos(edtTipo.Text);
  end
  else
  begin
    txtTipo.Caption := 'Vacio todos los tipos.';
  end;
end;

procedure TFLFacturasGastosEntregas.cbbFacturaChange(Sender: TObject);
var
  iAux, iDay, iMonth, iYear: Word;
  dFecha: TDateTime;
begin
  lblFecha.Enabled:= cbbFactura.ItemIndex = 5;
  edtFecha.Enabled:= cbbFactura.ItemIndex = 5;
  btnFecha.Enabled:= cbbFactura.ItemIndex = 5;
  if ( edtFecha.Enabled ) and ( edtFecha.Text = '' ) then
  begin
    dFecha:= IncMonth(Now,-1);
    iAux:= DaysInMonth( dFecha );
    DecodeDate( dFecha, iYear, iMonth, iDay  );
    dFecha:= EncodeDate( iYear, iMonth, iAux );
    edtFecha.Text:= DateToStr( dFecha );
  end;
end;

end.
