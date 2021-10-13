unit MGastosSalida;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbTables,
  DError, CVariables, StrUtils, DBActns, StdActns, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, dxSkinsCore, dxSkinBlueprint, dxSkinFoggy,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxCurrencyEdit, cxDBEdit,
  cxButtons, SimpleSearch, SimpleSearch2, dxSkinMoneyTwins;

type
  TFMGastosSalida = class(TForm)
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
    ALocalizar: TAction;
    AModificar: TAction;
    ASalir: TAction;
    AAceptar: TAction;
    ACancelar: TAction;
    sincronizarTabla: TQuery;
    SBAltas: TSpeedButton;
    SBBorrar: TSpeedButton;
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    STCliente: TStaticText;
    STMoneda: TStaticText;
    STTotalCajas: TStaticText;
    STTotalKilos: TStaticText;
    STAlbaran: TStaticText;
    STFecha: TStaticText;
    LAlbaran: TLabel;
    LFecha: TLabel;
    ABorrar: TAction;
    STTipoGastos: TStaticText;
    LTipoGastos: TLabel;
    LImporte: TLabel;
    BGBTipoGastos: TBGridButton;
    AAlta: TAction;
    Label1: TLabel;
    STTotalGastos: TStaticText;
    STTotalImporte: TStaticText;
    Label2: TLabel;
    rejilla: TDBGrid;
    tipo_tg: TBDEdit;
    importe_tg: TBDEdit;
    RejillaFlotante: TBGrid;
    PModificarImporte: TPanel;
    Label3: TLabel;
    valorImporteGastos: TBEdit;
    APrimero: TAction;
    AAnterior: TAction;
    ASiguiente: TAction;
    AUltimo: TAction;
    Label8: TLabel;
    valorRefFactura: TBEdit;
    ref_fac_tg: TBDEdit;
    LApunte: TLabel;
    QLineasAlbaran: TQuery;
    QGastosSalida: TQuery;
    TTipoGastos: TTable;
    QGastoFacturable: TQuery;
    LProducto: TLabel;
    producto_tg: TBDEdit;
    BGBProducto: TBGridButton;
    STProducto: TStaticText;
    Label9: TLabel;
    fecha_fac_tg: TBDEdit;
    btnFecha_fac_tg: TBCalendarButton;
    Label10: TLabel;
    btnValorFechaFactura: TBCalendarButton;
    Calendario: TBCalendario;
    ValorFechaFactura: TBEdit;
    Label38: TLabel;
    STTransporte: TStaticText;
    Label11: TLabel;
    valordesTransporte: TStaticText;
    ssTrans: TSimpleSearch2;
    valorTransporte: TcxDBTextEdit;
    transporte_tg: TcxDBTextEdit;
    ssTransporte: TSimpleSearch2;
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
    procedure ABorrarExecute(Sender: TObject);
    procedure tipo_tgChange(Sender: TObject);
    procedure AAltaExecute(Sender: TObject);
    procedure AModificarExecute(Sender: TObject);
    procedure tipo_tgRequiredTime(Sender: TObject; var isTime: Boolean);
    procedure APrimeroExecute(Sender: TObject);
    procedure AAnteriorExecute(Sender: TObject);
    procedure ASiguienteExecute(Sender: TObject);
    procedure AUltimoExecute(Sender: TObject);
    procedure producto_tgChange(Sender: TObject);
    procedure rejillaDblClick(Sender: TObject);
    procedure btnFecha_fac_tgClick(Sender: TObject);
    procedure btnValorFechaFacturaClick(Sender: TObject);
    procedure QGastosSalidaAfterScroll(DataSet: TDataSet);
    procedure transporte_tgPropertiesChange(Sender: TObject);
    procedure ssTransAntesEjecutar(Sender: TObject);
    procedure valorTransportePropertiesChange(Sender: TObject);
    procedure transporte_tgChange(Sender: TObject);
    procedure ssTransporteAntesEjecutar(Sender: TObject);


  private
    lRF: TBGrid;
    lCF: TBCalendario;
    { Private declarations }
    // registro, registros, registrosinsertados: integer;
    // select,  where, order: string;
    // FocoLocalizar, FocoModificar: TWinCOntrol;
    estado: TEstado;
    // localizado: boolean;
    // empresa, producto: string; opcion:integer;
    salir: boolean;

    procedure botoneraDespl;

    // procedure Modificar;
    procedure AceptarAltas;
    procedure AceptarModificar;
    procedure CancelarAltas;
    procedure CancelarModificar;
    procedure cambiarEstado(estad: TEstado);
    procedure calculoGastos;
    procedure borrarDatos();
    function evaluarDatosInputs(): Boolean;

    function  EsGastoFacturable( const ATipo: string ): boolean;
    procedure EuroConversorExecute;
    function  FechaStr( const AFecha: string ): string;
    procedure tipo_tgMod(Sender: TObject);


  public
    { Public declarations }
    sEmpresa: string;
    sCentro: string;
    sAlbaran: string;
    sFecha: string;
    empNom: string;
    cenNom: string;
    factu: string;
    sTransporte: string;
    bFacturable: boolean;

    procedure Botones;
    procedure descripcionCliente();

  end;

