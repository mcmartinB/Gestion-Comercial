unit UFMCompras;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbtables,
  DError, DBCtrls, kbmMemTable;

type
  TFMCompras = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    Label13: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    empresa_c: TBDEdit;
    BGBEmpresa_c: TBGridButton;
    stEmpresa_c: TStaticText;
    centro_c: TBDEdit;
    RejillaFlotante: TBGrid;
    QCompras: TQuery;
    BGBCentro_c: TBGridButton;
    stCentro_c: TStaticText;
    observaciones_c: TDBMemo;
    CalendarioFlotante: TBCalendario;
    LFecha: TLabel;
    fecha_c: TBDEdit;
    BCBFecha_c: TBCalendarButton;
    lblNombre1: TLabel;
    numero_c: TBDEdit;
    lblNombre2: TLabel;
    proveedor_c: TBDEdit;
    BGBProveedor_c: TBGridButton;
    stProveedor_c: TStaticText;
    lblNombre3: TLabel;
    lblNombre4: TLabel;
    lblCarpeta: TLabel;
    lblNombre5: TLabel;
    lblNombre6: TLabel;
    ref_compra_c: TBDEdit;
    pBoton: TPanel;
    btnAsignar: TButton;
    btnFacturas: TButton;
    DSEntregas: TDataSource;
    QEntregas: TQuery;
    QFacturas: TQuery;
    DSFacturas: TDataSource;
    PInferior: TPanel;
    lblNombre7: TLabel;
    DBGrid1: TDBGrid;
    lblNombre8: TLabel;
    DBGrid2: TDBGrid;
    status_gastos_c: TDBEdit;
    btnEntregas: TButton;
    lblNombre9: TLabel;
    quien_compra_c: TBDEdit;
    btnQuienCompra: TBGridButton;
    stQuienCompra: TStaticText;
    mtQuienCompra: TkbmMemTable;
    dsQuienCompra: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure centro_cChange(Sender: TObject);
    procedure proveedor_cChange(Sender: TObject);
    procedure empresa_cChange(Sender: TObject);
    procedure fecha_cChange(Sender: TObject);
    procedure numero_cChange(Sender: TObject);
    procedure QComprasBeforePost(DataSet: TDataSet);
    procedure QComprasAfterPost(DataSet: TDataSet);
    procedure QComprasPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure btnFacturasClick(Sender: TObject);
    procedure QComprasAfterOpen(DataSet: TDataSet);
    procedure QComprasBeforeClose(DataSet: TDataSet);
    procedure btnAsignarClick(Sender: TObject);
    procedure status_gastos_cChange(Sender: TObject);
    procedure btnEntregasClick(Sender: TObject);
    procedure quien_compra_cChange(Sender: TObject);

  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;
    iContador: integer;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

    procedure PonNombreCarpeta;
    function  GetNombreCarpeta: string;

    function  VerContadorCompras( const AEmpresa, ACentro: string ): integer;
    procedure  ActualizaContadorCompras( const AEmpresa, ACentro: string; const ANewContador: integer );

    procedure EstadoBotones( const AValor: string );

    procedure AbrirTablaTemporal;
    procedure CerrarTablaTemporal;

    procedure RejillaQuienCompra;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;
    function  MantenimientoGastos: boolean;
    function  MantenimientoEntregas: boolean;
  end;

implementation

uses UDMAuxDB, CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, UQRCompras, DPreview, bSQLUtils, UDMConfig,
  CUPCarpetaRemesaItem, UFMGastosCompras, CDGastosCompra, UFMEntregasCompras,
  CompraFichaDL;

{$R *.DFM}

procedure TFMCompras.AbrirTablas;
begin
     // Abrir tablas/Querys
  if not DataSetMaestro.Active then
  try
    DataSetMaestro.SQL.Clear;
    DataSetMaestro.SQL.Add(Select);
    DataSetMaestro.SQL.Add(Where);
    DataSetMaestro.SQL.Add(Order);
    DataSetMaestro.Open;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      raise Exception.Create('No puedo abrir la tabla de cabecera.');
    end;
  end;

     //Estado inicial
  Registro := 1;
  Registros := 0;
  //Registros := DataSetMaestro.RecordCount;
  RegistrosInsertados := 0;
