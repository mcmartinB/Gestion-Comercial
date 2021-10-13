unit MFacturas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, Derror, StdCtrls, DBTables,
  nbLabels;

type
  TFMFacturas = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    LEmpresa_f: TLabel;
    empresa_f: TBDEdit;
    LCliente_fac_f: TLabel;
    cliente_fac_f: TBDEdit;
    BCBFecha_factura_f: TBCalendarButton;
    LCliente_sal_f: TLabel;
    cliente_sal_f: TBDEdit;
    BGBCliente_sal_f: TBGridButton;
    STCliente_sal_f: TStaticText;
    Label13: TLabel;
    ACampos: TAction;
    LN_Factura_f: TLabel;
    LFecha_factura_f: TLabel;
    LMoneda_f: TLabel;
    LImporte_neto_f: TLabel;
    LTotal_impuesto_f: TLabel;
    LImporte_total_f: TLabel;
    LPrevision_cobro_f: TLabel;
    n_factura_f: TBDEdit;
    fecha_factura_f: TBDEdit;
    tipo_factura_f: TBDEdit;
    moneda_f: TBDEdit;
    importe_neto_f: TBDEdit;
    total_impuesto_f: TBDEdit;
    importe_total_f: TBDEdit;
    prevision_cobro_f: TBDEdit;
    BGBMoneda_f: TBGridButton;
    BGBEmpresa_f: TBGridButton;
    BGBCliente_fac_f: TBGridButton;
    STEmpresa_f: TStaticText;
    STCliente_fac_f: TStaticText;
    STMoneda_f: TStaticText;
    BCBPrevision_cobro_f: TBCalendarButton;
    RejillaFlotante: TBGrid;
    LTipo_impuesto_f: TLabel;
    tipo_impuesto_f: TBDEdit;
    BGBTipo_impuesto_f: TBGridButton;
    STTipo_impuesto_f: TStaticText;
    Label1: TLabel;
    importe_euros_f: TBDEdit;
    TImpuestos: TTable;
    QFacturas: TQuery;
    QFacturaManual: TQuery;
    DSFacturaManual: TDataSource;
    pgFactura: TPageControl;
    tsRemesa: TTabSheet;
    tsTexto: TTabSheet;
    mmoTextoFacutura: TDBMemo;
    tsAbono: TTabSheet;
    pBotonera: TPanel;
    BtnUno: TButton;
    QDetalleAbono: TQuery;
    DSDetalleAbono: TDataSource;
    grdAbonos: TDBGrid;
    btnDos: TButton;
    btnTres: TButton;
    pnlAbono: TPanel;
    nbLabel2: TnbLabel;
    centro_salida_fal: TBDEdit;
    nbLabel1: TnbLabel;
    n_albaran_fal: TBDEdit;
    nbLabel3: TnbLabel;
    fecha_albaran_fal: TBDEdit;
    btnFechaAlbaran: TBCalendarButton;
    producto_fal: TBDEdit;
    nbLabel4: TnbLabel;
    nbLabel5: TnbLabel;
    categoria_fal: TBDEdit;
    nbLabel6: TnbLabel;
    importe_fal: TBDEdit;
    nbLabel7: TnbLabel;
    cosechero_fal: TBDEdit;
    nbLabel8: TnbLabel;
    envase_fal: TBDEdit;
    nbLabel9: TnbLabel;
    nbLabel10: TnbLabel;
    unidad_fal: TComboBox;
    unidades_fal: TBDEdit;
    nbLabel11: TnbLabel;
    precio_fal: TBDEdit;
    lblTipoFactura: TStaticText;
    cbxFacturaAbono: TComboBox;
    lblFacturaAbono: TLabel;
    lblManualAutomatica: TLabel;
    cbxManualAutomatica: TComboBox;
    concepto_f: TBDEdit;
    lblAbonoEnNegativo01: TLabel;
    lblAbonoEnNegativo02: TLabel;
    LContabilizado_f: TLabel;
    Contabilizado_f: TDBCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    filename_conta_f: TBDEdit;
    cbxContabilizado_f: TComboBox;
    lblAnulacionFactura: TStaticText;
    nbLabel12: TnbLabel;
    centro_origen_fal: TBDEdit;
    Bevel1: TBevel;
    stCentroSalida: TnbStaticText;
    stProducto: TnbStaticText;
    stEnvase: TnbStaticText;
    stCentroOrigen: TnbStaticText;
    stCategoria: TnbStaticText;
    btnCentroSalida: TBGridButton;
    btnProducto: TBGridButton;
    btnEnvase: TBGridButton;
    btnCentroOrigen: TBGridButton;
    btnCategoria: TBGridButton;
    btnCosechero: TBGridButton;
    stCosechero: TnbStaticText;
    CalendarioFlotante: TBCalendario;
    DBGRemesas: TDBGrid;
    DSRemesas: TDataSource;
    QRemesas: TQuery;
    QRemesasremesa_fr: TIntegerField;
    QRemesasfecha_remesa_fr: TDateField;
    QRemesasimporte_cobrado_fr: TFloatField;
    Label4: TLabel;
    QRemesasmoneda_fr: TStringField;
    QImporteCobrado: TQuery;
    DSImporteCobrado: TDataSource;
    importe_cobrado: TBDEdit;
    pBuscarRemesa: TPanel;
    btnBuscarRemesa: TButton;
    porc_impuesto_f: TBDEdit;
    lblPorIva: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject;
      var isTime: Boolean);
    procedure n_factura_fExit(Sender: TObject);
    procedure Contabilizado_fEnter(Sender: TObject);
    procedure Contabilizado_fExit(Sender: TObject);
    procedure PorcentajeImpuesto(Sender: TObject);
    procedure CalculaImpuestos(Sender: TObject);
    procedure CalcularTotal2(Sender: TObject);
    procedure BtnUnoClick(Sender: TObject);
    procedure CalcularTotal(Sender: TObject);
    procedure QFacturasAfterEdit(DataSet: TDataSet);
    procedure QFacturasAfterCancel(DataSet: TDataSet);
    procedure QFacturasAfterPost(DataSet: TDataSet);
    procedure QFacturasBeforeInsert(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure CambiarMoneda(Sender: TObject);
    procedure QFacturasAfterOpen(DataSet: TDataSet);
    procedure QFacturasBeforeClose(DataSet: TDataSet);
    procedure pgFacturaChange(Sender: TObject);
    procedure DSMaestroStateChange(Sender: TObject);
    procedure btnDosClick(Sender: TObject);
    procedure btnTresClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure QFacturasAfterScroll(DataSet: TDataSet);
    procedure unidad_falChange(Sender: TObject);
    procedure QDetalleAbonoNewRecord(DataSet: TDataSet);
    procedure unidades_falChange(Sender: TObject);
    procedure QDetalleAbonoAfterEdit(DataSet: TDataSet);
    procedure QDetalleAbonoBeforePost(DataSet: TDataSet);
    procedure importe_falChange(Sender: TObject);
    procedure tipo_factura_fChange(Sender: TObject);
    procedure cbxFacturaAbonoChange(Sender: TObject);
    procedure cbxManualAutomaticaChange(Sender: TObject);
    procedure PonNombreDetalle(Sender: TObject);
    procedure QRemesasCalcFields(DataSet: TDataSet);
    procedure btnBuscarRemesaClick(Sender: TObject);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;
    bFacturaContabilizada: string;
    bAbono: boolean;
    rOldImporteAlbaran: Real;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

    procedure FacturacionManual;
    function NumeroCopias: Integer;

    procedure ConfigurarUnidadAbono;
    procedure MsgImporteAbono( const AVisible, ADetalle: boolean );

    procedure tsRemesaEnabled( const AEnable: Boolean );

  public
    numfac: integer;
    cambiado: boolean;
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;
    procedure Borrar; override;


    procedure BorrarFactura;
    procedure BorrarSalida;
    procedure BorrarEdi;
    procedure BorrarConcepto;
    procedure BorrarDatosAbono;

    procedure CambioRegistro;
    procedure AntesDeInsertar;
    procedure AntesDeLocalizar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;
    procedure QFacturasAfterInsert(DataSet: TDataSet);

    //Listado
    procedure Previsualizar; override;

    procedure Altas; override;
  end;

//var
  //FMFacturas: TFMFacturas;

implementation

uses bMath, UDMAuxDB, CVariables, CGestionPrincipal, UDMBaseDatos,
     UDMFacturacion, CAuxiliarDB, Principal, bDialogs, LFRepeticionFacturas,
     DFacturaManual, QLFacturaManual, DPreview, bSQLUtils, bNumericUtils,
     Variants, CFDFacturaManual, UDMCambioMoneda, DConfigMail, UDMConfig;

{$R *.DFM}

function YaFacture(AUsuario: string): Boolean;
begin
  with DMBaseDatos.QAux.SQL do
  begin
    Clear;
    Add(' update cnf_facturacion ');
    Add(' set facturando_cg = NULL ');
    Add(' where facturando_cg = ' + QuotedStr(gsCodigo));
  end;
  DMBaseDatos.QAux.ExecSQL;
  result := DMBaseDatos.QAux.RowsAffected = 1
end;

function PuedoFacturar(const AQuien: string; var VUsuario: string): Boolean;
begin
  with DMBaseDatos.QAux.SQL do
  begin
    Clear;
    Add(' update cnf_facturacion ');
    Add(' set facturando_cg = ' + QuotedStr(gsCodigo));
    Add(' where facturando_cg is null ');
    Add('    or facturando_cg = ' + QuotedStr(''));
    Add('    or facturando_cg = ' + QuotedStr(gsCodigo));
  end;
  DMBaseDatos.QAux.ExecSQL;
  result := DMBaseDatos.QAux.RowsAffected = 1;

  //Si no puedo facturar dev el codigo del usuario que lo esta haciendo
  if not result then
  begin
    with DMBaseDatos.QAux.SQL do
    begin
      Clear;
      Add(' select facturando_cg ');
      Add(' from cnf_facturacion ');
    end;
    try
      DMBaseDatos.QAux.Open;
      VUsuario := DMBaseDatos.QAux.Fields[0].AsString;
    finally
      DMBaseDatos.QAux.Close;
    end;
  end;
end;

function DesUsuario(AUsuario: string): string;
begin
  with DMBaseDatos.QAux.SQL do
  begin
    Clear;
    Add(' select descripcion_cu ');
    Add(' from cnf_usuarios ');
    Add(' where usuario_cu = ' + QuotedStr(AUsuario));
  end;
  try
    DMBaseDatos.QAux.Open;
    if not DMBaseDatos.QAux.IsEmpty then
      result := DMBaseDatos.QAux.Fields[0].AsString
    else
      result := AUsuario;
  finally
    DMBaseDatos.QAux.Close;
  end;
end;

procedure TFMFacturas.AbrirTablas;
begin
     // Abrir las tablas estrictamentes necesarias aqui,
     // las que sólo se usan para poner el nombre en una etiqueta
     // (las que se llaman en "PonNombre" se abren en su correspondiente
     // function por lo que no es necesario abrilas aqui
     {
        ABRE TABLAS AQUI SI ES NECESARIO
     }


     // Abrir tablas/Querys
  if not DataSetMaestro.Active then
  begin
    DataSetMaestro.SQL.Clear;
    DataSetMaestro.SQL.Add(Select);
    DataSetMaestro.SQL.Add(Where);
    DataSetMaestro.SQL.Add(Order);
    DataSetMaestro.Open;
  end;
     //Estado inicial
  Registros := DataSetMaestro.RecordCount;
  if Registros > 0 then
    Registro := 1
  else
    Registro := 0;
  RegistrosInsertados := 0;
end;

procedure TFMFacturas.CerrarTablas;
begin
      //Cerramos todos los dataSet abiertos
  DMBaseDatos.DBBaseDatos.CloseDataSets;
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMFacturas.FormCreate(Sender: TObject);
begin
  MultiplesAltas := false;
  pgFactura.ActivePage := tsRemesa;
  pgFacturaChange(pgFactura);
  pnlAbono.Visible := False;

     //Variables globales
  M := Self; //Formulario maestro --> siempre es necesario
  MD := nil; //:=Self;  -->Formulario Maestro-Detalle

     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //***************************************************************
     //Fuente de datos maestro
  DataSetMaestro := QFacturas;

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
  Select := ' SELECT * FROM frf_facturas  ';
  where := ' WHERE (empresa_f="###")AND (n_factura_f=00000) AND (fecha_factura_f = "01/01/1900")';
  Order := ' ORDER BY fecha_factura_f DESC, n_factura_f, empresa_f ';

  with QFacturaManual do
  begin
    SQL.Clear;
    SQL.Add(' select texto_fm ');
    SQL.Add(' from frf_fac_manual ');
    SQL.Add(' where empresa_fm = :empresa_f ');
    SQL.Add(' and factura_fm = :n_factura_f ');
    SQL.Add(' and fecha_fm = :fecha_factura_f ');
    if not Prepared then
      Prepare;
  end;

  with QDetalleAbono do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_fac_abonos_l ');
    SQL.Add(' where empresa_fal = :empresa_f ');
    SQL.Add(' and factura_fal = :n_factura_f ');
    SQL.Add(' and fecha_fal = :fecha_factura_f ');
    if not Prepared then
      Prepare;
  end;

  with QRemesas do
  begin
    SQL.Clear;
    SQL.Add(' select remesa_fr, fecha_remesa_fr, importe_cobrado_fr ');
    SQL.Add(' from frf_facturas_remesa ');
    SQL.Add(' where empresa_fr = :empresa_f ');
    SQL.Add(' and factura_fr = :n_factura_f ');
    SQL.Add(' and fecha_factura_fr = :fecha_factura_f ');
    if not Prepared then
      Prepare;
  end;

  with QImporteCobrado do
  begin
    SQL.Clear;
    SQL.Add(' select sum(importe_cobrado_fr) importe_cobrado');
    SQL.Add(' from frf_facturas_remesa ');
    SQL.Add(' where empresa_fr = :empresa_f ');
    SQL.Add(' and factura_fr = :n_factura_f ');
    SQL.Add(' and fecha_factura_fr = :fecha_factura_f ');
    if not Prepared then
      Prepare;
  end;

     //Abrir tablas/Querys
  try
    AbrirTablas;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
              //si no podemos abrir la tabla cerramos el formulario
      Close;
      Exit;
    end;
  end;

     //Lista de componentes, para optimizar recorrido
  Lista := TList.Create;
  PMaestro.GetTabOrderList(Lista);

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Visualizar estado inicial
  Visualizar;

      //Sólo necesario si utilizamos la rejilla despegable
      //pero si no lo borras no pasa nada - deberias borrarlo
  DMBaseDatos.QDespegables.Tag := kNull;

{*RELLENAR, CONSTANTES EN CVariables }
     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_f.Tag := kEmpresa; //Para mostrar rejilla flotante
  cliente_sal_f.Tag := KCliente; //Para poner nombre rejilla
  cliente_fac_f.Tag := KCliente; //Para mostrar el calendario
  moneda_f.Tag := KMoneda; //Para poner todos los nombres
  tipo_impuesto_f.Tag := kImpuesto; //del panel maestro
  fecha_factura_f.Tag := kCalendar;
  prevision_cobro_f.Tag := kCalendar;
     //PMaestro.Tag:=kMaestro;

  fecha_albaran_fal.Tag:= kCalendar;
  centro_salida_fal.Tag:= kCentro;
  centro_origen_fal.Tag:= kCentro;
  producto_fal.Tag:= kProducto;
  envase_fal.Tag:= kEnvase;
  categoria_fal.Tag:= kCategoria;
  cosechero_fal.Tag:= kCosechero;


  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnChangeMasterRecord := CambioRegistro;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnBrowse := AntesDeLocalizar;
  OnView := AntesDeVisualizar;
  QFacturas.AfterInsert := QFacturasAfterInsert;

     //Focos
  FocoAltas := empresa_f;
  FocoModificar := prevision_cobro_f;
  FocoLocalizar := empresa_f;



     //Inicializar variables
  CalendarioFlotante.Date := Date;
  cambiado := false;

  tsRemesaEnabled( False );
end;

procedure TFMFacturas.FormActivate(Sender: TObject);
begin
     //Si la tabla no esta abierta salimos
  if not DataSetMaestro.Active then Exit;
     //Variables globales
  M := Self;
  MD := nil;
{*DEJAR LAS NECESARIAS}
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := CalendarioFlotante;


     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;


procedure TFMFacturas.FormDeactivate(Sender: TObject);
begin
{*DEJAR LAS QUE TENIAN VALOR }
   //Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF := nil;

end;

procedure TFMFacturas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Lista.Free;

     (*MAL*)//No deberiamos hacer referncia directa a FPrincipal
     //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
     //Codigo de desactivacion
  CerrarTablas;


{*DEJAR LAS QUE TENIAN VALOR }
     //Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF := nil;

  with QFacturaManual do
  begin
    if Prepared then
      UnPrepare;
  end;
  with QDetalleAbono do
  begin
    if Prepared then
      UnPrepare;
  end;
  with QRemesas do
  begin
    if Prepared then
      UnPrepare;
  end;

  with QImporteCobrado do
  begin
    if Prepared then
      UnPrepare;
  end;

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMFacturas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin


{*DEJAR SI EXISTE CALENDARIO}
    //Si  el calendario esta desplegado no hacemos nada
  if (CalendarioFlotante <> nil) then
    if (CalendarioFlotante.Visible) then
            //No hacemos nada
      Exit;

  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
            //No hacemos nada
      Exit;


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
  end;

end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************
//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que concuerdan
//con los capos que hemos rellenado

procedure TFMFacturas.Filtro;
var Flag: Boolean;
  i: Integer;
begin
  where := ''; Flag := false;
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBEdit) then
    begin
      with Objeto as TBEdit do
      begin
        if Trim(Text) <> '' then
        begin
          if flag then where := where + ' and ';
          if InputType = itChar then
            where := where + ' ' + name + ' LIKE ' + '"' + Text + '"'
          else
            if InputType = itDate then
              where := where + ' ' + name + ' =' + SQLDate(Text)
            else
              where := where + ' ' + name + ' ="' + Text + '" ';
          flag := true;
        end;
      end;
    end;
  end;

  (*TODO*)
  (*
  if Trim(remesa_f.Text) <> '' then
  begin
    if flag then
    begin
      where := where + ' and ';
    end;
    where := where + ' remesa_f = ' + remesa_f.Text;
    flag := true;
  end;
  *)

   if Trim(filename_conta_f.Text) <> '' then
  begin
    if flag then
    begin
      where := where + ' and ';
    end;
    where := where + ' filename_conta_f LIKE ''%' + Trim(filename_conta_f.Text) + '%''';
    flag := true;
  end;

  case cbxContabilizado_f.ItemIndex of
    1:
    begin
      if flag then
      begin
        where := where + ' and ';
      end;
      where := where + ' Contabilizado_f = ''S'' ';
      flag := true;
    end;
    2:
    begin
      if flag then
      begin
        where := where + ' and ';
      end;
      where := where + ' Contabilizado_f <> ''S'' ';
      flag := true;
    end;
  end;

  if flag then where := ' WHERE ' + where;
