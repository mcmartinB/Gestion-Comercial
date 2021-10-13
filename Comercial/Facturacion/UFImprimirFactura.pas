unit UFImprimirFactura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, ComCtrls, dxCore,
  cxDateUtils, Menus, StdCtrls, cxButtons, SimpleSearch, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxLabel, cxGroupBox, Gauges, ExtCtrls,
  cxTextEdit, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxCheckGroup, BonnyClientDataSet, cxCurrencyEdit,
  dxBar, cxRadioGroup, cxCheckBox, dxBarBuiltInMenu,
  cxPC, ActnList, SQLExprEdit, SQLExprStrEdit, SQLExprIntEdit, SQLExprDateEdit,
  dxSkinsCore, dxSkinFoggy, dxSkinBlueprint, CMaestro, dxSkinBlue, dxSkinMoneyTwins, dxSkinscxPCPainter,
  dxSkinsdxBarPainter, uSalidaUtils, dxSkinBlack, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp,
  dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TFImprimirFactura = class(TForm)
    pnlConsulta: TPanel;
    gbCriterios: TcxGroupBox;
    lbEmpresa: TcxLabel;
    lbCliente: TcxLabel;
    lbFecFactura: TcxLabel;
    lbNumFactura: TcxLabel;
    cxGrid: TcxGrid;
    tvFacturas: TcxGridDBTableView;
    lvFacturas: TcxGridLevel;
    dsQFacturas: TDataSource;
    tvEmpresa: TcxGridDBColumn;
    tvFecha: TcxGridDBColumn;
    tvNumero: TcxGridDBColumn;
    tvCodigo: TcxGridDBColumn;
    tvCliente: TcxGridDBColumn;
    tvImporteTotal: TcxGridDBColumn;
    bmxBarManager: TdxBarManager;
    bmxPrincipal: TdxBar;
    dxLocalizar: TdxBarLargeButton;
    tvMarca: TcxGridDBColumn;
    dxSalir: TdxBarLargeButton;
    cxTabControl: TcxTabControl;
    btnSeleccionar: TcxButton;
    btnCancelar: TcxButton;
    tvDesCliente: TcxGridDBColumn;
    tvMoneda: TcxGridDBColumn;
    tvTipoFactura: TcxGridDBColumn;
    tvTipo: TcxGridDBColumn;
    tvImpuesto: TcxGridDBColumn;
    tvDesImpuesto: TcxGridDBColumn;
    tvImporteNeto: TcxGridDBColumn;
    tvImporteImpuesto: TcxGridDBColumn;
    lbImporteNeto: TcxLabel;
    lbImporteTotal: TcxLabel;
    lbCodFactura: TcxLabel;
    ssCliente: TSimpleSearch;
    SENumFactura: TSQLExprIntEdit;
    SECliente: TSQLExprStrEdit;
    SEFecFactura: TSQLExprDateEdit;
    SEImporteNeto: TSQLExprIntEdit;
    SEImporteTotal: TSQLExprIntEdit;
    dxImprimir: TdxBarLargeButton;
    SEEmpresa: TSQLExprStrEdit;
    cxLabel1: TcxLabel;
    cxNumFac: TcxLabel;
    SECodFactura: TSQLExprStrEdit;
    dxBarLargeButton1: TdxBarLargeButton;
    cxLabel2: TcxLabel;
    seSerie: TSQLExprStrEdit;
    tvSerie: TcxGridDBColumn;
    dxLimpiar: TdxBarLargeButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure dxLocalizarClick(Sender: TObject);
    procedure dxSalirClick(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure tvMarcaPropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tvDesClienteGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: String);
    procedure tvTipoFacturaGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: String);
    procedure tvDesImpuestoGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: String);
    procedure dxImprimirClick(Sender: TObject);
    procedure dxBarLargeButton1Click(Sender: TObject);
    procedure dxLimpiarClick(Sender: TObject);
  private
    QFacturas, QCabFactura, QDetFactura, QBasFactura, QGasFactura: TBonnyClientDataSet;

    procedure CreaQFacturas;
    function EjecutaQFacturas: boolean;
    procedure MontarConsulta;
    procedure ActivarConsulta(AValor: boolean);
    procedure VaciarConsulta;
    function ExisteFiltros: boolean;
    procedure RellenaMemFacturas;
    procedure Previsualizar;
    function AsuntoFactura: string;
    procedure CreaQCabFactura;
    function EjecutaQCabFactura( ACodFactura: string ): boolean;
    procedure CreaQDetFactura;
    function EjecutaQDetFactura( ACodFactura: string ): boolean;
    procedure CreaQBasFactura;
    function EjecutaQBasFactura( ACodFactura: string ): boolean;
    procedure CreaQGasFactura;
    function EjecutaQGasFactura( ACodFactura: string ): boolean;
    function  PrevisualizarAlbaran( const AEmpresa, ACentro, AAlbaran, AFecha, ACliente: String; const AIdioma: Integer; const APedirFirma : boolean; GGN : TGGN; AOriginal: boolean ): boolean;
    procedure ObtenerAlbaran( ACodFactura: string );



  public
    { Public declarations }
    sEmpresa, sCentro, sAlbaran, sFecha, sCliente: String;
  end;

