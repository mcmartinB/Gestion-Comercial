unit LFFacturasCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, DbTables, ActnList,
  ComCtrls, CGestionPrincipal, BEdit, Grids, DBGrids,
  BGrid, BSpeedButton, BGridButton, BCalendarButton, BCalendario, DError,
  QuickRpt;

type
  TFLFacturasCliente = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    RGAgrupar: TRadioGroup;
    ADesplegarRejilla: TAction;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    BCBHasta: TBCalendarButton;
    MEHasta: TBEdit;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    LEmpresa: TLabel;
    EEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    EDesde: TBEdit;
    EHasta: TBEdit;
    BGridButton1: TBGridButton;
    BGridButton2: TBGridButton;
    Query1: TQuery;
    QCambio: TQuery;
    QRecorrer: TQuery;
    QTemporal: TQuery;
    RGAbonos: TRadioGroup;
    cbxNacionalidad: TComboBox;
    ePais: TBEdit;
    btnPais: TBGridButton;
    Label5: TLabel;
    ESerie: TBEdit;
    BGBSerie: TBGridButton;
    procedure BBCancelarClick(Sender: TObject);
    procedure MEHastaExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure BAceptarExecute(Sender: TObject);
    procedure cbxNacionalidadChange(Sender: TObject);
  private
      {private declarations}
    orden: string;
    rFactorCambio: real;
    campo: string;

    function CamposVacios: boolean;

    procedure Total;
    function ConsultaTotal: boolean;
    procedure PrevisualizarTotal;

    procedure Desglose;
    function ConsultaDesglose: boolean;
    procedure PrevisualizarDesglose;

    procedure Semanal;
    function ConsultaSemanal: boolean;
    procedure PrevisualizarSemanal;
    procedure CambioEuroSemanal;
    procedure AgruparPorSemana(cliente: string; fecha: TDateTime; semana: integer; net, imp, tot, kil: real);
    function CrearTemporal: boolean;

    procedure CambioEuro(tabla: string);

    function PaisFactura: string;
    function PaisSalida: string;

  public
    { Public declarations }
  end;

var
  FLFacturasCliente: TFLFacturasCliente;

implementation

uses CVariables, UDMAuxDB, bTimeUtils, CReportes, Principal, CAuxiliarDB, LFacturasCliente,
  DPreview, LFacturasCliDes, LFacturasCliSem, UDMBaseDatos, UDMCambioMoneda, CFactura;

{$R *.DFM}

