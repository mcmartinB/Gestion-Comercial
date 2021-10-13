unit FacturasGastosSalidasFL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, DBtables, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Derror, Grids,
  DBGrids, BGrid, CheckLst, BDEdit, BonnyClientDataSet, DBClient, Provider,
  ADODB, kbmMemTable;

type
  TFLFacturasGastosSalidas = class(TForm)
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
    chkFactura: TCheckBox;
    lblFacturas: TLabel;
    edtTipo: TBEdit;
    txtTipo: TStaticText;
    lbl1: TLabel;
    cbbAgrupacion: TComboBox;
    lbl2: TLabel;
    cbbFactura: TComboBox;
    lbl3: TLabel;
    cbbTipoFactura: TComboBox;
    lbl4: TLabel;
    lblFecha: TLabel;
    edtFecha: TBEdit;
    btnFecha: TBCalendarButton;
    chKNoTransitos: TCheckBox;
    Label1: TLabel;
    cbxFactutable: TComboBox;
    Label38: TLabel;
    eTransporte: TBDEdit;
    STTransporte: TStaticText;
    aqryX3Factura: TADOQuery;
    kbmTablaTemporal: TkbmMemTable;
    kbmTablaTemporalagrupacion: TStringField;
    kbmTablaTemporaltipo: TStringField;
    kbmTablaTemporalcliente: TStringField;
    kbmTablaTemporalfecha: TDateField;
    kbmTablaTemporalfactura: TStringField;
    kbmTablaTemporaltransporte_g: TSmallintField;
    kbmTablaTemporalventa: TStringField;
    kbmTablaTemporalkilos: TFloatField;
    kbmTablaTemporalimporte: TFloatField;
    kbmTablaTemporaleuro_kilo: TFloatField;
    kbmTablaTemporalasiento: TStringField;
    kbmTablaTemporalfecha_asiento: TDateField;
    kbmTablaTemporalbase_imponible: TFloatField;
    kbmTablaTemporalempresa: TStringField;
    chkNoDevolucion: TCheckBox;
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
    procedure eTransporteChange(Sender: TObject);

  private
    {private declarations}

    function  ConsultaListadoFacturas: boolean;
    procedure ConfiguraListadoFacturas;
    function  ParametrosCorrectos: boolean;
    procedure CargarTablaTemporal;

  public
    { Public declarations }
  end;

implementation

uses Principal, CVariables, CAuxiliarDB, CReportes,  DateUtils,
  FacturasGastosSalidasQL, DPreview, UDMAuxDB, FacturasGastosTransporteQL,
  UDMBaseDatos, Variants, CGlobal;

{$R *.DFM}

//                          **** FORMULARIO ****


procedure TFLFacturasGastosSalidas.ConfiguraListadoFacturas;
begin
  with QLCompGastosEntregas.SQL do
  begin
    Clear;
    Add('  select  empresa_sc empresa, nvl( agrupacion_tg, ''OTRAS'' ) agrupacion, ');
    Add('          tipo_g tipo, cliente_sal_sc cliente, ');
    Add('          fecha_fac_g fecha, ref_fac_g factura, transporte_g,');
    Add('          trim( empresa_sc || '' '' || centro_salida_sc || '' '' || n_albaran_sc || '' '' || fecha_sc ) venta, ');
    Add('    (  select sum( kilos_sl ) from frf_salidas_l ');
    Add('       where empresa_sc = empresa_sl and centro_salida_Sc = centro_salida_sl ');
    Add('       and n_albaran_sc = n_albaran_sl and fecha_sc = fecha_sl ');

    if edtProducto.Text <> '' then
    begin
      Add('       and producto_sl = ' + QuotedStr( edtProducto.Text ) );
    end;
    Add('     ) kilos, ');
    Add('        sum( importe_g ) importe ');


    Add('    from frf_salidas_c join frf_gastos on empresa_sc = empresa_g and centro_salida_Sc = centro_salida_g ');
    Add('                                       and n_albaran_sc = n_albaran_g and fecha_sc = fecha_g ');
    Add('                       join frf_tipo_gastos on tipo_g = tipo_tg ');

    if ( eEmpresa.Text = 'BAG' ) and ( CGlobal.gProgramVersion = CGlobal.pvBAG ) then
    begin
      Add(' where empresa_sc[1,1] = ''F'' ');
    end
    else
    if ( eEmpresa.Text = 'SAT' ) and ( CGlobal.gProgramVersion = CGlobal.pvSAT ) then
    begin
      Add(' where ( empresa_sc = ''050'' or  empresa_sc = ''080'' ) ');
    end
    else
      Add(' where empresa_sc = :empresa ');

