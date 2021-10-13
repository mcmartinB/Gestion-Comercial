unit PrecioLiquidacionFL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons, ActnList, ExtCtrls, DError,
  Grids, DBGrids, BGridButton, BGrid, BDEdit, BEdit, BCalendarButton, DBTables,
  ComCtrls, BCalendario, CVariables, BSpeedButton;

type
  TFPrecioLiquidacionFL = class(TMaestroDetalle)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    Label1: TLabel;
    btnEmpresa: TBGridButton;
    empresa_pl: TBDEdit;
    stEmpresa: TStaticText;
    RejillaFlotante: TBGrid;
    PDetalle: TPanel;
    PDetalleEdit: TPanel;
    Label15: TLabel;
    btnCategoria: TBGridButton;
    Label16: TLabel;
    btnProducto: TBGridButton;
    categoria_pl: TBDEdit;
    producto_pl: TBDEdit;
    stCategoria: TStaticText;
    stProducto: TStaticText;
    RVisualizacion: TDBGrid;
    Label10: TLabel;
    variedad_pl: TBDEdit;
    anyo_semana_pl: TBDEdit;
    proveedor_pl: TBDEdit;
    btnProveedor: TBGridButton;
    stProveedor: TStaticText;
    Label3: TLabel;
    precio_kg_pl: TBDEdit;
    btnVariedad: TBGridButton;
    lbl1: TLabel;
    stVariedad: TStaticText;
    lbl2: TLabel;
    QMaestro: TQuery;
    dsDetalle: TDataSource;
    QDetalle: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);

    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure empresa_plChange(Sender: TObject);
    procedure proveedor_plChange(Sender: TObject);
    procedure categoria_plChange(Sender: TObject);
    procedure producto_plChange(Sender: TObject);
    procedure DSMaestroDataChange(Sender: TObject; Field: TField);
    procedure btnVariedadClick(Sender: TObject);
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
    procedure ValidarAnyoSemana;

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

procedure TFPrecioLiquidacionFL.AbrirTablas;
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