procedure TFLFacturasCliente.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLFacturasCliente.MEHastaExit(Sender: TObject);
begin
  if StrToDate(MEHasta.Text) < StrToDate(MEDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    MEDesde.SetFocus;
  end;
end;

procedure TFLFacturasCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFLFacturasCliente.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Text := '';
  EDesde.Text := '0';
  EHasta.Text := 'ZZZ';
  MEDesde.Text := DateToStr(Date);
  MEHasta.Text := DateTostr(Date);
  CalendarioFlotante.Date := Date;

  EEmpresa.Tag := kEmpresa;
  ESerie.Tag := kSerie;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  ePais.Tag := kPais;
  ePais.Text := 'ES';

end;

procedure TFLFacturasCliente.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLFacturasCliente.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kSerie: DespliegaRejilla(BGBSerie);
    kPais: DespliegaRejilla(btnPais, []);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLFacturasCliente.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(Eempresa.Text);
  end;
end;

function TFLFacturasCliente.CamposVacios: boolean;
begin
        //Comprobar si los campos se han rellenado correctamente
  if EEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición.');
    EEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if ESerie.Text <> '' then
  begin
    if not ExisteSErieG( ESerie.Text ) then
    begin
      ShowError('La serie indicada es incorrecta.');
      ESerie.SetFocus;
      Result := True;
      Exit;
    end;
  end;

  Result := False;
end;

procedure TFLFacturasCliente.BAceptarExecute(Sender: TObject);
begin
  if CamposVacios then Exit;

  case RGAbonos.ItemIndex of
    0: campo := '';
    1: campo := ' AND importe_total_euros_fc < 0 ';
    2: campo := ' AND importe_total_euros_fc > 0 ';
  end;

  case RGAgrupar.ItemIndex of
    0: total;
    1: desglose;
    2: semanal;
  end;
end;

procedure TFLFacturasCliente.Total;
begin
  if not ConsultaTotal then
  begin
    ShowError(' No existen datos para los parametros introducidos');
    Exit;
  end;

     //Recorrer query y realizar cambio de moneda si fuera necesario
  CambioEuro('TMP_LISTADO1');

     //Previsualar el informe
  PrevisualizarTotal;

end;

function TFLFacturasCliente.ConsultaTotal: boolean;
begin
  BorrarTemporal('TMP_FAC_CLI');
  with Query1 do
  begin
    Close;
    SQL.Clear;
    SQl.Add(' SELECT SUM(importe_neto_fc)NETO, SUM(importe_impuesto_fc)IMPUESTOS,' +
      ' SUM(importe_total_euros_fc)TOTAL, cod_cliente_fc CLIENTE_F, moneda_fc MONEDA,' +
      '  cod_empresa_fac_fc EMPRESA, cod_serie_fac_fc SERIE, fecha_factura_fc FECHA, n_factura_fc FACTURA' +
      ' FROM tfacturas_cab' +
      ' WHERE cod_empresa_fac_fc = ' + QuotedStr(EEmpresa.Text) );
    if ESerie.Text <> '' then
      SQL.Add(' AND cod_serie_fac_fc = ' + QuotedStr (ESerie.Text) );

    SQL.Add(' AND   cod_cliente_fc BETWEEN ' + QuotedStr(EDesde.text) + ' AND ' + QuotedStr(EHasta.text) +
            ' AND   fecha_factura_fc BETWEEN ' + QuotedStr(MEDesde.text) + ' AND ' + QuotedStr(MEHasta.Text) +
             campo + PaisFactura +
            ' GROUP BY cod_cliente_fc, cod_empresa_fac_fc, cod_serie_fac_fc, n_factura_fc, fecha_factura_fc, moneda_fc ' +
            ' INTO TEMP TMP_FAC_CLI');
    try
      ExecSQL;
    except
      Result := False;
      Exit;
    end;

    BorrarTemporal('TMP_SAL_CLI');
    Close;
    SQL.Clear;
    SQL.Add('SELECT SUM(KILOS_SL) KILOS, CLIENTE_FAC_SC CLIENTE_S, ' +
      '      EMPRESA_FAC_SC EMPRESA_S, SERIE_FAC_SC SERIE_S, N_FACTURA_SC FACTURA_S, FECHA_FACTURA_SC FECHA_FACTURA_S' +
      ' FROM FRF_SALIDAS_C, FRF_SALIDAS_L' +
      ' WHERE EMPRESA_FAC_SC = ' + QuotedStr(EEmpresa.Text) );
    if ESerie.Text <> '' then
      SQL.Add(' AND SERIE_FAC_SC = ' + QuotedStr(ESerie.Text) );

    SQL.Add(' AND   FECHA_FACTURA_SC BETWEEN ' + QuotedStr(MEDesde.text) + ' AND ' + QuotedStr(MEHasta.Text) +
            ' AND   CLIENTE_SAL_SC BETWEEN ' + QuotedStr(EDesde.text) + ' AND ' + QuotedStr(EHasta.text) +
            ' AND   EMPRESA_SC = EMPRESA_SL' +
            ' AND   CENTRO_SALIDA_SC = CENTRO_SALIDA_SL' +
            ' AND   N_ALBARAN_SC = N_ALBARAN_SL' +
            ' AND   FECHA_SC = FECHA_SL ' +
            ' AND es_transito_sc <> 2 ' +             //Tipo Salida: Devolucion
            PaisSalida +
    ' GROUP BY CLIENTE_FAC_SC, EMPRESA_FAC_SC, SERIE_FAC_SC, N_FACTURA_SC, FECHA_FACTURA_SC ' +
    ' INTO TEMP TMP_SAL_CLI');
    try
      ExecSQL;
    except
      Result := False;
      Exit;
    end;

    BorrarTemporal('TMP_LISTADO1');
    Close;
    SQL.Clear;

    SQL.Add(' SELECT SUM(NETO) NETO, SUM(IMPUESTOS) IMPUESTOS, ' +
      '        SUM(TOTAL) TOTAL, SUM(KILOS) KILOS, ' +
      '        MONEDA, CLIENTE_F, FECHA ' +
      ' FROM TMP_FAC_CLI, OUTER TMP_SAL_CLI ' +
      ' WHERE CLIENTE_F = CLIENTE_S' +
      ' AND   EMPRESA = EMPRESA_S ' +
      ' AND   SERIE = SERIE_S ' +
      ' AND   FECHA = FECHA_FACTURA_S' +
      ' AND   FACTURA = FACTURA_S' +
      ' group by MONEDA, CLIENTE_F, FECHA ' +
      ' INTO TEMP TMP_LISTADO1');
(*
      SQL.Add(' SELECT NETO, IMPUESTOS, TOTAL, KILOS, MONEDA, CLIENTE_F, FECHA'+
              ' FROM TMP_FAC_CLI, OUTER TMP_SAL_CLI '+
              ' WHERE CLIENTE_F = CLIENTE_S'+
              ' AND   FACTURA = FACTURA_S '+
              ' AND   FECHA = FECHA_FACTURA_S '+
              ' INTO TEMP TMP_LISTADO1');
*)
    try
      ExecSQL;
    except
      Result := False;
      BorrarTemporal('tmp_fac_cli');
      BorrarTemporal('tmp_sal_cli');
      Exit;
    end;

    BorrarTemporal('tmp_fac_cli');
    BorrarTemporal('tmp_sal_cli');

    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM TMP_LISTADO1');
    try
      Open;
    except
      Result := False;
      Exit;
    end;

      //preguntamos si la tabla esta vacia
    if EOF and BOF then
    begin
      BorrarTemporal('TMP_LISTADO1');
      Result := False;
    end
    else
    begin
      Result := True;
      Orden := 'CLIENTE_F, FECHA';
    end

  end; //es el end del WITH
end;

procedure TFLFacturasCliente.PrevisualizarTotal;
begin
    //monto la query para poder sacar el listado correcto
  with QRecorrer do
  begin
    RequestLive := False;
    Close;
    SQL.Clear;
    SQL.Add('SELECT SUM(NETO) NETO, SUM(IMPUESTOS) IMPUESTOS, ' +
      ' SUM(TOTAL) TOTAL, CLIENTE_F, SUM(KILOS) KILOS' +
      ' FROM TMP_LISTADO1' +
      ' GROUP BY CLIENTE_F' +
      ' ORDER BY CLIENTE_F');
    try
      open;
    except
      on E: EDBEngineError do
      begin
        ShowError('No se puede mostrar el listado');
        Exit;
      end;
    end;
  end;
    //llamar al QR que previsualiza el total
  QRLFActurasCliente := TQRLFacturasCliente.Create(Application);

  QRLFacturasCliente.sEmpresa:= EEmpresa.Text;
  QRLFacturasCliente.lblFechas.Caption := 'Fecha de ' + MEDesde.Text + ' a ' + MEHasta.Text;
  QRLFacturasCliente.lblClientes.Caption := 'Cliente de ' + EDesde.Text + ' a ' + EHasta.Text;
  case cbxNacionalidad.ItemIndex of
    1: QRLFacturasCliente.lblClientes.Caption := QRLFacturasCliente.lblClientes.Caption + ', nacionales';
    2: QRLFacturasCliente.lblClientes.Caption := QRLFacturasCliente.lblClientes.Caption + ', ' + desPais(ePais.Text);
    3: QRLFacturasCliente.lblClientes.Caption := QRLFacturasCliente.lblClientes.Caption + ', extranjeros';
    4: QRLFacturasCliente.lblClientes.Caption := QRLFacturasCliente.lblClientes.Caption + ', comunitarios';
    5: QRLFacturasCliente.lblClientes.Caption := QRLFacturasCliente.lblClientes.Caption + ', extracomunitarios';
  end;
  PonLogoGrupoBonnysa(QRLFacturasCliente, EEmpresa.Text);

  Preview(QRLFacturasCliente);

  QRecorrer.Close;
  Application.ProcessMessages;

end;

procedure TFLFacturasCliente.Desglose;
begin
  if not ConsultaDesglose then
  begin
    ShowError('No hay datos con los parametros introducidos');
    Exit;
  end;

  CambioEuro('TMP_LISTADO2');

  PrevisualizarDesglose;

end;

function TFLFacturasCliente.ConsultaDesglose: boolean;
begin
  BorrarTemporal('TMP_FAC_CLI');
  with Query1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' select SUM(importe_neto_fc)NETO, SUM(importe_impuesto_fc)IMPUESTOS,                 ');
    SQL.Add(' SUM(importe_total_euros_fc)TOTAL, cod_cliente_fc CLIENTE_F, moneda_fc MONEDA,       ');
    SQL.Add(' cod_empresa_fac_fc EMPRESA, cod_serie_fac_fc SERIE, n_factura_fc FACTURA, fecha_factura_fc FECHA ');
    SQL.Add(' FROM tfacturas_cab                                                                  ');
    SQL.Add(' WHERE cod_empresa_fac_fc = ' + QuotedStr(EEmpresa.Text)                              );
    if ESerie.Text <> '' then
      SQL.Add(' AND cod_serie_fac_fc = ' + QuotedStr(ESerie.Text)                                  );

    SQL.Add(' AND   cod_cliente_fc BETWEEN ' + QuotedStr(EDesde.text) + ' AND ' + QuotedStr(EHasta.text) +
            ' AND   fecha_factura_fc BETWEEN ' + QuotedStr(MEDesde.text) + ' AND ' + QuotedStr(MEHasta.Text) +
            campo + PaisFactura +
      ' GROUP BY cod_cliente_fc, cod_empresa_fac_fc, cod_serie_fac_fc, n_factura_fc, fecha_factura_fc, moneda_fc ' +
      ' INTO TEMP TMP_FAC_CLI');
    try
      ExecSQL;
    except
      Result := False;
      Exit;
    end;

    BorrarTemporal('TMP_SAL_CLI');
    Close;
    SQL.Clear;
    SQL.Add('SELECT SUM(KILOS_SL) KILOS, CLIENTE_FAC_SC CLIENTE_S, ' +
      ' EMPRESA_FAC_SC EMPRESA_S, SERIE_FAC_SC SERIE_S, N_FACTURA_SC FACTURA_S, FECHA_FACTURA_SC FECHA_S' +
      ' FROM FRF_SALIDAS_C, FRF_SALIDAS_L ' +

      ' WHERE EMPRESA_FAC_SC = ' + QuotedStr(EEmpresa.Text) );
    if ESerie.Text <> '' then
      SQL.Add(' AND SERIE_FAC_SC = ' + QuotedStr(ESerie.Text) );

    SQL.Add(' AND   FECHA_FACTURA_SC BETWEEN ' + QuotedStr(MEDesde.text) + ' AND ' + QuotedStr(MEHasta.Text) +
            ' AND   CLIENTE_SAL_SC BETWEEN ' + QuotedStr(EDesde.text) + ' AND ' + QuotedStr(EHasta.text) +

            ' AND   EMPRESA_SC = EMPRESA_SL  ' +
            ' AND   CENTRO_SALIDA_SC = CENTRO_SALIDA_SL' +
            ' AND   N_ALBARAN_SC = N_ALBARAN_SL' +
            ' AND   FECHA_SC = FECHA_SL ' +
            ' AND es_transito_sc <> 2 ' +               //Tipo Salida: Devolucion

            PaisSalida +

      ' GROUP BY CLIENTE_FAC_SC, EMPRESA_FAC_SC, SERIE_FAC_SC, N_FACTURA_SC, FECHA_FACTURA_SC ' +
      ' INTO TEMP TMP_SAL_CLI');
    try
      ExecSQL;
    except
      Result := False;
      Exit;
    end;

    BorrarTemporal('TMP_LISTADO2');
    Close;
    SQL.Clear;
    SQL.Add(' SELECT NETO, IMPUESTOS, TOTAL, KILOS, MONEDA, CLIENTE_F, EMPRESA, SERIE, FACTURA, FECHA ' +
      ' FROM TMP_FAC_CLI, OUTER TMP_SAL_CLI ' +
      ' WHERE CLIENTE_F = CLIENTE_S ' +
      ' AND EMPRESA = EMPRESA_S ' +
      ' AND SERIE = SERIE_S ' +
      ' AND FACTURA = FACTURA_S ' +
      ' AND FECHA = FECHA_S ' +
      ' INTO TEMP TMP_LISTADO2 ');
    try
      ExecSQL;
    except
      Result := False;
      Exit;
    end;

    BorrarTemporal('tmp_fac_cli');
    BorrarTemporal('tmp_sal_cli');

    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM TMP_LISTADO2 ');
    try
      Open;
    except
      Result := False;
      Exit;
    end;

      //comprobamos si la tabla esta vacia
    if EOF and BOF then
    begin
      BorrarTemporal('tmp_listado2');
      Result := False;
    end
    else
    begin
      Result := True;
      orden := ' CLIENTE_F, EMPRESA, SERIE, FECHA, FACTURA';
    end;
  end;