var
  FImprimirFactura: TFImprimirFactura;

implementation

{$R *.dfm}
uses UDFactura, CGestionPrincipal, CVariables, Principal, UDMAuxDB, DConfigMail, DPreview, UDMConfig,
  URFactura2, MSalidas, UDQAlbaranSalidaWEB, AlbaranEntreCentrosMercadonaDM,
  UDQAlbaranSalida, UQRAlbaranAlemaniaNoVar;

procedure TFImprimirFactura.CreaQFacturas;
begin
  QFacturas := TBonnyClientDataSet.Create(Self);
  dsQFacturas.DataSet := QFacturas;

  with QFacturas do
  begin
    SQL.Add(' select cod_empresa_fac_fc, cod_serie_fac_fc, cod_cliente_fc, des_cliente_fc, fecha_factura_fc, ');
    SQL.Add('        n_factura_fc, cod_factura_fc, tipo_factura_fc, impuesto_fc, moneda_fc, ');
    SQL.Add('        round(importe_neto_fc, 2) importe_neto_fc, importe_impuesto_fc, round(importe_total_fc, 2) importe_neto_fc');
    SQL.Add('   from tfacturas_cab ');
    SQL.ADd('   where 1=1 ');
  end;
end;

function TFImprimirFactura.EjecutaQFacturas: boolean;
begin
  with QFacturas do
  begin
    if Active then
      Close;

    Open;
    Result := not IsEmpty;
  end;
end;

procedure TFImprimirFactura.CreaQCabFactura;
begin
  QCabFactura := TBonnyClientDataSet.Create(Self);

  with QCabFactura do
  begin
    SQL.Add(' select * from tfacturas_cab ');
    SQL.Add('   where cod_factura_fc in ( :cod_factura ) ');
  end;
end;

function TFImprimirFactura.EjecutaQCabFactura (ACodFactura: string): boolean;
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

procedure TFImprimirFactura.CreaQDetFactura;
begin
  QDetFactura := TBonnyClientDataSet.Create(Self);

  with QDetFactura do
  begin
    SQL.Add(' select * from tfacturas_det ');
    SQL.Add('   where cod_factura_fd in ( :cod_factura ) ');
  end;
end;

function TFImprimirFactura.EjecutaQDetFactura (ACodFactura: string): boolean;
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

procedure TFImprimirFactura.CreaQBasFactura;
begin
  QBasFactura := TBonnyClientDataSet.Create(Self);

  with QBasFactura do
  begin
    SQL.Add(' select * from tfacturas_bas ');
    SQL.Add('   where cod_factura_fb in ( :cod_factura ) ');
  end;
end;

function TFImprimirFactura.EjecutaQBasFactura (ACodFactura: string): boolean;
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

procedure TFImprimirFactura.CreaQGasFactura;
begin
  QGasFactura := TBonnyClientDataSet.Create(Self);
//  dsQFacturas.DataSet := QFacturas;

  with QGasFactura do
  begin
    SQL.Add(' select * from tfacturas_gas ');
    SQL.Add('   where cod_factura_fg in ( :cod_factura ) ');
  end;
