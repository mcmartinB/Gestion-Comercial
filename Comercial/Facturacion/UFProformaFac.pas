unit UFProformaFac;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  CMaestroDetalle, Dialogs,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, ComCtrls,
  dxCore, cxDateUtils, Menus,  ActnList,
  dxStatusBar, cxCheckBox, cxGroupBox, cxRadioGroup, StdCtrls, cxButtons,
  SimpleSearch, cxMaskEdit, cxDropDownEdit, cxCalendar, cxTextEdit,
  cxLabel, Gauges, ExtCtrls,

  dxSkinsCore, dxSkinBlue, dxSkinFoggy, dxSkinsdxStatusBarPainter,
  dxSkinBlueprint, dxSkinMoneyTwins;

type
  TFProformaFac = class(TForm)
    pnl1: TPanel;
    gbCriterios: TcxGroupBox;
    lb2: TcxLabel;
    txDesdeAlbaran: TcxTextEdit;
    lb3: TcxLabel;
    txHastaAlbaran: TcxTextEdit;
    lb4: TcxLabel;
    deFechaFacturar: TcxDateEdit;
    btAceptar: TcxButton;
    btCancelar: TcxButton;
    st1: TdxStatusBar;
    lbCliente: TcxLabel;
    txCliente: TcxTextEdit;
    txDesCliente: TcxTextEdit;
    lb1: TcxLabel;
    deFechaFactura: TcxDateEdit;
    tx1: TcxTextEdit;
    cxlb9: TcxLabel;
    txPedido: TcxTextEdit;
    gbPrincipal: TcxGroupBox;
    cxEmpresa: TcxLabel;
    txEmpresa: TcxTextEdit;
    txDesEmpresa: TcxTextEdit;
    rgTipo: TcxRadioGroup;
    ActionList: TActionList;
    ACancelar: TAction;
    AAceptar: TAction;
    ssEmpresa: TSimpleSearch;
    ssCliente: TSimpleSearch;
    cxLabel1: TcxLabel;
    txSerie: TcxTextEdit;
    ssSerie: TSimpleSearch;
    procedure PonNombre(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btAceptarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure rgTipoFactura1PropertiesChange(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure AAceptarExecute(Sender: TObject);
    procedure ssSerieAntesEjecutar(Sender: TObject);
    procedure txClientePropertiesChange(Sender: TObject);

  private
    function Parametros(var ponerFoco: TcxCustomTextEdit): boolean;
    function EstaCambioGrabado: boolean;
    function VerificarAnyoContador: boolean;
    procedure Limpiar;
    procedure ProcesoFacturacion;
    function EsClienteExtranjero(codEmp, codCliente: string ): boolean;
    function RellenaTabla: boolean;
    function NumeraFacturas: boolean;
    function CanFacturarFecha(AEmpresa, ADate, ASerie: string): Boolean;
    function ComprobarCuentas: Boolean;
    function MostrarRejillaProforma : boolean;
    function Rellenafacturas: boolean;
    procedure Previsualizar;
    function HaySeleccion : Boolean;
    function FacturarPor(const empresa, cliente: string): integer;
    procedure AsignaFacturaTempCab(ClaveFactura: string; FacturaNumero: integer);
    procedure AsignaFacturaTempDet(ClaveFactura: string);
    procedure AsignaFacturaTempGas(ClaveFactura: string);
    procedure AsignaFacturaTempBas(ClaveFactura: string);
    function AsuntoFactura: string;
    procedure RellenarDatosIni;
    procedure OrdenaMemFacturas;

  public

  end;

var
  FProformaFac: TFProformaFac;

implementation

{$R *.dfm}

uses bDialogs, CAuxiliarDB, CVariables, UDMAuxDB, UDMBaseDatos, UDMCambioMoneda,
     CFactura, bSQLUtils, Principal, UFRejillaProforma, UDFactura,
     URFactura, UDMConfig,DConfigMail, CGlobal, DError, DPreview, CGestionPrincipal, BonnyQuery;

procedure TFProformaFac.PonNombre(Sender: TObject);
begin
  txSerie.Text := txEmpresa.Text;
  txDesEmpresa.Text := desEmpresa(txEmpresa.Text);
  txDesCliente.Text := desCliente(txCliente.Text);
end;

procedure TFProformaFac.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFProformaFac.btAceptarClick(Sender: TObject);
var temp: TcxCustomTextEdit;
begin

  //Datos del formulario correctos
  if not Parametros(temp) then
  begin
    temp.SetFocus;
    Exit;
  end;

  if not EstaCambioGrabado then
  begin
    Exit;
  end;

  //Comprobaciones a�o-contador
  if not VerificarAnyoContador then
  begin
    txCliente.SetFocus;
    Exit;
  end;

  Limpiar;

  ProcesoFacturacion;

  CFactura.LimpiarTemporales;

//  RellenarDatosIni;
end;

function TFProformaFac.Parametros(var ponerFoco: TcxCustomTextEdit): boolean;
var
  dFechaFacturar, dFechaFactura: TDateTime;
begin
     //Comprobar que el campo empresa tiene valor
  if (txDesEmpresa.Text = '') then
  begin
    ShowError('Falta el c�digo de la empresa o es incorrecto.');
    ponerFoco := txEmpresa;
    Parametros := false;
    Exit;
  end;

  //comprobar que existe la serie
  if not ExisteSerie(txEmpresa.Text, txSerie.Text, deFechaFactura.Text) then
  begin
    ShowError('No existe la serie de facturaci�n indicada.');
    ponerFoco := txSerie;
    Parametros := false;
    Exit;
  end;

      // Numero de Pedido
  if rgTipo.Properties.Items[rgTipo.ItemIndex].Value = 'P' then
  begin
    if txPedido.Text = '' then
    begin
    ShowError('Falta introducir el numero de pedido.');
    ponerFoco := txPedido;
    Parametros := false;
    Exit;
    end;
  end;


     //Comprobar que el cliente tiene valor
  if txDesCliente.Text = '' then
  begin
    ShowError('Falta el c�digo del cliente o es incorrecto.');
    ponerFoco := txCliente;
    Parametros := false;
    Exit;
  end;

  if not TryStrToDate( deFechaFactura.Text, dFechaFactura ) then
  begin
    ShowError('La fecha de "Fecha Factura" es incorrecta.');
    ponerFoco := deFechaFactura;
    Parametros := false;
    Exit;
  end;


  if rgTipo.Properties.Items[rgTipo.ItemIndex].Value = 'F' then
  begin
       //Comprobar que el albaran tiene valor
    if (trim(txDesdeAlbaran.Text) = '') then
    begin
      ShowError('Es necesario que rellene el albar�n a imprimir.');
      ponerFoco := txDesdeAlbaran;
      Parametros := false;
      Exit;
    end;
       //Si no hemos puesto nada rellenar automaticamente
    if (trim(txHastaAlbaran.Text) = '') then
    begin
      txHastaAlbaran.Text := txDesdeAlbaran.Text;
    end;

    if not TryStrToDate( deFechaFacturar.Text, dFechaFacturar ) then
    begin
      ShowError('La fecha de "Facturar Hasta" es incorrecta.');
      ponerFoco := deFechaFacturar;
      Parametros := false;
      Exit;
    end;

    if dFechaFacturar > dFechaFactura then
    begin
      ShowError('La fecha "Facturar Hasta" no puede se mayor que la fecha "Fecha Factura".');
      ponerFoco := deFechaFacturar;
      Parametros := false;
      Exit;
    end;

  end;

  ponerFoco := nil;
  Parametros := true;
end;

function TFProformaFac.EstaCambioGrabado: boolean;
var
    sMoneda: string;
begin
    result:= true;
    
  //Mirar a ver si el cambio del dia esta grabado
  //solamente exportacion
  if esClienteExtranjero( txEmpresa.Text, txCliente.Text ) then
  with DFactura.QAux do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQL.Add('select distinct moneda_sc from frf_salidas_c ');
    SQL.Add('where empresa_sc = :empresa ');
    SQL.Add('  and cliente_fac_sc = :cliente ');
    SQL.Add('  and fecha_sc between :fechaini and :fechafin ');
    SQL.Add('  and n_factura_sc is null ');
    SQL.Add('  and moneda_sc <> ''EUR'' ');

    ParamByName('empresa').AsString:= txEmpresa.Text;
    ParamByName('cliente').AsString:= txCliente.Text;
    ParamByName('fechaini').AsDateTime:= strtodate( deFechaFacturar.Text ) - 365;
    ParamByName('fechafin').AsDateTime:= strtodate( deFechaFacturar.Text );
    Open;

    if not IsEmpty then
    begin
      while not Eof and result do
      begin
        sMoneda:= Fields[0].AsString;
        if not ChangeExist( sMoneda, StrToDate( deFechaFactura.Text ) ) then
        begin
          result:= False;
          sMoneda:= 'No se puede facturar si no esta el cambio del d�a grabado.' + #13 + #10 +
                    'Falta grabar el cambio del "' + deFechaFactura.Text + '" para ''' + sMoneda + '''';
          ShowMessage( sMoneda );
        end;
        next;
      end;
    end;

    Close;
  end;
end;

function TFProformaFac.VerificarAnyoContador: boolean;
var
  iAux, iYear, iMonth, iDay: word;
begin
  result:= false;
  with DFactura.QGeneral do
  begin
    Sql.Clear;
    SQL.Add(' SELECT year(fecha_sc) year');
    SQL.Add(' FROM frf_salidas_c Frf_salidas_c');

    SQL.Add(' WHERE (cliente_fac_sc = :Cliente)');

    SQL.Add(' AND  (n_factura_sc IS NULL)');
    SQL.Add(' AND  (cliente_sal_sc <> "RET")');
    SQL.Add(' AND  (cliente_sal_sc <> "REA")');
    SQL.Add(' AND  (cliente_sal_sc <> "0BO")');
    SQL.Add(' AND  (cliente_sal_sc <> "EG")');
    if Trim(txPedido.Text) <> '' then
      SQL.Add(' AND  (n_pedido_sc = :pedido)')
    else
    begin
      SQL.Add(' AND  (empresa_sc = :empresa)');
      SQL.Add(' AND  (n_albaran_sc BETWEEN :albaranDesde AND :albaranHasta)');
      SQL.Add(' AND  (fecha_sc <= :fecha)');
    end;

    SQL.Add(' group by 1 order by 1');

    ParamByName('Cliente').AsString := txCliente.Text;
    if Trim(txPedido.Text) <> '' then
      ParamByName('pedido').AsString := txPedido.Text
    else
    begin
      ParamByName('empresa').AsString := txEmpresa.Text;
      ParamByName('albaranDesde').AsString := txDesdeAlbaran.Text;
      ParamByName('albaranHasta').AsString := txHastaAlbaran.Text;
      ParamByName('fecha').AsDate := StrToDate(deFechaFacturar.Text);
    end;

    Open;
    if IsEmpty then
    begin
      Advertir('No existen albaranes por facturar que cumplan el criterio seleccionado.');
    end
    else
    begin
      DecodeDate( StrToDate( deFechaFactura.Text ), iYear, iMonth, iDay );
      iAux:= FieldByName('year').AsInteger;
      if iAux <> iYear then
      begin
        Advertir('No se puede facturar albaranes del a�o ' + IntToStr( iAux) + ' con fecha del ' + IntToStr( iYear) + '.');
      end
      else
      begin
        Next;
        iAux:= FieldByName('year').AsInteger;
        If iAux <> iYear then
        begin
           Advertir('No se puede facturar albaranes del a�o ' + IntToStr( iAux) + ' con fecha del ' + IntToStr( iYear) + '.');
        end
        else
        begin
          Result:= True;
        end;
      end;
    end;
    Close;
  end;
end;

procedure TFProformaFac.Limpiar;
begin
     //BORRAR CONTENIDO DE LA TABLAs
  LimpiarTemporales;

     //Cerrar todos ls datastes abiertos
  DMBaseDatos.DBBaseDatos.CloseDataSets;
end;

procedure TFProformaFac.ProcesoFacturacion;
begin

     //Rellenamos tabla temporal lineas
  if not RellenaTabla then
  begin
    Limpiar;
    Exit;
  end;

     //Separacion en facturas
  if not NumeraFacturas then
  begin
    Limpiar;
    Exit;
  end;

  if not CanFacturarFecha(txEmpresa.Text, deFechaFactura.Text, txSerie.Text) then
  begin
    Limpiar;
    Exit;
  end;

     //Comprobar que los clientes tienen las cuentas de venta/ingresos???
  if not ComprobarCuentas then
  begin
    Limpiar;
    Exit;
  end;
      //Rellenamos tabla temporal cabecera, gastos y Bases
  PreparaFacturacion(False);

  if not MostrarRejillaProforma then
  begin
    Limpiar;
    exit;
  end;

  if not RellenaFacturas then
  begin
    Limpiar;
    Exit;
  end;

  Previsualizar;

//La consulta tarda mucho
//  ComprobarRiesgoCliente( txEmpresa.Text, txCliente.Text );
end;

function TFProformaFac.EsClienteExtranjero(codEmp, codCliente: string): boolean;
begin
  with DFactura.QAux do
  begin
    SQL.Text := ' select pais_c from frf_clientes ' +
      ' where cliente_c=' + QuotedStr(codCliente);
    try
      try
        Open;
        if IsEmpty then esClienteExtranjero := false
        else esClienteExtranjero := (Fields[0].AsString <> 'ES') and (Fields[0].AsString <> '');
      except
        esClienteExtranjero := false;
      end;
    finally
      Cancel;
      Close;
    end;
  end;
end;

function TFProformaFac.RellenaTabla: boolean;
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
    SQL.Add(' SELECT  empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc, cliente_sal_sc, porte_bonny_sc,           ');
    SQL.Add('         dir_sum_sc, n_pedido_sc, fecha_pedido_sc, vehiculo_sc, moneda_sc, incoterm_sc, plaza_incoterm_sc, facturable_sc, ');
    SQL.Add('         emp_procedencia_sl, centro_origen_sl,                                                           ');
    SQL.Add('         producto_sl, envase_sl, categoria_sl, calibre_sl, marca_sl, unidades_caja_sl,                   ');
    SQL.Add('         unidad_precio_sl, precio_sl, tipo_iva_sl, porc_iva_sl, comercial_sl,                                          ');

    SQL.Add('         pais_fac_c, representante_c, frf_productos.descripcion_p, frf_productos.descripcion2_p,         ');

    SQL.Add('         descripcion_e, descripcion2_e, tipo_iva_e,                                                      ');

    SQL.Add('         SUM(cajas_sl) cajas_sl, SUM(kilos_sl) kilos_sl, SUM(n_palets_sl) palets_sl, SUM(importe_neto_sl) importe_neto_sl, sum(kilos_posei_sl) kilos_posei_sl   ');

    SQL.Add(', ' + QuotedStr(txEmpresa.text) + ' empresaFacturacion ');
    SQL.Add(', ' + QuotedStr(txEmpresa.text) + ' serieFacturacion ');
    SQL.Add(', ' + SQLDate(deFechaFactura.Text) + ' fechaFacturacion ');
    SQL.Add(', ' + QuotedStr(txCliente.Text) + ' clienteFacturacion ');

    SQL.Add('FROM frf_salidas_c, frf_salidas_l, frf_clientes, frf_productos, frf_envases ');

    SQL.Add('WHERE cliente_fac_sc = :cliente ');

    SQL.Add('AND n_factura_sc IS NULL ');
    SQL.Add('AND cliente_sal_sc <> "RET" ');
    SQL.Add('AND cliente_sal_sc <> "REA" ');
    SQL.Add('AND cliente_sal_sc <> "0BO" ');
    SQL.Add('AND cliente_sal_sc <> "EG" ');

    if Trim(txPedido.Text) <> '' then
      SQL.Add('AND n_pedido_sc = :pedido ')
    else
    begin
      SQL.Add('AND empresa_sc = :empresa ');
      SQL.Add('AND n_albaran_sc BETWEEN :albaranDesde AND :albaranHasta ');
      SQL.Add('AND fecha_sc <= :fecha ');
    end;


    SQL.Add('AND empresa_sl = empresa_sc ');
    SQL.Add('AND centro_salida_sl = centro_salida_sc ');
    SQL.Add('AND n_albaran_sl = n_albaran_sc ');
    SQL.Add('AND fecha_sl = fecha_sc ');

    SQL.Add('AND cliente_c = cliente_fac_sc ');

    SQL.Add('AND producto_p = producto_sl ');

    SQL.Add('AND envase_e = envase_sl ');
    SQL.Add('AND (producto_e = producto_p OR producto_e IS  NULL) ');

    SQL.Add('AND  (facturable_sc <> 0 ) ');        //Solo Albaranes Facturables  1- Facturas 2 - Abonos

    SQL.Add('GROUP BY empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc, cliente_sal_sc, porte_bonny_sc, tipo_iva_sl, ');
    SQL.Add('         dir_sum_sc, n_pedido_sc, fecha_pedido_sc, vehiculo_sc, moneda_sc, incoterm_sc, plaza_incoterm_sc, facturable_sc,');
    SQL.Add('         emp_procedencia_sl, centro_origen_sl, ');
    SQL.Add('       	producto_sl, envase_sl, categoria_sl, calibre_sl, marca_sl, color_sl, unidades_caja_sl, ');
    SQL.Add('       	unidad_precio_sl, precio_sl, porc_iva_sl, comercial_sl, pais_fac_c, representante_c, ');
    SQL.Add('       	frf_productos.descripcion_p, frf_productos.descripcion2_p, ');
    SQL.Add('       	descripcion_e, descripcion2_e, tipo_iva_e ');
    SQL.Add('ORDER BY  facturable_sc, fecha_sc, tipo_iva_sl, dir_sum_sc, n_pedido_sc,  n_albaran_sc, producto_sl, envase_sl ');



         //PARAMETROS
    ParamByName('Cliente').AsString := txCliente.Text;
    if Trim(txPedido.Text) <> '' then
      ParamByName('pedido').AsString := txPedido.Text
    else
    begin
      ParamByName('empresa').AsString := txEmpresa.Text;
      ParamByName('albaranDesde').AsString := txDesdeAlbaran.Text;
      ParamByName('albaranHasta').AsString := txHastaAlbaran.Text;
      ParamByName('fecha').AsDate := StrToDate(deFechaFacturar.Text);
    end;

    try
      Open;
      if isEmpty then
      begin
        Advertir('No existen albaranes por facturar que cumplan el criterio seleccionado.');
        Result := false;
        Exit;
      end;
    except
      Result := false;
      Exit;
    end;

    //Rellenamos tabla en memoria - Lineas facturas mtFacturas_Det
    RellenaMemLineasFacturas(False);

  Result := True;
  end;
end;

function TFProformaFac.NumeraFacturas: boolean;
var
  bFacturar: boolean;
  sCliente, sPedido, sAlbaran, sDirSuministro: string;
  sMoneda, sImpuesto: string;
  sIncoterm, sPlazaIncoterm: string;
  iFacturable, contador, iNumLinea: integer;
  rSumLineas: Real;
begin
    bFacturar := true;

  with DFactura.mtFacturas_Det do
  begin
    if RecordCount = 0 then
    begin
      ShowError('No hay facturas a calcular para los datos introducidos');
      Result := false;
      Exit;
    end;

    contador := 1;
    iNumLinea := 1;
    Sort([]);
    First;
    while not Eof do
    begin
      case FacturarPor(FieldByName('cod_empresa_fac_fd').AsString, FieldByName('cod_cliente_fac_fd').AsString) of
        0:
          begin
                    //UNA FACTURA PARA TODOS LOS ALBARANES PENDIENTES
            bFacturar := true;
            sCliente := FieldByName('cod_cliente_fac_fd').AsString;
            sMoneda := FieldByName('moneda_fd').AsString;
            sImpuesto := FieldByName('tipo_iva_fd').AsString;
            sIncoterm := FieldByName('incoterm_fd').AsString;
            sPlazaIncoterm := FieldByName('plaza_incoterm_fd').AsString;
            iFacturable := FieldByName('facturable_fd').AsInteger;
            repeat
              if bFacturar then
              begin
                if (sMoneda <> FieldByName('moneda_fd').AsString) and
                  (sCliente = FieldByName('cod_cliente_fac_fd').AsString) then
                begin
                  bFacturar := false;
                  showerror('No se puede facturar al cliente "' +
                    FieldByName('cod_cliente_fac_fd').AsString +
                    '" por tener albaranes en distintas monedas.');
                end
                else
                begin
                  edit;
                  FieldByName('fac_interno_fd').AsInteger := contador;
                  FieldByName('num_linea_fd').AsInteger := iNumLinea;
                  inc(iNumLinea);
                  post;
                end;
              end;
              Next;
            until (sCliente <> FieldByName('cod_cliente_fac_fd').AsString) or
              (sImpuesto <> FieldByName('tipo_iva_fd').AsString) or
              (sIncoterm <> FieldByName('incoterm_fd').AsString) or
              (sPlazaIncoterm <> FieldByName('plaza_incoterm_fd').AsString) or
              (iFacturable <> FieldByName('facturable_fd').AsInteger) or
              EOF;
          end;
        1:
          begin
                    //OTROS UNA FACTURA POR ALBARAN
            sCliente := FieldByName('cod_cliente_fac_fd').AsString;
            sPedido := FieldByName('pedido_fd').AsString;

            sAlbaran := FieldByName('n_albaran_fd').AsString;
            repeat
              edit;
              FieldByName('fac_interno_fd').AsInteger := contador;
              FieldByName('num_linea_fd').AsInteger := iNumLinea;
              inc(iNumLinea);
//                FieldByName('cod_empresa_fac_fd').AsString := FieldByName('cod_empresa_albaran_fd').AsString;
              post;
              Next;
            until (sCliente <> FieldByName('cod_cliente_fac_fd').AsString) or
              (sPedido <> FieldByName('pedido_fd').AsString) or
              (sAlbaran <> FieldByName('n_albaran_fd').AsString) or EOF;
          end;
        2:
          begin
                    //UNA FACTURA PARA TODOS LOS ALBARANES PENDIENTES  de la misma DIRECCION SUMINISTRO
                    //POR DIRECCION SUMINISTRO
            bFacturar := true;
            sCliente := FieldByName('cod_cliente_fac_fd').AsString;
            sDirSuministro := FieldByName('cod_dir_sum_fd').AsString;
            sMoneda := FieldByName('moneda_fd').AsString;
            sImpuesto := FieldByName('tipo_iva_fd').AsString;
            sIncoterm := FieldByName('incoterm_fd').AsString;
            sPlazaIncoterm := FieldByName('plaza_incoterm_fd').AsString;
            iFacturable := FieldByName('facturable_fd').AsInteger;
            repeat
              if bFacturar then
              begin
                if (sMoneda <> FieldByName('moneda_fd').AsString) and
                  (sCliente = FieldByName('cod_cliente_fac_fd').AsString) then
                begin
                  bFacturar := false;
                  showerror('No se puede facturar al cliente "' +
                    FieldByName('cod_cliente_fac_fd').AsString +
                    '" por tener albaranes en distintas monedas.');
                end
                else
                begin
                  edit;
                  FieldByName('fac_interno_fd').AsInteger := contador;
                  FieldByName('num_linea_fd').AsInteger := iNumLinea;
                  inc(iNumLinea);
                  rSumLineas := rSumLineas + FieldByName('importe_total_fd').AsFloat;
                  post;
                end;
              end;
              Next;
            until (sCliente <> FieldByName('cod_cliente_fac_fd').AsString) or
              (sDirSuministro <> FieldByName('cod_dir_sum_fd').AsString) or
              (sImpuesto <> FieldByName('tipo_iva_fd').AsString) or
              (sIncoterm <> FieldByName('incoterm_fd').AsString) or
              (sPlazaIncoterm <> FieldByName('plaza_incoterm_fd').AsString) or
              (iFacturable <> FieldByName('facturable_fd').AsInteger) or
              EOF;
          end;
        3:
          begin
                //OTROS UNA FACTURA POR PEDIDO
                //POR PEDIDO, VEHICULO O AMBOS
            bFacturar := true;
            sCliente := FieldByName('cod_cliente_fac_fd').AsString;
            sMoneda := FieldByName('moneda_fd').AsString;
            sImpuesto := FieldByName('tipo_iva_fd').AsString;
            sPedido := FieldByName('pedido_fd').AsString;
            sIncoterm := FieldByName('incoterm_fd').AsString;
            sPlazaIncoterm := FieldByName('plaza_incoterm_fd').AsString;
            repeat
              if bFacturar then
              begin
                if (sMoneda <> FieldByName('moneda_fd').AsString) and
                   (sCliente = FieldByName('cod_cliente_fac_fd').AsString) then
                begin
                  bFacturar := false;
                  showerror('No se puede facturar al cliente "' +
                    FieldByName('cod_cliente_fac_fd').AsString +
                    '" por tener albaranes en distintas monedas.');
                end
                else
                begin
                  edit;
                  FieldByName('fac_interno_fd').AsInteger := contador;
                  FieldByName('num_linea_fd').AsInteger := iNumLinea;
                  inc(iNumLinea);
//                  FieldByName('cod_empresa_fac_fd').AsString := empresa.Text;
                  post;
                end;
              end;
              Next;
            until (sCliente <> FieldByName('cod_cliente_fac_fd').AsString) or
              (sPedido <> FieldByName('pedido_fd').AsString) or
              (sImpuesto <> FieldByName('tipo_iva_fd').AsString) or
              (sIncoterm <> FieldByName('incoterm_fd').AsString) or
              (sPlazaIncoterm <> FieldByName('plaza_incoterm_fd').AsString) or
              EOF;
          end;
      end;
      contador := contador + 1;
      iNumLinea := 1;
    end;

  end;
  result := bFacturar;
end;

function TFProformaFac.CanFacturarFecha(AEmpresa, ADate, ASerie: string): Boolean;
  var
  iYear, iMonth, iDay: Word;
begin
  Result := true;
  DecodeDate( StrToDateDef(ADate, Date), iYear, iMonth, iDay );
  with DFactura.mtFacturas_Det do
  begin
    First;
    while not Eof do
    begin
     (*FACTA�OS*)
     //IVA
      if Copy(FieldByName('tipo_iva_fd').AsString, 1, 1) = 'I' then
      begin
        DFactura.QAux.SQL.Clear;
        DFactura.QAux.SQL.Add(' SELECT fecha_fac_iva_fs, serie_cerrada_fs ' +
            ' FROM frf_facturas_serie ' +
            '    join frf_empresas_serie on cod_serie_es = cod_serie_fs and anyo_es = anyo_fs ' +
            ' WHERE cod_empresa_es = :empresa ' +
            ' and anyo_es = :anyo ' +
            ' and cod_serie_es = :serie ');
        DFactura.QAux.ParamByName('empresa').AsString := AEmpresa;
        DFactura.QAux.ParamByName('anyo').AsInteger := iYear;
        DFactura.QAux.ParamByName('serie').AsString := ASerie;
        DFactura.QAux.Open;

        if DFactura.QAux.FieldByName('serie_cerrada_fs').AsInteger = 1 then
        begin
          ShowError('La serie de facturaci�n del a�o ' + IntToStr( iYear ) + ' ya esta cerrada.');
          DFactura.QAux.Close;
          Result := false;
          break;
        end;


        if DFactura.QAux.FieldByName('fecha_fac_iva_fs').AsDateTime >
          StrToDate(ADate) then
        begin
          ShowError('La fecha de facturaci�n es incorrecta para la serie de IVA.');
          DFactura.QAux.Close;
          Result := false;
          break;
        end;
      end
      else
        if Copy(FieldByName('tipo_iva_fd').AsString, 1, 1) = 'G' then
        begin
          DFactura.QAux.SQL.Clear;
          DFactura.QAux.SQL.Add(' SELECT fecha_fac_igic_fs, serie_cerrada_fs ' +
            ' FROM frf_facturas_serie ' +
            '    join frf_empresas_serie on cod_serie_es = cod_serie_fs and anyo_es = anyo_fs ' +
            ' WHERE cod_empresa_es = :empresa ' +
            ' and anyo_es = :anyo ' +
            ' and cod_serie_es = :serie ');
          DFactura.QAux.ParamByName('empresa').AsString := Aempresa;
          DFactura.QAux.ParamByName('anyo').AsInteger := iYear;
          DFactura.QAux.ParamByName('serie').AsString := ASerie;
          DFactura.QAux.Open;

          if DFactura.QAux.FieldByName('serie_cerrada_fs').AsInteger = 1 then
          begin
            ShowError('La serie de facturaci�n del a�o ' + IntToStr( iYear ) + ' ya esta cerrada.');
            DFactura.QAux.Close;
            Result := false;
            break;
          end;

          if DFactura.QAux.FieldByName('fecha_fac_igic_fs').AsDateTime >
            StrToDate(ADate) then
          begin
            ShowError('La fecha de facturaci�n es incorrecta para la serie de IGIC.');
            DFactura.QAux.Close;
            Result := false;
            break;
          end;
        end;
    Next;
    end;
  end;
end;

function TFProformaFac.ComprobarCuentas: Boolean;
var
  aux, sEmpresa, sCliente: string;
  bCliente : Boolean;
begin
  sEmpresa := txEmpresa.Text;
  sCliente := txCliente.Text;
  bCliente := true;
  with DFactura.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add(' select cliente_c, cta_cliente_c, cta_ingresos_pgc_c ');
    SQL.Add('  from frf_clientes ');
    SQL.Add(' where cliente_c = :cliente ');
    ParamByName('cliente').AsString := sCliente;
    Open;

    if (FieldByName('cta_cliente_c').AsString = '') or
       (FieldByName('cta_ingresos_pgc_c').AsString = '') then
    begin
      aux := '';
      if (fieldbyname('cta_cliente_c').AsString = '') then
      begin
        aux := aux + '  * Falta la cuenta del cliente. ' + #13 + #10;
      end;

      if (fieldbyname('cta_ingresos_pgc_c').AsString = '') then
      begin
        aux := aux + '  * Falta la cuenta de ingresos del cliente. ' + #13 + #10;
      end;

      Advertir(' No se puede facturar al cliente "' +
        fieldbyname('cliente_c').AsString +
        '"' + #13 + #10 + aux +
        ' CONSULTE CON EL DEPARTAMENTO DE CONTABILIDAD.');
      bCliente := false;
    end;
  end;

  result := bCliente;
end;

function TFProformaFac.MostrarRejillaProforma: boolean;
begin
  Result := false;

  if not DFactura.mtFacturas_Cab.IsEmpty then
  begin
    FRejillaProforma:= TFRejillaProforma.Create( self );
    try
      FRejillaProforma.txEmpresa.Text := txEmpresa.Text;
      FRejillaProforma.txDesempresa.Text := DesEmpresa(txEmpresa.Text);
      FRejillaProforma.txCliente.Text := txCliente.Text;
      FRejillaProforma.txDesCliente.Text := desCliente(txCliente.Text);
      FRejillaProforma.txFechaFactura.Text := deFechaFactura.Text;
      if rgTipo.Properties.Items[rgTipo.ItemIndex].Value = 'F' then
      begin
        FRejillaProforma.txDesdeAlbaran.Text := txDesdeAlbaran.Text;
        FRejillaProforma.txHastaAlbaran.Text := txHastaAlbaran.Text;
        FRejillaProforma.txFechaFacturar.Text := deFechaFacturar.Text;

        FRejillaProforma.lb13.Visible := false;
        FRejillaProforma.txPedido.Visible := false;
      end
      else
      begin
        FRejillaProforma.lb13.Left := 439;
        FRejillaProforma.lb13.Top := 24;
        FRejillaProforma.txPedido.Left := 540;
        FRejillaProforma.txPedido.Top := 22;
        FRejillaProforma.txPedido.Text := txPedido.Text;

        FRejillaProforma.lb10.Visible := false;
        FRejillaProforma.lb11.Visible := false;
        FRejillaProforma.lb12.Visible := false;
        FRejillaProforma.txDesdeAlbaran.Visible := false;
        FRejillaProforma.txHastaAlbaran.Visible := false;
        FRejillaProforma.txFechaFacturar.Visible := false;
      end;

      FRejillaProforma.ShowModal;

    finally
      result := (FRejillaProforma.ModalResult = mrOk);
      FreeAndNil(FRejillaProforma );
    end;
  end;
end;

function TFProformaFac.Rellenafacturas: boolean;
var  iFacturaNumero, iFacturas, iInsertadas: Integer;
     sClaveFactura: string;
begin

  //iFacturaNumero := -1;
  iInsertadas := 0;
  iFacturas := DFactura.mtFacturas_Cab.Recordcount;

        //Recorrer tablas y actualizar datos
  DFactura.mtFacturas_Cab.First;
  while not DFactura.mtFacturas_Cab.Eof do
  begin
              //Actualiza contador y fecha facturas de empresa
    iFacturaNumero := DFactura.mtFacturas_Cab.FieldByName('fac_interno_fc').AsInteger;

    sClaveFactura := 'PROFORMA' + IntToStr(iFacturaNumero);

              //Recorremos Cabecera de Factura (mtFacturas_Cab) y Asignamos ClaveFactura
    AsignaFacturaTempCab(sClaveFactura, iFacturaNumero);

              //Recorremos Lineas de Factura (mtFacturas_Det) y Asignamos ClaveFactura
    AsignaFacturaTempDet(sClaveFactura);

              //Recorremos Gastos de Factura (mtFacturas_Gas)) y Asignamos ClaveFactura
    AsignaFacturaTempGas(sClaveFactura);

              //Recorremos Bases de Factura (mtFacturas_Bas)) y Asignamos ClaveFactura
    AsignaFacturaTempBas(sClaveFactura);

    DFactura.mtFacturas_Cab.Next;

    Inc(iInsertadas);
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
      ShowError('No se ha podido realizar la operaci�n completa.' +
        ' Se han insertado ' + IntToStr(iInsertadas) + ' facturas de ' +
        IntToStr(iFacturas) + ' posibles.');
      RellenaFacturas := false;
      Exit;
    end;
  end;

  RellenaFacturas := true;

end;

procedure TFProformaFac.Previsualizar;
begin

  OrdenaMemFacturas;

  DConfigMail.sAsunto:= AsuntoFactura;
  DConfigMail.sEmpresaConfig:= txEmpresa.Text;
  DConfigMail.sClienteConfig:= txCliente.Text;

  RFactura := TRFactura.Create(Application);
{ TODO : Creo que se puede quitar la asignacion de labelfecha. Mirar }
  RFactura.LabelFecha.Caption := deFechaFactura.Text;
  RFactura.definitivo := false;
  RFactura.bProforma := true;

  RFactura.Configurar(txEmpresa.Text, txCliente.Text);
  RFactura.printOriginal := false;
  RFactura.printEmpresa := false;

  DPreview.bCanSend := (DMConfig.EsLaFont);
  RFactura.Tag:= 3;
  Preview(RFactura, 1, False, True);

end;


function TFProformaFac.HaySeleccion: Boolean;
begin
  Result := true;
  with DFactura.QAux do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add(' SELECT count(*) registros');
    SQL.Add('   FROM frf_salidas_c ');
    SQL.Add('  WHERE cliente_fac_sc = :cliente ');

    SQL.Add('    AND n_factura_sc IS NULL ');
    SQL.Add('    AND cliente_sal_sc <> "RET" ');
    SQL.Add('    AND cliente_sal_sc <> "REA" ');
    SQL.Add('    AND cliente_sal_sc <> "0BO" ');
    SQL.Add('    AND cliente_sal_sc <> "EG" ');

    SQL.Add('    AND  (facturable_sc = 1 ) ');        //Solo Albaranes Facturables

    if Trim(txPedido.Text) <> '' then
      SQL.Add('  AND n_pedido_sc = :pedido ')
    else
    begin
      SQL.Add('  AND empresa_sc = :empresa ');
      SQL.Add('  AND n_albaran_sc BETWEEN :albaranDesde AND :albaranHasta ');
      SQL.Add('  AND fecha_sc <= :fecha ');
    end;

    ParamByName('Cliente').AsString := txCliente.Text;
    if Trim(txPedido.Text) <> '' then
      ParamByName('pedido').AsString := txPedido.Text
    else
    begin
      ParamByName('empresa').AsString := txEmpresa.Text;
      ParamByName('albaranDesde').AsString := txDesdeAlbaran.Text;
      ParamByName('albaranHasta').AsString := txHastaAlbaran.Text;
      ParamByName('fecha').AsDate := StrToDate(deFechaFacturar.Text);
    end;

    Open;
    try
      if FieldByName('registros').AsInteger = 0 then
      begin
        Advertir('No existen albaranes por facturar que cumplan el criterio seleccionado.');
        Result := false;
        Exit;
      end;
    finally
      Close;
    end;
  end;
end;

function TFProformaFac.FacturarPor(const empresa, cliente: string): integer;
begin
  //0 Facturar todos los albaranes pendientes
  //1 Un albaran una factura
  //2 Agrupacion albaranes por dir. suministro
  //3 Un pedido una factura
  if Trim(txPedido.Text) <> '' then
  begin
    result := 3;
  end
  else
  begin
    DFactura.QTemp.SQL.Clear;
    DFactura.QTemp.SQL.Add(' select NVL( albaran_factura_c, 0 ) ');
    DFactura.QTemp.SQL.Add(' from frf_clientes ');
    DFactura.QTemp.SQL.Add(' where cliente_c ' + SQLEqualS(cliente));
    DFactura.QTemp.Open;
    if DFactura.QTemp.Fields[0].AsInteger = 0 then
      result := 0
    else if DFactura.QTemp.Fields[0].AsInteger = 1 then
      result := 1
    else
      result := 2;
    DFactura.QTemp.Close;
  end;
end;


procedure TFProformaFac.AsignaFacturaTempDet(ClaveFactura: string);
begin
       //Recorremos Lineas de Factura
  with DFactura.mtFacturas_Det do
  begin
    Filter := ' fac_interno_fd = ' + QuotedStr(DFactura.mtFacturas_Cab.FieldByName('fac_interno_fc').AsString);
    Filtered := True;

    First;
    while not Eof do
    begin
      Edit;
      FieldByName('cod_factura_fd').AsString := ClaveFactura;

      Post;

      Next;
    end;
    Filter := '';
    Filtered := False;
  end;
end;

procedure TFProformaFac.AsignaFacturaTempGas(ClaveFactura: string);
begin
       //Recorremos Gastos de Factura
  with DFactura.mtFacturas_Gas do
  begin
    Filter := ' fac_interno_fg = ' + QuotedStr(DFactura.mtFacturas_Cab.FieldByName('fac_interno_fc').AsString);
    // A�adir empresa y fecha factura!!!!
    Filtered := True;

    First;
    while not Eof do
    begin
      Edit;
      FieldByName('cod_factura_fg').AsString := ClaveFactura;

      Post;

      Next;
    end;
    Filter := '';
    Filtered := False;
  end;
end;

function TFProformaFac.AsuntoFactura: string;
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

procedure TFProformaFac.FormActivate(Sender: TObject);
begin
//  Top := 1;
end;

procedure TFProformaFac.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  Limpiar;

  BEMensajes('');
  Action := caFree;
end;

procedure TFProformaFac.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  txEmpresa.Tag := kEmpresa;
  txCliente.Tag := kCliente;
  deFechaFacturar.Tag := kCalendar;
  deFechaFactura.Tag := kCalendar;

  txDesEmpresa.Text := '';
end;

procedure TFProformaFac.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFProformaFac.FormShow(Sender: TObject);
begin
  RellenarDatosIni;
end;

procedure TFProformaFac.RellenarDatosIni;
begin
   //Rellenamos datos iniciales
  txEmpresa.Text := gsDefEmpresa;
  txCliente.Text := '';
  txSerie.Text := gsDefEmpresa;
//  txCliente.Text := gsDefCliente;
  txDesdeAlbaran.Text := '1';
  txHastaAlbaran.Text := '999999';
  deFechaFacturar.Text := DateToStr(Date);
  deFechaFactura.Text := DateToStr(Date);
  rgTipo.ItemIndex := 0;
  txPedido.Enabled := false;
  txPedido.Text := '';

  txEmpresa.SetFocus;
end;


procedure TFProformaFac.AsignaFacturaTempCab(ClaveFactura: string; FacturaNumero: integer);
begin
        //Actualizamos Cabecera (mtFacturas_Cab)
  DFactura.mtFacturas_Cab.Edit;
  DFactura.mtFacturas_Cab.FieldByName('cod_factura_fc').AsString := ClaveFactura;
  DFactura.mtFacturas_Cab.FieldByName('n_factura_fc').AsInteger := FacturaNumero;
  DFactura.mtFacturas_Cab.Post;
end;

procedure TFProformaFac.OrdenaMemFacturas;
begin
  DFactura.mtFacturas_Gas.SortOn('cod_factura_fg;fecha_albaran_fg;n_albaran_fg;cod_tipo_gasto_fg', []);
  DFactura.mtFacturas_Det.SortOn('cod_factura_fd;fecha_albaran_fd;cod_dir_sum_fd;pedido_fd;n_albaran_fd;cod_dir_sum_fd;cod_producto_fd;cod_envase_fd', []);
  DFactura.mtFacturas_Cab.sortOn('cod_factura_fc', []);
end;

procedure TFProformaFac.rgTipoFactura1PropertiesChange(
  Sender: TObject);
begin
  if rgTipo.Properties.Items[rgTipo.ItemIndex].Value = 'F' then
  begin
    txPedido.Text := '';
    txPedido.Enabled := False;

    txDesdeAlbaran.Enabled := True;
    txHastaAlbaran.Enabled := True;
    deFechafacturar.Enabled := True;

    txDesdeAlbaran.SetFocus;
  end
  else
  begin
    txPedido.Enabled := true;

    txDesdeAlbaran.Text := '1';
    txHastaAlbaran.Text := '999999';
    deFechaFacturar.Text := DateToStr(Date);

    txDesdeAlbaran.Enabled := False;
    txHastaAlbaran.Enabled := False;
    deFechafacturar.Enabled := False;

    txPedido.SetFocus;
  end;
end;

procedure TFProformaFac.ssSerieAntesEjecutar(Sender: TObject);
begin
    ssSerie.SQLAdi := '';
    ssSerie.SQLAdi := ' anyo_es >= year(today) -1 ';
    if txEmpresa.Text <> '' then
      ssSerie.SQLAdi := ssSerie.SQLAdi + ' and cod_empresa_es = ' +  QuotedStr(txEmpresa.Text);
end;

procedure TFProformaFac.txClientePropertiesChange(Sender: TObject);
begin
  txDesCliente.Text := desCliente(txCliente.Text);
end;

procedure TFProformaFac.AsignaFacturaTempBas(ClaveFactura: string);
begin
       //Recorremos Bases de Factura
  with DFactura.mtFacturas_Bas do
  begin
    Filter := ' fac_interno_fb = ' + QuotedStr(DFactura.mtFacturas_Cab.FieldByName('fac_interno_fc').AsString);
    // A�adir empresa y fecha factura!!!!
    Filtered := True;

    First;
    while not Eof do
    begin
      Edit;
      FieldByName('cod_factura_fb').AsString := ClaveFactura;

      Post;

      Next;
    end;
    Filter := '';
    Filtered := False;
  end;
end;

procedure TFProformaFac.ACancelarExecute(Sender: TObject);
begin
  btCancelar.Click;
end;

procedure TFProformaFac.AAceptarExecute(Sender: TObject);
begin
  btAceptar.Click;
end;

end.


