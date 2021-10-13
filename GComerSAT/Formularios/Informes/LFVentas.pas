unit LFVentas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, DBTables, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlueprint,
  dxSkinFoggy, Menus, cxButtons, SimpleSearch, cxTextEdit, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
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
  TFLVentas = class(TForm)
    Panel1: TPanel;
    GBFecha: TGroupBox;
    Desde: TLabel;
    Label14: TLabel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    GBEmpresa: TGroupBox;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    BGBEmpresa: TBGridButton;
    BGBCentro: TBGridButton;
    BGBProducto: TBGridButton;
    EProducto: TBEdit;
    ECentro: TBEdit;
    EEmpresa: TBEdit;
    STEmpresa: TStaticText;
    STCentro: TStaticText;
    STProducto: TStaticText;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    RGFactura: TRadioGroup;
    TTemporal: TTable;
    QTemporal: TQuery;
    lblEnvase: TLabel;
    stEnvase: TStaticText;
    lblCliente: TLabel;
    edtCliente: TBEdit;
    btnCliente: TBGridButton;
    stCliente: TStaticText;
    edtEnvase: TcxTextEdit;
    ssEnvase: TSimpleSearch;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure MEHastaExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function CamposVacios: boolean;
    procedure edtEnvaseExit(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
  private
    {private declarations}
    nom_tabla: string;
    rFactorCambio, neto, total, iva: real;
    procedure RecorrerQuery;

    procedure CrearTemporal;
    procedure GrabarTemporal;

    procedure Imprimir;
    function AbrirQuery: boolean;
  public
    { Public declarations }
    empresa, centro, producto, factura: string;
  end;

var
  FLVentas: TFLVentas;
  Autorizado: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, DPreview, CReportes,
  CAuxiliarDB, LVentas, UDMBaseDatos, UDMCambioMoneda, bTextUtils;

{$R *.DFM}

//                         ****  BOTONES  ****

procedure TFLVentas.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;

  Self.ActiveControl := nil;

  try
    CrearTemporal;
  except
    exit;
  end;

     {try
       AbrirQuery;
     except
       Exit;
     end;}

  if not AbrirQuery then Exit;

  RecorrerQuery;

  Imprimir;

  BorrarTemporal( nom_tabla );
end;

procedure TFLVentas.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                          **** FORMULARIO ****

procedure TFLVentas.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  MEDesde.Text := DateTostr(Date-6);
  MEHasta.Text := DateTostr(Date);
  CalendarioFlotante.Date := Date;

  EEmpresa.Tag := kEmpresa;
  ECentro.Tag := kCentro;
  EProducto.Tag := kProducto;
  edtEnvase.Tag := kEnvase;
  edtCliente.Tag := kCliente;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;


  ECentro.Text := gsDefCentro;
  EProducto.Text := gsDefProducto;
  edtCliente.Text:= '';
  edtEnvase.Text:= '';
  EEmpresa.Text := gsDefEmpresa;

  nom_tabla := gsCodigo + 'tmp_vent';
end;

procedure TFLVentas.FormActivate(Sender: TObject);
begin
  Top := 1;
  ActiveControl := EEmpresa;
end;

procedure TFLVentas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLVentas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');
  Action := caFree;
end;

//                     ****  CAMPOS DE EDICION  ****

procedure TFLVentas.MEHastaExit(Sender: TObject);
begin
  if StrToDate(MEHasta.Text) < StrToDate(MEDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    MEDesde.SetFocus;
  end;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLVentas.ADesplegarRejillaExecute(Sender: TObject);
begin
  if edtEnvase.Focused then
    ssEnvase.Execute;
  
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kCentro: DespliegaRejilla(BGBCentro, [EEmpresa.Text]);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLVentas.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa:
    begin
      STEmpresa.Caption := desEmpresa(Eempresa.Text);
      STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
      STCentro.Caption := desCentro(Eempresa.Text, Ecentro.Text);
      if edtCliente.Text = '' then
        stCliente.Caption := 'TODOS LOS CLIENTES'
      else
        stCliente.Caption := desCliente(edtCliente.Text);
      if edtEnvase.Text = '' then
        stEnvase.Caption := 'TODOS LOS ARTICULOS'
      else
        stEnvase.Caption := desEnvase(Eempresa.Text, edtEnvase.Text);
    end;
    kProducto: STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
    kCentro: STCentro.Caption := desCentro(Eempresa.Text, Ecentro.Text);
    kCliente:
    begin
      if edtCliente.Text = '' then
        stCliente.Caption := 'TODOS LOS CLIENTES'
      else
        stCliente.Caption := desCliente(edtCliente.Text);
    end;
    kEnvase:
    begin
      if edtEnvase.Text = '' then
        stEnvase.Caption := 'TODOS LOS ARTICULOS'
      else
        stEnvase.Caption := desEnvase(Eempresa.Text, edtEnvase.Text);
    end;
  end;
end;

function TFLVentas.CamposVacios: boolean;
var
  dIni, dFin: TDateTime;
begin
        //Comprobamos que los campos esten todos con datos
  if EEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if EProducto.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EProducto.SetFocus;
    Result := True;
    Exit;
  end;

  if ECentro.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    ECentro.SetFocus;
    Result := True;
    Exit;
  end;

  if stEnvase.Caption = '' then
  begin
    ShowError('El código del artículo es incorrecto');
    edtEnvase.SetFocus;
    Result := True;
    Exit;
  end;

  if stCliente.Caption = '' then
  begin
    ShowError('El código del cliente es incorrecto');
    edtCliente.SetFocus;
    Result := True;
    Exit;
  end;

  if not TryStrToDateTime( MEDesde.Text, dIni ) then
  begin
    ShowError('Fecha de inicio incorrecta');
    MEDesde.SetFocus;
    Result := True;
    Exit;
  end;

  if not TryStrToDateTime( MEHasta.Text, dFin ) then
  begin
    ShowError('Fecha de fin incorrecta');
    MEHasta.SetFocus;
    Result := True;
    Exit;
  end;

  if dIni > dFin then
  begin
    ShowError('Rango de fechas incorrecto');
    MEDesde.SetFocus;
    Result := True;
    Exit;
  end;

  Result := False;
end;

//******************************  Parte privada  *******************************

procedure TFLVentas.RecorrerQuery;
var i: integer;
  moneda: string;
begin
    //
  with DMAuxDB.QGeneral do
  begin
    First;
    moneda := FieldByName('moneda_sc').AsString;
      //moneda:= '';
    for i := 0 to RecordCount - 1 do
    begin
      rFactorCambio:= ToEuro( moneda, FieldByName('fecha_sl').AsString );
      neto := (FieldByName('neto').AsFloat * rFactorCambio);
      iva := (FieldByName('iva').AsFloat * rFactorCambio);
      total := (FieldByName('total').AsFloat * rFactorCambio);
      GrabarTemporal;
      Next;
      moneda := FieldByName('moneda_sc').AsString;
    end;
  end;
  TTemporal.Close;
end;

procedure TFLVentas.ssEnvaseAntesEjecutar(Sender: TObject);
begin
    ssEnvase.SQLAdi := '';
    if eProducto.Text <> '' then
      ssEnvase.SQLAdi := ' producto_e = ' +  QuotedStr(eProducto.Text);
end;

procedure TFLVentas.CrearTemporal;
begin
  TTemporal.TableName := nom_tabla;
  TTemporal.IndexFieldNames := 'cliente_tv;n_albaran_tv';
  if TTemporal.Exists then
  begin
    try
      BorrarTemporal( nom_tabla );
    except
      on E: EDBEngineError do
      begin
        ShowError(e);
        raise; //o intentar borrar su contenido.
      end;
    end;
  end;
  with QTemporal do
  begin
    Close;
    SQL.Clear;
    SQL.Add('CREATE TABLE ' + nom_tabla + ' (');
    SQL.Add(' n_albaran_tv integer,');
    SQL.Add(' fecha_tv date,');
    SQL.Add(' envase_tv char(9),');
    SQL.Add(' categoria_tv char(3),');
    SQL.Add(' kilos_tv DECIMAL (10,2),');
    SQL.Add(' neto_tv DECIMAL (10,2),');
    SQl.Add(' iva_tv DECIMAL (10,2),');
    SQl.Add(' total_tv DECIMAL (12,2),');
    SQl.Add(' n_factura_tv integer,');
    SQL.Add(' fecha_factura_tv date,');
    SQL.Add(' cliente_tv char(3))');
    try
      ExecSQL;
    except
      on E: EDBEngineError do
      begin
        ShowError(E);
        raise;
      end;
    end;
  end;
end;

procedure TFLVentas.edtEnvaseExit(Sender: TObject);
begin
  if EsNumerico(edtEnvase.Text) and (Length(edtEnvase.Text) <= 5) then
    if (edtEnvase.Text <> '' ) and (Length(edtEnvase.Text) < 9) then
      edtEnvase.Text := 'COM-' + Rellena( edtEnvase.Text, 5, '0');
end;

procedure TFLVentas.GrabarTemporal;
begin
   //grabar los registros con los importes convertidos a Euros.
  if not TTemporal.Active then
  begin
    try
      TTemporal.Open;
    except
      on E: EDBEngineError do
      begin
        ShowError('Error al insertar registro en la tabla temporal');
        raise;
      end;
    end;
  end;

  try
    with DMAuxDB.QGeneral do
    begin
      TTemporal.InsertRecord([FieldByName('n_albaran_sl').AsInteger,
        FieldByName('fecha_sl').AsDateTime,
          FieldByName('envase_sl').AsString,
          FieldByName('categoria_sl').AsString,
          FieldByName('kilos').AsFloat,
          neto,
          iva,
          total,
          FieldByName('n_factura_sc').AsInteger,
          FieldByName('fecha_factura_sc').AsDateTime,
          FieldByName('cliente_sal_sc').AsString]);
    end;
  except
    on E: EDBEngineError do
    begin
      ShowError('Error al insertar registro en la tabla temporal');
      raise;
    end;
  end;
end;

procedure TFLVentas.Imprimir;
begin
     //Llamamos al QReport
  QRLVentas := TQRLVentas.Create(Application);
  TTemporal.Open;
  try
    PonLogoGrupoBonnysa(QRLVentas, EEmpresa.Text);
    Preview(QRLVentas);
  finally
    DMAuxDB.QGeneral.Close;
  end;
end;

function TFLVentas.AbrirQuery: boolean;
var desde, hasta: string;
begin
  case RGFactura.ItemIndex of
    0: Factura := ' AND n_factura_sc Is Not Null';
    1: Factura := ' AND n_factura_sc Is Null';
    2: Factura := ' ';
  end;

  desde := MEDesde.Text;
  hasta := MEHasta.Text;

     //Rellenamos la SQL
  with DMAuxDB.QGeneral do
  begin
    if Active then Close;
    with SQL do
    begin
      Clear;
      Add('SELECT n_albaran_sl, fecha_sl, envase_sl, categoria_sl, ');
      Add('       SUM(importe_neto_sl) neto, SUM(iva_sl) iva,');
      Add('       SUM(importe_total_sl) total, n_factura_sc, fecha_factura_sc, ');
      Add('       cliente_sal_sc,moneda_sc, SUM( kilos_sl ) kilos ');
      Add('FROM frf_salidas_c, frf_salidas_l');
      Add('WHERE (empresa_sl = empresa_sc)');
      Add(' AND (centro_salida_sl = centro_salida_sc)');
      Add(' AND (n_albaran_sl = n_albaran_sc)');
      Add(' AND (fecha_sl = fecha_sc)');
      Add(' AND ((empresa_sl = ' + QuotedStr(Eempresa.Text) + ')');
      Add(' AND (centro_origen_sl = ' + QuotedStr(ECentro.Text) + ')');
      Add(' AND (producto_sl = ' + QuotedStr(EProducto.Text) + ')');
      Add(' AND fecha_sl BETWEEN ' + QuotedStr(desde) + ' AND ' + QuotedStr(hasta));
      if edtCliente.Text <> '' then
      begin
        if RGFactura.ItemIndex = 2 then
        begin
          Add(' AND cliente_sal_sc = ' + QuotedStr(edtCliente.Text) );
        end
        else
        begin
          Add(' AND cliente_sal_sc = ' + QuotedStr(edtCliente.Text) );
          Add(' AND (cliente_sal_sc not in ("0BO","RET","EG","REA"))');
        end;
      end
      else
      begin
        if RGFactura.ItemIndex <> 2 then
        begin
          Add(' AND (cliente_sal_sc not in ("0BO","RET","EG","REA"))');
        end;
      end;
      if edtEnvase.Text <> '' then
      begin
        Add(' AND envase_sl = ' + QuotedStr(edtEnvase.Text) );
      end;
      Add(Factura);
      Add(' AND (importe_total_sl IS NOT NULL))');

      Add('  and es_transito_sc <> 2 ');      // Tipo Salida: Devolucion

      Add(' GROUP BY cliente_sal_sc, n_albaran_sl, fecha_sl, envase_sl, categoria_sl,');
      Add(' n_factura_sc, fecha_factura_sc,moneda_sc');
      Add(' ORDER BY cliente_sal_sc, n_albaran_sl, fecha_sl,envase_sl');
    end;

    try
      Open;
    except
      on E: Exception do
      begin
        ShowError('No se pueden abrir las tablas necesarias para elaborar el informe.');
        Result := False;
        Exit;
      end;
    end;

      //Comprobar que no este vacia la tabla
    if IsEmpty then
    begin
      ShowError('No se han encontrado datos para los valores introducidos.');
      Result := False;
      Exit;
    end;
  end;
  Result := True;
end;

end.

