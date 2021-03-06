unit LAlbaranesSalida;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls, Dialogs,
  StdCtrls, ExtCtrls, Forms, Quickrpt, Db, DBTables, Printers, jpeg, QRCtrls;

type
  TQRAlbaranesSalida = class(TQuickRep)
    BonnyBand: TQRBand;
    LClienteSalida: TQRLabel;
    LDireccionSuministro: TQRLabel;
    LDomicilio: TQRLabel;
    Lpoblacion: TQRLabel;
    LProvincia: TQRLabel;
    LPais: TQRLabel;
    QAlbaran: TQuery;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRDBText14: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText12: TQRDBText;
    qrdbtxtalbaran: TQRDBText;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRDBText16: TQRDBText;
    QRShape20: TQRShape;
    QRShape23: TQRShape;
    QRShape24: TQRShape;
    QRShape25: TQRShape;
    QRShape26: TQRShape;
    QRShape22: TQRShape;
    QRShape21: TQRShape;
    QRShape27: TQRShape;
    QRShape19: TQRShape;
    QRShape18: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    ChildBand1: TQRChildBand;
    QRLabel22: TQRLabel;
    QRShape29: TQRShape;
    QRLabel23: TQRLabel;
    QRShape30: TQRShape;
    QRLabel24: TQRLabel;
    QRShape31: TQRShape;
    QRLabel25: TQRLabel;
    QRShape32: TQRShape;
    pslCalibre: TQRLabel;
    QRShape33: TQRShape;
    QRLabel27: TQRLabel;
    QRShape34: TQRShape;
    QRLabel28: TQRLabel;
    QRShape35: TQRShape;
    QRLabel29: TQRLabel;
    QRShape36: TQRShape;
    QRLabel30: TQRLabel;
    BandaPieDetalle: TQRBand;
    CabGrupoDetalles: TQRGroup;
    BandaDatosDetalle: TQRBand;
    LCajas: TQRExpr;
    LKilos: TQRExpr;
    LImporte: TQRExpr;
    QRBand1: TQRBand;
    QRExpr3: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr1: TQRExpr;
    psdCalibre: TQRDBText;
    color: TQRDBText;
    marca: TQRDBText;
    LEnvase: TQRLabel;
    LProducto: TQRLabel;
    PrecioUnidad: TQRDBText;
    LPor: TQRLabel;
    UnidadCobro: TQRDBText;
    lin1: TQRShape;
    lin2: TQRShape;
    lin3: TQRShape;
    lin4: TQRShape;
    lin5: TQRShape;
    lin6: TQRShape;
    lin7: TQRShape;
    lin8: TQRShape;
    ImporteAcum: TQRExpr;
    psImporte: TQRLabel;
    psIva: TQRLabel;
    psTotal: TQRLabel;
    BandaObserbaciones: TQRChildBand;
    Rneto: TQRShape;
    Riva: TQRShape;
    Rtotal: TQRShape;
    moneda1: TQRLabel;
    moneda2: TQRLabel;
    moneda3: TQRLabel;
    Lneto: TQRLabel;
    LIva: TQRLabel;
    Ltotal: TQRLabel;
    BandaCalidad: TQRChildBand;
    psMemoCalidad: TQRMemo;
    LObservaciones: TQRLabel;
    DataSource1: TDataSource;
    LPalets: TQRLabel;
    LLogifruit: TQRLabel;
    QPalets: TQuery;
    psMemoPalets: TQRMemo;
    psMemoCajas: TQRMemo;
    QLogifruit: TQuery;
    QAlbarancod_empresa: TStringField;
    QAlbaranempresa: TStringField;
    QAlbarancod_centro_salida: TStringField;
    QAlbarancentro_salida: TStringField;
    QAlbaranalbaran: TIntegerField;
    QAlbaranfecha_albaran: TDateField;
    QAlbaranhora_albaran: TStringField;
    QAlbarancod_cliente_salida: TStringField;
    QAlbarancliente_salida: TStringField;
    QAlbaranvia_cli: TStringField;
    QAlbarandomicilio_cli: TStringField;
    QAlbaranpoblacion_cli: TStringField;
    QAlbarancod_postal_cli: TStringField;
    QAlbaranprovincia_cli: TStringField;
    QAlbarancod_pais_cli: TStringField;
    QAlbaranpais_cli: TStringField;
    QAlbaranvalorar_albaran: TStringField;
    QAlbarancod_suministro: TStringField;
    QAlbaransuministro: TStringField;
    QAlbaranvia_sum: TStringField;
    QAlbarandomicilio_sum: TStringField;
    QAlbarancod_postal_sum: TStringField;
    QAlbaranpoblacion_sum: TStringField;
    QAlbaranprovincia_sum_ext: TStringField;
    QAlbaranprovincia_sum_esp: TStringField;
    QAlbarancod_pais_sum: TStringField;
    QAlbaranpais_sum: TStringField;
    QAlbarancod_moneda: TStringField;
    QAlbarannumero_pedido: TStringField;
    QAlbarancod_transporte: TSmallintField;
    QAlbarantransporte: TStringField;
    QAlbaranvehiculo: TStringField;
    QAlbarancod_producto: TStringField;
    QAlbaranproducto_castellan: TStringField;
    QAlbaranproducto_ingles: TStringField;
    QAlbarancod_marca: TStringField;
    QAlbaranmarca: TStringField;
    QAlbarancod_envase: TStringField;
    QAlbaranenvase_castellano: TStringField;
    QAlbaranenvase_ingles: TStringField;
    QAlbaranunidades_envase: TSmallintField;
    QAlbarancalibre: TStringField;
    QAlbarancod_color: TStringField;
    QAlbarancajas: TIntegerField;
    QAlbarankilos: TFloatField;
    QAlbaranprecio: TFloatField;
    QAlbaranunidad_precio: TStringField;
    QAlbaranporcentaje_iva: TFloatField;
    QAlbaranimporte_neto: TFloatField;
    QAlbaraniva: TFloatField;
    QAlbaranimporte_total: TFloatField;
    QAlbarancod_iva: TStringField;
    QAlbaraniva_descrip_corta: TStringField;
    QAlbaraniva_descrip_larga: TStringField;
    QRLabel1: TQRLabel;
    QRNotas: TQRMemo;
    QNotas: TQuery;
    QRImageCab: TQRImage;
    PsEmpresa: TQRLabel;
    PsNif: TQRLabel;
    PsDireccion: TQRLabel;
    qrdbtxtalbaran2: TQRDBText;
    procedure BandaDireccionBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure CabGrupoDetallesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRAlbaranesSalidaBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure BandaPieDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BandaCalidadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BandaCalidadAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure BandaObserbacionesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure LProductoPrint(sender: TObject; var Value: string);
    procedure QRAlbaranesSalidaAfterPrint(Sender: TObject);
    procedure BandaDatosDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtalbaranPrint(sender: TObject; var Value: String);
    procedure qrdbtxtalbaran2Print(sender: TObject; var Value: String);
  private
    EsBonnysa: Boolean;
    ClienteEspanyol: Boolean;
    HayTomate: Boolean;
    Mascara: string;
    

    bMultiproductoInf, bMultiproductoLin: Boolean;

    procedure Configurar(const AEmpresa: string);
    procedure SQLAlbaran( const AFactura, APendientes: boolean);

    procedure SinDireccionSuministro;
    procedure ConDireccionSuministro;

    procedure DescripcionProducto;
    procedure DescripcionEnvase;
  public
    ExistReport: Boolean;

  end;