end;

procedure TFLFacturasCliente.PrevisualizarDesglose;
begin
    //monto la query para poder sacar el listado correcto
  with Query1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM TMP_LISTADO2 ORDER BY CLIENTE_F, FECHA, FACTURA');
    try
      open;
    except
      on E: EDBEngineError do
        ShowError(e)
    end;
  end;
  QRLFacturasCliDes := TQRLFacturasCliDes.Create(Application);
  QRLFacturasCliDes.lblFechas.Caption := 'Fecha de ' + MEDesde.Text + ' a ' + MEHasta.Text;
  QRLFacturasCliDes.lblClientes.Caption := 'Cliente de ' + EDesde.Text + ' a ' + EHasta.Text;
  case cbxNacionalidad.ItemIndex of
    1: QRLFacturasCliDes.lblClientes.Caption := QRLFacturasCliDes.lblClientes.Caption + ', nacionales';
    2: QRLFacturasCliDes.lblClientes.Caption := QRLFacturasCliDes.lblClientes.Caption + ', ' + desPais(ePais.Text);
    3: QRLFacturasCliDes.lblClientes.Caption := QRLFacturasCliDes.lblClientes.Caption + ', extranjeros';
    4: QRLFacturasCliente.lblClientes.Caption := QRLFacturasCliDes.lblClientes.Caption + ', comunitarios';
    5: QRLFacturasCliente.lblClientes.Caption := QRLFacturasCliDes.lblClientes.Caption + ', extracomunitarios';
  end;
  PonLogoGrupoBonnysa(QRLFacturasCliDes, EEmpresa.Text);
  Preview(QRLFacturasCliDes);
  Query1.Close;
  Application.ProcessMessages;

