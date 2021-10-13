unit UFFacturacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin,
  dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, StdCtrls, cxButtons,
  BonnyQuery, DB, Grids, DBGrids, cxControls, cxContainer, cxEdit,
  cxCheckBox, cxLabel, cxTextEdit, cxMemo, cxGroupBox, SimpleSearch,
  cxListBox, cxMaskEdit, cxDropDownEdit;

type

  TRImportes = record
    sCodFactura, sEmpresa, sFecha, sNumero: String;
    iTasaImpuesto, iCajas, iUnidades: Integer;
    rPorcentajeImpuesto, rKilos, rImporteNeto, rImporteImpuesto, rImporteTotal: Real;
  end;

  TRImpBases = record
    aRImportes: array of TRImportes;
  end;

  TFFacturacion = class(TForm)
    mmxEmpresa: TcxMemo;
    gbCabecera: TcxGroupBox;
    btFacturacion: TcxButton;
    gb1: TcxGroupBox;
    mmxErrores: TcxMemo;
    mmxFacturas: TcxMemo;
    btIniciar: TcxButton;
    cxLabel4: TcxLabel;
    txGrupo: TcxTextEdit;
    txDesGrupo: TcxTextEdit;
    gb2: TcxGroupBox;
    cxLabel1: TcxLabel;
    txEmpresa: TcxTextEdit;
    cxLabel2: TcxLabel;
    txAno: TcxTextEdit;
    cbEmpresa: TcxCheckBox;
    txDesEmpresa: TcxTextEdit;
    cxLabel3: TcxLabel;
    txFactura: TcxTextEdit;
    cbxBox: TcxComboBox;
    ssGrupo: TSimpleSearch;
    ssEmpresa: TSimpleSearch;
    cxLabel5: TcxLabel;
    txFecha: TcxTextEdit;
    gb3: TcxGroupBox;
    lb1: TcxLabel;
    txFechaDesde: TcxTextEdit;
    cbFechas: TcxCheckBox;
    lb2: TcxLabel;
    txFechaHasta: TcxTextEdit;
    procedure btFacturacionClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbEmpresaClick(Sender: TObject);
    procedure ssEmpresaOldClick(Sender: TObject);
    procedure txEmpresaPropertiesChange(Sender: TObject);
    procedure btIniciarClick(Sender: TObject);
    procedure ssGrupoAntesEjecutar(Sender: TObject);
    procedure txGrupoPropertiesChange(Sender: TObject);
    procedure ssEmpresaOldAntesEjecutar(Sender: TObject);
    procedure txGrupoExit(Sender: TObject);
    procedure cbxBoxPropertiesChange(Sender: TObject);
    procedure ssEmpresaAntesEjecutar(Sender: TObject);
    procedure cbFechasClick(Sender: TObject);
  private
    QEmpresa, QSeleccion, QNota, QInsError, QDatosAlbaran,
    QFactManual, QAnulacion, QFactura, QExisteEmpresa: TBonnyQuery;
    slErrores: TStringList;
    sRuta, sErrores, sMensaje: String;

    procedure AbrirBD;
    procedure CrearBuffers;
    procedure LimpiarBuffers;
    procedure BorrarListas;
    procedure CerrarTablas;
    procedure RellenarDatosIni;
    function Parametros: Boolean;
    procedure GrabarError(sCodigo, sMensaje: String);
    procedure GrabarFichero(ARuta: String);
    procedure GrabarTabla(sCodFactura, sCodigo, sMensaje: String);
    function ObtenerRuta: String;
    procedure CreaQEmpresa;
    procedure CreaQSeleccion;
    procedure CreaQNota;
    procedure CreaQInsError;
    procedure CreaQDatosAlbaran;
    procedure CreaQFactManual;
    procedure CreaQAnulacion;
    procedure CreaQFactura;
    procedure CreaQExisteEmpresa;
    function EjecutaQEmpresa: Boolean;
    function EjecutaQSeleccion: Boolean;
    procedure ProcFacturacion;
    procedure FactManual;
    procedure FactAnulada;
    function LineasFacturaManual: Boolean;
    procedure FactAutomatica;
    function LineasFactura: boolean;
    function CabeceraFactura: boolean;
    procedure NotaFactura;
    function GetNotaFactura: String;
    function GetNotaFacturaAux: String;
    function GastosFactura: Boolean;
    procedure CalculoImportesTotales;
    procedure ObtenerAnulacion;
    procedure ObtenerFactura;
    function ExisteEmpresa: boolean;

    procedure RellenaMemLineasFacturas;
    procedure RellenaMemCabeceraFacturas;
    procedure RellenaMemGastosFacturas;
    procedure RellenaMemBaseFacturas(ARImpBases: TRImpBases);
    procedure RellenaMemLineasFacturasManual;
    procedure RellenaDesdeLineas;
    procedure RellenaDesdeFactura;

    function InsertaFacturaCabecera: boolean;
    function InsertaFacturaDetalle(bFactura: boolean): Boolean;
    function InsertaFacturaGastos: boolean;
    function InsertaFacturaBase: boolean;


  public
    { Public declarations }
  end;

var
  FFacturacion: TFFacturacion;

implementation

uses UDFactura, CFactura, bMath, bSQLUtils;


{$R *.dfm}

procedure TFFacturacion.btFacturacionClick(Sender: TObject);
begin
  if not Parametros then exit;

  CreaQEmpresa;
  CreaQSeleccion;
  ProcFacturacion;
end;

procedure TFFacturacion.AbrirBD;
begin
  if DFactura.DataBase.Connected then
    DFactura.DataBase.Close;

  if txGrupo.Text = 'BAG' then
  begin
    DFactura.DataBase.Params.Values['DATABASE NAME'] := 'comerbag';
  end
  else
  begin
    DFactura.DataBase.Params.Values['DATABASE NAME'] := 'comersat';
  end;

  if cbxBox.ItemIndex = 0 then
    DFactura.DataBase.Params.Values['SERVER NAME'] := 'server3'
  else
    DFactura.DataBase.Params.Values['SERVER NAME'] := 'iserver1';

  DFactura.DataBase.Open;
end;
procedure TFFacturacion.CrearBuffers;
begin
  slErrores := TStringList.Create;
end;

procedure TFFacturacion.LimpiarBuffers;
begin
  slErrores.Clear;
end;

procedure TFFacturacion.BorrarListas;
begin
  FreeAndNil(slErrores);
end;

procedure TFFacturacion.CerrarTablas;
begin
  DFactura.mtFacturas_Cab.Close;
  DFactura.mtFacturas_Det.Close;
  DFactura.mtFacturas_Gas.Close;
  DFactura.mtFacturas_Bas.Close;
end;

procedure TFFacturacion.RellenarDatosIni;
begin
  mmxEmpresa.Clear;
  mmxFacturas.Clear;
  mmxErrores.Clear;
  cbEmpresa.Checked := false;
  txEmpresa.Text := '';
  txAno.Text := '';
  txFactura.Text := '';
  txFecha.Text := '';
  cbFechas.Checked := false;
  txFechaDesde.Text := '';
  txFechaHasta.Text := '';
end;

function TFFacturacion.Parametros: boolean;
begin
  Result := true;

  if cbEmpresa.Checked then
  begin
    if (txEmpresa.Text = '') and
       (txAno.Text = '') and
       (txFactura.Text = '') and
       (txFecha.Text = '') then
    begin
      ShowMessage('Debe seleccionar al menos, uno de los campos Empresa / Año / Factura / Fecha.');
      result := false;
      exit;
    end;
  end;
  if cbFechas.Checked then
  begin
    if (txFechaDesde.Text = '') or (txFechaHasta.Text = '') then
    begin
      ShowMessage('Los campos Fecha Desde y Fecha Hasta deben contener valor.');
      result := false;
      exit;
    end;
  end;
end;