end;

function TFImprimirFactura.EjecutaQGasFactura (ACodFactura: string): boolean;
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

procedure TFImprimirFactura.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  CreaQFacturas;
end;

procedure TFImprimirFactura.dxBarLargeButton1Click(Sender: TObject);
var
   iTipoAlbaran, i:Integer;
    sCodFactura: String;
    miGGN: TGGN;
begin

  for i:=0 to tvFacturas.DataController.RecordCount-1 do
  begin
    if tvFacturas.DataController.GetValue(i, tvMarca.Index) = true then
    begin
      sCodFactura := tvFacturas.DataController.GetValue(i, tvCodigo.Index);
      ObtenerAlbaran( sCodFactura );

      iTipoAlbaran:= TipoAlbaran( sEmpresa, sCliente );

      miGGN := ConfigurarGGN('database', sempresa, sCentro, StrtoInt(sAlbaran), StrToDate(sFecha));
      PrevisualizarAlbaran ( sEmpresa, sCentro, sAlbaran, sFecha, sCliente, iTipoAlbaran, False, miGGN, False );
    end;
  end;

    WindowState := wsMaximized;
end;

function TFImprimirFactura.PrevisualizarAlbaran( const AEmpresa, ACentro, AAlbaran, AFecha, ACliente: String; const AIdioma: Integer; const APedirFirma : boolean; GGN : TGGN; AOriginal: boolean ): boolean;
begin
  Result:= False;
  if AIdioma = 0 then
  begin

    if ACliente = 'WEB' then
    begin
       result:= UDQAlbaranSalidaWEB.PreAlbaran( Self, AEmpresa, ACentro, StrToInt( AAlbaran), StrToDateTime( AFecha ), APedirFirma, AOriginal, GGN  );
    end
    else
    if AEmpresa = '506'  then
    begin
       result:= AlbaranEntreCentrosMercadonaDM.PreAlbaran( Self, AEmpresa, ACentro,
                   StrToInt( AAlbaran), StrToDateTime( AFecha ), APedirFirma,  AOriginal, GGN  );
    end
    else
    if ( ACliente = 'GOM' ) or ( ACliente = 'ERO' ) or
       ( ACliente = 'THA' ) or ( ACliente = 'M&W' ) or
       ( ACliente = 'APS' ) or ( ACliente = 'P' ) then
    begin
      result:= UDQAlbaranSalida.PreAlbaran( Self, AEmpresa, ACentro,
                   StrToInt( AAlbaran), StrToDateTime( AFecha ), APedirFirma,  AOriginal, GGN );
    end
    else
    begin
       result:= UDQAlbaranSalida.PreAlbaranSAT( Self, AEmpresa, ACentro,
                   StrToInt( AAlbaran), StrToDateTime( AFecha ), APedirFirma, AOriginal, GGN   );
    end;
  end
  else
  if AIdioma = 1 then
  begin
    result:= UQRAlbaranAlemaniaNoVar.PreAlbaranAleman( AEmpresa, ACentro, ACliente, StrToInt( AAlbaran ),
                               StrToDate( AFecha ), APedirFirma,  AOriginal, GGN );
  end;
end;

procedure TFImprimirFactura.ObtenerAlbaran (ACodFactura: String);
begin
  with DFactura.QAux do
  begin

    SQL.Clear;
    SQL.Add(' select distinct cod_empresa_albaran_fd, cod_centro_albaran_fd, n_albaran_fd, fecha_albaran_fd, cod_cliente_albaran_fd ');
    SQL.Add(' from tfacturas_det                        ');
    SQL.Add(' where cod_factura_fd = :codigofactura     ');

    ParamByName('codigofactura').AsString:= ACodFactura;
    Open;
    if not IsEmpty then
    begin
      sEmpresa := FieldByName('cod_empresa_albaran_fd').AsString;
      sCentro := FieldByName('cod_centro_albaran_fd').AsString;
      sAlbaran := FieldByName('n_albaran_fd').AsString;
      sFecha := FieldByName('fecha_albaran_fd').AsString;
      sCliente := FieldByName('cod_cliente_albaran_fd').AsString;
    end
    else
    begin
      sEmpresa := '';
      sCentro := '';
      sAlbaran := '';
      sFecha := '';
      sCliente := '';
    end;
  end;

