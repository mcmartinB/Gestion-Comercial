unit UFRepFacturacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  CMaestroDetalle, Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, ComCtrls, dxCore, cxDateUtils, Menus, ActnList, cxCheckBox,
  StdCtrls, cxButtons, SimpleSearch, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxLabel, cxGroupBox, Gauges, ExtCtrls, cxTextEdit,
  BonnyQuery, CGestionPrincipal,

  dxSkinsCore, dxSkinMoneyTwins, dxSkinBlue, dxSkinFoggy, dxSkinBlueprint,
  dxSkinBlack, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue;

type
  TFRepFacturacion = class(TForm)
    tx1: TcxTextEdit;
    pnl1: TPanel;
    Gauge1: TGauge;
    gbCriterios: TcxGroupBox;
    lb2: TcxLabel;
    txDesdeFactura: TcxTextEdit;
    lb3: TcxLabel;
    txHastaFactura: TcxTextEdit;
    lb4: TcxLabel;
    deDesdeFecha: TcxDateEdit;
    lbCliente: TcxLabel;
    txCliente: TcxTextEdit;
    txDesCliente: TcxTextEdit;
    gbCopias: TcxGroupBox;
    cbOriginal: TcxCheckBox;
    cbEmpresa: TcxCheckBox;
    btAceptar: TcxButton;
    btCancelar: TcxButton;
    lb7: TcxLabel;
    lbFacturas: TcxLabel;
    lb5: TcxLabel;
    txEmpresa: TcxTextEdit;
    txDesEmpresa: TcxTextEdit;
    lb1: TcxLabel;
    deHastaFecha: TcxDateEdit;
    ActionList: TActionList;
    ssEmpresa: TSimpleSearch;
    ssCliente: TSimpleSearch;
    AAceptar: TAction;
    ACancelar: TAction;
    cxLabel1: TcxLabel;
    txSerie: TcxTextEdit;
    ssSerie: TSimpleSearch;
    procedure btCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btAceptarClick(Sender: TObject);
    procedure AAceptarExecute(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure ssSerieAntesEjecutar(Sender: TObject);
    procedure txClientePropertiesChange(Sender: TObject);
  private
    QFacturas, QCopias: TBonnyQuery;

    procedure CreaQFacturas;
    procedure CreaQCopias;
    procedure RellenarDatosIni;
    function Parametros: boolean;
    procedure RepetirFacturas;
    function RellenaTabla: Boolean;
    function HaySeleccion: Boolean;
    procedure Limpiar;
    function Rellenafacturas: boolean;
    procedure Previsualizar;
    procedure OrdenaMemFacturas;
    function AsuntoFactura: string;
    function NumeroCopias: Integer;

  public
    { Public declarations }
  end;

var
  FRepFacturacion: TFRepFacturacion;

implementation

{$R *.dfm}

uses CVariables, UDMAuxDB, UDFactura,UDMBaseDatos, bDialogs, CFactura, UFRejillaFacturacion,
     CAuxiliarDB, URFactura, UDMConfig, DConfigMail, Principal, DError, DPreview;

procedure TFRepFacturacion.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFRepFacturacion.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;
  CreaQFacturas;
  CreaQCopias;
end;

procedure TFRepFacturacion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

//  Limpiar;

  BEMensajes('');
  Action := caFree;

  CloseQuerys([QFacturas, QCopias]);
end;

procedure TFRepFacturacion.FormShow(Sender: TObject);
begin
  RellenarDatosIni;
end;

procedure TFRepFacturacion.CreaQFacturas;
begin
  QFacturas := TBonnyQuery.Create(Self);
  with QFacturas do
  begin
    SQL.Add(' SELECT count(*) registros');
    SQL.Add('   FROM tfacturas_cab ');
    SQL.Add('  WHERE cod_empresa_fac_fc = :empresa');
    SQL.Add('    AND cod_serie_fac_fc = :serie ');
    SQL.Add('    AND cod_cliente_fc = :cliente');
    SQL.Add('    AND n_factura_fc BETWEEN :DesdeFactura AND :HastaFactura ');
    SQL.Add('    AND fecha_factura_fc BETWEEN :DesdeFecha AND :HastaFecha ');

    SQL.Add('    AND (automatica_fc = 1 ) ');        //Solo facturas Automaticas
    SQL.Add('    AND (anulacion_fc = 0 ) ');         //Solo facturas NO anuladas
    SQL.Add('    AND (contabilizado_fc = 0) ');      //Solo Pendiente de contabilizar

    Prepare;
  end;
end;

procedure TFRepFacturacion.CreaQCopias;
begin
  QCopias := TBonnyQuery.Create(Self);
  with QCopias do
  begin
    SQL.Add(' SELECT MAX(n_copias_fac_c) ');
    SQL.Add('   FROM frf_clientes ');
    SQL.Add('  WHERE cliente_c = :cliente ');

    Prepare;
   end;
end;

procedure TFRepFacturacion.RellenarDatosIni;
begin
   //Borrar contenido de las tablas
  Limpiar;

   //Rellenamos datos iniciales
  txEmpresa.Text := gsDefEmpresa;
  txDesdeFactura.Text := '1';
  txHastaFactura.Text := '999999';
  deDesdeFecha.Text := DateToStr(Date);
  deHastaFecha.Text := DateToStr(Date);

  Gauge1.progress:=0;
  Gauge1.maxvalue:=0;
  lbFacturas.Caption := 'Total Facturas: 0';

  txEmpresa.SetFocus;
end;

procedure TFRepFacturacion.PonNombre(Sender: TObject);
begin
  txSerie.Text := txEmpresa.Text;
  txDesEmpresa.Text := desEmpresa(txEmpresa.Text);
  txDesCliente.Text := desCliente(txCliente.Text);
end;

procedure TFRepFacturacion.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFRepFacturacion.btAceptarClick(Sender: TObject);
begin
  //Datos del formulario correctos
  if not Parametros then exit;

  RepetirFacturas;

  CFactura.LimpiarTemporales;
//  RellenarDatosIni;
end;

function TFRepFacturacion.Parametros: boolean;
begin
     //Comprobar que todos los campos tienen valor
  if txDesEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición.');
    txEmpresa.SetFocus;
    Result := false;
    Exit;
  end;

  //comprobar que existe la serie
  if not ExisteSerie(txEmpresa.Text, txSerie.Text, deDesdeFecha.Text) then
  begin
    ShowError('No existe la serie de facturación indicada.');
    txSerie.SetFocus;
    Result := false;
    Exit;
  end;

  if txDesCliente.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición.');
    txCliente.SetFocus;
    Result := false;
    Exit;
  end;
  if trim(deDesdeFecha.Text) = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición.');
    deDesdeFecha.SetFocus;
    Result := false;
    Exit;
  end;
  if trim(deHastaFecha.Text) = '' then
  begin
    deHastaFecha.Text := deDesdeFecha.Text;
  end;
  if deDesdeFecha.Date > deHastaFecha.Date then
  begin
    ShowError('La fecha de factura del campo "desde" debe ser menor o igual que ' +
      ' la fecha almacenada en el campo "hasta".');
    deDesdeFecha.SetFocus;
    Result := false;
    Exit;
  end;
  if trim(txDesdeFactura.Text) = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición.');
    txDesdeFactura.SetFocus;
    Result := false;
    Exit;
  end;
  if trim(txHastaFactura.Text) = '' then
  begin
    txHastaFactura.Text := txDesdeFactura.Text;
  end;
     //Desde menor que hasta
  try
    if StrToInt(txDesdeFactura.Text) > StrToInt(txHastaFactura.Text) then
    begin
      ShowError('El numero de factura del campo "desde" debe ser menor o igual que ' +
        ' el número almacenado en el campo "hasta".');
      txDesdeFactura.SetFocus;
      Result := false;
      Exit;
    end;
  except
    ShowError('Los números  de facturas deben de ser enteros.');
    txDesdeFactura.SetFocus;
    Result := false;
    Exit;
  end;
  Result := true;
end;

procedure TFRepFacturacion.RepetirFacturas;
begin
     //Rellenamos tabla temporal lineas
  if not RellenaTabla then
  begin
    Limpiar;
    Exit;
  end;
      //Rellenamos tabla temporal cabecera gastos y bases
  PreparaFacturacion(True);

  if not RellenaFacturas then
  begin
    Limpiar;
    Exit;
  end;
  
  showmessage('Proceso finalizado correctamente.');
  Previsualizar;
end;

procedure TFRepFacturacion.ssSerieAntesEjecutar(Sender: TObject);
begin
    ssSerie.SQLAdi := '';
    ssSerie.SQLAdi := ' anyo_es >= year(today) -1 ';
    if txEmpresa.Text <> '' then
      ssSerie.SQLAdi := ssSerie.SQLAdi + ' and cod_empresa_es = ' +  QuotedStr(txEmpresa.Text);
end;

procedure TFRepFacturacion.txClientePropertiesChange(Sender: TObject);
begin
  txDesCliente.Text := desCliente(txCliente.Text);
end;

function TFRepFacturacion.RellenaTabla: Boolean;
begin
     //LINEAS
  if not HaySeleccion then
  begin
    Result := False;
    Exit;
  end;
  with DFactura.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add(' SELECT  cod_factura_fc, ');
    SQL.Add('         cod_empresa_fac_fc EmpresaFacturacion, ');
    SQL.Add('         cod_serie_fac_fc serieFacturacion, ');
    SQL.Add('         n_factura_fc fac_interno_fd, ');
    SQL.Add('         fecha_factura_fc fechaFacturacion, ');
    SQL.Add('         cod_cliente_fc clienteFacturacion, ');
    SQL.Add('         empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc, cliente_sal_sc, porte_bonny_sc,           ');
    SQL.Add('         dir_sum_sc, n_pedido_sc, fecha_pedido_sc, vehiculo_sc, moneda_sc, incoterm_sc, plaza_incoterm_sc, facturable_sc, ');
    SQL.Add('         emp_procedencia_sl, centro_origen_sl, ');
    SQL.Add('         producto_sl, envase_sl, categoria_sl, calibre_sl, marca_sl, unidades_caja_sl,                   ');
    SQL.Add('         unidad_precio_sl, precio_sl, tipo_iva_sl, porc_iva_sl, comercial_sl,                            ');

    SQL.Add('         pais_fac_c, representante_c, frf_productos.descripcion_p, frf_productos.descripcion2_p,         ');

    SQL.Add('         descripcion_e, descripcion2_e, tipo_iva_e,                                                      ');

    SQL.Add('         SUM(cajas_sl) cajas_sl, SUM(kilos_sl) kilos_sl, SUM(n_palets_sl) palets_sl, SUM(importe_neto_sl) importe_neto_sl, sum(kilos_posei_sl) kilos_posei_sl            ');

    SQL.Add('FROM tfacturas_cab, frf_salidas_c, frf_salidas_l, frf_clientes, frf_productos, frf_envases ');

    SQL.Add('  WHERE cod_empresa_fac_fc = :empresa');
    SQL.Add('    AND cod_serie_fac_fc = :serie ');
    SQL.Add('    AND cod_cliente_fc = :cliente');
    SQL.Add('    AND n_factura_fc BETWEEN :DesdeFactura AND :HastaFactura ');
    SQL.Add('    AND fecha_factura_fc BETWEEN :DesdeFecha AND :HastaFecha ');

    SQL.Add('    AND (automatica_fc = 1 ) ');        //Solo facturas Automaticas
    SQL.Add('    AND (anulacion_fc = 0 ) ');         //Solo facturas NO anuladas
    SQL.Add('    AND (contabilizado_fc = 0) ');      //Solo Pendiente de contabilizar

    SQL.Add('    AND empresa_fac_sc = cod_empresa_fac_fc  ');
    SQL.Add('    AND serie_fac_sc = cod_serie_fac_fc      ');
    SQL.Add('    AND n_factura_sc = n_factura_fc ');
    SQL.Add('    AND fecha_factura_sc = fecha_factura_fc ');

    SQL.Add('AND empresa_sl = empresa_sc ');
    SQL.Add('AND centro_salida_sl = centro_salida_sc ');
    SQL.Add('AND n_albaran_sl = n_albaran_sc ');
    SQL.Add('AND fecha_sl = fecha_sc ');

    SQL.Add('AND cliente_c = cliente_fac_sc ');

    SQL.Add('AND producto_p = producto_sl ');

    SQL.Add('AND envase_e = envase_sl ');
    SQL.Add('AND (producto_e = producto_p OR producto_e IS NULL) ');

    SQL.Add('GROUP BY cod_factura_fc, cod_empresa_fac_fc, cod_serie_fac_fc, n_factura_fc, fecha_factura_fc, cod_cliente_fc, ');
    SQL.Add('         empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc, cliente_sal_sc, porte_bonny_sc, ');
    SQL.Add('         dir_sum_sc, n_pedido_sc, fecha_pedido_sc, vehiculo_sc, moneda_sc, incoterm_sc, plaza_incoterm_sc, facturable_sc, ');
    SQL.Add('         emp_procedencia_sl, centro_origen_sl, ');
    SQL.Add('       	producto_sl, envase_sl, categoria_sl, calibre_sl, marca_sl, color_sl, unidades_caja_sl, ');
    SQL.Add('       	unidad_precio_sl, precio_sl, tipo_iva_sl, porc_iva_sl, comercial_sl, pais_fac_c, representante_c, ');
    SQL.Add('       	frf_productos.descripcion_p, frf_productos.descripcion2_p, ');
    SQL.Add('       	descripcion_e, descripcion2_e, tipo_iva_e ');
    SQL.Add('ORDER BY facturable_sc, fecha_sc, n_pedido_sc, n_albaran_sc, dir_sum_sc, producto_sl, envase_sl ');



         //PARAMETROS
    ParamByName('empresa').AsString := txEmpresa.Text;
    ParamByName('serie').AsString := txSerie.Text;
    ParamByName('cliente').AsString := txCliente.Text;
    ParamByName('DesdeFactura').AsInteger := StrToInt(txDesdeFactura.Text);
    ParamByName('HastaFactura').AsInteger := StrToInt(txHastaFactura.Text);
    ParamByName('DesdeFecha').AsDateTime := deDesdeFecha.Date;
    ParamByName('HastaFecha').AsDateTime := deHastaFecha.Date;

    try
      Open;
      if isEmpty then
      begin
        Advertir('No existen facturas que cumplan el criterio seleccionado.');
        Result := false;
        Exit;
      end;
    except
      Result := false;
      Exit;
    end;

    //Rellenamos tabla en memoria - Lineas facturas mtFacturas_Det
    RellenaMemLineasFacturas(True);

  Result := True;
  end;
end;

function TFRepFacturacion.HaySeleccion: Boolean;
begin
  Result := true;
  with QFacturas do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := txEmpresa.Text;
    ParamByName('serie').AsString := txSerie.Text;
    ParamByName('cliente').AsString := txCliente.Text;
    ParamByName('DesdeFactura').AsInteger := StrToInt(txDesdeFactura.Text);
    ParamByName('HastaFactura').AsInteger := StrToInt(txHastaFactura.Text);
    ParamByName('DesdeFecha').AsDateTime := deDesdeFecha.Date;
    ParamByName('HastaFecha').AsDateTime := deHastaFecha.Date;

    Open;
    if FieldByName('registros').AsInteger = 0 then
    begin
      Advertir('No existen facturas que cumplan el criterio seleccionado.');
      Result := false;
      Exit;
    end;
  end;
end;

procedure TFRepFacturacion.Limpiar;
begin
     //BORRAR CONTENIDO DE LA TABLAs
  LimpiarTemporales;

     //Cerrar todos ls datastes abiertos
  DMBaseDatos.DBBaseDatos.CloseDataSets;

  Gauge1.progress:=0;
  Gauge1.maxvalue:=0;
end;

function TFRepFacturacion.Rellenafacturas: boolean;
var iInsertadas, iFacturas: Integer;
begin
  iInsertadas := 0;
  iFacturas := DFactura.mtFacturas_Cab.Recordcount;
  Gauge1.maxvalue:=iFacturas;
  Lbfacturas.Caption:= 'Total facturas: '+formatfloat(',0',iFacturas);

        //Recorrer tablas y actualizar datos
  DFactura.mtFacturas_Cab.First;
  while not DFactura.mtFacturas_Cab.Eof do
  begin
             //ABRIR TRANSACCION
    if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
      break;

          //Borramos datos en tfacturas_gas (BD)
    if not BorraFacturaGastos(DFactura.mtFacturas_Cab.FieldByName('cod_factura_fc').AsString) then
      Break;
          //Borramos datos en tfacturas_det (BD)
    if not BorraFacturaDetalle(DFactura.mtFacturas_Cab.FieldByName('cod_factura_fc').AsString) then
      Break;
          //Borramos datos en tfacturas_bas (BD)
    if not BorraFacturaBase(DFactura.mtFacturas_Cab.FieldByName('cod_factura_fc').AsString) then
      Break;
          //Borramos datos en tfacturas_cab (BD)
    if not BorraFacturaCabecera(DFactura.mtFacturas_Cab.FieldByName('cod_factura_fc').AsString) then
      Break;

          // Insertamos en tfacturas_cab (BD)
    if not InsertaFacturaCabecera(DFactura.mtFacturas_Cab.FieldByName('cod_factura_fc').AsString,
                                  DFactura.mtFacturas_Cab.FieldByName('n_factura_fc').AsInteger) then
      break;

          // Insertamos en tfacturas_gas (BD)
    if not InsertaFacturaGastos(DFactura.mtFacturas_Cab.FieldByName('cod_factura_fc').AsString) then
      break;

          // Insertamos en tfacturas_det (BD)
    if not InsertaFacturaDetalle(DFactura.mtFacturas_Cab.FieldByName('cod_factura_fc').AsString,
                                 DFactura.mtFacturas_Cab.FieldByName('n_factura_fc').AsInteger, True) then
      Break;

         // Insertamos en tfacturas_bas (BD)
    if not InsertaFacturaBase(DFactura.mtFacturas_Cab.FieldByName('cod_factura_fc').AsString) then
      Break;

    AceptarTransaccion(DMBaseDatos.DBBaseDatos);

    DFactura.mtFacturas_Cab.Next;

    Inc(iInsertadas);
    Gauge1.progress:=Gauge1.progress+1;
  end;

  if (iInsertadas < iFacturas) or (iInsertadas = 0) then
  begin
    if iInsertadas = 0 then
    begin
      ShowError('No se ha podido realizar la operacion.');
      RellenaFacturas := false;
      Exit;
    end
    else
    begin
      ShowError('No se ha podido realizar la operación completa.' +
        ' Se han insertado ' + IntToStr(iInsertadas) + ' facturas de ' +
        IntToStr(iFacturas) + ' posibles.');
      RellenaFacturas := false;
      Exit;
    end;
  end;

  RellenaFacturas := true;
end;

procedure TFRepFacturacion.Previsualizar;
begin

  OrdenaMemFacturas;

  DConfigMail.sAsunto:= AsuntoFactura;
  DConfigMail.sEmpresaConfig:= txEmpresa.Text;
  DConfigMail.sClienteConfig:= txCliente.Text;

  RFactura := TRFactura.Create(Application);
//  RFactura.LabelFecha.Caption := deFechaFactura.Text;
  RFactura.definitivo := true;
  RFactura.bProforma := false;

  RFactura.Configurar(txEmpresa.Text, txCliente.Text);
  RFactura.printOriginal := cbOriginal.Checked;
  RFactura.printEmpresa := cbEmpresa.Checked;

  DPreview.bCanSend := (DMConfig.EsLaFont);
  if cbOriginal.Checked then
    RFactura.Tag:= 1
  else
  if cbEmpresa.Checked then
    RFactura.Tag:= 2
  else
    RFactura.Tag:= 3;
  Preview(RFactura, NumeroCopias, False, True);
end;

procedure TFRepFacturacion.OrdenaMemFacturas;
begin
  DFactura.mtFacturas_Gas.SortOn('cod_factura_fg;fecha_albaran_fg;n_albaran_fg;cod_tipo_gasto_fg', []);
  DFactura.mtFacturas_Det.SortOn('cod_factura_fd;fecha_albaran_fd;pedido_fd;n_albaran_fd;cod_dir_sum_fd;cod_producto_fd;cod_envase_fd', []);
  DFactura.mtFacturas_Cab.sortOn('cod_factura_fc', []);
end;

function TFRepFacturacion.AsuntoFactura: string;
var sIniFactura, sFinFactura, sIniCliente, sFinCliente: string;
begin
  DFactura.mtFacturas_Cab.First;
  sIniFactura := DFactura.mtFacturas_Cab.fieldbyname('n_factura_fc').AsString;
  DFactura.mtFacturas_Cab.Last;
  sFinFactura := DFactura.mtFacturas_Cab.fieldbyname('n_factura_fc').AsString;

  sIniCliente := DFactura.mtFacturas_Cab.fieldbyname('cod_cliente_fc').AsString;
  sFinCliente := DFactura.mtFacturas_Cab.fieldbyname('cod_cliente_fc').AsString;

  if sIniFactura <> sFinFactura then
  begin
    result:= 'Envío facturas ' + sIniFactura + '-' + sFinFactura;
    if sIniCliente <> sFinCliente then
    begin
      result:= result + ' [' + sIniCliente + '-' + sFinCliente + ']';
    end
    else
    begin
      result:= result + ' [' + desCliente( sIniCliente ) + ']';
    end;
  end
  else
  begin
    result:= 'Envío factura ' + sIniFactura + ' [' + desCliente( sIniCliente ) + ']';
  end;
end;

function TFRepFacturacion.NumeroCopias: Integer;
var aux: integer;
begin
  with QCopias do
  begin
    if Active then
      Close;

    ParamByName('cliente').AsString := txCliente.Text;

    try
      AbrirConsulta(QCopias);
    except
             //
    end;
    aux := Fields[0].AsInteger;
    if (aux > 1) and not cbOriginal.Checked then Dec(aux);
    if (aux > 1) and not cbEmpresa.Checked then Dec(aux);
    NumeroCopias := aux;
  end;
end;

procedure TFRepFacturacion.AAceptarExecute(Sender: TObject);
begin
  btAceptar.Click;
end;

procedure TFRepFacturacion.ACancelarExecute(Sender: TObject);
begin
  btCancelar.Click;
end;

end.