end;

//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que son insertados
//para, else fin usa los campos que marcamos como PrimaryKey

procedure TFMFacturas.AnyadirRegistro;
var Flag: Boolean;
  i: Integer;
begin
  Flag := false;
  if where <> '' then where := where + ' OR ('
  else where := ' WHERE (';

  for i := 0 to Lista.Count - 1 do
  begin
    objeto := Lista.Items[i];
    if (objeto is TBDEdit) then
    begin
      with objeto as TBDEdit do
      begin
        if PrimaryKey and (Trim(Text) <> '') then
        begin
          if flag then where := where + ' and ';
          if InputType = itDate then
            where := where + ' ' + name + ' =' + SQLDate(Text)
          else
            where := where + ' ' + name + ' =' + '"' + Text + '"';
          flag := true;
        end;
      end;
    end;
  end;
  where := where + ') ';
end;


//function semi-generica, introducir restricciones particulares donde se indica
//Conprueba que tengan valor todos los campos marcados como required

procedure TFMFacturas.ValidarEntradaMaestro;
var
  rAux: real;
begin
  //Los abonos son negativos y las facturas positiva
  if tipo_factura_f.Text = '381' then
  begin
    rAux:= StrToFloatDef( importe_neto_f.Text, 0 );
    if rAux > 0 then
    begin
      raise Exception.Create( 'El importe del abono debe ser negativo.' );
    end;
  end
  else
  begin
    rAux:= StrToFloatDef( importe_neto_f.Text, 0 );
    if rAux < 0 then
    begin
      raise Exception.Create( 'El importe de la factura debe ser positivo.' );
    end;
  end;
end;

//**************************************************************
//IMPRESION: Introducir QuickReport
//**************************************************************

procedure TFMFacturas.Previsualizar;
var
  FLRepeticionFacturas: TFLRepeticionFacturas;