end;

procedure TFMCompras.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuery(DataSetMaestro);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMCompras.FormCreate(Sender: TObject);
begin

  M := self;
  MD := nil;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(pcNulo);

     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
  PanelMaestro.Visible := false; {Hasta que no tengamos los datos}

     //Fuente de datos maestro
 {+}DataSetMaestro := QCompras;

  //Lista de componentes
  Lista := TList.Create;
  PMaestro.GetTabOrderList(Lista);

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_compras ';
 {+}where := ' WHERE empresa_c=' + QUOTEDSTR('###');
 {+}Order := ' ORDER BY empresa_c, fecha_c desc, numero_c desc';


  with QEntregas do
  begin
    SQL.Clear;
    SQL.Add(' select codigo_ec codigo, almacen_ec almacen, fecha_carga_ec carga, albaran_ec albaran ');
    SQL.Add('   from frf_compras_entregas, frf_entregas_c ');

    SQL.Add(' where empresa_ce = :empresa_c ');
    SQL.Add('   and centro_ce = :centro_c ');
    SQL.Add('   and compra_ce = :numero_c ');
    SQL.Add('   and codigo_ec = entrega_ce ');
    SQL.Add(' order by entrega_ce ');

    Prepare;
  end;

  with QFacturas do
  begin
    SQL.Clear;
    SQL.Add(' select tipo_gc Tipo, ref_fac_gc factura, fecha_fac_gc fecha, producto_gc Producto, importe_gc Importe ');
    SQL.Add(' from frf_gastos_compras ');
    SQL.Add(' where empresa_gc = :empresa_c ');
    SQL.Add('   and centro_gc = :centro_c ');
    SQL.Add('   and numero_gc = :numero_c ');
    SQL.Add(' order by tipo_gc, producto_gc ');
    Prepare;
  end;

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;

     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_c.Tag := kEmpresa;
  quien_compra_c.Tag:= kEmpresa;
  centro_c.Tag:= kCentro;
  proveedor_c.Tag:= kProveedor;
  fecha_c.Tag:= kCalendar;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;

     //Focos
  {+}FocoAltas := empresa_c;
  {+}FocoModificar := observaciones_c;
  {+}FocoLocalizar := empresa_c;

  //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
  gCF := CalendarioFlotante;
  CalendarioFlotante.Date:= Date;
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

  //Abrir tablas/Querys
  try
    AbrirTablas;
    Visualizar;
  except
    Close;
  end;
     //Desplegar(Self,439);
  if PanelMaestro.Visible = false then
    PanelMaestro.Visible := true;

  AbrirTablaTemporal;;
end;

procedure TFMCompras.CerrarTablaTemporal;
begin
  mtQuienCompra.Close;
end;

procedure TFMCompras.AbrirTablaTemporal;
begin
  mtQuienCompra.FieldDefs.Clear;
  mtQuienCompra.FieldDefs.Add('codigo', ftString, 3, False);
  mtQuienCompra.FieldDefs.Add('nombre', ftString, 30, False);
  mtQuienCompra.IndexFieldNames:= 'empresa;codigo';
  mtQuienCompra.CreateTable;

  mtQuienCompra.Open;

  mtQuienCompra.Insert;
  mtQuienCompra.FieldByName('codigo').AsString:= '002';
  mtQuienCompra.FieldByName('nombre').AsString:= 'ALZAMORA';
  mtQuienCompra.Post;

  mtQuienCompra.Insert;
  mtQuienCompra.FieldByName('codigo').AsString:= '022';
  mtQuienCompra.FieldByName('nombre').AsString:= 'AGROGENESIS';
  mtQuienCompra.Post;

  mtQuienCompra.Insert;
  mtQuienCompra.FieldByName('codigo').AsString:= '050';
  mtQuienCompra.FieldByName('nombre').AsString:= 'SAT BONNYSA';
  mtQuienCompra.Post;
end;

{+ CUIDADIN }