end;

procedure TFImprimirFactura.dxImprimirClick(Sender: TObject);
begin
  RellenaMemFacturas;
  Previsualizar;

  WindowState := wsMaximized;
end;

procedure TFImprimirFactura.dxLimpiarClick(Sender: TObject);
begin
  VaciarConsulta;
end;

procedure TFImprimirFactura.dxLocalizarClick(Sender: TObject);
begin
  if not ExisteFiltros then
  begin
    ShowMessage(' ATENCION! No se puede ejecutar una consulta sin filtros.');
    Exit;
  end;
  MontarConsulta;
  if EjecutaQFacturas then
  begin
    ActivarConsulta(False);
    cxGrid.SetFocus;

    cxNumFac.Caption := IntToStr(QFacturas.RecordCount);
  end
  else
  begin
    ShowMessage('No existen datos con el criterio seleccionado.') ;
    ActivarConsulta(True);
//    VaciarConsulta;
    SEEmpresa.SetFocus;
  end;
end;

procedure TFImprimirFactura.MontarConsulta;
begin
  with QFacturas do
  begin
    SQL.Clear;
    SQL.Add(' select cod_empresa_fac_fc, cod_serie_fac_fc, cod_cliente_fc, des_cliente_fc, fecha_factura_fc, ');
    SQL.Add('        n_factura_fc, cod_factura_fc, tipo_factura_fc, impuesto_fc, moneda_fc, ');
    SQL.Add('        round(importe_neto_fc, 2) importe_neto_fc, importe_impuesto_fc, round(importe_total_fc, 2) importe_total_fc');
    SQL.Add('  from tfacturas_cab ');
    SQL.Add('  where 1 = 1 ');


    if SEEmpresa.Text <> '' then
      SQL.Add(Format(' and %s', [ SEEmpresa.SQLExpr ]));
    if SESerie.Text <> '' then
      SQL.Add(Format(' and %s', [ SESerie.SQLExpr ]));
    if SECliente.Text <> '' then
      SQL.Add(Format(' and %s', [ SECliente.SQLExpr ]));
    if SENumFactura.Text <> '' then
      SQL.Add(Format(' and %s', [ SENumFactura.SQLExpr ]));
    if SEFecFactura.Text <> '' then
      SQL.Add(Format(' and %s', [ SEFecFactura.SQLExpr ]));
    if SEImporteNeto.Text <> '' then
      SQL.Add(Format(' and %s', [ SEImporteNeto.SQLExpr ]));
    if SEImporteTotal.Text <> '' then
      SQL.Add(Format(' and %s', [ SEImporteTotal.SQLExpr ]));
    if SECodFactura.Text <> '' then
      SQL.Add(Format(' and %s', [ SECodFactura.SQLExpr ]));

    SQL.Add(' order by cod_empresa_fac_fc, cod_serie_fac_fc, n_factura_fc, fecha_factura_fc ');
  end;
end;


procedure TFImprimirFactura.Previsualizar;
begin

//  OrdenaMemFacturas;

//  DConfigMail.sAsunto:= AsuntoFactura;
//  DConfigMail.sEmpresaConfig:= '050';
//  DConfigMail.sClienteConfig:= 'GL';

  RFactura2 := TRFactura2.Create(Application);
  RFactura2.definitivo := true;
  RFactura2.bProforma := false;

//  RFactura2.Configurar('050', 'GL');
  RFactura2.printOriginal := true;
  RFactura2.printEmpresa := true;

  DPreview.bCanSend := (DMConfig.EsLaFont);
//  if cbOriginal.Checked then
  RFactura2.Tag:= 1 ;
//  else
//  if cbEmpresa.Checked then
//    RFactura.Tag:= 2
//  else
//    RFactura.Tag:= 3;
  Preview(RFactura2, 1, False, True);

end;

procedure TFImprimirFactura.RellenaMemFacturas;
var i, long: integer;
    lista_f: string;
