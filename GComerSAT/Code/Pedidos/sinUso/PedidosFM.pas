unit PedidosFM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons, ActnList, ExtCtrls, DError,
  Grids, DBGrids, BGridButton, BGrid, BDEdit, BEdit, BCalendarButton, DBTables,
  ComCtrls, BCalendario, CVariables, BSpeedButton;

type
  TFMPedidos = class(TMaestroDetalle)
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
    Label15: TLabel;
    btnEnvase: TBGridButton;
    Label16: TLabel;
    btnProducto: TBGridButton;
    Label17: TLabel;
    Label18: TLabel;
    envase_pdd: TBDEdit;
    producto_pdd: TBDEdit;
    calibre_pdd: TBDEdit;
    color_pdd: TBDEdit;
    STEnvase: TStaticText;
    STProducto: TStaticText;
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
    unidades_pdd: TBDEdit;
    unidad_pdd: TBDEdit;
    Label8: TLabel;
    btnCategoria: TBGridButton;
    btnCalibre: TBGridButton;
    btnColor: TBGridButton;
    cbxUnidades: TComboBox;
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
    lblNombre1: TLabel;
    cajas_total_pdd: TDBText;
    DSTotal: TDataSource;
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
    procedure envase_pddChange(Sender: TObject);
    procedure producto_pddChange(Sender: TObject);
    procedure cbxUnidadesChange(Sender: TObject);
    procedure unidad_pddChange(Sender: TObject);
    procedure aux_anulado_pdcChange(Sender: TObject);
    procedure anulado_pdcClick(Sender: TObject);
    procedure moneda_pdcChange(Sender: TObject);
  private
    { Private declarations }
    ListaComponentes: TList;
    ListaDetalle: TList;
    Objeto: TObject;
    operacion: TEstadoDetalle;

    procedure VerDetalle;
    procedure EditarDetalle;
    procedure ValidarEntradaDetalle;
    procedure RellenaClaveDetalle;
    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

  public

    //SOBREESCRIBIR METODO
    procedure DetalleAltas; override;

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

uses PedidosQM, PedidosDM, CGestionPrincipal, UDMBaseDatos, UDMAuxDB, CAuxiliarDB,
     Principal,DPreview, bSQLUtils, bNumericUtils, CReportes, UDMConfig, CMaestro;

{$R *.DFM}

procedure TFMPedidos.AbrirTablas;
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