end;

procedure TFLFacturasCliente.Semanal;
begin
  if not ConsultaSemanal then
  begin
    ShowError('No hay datos con los parametros introducidos');
    Exit;
  end;
  if not CrearTemporal then Exit;

  CambioEuroSemanal;

  PrevisualizarSemanal;
end;

function TFLFacturasCliente.ConsultaSemanal: boolean;
begin
  BorrarTemporal('TMP_FAC_CLI');
  with Query1 do
  begin
    Close;
    SQL.Clear;
    SQl.Add(' SELECT SUM(importe_neto_fc)NETO, SUM(importe_impuesto_fc)IMPUESTOS,' +
      ' SUM(importe_total_euros_fc)TOTAL, cod_cliente_fc CLIENTE_F, moneda_fc MONEDA,' +
      ' cod_empresa_fac_fc EMPRESA, cod_serie_fac_fc SERIE,fecha_factura_fc FECHA, n_factura_fc FACTURA ' +
      ' FROM tfacturas_cab' +
      ' WHERE cod_empresa_fac_fc = ' + QuotedStr(EEmpresa.Text) );

    if ESerie.Text <> '' then
      SQL.Add(' AND cod_serie_fac_fc = ' + QuotedStr(ESerie.Text) );

    SQL.Add(' AND   cod_cliente_fc BETWEEN ' + QuotedStr(EDesde.text) + ' AND ' + QuotedStr(EHasta.text) +
            ' AND   fecha_factura_fc BETWEEN ' + QuotedStr(MEDesde.text) + ' AND ' + QuotedStr(MEHasta.Text) +
            campo + PaisFactura +
            ' GROUP BY cod_cliente_fc, cod_empresa_fac_fc, cod_serie_fac_fc, n_factura_fc, fecha_factura_fc, moneda_fc ' +
            ' INTO TEMP TMP_FAC_CLI');
    try
      ExecSQL;
    except
      Result := False;
      Exit;
    end;

    BorrarTemporal('TMP_SAL_CLI');
    Close;
    SQL.Clear;
    SQL.Add('SELECT SUM(KILOS_SL) KILOS, CLIENTE_FAC_SC CLIENTE_S,' +
      ' EMPRESA_FAC_SC EMPRESA_S, SERIE_FAC_SC SERIE_S, FECHA_FACTURA_SC FECHA_S, N_FACTURA_SC FACTURA_S ' +
      ' FROM FRF_SALIDAS_C, FRF_SALIDAS_L' +
      ' WHERE EMPRESA_SC = EMPRESA_SL' +
      ' AND   CENTRO_SALIDA_SC = CENTRO_SALIDA_SL' +
      ' AND   N_ALBARAN_SC = N_ALBARAN_SL' +
      ' AND   FECHA_SC = FECHA_SL ' +
      ' AND   EMPRESA_FAC_SC = ' + QuotedStr(EEmpresa.Text) );

    if ESerie.Text <> '' then
      SQL.Add(' AND SERIE_FAC_SC = ' + QuotedStr(ESerie.Text) );

    SQL.Add(' AND   FECHA_FACTURA_SC BETWEEN ' + QuotedStr(MEDesde.text) + ' AND ' + QuotedStr(MEHasta.Text) +
            ' AND   CLIENTE_FAC_SC BETWEEN ' + QuotedStr(EDesde.text) + ' AND ' + QuotedStr(EHasta.text) +
            ' AND es_transito_sc <> 2 ' +             //
            PaisSalida +
      ' GROUP BY CLIENTE_FAC_SC, EMPRESA_FAC_SC, SERIE_FAC_SC, N_FACTURA_SC, FECHA_FACTURA_SC ' +
      ' INTO TEMP TMP_SAL_CLI');
    try
      ExecSQL;
    except
      Result := False;
      Exit;
    end;

    BorrarTemporal('TMP_LISTADO3');
    Close;
    SQL.Clear;
    SQL.Add(' SELECT SUM(NETO) NETO, SUM(IMPUESTOS) IMPUESTOS, ' +
      '        SUM(TOTAL) TOTAL, SUM(KILOS) KILOS, ' +
      '        MONEDA, CLIENTE_F, FECHA ' +
      ' FROM TMP_FAC_CLI, OUTER TMP_SAL_CLI ' +
      ' WHERE CLIENTE_F = CLIENTE_S' +
      ' AND   EMPRESA = EMPRESA_S ' +
      ' AND   SERIE = SERIE_S' +
      ' AND   FECHA = FECHA_S' +
      ' AND   FACTURA = FACTURA_S' +
      ' group by MONEDA, CLIENTE_F, FECHA ' +
      ' INTO TEMP TMP_LISTADO3');
    try
      ExecSQL;
    except
      Result := False;
      Exit;
    end;

    BorrarTemporal('tmp_fac_cli');
    BorrarTemporal('tmp_sal_cli');

    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM TMP_LISTADO3');
    try
      Open;
    except
      Result := False;
      Exit;
    end;

      //preguntamos si la tabla esta vacia
    if isEmpty then
    begin
      BorrarTemporal('TMP_LISTADO3');
      Result := False;
    end
    else
    begin
      Result := True;
      Orden := 'CLIENTE_F, FECHA';
    end

  end;