begin
  CreaQCabFactura;
  CreaQDetFactura;
  CreaQBasFactura;
  CreaQGasFactura;

  lista_f := '';
  for i:=0 to tvFacturas.DataController.RecordCount-1 do
  begin
    if tvFacturas.DataController.GetValue(i, tvMarca.Index) = true then
      lista_f := lista_f + QuotedStr(tvFacturas.DataController.GetValue(i, tvCodigo.Index)) + ',';
  end;
  long := length(lista_f);
  lista_f[long] := ' ';

  EjecutaQCabFactura( lista_f );
  EjecutaQDetFactura( lista_f );
  EjecutaQBasFactura( lista_f );
  EjecutaQGasFactura( lista_f );

  DFactura.mtFacturas_Bas2.LoadFromDataSet(QBasFactura, []);
  DFactura.mtFacturas_Bas2.SortOn('cod_factura_fb', []);
  DFactura.mtFacturas_Gas2.LoadFromDataSet(QGasFactura, []);
  DFactura.mtFacturas_Gas2.SortOn('cod_factura_fg;fecha_albaran_fg;n_albaran_fg;cod_tipo_gasto_fg', []);
  DFactura.mtFacturas_Det2.LoadFromDataSet(QDetFactura, []);
  DFactura.mtFacturas_Det2.SortOn('cod_factura_fd;fecha_albaran_fd;pedido_fd;n_albaran_fd;cod_dir_sum_fd;cod_producto_fd;cod_envase_fd', []);
  DFactura.mtFacturas_Cab2.LoadFromDataSet(QCabFactura, []);
  DFactura.mtFacturas_Cab2.SortOn('cod_factura_fc', []);
end;

procedure TFImprimirFactura.dxSalirClick(Sender: TObject);
var sAux: String;
begin
  if cxGrid.Enabled then
  begin
    if dxImprimir.Enabled then
    begin
      sAux := '�Desea salir de la selecci�n?';
      case MessageDlg(sAux, mtInformation, [mbNo,mbYes],0) of
      mryes:
      begin
        ActivarConsulta(True);
//        VaciarConsulta;
        cxNumFac.Caption := '0';
        tvFacturas.DataController.Filter.Root.Clear;
        QFacturas.Close;
        SEEmpresa.SetFocus;
      end;
      mrno:
      begin
        Exit;
      end;
      end;
    end
    else
    begin
      ActivarConsulta(True);
//      VaciarConsulta;
      tvFacturas.DataController.Filter.Root.Clear;
      cxNumFac.Caption := '0';      
      QFacturas.Close;
      SEEmpresa.SetFocus;
    end;
  end
  else
    Close;
end;

procedure TFImprimirFactura.ActivarConsulta(AValor: boolean);
begin
  pnlConsulta.Enabled := AValor;
  dxLocalizar.Enabled := AValor;
  dxLimpiar.Enabled := AValor;
  dxImprimir.Enabled := false;

  cxTabControl.Enabled := not AValor;
  cxGrid.Enabled := not AValor;
  btnSeleccionar.Enabled := not AValor;
  btnCancelar.Enabled := not AValor;
end;

procedure TFImprimirFactura.VaciarConsulta;
begin
  SEEmpresa.Text := '';
  SESerie.Text := '';
  SECliente.Text := '';
  SENumFactura.Text := '';
  SEFecFactura.Text := '';
  SEImporteNeto.Text := '';
  SEImporteTotal.Text := '';
  SECodFactura.Text := '';
end;

procedure TFImprimirFactura.btnSeleccionarClick(Sender: TObject);
var i: Integer;
begin
  tvFacturas.BeginUpdate;
  for i:=0 to tvFacturas.DataController.RecordCount-1 do
    tvFacturas.DataController.SetValue(i,tvMarca.Index, True);
  tvFacturas.EndUpdate;
  dxImprimir.Enabled := True;
end;

