unit UFFacturarEdi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  CMaestroDetalle, Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, ComCtrls, dxCore, cxDateUtils, Menus, ActnList, StdCtrls,
  cxButtons, SimpleSearch, cxMaskEdit, cxDropDownEdit, cxCalendar, cxLabel,
  cxGroupBox, Gauges, ExtCtrls, cxTextEdit, BonnyQuery, CGestionPrincipal, CVariables,

  dxSkinsCore, dxSkinBlue, dxSkinFoggy, dxSkinMoneyTwins, dxSkinBlueprint,
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

  TRDatosAlbaran  = record
    sNumAlbaran, sFechaAlbaran,
    sDirSuministro, sPedido, sFechaPedido, sFechaDescarga, sPorcentaje: string;
  end;

  TFFacturarEdi = class(TForm)
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
    lb5: TcxLabel;
    txEmpresa: TcxTextEdit;
    txDesEmpresa: TcxTextEdit;
    lb1: TcxLabel;
    deHastaFecha: TcxDateEdit;
    btAceptar: TcxButton;
    btCancelar: TcxButton;
    lb7: TcxLabel;
    lbFacturas: TcxLabel;
    txRuta: TcxTextEdit;
    lb6: TcxLabel;
    btnRuta: TcxButton;
    ActionList: TActionList;
    ACancelar: TAction;
    AAceptar: TAction;
    ssEmpresa: TSimpleSearch;
    ssCliente: TSimpleSearch;
    cxLabel1: TcxLabel;
    txSerie: TcxTextEdit;
    ssSerie: TSimpleSearch;
    procedure btnRutaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PonNombre(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btAceptarClick(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure AAceptarExecute(Sender: TObject);
    procedure txClientePropertiesChange(Sender: TObject);
    procedure ssSerieAntesEjecutar(Sender: TObject);
  private
    sEmpresa, sCliente, sRuta, SVendedor: string;
    iFactIni, iFactFin: Integer;
    dFechaIni, dFechaFin: TDateTime;
    cabeceras, lineas, cabImpuestos, linImpuestos: TStringList;
    QClienteEdi, QFacturasEdi, QAlbaran, QCodInterno,
    QCabEdi, QLinEdi, QCabIva, QLinIva, QCodEdi, QNLinImp :TBonnyQuery;

    RDatosAlbaran: TRDatosAlbaran;

    procedure RellenarDatosIni;
    function Parametros: boolean;
    function ClienteEDI: Boolean;
    procedure CreaQClienteEdi;
    procedure CreaQFacturasEdi;
    procedure CreaQAlbaran;
    procedure CreaQCodInterno;
    procedure CreaQCabEdi;
    procedure CreaQLinEdi;
    procedure CreaQCodEdi;
    procedure CreaQCabIva;
    procedure CreaQLinIva;
    function EjecutaQFacturasEdi: boolean;
    function EjecutaQCabEdi:boolean;
    function EjecutaQLinEdi: boolean;
    function EjecutaQCabIva: boolean;
    function EjecutaQLinIva: boolean;
    function EjecutaQCodEdi: boolean;
    function CrearFicheros(var VMensaje: string):boolean;
    procedure GuardarFichero(ARuta: string);
    procedure LimpiarBuffers;
    procedure CerrarTablas;
    procedure BorrarListas;
    procedure AddCabecera;
    procedure AddLineas;
    procedure AddLinea;
    procedure AddCabecerasImpuestos;
    procedure AddCabeceraImpuestos;
    procedure AddLineasImpuestos;
    procedure AddLineaImpuestos;
    function GetIdTicket: string;
    function Dun14Code: string;
    function Ean13Code: string;
    function GetCantidad: string;
    function GetMedida: string;
    function GetUnidadMedida:string;
    function GetImpDescuentoLin: string;
    function GetStatus: string;
    function GetTipoIva: string;
    function GetDatosAlbaran: TRDatosAlbaran;
    function GetComprador: String;
    function GetReceptor: String;
    function GetPedido: String;
    function GetRSocial: String;
    function GetCalle: String;
    function GetCiudad: String;
    function GetCP: String;
    function GetNIF: string;
    function GetIMPCGS: String;
    function GetTipoDesc: String;
    function GetPorcDesc: String;
    function GetFAlbaran: String;
    function GetFPedido: String;
    function GetFEntrega: String;
    function GetRRSocial: String;
    function GetFPerFac: String;
    function GetInternoProv: String;
    function CodInternoProv: String;
    function DatosCodEdi: boolean;
    function GetTotImporteLinea: String;
    function GetTotImporteDescuento: String;
    function GetTotImporteImpuesto: String;
    function GetTotImporteTotal: String;
    function GetImporteLinea: String;
    function GetImporteLinea2: String;
    function GetCabImporteNeto: String;
    function GetCabImporteImpuesto: String;
    function GetLinImporteNeto: String;
    function GetLinImporteImpuesto: String;
    function GetNLinImp: String;

  public
    { Public declarations }
  end;

var
  FFacturarEdi: TFFacturarEdi;

implementation

{$R *.dfm}
uses UDFactura, Principal, UDMAuxDB, DError, FileCtrl, CGlobal, bTextUtils, UDMBaseDatos, CFactura;

procedure TFFacturarEdi.btnRutaClick(Sender: TObject);
var dir: string;
begin
  dir := txRuta.Text;
  if SelectDirectory(' Selecciona directorio destino.', 'c:\', dir) then
  begin
    if copy(dir, length(dir) - 1, length(dir)) <> '\' then
    begin
      txRuta.Text := dir + '\';
      txRuta.Hint:= txRuta.Text;
    end
    else
    begin
      txRuta.Text := dir;
    end;
  end;
  Application.BringToFront;
end;

procedure TFFacturarEdi.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  if gsDirEdi <> '' then
    txRuta.Text := Lowercase( gsDirEdi + '\');
  txRuta.Hint:= txRuta.Text;

  cabeceras := TStringList.Create;
  lineas := TStringList.Create;
  cabImpuestos := TStringList.Create;
  linImpuestos := TStringList.Create;

  CreaQClienteEdi;
  CreaQFacturasEdi;
  CreaQAlbaran;
  CreaQCodInterno;
  CreaQCabEdi;
  CreaQLinEdi;
  CreaQCodEdi;
  CreaQCabIva;
  CreaQLinIva;
end;

procedure TFFacturarEdi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  CerrarTablas;
  BorrarListas;

  BEMensajes('');
  Action := caFree;

  CloseQuerys([QCabEdi, QLinEdi, QCabIva, QLinIva, QClienteEdi, QFacturasEdi, QAlbaran, QCodInterno, QCodEdi]);
end;

procedure TFFacturarEdi.RellenarDatosIni;
begin
   //Borrar contenido de las tablas
  CerrarTablas;

  RDatosAlbaran.sNumAlbaran := '';
  RDatosAlbaran.sFechaAlbaran := '';
  RDatosAlbaran.sDirSuministro := '';
  RDatosAlbaran.sPedido := '';
  RDatosAlbaran.sFechaPedido := '';
  RDatosAlbaran.sFechaDescarga := '';
  RDatosAlbaran.sPorcentaje := '';

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

procedure TFFacturarEdi.ssSerieAntesEjecutar(Sender: TObject);
begin
    ssSerie.SQLAdi := '';
    ssSerie.SQLAdi := ' anyo_es >= year(today) -1 ';
    if txEmpresa.Text <> '' then
      ssSerie.SQLAdi := ssSerie.SQLAdi + ' and cod_empresa_es = ' +  QuotedStr(txEmpresa.Text);
end;

procedure TFFacturarEdi.txClientePropertiesChange(Sender: TObject);
begin
  txDesCliente.Text := desCliente(txCliente.Text);
end;

procedure TFFacturarEdi.PonNombre(Sender: TObject);
begin
  txSerie.Text := txEmpresa.Text;
  txDesEmpresa.Text := desEmpresa(txEmpresa.Text);
  txDesCliente.Text := desCliente(txCliente.Text);
end;

procedure TFFacturarEdi.FormShow(Sender: TObject);
begin
  RellenarDatosIni;
end;

procedure TFFacturarEdi.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFFacturarEdi.FormKeyDown(Sender: TObject; var Key: Word;
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
  VK_ESCAPE:
    begin
      btCancelarClick(Self);
    end;
  end;
end;

procedure TFFacturarEdi.btAceptarClick(Sender: TObject);
var
  sMsg: string;
begin
  //Esperamos **********************************************
  BEMensajes(' Creando ficheros de texto .....');
  self.Refresh;
  //Esperamos **********************************************
  sMsg := '';

  //Datos del formulario correctos
  if not Parametros then exit;

  if not ClienteEDI then
  begin
    ShowMessage('Este cliente no esta marcado como cliente EDI.');
    txCliente.SetFocus;
    exit;
  end;

  if not EjecutaQFacturasEdi then
  begin
    ShowMessage('No se han conseguido facturas para la generaci?n de los ficheros.');
    txCliente.SetFocus;
    Exit;
  end;

  if not CrearFicheros(sMsg) then
  begin
    MessageDlg( sMsg, mtInformation, [mbOK], 0);
    Exit;
  end;

  MessageDlg( sMsg, mtInformation, [mbOK], 0);
  GuardarFichero(txRuta.Text);

//  RellenarDatosIni;
  BEMensajes('');
end;

function TFFacturarEdi.Parametros: boolean;
begin
  Result := False;

  if txDesEmpresa.Text = '' then
  begin
    txEmpresa.SetFocus;
    ShowError('Falta codigo de la empresa o es incorrecto.');
    exit;
  end;

  if txDesCliente.Text = '' then
  begin
    txCliente.SetFocus;
    ShowError('Falta codigo del cliente o es incorrecto.');
    exit;
  end;

  if not TryStrToInt( Trim( txDesdeFactura.Text ), iFactIni ) then
  begin
    txDesdeFactura.SetFocus;
    ShowError('Falta el n?mero de la factura inicial o es incorrecto.');
    exit;
  end;

  if not TryStrToInt( Trim( txHastaFactura.Text ), iFactFin ) then
  begin
    txHastaFactura.SetFocus;
    ShowError('Falta el n?mero de la factura final o es incorrecto.');
    exit;
  end;

  if iFactIni > iFactFin then
  begin
    txDesdeFactura.SetFocus;
    ShowError('Rango de facturas incorrecto.');
    exit;
  end;

  if  not TryStrToDate( Trim( deDesdeFecha.Text ), dFechaIni ) then
  begin
    deDesdeFecha.SetFocus;
    ShowError('Falta Fecha de Facturacion inicial.');
    exit;
  end;

  if not TryStrToDate( Trim( deHastaFecha.Text ), dFechaFin ) then
  begin
    deHastaFecha.SetFocus;
    ShowError('Falta Fecha de Facturacion final.');
    exit;
  end;

  if dFechaIni > dFechaFin then
  begin
    deDesdeFecha.SetFocus;
    ShowError('Rango de fechas incorrecto.');
    exit;
  end;

  if not DirectoryExists( txRuta.Text ) then
  begin
    txRuta.SetFocus;
    ShowError('La ruta destino no es valida.');
    exit;
  end
  else
  begin
    sEmpresa:= txEmpresa.Text;
    sCliente:= txCliente.Text;
    sRuta:= txRuta.Text;

    sVendedor:= sEmpresa;

    if sVendedor = '' then
      MessageDlg('' + #13 + #10 + 'No se ha podido localizar el c?digo EAN del Vendedor,      ' + #13 + #10 + 'este c?digo es necesario para la facturaci?n EDI.' + #13 + #10 + '' + #13 + #10 + 'Por favor, compruebe que el campo "Codigo EAN13"    ' + #13 + #10 + 'en el mantenimiento de empresas tiene valor. Gracias.', mtWarning, [mbOK], 0)
    else
      Result := True;
  end;

end;

function TFFacturarEdi.ClienteEDI: Boolean;
begin
  with QClienteEDI do
  begin
    if Active then
      Close;

    ParamBYName('cliente').AsString := txCliente.Text;
    Open;
    Result := not IsEmpty;
  end;
end;

procedure TFFacturarEdi.CreaQClienteEdi;
begin
  QClienteEDI := TBonnyQuery.Create(Self);
  with QClienteEDI do
  begin
    SQL.Add(' select nombre_c ');
    SQL.Add(' from frf_clientes ');
    SQL.Add(' where cliente_c = :cliente ');
    SQL.Add(' and edi_c = ''S'' ');

    Prepare;
  end;
end;

function TFFacturarEdi.EjecutaQFacturasEdi: boolean;
begin
  with QFacturasEdi do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := txEmpresa.Text;
    ParamByName('serie').AsString := txSerie.Text;
    ParamByName('cliente').AsString := txCliente.Text;
    ParamByName('desdeFecha').AsDate := deDesdeFecha.Date;
    ParamByName('hastaFecha').AsDate := deHastaFecha.Date;
    ParamByName('desdeFactura').AsString := txDesdeFactura.Text;
    ParamByName('hastaFactura').AsString := txHastaFactura.Text;
    Open;

    Result := not IsEmpty;
  end;
end;

function TFFacturarEdi.EjecutaQCabEdi: boolean;
begin
  with QCabEdi do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QFacturasEdi.FieldByName('cod_factura_fc').AsString;
    Open;

    if (IsEmpty) OR (QCabEdi.FieldByName('vendedor').AsString = '') OR
       (QCabEdi.FieldByName('cliente').AsString = '') OR
       (QCabEdi.FieldByName('comprador').AsString = '') OR
       (QCabEdi.FieldByName('receptor').AsString = '') OR
       (QCabEdi.FieldByName('pagador').AsString = '') then
          Result := false
    else
      Result := true;
  end;
end;

procedure TFFacturarEdi.CreaQFacturasEdi;
begin
  QFacturasEdi := TBonnyQuery.Create(Self);
  with QFacturasEdi do
  begin
    SQL.Add(' select * from tfacturas_cab, frf_clientes ');
    SQL.Add(' where cod_empresa_fac_fc = :empresa ');
    SQL.Add('    and cod_serie_fac_fc = :serie ');
    SQL.Add('    and cod_cliente_fc = :cliente ');
    SQL.Add('    and fecha_factura_fc between :desdeFecha and :hastaFecha ');
    SQL.Add('    and n_factura_fc between :desdeFactura and :hastaFactura ');

    SQL.Add('    and cliente_c = cod_cliente_fc ');
    SQL.Add('    and edi_c = ''S'' ');

    SQL.Add(' order by n_factura_fc, fecha_factura_fc ');
  end;

end;

procedure TFFacturarEdi.CreaQAlbaran;
begin
  QAlbaran := TBonnyQuery.Create(Self);
  with QAlbaran do
  begin
    SQL.Add(' select cod_empresa_albaran_fd, cod_centro_albaran_fd, n_albaran_fd,                                           ');
    SQL.Add('        fecha_albaran_fd, cod_dir_sum_fd, pedido_fd, fecha_pedido_fd,                                          ');
    SQL.Add('        porcentaje_comision_fd, porcentaje_descuento_fd, cod_cliente_fc,                                       ');
    SQl.Add('        fecha_descarga_sc                                                                                      ');
    SQL.Add('  from tfacturas_cab                                                                                           ');
    SQL.Add('  left join tfacturas_det on cod_factura_fd = cod_factura_fc                                                   ');
    SQL.Add('  left join frf_salidas_c on empresa_sc = cod_empresa_albaran_fd and centro_salida_sc = cod_centro_albaran_fd  ');
    SQL.Add('                         and n_albaran_sc = n_albaran_fd and fecha_sc = fecha_albaran_fd                       ');
    SQL.Add(' where cod_factura_fc = :codfactura                                                                            ');
    SQL.Add('   and cod_factura_fd = cod_factura_fc                                                                         ');
    SQL.Add('   and num_linea_fd = 1                                                                                        ');

    Prepare;
  end;
end;

procedure TFFacturarEdi.CreaQCodInterno;
begin
  QCodInterno := TBonnyQuery.Create(Self);
  with QCodInterno do
  begin
    SQL.Add(' select cip_c from frf_clientes ');
    SQL.Add('  where cliente_c = :cliente ');

    Prepare;
  end;
end;

procedure TFFacturarEdi.CreaQCabEdi;
begin
  QCabEdi := TBonnyQuery.Create(Self);
  with QCabEdi do
  begin
    SQL.Add(' select DISTINCT tfacturas_cab.*, codigo_ean_e vendedor, codigo_ean_e cobrador, quienpide_ce comprador, ');
    SQL.Add('        quienrecibe_ce receptor, aquiensefactura_ce cliente, quienpaga_ce pagador, codigo_ce codigo, cod_dir_sum_fd dpto  ');
    SQL.Add('   from tfacturas_cab, tfacturas_det, frf_empresas, frf_clientes, frf_clientes_edi ');
    SQL.Add('  where cod_factura_fc = :codfactura ');

    SQL.Add('    and cod_factura_fd = cod_factura_fc ');

    SQL.Add('    and empresa_e = cod_empresa_fac_fc ');

    SQL.Add('    and cliente_c = cod_cliente_fc ');
    SQL.Add('    and edi_c = ''S'' ');

    SQL.Add('    and empresa_ce = cod_empresa_albaran_fd ');
    SQL.Add('    and cliente_ce = cod_cliente_albaran_fd ');
    SQL.Add('    and dir_sum_ce = cod_dir_sum_fd ');

  end;

end;

function TFFacturarEdi.CrearFicheros(var VMensaje: String): boolean;
var iTotal, iPasados: Integer;
    bFactError : boolean;
begin
  LimpiarBuffers;

  QFacturasEdi.Last;
  QFacturasEdi.First;
  iTotal:= QFacturasEdi.RecordCount;
  Gauge1.maxvalue:= iTotal;
  Lbfacturas.Caption:= 'Total facturas: '+formatfloat(',0',iTotal);
  iPasados:= 0;
  QFacturasEdi.First;
  while not QFacturasEdi.Eof do
  begin
    bFactError := false;

    if EjecutaQCabEdi then
    begin
      EjecutaQLinEdi;
      EjecutaQCabIva;
      EjecutaQLinIva;
      if not DatosCodEdi then
        bFactError := true;

      if not bFactError then
      begin
        AddCabecera;
        AddLineas;
        AddCabecerasImpuestos;
        AddLineasImpuestos;

        Gauge1.progress:=Gauge1.progress+1;
        iPasados:= iPasados + 1;
      end;
    end
    else
      bFactError := true;


    if bFactError then
    begin
      if VMensaje = '' then
        VMensaje:=  QFacturasEdi.FieldByName('cod_empresa_fac_fc').AsString +  ' ' +
                    QFacturasEdi.FieldByName('cod_serie_fac_fc').AsString +  ' ' +
                    QFacturasEdi.FieldByName('fecha_factura_fc').AsString +  ' ' +
                    QFacturasEdi.FieldByName('n_factura_fc').AsString
      else
        VMensaje:=  VMensaje + #13 + #10 +
                    QFacturasEdi.FieldByName('cod_empresa_fac_fc').AsString +  ' ' +
                    QFacturasEdi.FieldByName('cod_serie_fac_fc').AsString +  ' ' +
                    QFacturasEdi.FieldByName('fecha_factura_fc').AsString +  ' ' +
                    QFacturasEdi.FieldByName('n_factura_fc').AsString;
    end;

    QFacturasEdi.Next;
  end;

  if iPasados < iTotal then
  begin
    VMensaje:= 'Pasadas ' + IntToStr( iPasados ) + ' de ' +   IntToStr( iTotal ) + ' facturas.'  + #13 + #10 +
               'FALTAN: ' + #13 + #10 + VMensaje;

  end
  else
  begin
    VMensaje:= 'Pasadas ' + IntToStr( iPasados ) + ' facturas.'  + #13 + #10 +
               'PROCESO FINALIZADO CORRECTAMENTE.';
  end;
  result:= iPasados > 0;

end;

procedure TFFacturarEdi.LimpiarBuffers;
begin
  cabeceras.Clear;
  lineas.Clear;
  cabImpuestos.Clear;
  linImpuestos.Clear;
end;


procedure TFFacturarEdi.CerrarTablas;
begin
  CloseQuerys([QLinEdi, QLinIva, QCabIva, QCabEdi, QFacturasEdi]);
end;

procedure TFFacturarEdi.AddCabecera;
begin
  RDatosAlbaran := GetDatosAlbaran;
  cabeceras.Add(
      QCabEdi.FieldByName('cod_factura_fc').AsString + '|' +
      QCabEdi.FieldByName('vendedor').AsString + '|' +
      QCabEdi.FieldByName('cobrador').AsString + '|' +
      GetComprador +
      GetReceptor +
//      QCabEdi.FieldByName('codigo').AsString + '|' +                //MOD
      QCabEdi.FieldByName('cliente').AsString + '|' +
      QCabEdi.FieldByName('pagador').AsString + '|' +

      GetPedido +

      QCabEdi.FieldByName('fecha_factura_fc').AsString + '|' +
      QCabEdi.FieldByName('tipo_factura_fc').AsString + '|' +
      '|' +                                                   //funcion_fec
      GetRSocial +
      GetCalle +
      GetCiudad +
      GetCP +
      GetNif +
      '|' +                                                   //razon_fec
      GetIdTicket +
      RDatosAlbaran.sNumAlbaran + '|' +
      GetTotImporteLinea + '|' +
      '|' +                                                   //tipo_cargos_fec
      '0' + '|' +                                             //porc_cargos_fec
      GetIMPCGS +                                             //cargos_fec  SUM(tfacturas_gas.importe_neto_fg)
      GetTipoDesc +
      GetPorcDesc +
      GetTotImporteDescuento + '|' +
      GetTotImporteImpuesto + '|' +
      GetTotImporteTotal + '|' +
      '|' +                                                   //forma_pago_fec
      QCabEdi.FieldByName('moneda_fc').AsString + '|' +
      QCabEdi.FieldByName('prevision_cobro_fc').AsString + '|' +
      GetTotImporteTotal + '|' +
      '|' +                                                   //vencimiento2_fec
      '|' +                                                   //importe_vto2_fec
      '|' +                                                   //vencimiento3_fec
      '|' +                                                   //importe_vto3_fec
      '|' +                                                   //status_fec
      GetFAlbaran +
      GetFPedido +
      GetFEntrega +
      GetRRSocial +
      '|' +                                                   //dummy
      GetFPerFac +
      GetInternoProv
    );
end;

function TFFacturarEdi.GetIdTicket: string;
begin
//  if QCabEdi.FieldByName('cod_cliente_fc').AsString = 'TS' then
//    result:= QCabEdi.FieldByName('cod_factura_fc').AsString + '|'
//  else
    result:= '|';
end;

procedure TFFacturarEdi.GuardarFichero(ARuta: string);
begin
  //Guardar ficheros
  cabeceras.savetofile(ARuta + 'cabfac.txt');
  lineas.savetofile(ARuta + 'linfac.txt');
  linImpuestos.savetofile(ARuta + 'implfac.txt');
  cabImpuestos.savetofile(ARuta + 'impfac.txt');
end;

procedure TFFacturarEdi.CreaQLinEdi;
begin
  QLinEdi := TBonnyQuery.Create(Self);
  with QLinEdi do
  begin
    SQL.Add(' select tfacturas_det.*, fecha_factura_fc fecha_factura ');
    SQL.Add('   from tfacturas_cab, tfacturas_det');
    SQL.Add('  where cod_factura_fc = :codfactura ');

    SQL.Add(' and cod_factura_fd = cod_factura_fc ');

    SQL.Add(' order by num_linea_fd ');
  end;
end;

function TFFacturarEdi.EjecutaQLinEdi: boolean;
begin
  with QLinEdi do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QFacturasEdi.fieldbyname('cod_factura_fc').AsString;
    Open;

    Result := not IsEmpty;
  end;
end;

procedure TFFacturarEdi.AddLineas;
begin
  QLinEdi.First;
  while not QLinEdi.eof do
  begin
    EjecutaQCodEdi;

    AddLinea;
    QLinEdi.Next;
  end;
end;

procedure TFFacturarEdi.AddLinea;
begin
  lineas.Add(
        QLinEdi.FieldByName('cod_factura_fd').AsString + '|' +
        QLinEdi.FieldByName('fecha_factura').AsString + '|' +
        QLinEdi.FieldByName('num_linea_fd').AsString + '|' +
        Ean13Code +
        Copy(QCodEdi.FieldByName('descripcion_ce').AsString, 1, 34) + '|' +
        '|' +                                                     //var_prom_fel
        Dun14Code +
        GetCantidad +                                              //cantidad_fel
        GetMedida +                                               //medidal_fel
        GetUnidadMedida +                                         //unidad_medid_fel
        QLinEdi.FieldByName('precio_fd').AsString + '|' +
        QLinEdi.FieldByName('precio_fd').AsString + '|' +
        '|' +                                                     //tipo_cargo_fel
        '0' + '|' +                                               //porc_cargo_fel
        '0' + '|' +                                               //cargos_fel
        '|' +                                                     //tipo_desc_fel
        '0' + '|' +                                               //porc_descuen_fel
        GetImpDescuentoLin +
        GetImporteLinea + '|' +
        GetStatus +                                               //status_fel
        GetImporteLinea2                                          //BRUTO linea
      );
end;

function TFFacturarEdi.Dun14Code: string;
begin
  if QCabEdi.FieldByName('cod_cliente_fc').AsString = 'AMA' then
    result := '|'
  else
  begin
    if CGlobal.gProgramVersion = CGlobal.pvSAT then
    begin
      if (QCodEdi.FieldByName('dun14_ce').AsString) <> '' then
        result := QCodEdi.FieldByName('dun14_ce').AsString + '|'
      else
        result := '0' + QCodEdi.FieldByName('ref_cliente_ce').AsString + '|';
    end
    else
      result := QCodEdi.FieldByName('dun14_ce').AsString + '|';
  end;
end;

function TFFacturarEdi.Ean13Code: string;
begin
  if QCabEdi.FieldByName('cod_cliente_fc').AsString = 'AMA' then
  begin
    if (QCodEdi.FieldByName('dun14_ce').AsString) <> '' then
      result := QCodEdi.FieldByName('dun14_ce').AsString + '|'
    else
    begin
      if CGlobal.gProgramVersion = CGlobal.pvSAT then
        result := '0' + QCodEdi.FieldByName('ref_cliente_ce').AsString + '|'
      else
        result := QCodEdi.FieldByName('ref_cliente_ce').AsString + '|';
    end;
  end
  else if QCabEdi.FieldByName('cod_cliente_fc').AsString = 'LID' then
  begin
    if (QCodEdi.FieldByName('dun14_ce').AsString) <> '' then
      result := QCodEdi.FieldByName('dun14_ce').AsString + '|'
    else
      result := QCodEdi.FieldByName('ref_cliente_ce').AsString + '|';
  end
  else
    result := QCodEdi.FieldByName('ref_cliente_ce').AsString + '|';
end;

function TFFacturarEdi.GetMedida: string;
begin
{
  if QCabEdi.FieldByName('cod_cliente_fc').AsString = 'TS' then
  begin
    if (QLinEdi.FieldByName('unidad_facturacion_fd').AsString = 'UND') OR       //PCE
       (QLinEdi.FieldByName('unidad_facturacion_fd').AsString = 'CAJ') then
        result := '|'
    else
    begin
      if QCabEdi.FieldByName('tipo_factura_fc').AsString = '381' then
        result := FloatToStr(QLinEdi.FieldByName('cajas_fd').AsFloat * (-1)) + '|'
      else
        result := QLinEdi.FieldByName('cajas_fd').AsString + '|';
    end;
  end
  else
  begin
}
    if QCabEdi.FieldByName('tipo_factura_fc').AsString = '381' then
    begin
      if QLinEdi.FieldByName('unidad_facturacion_fd').AsString = 'KGS' then
        result := FloatToStr(QLinEdi.FieldByName('kilos_fd').AsFloat * (-1)) + '|'
      else if QLinEdi.FieldByName('unidad_facturacion_fd').AsString = 'UND' then
       result := FloatToStr(QLinEdi.FieldByName('unidades_fd').AsFloat * (-1)) + '|'
      else if QLinEdi.FieldByName('unidad_facturacion_fd').AsString = 'CAJ' then
        result := FloatToStr(QLinEdi.FieldByName('cajas_fd').AsFloat * (-1)) + '|';
    end
    else
    begin
      if QLinEdi.FieldByName('unidad_facturacion_fd').AsString = 'KGS' then
        result := QLinEdi.FieldByName('kilos_fd').AsString + '|'
      else if QLinEdi.FieldByName('unidad_facturacion_fd').AsString = 'UND' then
       result := QLinEdi.FieldByName('unidades_fd').AsString + '|'
      else if QLinEdi.FieldByName('unidad_facturacion_fd').AsString = 'CAJ' then
        result := QLinEdi.FieldByName('cajas_fd').AsString + '|';
    end;
//  end;
end;

function TFFacturarEdi.GetCantidad: string;
begin
  if (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'TS') or
     (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'LID') or   //Clientes Grupo LIDL
     (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'LFI') or
     (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'LDK') or
     (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'LSE') or
     (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'LPL') or
     (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'POR') or  //
     (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'PRX')  then
  begin
    if QCabEdi.FieldByName('tipo_factura_fc').AsString = '381' then
    begin
      if QLinEdi.FieldByName('unidad_facturacion_fd').AsString = 'KGS' then
        result := FloatToStr(QLinEdi.FieldByName('kilos_fd').AsFloat * (-1)) + '|'
      else if QLinEdi.FieldByName('unidad_facturacion_fd').AsString = 'UND' then
       result := FloatToStr(QLinEdi.FieldByName('unidades_fd').AsFloat * (-1)) + '|'
      else if QLinEdi.FieldByName('unidad_facturacion_fd').AsString = 'CAJ' then
        result := FloatToStr(QLinEdi.FieldByName('cajas_fd').AsFloat * (-1)) + '|';
    end
    else
    begin
      if QLinEdi.FieldByName('unidad_facturacion_fd').AsString = 'KGS' then
        result := QLinEdi.FieldByName('kilos_fd').AsString + '|'
      else if QLinEdi.FieldByName('unidad_facturacion_fd').AsString = 'UND' then
       result := QLinEdi.FieldByName('unidades_fd').AsString + '|'
      else if QLinEdi.FieldByName('unidad_facturacion_fd').AsString = 'CAJ' then
        result := QLinEdi.FieldByName('cajas_fd').AsString + '|';
    end;
  end
  else
    result := '0' + '|';
end;

function TFFacturarEdi.GetUnidadMedida: string;
begin
  if QCabEdi.Fieldbyname('cod_cliente_fc').AsString = 'JS' then               //Sainsbury
    result := QLinEdi.FieldByName('unidades_caja_fd').AsString + '|'
  else
  begin
    if QLinEdi.FieldByName('unidad_facturacion_fd').AsString = 'KGS' then
      result := 'KGM' + '|'
    else
      result := 'PCE' + '|';
  end;
end;

function TFFacturarEdi.GetImpDescuentoLin: string;
begin
  result := '0' + '|';
end;

procedure TFFacturarEdi.AddCabecerasImpuestos;
begin
  QCabIva.First;
  while not QCabIva.eof do
  begin
    AddCabeceraImpuestos;
    QCabIva.Next;
  end;
end;

procedure TFFacturarEdi.CreaQCabIva;
begin
  QCabIva := TBonnyQuery.Create(Self);
  with QCabIva do
  begin
    SQL.Add(' select codigo_ean_e, cod_factura_fc, cod_empresa_fac_fc, n_factura_fc, fecha_factura_fc, ');
    SQL.Add('        impuesto_fc, porcentaje_impuesto_fb, tipo_impuesto_fc, ');
    SQL.Add('        importe_impuesto_fb, importe_neto_fb');
    SQL.Add(' from frf_empresas, tfacturas_cab, tfacturas_bas ');
    SQL.Add(' where cod_factura_fc = :codfactura ');

    SQL.Add('   and cod_factura_fb = cod_factura_fc ');

    SQL.Add('   and empresa_e = cod_empresa_fac_fc ');
    SQL.Add(' order by n_factura_fc, fecha_factura_fc, porcentaje_impuesto_fb ');
  end;
end;

procedure TFFacturarEdi.CreaQLinIva;
begin
  QLinIva := TBonnyQuery.Create(Self);
  with QLinIva do
  begin
    SQL.Add(' select codigo_ean_e, cod_factura_fc, cod_empresa_fac_fc, n_factura_fc, fecha_factura_fc, ');
    SQL.Add('        impuesto_fc, porcentaje_impuesto_fd, ');
    SQL.Add('        importe_impuesto_fd, importe_neto_fd, num_linea_fd ');
    SQL.Add(' from frf_empresas, tfacturas_cab, tfacturas_det ');
    SQL.Add(' where cod_factura_fc = :codfactura ');

    SQL.Add('   and cod_factura_fd = cod_factura_fc ');

    SQL.Add('   and empresa_e = cod_empresa_fac_fc ');
    SQL.Add(' order by n_factura_fc, fecha_factura_fc, num_linea_fd ');
  end;
end;

function TFFacturarEdi.EjecutaQCabIva: boolean;
begin
  with QCabIva do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QFacturasEdi.fieldbyname('cod_factura_fc').AsString;
    Open;

    Result := not IsEmpty;
  end;
end;

function TFFacturarEdi.EjecutaQLinIva: boolean;
begin
  with QLinIva do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QFacturasEdi.fieldbyname('cod_factura_fc').AsString;
    Open;

    Result := not IsEmpty;
  end;
end;

procedure TFFacturarEdi.AddCabeceraImpuestos;
begin
  cabImpuestos.Add(
    QCabIva.FieldByName('cod_factura_fc').AsString + '|' +
    QCabIVa.FieldByName('fecha_factura_fc').AsString + '|' +
    GetTipoIva +
    GetCabImporteNeto + '|' +
    QCabIva.FieldByName('porcentaje_impuesto_fb').AsString + '|' +
    GetCabImporteImpuesto + '|' +
    GetNLinImp + '|'                                                                //N? Lineas
  );
end;

function TFFacturarEdi.GetTipoIva: string;
begin
  if QCabEdi.FieldByName('cod_cliente_fc').AsString = 'JS' then   //Sainsbury
  begin
    if QCabIva.FieldByName('porcentaje_impuesto_fb').AsFloat = 0 then
      result := 'E' + '|'
    else if QCabIva.FieldByName('impuesto_fc').AsString = 'I' then
      result := 'VAT' + '|'
    else if QCabIva.FieldByName('impuesto_fc').AsString = 'G' then
      result := 'IGI' + '|'
    else
      result := 'ERROR';
  end
  else if QCabEdi.FieldByName('cod_cliente_fc').AsString = 'MER' then   //MERCADONA
  begin
    if QCabIva.FieldByName('impuesto_fc').AsString = 'I' then
    begin
      if QCabIva.FieldByName('tipo_impuesto_fc').AsString = 'IE' then
        result := 'EXT' + '|'
      else
        result := 'VAT' + '|';
    end
    else if QCabIva.FieldByName('impuesto_fc').AsString = 'G' then
      result := 'IGI' + '|'
    else
      result := 'ERROR';
  end
  else
  begin
    if QCabIva.FieldByName('impuesto_fc').AsString = 'I' then
      result := 'VAT' + '|'
    else if QCabIva.FieldByName('impuesto_fc').AsString = 'G' then
      result := 'IGI' + '|'
    else
      result := 'ERROR';
  end;
end;

procedure TFFacturarEdi.AddLineaImpuestos;
begin
  linImpuestos.Add(
    QLinIva.FieldByName('cod_factura_fc').AsString + '|' +
    QLinIva.FieldByName('fecha_factura_fc').AsString + '|' +
    QLinIva.FieldByName('num_linea_fd').AsString + '|' +
    GetTipoIva +
    GetLinImporteNeto + '|' +
    QLinIva.FieldByName('porcentaje_impuesto_fd').AsString + '|' +
    GetLinImporteImpuesto + '|' +
    '|'                                                              //status_iec
  );
end;

procedure TFFacturarEdi.AddLineasImpuestos;
begin
  QLinIva.First;
  while not QLinIva.eof do
  begin
    AddLineaImpuestos;
    QLinIva.Next;
  end;
end;

function TFFacturarEdi.GetDatosAlbaran: TRDatosAlbaran;
begin
  with QAlbaran do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QCabEdi.FieldByName('cod_factura_fc').AsString;
    Open;
    //* Numero Albaran *//
    if ( Copy( FieldByName('cod_empresa_albaran_fd').AsString, 1, 1) = 'F' ) and
       ( FieldByName('cod_cliente_fc').AsString <> 'ECI' ) then
    begin
      Result.sNumAlbaran :=
        FieldByName('cod_empresa_albaran_fd').AsString +
        FieldByName('cod_centro_albaran_fd').AsString +
        Rellena( FieldByName('n_albaran_fd').AsString , 5, '0', taLeftJustify ) +
        Coletilla( FieldByName('cod_empresa_albaran_fd').AsString );
    end
    else
    begin
      Result.sNumAlbaran := FieldByName('n_albaran_fd').AsString;
    end;
    Result.sFechaAlbaran := FieldByName('fecha_albaran_fd').AsString;
    Result.sDirSuministro := FieldByName('cod_dir_sum_fd').AsString;
    Result.sPedido := FieldByName('pedido_fd').AsString;
    Result.sFechaPedido := FieldByName('fecha_pedido_fd').AsString;
    Result.sFechaDescarga := FieldByName('fecha_descarga_sc').AsString;
    Result.sPorcentaje := FloatToStr(FieldByName('porcentaje_comision_fd').AsFloat +
                                     FieldByName('porcentaje_descuento_fd').AsFloat);
  end;
end;

function TFFacturarEdi.GetComprador: String;
begin
  if QCabEdi.FieldByName('cod_cliente_fc').AsString = 'ECI' then
    result := QCabEdi.FieldByName('receptor').AsString + '|'
  else
    result := QCabEdi.FieldByName('comprador').AsString + '|';
end;

function TFFacturarEdi.GetReceptor: string;
begin
  if QCabEdi.FieldByName('cod_cliente_fc').AsString = 'JS' then
    result := QCabEdi.FieldByName('codigo').AsString + '|'                 //MOD
  else
    result := QCabEdi.FieldByName('receptor').AsString + '|';

end;
function TFFacturarEdi.GetPedido: String;
begin
//  if (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'CMP') OR
  if (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'ZE') then
  begin
    result := '188' + RDatosAlbaran.sPedido + '000' + '|';
  end
  else
    result := RDatosAlbaran.sPedido + '|';
end;

function TFFacturarEdi.GetRSocial: String;
begin
  if QCabEdi.FieldByName('cod_cliente_fc').AsString = 'DIA' then
    result := 'DIA S.A.' + '|'
  else
    result := QCabEdi.FieldByName('des_cliente_fc').AsString + '|';
end;

function TFFacturarEdi.GetCalle: String;
begin
  if QCabEdi.FieldByName('cod_cliente_fc').AsString = 'DIA' then
    result := 'C/ Jacinto Benavente, 2 A Parque Empresarial Las Rozas' + '|'
  else
    result := Copy(QCabEdi.FieldByName('domicilio_fc').AsString, 1, 35) + '|';
end;

function TFFacturarEdi.GetCiudad: String;
begin
  if QCabEdi.FieldByName('cod_cliente_fc').AsString = 'DIA' then
    result := 'MADRID' + '|'
  else
    result := QCabEdi.FieldByName('poblacion_fc').AsString + '|';
end;


function TFFacturarEdi.GetCP: String;
begin
  if QCabEdi.FieldByName('cod_cliente_fc').AsString = 'DIA' then
    result := '28232' + '|'
  else
    result := Trim(Copy(QCabEdi.FieldByName('cod_postal_fc').AsString, 1, 6)) + '|';
end;

function TFFacturarEdi.GetNIF: string;
begin
  if QCabEdi.FieldByName('cod_cliente_fc').AsString = 'DIA' then
    result := 'A28164754' + '|'
  else if QCabEdi.FieldByName('cod_cliente_fc').AsString = 'LID' then
    result := 'ES' + QCabEdi.FieldByName('nif_fc').AsString + '|'
  else
    result := QCabEdi.FieldByName('nif_fc').AsString + '|';
end;

function TFFacturarEdi.GetIMPCGS: String;
begin
  result := '0' + '|';
end;

function TFFacturarEdi.GetTipoDesc: String;
begin
  if QCabEdi.FieldByName('importe_descuento_fc').AsFloat <> 0 then
    Result := 'TD' + '|'
  else
    Result := '|';
end;

function TFFacturarEdi.GetPorcDesc: String;
begin
  if (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'AMA') OR
     (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'SUM') OR
     (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'ERO') OR
     (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'MER') OR
     (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'LID') then
      result := '0' + '|'
  else
    result := RDatosAlbaran.sPorcentaje + '|';
end;

function TFFacturarEdi.GetFAlbaran: String;
begin
{
  if (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'LID') OR
     (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'TS') or
     (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'JS') then   //MOD
}
      result := RDatosAlbaran.sFechaAlbaran + '|'

//  else
//    result := '|';
end;

function TFFacturarEdi.GetFPedido: String;
begin
//  if (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'TS') then
//      result := RDatosAlbaran.sFechaAlbaran + '|'
//  else if (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'JS') then          //Sainsbury
//      result := RDatosAlbaran.sFechaPedido + '|'
//  else
    result := RDatosAlbaran.sFechaPedido + '|';
end;

function TFFacturarEdi.GetFEntrega: String;
begin
{
  if (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'LID') then
    result := DateToStr(StrToDate(RDatosAlbaran.sFechaAlbaran) + 1) + '|'
  else if (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'TS') then
    result := RDatosAlbaran.sFechaAlbaran + '|'
  else
    result := '|'
  }
  result := RDatosAlbaran.sFechaDescarga + '|'
end;

function TFFacturarEdi.GetRRSocial: String;
begin
  if (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'TS') then
    result := desSuministro( QCabEdi.FieldByName('cod_empresa_fac_fc').AsString,
                             QCabEdi.FieldByName('cod_cliente_fc').AsString,
                             RDatosAlbaran.sDirSuministro )+ '|'
  else
    result := '|';
end;

function TFFacturarEdi.GetFPerFac: String;
begin
  if (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'ZE') then
     result := CodInternoProv + '|'
  else
  if (QCabEdi.FieldByName('cod_cliente_fc').AsString = 'CMP') then
  begin
    if QCabEdi.FieldByName('cod_empresa_fac_fc').AsString = '050' then
      result := '188/53656' + '|'
    else
      result := CodInternoProv + '|'
  end
  else if QCabEdi.FieldByName('cod_cliente_fc').AsString = 'ECI' then
    result := '186' + '|'
  else if QCabEdi.FieldByName('cod_cliente_fc').AsString = 'JS' then
    result := QCabEdi.FieldByName('dpto').AsString  + '|'
  else
    result := '|';
end;

function TFFacturarEdi.GetInternoProv: String;
begin
  if QCabEdi.FieldByName('cod_cliente_fc').AsString = 'JS' then
    result := 'S0623' + '|'
  else
    result := '|';
end;

function TFFacturarEdi.CodInternoProv: String;
begin
  with QCodInterno do
  begin
    if Active then
      Close;

    ParamByName('cliente').AsString := QCabEdi.FieldByName('cod_cliente_fc').AsString;
    Open;
    Result := FieldByname('cip_c').AsString;

  end;
end;

procedure TFFacturarEdi.CreaQCodEdi;
begin

  QCodEdi := TBonnyQuery.Create(Self);
  with QCodEdi do
  begin
    SQL.Add(' select ref_cliente_ce, dun14_ce, descripcion_ce ');
    SQL.Add('   from frf_clientes_env');

    SQL.Add(' where empresa_ce = :empresa    ');
    SQL.Add('   and cliente_ce = :cliente    ');
    SQL.Add('   and envase_ce = :envase      ');
    SQL.Add('   and producto_ce =  :producto ');

//    SQL.Add(' select ean13_ee, dun14_ee, descripcion_ee ');
//    SQL.Add('   from frf_ean13_edi');
//    SQL.Add(' where empresa_ee = :empresa ');
//    SQL.Add('   and cliente_fac_ee = :cliente ');
//    SQL.Add('   and envase_ee = :envase ');
//    SQL.Add(' and (producto_ee =  :producto or ');
//    SQL.Add('      producto_ee IS NULL) ');
//    SQL.Add(' and fecha_baja_ee is null ');
  end;
end;

function TFFacturarEdi.EjecutaQCodEdi: boolean;
begin
  with QCodEdi do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := QLinEdi.fieldbyname('cod_empresa_albaran_fd').AsString;
    ParamByName('cliente').AsString := QCabEdi.fieldbyname('cod_cliente_fc').AsString;
    ParamByName('envase').AsString := QLinEdi.fieldbyname('cod_envase_fd').AsString;
    ParamByName('producto').AsString := QLinEdi.fieldbyname('cod_producto_fd').AsString;

    Open;

    Result := not (IsEmpty) and (FieldByName('ref_cliente_ce').AsString <> '')

  end;
end;


function TFFacturarEdi.DatosCodEdi: boolean;
begin

  result := true;
  while not QLinEdi.Eof do
  begin
    if not EjecutaQCodEdi then
    begin
      Result := False;
      Exit;
    end;

    QLinEdi.Next;

  end;
end;

function TFFacturarEdi.GetTotImporteLinea: String;
begin
  if (QCabEdi.FieldByName('tipo_factura_fc').AsString = '381')  then
    result := FloatToStr(QCabEdi.FieldByName('importe_linea_fc').AsFloat * (-1))
  else
    result := QCabEdi.Fieldbyname('importe_linea_fc').AsString;
end;

function TFFacturarEdi.GetTotImporteDescuento: String;
begin
  if (QCabEdi.FieldByName('tipo_factura_fc').AsString = '381')  then
    result := FloatToStr(QCabEdi.FieldByName('importe_descuento_fc').AsFloat * (-1))
  else
    result := QCabEdi.FieldByName('importe_descuento_fc').AsString;
end;

function TFFacturarEdi.GetTotImporteImpuesto: String;
begin
  if (QCabEdi.FieldByName('tipo_factura_fc').AsString = '381')  then
    result := FloatToStr(QCabEdi.FieldByName('importe_impuesto_fc').AsFloat * (-1))
  else
    result := QCabEdi.FieldByName('importe_impuesto_fc').AsString;
end;

function TFFacturarEdi.GetTotImporteTotal: String;
begin
  if (QCabEdi.FieldByName('tipo_factura_fc').AsString = '381')  then
    result := FloatToStr(QCabEdi.FieldByName('importe_total_fc').AsFloat * (-1))
  else
    result := QCabEdi.FieldByName('importe_total_fc').AsString;
end;

function TFFacturarEdi.GetImporteLinea: String;
begin

  if (QCabEdi.FieldByName('tipo_factura_fc').AsString = '381')  then
    result := FloatToStr(QLinEdi.FieldByName('importe_linea_fd').AsFloat * (-1))
  else
    result := QLinEdi.FieldByName('importe_linea_fd').AsString;
end;

function TFFacturarEdi.GetImporteLinea2: String;
begin
  if QCabEdi.FieldByName('cliente').AsString = 'SOK' then
    result := QLinEdi.FieldByName('importe_linea_fd').AsString
  else
    result := '';

end;

function TFFacturarEdi.GetCabImporteNeto: String;
begin
  if (QCabEdi.FieldByName('tipo_factura_fc').AsString = '381')  then
    result := FloatToStr(QCabIva.FieldByName('importe_neto_fb').AsFloat * (-1))
  else
    result := QCabIva.FieldByName('importe_neto_fb').AsString;
end;

function TFFacturarEdi.GetCabImporteImpuesto: String;
begin
  if (QCabEdi.FieldByName('tipo_factura_fc').AsString = '381')  then
    result := FloatToStr(QCabIva.FieldByName('importe_impuesto_fb').AsFloat * (-1))
  else
    result := QCabIva.FieldByName('importe_impuesto_fb').AsString;
end;

function TFFacturarEdi.GetNLinImp: String;
begin
  QNLinImp := TBonnyQuery.Create(Self);
  with QNLinImp do
  try
    SQL.Add(' select count(*) cantidad from tfacturas_det ');
    SQL.Add(' where cod_factura_fd = :codfactura ');
    SQL.Add('   and porcentaje_impuesto_fd = :porcentaje ');

    ParamByName('codfactura').AsString := QCabEdi.FieldByName('cod_factura_fc').AsString;
    ParamByName('porcentaje').AsFloat := QCabIva.FieldByName('porcentaje_impuesto_fb').Asfloat;
    Open;

    Result := Fieldbyname('cantidad').AsString;
  finally
    Free;
  end;
end;

function TFFacturarEdi.GetLinImporteNeto: String;
begin
  if (QCabEdi.FieldByName('tipo_factura_fc').AsString = '381')  then
    result := FloatToStr(QLinIva.FieldByName('importe_neto_fd').AsFloat * (-1))
  else
    result := QLinIva.FieldByName('importe_neto_fd').AsString;
end;

function TFFacturarEdi.GetLinImporteImpuesto: String;
begin
  if (QCabEdi.FieldByName('tipo_factura_fc').AsString = '381')  then
    result := FloatToStr(QLinIva.FieldByName('importe_impuesto_fd').AsFloat * (-1))
  else
    result := QLinIva.FieldByName('importe_impuesto_fd').AsString;
end;

function TFFacturarEdi.GetStatus: string;
begin
  if QCabEdi.FieldByName('cod_cliente_fc').AsString = 'TS' then
  begin
    if (QLinEdi.FieldByName('unidad_facturacion_fd').AsString = 'UND') OR       //PCE
       (QLinEdi.FieldByName('unidad_facturacion_fd').AsString = 'CAJ') then
    begin
      result := 'TU|' +
                QLinEdi.FieldByName('importe_neto_fd').AsString + '|' +
                QLinEdi.FieldByName('unidades_caja_fd').AsString + '|' +
                GetUnidadMedida +'|';
    end
    else
    begin
      result := 'VQ|' +
                QLinEdi.FieldByName('importe_neto_fd').AsString + '|' +
                QLinEdi.FieldByName('unidades_caja_fd').AsString + '|' +
                GetUnidadMedida + '|';
    end;
  end
  else
    result := '|';
end;

procedure TFFacturarEdi.BorrarListas;
begin
  FreeAndNil(cabeceras);
  FreeAndNil(lineas);
  FreeAndNil(cabImpuestos);
  FreeAndNil(linImpuestos);
end;

procedure TFFacturarEdi.ACancelarExecute(Sender: TObject);
begin
  btCancelar.Click;
end;

procedure TFFacturarEdi.AAceptarExecute(Sender: TObject);
begin
  btAceptar.Click;
end;

end.
