unit FMPedidosFormato;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons, ActnList, ExtCtrls, DError,
  Grids, DBGrids, BGridButton, BGrid, BDEdit, BEdit, BCalendarButton, DBTables,
  ComCtrls, BCalendario, CVariables, BSpeedButton, UDMAuxDB;

type
  TfrmMPedidosFormato = class(TMaestroDetalle)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    Label13: TLabel;
    Label1: TLabel;
    btnEmpresa: TBGridButton;
    empresa_pdc: TBDEdit;
    STEmpresa: TStaticText;
    Label4: TLabel;
    fecha_pdc: TBDEdit;
    DSDetalle: TDataSource;
    btnFecha: TBCalendarButton;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    PDetalle: TPanel;
    PDetalleEdit: TPanel;
    Label17: TLabel;
    Label18: TLabel;
    calibre_pdd: TBDEdit;
    color_pdd: TBDEdit;
    RVisualizacion: TDBGrid;
    Label10: TLabel;
    categoria_pdd: TBDEdit;
    centro_pdc: TBDEdit;
    ref_pedido_pdc: TBDEdit;
    cliente_pdc: TBDEdit;
    dir_suministro_pdc: TBDEdit;
    btnCliente: TBGridButton;
    STCliente: TStaticText;
    btnSuministro: TBGridButton;
    STSuministro: TStaticText;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btnCentro: TBGridButton;
    STCentro: TStaticText;
    observaciones_pdc: TDBMemo;
    Label8: TLabel;
    btnCategoria: TBGridButton;
    btnCalibre: TBGridButton;
    btnColor: TBGridButton;
    Label7: TLabel;
    anulado_pdc: TDBCheckBox;
    cbAnulado_pdc: TComboBox;
    Label9: TLabel;
    motivo_anulacion_pdc: TBDEdit;
    aux_anulado_pdc: TBDEdit;
    Label11: TLabel;
    moneda_pdc: TBDEdit;
    BGridButton1: TBGridButton;
    STMoneda: TStaticText;
    Label12: TLabel;
    formato_cliente_pdd: TBDEdit;
    btnFormatoCliente: TBGridButton;
    stFormatoCliente: TStaticText;
    Label14: TLabel;
    producto_base_pdd: TBDEdit;
    btnProductoBase: TBGridButton;
    stProductoBase: TStaticText;
    Label15: TLabel;
    marca_pdd: TBDEdit;
    btnMarca: TBGridButton;
    stMarca: TStaticText;
    stCategoria: TStaticText;
    stColor: TStaticText;
    Label27: TLabel;
    cbxUnidad_pdd: TComboBox;
    cantidad_pdd: TBDEdit;
    Label16: TLabel;
    envase_pdd: TBDEdit;
    btnEnvase: TBGridButton;
    stEnvase: TStaticText;
    lblPalets: TLabel;
    palets_pdd: TBDEdit;
    Label19: TLabel;
    cajas_pdd: TBDEdit;
    Label23: TLabel;
    unidades_pdd: TBDEdit;
    Label31: TLabel;
    kilos_pdd: TBDEdit;
    Label20: TLabel;
    cbxUnidadFacturacion: TComboBox;
    precio_pdd: TBDEdit;
    Label21: TLabel;
    precio_pdd_: TBDEdit;
    Label32: TLabel;
    unidad_precio_pdd: TBDEdit;
    Label33: TLabel;
    importe_neto_pdd: TBDEdit;
    Lporc_iva_ocl: TLabel;
    porc_iva_pdd: TBDEdit;
    tipo_iva_pdd: TBDEdit;
    Liva_ocl: TLabel;
    iva_pdd: TBDEdit;
    LImporteTotal: TLabel;
    importe_total_pdd: TBDEdit;
    Label22: TLabel;
    cajas_pdd_: TBDEdit;
    Label24: TLabel;
    cajas_aservir_pdd: TBDEdit;
    pFinalizar: TPanel;
    btnFinalizar: TButton;
    finalizado_pdc: TBDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);

    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure empresa_pdcChange(Sender: TObject);
    procedure centro_pdcChange(Sender: TObject);
    procedure cliente_pdcChange(Sender: TObject);
    procedure dir_suministro_pdcChange(Sender: TObject);
    procedure aux_anulado_pdcChange(Sender: TObject);
    procedure anulado_pdcClick(Sender: TObject);
    procedure moneda_pdcChange(Sender: TObject);
    procedure producto_base_pddChange(Sender: TObject);
    procedure marca_pddChange(Sender: TObject);
    procedure categoria_pddChange(Sender: TObject);
    procedure color_pddChange(Sender: TObject);
    procedure formato_cliente_pddChange(Sender: TObject);
    procedure envase_pddChange(Sender: TObject);
    procedure cbxUnidad_pddChange(Sender: TObject);
    procedure cantidad_pddChange(Sender: TObject);
    procedure RVisualizacionDblClick(Sender: TObject);
    procedure cbxUnidadFacturacionChange(Sender: TObject);
    procedure precio_pddChange(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
    procedure finalizado_pdcChange(Sender: TObject);
  private
    { Private declarations }
    ListaComponentes: TList;
    ListaDetalle: TList;
    Objeto: TObject;
    operacion: TEstadoDetalle;

    //Valores sacados del formato
    sProducto, sNombreFormato, sTipoEnvase, sTipoPalet: string;
    iProductoBase: integer;
    sMarca, sCategoria, sCalibre, sColor: string;
    sUnidadPedidoFormato: string;
    bPesoVariable: boolean;
    sUnidadFacturaEnvase: string;
    iCajasPalet, iUnidadesCaja: integer;
    rPesoNetoCaja: Real;

    //Valores introducidos por el operario
    rCantidad: Real;
    sUnidadPedido: string;
    sUnidadFactura: string;

    //Valores calculados
    iPalets, iCajas, iUnidades: integer;
    rKilos, rPrecio: real;

    rImpuestosActual: TImpuesto;

    procedure CambioUnidadPedido;
    procedure CambioUnidadPrecio;
    procedure ActualizarValores;

    procedure VerDetalle;
    procedure EditarDetalle;
    procedure ValidarEntradaDetalle;
    procedure RellenaClaveDetalle;
    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

    procedure btnFormatoClienteAccion;

  public

    //SOBREESCRIBIR METODO
    procedure DetalleAltas; override;
    procedure DetalleModificar; override;

    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;
    procedure AntesDeLocalizar;

    //Listado
    procedure Previsualizar; override;
 end;

implementation

uses QMPedidosFormato, DMPedidosFormato, CGestionPrincipal, UDMBaseDatos, CAuxiliarDB,
     Principal,DPreview, bSQLUtils, bNumericUtils, CReportes, UDMConfig,
     CMaestro, UFFormatoCliente, bMath;

{$R *.DFM}

procedure TfrmMPedidosFormato.AbrirTablas;
begin
     // Abrir tablas/Querys
  if not DataSetMaestro.Active then
  begin
    DataSetMaestro.SQL.Clear;
    DataSetMaestro.SQL.Add(Select);
    DataSetMaestro.SQL.Add(Where);
    DataSetMaestro.SQL.Add(Order);
    DataSetMaestro.Open;
  end;

  if not DSDetalle.DataSet.Active then
    DSDetalle.DataSet.Open;

  //Estado inicial
  Registros := 0;
  if Registros > 0 then
    Registro := 1
  else
    Registros := 0;
  RegistrosInsertados := 0;
end;

procedure TfrmMPedidosFormato.CerrarTablas;
begin
  BorrarTemporal('temporal');

  CloseAuxQuerys;
  bnCloseQuerys([dtmMPedidosFormato.TDetalle, dtmMPedidosFormato.QMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TfrmMPedidosFormato.FormCreate(Sender: TObject);
begin
  CrearModuloDeDatos;

  LineasObligadas := false;
  ListadoObligado := false;
  // INICIO
  //Variables globales
  M := Self;
  MD := Self;
  //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
  PanelDetalle := PDetalleEdit;
  RejillaVisualizacion := RVisualizacion;

  //Lista de componentes
  ListaComponentes := TList.Create;
  PMaestro.GetTabOrderList(ListaComponentes);
  ListaDetalle := TList.Create;
  PDetalleEdit.GetTabOrderList(ListaDetalle);

  //rejilla al tamaño maximo
  PDetalleEdit.Height := 0;

  //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> CVariables.tfMaestroDetalle then
  begin
    FormType := CVariables.tfMaestroDetalle;
    BHFormulario;
  end;
  //Inicialmente grupo de desplazamiento deshabilitado
  Visualizar;

  //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;
  //Asignamos constantes a los componentes que los tienen
  //para facilitar distingirlos
  empresa_pdc.Tag := kEmpresa;
  fecha_pdc.Tag := kCalendar;
  centro_pdc.Tag:= kCentro;
  cliente_pdc.Tag:=  kCliente;
  dir_suministro_pdc.Tag:=   kSuministro;
  producto_base_pdd.Tag:=   kProductoBase;
  formato_cliente_pdd.Tag:=   kFormatoCliente;
  marca_pdd.Tag:= kMarca;
  categoria_pdd.Tag:= kCategoria;
  calibre_pdd.Tag:= kCalibre;
  color_pdd.Tag:= kColor;

  //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnValidateDetailConstrains := ValidarEntradaDetalle;

  //Eventos
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnBrowse := AntesDeLocalizar;
  OnView := AntesDeVisualizar;
  OnViewDetail := VerDetalle;
  OnEditDetail := EditarDetalle;

  //Focos
  {+}FocoAltas := empresa_pdc;
  {+}FocoModificar := observaciones_pdc;
  {+}FocoLocalizar := empresa_pdc;
  FocoDetalle := producto_base_pdd;

  //Inicializacion de variables
  CalendarioFlotante.Date := Date;

  //Fuente de datos
  DSMaestro.DataSet:= dtmMPedidosFormato.QMaestro;
  DSDetalle.DataSet:= dtmMPedidosFormato.TDetalle;
 {+}DataSetMaestro := dtmMPedidosFormato.QMaestro;
  DataSourceDetalle := DSDetalle;
  //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_pedido_cab ';
 {+}where := ' WHERE empresa_pdc=' + QuotedStr('###');
 {+}Order := ' ORDER BY empresa_pdc, centro_pdc, fecha_pdc desc, ref_pedido_pdc DESC ';
  //Abrir tablas/Querys

  try
    AbrirTablas;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      Close;
      Exit;
    end;
  end;
end;

procedure TfrmMPedidosFormato.FormActivate(Sender: TObject);
begin
  if not DataSourceDetalle.DataSet.Active then Exit;
  //Variables globales
  M := Self;
  MD := Self;
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := CalendarioFlotante;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> CVariables.tfMaestroDetalle then
  begin
    FormType := CVariables.tfMaestroDetalle;
    BHFormulario;
  end;
     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(PCMaestro);
  BHGrupoDesplazamientoDetalle(PCDetalle);

     //Formulario maximizado
  Self.WindowState := wsMaximized;
end;


procedure TfrmMPedidosFormato.FormDeactivate(Sender: TObject);
begin
  gRF := nil;
  gCF := nil;
end;

procedure TfrmMPedidosFormato.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListaComponentes.Free;
  ListaDetalle.Free;

  //Variables globales
  gRF := nil;
  gCF := nil;

  //Codigo de desactivacion
  CerrarTablas;

     //Restauramos barra de herramientas si es necesario
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  // Cambia acción por defecto para Form hijas en una aplicación MDI
  // Cierra el Form y libera toda la memoria ocupada por el Form
  DestruirModuloDeDatos;
  Action := caFree;
end;

procedure TfrmMPedidosFormato.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{*}//Si la rejilla esta desplegada no hacemos nada
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
           //No hacemos nada
      Exit;

{*}//Si  el calendario esta desplegado no hacemos nada
  if (CalendarioFlotante <> nil) then
    if (CalendarioFlotante.Visible) then
            //No hacemos nada
      Exit;

    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  case key of
    vk_Return, vk_down:
      begin
        Key := 0;
        if not observaciones_pdc.Focused then
          PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        Key := 0;
        if not observaciones_pdc.Focused then
          PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

//...................... FILTRO LOCALIZACION .........................
//function generica, tiene mucha importancia que los datos esten en campos
//que hereden de TBEdit y que se llamen igual que el campo al que representan
//en la base de datos
//....................................................................

procedure TfrmMPedidosFormato.Filtro;
var Flag: Boolean;
  i: Integer;
begin
  where := ''; Flag := false;
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBEdit) then
    begin
      with Objeto as TBEdit do
      begin
        if Trim(Text) <> '' then
        begin
          if flag then where := where + ' and ';
          if InputType = itChar then
            where := where + ' ' + name + ' LIKE ' + SQLFilter(Text)
          else
            if InputType = itDate then
              where := where + ' ' + name + ' =' + SQLDate(Text)
            else
              where := where + ' ' + name + ' =' + Text;
          flag := true;
        end;
      end;
    end;
  end;

  case cbAnulado_pdc.ItemIndex of
    1:
    begin
      if flag then where := where + ' and ';
      where := where + ' anulado_pdc <> 0 ';
      flag := True;
    end;
    2:
    begin
      if flag then where := where + ' and ';
      where := where + ' anulado_pdc = 0 ';
      flag := True;
    end;
  end;

  if flag then where := ' WHERE ' + where;
end;

//...................... REGISTROS INSERTADOS .........................
//function generica, tiene mucha importancia que los datos esten en campos
//que hereden de TBDEdit y que se llamen igual que el campo al que representan
//en la base de datos. Si quieres que salgan aqui pon a True la propiedad
// PrimaryKey del componente.
//....................................................................

procedure TfrmMPedidosFormato.AnyadirRegistro;
var Flag: Boolean;
  i: Integer;
begin
  Flag := false;
  if where <> '' then where := where + ' OR ('
  else where := ' WHERE (';

  for i := 0 to ListaComponentes.Count - 1 do
  begin
    objeto := ListaComponentes.Items[i];
    if (objeto is TBDEdit) then
    begin
      with objeto as TBDEdit do
      begin
        if PrimaryKey and (Trim(Text) <> '') then
        begin
          if flag then where := where + ' and ';
          if InputType = itChar then
            where := where + ' ' + name + ' =' + SQLFilter(Text)
          else
            if InputType = itDate then
              where := where + ' ' + name + ' =' + SQLDate(Text)
            else
              where := where + ' ' + name + ' =' + Text;
          flag := True;
        end;
        where := where + ' and pedido_pdc = ' + DataSeTMaestro.FieldByname('pedido_pdc').AsString;
      end;
    end;
  end;
  where := where + ') ';
end;

//...................... VALIDAR CAMPOS .........................
//function generica, tiene mucha importancia que los datos esten en campos
//que hereden de TBDEdit y que se llamen igual que el campo al que representan
//en la base de datos. Si quieres que salgan aqui pon a True la propiedad
// Required del componente y en RequiredMsg el mensaje que quieres mostrar
//....................................................................
// La funcion generica que realiza es comprobar que los campos que tienen
// datos por obligacion los tengan, en caso de querer hacer algo mas hay
// que implenentarlo, como comprobar la existencia de un valor en la base
// de datos
//....................................................................

procedure TfrmMPedidosFormato.ValidarEntradaMaestro;
var i: Integer;
begin
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBEdit) then
    begin
      with Objeto as TBEdit do
      begin
        if Required and (Trim(Text) = '') then
        begin
          if Trim(RequiredMsg) <> '' then
            raise Exception.Create(RequiredMsg)
          else
            raise Exception.Create('Faltan datos de obligada inserción.');
        end;
      end;
    end;
  end;

  //Cargar direccion de suministro
  if Trim( dir_suministro_pdc.Text ) = '' then
  begin
    dir_suministro_pdc.Text:= cliente_pdc.Text;
  end;

  //Direccion de suministro valida
  if not dtmMPedidosFormato.DirSumValida( empresa_pdc.Text, cliente_pdc.Text, dir_suministro_pdc.Text ) then
  begin
    dir_suministro_pdc.SetFocus;
    raise Exception.Create('Dirección de suministro no valida.');
  end;

  if Estado = teAlta  then
  begin
    DSMaestro.DataSet.FieldByName('pedido_pdc').AsInteger:=
      dtmMPedidosFormato.NuevaPedido( empresa_pdc.Text, centro_pdc.Text );
  end;
end;

procedure TfrmMPedidosFormato.Previsualizar;
var
  qrpMPedidosFormato: TqrpMPedidosFormato;
begin
  dtmMPedidosFormato.QueryListado( empresa_pdc.Text, centro_pdc.Text, cliente_pdc.Text, '', ref_pedido_pdc.Text,
                          StrToDate( fecha_pdc.Text), StrToDate( fecha_pdc.Text) );
  dtmMPedidosFormato.QListado.Open;
  dtmMPedidosFormato.QNotas.Open;
  if not dtmMPedidosFormato.QListado.IsEmpty then
  begin
    qrpMPedidosFormato := TqrpMPedidosFormato.Create(Application);
    try
      PonLogoGrupoBonnysa(qrpMPedidosFormato, empresa_pdc.Text);
      qrpMPedidosFormato.lblPeriodo.Caption:= '';
      qrpMPedidosFormato.lblProducto.Caption:= '';
      qrpMPedidosFormato.ReportTitle:= 'PEDIDOS';
      qrpMPedidosFormato.bNotas:= True;

      Preview(qrpMPedidosFormato);
    except
      qrpMPedidosFormato.Free;
    end;
  end;
  dtmMPedidosFormato.QNotas.Close;
  dtmMPedidosFormato.QListado.Close;
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//*****************************************************************************

procedure TfrmMPedidosFormato.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCentro: DespliegaRejilla(btnCentro,[empresa_pdc.Text]);
    kCliente: DespliegaRejilla(btnCliente,[empresa_pdc.Text]);
    kSuministro: DespliegaRejilla(btnSuministro,[empresa_pdc.Text,cliente_pdc.Text]);
    kCalendar: DespliegaCalendario(btnFecha);
    kMarca: DespliegaRejilla(btnMarca);
    kProductoBase: DespliegaRejilla(btnProductoBase,[empresa_pdc.Text]);
    kCalibre: DespliegaRejilla(btnCalibre,[empresa_pdc.Text, DSDetalle.DataSet.FieldByName('producto_pdd').AsString ] );
    kCategoria: DespliegaRejilla(btnCategoria,[empresa_pdc.Text, DSDetalle.DataSet.FieldByName('producto_pdd').AsString ] );
    kColor: DespliegaRejilla(btnColor,[empresa_pdc.Text, DSDetalle.DataSet.FieldByName('producto_pdd').AsString ] );
    kFormatoCliente: btnFormatoClienteAccion;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************


//Evento que se produce cuando pulsamos altas
//Aprobrechar para modificar estado controles

procedure TfrmMPedidosFormato.AntesDeInsertar;
begin
  empresa_pdc.Text:= gsDefEmpresa;
  centro_pdc.Text:= gsDefCentro;
  fecha_pdc.Text := DateTostr(date);
  anulado_pdc.Field.AsInteger:= 0;

  //anulado_pdc.Checked:= False;
  //Rejilla en visualizacion
  VerDetalle;
end;

procedure TfrmMPedidosFormato.AntesDeLocalizar;
begin
  anulado_pdc.Visible:= False;
  cbanulado_pdc.ItemIndex:= 0;
  cbanulado_pdc.Visible:= True;

  //Rejilla en visualizacion
  VerDetalle;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TfrmMPedidosFormato.AntesDeModificar;
var i: Integer;
begin
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;

  ref_pedido_pdc.Enabled:= DSMaestro.DataSet.FieldByName('finalizado_pdc').Asinteger = 0;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TfrmMPedidosFormato.AntesDeVisualizar;
var i: Integer;
begin
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := true;
  end;

  anulado_pdc.Visible:= True;
  cbanulado_pdc.Visible:= False;
end;

procedure TfrmMPedidosFormato.VerDetalle;
var i: integer;
begin
  LineasObligadas := false;
  for i := 0 to ListaDetalle.Count - 1 do
  begin
    Objeto := ListaDetalle.Items[i];
    if (Objeto is TBDEdit) then
    begin
      with Objeto as TBDEdit do
      begin
        if Modificable = false then
          Enabled := true;
      end;
    end;
  end;

  FocoDetalle := producto_base_pdd;

  PDetalleEdit.Height := 0;
  operacion := tedEspera;
end;


procedure TfrmMPedidosFormato.EditarDetalle;
var i: integer;
begin
  if EstadoDetalle <> tedAlta then
  begin
    for i := 0 to ListaDetalle.Count - 1 do
    begin
      Objeto := ListaDetalle.Items[i];
      if (Objeto is TBDEdit) then
      begin
        with Objeto as TBDEdit do
        begin
          if Modificable = false then
            Enabled := false;
        end;
      end;

    end;

    if DSDetalle.DataSet.FieldByName('unidad_pdd').AsString = 'C' then
    begin
      cbxUnidad_pdd.ItemIndex:= 0;
    end
    else
    if DSDetalle.DataSet.FieldByName('unidad_pdd').AsString = 'U' then
    begin
      cbxUnidad_pdd.ItemIndex:= 1;
    end
    else
    begin
      cbxUnidad_pdd.ItemIndex:= 2;
    end;

    if DSDetalle.DataSet.FieldByName('unidad_precio_pdd').AsString = 'C' then
    begin
      cbxUnidadFacturacion.ItemIndex:= 0;
    end
    else
    if DSDetalle.DataSet.FieldByName('unidad_precio_pdd').AsString = 'U' then
    begin
      cbxUnidadFacturacion.ItemIndex:= 1;
    end
    else
    begin
      cbxUnidadFacturacion.ItemIndex:= 2;
    end;

    case cbxUnidad_pdd.ItemIndex of
      0: sUnidadPedido:= 'C'; //Cajas
      1: sUnidadPedido:= 'U'; //Unidades
      2: sUnidadPedido:= 'K'; //Kilos
    end;

    case cbxUnidadFacturacion.ItemIndex of
      0: sUnidadFactura:= 'C'; //Cajas
      1: sUnidadFactura:= 'U'; //Unidades
      2: sUnidadFactura:= 'K'; //Kilos
    end;

    stProductoBase.Caption:= desProductoBase( empresa_pdc.Text, producto_base_pdd.Text );
    stMarca.Caption:= desMarca( marca_pdd.Text );
    stCategoria.Caption:= desCategoria( empresa_pdc.Text,
      DSDetalle.DataSet.FieldByName('producto_pdd').AsString, categoria_pdd.Text );
    stColor.Caption:= desColor( empresa_pdc.Text,
      DSDetalle.DataSet.FieldByName('producto_pdd').AsString, color_pdd.Text );
    stEnvase.Caption:= desEnvase( empresa_pdc.Text, envase_pdd.Text );

    dtmMPedidosFormato.DatosFormatoCliente( empresa_pdc.Text, cliente_pdc.Text, dir_suministro_pdc .Text, formato_cliente_pdd.Text,
      sNombreFormato, sTipoPalet, sTipoEnvase, sUnidadPedidoFormato, sUnidadFacturaEnvase, sProducto, iProductoBase, iCajasPalet,
      iUnidadesCaja, bPesoVariable, rPesoNetoCaja, sMarca, sCategoria, sCalibre, sColor );
    stFormatoCliente.Caption:= sNombreFormato;

    FocoDetalle := cantidad_pdd;
    rCantidad:= StrToFloatDef( cantidad_pdd.Text, 0 );
  end
  else
  begin
    FocoDetalle := producto_base_pdd;
    rCantidad:= 0;
  end;

  //rejilla al tamaño minimo
  PDetalleEdit.Height := 195;
end;


//...................... VALIDAR CAMPOS .........................
//function generica, tiene mucha importancia que los datos esten en campos
//que hereden de TBDEdit y que se llamen igual que el campo al que representan
//en la base de datos. Si quieres que salgan aqui pon a True la propiedad
// Required del componente y en RequiredMsg el mensaje que quieres mostrar
//....................................................................
// La funcion generica que realiza es comprobar que los campos que tienen
// datos por obligacion los tengan, en caso de querer hacer algo mas hay
// que implenentarlo, como comprobar la existencia de un valor en la base
// de datos
//....................................................................

procedure TfrmMPedidosFormato.ValidarEntradaDetalle;
var i: Integer;
begin
  for i := 0 to ListaDetalle.Count - 1 do
  begin
    Objeto := ListaDetalle.Items[i];
    if (Objeto is TBDEdit) then
    begin
      with Objeto as TBDEdit do
      begin
        if Required and (Trim(Text) = '') then
        begin
          if Trim(RequiredMsg) <> '' then
            raise Exception.Create(RequiredMsg)
          else
            raise Exception.Create('Faltan datos de obligada inserción..');
          TBEdit(Objeto).setfocus;
        end;
      end;
    end;
  end;

    //Completamos la clave primaria
  if estadoDetalle <> tedModificar then
    RellenaClaveDetalle;
end;

procedure TfrmMPedidosFormato.RellenaClaveDetalle;
begin
  DSDetalle.DataSet.FieldByName('empresa_pdd').AsString:=
    DSMaestro.DataSet.FieldByName('empresa_pdc').AsString;
  DSDetalle.DataSet.FieldByName('centro_pdd').AsString:=
    DSMaestro.DataSet.FieldByName('centro_pdc').AsString;
  DSDetalle.DataSet.FieldByName('pedido_pdd').AsString:=
    DSMaestro.DataSet.FieldByName('pedido_pdc').AsString;
  DSDetalle.DataSet.FieldByName('linea_pdd').AsInteger:=
    dtmMPedidosFormato.NuevaLinea(DSMaestro.DataSet.FieldByName('empresa_pdc').AsString,
    DSMaestro.DataSet.FieldByName('centro_pdc').AsString,
    DSMaestro.DataSet.FieldByName('pedido_pdc').AsInteger);
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TfrmMPedidosFormato.RequiredTime(Sender: TObject;
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

procedure TfrmMPedidosFormato.DetalleModificar;
begin
  rImpuestosActual:= ImpuestosCliente( empresa_pdc.Text, empresa_pdc.Text, cliente_pdc.Text, cliente_pdc.Text, StrToDateTimeDef( fecha_pdc.Text, Now ) );
  Lporc_iva_ocl.Caption:= '% ' + rImpuestosActual.sTipo;
  inherited;
end;

procedure TfrmMPedidosFormato.DetalleAltas;
var
   //aux1,aux2:String;
  aux3: TEstadoDetalle;
begin
  rImpuestosActual:= ImpuestosCliente( empresa_pdc.Text, empresa_pdc.Text, cliente_pdc.Text, cliente_pdc.Text, StrToDateTimeDef( fecha_pdc.Text, Now ) );
  Lporc_iva_ocl.Caption:= '% ' + rImpuestosActual.sTipo;

  //Evento antes de permitir la entrada de datos
  try
    aux3 := EstadoDetalle;
    EstadoDetalle := tedAlta;
    EditarDetalle;
    EstadoDetalle := aux3;
  except
    Exit;
  end;

     //La primera insercion de la tanda
  if Estado <> teOperacionDetalle then
  begin
          //estado detalle
    if Estado = teAlta then
    begin
      EstadoDetalle := tedAltaRegresoMaestro;
    end
    else
    begin
      EstadoDetalle := tedAlta;
    end;
          //estado maestro
    Estado := teOperacionDetalle;

    DetallesInsertados := 0;
    BEEstado;
    BHEstado;

    PanelMaestro.Enabled := false;
    PanelDetalle.Enabled := true;
    RejillaVisualizacion.Enabled := false;

  end
  else
    LineasObligadas := false;


  Operacion := EstadoDetalle;

     //Todas la inserciones
  DataSourceDetalle.DataSet.Insert;

  Self.ActiveControl := producto_base_pdd;
  cbxUnidad_pdd.ItemIndex:= 2;
  cbxUnidadFacturacion.ItemIndex:= 2;
  sUnidadPedido:= 'K'; //Kilos
  sUnidadFactura:= 'K'; //Kilos


  DSDetalle.DataSet.FieldByName('tipo_iva_pdd').AsString:= rImpuestosActual.sCodigo;


  stProductoBase.Caption:= '';
  stFormatoCliente.Caption:= '';
  stMarca.Caption:= '';
  stCategoria.Caption:= '';
  stColor.Caption:= '';
  stEnvase.Caption:= '';
end;

procedure TfrmMPedidosFormato.empresa_pdcChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(empresa_pdc.Text);
  STCentro.Caption := desCentro(empresa_pdc.Text,centro_pdc.Text);
  STCliente.Caption := desCliente(empresa_pdc.Text,cliente_pdc.Text);
  STSuministro.Caption := desSuministroEx(empresa_pdc.Text,cliente_pdc.Text,dir_suministro_pdc.Text);
end;

procedure TfrmMPedidosFormato.centro_pdcChange(Sender: TObject);
begin
  STCentro.Caption := desCentro(empresa_pdc.Text,centro_pdc.Text);
end;

function GetMonedaCliente( const AEmpresa, ACliente: string ): string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select moneda_c from frf_clientes ');
    SQL.Add('where empresa_c = :empresa ');
    SQL.Add('  and cliente_c = :cliente ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    Open;
    result:= FieldByName('moneda_c').AsString;
    Close;       
  end;
end;

procedure TfrmMPedidosFormato.cliente_pdcChange(Sender: TObject);
begin
  STCliente.Caption := desCliente(empresa_pdc.Text,cliente_pdc.Text);
  moneda_pdc.Text:= GetMonedaCliente( empresa_pdc.Text,cliente_pdc.Text );
  STSuministro.Caption := desSuministroEx(empresa_pdc.Text,cliente_pdc.Text,dir_suministro_pdc.Text);
end;

procedure TfrmMPedidosFormato.dir_suministro_pdcChange(Sender: TObject);
begin
  STSuministro.Caption := desSuministroEx(empresa_pdc.Text,cliente_pdc.Text,dir_suministro_pdc.Text);
end;

procedure TfrmMPedidosFormato.moneda_pdcChange(Sender: TObject);
begin
  STMoneda.Caption := desMoneda(moneda_pdc.Text);
end;

procedure TfrmMPedidosFormato.aux_anulado_pdcChange(Sender: TObject);
begin
  motivo_anulacion_pdc.Enabled:= ( TEdit( Sender ).Text <> '0' );
end;

procedure TfrmMPedidosFormato.anulado_pdcClick(Sender: TObject);
begin
  motivo_anulacion_pdc.Enabled:= anulado_pdc.Checked;
  if not motivo_anulacion_pdc.Enabled then
    motivo_anulacion_pdc.Text:= '';
end;

(*
  if DMConfig.EsLaFont then
  begin
    sUnidad:= dtmMPedidosFormato.Unidad( empresa_pdc.Text, producto_pdd.Text, envase_pdd.Text, cliente_pdc.Text );
    if sUnidad <> '' then
    begin
     unidad_pdd.Text:= sUnidad;
    end;
  end;
*)

procedure TfrmMPedidosFormato.btnFormatoClienteAccion;
var
  sAux: String;
begin
  sAux:= formato_cliente_pdd.Text;
  if SeleccionaFormatoCliente( self,formato_cliente_pdd, empresa_pdc.Text, producto_base_pdd.Text,
                               cliente_pdc.Text, dir_suministro_pdc.Text, sAux ) then
    formato_cliente_pdd.Text:= sAux;
end;

procedure TfrmMPedidosFormato.producto_base_pddChange(Sender: TObject);
begin
  if DSDetalle.State in [dsInsert, dsEdit] then
  begin
    stProductoBase.Caption:= desProductoBase( empresa_pdc.Text, producto_base_pdd.Text );
    if stProductoBase.Caption <> '' then
    begin
      DSDetalle.DataSet.FieldByName('producto_pdd').AsString:= 'P';
    end
    else
    begin
      DSDetalle.DataSet.FieldByName('producto_pdd').AsString:= ''
    end;
    stCategoria.Caption:= desCategoria( empresa_pdc.Text,
      DSDetalle.DataSet.FieldByName('producto_pdd').AsString, categoria_pdd.Text );
    stColor.Caption:= desColor( empresa_pdc.Text,
      DSDetalle.DataSet.FieldByName('producto_pdd').AsString, color_pdd.Text );

    if producto_base_pdd.Text = '' then
    begin
      porc_iva_pdd.Text:= '';
    end
    else
    begin
      case TipoIvaEnvase( empresa_pdc.Text, envase_pdd.Text, producto_base_pdd.Text ) of
        0: porc_iva_pdd.Text:= FloatToStr( rImpuestosActual.rSuper );
        1: porc_iva_pdd.Text:= FloatToStr( rImpuestosActual.rReducido );
        2: porc_iva_pdd.Text:= FloatToStr( rImpuestosActual.rGeneral );
      end;
    end;
    ActualizarValores;
  end;
end;

procedure TfrmMPedidosFormato.marca_pddChange(Sender: TObject);
begin
  if DSDetalle.State in [dsInsert, dsEdit] then
  begin
    stMarca.Caption:= desMarca( marca_pdd.Text );
  end;
end;

procedure TfrmMPedidosFormato.categoria_pddChange(Sender: TObject);
begin
  if DSDetalle.State in [dsInsert, dsEdit] then
  begin
    stCategoria.Caption:= desCategoria( empresa_pdc.Text,
      DSDetalle.DataSet.FieldByName('producto_pdd').AsString, categoria_pdd.Text );
  end;
end;

procedure TfrmMPedidosFormato.color_pddChange(Sender: TObject);
begin
  if DSDetalle.State in [dsInsert, dsEdit] then
  begin
    stColor.Caption:= desColor( empresa_pdc.Text,
      DSDetalle.DataSet.FieldByName('producto_pdd').AsString, color_pdd.Text );
  end;
end;

procedure TfrmMPedidosFormato.envase_pddChange(Sender: TObject);
begin
  if DSDetalle.State in [dsInsert, dsEdit] then
  begin
    stEnvase.Caption:= desEnvase( empresa_pdc.Text, envase_pdd.Text );
  end;
end;

procedure TfrmMPedidosFormato.formato_cliente_pddChange(Sender: TObject);
begin
(*
  if DSDetalle.State in [dsInsert, dsEdit] then
  begin
    stFormatoCliente.Caption:= desFormatoCliente( empresa_pdc.Text, cliente_pdc.Text,
      dir_suministro_pdc.Text, formato_cliente_pdd.Text );
  end;
*)
  if DSDetalle.State in [dsInsert, dsEdit] then
  begin
    if dtmMPedidosFormato.DatosFormatoCliente( empresa_pdc.Text, cliente_pdc.Text, dir_suministro_pdc .Text, formato_cliente_pdd.Text,
      sNombreFormato, sTipoPalet, sTipoEnvase, sUnidadPedidoFormato, sUnidadFacturaEnvase, sProducto, iProductoBase, iCajasPalet,
      iUnidadesCaja, bPesoVariable, rPesoNetoCaja, sMarca, sCategoria, sCalibre, sColor ) then
    begin
      //tipo_palets_ocl.Text:= sTipoPalet;
      envase_pdd.Text:= sTipoEnvase;
      if marca_pdd.Text = '' then
        marca_pdd.Text:= sMarca;
      if categoria_pdd.Text = '' then
        categoria_pdd.Text:= sCategoria;
      if calibre_pdd.Text = '' then
        calibre_pdd.Text:= sCalibre;
      if color_pdd.Text = '' then
        color_pdd.Text:= sColor;
      DSDetalle.DataSet.FieldByName('producto_pdd').AsString:= sProducto;
      stFormatoCliente.caption:= sNombreFormato;

      if sUnidadPedidoFormato <> sUnidadPedido then
      begin
        if sUnidadPedidoFormato = 'C' then
        begin
          cbxUnidad_pdd.ItemIndex:= 0;
        end
        else
        if sUnidadPedidoFormato = 'U' then
        begin
          cbxUnidad_pdd.ItemIndex:= 1;
        end
        else
        begin
          cbxUnidad_pdd.ItemIndex:= 2;
        end;
      end;
      CambioUnidadPedido;

      if sUnidadFacturaEnvase <> sUnidadFactura then
      begin
        if sUnidadFacturaEnvase = 'C' then
        begin
          cbxUnidadFacturacion.ItemIndex:= 0;
        end
        else
        if sUnidadFacturaEnvase = 'U' then
        begin
          cbxUnidadFacturacion.ItemIndex:= 1;
        end
        else
        begin
          cbxUnidadFacturacion.ItemIndex:= 2;
        end;
      end;
      CambioUnidadPrecio;

      ActualizarValores;
    end
    else
    begin
      //tipo_palets_ocl.Text:= '';
      envase_pdd.Text:= '';
      DSDetalle.DataSet.FieldByName('producto_pdd').AsString:= sProducto;
      stFormatoCliente.caption:= '';
    end;
  end;
end;

procedure TfrmMPedidosFormato.CambioUnidadPedido;
begin
  case cbxUnidad_pdd.ItemIndex of
    0: sUnidadPedido:= 'C'; //Cajas
    1: sUnidadPedido:= 'U'; //Unidades
    2: sUnidadPedido:= 'K'; //Kilos
  end;
  DSDetalle.DataSet.FieldByName('unidad_pdd').AsString:= sUnidadPedido;
end;

procedure TfrmMPedidosFormato.CambioUnidadPrecio;
begin
  case cbxUnidadFacturacion.ItemIndex of
    0: sUnidadFactura:= 'C'; //Cajas
    1: sUnidadFactura:= 'U'; //Unidades
    2: sUnidadFactura:= 'K'; //Kilos
  end;
  DSDetalle.DataSet.FieldByName('unidad_precio_pdd').AsString:= sUnidadFactura;
end;

procedure TfrmMPedidosFormato.cbxUnidad_pddChange(Sender: TObject);
begin
  if DSDetalle.State in [dsInsert, dsEdit] then
  begin
    CambioUnidadPedido;
    ActualizarValores;
  end;
end;

procedure TfrmMPedidosFormato.cbxUnidadFacturacionChange(Sender: TObject);
begin
  if DSDetalle.State in [dsInsert, dsEdit] then
  begin
    CambioUnidadPrecio;
    ActualizarValores;
  end;
end;

procedure TfrmMPedidosFormato.cantidad_pddChange(Sender: TObject);
begin
  if DSDetalle.State in [dsInsert, dsEdit] then
  begin
    //rCantidad:= StrToFloatDef( cantidad_pdd.Text, 0 );
    ActualizarValores;
  end;
end;

procedure TfrmMPedidosFormato.precio_pddChange(Sender: TObject);
begin
  if DSDetalle.State in [dsInsert, dsEdit] then
  begin
    //rPrecio:= StrToFloatDef( precio_pdd.Text, 0 );
    ActualizarValores;
  end;
end;

procedure TfrmMPedidosFormato.ActualizarValores;
begin
  rCantidad:= StrToFloatDef( cantidad_pdd.Text, 0 );
  rPrecio:= StrToFloatDef( precio_pdd.Text, 0 );

  if rCantidad = 0 then
  begin
    iPalets:= 0;
    iCajas:= 0;
    iUnidades:= 0;
    rKilos:= 0;
  end
  else
  begin
    if sUnidadPedido = 'C' then
    begin
      iCajas:= Trunc( rCantidad );
      iUnidades:= iCajas;
      if iUnidadesCaja <> 0 then
        iUnidades:= iCajas * iUnidadesCaja;
       rKilos:= iCajas * rPesoNetoCaja;
    end
    else
    if sUnidadPedido = 'U' then
    begin
      iUnidades:= Trunc( rCantidad );
      iCajas:= iUnidades;
      if iUnidadesCaja <> 0 then
      begin
        iCajas:= Trunc( rCantidad ) div iUnidadesCaja;
        if Trunc( rCantidad ) mod iUnidadesCaja > 0 then
          iCajas:= iCajas + 1;
      end;
      rKilos:= iCajas * rPesoNetoCaja;
    end
    else
    begin
      rKilos:= rCantidad;
      if rPesoNetoCaja > 0 then
      begin
        iCajas:=  Trunc( rKilos / rPesoNetoCaja );
        iUnidades:= iCajas;
        if iUnidadesCaja <> 0 then
          iUnidades:= iCajas * iUnidadesCaja;
      end
      else
      begin
        iCajas:= 1;
        iUnidades:= 1;
      end;
    end;
    iPalets:= 1;
    if iCajasPalet <> 0 then
    begin
      iPalets:= iCajas div iCajasPalet;
      if iCajas mod iCajasPalet <> 0 then
        iPalets:= iPalets + 1;
    end;
  end;

  if DSDetalle.State in [dsINsert, dsEdit] then
  begin
    if DSDetalle.DataSet.FieldByName('cajas_pdd').AsInteger =
      DSDetalle.DataSet.FieldByName('cajas_aservir_pdd').AsInteger then
    begin
      DSDetalle.DataSet.FieldByName('cajas_pdd').AsInteger:= iCajas;
      DSDetalle.DataSet.FieldByName('cajas_aservir_pdd').AsInteger:= iCajas;
    end
    else
    begin
      DSDetalle.DataSet.FieldByName('cajas_pdd').AsInteger:= iCajas;
    end;

    DSDetalle.DataSet.FieldByName('palets_pdd').AsInteger:= iPalets;
    DSDetalle.DataSet.FieldByName('unidades_pdd').AsInteger:= iUnidades;
    DSDetalle.DataSet.FieldByName('kilos_pdd').AsFloat:= rKilos;

    //DSDetalle.DataSet.FieldByName('precio_pdd').AsFloat:= rPrecio;
    case cbxUnidadFacturacion.ItemIndex of
      0: DSDetalle.DataSet.FieldByName('importe_neto_pdd').AsFloat:= bRoundTo( rPrecio * iCajas, -2 );
      1: DSDetalle.DataSet.FieldByName('importe_neto_pdd').AsFloat:= bRoundTo( rPrecio * iUnidades, -2 );
      2: DSDetalle.DataSet.FieldByName('importe_neto_pdd').AsFloat:= bRoundTo( rPrecio * rKilos, -2 );
    end;
    DSDetalle.DataSet.FieldByName('porc_iva_pdd').AsFloat:= StrToFloatDef( porc_iva_pdd.Text, 0 );
    DSDetalle.DataSet.FieldByName('iva_pdd').AsFloat:= bRoundTo( ( DSDetalle.DataSet.FieldByName('importe_neto_pdd').AsFloat *
      DSDetalle.DataSet.FieldByName('porc_iva_pdd').AsFloat ) / 100, -2 );
    DSDetalle.DataSet.FieldByName('importe_total_pdd').AsFloat:= DSDetalle.DataSet.FieldByName('importe_neto_pdd').AsFloat +
      DSDetalle.DataSet.FieldByName('iva_pdd').AsFloat;
  end;
end;

procedure TfrmMPedidosFormato.RVisualizacionDblClick(Sender: TObject);
begin
  DetalleModificar;
end;

procedure TfrmMPedidosFormato.btnFinalizarClick(Sender: TObject);
var
  sMsg: string;
begin
  if ( DSMaestro.State = dsBrowse ) and ( not DSMaestro.DataSet.IsEmpty ) then
  begin
    if finalizado_pdc.Text <> '1' then
    if dtmMPedidosFormato.FinalizarPedido( empresa_pdc.Text, centro_pdc.Text,
         DSMaestro.DataSet.FieldByName('pedido_pdc').AsString, sMsg ) then
    begin
      btnFinalizar.Enabled:= false;
      DSMaestro.DataSet.Edit;
      DSMaestro.DataSet.FieldByName('finalizado_pdc').Asinteger:= 1;
      DSMaestro.DataSet.Post;
      ShowMessage('FINALIZACION PEDIDO OK');
    end
    else
    begin
      if dtmMPedidosFormato.ForzarFinPedido( empresa_pdc.Text, centro_pdc.Text,
         DSMaestro.DataSet.FieldByName('pedido_pdc').AsString, sMsg ) then
      begin
        btnFinalizar.Enabled:= false;
        DSMaestro.DataSet.Edit;
        DSMaestro.DataSet.FieldByName('finalizado_pdc').Asinteger:= 1;
        DSMaestro.DataSet.Post;
        ShowMessage('FINALIZACION PEDIDO OK');
      end;
    end;
  end;
end;

procedure TfrmMPedidosFormato.finalizado_pdcChange(Sender: TObject);
begin
  btnFinalizar.Enabled:= finalizado_pdc.Text <> '1';
end;

end.