function ExecuteAlbaranesToPDF(empresa, cliente, desde, hasta: string;
                               const APendientes: boolean): Boolean;
procedure PreviewAlbaranesFactura( const AEmpresa: string; const AFactura: integer; const AFecha: TDateTime );

implementation

uses CVariables, StrUtils, UDMAuxDB, DError, DEnvioAlbSal, Variants,
   DPreview, bTextUtils;

{$R *.DFM}


procedure TQRAlbaranesSalida.SQLAlbaran( const AFactura, APendientes: boolean);
begin
  with QAlbaran do
  begin
    SQL.Clear;

    SQL.Add('   SELECT ');
    SQL.Add('        Frf_salidas_c.empresa_sc cod_empresa, ');
    SQL.Add('        Frf_empresas.nombre_e empresa, ');

    SQL.Add('        Frf_salidas_c.centro_salida_sc cod_centro_salida, ');
    SQL.Add('        Frf_centros_1.descripcion_c centro_salida, ');

    SQL.Add('        Frf_salidas_c.n_albaran_sc albaran, ');
    SQL.Add('        Frf_salidas_c.fecha_sc fecha_albaran, ');
    SQL.Add('        Frf_salidas_c.hora_sc hora_albaran, ');

    SQL.Add('        Frf_salidas_c.cliente_sal_sc cod_cliente_salida, ');
    SQL.Add('        Frf_clientes_1.nombre_c cliente_salida, ');
    SQL.Add('        Frf_clientes_1.tipo_via_c via_cli, ');
    SQL.Add('        Frf_clientes_1.domicilio_c domicilio_cli, ');
    SQL.Add('        Frf_clientes_1.poblacion_c poblacion_cli, ');
    SQL.Add('        Frf_clientes_1.cod_postal_c cod_postal_cli, ');
    SQL.Add('        Frf_provincias.nombre_p provincia_cli, ');
    SQL.Add('        Frf_clientes_1.pais_c cod_pais_cli, ');
    SQL.Add('        Frf_paises1.descripcion_p pais_cli, ');

    SQL.Add('        case when Frf_clientes_1.tipo_albaran_c = 1 then ''S'' else ''N'' end valorar_albaran, ');

    SQL.Add('        Frf_salidas_c.dir_sum_sc cod_suministro, ');
    SQL.Add('        Frf_dir_sum.nombre_ds suministro, ');
    SQL.Add('        Frf_dir_sum.tipo_via_ds via_sum, ');
    SQL.Add('        Frf_dir_sum.domicilio_ds domicilio_sum, ');
    SQL.Add('        Frf_dir_sum.cod_postal_ds cod_postal_sum, ');
    SQL.Add('        Frf_dir_sum.poblacion_ds poblacion_sum, ');
    SQL.Add('        Frf_dir_sum.provincia_ds provincia_sum_ext, ');
    SQL.Add('        Frf_provincias2.nombre_p provincia_sum_esp, ');
    SQL.Add('        Frf_dir_sum.pais_ds cod_pais_sum, ');
    SQL.Add('        Frf_paises2.descripcion_p pais_sum, ');

    SQL.Add('        Frf_salidas_c.moneda_sc cod_moneda, ');
    SQL.Add('        Frf_salidas_c.n_pedido_sc numero_pedido, ');
    SQL.Add('        Frf_salidas_c.transporte_sc cod_transporte, ');
    SQL.Add('        Frf_transportistas.descripcion_t transporte, ');
    SQL.Add('        Frf_salidas_c.vehiculo_sc vehiculo, ');

    SQL.Add('        Frf_salidas_l.producto_sl cod_producto, ');
    SQL.Add('        Frf_productos.descripcion_p producto_castellan, ');
    SQL.Add('        Frf_productos.descripcion2_p producto_ingles, ');

    SQL.Add('        Frf_salidas_l.marca_sl cod_marca, ');
    SQL.Add('        Frf_marcas.descripcion_m marca, ');

    SQL.Add('        Frf_salidas_l.envase_sl cod_envase, ');
    SQL.Add('        Frf_envases.descripcion_e envase_castellano, ');
    SQL.Add('        Frf_envases.descripcion2_e envase_ingles, ');
    SQL.Add('        Frf_salidas_l.unidades_caja_sl unidades_envase, ');

    SQL.Add('        Frf_salidas_l.calibre_sl calibre, ');
    SQL.Add('        Frf_salidas_l.color_sl cod_color, ');

    SQL.Add('        Frf_salidas_l.cajas_sl cajas, ');
    SQL.Add('        Frf_salidas_l.kilos_sl kilos, ');
    SQL.Add('        Frf_salidas_l.precio_sl precio, ');
    SQL.Add('        Frf_salidas_l.unidad_precio_sl unidad_precio, ');
    SQL.Add('        Frf_salidas_l.porc_iva_sl porcentaje_iva, ');

    SQL.Add('        Frf_salidas_l.importe_neto_sl importe_neto, ');
    SQL.Add('        Frf_salidas_l.iva_sl iva, ');
    SQL.Add('        Frf_salidas_l.importe_total_sl importe_total, ');

    SQL.Add('        Frf_salidas_l.tipo_iva_sl cod_iva, ');
    SQL.Add('        Frf_impuestos.tipo_i iva_descrip_corta, ');
    SQL.Add('        Frf_impuestos.descripcion_i iva_descrip_larga ');

    SQL.Add(' FROM ');
    SQL.Add('        frf_empresas Frf_empresas, ');
    SQL.Add('        frf_salidas_c Frf_salidas_c, ');
    SQL.Add('        frf_centros Frf_centros_1, ');
    SQL.Add('        frf_transportistas Frf_transportistas, ');
    SQL.Add('        frf_salidas_l Frf_salidas_l, ');
    SQL.Add('        frf_productos Frf_productos, ');
    SQL.Add('        frf_clientes Frf_clientes_1, ');
    SQL.Add('        frf_marcas Frf_marcas, ');
    SQL.Add('        frf_envases Frf_envases, ');
    SQL.Add('        frf_paises Frf_paises1, ');
    SQL.Add('        frf_impuestos Frf_impuestos, ');
    SQL.Add('        OUTER (frf_dir_sum Frf_dir_sum, ');
    SQL.Add('        OUTER frf_paises Frf_paises2, ');
    SQL.Add('        OUTER frf_provincias Frf_provincias2), ');
    SQL.Add('        OUTER frf_provincias Frf_provincias ');

    if AFactura then
    begin
      SQL.Add(' WHERE ');
      SQL.Add('    (Frf_empresas.empresa_e = :empresa) ');

      SQL.Add('    AND  (Frf_salidas_c.fecha_factura_sc=:fecha) ');
      SQL.Add('    AND  (Frf_salidas_c.n_factura_sc = :factura) ');
    end
    else
    begin
      SQL.Add(' WHERE ');
      SQL.Add('    (Frf_empresas.empresa_e = :empresa) ');

      SQL.Add('    AND  (Frf_salidas_c.empresa_sc=Frf_empresas.empresa_e) ');
      SQL.Add('    AND  (Frf_salidas_c.fecha_sc BETWEEN :desde AND :hasta) ');
      SQL.Add('    AND  (Frf_salidas_c.cliente_sal_sc=:cliente) ');
    end;

    SQL.Add('    AND  (Frf_centros_1.empresa_c = Frf_empresas.empresa_e) ');
    SQL.Add('    AND  (Frf_centros_1.centro_c = Frf_salidas_c.centro_salida_sc) ');

    SQL.Add('    AND  (Frf_transportistas.transporte_t = Frf_salidas_c.transporte_sc) ');

    SQL.Add('    AND  (Frf_salidas_l.empresa_sl = Frf_empresas.empresa_e) ');
    SQL.Add('    AND  (Frf_salidas_l.centro_salida_sl = Frf_salidas_c.centro_salida_sc) ');
    SQL.Add('    AND  (Frf_salidas_l.n_albaran_sl = Frf_salidas_c.n_albaran_sc) ');
    SQL.Add('    AND  (Frf_salidas_l.fecha_sl = Frf_salidas_c.fecha_sc) ');

    SQL.Add('    AND  (Frf_productos.producto_p = Frf_salidas_l.producto_sl) ');

    SQL.Add('    AND  (Frf_clientes_1.cliente_c = Frf_salidas_c.cliente_sal_sc) ');

    SQL.Add('    AND  (Frf_marcas.codigo_m = Frf_salidas_l.marca_sl) ');

    SQL.Add('    AND  (Frf_envases.envase_e = Frf_salidas_l.envase_sl) ');

    SQL.Add('    AND  (Frf_paises1.pais_p = Frf_clientes_1.pais_c) ');

    SQL.Add('    AND  (Frf_impuestos.codigo_i = Frf_salidas_l.tipo_iva_sl) ');

    SQL.Add('    AND  (Frf_dir_sum.cliente_ds = Frf_salidas_c.cliente_sal_sc) ');
    SQL.Add('    AND  (Frf_dir_sum.dir_sum_ds = Frf_salidas_c.dir_sum_sc) ');

    SQL.Add('    AND  (Frf_paises2.pais_p = Frf_dir_sum.pais_ds) ');

    SQL.Add('    AND  (Frf_provincias2.codigo_p = Frf_dir_sum.cod_postal_ds[1,2]) ');

    SQL.Add('    AND  (Frf_provincias.codigo_p = Frf_clientes_1.cod_postal_c[1,2]) ');

    if APendientes then
    begin
      SQL.Add('    AND  n_albaran_sc NOT IN (SELECT n_albaran_ae FROM frf_alb_enviados ');
      SQL.Add('                              WHERE empresa_ae = empresa_sc ');
      SQL.Add('                              AND   cliente_sal_ae = cliente_sal_sc ');
      SQL.Add('                              AND   n_albaran_ae = n_albaran_sc ');
      SQL.Add('                              AND   fecha_ae = fecha_sc) ');
    end;


    if AFactura then
    begin
    SQL.Add(' ORDER BY ');
    SQL.Add('        Frf_salidas_c.empresa_sc , Frf_salidas_c.centro_salida_sc , ');
    SQL.Add('        Frf_salidas_c.fecha_sc , Frf_salidas_c.n_albaran_sc , ');

    SQL.Add('        Frf_salidas_l.producto_sl , Frf_salidas_l.envase_sl , ');
    SQL.Add('        Frf_salidas_l.marca_sl , Frf_salidas_l.color_sl , ');
    SQL.Add('        Frf_salidas_l.calibre_sl , Frf_salidas_l.precio_sl, ');
    SQL.Add('        Frf_salidas_l.unidad_precio_sl ');
    end
    else
    begin
    SQL.Add(' ORDER BY ');
    SQL.Add('        Frf_salidas_c.empresa_sc , Frf_salidas_c.cliente_sal_sc , ');
    SQL.Add('        Frf_salidas_c.dir_sum_sc , Frf_salidas_c.centro_salida_sc , ');
    SQL.Add('        Frf_salidas_c.n_albaran_sc , Frf_salidas_c.fecha_sc , ');

    SQL.Add('        Frf_salidas_l.producto_sl , Frf_salidas_l.envase_sl , ');
    SQL.Add('        Frf_salidas_l.marca_sl , Frf_salidas_l.color_sl , ');
    SQL.Add('        Frf_salidas_l.calibre_sl , Frf_salidas_l.precio_sl, ');
    SQL.Add('        Frf_salidas_l.unidad_precio_sl ');
    end;
  end;