end;

function TFLFacturasCliente.CrearTemporal: boolean;
begin
  BorrarTemporal('TMP_SEMANAL');
  with QTemporal do
  begin
    Close;
    SQL.Clear;
    SQL.Add('CREATE TEMP TABLE TMP_SEMANAL (' +
      ' CLI CHAR(3), ' +
      ' ANYO_SEM INTEGER, ' +
      ' KILOS DECIMAL(10,2), ' +
      ' NET DECIMAL(10,2), ' +
      ' IMP DECIMAL(10,2), ' +
      ' TOT DECIMAL(10,2))');
    try
      ExecSQL;
    except
      on E: EDBEngineError do
      begin
        ShowError(e);
        Result := False;
        Exit;
      end;
    end;
  end;
  Result := True;
end;

procedure TFLFacturasCliente.CambioEuroSemanal;
var sem, aux: integer;
  k, n, i, t: real;
  fech, fech_aux: TDateTime;
  aux_cli, cli: string;
begin
  with QRecorrer do
  begin
    RequestLive := True;
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM TMP_LISTADO3 ORDER BY ' + orden);
    try
      open;
    except
      BorrarTemporal('TMP_LISTADO3');
      exit;
    end;

    k := 0;
    n := 0;
    i := 0;
    t := 0;
    sem := Semana(FieldByName('fecha').AsDateTime);
    cli := FieldByName('cliente_f').AsString;
    fech := FieldByName('fecha').AsDateTime;
    fech_aux := fech;
    aux := sem;
    aux_cli := cli;
    while not EOF do
    begin
      if FieldByName('moneda').AsString <> 'EUR' then
      begin
        rFactorCambio:= ToEuro(FieldByName('moneda').AsString, FieldByName('fecha').AsString);
        Edit;
        FieldByName('neto').AsFloat := FieldByName('neto').AsFloat * rFactorCambio;
        FieldByName('impuestos').AsFloat := FieldByName('impuestos').AsFloat * rFactorCambio;
      end;
      if (sem <> aux) or (cli <> aux_cli) then
      begin
        AgruparPorSemana(aux_cli, fech_aux, aux, n, i, t, k);
        aux := sem;
        aux_cli := cli;
        k := FieldByName('kilos').AsFloat;
        n := FieldByName('neto').AsFloat;
        i := FieldByName('impuestos').AsFloat;
        t := FieldByName('total').AsFloat;
      end //grabar
      else
      begin
             //agrupar
        k := k + FieldByName('kilos').AsFloat;
        n := n + FieldByName('neto').AsFloat;
        i := i + FieldByName('impuestos').AsFloat;
        t := t + FieldByName('total').AsFloat;
      end;
      Next;
      sem := Semana(FieldByName('fecha').AsDateTime);
      cli := FieldByName('cliente_f').AsString;
      fech_aux := fech;
      fech := FieldByName('fecha').AsDateTime
    end;
    if (sem = aux) then
      AgruparPorSemana(aux_cli, fech_aux, aux, n, i, t, k);
    Close;
  end;