procedure TFMPedidos.CerrarTablas;
begin
  BorrarTemporal('temporal');

  CloseAuxQuerys;
  bnCloseQuerys([DMPedidos.TDetalle, DMPedidos.QMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMPedidos.FormCreate(Sender: TObject);
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
  producto_pdd.Tag:=   kProducto;
  envase_pdd.Tag:=   kEnvase;
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
  {+}FocoModificar := ref_pedido_pdc;
  {+}FocoLocalizar := empresa_pdc;
  FocoDetalle := producto_pdd;

  //Inicializacion de variables
  CalendarioFlotante.Date := Date;

  //Fuente de datos
  DSMaestro.DataSet:= DMPedidos.QMaestro;
  DSDetalle.DataSet:= DMPedidos.TDetalle;
 {+}DataSetMaestro := DMPedidos.QMaestro;
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

procedure TFMPedidos.FormActivate(Sender: TObject);
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


procedure TFMPedidos.FormDeactivate(Sender: TObject);
begin
  gRF := nil;
  gCF := nil;
end;

procedure TFMPedidos.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMPedidos.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMPedidos.Filtro;
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
              where := where + ' ' + name + ' =' + SQLNumeric(Text);
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

procedure TFMPedidos.AnyadirRegistro;
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

procedure TFMPedidos.ValidarEntradaMaestro;
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
  if not DMPedidos.DirSumValida( empresa_pdc.Text, cliente_pdc.Text, dir_suministro_pdc.Text ) then
  begin
    dir_suministro_pdc.SetFocus;
    raise Exception.Create('Dirección de suministro no valida.');
  end;

  if Estado = teAlta  then
  begin
    DSMaestro.DataSet.FieldByName('pedido_pdc').AsInteger:=
      DMPedidos.NuevaPedido( empresa_pdc.Text, centro_pdc.Text );
  end;
end;

procedure TFMPedidos.Previsualizar;
var
  QMPedidos: TQMPedidos;
begin
  DMPedidos.QueryListado( empresa_pdc.Text, centro_pdc.Text, cliente_pdc.Text, '', ref_pedido_pdc.Text,
                          StrToDate( fecha_pdc.Text), StrToDate( fecha_pdc.Text) );
  DMPedidos.QListado.Open;
  DMPedidos.QNotas.Open;
  if not DMPedidos.QListado.IsEmpty then
  begin
    QMPedidos := TQMPedidos.Create(Application);
    try
      PonLogoGrupoBonnysa(QMPedidos, empresa_pdc.Text);
      QMPedidos.lblPeriodo.Caption:= '';
      QMPedidos.lblProducto.Caption:= '';
      QMPedidos.ReportTitle:= 'PEDIDOS';
      QMPedidos.bNotas:= True;
      Preview(QMPedidos);
    except
      QMPedidos.Free;
    end;
  end;
  DMPedidos.QNotas.Close;
  DMPedidos.QListado.Close;
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//*****************************************************************************

procedure TFMPedidos.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCentro: DespliegaRejilla(btnCentro,[empresa_pdc.Text]);
    kCliente: DespliegaRejilla(btnCliente,[empresa_pdc.Text]);
    kSuministro: DespliegaRejilla(btnSuministro,[empresa_pdc.Text,cliente_pdc.Text]);
    kCalendar: DespliegaCalendario(btnFecha);
    kProducto: DespliegaRejilla(btnProducto,[empresa_pdc.Text]);
    kEnvase: DespliegaRejilla(btnEnvase,[empresa_pdc.Text, producto_pdd.Text, cliente_pdc.Text]);
    kCalibre: DespliegaRejilla(btnCalibre,[empresa_pdc.Text, producto_pdd.Text]);
    kCategoria: DespliegaRejilla(btnCategoria,[empresa_pdc.Text, producto_pdd.Text]);
    kColor: DespliegaRejilla(btnColor,[empresa_pdc.Text, producto_pdd.Text]);
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

procedure TFMPedidos.AntesDeInsertar;
begin
  empresa_pdc.Text:= gsDefEmpresa;
  centro_pdc.Text:= gsDefCentro;
  fecha_pdc.Text := DateTostr(date);
  anulado_pdc.Field.AsInteger:= 0;

  //anulado_pdc.Checked:= False;
  //Rejilla en visualizacion
  VerDetalle;
end;

procedure TFMPedidos.AntesDeLocalizar;
begin
  anulado_pdc.Visible:= False;
  cbanulado_pdc.ItemIndex:= 0;
  cbanulado_pdc.Visible:= True;

  //Rejilla en visualizacion
  VerDetalle;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMPedidos.AntesDeModificar;
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
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMPedidos.AntesDeVisualizar;
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

procedure TFMPedidos.VerDetalle;
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

  FocoDetalle := producto_pdd;

  PDetalleEdit.Height := 0;
  operacion := tedEspera;
end;


procedure TFMPedidos.EditarDetalle;
var i: integer;
begin
  if EstadoDetalle <> tedAlta then
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

  FocoDetalle := producto_pdd;

     //rejilla al tamaño minimo
  PDetalleEdit.Height := 120;
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

procedure TFMPedidos.ValidarEntradaDetalle;
var i: Integer;
begin
  for i := 0 to ListaDetalle.Count - 1 do
  begin
    Objeto := ListaDetalle.Items[i];
    if (Objeto is TBDEdit) then
    begin
      with Objeto as TBDEdit do
      begin
        if {Required and}(Trim(Text) = '') then
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

procedure TFMPedidos.RellenaClaveDetalle;
begin
  DSDetalle.DataSet.FieldByName('empresa_pdd').AsString:=
    DSMaestro.DataSet.FieldByName('empresa_pdc').AsString;
  DSDetalle.DataSet.FieldByName('centro_pdd').AsString:=
    DSMaestro.DataSet.FieldByName('centro_pdc').AsString;
  DSDetalle.DataSet.FieldByName('pedido_pdd').AsString:=
    DSMaestro.DataSet.FieldByName('pedido_pdc').AsString;
  DSDetalle.DataSet.FieldByName('linea_pdd').AsInteger:=
    DMPedidos.NuevaLinea(DSMaestro.DataSet.FieldByName('empresa_pdc').AsString,
    DSMaestro.DataSet.FieldByName('centro_pdc').AsString,
    DSMaestro.DataSet.FieldByName('pedido_pdc').AsInteger);
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMPedidos.RequiredTime(Sender: TObject;
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

procedure TFMPedidos.DetalleAltas;
var
   //aux1,aux2:String;
  aux3: TEstadoDetalle;
begin
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

  Self.ActiveControl := producto_pdd;
  (*ERNESTO 22/4/2010 -> para Mercadona, antes eran cajas*)
  unidad_pdd.Text:= 'K';
  cbxUnidades.ItemIndex:= 0;
end;

procedure TFMPedidos.empresa_pdcChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(empresa_pdc.Text);
  STCentro.Caption := desCentro(empresa_pdc.Text,centro_pdc.Text);
  STCliente.Caption := desCliente(empresa_pdc.Text,cliente_pdc.Text);
  STSuministro.Caption := desSuministroEx(empresa_pdc.Text,cliente_pdc.Text,dir_suministro_pdc.Text);
end;

procedure TFMPedidos.centro_pdcChange(Sender: TObject);
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

procedure TFMPedidos.cliente_pdcChange(Sender: TObject);
begin
  STCliente.Caption := desCliente(empresa_pdc.Text,cliente_pdc.Text);
  STSuministro.Caption := desSuministroEx(empresa_pdc.Text,cliente_pdc.Text,dir_suministro_pdc.Text);
  if ( ( Estado = teAlta ) or ( Estado = teModificar ) ) and  ( moneda_pdc.Text = '' )then
    moneda_pdc.Text:= GetMonedaCliente( empresa_pdc.Text,cliente_pdc.Text )
  else
    STMoneda.Caption := desMoneda(moneda_pdc.Text);
end;

procedure TFMPedidos.dir_suministro_pdcChange(Sender: TObject);
begin
  STSuministro.Caption := desSuministroEx(empresa_pdc.Text,cliente_pdc.Text,dir_suministro_pdc.Text);
end;

procedure TFMPedidos.moneda_pdcChange(Sender: TObject);
begin
  STMoneda.Caption := desMoneda(moneda_pdc.Text);
end;

procedure TFMPedidos.envase_pddChange(Sender: TObject);
var
  sUnidad: String;
begin
  STEnvase.Caption := desEnvaseClienteEx(empresa_pdc.Text,producto_pdd.Text,envase_pdd.Text,cliente_pdc.Text);
  if DMConfig.EsLaFont then
  begin
    sUnidad:= DMPedidos.Unidad( empresa_pdc.Text, producto_pdd.Text, envase_pdd.Text, cliente_pdc.Text );
    if sUnidad <> '' then
    begin
     unidad_pdd.Text:= sUnidad;
    end;
  end;
end;

procedure TFMPedidos.producto_pddChange(Sender: TObject);
begin
  STProducto.Caption := desProducto(empresa_pdc.Text,producto_pdd.Text);
end;

procedure TFMPedidos.cbxUnidadesChange(Sender: TObject);
begin
  if unidad_pdd.DataSource.State in [ dsInsert, dsEdit ] then
  begin
    case cbxUnidades.ItemIndex of
      0: unidad_pdd.Text:= 'K';
      1: unidad_pdd.Text:= 'C';
      2: unidad_pdd.Text:= 'U';
    end;
  end;
end;

procedure TFMPedidos.unidad_pddChange(Sender: TObject);
begin
  if unidad_pdd.Text = 'K' then
    cbxUnidades.ItemIndex:= 0
  else
  if unidad_pdd.Text = 'C' then
    cbxUnidades.ItemIndex:= 1
  else
  if unidad_pdd.Text = 'U' then
    cbxUnidades.ItemIndex:= 2;
end;

procedure TFMPedidos.aux_anulado_pdcChange(Sender: TObject);
begin
  motivo_anulacion_pdc.Enabled:= ( TEdit( Sender ).Text <> '0' );
end;

procedure TFMPedidos.anulado_pdcClick(Sender: TObject);
begin
  motivo_anulacion_pdc.Enabled:= anulado_pdc.Checked;
  if not motivo_anulacion_pdc.Enabled then
    motivo_anulacion_pdc.Text:= '';
end;

end.