begin
  DConfigMail.sEmpresaConfig:= empresa_f.Text;
  DConfigMail.sClienteConfig:= cliente_fac_f.Text;
  DConfigMail.sAlbaranConfig:= n_factura_f.Text;

  if ( tipo_factura_f.Text <> '380' ) or ( concepto_f.Text = 'M' ) then
    FacturacionManual
  else
  begin
    FLRepeticionFacturas := TFLRepeticionFacturas.Create(nil);
    FLRepeticionFacturas.Height:= 0;
    FLRepeticionFacturas.Width:= 0;
    FLRepeticionFacturas.Enabled := False;
    FLRepeticionFacturas.eEmpresa.Text := QFacturas.FieldByName('empresa_f').AsString;
    FLRepeticionFacturas.eFacturaHasta.Text := QFacturas.FieldByName('n_factura_f').AsString;
    FLRepeticionFacturas.eFacturaDesde.Text := QFacturas.FieldByName('n_factura_f').AsString;
    FLRepeticionFacturas.eFechaHasta.Text := QFacturas.FieldByName('fecha_factura_f').AsString;
    FLRepeticionFacturas.eFechaDesde.Text := QFacturas.FieldByName('fecha_factura_f').AsString;
    FLRepeticionFacturas.printOriginal.Checked := True;
    FLRepeticionFacturas.printEmpresa.Checked := False;
    FLRepeticionFacturas.cbxSoloVer.Checked := True;
    FLRepeticionFacturas.chkKilos.Checked := True; //( empresa_f.Text = '080' ) and ( cliente_fac_f.Text = 'BAG' );
    try
      FLRepeticionFacturas.RepetirFactura;
    finally
      FreeAndNil(FLRepeticionFacturas);
      FPrincipal.AIPrevisualizar.Enabled:= True;
    end;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar rejilla flotante (Formulario)
//   - Borrar Lista de acciones(Formulario)
//   - Borrar las funciones de esta seccion(Codigo)
//*****************************************************************************
//*****************************************************************************

procedure TFMFacturas.ARejillaFlotanteExecute(Sender: TObject);
var
  sAux: string;
begin
{*CAMBIAR }
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa_f);
    kCliente:
      begin
        if (ActiveControl.Name = Cliente_sal_f.Name) then
          DespliegaRejilla(BGBCliente_sal_f);
        if (ActiveControl.Name = Cliente_fac_f.Name) then
          DespliegaRejilla(BGBCliente_fac_f);
      end;
    kMoneda: DespliegaRejilla(BGBMoneda_f);
    kImpuesto: DespliegaRejilla(BGBTipo_impuesto_f);
    kCalendar:
      begin
        if ActiveControl.Name = Fecha_factura_f.Name then
          DespliegaCalendario(BCBFecha_factura_f)
        else
        if ActiveControl.Name = Prevision_cobro_f.Name then
          DespliegaCalendario(BCBPrevision_cobro_f)
        else
          DespliegaCalendario(btnFechaAlbaran);
      end;
    kProducto: DespliegaRejilla(btnProducto, [empresa_f.text]);
    kEnvase: begin
               sAux:= GetProductoBase( empresa_f.Text, producto_fal.Text );
               DespliegaRejilla(btnEnvase, [empresa_f.text, sAux, cliente_fac_f.Text]);
             end;
    kCosechero: DespliegaRejilla(btnCosechero, [empresa_f.Text]);
    kCategoria: DespliegaRejilla(btnCategoria, [empresa_f.Text, producto_fal.Text]);
    kCentro: if centro_salida_fal.Focused then
               DespliegaRejilla(btnCentroSalida, [empresa_f.text])
             else
               DespliegaRejilla(btnCentroOrigen, [empresa_f.text]);
  end;

end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando cambia el registro activo
//Tambien se genera cuando se muestra el primero

procedure TFMFacturas.CambioRegistro;
begin
  pgFacturaChange(pgFactura);
(*
     if (Estado=teConjuntoResultado) and (registros>0) then
     begin
          if (concepto_f.ItemIndex = 1) then
          begin
            BtnUno.Enabled:=true;
          end
          else
          begin
            BtnUno.Enabled:=false;
          end;
     end
     else
     begin
          BtnUno.Enabled:=false;
     end;
*)
end;
//Evento que se produce cuando pulsamos altas
//Aprobrechar para modificar estado controles

procedure TFMFacturas.AntesDeInsertar;
begin
    //Actualizamos las variables que sean necesarias
  Cambiado := False;
  total_impuesto_f.Enabled := false;
  importe_total_f.Enabled := false;
  importe_euros_f.Enabled := false;
  BtnUno.Enabled := false;
  concepto_f.Enabled := true;
  MsgImporteAbono( tipo_factura_f.Text = '381', False );

  btnBuscarRemesa.Enabled:= False;
end;

//Evento que se produce cuando pulsamos localizar
//Aprobrechar para modificar estado controles

procedure TFMFacturas.AntesDeLocalizar;
begin
  BtnUno.Enabled := false;
  porc_impuesto_f.Text := '';
  total_impuesto_f.Text := '';
  importe_total_f.Text := '';
  importe_euros_f.Text := '';
  concepto_f.Enabled := false;

  cbxFacturaAbono.ItemIndex:= 0;
  lblFacturaAbono.Visible:= True;
  cbxFacturaAbono.Visible:= True;
  lblTipoFactura.Visible:= False;

  cbxManualAutomatica.ItemIndex:= 0;
  lblManualAutomatica.Visible:= True;
  cbxManualAutomatica.Visible:= True;

  pgFactura.Enabled:= True;
  pgFactura.ActivePage:= tsRemesa;
  tsRemesaEnabled(True);

  cbxContabilizado_f.Visible:= True;
  cbxContabilizado_f.ItemIndex:= 0;

  btnBuscarRemesa.Enabled:= False;
end;
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMFacturas.AntesDeModificar;
var i: Integer;
begin
  //Deshabilitamos todos los componentes Modificable=False
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;
    //Menos importe_neto, porcion_iva si la factura es manual
    //simepre que no este conatbilizado
  if ( concepto_f.Text = 'M' ) and not Contabilizado_f.Checked then
  begin
    //tipo_impuesto_f.Enabled := true;
    //tipo_factura_f.Enabled := true;
    importe_neto_f.Enabled := true;
    //porc_impuesto_f.Enabled := true;
  end;
  BtnUno.Enabled := false;
  concepto_f.Enabled := true;
  MsgImporteAbono( tipo_factura_f.Text = '381', False );

  btnBuscarRemesa.Enabled:= False;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMFacturas.AntesDeVisualizar;
var i: Integer;
begin
  //Resaturamos estado controles
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          if Enabled = false then Enabled := true;
  end;

  //Al aceptar localizar rellenan la descripcion estas funciones
  //por eso hay que llamarlas desde aqui otra vez.
  STCliente_sal_f.Caption := desCliente(empresa_f.Text, cliente_sal_f.Text);
  STCliente_fac_f.Caption := desCliente(empresa_f.Text, cliente_fac_f.Text);
  concepto_f.Enabled := true;

  lblFacturaAbono.Visible:= False;
  cbxFacturaAbono.Visible:= False;
  lblTipoFactura.Visible:= True;

  lblManualAutomatica.Visible:= False;
  cbxManualAutomatica.Visible:= False;

  MsgImporteAbono( False, False );
  tsRemesaEnabled( False);

  Contabilizado_f.Visible:= True;
  cbxContabilizado_f.Visible:= False;

  btnBuscarRemesa.Enabled:= True;
end;

procedure TFMFacturas.n_factura_fExit(Sender: TObject);
begin
  if IntToStr(numfac) <> n_factura_f.Text then
    cambiado := True;
end;

procedure TFMFacturas.Contabilizado_fEnter(Sender: TObject);
begin
  if Estado in [teModificar, teAlta] then
    TDBCheckBox(Sender).Color := clMoneyGreen;
end;

procedure TFMFacturas.Contabilizado_fExit(Sender: TObject);
begin
  TDBCheckBox(Sender).Color := clSilver;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMFacturas.PonNombre(Sender: TObject);
begin
{*    }
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
     //*********************************
     //FUNCIONES DEFINIDAS EN CAuxiliarDB
     //DEJAR LAS NECESARIAS, AÑADIR LAS QUE FALTEN
     //*********************************
  case TComponent(Sender).Tag of
    kImpuesto:
      begin
        STTipo_impuesto_f.Caption := desImpuesto(tipo_impuesto_f.Text);
      end;
    kCliente:
      begin
        if (Sender = Cliente_sal_f) then
          STCliente_sal_f.Caption := desCliente(empresa_f.Text, cliente_sal_f.Text);
        if Sender = Cliente_fac_f then
          STCliente_fac_f.Caption := desCliente(empresa_f.Text, cliente_fac_f.Text);
      end;
    kEmpresa:
    begin
      STEmpresa_f.Caption := desEmpresa(empresa_f.Text);
    end;
  end;
end;

//Para saber cuando tenemos que obligar a que un campo sea requerido

procedure TFMFacturas.RequiredTime(Sender: TObject;
  var isTime: Boolean);
begin
  isTime := false;
  if TBEdit(Sender).CanFocus then
  begin
    if (Estado = teLocalizar) then
      Exit;
    if (gRF <> nil) and (esVisible( gRF ) = true) then
      Exit;
    if (gCF <> nil) and (esVisible( gCF ) = true) then
      Exit;
    isTime := true;
  end;
end;

procedure TFMFacturas.PorcentajeImpuesto(Sender: TObject);
begin
  PonNombre(Sender);
end;

procedure TFMFacturas.CalculaImpuestos(Sender: TObject);
begin
  if (Estado = teAlta) then
  begin
       //tenemos que tener un porcentaje y un importe
       //obligatoriamente los dos
    if (trim(importe_neto_f.Text) <> '') and
      (trim(porc_impuesto_f.Text) <> '') then
    begin
        total_impuesto_f.Text := FormatFloat('#0.00',
          bRoundTo( bRoundTo( (StrToFloat(importe_neto_f.Text) * Redondea(StrToFloat(porc_impuesto_f.Text) / 100, 2)),2),2));
    end
    else
    begin
      total_impuesto_f.Text := '0';
    end;
  end;
end;

procedure TFMFacturas.CalcularTotal(Sender: TObject);
begin
  if (Estado <> teLocalizar) and (Estado <> teConjuntoResultado) then
  begin
          //Si importe neto = 0  -> total = 0
    if (Trim(importe_neto_f.Text) = '') or
      (Trim(importe_neto_f.Text) = '-') or
      (Trim(importe_neto_f.Text) = '0') then
    begin
      importe_total_f.Text := '0';
      importe_euros_f.Text := '0';
      Exit;
    end;
          //Sino calculamos impuestos,sumamos neto + impuestos
    if (Trim(porc_impuesto_f.Text) <> '') then
    begin
        total_impuesto_f.Text := FormatFloat('#0.00',
          bRoundTo( (StrToFloat(importe_neto_f.Text) * Redondea(StrToFloat(porc_impuesto_f.Text) / 100, 2)),2));
    end
    else
      total_impuesto_f.Text := '0';

    if Trim(total_impuesto_f.Text) <> '' then
    begin
        importe_total_f.Text := FormatFloat('#0.00',
          bRoundTo( StrToFloat(importe_neto_f.Text) + StrToFloat(total_impuesto_f.Text),2));
    end
    else
      importe_total_f.Text := importe_neto_f.Text;

          //Si la moneda es euro ya lo tenemos sino lo calculamos
    if Trim(moneda_f.Text) <> '' then
    begin
      if moneda_f.Text = 'EUR' then
      begin
        importe_euros_f.Text := importe_total_f.Text;
      end
      else
        if length(Trim(moneda_f.Text)) = 3 then
        begin
          try
            importe_euros_f.Text := FloatToStr(
              ChangeToEuro( moneda_f.Text, fecha_factura_f.Text, StrToFloat(importe_total_f.Text) ) );
          except
            ShowMessage('ERROR al calcular el cambio a Euros, comprobar que la moneda sea correcta.');
          end;
        end;
    end;
  end;