end;

procedure TFLFacturasCliente.AgruparPorSemana(cliente: string; fecha: TDateTime; semana: integer; net, imp, tot, kil: real);
var
  ano_sem: string;
begin
  ano_sem := AnyoSemana(fecha);
(*
     if Length(IntToStr(semana)) = 1 then
       ano_sem:=('0'+IntToStr(semana))
     else
       ano_sem:=IntToStr(semana);
     DecodeDate(fecha,a,m,d);
     //Si la semana es 1 y el dia es mayor que 7 se le suma uno al año para que el año-semana sea correcto
     if (ano_sem = '01') and (d > 7)then
        a:=a+1;
     //Si la semana es 52 y el dia es menor que 25 se le resta uno al año para que el año-semana sea correcto
     if (ano_sem = '52') and (d < 25)then
        a:=a-1;
     //****************************************************************************************
     ano_sem:=IntToStr(a) + ano_sem;
*)
  with QTemporal do
  begin
    Close;
    SQL.Clear;
    SQl.Add('INSERT INTO TMP_SEMANAL ' +
      ' VALUES (' +
      ' :cliente,:semana,:kilos,:neto,:impuestos,:total)');
    paramByName('cliente').AsString := Cliente;
    ParamByName('semana').AsInteger := StrToInt(ano_sem);
    ParamByName('kilos').AsFloat := kil;
    ParamByName('neto').AsFloat := net;
    ParamByName('impuestos').AsFloat := imp;
    ParamByName('total').AsFloat := tot;
    try
      ExecSQL;
    except
      raise;
    end;
  end;