end;


function ExecuteAlbaranesToPDF(empresa, cliente, desde, hasta: string;
                               const APendientes: boolean ): Boolean;
var
  aux: string;
  bFactura: Boolean;
begin
  with TQRAlbaranesSalida.Create(Application) do
  begin
    try
      //Cabecera del albaran
      Configurar(empresa);

      QAlbaran.Close;
      bFactura:= False;
      SQLAlbaran( bFactura, APendientes );

      QAlbaran.ParamByName('empresa').AsString := empresa;
      QAlbaran.ParamByName('cliente').AsString := cliente;
      QAlbaran.ParamByName('desde').AsDateTime := StrToDate(desde);
      QAlbaran.ParamByName('hasta').AsDateTime := StrToDate(hasta);
      QAlbaran.Open;

      //Crear PDF, cambio los separadores de fecha
      aux := 'Albaran ' + desde;
      ReportTitle := StringReplace(aux, '/', '-', [rfReplaceAll, rfIgnoreCase]);
      //cambiar por TStringList
      FDEnvioAlbSal.Adjunto.Add(gsDirActual + '\..\temp'  + '\' + ReportTitle + '.pdf');
                                  //gDirectorioTemporal
      if giPrintPDF > -1 then
      begin
        PrinterSettings.PrinterIndex := giPrintPDF;
        ShowProgress := False;
        Screen.Cursor := crHourGlass;
        try
          //ReportTitle:= StringReplace(Trim(ReportTitle), ' ', '_', [rfReplaceAll]);
          ReportTitle:= Trim(ReportTitle);
          print;
        except
          ShowError('Existe un problema al crear los albaranes.' + #13#10 +
            'Cierre el programa, reinicie el ordenador y vuelva a lanzarlo.');
          Application.ProcessMessages;
          ExistReport := False;
        end;
        Application.ProcessMessages;
      end
      else
      begin
        Result := False;
        Screen.Cursor := crDefault;
        Free;
        Exit;
      end;
    finally
      Result := ExistReport;
      Screen.Cursor := crDefault;
      Free;
      Application.ProcessMessages;
    end;
  end;
end;


procedure PreviewAlbaranesFactura( const AEmpresa: string; const AFactura: integer; const AFecha: TDateTime );
var
  bFactura, bPendientes: Boolean;
  QRAlbaranesSalida: TQRAlbaranesSalida;
begin
  QRAlbaranesSalida:= TQRAlbaranesSalida.Create(Application);
  with QRAlbaranesSalida do
  begin
    //Cabecera del albaran
    Configurar(AEmpresa);
    ReportTitle := AEmpresa + '_' + FormatDateTime( 'aaaammdd', AFecha ) + '_' + IntTostr( AFactura );

    QAlbaran.Close;
    bFactura:= True;
    bPendientes:= False;
    SQLAlbaran( bFactura, bPendientes );

    QAlbaran.ParamByName('empresa').AsString := AEmpresa;
    QAlbaran.ParamByName('factura').AsInteger := AFactura;
    QAlbaran.ParamByName('fecha').AsDateTime := AFecha;

    try
      QAlbaran.Open;
      if not QAlbaran.IsEmpty then
      begin
        DPreview.Preview(QRAlbaranesSalida);
      end
      else
      begin
        ShowMessage('Sin albaranes asociados.');
        QAlbaran.Close;
        FreeAndNil( QRAlbaranesSalida);
      end;
    except
      QAlbaran.Close;
      FreeAndNil( QRAlbaranesSalida);
    end;
  end;
end;

procedure TQRAlbaranesSalida.QRAlbaranesSalidaBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  try
    //Abrir tablas *******************************************************
    QAlbaran.Open;

    if QAlbaran.IsEmpty then
    begin
      MessageDlg('' + #13 + #10 + '  No existen albaranes para el cliente y        ' + #13 + #10 + '  rango de fechas seleccionado.', mtInformation, [mbOK], 0);
      PrintReport := False;
      ExistReport := False;
      Exit;
    end;
    ExistReport := True;
    //Observaciones
    QNotas.Open;
    //Palets y cajas logifruit
    QPalets.Open;
    QLogifruit.Open;
    //*********************************************************************
  except
    MessageDlg('' + #13 + #10 + 'No se puede generar el informe.' + #13 + #10 + '' + #13 + #10 + 'Error al intentar seleccionar datos para la     ' + #13 + #10 + 'generaci?n de los albaranes.', mtError, [mbOK], 0);
    PrintReport := False;
    Exit;
  end;

  //Valorar Albaranes *******************************************************
  if QAlbaranvalorar_albaran.AsString = 'N' then
  begin
    PrecioUnidad.Enabled := False;
    LPor.Enabled := False;
    UnidadCobro.Enabled := False;
    LImporte.Enabled := False;
  end;
  //*********************************************************************

  //Mascara Segun moneda ************************************************
    Mascara := '#,##0.00';
  LImporte.Mask := Mascara;
  //*********************************************************************

  CabGrupoDetalles.Height := 0;

  if QAlbarancod_pais_cli.AsString = 'ES' then ClienteEspanyol := true
  else ClienteEspanyol := False;

  if QAlbarancod_empresa.AsString = '050' then EsBonnysa := true
  else EsBonnysa := False;

  HayTomate := False;
  bMultiproductoInf:= False;
  bMultiproductoLin:= False;
end;

procedure TQRAlbaranesSalida.Configurar(const AEmpresa: string);
var
  bAux: Boolean;
  sAux, ssEmpresa: string;
begin
      if ( AEmpresa = '050' ) or ( AEmpresa = '080' ) then
      ssEmpresa:= 'SAT'
    else
      ssEmpresa:= AEmpresa;
  bAux:= FileExists( gsDirActual + '\recursos\' + ssEmpresa + 'Page.wmf');
  if bAux then
  begin
    QRImageCab.Top:= -18; //-20
    QRImageCab.Left:= -37; //-20
    QRImageCab.Width:= 763; //-30
    QRImageCab.Height:= 1102; //-20
    QRImageCab.Picture.LoadFromFile( gsDirActual + '\recursos\' + ssEmpresa + 'Page.wmf');
    QRImageCab.Stretch:= True;
    QRImageCab.Enabled:= True;
  end
  else
  begin
    QRImageCab.Enabled:= False;
    ConsultaOpen(DMAuxDB.QAux,
      ' select nombre_e,nif_e,tipo_via_e,domicilio_e,cod_postal_e, ' +
      '        poblacion_e,nombre_p ' +
      ' from frf_empresas,frf_provincias ' +
      ' where empresa_e=' + QuotedStr(Trim(AEmpresa)) +
      '   and cod_postal_e[1,2]=codigo_p');

    with DMAuxDB.QAux do
    begin
      PsEmpresa.Caption := FieldByName('nombre_e').AsString;
      PsNif.Caption := 'NIF: ' + FieldByName('nif_e').AsString;

      sAux := '';
      if Trim(FieldByName('tipo_via_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('tipo_via_e').AsString) + '. ';
      if Trim(FieldByName('domicilio_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('domicilio_e').AsString) + '      ';
      if Trim(FieldByName('cod_postal_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('cod_postal_e').AsString) + '  ';
      if Trim(FieldByName('poblacion_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('poblacion_e').AsString) + '      ';
      if Trim(FieldByName('cod_postal_e').AsString) <> '' then
       sAux := sAux + '(' + Trim(FieldByName('nombre_p').AsString) + ')  ';

      PsDireccion.Caption := sAux;

      Close;
    end;
  end;

  PsDireccion.Enabled:= not bAux;
  PsEmpresa.Enabled:= not bAux;
  PsNif.Enabled:= not bAux;
end;

procedure TQRAlbaranesSalida.BandaDireccionBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if QAlbaran.FieldByName('suministro').Value = NULL then
  begin
    SinDireccionSuministro;
  end
  else
  begin
    ConDireccionSuministro;
  end;
end;

procedure TQRAlbaranesSalida.BandaPieDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  importe, iva, total: Real;
begin
  //Valorar Albaranes *******************************************************
  if QAlbaranvalorar_albaran.AsString = 'N' then
  begin
    importe := 0;
    iva := 0;
    total := 0;

    LNeto.Enabled := False;
    LIva.Enabled := False;
    LTotal.Enabled := False;
    RNeto.Enabled := False;
    RIva.Enabled := False;
    RTotal.Enabled := False;
    psIva.Enabled := False;

    moneda1.Enabled := False;
    moneda2.Enabled := False;
    moneda3.Enabled := False;
  end
  else
  begin
    importe := ImporteAcum.Value.dblResult;
    if QAlbaran.FieldByName('porcentaje_iva').AsFloat <> 0 then
      iva := Round(importe * QAlbaran.FieldByName('porcentaje_iva').AsFloat) / 100
    else
      iva := 0;
    total := importe + iva;

    moneda1.Caption := QAlbaran.FieldByName('cod_moneda').AsString;
    moneda2.Caption := QAlbaran.FieldByName('cod_moneda').AsString;
    moneda3.Caption := QAlbaran.FieldByName('cod_moneda').AsString;
  end;

  if importe = 0 then psImporte.Caption := ''
  else psImporte.Caption := FormatFloat(Mascara, importe);

  if QAlbaran.FieldByName('porcentaje_iva').AsFloat <> 0 then
  begin
    if importe = 0 then psIva.Caption := ''
    else psIva.Caption := FormatFloat(Mascara, iva);

    LIva.Enabled := True;
    LIva.Caption := 'Total ' + QAlbaran.FieldByName('iva_descrip_corta').AsString +
      ' ' + QAlbaran.FieldByName('porcentaje_iva').AsString + '%';
    RIva.Enabled := True;
    moneda2.Enabled := True;
  end
  else
  begin
    psIva.Caption := QAlbaran.FieldByName('iva_descrip_larga').AsString;

    LIva.Enabled := False;
    RIva.Enabled := False;
    moneda2.Enabled := False;
  end;

  if importe = 0 then psTotal.Caption := ''
  else psTotal.Caption := FormatFloat(Mascara, total);



  //Palets
  psMemoPalets.Lines.Clear;
  LPalets.Enabled := not QPalets.IsEmpty;
  if LPalets.Enabled then
  begin
    while not QPalets.Eof do
    begin
      psMemoPalets.Lines.Add(QPalets.FieldByName('palets').asstring);
      QPalets.Next;
    end;
  end;

  //Cajas logifruit
  psMemoCajas.Lines.Clear;
  LLogifruit.Enabled := not QLogifruit.IsEmpty;
  if LLogifruit.Enabled then
  begin
    while not QLogifruit.Eof do
    begin
      psMemoCajas.Lines.Add(QLogifruit.FieldByName('logifruit').asstring);
      QLogifruit.Next;
    end;
  end;
end;

procedure TQRAlbaranesSalida.ConDireccionSuministro;
var
  pais, provincia: string;
begin
  LClienteSalida.Caption := QAlbaran.FieldByName('cliente_salida').AsString;
  LDireccionSuministro.Caption := QAlbaran.FieldByName('suministro').AsString;

  if QAlbaran.FieldByName('via_sum').AsString <> '' then
    LDomicilio.Caption := QAlbaran.FieldByName('via_sum').AsString + '/ ' + QAlbaran.FieldByName('domicilio_sum').AsString
  else
    LDomicilio.Caption := QAlbaran.FieldByName('domicilio_sum').AsString;

  Lpoblacion.Caption := QAlbaran.FieldByName('poblacion_sum').AsString;

  if QAlbaran.FieldByName('cod_pais_sum').AsString = 'ES' then
  begin
    provincia := QAlbaran.FieldByName('provincia_sum_esp').AsString;
    pais := '';
  end
  else
  begin
    if QAlbaran.FieldByName('provincia_sum_ext').AsString = '' then
    begin
      provincia := QAlbaran.FieldByName('pais_sum').AsString;
      pais := '';
    end
    else
    begin
      provincia := QAlbaran.FieldByName('provincia_sum_ext').AsString;
      pais := QAlbaran.FieldByName('pais_sum').AsString;
    end;
  end;

  if QAlbaran.FieldByName('cod_postal_sum').AsString <> '' then
    LProvincia.Caption := QAlbaran.FieldByName('cod_postal_sum').AsString + '    ' + provincia
  else
    LProvincia.Caption := provincia;

  LPais.Caption := pais;
end;

procedure TQRAlbaranesSalida.SinDireccionSuministro;
var
  provincia: string;
begin
  LClienteSalida.Caption := '';
  LDireccionSuministro.Caption := QAlbaran.FieldByName('cliente_salida').AsString;

  if QAlbaran.FieldByName('via_cli').AsString <> '' then
    LDomicilio.Caption := QAlbaran.FieldByName('via_cli').AsString + '/ ' + QAlbaran.FieldByName('domicilio_cli').AsString
  else
    LDomicilio.Caption := QAlbaran.FieldByName('domicilio_cli').AsString;

  LPoblacion.Caption := QAlbaran.FieldByName('poblacion_cli').AsString;

  if QAlbaran.FieldByName('cod_pais_cli').AsString = 'ES' then
    provincia := QAlbaran.FieldByName('provincia_cli').AsString
  else
    provincia := QAlbaran.FieldByName('pais_cli').AsString;

  if QAlbaran.FieldByName('cod_postal_cli').AsString <> '' then
    LProvincia.Caption := QAlbaran.FieldByName('cod_postal_cli').AsString + '    ' + provincia
  else
    LProvincia.Caption := provincia;

  LPais.Caption := '';
end;

procedure TQRAlbaranesSalida.CabGrupoDetallesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  DescripcionProducto;
  DescripcionEnvase;
  if EsBonnysa then
    if (QAlbarancod_producto.AsString = 'TOM') or         //(QAlbarancod_producto.AsString = 'T') or
      (QAlbarancod_producto.AsString = 'TCP') or            //(QAlbarancod_producto.AsString = 'F') or
      (QAlbarancod_producto.AsString = 'RAM') or            //(QAlbarancod_producto.AsString = 'R') or
      (QAlbarancod_producto.AsString = 'TOM') or            //(QAlbarancod_producto.AsString = 'E') or
      (QAlbarancod_producto.AsString = 'RAF') or            //(QAlbarancod_producto.AsString = 'M') or
      (QAlbarancod_producto.AsString = 'TCH') then            //(QAlbarancod_producto.AsString = 'C') then
      HayTomate := True;
end;

procedure TQRAlbaranesSalida.DescripcionProducto;
begin
  if QAlbaran.FieldByName('cod_pais_cli').AsString = 'ES' then
  begin
    LProducto.Caption := QAlbaran.FieldByName('producto_castellan').AsString;
  end
  else
  begin
    if QAlbaran.FieldByName('producto_ingles').AsString <> '' then
    begin
      LProducto.Caption := QAlbaran.FieldByName('producto_ingles').AsString;
    end
    else
    begin
      LProducto.Caption := QAlbaran.FieldByName('producto_castellan').AsString;
    end;
  end;
end;

procedure TQRAlbaranesSalida.DescripcionEnvase;
begin
  if QAlbaran.FieldByName('cod_pais_cli').AsString = 'ES' then
  begin
    LEnvase.Caption := QAlbaran.FieldByName('envase_castellano').AsString;
  end
  else
  begin
    if QAlbaran.FieldByName('envase_ingles').AsString <> '' then
    begin
      LEnvase.Caption := QAlbaran.FieldByName('envase_ingles').AsString;
    end
    else
    begin
      LEnvase.Caption := QAlbaran.FieldByName('envase_castellano').AsString;
    end;
  end;
end;

procedure TQRAlbaranesSalida.BandaCalidadBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := HayTomate;
  if not HayTomate then Exit;

  if ClienteEspanyol then
  begin
    psMemoCalidad.Lines.Text := 'Toda la producci?n de tomate comercializada por ' +
      'S.A.T. N?9359 BONNYSA est? certificada conforme a ' +
      'las normas UNE 155001-1 (1997) y UNE 155001-2.';
  end
  else
  begin
    psMemoCalidad.Lines.Text := 'All the tomatoes packed by S.A.T N?9359 BONNYSA are ' +
      'certified according to UNE 155001-1 (1997) and UNE ' +
      '155001-2 product standards.';
  end;
end;

procedure TQRAlbaranesSalida.BandaCalidadAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  HayTomate := False;
end;

procedure TQRAlbaranesSalida.BandaObserbacionesBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := not QNotas.IsEmpty;
  if PrintBand then
  begin
    QRNotas.Lines.Clear;
    QRNotas.Lines.Add( QNotas.Fields[0].AsString )
  end;
end;

procedure TQRAlbaranesSalida.LProductoPrint(sender: TObject;
  var Value: string);
begin
  //BEEF
  if QAlbaran.FieldByName('cod_producto').AsString <> 'ES' then
    if ((QAlbaran.FieldByName('cod_producto').AsString = 'TOM') or
      (QAlbaran.FieldByName('cod_producto').AsString = 'TOM')) and
      ((Trim(QAlbaran.FieldByName('calibre').AsString) = 'G') or
      (Trim(QAlbaran.FieldByName('calibre').AsString) = 'GG')) and
      (QAlbaran.FieldByName('cod_envase').AsString <> '001')
      then Value := 'BEEF';
end;

procedure TQRAlbaranesSalida.QRAlbaranesSalidaAfterPrint(Sender: TObject);
begin
  try
    //Abrir tablas *******************************************************
    QAlbaran.Close;
    //Observaciones
    QNotas.Close;
    //Palets y cajas logifruit
    QPalets.Close;
    QLogifruit.Close;
    //*********************************************************************
  except
  end;
end;

procedure TQRAlbaranesSalida.BandaDatosDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  bMultiproductoLin:= Copy( QAlbaran.FieldByName('cod_envase').AsString, 1, 1 ) = 'M';
  bMultiproductoInf:= bMultiproductoInf or bMultiproductoLin;
end;

procedure TQRAlbaranesSalida.qrdbtxtalbaranPrint(sender: TObject;
  var Value: String);
begin
    if ( Copy( DataSet.FieldByName('cod_empresa').AsString, 1, 1) = 'F' ) and ( DataSet.FieldByName('cod_cliente_salida').AsString <> 'ECI' )then
    begin
      Value := DataSet.FieldByName('cod_empresa').AsString + DataSet.FieldByName('cod_centro_salida').AsString + Rellena( Value, 5, '0', taLeftJustify );
      qrdbtxtalbaran.Alignment := taRightJustify;
      qrdbtxtalbaran.Width:= 73;
      qrdbtxtalbaran.Left:= 42;
    end
    else
    //Bargosa
    if Trim( DataSet.FieldByName('cod_empresa').AsString ) = '505' then
    begin
      Value := 'BON.' + Rellena( Value, 5, '0', taLeftJustify );
      qrdbtxtalbaran.Alignment := taRightJustify;
      qrdbtxtalbaran.Width:= 73;
      qrdbtxtalbaran.Left:= 42;
    end
    else
    begin
      qrdbtxtalbaran.Alignment := taCenter;
      qrdbtxtalbaran.Width:= 87;
      qrdbtxtalbaran.Left:= 42;
    end;
end;

procedure TQRAlbaranesSalida.qrdbtxtalbaran2Print(sender: TObject;
  var Value: String);
begin
    if ( Copy( DataSet.FieldByName('cod_empresa').AsString, 1, 1) = 'F' ) and ( DataSet.FieldByName('cod_cliente_salida').AsString <> 'ECI' )then
    begin
      Value := Coletilla( DataSet.FieldByName('cod_empresa').AsString );
      qrdbtxtalbaran2.Enabled := True;
    end
    else
    //Bargosa
    if Trim( DataSet.FieldByName('cod_empresa').AsString ) = '505' then
    begin
      Value := '';
      qrdbtxtalbaran2.Enabled := False;
    end
    else
    begin
      Value := '';
      qrdbtxtalbaran2.Enabled := False;
    end;
end;

end.

