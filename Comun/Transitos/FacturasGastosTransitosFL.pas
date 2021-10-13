unit FacturasGastosTransitosFL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, DBtables, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Derror, Grids,
  DBGrids, BGrid, CheckLst, kbmMemTable, ADODB, BDEdit;

type
  TFLFacturasGastosTransitos = class(TForm)
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
    qryQLCompGastosCompras: TQuery;
    Label4: TLabel;
    eCentro: TBEdit;
    stCentro: TStaticText;
    lblNombre1: TLabel;
    edtProducto: TBEdit;
    txtProducto: TStaticText;
    chkFactura: TCheckBox;
    lblFacturas: TLabel;
    chkAbonos: TCheckBox;
    edtTipo: TBEdit;
    txtTipo: TStaticText;
    lbl1: TLabel;
    cbbAgrupacion: TComboBox;
    lbl2: TLabel;
    cbbFactura: TComboBox;
    lbl3: TLabel;
    lblFecha: TLabel;
    edtFecha: TBEdit;
    btnFecha: TBCalendarButton;
    aqryX3Factura: TADOQuery;
    kbmTablaTemporal: TkbmMemTable;
    kbmTablaTemporalagrupacion: TStringField;
    kbmTablaTemporaltipo: TStringField;
    kbmTablaTemporalcliente: TStringField;
    kbmTablaTemporalfecha: TDateField;
    kbmTablaTemporalfactura: TStringField;
    kbmTablaTemporaltransporte_gt: TSmallintField;
    kbmTablaTemporalventa: TStringField;
    kbmTablaTemporalkilos: TFloatField;
    kbmTablaTemporalimporte: TFloatField;
    kbmTablaTemporaleuro_kilo: TFloatField;
    kbmTablaTemporalasiento: TStringField;
    kbmTablaTemporalfecha_asiento: TDateField;
    kbmTablaTemporalbase_imponible: TFloatField;
    kbmTablaTemporalempresa: TStringField;
    Label38: TLabel;
    eTransporte: TBDEdit;
    STTransporte: TStaticText;
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
    procedure eCentroChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
    procedure edtTipoChange(Sender: TObject);
    procedure cbbFacturaChange(Sender: TObject);
    procedure eTransporteChange(Sender: TObject);

  private
    {private declarations}
    sAgrupa: String;

    function  ConsultaListadoFacturas: boolean;
    procedure ConfiguraListadoFacturas;
    function  ParametrosCorrectos: boolean;
    procedure CargarTablaTemporal;

  public
    { Public declarations }
  end;

implementation

uses Principal, CVariables, CAuxiliarDB, CReportes,  DateUtils,
  FacturasGastosTransitosQL, FacturasGastosTransTransporteQL, UDMAuxDB, UDMBaseDatos,
  Variants, DPreview, CGlobal;

{$R *.DFM}

//                          **** FORMULARIO ****


procedure TFLFacturasGastosTransitos.ConfiguraListadoFacturas;
begin
  with qryQLCompGastosCompras.SQL do
  begin
    Clear;
    Add('  select  empresa_tc empresa, nvl( agrupacion_tg, ''OTRAS'' ) agrupacion, ');
    Add('          tipo_gt tipo, centro_tc centro, ');
    Add('          fecha_fac_gt fecha, ref_fac_gt factura, transporte_gt, producto_tl producto, ');
    Add('          trim( empresa_tc || '' '' || centro_tc || '' '' || referencia_tc || '' '' || fecha_tc ) venta, ');