function TFImprimirFactura.AsuntoFactura: string;
var sIniFactura, sFinFactura, sIniCliente, sFinCliente: string;
begin
  DFactura.mtFacturas_Cab2.First;
  sIniFactura := DFactura.mtFacturas_Cab2.fieldbyname('n_factura_fc').AsString;
  DFactura.mtFacturas_Cab2.Last;
  sFinFactura := DFactura.mtFacturas_Cab2.fieldbyname('n_factura_fc').AsString;

  sIniCliente := DFactura.mtFacturas_Cab2.fieldbyname('cod_cliente_fc').AsString;
  sFinCliente := DFactura.mtFacturas_Cab2.fieldbyname('cod_cliente_fc').AsString;

  if sIniFactura <> sFinFactura then
  begin
    result:= 'Env�o facturas ' + sIniFactura + '-' + sFinFactura;
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
    result:= 'Env�o factura ' + sIniFactura + ' [' + desCliente( sIniCliente ) + ']';
  end;
end;

procedure TFImprimirFactura.btnCancelarClick(Sender: TObject);
var i: integer;
begin
  tvFacturas.BeginUpdate;
  for i:=0 to tvFacturas.DataController.RecordCount-1 do
    tvFacturas.DataController.SetValue(i,tvMarca.Index, False);
  tvFacturas.EndUpdate;
  dxImprimir.Enabled := False;
end;

procedure TFImprimirFactura.tvMarcaPropertiesChange(Sender: TObject);
var i:Integer;
begin
  dxImprimir.Enabled := false;
  for i:= 0 to tvFacturas.Datacontroller.RecordCount-1 do
    if tvFacturas.DataController.GetValue(i, tvMarca.Index) = True then
    begin
      dxImprimir.Enabled := true;
      exit;
    end;
end;

procedure TFImprimirFactura.FormShow(Sender: TObject);
begin
  ActivarConsulta(True);
  SEFecFactura.Text := DateToStr(now);
  SEEmpresa.SetFocus;
end;

procedure TFImprimirFactura.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  BEMensajes('');
  Action := caFree;
end;

procedure TFImprimirFactura.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F1:
    begin
      dxLocalizarClick(Self);
    end;
    $0D{, $28}: //vk_return,vk_down
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;
{
    $26: //vk_up
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        Exit;
      end;
}
    VK_ESCAPE:
    begin
     dxSalirClick(Self);
    end;
  end;
end;

function TFImprimirFactura.ExisteFiltros: boolean;
begin
  if (SEEmpresa.Text <> '') or (SESerie.Text <> '') or (SECliente.Text <> '') or (SENumFactura.Text <> '') or
     (SEFecFactura.Text <> '') or (SEImporteNeto.Text <> '') or (SEImporteTotal.Text <> '') or
     (SECodFactura.Text <> '') then
      Result := true
  else

      Result := false;
end;

procedure TFImprimirFactura.tvDesClienteGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
var AEmpresa, ACliente: Variant;
begin
  if tvFacturas.GetColumnByFieldName('cod_empresa_fac_fc') <> nil then
    AEmpresa := ARecord.Values[tvFacturas.GetColumnByFieldName('cod_empresa_fac_fc').Index]
  else
    AEmpresa := null;

  if tvFacturas.GetColumnByFieldName('cod_cliente_fc') <> nil then
    ACliente := ARecord.Values[tvFacturas.GetColumnByFieldName('cod_cliente_fc').Index]
  else
    ACliente := null;

  AText := DesCliente(ACliente);
end;

procedure TFImprimirFactura.tvTipoFacturaGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
var ATipo: Variant;
begin
  if tvFacturas.GetColumnByFieldName('tipo_factura_fc') <> nil then
    ATipo := ARecord.Values[tvFacturas.GetColumnByFieldName('tipo_factura_fc').Index]
  else
    ATipo := null;

  if ATipo = '380' then
    AText := 'FACTURA'
  else
    AText := 'ABONO';
end;

procedure TFImprimirFactura.tvDesImpuestoGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
var AImpuesto: Variant;
begin
  if tvFacturas.GetColumnByFieldName('impuesto_fc') <> nil then
    AImpuesto := ARecord.Values[tvFacturas.GetColumnByFieldName('impuesto_fc').Index]
  else
    AImpuesto := null;

  if AImpuesto = 'I'then
    AText := 'IVA'
  else if AImpuesto = 'G' then
    AText := 'IGIC'
  else
    AText := 'EXENTO';
end;

end.