end;

procedure TFMFacturas.CalcularTotal2(Sender: TObject);
begin
  if (Estado <> teLocalizar) and (Estado <> teConjuntoResultado) then
  begin
          //Si importe neto = 0  -> total = 0
    if Trim(importe_neto_f.Text) = '' then
    begin
      importe_total_f.Text := '0';
      Exit;
    end;
    if Trim(importe_neto_f.Text) = '0' then
    begin
      importe_total_f.Text := '0';
      Exit;
    end;
          //Sino sumamos neto + impuestos
    if Trim(total_impuesto_f.Text) <> '' then
    begin
        importe_total_f.Text := FormatFloat('#0.00',
          bRoundTo( StrToFloat(importe_neto_f.Text) + StrToFloat(total_impuesto_f.Text),2));
    end
    else
      importe_total_f.Text := importe_neto_f.Text;

          //Si la moneda es euro ya lo tenemos sino lo calculamos
    if Trim(moneda_f.Text) <> '' then
    begin
      if moneda_f.Text = 'EUR' then
      begin
        importe_euros_f.Text := importe_total_f.Text;
      end
      else
      begin
        importe_euros_f.Text := FloatToStr(
          ChangeToEuro( moneda_f.Text, fecha_factura_f.Text, StrToFloat(importe_total_f.Text) ) );
      end;
    end;
  end;
end;

procedure TFMFacturas.Borrar;
var
  sMsg, empresa, factura, fecha: string;
