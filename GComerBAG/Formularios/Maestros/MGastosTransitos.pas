unit MGastosTransitos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbTables,
  DError, CVariables, StrUtils, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlueprint,
  dxSkinFoggy, Menus, cxButtons, SimpleSearch, cxTextEdit, cxDBEdit, dxSkinBlue,
  dxSkinMoneyTwins, SimpleSearch2;

type
  TFMGastosTransitos = class(TForm)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    AGastos: TActionList;
    ARejillaFlotante: TAction;
    LEmpresa: TLabel;
    LCentro: TLabel;
    PRejilla: TPanel;
    STEmpresa: TStaticText;
    STCentro: TStaticText;
    PBotones: TPanel;
    SBAceptar: TSpeedButton;
    SBCancelar: TSpeedButton;
    SBAnterior: TSpeedButton;
    SBPrimero: TSpeedButton;
    SBSiguiente: TSpeedButton;
    SBUltimo: TSpeedButton;
    SBSalir: TSpeedButton;
    SBModificar: TSpeedButton;
    AModificar: TAction;
    APrimero: TAction;
    ASiguiente: TAction;
    AAnterior: TAction;
    AUltimo: TAction;
    ASalir: TAction;
    AAceptar: TAction;
    ACancelar: TAction;
    SBAltas: TSpeedButton;
    SBBorrar: TSpeedButton;
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    STTransportista: TStaticText;
    STVehiculo: TStaticText;
    STTotalCajas: TStaticText;
    STTotalKilos: TStaticText;
    STReferencia: TStaticText;
    STFecha: TStaticText;
    LReferencia: TLabel;
    LFecha: TLabel;
    ABorrar: TAction;
    tipo_tg: TBDEdit;
    importe_tg: TBDEdit;
    STTipoGastos: TStaticText;
    LTipoGastos: TLabel;
    LImporte: TLabel;
    BGBTipoGastos: TBGridButton;
    AAlta: TAction;
    RejillaFlotante: TBGrid;
    Label1: TLabel;
    STTotalGastos: TStaticText;
    rejilla: TDBGrid;
    ACalculadora: TAction;
    AEuro: TAction;
    ANoEuro: TAction;
    AEuroConversor: TAction;
    QGastosSalida: TQuery;
    TTipoGastos: TTable;
    LProducto: TLabel;
    producto_tg: TBDEdit;
    BGBProducto: TBGridButton;
    STProducto: TStaticText;
    PModificarImporte: TPanel;
    Label3: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    btnValorFechaFactura: TBCalendarButton;
    ValorFechaFactura: TBEdit;
    valorImporteGastos: TBEdit;
    valorRefFactura: TBEdit;
    LApunte: TLabel;
    Label9: TLabel;
    btnFecha_fac_tg: TBCalendarButton;
    ref_fac_tg: TBDEdit;
    fecha_fac_tg: TBDEdit;
    Calendario: TBCalendario;
    Label11: TLabel;
    valorTransporte: TcxDBTextEdit;
    ssTrans: TSimpleSearch2;
    valordesTransporte: TStaticText;
    LTransporte: TLabel;
    transporte_tg: TcxDBTextEdit;
    ssTransporte: TSimpleSearch2;
    STTransporte: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure AAceptarExecute(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure ASalirExecute(Sender: TObject);
    procedure AUltimoExecute(Sender: TObject);
    procedure AAnteriorExecute(Sender: TObject);
    procedure ASiguienteExecute(Sender: TObject);
    procedure APrimeroExecute(Sender: TObject);
    procedure ABorrarExecute(Sender: TObject);
    procedure rejillaCellClick(Column: TColumn);
    procedure tipo_tgChange(Sender: TObject);
    procedure AAltaExecute(Sender: TObject);
    procedure AModificarExecute(Sender: TObject);
    procedure tipo_tgRequiredTime(Sender: TObject; var isTime: Boolean);
    procedure rejillaDblClick(Sender: TObject);
    procedure producto_tgChange(Sender: TObject);
    procedure btnFecha_fac_tgClick(Sender: TObject);
    procedure btnValorFechaFacturaClick(Sender: TObject);
    procedure QGastosSalidaAfterScroll(DataSet: TDataSet);
    procedure transporte_tgPropertiesChange(Sender: TObject);
    procedure ssTransporteAntesEjecutar(Sender: TObject);
    procedure valorTransportePropertiesChange(Sender: TObject);
    procedure ssTransAntesEjecutar(Sender: TObject);
    procedure PRejillaEnter(Sender: TObject);


  private
    lRF: TBGrid;
    lCF: TBCalendario;
    { Private declarations }
    //registro, registros, registrosinsertados: integer;
    // select,  where, order: string;
    // FocoLocalizar, FocoModificar: TWinCOntrol;
    estado: TEstado;
    // localizado: boolean;
    // empresa, producto: string; opcion:integer;
    salir: boolean;

    procedure botoneraDespl();

    // procedure Modificar;
    procedure AceptarAltas;
    procedure AceptarModificar;
    procedure CancelarAltas;
    procedure CancelarModificar;
    procedure cambiarEstado(estad: TEstado);
    procedure calculoGastos;
    procedure borrarDatos();
    function evaluarDatosInputs(): Boolean;

    procedure EuroConversorExecute;

    function  FechaStr( const AFecha: string ): string;
    procedure tipo_tgMod(Sender: TOBject);

  public
    { Public declarations }
    sEmpresa: string;
    sCentro: string;
    sReferencia: string;
    sTransporte: string;
    sFecha: string;
    empNom: string;
    cenNom: string;
    factu: string;
    gastoAsignado: Boolean;

    procedure descripcionCliente();
    procedure Botones;
  end;

var
//  FMGastosTransitos: TFMGastosTransitos;
  opcc: Integer;

procedure GastosTransito(AEmpresa, ACentro, AReferencia, AFecha, ATransporte: string;
  AAsignado: Boolean);

implementation

uses bDialogs, CAuxiliarDB, Principal, UDMBaseDatos, UDMAuxDB,
  bSQLUtils, DConversor, Variants;

{$R *.DFM}

function PutString( const AProducto: string ): string;
begin
  if Trim( AProducto ) = '' then
  begin
    result:= 'NULL';
  end
  else
  begin
    result:= QuotedStr( AProducto );
  end;
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMGastosTransitos.FormCreate(Sender: TObject);
begin
  Salir := false;

     //Teclas para las altas y bajas
  AAlta.ShortCut := vk_add; //mas numerico
  ABorrar.ShortCut := VK_SUBTRACT; //menos numerico
  ASalir.ShortCut := VK_ESCAPE;

     //Tamaño y posicion del formulario
  QGastosSalida.Open;
  cambiarEstado(teLocalizar);


  lRF := gRF;
  lCF := gCF;
  gRF := RejillaFlotante;
  gCF := nil;

  Botones;

  Calendario.Date:= Date;
end;

procedure TFMGastosTransitos.FormActivate(Sender: TObject);
begin
  gRF := RejillaFlotante;
  gCF := nil;
end;

procedure TFMGastosTransitos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if salir then
  begin
    QGastosSalida.Close;
    DMBaseDatos.QDespegables.Close;
    DMBaseDatos.QGeneral.Close;
    borrarDatos;

    gRF := lRF;
    gCF := lCF;

    Action := caFree;
  end
  else
  begin
    Action := caNone;
  end;
end;

procedure TFMGastosTransitos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  case key of
    vk_Return, vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
    vk_f8:
      begin
        Key := 0;
        EuroConversorExecute;
      end;
  end;
end;

procedure TFMGastosTransitos.PRejillaEnter(Sender: TObject);
begin
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMGastosTransitos.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  if NewHeight < 35 then
  begin
    ShowWindow(Application.Handle, SW_SHOWMINNOACTIVE);
    Resize := False;
  end;
end;

procedure TFMGastosTransitos.ARejillaFlotanteExecute(Sender: TObject);
begin
  if transporte_tg.Focused then
    Exit;

  if ( Estado <> teAlta ) and ( Estado <> teModificar ) then
    Exit;

  if tipo_tg.Focused then
  begin
    if DMBaseDatos.QDespegables.Active then
      DMBaseDatos.QDespegables.Close;
    DMBaseDatos.QDespegables.SQL.Clear;
    RejillaFlotante.BControl := tipo_tg;
    DMBaseDatos.QDespegables.SQL.Add('SELECT tipo_tg,descripcion_tg,facturable_tg  FROM frf_tipo_gastos ');
    DMBaseDatos.QDespegables.SQL.Add('WHERE gasto_transito_tg = 1 ');
    DMBaseDatos.QDespegables.SQL.Add(' and tipo_tg Not In ');
    DMBaseDatos.QDespegables.SQL.Add('(SELECT tipo_gt FROM frf_gastos_trans ');
    DMBaseDatos.QDespegables.SQL.Add(' WHERE empresa_gt = ' + QuotedStr(sEmpresa) + ' ');
    DMBaseDatos.QDespegables.SQL.Add(' And   centro_gt = ' + QuotedStr(sCentro) + ' ');
    DMBaseDatos.QDespegables.SQL.Add(' And   referencia_gt     = ' + sReferencia + '  ');
    if trim(sFecha) <> '' then
      DMBaseDatos.QDespegables.SQL.Add(' And   fecha_gt         =' + SQLDate(sFecha) + ' ');

    DMBaseDatos.QDespegables.SQL.Add(')and tipo_tg Not In ');
    DMBaseDatos.QDespegables.SQL.Add('(SELECT tipo_tg FROM tmp_gastos ');
    DMBaseDatos.QDespegables.SQL.Add(' WHERE empresa_tg = ' + QuotedStr(sEmpresa) + ' ');
    DMBaseDatos.QDespegables.SQL.Add(' And   centro_tg = ' + QuotedStr(sCentro) + ' ');
    DMBaseDatos.QDespegables.SQL.Add(' And   albaran_tg     = ' + sReferencia + '  ');
    if trim(sFecha) <> '' then
      DMBaseDatos.QDespegables.SQL.Add(' And   fecha_tg         =' + SQLDate(sFecha) + ' ');
    DMBaseDatos.QDespegables.SQL.Add('and usuario_tg = ' + QuotedStr(gsCodigo));
    DMBaseDatos.QDespegables.SQL.Add('And accion_tg = ' + QuotedStr('A'));
    DMBaseDatos.QDespegables.SQL.Add(')ORDER BY tipo_tg');

    DMBaseDatos.QDespegables.Open;
    BGBTipoGastos.GridShow;
  end
  else
  if producto_tg.Focused then
  begin
    if DMBaseDatos.QDespegables.Active then
      DMBaseDatos.QDespegables.Close;
    DMBaseDatos.QDespegables.SQL.Clear;
    RejillaFlotante.BControl := producto_tg;
    DMBaseDatos.QDespegables.SQL.Add('select producto_p, descripcion_p');
    DMBaseDatos.QDespegables.SQL.Add('from frf_productos');
    DMBaseDatos.QDespegables.SQL.Add('order by 2');

    DMBaseDatos.QDespegables.Open;
    BGBProducto.GridShow;
  end
  else
  if fecha_fac_tg.Focused then
  begin
    btnFecha_fac_tg.Click;
    Exit;
  end
  else
  if ValorFechaFactura.Focused then
  begin
    btnValorFechaFactura.Click;
    Exit;
  end;
end;


//***************************************************************
//Procedimientos de los botones, acciones, desplazamientos, etc..
//***************************************************************

procedure TFMGastosTransitos.AAceptarExecute(Sender: TObject);
begin
  if RejillaFlotante.Visible then
  begin
    try
      RejillaFlotante.DblClick;
    except
    end;
    Exit;
  end;
  if Calendario.Visible then
  begin
    try
      Calendario.DblClick;
      Calendario.BControl.SetFocus;
    except
    end;
    Exit;
  end;

  if Estado = teAlta then
    AceptarAltas;
  if Estado = teModificar then
    AceptarModificar;
  calculoGastos;
end;

procedure TFMGastosTransitos.ACancelarExecute(Sender: TObject);
var
  sAux: string;
begin
  if RejillaFlotante.Visible then
  begin
    try
      RejillaFlotante.Hide;
    except
    end;
    Exit;
  end;
  if Calendario.Visible then
  begin
    sAux:= Calendario.BControl.Text;
    Calendario.DblClick;
    Calendario.BControl.Text:= sAux;
    Calendario.BControl.SetFocus;
    Exit;
  end;

  calculoGastos;
  if estado = teModificar then
  begin
    CancelarModificar;
    Exit;
  end;
  if estado = teAlta then
  begin
    CancelarAltas;
    Exit;
  end;
end;

procedure TFMGastosTransitos.ASalirExecute(Sender: TObject);
begin
  if Salir then
    Close;
end;

procedure TFMGastosTransitos.AceptarAltas;
begin
  if tipo_tg.Text = '' then
  begin
    MessageDlg('Debe introducir un tipo de Gasto...', mtError, [mbOK], 0);
    tipo_tg.SetFocus;
    Exit;
  end;
  if importe_tg.Text = '' then
  begin
    MessageDlg('Debe introducir el importe del Gasto...', mtError, [mbOK], 0);
    importe_tg.SetFocus;
    Exit;
  end;
  if STProducto.Caption = '' then
  begin
    MessageDlg('Debe introducir un producto valido o dejarlo en blanco ...', mtError, [mbOK], 0);
    producto_tg.SetFocus;
    Exit;
  end;
  if STTransporte.Caption = '' then
  begin
    MessageDlg('Debe introducir un transporte ...', mtError, [mbOK], 0);
    transporte_tg.SetFocus;
    Exit;
  end;
  if evaluarDatosInputs() then
  begin
    QGastosSalida.FieldByName('empresa_tg').AsString := sEmpresa;
    QGastosSalida.FieldByName('centro_tg').AsString := sCentro;
    QGastosSalida.FieldByName('albaran_tg').AsInteger := StrToInt(sReferencia);
    QGastosSalida.FieldByName('fecha_tg').AsString := sFecha;
    QGastosSalida.FieldByName('accion_tg').AsString := 'A';
    QGastosSalida.FieldByName('usuario_tg').AsString := gsCodigo;
    QGastosSalida.FieldByName('descriptipo_tg').AsString := STTipoGastos.Caption;
    QGastosSalida.FieldByName('descriptrans_tg').AsString := STTransporte.Caption;
    QGastosSalida.FieldByName('facturable_tg').AsString := factu;
    QGastosSalida.Post;
    QGastosSalida.Close;
    QGastosSalida.Open;
    tipo_tg.SetFocus;
    QGastosSalida.Insert;
    QGastosSalida.FieldByName('transporte_tg').AsString := sTransporte;
  end;
(*
  else
  begin
    QGastosSalida.DisableControls;
    QGastosSalida.Cancel;
    tipo_tg.SetFocus;
    QGastosSalida.Insert;
    QGastosSalida.EnableControls;
  end;
*)
end;

function TFMGastosTransitos.FechaStr( const AFecha: string ): string;
begin
  if Trim( AFecha ) = '' then
    result:= 'NULL'
  else
    result:= QuotedStr(AFecha);
end;

procedure TFMGastosTransitos.CancelarAltas;
var
  import: string;
  sincronizarTabla: TQuery;
  sAux: string;
begin
  QGastosSalida.Cancel;
  cambiarEstado(teLocalizar);
  QGastosSalida.Close;
  QGastosSalida.Open;
  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM tmp_gastos');
    SQL.Add('Where usuario_tg = ' + QuotedStr(gsCodigo));
    SQL.Add('And accion_tg = ' + QuotedStr('A'));
    Open;
    sincronizarTabla := TQuery.Create(nil);
    sincronizarTabla.DatabaseName := 'BDProyecto'; ;
    while not Eof do
    begin
      if FieldByName('solo_lectura_tg').AsString = '' then
        sAux:= '0';
      import := SQLNumeric(FieldByName('importe_tg').AsString);
      sincronizarTabla.SQL.Clear;
      sincronizarTabla.SQL.Add('INSERT into frf_gastos_trans(' +
        'empresa_gt,centro_gt,referencia_gt,fecha_gt,' +
        'tipo_gt,producto_gt,importe_gt, ref_fac_gt, fecha_fac_gt, solo_lectura_gt, transporte_gt) ');
      sincronizarTabla.SQL.Add('VAlUES (' +
        QuotedStr(sEmpresa) + ',' + QuotedStr(sCentro) + ',' +
        sReferencia + ',' + SQLDate(sFecha) + ',' +
        QuotedStr(FieldByName('tipo_tg').AsString) + ',' +
        PutString( FieldByName('producto_tg').AsString ) + ',' +
        import + ',' +
        PutString( FieldByName('ref_fac_tg').AsString) + ',' +
        FechaStr( FieldByName('fecha_fac_tg').AsString) + ',' + sAux +  ',' +
        FieldByName('transporte_tg').AsString + 
        ') ');
      try
        sincronizarTabla.ExecSQL;
      except
                 //
      end;
      Next;
    end;
    sincronizarTabla.Free;
    Close;
  end;
end;



procedure TFMGastosTransitos.AceptarModificar;
var import, referencia, fecha, tipo, producto, transporte, destransporte: string;
begin
  import := SQLNumeric(valorImporteGastos.Text);
  referencia := Trim(valorRefFactura.Text);
  fecha := ValorFechaFactura.Text;
  tipo := QGastosSalida.FieldByName('tipo_tg').AsString;
  producto:= Trim(QGastosSalida.FieldByName('producto_tg').AsString);
  transporte := valorTransporte.Text;
  destransporte:=Trim(valordesTransporte.Caption);

  if not DMBaseDatos.QGeneral.Active then
    DMBaseDatos.QGeneral.Close;
  DMBaseDatos.QGeneral.SQL.Clear;
  DMBaseDatos.QGeneral.SQL.Add('UPDATE frf_gastos_trans ' +
    'SET importe_gt =' + import + ' , ' );

  if Trim(referencia) <> '' then
    DMBaseDatos.QGeneral.SQL.Add(' ref_fac_gt =' + QuotedStr(referencia) + ', ')
  else
    DMBaseDatos.QGeneral.SQL.Add(' ref_fac_gt = NULL, ');

  DMBaseDatos.QGeneral.SQL.Add(' fecha_fac_gt =' + FechaStr(fecha) + ', ' +
                               ' transporte_gt =' + transporte + ' ' +
    'Where empresa_gt = ' + QuotedStr(sEmpresa) + ' ' +
    'And   centro_gt = ' + QuotedStr(sCentro) + ' ' +
    'And   referencia_gt = ' + sReferencia + ' ' +
    'And   fecha_gt = ' + SQLDate(sFecha) + ' ' +
    'And   tipo_gt = ' + QuotedStr(tipo)  + ' ');
  if producto = '' then
  begin
    //DMBaseDatos.QGeneral.SQL.Add(' and producto_gt is null ');
    DMBaseDatos.QGeneral.SQL.Add(' and nvl(producto_gt,'''') = '''' ');
  end
  else
  begin
    DMBaseDatos.QGeneral.SQL.Add(' and producto_gt = '  + QuotedStr(producto) );
  end;
  DMBaseDatos.QGeneral.ExecSQL;

  QGastosSalida.Edit;
  QGastosSalida.FieldByName('importe_tg').AsString := valorImporteGastos.Text;
  QGastosSalida.FieldByName('ref_fac_tg').AsString := Trim(valorRefFactura.Text);
  QGastosSalida.FieldByName('fecha_fac_tg').AsString := ValorFechaFactura.Text;
  QGastosSalida.FieldByName('transporte_tg').AsString := valorTransporte.Text;
  QGastosSalida.FieldByName('descriptrans_tg').AsString := valordesTransporte.Caption;
  QGastosSalida.Post;
  QGastosSalida.Close;
  QGastosSalida.Open;

  rejilla.Enabled := True;
  PModificarImporte.Visible := False;
  if not valorImporteGastos.Enabled then
    valorImporteGastos.Enabled := True;
  PRejilla.Enabled := True;
  cambiarEstado(teLocalizar);
end;

procedure TFMGastosTransitos.CancelarModificar;
begin
        //Cancelar la operacion
        //Ocultar el edit en el que se introducirá la operacion
  cambiarEstado(teLocalizar);
  rejilla.Enabled := True;
  PModificarImporte.Visible := False;
  PRejilla.Enabled := True;
end;

procedure TFMGastosTransitos.AUltimoExecute(Sender: TObject);
begin
  //ir a la ultima posicion
  QGastosSalida.Last;
  botoneraDespl;
end;

procedure TFMGastosTransitos.AAnteriorExecute(Sender: TObject);
begin
  QGastosSalida.Prior;
  botoneraDespl;
end;

procedure TFMGastosTransitos.ASiguienteExecute(Sender: TObject);
begin
  //ir a la posicion siguiente
  QGastosSalida.Next;
  botoneraDespl;
end;

procedure TFMGastosTransitos.APrimeroExecute(Sender: TObject);
begin
  QGastosSalida.First;
  botoneraDespl;
end;

// ******************************************************************
// **                  OBTENCIÓN DE DATOS                          **
// ******************************************************************

procedure TFMGastosTransitos.descripcionCliente();
var cadTransp: string;
  cadTotCajas: string;
  cadTotKilos: string;
  TotKilos: Extended;
  TotCajas: Extended;
  QLineasAlbaran: TQuery;
begin

  TotKilos := 0;
  TotCajas := 0;

  STTransportista.Caption := '';
  STVehiculo.Caption := '';
  STTotalCajas.Caption := '';
  STTotalKilos.Caption := '';

  if ((Trim(sEmpresa) = '') or
    (Trim(sCentro) = '') or
    (Trim(sReferencia) = '') or
    (Trim(sFecha) = ''))
    then exit;

  DMBaseDatos.QGeneral.SQL.Clear;
  DMBaseDatos.QGeneral.SQL.Add('SELECT * FROM frf_transitos_c ');
  DMBaseDatos.QGeneral.SQL.Add('WHERE empresa_tc Like ' + QuotedStr(sEmpresa) + ' ');
  DMBaseDatos.QGeneral.SQL.Add('And   centro_tc Like ' + QuotedStr(sCentro) + ' ');
  DMBaseDatos.QGeneral.SQL.Add('And   referencia_tc=' + sReferencia + ' ');
  DMBaseDatos.QGeneral.SQL.Add('And   fecha_tc=' + SQLDate(sFecha) + ' ');
  DMBaseDatos.QGeneral.SQL.Add('ORDER BY empresa_tc,centro_tc,fecha_tc,referencia_tc ');
  DMBaseDatos.QGeneral.Open;

  if DMBaseDatos.QGeneral.IsEmpty then Exit;

  cadTransp := DMBaseDatos.QGeneral.FieldByName('transporte_tc').AsString;
  STVehiculo.Caption := DMBaseDatos.QGeneral.FieldByName('vehiculo_tc').AsString;

  DMBaseDatos.QGeneral.SQL.Clear;
  DMBaseDatos.QGeneral.SQL.Add('SELECT * FROM frf_transportistas ');
  DMBaseDatos.QGeneral.SQL.Add('WHERE transporte_t = ' + cadTransp);
  DMBaseDatos.QGeneral.SQL.Add('ORDER BY transporte_t');
  DMBaseDatos.QGeneral.Open;


  if not DMBaseDatos.QGeneral.IsEmpty then
    STTransportista.Caption := cadTransp + ' - ' +
      DMBaseDatos.QGeneral.FieldByName('descripcion_t').AsString;


  QLineasAlbaran := TQuery.Create(nil);
  QLineasAlbaran.DataBaseName := 'BDProyecto';
  QLineasAlbaran.SQL.Clear;
  QLineasAlbaran.RequestLive := False;
  QLineasAlbaran.SQL.Add('SELECT empresa_tl, centro_tl, referencia_tl,fecha_tl,' +
    'SUM(cajas_tl) As cajas, SUM(kilos_tl) As kilos ' +
    'FROM frf_transitos_l ');
  QLineasAlbaran.SQL.Add('GROUP BY empresa_tl, centro_tl, referencia_tl,fecha_tl ');
  QLineasAlbaran.SQL.Add('HAVING empresa_tl Like ' + QuotedStr(sEmpresa) + ' ');
  QLineasAlbaran.SQL.Add('And    centro_tl Like ' + QuotedStr(sCentro) + ' ');
  QLineasAlbaran.SQL.Add('And    referencia_tl = ' + sReferencia + ' ');
  QLineasAlbaran.SQL.Add('And    fecha_tl = ' + SQLDate(sFecha) + ' ');
  QLineasAlbaran.Open;

  if not QLineasAlbaran.IsEmpty then
  begin
    TotCajas := QLineasAlbaran.FieldByName('cajas').AsVariant;
    cadTotCajas := QLineasAlbaran.FieldByName('cajas').AsString;
    TotKilos := QLineasAlbaran.FieldByName('kilos').AsVariant;
    cadTotKilos := QLineasAlbaran.FieldByName('kilos').AsString;
  end;
  QLineasAlbaran.Close;
  QLineasAlbaran.Free;

  if trim(cadTotCajas) <> '' then STTotalCajas.Caption := FormatFloat('##,###,##0.00', TotCajas);
  if trim(cadTotKilos) <> '' then STTotalKilos.Caption := FormatFloat('##,###,##0.00', TotKilos);
  calculoGastos;
end;

procedure TFMGastosTransitos.ABorrarExecute(Sender: TObject);
var
  tipo, producto: string;
begin
  if QGastosSalida.RecordCount <= 0 then Exit;

  if MessageDlg('¿ Desea borrar el gasto seleccionado ... ?',
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  tipo := QuotedStr(QGastosSalida.FieldByName('tipo_tg').AsString);
  producto:= QGastosSalida.FieldByName('producto_tg').AsString;

  DMBaseDatos.QGeneral.SQL.Clear;
  DMBaseDatos.QGeneral.SQL.Add('DELETE FROM frf_gastos_trans');
  DMBaseDatos.QGeneral.SQL.Add('WHERE empresa_gt =' + QuotedStr(sEmpresa) + ' ' +
    'And   centro_gt = ' + QuotedStr(sCentro) + ' ' +
    'And   referencia_gt = ' + sReferencia + ' ' +
    'And   fecha_gt = ' + SQLDate(sFecha) + ' ' +
    'And   tipo_gt = ' + tipo + ' ');
  if producto <> '' then
  begin
    DMBaseDatos.QGeneral.SQL.Add('And   producto_gt = ' + QuotedStr(producto) );
  end
  else
  begin
    //DMBaseDatos.QGeneral.SQL.Add('And   producto_gt is NULL ');
    DMBaseDatos.QGeneral.SQL.Add('And   nvl(producto_gt,'''') = '''' ');
  end;
  DMBaseDatos.QGeneral.ExecSQL;
  QGastosSalida.Close;
  QGastosSalida.Open;

  DMBaseDatos.QGeneral.SQL.Clear;
  DMBaseDatos.QGeneral.SQL.Add('DELETE FROM tmp_gastos');
  DMBaseDatos.QGeneral.SQL.Add('WHERE empresa_tg =' + QuotedStr(sEmpresa) + ' ' +
    'And   centro_tg = ' + QuotedStr(sCentro) + ' ' +
    'And   albaran_tg = ' + sReferencia + ' ' +
    'And   fecha_tg = ' + SQLDate(sFecha) + ' ' +
    'And   usuario_tg = ' + QuotedStr(gsCodigo) + ' ');
  DMBaseDatos.QGeneral.SQL.Add('And tipo_tg In (' + tipo + ') ');
  if producto <> '' then
  begin
    DMBaseDatos.QGeneral.SQL.Add('And   producto_tg = ' + QuotedStr(producto) );
  end
  else
  begin
    //DMBaseDatos.QGeneral.SQL.Add('And   producto_tg is NULL ');
    DMBaseDatos.QGeneral.SQL.Add('And   nvl(producto_tg, '''') = '''' ');
  end;
  DMBaseDatos.QGeneral.ExecSQL;
  rejilla.DataSource.DataSet.Close;
  rejilla.DataSource.DataSet.Open;

  calculoGastos;
  cambiarEstado(teLocalizar);
end;

procedure TFMGastosTransitos.cambiarEstado(estad: TEstado);
var vis: Boolean;
begin
  estado := estad;
  if estad = teAlta then vis := True
  else vis := False;

  LTipoGastos.Visible := vis;
  tipo_tg.Visible := vis;

  LProducto.Visible := vis;
  producto_tg.Visible := vis;
  STProducto.Visible := vis;
  BGBProducto.Enabled := vis;

  BGBTipoGastos.Visible := vis;
  BGBProducto.Visible := vis;
  STTipoGastos.Visible := vis;

  LTransporte.Visible := vis;
  transporte_tg.Visible := vis;
  ssTransporte.Visible := vis;
  STTransporte.Visible := vis;

  LImporte.Visible := vis;
  importe_tg.Visible := vis;
  ref_fac_tg.Visible := vis;
  LApunte.Visible := vis;

  tipo_tg.Enabled := vis;
  BGBTipoGastos.Enabled := vis;

  importe_tg.Enabled := vis;
  ref_fac_tg.Enabled := vis;

  rejilla.Enabled := not vis;

  if rejilla.Enabled then
  begin
    rejilla.Top:= 16;
    rejilla.Height:= 240;
  end
  else
  begin
    rejilla.Top:= 96;
    rejilla.Height:= 160;
  end;

  APrimero.Enabled := True;
  ASiguiente.Enabled := True;
  AAnterior.Enabled := True;
  AUltimo.Enabled := True;

  if (estad = teAlta) or (estad = teModificar) then begin
    APrimero.Enabled := False;
    ASiguiente.Enabled := False;
    AAnterior.Enabled := False;
    AUltimo.Enabled := False;
    rejilla.Enabled := False;
  end;

  Botones;
end;

procedure TFMGastosTransitos.Botones;
begin
  case estado of
    teAlta:
      begin
        Salir := false;
        ASalir.ShortCut := 0;
        ACancelar.ShortCut := VK_ESCAPE;

        AModificar.Enabled := False;
        AAlta.Enabled := False;
        ABorrar.Enabled := FAlse;

        AAceptar.Enabled := True;
        ACancelar.Enabled := True;

        ASalir.Enabled := false;

        ARejillaFlotante.Enabled := true;
      end;
    teModificar:
      begin
        Salir := false;
        ASalir.ShortCut := 0;
        ACancelar.ShortCut := VK_ESCAPE;

        AModificar.Enabled := False;
        AAlta.Enabled := False;
        ABorrar.Enabled := False;

        AAceptar.Enabled := True;
        ACancelar.Enabled := True;

        ASalir.Enabled := false;

        ARejillaFlotante.Enabled := true;
      end;
    teLocalizar:
      begin
        Salir := true;
        ASalir.ShortCut := VK_ESCAPE;
        ACancelar.ShortCut := 0;

        if gastoAsignado then
        begin
          if QGastosSalida.RecordCount > 0 then
            AModificar.Enabled := True
          else
            AModificar.Enabled := False;
          ABorrar.Enabled := false;
          AAlta.Enabled := False;
          AAceptar.Enabled := false;
          ACancelar.Enabled := false;
          ASalir.Enabled := true;
          ARejillaFlotante.Enabled := True;

          botoneraDespl;
          
          Exit;
        end;

        if QGastosSalida.RecordCount > 0 then
        begin
          AModificar.Enabled := true;
          ABorrar.Enabled := true;
        end
        else
        begin
          AModificar.Enabled := false;
          ABorrar.Enabled := false;
        end;
        AAlta.Enabled := true;

        AAceptar.Enabled := false;
        ACancelar.Enabled := false;


        ASalir.Enabled := true;

        ARejillaFlotante.Enabled := true;

      end;
  end;
end;

procedure TFMGastosTransitos.botoneraDespl();
begin
  if ((not rejilla.DataSource.DataSet.Active) or
    (rejilla.DataSource.DataSet.RecordCount <= 0)) then
  begin
    APrimero.Enabled := False;
    AAnterior.Enabled := False;
    ASiguiente.Enabled := False;
    AUltimo.Enabled := False;
    Exit;
  end;


  if rejilla.DataSource.DataSet.Bof then
  begin
    APrimero.Enabled := False;
    AAnterior.Enabled := False;
  end
  else
  begin
    APrimero.Enabled := True;
    AAnterior.Enabled := True;
  end;

  if rejilla.DataSource.DataSet.Eof then
  begin
    ASiguiente.Enabled := False;
    AUltimo.Enabled := False;
  end
  else
  begin
    ASiguiente.Enabled := True;
    AUltimo.Enabled := True;
  end;

  AModificar.Enabled:= DSMaestro.DataSet.FieldByName('solo_lectura_tg').AsInteger <> 1;
  ABorrar.Enabled:= AModificar.Enabled and not gastoAsignado;
end;

procedure TFMGastosTransitos.rejillaCellClick(Column: TColumn);
begin
(*    if gastoAsignado then Exit;
    if (rejilla.SelectedRows.Count <= 0) Then
    begin
      ABorrar.Enabled:=false;
    end
    else
    begin
      ABorrar.Enabled:=true;
    end;
*)
end;

procedure TFMGastosTransitos.tipo_tgChange(Sender: TObject);
begin
  if not TTipoGastos.Active then
    TTipoGastos.Open;
  if TTipoGastos.FindKey([tipo_tg.Text]) then
  begin
    factu := Trim(TTipoGastos.FieldByName('facturable_tg').AsString);
    STTipoGastos.Caption := Trim(TTipoGastos.FieldByName('descripcion_tg').AsString);
    // Solo se permite cambiar el transportista si el tipo de gasto tiene agrupacion (agrupacion_tg) TRANSPORTE    if TTipoGastos.FieldbyName('agrupacion_tg').AsString = 'TRANSPORTE' then
    if TTipoGastos.FieldByName('agrupacion_tg').AsString = 'TRANSPORTE' then
    begin
      transporte_tg.Enabled := true;
      stTransporte.Enabled := true;
    end
    else
    begin
      if QGastosSalida.State in dsEditModes then
        QGastosSalida.fieldbyname('transporte_tg').AsString := sTransporte;
      transporte_tg.Enabled := false;
      stTransporte.Enabled := false;
    end;
  end
  else STTipoGastos.Caption := '';
  TTipoGastos.Close;
end;

procedure TFMGastosTransitos.tipo_tgMod(Sender: TOBject);
begin
  if not TTipoGastos.Active then
    TTipoGastos.Open;
  if TTipoGastos.FindKey([tipo_tg.Text]) then
  begin
    factu := Trim(TTipoGastos.FieldByName('facturable_tg').AsString);
    // Solo se permite cambiar el transportista si el tipo de gasto tiene agrupacion (agrupacion_tg) TRANSPORTE    if TTipoGastos.FieldbyName('agrupacion_tg').AsString = 'TRANSPORTE' then
    if TTipoGastos.FieldByName('agrupacion_tg').AsString = 'TRANSPORTE' then
    begin
      valorTransporte.Enabled := true;
//      ssTrans.Enabled := true;
      valordesTransporte.Enabled := true;
    end
    else
    begin
      valorTransporte.Enabled := false;
//      ssTrans.Enabled := false;
      valordesTransporte.Enabled := false;
    end;
  end
  else STTipoGastos.Caption := '';
  TTipoGastos.Close;
end;

procedure TFMGastosTransitos.producto_tgChange(Sender: TObject);
begin
  if producto_tg.Text = '' then
  begin
    STProducto.Caption:= 'VACÍO = TODOS LOS PRODUCTOS';
  end
  else
  begin
    STProducto.Caption:= desProducto( sEmpresa, producto_tg.Text );
  end;
end;

procedure TFMGastosTransitos.AAltaExecute(Sender: TObject);
begin
  cambiarEstado(teAlta);

  transporte_tg.Enabled := false;
  ssTransporte.Enabled := false;
  STTransporte.Enabled := false;
  
  QGastosSalida.Insert;
    tipo_tgChange(nil);
  producto_tg.Change;
  QGastosSalida.FieldByName('transporte_tg').AsString := sTransporte;
  tipo_tg.SetFocus;
end;

procedure TFMGastosTransitos.AModificarExecute(Sender: TObject);
begin
  ssTrans.Enabled := false;
  tipo_tgMod(self);

  if QGastosSalida.RecordCount > 0 then
  begin
    cambiarEstado(teModificar);
    tipo_tgMod(Self);
    valorImporteGastos.Text := rejilla.DataSource.DataSet.FieldByName('importe_tg').AsString;
    valorRefFactura.Text := rejilla.DataSource.DataSet.FieldByName('ref_fac_tg').AsString;
    ValorFechaFactura.Text := rejilla.DataSource.DataSet.FieldByName('fecha_fac_tg').AsString;
    valorTransporte.Text := rejilla.DataSource.DataSet.FieldByName('transporte_tg').AsString;
    valordesTransporte.Caption := rejilla.DataSource.DataSet.FieldByName('descriptrans_tg').AsString;
    rejilla.Enabled := False;
    PModificarImporte.Show;
    if gastoAsignado then begin
      valorImporteGastos.Enabled := False;
      valorRefFactura.SetFocus;
    end else begin
      valorImporteGastos.Enabled := True;
      valorImporteGastos.SetFocus;
    end;
    PRejilla.Enabled := False;
    producto_tg.Change;
  end;
end;

procedure TFMGastosTransitos.calculoGastos;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add('SELECT SUM(importe_tg) As gastosTotal ' +
      'FROM tmp_gastos ');
    SQL.Add('Where empresa_tg    = ' + QuotedStr(sEmpresa) + ' ' +
      'And   centro_tg     = ' + QuotedStr(sCentro) + ' ' +
      'And   albaran_tg = ' + sReferencia + ' ' +
      'And   fecha_tg      = ' + SQLDate(sFecha) + ' ' +
      'And   usuario_tg    = ' + QuotedStr(gsCodigo) + ' ');
    SQL.Add('GROUP BY empresa_tg,centro_tg,albaran_tg,fecha_tg ');
    Open;
    if IsEmpty then STTotalGastos.Caption := '0'
    else STTotalGastos.Caption := FieldByName('gastosTotal').AsString;
    Close;
  end;
end;

procedure TFMGastosTransitos.borrarDatos();
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;
// Elimina de la tabla Temporal...
    SQL.Clear;
    SQL.Add('DELETE FROM tmp_gastos ');
    SQL.Add('WHERE empresa_tg =' + QuotedStr(sEmpresa) + ' ' +
      'And centro_tg =' + QuotedStr(sCentro) + ' ' +
      'And albaran_tg =' + sReferencia + ' ' +
      'And fecha_tg = ' + SQLDate(sFecha) + ' '
      + 'And usuario_tg = ' + QuotedStr(gsCodigo) + ' ');
    ExecSQL;
    if Active then Close;
  end;
end;

procedure TFMGastosTransitos.tipo_tgRequiredTime(Sender: TObject;
  var isTime: Boolean);
begin
  isTime := false;
  if TBEdit(Sender).CanFocus then
  begin
    if (Estado = teLocalizar) then
      Exit;
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
    isTime := true;
  end;
end;

procedure TFMGastosTransitos.transporte_tgPropertiesChange(Sender: TObject);
begin
  STTransporte.Caption := desTransporte(sEmpresa, transporte_tg.Text);
end;

procedure TFMGastosTransitos.valorTransportePropertiesChange(Sender: TObject);
begin
  valordesTransporte.Caption := desTransporte(sEmpresa, valorTransporte.Text);
end;

function TFMGastosTransitos.evaluarDatosInputs(): Boolean;
begin
  evaluarDatosInputs := TRUE;
  if estado <> teAlta then Exit;

  if ActiveControl.Name = 'RejillaFlotante' then
  begin
    Exit;
  end;

  with DMBaseDatos.QGeneral do
  begin
    SQL.Clear;
    SQL.Add('SELECT count(*) As cuenta FROM frf_tipo_gastos ');
    SQL.Add('WHERE tipo_tg = ' + QuotedStr(tipo_tg.Text));
    SQL.Add('AND gasto_transito_tg = 1');
    Open;
    if (FieldByName('cuenta').AsInteger = 0) then
    begin
      evaluarDatosInputs := FALSE;
      Advertir('El Tipo de Gastos introducido no es de transito o no existe ...');
      Close;
      tipo_tg.SetFocus;
      Exit;
    end
    else
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT count(*) As cuenta FROM frf_gastos_trans ');
      SQL.Add('WHERE tipo_gt = ' + QuotedStr(tipo_tg.Text) + ' ' +
        'And   empresa_gt = ' + QuotedStr(sEmpresa) + ' ' +
        'And   centro_gt = ' + QuotedStr(sCentro) + ' ' +
        'And   referencia_gt = ' + sReferencia + ' ' +
        'And   fecha_gt = ' + SQLDate(sFecha) + ' ');
      if Trim( producto_tg.Text ) = '' then
      begin
        //SQL.Add('And   producto_gt is NULL ');
        SQL.Add('And   nvl(producto_gt,'''') = ''''  ');
      end
      else
      begin
        SQL.Add('And   producto_gt =  ' + QuotedStr(producto_tg.Text));
      end;
      Open;
      if ((FieldByName('cuenta').AsInteger) > 0) then
      begin
        evaluarDatosInputs := FALSE;
        Advertir('El Tipo de Gastos ya ha sido introducido para este Albarán...');
        tipo_tg.SetFocus;
      end
      else
      begin
        Close;
        {
        SQL.Clear;
        SQL.Add('SELECT count(*) As cuenta FROM tmp_gastos ');
        Open;
        ShowMessage(FieldByName('cuenta').AsString);
        Close;
        }
        SQL.Clear;
        SQL.Add('SELECT count(*) As cuenta FROM tmp_gastos ');
        SQL.Add('WHERE tipo_tg = ' + QuotedStr(tipo_tg.Text) + ' ' +
         'And   empresa_tg = ' + QuotedStr(sEmpresa) + ' ' +
         'And   centro_tg = ' + QuotedStr(sCentro) + ' ' +
         'And   albaran_tg = ' + sReferencia + ' ' +
         'And   fecha_tg = ' + SQLDate(sFecha) + ' ');
        if Trim( producto_tg.Text ) = '' then
        begin
          SQL.Add('And   nvl(producto_tg,'''') = ''''  ');
        end
        else
        begin
          SQL.Add('And   producto_tg =  ' + QuotedStr(producto_tg.Text));
        end;
        //SQL.Add('and usuario_tg is not null ');
        SQL.Add('and usuario_tg = ' + QuotedStr(gsCodigo) );
        SQL.Add('And accion_tg = ' + QuotedStr('A'));
        Open;
        //ShowMessage(FieldByName('cuenta').AsString);
        if ((FieldByName('cuenta').AsInteger) > 0) then
        begin
          evaluarDatosInputs := FALSE;
          Advertir('El Tipo de Gastos ya ha sido introducido para este Albarán...');
          tipo_tg.SetFocus;
        end;
      end;
    end;
    Close;
  end;
end;

procedure TFMGastosTransitos.rejillaDblClick(Sender: TObject);
begin
  AModificar.Execute;
end;


procedure TFMGastosTransitos.ssTransAntesEjecutar(Sender: TObject);
begin
  ssTrans.SQLAdi := '';
end;

procedure TFMGastosTransitos.ssTransporteAntesEjecutar(Sender: TObject);
begin
  ssTransporte.SQLAdi := '';
end;

procedure GastosTransito(AEmpresa, ACentro, AReferencia, AFecha, ATransporte: string;
  AAsignado: Boolean);
var tip: string;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;
// Elimina de la tabla Temporal...
    SQL.Clear;
    SQL.Add('DELETE FROM tmp_gastos ');
    SQL.Add('WHERE usuario_tg = ' + QuotedStr(gsCodigo) + ' ');
    ExecSQL;

    SQL.Clear;
    SQL.Add('INSERT INTO tmp_gastos (empresa_tg,centro_tg,albaran_tg,' +
      'fecha_tg,tipo_tg,producto_tg,importe_tg,usuario_tg,');
    SQL.Add('ref_fac_tg,');
    SQL.Add('fecha_fac_tg, solo_lectura_tg, transporte_tg) ');

    SQL.Add('SELECT empresa_gt,centro_gt,referencia_gt,' +
      'fecha_gt,tipo_gt,producto_gt,importe_gt,' + QuotedStr(gsCodigo) + ' As usuario ');
    SQL.Add(' ,ref_fac_gt ');
    SQL.Add(' , fecha_fac_gt, solo_lectura_gt, transporte_gt ');
    SQL.Add('FROM frf_gastos_trans');
    SQL.Add('WHERE empresa_gt=' + QuotedStr(AEmpresa) + ' ' +
      'And centro_gt=' + QuotedStr(ACentro) + ' ' +
      'And referencia_gt=' + AReferencia + ' ' +
      'And fecha_gt=' + SQLDate(AFecha) + ' ');
    ExecSQL;
  end;


  with TFMGastosTransitos.Create(nil) do
  begin
    try
       // Datos de gastos de la Salida que
      if QGastosSalida.Active then QGastosSalida.Close;
      QGastosSalida.SQL.Clear;
      QGastosSalida.SQL.Add('SELECT * FROM tmp_gastos ');
      QGastosSalida.SQL.Add('WHERE empresa_tg =' + QuotedStr(AEmpresa) + ' ' +
        'And centro_tg =' + QuotedStr(ACentro) + ' ' +
        'And albaran_tg =' + AReferencia + ' ' +
        'And fecha_tg = ' + SQLDate(AFecha) + ' ' +
        'And usuario_tg = ' + QuotedStr(gsCodigo) + ' ');
      QGastosSalida.SQL.Add('ORDER BY tipo_tg');
      QGastosSalida.Open;
      QGastosSalida.First;
      while not QGastosSalida.Eof do
      begin
        tip := QGastosSalida.FieldByName('tipo_tg').AsString;
        if not TTipoGastos.Active then TTipoGastos.Open;
        if TTipoGastos.FindKey([tip]) then
        begin
          QGastosSalida.Edit;
          QGastosSalida.FieldByName('descriptipo_tg').AsString := TTipoGastos.FieldByName('descripcion_tg').AsString;
          QGastosSalida.FieldByName('facturable_tg').AsString := TTipoGastos.FieldByName('facturable_tg').AsString;
          QGastosSalida.Post;
        end;

        if QGastosSalida.FieldByName('transporte_tg').AsString <> ''then
        begin
          DMAuxDB.QDescripciones.SQL.Text := ' select descripcion_t from frf_transportistas ' +
            ' where transporte_t=' + QGastosSalida.FieldByName('transporte_tg').AsString;
          try
            DMAuxDB.QDescripciones.Open;
            if not DMAuxDB.QDescripciones.IsEmpty then
            begin
              QGastosSalida.Edit;
              QGastosSalida.FieldByName('descriptrans_tg').AsString :=
                DMAuxDB.QDescripciones.FieldByName('descripcion_t').AsString;
              QGastosSalida.Post;
            end;
          finally
            DMAuxDB.QDescripciones.Cancel;
            DMAuxDB.QDescripciones.Close;
          end;
        end;

        QGastosSalida.Next;
      end;
      TTipoGastos.Close;
      QGastosSalida.Close;
      QGastosSalida.Open;


      sEmpresa := AEmpresa;
      empNom := AEmpresa + ' - ' + DesEmpresa(AEmpresa);
      sCentro := ACentro;
      cenNom := ACentro + ' - ' + DesCentro(AEmpresa, ACentro);
      sReferencia := AReferencia;
      sFecha := AFecha;
      sTransporte := ATransporte;
      STEmpresa.Caption := empNom;
      STCentro.Caption := cenNom;
      STReferencia.Caption := AReferencia;
      STFecha.Caption := AFecha;
      descripcionCliente;
      gastoAsignado := AAsignado;
      if gastoAsignado then
        ShowMessage('Recuerde que para modificar los importes de los gastos es necesario desasignar los gastos antes.');
      Botones;

      ShowModal;
    except
      Free;
      Application.ProcessMessages;
    end;
  end;
end;

procedure TFMGastosTransitos.EuroConversorExecute;
var
  aux: string;
begin
  if Trim(STFecha.Caption) <> '' then
  try
    aux := DConversor.Execute(self, StrTodate(STFecha.Caption), 'EUR', 'GBP');
  except
    aux := DConversor.Execute(self, Date, 'GBP', 'EUR');
  end
  else
    aux := DConversor.Execute(self, Date, 'GBP', 'EUR');

  if ActiveControl is TBEdit then
  begin
    if Trim(aux) <> '' then
      TBEdit(ActiveControl).Text := aux;
  end;
end;

procedure TFMGastosTransitos.btnFecha_fac_tgClick(Sender: TObject);
var
  dFecha: TDate;
begin
  dFecha:= StrToDateDef( fecha_fac_tg.Text, Date );
  Calendario.Date:= dFecha;
  Calendario.BControl:= fecha_fac_tg;
  btnFecha_fac_tg.CalendarShow;
end;

procedure TFMGastosTransitos.btnValorFechaFacturaClick(Sender: TObject);
var
  dFecha: TDate;
begin
  dFecha:= StrToDateDef( ValorFechaFactura.Text, Date );
  Calendario.Date:= dFecha;
  Calendario.BControl:= ValorFechaFactura;
  btnValorFechaFactura.CalendarShow;
end;

procedure TFMGastosTransitos.QGastosSalidaAfterScroll(DataSet: TDataSet);
begin
  botoneraDespl;
end;

end.