//    Add('  where empresa_sc  = :empresa ');
    Add('  AND  fecha_sc BETWEEN :desde AND :hasta ');

    if eCliente.Text <> '' then
      Add('    and cliente_sal_sc  = :cliente ');

    if eTransporte.Text <> '' then
      Add('    and transporte_g  = :transporte ');


    if edtTipo.Text <> '' then
    begin
      Add('    and ( tipo_g =:tipo )');
    end;

    if cbbAgrupacion.ItemIndex <> 0 then
    begin
      Add('    and ( nvl( agrupacion_tg, ''OTRAS'' ) =:agrupacion )');
    end;

    if edtProducto.Text <> '' then
    begin
      Add('    and exists ');
      Add('        (  select * from frf_salidas_l ');
      Add('           where empresa_sc = empresa_sl and centro_salida_Sc = centro_salida_sl ');
      Add('           and n_albaran_sc = n_albaran_sl and fecha_sc = fecha_sl ');
      Add('           and producto_sl = ' + QuotedStr( edtProducto.Text ) + ' ) ');
    end;

    if cbxFactutable.ItemIndex = 1 then
    begin
      Add('    and nvl(facturable_tg, ''N'') = ''N'' ');
    end
    else
    if cbxFactutable.ItemIndex = 2 then
    begin
      Add('    and nvl(facturable_tg, ''N'') = ''S'' ');
    end;

    if cbbFactura.ItemIndex = 1 then
    begin
      Add('    and nvl(ref_fac_g,'''') = '''' ');
    end
    else
    if cbbFactura.ItemIndex = 2 then
    begin
      Add('    and nvl(ref_fac_g,'''') <> '''' ');
    end
    else
    if cbbFactura.ItemIndex = 3 then
    begin
      Add('    and nvl(ref_fac_g,'''') <> '''' and nvl(fecha_fac_g,'''') = '''' ');
    end
    else
    if cbbFactura.ItemIndex = 4 then
    begin
      Add('    and nvl(ref_fac_g,'''') <> '''' and nvl(fecha_fac_g,'''') <> '''' ');
    end
    else
    if cbbFactura.ItemIndex = 5 then
    begin
      Add('    and ( ( nvl(ref_fac_g,'''') = '''' ) or ( nvl(fecha_fac_g,'''') = '''' ) or ( fecha_fac_g > :fecha ) ) ');
    end;

    if chkNoTransitos.Checked then
    begin
      Add(' and  gasto_transito_tg <> 1 ');
    end;

    if chkNoDevolucion.Checked then
    begin
      Add('  and es_transito_sc <> 2 ');      // Tipo Salida: Devolucion
    end;

    Add(' group by 1,2,3,4,5,6,7,8,9 ');
    if cbbTipoFactura.ItemIndex = 1 then
      Add(' having sum( importe_g ) >= 0 ')
    else
    if cbbTipoFactura.ItemIndex = 2 then
      Add(' having sum( importe_g ) < 0 ');

    if cbbAgrupacion.Items[cbbAgrupacion.ItemIndex] = 'TRANSPORTE' then
      Add(' order by empresa, transporte_g, agrupacion, tipo, fecha, factura, cliente, venta ')
    else
      Add(' order by empresa, agrupacion, tipo, cliente, fecha, factura, venta ');
  end;
