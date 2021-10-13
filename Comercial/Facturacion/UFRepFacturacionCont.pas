unit UFRepFacturacionCont;

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
  dxSkinXmas2008Blue, BonnyClientDataSet;

type
  TFRepFacturacionCont = class(TForm)
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
    ssSerie: TSimpleSearch;
    txSerie: TcxTextEdit;
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
    QCabFactura, QDetFactura, QBasFactura, QGasFactura: TBonnyClientDataSet;
    lista_f: string;

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
    procedure ActualizaDatosFactura;
    function ActualizaDetFactura: boolean;
    function ActualizaCabFactura: boolean;
    procedure RellenaMemFacturas;
    procedure CreaQCabFactura;
    function EjecutaQCabFactura( ACodFactura: string ): boolean;
    procedure CreaQDetFactura;
    function EjecutaQDetFactura( ACodFactura: string ): boolean;
    procedure CreaQBasFactura;
    function EjecutaQBasFactura( ACodFactura: string ): boolean;
    procedure CreaQGasFactura;
    function EjecutaQGasFactura( ACodFactura: string ): boolean;


  public
    { Public declarations }
  end;

var
  FRepFacturacionCont: TFRepFacturacionCont;

implementation

{$R *.dfm}

uses CVariables, UDMAuxDB, UDFactura,UDMBaseDatos, bDialogs, CFactura, UFRejillaFacturacion,
     CAuxiliarDB, URFactura, UDMConfig, DConfigMail, Principal, DError, DPreview;

procedure TFRepFacturacionCont.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFRepFacturacionCont.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;
  CreaQFacturas;
  CreaQCopias;
end;