var
  FMGastosSalida: TFMGastosSalida;
  opcc: Integer;

implementation

uses UDMAuxDB, bDialogs, UDMBaseDatos, CAuxiliarDB, Principal, bSQLUtils,
     DConversor, UFTransportistas, MSalidas;

{$R *.DFM}

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMGastosSalida.FormCreate(Sender: TObject);
begin
  with QGastoFacturable do
  begin
    SQL.Clear;
    SQL.Add(' select facturable_tg ');
    SQL.Add(' from frf_tipo_gastos ');
    SQL.Add(' where tipo_tg = :tipo ');
  end;

  Salir := false;

     //Teclas para las altas y bajas
  AAlta.ShortCut := vk_add; //mas numerico
//  ABorrar.ShortCut := VK_SUBTRACT; //menos numerico
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

{+ CUIDADIN }

procedure TFMGastosSalida.FormActivate(Sender: TObject);
begin
  gRF := RejillaFlotante;
  gCF := nil;
end;


procedure TFMGastosSalida.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  if salir then
  begin
    QGastosSalida.Close;
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

procedure TFMGastosSalida.FormKeyDown(Sender: TObject; var Key: Word;
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


//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMGastosSalida.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  if NewHeight < 35 then
  begin
    ShowWindow(Application.Handle, SW_SHOWMINNOACTIVE);
    Resize := False;
  end;
end;

procedure TFMGastosSalida.ARejillaFlotanteExecute(Sender: TObject);
var
  sAux: string;                                                                                         
begin
  if (transporte_tg.Focused) or (valorTransporte.Focused) then
    Exit;

  if ( Estado <> teAlta ) and ( Estado <> teModificar ) then
    EXit;
  if DMBaseDatos.QDespegables.Active then
    DMBaseDatos.QDespegables.Close;
  DMBaseDatos.QDespegables.SQL.Clear;

  if tipo_tg.Focused then
  begin
    RejillaFlotante.BControl := tipo_tg;
    DMBaseDatos.QDespegables.SQL.Add('SELECT tipo_tg,descripcion_tg,facturable_tg  FROM frf_tipo_gastos ');
    DMBaseDatos.QDespegables.SQL.Add('WHERE gasto_transito_tg = 0 ');
    DMBaseDatos.QDespegables.SQL.Add(' and tipo_tg Not In ');
    DMBaseDatos.QDespegables.SQL.Add('(SELECT tipo_g FROM frf_gastos ');
    DMBaseDatos.QDespegables.SQL.Add(' WHERE empresa_g = ' + QuotedStr(sEmpresa) + ' ');
    DMBaseDatos.QDespegables.SQL.Add(' And   centro_salida_g = ' + QuotedStr(sCentro) + ' ');
    DMBaseDatos.QDespegables.SQL.Add(' And   n_albaran_g     = ' + sAlbaran + '  ');
    if trim(sFecha) <> '' then
      DMBaseDatos.QDespegables.SQL.Add(' And   fecha_g         =' + SQLDate(sFecha) + ' ');

    DMBaseDatos.QDespegables.SQL.Add(')and tipo_tg Not In ');
    DMBaseDatos.QDespegables.SQL.Add('(SELECT tipo_tg FROM tmp_gastos ');
    DMBaseDatos.QDespegables.SQL.Add(' WHERE empresa_tg = ' + QuotedStr(sEmpresa) + ' ');
    DMBaseDatos.QDespegables.SQL.Add(' And   centro_tg = ' + QuotedStr(sCentro) + ' ');
    DMBaseDatos.QDespegables.SQL.Add(' And   albaran_tg     = ' + sAlbaran + '  ');
    if trim(sFecha) <> '' then
      DMBaseDatos.QDespegables.SQL.Add(' And   fecha_tg         =' + SQLDate(sFecha) + ' ');
    DMBaseDatos.QDespegables.SQL.Add('and usuario_tg = ' + QuotedStr(gsCodigo));
    DMBaseDatos.QDespegables.SQL.Add('And accion_tg = ' + QuotedStr('A'));
    DMBaseDatos.QDespegables.SQL.Add(')ORDER BY tipo_tg');
  end
  else
  if transporte_tg.Focused then
  begin
{

    sAux:= transporte_tg.Text;
    if SeleccionaTransportista( self, transporte_tg, sEmpresa, sAux ) then
    begin
      transporte_tg.Text:= sAux;
    end;
}
  end
  else
  if producto_tg.Focused then
  begin
    RejillaFlotante.BControl := producto_tg;
    DMBaseDatos.QDespegables.SQL.Add('select producto_p, descripcion_p');
    DMBaseDatos.QDespegables.SQL.Add('from frf_productos');
    DMBaseDatos.QDespegables.SQL.Add('order by 2');
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

  if not (transporte_tg.Focused) then
  begin
    DMBaseDatos.QDespegables.Open;
    BGBTipoGastos.GridShow;
  end;
end;


//***************************************************************
//Procedimientos de los botones, acciones, desplazamientos, etc..
//***************************************************************

procedure TFMGastosSalida.AAceptarExecute(Sender: TObject);
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

procedure TFMGastosSalida.ACancelarExecute(Sender: TObject);
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

procedure TFMGastosSalida.ASalirExecute(Sender: TObject);
begin
  if Salir then
    Close;
end;

procedure TFMGastosSalida.AceptarAltas;
begin
  if EsGastoFacturable( tipo_tg.Text ) and ( not bFacturable ) then
  begin
    ShowMessage('No se pueden dar de alta gastos facturables en una salida ya facturada.');
    CancelarAltas;
  end;

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
    QGastosSalida.FieldByName('albaran_tg').AsInteger := StrToInt(sAlbaran);
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
  end
  else
  begin
    QGastosSalida.DisableControls;
    QGastosSalida.Cancel;
    tipo_tg.SetFocus;
    QGastosSalida.Insert;
    QGastosSalida.FieldByName('transporte_tg').AsString := sTransporte;
    QGastosSalida.EnableControls;
  end;

  //Log
  FMSalidas.InsertarLogTransacciones('ALTA GASTOS');

end;

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

function TFMGastosSalida.FechaStr( const AFecha: string ): string;
begin
  if Trim( AFecha ) = '' then
    result:= 'NULL'
  else
    result:= QuotedStr(AFecha);
end;

procedure TFMGastosSalida.CancelarAltas;
var
  import, referencia, fecha, transporte: string;
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
    sincronizarTabla.Close;
    while not Eof do
    begin
      import := SQLNumeric(FieldByName('importe_tg').AsString);
      referencia := Trim(FieldByName('ref_fac_tg').AsString);
      fecha := FieldByName('fecha_fac_tg').AsString;
      transporte := FieldByName('transporte_tg').AsString;
      sincronizarTabla.SQL.Clear;
      sincronizarTabla.SQL.Add('INSERT into frf_gastos(' +
        'empresa_g,centro_salida_g,n_albaran_g,fecha_g,' +
        'tipo_g,producto_g,importe_g,ref_fac_g,fecha_fac_g, transporte_g) ');
      sincronizarTabla.SQL.Add('VAlUES (' +
        QuotedStr(sEmpresa) + ',' + QuotedStr(sCentro) + ',' +
        sAlbaran + ',' + SQLDate(sFecha) + ',' +
        QuotedStr(FieldByName('tipo_tg').AsString) + ',' +
        PutString( FieldByName('producto_tg').AsString ) + ',' +
        import + ',' + QuotedStr(referencia) + ',' + FechaStr(fecha) + ',' + transporte + ') ');

      try
        sincronizarTabla.ExecSQL;
      except
                 //
      end;
      Next;
    end;
    sincronizarTabla.Close;
    Close;
  end;
end;


procedure TFMGastosSalida.AceptarModificar;
var import, referencia, fecha, producto, transporte, destransporte: string;
begin
  import := SQLNumeric(valorImporteGastos.Text);
  referencia := Trim(valorRefFactura.Text);
  fecha := ValorFechaFactura.Text;
  producto:= Trim(QGastosSalida.FieldByName('producto_tg').AsString);
  transporte:=SQLNumeric(valorTransporte.Text);
  destransporte:=Trim(valordesTransporte.Caption);

  if not DMBaseDatos.QGeneral.Active then
    DMBaseDatos.QGeneral.Close;
  DMBaseDatos.QGeneral.SQL.Clear;
  DMBaseDatos.QGeneral.SQL.Add('UPDATE frf_gastos ' +
    'SET importe_g =' + import + ', ' +
    'ref_fac_g =' + QuotedStr(referencia) + ', ' +
    'fecha_fac_g =' + FechaStr(fecha) + ', ' +
    'transporte_g =' + transporte + ' ' +
    'Where empresa_g = ' + QuotedStr(sEmpresa) + ' ' +
    'And   centro_salida_g = ' + QuotedStr(sCentro) + ' ' +
    'And   n_albaran_g = ' + sAlbaran + ' ' +
    'And   fecha_g = ' + SQLDate(sFecha) + ' ' +
    'And   tipo_g = ' + QuotedStr(QGastosSalida.FieldByName('tipo_tg').AsString) + '');
  if producto = '' then
  begin
    //DMBaseDatos.QGeneral.SQL.Add(' and producto_g is null ');
    DMBaseDatos.QGeneral.SQL.Add(' and nvl(producto_g,'''') = ''''  ');
  end
  else
  begin
    DMBaseDatos.QGeneral.SQL.Add(' and producto_g = '  + QuotedStr(producto) );
  end;
  DMBaseDatos.QGeneral.ExecSQL;

  QGastosSalida.Edit;
  QGastosSalida.FieldByName('importe_tg').AsString := valorImporteGastos.Text;
  QGastosSalida.FieldByName('transporte_tg').AsString := valorTransporte.Text;
  QGastosSalida.FieldByName('descriptrans_tg').AsString := valordesTransporte.Caption;
  QGastosSalida.FieldByName('ref_fac_tg').AsString := valorRefFactura.Text;
  QGastosSalida.FieldByName('fecha_fac_tg').AsString := ValorFechaFactura.Text;
  QGastosSalida.Post;
  QGastosSalida.Close;
  QGastosSalida.Open;

  rejilla.Enabled := True;
  PModificarImporte.Visible := False;
  PRejilla.Enabled := True;
  cambiarEstado(teLocalizar);

  //Log
  FMSalidas.InsertarLogTransacciones('MODIFICACION GASTOS');

end;

procedure TFMGastosSalida.CancelarModificar;
begin
        //Cancelar la operacion
        //Ocultar el edit en el que se introducirá la operacion
  cambiarEstado(teLocalizar);
  rejilla.Enabled := True;
  PModificarImporte.Visible := False;
  PRejilla.Enabled := True;
end;

// ******************************************************************
// **                  OBTENCIÓN DE DATOS                          **
// ******************************************************************

procedure TFMGastosSalida.descripcionCliente();
var cadCliente: string;
  cadMoneda: string;
  cadTotCajas: string;
  cadTotKilos: string;
  cadTotImporteNeto: string;
  TotKilos: Extended;
  TotCajas: Extended;
  TotImporteNeto: Extended;
begin

  TotKilos := 0;
  TotCajas := 0;
  TotImporteNeto := 0;

  STCliente.Caption := '';
  STMoneda.Caption := '';
  STTotalCajas.Caption := '';
  STTotalKilos.Caption := '';

  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM frf_salidas_c ');
    SQL.Add('WHERE empresa_sc Like ' + QuotedStr(sEmpresa) + ' ');
    SQL.Add('And   centro_salida_sc Like ' + QuotedStr(sCentro) + ' ');
    SQL.Add('And   n_albaran_sc=' + sAlbaran + ' ');
    SQL.Add('And   fecha_sc=' + SQLDate(sFecha) + ' ');
    SQL.Add('ORDER BY empresa_sc,centro_salida_sc,fecha_sc,n_albaran_sc ');
    Open;
    if IsEmpty then exit;
    cadCliente := FieldByName('cliente_fac_sc').AsString;
    cadMoneda := FieldByName('moneda_sc').AsString;
          //monedaALbaran

    SQL.Clear;
    SQL.Add('SELECT * FROM frf_clientes ');
    SQL.Add('WHERE cliente_c Like ' + QuotedStr(cadCliente));
    SQL.Add('ORDER BY cliente_c');
    Open;
    if not IsEmpty then
      cadCliente := cadCliente + ' - ' + FieldByName('nombre_c').AsString;
    SQL.Clear;
    SQL.Add('SELECT * FROM frf_monedas ');
    SQL.Add('WHERE moneda_m Like ' + QuotedStr(cadMoneda));
    SQL.Add('ORDER BY moneda_m,descripcion_m');
    Open;
    if not IsEmpty then
      cadMoneda := cadMoneda + ' - ' + FieldByName('descripcion_m').AsString;

    QLineasAlbaran.SQL.Clear;
    QLineasAlbaran.RequestLive := False;
    QLineasAlbaran.SQL.Add('SELECT empresa_sl, centro_salida_sl, n_albaran_sl,fecha_sl,' +
      'SUM(cajas_sl) As cajas, SUM(kilos_sl) As kilos, SUM(importe_neto_sl) As importNeto ' +
      'FROM frf_salidas_l ');
    QLineasAlbaran.SQL.Add('GROUP BY empresa_sl, centro_salida_sl, n_albaran_sl,fecha_sl ');
    QLineasAlbaran.SQL.Add('HAVING empresa_sl Like ' + QuotedStr(sEmpresa) + ' ');
    QLineasAlbaran.SQL.Add('And    centro_salida_sl Like ' + QuotedStr(sCentro) + ' ');
    QLineasAlbaran.SQL.Add('And    n_albaran_sl = ' + sAlbaran + ' ');
    QLineasAlbaran.SQL.Add('And    fecha_sl = ' + SQLDate(sFecha) + ' ');
    QLineasAlbaran.Open;
    if not QLineasAlbaran.IsEmpty then
    begin
      TotCajas := QLineasAlbaran.FieldByName('cajas').AsVariant;
      cadTotCajas := QLineasAlbaran.FieldByName('cajas').AsString;
      TotKilos := QLineasAlbaran.FieldByName('kilos').AsVariant;
      cadTotKilos := QLineasAlbaran.FieldByName('kilos').AsString;
      TotImporteNeto := QLineasAlbaran.FieldByName('importNeto').AsVariant;
      cadTotImporteNeto := QLineasAlbaran.FieldByName('importNeto').AsVariant;
    end;
    QLineasAlbaran.Close;

    STCliente.Caption := cadCliente;
    STMoneda.Caption := cadMoneda;
    if trim(cadTotCajas) <> '' then STTotalCajas.Caption := FormatFloat('##,###,##0.00', TotCajas);
    if trim(cadTotKilos) <> '' then STTotalKilos.Caption := FormatFloat('##,###,##0.00', TotKilos);
    if trim(cadTotImporteNeto) <> '' then STTotalImporte.Caption := FormatFloat('##,###,##0.00', TotImporteNeto);
  end;
  calculoGastos;
end;

procedure TFMGastosSalida.ABorrarExecute(Sender: TObject);
var 
  em, ce, al, fe, ti: string;
  cad, producto: string;
begin
  producto:= Trim(QGastosSalida.FieldByName('producto_tg').AsString);

  if QGastosSalida.IsEmpty then
  begin
    Exit;
  end;

  if ( QGastosSalida.FieldByName('facturable_tg').AsString = 'S' ) and ( not bFacturable ) then
  begin
    ShowMessage('No se puede borrar un gasto facturable de una salida ya facturada.');
    Exit;
  end;

  cad := '¿ Desea borrar el gasto seleccionado... ?';
  if MessageDlg(cad, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  with rejilla.DataSource.DataSet do
  begin
    em := sEmpresa; // FieldByName('empresa_tg').AsString;
    ce := sCentro; // FieldByName('centro_tg').AsString;
    al := sAlbaran; // FieldByName('albaran_tg').AsString;
    fe := SQLDate(sFecha); // FieldByName('fecha_tg').AsString;
    ti := FieldByName('tipo_tg').AsString;

    DMBaseDatos.QGeneral.SQL.Clear;
    DMBaseDatos.QGeneral.SQL.Add('DELETE FROM frf_gastos');
    DMBaseDatos.QGeneral.SQL.Add('WHERE empresa_g =' + QuotedStr(em) + ' ' +
        'And   centro_salida_g = ' + QuotedStr(ce) + ' ' +
        'And   n_albaran_g = ' + al + ' ' +
        'And   fecha_g = ' + fe + ' ' +
        'And   tipo_g = ' + QuotedStr(ti) + ' ');
    if producto <> '' then
    begin
      DMBaseDatos.QGeneral.SQL.Add('And   producto_g = ' + QuotedStr(producto) );
    end
    else
    begin
      //DMBaseDatos.QGeneral.SQL.Add('And   producto_g is NULL ');
      DMBaseDatos.QGeneral.SQL.Add('And   nvl(producto_g, '''' ) = '''' ');
    end;
    DMBaseDatos.QGeneral.ExecSQL;
  end;

  DMBaseDatos.QGeneral.SQL.Clear;
  DMBaseDatos.QGeneral.SQL.Add('DELETE FROM tmp_gastos');
  DMBaseDatos.QGeneral.SQL.Add('WHERE empresa_tg =' + QuotedStr(em) + ' ' +
      'And   centro_tg = ' + QuotedStr(ce) + ' ' +
      'And   albaran_tg = ' + al + ' ' +
      'And   fecha_tg = ' + fe + ' ' +
      'And   usuario_tg = ' + QuotedStr(gsCodigo) + ' ');
  DMBaseDatos.QGeneral.SQL.Add('And tipo_tg =' + ti );
  if producto <> '' then
  begin
    DMBaseDatos.QGeneral.SQL.Add('And   producto_tg = ' + QuotedStr(producto) );
  end
  else
  begin
    //DMBaseDatos.QGeneral.SQL.Add('And   producto_tg is NULL ');
    DMBaseDatos.QGeneral.SQL.Add('And   nvl(producto_tg,'''') = ''''  ');
  end;
  DMBaseDatos.QGeneral.ExecSQL;
  rejilla.DataSource.DataSet.Close;
  rejilla.DataSource.DataSet.Open;

  DMBaseDatos.QGeneral.Close;
  calculoGastos;
  cambiarEstado(teLocalizar);

  //Log
  FMSalidas.InsertarLogTransacciones('BAJA GASTOS');

end;

procedure TFMGastosSalida.cambiarEstado(estad: TEstado);
var vis: Boolean;
begin
  estado := estad;
  if estad = teAlta then vis := True
  else vis := False;

  LTipoGastos.Visible := vis;
  tipo_tg.Visible := vis;
  BGBTipoGastos.Visible := vis;
  STTipoGastos.Visible := vis;
  LImporte.Visible := vis;
  importe_tg.Visible := vis;
  ref_fac_tg.Visible := vis;
  LApunte.Visible := vis;
  rejilla.Enabled := not vis;

  STTransporte.Visible := vis;

  if rejilla.Enabled then
  begin
    rejilla.Top:= 216;
    rejilla.Height:= 210;
  end
  else
  begin
    rejilla.Top:= 296;
    rejilla.Height:= 130;
  end;

  LProducto.Visible := vis;
  producto_tg.Visible := vis;
  STProducto.Visible := vis;
  BGBProducto.Visible := vis;


  case estad of
    teAlta:
      begin
        APrimero.Enabled := False;
        ASiguiente.Enabled := False;
        AAnterior.Enabled := False;
        AUltimo.Enabled := False;
      end;
    teModificar:
      begin
        APrimero.Enabled := False;
        ASiguiente.Enabled := False;
        AAnterior.Enabled := False;
        AUltimo.Enabled := false;
      end;
    teLocalizar:
      begin
        botoneraDespl;
      end;
  end;
  Botones;
end;

procedure TFMGastosSalida.Botones;
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

        botoneraDespl;
      end;
  end;
end;


procedure TFMGastosSalida.tipo_tgChange(Sender: TObject);
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

procedure TFMGastosSalida.tipo_tgMod(Sender: TObject);
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
      valordesTransporte.Enabled := true;
    end
    else
    begin
      valorTransporte.Enabled := false;
      valordesTransporte.Enabled := false;
    end;
  end
  else STTipoGastos.Caption := '';
  TTipoGastos.Close;
end;                                    

procedure TFMGastosSalida.AAltaExecute(Sender: TObject);
begin
  cambiarEstado(teAlta);

  transporte_tg.Enabled := false;
  ssTransporte.Enabled := false;
  STTransporte.Enabled := false;
  
  QGastosSalida.Insert;
  QGastosSalida.FieldByName('transporte_tg').AsString := sTransporte;
  Transporte_tgChange(Self);
  tipo_tg.SetFocus;
  producto_tg.Change;
end;

procedure TFMGastosSalida.AModificarExecute(Sender: TObject);
begin
  ssTrans.Enabled := false;
  tipo_tgMod(self);

  if producto_tg.Focused then
    exit;
  if estado = teAlta then
    exit;
  
  if QGastosSalida.RecordCount > 0 then
  begin
    if ( QGastosSalida.FieldByName('facturable_tg').AsString = 'S' ) and ( not bFacturable ) then
    begin
      ShowMessage('No se pueden modificar los gastos facturables de una salida ya facturada.');
    end
    else
    begin
      cambiarEstado(teModificar);
      tipo_tgMod(Self);
      valorImporteGastos.Text := rejilla.DataSource.DataSet.FieldByName('importe_tg').AsString;
      valorTransporte.Text := rejilla.DataSource.DataSet.FieldByName('transporte_tg').AsString;
      valordesTransporte.Caption := rejilla.DataSource.DataSet.FieldByName('descriptrans_tg').AsString;
      valorRefFactura.Text := rejilla.DataSource.DataSet.FieldByName('ref_fac_tg').AsString;
      ValorFechaFactura.Text := rejilla.DataSource.DataSet.FieldByName('fecha_fac_tg').AsString;
      rejilla.Enabled := False;
      PModificarImporte.Show;
      valorImporteGastos.SetFocus;
      PRejilla.Enabled := False;
    end;
  end;
  producto_tg.Change;
end;

procedure TFMGastosSalida.calculoGastos;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;
    SQL.Clear;
          //'(Importe_g*CASE WHEN facturable_tg="S" THEN -1 ELSE 1 END)  '+
    SQL.Add('SELECT SUM(importe_tg*CASE WHEN facturable_tg="S" THEN -1 ELSE 1 END) As gastosTotal ' +
      'FROM tmp_gastos ');
    SQL.Add('Where empresa_tg    = ' + QuotedStr(sEmpresa) + ' ' +
      'And   centro_tg     = ' + QuotedStr(sCentro) + ' ' +
      'And   albaran_tg = ' + sAlbaran + ' ' +
      'And   fecha_tg      = ' + SQLDate(sFecha) + ' ' +
      'And   usuario_tg    = ' + QuotedStr(gsCodigo) + ' ');
    SQL.Add('GROUP BY empresa_tg,centro_tg,albaran_tg,fecha_tg ');
    Open;
    if IsEmpty then STTotalGastos.Caption := '0'
    else STTotalGastos.Caption := FieldByName('gastosTotal').AsString;
    Close;
  end;
end;

procedure TFMGastosSalida.borrarDatos();
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;
// Elimina de la tabla Temporal...
    SQL.Clear;
    SQL.Add('DELETE FROM tmp_gastos ');
    SQL.Add('WHERE empresa_tg =' + QuotedStr(sEmpresa) + ' ' +
      'And centro_tg =' + QuotedStr(sCentro) + ' ' +
      'And albaran_tg =' + sAlbaran + ' ' +
      'And fecha_tg = ' + SQLDate(sFecha) + ' '
      + 'And usuario_tg = ' + QuotedStr(gsCodigo) + ' ');
    ExecSQL;
    if Active then Close;
  end;
end;

procedure TFMGastosSalida.tipo_tgRequiredTime(Sender: TObject;
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

procedure TFMGastosSalida.transporte_tgChange(Sender: TObject);
begin
  STTransporte.Caption:= desTransporte( sEmpresa, transporte_tg.Text );
end;

procedure TFMGastosSalida.transporte_tgPropertiesChange(Sender: TObject);
var sAux: String;
begin
  STTransporte.Caption := desTransporte(sEmpresa, transporte_tg.Text);
end;

procedure TFMGastosSalida.valorTransportePropertiesChange(Sender: TObject);
begin
  valordesTransporte.Caption := desTransporte(sEmpresa, valorTransporte.Text);
end;

function TFMGastosSalida.evaluarDatosInputs(): Boolean;
begin
  evaluarDatosInputs := TRUE;
  if estado <> teAlta then Exit;

  if ActiveControl.Name = 'RejillaFlotante' then
  begin
    Exit;
  end;

  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add('SELECT count(*) As cuenta FROM frf_tipo_gastos ');
    SQL.Add('WHERE tipo_tg = ' + QuotedStr(tipo_tg.Text));
    SQL.Add('AND gasto_transito_tg = 0');
    Open;
    if (FieldByName('cuenta').AsInteger = 0) then
    begin
      evaluarDatosInputs := FALSE;
      Advertir('El Tipo de Gastos introducido no es de salida o no existe ...');
      tipo_tg.SetFocus;
    end
    else
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT count(*) As cuenta FROM frf_gastos ');
      SQL.Add('WHERE tipo_g = ' + QuotedStr(tipo_tg.Text) + ' ' +
        'And   empresa_g = ' + QuotedStr(sEmpresa) + ' ' +
        'And   centro_salida_g = ' + QuotedStr(sCentro) + ' ' +
        'And   n_albaran_g = ' + sAlbaran + ' ' +
        'And   fecha_g = ' + SQLDate(sFecha) + ' ');
      if Trim( producto_tg.Text ) = '' then
      begin
        SQL.Add('And   nvl(producto_g,'''') = ''''  ');
      end
      else
      begin
        SQL.Add('And   producto_g =  ' + QuotedStr(producto_tg.Text));
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

        SQL.Clear;
        SQL.Add('SELECT count(*) As cuenta FROM tmp_gastos ');
        SQL.Add('WHERE tipo_tg = ' + QuotedStr(tipo_tg.Text) + ' ' +
         'And   empresa_tg = ' + QuotedStr(sEmpresa) + ' ' +
         'And   centro_tg = ' + QuotedStr(sCentro) + ' ' +
         'And   albaran_tg = ' + sAlbaran + ' ' +
         'And   fecha_tg = ' + SQLDate(sFecha) + ' ');
        if Trim( producto_tg.Text ) = '' then
        begin
          SQL.Add('And   nvl(producto_tg,'''') = ''''  ');
        end
        else
        begin
          SQL.Add('And   producto_tg =  ' + QuotedStr(producto_tg.Text));
        end;
        SQL.Add('and usuario_tg = ' + QuotedStr(gsCodigo));
        SQL.Add('And accion_tg = ' + QuotedStr('A'));
        Open;
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

procedure TFMGastosSalida.APrimeroExecute(Sender: TObject);
begin
  rejilla.DataSource.DataSet.First;
  botoneraDespl;
end;

procedure TFMGastosSalida.AAnteriorExecute(Sender: TObject);
begin
  rejilla.DataSource.DataSet.Prior;
  botoneraDespl;
end;

procedure TFMGastosSalida.ASiguienteExecute(Sender: TObject);
begin
  rejilla.DataSource.DataSet.Next;
  botoneraDespl;
end;

procedure TFMGastosSalida.AUltimoExecute(Sender: TObject);
begin
  rejilla.DataSource.DataSet.Last;
  botoneraDespl;
end;

procedure TFMGastosSalida.botoneraDespl;
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
  ABorrar.Enabled:= AModificar.Enabled;
end;

function TFMGastosSalida.EsGastoFacturable( const ATipo: string ): boolean;
begin
  with QGastoFacturable do
  begin
    ParamByName('tipo').AsString:= ATipo;
    Open;
    result:= FieldByName('facturable_tg').AsString = 'S';
    Close;
  end;
end;

procedure TFMGastosSalida.EuroConversorExecute;
var
  aux: string;
begin
  if Trim(STFecha.Caption) <> '' then
  try
    aux := DConversor.Execute(self, StrTodate(STFecha.Caption), 'EUR', 'GBP');
  except
    aux := DConversor.Execute(self, Date, 'EUR', 'GBP');
  end
  else
    aux := DConversor.Execute(self, Date, 'EUR', 'GBP');

  if ActiveControl is TBEdit then
  begin
    if Trim(aux) <> '' then
      TBEdit(ActiveControl).Text := aux;
  end;
end;

procedure TFMGastosSalida.producto_tgChange(Sender: TObject);
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

procedure TFMGastosSalida.rejillaDblClick(Sender: TObject);
begin
  if not DSMaestro.DataSet.IsEmpty then
    SBModificar.Click;
end;

procedure TFMGastosSalida.ssTransAntesEjecutar(Sender: TObject);
begin
  ssTrans.SQLAdi := '';
  if sEmpresa <> '' then
    ssTrans.SQLAdi := ' empresa_t = ' +  QuotedStr(sEmpresa);
end;

procedure TFMGastosSalida.ssTransporteAntesEjecutar(Sender: TObject);
begin
  ssTransporte.SQLAdi := '';
  if sEmpresa <> '' then
    ssTransporte.SQLAdi := ' empresa_t = ' +  QuotedStr(sEmpresa);
end;

procedure TFMGastosSalida.btnFecha_fac_tgClick(Sender: TObject);
var
  dFecha: TDate;
begin
  dFecha:= StrToDateDef( fecha_fac_tg.Text, Date );
  Calendario.Date:= dFecha;
  Calendario.BControl:= fecha_fac_tg;
  btnFecha_fac_tg.CalendarShow;
end;

procedure TFMGastosSalida.btnValorFechaFacturaClick(Sender: TObject);
var
  dFecha: TDate;
begin
  dFecha:= StrToDateDef( ValorFechaFactura.Text, Date );
  Calendario.Date:= dFecha;
  Calendario.BControl:= ValorFechaFactura;
  btnValorFechaFactura.CalendarShow;
end;

procedure TFMGastosSalida.QGastosSalidaAfterScroll(DataSet: TDataSet);
begin
  botoneraDespl;
end;

end.


