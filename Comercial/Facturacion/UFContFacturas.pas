unit UFContFacturas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  CMaestroDetalle, Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, dxCore,
  cxDateUtils, Menus, ActnList, cxCheckBox, cxEdit, ComCtrls,
  StdCtrls, cxButtons, SimpleSearch, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxLabel, cxGroupBox, Gauges, ExtCtrls, cxTextEdit,

  dxSkinsCore, dxSkinBlue,  dxSkinFoggy, dxSkinBlack, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TFContFacturas = class(TForm)
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
    cbRecargo: TcxCheckBox;
    ActionList: TActionList;
    ACancelar: TAction;
    AAceptar: TAction;
    ssEmpresa: TSimpleSearch;
    ssCliente: TSimpleSearch;
    cxLabel1: TcxLabel;
    txSerie: TcxTextEdit;
    ssSerie: TSimpleSearch;
    procedure FormCreate(Sender: TObject);
    procedure btAceptarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PonNombre(Sender: TObject);
    procedure btnRutaClick(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure AAceptarExecute(Sender: TObject);
    procedure ssSerieAntesEjecutar(Sender: TObject);
    procedure txClientePropertiesChange(Sender: TObject);

  private
    iNumFacturas, iFactIni, iFactFin: Integer;
    dFechaIni, dFechaFin: TDateTime;

    procedure RellenarDatosIni;
    function Parametros: boolean;
    function Contabilizar: boolean;
    function FacturasNoProcesadas: integer;
    procedure CreaQGrupoT;
    function EjecutaQGrupoT: boolean;

  public

  end;

var
  FContFacturas: TFContFacturas;

implementation

{$R *.dfm}
uses DError, Principal, UDMAuxDB, bMath, CGlobal, UDMBaseDatos, CAuxiliarDB, FileCtrl, UDFactura,
     CContabilizacion, CGestionPrincipal, CVariables, BonnyQuery, CFactura;

procedure TFContFacturas.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  CrearBuffers;
  CrearConsultas;
end;

procedure TFContFacturas.btAceptarClick(Sender: TObject);
begin
  //Datos del formulario correctos
  if not Parametros then exit;

  LimpiarBuffers;
  CreaQGrupoT;

  NombresFicheros(txRuta.Text, txEmpresa.Text);
  if Contabilizar then
  begin
    GrabarFichero(txRuta.Text);

    Gauge1.Progress := iFacConta;
    if iFacConta <> iNumFacturas then
      showmessage('Proceso de Contabilización finalizado con ERRORES.' + #13 + #10 +
                  IntToStr(iNumFacturas - Gauge1.Progress) + ' factura/s no contabilizada/s.')
    else
      showmessage('Proceso de Contabilización finalizado correctamente.');
  end;

//  RellenarDatosIni;

end;

function TFContFacturas.Parametros: boolean;
begin
  Result := False;

  if ( txEmpresa.Text <> '' ) and ( txDesEmpresa.Text  = '' ) then
  begin
    txEmpresa.SetFocus;
    ShowError('El codigo de empresa es incorrecto.');
    exit;
  end;

  //comprobar que existe la serie
  if txSerie.Text <> '' then
  begin
    if not ExisteSerie(txEmpresa.Text, txSerie.Text, deDesdeFecha.Text) then
    begin
      txSerie.SetFocus;
      ShowError('No existe la serie de facturación indicada.');
      Exit;
    end;
  end;

  if ( txCliente.Text <> '' ) and ( txDesCliente.Text  = '' ) then
  begin
    txCliente.SetFocus;
    ShowError('El codigo del cliente es incorrecto.');
    exit;
  end;

  if not TryStrToInt( Trim( txDesdeFactura.Text ), iFactIni ) then
  begin
    txDesdeFactura.SetFocus;
    ShowError('Falta el número de la factura inicial o es incorrecto.');
    exit;
  end;

  if not TryStrToInt( Trim( txHastaFactura.Text ), iFactFin ) then
  begin
    txHastaFactura.SetFocus;
    ShowError('Falta el número de la factura final o es incorrecto.');
    exit;
  end;

  if iFactIni > iFactFin then
  begin
    txDesdeFactura.SetFocus;
    ShowError('Rango de facturas incorrecto.');
    exit;
  end;

  if not TryStrToDate( Trim( deDesdeFecha.Text ), dFechaIni ) then
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
  end;

  Result := true;
end;

function TFContFacturas.Contabilizar: boolean;
var
    //iRango: Integer;
    sMsg: string;
begin
  Result := true;
  iNumFacturas := FacturasNoProcesadas;
  if iNumFacturas > 0 then
  begin
    //iRango := (iFactFin + 1) - iFactIni;
    sMsg := ' Hay ' + IntToStr( iNumFacturas ) + ' facturas no contabilizadas ' + #13 + #10 +
           ' ¿Continuar con el proceso de Contabilización de Facturas? ';
    if MessageDlg( sMsg, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      Gauge1.maxvalue := iNumFacturas;
      Lbfacturas.Caption:= 'Total facturas: '+formatfloat(',0',iNumFacturas);

      EjecutaQGrupoT;
      ContabilizarFacturas(DMBaseDatos.DBBaseDatos);
    end
    else
    begin
      ShowMessage('Operación cancelada por el usuario.');
      Result := false;
    end;
  end
  else
  begin
    ShowMessage('No hay facturas a contabilizar dentro del rango seleccionado.');
    Result := False;
  end;

end;

function TFContFacturas.FacturasNoProcesadas: integer;
var QNumFacturas: TBonnyQuery;
begin
  QNumFacturas := TBonnyQuery.Create(Self);
  with QNumFacturas do
  try
    SQL.Add('  select count(*) from tfacturas_cab, frf_empresas ');
    SQL.Add('   where 1= 1 ');
    if txEmpresa.text <> '' then
      SQL.Add(' and cod_empresa_fac_fc = :empresa ');
    if txSerie.text <> '' then
      SQL.Add(' and cod_serie_fac_fc = :serie ');
    if txCliente.Text <> '' then
      SQL.Add('   and cod_cliente_fc = :cliente ');
    SQL.Add('   and n_factura_fc between :facturaIni and :facturaFin ');
    SQL.Add('   and fecha_factura_fc between :fechaIni and :fechaFin ');
    SQL.Add('   and contabilizado_fc = 0 ');
    SQL.Add('   and  empresa_e = cod_empresa_fac_fc ');
    SQL.Add('   and  contabilizar_e = 1 ');
    if cbRecargo.Checked then
    begin
    SQL.Add('   and cod_cliente_fc in (select cliente_irc from frf_impuestos_recargo_cli ');
    SQL.Add('   			                  where empresa_irc = cod_empresa_fac_fc ');
    SQL.Add('   			                    and cliente_irc = cod_cliente_fc ');
    SQL.Add('   			                    and recargo_irc <> 0 ');
    SQL.Add('   			                    and fecha_factura_fc  between fecha_ini_irc and case ');
    SQL.Add('                             when fecha_fin_irc is null then fecha_factura_fc else fecha_fin_irc end) ');
    end
    else
    begin
    SQL.Add('   and cod_cliente_fc not in (select cliente_irc from frf_impuestos_recargo_cli ');
    SQL.Add('   			                  where empresa_irc = cod_empresa_fac_fc ');
    SQL.Add('   			                    and cliente_irc = cod_cliente_fc ');
    SQL.Add('   			                    and recargo_irc <> 0 ');
    SQL.Add('   			                    and fecha_factura_fc  between fecha_ini_irc and case ');
    SQL.Add('                             when fecha_fin_irc is null then fecha_factura_fc else fecha_fin_irc end) ');
    end;

    if txEmpresa.Text <> ''  then
      ParamByName('empresa').AsString := txEmpresa.Text;
    if txSerie.Text <> ''  then
      ParamByName('serie').AsString := txSerie.Text;
    if txCliente.Text <> '' then
      ParamByName('cliente').AsString := txCliente.Text;
    ParamByName('facturaIni').AsInteger := iFactIni;
    ParamByName('facturaFin').AsInteger := iFactFin;
    ParamByName('fechaIni').AsDateTime := dFechaIni;
    ParamByName('fechaFin').AsDateTime := dFechaFin;

    Open;
    Result := Fields[0].AsInteger;
    Close;

  finally
    free;
  end;

end;


procedure TFContFacturas.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFContFacturas.FormClose(Sender: TObject;
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
end;

procedure TFContFacturas.FormShow(Sender: TObject);
begin
  RellenarDatosIni;
  txRuta.Text := ObtenerRuta;
end;

procedure TFContFacturas.RellenarDatosIni;
begin
   //Borrar contenido de las tablas
//  Limpiar;

   //Rellenamos datos iniciales
  txEmpresa.Text := gsDefEmpresa;
  txDesdeFactura.Text := '1';
  txHastaFactura.Text := '999999';
  deDesdeFecha.Text := DateToStr(Date);
  deHastaFecha.Text := DateToStr(Date);
  cbRecargo.Checked := false;

  Gauge1.progress:=0;
  Gauge1.maxvalue:=0;
  lbFacturas.Caption := 'Total Facturas: 0';

  txEmpresa.SetFocus;

end;

procedure TFContFacturas.ssSerieAntesEjecutar(Sender: TObject);
begin
    ssSerie.SQLAdi := '';
    ssSerie.SQLAdi := ' anyo_es >= year(today) -1 ';
    if txEmpresa.Text <> '' then
      ssSerie.SQLAdi := ssSerie.SQLAdi + ' and cod_empresa_es = ' +  QuotedStr(txEmpresa.Text);
end;

procedure TFContFacturas.txClientePropertiesChange(Sender: TObject);
begin
  if txCliente.Text = '' then
    txDesCliente.Text := 'TODOS LOS CLIENTES'
  else
    txDesCliente.Text := desCliente(txCliente.Text);
end;

procedure TFContFacturas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFContFacturas.PonNombre(Sender: TObject);
begin

  txSerie.Text := txEmpresa.Text;
  if txEmpresa.Text = '' then
    txDesEmpresa.Text := 'TODAS LAS EMPRESAS'
  else
    txDesEmpresa.Text := desEmpresa(txEmpresa.Text);

  if txCliente.Text = '' then
    txDesCliente.Text := 'TODOS LOS CLIENTES'
  else
    txDesCliente.Text := desCliente(txCliente.Text);

//  txDesEmpresa.Text := desEmpresa(txEmpresa.Text);
//  txDesCliente.Text := desCliente(txEmpresa.Text, txCliente.Text);
end;

procedure TFContFacturas.CreaQGrupoT;
begin
  QGrupoT := TBonnyQuery.Create(Self);
  with QGrupoT do
  begin
    SQL.Add(' select * from tfacturas_cab, frf_empresas ');
    SQL.Add('  where 1= 1 ');
    if txEmpresa.text <> '' then
      SQL.Add('  and cod_empresa_fac_fc = :empresa ');
    if txSerie.text <> '' then
      SQL.Add('  and cod_serie_fac_fc = :serie ');
    if txCliente.Text <> '' then
      SQL.Add('  and cod_cliente_fc = :cliente ');
    SQL.Add('    and n_factura_fc between :facturaIni and :facturaFin ');
    SQL.Add('    and fecha_factura_fc between :fechaIni and :fechaFin ');
    SQL.Add('    and contabilizado_fc = 0 ');
    SQL.Add('    and  empresa_e = cod_empresa_fac_fc ');
    SQL.Add('    and  contabilizar_e = 1 ');

    if cbRecargo.Checked then
    begin
    SQL.Add('   and cod_cliente_fc in (select cliente_irc from frf_impuestos_recargo_cli ');
    SQL.Add('   			                  where empresa_irc = cod_empresa_fac_fc ');
    SQL.Add('   			                    and cliente_irc = cod_cliente_fc ');
    SQL.Add('   			                    and recargo_irc <> 0 ');
    SQL.Add('   			                    and fecha_factura_fc  between fecha_ini_irc and case ');
    SQL.Add('                             when fecha_fin_irc is null then fecha_factura_fc else fecha_fin_irc end) ');
    end
    else
    begin
    SQL.Add('   and cod_cliente_fc not in (select cliente_irc from frf_impuestos_recargo_cli ');
    SQL.Add('   			                  where empresa_irc = cod_empresa_fac_fc ');
    SQL.Add('   			                    and cliente_irc = cod_cliente_fc ');
    SQL.Add('   			                    and recargo_irc <> 0 ');
    SQL.Add('   			                    and fecha_factura_fc  between fecha_ini_irc and case ');
    SQL.Add('                             when fecha_fin_irc is null then fecha_factura_fc else fecha_fin_irc end) ');
    end;

    SQL.Add('  order by cod_empresa_fac_fc, cod_serie_fac_fc, YEAR(fecha_factura_fc), n_factura_fc, fecha_factura_fc ');

    Prepare;
  end;
end;

function TFContFacturas.EjecutaQGrupoT: boolean;
begin
  with QGrupoT do
  begin
    if Active then
      Close;

    if txEmpresa.Text <> '' then
      ParamByName('empresa').AsString := txEmpresa.Text;
    if txSerie.Text <> '' then
      ParamByName('serie').AsString := txSerie.Text;
    if txCliente.Text <> '' then
      ParamByName('cliente').AsString := txCliente.Text;
    ParamByName('facturaIni').AsInteger := iFactIni;
    ParamByName('facturaFin').AsInteger := iFactFin;
    ParamByName('fechaIni').AsDateTime := dFechaIni;
    ParamByName('fechaFin').AsDateTime := dFechafin;

    Open;
    Result := not IsEmpty;
  end;
end;

procedure TFContFacturas.btnRutaClick(Sender: TObject);
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



procedure TFContFacturas.ACancelarExecute(Sender: TObject);
begin
  btCancelar.Click;
end;

procedure TFContFacturas.AAceptarExecute(Sender: TObject);
begin
  btAceptar.Click;
end;

end.
