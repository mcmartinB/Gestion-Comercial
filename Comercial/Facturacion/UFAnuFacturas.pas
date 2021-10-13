unit UFAnuFacturas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, ComCtrls, dxCore,
  cxDateUtils, Menus, StdCtrls, cxButtons, SimpleSearch, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxLabel, cxGroupBox, Gauges, ExtCtrls,
  cxTextEdit, BonnyQuery, DB, DBClient, kbmMemTable, Grids, DBGrids, DBTables,
  cxCheckBox, ActnList,

  dxSkinsCore, dxSkinBlue,  dxSkinFoggy, dxSkinBlueprint, dxSkinMoneyTwins;

type
  TFAnuFacturas = class(TForm)
    tx1: TcxTextEdit;
    pnl1: TPanel;
    Gauge1: TGauge;
    gbCriterios: TcxGroupBox;
    lb2: TcxLabel;
    txFactura: TcxTextEdit;
    lb4: TcxLabel;
    deFechaFactura: TcxDateEdit;
    lbCliente: TcxLabel;
    txCliente: TcxTextEdit;
    txDesCliente: TcxTextEdit;
    lb5: TcxLabel;
    txEmpresa: TcxTextEdit;
    txDesEmpresa: TcxTextEdit;
    btAceptar: TcxButton;
    btCancelar: TcxButton;
    lb7: TcxLabel;
    lbFacturas: TcxLabel;
    lb1: TcxLabel;
    deFechaAbono: TcxDateEdit;
    lb3: TcxLabel;
    ds1: TDataSource;
    cbAbonosPerdidos: TcxCheckBox;
    cxlb6: TcxLabel;
    txAbono: TcxTextEdit;
    ActionList: TActionList;
    ACancelar: TAction;
    AAceptar: TAction;
    ssEmpresa: TSimpleSearch;
    ssCliente: TSimpleSearch;
    cxLabel1: TcxLabel;
    txtSerie: TcxTextEdit;
    ssSerie: TSimpleSearch;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCancelarClick(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btAceptarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbAbonosPerdidosClick(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure AAceptarExecute(Sender: TObject);
    procedure ssSerieAntesEjecutar(Sender: TObject);
    procedure txClientePropertiesChange(Sender: TObject);

  private
    sFacturas,
    sEmpOrigen, sSerOrigen, sCodOrigen, sFechaOrigen, sSerieOrigen: string;
    dFechaFacturaOrigen, dFechaCobroOrigen, dFechaTeaoreriaOrigen: TDateTime;
    dFechaFactura, dFechaAbono: TDateTime;
    iFactura, iFacturaNumero,
    iNumOrigen: integer;
    sClaveFactura: String;
    resumenFact: TStringList;
    bAbonoPerdido: boolean;


    function Parametros: boolean;
    procedure RellenarDatosIni;
    procedure AnularFacturas;
    procedure CreaQFacturas;
    function EjecutaQFacturas: boolean;
    procedure CreaQLineas;
    procedure CreaQGastos;
    procedure CreaQBases;
    procedure CreaQFacturasAnu;
    procedure CreaQLineasAnu;
    procedure CreaQGastosAnu;
    procedure CreaQActFactura;
    procedure CreaQAlbaranes;
    procedure CreaTemporal;
    procedure BorraTemporal;
    function EjecutaQLineas: boolean;
    function EjecutaQGastos: boolean;
    function EjecutaQBases: boolean;
    function EjecutaQLineasAnu: Boolean;
    function EjecutaQGastosAnu: Boolean;
    procedure Anular;
    procedure InsertarCabecera;
    procedure InsertarLineas;
    procedure InsertarGastos;
    procedure InsertarBases;
    procedure ActualizarFactura;
    procedure ActualizarAlbaranes;
    function MostrarRejillaAnulacion: Boolean;
    function MostrarRejillaAnuladas: Boolean;
    procedure RellenaTablasMem;
    procedure RellenaTablasMemAnu;
    procedure IniTemporal;
    procedure MontarConsultaAnu;
    procedure AbrirMantFacturas;
    function CanFacturarFecha(AEmpresa, ADate, ASerie: string): Boolean;

  public
    QFacturas, QLineas, QGastos, QBases,
    QFacturasAnu, QLineasAnu, QGastosAnu,
    QActFactura, QAlbaranes: TBonnyQuery;
    mtFactAnula: TkbmMemTable;


  end;

var
  FAnuFacturas: TFAnuFacturas;

implementation

uses Principal, CGestionPrincipal, CVariables, UDMAuxDB, DError, UDMBaseDatos, CAuxiliarDB, UDFactura,
     CFactura, UFRejillaAnulacion, UFRejillaAnuladas, UFManFacturas, CUAMenuUtils, bDialogs;

{$R *.dfm}

procedure TFAnuFacturas.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  CreaQLineas;
  CreaQGastos;
  CreaQBases;
  CreaTemporal;
  CreaQFacturasAnu;
  CreaQLineasAnu;
  CreaQGastosAnu;
  CreaQActFactura;
  CreaQAlbaranes;

  resumenFact := TStringList.Create;
end;

procedure TFAnuFacturas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  BEMensajes('');
  Action := caFree;
  BorraTemporal;
  resumenFact.Free;
end;

procedure TFAnuFacturas.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFAnuFacturas.PonNombre(Sender: TObject);
begin
  txtSerie.Text := txEmpresa.Text;
  txDesEmpresa.Text := desEmpresa(txEmpresa.Text);
end;

procedure TFAnuFacturas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFAnuFacturas.btAceptarClick(Sender: TObject);
begin

  bAbonoPerdido:= cbAbonosPerdidos.Checked;
  //Datos del formulario correctos
  if not Parametros then exit;

  CreaQFacturas;

  AnularFacturas;

//  RellenarDatosIni;

end;

function TFAnuFacturas.Parametros: boolean;
begin
  Result := False;

  if txDesEmpresa.Text = '' then
  begin
    txEmpresa.SetFocus;
    ShowError('Falta codigo de la empresa o es incorrecto.');
    exit;
  end;

  //comprobar que existe la serie
  if not ExisteSerie(txEmpresa.Text, txtSerie.Text, deFechaFactura.Text) then
  begin
    txtSerie.SetFocus;
    ShowError('No existe la serie de facturación indicada.');
    Exit;
  end;

  if txDesCliente.Text = '' then
  begin
    txCliente.SetFocus;
    ShowError('Falta codigo del cliente o es incorrecto.');
    exit;
  end;

  if not TryStrToDate( Trim( deFechaFactura.Text ), dFechaFactura ) then
  begin
    deFechaFactura.SetFocus;
    ShowError('Falta Fecha de Factura.');
    exit;
  end;

  if not TryStrToDate( Trim( deFechaAbono.Text ), dFechaAbono ) then
  begin
    deFechaAbono.SetFocus;
    ShowError('Falta Fecha de Abono.');
    exit;
  end;

  if dFechaFactura > dFechaAbono then
  begin
    deFechaFactura.SetFocus;
    ShowError('La Fecha de Abono debe ser mayor o igual que la Fecha de Factura.');
    exit;
  end;

  if txFactura.Text <> '' then
    TryStrToInt( Trim( txFactura.Text ), iFactura );

  Result := true;
end;

procedure TFAnuFacturas.FormShow(Sender: TObject);
begin
  RellenarDatosIni;
end;

procedure TFAnuFacturas.RellenarDatosIni;
begin
  LimpiarTemporales;
  resumenFact.Clear;

   //Rellenamos datos iniciales
  txEmpresa.Text := gsDefEmpresa;
  deFechaAbono.Text := DateToStr(Date);
  cbAbonosPerdidos.Checked := False;
  txAbono.Text := '';
  txAbono.Enabled := False;

  Gauge1.progress:=0;
  Gauge1.maxvalue:=0;
  lbFacturas.Caption := 'Total Facturas: 0';

  cbAbonosPerdidosClick(Self);
  txEmpresa.SetFocus;
end;

procedure TFAnuFacturas.AnularFacturas;
begin

  if EjecutaQFacturas then
  begin
      // Control de albaranes a facturar para contador de facturas perdidas
    if (bAbonoPerdido) and (QFacturas.RecordCount > 1) then
    begin
      Advertir('ATENCION: Se ha encontrado más de una factura para anular con el filtro indicado. Nº facturas seleccionadas: ' +
                IntToStr(QFacturas.RecordCount));
      Exit;
    end;

    if not CanFacturarFecha(txEmpresa.Text, deFechaAbono.Text, txtSerie.Text) then
      Exit;

    IniTemporal;
    RellenaTablasMem;
    if MostrarRejillaAnulacion then
    begin
      Anular;
      MontarConsultaAnu;
      RellenaTablasMemAnu;
      if MostrarRejillaAnuladas then
        AbrirMantFacturas;
    end;
  end
  else
    showmessage('No existen facturas dentro del rango seleccionado.');

end;

procedure TFAnuFacturas.CreaQFacturas;
begin
  QFacturas := TBonnyQuery.Create(Self);
  with QFacturas do
  begin
    RequestLive := True;
    SQL.Add(' select * from tfacturas_cab ');
    SQL.Add('  where tipo_factura_fc = ' + QuotedStr('380') );
    //SQL.Add('    and automatica_fc = 1 ');
    SQL.Add('    and anulacion_fc = 0 ');
    SQL.Add('    and cod_empresa_fac_fc = :empresa ');
    SQL.Add('    and cod_serie_fac_fc = :serie ');
    SQL.Add('    and cod_cliente_fc = :cliente ');
    SQL.Add('    and fecha_factura_fc = :fechafac ');
    if txFactura.Text <> '' then
      SQL.Add(' and n_factura_fc = :numerofac ');
    SQL.Add(' order by cod_factura_fc ');
  end;
end;

function TFAnuFacturas.EjecutaQFacturas: boolean;
begin
  with QFacturas do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := txEmpresa.Text;
    ParamByName('serie').AsString := txtSerie.Text;
    ParamByName('cliente').AsString := txCliente.Text;
    ParamByName('fechafac').AsDateTime := dFechaFactura;
    if txFactura.Text <> '' then
      ParamByName('numerofac').AsInteger := iFactura;

    Open;
    Last;
    First;
    Result := not IsEmpty;
  end;
end;

procedure TFAnuFacturas.Anular;
var sAux: String;
    iFacturas: integer;
begin

  mtFactAnula.Filter := ' anular = true';
  mtFactAnula.Filtered := true;
  iFacturas :=mtFactAnula.Recordcount;
  mtFactAnula.Filter := '';
  mtFactAnula.Filtered := false;
  Gauge1.maxvalue := iFacturas;
  Lbfacturas.Caption:= 'Total facturas: '+formatfloat(',0',iFacturas);

  DFactura.mtFacturas_Cab.First;
  while not DFactura.mtFacturas_Cab.Eof do
  begin
    mtFactAnula.locate('cod_factura', DFactura.mtFacturas_Cab.FieldByName('cod_factura_fc').AsString, [] );
    if mtFactAnula.FieldByName('anular').AsBoolean then
    begin

               //ABRIR TRANSACCION
      if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
        break;

      try
        if bAbonoPerdido then
          iFacturaNumero := StrToInt(txAbono.Text)
        else
          iFacturaNumero := GetNumeroFactura(DFactura.mtFacturas_Cab.FieldByName('cod_empresa_fac_fc').AsString,
                                             '381',
                                             DFactura.mtFacturas_Cab.FieldByName('impuesto_fc').AsString,
                                             DFactura.mtFacturas_Cab.FieldByName('cod_serie_fac_fc').AsString,
                                             dFechaAbono, sAux);
        if iFacturaNumero = -1 then
        begin
          ShowError( sAux );
          CancelarTransaccion(DMBaseDatos.DBBaseDatos);
          Break;
        end;

        sClaveFactura := NewCodigoFactura(DFactura.mtFacturas_Cab.FieldByName('cod_empresa_fac_fc').AsString,
                                          '381',
                                          DFactura.mtFacturas_Cab.FieldByName('impuesto_fc').AsString,
                                          DFactura.mtFacturas_Cab.FieldByName('cod_serie_fac_fc').AsString,
                                          dFechaAbono,
                                          iFacturaNumero );
        sEmpOrigen := DFactura.mtFacturas_Cab.FieldByName('cod_empresa_fac_fc').AsString;
        sSerOrigen := DFactura.mtFacturas_Cab.FieldByName('cod_serie_fac_fc').AsString;
        iNumOrigen := DFactura.mtFacturas_Cab.FieldByName('n_factura_fc').AsInteger;
        sCodOrigen := DFactura.mtFacturas_Cab.FieldByName('cod_factura_fc').AsString;
        sFechaOrigen := DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsString;
        sSerieOrigen := DFactura.mtFacturas_Cab.FieldByName('cod_serie_fac_fc').AsString;

        dFechaFacturaOrigen:= DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsDateTime;
        dFechaCobroOrigen:= DFactura.mtFacturas_Cab.FieldByName('prevision_cobro_fc').AsDateTime;
        dFechaTeaoreriaOrigen:= DFactura.mtFacturas_Cab.FieldByName('prevision_tesoreria_fc').AsDateTime;

        InsertarCabecera;
        InsertarLineas;
        InsertarGastos;
        InsertarBases;
        ActualizarAlbaranes;
        ActualizarFactura;

        AceptarTransaccion(DMBaseDatos.DBBaseDatos);

        resumenFact.Add(sClaveFactura);
        Gauge1.progress:=Gauge1.progress+1;

      except
        CancelarTransaccion(DMBaseDatos.DBBaseDatos);
        break;
      end;

    end;
    DFactura.mtFacturas_Cab.Next;
  end;
end;

procedure TFAnuFacturas.InsertarCabecera;
begin

  if not (DFactura.mtFacturas_Cab.State in dsEditmodes) then
    DFactura.mtFacturas_Cab.Edit;
  DFactura.mtFacturas_Cab.FieldByName('cod_factura_fc').AsString := sClaveFactura;
  DFactura.mtFacturas_Cab.FieldByName('n_factura_fc').AsInteger := iFacturaNumero;
  DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsDateTime := dFechaAbono;
  DFactura.mtFacturas_Cab.FieldByName('tipo_factura_fc').AsString := '381';
  DFactura.mtFacturas_Cab.FieldByName('anulacion_fc').AsInteger := 1;
  DFactura.mtFacturas_Cab.FieldByName('cod_factura_anula_fc').AsString := sCodOrigen;
  DFactura.mtFacturas_Cab.FieldByName('notas_fc').AsString := ' Anulacion factura ' + sCodOrigen +
                                                             ' de fecha ' + sFechaOrigen +
                                                             ' por no corresponder.';
  DFactura.mtFacturas_Cab.FieldByName('importe_linea_fc').AsFloat := DFactura.mtFacturas_Cab.FieldByName('importe_linea_fc').AsFloat * (-1);
  DFactura.mtFacturas_Cab.FieldByName('importe_descuento_fc').AsFloat := DFactura.mtFacturas_Cab.FieldByName('importe_descuento_fc').AsFloat * (-1);
  DFactura.mtFacturas_Cab.FieldByName('importe_neto_fc').AsFloat := DFactura.mtFacturas_Cab.FieldByName('importe_neto_fc').AsFloat * (-1);
  DFactura.mtFacturas_Cab.FieldByName('importe_impuesto_fc').AsFloat := DFactura.mtFacturas_Cab.FieldByName('importe_impuesto_fc').AsFloat * (-1);
  DFactura.mtFacturas_Cab.FieldByName('importe_total_fc').AsFloat := DFactura.mtFacturas_Cab.FieldByName('importe_total_fc').AsFloat * (-1);
  DFactura.mtFacturas_Cab.FieldByName('importe_neto_euros_fc').AsFloat := DFactura.mtFacturas_Cab.FieldByName('importe_neto_euros_fc').AsFloat * (-1);
  DFactura.mtFacturas_Cab.FieldByName('importe_impuesto_euros_fc').AsFloat := DFactura.mtFacturas_Cab.FieldByName('importe_impuesto_euros_fc').AsFloat * (-1);
  DFactura.mtFacturas_Cab.FieldByName('importe_total_euros_fc').AsFloat := DFactura.mtFacturas_Cab.FieldByName('importe_total_euros_fc').AsFloat * (-1);

  DFactura.mtFacturas_Cab.FieldByName('prevision_cobro_fc').AsDateTime := dFechaCobroOrigen;
  DFactura.mtFacturas_Cab.FieldByName('prevision_tesoreria_fc').AsDateTime := dFechaTeaoreriaOrigen;
  DFactura.mtFacturas_Cab.FieldByName('fecha_fac_ini_fc').AsDateTime := dFechaFacturaOrigen;

  DFactura.mtFacturas_Cab.FieldByName('contabilizado_fc').AsInteger := 0;
  DFactura.mtFacturas_Cab.FieldByName('fecha_conta_fc').AsString := '';
  DFactura.mtFacturas_Cab.FieldByName('filename_conta_fc').AsString := '';

  DFactura.mtFacturas_Cab.Post;

          // Insertamos en tfacturas_cab (BD)
  if not InsertaFacturaCabecera(sClaveFactura, iFacturaNumero) then
    raise Exception.Create('Error al insertar cabecera en tfacturas_cab.');

end;

procedure TFAnuFacturas.InsertarLineas;
begin

  DFactura.mtFacturas_Det.Filter := ' cod_factura_fd = ' + QuotedStr(sCodOrigen);
  DFactura.mtFacturas_Det.Filtered := True;
  DFactura.mtFacturas_Det.First;
  while not DFactura.mtFacturas_Det.Eof do
  begin
    if not (DFactura.mtFacturas_Det.State in dsEditmodes) then
      DFactura.mtFacturas_Det.Edit;

    DFactura.mtFacturas_Det.FieldByName('cod_factura_fd').AsString := sClaveFactura;
    DFactura.mtFacturas_Det.FieldByName('cajas_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('cajas_fd').AsFloat * (-1);
    DFactura.mtFacturas_Det.FieldByName('unidades_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('unidades_fd').AsFloat * (-1);
    DFactura.mtFacturas_Det.FieldByName('kilos_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('kilos_fd').AsFloat * (-1);
    DFactura.mtFacturas_Det.FieldByName('kilos_posei_fd').AsFloat := 0;
    DFactura.mtFacturas_Det.FieldByName('importe_linea_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('importe_linea_fd').AsFloat * (-1);
    DFactura.mtFacturas_Det.FieldByName('importe_comision_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('importe_comision_fd').AsFloat * (-1);
    DFactura.mtFacturas_Det.FieldByName('importe_descuento_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('importe_descuento_fd').AsFloat * (-1);
    DFactura.mtFacturas_Det.FieldByName('importe_euroskg_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('importe_euroskg_fd').AsFloat * (-1);
    DFactura.mtFacturas_Det.FieldByName('importe_total_descuento_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('importe_total_descuento_fd').AsFloat * (-1);
    DFactura.mtFacturas_Det.FieldByName('importe_neto_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('importe_neto_fd').AsFloat * (-1);
    DFactura.mtFacturas_Det.FieldByName('importe_impuesto_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('importe_impuesto_fd').AsFloat * (-1);
    DFactura.mtFacturas_Det.FieldByName('importe_total_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('importe_total_fd').AsFloat * (-1);

    DFactura.mtFacturas_Det.Post;

//    DFactura.mtFacturas_Det.Next;

  end;
  DFactura.mtFacturas_Det.Filter := '';
  DFactura.mtFacturas_Det.Filtered := False;

            // Insertamos en tfacturas_det (BD)
  if not InsertaFacturaDetalle(sClaveFactura, iFacturaNumero, False) then
    raise Exception.Create('Error al insertar linea de detalle en tfacturas_det.');

end;

procedure TFAnuFacturas.InsertarGastos;
begin

  DFactura.mtFacturas_Gas.Filter := ' cod_factura_fg = ' + QuotedStr(sCodOrigen);
  DFactura.mtFacturas_Gas.Filtered := True;
  DFactura.mtFacturas_Gas.First;
  while not DFactura.mtFacturas_Gas.Eof do
  begin
    if not (DFactura.mtFacturas_Gas.State in dsEditModes) then
      DFactura.mtFacturas_Gas.Edit;

    DFactura.mtFacturas_Gas.FieldByName('cod_factura_fg').AsString := sClaveFactura;
    DFactura.mtFacturas_Gas.FieldByName('importe_neto_fg').AsFloat := DFactura.mtFacturas_Gas.FieldByName('importe_neto_fg').AsFloat * (-1);
    DFactura.mtFacturas_Gas.FieldByName('importe_impuesto_fg').AsFloat := DFactura.mtFacturas_Gas.FieldByName('importe_impuesto_fg').AsFloat * (-1);
    DFactura.mtFacturas_Gas.FieldByName('importe_total_fg').AsFloat := DFactura.mtFacturas_Gas.FieldByName('importe_total_fg').AsFloat * (-1);

    DFactura.mtFacturas_Gas.Post;

//    DFactura.mtFacturas_Gas.Next;
  end;
  DFactura.mtFacturas_Gas.Filter := '';
  DFactura.mtFacturas_Gas.Filtered := False;

         // Insertamos en tfacturas_gas (BD)
  if not InsertaFacturaGastos(sClaveFactura) then
    raise Exception.Create('Error al insertar gastos en tfacturas_gas.');
end;

procedure TFAnuFacturas.InsertarBases;
begin

  DFactura.mtFacturas_Bas.Filter := ' cod_factura_fb = ' + QuotedStr(sCodOrigen);
  DFactura.mtFacturas_Bas.Filtered := True;
  DFactura.mtFacturas_Bas.First;
  while not DFactura.mtFacturas_Bas.Eof do
  begin

    if not (DFactura.mtFacturas_Bas.State in dsEditModes) then
      DFactura.mtFacturas_Bas.Edit;

    DFactura.mtFacturas_Bas.FieldByName('cod_factura_fb').AsString := sClaveFactura;
    DFactura.mtFacturas_Bas.FieldByName('cajas_fb').AsInteger := DFactura.mtFacturas_Bas.FieldByName('cajas_fb').AsInteger * (-1);
    DFactura.mtFacturas_Bas.FieldByName('unidades_fb').AsInteger := DFactura.mtFacturas_Bas.FieldByName('unidades_fb').AsInteger * (-1);
    DFactura.mtFacturas_Bas.FieldByName('kilos_fb').AsFloat := DFactura.mtFacturas_Bas.FieldByName('kilos_fb').AsFloat * (-1);
    DFactura.mtFacturas_Bas.FieldByName('importe_neto_fb').AsFloat := DFactura.mtFacturas_Bas.FieldByName('importe_neto_fb').AsFloat * (-1);
    DFactura.mtFacturas_Bas.FieldByName('importe_impuesto_fb').AsFloat := DFactura.mtFacturas_Bas.FieldByName('importe_impuesto_fb').AsFloat * (-1);
    DFactura.mtFacturas_Bas.FieldByName('importe_total_fb').AsFloat := DFactura.mtFacturas_Bas.FieldByName('importe_total_fb').AsFloat * (-1);
    DFactura.mtFacturas_Bas.Post;

//    DFactura.mtFacturas_Bas.Next;
  end;
  DFactura.mtFacturas_Bas.Filter := '';
  DFactura.mtFacturas_Bas.Filtered := False;

       // Insertamos en tfacturas_bas (BD)
  if not InsertaFacturaBase(sClaveFactura) then
    raise Exception.Create('Error al insertar bases en tfacturas_bas.');
end;

procedure TFAnuFacturas.ActualizarFactura;
begin

  try
    with QActFactura do
    begin
      if Active then
        Close;

      ParamByName('anulacion').AsInteger := 1;
      ParamByName('codanula').AsString := sClaveFactura;
      ParamByName('notas').AsString := ' Factura anulada por el abono ' + sClaveFactura +
                                                  ' de fecha ' + DateToStr(dFechaAbono) + ' por no corresponder.';
      //ParamByName('fechafactura').AsDateTime := StrToDate(sFechaOrigen);
      ParamByName('codfactura').AsString := sCodOrigen;

      ExecSQL;
    end;

  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      raise;
    end;
  end;

end;

procedure TFAnuFacturas.ActualizarAlbaranes;
begin
  try
    with QAlbaranes do
    begin
      if Active then
        Close;

      ParamByName('MIEMP').AsString := sEmpOrigen;
      ParamByName('MISER').AsString := sSerOrigen;
      ParamByName('MIFAC').AsInteger := iNumOrigen;
      ParamByName('MIFEC').AsString := sFechaOrigen;

      ExecSQL;
    end;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      raise;
    end;
  end;
end;

function TFAnuFacturas.MostrarRejillaAnulacion: boolean;
begin
  FRejillaAnulacion:= TFRejillaAnulacion.Create( self );
  try

    FRejillaAnulacion.txEmpresa.Text := txEmpresa.Text;
    FRejillaAnulacion.txDesempresa.Text := DesEmpresa(txEmpresa.Text);
    FRejillaAnulacion.txSerie.Text := txtSerie.Text;
    FRejillaAnulacion.txCliente.Text := txCliente.Text;
    FRejillaAnulacion.txDesCliente.Text := desCliente(txCliente.Text);
    FRejillaAnulacion.txFechaFactura.Text := deFechaFactura.Text;

    FRejillaAnulacion.ShowModal;

  finally
    result := (FRejillaAnulacion.ModalResult = mrOk);
    FreeAndNil(FRejillaAnulacion );
  end;
end;

function TFAnuFacturas.MostrarRejillaAnuladas: boolean;
begin
  FRejillaAnuladas:= TFRejillaAnuladas.Create( self );
  try
    FRejillaAnuladas.ShowModal;

  finally
    result := (FRejillaAnuladas.ModalResult = mrOk);
    FreeAndNil(FRejillaAnuladas );
  end;
end;

procedure TFAnuFacturas.RellenaTablasMem ;
begin
  QFacturas.First;
  while not QFacturas.Eof do
  begin
    EjecutaQLineas;
    EjecutaQGastos;
    EjecutaQBases;
    DFactura.mtFacturas_Det.LoadFromDataSet(QLineas, [mtcpoAppend]);
    DFactura.mtFacturas_Gas.LoadFromDataSet(QGastos, [mtcpoAppend]);
    DFactura.mtFacturas_Bas.LoadFromDataSet(QBases,  [mtcpoAppend]);

    QFacturas.Next;
  end;

  DFactura.mtFacturas_Cab.LoadFromDataSet(QFacturas, []);
end;

procedure TFAnuFacturas.RellenaTablasMemAnu;
begin
  DFactura.mtFacturas_Det.DeleteTable;
  DFactura.mtFacturas_Cab.DeleteTable;
  QFacturasAnu.First;
  while not QFacturasAnu.Eof do
  begin
    EjecutaQLineasAnu;
    EjecutaQGastosAnu;
    DFactura.mtFacturas_Det.LoadFromDataSet(QLineasAnu, [mtcpoAppend]);
    DFactura.mtFacturas_Gas.LoadFromDataSet(QGastosAnu, [mtcpoAppend]);

    QFacturasAnu.Next;
  end;

  DFactura.mtFacturas_Cab.LoadFromDataSet(QFacturasAnu, []);
end;

procedure TFAnuFacturas.ssSerieAntesEjecutar(Sender: TObject);
begin
    ssSerie.SQLAdi := '';
    ssSerie.SQLAdi := ' anyo_es >= year(today) -1 ';
    if txEmpresa.Text <> '' then
      ssSerie.SQLAdi := ssSerie.SQLAdi + ' and cod_empresa_es = ' +  QuotedStr(txEmpresa.Text);
end;

procedure TFAnuFacturas.txClientePropertiesChange(Sender: TObject);
begin
  txDesCliente.Text := desCliente(txCliente.Text);
end;

procedure TFAnuFacturas.IniTemporal;
begin
  mtFactAnula.Open;

  QFacturas.First;
  while not QFacturas.Eof do
  begin
    mtFactAnula.Append;
    mtFactAnula.FieldByName('cod_factura').AsString := QFacturas.FieldByname('cod_factura_fc').AsString;
    mtFactAnula.FieldByName('anular').AsBoolean := False;
    mtFactAnula.Post;

    QFacturas.Next;
  end;
end;

procedure TFAnuFacturas.MontarConsultaAnu;
var i: Integer;
begin

  sFacturas := '';
  for i:=0 to resumenFact.Count - 1 do
  begin
    if i <> 0 then sFacturas := sFacturas + ',';
    sFacturas := sFacturas + QuotedStr(resumenFact[i]);
  end;

  with QFacturasAnu do
  begin
    if Active then
      Close;

    SQL.Clear;
    SQL.Add(' select * from tfacturas_cab ');
    SQL.Add('  where cod_factura_fc in ( ' + sFacturas +  ' ) ');

    Open;
  end;
end;

procedure TFAnuFacturas.AbrirMantFacturas;
begin
  FManFacturas := TFManFacturas.Create(Self);
  FManFacturas.MostrarFacturasExt(sFacturas);
end;

function TFAnuFacturas.CanFacturarFecha(AEmpresa, ADate, ASerie: string): Boolean;
  var
  iYear, iMonth, iDay: Word;
  QContador: TBonnyQuery;
begin
  Result := true;
  DecodeDate( StrToDateDef(ADate, Date), iYear, iMonth, iDay );
  QFacturas.First;
  with QFacturas do
  begin
    if bAbonoPerdido then
    begin
      if ExisteFacturaPerdida(AEmpresa, ASerie, StrToInt(txAbono.Text), ADate) then
      begin
        ShowError('El número de abono indicado en el contador de abonos perdidos ya existe.');
        Result := false;
        exit;
      end;
      if ErrorFacturaPerdida(AEmpresa, ASerie, StrToInt(txAbono.Text), ADate,
                             QFacturas.FieldByName('impuesto_fc').AsString, '381'  ) then
      begin
        ShowError('El número de abono indicado en el contador de abonos perdidos es incorrecto. ');
        Result := false;
        exit;
      end;
      if not ValidarFecFactPerdidas(AEmpresa, ASerie, StrToInt(txAbono.Text), ADate,
                                    QFacturas.FieldByName('impuesto_fc').AsString, '381' ) then
      begin
        ShowError('La fecha "Fecha Abono" es incorrecta para el contador de abonos perdidos.');
        Result := false;
        exit;
      end;
    end
    else if QFacturas.FieldByName('impuesto_fc').AsString = 'I' then
    begin
      QContador := TBonnyQuery.Create(Self);
      with QContador do
      try
        SQL.Add(' SELECT fecha_abn_iva_fs, serie_cerrada_fs ');
        SQL.Add('   FROM frf_facturas_serie ');
        SQL.Add('    join frf_empresas_serie on cod_serie_es = cod_serie_fs and anyo_es = anyo_fs ');
        SQL.Add('  WHERE cod_empresa_es = :empresa ');
        SQL.Add('    and anyo_es = :anyo ');
        SQL.Add('    and cod_serie_es = :serie ');

        ParamByName('empresa').AsString := AEmpresa;
        ParamByName('anyo').AsInteger := iYear;
        ParamByName('serie').AsString := ASerie;
        Open;

        if FieldByName('serie_cerrada_fs').AsInteger = 1 then
        begin
          ShowError('La serie de facturación del año ' + IntToStr( iYear ) + ' ya esta cerrada.');
          Close;
          Result := false;
          Exit;
        end;

        if FieldByName('fecha_abn_iva_fs').AsDateTime > StrToDate(ADate) then
        begin
          ShowError('La fecha de abono es incorrecta para la serie de IVA.');
          Close;
          Result := false;
          Exit;
        end;
      finally
        Free;
      end
    end
    else if QFacturas.FieldByName('impuesto_fc').AsString = 'G' then
    begin
      QContador := TBonnyQuery.Create(Self);
      with QContador do
      try
        SQL.Add(' SELECT fecha_abn_igic_fs, serie_cerrada_fs ');
        SQL.Add('   FROM frf_facturas_serie ');
        SQL.Add('    join frf_empresas_serie on cod_serie_es = cod_serie_fs and anyo_es = anyo_fs ');
        SQL.Add('  WHERE cod_empresa_es = :empresa ');
        SQL.Add('    and anyo_es = :anyo ');
        SQL.Add('    and cod_serie_es = :serie ');

        ParamByName('empresa').AsString := Aempresa;
        ParamByName('anyo').AsInteger := iYear;
        ParamByName('serie').AsString := ASerie;

        Open;

        if FieldByName('serie_cerrada_fs').AsInteger = 1 then
        begin
          ShowError('La serie de facturación del año ' + IntToStr( iYear ) + ' ya esta cerrada.');
          Close;
          Result := false;
          Exit;
        end;        

        if FieldByName('fecha_abn_igic_fs').AsDateTime > StrToDate(ADate) then
        begin
          ShowError('La fecha de abono es incorrecta para la serie de IGIC.');
          Close;
          Result := false;
          Exit;
        end;
      finally
        Free;
      end;
    end;

    QFacturas.Next;
  end;
end;

procedure TFAnuFacturas.CreaQLineas;
begin
  QLineas := TBonnyQuery.Create(Self);
  with QLineas do
  begin
    SQL.Add(' select * from tfacturas_det ');
    SQL.Add('  where cod_factura_fd = :codfactura ');
  end;
end;

procedure TFAnuFacturas.CreaQGastos;
begin
  QGastos := TBonnyQuery.Create(Self);
  with QGastos do
  begin
    SQL.Add(' select * from tfacturas_gas ');
    SQL.Add('  where cod_factura_fg = :codfactura ');
  end;
end;

procedure TFAnuFacturas.CreaQBases;
begin
  QBases := TBonnyQuery.Create(Self);
  with QBases do
  begin
    SQL.Add(' select * from tfacturas_bas ');
    SQL.Add('  where cod_factura_fb = :codfactura ');
  end;
end;

procedure TFAnuFacturas.CreaQFacturasAnu;
begin
  QFacturasAnu := TBonnyQuery.Create(Self);
  with QFacturasAnu do
  begin
    SQL.Add(' select * from tfacturas_cab ');
  end;
end;

procedure TFAnuFacturas.CreaQLineasAnu;
begin
  QLineasAnu := TBonnyQuery.Create(Self);
  with QLineasAnu do
  begin
    SQL.Add(' select * from tfacturas_det ');
    SQl.Add('  where cod_factura_fd = :codfactura ');
  end;
end;

procedure TFAnuFacturas.CreaQGastosAnu;
begin
  QGastosAnu := TBonnyQuery.Create(Self);
  with QGastosAnu do
  begin
    SQL.Add(' select * from tfacturas_gas ');
    SQl.Add('  where cod_factura_fg = :codfactura ');
  end;
end;

procedure TFAnuFacturas.CreaQActFactura;
begin
  QActFactura := TBonnyQuery.Create(Self);
  with QActFactura do
  begin
    SQL.Add(' UPDATE tfacturas_cab set ');
    SQL.Add(' anulacion_fc = :anulacion, cod_factura_anula_fc = :codanula, notas_fc = :notas ');
    //SQL.Add(' ,prevision_cobro_fc = :fechafactura ');
    SQL.Add(' WHERE cod_factura_fc = :codfactura ');
  end;

end;

procedure TFAnuFacturas.CreaQAlbaranes;
begin
  QAlbaranes := TBonnyquery.Create(Self);
  with QAlbaranes do
  begin
    SQL.Add(' UPDATE frf_salidas_c set ');
    SQL.Add(' (empresa_fac_sc, serie_fac_sc, n_factura_sc,fecha_factura_sc)=(NULL,NULL,NULL,NULL) ');
    SQL.Add(' WHERE empresa_fac_sc = :MIEMP ');
    SQL.Add('   AND serie_fac_sc = :MISER ');
    SQL.Add('   AND n_factura_sc = :MIFAC ');
    SQL.Add('   AND fecha_factura_sc = :MIFEC ');
  end;
end;

procedure TFAnuFacturas.CreaTemporal;
begin
  mtFactAnula := TkbmMemTable.Create(Self);
  with mtFactAnula do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('cod_factura', ftString, 15, False);
    FieldDefs.Add('anular', ftBoolean, 0, False);

    CreateTable;

  end;
end;

procedure TFAnuFacturas.BorraTemporal;
begin
  mtFactAnula.Close;
end;

function TFAnuFacturas.EjecutaQLineas: boolean;
begin
  with QLineas do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QFacturas.FieldByName('cod_factura_fc').AsString;
    Open;

    Result := not IsEmpty;
  end;
end;

function TFAnuFacturas.EjecutaQGastos: boolean;
begin
  with QGastos do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QFacturas.FieldByName('cod_factura_fc').AsString;
    Open;

    Result := not IsEmpty;
  end;
end;

function TFAnuFacturas.EjecutaQBases: boolean;
begin
  with QBases do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QFacturas.FieldByName('cod_factura_fc').AsString;
    Open;

    Result := not IsEmpty;
  end;
end;

function TFAnuFacturas.EjecutaQLineasAnu: boolean;
begin
  with QLineasAnu do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QFacturasAnu.FieldByName('cod_factura_fc').AsString;
    Open;

    Result := not IsEmpty;
  end;
end;

function TFAnuFacturas.EjecutaQGastosAnu: boolean;
begin
  with QGastosAnu do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QFacturasAnu.FieldByName('cod_factura_fc').AsString;
    Open;

    result := not IsEmpty;
  end;
end;

procedure TFAnuFacturas.cbAbonosPerdidosClick(Sender: TObject);
begin
  if cbAbonosPerdidos.Checked then
  begin
    txAbono.Enabled := True;
    txAbono.Style.LookAndFeel.NativeStyle := True;
    txAbono.Style.Color := clWindow;
    txAbono.SetFocus;
  end
  else
    begin
    txAbono.Enabled := False;
    txAbono.Text := '';
    txAbono.Style.LookAndFeel.NativeStyle := False;
    txAbono.Style.Color := clBtnFace;
    end;
end;

procedure TFAnuFacturas.ACancelarExecute(Sender: TObject);
begin
  btCancelar.Click;
end;

procedure TFAnuFacturas.AAceptarExecute(Sender: TObject);
begin
  btAceptar.Click;
end;

end.