//    Add('    (  select sum( kilos_tl ) from frf_transitos_l ');
//    Add('       where empresa_tc = empresa_tl and centro_tc = centro_tl ');
//    Add('       and referencia_tc = referencia_tl and fecha_tc = fecha_tl ');
//    if edtProducto.Text <> '' then
//    begin
//      Add('       and producto_tl = ' + QuotedStr( edtProducto.Text ) );
//    end;
//    Add('     ) kilos, ');
//    Add('        sum( importe_gt ) importe ');

    Add('          round(sum (kilos_tl / (select count(*) from frf_gastos_trans where empresa_tc = empresa_gt and centro_tc = centro_gt                     ');
    Add('                                                                         and referencia_tc = referencia_gt and fecha_tc = fecha_gt)), 2) kilos,    ');
    Add('          round(sum( importe_gt / (select count(*) from frf_transitos_l where empresa_gt = empresa_tl and centro_gt = centro_tl                    ');
    Add('                                                                          and referencia_gt = referencia_tl and fecha_gt = fecha_tl)), 2) importe  ');

    Add('    from frf_transitos_c join frf_gastos_trans on empresa_tc = empresa_gt and centro_tc = centro_gt ');
    Add('                                       and referencia_tc = referencia_gt and fecha_tc = fecha_gt ');
    Add('                       join frf_tipo_gastos on tipo_gt = tipo_tg ');
    Add('                       join frf_transitos_l on empresa_gt = empresa_tl and centro_gt = centro_tl and referencia_gt = referencia_tl and fecha_gt = fecha_tl ');

    if ( eEmpresa.Text = 'BAG' ) and ( CGlobal.gProgramVersion = CGlobal.pvBAG ) then
    begin
      Add(' where empresa_tc[1,1] = ''F'' ');
    end
    else
    if ( eEmpresa.Text = 'SAT' ) and ( CGlobal.gProgramVersion = CGlobal.pvSAT ) then
    begin
      Add(' where ( empresa_tc = ''050'' or  empresa_tc = ''080'' ) ');
    end
    else
      Add(' where empresa_tc = :empresa ');

    Add('  AND  fecha_tc BETWEEN :desde AND :hasta ');

    if eTransporte.Text <> '' then
      Add('    and transporte_gt = :transporte ');

    if eCentro.Text <> '' then
      Add('    and centro_tc  = :centro ');

    if edtTipo.Text <> '' then
    begin
      Add('    and ( tipo_gt =:tipo )');
    end;

    if cbbAgrupacion.ItemIndex <> 0 then
    begin
      Add('    and ( nvl( agrupacion_tg, ''OTRAS'' ) =:agrupacion )');
    end;

    if edtProducto.Text <> '' then
    begin
      Add('       and producto_tl = ' + QuotedStr( edtProducto.Text ) );
    end;
{
    if edtProducto.Text <> '' then
    begin
      Add('    and exists ');
      Add('        (  select * from frf_transitos_l ');
      Add('           where empresa_tc = empresa_tl and centro_tc = centro_tl ');
      Add('           and referencia_tc = referencia_tl and fecha_tc = fecha_tl ');
      Add('           and producto_tl = ' + QuotedStr( edtProducto.Text ) + ' ) ');
    end;
}
    if cbbFactura.ItemIndex = 1 then
    begin
      Add('    and nvl(ref_fac_gt,'''') = '''' ');
    end
    else
    if cbbFactura.ItemIndex = 2 then
    begin
      Add('    and nvl(ref_fac_gt,'''') <> '''' ');
    end
    else
    if cbbFactura.ItemIndex = 3 then
    begin
      Add('    and nvl(ref_fac_gt,'''') <> '''' and nvl(fecha_fac_gt,'''') = '''' ');
    end
    else
    if cbbFactura.ItemIndex = 4 then
    begin
      Add('    and nvl(ref_fac_gt,'''') <> '''' and nvl(fecha_fac_gt,'''') <> '''' ');
    end
    else
    if cbbFactura.ItemIndex = 5 then
    begin
      Add('    and ( ( nvl(ref_fac_gt,'''') = '''' ) or ( nvl(fecha_fac_gt,'''') = '''' ) or ( fecha_fac_gt > :fecha ) ) ');
    end;

    Add(' group by 1,2,3,4,5,6,7,8,9 ');
    if chkAbonos.Checked then
      Add(' having sum( importe_gt ) < 0 ');

    if cbbAgrupacion.Items[cbbAgrupacion.ItemIndex] = sAgrupa then
      Add(' order by empresa, transporte_gt, centro, agrupacion, tipo, fecha, factura, venta ')
    else
      Add(' order by empresa, centro, agrupacion, tipo, fecha, factura, venta ');
  end;
end;

procedure TFLFacturasGastosTransitos.FormCreate(Sender: TObject);
var
  bOtras: Boolean;