procedure TFRepFacturacionCont.FormClose(Sender: TObject;
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

procedure TFRepFacturacionCont.FormShow(Sender: TObject);
begin
  RellenarDatosIni;
end;

procedure TFRepFacturacionCont.CreaQFacturas;
begin
  QFacturas := TBonnyQuery.Create(Self);
  with QFacturas do
  begin
    SQL.Add(' SELECT count(*) registros');
    SQL.Add('   FROM tfacturas_cab ');
    SQL.Add('  WHERE cod_empresa_fac_fc = :empresa');
    SQL.Add('    AND cod_cliente_fc = :cliente');
    SQL.Add('    AND n_factura_fc BETWEEN :DesdeFactura AND :HastaFactura ');
    SQL.Add('    AND fecha_factura_fc BETWEEN :DesdeFecha AND :HastaFecha ');

    SQL.Add('    AND (automatica_fc = 1 ) ');        //Solo facturas Automaticas
    SQL.Add('    AND (anulacion_fc = 0 ) ');         //Solo facturas NO anuladas
    SQL.Add('    AND (contabilizado_fc = 1) ');      //Solo Facturas Contabilizadas

    Prepare;
  end;
end;

procedure TFRepFacturacionCont.CreaQCabFactura;
begin
  QCabFactura := TBonnyClientDataSet.Create(Self);

  with QCabFactura do
  begin
    SQL.Add(' select * from tfacturas_cab ');
    SQL.Add('   where cod_factura_fc in ( :cod_factura ) ');
  end;

end;

procedure TFRepFacturacionCont.CreaQDetFactura;
begin
  QDetFactura := TBonnyClientDataSet.Create(Self);

  with QDetFactura do
  begin
    SQL.Add(' select * from tfacturas_det ');
    SQL.Add('   where cod_factura_fd in ( :cod_factura ) ');
  end;
end;

procedure TFRepFacturacionCont.CreaQGasFactura;
begin
  QGasFactura := TBonnyClientDataSet.Create(Self);

  with QGasFactura do
  begin
    SQL.Add(' select * from tfacturas_gas ');
    SQL.Add('   where cod_factura_fg in ( :cod_factura ) ');
  end;
end;

procedure TFRepFacturacionCont.CreaQBasFactura;
begin
  QBasFactura := TBonnyClientDataSet.Create(Self);

  with QBasFactura do
  begin
    SQL.Add(' select * from tfacturas_bas ');
    SQL.Add('   where cod_factura_fb in ( :cod_factura ) ');
  end;

end;

function TFRepFacturacionCont.EjecutaQCabFactura(ACodFactura: string): boolean;
begin
  with QCabFactura do
  begin
    if Active then
      Close;

    SQL.Clear;
//    SQL.Add(' select * from tfacturas_cab ');
    SQL.Add(' select cod_factura_fc, cod_empresa_fac_fc, cod_serie_fac_fc, n_factura_fc, fecha_factura_fc, impuesto_fc, tipo_factura_fc, automatica_fc, ');
    SQL.Add('        anulacion_fc, cod_factura_anula_fc, cod_cliente_fc, des_cliente_fc, cta_cliente_fc, nif_fc, tipo_via_fc, domicilio_fc, ');
    SQL.Add('        poblacion_fc, cod_postal_fc, provincia_fc, cod_pais_fc, des_pais_fc, notas_fc, incoterm_fc, plaza_incoterm_fc, forma_pago_fc, ');
    SQL.Add('        des_forma_pago_fc, tipo_impuesto_fc, des_tipo_impuesto_fc, moneda_fc, importe_linea_fc, round(importe_descuento_fc, 2) importe_descuento_fc, ');
    SQL.Add('        round(importe_neto_fc, 2) importe_neto_fc, importe_impuesto_fc, round(importe_total_fc, 2) importe_total_fc, round(importe_neto_euros_fc, 2) importe_neto_euros_fc, ');
    SQL.Add('        importe_impuesto_euros_fc, round(importe_total_euros_fc, 2) importe_total_euros_fc, fecha_fac_ini_fc, prevision_cobro_fc, prevision_tesoreria_fc, ');
    SQL.Add('        contabilizado_fc, fecha_conta_fc, filename_conta_fc ');
    SQL.Add('   from tfacturas_cab ');
    SQL.Add('   where cod_factura_fc in (' + ACodFactura +  ' ) ');

    Open;
    Result := not IsEmpty;
  end;

end;

function TFRepFacturacionCont.EjecutaQDetFactura(ACodFactura: string): boolean;
begin
  with QDetFactura do
  begin
    if Active then
      Close;

    SQL.Clear;
//    SQL.Add(' select * from tfacturas_det ');
    SQL.Add(' select cod_factura_fd, num_linea_fd, cod_empresa_albaran_fd, cod_centro_albaran_fd, n_albaran_fd, fecha_albaran_fd, ');
    SQL.Add('        cod_cliente_albaran_fd, cod_dir_sum_fd, pedido_fd, fecha_pedido_fd, matricula_fd, emp_procedencia_fd, centro_origen_fd, ');
    SQL.Add('        cod_factura_origen_fd, cod_producto_fd, des_producto_fd, cod_envase_fd, cod_envaseold_fd, des_envase_fd, categoria_fd, ');
    SQL.Add('        calibre_fd, marca_fd, nom_marca_fd, cajas_fd, unidades_caja_fd, unidades_fd, kilos_fd, kilos_posei_fd, unidad_facturacion_fd, precio_fd, ');
    SQL.Add('        importe_linea_fd, cod_representante_fd, porcentaje_comision_fd, porcentaje_descuento_fd, euroskg_fd, importe_comision_fd, ');
    SQL.Add('        round(importe_descuento_fd, 2) importe_descuento_fd, round(importe_euroskg_fd, 2) importe_euroskg_fd, round(importe_total_descuento_fd, 2) importe_total_descuento_fd, ');
    SQL.Add('        round(importe_neto_fd, 2) importe_neto_fd, tasa_impuesto_fd, porcentaje_impuesto_fd, importe_impuesto_fd, round(importe_total_fd, 2) importe_total_fd, ');
    SQL.Add('        cod_comercial_fd ');
    SQL.Add('   from tfacturas_det ');
    SQL.Add('   where cod_factura_fd in (' + ACodFactura +  ' ) ');

    Open;
    Result := not IsEmpty;
  end;

end;


function TFRepFacturacionCont.EjecutaQGasFactura(ACodFactura: string): boolean;
begin
  with QBasFactura do
  begin
    if Active then
      Close;

    SQL.Clear;
//    SQL.Add(' select * from tfacturas_bas ');
    SQL.Add(' select cod_factura_fb, tasa_impuesto_fb, porcentaje_impuesto_fb, cajas_fb, ');
    SQL.Add('        unidades_fb, kilos_fb, round(importe_neto_fb, 2) importe_neto_fb, ');
    SQL.Add('        round(importe_impuesto_fb, 2) importe_impuesto_fb, round(importe_total_fb, 2) importe_total_fb ');
    SQL.Add('   from tfacturas_bas ');
    SQL.Add('   where cod_factura_fb in (' + ACodFactura +  ' ) ');

    Open;
    Result := not IsEmpty;
  end;

end;

function TFRepFacturacionCont.EjecutaQBasFactura(ACodFactura: string): boolean;
begin
  with QGasFactura do
  begin
    if Active then
      Close;

    SQL.Clear;
    SQL.Add(' select * from tfacturas_gas ');
    SQL.Add('   where cod_factura_fg in (' + ACodFactura +  ' ) ');

    Open;
    Result := not IsEmpty;
  end;
end;

procedure TFRepFacturacionCont.RellenaMemFacturas;
begin
  CreaQCabFactura;
  CreaQDetFactura;
  CreaQBasFactura;
  CreaQGasFactura;

  EjecutaQCabFactura( lista_f );
  EjecutaQDetFactura( lista_f );
  EjecutaQBasFactura( lista_f );
  EjecutaQGasFactura( lista_f );

  DFactura.mtFacturas_Bas.LoadFromDataSet(QBasFactura, []);
  DFactura.mtFacturas_Bas.SortOn('cod_factura_fb', []);
  DFactura.mtFacturas_Gas.LoadFromDataSet(QGasFactura, []);
  DFactura.mtFacturas_Gas.SortOn('cod_factura_fg;fecha_albaran_fg;n_albaran_fg;cod_tipo_gasto_fg', []);
  DFactura.mtFacturas_Det.LoadFromDataSet(QDetFactura, []);
  DFactura.mtFacturas_Det.SortOn('cod_factura_fd;fecha_albaran_fd;pedido_fd;n_albaran_fd;cod_dir_sum_fd;cod_producto_fd;cod_envase_fd', []);
  DFactura.mtFacturas_Cab.LoadFromDataSet(QCabFactura, []);
  DFactura.mtFacturas_Cab.SortOn('cod_factura_fc', []);
end;

procedure TFRepFacturacionCont.CreaQCopias;
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

procedure TFRepFacturacionCont.RellenarDatosIni;
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

procedure TFRepFacturacionCont.PonNombre(Sender: TObject);
begin
  txSerie.Text := txEmpresa.Text;
  txDesEmpresa.Text := desEmpresa(txEmpresa.Text);
  txDesCliente.Text := desCliente(txCliente.Text);
end;

procedure TFRepFacturacionCont.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFRepFacturacionCont.btAceptarClick(Sender: TObject);
begin
  //Datos del formulario correctos
  if not Parametros then exit;

  RepetirFacturas;

  CFactura.LimpiarTemporales;
//  RellenarDatosIni;
end;

function TFRepFacturacionCont.Parametros: boolean;
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

procedure TFRepFacturacionCont.RepetirFacturas;
begin
  //Busqueda facturas
  if not RellenaTabla then
  begin
    Limpiar;
    Exit;
  end;
      //Rellenamos tabla temporal cabecera gastos y bases
  //PreparaFacturacion(True);

  if not RellenaFacturas then
  begin
    Limpiar;
    Exit;
  end;
  
  showmessage('Proceso finalizado correctamente.');
  RellenaMemFacturas;
  Previsualizar;
end;

procedure TFRepFacturacionCont.ssSerieAntesEjecutar(Sender: TObject);
begin
    ssSerie.SQLAdi := '';
    ssSerie.SQLAdi := ' anyo_es >= year(today) -1 ';
    if txEmpresa.Text <> '' then
      ssSerie.SQLAdi := ssSerie.SQLAdi + ' and cod_empresa_es = ' +  QuotedStr(txEmpresa.Text);
end;

procedure TFRepFacturacionCont.txClientePropertiesChange(Sender: TObject);
begin
  txDesCliente.Text := desCliente(txCliente.Text);
end;

function TFRepFacturacionCont.RellenaTabla: Boolean;
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
    SQL.Add(' select * from tfacturas_cab                                      ');
    SQL.Add('  WHERE cod_empresa_fac_fc = :empresa                             ');
    SQL.Add('    AND cod_serie_fac_fc = :serie                                 ');
    SQL.Add('    AND cod_cliente_fc = :cliente                                 ');
    SQL.Add('    AND n_factura_fc BETWEEN :DesdeFactura AND :HastaFactura      ');
    SQL.Add('    AND fecha_factura_fc BETWEEN :DesdeFecha AND :HastaFecha      ');

    SQL.Add('    AND (automatica_fc = 1 )                                     ');
    SQL.Add('    AND (anulacion_fc = 0 )                                      ');
    SQL.Add('    AND (contabilizado_fc = 1)                                   ');


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

  end;
end;

function TFRepFacturacionCont.HaySeleccion: Boolean;
begin
  Result := true;
  with QFacturas do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := txEmpresa.Text;
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

procedure TFRepFacturacionCont.Limpiar;
begin
     //BORRAR CONTENIDO DE LA TABLAs
  LimpiarTemporales;

     //Cerrar todos ls datastes abiertos
  DMBaseDatos.DBBaseDatos.CloseDataSets;

  Gauge1.progress:=0;
  Gauge1.maxvalue:=0;
end;

function TFRepFacturacionCont.Rellenafacturas: boolean;
var iInsertadas, iFacturas, long: Integer;
begin
  iInsertadas := 0;
  DFactura.QGeneral.First;
  DFactura.QGeneral.Last;
  iFacturas := DFactura.QGeneral.Recordcount;
  Gauge1.maxvalue:=iFacturas;
  Lbfacturas.Caption:= 'Total facturas: '+formatfloat(',0',iFacturas);
  lista_f := '';

  DFactura.QGeneral.First;
  // Actualizar datos del albaran en Facturas
  while not DFactura.QGeneral.Eof do
  begin
    //ABRIR TRANSACCION
    if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
      break;

    if not ActualizaDetFactura then
      break;

    if not ActualizaCabFactura then
      break;

    AceptarTransaccion(DMBaseDatos.DBBaseDatos);

    lista_f := lista_f +  QuotedStr(DFactura.QGeneral.FieldByName('cod_factura_fc').AsString) + ',';

    DFactura.QGeneral.Next;

    Inc(iInsertadas);
    Gauge1.progress:=Gauge1.progress+1;
  end;
  long := length(lista_f);
  lista_f[long] := ' ';


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

procedure TFRepFacturacionCont.Previsualizar;
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

procedure TFRepFacturacionCont.OrdenaMemFacturas;
begin
  DFactura.mtFacturas_Gas.SortOn('cod_factura_fg;fecha_albaran_fg;n_albaran_fg;cod_tipo_gasto_fg', []);
  DFactura.mtFacturas_Det.SortOn('cod_factura_fd;fecha_albaran_fd;pedido_fd;n_albaran_fd;cod_dir_sum_fd;cod_producto_fd;cod_envase_fd', []);
  DFactura.mtFacturas_Cab.sortOn('cod_factura_fc', []);
end;

function TFRepFacturacionCont.AsuntoFactura: string;
var sIniFactura, sFinFactura, sIniCliente, sFinCliente: string;
begin
  DFactura.mtFacturas_Cab.First;
  sIniFactura := DFactura.mtFacturas_Cab.fieldbyname('cod_factura_fc').AsString;
  DFactura.mtFacturas_Cab.Last;
  sFinFactura := DFactura.mtFacturas_Cab.fieldbyname('cod_factura_fc').AsString;

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

function TFRepFacturacionCont.NumeroCopias: Integer;
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

procedure TFRepFacturacionCont.AAceptarExecute(Sender: TObject);
begin
  btAceptar.Click;
end;

procedure TFRepFacturacionCont.ACancelarExecute(Sender: TObject);
begin
  btCancelar.Click;
end;

procedure TFRepFacturacionCont.ActualizaDatosFactura;
begin



  if AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
  begin
    try
      ActualizaDetFactura;
      ActualizaCabFactura;
      DMBaseDatos.DBBaseDatos.Commit;
    except
      on e: Exception do
      begin
        DMBaseDatos.DBBaseDatos.RollBack;
        raise Exception.Create('ERROR al modificar datos de Factura --> ' + #13 + #10 + e.Message );
      end;
    end;
  end
  else
  begin
    raise Exception.Create('No puedo modificar datos de factura.' + #13 + #10 +
                           'No puedo abrir la transacción.' );
  end;
end;

function TFRepFacturacionCont.ActualizaDetFactura: boolean;
begin
  Result := true;
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select cod_factura_fc,                                                                                                                ');
    SQL.Add('          cod_empresa_fac_fc EmpresaFacturacion,                                                                                       ');
    SQL.Add('          cod_serie_fac_fc serieFacturacion,                                                                                           ');
    SQL.Add('          n_factura_fc fac_interno_fd,                                                                                                 ');
    SQL.Add('          fecha_factura_fc fechaFacturacion,                                                                                           ');
    SQL.Add('          empresa_sc,                                                                                                                  ');
    SQL.Add(' 	       centro_salida_sc,                                                                                                            ');
    SQL.Add('          n_albaran_sc,                                                                                                                ');
    SQL.Add(' 	       fecha_sc,                                                                                                                    ');
    SQL.Add('          n_pedido_sc,                                                                                                                 ');
    SQL.Add('          fecha_pedido_sc,                                                                                                             ');
    SQL.Add('          vehiculo_sc,                                                                                                                 ');
    SQL.Add('          incoterm_sc,                                                                                                                 ');
    SQL.Add('          plaza_incoterm_sc                                                                                                            ');
    SQL.Add(' from tfacturas_cab, tfacturas_det, frf_salidas_c                                                                                      ');
    SQL.Add('  WHERE cod_factura_fc = :cod_factura                                                                                                  ');

    SQL.Add('     AND empresa_fac_sc = cod_empresa_fac_fc                                                                                           ');
    SQL.Add('     AND serie_fac_sc = cod_serie_fac_fc                                                                                               ');
    SQL.Add('     AND n_factura_sc = n_factura_fc                                                                                                   ');
    SQL.Add('     AND fecha_factura_sc = fecha_factura_fc                                                                                           ');

    SQL.Add('     AND cod_empresa_albaran_fd = empresa_sc                                                                                           ');
    SQL.Add('     AND cod_centro_albaran_fd = centro_salida_sc                                                                                      ');
    SQL.Add('     AND n_albaran_fd = n_albaran_sc                                                                                                   ');
    SQL.Add('     AND fecha_albaran_fd = fecha_sc                                                                                                   ');

    SQL.Add('     AND cod_factura_fd = cod_factura_fc                                                                                               ');

    SQL.Add(' group by cod_factura_fc, cod_empresa_fac_fc, cod_serie_fac_fc, n_factura_fc, fecha_factura_fc, empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc,    ');
    SQL.Add('          n_pedido_sc, fecha_pedido_sc, vehiculo_sc, incoterm_sc, plaza_incoterm_sc                                                    ');
    SQL.Add(' order by cod_factura_fc, cod_empresa_fac_fc, cod_serie_fac_fc, n_factura_fc, fecha_factura_fc, empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc,    ');
    SQL.Add('          n_pedido_sc, fecha_pedido_sc, vehiculo_sc, incoterm_sc, plaza_incoterm_sc                                                    ');

    ParamByName('cod_factura').AsString := DFactura.QGeneral.FieldByName('cod_factura_fc').AsString;

    Open;

    while not DMAuxDB.QAux.Eof do
    begin
      with DMAuxDB.QDescripciones do
      begin
        SQL.Clear;
        SQL.Add(' update tfacturas_det set pedido_fd = :pedido,             ');
        SQL.Add('                          fecha_pedido_fd = :fecha_pedido, ');
        SQL.Add('                          matricula_fd = :matricula        ');
        SQL.Add('  where cod_factura_fd = :cod_factura                      ');
        SQL.Add('    and cod_empresa_albaran_fd = :empresa_alb              ');
        SQL.Add('    and cod_centro_albaran_fd = :centro_alb                ');
        SQL.Add('    and n_albaran_fd = :numero_alb                         ');
        SQL.Add('    and fecha_albaran_fd = :fecha_alb                      ');

        ParamByName('cod_factura').AsString := DMAuxDB.QAux.FieldByName('cod_factura_fc').AsString;
        ParamByName('empresa_alb').AsString := DMAuxDB.QAux.FieldByName('empresa_sc').AsString;
        ParamByName('centro_alb').AsString := DMAuxDB.QAux.FieldByName('centro_salida_sc').AsString;
        ParamByName('numero_alb').AsString := DMAuxDB.QAux.FieldByName('n_albaran_sc').AsString;
        ParamByName('fecha_alb').AsString := DMAuxDB.QAux.FieldByName('fecha_sc').AsString;
        ParamByName('pedido').AsString := DMAuxDB.QAux.FieldByName('n_pedido_sc').AsString;
        ParamByName('fecha_pedido').AsString := DMAuxDB.QAux.FieldByName('fecha_pedido_sc').AsString;
        ParamByName('matricula').AsString := DMAuxDB.QAux.FieldByName('vehiculo_sc').AsString;

        try
          EjecutarConsulta(DMAuxDB.QDescripciones);
        except
          CancelarTransaccion(DMBaseDatos.DBBaseDatos);
          result := false;
        end;
      end;

    DMAuxDB.QAux.Next;
    end;
  end;
end;

function TFRepFacturacionCont.ActualizaCabFactura: boolean;
begin

  Result := true;
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select cod_factura_fc,                                                                                                                ');
    SQL.Add('          incoterm_sc,                                                                                                                 ');
    SQL.Add('          plaza_incoterm_sc                                                                                                            ');
    SQL.Add(' from tfacturas_cab, tfacturas_det, frf_salidas_c                                                                                      ');
    SQL.Add('  WHERE cod_factura_fc = :cod_factura                                                                                                  ');

    SQL.Add('     AND empresa_fac_sc = cod_empresa_fac_fc                                                                                           ');
    SQL.Add('     AND serie_fac_sc = cod_serie_fac_fc                                                                                               ');
    SQL.Add('     AND n_factura_sc = n_factura_fc                                                                                                   ');
    SQL.Add('     AND fecha_factura_sc = fecha_factura_fc                                                                                           ');

    SQL.Add('     AND cod_empresa_albaran_fd = empresa_sc                                                                                           ');
    SQL.Add('     AND cod_centro_albaran_fd = centro_salida_sc                                                                                      ');
    SQL.Add('     AND n_albaran_fd = n_albaran_sc                                                                                                   ');
    SQL.Add('     AND fecha_albaran_fd = fecha_sc                                                                                                   ');

    SQL.Add('     AND cod_factura_fd = cod_factura_fc                                                                                               ');

    SQL.Add(' group by cod_factura_fc, incoterm_sc, plaza_incoterm_sc                                                    ');
    SQL.Add(' order by cod_factura_fc, incoterm_sc, plaza_incoterm_sc                                                    ');

    ParamByName('cod_factura').AsString := DFactura.QGeneral.FieldByName('cod_factura_fc').AsString;

    Open;

    while not DMAuxDB.QAux.Eof do
    begin
      with DMAuxDB.QDescripciones do
      begin

        SQL.Clear;
        SQL.Add(' update tfacturas_cab set incoterm_fc = :incoterm,             ');
        SQL.Add('                          plaza_incoterm_fc = :plaza_incoterm  ');
        SQL.Add('  where cod_factura_fc = :cod_factura                          ');

        ParamByName('cod_factura').AsString :=  DMAuxDB.QAux.FieldByName('cod_factura_fc').AsString;
        ParamByName('incoterm').AsString :=  DMAuxDB.QAux.FieldByName('incoterm_sc').AsString;
        ParamByName('plaza_incoterm').AsString :=  DMAuxDB.QAux.FieldByName('plaza_incoterm_sc').AsString;

        try
          EjecutarConsulta(DMAuxDB.QDescripciones);
        except
          CancelarTransaccion(DMBaseDatos.DBBaseDatos);
          result := false;
        end;
      end;

      DMAuxDB.QAux.Next;
    end;
  end;
end;

end.