begin
  if Contabilizado_f.Checked then begin
    ShowError('No se puede borrar una factura que ya ha sido contabilizada.');
    Exit;
  end;

     //Barra estado
  Estado := teBorrar;
  BEEstado;
  BHEstado;

  empresa := empresa_f.Text;
  factura := n_factura_f.Text;
  fecha := fecha_factura_f.Text;

  if tipo_factura_f.Text = '380' then
    sMsg:= '¿Desea borrar la factura seleccionada?'
  else
    sMsg:= '¿Desea borrar el abono seleccionado?';

  if MessageDlg( sMsg, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
    begin
      Visualizar;
      Exit;
    end;

    try
      BorrarDatosAbono;
      BorrarConcepto;
      BorrarSalida;
      BorrarEdi;
      BorrarFactura;
           //Registrar('Borrado de la factura: '+empresa+'-'+factura+'-'+fecha);
    except
      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
    end;
    AceptarTransaccion(DMBaseDatos.DBBaseDatos);
  end;
  Visualizar;
end;

procedure TFMFacturas.BorrarFactura;
begin
  DataSeTMaestro.Delete;
  if Registro = Registros then
    Registro := Registro - 1;
  Registros := Registros - 1;
end;

procedure TFMFacturas.BorrarConcepto;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add(' DELETE FROM frf_fac_manual ' +
      ' WHERE empresa_fm=' + quotedstr(empresa_f.Text) +
      '   AND factura_fm=' + n_factura_f.Text +
      '   AND fecha_fm=' + SQLDate(fecha_factura_f.Text));
    EjecutarConsulta(DMBaseDatos.QGeneral);
  end;
end;

procedure TFMFacturas.BorrarDatosAbono;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    if  tipo_factura_f.Text = '381' then
    begin
      //ABONO
      SQL.Clear;
      SQL.Add(' delete from frf_facturas_abono ');
      SQL.Add(' where empresa_fa = :empresa ');
      SQL.Add(' and n_abono_fa = :factura ');
      SQL.Add(' and fecha_abono_fa = :fecha ');
      ParamByName('empresa').AsString:= empresa_f.Text;
      ParamByName('factura').AsInteger:= StrToInt( n_factura_f.Text );
      ParamByName('fecha').AsDateTime:= StrTodate( fecha_factura_f.Text );
      EjecutarConsulta(DMBaseDatos.QGeneral);
    end
    else
    begin
      //FACTURA
      SQL.Clear;
      SQL.Add(' delete from frf_facturas_abono ');
      SQL.Add(' where empresa_fa = :empresa ');
      SQL.Add(' and n_factura_fa = :factura ');
      SQL.Add(' and fecha_factura_fa = :fecha ');
      ParamByName('empresa').AsString:= empresa_f.Text;
      ParamByName('factura').AsInteger:= StrToInt( n_factura_f.Text );
      ParamByName('fecha').AsDateTime:= StrTodate( fecha_factura_f.Text );
      EjecutarConsulta(DMBaseDatos.QGeneral);
    end;

    SQL.Clear;
    SQL.Add(' delete from frf_fac_abonos_l ');
    SQL.Add(' where empresa_fal = :empresa ');
    SQL.Add(' and factura_fal = :factura ');
    SQL.Add(' and fecha_fal = :fecha ');
    ParamByName('empresa').AsString:= empresa_f.Text;
    ParamByName('factura').AsInteger:= StrToInt( n_factura_f.Text );
    ParamByName('fecha').AsDateTime:= StrTodate( fecha_factura_f.Text );
    EjecutarConsulta(DMBaseDatos.QGeneral);

    SQL.Clear;
    SQL.Add(' delete from frf_facturas_sal ');
    SQL.Add(' where empresa_fs = :empresa ');
    SQL.Add(' and n_factura_fs = :factura ');
    SQL.Add(' and fecha_factura_fs = :fecha ');
    ParamByName('empresa').AsString:= empresa_f.Text;
    ParamByName('factura').AsInteger:= StrToInt( n_factura_f.Text );
    ParamByName('fecha').AsDateTime:= StrTodate( fecha_factura_f.Text );
    EjecutarConsulta(DMBaseDatos.QGeneral);
  end;
end;

procedure TFMFacturas.BorrarSalida;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add(' UPDATE frf_salidas_c set ' +
      ' (n_factura_sc,fecha_factura_sc)=(NULL,NULL) ' +
      ' WHERE empresa_sc=' + quotedstr(empresa_f.Text) +
      '   AND n_factura_sc=' + n_factura_f.Text +
      '   AND fecha_factura_sc=' + SQLDate(fecha_factura_f.Text));
    EjecutarConsulta(DMBaseDatos.QGeneral);
  end;
end;

procedure TFMFacturas.BorrarEdi;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add(' DELETE FROM frf_facturas_edi_c ' +
      ' WHERE EMPRESA_FEC = ' + QuotedStr( empresa_f.Text ) +
      '   and factura_fec=' + n_factura_f.Text +
      '   AND fecha_factura_fec=' + SQLDate(fecha_factura_f.Text));
    EjecutarConsulta(DMBaseDatos.QGeneral);

    SQL.Clear;
    SQL.Add(' DELETE FROM frf_facturas_edi_l ' +
      ' WHERE EMPRESA_FEL = ' + QuotedStr( empresa_f.Text ) +
      '   and factura_fel=' + n_factura_f.Text +
      '   AND fecha_factura_fel=' + SQLDate(fecha_factura_f.Text));
    EjecutarConsulta(DMBaseDatos.QGeneral);

    SQL.Clear;
    SQL.Add(' DELETE FROM frf_impues_edi_l ' +
      ' WHERE EMPRESA_IEL = ' + QuotedStr( empresa_f.Text ) +
      '   and factura_iel=' + n_factura_f.Text +
      '   AND fecha_factura_iel=' + SQLDate(fecha_factura_f.Text));
    EjecutarConsulta(DMBaseDatos.QGeneral);

    SQL.Clear;
    SQL.Add(' DELETE FROM frf_impues_edi_c '+
      ' WHERE EMPRESA_IEC = ' + QuotedStr( empresa_f.Text ) +
      '   and factura_iec='+n_factura_f.Text+
            '   AND fecha_factura_iec='+SQLDate(fecha_factura_f.Text));
    EjecutarConsulta(DMBaseDatos.QGeneral);

  end;
end;

procedure TFMFacturas.FacturacionManual;
begin
  with DMBaseDatos.QListado do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    Sql.Clear;
    Sql.Add(' select f.n_factura_f factura, f.fecha_factura_f fecha, c.cliente_c cliente, ' +
      ' c.cta_cliente_c paga, c.nombre_c nombre, c.tipo_via_fac_c via, ' +
      ' c.domicilio_fac_c domicilio, c.poblacion_fac_c poblacion,  ' +
      ' c.cod_postal_fac_c codPostal, pr.nombre_p provincia, ' +
      ' c.pais_fac_c codPais, p.descripcion_p pais, c.nif_c nif, ' +
      ' fm.texto_fm concepto, i.descripcion_i impuesto, ' +
      ' f.porc_impuesto_f porcentaje, f.total_impuesto_f iva, ' +
      ' f.importe_neto_f neto, f.importe_total_f total, ' +
      ' f.importe_euros_f euros, fp.descripcion_fp des, fp.descripcion2_fp des2, ' +
      ' fp.descripcion3_fp des3, fp.descripcion4_fp des4, fp.descripcion5_fp des5,' +
      ' fp.descripcion6_fp des6, fp.descripcion7_fp des7, fp.descripcion8_fp des8,' +
      ' fp.descripcion9_fp des9, ' +
      ' f.empresa_f empresa, f.tipo_factura_f tipo_factura, f.tipo_impuesto_f tipo_impuesto ' +

      ' from frf_facturas f, frf_clientes c, frf_paises p, outer frf_provincias pr, ' +
      ' outer frf_fac_manual fm , outer frf_forma_pago fp , frf_impuestos i' +
      ' where f.empresa_f=:empresa ' +
      ' and   f.n_factura_f=:factura ' +
      ' and   f.fecha_factura_f=:fecha ' +
      ' and   f.empresa_f=c.empresa_c ' +
      ' and   f.cliente_fac_f=c.cliente_c ' +
      ' and   c.pais_c=p.pais_p ' +
      ' and   substr(c.cod_postal_fac_c,1,2)=pr.codigo_p ' +
      ' and   f.empresa_f=fm.empresa_fm ' +
      ' and   f.n_factura_f=fm.factura_fm ' +
      ' and   f.fecha_factura_f=fm.fecha_fm ' +
      ' and   c.forma_pago_c=fp.codigo_fp ' +
      ' and   f.tipo_impuesto_f=i.codigo_i');
    ParamByName('empresa').AsString := empresa_f.Text;
    ParamByName('factura').AsInteger := StrToInt(n_factura_f.Text);
    ParamByName('fecha').Asdatetime := StrTodate(fecha_factura_f.Text);

    try
      Open;
      First;
    except
      Exit;
    end;
  end;

     //Configuracion informe
  QRLFacturaManual := TQRLFacturaManual.Create(Application);
  with QRLFacturaManual do
  begin
    Configurar(empresa_f.Text);
    LMon1.Caption := moneda_f.Text;
    LMon2.Caption := moneda_f.Text;
    LMon3.Caption := moneda_f.Text;
    if moneda_f.Text = 'EUR' then
    begin
      LEuro.Enabled := false;
      MEuro.Enabled := false;
      REuro.Enabled := false;
      cantEuro.Enabled := false;
    end
    else
    begin
      LEuro.Enabled := true;
      MEuro.Enabled := true;
      REuro.Enabled := true;
      cantEuro.Enabled := true;
    end;

    if (Trim(porc_impuesto_f.Text) <> '') and
      (StrToFloat(porc_impuesto_f.Text) = 0) then
    begin
      desImpuestos.Enabled := true;
      liva.Enabled := false;
      liva2.Enabled := false;
      lmon2.Enabled := false;
      rIva.Enabled := false;
      cantIva.Enabled := false;
    end
    else
    begin
      desImpuestos.Enabled := false;
      if copy(tipo_impuesto_f.Text, 1, 1) = 'G' then
      begin
        liva.Enabled := true;
        liva2.Enabled := false;
        liva.Caption := 'Total IGIC ';
      end
      else
      begin
        liva.Enabled := true;
        liva2.Enabled := true;
        liva.Caption := 'Total IVA ';
        liva2.Caption := '/ VAT';
      end;
      lmon2.Enabled := true;
      rIva.Enabled := true;
      cantIva.Enabled := true;
    end;

    if tipo_factura_f.Text = '380' then
      DConfigMail.sAsunto:= 'Envío Factura '
    else
      DConfigMail.sAsunto:= 'Envío Abono ';
    DConfigMail.sAsunto:= DConfigMail.sAsunto + n_factura_f.Text + '[' + DesCliente( empresa_f.Text, cliente_fac_f.Text ) + ']';
    DPreview.Preview(QRLFacturaManual, 3, False, True);

  end;
end;

function TFMFacturas.NumeroCopias: Integer;
begin
  with DMBaseDatos.QGeneral do
  begin
    Tag := -1;
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add('SELECT c.n_copias_fac_c ');
    SQL.Add('FROM frf_clientes c ');
    SQL.Add('WHERE  (c.empresa_c=' + QuotedStr(empresa_f.Text) + ') ');
    SQL.Add('AND  (c.cliente_c=' + QuotedStr(cliente_fac_f.Text) + ') ');

    try
      AbrirConsulta(DMBaseDatos.QGeneral);
    except
      NumeroCopias := 3;
      Exit;
    end;

    if Fields[0].AsInteger > 0 then
      NumeroCopias := Fields[0].AsInteger
    else
      NumeroCopias := 3;
  end;
end;

procedure TFMFacturas.QFacturasAfterInsert(DataSet: TDataSet);
begin
  //Ponemos los checkBox de  contabilizado como false
  DataSet.FieldByName('contabilizado_f').AsString := 'N';

  if (Estado = teAlta) then
  begin
    if bAbono = true then
    begin
      DataSet.FieldByName('tipo_factura_f').AsInteger := 381;
      tipo_factura_f.Text:= '381';
    end
    else
    begin
      DataSet.FieldByName('tipo_factura_f').AsInteger := 380;
      tipo_factura_f.Text:= '380';
    end;
    QFacturas.FieldByName('concepto_f').AsString := 'M'
  end;
end;


procedure TFMFacturas.QFacturasAfterEdit(DataSet: TDataSet);
begin
  bFacturaContabilizada := DataSet.FieldByName('contabilizado_f').AsString;
end;

procedure TFMFacturas.QFacturasAfterCancel(DataSet: TDataSet);
begin
  //Desmarcamos que estamos facturando
  if (Estado = teAlta) then YaFacture(gsCodigo);
end;

procedure TFMFacturas.QFacturasAfterPost(DataSet: TDataSet);
begin
  //Desmarcamos que estamos facturando
  if (Estado = teAlta) then YaFacture(gsCodigo);
  QFacturasAfterScroll(QFacturas);
end;

procedure TFMFacturas.QFacturasBeforeInsert(DataSet: TDataSet);
var
  sAux: string;
begin
  if (Estado = teAlta) then
  begin
    sAux := gsCodigo;
    if not PuedoFacturar(gsCodigo, sAux) then
    begin
      ShowMessage('En este momento esta facturando ' + DesUsuario(sAux) +
        #13 + #10 + 'Por favor, intentelo mas tarde.');
      CancelarAlta;
      Abort;
    end;
  end;
end;

procedure TFMFacturas.FormDestroy(Sender: TObject);
begin
  //Por si acaso se produce algun error
  YaFacture(gsCodigo);
end;

procedure TFMFacturas.CambiarMoneda(Sender: TObject);
begin
  STMoneda_f.Caption := desMoneda(moneda_f.Text);
  if QFacturas.State in [dsInsert, dsEdit] then
    CalcularTotal(nil);
end;

procedure TFMFacturas.QFacturasAfterOpen(DataSet: TDataSet);
begin
  QFacturaManual.Open;
  QDetalleAbono.Open;
  QRemesas.Open;
  QImporteCobrado.Open;

  if not QFacturas.IsEmpty then
  begin
    tsAbono.TabVisible := QFacturas.FieldByName('concepto_f').AsString = 'M';
    tsTexto.TabVisible := ( QFacturas.FieldByName('tipo_factura_f').AsString <> '380' ) or
                          ( QFacturas.FieldByName('concepto_f').AsString = 'M' );
  end
  else
  begin
    tsTexto.TabVisible := False;
    tsAbono.TabVisible := False;
  end;

  lblAnulacionFactura.Visible:= False;
  if not QFacturas.IsEmpty then
  begin
    if QFacturas.FieldByName('anulacion_f').AsInteger <> 0 then
    begin
      lblAnulacionFactura.Visible:= True;
      if QFacturas.FieldByName('tipo_factura_f').AsString = '380'  then
      begin
        with DMFacturacion.QGetAbonoAnulacion do
        begin
          ParamByName('empresa').AsString:= empresa_f.Text;
          ParamByName('factura').AsString:= n_factura_f.Text;
          ParamByName('fecha').AsString:= fecha_factura_f.Text;
          Open;
          lblAnulacionFactura.Caption:= 'ANULADA POR ('+
            FieldByName('empresa_fa').AsString + ' - ' +
            FieldByName('n_abono_fa').AsString + ' - ' +
            FieldByName('fecha_abono_fa').AsString + ')';
          Close;
        end;
      end
      else
      begin
        with DMFacturacion.QGetFacturaAnulacion do
        begin
          ParamByName('empresa').AsString:= empresa_f.Text;
          ParamByName('abono').AsString:= n_factura_f.Text;
          ParamByName('fecha').AsString:= fecha_factura_f.Text;
          Open;
          lblAnulacionFactura.Caption:= 'ANULA A ('+
            FieldByName('empresa_fa').AsString + ' - ' +
            FieldByName('n_factura_fa').AsString + ' - ' +
            FieldByName('fecha_factura_fa').AsString + ')';
          Close;
        end;
      end;
    end
  end;
end;

procedure TFMFacturas.QFacturasBeforeClose(DataSet: TDataSet);
begin
  QFacturaManual.Close;
  QDetalleAbono.Close;
  QRemesas.Close;
  QImporteCobrado.Close;
end;

procedure TFMFacturas.pgFacturaChange(Sender: TObject);
begin
  case pgFactura.ActivePageIndex of
    0: begin
        (*A
        BtnUno.Caption := 'Modificar';
        *)
        BtnUno.Caption := '-';
        BtnDos.Caption := '-';
        BtnTres.Caption := '-';
        (*A
        BtnUno.Enabled := not QFacturas.IsEmpty;
        *)
        BtnUno.Enabled := False;
        BtnDos.Enabled := False;
        BtnTres.Enabled := False;
        pBuscarRemesa.Visible:= True;
      end;
    1: begin
        BtnUno.Caption := 'Añadir';
        BtnDos.Caption := 'Modificar';
        BtnTres.Caption := 'Borrar';
        if not QFacturas.IsEmpty and
          ( ( QFacturas.FieldByName('tipo_factura_f').AsString <> '380' ) or (QFacturas.FieldByName('concepto_f').AsString = 'M') ) then
        begin
          BtnUno.Enabled := QFacturaManual.IsEmpty and not (Contabilizado_f.Checked );
          BtnDos.Enabled := not QFacturaManual.IsEmpty and not (Contabilizado_f.Checked );
          BtnTres.Enabled := not QFacturaManual.IsEmpty and not (Contabilizado_f.Checked );
        end
        else
        begin
          BtnUno.Enabled := False;
          BtnDos.Enabled := False;
          BtnTres.Enabled := False;
        end;
        pBuscarRemesa.Visible:= False;
      end;
    2: begin
        BtnUno.Caption := 'Añadir';
        BtnDos.Caption := 'Modificar';
        BtnTres.Caption := 'Borrar';
        if not QFacturas.IsEmpty and
          ( ( QFacturas.FieldByName('tipo_factura_f').AsString <> '380' ) or (QFacturas.FieldByName('concepto_f').AsString = 'M') ) then
        begin
          BtnUno.Enabled := True and not (Contabilizado_f.Checked );
          BtnDos.Enabled := not QDetalleAbono.IsEmpty and not (Contabilizado_f.Checked );
          BtnTres.Enabled := not QDetalleAbono.IsEmpty and not (Contabilizado_f.Checked );
        end
        else
        begin
          BtnUno.Enabled := False;
          BtnDos.Enabled := False;
          BtnTres.Enabled := False;
        end;
        pBuscarRemesa.Visible:= False;
      end;
  end;
  BtnUno.Tag := pgFactura.ActivePageIndex;
  BtnDos.Tag := pgFactura.ActivePageIndex;
  BtnTres.Tag := pgFactura.ActivePageIndex;
end;

procedure TFMFacturas.DSMaestroStateChange(Sender: TObject);
begin
  if QFacturas.State <> dsBrowse then
  begin
    pBotonera.Enabled := filename_conta_f.Enabled;
    pgFactura.Enabled := filename_conta_f.Enabled;
  end
  else
  begin
    pBotonera.Enabled := not QFacturas.isEmpty;
    pgFactura.Enabled := pBotonera.Enabled;
    if pBotonera.Enabled then
    begin
      pgFacturaChange(pgFactura);
    end;
  end;
end;

procedure TFMFacturas.BtnUnoClick(Sender: TObject);
begin
  if QFacturas.IsEmpty then Exit;
  case TButton(Sender).Tag of
    0:
      begin
        if ( Contabilizado_f.Checked  ) then
        begin
          ShowMessage(' No se puede modificar los datos de la remesa de una factura contabilizada. ' );
          Exit;
        end;

        BtnUno.Tag := 4;
        BtnUno.Caption := 'Aceptar';
        BtnDos.Tag := 4;
        BtnDos.Caption := 'Cancelar';
        BtnDos.Enabled := True;
        BtnTres.Visible := False;
        tsAbono.TabVisible := False;
        tsTexto.TabVisible := False;
        tsRemesaEnabled( True );
        BHDeshabilitar;
        QFacturas.Edit;
      end;
    1:
      begin
        with TFDFacturaManual.Create(self) do
        begin
          try
          //Rellenamos campos estaticos
            empresaText.Caption := STEmpresa_f.Caption;
            empresa.Text := empresa_f.Text;
            cliente_facText.Caption := STCliente_fac_f.Caption;
            cliente.Text := cliente_fac_f.Text;
            fecha.Text := fecha_factura_f.Text;
            factura.Text := n_factura_f.Text;
            DSFactura.DataSet := QFacturas;

            ShowModal;
          finally
            Free;
          end;
        end;
        QFacturaManual.Close;
        QFacturaManual.Open;
        pgFacturaChange(pgFactura);
      end;
    2:
      begin
        BtnUno.Tag := 3;
        BtnUno.Caption := 'Aceptar';
        BtnDos.Tag := 3;
        BtnDos.Caption := 'Cancelar';
        BtnDos.Enabled := True;
        BtnTres.Visible := False;
        tsRemesa.TabVisible := False;
        tsTexto.TabVisible := False;
        pnlAbono.Visible := True;
        BHDeshabilitar;
        QDetalleAbono.Insert;
        QDetalleAbono.FieldByName('empresa_fal').AsString := QFacturas.FieldByName('empresa_f').AsString;
        QDetalleAbono.FieldByName('factura_fal').AsString := QFacturas.FieldByName('n_factura_f').AsString;
        QDetalleAbono.FieldByName('fecha_fal').AsString := QFacturas.FieldByName('fecha_factura_f').AsString;
        rOldImporteAlbaran:= 0;
        centro_salida_fal.SetFocus;
        MsgImporteAbono( True, True );
      end;
    3:
      begin
        try
          QDetalleAbono.Post;
          QDetalleAbono.Close;
          QDetalleAbono.Open;
          BtnTres.Visible := True;
          tsRemesa.TabVisible := True;
          tsTexto.TabVisible := True;
          pgFacturaChange(pgFactura);
          pnlAbono.Visible := False;
          BHRestaurar;

          //mensaje si tiene comision
          with DMAuxDB.QAux do
          begin
            SQl.Clear;
            SQl.Add(' select * ');
            SQl.Add(' from frf_fac_abonos_l, frf_salidas_c, frf_clientes ');
            SQl.Add(' where empresa_fal = :empresa ');
            SQl.Add(' and factura_fal = :abono ');
            SQl.Add(' and fecha_fal = :fecha ');
            SQl.Add(' and empresa_sc = :empresa ');
            SQl.Add(' and centro_salida_sc = centro_salida_fal ');
            SQl.Add(' and n_albaran_sc =  n_albaran_fal ');
            SQl.Add(' and fecha_sc = fecha_albaran_fal ');
            SQl.Add(' and empresa_c = :empresa ');
            SQl.Add(' and cliente_c = cliente_fac_sc ');
            SQl.Add(' and ( exists (select * from frf_clientes_descuento ');
            SQl.Add('               where empresa_cd = :empresa ');
            SQl.Add('               and cliente_cd = cliente_fac_sc ');
            SQl.Add('               and fecha_factura_sc between fecha_ini_cd and nvl(fecha_fin_cd,Today) ');
            SQl.Add('               and descuento_cd <> 0 ');
            SQl.Add('               and facturable_cd = 1 ) ');
            SQl.Add('       or ');
            SQl.Add('       exists (select * from frf_representantes_comision ');
            SQl.Add('               where empresa_rc = :empresa ');
            SQl.Add('               and representante_rc = representante_c ');
            SQl.Add('               and fecha_factura_sc between fecha_ini_rc and nvl(fecha_fin_rc,Today) ');
            SQl.Add('               and comision_rc <> 0 ) ');
            SQl.Add('     ) ');
            ParamByName('empresa').AsString:= empresa_f.Text;
            ParamByName('abono').AsInteger:= StrToIntDef( n_factura_f.Text, 0 );
            ParamByName('fecha').AsDateTime:= StrToDateDef( fecha_factura_f.Text, Date );
            Open;
            if not IsEmpty then
            begin
              ShowMessage('Cliente con descuento facturable o con representante con comisión, por favor revise los importes.');
            end;
            Close;
          end;

        except
          on e: exception do
          begin
            ShowMessage('ERROR' + #13 + #10 + e.Message);
          end;
        end;
        MsgImporteAbono( False, True );
      end;
    4:
      begin
        try
          QFacturas.Post;
          BtnTres.Visible := True;
          tsAbono.TabVisible := QFacturas.FieldByName('concepto_f').AsString = 'M';
          tsTexto.TabVisible := ( QFacturas.FieldByName('tipo_factura_f').AsString <> '380' ) or
                                ( QFacturas.FieldByName('concepto_f').AsString = 'M' );
          tsRemesaEnabled( False );
          pgFacturaChange(pgFactura);
          BHRestaurar;
        except
          on e: exception do
          begin
            ShowMessage('ERROR' + #13 + #10 + e.Message);
          end;
        end;
      end;
  end;
end;

procedure TFMFacturas.btnDosClick(Sender: TObject);
begin
  if QFacturas.IsEmpty then Exit;
  case TButton(Sender).Tag of
    0:
      begin
        if not gbEnlaceContable then
        begin
          ShowMessage(' Para descontabilizar una factura pongase      ' + #13 + #10 +
                ' en contacto con el departamento de contabilidad.      ');
          Exit;
        end;
        if Preguntar('¿Seguro que quiere modificar el estado de la contabilización?') then
        begin
          QFacturas.Edit;
          if QFacturas.FieldByName('contabilizado_f').AsString = 'S' then
            QFacturas.FieldByName('contabilizado_f').AsString := 'N'
          else
            QFacturas.FieldByName('contabilizado_f').AsString := 'S';
          QFacturas.Post;
        end;
        pgFacturaChange(pgFactura);
      end;
    1:
      begin
        with TFDFacturaManual.Create(self) do
        begin
          try
          //Rellenamos campos estaticos
            empresaText.Caption := STEmpresa_f.Caption;
            empresa.Text := empresa_f.Text;
            cliente_facText.Caption := STCliente_fac_f.Caption;
            cliente.Text := cliente_fac_f.Text;
            fecha.Text := fecha_factura_f.Text;
            factura.Text := n_factura_f.Text;
            DSFactura.DataSet := QFacturas;

            ShowModal;
          finally
            Free;
          end;
        end;
        QFacturaManual.Close;
        QFacturaManual.Open;
        pgFacturaChange(pgFactura);
      end;
    2:
      begin
        BtnUno.Tag := 3;
        BtnUno.Caption := 'Aceptar';
        BtnDos.Tag := 3;
        BtnDos.Caption := 'Cancelar';
        BtnDos.Enabled := True;
        BtnTres.Visible := False;
        tsRemesa.TabVisible := False;
        tsTexto.TabVisible := False;
        pnlAbono.Visible := True;
        BHDeshabilitar;
        rOldImporteAlbaran:= QDetalleAbono.FieldByName('importe_fal').AsFloat;
        QDetalleAbono.Edit;
        centro_salida_fal.SetFocus;
        MsgImporteAbono( True, True );

        stCentroSalida.Caption:= desCentro(empresa_f.Text, centro_salida_fal.Text);
        stCentroOrigen.Caption:= desCentro(empresa_f.Text, centro_origen_fal.Text);
        stProducto.Caption:= desProducto(empresa_f.Text, producto_fal.Text);
        stCategoria.Caption:= desCategoria(empresa_f.Text, producto_fal.Text, categoria_fal.Text);
        stEnvase.Caption:= desEnvase(empresa_f.Text, envase_fal.Text);
        stCosechero.Caption:= desCosechero(empresa_f.Text, cosechero_fal.Text);
        if stCosechero.Caption= '' then
          stCosechero.Caption:= 'COSECHERO OPTATIVO';
      end;
    3:
      begin
        QDetalleAbono.Cancel;
        BtnTres.Visible := True;
        tsRemesa.TabVisible := True;
        tsTexto.TabVisible := True;
        pgFacturaChange(pgFactura);
        pnlAbono.Visible := False;
        BHRestaurar;
        MsgImporteAbono( False, True );
      end;
    4:
      begin
        QFacturas.cancel;
        BtnTres.Visible := True;
        tsAbono.TabVisible := QFacturas.FieldByName('concepto_f').AsString = 'M';
        tsTexto.TabVisible := ( QFacturas.FieldByName('tipo_factura_f').AsString <> '380' ) or
                             ( QFacturas.FieldByName('concepto_f').AsString = 'M' );
        tsRemesaEnabled( False );
        pgFacturaChange(pgFactura);
        BHRestaurar;
      end;
  end;
end;

function BorrarFacturaManual(const AEmpresa, ANumero, AFecha: string): boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' delete from frf_fac_manual ');
    SQL.Add(' where empresa_fm = :empresa ');
    SQL.Add('   and factura_fm = :factura ');
    SQL.Add('   and fecha_fm = :fecha ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('factura').AsString := ANumero;
    ParamByName('fecha').AsString := AFecha;
    ExecSQL;
    result := RowsAffected <> 0;
  end;
end;

procedure TFMFacturas.btnTresClick(Sender: TObject);
begin
  if QFacturas.IsEmpty then Exit;
  case TButton(Sender).Tag of
    0:
      begin
        pgFacturaChange(pgFactura);
      end;
    1:
      begin
        if BorrarFacturaManual(QFacturas.FieldByName('empresa_f').AsString,
          QFacturas.FieldByName('n_factura_f').AsString,
          QFacturas.FieldByName('fecha_factura_f').AsString) then
        begin
          QFacturaManual.Close;
          QFacturaManual.Open;
        end;
        pgFacturaChange(pgFactura);
      end;
    2:
      begin
        if QDetalleAbono.RecordCount > 1 then
        begin
          if Preguntar('¿Seguro que quiere borrar la linea del abono activo?') then
            QDetalleAbono.Delete;
          pgFacturaChange(pgFactura);
        end
        else
        begin
          Informar('Tiene que haber por lo menos una linea de detalle.');
        end;
      end;
  end;
end;

procedure TFMFacturas.BitBtn1Click(Sender: TObject);
begin
  ShowMessage('Hola mundo');
end;

procedure TFMFacturas.QFacturasAfterScroll(DataSet: TDataSet);
begin
  if not QFacturas.IsEmpty then
  begin
    tsAbono.TabVisible := QFacturas.FieldByName('concepto_f').AsString = 'M';
    tsTexto.TabVisible := ( QFacturas.FieldByName('tipo_factura_f').AsString <> '380' ) or
                          ( QFacturas.FieldByName('concepto_f').AsString = 'M' );
    if QFacturas.FieldByName('anulacion_f').AsInteger <> 0 then
    begin
      lblAnulacionFactura.Visible:= True;
      if QFacturas.FieldByName('tipo_factura_f').AsString = '380'  then
      begin
        with DMFacturacion.QGetAbonoAnulacion do
        begin
          ParamByName('empresa').AsString:= empresa_f.Text;
          ParamByName('factura').AsString:= n_factura_f.Text;
          ParamByName('fecha').AsString:= fecha_factura_f.Text;
          Open;
          lblAnulacionFactura.Caption:= 'ANULADA POR ('+
            FieldByName('empresa_fa').AsString + ' - ' +
            FieldByName('n_abono_fa').AsString + ' - ' +
            FieldByName('fecha_abono_fa').AsString + ')';
          Close;
        end;
      end
      else
      begin
        with DMFacturacion.QGetFacturaAnulacion do
        begin
          ParamByName('empresa').AsString:= empresa_f.Text;
          ParamByName('abono').AsString:= n_factura_f.Text;
          ParamByName('fecha').AsString:= fecha_factura_f.Text;
          Open;
          lblAnulacionFactura.Caption:= 'ANULA A ('+
            FieldByName('empresa_fa').AsString + ' - ' +
            FieldByName('n_factura_fa').AsString + ' - ' +
            FieldByName('fecha_factura_fa').AsString + ')';
          Close;
        end;
      end;
    end
    else
    begin
      lblAnulacionFactura.Visible:= False;
    end;
  end
  else
  begin
    tsTexto.TabVisible := False;
    tsAbono.TabVisible := False;
    lblAnulacionFactura.Visible:= False;
  end;
end;

procedure TFMFacturas.ConfigurarUnidadAbono;
var
  sAux: String;
begin
  if unidad_fal.ItemIndex = 0 then
  begin
    unidades_fal.ReadOnly:= True;
    unidades_fal.ColorEdit:= clSilver;
    unidades_fal.ColorNormal:= clSilver;
    unidades_fal.TabStop:= False;

    precio_fal.ReadOnly:= True;
    precio_fal.ColorEdit:= clSilver;
    precio_fal.ColorNormal:= clSilver;
    precio_fal.TabStop:= False;
    precio_fal.Text:= importe_fal.Text;

    importe_fal.ReadOnly:= False;
    importe_fal.ColorEdit:= clMoneyGreen;
    importe_fal.ColorNormal:= clWhite;
    importe_fal.TabStop:= True;

    sAux:= importe_fal.Text;
    unidades_fal.Text:= '1';
    precio_fal.Text:= importe_fal.Text;

  end
  else
  begin
    unidades_fal.ReadOnly:= False;
    unidades_fal.ColorEdit:= clMoneyGreen;
    unidades_fal.ColorNormal:= clWhite;
    unidades_fal.TabStop:= True;

    precio_fal.ReadOnly:= False;
    precio_fal.ColorEdit:= clMoneyGreen;
    precio_fal.ColorNormal:= clWhite;
    precio_fal.TabStop:= True;

    (*
    importe_fal.ReadOnly:= True;
    importe_fal.ColorEdit:= clSilver;
    importe_fal.ColorNormal:= clSilver;
    importe_fal.TabStop:= False;
    *)

    importe_fal.ReadOnly:= False;
    importe_fal.ColorEdit:= clMoneyGreen;
    importe_fal.ColorNormal:= clWhite;
    importe_fal.TabStop:= True;
  end;
end;

procedure TFMFacturas.unidad_falChange(Sender: TObject);
begin
  if QDetalleAbono.State in [dsInsert, dsEdit] then
  begin
    ConfigurarUnidadAbono;
  end;
end;

procedure TFMFacturas.QDetalleAbonoNewRecord(DataSet: TDataSet);
begin
  if DataSeTMaestro.FieldByName('cliente_fac_f').AsString = 'MER' then
    unidad_fal.ItemIndex:= 1
  else
    unidad_fal.ItemIndex:= 0;
  ConfigurarUnidadAbono;
end;

procedure TFMFacturas.unidades_falChange(Sender: TObject);
var
  unidades, precio: real;
  aux: string;
begin
  if QDetalleAbono.State in [dsInsert, dsEdit] then
  begin
    if precio_fal.ReadOnly = false then
    begin
      if Trim( unidades_fal.Text ) = '' then
      begin
        unidades:= 0;
      end
      else
      begin
        aux:= StringReplace( unidades_fal.Text, '.', '', [rfReplaceAll, rfIgnoreCase] );
        unidades:= StrToFloat( aux );
      end;

      if ( Trim( precio_fal.Text ) = '' ) or  ( Trim( precio_fal.Text ) = '-' ) then
      begin
        precio:= 0
      end
      else
      begin
        aux:= StringReplace( precio_fal.Text, '.', '', [rfReplaceAll, rfIgnoreCase] );
        precio:= StrToFloat( aux );
      end;

      importe_fal.Text:= FormatFloat( '###0.00', bRoundTo( precio * unidades,2) );
    end;
  end;
end;

procedure TFMFacturas.QDetalleAbonoAfterEdit(DataSet: TDataSet);
begin
  if DataSet.FieldByName('unidad_fal').AsString = 'UND' then
    unidad_fal.ItemIndex:= 1
  else
  if DataSet.FieldByName('unidad_fal').AsString = 'CAJ' then
    unidad_fal.ItemIndex:= 2
  else
  if DataSet.FieldByName('unidad_fal').AsString = 'KGS' then
    unidad_fal.ItemIndex:= 3
  else
    unidad_fal.ItemIndex:= 0;

  ConfigurarUnidadAbono;
end;

procedure TFMFacturas.QDetalleAbonoBeforePost(DataSet: TDataSet);
var
  rImporteFac, rImporteDet, rAuxNeto: real;
begin
  if unidad_fal.ItemIndex = 0 then
    DataSet.FieldByName('unidad_fal').Value:= null
  else
  if unidad_fal.ItemIndex = 1 then
    DataSet.FieldByName('unidad_fal').AsString:= 'UND'
  else
  if unidad_fal.ItemIndex = 2 then
    DataSet.FieldByName('unidad_fal').AsString:= 'CAJ'
  else
  if unidad_fal.ItemIndex = 3 then
    DataSet.FieldByName('unidad_fal').AsString:= 'KGS';

  //Los importes deben tener el mismo signo que la cabacera
  rImporteFac:= StrToFloatDef( importe_total_f.Text, 0 );
  rImporteDet:= StrToFloatDef( importe_fal.Text, 0 );
  if rImporteFac > 0 then
  begin
    if rImporteDet < 0 then
      raise Exception.Create('El importe del detalle debe tener el mismo signo que la cabecera.');
  end
  else
  begin
    if rImporteDet > 0 then
      raise Exception.Create('El importe del detalle debe tener el mismo signo que la cabecera.');
  end;

  //Debe existir el albaran y el producto en el albaran
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select * ');
    SQL.Add('from frf_salidas_c');
    SQL.Add('where empresa_sc = :empresa ');
    SQL.Add('  and centro_salida_sc = :centro ');
    SQL.Add('  and n_albaran_sc = :albaran ');
    SQL.Add('  and fecha_sc = :fecha ');
    ParamByName('empresa').AsString:= empresa_f.Text;
    ParamByName('centro').AsString:= centro_salida_fal.Text;
    ParamByName('albaran').AsString:= n_albaran_fal.Text;
    ParamByName('fecha').AsString:= fecha_albaran_fal.Text;
    Open;
    if IsEmpty then
    begin
      Close;
      raise Exception.Create('Albarán inexistente.');
    end;
  end;
  //Debe existir producto, origen envase, categoria si es un ¿¿¿abono???
  //if ( QFacturas.FieldByName('tipo_factura_f').AsString =  '381' ) then
  //begin
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add('select * from frf_salidas_l');
      SQL.Add('where empresa_sl = :empresa ');
      SQL.Add('  and centro_salida_sl = :centro ');
      SQL.Add('  and n_albaran_sl = :albaran ');
      SQL.Add('  and fecha_sl = :fecha ');

      SQL.Add('  and centro_origen_sl = :origen ');
      SQL.Add('  and producto_sl = :producto ');
      SQL.Add('  and envase_sl = :envase ');
      SQL.Add('  and categoria_sl = :categoria ');

      ParamByName('empresa').AsString:= empresa_f.Text;
      ParamByName('centro').AsString:= centro_salida_fal.Text;
      ParamByName('albaran').AsString:= n_albaran_fal.Text;
      ParamByName('fecha').AsString:= fecha_albaran_fal.Text;

      ParamByName('origen').AsString:= centro_origen_fal.Text;
      ParamByName('producto').AsString:= producto_fal.Text;
      ParamByName('envase').AsString:= envase_fal.Text;
      ParamByName('categoria').AsString:= categoria_fal.Text;

      Open;
      if IsEmpty then
      begin
        Close;
        producto_fal.SetFocus;
        raise Exception.Create('Producto, origen, envase y/o categoria inexistente para el albarán seleccionado.');
      end;
    end;
  (*
  end
  else
  begin
    if Trim( producto_fal.Text ) = '' then
    begin
      producto_fal.SetFocus;
      raise Exception.Create('El código del producto es de obligada inserción.');
    end
    else
    if Trim( stProducto.Caption ) = '' then
    begin
      producto_fal.SetFocus;
      raise Exception.Create('El código del producto es incorrecto.');
    end;
    if Trim( centro_origen_fal.Text ) = '' then
    begin
      centro_origen_fal.SetFocus;
      raise Exception.Create('El código del centro de origen es de obligada inserción.');
    end
    else
    if Trim( stCentroOrigen.Caption ) = '' then
    begin
      centro_origen_fal.SetFocus;
      raise Exception.Create('El código del centro de origen es incorrecto.');
    end;
    if Trim( categoria_fal.Text ) = '' then
    begin
      categoria_fal.SetFocus;
      raise Exception.Create('El código de la categoria es de obligada inserción.');
    end
    else
    if Trim( stCategoria.Caption ) = '' then
    begin
      categoria_fal.SetFocus;
      raise Exception.Create('El código de la categoria es incorrecto.');
    end;
    if Trim( envase_fal.Text ) = '' then
    begin
      envase_fal.SetFocus;
      raise Exception.Create('El código del envase es de obligada inserción.');
    end
    else
    if Trim( stEnvase.Caption ) = '' then
    begin
      envase_fal.SetFocus;
      raise Exception.Create('El código del envase es incorrecto.');
    end;
  end;
  *)

  if unidad_fal.ItemIndex = 0 then
  begin
    DataSet.FieldByName('unidades_fal').Value:= 1;
    DataSet.FieldByName('precio_fal').Value:= rImporteDet;
  end
  else
  begin
    if ( Trim( unidades_fal.Text ) = '' ) or
       ( Trim( unidades_fal.Text ) = '0' ) or
       ( Trim( unidades_fal.Text ) = '-' ) then
    begin
      unidades_fal.SetFocus;
      raise Exception.Create('La cantidad de unidades debe ser difente de 0.');
    end;
    if ( Trim( precio_fal.Text ) = '' ) or
       ( Trim( precio_fal.Text ) = '0' ) or
       ( Trim( precio_fal.Text ) = '-' ) then
    begin
      precio_fal.SetFocus;
      raise Exception.Create('El precio debe ser difente de 0.');
    end;
  end;

  //El sumatorio del valor neto de las lineas no puede superar el de la cabecera
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select sum(importe_fal) neto_albaran ');
    SQL.Add(' from frf_fac_abonos_l ');
    SQL.Add(' where empresa_fal = :empresa ');
    SQL.Add(' and factura_fal = :factura ');
    SQL.Add(' and fecha_fal = :fecha ');
    ParamByName('empresa').AsString:= empresa_f.Text;
    ParamByName('factura').AsString:= n_factura_f.Text;
    ParamByName('fecha').AsString:= fecha_factura_f.Text;
    Open;
    rAuxNeto:= bRoundTo( FieldByName('neto_albaran').AsFloat - rOldImporteAlbaran + rImporteDet, -2 );
    Close;
    if bRoundTo( ABS( rAuxNeto ) - ABS( StrToFloatDef( importe_neto_f.Text, 0 ) ), -2 ) >= 0.01 then
    begin
      if importe_fal.CanFocus then
        importe_fal.SetFocus
      else
        precio_fal.SetFocus;
      raise Exception.Create('El sumatorio del valor neto de las lineas no puede superar el de la cabecera.');
    end;
  end;
end;

procedure TFMFacturas.importe_falChange(Sender: TObject);
begin
  if QDetalleAbono.State in [dsInsert, dsEdit] then
  begin
    if ( importe_fal.ReadOnly = false ) and ( unidad_fal.ItemIndex = 0 ) then
    begin
      precio_fal.Text:= importe_fal.Text;
    end;
  end;
end;

procedure TFMFacturas.tipo_factura_fChange(Sender: TObject);
begin
  if TEdit( Sender ).Text = '381' then
  begin
    lblTipoFactura.Caption:= 'ABONO';
    //tsAbono.TabVisible := True;
  end
  else
  begin
    lblTipoFactura.Caption:= 'FACTURA';
    //tsAbono.TabVisible := False;
  end;
end;

procedure TFMFacturas.cbxFacturaAbonoChange(Sender: TObject);
begin
  case cbxFacturaAbono.ItemIndex of
    0: tipo_factura_f.Text:= '';
    1: tipo_factura_f.Text:= '380';
    2: tipo_factura_f.Text:= '381';
  end;
end;

procedure TFMFacturas.cbxManualAutomaticaChange(Sender: TObject);
begin
  case cbxManualAutomatica.ItemIndex of
    0: concepto_f.Text:= '';
    1: concepto_f.Text:= 'A';
    2: concepto_f.Text:= 'M';
  end;
end;

procedure TFMFacturas.MsgImporteAbono( const AVisible, ADetalle: boolean );
begin
  if ADetalle then
  begin
    lblAbonoEnNegativo01.Caption:= 'ATENCIÓN: Introducir el precio en negativo, ';
    lblAbonoEnNegativo02.Caption:= 'el importe del abono debe ser negativo. ';
  end
  else
  begin
    lblAbonoEnNegativo01.Caption:= 'ATENCIÓN: Todos los importes de los abonos ';
    lblAbonoEnNegativo02.Caption:= 'se introducen en negativo. ';
  end;
  lblAbonoEnNegativo01.Visible:= AVisible;
  lblAbonoEnNegativo02.Visible:= AVisible;
end;

procedure TFMFacturas.Altas;
var
  sEmpresa: string;
  iFactura: integer;
  dFecha: TDateTime;
begin
  if FacturaManual( self, sEmpresa, iFactura, dFecha ) then
  begin
    Where:= ' where empresa_f = ' + QuotedStr( sEmpresa );
    Where:= Where + ' and n_factura_f = ' + IntToStr( iFactura );
    Where:= Where + ' and fecha_factura_f = ' + QuotedStr( DateToStr( dFecha ) );
    DataSetMaestro.SQL.Clear;
    DataSetMaestro.SQL.Add(Select);
    DataSetMaestro.SQL.Add(Where);
    DataSetMaestro.SQL.Add(Order);
    DataSetMaestro.Open;
   //Estado inicial
    Registros := DataSetMaestro.RecordCount;
    if Registros > 0 then
      Registro := 1
    else
      Registro := 0;
    RegistrosInsertados := 1;
    Visualizar;
    pgFactura.ActivePage:= tsAbono;
    pBuscarRemesa.Visible:= False;
    //FacturacionManual;
  end;
end;

procedure TFMFacturas.PonNombreDetalle(Sender: TObject);
begin
  case TBEdit(Sender).Tag of
    kCentro: if centro_salida_fal.Focused then
               stCentroSalida.Caption:= desCentro(empresa_f.Text, centro_salida_fal.Text)
             else
               stCentroOrigen.Caption:= desCentro(empresa_f.Text, centro_origen_fal.Text);
    kProducto:begin
                stProducto.Caption:= desProducto(empresa_f.Text, producto_fal.Text);
                stCategoria.Caption:= desCategoria(empresa_f.Text, producto_fal.Text, categoria_fal.Text);
              end;
    kCategoria: stCategoria.Caption:= desCategoria(empresa_f.Text, producto_fal.Text, categoria_fal.Text);
    kEnvase: stEnvase.Caption:= desEnvase(empresa_f.Text, envase_fal.Text);
    kCosechero: begin
                  stCosechero.Caption:= desCosechero(empresa_f.Text, cosechero_fal.Text);
                  if stCosechero.Caption= '' then
                     stCosechero.Caption:= 'COSECHERO OPTATIVO';
                end;
  end;
end;

procedure TFMFacturas.QRemesasCalcFields(DataSet: TDataSet);
begin
  QRemesasmoneda_fr.AsString:= moneda_f.Text;
end;

procedure TFMFacturas.btnBuscarRemesaClick(Sender: TObject);
var
  sFiltro, sEmpresaRemesa, sNumeroRemesa: string;
  iNumeroRemesa: integer;
begin
  if ( Estado = teConjuntoResultado ) or ( Estado = teEspera ) then
  begin
    //Construir filtro con datos pasados
    if InputQuery('Buscar facturas de la remesa','Código de la empresa:', sEmpresaRemesa) then
    begin
      if Trim(  sEmpresaRemesa ) = '' then
      begin
        ShowMessage('Falta código de la empresa.');
        Exit;
      end;
    end
    else
    begin
      ShowMessage('Cancelado por el usuario.');
      Exit;
    end;

    if InputQuery('Buscar facturas de la remesa','Número  de remesa:', sNumeroRemesa) then
    begin
      if Trim( sNumeroRemesa ) <> '' then
      begin
        with DMAuxDB.QAux do
        begin
          SQl.Clear;
          SQL.Add('select *');
          SQL.Add('from frf_facturas_remesa');
          SQL.Add('where empresa_fr = :empresa');
          SQL.Add('and remesa_fr = :remesa ');
          ParamByName('empresa').AsString:= sEmpresaRemesa;
          if tryStrToInt( sNumeroRemesa, iNumeroRemesa ) then
          begin
            ParamByName('remesa').Asinteger:= iNumeroRemesa;
            if iNumeroRemesa = 0 then
            begin
              ShowMessage('El número de la remesa no puede ser 0.');
              Exit;
            end;
            Open;
            if IsEmpty then
            begin
              Close;
              ShowMessage('Sin facturas para la remesa seleccionada (' + sEmpresaRemesa + ',' + sNumeroRemesa + ').');
            end
            else
            begin
              sFiltro:= 'Where empresa_f = ' + QuotedStr( sEmpresaRemesa ) + #13 + #10;
              sFiltro:= sFiltro + '  and ( ' + #13 + #10;
              sFiltro:= sFiltro + '        (n_factura_f = ' + FieldByName('factura_fr').AsString + ' and ' +
                                           'fecha_factura_f = ' + QuotedStr( FieldByName('fecha_factura_fr').AsString ) + ') ' + #13 + #10;
              Next;
              while not Eof do
              begin
                sFiltro:= sFiltro + '  or ' + #13 + #10;
                sFiltro:= sFiltro + '        (n_factura_f = ' + FieldByName('factura_fr').AsString + ' and ' +
                                           'fecha_factura_f = ' + QuotedStr( FieldByName('fecha_factura_fr').AsString ) + ') ' + #13 + #10;
                Next;
              end;
              Close;
            end;
            sFiltro:= sFiltro + '      )';
          end
          else
          begin
            ShowMessage('Número de remesa incorrecto.');
            Exit;
          end;
        end;
      end
      else
      begin
        ShowMessage('Falta número de remesa.');
        Exit;
      end;
    end
    else
    begin
      ShowMessage('Cancelado por el usuario.');
      Exit;
    end;

    Where:= sFiltro;
    //Aplicar Query
    DataSeTMaestro.SQL.Clear;
    DataSeTMaestro.SQL.Add(Select);
    DataSeTMaestro.SQL.Add(Where);
    DataSeTMaestro.SQL.Add(Order);

    //activar Query
    try
      AbrirConsulta(DataSeTMaestro);
    except
      try
      except
        //Seguramente no existe el directorio
      end;
      Exit;
    end;

    //Numero de registros
    Registros := CantidadRegistros;
    Registro := 1;

    //Poner estado segun el resultado de la busqueda
    Visualizar;

    //Mensaje si no encontramos ningun registro
    if Registros = 0 then
      BEMensajes('No se encontro ningun registro')
    else
      BERegistros;
  end;
end;

procedure TFMFacturas.tsRemesaEnabled( const AEnable: Boolean );
begin
  cbxContabilizado_f.Enabled:= AEnable;
  filename_conta_f.Enabled:= AEnable;
  LContabilizado_f.Enabled:= AEnable;
  importe_cobrado.Enabled:= AEnable;
  DBGRemesas.Enabled:= not AEnable;
end;

end.