begin
  gRF := nil;
  gCF := nil;

  FormType := tfOther;
  BHFormulario;

  EDesde.Text := DateTostr(Date-7);
  EHasta.Text := DateTostr(Date-1);
  CalendarioFlotante.Date := Date;

  eCentro.Text:= '';
  eCentroChange( eCentro );
  eTransporte.Text:= '';
  eTransporteChange(eTransporte);
  edtProducto.Text:= '';
  edtProductoChange( edtProducto );
  edtTipoChange( edtTipo );

  if CGlobal.gProgramVersion = CGlobal.pvBAG then
    eEmpresa.Text := 'BAG'
  else
    eEmpresa.Text := 'SAT';
  STEmpresa.Caption := desEmpresa(eEmpresa.Text);

  EDesde.Tag := kCalendar;
  EHasta.Tag := kCalendar;
  edtFecha.Tag := kCalendar;

  eEmpresa.Tag:= kEmpresa;

  gCF := calendarioFlotante;

  if CGlobal.gProgramVersion = CGlobal.pvBAG then
    sAgrupa := 'TRANSPORTE'
  else
    sAgrupa := 'TRANSITO';

  //Carga r agrupaciones
  bOtras:= false;
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(agrupacion_tg,''OTRAS'') agrupacion_tg');
    SQL.Add(' from frf_tipo_gastos ');
    SQL.Add('where gasto_transito_tg = 1');
    SQL.Add('group by 1 ');
    Open;
    cbbAgrupacion.Items.Clear;
    cbbAgrupacion.Items.Add('TODAS');
    while not Eof do
    begin
      if fiELDbYName('agrupacion_tg').AsString = 'OTRAS' then
        bOtras:= True
      else
        cbbAgrupacion.Items.Add(fiELDbYName('agrupacion_tg').AsString);
      Next;
    end;
    if bOtras = True then
      cbbAgrupacion.Items.Add('OTRAS');

    Close;
    cbbAgrupacion.ItemIndex:= 0;
  end;
end;

procedure TFLFacturasGastosTransitos.FormActivate(Sender: TObject);
begin
  ActiveControl := eEmpresa;
end;