procedure TFPrecioLiquidacionFL.CerrarTablas;
begin
  BorrarTemporal('temporal');

  CloseAuxQuerys;
  bnCloseQuerys([DMPedidos.TDetalle, DMPedidos.QMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFPrecioLiquidacionFL.FormCreate(Sender: TObject);
begin
  CrearModuloDeDatos;

  LineasObligadas := true;
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
  empresa_pl.Tag := kEmpresa;
  proveedor_pl.Tag:=  kProveedor;
  producto_pl.Tag:=   kProducto;
  categoria_pl.Tag:= kCategoria;
  variedad_pl.Tag:= kVariedad;

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
  {+}FocoAltas := empresa_pl;
  {+}FocoModificar := producto_pl;
  {+}FocoLocalizar := empresa_pl;
  FocoDetalle := producto_pl;


  //Fuente de datos
  DSMaestro.DataSet:= QMaestro;
  DSDetalle.DataSet:= QDetalle;
 {+}DataSetMaestro := QMaestro;
  DataSourceDetalle := DSDetalle;
  //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_precio_liquidacion ';
 {+}where := ' WHERE empresa_pl=' + QuotedStr('###');
 {+}Order := ' ORDER BY empresa_pl, proveedor_pl, anyo_semana_pl ';
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

procedure TFPrecioLiquidacionFL.FormActivate(Sender: TObject);
begin
  if not DataSourceDetalle.DataSet.Active then Exit;
  //Variables globales
  M := Self;
  MD := Self;
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

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
//  Self.WindowState := wsMaximized;
end;


procedure TFPrecioLiquidacionFL.FormDeactivate(Sender: TObject);
begin
  gRF := nil;
  gCF := nil;
end;

procedure TFPrecioLiquidacionFL.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFPrecioLiquidacionFL.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{*}//Si la rejilla esta desplegada no hacemos nada
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
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
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

procedure TFPrecioLiquidacionFL.Filtro;
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

  if flag then where := ' WHERE ' + where;
end;

//...................... REGISTROS INSERTADOS .........................
//function generica, tiene mucha importancia que los datos esten en campos
//que hereden de TBDEdit y que se llamen igual que el campo al que representan
//en la base de datos. Si quieres que salgan aqui pon a True la propiedad
// PrimaryKey del componente.
//....................................................................

procedure TFPrecioLiquidacionFL.AnyadirRegistro;
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
//        where := where + ' and pedido_pdc = ' + DataSeTMaestro.FieldByname('pedido_pdc').AsString;
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

procedure TFPrecioLiquidacionFL.ValidarEntradaMaestro;
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

  ValidarAnyoSemana;

end;

procedure TFPrecioLiquidacionFL.Previsualizar;
var
  QMPedidos: TQMPedidos;
begin
{
  DMPedidos.QueryListado( empresa_pl.Text, centro_pdc.Text, cliente_pdc.Text, '', ref_pedido_pdc.Text,
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
}
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//*****************************************************************************

procedure TFPrecioLiquidacionFL.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kProveedor: DespliegaRejilla(btnProveedor,[empresa_pl.Text]);
    kProducto: DespliegaRejilla(btnProducto,[empresa_pl.Text]);
    kCategoria: DespliegaRejilla(btnCategoria,[empresa_pl.Text, producto_pl.Text]);
    kVariedad: DespliegaRejilla(btnVariedad,[empresa_pl.Text, producto_pl.Text, proveedor_pl.Text]);
  end;
end;

procedure TFPrecioLiquidacionFL.btnVariedadClick(Sender: TObject);
begin
{
  if variedad_pl.Focused then
  if SeleccionaProductoProvedor( self, variedad_pl, empresa_pl.Text, proveedor_pl.Text, producto_pl.Text, sResult ) then
  begin
    variedad_pl.Text:= sResult;
  end;
}
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************


//Evento que se produce cuando pulsamos altas
//Aprobrechar para modificar estado controles

procedure TFPrecioLiquidacionFL.AntesDeInsertar;
begin
  empresa_pl.Text:= gsDefEmpresa;
//  proveedor_pl.Text:= gsDefCentro;
//  anulado_pdc.Field.AsInteger:= 0;

  //anulado_pdc.Checked:= False;
  //Rejilla en visualizacion
//  VerDetalle;
end;

procedure TFPrecioLiquidacionFL.AntesDeLocalizar;
begin
  //Rejilla en visualizacion
  VerDetalle;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFPrecioLiquidacionFL.AntesDeModificar;
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

procedure TFPrecioLiquidacionFL.AntesDeVisualizar;
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

end;

procedure TFPrecioLiquidacionFL.VerDetalle;
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

  FocoDetalle := producto_pl;

  PDetalleEdit.Height := 0;
  operacion := tedEspera;
end;


procedure TFPrecioLiquidacionFL.EditarDetalle;
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

  FocoDetalle := producto_pl;

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

procedure TFPrecioLiquidacionFL.ValidarAnyoSemana;
var iAux: Integer;
begin

    if Length( anyo_semana_pl.Text ) <> 6 then
    begin
      raise Exception.Create('El Año/Semana Fruta es obligatorio y su formato debe ser "AAAASS" donde "AAAA" es el año y "SS" la semana.' + #13 + #10 +
                           'Debe de tener 6 digitos.' );
    end;

    if not TryStrToInt( anyo_semana_pl.Text, iAux ) then
    begin
      raise Exception.Create('El fomato para el Año/Semana Fruta debe ser "AAAASS" donde "AAAA" es el año y "SS" la semana.' + #13 + #10 +
                             'Todos los caracteres deben ser numéricos.' );
    end;
end;

procedure TFPrecioLiquidacionFL.ValidarEntradaDetalle;
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

procedure TFPrecioLiquidacionFL.RellenaClaveDetalle;
begin
{
  DSDetalle.DataSet.FieldByName('empresa').AsString:=
    DSMaestro.DataSet.FieldByName('empresa_pdc').AsString;
  DSDetalle.DataSet.FieldByName('centro_pdd').AsString:=
    DSMaestro.DataSet.FieldByName('centro_pdc').AsString;
  DSDetalle.DataSet.FieldByName('pedido_pdd').AsString:=
    DSMaestro.DataSet.FieldByName('pedido_pdc').AsString;
  DSDetalle.DataSet.FieldByName('linea_pdd').AsInteger:=
    DMPedidos.NuevaLinea(DSMaestro.DataSet.FieldByName('empresa_pdc').AsString,
    DSMaestro.DataSet.FieldByName('centro_pdc').AsString,
    DSMaestro.DataSet.FieldByName('pedido_pdc').AsInteger);
}
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFPrecioLiquidacionFL.RequiredTime(Sender: TObject;
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

procedure TFPrecioLiquidacionFL.DetalleAltas;
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

  Self.ActiveControl := producto_pl;
end;

procedure TFPrecioLiquidacionFL.DSMaestroDataChange(Sender: TObject;
  Field: TField);
begin
  with QDetalle do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := QMaestro.fieldbyname('empresa_pl').AsString;
    ParamByName('proveedor').AsString := QMaestro.fieldbyname('proveedor_pl').AsString;
    ParamByName('anyo_semana').AsString := QMaestro.fieldbyname('anyo_semana_pl').AsString;
    Open;
  end;
end;

procedure TFPrecioLiquidacionFL.empresa_plChange(Sender: TObject);
begin
  stEmpresa.Caption := desEmpresa(empresa_pl.Text);
end;

procedure TFPrecioLiquidacionFL.proveedor_plChange(Sender: TObject);
begin
  stProveedor.Caption := desProveedor(empresa_pl.Text, proveedor_pl.Text);
end;

procedure TFPrecioLiquidacionFL.categoria_plChange(Sender: TObject);
var
  sUnidad: String;
begin
  stCategoria.Caption := desCategoria(empresa_pl.Text, producto_pl.Text, categoria_pl.Text);
end;

procedure TFPrecioLiquidacionFL.producto_plChange(Sender: TObject);
begin
  stProducto.Caption := desProducto(empresa_pl.Text,producto_pl.Text);
end;

end.