end;

procedure TFLFacturasCliente.PrevisualizarSemanal;
begin
    //monto la query para poder sacar el listado correcto
  with Query1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM TMP_SEMANAL ORDER BY CLI, ANYO_SEM');
    try
      open;
    except
      on E: EDBEngineError do
        ShowError(e)
    end;
  end;
  QRLFacturasCliSem := TQRLFacturasCliSem.Create(Application);
  QRLFacturasCliSem.lblFechas.Caption := 'Fecha de ' + MEDesde.Text + ' a ' + MEHasta.Text;
  QRLFacturasCliSem.lblClientes.Caption := 'Cliente de ' + EDesde.Text + ' a ' + EHasta.Text;
  case cbxNacionalidad.ItemIndex of
    1: QRLFacturasCliSem.lblClientes.Caption := QRLFacturasCliSem.lblClientes.Caption + ', nacionales';
    2: QRLFacturasCliSem.lblClientes.Caption := QRLFacturasCliSem.lblClientes.Caption + ', ' + desPais(ePais.Text);
    3: QRLFacturasCliSem.lblClientes.Caption := QRLFacturasCliSem.lblClientes.Caption + ', extranjeros';
    4: QRLFacturasCliente.lblClientes.Caption := QRLFacturasCliente.lblClientes.Caption + ', comunitarios';
    5: QRLFacturasCliente.lblClientes.Caption := QRLFacturasCliente.lblClientes.Caption + ', extracomunitarios';
  end;
  PonLogoGrupoBonnysa(QRLFacturasCliSem, EEmpresa.Text);
  Preview(QRLFacturasCliSem);
  Query1.Close;
  Application.ProcessMessages;