procedure TFLFacturasGastosTransitos.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLFacturasGastosTransitos.FormClose(Sender: TObject;
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

procedure TFLFacturasGastosTransitos.BBAceptarClick(Sender: TObject);
var
  bMostrarReport: boolean;
begin
  if not CerrarForm(true) then
    Exit;
  if not ParametrosCorrectos then
    Exit;

  //Nuevo listado para mostrar datos contables para facturas SOLO de trasporte 14/04/2019
  if cbbAgrupacion.Items[cbbAgrupacion.ItemIndex] = sAgrupa then
  begin
    //Llamamos al QReport
    QLFacturasGastosTransTransporte := TQLFacturasGastosTransTransporte.Create(Application);
    try
      bMostrarReport:= ConsultaListadoFacturas;
      if bMostrarReport then
      begin
        CargarTablaTemporal;
        kbmTablaTemporal.IndexFieldNames:= 'empresa;transporte_gt;agrupacion;tipo;fecha;factura';
        kbmTablaTemporal.SortFields:= 'empresa;transporte_gt;agrupacion;tipo;fecha;factura';
        kbmTablaTemporal.Sort([]);

        QLFacturasGastosTransTransporte.bAgruparFactura:= chkFactura.Checked;
        QLFacturasGastosTransTransporte.LPeriodo.Caption := EDesde.Text + ' a ' + EHasta.Text;
        if edtProducto.Text <> '' then
          QLFacturasGastosTransTransporte.lblProducto.Caption := 'TRANSITOS CON ' + txtProducto.Caption
        else
          QLFacturasGastosTransTransporte.lblProducto.Caption := 'TODOS LOS PRODUCTOS.';
        PonLogoGrupoBonnysa(QLFacturasGastosTransTransporte, eEmpresa.Text );

        if eCentro.Text <> '' then
          QLFacturasGastosTransTransporte.qrlblCabCentro.Caption:= eCentro.Text + ' ' + stCentro.Caption
        else
          QLFacturasGastosTransTransporte.qrlblCabCentro.Caption:= '';
        QLFacturasGastosTransTransporte.bndCabecera.Height:= 90;

        Preview(QLFacturasGastosTransTransporte);
      end
      else
      begin
        FreeAndNil(QLFacturasGastosTransTransporte);
      end;
    except
      FreeAndNil(QLFacturasGastosTransTransporte);
      Raise;
    end;
  end
  else
  begin
    //Llamamos al QReport
    QLFacturasGastosTransitos := TQLFacturasGastosTransitos.Create(Application);
    try
      bMostrarReport:= ConsultaListadoFacturas;
      if bMostrarReport then
      begin
        QLFacturasGastosTransitos.sEmpresa:= eEmpresa.Text;
        QLFacturasGastosTransitos.bAgruparFactura:= chkFactura.Checked;
        QLFacturasGastosTransitos.LPeriodo.Caption := EDesde.Text + ' a ' + EHasta.Text;
        if edtProducto.Text <> '' then
          QLFacturasGastosTransitos.lblProducto.Caption := 'TRANSITOS CON ' + txtProducto.Caption
        else
          QLFacturasGastosTransitos.lblProducto.Caption := 'TODOS LOS PRODUCTOS.';
        PonLogoGrupoBonnysa(QLFacturasGastosTransitos, eEmpresa.Text );

        if eCentro.Text <> '' then
          QLFacturasGastosTransitos.qrlblCabCentro.Caption:= eCentro.Text + ' ' + stCentro.Caption
        else
          QLFacturasGastosTransitos.qrlblCabCentro.Caption:= '';
        QLFacturasGastosTransitos.bndCabecera.Height:= 90;

        Preview(QLFacturasGastosTransitos);
      end
      else
      begin
        FreeAndNil(QLFacturasGastosTransitos);
      end;
    except
      FreeAndNil(QLFacturasGastosTransitos);
      Raise;
    end;
  end;
end;

procedure TFLFacturasGastosTransitos.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLFacturasGastosTransitos.CargarTablaTemporal;
var CodigoX3: String;
begin

  //Contabilidad
  DMBaseDatos.conX3.Open;
  aqryX3Factura.SQL.Clear;
  aqryX3Factura.SQL.Add(' SELECT NUM_0 [Asiento],BPRDAT_0 [Fecha_Documento], BPRVCR_0 [Doc_Origen],  ');
  aqryX3Factura.SQL.Add(' CPY_0 [Sociedad], BPR_0 [Cod_Tercero], AMTATI_0 [Importe]                  ');
  aqryX3Factura.SQL.Add('   FROM BONNYSA.PINVOICE                                                    ');
  aqryX3Factura.SQL.Add(' WHERE 1 = 1                                                                ');
  aqryX3Factura.SQL.Add(' AND BPRVCR_0 = :factura ');
  aqryX3Factura.SQL.Add(' AND BPR_0 = :transporte ');
  aqryX3Factura.SQL.Add(' AND BPRDAT_0 = :fecha   ');

  if kbmTablaTemporal.Active then
    kbmTablaTemporal.Close;

  kbmTablaTemporal.Open;
  qryQLCompGastosCompras.First;
  while not qryQLCompGastosCompras.Eof do
  begin
    kbmTablaTemporal.Insert;
    kbmTablaTemporal.FieldByName('empresa').AsString := qryQLCompGastosCompras.FieldByName('empresa').AsString;
    kbmTablaTemporal.FieldByName('agrupacion').AsString := qryQLCompGastosCompras.FieldByName('agrupacion').AsString;
    kbmTablaTemporal.FieldByName('tipo').AsString := qryQLCompGastosCompras.FieldByName('tipo').AsString;
    kbmTablaTemporal.FieldByName('centro').AsString := qryQLCompGastosCompras.FieldByName('centro').AsString;
    kbmTablaTemporal.FieldByName('fecha').AsString := qryQLCompGastosCompras.FieldByName('fecha').AsString;
    kbmTablaTemporal.FieldByName('factura').AsString := qryQLCompGastosCompras.FieldByName('factura').AsString;
    kbmTablaTemporal.FieldByName('transporte_gt').AsInteger := qryQLCompGastosCompras.FieldByName('transporte_gt').AsInteger;
    kbmTablaTemporal.FieldByName('venta').AsString := qryQLCompGastosCompras.FieldByName('venta').AsString;
    kbmTablaTemporal.FieldByName('kilos').AsFloat := qryQLCompGastosCompras.FieldByName('kilos').AsFloat;
    kbmTablaTemporal.FieldByName('importe').AsFloat := qryQLCompGastosCompras.FieldByName('importe').AsFloat;
    if qryQLCompGastosCompras.FieldByName('kilos').AsFloat = 0 then
      kbmTablaTemporal.FieldByName('euro_kilo').AsFloat := 0
    else
      kbmTablaTemporal.FieldByName('euro_kilo').AsFloat := qryQLCompGastosCompras.FieldByName('importe').AsFloat /qryQLCompGastosCompras.FieldByName('kilos').AsFloat;

    //Datos Contabilidad
    if qryQLCompGastosCompras.FieldByName('factura').IsNull then
      aqryX3Factura.Parameters.ParamByName('factura').Value := ''
    else
      aqryX3Factura.Parameters.ParamByName('factura').Value:= qryQLCompGastosCompras.FieldByName('factura').AsString;

    CodigoX3 := CodigoX3Transporte(qryQLCompGastosCompras.FieldByName('empresa').AsString, qryQLCompGastosCompras.FieldByName('transporte_gt').AsString);
    if CodigoX3 = ''  then
      aqryX3Factura.Parameters.ParamByName('transporte').Value := ''
    else
      aqryX3Factura.Parameters.ParamByName('transporte').Value:= CodigoX3;
    if (qryQLCompGastosCompras.FieldByName('fecha').IsNull) or (YearOf(qryQLCompGastosCompras.FieldByName('fecha').AsDateTime) < 1900) then
      aqryX3Factura.Parameters.ParamByName('fecha'). value := Null
    else
      aqryX3Factura.Parameters.ParamByName('fecha').Value:= qryQLCompGastosCompras.FieldByName('fecha').AsString;
      
    aqryX3Factura.Open;

    kbmTablaTemporal.FieldByName('asiento').AsString := aqryX3Factura.FieldByName('asiento').AsString;
    kbmTablaTemporal.FieldByName('fecha_asiento').AsString := aqryX3Factura.FieldByName('Fecha_Documento').AsString;
    kbmTablaTemporal.FieldByName('base_imponible').AsString := aqryX3Factura.FieldByName('Importe').AsString;

    aqryX3Factura.Close;

    kbmTablaTemporal.Post;

    qryQLCompGastosCompras.Next;
  end;
end;

//                     ****  CAMPOS DE EDICION  ****

procedure TFLFacturasGastosTransitos.EHastaExit(Sender: TObject);
begin
  if StrToDate(EHasta.Text) < StrToDate(EDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    EDesde.SetFocus;
  end;
end;

procedure TFLFacturasGastosTransitos.eTransporteChange(Sender: TObject);
begin
  if eTransporte.Text <> '' then
    STTransporte.Caption := desTransporte(eEmpresa.Text, eTransporte.Text)
  else
    STTransporte.Caption := 'Vacio todos los transportes.';

end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLFacturasGastosTransitos.ADesplegarRejillaExecute(Sender: TObject);
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


function TFLFacturasGastosTransitos.ConsultaListadoFacturas: Boolean;
begin
  ConfiguraListadoFacturas;
  with qryQLCompGastosCompras do
  begin
    Close;
    if (eEmpresa.Text <> 'BAG') and (eEmpresa.Text <> 'SAT')  then
      ParamByName('empresa').AsString := eEmpresa.Text;
    if eCentro.Text <> '' then
      ParamByName('centro').AsString := eCentro.Text;
    if eTransporte.Text <> '' then
      ParamByName('transporte').AsString := eTransporte.Text;
    ParamByName('desde').AsDate := StrToDate(EDesde.Text);
    ParamByName('hasta').AsDate := StrToDate(EHasta.Text);
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

  if qryQLCompGastosCompras.IsEmpty then
  begin
    ShowMessage('Sin datos para los parametros seleccionados.');
    qryQLCompGastosCompras.Close;
    result:= False;
  end
  else
  begin
    result:= True;
  end;
end;

function TFLFacturasGastosTransitos.ParametrosCorrectos: boolean;
var
  dIni, dFin: TDateTime;
begin
  result:= False;
  if (Trim( eEmpresa.Text ) = '') or (STEmpresa.Caption = '') then
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
  if stCentro.Caption = '' then
  begin
    ShowMessage('Centro incorrecto.');
    eCentro.SetFocus;
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

procedure TFLFacturasGastosTransitos.eEmpresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(eEmpresa.Text);
end;

procedure TFLFacturasGastosTransitos.eCentroChange(Sender: TObject);
begin
  if eCentro.Text <> '' then
    stCentro.Caption := desCentro(eEmpresa.Text, eCentro.Text)
  else
    stCentro.Caption := 'Vacio todos los centros.';
end;

procedure TFLFacturasGastosTransitos.edtProductoChange(Sender: TObject);
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

procedure TFLFacturasGastosTransitos.edtTipoChange(Sender: TObject);
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

procedure TFLFacturasGastosTransitos.cbbFacturaChange(Sender: TObject);
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