procedure TFMCompras.FormActivate(Sender: TObject);
begin
  Exit;

  DataSetMaestro.EnableControls;

  //if not DataSetMaestro.Active then Exit;
  //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;

     //Formulario activo
  M := self;
  MD := nil;

     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);

     //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
  gCF := CalendarioFlotante;
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

     //Abrir tablas/Querys
  try
    AbrirTablas;
    Visualizar;
  except
    Close;
  end;
     //Desplegar(Self,439);
  if PanelMaestro.Visible = false then
    PanelMaestro.Visible := true;
end;


procedure TFMCompras.FormDeactivate(Sender: TObject);
begin
  Exit;

  //Desahabilitamos controles de Base de datos
  //mientras estamos desactivados
  DataSetMaestro.DisableControls;

 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF := nil;

  //CerrarTablas;
end;

procedure TFMCompras.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CerrarTablaTemporal;

  with QEntregas do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QFacturas do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  //Liberamos recursos
  Lista.Free;

     //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

     //Codigo de desactivacion
  CerrarTablas;

     //Formulario activo
  M := nil;
  MD := nil;
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMCompras.FormKeyDown(Sender: TObject; var Key: Word;
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
    vk_Return:
      begin
        if not observaciones_c.Focused then
        begin
          Key := 0;
          PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        end;
      end;
    vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
    Ord('F'):
      if ssAlt in Shift  then
          if not MantenimientoGastos then
            ShowMessage('Debe tener una compra seleccionada y en modo de visualización.');
    Ord('E'):
      if ssAlt in Shift  then
          if not MantenimientoEntregas then
            ShowMessage('Debe tener una compra seleccionada y en modo de visualización.');
  end;
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

{+}//Sustituir por funcion generica

procedure TFMCompras.Filtro;
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
            where := where + ' ' + name + ' LIKE ' + SQLFilter(Text)
          else
            if InputType = itDate then
              where := where + ' ' + name + ' =' + SQLDate(Text)
            else
              where := where + ' ' + name + ' =' + SQLNumeric(Text);
          flag := True;
        end;
      end;
    end;
  end;
  if flag then where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFMCompras.AnyadirRegistro;
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
          if InputType = itChar then
            where := where + ' ' + name + ' =' + SQLFilter(Text)
          else
            if InputType = itDate then
              where := where + ' ' + name + ' =' + SQLDate(Text)
            else
              where := where + ' ' + name + ' =' + Text;
          flag := True;
        end;
      end;
    end;
  end;
  where := where + ') ';
end;

{+}//Sustituir por funcion generica

procedure TFMCompras.ValidarEntradaMaestro;
var
  dFecha: TDateTime;
begin
  if stEmpresa_c.Caption = '' then
  begin
    raise Exception.Create('Falta el código de la empresa o es incorrecto.');
  end;
  if stCentro_c.Caption = '' then
  begin
    raise Exception.Create('Falta el código del centro o es incorrecto.');
  end;
  if stProveedor_c.Caption = '' then
  begin
    raise Exception.Create('Falta el código del proveedor o es incorrecto.');
  end;
  if not tryStrToDate( fecha_c.Text, dFecha ) then
  begin
    raise Exception.Create('Falta la fecha de la compra o es incorrecta.');
  end;
  if Trim( numero_c.Text ) = '' then
  begin
    raise Exception.Create('Falta el contador de la compra.');
  end;
  if stQuienCompra.Caption = '' then
  begin
    raise Exception.Create('Falta quien compra o es incorrecto.');
  end;
end;

procedure TFMCompras.Previsualizar;
var
  QRCompras: TQRCompras;
begin
  if not QCompras.IsEmpty then
    CompraFichaDL.PrevisualizarCompra( Self, empresa_c.Text, centro_c.Text, StrToInt( numero_c.Text ) );
  Exit;

  //Crear el listado
  DMBaseDatos.QListado.SQL.Clear;
  DMBaseDatos.QListado.SQL.AddStrings(QCompras.SQL);
  try
    DMBaseDatos.QListado.Open;
    QRCompras:= TQRCompras.Create(Application);
    try
      PonLogoGrupoBonnysa(QRCompras);
      Preview(QRCompras);
    except
      FreeAndNil(QRCompras);
      Raise;
    end;
  finally
    DMBaseDatos.QListado.Close;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//*****************************************************************************

procedure TFMCompras.ARejillaFlotanteExecute(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  case ActiveControl.Tag of
    kEmpresa: if empresa_c.Focused then
                DespliegaRejilla(BGBEmpresa_c)
              else
                RejillaQuienCompra;
    kCentro: DespliegaRejilla(BGBCentro_c, [empresa_c.Text]);
    kProveedor: DespliegaRejilla(BGBProveedor_c, [empresa_c.Text]);
    kCalendar: DespliegaCalendario(BCBFecha_c);
  end;
end;

procedure TFMCompras.RejillaQuienCompra;
begin
  RejillaFlotante.DataSource := dsQuienCompra;
  RejillaFlotante.ColumnResult := 0;
  RejillaFlotante.ColumnFind := 1;
  RejillaFlotante.BControl := quien_compra_c;
  btnQuienCompra.GridShow;
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************

//Evento que se produce cuando cambia el registro activo
//Tambien se genera cuando se muestra el primero
//Evento que se produce cuando pulsamos modificar
//Aprovechar para modificar estado controles

procedure TFMCompras.AntesDeInsertar;
begin
  empresa_c.Text:= gsDefEmpresa;
  centro_c.Text:= gsDefCentro;
  fecha_c.Text:= DateToStr( Date );
  iContador:= VerContadorCompras( empresa_c.Text, centro_c.Text );
  numero_c.Text:= IntToStr( iContador );

  PInferior.Enabled:= false;
end;

procedure TFMCompras.AntesDeModificar;
var i: Integer;
begin
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;
  iContador:= -1;
  lblCarpeta.Caption:= '';

  PInferior.Enabled:= false;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprovechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMCompras.AntesDeVisualizar;
var i: Integer;
begin
    //Resaturar estado
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := True;
  end;

  PInferior.Enabled:= True;
end;


procedure TFMCompras.RequiredTime(Sender: TObject;
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

procedure TFMCompras.empresa_cChange(Sender: TObject);
begin
  stEmpresa_c.Caption := desEmpresa(empresa_c.Text);
  stCentro_c.Caption:= desCentro( empresa_c.text, centro_c.text );
  stProveedor_c.Caption:= desProveedor( empresa_c.text, proveedor_c.text );
  PonNombreCarpeta;
  if ( DSMaestro.DataSet.State in [dsInsert, dsEdit] ) and ( Estado <> teLocalizar ) then
  begin
    iContador:= VerContadorCompras( empresa_c.Text, centro_c.Text );
    numero_c.Text:= IntToStr( iContador );

    if ( DSMaestro.DataSet.State in [dsInsert] ) then
    begin
      if Length(empresa_c.Text) = 3 then
      begin
        if empresa_c.Text = '050' then
        begin
          if ( quien_compra_c.Text <> '022' ) and  ( quien_compra_c.Text <> '002' )  then
          begin
            quien_compra_c.Text:= empresa_c.Text;
          end;
        end
        else
        begin
          quien_compra_c.Text:= empresa_c.Text;
        end;
      end;
    end;
  end;
  quien_compra_c.Enabled:= (empresa_c.Text = '050');
  btnQuienCompra.Enabled:= (empresa_c.Text = '050');
end;

procedure TFMCompras.centro_cChange(Sender: TObject);
begin
  stCentro_c.Caption:= desCentro( empresa_c.text, centro_c.text );
  PonNombreCarpeta;
  if ( DSMaestro.DataSet.State in [dsInsert, dsEdit] ) and ( Estado <> teLocalizar ) then
  begin
    iContador:= VerContadorCompras( empresa_c.Text, centro_c.Text );
    numero_c.Text:= IntToStr( iContador );
  end;
end;

procedure TFMCompras.proveedor_cChange(Sender: TObject);
begin
  stProveedor_c.Caption:= desProveedor( empresa_c.text, proveedor_c.text );
  PonNombreCarpeta;
end;

procedure TFMCompras.fecha_cChange(Sender: TObject);
begin
  PonNombreCarpeta;
end;

procedure TFMCompras.numero_cChange(Sender: TObject);
begin
  PonNombreCarpeta;
end;

function TFMCompras.GetNombreCarpeta: string;
begin
   result:= empresa_c.Text + '-' + centro_c.Text + '-' +
            FormatDateTime('yy', StrToDateDef( fecha_c.Text, Date ) ) + '-' +
            proveedor_c.Text + '-' +
            FormatFloat( '00000', StrToIntDef( numero_c.Text, 0 ) );
end;

procedure TFMCompras.PonNombreCarpeta;
begin
  if ( empresa_c.Text <> '' ) and ( centro_c.Text <> '' ) and
     ( fecha_c.Text <> '' ) and  ( proveedor_c.Text <> '' ) and
     ( numero_c.Text <> '' ) then
  begin
     lblCarpeta.Caption:= GetNombreCarpeta;
  end
  else
  begin
    lblCarpeta.Caption:= '';
  end;
end;


function  TFMCompras.VerContadorCompras( const AEmpresa, ACentro: string ): integer;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select cont_compras_c from frf_centros ');
    SQL.Add(' where empresa_c = :empresa and centro_c = :centro ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    Open;
    result:= FieldByName('cont_compras_c').AsInteger;
    Close;
  end;
end;

procedure  TFMCompras.ActualizaContadorCompras( const AEmpresa, ACentro: string; const ANewContador: integer );
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' update frf_centros set cont_compras_c = :contador');
    SQL.Add(' where empresa_c = :empresa and centro_c = :centro ');
    ParamByName('contador').AsInteger:= ANewContador;
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ExecSQL;
  end;
end;

procedure TFMCompras.QComprasBeforePost(DataSet: TDataSet);
begin
  if iContador = StrToInt( numero_c.Text ) then
  begin
    if not DMBaseDatos.DBBaseDatos.InTransaction then
    begin
      DMBaseDatos.DBBaseDatos.StartTransaction;
      ActualizaContadorCompras( empresa_c.Text, centro_c.Text, iContador + 1 );
    end
    else
    begin
      raise Exception.Create('No puedo actualizar el contador, por favor intentelo mas tarde.');
    end;
  end;
end;

procedure TFMCompras.QComprasAfterPost(DataSet: TDataSet);
begin
  if iContador = StrToInt( numero_c.Text ) then
  begin
    DMBaseDatos.DBBaseDatos.Commit;
  end;
  if DataSet.State = dsInsert then
  begin
    CUPCarpetaRemesaItem.CrearSenyal( empresa_c.Text, numero_c.Text, fecha_c.Text );
  end;
end;

procedure TFMCompras.QComprasPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  if iContador = StrToInt( numero_c.Text ) then
  begin
    DMBaseDatos.DBBaseDatos.Rollback;
  end;
end;

procedure TFMCompras.btnFacturasClick(Sender: TObject);
begin
  if not MantenimientoGastos then
  begin
    if numero_c.Text = '0' then
      ShowMessage('Por favor, seleccione una compra valida.')
    else
      ShowMessage('Debe tener una compra seleccionada y en modo de visualización.');
  end;
end;

procedure TFMCompras.btnEntregasClick(Sender: TObject);
begin
  //ShowMessage('Programa en desarrollo.');
  if not MantenimientoEntregas then
  begin
    ShowMessage('Debe tener una compra seleccionada y en modo de visualización.');
  end;
end;

function TFMCompras.MantenimientoGastos: boolean;
begin
  result:= false;
  if ( Estado = teConjuntoResultado ) and not DSMaestro.DataSet.IsEmpty  and ( numero_c.Text <> '0' ) then
  begin
    FMGastosCompras := TFMGastosCompras.Create(Self);
    try
      FMGastosCompras.CargaParametros( empresa_c.Text, centro_c.Text, StrToIntDef( numero_c.Text, 0) );
      FMGastosCompras.ShowModal;
      if FMGastosCompras.GastosModificados then
      begin
        QCompras.Edit;
        QCompras.FieldByName('status_gastos_c').AsInteger:= -1;
        QCompras.Post;
      end;
      EstadoBotones( '-1' );
      QFacturas.Close;
      QFacturas.Open;
      result:= True;
    finally
      FreeAndNil(FMGastosCompras);
    end;
  end;
end;

function TFMCompras.MantenimientoEntregas: boolean;
begin
  result:= false;
  if ( Estado = teConjuntoResultado ) and ( not DSMaestro.DataSet.IsEmpty ) then
  begin
    FMEntregasCompras := TFMEntregasCompras.Create(Self);
    try
      FMEntregasCompras.CargaParametros( empresa_c.Text, centro_c.Text,
                                         StrToIntDef( numero_c.Text, 0),
                                         StrToDateDef( fecha_c.Text, Date ),
                                         proveedor_c.Text );
      FMEntregasCompras.ShowModal;
      if FMEntregasCompras.GastosModificados then
      begin
        QCompras.Edit;
        QCompras.FieldByName('status_gastos_c').AsInteger:= -1;
        QCompras.Post;
      end;
      EstadoBotones( '-1' );
      QEntregas.Close;
      QEntregas.Open;
      result:= True;
    finally
      FreeAndNil(FMEntregasCompras);
    end;
  end;
end;

procedure TFMCompras.QComprasAfterOpen(DataSet: TDataSet);
begin
  QEntregas.Open;
  QFacturas.Open;
end;

procedure TFMCompras.QComprasBeforeClose(DataSet: TDataSet);
begin
  QEntregas.Close;
  QFacturas.Close;
end;

procedure TFMCompras.btnAsignarClick(Sender: TObject);
var
  sAux: string;
begin
  if not QCompras.IsEmpty and ( QCompras.State = dsBrowse ) and ( numero_c.Text <> '0' ) then
  begin
    DGastosCompra:= TDGastosCompra.Create( self );
    try
      if DGastosCompra.GastosFacturaSeleccionada( empresa_c.Text, centro_c.Text, StrToInt( numero_c.Text ), False, sAux ) then
      begin
        QCompras.Edit;
        QCompras.FieldByName('status_gastos_c').AsInteger:= 1;
        QCompras.Post;
        EstadoBotones( '1' );
      end;
      ShowMessage( sAux );
    finally
      FreeAndNil( DGastosCompra );
    end;
  end
  else
  begin
    ShowMessage('Por favor, seleccione una compra valida.');
  end;
end;

procedure TFMCompras.status_gastos_cChange(Sender: TObject);
begin
  EstadoBotones( status_gastos_c.Text );
end;

procedure TFMCompras.EstadoBotones( const AValor: string );
begin

  //AValor =  0 -> no hay gastos
  //AValor =  1 -> gastos asignados
  //AValor = -1 -> gastos por asignar

  btnFacturas.Enabled:= not QCompras.IsEmpty and ( QCompras.State = dsBrowse );
  btnEntregas.Enabled:= btnFacturas.Enabled;
  if ( AValor = '-1' ) then
  begin
    btnAsignar.Enabled:= not QCompras.IsEmpty and ( QCompras.State = dsBrowse );
  end
  else
  begin
    btnAsignar.Enabled:= False;
  end;
end;

procedure TFMCompras.quien_compra_cChange(Sender: TObject);
begin
  if empresa_c.Text = '050' then
  begin
    if quien_compra_c.Text = '050' then
    begin
      stQuienCompra.Caption := 'SAT BONNYSA';
    end
    else
    if quien_compra_c.Text = '022' then
    begin
      stQuienCompra.Caption := 'AGROGENESIS';
    end
    else
    if quien_compra_c.Text = '002' then
    begin
      stQuienCompra.Caption := 'ALZAMORA';
    end
    else
    begin
      stQuienCompra.Caption := '';
    end
  end
  else
  begin
    stQuienCompra.Caption := desEmpresa(quien_compra_c.Text);
  end;
end;

end.