end;

procedure TFLFacturasGastosSalidas.FormCreate(Sender: TObject);
var
  bOtras: Boolean;
begin
  gRF := nil;
  gCF := nil;

  FormType := tfOther;
  BHFormulario;

  if CGlobal.gProgramVersion = CGlobal.pvBAG then
    eEmpresa.Text := 'BAG'
  else
    eEmpresa.Text := 'SAT';
  STEmpresa.Caption := desEmpresa(eEmpresa.Text);


  EDesde.Text := DateTostr(Date-7);
  EHasta.Text := DateTostr(Date-1);
  CalendarioFlotante.Date := Date;

  eCliente.Text:= '';
  eClienteChange( eCliente );
  edtProducto.Text:= '';
  edtProductoChange( edtProducto );
  edtTipoChange( edtTipo );

  EDesde.Tag := kCalendar;
  EHasta.Tag := kCalendar;
  edtFecha.Tag := kCalendar;

  eEmpresa.Tag:= kEmpresa;

  gCF := calendarioFlotante;

  //Carga r agrupaciones
  bOtras:= false;
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(agrupacion_tg,''OTRAS'') agrupacion_tg');
    SQL.Add(' from frf_tipo_gastos ');
    SQL.Add('where gasto_transito_tg = 0');
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

procedure TFLFacturasGastosSalidas.FormActivate(Sender: TObject);
begin
  ActiveControl := eEmpresa;
end;