end;

procedure TFLFacturasCliente.CambioEuro(tabla: string);
begin
  with QRecorrer do
  begin
    RequestLive := True;
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM ' + TABLA + ' ORDER BY ' + orden);
    try
      open;
    except
      BorrarTemporal(TABLA);
      exit;
    end;
    while not EOF do
    begin
      if FieldByName('moneda').AsString <> 'EUR' then
      begin
        rFactorCambio:= ToEuro( FieldByName('moneda').AsString, FieldByName('fecha').AsString );
        Edit;
        FieldByName('neto').AsFloat := FieldByName('neto').AsFloat * rFactorCambio;
        FieldByName('impuestos').AsFloat := FieldByName('impuestos').AsFloat * rFactorCambio;
      end;
      Next;
    end;
    Close;
  end;
end;

function TFLFacturasCliente.PaisFactura: string;
var
  pais: string;
begin
  result := '';
  case cbxNacionalidad.ItemIndex of
    1: pais := ' and pais_c = ''ES'' ';
    2: pais := ' and pais_c = ' + QuotedStr(ePais.Text);
    3: pais := ' and pais_c <> ''ES'' ';
    4: pais := ' and pais_c <> ''ES''  ' +
               ' and exists  ' +
               '      ( select *  ' +
               '        from frf_paises  ' +
               '        where comunitario_p = 1 ' +
               '         and pais_p = pais_c ) ';
    5: pais := ' and pais_c <> ''ES''  ' +
               ' and exists  ' +
               '      ( select *  ' +
               '        from frf_paises  ' +
               '        where comunitario_p = 0 ' +
               '         and pais_p = pais_c ) ';
  else exit;
  end;
  result := ' and exists ' +
    ' ( ' +
    '  select cliente_c from frf_clientes ' +
    '  where cliente_c = cod_cliente_fc ' +
    pais +
    ' ) ';
end;

function TFLFacturasCliente.PaisSalida: string;
var
  pais: string;
begin
  result := '';
  case cbxNacionalidad.ItemIndex of
    1: pais := ' and pais_c = ''ES'' ';
    2: pais := ' and pais_c = ' + QuotedStr(ePais.Text);
    3: pais := ' and pais_c <> ''ES'' ';
    4: pais := ' and pais_c <> ''ES''  ' +
               ' and exists  ' +
               '      ( select *  ' +
               '        from frf_paises  ' +
               '        where comunitario_p = 1 ' +
               '         and pais_p = pais_c ) ';
    5: pais := ' and pais_c <> ''ES''  ' +
               ' and exists  ' +
               '      ( select *  ' +
               '        from frf_paises  ' +
               '        where comunitario_p = 0 ' +
               '         and pais_p = pais_c ) ';

  else exit;
  end;
  result := ' and exists ' +
    ' ( ' +
    '  select cliente_c from frf_clientes ' +
    '  where cliente_c = cliente_fac_sc ' +
    pais +
    ' ) ';
end;

procedure TFLFacturasCliente.cbxNacionalidadChange(Sender: TObject);
begin
  ePais.Enabled := TComboBox(sender).ItemIndex = 2;
  btnPais.Enabled := ePais.Enabled;
end;

end.