procedure TFFacturacion.GrabarError(sCodigo, sMensaje: String);
var sAux: String;
begin
  sAux := QSeleccion.FieldByName('empresa_f').AsString + ' ' +
          QSeleccion.FieldByName('n_factura_f').AsString + ' ' +
          QSeleccion.FieldByName('fecha_factura_f').AsString + ' ' +
          'Error al generar la factura ' + QSeleccion.FieldBYName('n_factura_f').AsString + ' del ' +
          QSeleccion.FieldByName('fecha_factura_f').AsString + '.';
  slErrores.Add( sAux + #13 + #10 + sCodigo + ' - ' + sMensaje);
  mmxErrores.Lines.Add(sAux + #13 + #10 + sCodigo + ' - ' + sMensaje);
  mmxErrores.Lines.Add('');

  GrabarFichero(sRuta);
  GrabarTabla( NewCodigoFactura(QSeleccion.Fieldbyname('empresa_f').AsString,
                                QSeleccion.FieldByName('tipo_factura_f').AsString,
                                Copy(QSeleccion.FieldByName('tipo_impuesto_f').AsString,1,1),
                                QSeleccion.FieldByName('fecha_factura_f').AsDateTime,
                                QSeleccion.FieldByName('n_factura_f').AsInteger ),
                                sCodigo, sMensaje);
end;

procedure TFFacturacion.GrabarFichero(ARuta: string);
begin
  if slErrores.Count > 0 then
    slErrores.SaveToFile(ARuta + sErrores);
end;

procedure TFFacturacion.GrabarTabla(sCodFactura, sCodigo, sMensaje: String);
begin
  with QInsError do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := sCodFactura;
    ParamByName('codigo').AsString := sCodigo;
    ParamByName('observacion').AsString := sMensaje;

    ExecSQL;
  end;
end;

function TFFacturacion.ObtenerRuta: String;
var QDirectorio: TBonnyQuery;
    sDir: String;
begin
{
  QDirectorio := TBonnyQuery.Create(Self);

  with QDirectorio do
  try
    SQL.Add(' select directorio_cd from cnf_directorios ');
    SQL.Add('  where usuario_cd = ''all'' ');
    SQL.Add('    and codigo_cd = ''conta_facturas'' ');

    Open;
    sDir:= fieldbyname('directorio_cd').AsString;
  finally
    free;
  end;

  if Copy( sDir, Length( sDir ), 1 ) <> '\' then
    sDir := sDir + '\';
}
  sDir := 'C:\Users\Propietario\Documents\Contabilidad\Datos\';
  result := sDir;
end;

procedure TFFacturacion.CreaQEmpresa;
begin
  QEmpresa := TBonnyQuery.Create(Self);
  with QEmpresa do
  begin
    SQL.Add(' select distinct empresa_f, year(fecha_factura_f) ano_f ');
    SQL.Add('   from frf_facturas ');
    SQL.Add('  where 1=1 ');
    if cbEmpresa.Checked then
    begin
      if txEmpresa.Text <> '' then
        SQL.Add('   and empresa_f = :empresa ');
      if txAno.Text <> '' then
        SQL.Add('   and year(fecha_factura_f) = :ano ');
    end;
    if cbFechas.Checked then
      SQL.Add(' and fecha_factura_f between :fecha1 and :fecha2 ');

    SQL.Add('  order by empresa_f, ano_f ');
  end;

end;

procedure TFFacturacion.CreaQSeleccion;
begin
  QSeleccion := TBonnyQuery.Create(Self);
  with QSeleccion do
  begin
    SQL.Add(' select * from frf_facturas');
    SQL.Add(' where year(fecha_factura_f) = :anyo ');
    SQL.Add('   and empresa_f = :empresa ');
    if txFactura.Text <> '' then
      SQL.Add(' and n_factura_f = :factura ');
    if txFecha.Text <> '' then
      SQL.Add(' and fecha_factura_f = :fecha ');
    if cbFechas.Checked then
      SQL.Add(' and fecha_factura_f between :fecha1 and :fecha2 ');

    SQL.Add(' order by empresa_f, n_factura_f, fecha_factura_f ');


    Prepare;
  end;
end;

procedure TFFacturacion.CreaQNota;
begin
  QNota := TBonnyQuery.Create(Self);
  with QNota do
  begin
    SQL.Clear;
    SQL.Add(' select nota_factura_sc ');
    SQL.Add(' from frf_salidas_c ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add('   and centro_salida_sc = :centro ');
    SQL.Add('   and n_albaran_sc = :albaran ');
    SQL.Add('   and fecha_sc = :fecha ');

    Prepare;
  end;
end;

procedure TFFacturacion.CreaQInsError;
begin
  QInsError := TBonnyQuery.Create(Self);
  with QInsError do
  begin
    SQL.Add(' INSERT INTO tfacturas_err VALUES (   ');
    SQL.Add(' :codfactura, :codigo, :observacion)  ');;

    Prepare;

  end;
end;

procedure TFFacturacion.CreaQDatosAlbaran;
begin
  QDatosAlbaran := TBonnyQuery.Create(Self);
  with QDatosAlbaran do
  begin
    SQL.Add(' SELECT porte_bonny_sc, dir_sum_sc, n_pedido_sc, vehiculo_sc, moneda_sc, ');
    SQL.Add('        incoterm_sc, plaza_incoterm_sc, emp_procedencia_sl, calibre_sl, ');
    SQL.Add('        marca_sl, unidades_caja_sl, tipo_iva_sl, porc_iva_sl ');
    SQL.Add('   FROM frf_salidas_c, frf_salidas_l l1');
    SQL.Add('  WHERE empresa_sc = :empresa ');
    SQL.Add('     and fecha_sc = :fecha ');
    SQL.Add('     and n_albaran_sc = :albaran ');
    SQL.Add('     and centro_salida_sc = :centro ');
    SQL.Add('     and l1.producto_sl = :producto ');
    SQL.Add('     and l1.envase_sl = :envase ');
    SQL.Add('     and l1.categoria_sl = :categoria ');

    SQL.Add('     and l1.empresa_sl = empresa_sc ');
    SQL.Add('     and l1.centro_salida_sl = centro_salida_sc ');
    SQL.Add('     and l1.n_albaran_sl = n_albaran_sc ');
    SQL.Add('     and l1.fecha_sl = fecha_sc ');

    SQL.Add('    and l1.rowid = (select MIN(rowid) from frf_salidas_l l2 ');
    SQL.Add('  		where l2.n_albaran_sl = l1.n_albaran_sl ');
    SQL.Add('  		  and l2.empresa_sl = l1.empresa_sl ');
    SQL.Add('  		  and l2.fecha_sl = l1.fecha_sl ');
    SQL.Add('   	  and l2.centro_salida_sl = l1.centro_salida_sl ');
    SQL.Add('  		  and l2.producto_sl = l1.producto_sl ');
    SQL.Add('  		  and l2.envase_sl = l1.envase_sl ');
    SQL.Add('  		  and l2.categoria_sl = l1.categoria_sl ) ');

    Prepare;

  end;
end;

procedure TFFacturacion.CreaQFactManual;
begin
  QFactManual := tBonnyQuery.Create(Self);
  with QFactManual do
  begin
    SQL.Add(' select texto_fm from frf_fac_manual ');
    SQL.Add('  where empresa_fm = :empresa ');
    SQL.Add('    and factura_fm = :factura ');
    SQL.Add('    and fecha_fm = :fecha ');

    Prepare;

  end;
end;

procedure TFFacturacion.CreaQAnulacion;
begin
  QAnulacion := TBonnyQuery.Create(Self);
  with QAnulacion do
  begin
    SQL.Add(' select n_abono_fa, fecha_abono_fa ');
    SQL.Add('   from frf_facturas_abono ');
    SQL.Add('  where empresa_fa = :empresa ');
    SQL.Add('    and n_factura_fa = :factura ');
    SQL.Add('    and fecha_factura_fa = :fecha ');

    Prepare;
  end;
end;

procedure TFFacturacion.CreaQFactura;
begin
  QFactura := TBonnyQuery.Create(Self);
  with QFactura do
  begin
    SQL.Add(' select n_factura_fa, fecha_factura_fa ');
    SQL.Add('  from frf_facturas_abono ');
    SQL.Add(' where empresa_fa = :empresa ');
    SQL.Add('   and n_abono_fa = :abono ');
    SQL.Add('   and fecha_abono_fa = :fecabono ');

    Prepare;
  end;
end;

procedure TFFacturacion.CreaQExisteEmpresa;
begin
  QExisteEmpresa := TBonnyQuery.Create(Self);
  with QExisteEmpresa do
  begin
    SQL.Add(' select count(*) contador from tfacturas_cab     ');
    SQL.Add(' where cod_empresa_fac_fc = :empresa    ');
    SQL.Add('   and year(fecha_factura_fc) = :ano    ');

    Prepare;
  end;
end;

function TFFacturacion.EjecutaQEmpresa: boolean;
begin
  with QEmpresa do
  begin
    if cbEmpresa.Checked then
    begin
      if txEmpresa.Text <> '' then
        ParamByName('empresa').AsString := txEmpresa.Text;
      if txAno.Text <> '' then
        ParamByName('ano').AsString := txAno.Text;
    end;

    if cbFechas.Checked then
    begin
      ParamByName('fecha1').AsString := txFechaDesde.Text;
      ParamByName('fecha2').AsString := txFechaHasta.Text;
    end;

    Open;

    Result := not IsEmpty;
  end;
end;

function TFFacturacion.EjecutaQSeleccion: boolean;
begin
  with QSeleccion do
  begin
    if Active then
      Close;

    ParamByName('anyo').AsInteger := QEmpresa.FieldbyName('ano_f').AsInteger;
    ParamByName('empresa').AsString := QEmpresa.FieldByName('empresa_f').AsString;
    if txFactura.Text <> '' then
      ParamByName('factura').AsString := txFactura.Text;
    if txFecha.Text <> '' then
      ParamByName('fecha').AsString := txFecha.Text;

    if cbFechas.Checked then
    begin
      ParamByName('fecha1').AsString := txFechaDesde.Text;
      ParamByName('fecha2').AsString := txFechaHasta.Text;
    end;

    Open;

    Result := not IsEmpty;

  end;
  QSeleccion.Last;
  QSeleccion.First;
end;

procedure TFFacturacion.ProcFacturacion;
var HoraInicio, HoraFin: TDateTime;
begin
  sRuta := ObtenerRuta;

  if not EjecutaQEmpresa then
  begin
    ShowMessage('ATENCION! No existen datos con el criterio seleccionado.');
    txEmpresa.SetFocus;
    exit;
  end;

  HoraInicio := Now;
  mmxEmpresa.Lines.Add('COMIENZA PROCESO .... ');
  mmxEmpresa.Lines.Add('Hora Inicio: ' + FormatDateTime('hh:nn:ss', HoraInicio));
  mmxEmpresa.Lines.Add('');

  QEmpresa.First;
  while not QEmpresa.Eof do
  begin
    if not ExisteEmpresa then
    begin

      sErrores := 'ERR_FACT_' + QEmpresa.Fieldbyname('empresa_f').AsString + '_' +
                  QEmpresa.FieldbyName('ano_f').AsString; //+ '_' + FormatDateTime( 'yyyymmddhhnnss', Now );

      EjecutaQSeleccion;

      mmxEmpresa.Lines.Add('EMPRESA: ' + QEmpresa.Fieldbyname('empresa_f').AsString +
                           '       AÑO: ' + QEmpresa.FieldByName('ano_f').AsString);
      mmxEmpresa.Lines.Add('TOTAL FACTURAS: ' + IntToStr(QSeleccion.RecordCount));
      mmxEmpresa.Lines.Add('');

      mmxFacturas.Lines.Add('EMPRESA: ' + QEmpresa.Fieldbyname('empresa_f').AsString +
                            '       AÑO: ' + QEmpresa.FieldByName('ano_f').AsString);

        //ABRIR TRANSACCION
      if not AbrirTransaccion(DFactura.DataBase) then
      begin
        sMensaje := 'Error al abrir transaccion en BD.';
        GrabarError('001', sMensaje);
      end;

      QSeleccion.First;
      while not QSeleccion.Eof do
      begin
        Application.ProcessMessages;

        mmxFacturas.Lines.Add('Factura Nº: ' + QSeleccion.FieldByName('n_factura_f').AsString +
                              '    Fecha: ' + QSeleccion.FieldByName('fecha_factura_f').AsString);

        if (QSeleccion.FieldByName('concepto_f').AsString = 'M') and
           (QSeleccion.FieldByName('anulacion_f').AsInteger = 0) then
           FactManual
        else if (QSeleccion.FieldByName('concepto_f').AsString = 'A') and
                (QSeleccion.FieldByName('anulacion_f').AsInteger = 0) then
          FactAutomatica
        else if (QSeleccion.FieldByName('anulacion_f').AsInteger = 1) then
          FactAnulada;

          //Insertamos en datos de factura en BD
        InsertaFacturaCabecera;
        if DFactura.mtFacturas_Gas.Active then
          InsertaFacturaGastos;
        if DFactura.mtFacturas_Det.Active then
          InsertaFacturaDetalle(False);
        if DFactura.mtFacturas_Bas.Active then
          InsertaFacturaBase;

        CerrarTablas;

        QSeleccion.Next;
      end;

      AceptarTransaccion(DFactura.DataBase);

      GrabarFichero(sRuta);
      mmxFacturas.Clear;
      mmxErrores.Clear;
      LimpiarBuffers;
    end;
    QEmpresa.Next;

  end;

  HoraFin := Now;
  mmxEmpresa.Lines.Add('FINALIZACION PROCESO ....');
  mmxEmpresa.Lines.Add('Hora Finalizacion: ' + FormatDateTime('hh:nn:ss', HoraFin));
  mmxEmpresa.Lines.Add('');
  mmxEmpresa.Lines.Add('Tiempo de ejecucion: ' + FormatDateTime('hh:nn:ss', (HoraFin - HoraInicio)));

end;

procedure TFFacturacion.FactManual;
begin
    //Rellenamos tabla temporal detalle mtFacturas_Det
  if not LineasFacturaManual then
  begin
    sMensaje := 'mtFacturas_Det. Imposible obtener datos para generar lineas Factura.';
    GrabarError('002', sMensaje);
  end;

    //Rellenamos tabla temporal cabecera mtFacturas_Cab
  if not CabeceraFactura then
  begin
    sMensaje := 'mtFacturas_Cab. Imposible obtener datos para generar cabecera Factura.';
    GrabarError('003', sMensaje);
  end;

    //Observaciones de la factura
//  NotaFactura;

     //Calculo importes totales y rellenamos tabla temporal bases mtFacturas_Bas
  CalculoImportesTotales;
end;

procedure TFFacturacion.FactAnulada;
begin
      //Rellenamos tabla temporal cabecera mtFacturas_Cab
  if not CabeceraFactura then
  begin
    sMensaje := 'mtFacturas_Cab. Imposible obtener datos para generar cabecera Factura.';
    GrabarError('003', sMensaje);
  end;

    //Obtener Factura de Anulacion y actualizar valor
  if QSeleccion.FieldByName('tipo_factura_f').AsString = '380' then
    ObtenerAnulacion
  else
    ObtenerFactura;
     //Calculo importes totales y rellenamos tabla temporal bases mtFacturas_Bas
  CalculoImportesTotales;
end;

function TFFacturacion.LineasFacturaManual: Boolean;
begin
  with DFactura.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add('  SELECT  empresa_fal, centro_salida_fal, n_albaran_fal, fecha_albaran_fal, cliente_sal_f, cliente_fac_f, ');
    SQL.Add('       	 centro_origen_fal, ');
    SQL.Add('  	 producto_fal, envase_fal, categoria_fal, ');
    SQL.Add('  	 unidad_fal, precio_fal, ');

    SQL.Add('  	 pais_fac_c, representante_c, frf_productos.descripcion_p, frf_productos.descripcion2_p, ');

    SQL.Add('  	 descripcion_e, descripcion2_e, tipo_iva_e, ');

    SQL.Add('           SUM(unidades_fal) unidades,  SUM(importe_fal) importe_neto, ');
    SQL.Add('           empresa_f, fecha_factura_f, n_factura_f ');
    SQL.Add('  from frf_facturas, frf_fac_abonos_l, frf_clientes, frf_productos, frf_envases ');
    SQL.Add('  where empresa_f = :empresa ');
    SQL.Add('    and n_factura_f = :numerofactura  ');
    SQL.Add('    and fecha_factura_f = :fechafactura  ');

    SQL.Add('    and empresa_fal = empresa_f   ');
    SQL.Add('    and factura_fal = n_factura_f  ');
    SQL.Add('    and fecha_fal = fecha_factura_f  ');

    SQL.Add('    and empresa_f = empresa_c  ');
    SQL.Add('    and cliente_fac_f = cliente_c  ');

    SQL.Add('    and empresa_p = empresa_fal ');
    SQL.Add('    and producto_p = producto_fal  ');

    SQL.Add('    and empresa_e = empresa_fal  ');
    SQL.Add('    and envase_e = envase_fal ');
    SQL.Add('    and producto_base_e = producto_base_p ');

    SQL.Add('  GROUP BY empresa_fal, centro_salida_fal, n_albaran_fal, fecha_albaran_fal, cliente_sal_f, cliente_fac_f,  ');
    SQL.Add('  	        centro_origen_fal,  ');
    SQL.Add('  	        producto_fal, envase_fal, categoria_fal, ');
    SQL.Add('  	        unidad_fal, precio_fal, ');
    SQL.Add('  	        pais_fac_c, representante_c, frf_productos.descripcion_p, frf_productos.descripcion2_p, ');
    SQL.Add('  	        descripcion_e, descripcion2_e, tipo_iva_e, ');
    SQL.Add('  	        empresa_f, fecha_factura_f, n_factura_f ');
    SQL.Add('  ORDER BY fecha_albaran_fal, n_albaran_fal, producto_fal, envase_fal   ');

         //PARAMETROS
    ParamByName('empresa').AsString := QSeleccion.FieldByName('empresa_f').AsString;
    ParamByName('fechafactura').AsDateTime := QSeleccion.FieldByName('fecha_factura_f').AsDateTime;
    ParamByName('numerofactura').AsString := QSeleccion.FieldByName('n_factura_f').AsString;

    try
      Open;
      if isEmpty then
      begin
        Result := false;
        Exit;
      end;
    except
      Result := false;
      Exit;
    end;

    //Rellenamos tabla en memoria - Lineas facturas mtFacturas_Det
    RellenaMemLineasFacturasManual;

  Result := True;
  end;
end;

procedure TFFacturacion.FactAutomatica;
begin
    //Rellenamos tabla temporal detalle mtFacturas_Det
  if not LineasFactura then
  begin
    sMensaje := 'mtFacturas_Det. Imposible obtener datos para generar lineas Factura.';
    GrabarError('002', sMensaje);
  end;

    //Rellenamos tabla temporal cabecera mtFacturas_Cab
  if not CabeceraFactura then
  begin
    sMensaje := 'mtFacturas_Cab. Imposible obtener datos para generar cabecera Factura.';
    GrabarError('003', sMensaje);
  end;

    //Observaciones de la factura
//  NotaFactura;

    //Rellenamos tabla temporal gastos  mtFacturas_Gas
  if not GastosFactura then
  begin
    sMensaje := 'mtFacturas_Gas. Imposible obtener datos para generar gastos Factura.';
    GrabarError('004', sMensaje);
  end;
     //Calculo importes totales y rellenamos tabla temporal bases mtFacturas_Bas
  CalculoImportesTotales;
end;

function TFFacturacion.LineasFactura: Boolean;
begin
  with DFactura.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add(' SELECT  empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc, cliente_sal_sc, cliente_fac_sc, porte_bonny_sc,         ');
    SQL.Add('         dir_sum_sc, n_pedido_sc, vehiculo_sc, moneda_sc, incoterm_sc, plaza_incoterm_sc,              ');
    SQL.Add('         emp_procedencia_sl, centro_origen_sl,                                                         ');
    SQL.Add('         producto_sl, envase_sl, categoria_sl, calibre_sl, marca_sl, unidades_caja_sl,                 ');
    SQL.Add('         unidad_precio_sl, precio_sl, tipo_iva_sl, porc_iva_sl,                                        ');

    SQL.Add('         pais_fac_c, representante_c, frf_productos.descripcion_p, frf_productos.descripcion2_p,       ');

    SQL.Add('         descripcion_e, descripcion2_e, tipo_iva_e,                                                    ');

    SQL.Add('         SUM(cajas_sl) cajas_sl, SUM(kilos_sl) kilos_sl, SUM(importe_neto_sl) importe_neto_sl,         ');
    SQL.Add('         empresa_fac_sc, fecha_factura_sc, n_factura_sc, cliente_sal_sc ');

    SQL.Add('FROM frf_salidas_c, frf_salidas_l, frf_clientes, frf_productos, frf_envases ');

    SQL.Add('WHERE empresa_fac_sc = :empresa ');
    SQL.Add('  AND fecha_factura_sc = :fechafactura ');
    SQL.Add('  AND n_factura_sc = :numerofactura ');

    SQL.Add('AND empresa_sl = empresa_sc ');
    SQL.Add('AND centro_salida_sl = centro_salida_sc ');
    SQL.Add('AND n_albaran_sl = n_albaran_sc ');
    SQL.Add('AND fecha_sl = fecha_sc ');

    SQL.Add('AND empresa_c = empresa_sc ');
    SQL.Add('AND cliente_c = cliente_fac_sc ');

    SQL.Add('AND empresa_p = empresa_sc ');
    SQL.Add('AND producto_p = producto_sl ');

    SQL.Add('AND empresa_e = empresa_sc ');
    SQL.Add('AND envase_e = envase_sl ');
    SQL.Add('AND producto_base_e = producto_base_p ');

//    SQL.Add('AND  (facturable_sc = 1 ) ');        //Solo Albaranes Facturables

    SQL.Add('GROUP BY empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc, cliente_sal_sc, cliente_fac_sc, porte_bonny_sc, ');
    SQL.Add('         dir_sum_sc, n_pedido_sc, vehiculo_sc, moneda_sc, incoterm_sc, plaza_incoterm_sc, ');
    SQL.Add('         emp_procedencia_sl, centro_origen_sl, ');
    SQL.Add('       	producto_sl, envase_sl, categoria_sl, calibre_sl, marca_sl, color_sl, unidades_caja_sl, ');
    SQL.Add('       	unidad_precio_sl, precio_sl, tipo_iva_sl, porc_iva_sl, pais_fac_c, representante_c, ');
    SQL.Add('       	frf_productos.descripcion_p, frf_productos.descripcion2_p, ');
    SQL.Add('       	descripcion_e, descripcion2_e, tipo_iva_e, ');
    SQL.Add('         empresa_fac_sc, fecha_factura_sc, n_factura_sc ');
    SQL.Add('ORDER BY fecha_sc, n_pedido_sc, n_albaran_sc, dir_sum_sc, producto_sl, envase_sl ');



         //PARAMETROS
    ParamByName('empresa').AsString := QSeleccion.FieldByName('empresa_f').AsString;
    ParamByName('fechafactura').AsDateTime := QSeleccion.FieldByName('fecha_factura_f').AsDateTime;
    ParamByName('numerofactura').AsString := QSeleccion.FieldByName('n_factura_f').AsString;

    try
      Open;
      if isEmpty then
      begin
        Result := false;
        Exit;
      end;
    except
      Result := false;
      Exit;
    end;

    //Rellenamos tabla en memoria - Lineas facturas mtFacturas_Det
    RellenaMemLineasFacturas;

  Result := True;
  end;
end;

//Rellenamos tabla temporal cabecera
function TFFacturacion.CabeceraFactura: boolean;
begin
  RellenaMemCabeceraFacturas;

  if DFactura.mtFacturas_Cab.RecordCount = 0 then
  begin
    CabeceraFactura := false;
    Exit;
  end;
  CabeceraFactura := true;
end;

procedure TFFacturacion.NotaFactura;
var
  sAux: String;
begin

  sAux := '';
  with DFactura.mtFacturas_Cab do
  begin
    First;
    while not Eof do
    begin
      sAux := GetNotaFactura;
      if length( sAux ) > 250 then
        sAux:= copy( sAux, 1, 250 ) + #13 + #10 + '...';

      if Trim( sAux ) <> '' then
      begin
        Edit;
        FieldByName('notas_fc').AsString:= sAux;
        Post;
      end;
      Next;
    end;
  end;

end;

function TFFacturacion.GetNotaFactura : string;
var sEmpresa, sCentro, sAlbaran, sFecha: string;
begin
  result:= '';
  sEmpresa := '';
  sCentro := '';
  sAlbaran := '';
  sFecha := '';
  with DFactura.mtFacturas_Det do
  begin
    Filter := ' fac_interno_fd = ' + QuotedStr(DFactura.mtFacturas_Cab.FieldByName('fac_interno_fc').AsString);
    Filtered := True;

    First;
    while not Eof do
    begin
      if (sEmpresa = '') or (sEmpresa <> FieldByName('cod_empresa_albaran_fd').AsString) or
         (sCentro <> FieldByName('cod_centro_albaran_fd').AsString) or
         (sAlbaran <> FieldByName('n_albaran_fd').AsString) or
         (sFecha <> FieldByName('fecha_albaran_fd').AsString) then
      begin
        if result <> '' then
          result:= result + #13 + #10;
        result:= result + GetNotaFacturaAux;
      end;
      sEmpresa := FieldByName('cod_empresa_albaran_fd').AsString;
      sCentro := FieldByName('cod_centro_albaran_fd').AsString;
      sAlbaran := FieldByName('n_albaran_fd').AsString;
      sFecha := FieldByName('fecha_albaran_fd').AsString;
      Next;
    end;

    Filter := '';
    Filtered := False;
  end;
end;

//Observaciones de la factura
function TFFacturacion.GetNotaFacturaAux: string;
begin
  result:= '';
  with QNota do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString:= DFactura.mtFacturas_Det.FieldByName('cod_empresa_albaran_fd').AsString;
    ParamByName('centro').AsString:= DFactura.mtFacturas_Det.FieldByName('cod_centro_albaran_fd').AsString;
    ParamByName('albaran').AsString:= DFactura.mtFacturas_Det.FieldByName('n_albaran_fd').AsString;
    ParamByName('fecha').AsString:= DFactura.mtFacturas_Det.FieldByName('fecha_albaran_fd').AsString;
    Open;

    result:= FieldByName('nota_factura_sc').AsString;
  end;
end;

//Rellenamos tabla temporal gastos
function TFFacturacion.GastosFactura: boolean;
var sEmpresa, sCentro, sAlbaran, sFecha: string;
begin
  sEmpresa := '';
  sCentro := '';
  sAlbaran := '';
  sFecha := '';
  if DFactura.mtFacturas_Det.Active then
  begin
    with DFactura.mtFacturas_Det do
    begin
      First;
      while not Eof do
      begin
        if (sEmpresa = '') or (sEmpresa <> FieldByName('cod_empresa_albaran_fd').AsString) or
           (sCentro <> FieldByName('cod_centro_albaran_fd').AsString) or
           (sAlbaran <> FieldByName('n_albaran_fd').AsString) or
           (sFecha <> FieldByName('fecha_albaran_fd').AsString) then
        begin
          with DFactura.QGeneral do
          begin
            if Active then
            begin
              Cancel;
              Close;
            end;

            SQL.Clear;
            SQL.Add('SELECT DISTINCT empresa_g, centro_salida_g, n_albaran_g,');
            SQL.Add('                fecha_g,tipo_g,descripcion_tg,importe_g, ');
            SQL.Add('                tipo_iva_tg, ');
            SQL.Add('      case when exists ( select * ');
            SQL.Add('                           from frf_impuestos_recargo_cli ');
            SQL.Add('                           where empresa_irc = :empresa ');
            SQL.Add('                           and cliente_irc = :cliente ');
            SQL.Add('                           and fecha_g  between fecha_ini_irc and case when fecha_fin_irc is null then fecha_g else fecha_fin_irc end ) ');

            SQL.Add('             then ( select case when tipo_iva_tg = 0 then super_il  +  recargo_super_il ');
            SQL.Add('                                when tipo_iva_tg = 1 then reducido_il + recargo_reducido_il ');
            SQL.Add('                                when tipo_iva_tg = 2 then general_il + recargo_general_il ');
            SQL.Add('                                else 0 ');
            SQL.Add('                           end ');
            SQL.Add('                    from frf_impuestos_l ');
            SQL.Add('                    where codigo_il= :tipo_iva ');
            SQL.Add('                    and fecha_g  between fecha_ini_il and case when fecha_fin_il is null then fecha_g else fecha_fin_il end ) ');

            SQL.Add('             else ( select case when tipo_iva_tg = 0 then super_il ');
            SQL.Add('                                when tipo_iva_tg = 1 then reducido_il ');
            SQL.Add('                                when tipo_iva_tg = 2 then general_il ');
            SQL.Add('                                else 0 ');
            SQL.Add('                           end ');
            SQL.Add('                    from frf_impuestos_l ');
            SQL.Add('                    where codigo_il= :tipo_iva ');
            SQL.Add('                    and fecha_g  between fecha_ini_il and case when fecha_fin_il is null then fecha_g else fecha_fin_il end ) ');
            SQL.Add('        end porcentaje_iva');

            SQL.Add('FROM frf_gastos, frf_tipo_gastos ');
            SQL.Add('WHERE empresa_g = :empresa ');
            SQL.Add('AND centro_salida_g = :centro ');
            SQL.Add('AND n_albaran_g = :albaran  ');
            SQL.Add('AND fecha_g = :fecha');
            SQL.Add('AND tipo_g=tipo_tg ');
            SQL.Add('AND facturable_tg="S" ');

            ParamByName('empresa').AsString := DFactura.mtFacturas_Det.FieldByName('cod_empresa_albaran_fd').AsString;
            ParamByName('centro').AsString := DFactura.mtFacturas_Det.FieldByName('cod_centro_albaran_fd').AsString;
            ParamByName('albaran').AsInteger := DFactura.mtFacturas_Det.FieldByName('n_albaran_fd').AsInteger;
            ParamByName('fecha').AsDateTime := DFactura.mtFacturas_Det.FieldByName('fecha_albaran_fd').AsDateTime;
            ParamByName('cliente').AsString := DFactura.mtFacturas_Det.FieldByName('cod_cliente_fac_fd').AsString;
            ParamByName('tipo_iva').AsString := DFactura.mtFacturas_Det.FieldByName('tipo_iva_fd').AsString;

            try
              Open;
            except
              Result := false;
              Exit;
            end;

            RellenaMemGastosFacturas;

          end;
        end;
        sEmpresa := FieldByName('cod_empresa_albaran_fd').AsString;
        sCentro := FieldByName('cod_centro_albaran_fd').AsString;
        sAlbaran := FieldByName('n_albaran_fd').AsString;
        sFecha := FieldByName('fecha_albaran_fd').AsString;
        Next;
      end;
    end;
  end;
  Result := true;
end;

procedure TFFacturacion.CalculoImportesTotales;
var rImporteLinea, rImporteDescuento,
    rImporteNeto, rImporteImpuesto, rImporteTotal,
    rImporteNetoEuros, rImporteImpuestoEuros, rImporteTotalEuros: real;
    i, iBases: integer;
    flag: boolean;
    RImpBases: TRImpBases;
    sCodError : String;
begin

  rImporteLinea := 0;
  rImporteDescuento := 0;
  rImporteNeto := 0;
  rImporteImpuesto := 0;
  rImporteTotal := 0;
  rImporteNetoEuros := 0;
  rImporteImpuestoEuros := 0;
  rImporteTotalEuros := 0;

      if DFactura.mtFacturas_Det.Active then
      begin

        iBases := 0;

          //INICIALIZAMOS BASES DETALLE
        DFactura.mtFacturas_Det.First;
        while not DFactura.mtFacturas_Det.Eof do
        begin
          i:= 0;
          flag:= False;
          while ( i < iBases ) and ( not flag ) do
          begin
            if DFactura.mtFacturas_Det.FieldByName('porcentaje_impuesto_fd').AsFloat =  RImpBases.aRImportes[i].rPorcentajeImpuesto then
              flag:= True
            else
              inc(i);
          end;
          if not flag then
          begin
            SetLength( RImpBases.aRImportes, iBases + 1);
            RImpBases.aRImportes[iBases].rPorcentajeImpuesto:= DFactura.mtFacturas_Det.FieldByName('porcentaje_impuesto_fd').AsFloat;
            RImpBases.aRImportes[iBases].iTasaImpuesto:= DFactura.mtFacturas_Det.FieldByName('tasa_impuesto_fd').AsInteger;
            RImpBases.aRImportes[i].iCajas := 0;
            RImpBases.aRImportes[i].iUnidades := 0;
            RImpBases.aRImportes[i].rKilos := 0;
            RImpBases.aRImportes[i].rImporteNeto:= 0;
            RImpBases.aRImportes[i].rImporteImpuesto:= 0;
            RImpBases.aRImportes[i].rImporteTotal:= 0;
            iBases:= iBases + 1;
          end;

          DFactura.mtFacturas_Det.Next;
        end;
      end;

      if DFactura.mtFacturas_Gas.Active then
      begin

          //INICIALIZAMOS BASES GASTOS
        DFactura.mtFacturas_Gas.First;
        while not DFactura.mtFacturas_Gas.Eof do
        begin
          i:= 0;
          flag:= False;
          while ( i < iBases ) and ( not flag ) do
          begin
            if DFactura.mtFacturas_gas.FieldByName('porcentaje_impuesto_fg').AsFloat =  RImpBases.aRImportes[i].rPorcentajeImpuesto then
              flag:= True
            else
              inc(i);
          end;
          if not flag then
          begin
            SetLength( RImpBases.aRImportes, iBases + 1);

            RImpBases.aRImportes[iBases].rPorcentajeImpuesto:= DFactura.mtFacturas_Gas.FieldByName('porcentaje_impuesto_fg').AsFloat;
            RImpBases.aRImportes[iBases].iTasaImpuesto:= DFactura.mtFacturas_Gas.FieldByName('tasa_impuesto_fg').AsInteger;
            RImpBases.aRImportes[i].iCajas := 0;
            RImpBases.aRImportes[i].iUnidades := 0;
            RImpBases.aRImportes[i].rKilos := 0;
            RImpBases.aRImportes[i].rImporteNeto:= 0;
            RImpBases.aRImportes[i].rImporteImpuesto:= 0;
            RImpBases.aRImportes[i].rImporteTotal:= 0;
            iBases:= iBases + 1;
          end;

          DFactura.mtFacturas_Gas.Next;
        end;
      end;

      if DFactura.mtFacturas_Det.Active then
      begin

          //Detalle Linea
        DFactura.mtFacturas_Det.First;
        with DFactura.mtFacturas_Det do
        begin
          rImporteLinea := 0;
          rImporteDescuento := 0;
          rImporteNeto := 0;
          rImporteImpuesto := 0;
          rImporteTotal := 0;
          rImporteNetoEuros := 0;
          rImporteImpuestoEuros := 0;
          rImporteTotalEuros := 0;

          First;
          while not Eof do
          begin
             // CALCULOS BASES
            i := 0;
            while i< iBases do
            begin
              if DFactura.mtFacturas_Det.FieldByName('porcentaje_impuesto_fd').AsFloat = RImpBases.aRImportes[i].rPorcentajeImpuesto then
              begin
                RImpBases.aRImportes[i].sCodFactura := DFactura.mtFacturas_Det.Fieldbyname('cod_factura_fd').AsString;

                RImpBases.aRImportes[i].sEmpresa := DFactura.mtFacturas_Det.FieldByName('cod_empresa_fac_fd').AsString;
                RImpBases.aRImportes[i].sFecha := DFactura.mtFacturas_Det.FieldByName('fecha_fac_fd').AsString;
                RImpBases.aRImportes[i].sNumero := DFactura.mtFacturas_Det.FieldByName('fac_interno_fd').AsString;

                RImpBases.aRImportes[i].iCajas := RImpBases.aRImportes[i].iCajas +
                                                  DFactura.mtFacturas_Det.FieldByName('cajas_fd').AsInteger;
                RImpBases.aRImportes[i].iUnidades := RImpBases.aRImportes[i].iUnidades +
                                                     DFactura.mtFacturas_Det.FieldByName('unidades_fd').AsInteger;
                RImpBases.aRImportes[i].rKilos := RImpBases.aRImportes[i].rKilos +
                                                  DFactura.mtFacturas_Det.FieldByName('kilos_fd').AsFloat;
                RImpBases.aRImportes[i].rImporteNeto := RImpBases.aRImportes[i].rImporteNeto +
                                                        DFactura.mtFacturas_Det.FieldByName('importe_neto_fd').AsFloat;
                RImpBases.aRImportes[i].rImporteImpuesto := RImpBases.aRImportes[i].rImporteImpuesto +
                                                            DFactura.mtFacturas_Det.FieldByName('importe_impuesto_fd').AsFloat;
                RImpBases.aRImportes[i].rImporteTotal := RImpBases.aRImportes[i].rImporteTotal +
                                                         DFactura.mtFacturas_Det.FieldByName('importe_total_fd').AsFloat;
                Break;
              end;
              Inc(i)
            end;
            rImporteLinea := rImporteLinea + FieldByName('importe_linea_fd').AsFloat;
            rImporteDescuento := rImporteDescuento + FieldByName('importe_total_descuento_fd').AsFloat;
            rImporteNeto := rImporteNeto + FieldByName('importe_neto_fd').AsFloat;
            rImporteImpuesto := rImporteImpuesto + FieldByName('importe_impuesto_fd').AsFloat;
            rImporteTotal := rImporteTotal + FieldByName('importe_total_fd').AsFloat;
            Next;
          end;

        end;
      end;
      if DFactura.mtFacturas_Gas.Active then
      begin

          //Gastos
        with DFactura.mtFacturas_Gas do
        begin
          First;
          while not Eof do
          begin
              // CALCULOS BASES
            i:=0;
            while i<iBases do
            begin
              if DFactura.mtFacturas_Gas.FieldByName('porcentaje_impuesto_fg').AsFloat = RImpBases.aRImportes[i].rPorcentajeImpuesto then
              begin
                RImpBases.aRImportes[i].sCodFactura := DFactura.mtFacturas_Gas.Fieldbyname('cod_factura_fg').AsString;

                RImpBases.aRImportes[i].sEmpresa := DFactura.mtFacturas_Gas.FieldByName('cod_empresa_fac_fg').AsString;
                RImpBases.aRImportes[i].sFecha := DFactura.mtFacturas_Gas.FieldByName('fecha_fac_fg').AsString;
                RImpBases.aRImportes[i].sNumero := DFactura.mtFacturas_Gas.FieldByName('fac_interno_fg').AsString;

                RImpBases.aRImportes[i].rImporteNeto := RImpBases.aRImportes[i].rImporteNeto +
                                                        DFactura.mtFacturas_Gas.FieldByName('importe_neto_fg').AsFloat;
                RImpBases.aRImportes[i].rImporteImpuesto := RImpBases.aRImportes[i].rImporteImpuesto +
                                                            DFactura.mtFacturas_Gas.FieldByName('importe_impuesto_fg').AsFloat;
                RImpBases.aRImportes[i].rImporteTotal := RImpBases.aRImportes[i].rImporteTotal +
                                                         DFactura.mtFacturas_Gas.FieldByName('importe_total_fg').AsFloat;
                Break;
              end;
              Inc(i)
            end;

            rImporteNeto := rImporteNeto + FieldByName('importe_neto_fg').AsFloat;
            rImporteImpuesto := rImporteImpuesto + FieldByName('importe_impuesto_fg').AsFloat;
            rImporteTotal := rImporteTotal + FieldByName('importe_total_fg').AsFloat;
            Next;
          end;

        end;
      end;

      if DFactura.mtFacturas_Det.Active then
      begin

        if DFactura.mtFacturas_Cab.FieldByName('moneda_fc').AsString = 'EUR' then
        begin
          rImporteNetoEuros := rImporteNeto;
          rImporteImpuestoEuros := rImporteImpuesto;
          rImporteTotalEuros := rImporteTotal;
        end
        else
          try
            rImporteNetoEuros := ChangeToEuro( DFactura.mtFacturas_Cab.FieldByName('moneda_fc').AsString,
                                               DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsString,
                                               rImporteNeto);
            rImporteImpuestoEuros := ChangeToEuro( DFactura.mtFacturas_Cab.FieldByName('moneda_fc').AsString,
                                                   DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsString,
                                                   rImporteImpuesto);
            rImporteTotalEuros := ChangeToEuro( DFactura.mtFacturas_Cab.FieldByName('moneda_fc').AsString,
                                                DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsString,
                                                rImporteTotal);
            except
              sMensaje := 'ERROR al calcular el cambio a Euros, comprobar que la moneda sea correcta.';
              GrabarError('007', sMensaje);
            end;

        RellenaMemBaseFacturas(RImpBases);

        sCodError := '';
        if ((Abs(bRoundTo(rImporteTotal, 2) - QSeleccion.FieldByName('importe_total_f').AsFloat) > 1) and
             (bRoundTo(rImporteTotal, 2) <> QSeleccion.FieldByName('importe_total_f').AsFloat)) then
        begin
          sMensaje := 'Cabecera Factura. Importes Totales no coincide con lineas de factura.';
          sCodError := '006';
          GrabarError(sCodError, sMensaje);
        end;

        DFactura.mtFacturas_Cab.Edit;
        DFactura.mtFacturas_Cab.FieldByName('importe_linea_fc').AsFloat := rImporteLinea;
        DFactura.mtFacturas_Cab.FieldByName('importe_descuento_fc').AsFloat := rImporteDescuento;

        DFactura.mtFacturas_Cab.FieldByName('importe_neto_euros_fc').AsFloat := rImporteNetoEuros;
        DFactura.mtFacturas_Cab.FieldByName('importe_impuesto_euros_fc').AsFloat := rImporteImpuestoEuros;
        DFactura.mtFacturas_Cab.FieldByName('importe_total_euros_fc').AsFloat := rImporteTotalEuros;

        //Valores totales de frf_facturas
        DFactura.mtFacturas_Cab.FieldByName('importe_neto_fc').AsFloat := QSeleccion.Fieldbyname('importe_neto_f').AsFloat;
        DFactura.mtFacturas_Cab.FieldByName('importe_impuesto_fc').AsFloat := QSeleccion.FieldByName('total_impuesto_f').AsFloat;
        DFactura.mtFacturas_Cab.FieldByName('importe_total_fc').AsFloat := QSeleccion.FieldByName('importe_total_f').AsFloat;

        DFactura.mtFacturas_Cab.Post;

      end
      else
      begin
        DFactura.mtFacturas_Cab.Edit;
        DFactura.mtFacturas_Cab.FieldByName('importe_linea_fc').AsFloat := rImporteLinea;
        DFactura.mtFacturas_Cab.FieldByName('importe_descuento_fc').AsFloat := rImporteDescuento;
        DFactura.mtFacturas_Cab.FieldByName('importe_neto_fc').AsFloat := QSeleccion.Fieldbyname('importe_neto_f').AsFloat;
        DFactura.mtFacturas_Cab.FieldByName('importe_impuesto_fc').AsFloat := QSeleccion.FieldByName('total_impuesto_f').AsFloat;
        DFactura.mtFacturas_Cab.FieldByName('importe_total_fc').AsFloat := QSeleccion.FieldByName('importe_total_f').AsFloat;
        DFactura.mtFacturas_Cab.FieldByName('importe_neto_euros_fc').AsFloat := ChangeToEuro( DFactura.mtFacturas_Cab.FieldByName('moneda_fc').AsString,
                                                        DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsString,
                                                        QSeleccion.Fieldbyname('importe_neto_f').AsFloat);
        DFactura.mtFacturas_Cab.FieldByName('importe_impuesto_euros_fc').AsFloat := ChangeToEuro( DFactura.mtFacturas_Cab.FieldByName('moneda_fc').AsString,
                                                            DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsString,
                                                            QSeleccion.FieldByName('total_impuesto_f').AsFloat);
        DFactura.mtFacturas_Cab.FieldByName('importe_total_euros_fc').AsFloat := QSeleccion.FieldByName('importe_euros_f').AsFloat;
        DFactura.mtFacturas_Cab.Post;
      end;
end;

procedure TFFacturacion.ObtenerAnulacion;
var iAbono: integer;
    dFecha: TDate;
    sCodAbono: String;
begin
  with QAnulacion do
  begin
    if Active then
      Close;
    ParamByName('empresa').AsString := QSeleccion.FieldByName('empresa_f').AsString;
    ParamByName('factura').AsInteger := QSeleccion.FieldByName('n_factura_f').AsInteger;
    ParamByName('fecha').AsDateTime := QSeleccion.FieldByName('fecha_factura_f').AsDateTime;

    Open;

    iAbono := FieldByName('n_abono_fa').AsInteger;
    dFecha := FieldByName('fecha_abono_fa').AsDateTime;
  end;
  sCodAbono := NewCodigoFactura(QSeleccion.Fieldbyname('empresa_f').AsString,
                                '381',
                                Copy(QSeleccion.FieldByName('tipo_impuesto_f').AsString,1,1),
                                dFecha,
                                iAbono);
  DFactura.mtFacturas_Cab.Edit;
  DFactura.mtFacturas_Cab.FieldByName('cod_factura_anula_fc').AsString := sCodAbono;
  DFactura.mtFacturas_Cab.FieldByName('automatica_fc').AsInteger := 0;
  DFactura.mtFacturas_Cab.FieldByName('anulacion_fc').AsInteger := 1;

  DFactura.mtFacturas_Cab.Post;

end;

procedure TFFacturacion.ObtenerFactura;
var iFactura: integer;
    dFecha: TDate;
    sCodFactura: String;
begin
  with QFactura do
  begin
    if Active then
      Close;
    ParamByName('empresa').AsString := QSeleccion.FieldByName('empresa_f').AsString;
    ParamByName('abono').AsInteger := QSeleccion.FieldByName('n_factura_f').AsInteger;
    ParamByName('fecabono').AsDateTime := QSeleccion.FieldByName('fecha_factura_f').AsDateTime;

    Open;

    iFactura := FieldByName('n_factura_fa').AsInteger;
    dFecha := FieldByName('fecha_factura_fa').AsDateTime;
  end;
  sCodFactura := NewCodigoFactura(QSeleccion.Fieldbyname('empresa_f').AsString,
                                '380',
                                Copy(QSeleccion.FieldByName('tipo_impuesto_f').AsString,1,1),
                                dFecha,
                                iFactura);
  DFactura.mtFacturas_Cab.Edit;
  DFactura.mtFacturas_Cab.FieldByName('cod_factura_anula_fc').AsString := sCodFactura;
  DFactura.mtFacturas_Cab.FieldByName('automatica_fc').AsInteger := 0;
  DFactura.mtFacturas_Cab.FieldByName('anulacion_fc').AsInteger := 1;

  DFactura.mtFacturas_Cab.Post;

end;

function TFFacturacion.ExisteEmpresa: boolean;
begin
  if (txFactura.Text <> '') or (txFecha.Text <> '') or (cbFechas.Checked)  then
  begin
    result := false;
    exit;
  end;
  with QExisteEmpresa do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := QEmpresa.Fieldbyname('empresa_f').AsString;
    ParamByName('ano').AsInteger := QEmpresa.Fieldbyname('ano_f').AsInteger;
    Open;

    Result := FieldByName('contador').AsInteger <> 0;
  end;
end;
procedure TFFacturacion.RellenaMemLineasFacturas;
var rComision, rDescuento, rImpuesto,
    rImpComision, rImpDescuento: real;
    iNumLinea: integer;
begin
  iNumLinea := 1;
  with DFactura.QGeneral do
  begin
    First;
    DFactura.mtFacturas_Det.Open ;
    while not Eof do
    begin

      DFactura.mtFacturas_Det.Append;

      DFactura.mtFacturas_Det.FieldByName('cod_empresa_albaran_fd').asString := FieldByName('empresa_sc').asString;
      DFactura.mtFacturas_Det.FieldByName('cod_centro_albaran_fd').asString := FieldByName('centro_salida_sc').asString;
      DFactura.mtFacturas_Det.FieldByName('n_albaran_fd').asInteger := FieldByName('n_albaran_sc').AsInteger;
      DFactura.mtFacturas_Det.FieldByName('fecha_albaran_fd').asDateTime := FieldByName('fecha_sc').aSDateTime;
      DFactura.mtFacturas_Det.FieldByName('cod_cliente_albaran_fd').asString := FieldByName('cliente_sal_sc').asString;
      DFactura.mtFacturas_Det.FieldByName('cod_dir_sum_fd').AsString := FieldByName('dir_sum_sc').AsString;
      DFactura.mtFacturas_Det.FieldByName('pedido_fd').AsString:= FieldByName('n_pedido_sc').AsString;
      DFactura.mtFacturas_Det.FieldByName('matricula_fd').AsString := FieldByName('vehiculo_sc').AsString;
      DFactura.mtFacturas_Det.FieldByName('emp_procedencia_fd').AsString := FieldByName('emp_procedencia_sl').AsString;
      DFactura.mtFacturas_Det.FieldByName('centro_origen_fd').AsString := FieldByName('centro_origen_sl').AsString;
      DFactura.mtFacturas_Det.FieldByName('cod_producto_fd').AsString := FieldByName('producto_sl').AsString;
      DFactura.mtFacturas_Det.FieldByName('des_producto_fd').AsString := DescripcionProducto;
      DFactura.mtFacturas_Det.FieldByName('cod_envase_fd').AsString := FieldByName('envase_sl').AsString;
      DFactura.mtFacturas_Det.FieldByName('des_envase_fd').AsString := DescripcionEnvase(FieldByname('empresa_sc').AsString,
                                                                                         FieldByname('producto_sl').AsString,
                                                                                         FieldByname('envase_sl').AsString,
                                                                                         FieldByname('cliente_sal_sc').AsString);
      DFactura.mtFacturas_Det.FieldByName('categoria_fd').AsString := FieldByName('categoria_sl').AsString;
      DFactura.mtFacturas_Det.FieldByName('calibre_fd').AsString := FieldByName('calibre_sl').AsString;
      DFactura.mtFacturas_Det.FieldByName('marca_fd').AsString := FieldByName('marca_sl').AsString;
      DFactura.mtFacturas_Det.FieldByName('nom_marca_fd').AsString := DescripcionMarca(FieldByName('marca_sl').AsString);
      DFactura.mtFacturas_Det.FieldByName('cajas_fd').AsInteger := FieldByName('cajas_sl').AsInteger;
      DFactura.mtFacturas_Det.FieldByName('unidades_caja_fd').AsInteger := FieldByName('unidades_caja_sl').AsInteger;
      DFactura.mtFacturas_Det.FieldByName('unidades_fd').AsInteger := FieldByName('cajas_sl').AsInteger *
                                                                           FieldByName('unidades_caja_sl').AsInteger;
      DFactura.mtFacturas_Det.FieldByName('kilos_fd').AsFloat := FieldByName('kilos_sl').AsFloat;
      DFactura.mtFacturas_Det.FieldByName('unidad_facturacion_fd').AsString := FieldByName('unidad_precio_sl').AsString;
      DFactura.mtFacturas_Det.FieldByName('precio_fd').AsFloat := FieldByName('precio_sl').AsFloat;
      DFactura.mtFacturas_Det.FieldByName('importe_linea_fd').AsFloat := FieldByName('importe_neto_sl').AsFloat;
      DFactura.mtFacturas_Det.FieldByName('cod_representante_fd').AsString := FieldbyName('representante_c').AsString;

      rComision := GetPorcentajeComision(FieldByName('empresa_sc').AsString,
                                         FieldByName('representante_c').AsString,
                                         FieldByName('fecha_factura_sc').AsDatetime);
      rDescuento:= GetPorcentajeDescuento(FieldByName('empresa_sc').AsString,
                                          FieldByName('cliente_sal_sc').asString,
                                          FieldByName('centro_salida_sc').asString,
                                          FieldByName('producto_sl').AsString,
                                          FieldByName('fecha_factura_sc').AsDatetime);

      rImpComision := bRoundTo(FieldByName('importe_neto_sl').AsFloat * rComision/100, 2);
      rImpDescuento:= bRoundTo((FieldByName('importe_neto_sl').AsFloat - rImpComision) * rDescuento/100, 2);

      DFactura.mtFacturas_Det.FieldByName('porcentaje_comision_fd').AsFloat := rComision;
      DFactura.mtFacturas_Det.FieldByName('porcentaje_descuento_fd').AsFloat := rDescuento;
      DFactura.mtFacturas_Det.FieldByName('importe_comision_fd').AsFloat := rImpComision;
      DFactura.mtFacturas_Det.FieldByName('importe_descuento_fd').AsFloat := rImpDescuento;
      DFactura.mtFacturas_Det.FieldByName('importe_total_descuento_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('importe_comision_fd').AsFloat +
                                                                                   DFactura.mtFacturas_Det.FieldByName('importe_descuento_fd').AsFloat;
      DFactura.mtFacturas_Det.FieldByName('importe_neto_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('importe_linea_fd').AsFloat -
                                                                             DFactura.mtFacturas_Det.FieldByName('importe_total_descuento_fd').AsFloat;
      DFactura.mtFacturas_Det.FieldByName('tasa_impuesto_fd').AsInteger := FieldByName('tipo_iva_e').AsInteger;
      rImpuesto := FieldByName('porc_iva_sl').AsFloat;
      DFactura.mtFacturas_Det.FieldByName('porcentaje_impuesto_fd').AsFloat := rImpuesto;
      DFactura.mtFacturas_Det.FieldByName('importe_impuesto_fd').AsFloat := bRoundTo(DFactura.mtFacturas_Det.FieldByName('importe_neto_fd').AsFloat * rImpuesto/100, 2);
//      DFactura.mtFacturas_Det.FieldByName('importe_impuesto_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('importe_neto_fd').AsFloat * rImpuesto/100;
      DFactura.mtFacturas_Det.FieldByName('importe_total_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('importe_neto_fd').AsFloat +
                                                                              DFactura.mtFacturas_Det.FieldByName('importe_impuesto_fd').AsFloat;

      DFactura.mtFacturas_Det.FieldByName('cod_empresa_fac_fd').AsString := FieldByName('empresa_fac_sc').asString;
      DFactura.mtFacturas_Det.FieldByName('fecha_fac_fd').AsDateTime := FieldByName('fecha_factura_sc').AsDateTime;
      DFactura.mtFacturas_Det.FieldByName('cod_cliente_fac_fd').AsString := FieldByName('cliente_fac_sc').AsString;
      DFactura.mtFacturas_Det.FieldByName('moneda_fd').AsString := FieldByName('moneda_sc').AsString;
      DFactura.mtFacturas_Det.FieldByName('tipo_iva_fd').AsString := FieldByName('tipo_iva_sl').AsString;
      if FieldByName('porte_bonny_sc').asInteger = 1 then
      begin
        DFactura.mtFacturas_Det.FieldByName('incoterm_fd').AsString := FieldByName('incoterm_sc').AsString;
        DFactura.mtFacturas_Det.FieldByName('plaza_incoterm_fd').AsString := FieldByName('plaza_incoterm_sc').AsString;
      end
      else
      begin
        DFactura.mtFacturas_Det.FieldByName('incoterm_fd').AsString := '';
        DFactura.mtFacturas_Det.FieldByName('plaza_incoterm_fd').AsString := '';
      end;

      DFactura.mtFacturas_Det.FieldByName('fac_interno_fd').AsInteger := FieldByName('n_factura_sc').AsInteger;
      DFactura.mtFacturas_Det.FieldByName('cod_factura_fd').AsString :=
                                              NewCodigoFactura(QSeleccion.Fieldbyname('empresa_f').AsString,
                                                               QSeleccion.FieldByName('tipo_factura_f').AsString,
                                                               Copy(QSeleccion.FieldByName('tipo_impuesto_f').AsString,1,1),
                                                               QSeleccion.FieldByName('fecha_factura_f').AsDateTime,
                                                               QSeleccion.FieldByName('n_factura_f').AsInteger );
      DFactura.mtFacturas_Det.FieldByName('num_linea_fd').AsInteger := iNumLinea;
      inc(iNumLinea);

      DFactura.mtFacturas_Det.Post;

      Next;
    end;
    Close;
  end;
end;

procedure TFFacturacion.RellenaMemCabeceraFacturas;
begin
  if DFactura.mtFacturas_Det.Active then
    RellenaDesdeLineas
  else
    RellenaDesdeFactura;
end;

procedure TFFacturacion.RellenaDesdeLineas;
var sFactura: string;
    RDatosClienteFac: TRDatosClienteFac;
begin
  sFactura := '';

  with DFactura.mtFacturas_Det do
  begin
    First;
    DFactura.mtFacturas_Cab.Open ;
    while not Eof do
    begin
      if (sFactura = '') or (sFactura <> FieldByName('fac_interno_fd').AsString) then
      begin

        RDatosClienteFac := GetDatosCliente(DFactura.mtFacturas_Det.FieldByName('cod_empresa_fac_fd').AsString,
                                            DFactura.mtFacturas_Det.FieldByName('cod_cliente_fac_fd').AsString,
                                            DFactura.mtFacturas_Det.FieldByName('cod_dir_sum_fd').AsString);
        DFactura.mtFacturas_Cab.Append;

        DFactura.mtFacturas_Cab.FieldByName('cod_empresa_fac_fc').AsString := FieldByName('cod_empresa_fac_fd').AsString;
        DFactura.mtFacturas_Cab.FieldByName('fac_interno_fc').asString := FieldbyName('fac_interno_fd').AsString;
        DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsDateTime := FieldByName('fecha_fac_fd').AsDateTime;
        DFactura.mtFacturas_Cab.FieldByName('impuesto_fc').AsString := Copy(QSeleccion.FieldByName('tipo_impuesto_f').AsString, 1, 1);
        DFactura.mtFacturas_Cab.FieldByName('tipo_factura_fc').AsString := QSeleccion.FieldByName('tipo_factura_f').AsString;
        if QSeleccion.FieldByName('concepto_f').AsString = 'A' then
          DFactura.mtFacturas_Cab.FieldByName('automatica_fc').asInteger := 1
        else
          DFactura.mtFacturas_Cab.FieldByName('automatica_fc').asInteger := 0;
        DFactura.mtFacturas_Cab.FieldByName('anulacion_fc').asInteger := QSeleccion.FieldByName('anulacion_f').AsInteger;
        DFactura.mtFacturas_Cab.FieldByName('cod_factura_anula_fc').AsString := '';
        DFactura.mtFacturas_Cab.FieldByName('cod_cliente_fc').AsString := FieldByname('cod_cliente_fac_fd').AsString;
        DFactura.mtFacturas_Cab.FieldByName('des_cliente_fc').AsString := RDatosClienteFac.sDesCliente;
        DFactura.mtFacturas_Cab.FieldByName('cta_cliente_fc').AsString := RDatosClienteFac.sCtaCliente;
        DFactura.mtFacturas_Cab.FieldByName('nif_fc').AsString := RDatosClienteFac.sNIFCliente;
        DFactura.mtFacturas_Cab.FieldByName('tipo_via_fc').AsString := RDatosClienteFac.sTipoVia;
        DFactura.mtFacturas_Cab.FieldByName('domicilio_fc').AsString := RDatosClienteFac.sDomicilio;
        DFactura.mtFacturas_Cab.FieldByName('poblacion_fc').AsString := RDatosClienteFac.sPoblacion;
        DFactura.mtFacturas_Cab.FieldByName('cod_postal_fc').AsString := RDatosClienteFac.sCodPostal;
        if RDatosClienteFac.sCodPais = 'ES' then
          DFactura.mtFacturas_Cab.FieldByName('provincia_fc').AsString := RDatosClienteFac.sProvincia
        else
          DFactura.mtFacturas_Cab.FieldByName('provincia_fc').AsString := '';
        DFactura.mtFacturas_Cab.FieldByName('cod_pais_fc').AsString := RDatosClienteFac.sCodPais;
        DFactura.mtFacturas_Cab.FieldByName('des_pais_fc').AsString := RDatosClienteFac.sDesPais;

        DFactura.mtFacturas_Cab.FieldByName('incoterm_fc').Asstring := FieldByName('incoterm_fd').AsString;
        DFactura.mtFacturas_Cab.FieldByName('plaza_incoterm_fc').AsString := FieldByName('plaza_incoterm_fd').AsString;
        DFactura.mtFacturas_Cab.FieldByName('forma_pago_fc').AsString := RDatosClienteFac.sFormaPago;
        DFactura.mtFacturas_Cab.FieldByName('des_forma_pago_fc').AsString := desFormaPagoEx(RDatosClienteFac.sFormaPago);
        DFactura.mtFacturas_Cab.FieldByName('tipo_impuesto_fc').AsString := QSeleccion.FieldByName('tipo_impuesto_f').AsString;
        DFactura.mtFacturas_Cab.FieldByName('des_tipo_impuesto_fc').AsString := DesImpuesto(FieldByName('tipo_iva_fd').AsString);
        DFactura.mtFacturas_Cab.FieldByName('moneda_fc').AsString := QSeleccion.FieldByName('moneda_f').AsString;
        DFactura.mtFacturas_Cab.FieldByName('prevision_cobro_fc').AsDateTime := QSeleccion.FieldByName('prevision_cobro_f').AsDateTime;
        if QSeleccion.FieldByName('contabilizado_f').AsString = 'N' then
          DFactura.mtFacturas_Cab.FieldByName('contabilizado_fc').AsInteger := 0
        else
          DFactura.mtFacturas_Cab.FieldByName('contabilizado_fc').AsInteger := 1;
        DFactura.mtFacturas_Cab.FieldByName('fecha_conta_fc').AsString := '';
        DFactura.mtFacturas_Cab.FieldByName('filename_conta_fc').AsString := QSeleccion.FieldByName('filename_conta_f').AsString;

        DFactura.mtFacturas_Cab.FieldByName('cod_factura_fc').Asstring := DFactura.mtFacturas_Det.FieldByName('cod_factura_fd').AsString;
        DFactura.mtFacturas_Cab.FieldByName('n_factura_fc').AsInteger := DFactura.mtFacturas_Det.FieldByName('fac_interno_fd').AsInteger;
        if (QSeleccion.FieldByName('concepto_f').AsString = 'A') and
           (QSeleccion.FieldByName('anulacion_f').AsInteger = 0) then
          DFactura.mtFacturas_Cab.FieldByName('notas_fc').AsString := QSeleccion.FieldByName('nota_albaran_f').AsString
        else
        begin
          if QFactManual.Active then
            QFactManual.Close;

          QFactManual.Parambyname('empresa').AsString := QSeleccion.FieldByName('empresa_f').AsString;
          QFactManual.Parambyname('factura').AsInteger := QSeleccion.FieldByName('n_factura_f').AsInteger;
          QFactManual.Parambyname('fecha').AsDateTime := QSeleccion.FieldByName('fecha_factura_f').AsDateTime;

          QFactManual.Open;

          DFactura.mtFacturas_Cab.FieldByName('notas_fc').AsString := QFactManual.FieldByName('texto_fm').AsString;
        end;

        DFactura.mtFacturas_Cab.Post;
      end;
      sFactura := FieldByName('fac_interno_fd').AsString;
      Next;
    end;
  end;
end;

procedure TFFacturacion.RellenaDesdeFactura;
var RDatosClienteFac: TRDatosClienteFac;
begin
  DFactura.mtFacturas_Cab.Open ;

  RDatosClienteFac := GetDatosCliente(QSeleccion.FieldByName('empresa_f').AsString,
                                      QSeleccion.FieldByName('cliente_fac_f').AsString,
                                      '');
  DFactura.mtFacturas_Cab.Append;

  DFactura.mtFacturas_Cab.FieldByName('cod_empresa_fac_fc').AsString := QSeleccion.FieldByName('empresa_f').AsString;
  DFactura.mtFacturas_Cab.FieldByName('fac_interno_fc').asString := QSeleccion.FieldbyName('n_factura_f').AsString;
  DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsDateTime := QSeleccion.FieldByName('fecha_factura_f').AsDateTime;
  DFactura.mtFacturas_Cab.FieldByName('impuesto_fc').AsString := Copy(QSeleccion.FieldByName('tipo_impuesto_f').AsString, 1, 1);
  DFactura.mtFacturas_Cab.FieldByName('tipo_factura_fc').AsString := QSeleccion.FieldByName('tipo_factura_f').AsString;
  if QSeleccion.FieldByName('concepto_f').AsString = 'A' then
    DFactura.mtFacturas_Cab.FieldByName('automatica_fc').asInteger := 1
  else
    DFactura.mtFacturas_Cab.FieldByName('automatica_fc').asInteger := 0;
  DFactura.mtFacturas_Cab.FieldByName('anulacion_fc').asInteger := QSeleccion.Fieldbyname('anulacion_f').AsInteger;
  DFactura.mtFacturas_Cab.FieldByName('cod_factura_anula_fc').AsString := '';
  DFactura.mtFacturas_Cab.FieldByName('cod_cliente_fc').AsString := QSeleccion.FieldByname('cliente_fac_f').AsString;
  DFactura.mtFacturas_Cab.FieldByName('des_cliente_fc').AsString := RDatosClienteFac.sDesCliente;
  DFactura.mtFacturas_Cab.FieldByName('cta_cliente_fc').AsString := RDatosClienteFac.sCtaCliente;
  DFactura.mtFacturas_Cab.FieldByName('nif_fc').AsString := RDatosClienteFac.sNIFCliente;
  DFactura.mtFacturas_Cab.FieldByName('tipo_via_fc').AsString := RDatosClienteFac.sTipoVia;
  DFactura.mtFacturas_Cab.FieldByName('domicilio_fc').AsString := RDatosClienteFac.sDomicilio;
  DFactura.mtFacturas_Cab.FieldByName('poblacion_fc').AsString := RDatosClienteFac.sPoblacion;
  DFactura.mtFacturas_Cab.FieldByName('cod_postal_fc').AsString := RDatosClienteFac.sCodPostal;
  if RDatosClienteFac.sCodPais = 'ES' then
    DFactura.mtFacturas_Cab.FieldByName('provincia_fc').AsString := RDatosClienteFac.sProvincia
  else
    DFactura.mtFacturas_Cab.FieldByName('provincia_fc').AsString := '';
  DFactura.mtFacturas_Cab.FieldByName('cod_pais_fc').AsString := RDatosClienteFac.sCodPais;
  DFactura.mtFacturas_Cab.FieldByName('des_pais_fc').AsString := RDatosClienteFac.sDesPais;

  DFactura.mtFacturas_Cab.FieldByName('incoterm_fc').Asstring := '';
  DFactura.mtFacturas_Cab.FieldByName('plaza_incoterm_fc').AsString := '';
  DFactura.mtFacturas_Cab.FieldByName('forma_pago_fc').AsString := RDatosClienteFac.sFormaPago;
  DFactura.mtFacturas_Cab.FieldByName('des_forma_pago_fc').AsString := desFormaPagoEx(RDatosClienteFac.sFormaPago);
  DFactura.mtFacturas_Cab.FieldByName('tipo_impuesto_fc').AsString := QSeleccion.FieldByName('tipo_impuesto_f').AsString;
  DFactura.mtFacturas_Cab.FieldByName('des_tipo_impuesto_fc').AsString := DesImpuesto(QSeleccion.FieldByName('tipo_impuesto_f').AsString);
  DFactura.mtFacturas_Cab.FieldByName('moneda_fc').AsString := QSeleccion.FieldByName('moneda_f').AsString;
  DFactura.mtFacturas_Cab.FieldByName('prevision_cobro_fc').AsDateTime := QSeleccion.FieldByName('prevision_cobro_f').AsDateTime;
  if QSeleccion.FieldByName('contabilizado_f').AsString = 'N' then
    DFactura.mtFacturas_Cab.FieldByName('contabilizado_fc').AsInteger := 0
  else
    DFactura.mtFacturas_Cab.FieldByName('contabilizado_fc').AsInteger := 1;
  DFactura.mtFacturas_Cab.FieldByName('fecha_conta_fc').AsString := '';
  DFactura.mtFacturas_Cab.FieldByName('filename_conta_fc').AsString := QSeleccion.FieldByName('filename_conta_f').AsString;

  DFactura.mtFacturas_Cab.FieldByName('cod_factura_fc').Asstring := NewCodigoFactura(QSeleccion.Fieldbyname('empresa_f').AsString,
                                                                                     QSeleccion.FieldByName('tipo_factura_f').AsString,
                                                                                     Copy(QSeleccion.FieldByName('tipo_impuesto_f').AsString,1,1),
                                                                                     QSeleccion.FieldByName('fecha_factura_f').AsDateTime,
                                                                                     QSeleccion.FieldByName('n_factura_f').AsInteger );
  DFactura.mtFacturas_Cab.FieldByName('n_factura_fc').AsInteger := QSeleccion.FieldByName('n_factura_f').AsInteger;
  if (QSeleccion.FieldByName('concepto_f').AsString = 'A') and
     (QSeleccion.FieldByName('anulacion_f').AsInteger = 0) then
    DFactura.mtFacturas_Cab.FieldByName('notas_fc').AsString := QSeleccion.FieldByName('nota_albaran_f').AsString
  else
  begin
    if QFactManual.Active then
      QFactManual.Close;

    QFactManual.Parambyname('empresa').AsString := QSeleccion.FieldByName('empresa_f').AsString;
    QFactManual.Parambyname('factura').AsInteger := QSeleccion.FieldByName('n_factura_f').AsInteger;
    QFactManual.Parambyname('fecha').AsDateTime := QSeleccion.FieldByName('fecha_factura_f').AsDateTime;

    QFactManual.Open;

    DFactura.mtFacturas_Cab.FieldByName('notas_fc').AsString := QFactManual.FieldByName('texto_fm').AsString;
  end;

//  DFactura.mtFacturas_Cab.FieldByName('notas_fc').AsString := QSeleccion.FieldByName('nota_albaran_f').AsString;

  DFactura.mtFacturas_Cab.Post;
end;

procedure TFFacturacion.RellenaMemGastosFacturas;
begin
  with DFactura.QGeneral do
  begin
    First;
    DFactura.mtFacturas_Gas.Open ;
    while not Eof do
    begin
      DFactura.mtFacturas_Gas.Append;

      DFactura.mtFacturas_Gas.FieldByName('cod_empresa_albaran_fg').AsString := FieldByName('empresa_g').asString;
      DFactura.mtFacturas_Gas.FieldByName('cod_centro_albaran_fg').AsString := FieldByName('centro_salida_g').asString;
      DFactura.mtFacturas_Gas.FieldByName('n_albaran_fg').AsString := FieldByName('n_albaran_g').asString;
      DFactura.mtFacturas_Gas.FieldByName('fecha_albaran_fg').AsDateTime := FieldByName('fecha_g').asDateTime;
      DFactura.mtFacturas_Gas.FieldByName('cod_tipo_gasto_fg').AsString := FieldByName('tipo_g').asString;
      DFactura.mtFacturas_Gas.FieldByName('des_tipo_gasto_fg').AsString := FieldByName('descripcion_tg').asString;
      DFactura.mtFacturas_Gas.FieldByName('importe_neto_fg').AsFloat := FieldByName('importe_g').AsFloat;
      DFactura.mtFacturas_Gas.FieldByName('tasa_impuesto_fg').AsInteger := FieldByName('tipo_iva_tg').AsInteger;
      DFactura.mtFacturas_Gas.FieldByName('porcentaje_impuesto_fg').AsFloat := FieldByName('porcentaje_iva').AsFloat;
      DFactura.mtFacturas_Gas.FieldByName('importe_impuesto_fg').AsFloat := bRoundTo(DFactura.mtFacturas_Gas.FieldByName('importe_neto_fg').AsFloat *
                                                                                          DFactura.mtFacturas_Gas.FieldByName('porcentaje_impuesto_fg').AsFloat/100, 2);
      DFactura.mtFacturas_Gas.FieldByName('importe_total_fg').AsFloat := DFactura.mtFacturas_Gas.FieldByName('importe_neto_fg').AsFloat +
                                                                              DFactura.mtFacturas_Gas.FieldByName('importe_impuesto_fg').AsFloat;
      DFactura.mtFacturas_Gas.FieldByName('cod_empresa_fac_fg').AsString := DFactura.mtFacturas_Det.FieldByName('cod_empresa_fac_fd').AsString;
      DFactura.mtFacturas_Gas.FieldByName('fecha_fac_fg').AsDateTime := DFactura.mtFacturas_Det.FieldByName('fecha_fac_fd').AsDateTime;
      DFactura.mtFacturas_Gas.FieldByName('fac_interno_fg').AsString := DFactura.mtFacturas_Det.FieldByName('fac_interno_fd').AsString;

      DFactura.mtFacturas_Gas.FieldByName('cod_factura_fg').AsString := DFactura.mtFacturas_Det.FieldByName('cod_factura_fd').AsString;

      DFactura.mtFacturas_Gas.Post;

      Next;
    end;
  end;
end;

procedure TFFacturacion.RellenaMemBaseFacturas(ARImpBases: TRImpBases);
var i, iBases: Integer;
begin
  iBases := Length(ARImpBases.aRImportes);
  DFactura.mtFacturas_Bas.Open ;

  i := 0;
  while i < iBases do
  begin
    DFactura.mtFacturas_Bas.Append;

    DFactura.mtFacturas_Bas.FieldByName('cod_factura_fb').AsString := ARImpBases.aRImportes[i].sCodFactura;

    DFactura.mtFacturas_Bas.FieldByName('cod_empresa_fac_fb').AsString := ARImpBases.aRImportes[i].sEmpresa;
    DFactura.mtFacturas_Bas.FieldByName('fecha_fac_fb').AsString := ARImpBases.aRImportes[i].sFecha;
    DFactura.mtFacturas_Bas.FieldByName('fac_interno_fb').AsString := ARImpBases.aRImportes[i].sNumero;

    DFactura.mtFacturas_Bas.FieldByName('tasa_impuesto_fb').AsInteger := ARImpBases.aRImportes[i].iTasaImpuesto;
    DFactura.mtFacturas_Bas.FieldByName('porcentaje_impuesto_fb').AsFloat := ARImpBases.aRImportes[i].rPorcentajeImpuesto;
    DFactura.mtFacturas_Bas.FieldByName('cajas_fb').AsInteger := ARImpBases.aRImportes[i].iCajas;
    DFactura.mtFacturas_Bas.FieldByName('unidades_fb').AsInteger := ARImpBases.aRImportes[i].iUnidades;
    DFactura.mtFacturas_Bas.FieldByName('kilos_fb').AsFloat := ARImpBases.aRImportes[i].rKilos;
    DFactura.mtFacturas_Bas.FieldByName('importe_neto_fb').AsFloat := ARImpBases.aRImportes[i].rImporteNeto;
    DFactura.mtFacturas_Bas.FieldByName('importe_impuesto_fb').AsFloat := ARImpBases.aRImportes[i].rImporteImpuesto;
    DFactura.mtFacturas_Bas.FieldByName('importe_total_fb').AsFloat := ARImpBases.aRImportes[i].rImporteTotal;

    DFactura.mtFacturas_Bas.Post;

    Inc(i)
  end;
end;

procedure TFFacturacion.RellenaMemLineasFacturasManual;
  var rComision, rDescuento, rImpuesto,
    rImpComision, rImpDescuento: real;
    iNumLinea: integer;
begin
  iNumLinea := 1;
  with DFactura.QGeneral do
  begin
    if QDatosAlbaran.Active then
      QDatosAlbaran.Close;

    QDatosAlbaran.ParamByName('empresa').AsString := DFactura.QGeneral.FieldByName('empresa_fal').AsString;
    QDatosAlbaran.ParamByName('fecha').AsDateTime := DFactura.QGeneral.FieldByName('fecha_albaran_fal').AsDateTime;
    QDatosAlbaran.ParamByName('albaran').AsInteger := DFactura.QGeneral.FieldByName('n_albaran_fal').AsInteger;
    QDatosAlbaran.ParamByName('centro').AsString := DFactura.QGeneral.FieldByName('centro_salida_fal').AsString;
    QDatosAlbaran.ParamByName('producto').AsString := DFactura.QGeneral.FieldByName('producto_fal').AsString;
    QDatosAlbaran.ParamByName('envase').AsString := DFactura.QGeneral.FieldByName('envase_fal').AsString;
    QDatosAlbaran.ParamByName('categoria').AsString := DFactura.QGeneral.FieldByName('categoria_fal').AsString;

    QDatosAlbaran.Open;

    First;
    DFactura.mtFacturas_Det.Open ;
    while not Eof do
    begin

      DFactura.mtFacturas_Det.Append;

      DFactura.mtFacturas_Det.FieldByName('cod_empresa_albaran_fd').asString := FieldByName('empresa_fal').asString;
      DFactura.mtFacturas_Det.FieldByName('cod_centro_albaran_fd').asString := FieldByName('centro_salida_fal').asString;
      DFactura.mtFacturas_Det.FieldByName('n_albaran_fd').asInteger := FieldByName('n_albaran_fal').AsInteger;
      DFactura.mtFacturas_Det.FieldByName('fecha_albaran_fd').asDateTime := FieldByName('fecha_albaran_fal').aSDateTime;
      DFactura.mtFacturas_Det.FieldByName('cod_cliente_albaran_fd').asString := FieldByName('cliente_sal_f').asString;
      DFactura.mtFacturas_Det.FieldByName('cod_dir_sum_fd').AsString := QDatosAlbaran.FieldByName('dir_sum_sc').AsString;
      DFactura.mtFacturas_Det.FieldByName('pedido_fd').AsString:= QDatosAlbaran.FieldByName('n_pedido_sc').AsString;
      DFactura.mtFacturas_Det.FieldByName('matricula_fd').AsString := QDatosAlbaran.FieldByName('vehiculo_sc').AsString;
      DFactura.mtFacturas_Det.FieldByName('emp_procedencia_fd').AsString := QDatosAlbaran.FieldByName('emp_procedencia_sl').AsString;
      DFactura.mtFacturas_Det.FieldByName('centro_origen_fd').AsString := FieldByName('centro_origen_fal').AsString;
      DFactura.mtFacturas_Det.FieldByName('cod_producto_fd').AsString := FieldByName('producto_fal').AsString;
      DFactura.mtFacturas_Det.FieldByName('des_producto_fd').AsString := DescripcionProducto;
      DFactura.mtFacturas_Det.FieldByName('cod_envase_fd').AsString := FieldByName('envase_fal').AsString;
      DFactura.mtFacturas_Det.FieldByName('des_envase_fd').AsString := DescripcionEnvase(FieldByname('empresa_fal').AsString,
                                                                                         FieldByname('producto_fal').AsString,
                                                                                         FieldByname('envase_fal').AsString,
                                                                                         FieldByname('cliente_sal_f').AsString);
      DFactura.mtFacturas_Det.FieldByName('categoria_fd').AsString := FieldByName('categoria_fal').AsString;
      DFactura.mtFacturas_Det.FieldByName('calibre_fd').AsString := QDatosAlbaran.FieldByName('calibre_sl').AsString;
      DFactura.mtFacturas_Det.FieldByName('marca_fd').AsString := QDatosAlbaran.FieldByName('marca_sl').AsString;
      DFactura.mtFacturas_Det.FieldByName('nom_marca_fd').AsString := DescripcionMarca(QDatosAlbaran.FieldByName('marca_sl').AsString);
      DFactura.mtFacturas_Det.FieldByName('cajas_fd').AsInteger := 0;
      DFactura.mtFacturas_Det.FieldByName('unidades_fd').AsInteger := 0;
      DFactura.mtFacturas_Det.FieldByName('kilos_fd').AsFloat := 0;
      if FieldByName('unidad_fal').AsString = 'CAJ' then
        DFactura.mtFacturas_Det.FieldByName('cajas_fd').AsInteger := FieldByName('unidades').AsInteger
      else if FieldByName('unidad_fal').AsString = 'UND' then
        DFactura.mtFacturas_Det.FieldByName('unidades_fd').AsInteger := FieldByName('unidades').AsInteger
      else if FieldbyName('unidad_fal').AsString = 'KGS' then
        DFactura.mtFacturas_Det.FieldByName('kilos_fd').AsFloat := FieldByName('unidades').AsFloat;

      DFactura.mtFacturas_Det.FieldByName('unidades_caja_fd').AsInteger := QDatosAlbaran.FieldByName('unidades_caja_sl').AsInteger;
      if FieldByName('unidad_fal').AsString = '' then
        DFactura.mtFacturas_Det.FieldByName('unidad_facturacion_fd').AsString := 'IMP'
      else
        DFactura.mtFacturas_Det.FieldByName('unidad_facturacion_fd').AsString := FieldByName('unidad_fal').AsString;
      DFactura.mtFacturas_Det.FieldByName('precio_fd').AsFloat := FieldByName('precio_fal').AsFloat;
      DFactura.mtFacturas_Det.FieldByName('importe_linea_fd').AsFloat := FieldByName('importe_neto').AsFloat;
      DFactura.mtFacturas_Det.FieldByName('cod_representante_fd').AsString := FieldbyName('representante_c').AsString;

      rComision := 0;
      rDescuento := 0;
      rImpComision := 0;
      rImpDescuento := 0;
{
      rComision := GetPorcentajeComision(FieldByName('empresa_fal').AsString,
                                         FieldByName('representante_c').AsString,
                                         FieldByName('fecha_factura_f').AsDatetime);
      rDescuento:= GetPorcentajeDescuento(FieldByName('empresa_fal').AsString,
                                          FieldByName('cliente_sal_f').asString,
                                          FieldByName('centro_salida_fal').asString,
                                          FieldByName('producto_fal').AsString,
                                          FieldByName('fecha_factura_f').AsDatetime);

      rImpComision := bRoundTo(FieldByName('importe_neto').AsFloat * rComision/100, 2);
      rImpDescuento:= bRoundTo((FieldByName('importe_neto').AsFloat - rImpComision) * rDescuento/100, 2);
}

      DFactura.mtFacturas_Det.FieldByName('porcentaje_comision_fd').AsFloat := rComision;
      DFactura.mtFacturas_Det.FieldByName('porcentaje_descuento_fd').AsFloat := rDescuento;
      DFactura.mtFacturas_Det.FieldByName('importe_comision_fd').AsFloat := rImpComision;
      DFactura.mtFacturas_Det.FieldByName('importe_descuento_fd').AsFloat := rImpDescuento;
      DFactura.mtFacturas_Det.FieldByName('importe_total_descuento_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('importe_comision_fd').AsFloat +
                                                                                   DFactura.mtFacturas_Det.FieldByName('importe_descuento_fd').AsFloat;
      DFactura.mtFacturas_Det.FieldByName('importe_neto_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('importe_linea_fd').AsFloat -
                                                                             DFactura.mtFacturas_Det.FieldByName('importe_total_descuento_fd').AsFloat;
      DFactura.mtFacturas_Det.FieldByName('tasa_impuesto_fd').AsInteger := FieldByName('tipo_iva_e').AsInteger;
      rImpuesto := QDatosAlbaran.FieldByName('porc_iva_sl').AsFloat;
      DFactura.mtFacturas_Det.FieldByName('porcentaje_impuesto_fd').AsFloat := rImpuesto;
      DFactura.mtFacturas_Det.FieldByName('importe_impuesto_fd').AsFloat := bRoundTo(DFactura.mtFacturas_Det.FieldByName('importe_neto_fd').AsFloat * rImpuesto/100, 2);
      DFactura.mtFacturas_Det.FieldByName('importe_total_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('importe_neto_fd').AsFloat +
                                                                              DFactura.mtFacturas_Det.FieldByName('importe_impuesto_fd').AsFloat;

      DFactura.mtFacturas_Det.FieldByName('cod_empresa_fac_fd').AsString := FieldByName('empresa_f').asString;
      DFactura.mtFacturas_Det.FieldByName('fecha_fac_fd').AsDateTime := FieldByName('fecha_factura_f').AsDateTime;
      DFactura.mtFacturas_Det.FieldByName('cod_cliente_fac_fd').AsString := FieldByName('cliente_fac_f').AsString;
      DFactura.mtFacturas_Det.FieldByName('moneda_fd').AsString := QDatosAlbaran.FieldByName('moneda_sc').AsString;
      DFactura.mtFacturas_Det.FieldByName('tipo_iva_fd').AsString := QDatosAlbaran.FieldByName('tipo_iva_sl').AsString;
      if QDatosAlbaran.FieldByName('porte_bonny_sc').asInteger = 1 then
      begin
        DFactura.mtFacturas_Det.FieldByName('incoterm_fd').AsString := QDatosAlbaran.FieldByName('incoterm_sc').AsString;
        DFactura.mtFacturas_Det.FieldByName('plaza_incoterm_fd').AsString := QDatosAlbaran.FieldByName('plaza_incoterm_sc').AsString;
      end
      else
      begin
        DFactura.mtFacturas_Det.FieldByName('incoterm_fd').AsString := '';
        DFactura.mtFacturas_Det.FieldByName('plaza_incoterm_fd').AsString := '';
      end;

      DFactura.mtFacturas_Det.FieldByName('fac_interno_fd').AsInteger := FieldByName('n_factura_f').AsInteger;
      DFactura.mtFacturas_Det.FieldByName('cod_factura_fd').AsString :=
                                              NewCodigoFactura(QSeleccion.Fieldbyname('empresa_f').AsString,
                                                               QSeleccion.FieldByName('tipo_factura_f').AsString,
                                                               Copy(QSeleccion.FieldByName('tipo_impuesto_f').AsString,1,1),
                                                               QSeleccion.FieldByName('fecha_factura_f').AsDateTime,
                                                               QSeleccion.FieldByName('n_factura_f').AsInteger );
      DFactura.mtFacturas_Det.FieldByName('num_linea_fd').AsInteger := iNumLinea;
      inc(iNumLinea);

      DFactura.mtFacturas_Det.Post;

      Next;
    end;
    Close;
  end;
end;

function TFFacturacion.InsertaFacturaCabecera: boolean;
begin
  result := True;
          // Insertamos en tfacturas_cab BD
  with DFactura.QGeneral do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO tfacturas_cab ');
    SQL.Add('( cod_factura_fc, cod_empresa_fac_fc, n_factura_fc, fecha_factura_fc, ');
    SQL.Add('  impuesto_fc, tipo_factura_fc, automatica_fc, anulacion_fc, cod_factura_anula_fc, ');
    SQL.Add('  cod_cliente_fc, des_cliente_fc, cta_cliente_fc, nif_fc, ');
    SQL.Add('  tipo_via_fc, domicilio_fc, poblacion_fc, cod_postal_fc, provincia_fc, ');
    SQL.Add('  cod_pais_fc, des_pais_fc, notas_fc, incoterm_fc, ');
    SQL.Add('  plaza_incoterm_fc, forma_pago_fc, des_forma_pago_fc, tipo_impuesto_fc, ');
    SQL.Add('  des_tipo_impuesto_fc, moneda_fc, importe_linea_fc, ');
    SQL.Add('  importe_descuento_fc, importe_neto_fc, importe_impuesto_fc, ');
    SQL.Add('  importe_total_fc, importe_neto_euros_fc, importe_impuesto_euros_fc, importe_total_euros_fc, ');
    SQL.Add('  prevision_cobro_fc, contabilizado_fc, fecha_conta_fc, filename_conta_fc ) ');

    SQL.add('VALUES (');

    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('cod_factura_fc').AsString) + ', ');
//    SQL.Add(QuotedStr(ClaveFactura) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('cod_empresa_fac_fc').AsString) + ', ');
    SQL.Add(DFactura.mtFacturas_Cab.FieldByName('n_factura_fc').AsString + ', ');
//    SQL.Add(SQLNumeric(FacturaNumero) + ', ');
    SQL.Add(SQLDate(DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('impuesto_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('tipo_factura_fc').AsString) + ', ');
    SQL.Add(DFactura.mtFacturas_Cab.FieldByName('automatica_fc').AsString + ', ');
    SQL.Add(DFactura.mtFacturas_Cab.FieldByName('anulacion_fc').AsString + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('cod_factura_anula_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('cod_cliente_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('des_cliente_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('cta_cliente_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('nif_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('tipo_via_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('domicilio_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('poblacion_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('cod_postal_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('provincia_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('cod_pais_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('des_pais_fc').AsString) + ', ');
//      SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('notas_fc').AsString) + ', ');
    SQL.Add(':nota' + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('incoterm_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('plaza_incoterm_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('forma_pago_fc').AsString) + ', ');
//      SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('des_forma_pago_fc').AsString) + ', ');
    SQL.Add(':des_forma_pago' + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('tipo_impuesto_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('des_tipo_impuesto_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('moneda_fc').AsString) + ', ');
    SQL.add(SQLNumeric(DFactura.mtFacturas_Cab.FieldByName('importe_linea_fc').AsString) + ', ');
    SQL.add(SQLNumeric(DFactura.mtFacturas_Cab.FieldByName('importe_descuento_fc').AsString) + ', ');
    SQL.add(SQLNumeric(DFactura.mtFacturas_Cab.FieldByName('importe_neto_fc').AsString) + ', ');
    SQL.add(SQLNumeric(DFactura.mtFacturas_Cab.FieldByName('importe_impuesto_fc').AsString) + ', ');
    SQL.add(SQLNumeric(DFactura.mtFacturas_Cab.FieldByName('importe_total_fc').AsString) + ', ');
    SQL.add(SQLNumeric(DFactura.mtFacturas_Cab.FieldByName('importe_neto_euros_fc').AsString) + ', ');
    SQL.add(SQLNumeric(DFactura.mtFacturas_Cab.FieldByName('importe_impuesto_euros_fc').AsString) + ', ');
    SQL.add(SQLNumeric(DFactura.mtFacturas_Cab.FieldByName('importe_total_euros_fc').AsString) + ', ');
    SQL.Add(SQLDate(DFactura.mtFacturas_Cab.FieldByName('prevision_cobro_fc').AsString) + ', ');
    SQL.Add(DFactura.mtFacturas_Cab.FieldByName('contabilizado_fc').AsString + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('fecha_conta_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('filename_conta_fc').AsString) + ')');
    ParamByName('nota').DataType := ftString;
    if DFactura.mtFacturas_Cab.FieldByName('notas_fc').AsString <> '' then
      ParamByName('nota').AsString := DFactura.mtFacturas_Cab.FieldByName('notas_fc').AsString
    else
      ParamByName('nota').Clear;
    ParamByName('des_forma_pago').AsString := DFactura.mtFacturas_Cab.FieldByName('des_forma_pago_fc').AsString;

    try
      //Rellena tabla cabecera de facturacion
      EjecutarConsulta(DFactura.QGeneral);
    except
      on e: Exception do
      begin
        sMensaje := 'Error al insertar Cabecera Factura (BD).' + #13 + #10 + e.Message;
        GrabarError('008', sMensaje);
      end;
    end;
  end;
end;

function TFFacturacion.InsertaFacturaDetalle(bFactura: boolean): Boolean;
var sEmpresa, sCentro, sAlbaran, sFecha: string;
begin
  Result := True;
            //Lineas detalle Factura
  with DFactura.mtFacturas_Det do
  begin
    sEmpresa := '';
    sCentro := '';
    sAlbaran := '';
    sFecha := '';

    First;
    while not Eof do
    begin
              // Insertamos linea de detalle Factura
      with DFactura.QGeneral do
      begin
        SQL.Clear;
        SQL.Add('INSERT INTO tfacturas_det ');
        SQL.Add('( cod_factura_fd, num_linea_fd, cod_empresa_albaran_fd, cod_centro_albaran_fd, n_albaran_fd, ');
        SQL.Add('  fecha_albaran_fd, cod_cliente_albaran_fd, cod_dir_sum_fd, pedido_fd, matricula_fd, ');
        SQL.Add('  emp_procedencia_fd, centro_origen_fd, ');
        SQL.Add('  cod_producto_fd, des_producto_fd, cod_envase_fd, des_envase_fd, categoria_fd, ');
        SQL.Add('  calibre_fd, marca_fd, nom_marca_fd, cajas_fd, unidades_caja_fd, unidades_fd, ');
        SQL.Add('  kilos_fd, unidad_facturacion_fd, precio_fd, importe_linea_fd, cod_representante_fd, ');
        SQL.Add('  porcentaje_comision_fd, porcentaje_descuento_fd, importe_comision_fd, importe_descuento_fd, ');
        SQL.Add('  importe_total_descuento_fd, importe_neto_fd, ');
        SQL.Add('  tasa_impuesto_fd, porcentaje_impuesto_fd, importe_impuesto_fd, importe_total_fd ) ');

        SQL.add(' VALUES ( ');

        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('cod_factura_fd').AsString) + ', ');
        SQL.Add(DFactura.mtFacturas_Det.FieldByName('num_linea_fd').AsString + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('cod_empresa_albaran_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('cod_centro_albaran_fd').AsString) + ', ');
        SQL.Add(DFactura.mtFacturas_Det.FieldByName('n_albaran_fd').AsString + ', ');
        SQL.Add(SQLDate(DFactura.mtFacturas_Det.FieldByName('fecha_albaran_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('cod_cliente_albaran_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('cod_dir_sum_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('pedido_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('matricula_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('emp_procedencia_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('centro_origen_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('cod_producto_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('des_producto_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('cod_envase_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('des_envase_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('categoria_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('calibre_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('marca_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('nom_marca_fd').AsString) + ', ');
        SQL.Add(DFactura.mtFacturas_Det.FieldByName('cajas_fd').AsString + ', ');
        SQL.Add(DFactura.mtFacturas_Det.FieldByName('unidades_caja_fd').AsString + ', ');
        SQL.Add(DFactura.mtFacturas_Det.FieldByName('unidades_fd').AsString + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('kilos_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('unidad_facturacion_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('precio_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('importe_linea_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('cod_representante_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('porcentaje_comision_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('porcentaje_descuento_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('importe_comision_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('importe_descuento_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('importe_total_descuento_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('importe_neto_fd').AsString) + ', ');
        SQL.Add(DFactura.mtFacturas_Det.FieldByName('tasa_impuesto_fd').AsString + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('porcentaje_impuesto_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('importe_impuesto_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('importe_total_fd').AsString) + ')');

        try
          //Rellena tabla detalle de facturacion
          EjecutarConsulta(DFactura.QGeneral);
        except
          on e: Exception do
          begin
            sMensaje := 'Error al insertar Detalle Factura (BD).' + #13 + #10 + e.Message;
            GrabarError('009', sMensaje);
          end;
        end;
      end;

      if bFactura then
      begin
        if (sEmpresa = '') or (sEmpresa <> DFactura.mtFacturas_Det.FieldByName('cod_empresa_albaran_fd').AsString) or
         (sCentro <> DFactura.mtFacturas_Det.FieldByName('cod_centro_albaran_fd').AsString) or
         (sAlbaran <> DFactura.mtFacturas_Det.FieldByName('n_albaran_fd').AsString) or
         (sFecha <> DFactura.mtFacturas_Det.FieldByName('fecha_albaran_fd').AsString) then
        begin
                        // Actualizamos Cabecera albaran
          with DFactura.QGeneral do
          begin
            Cancel;
            Close;
            SQL.Clear;
            SQL.Add('UPDATE frf_salidas_c ');
            SQL.Add('SET ');
            SQL.Add('   empresa_fac_sc = ' + quotedStr(DFactura.mtFacturas_Cab.FieldByName('cod_empresa_fac_fc').AsString) + ' ,');
            SQL.Add('   fecha_factura_sc= ' + SQLDate(DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsString) + ' ,');
            SQL.Add('   n_factura_sc= ' + DFactura.mtFacturas_Cab.FieldByName('n_factura_fc').AsString + ' ');
            SQL.Add('Where empresa_sc= ' + quotedStr(DFactura.mtFacturas_Det.FieldByName('cod_empresa_albaran_fd').AsString) + ' ');
            SQL.Add('AND centro_salida_sc= ' + quotedstr(DFactura.mtFacturas_Det.FieldByName('cod_centro_albaran_fd').AsString) + ' ');
            SQL.Add('AND n_albaran_sc= ' + DFactura.mtFacturas_Det.FieldByName('n_albaran_fd').AsString + ' ');
            SQL.Add('AND fecha_sc= ' + SQLDate(DFactura.mtFacturas_Det.FieldByName('fecha_albaran_fd').AsString) + ' ');

            try
              //Rellena tabla detalle de facturacion
              EjecutarConsulta(DFactura.QGeneral);
            except
              CancelarTransaccion(DFactura.DataBase);
              result := false;
            end;
          end;
          sEmpresa := DFactura.mtFacturas_Det.FieldByName('cod_empresa_albaran_fd').AsString;
          sCentro := DFactura.mtFacturas_Det.FieldByName('cod_centro_albaran_fd').AsString;
          sAlbaran := DFactura.mtFacturas_Det.FieldByName('n_albaran_fd').AsString;
          sFecha := DFactura.mtFacturas_Det.FieldByName('fecha_albaran_fd').AsString;
        end;
      end;
      Next;
    end;
  end;

end;

function TFFacturacion.InsertaFacturaGastos: boolean;
begin
  result := True;
          //Gastos Factura
  with DFactura.mtFacturas_Gas do
  begin
    First;
    while not Eof do
    begin
      with DFactura.QGeneral do
      begin
        SQL.Clear;
        SQL.Add('INSERT INTO tfacturas_gas ');
        SQL.Add('( cod_factura_fg, cod_empresa_albaran_fg, cod_centro_albaran_fg, n_albaran_fg, ');
        SQL.Add('  fecha_albaran_fg, cod_tipo_gasto_fg, des_tipo_gasto_fg, importe_neto_fg, ');
        SQL.Add('  tasa_impuesto_fg, porcentaje_impuesto_fg, importe_impuesto_fg, importe_total_fg ) ');

        SQL.Add(' VALUES (' );

        SQL.Add(QuotedStr(DFactura.mtFacturas_Gas.FieldByName('cod_factura_fg').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Gas.FieldByName('cod_empresa_albaran_fg').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Gas.FieldByName('cod_centro_albaran_fg').AsString) + ', ');
        SQL.Add(DFactura.mtFacturas_Gas.FieldByName('n_albaran_fg').AsString + ', ');
        SQL.Add(SQLDate(DFactura.mtFacturas_Gas.FieldByName('fecha_albaran_fg').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Gas.FieldByName('cod_tipo_gasto_fg').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Gas.FieldByName('des_tipo_gasto_fg').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Gas.FieldByName('importe_neto_fg').AsString) + ', ');
        SQL.Add(DFactura.mtFacturas_Gas.FieldByName('tasa_impuesto_fg').AsString + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Gas.FieldByName('porcentaje_impuesto_fg').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Gas.FieldByName('importe_impuesto_fg').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Gas.FieldByName('importe_total_fg').AsString) + ')');

        try
          //Rellena tabla detalle de facturacion
          EjecutarConsulta(DFactura.QGeneral);
        except
          on e: Exception do
          begin
            sMensaje := 'Error al insertar Gastos Factura (BD).' + #13 + #10 + e.Message;
            GrabarError('010', sMensaje);
          end;
        end;

      end;

      Next;
    end;
  end;
end;

function TFFacturacion.InsertaFacturaBase: boolean;
begin
  result := True;
          //Base Factura
  with DFactura.mtFacturas_Bas do
  begin
    First;
    while not Eof do
    begin
      with DFactura.QGeneral do
      begin
        SQL.Clear;
        SQL.Add('INSERT INTO tfacturas_bas ');
        SQL.Add('( cod_factura_fb, tasa_impuesto_fb, porcentaje_impuesto_fb, cajas_fb,   ');
        SQL.Add('  unidades_fb, kilos_fb, importe_neto_fb, importe_impuesto_fb, importe_total_fb ) ');

        SQL.Add(' VALUES (' );

        SQL.Add(QuotedStr(DFactura.mtFacturas_Bas.FieldByName('cod_factura_fb').AsString) + ', ');
        SQL.Add(DFactura.mtFacturas_Bas.FieldByName('tasa_impuesto_fb').AsString + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Bas.FieldByName('porcentaje_impuesto_fb').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Bas.FieldByName('cajas_fb').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Bas.FieldByName('unidades_fb').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Bas.FieldByName('kilos_fb').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Bas.FieldByName('importe_neto_fb').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Bas.FieldByName('importe_impuesto_fb').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Bas.FieldByName('importe_total_fb').AsString) + ') ');

        try
          //Rellena tabla detalle de facturacion
          EjecutarConsulta(DFactura.QGeneral);
        except
          on e: Exception do
          begin
            sMensaje := 'Error al insertar Bases Factura (BD).' + #13 + #10 + e.Message;
            GrabarError('011', sMensaje);
          end;
        end;

      end;

      Next;
    end;
  end;
end;


procedure TFFacturacion.FormCreate(Sender: TObject);
begin
  DFactura := TDFactura.Create(Application);

  txGrupo.Text := 'SAT';
  AbrirBD;

  CreaQNota;
  CreaQInsError;
  CreaQDatosAlbaran;
  CreaQFactManual;
  CreaQAnulacion;
  CreaQFactura;
  CreaQExisteEmpresa;

end;

procedure TFFacturacion.FormShow(Sender: TObject);
begin
  CrearBuffers;

  gbCabecera.SetFocus;
end;

procedure TFFacturacion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BorrarListas;
end;

procedure TFFacturacion.cbEmpresaClick(Sender: TObject);
begin
  txEmpresa.Properties.ReadOnly := not cbEmpresa.Checked;
  ssEmpresa.Enabled := cbEmpresa.Checked;
  txAno.Properties.ReadOnly := not cbEmpresa.Checked;
  txFactura.Properties.ReadOnly := not cbEmpresa.Checked;
  txFecha.Properties.ReadOnly := not cbEmpresa.Checked;
end;

procedure TFFacturacion.ssEmpresaOldClick(Sender: TObject);
begin
  ssEmpresa.Execute;
end;

procedure TFFacturacion.txEmpresaPropertiesChange(Sender: TObject);
begin
  txDesEmpresa.Text := desEmpresa(txEmpresa.Text);
end;

procedure TFFacturacion.btIniciarClick(Sender: TObject);
begin
  RellenarDatosIni;
end;

procedure TFFacturacion.ssGrupoAntesEjecutar(Sender: TObject);
begin
  ssGrupo.SQLAdi := ' contabilizar_emp = 1';
end;

procedure TFFacturacion.txGrupoPropertiesChange(Sender: TObject);
begin
  txDesGrupo.Text := destEmpresa(txGrupo.Text);
end;

procedure TFFacturacion.ssEmpresaOldAntesEjecutar(Sender: TObject);
begin
  ssEmpresa.SQLAdi := ' contabilizar_e = 1';
end;

procedure TFFacturacion.txGrupoExit(Sender: TObject);
begin
  AbrirBD;
end;

procedure TFFacturacion.cbxBoxPropertiesChange(Sender: TObject);
begin
  AbrirBD;
end;

procedure TFFacturacion.ssEmpresaAntesEjecutar(Sender: TObject);
begin
  ssEmpresa.SQLAdi := ' contabilizar_e = 1';
end;

procedure TFFacturacion.cbFechasClick(Sender: TObject);
begin
  txFechaDesde.Properties.ReadOnly := not cbFechas.Checked;
  txFechaHasta.Properties.ReadOnly := not cbFechas.Checked;
end;

end.