procedure TFLFacturasGastosSalidas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLFacturasGastosSalidas.FormClose(Sender: TObject;
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

procedure TFLFacturasGastosSalidas.BBAceptarClick(Sender: TObject);
var
  bMostrarReport: boolean;
begin
  if not CerrarForm(true) then
    Exit;
  if not ParametrosCorrectos then
    Exit;

  //Nuevo listado para mostrar datos contables para facturas SOLO de trasporte 14/04/2019
  if  cbbAgrupacion.Items[cbbAgrupacion.ItemIndex] = 'TRANSPORTE' then
  begin
    //Llamamos al QReport
    QLFacturasGastosTransporte := TQLFacturasGastosTransporte.Create(Application);
    try
      bMostrarReport:= ConsultaListadoFacturas;
      if bMostrarReport then
      begin
        CargarTablaTemporal;
        kbmTablaTemporal.IndexFieldNames:= 'empresa;transporte_g;agrupacion;tipo;fecha;factura';
        kbmTablaTemporal.SortFields:= 'empresa;transporte_g;agrupacion;tipo;fecha;factura';
        kbmTablaTemporal.Sort([]);

//        QLFacturasGastosTransporte.sEmpresa:= eEmpresa.Text;
        QLFacturasGastosTransporte.bAgruparFactura:= chkFactura.Checked;
        QLFacturasGastosTransporte.LPeriodo.Caption := EDesde.Text + ' a ' + EHasta.Text;
        if edtProducto.Text <> '' then
          QLFacturasGastosTransporte.lblProducto.Caption := 'ALBARANES CON ' + txtProducto.Caption
        else
          QLFacturasGastosTransporte.lblProducto.Caption := 'TODOS LOS PRODUCTOS.';
        PonLogoGrupoBonnysa(QLFacturasGastosTransporte, eEmpresa.Text );

        if eCliente.Text <> '' then
          QLFacturasGastosTransporte.lblCliente.Caption:= eCliente.Text + ' ' + stCliente.Caption
        else
          QLFacturasGastosTransporte.lblCliente.Caption:= '';
        if eTransporte.Text <> '' then
          QLFacturasGastosTransporte.lblTransporte.Caption:= eTransporte.Text + ' ' + stTransporte.Caption
        else
          QLFacturasGastosTransporte.lblTransporte.Caption:= '';
        QLFacturasGastosTransporte.bndCabecera.Height:= 90;

        Preview(QLFacturasGastosTransporte);
      end
      else
      begin
        FreeAndNil(QLFacturasGastosTransporte);
      end;
    except
      FreeAndNil(QLFacturasGastosTransporte);
      Raise;
    end;
  end
  else
  begin
    //Llamamos al QReport
    QLFacturasGastosSalidas := TQLFacturasGastosSalidas.Create(Application);
    try
      bMostrarReport:= ConsultaListadoFacturas;
      if bMostrarReport then
      begin
        QLFacturasGastosSalidas.sEmpresa:= eEmpresa.Text;
        QLFacturasGastosSalidas.bAgruparFactura:= chkFactura.Checked;
        QLFacturasGastosSalidas.LPeriodo.Caption := EDesde.Text + ' a ' + EHasta.Text;
        if edtProducto.Text <> '' then
          QLFacturasGastosSalidas.lblProducto.Caption := 'ALBARANES CON ' + txtProducto.Caption
        else
          QLFacturasGastosSalidas.lblProducto.Caption := 'TODOS LOS PRODUCTOS.';
        PonLogoGrupoBonnysa(QLFacturasGastosSalidas, eEmpresa.Text );

        if eCliente.Text <> '' then
          QLFacturasGastosSalidas.lblCliente.Caption:= eCliente.Text + ' ' + stCliente.Caption
        else
          QLFacturasGastosSalidas.lblCliente.Caption:= '';
        if eTransporte.Text <> '' then
          QLFacturasGastosSalidas.lblTransporte.Caption:= eTransporte.Text + ' ' + stTransporte.Caption
        else
          QLFacturasGastosSalidas.lblTransporte.Caption:= '';
        QLFacturasGastosSalidas.bndCabecera.Height:= 90;

        Preview(QLFacturasGastosSalidas);
      end
      else
      begin
        FreeAndNil(QLFacturasGastosSalidas);
      end;
    except
      FreeAndNil(QLFacturasGastosSalidas);
      Raise;
    end;
  end;
end;

procedure TFLFacturasGastosSalidas.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLFacturasGastosSalidas.CargarTablaTemporal;
var CodigoX3: string;
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
  QLCompGastosEntregas.First;
  while not QLCompGastosEntregas.Eof do
  begin
    kbmTablaTemporal.Insert;
    kbmTablaTemporal.FieldByName('empresa').AsString := QLCompGastosEntregas.FieldByName('empresa').AsString;
    kbmTablaTemporal.FieldByName('agrupacion').AsString := QLCompGastosEntregas.FieldByName('agrupacion').AsString;
    kbmTablaTemporal.FieldByName('tipo').AsString := QLCompGastosEntregas.FieldByName('tipo').AsString;
    kbmTablaTemporal.FieldByName('cliente').AsString := QLCompGastosEntregas.FieldByName('cliente').AsString;
    kbmTablaTemporal.FieldByName('fecha').AsString := QLCompGastosEntregas.FieldByName('fecha').AsString;
    kbmTablaTemporal.FieldByName('factura').AsString := QLCompGastosEntregas.FieldByName('factura').AsString;
    kbmTablaTemporal.FieldByName('transporte_g').AsInteger := QLCompGastosEntregas.FieldByName('transporte_g').AsInteger;
    kbmTablaTemporal.FieldByName('venta').AsString := QLCompGastosEntregas.FieldByName('venta').AsString;
    kbmTablaTemporal.FieldByName('kilos').AsFloat := QLCompGastosEntregas.FieldByName('kilos').AsFloat;
    kbmTablaTemporal.FieldByName('importe').AsFloat := QLCompGastosEntregas.FieldByName('importe').AsFloat;
    if QLCompGastosEntregas.FieldByName('kilos').AsFloat = 0 then
      kbmTablaTemporal.FieldByName('euro_kilo').AsFloat := 0
    else
      kbmTablaTemporal.FieldByName('euro_kilo').AsFloat := QLCompGastosEntregas.FieldByName('importe').AsFloat /QLCompGastosEntregas.FieldByName('kilos').AsFloat;

    //Datos Contabilidad
    if QLCompGastosEntregas.FieldByName('factura').IsNull then
      aqryX3Factura.Parameters.ParamByName('factura').Value := ''
    else
      aqryX3Factura.Parameters.ParamByName('factura').Value:= QLCompGastosEntregas.FieldByName('factura').AsString;

    CodigoX3 := CodigoX3Transporte(QLCompGastosEntregas.FieldByName('empresa').AsString, QLCompGastosEntregas.FieldByName('transporte_g').AsString);
    if CodigoX3 = ''  then
      aqryX3Factura.Parameters.ParamByName('transporte').Value := ''
    else
      aqryX3Factura.Parameters.ParamByName('transporte').Value:= CodigoX3;
    if (QLCompGastosEntregas.FieldByName('fecha').IsNull) or (YearOf(QLCompGastosEntregas.FieldByName('fecha').AsDateTime) < 1900) then
      aqryX3Factura.Parameters.ParamByName('fecha').value := Null
    else
      aqryX3Factura.Parameters.ParamByName('fecha').Value:= QLCompGastosEntregas.FieldByName('fecha').AsString;
      
    aqryX3Factura.Open;

    kbmTablaTemporal.FieldByName('asiento').AsString := aqryX3Factura.FieldByName('asiento').AsString;
    kbmTablaTemporal.FieldByName('fecha_asiento').AsString := aqryX3Factura.FieldByName('Fecha_Documento').AsString;
    kbmTablaTemporal.FieldByName('base_imponible').AsString := aqryX3Factura.FieldByName('Importe').AsString;

    aqryX3Factura.Close;

    kbmTablaTemporal.Post;

    QLCompGastosEntregas.Next;
  end;

end;

//                     ****  CAMPOS DE EDICION  ****

procedure TFLFacturasGastosSalidas.EHastaExit(Sender: TObject);
begin
  if StrToDate(EHasta.Text) < StrToDate(EDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    EDesde.SetFocus;
  end;
end;

procedure TFLFacturasGastosSalidas.eTransporteChange(Sender: TObject);
begin
  if eTransporte.Text <> '' then
    STTransporte.Caption := desTransporte(eEmpresa.Text, eTransporte.Text)
  else
    STTransporte.Caption := 'Vacio todos los transportes.';

end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLFacturasGastosSalidas.ADesplegarRejillaExecute(Sender: TObject);
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


function TFLFacturasGastosSalidas.ConsultaListadoFacturas: Boolean;
begin
  ConfiguraListadoFacturas;
  with QLCompGastosEntregas do
  begin
    Close;
    if (eEmpresa.Text <> 'BAG') and (eEmpresa.Text <> 'SAT')  then
      ParamByName('empresa').AsString := eEmpresa.Text;
    if eCliente.Text <> '' then
      ParamByName('cliente').AsString := eCliente.Text;
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

function TFLFacturasGastosSalidas.ParametrosCorrectos: boolean;
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
  if STCliente.Caption = '' then
  begin
    ShowMessage('Cliente incorrecto.');
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

procedure TFLFacturasGastosSalidas.eEmpresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(eEmpresa.Text);
end;

procedure TFLFacturasGastosSalidas.eClienteChange(Sender: TObject);
begin
  if eCliente.Text <> '' then
    STCliente.Caption := desCliente(eCliente.Text)
  else
    STCliente.Caption := 'Vacio todos los clientes.';
end;

procedure TFLFacturasGastosSalidas.edtProductoChange(Sender: TObject);
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

procedure TFLFacturasGastosSalidas.edtTipoChange(Sender: TObject);
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

procedure TFLFacturasGastosSalidas.cbbFacturaChange(Sender: TObject);
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
