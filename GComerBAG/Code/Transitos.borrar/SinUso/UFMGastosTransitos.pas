unit UFMGastosTransitos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbtables,
  DError, DBCtrls;

type
  TFMGastosTransitos = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    Label13: TLabel;
    Label1: TLabel;
    empresa_stc: TBDEdit;
    BGBEmpresa: TBGridButton;
    stEmpresa: TStaticText;
    RejillaFlotante: TBGrid;
    QServicios: TQuery;
    observaciones_stc: TDBMemo;
    CalendarioFlotante: TBCalendario;
    LFecha: TLabel;
    fecha_stc: TBDEdit;
    BCBFecha: TBCalendarButton;
    lblNombre1: TLabel;
    lblNombre3: TLabel;
    matricula_stc: TBDEdit;
    pBoton: TPanel;
    btnAsignar: TButton;
    btnGastos: TButton;
    DSSalidas: TDataSource;
    QTransitos: TQuery;
    QGastos: TQuery;
    DSGastos: TDataSource;
    PInferior: TPanel;
    lblNombre7: TLabel;
    DBGrid1: TDBGrid;
    lblNombre8: TLabel;
    DBGrid2: TDBGrid;
    btnSalidas: TButton;
    lblServico: TLabel;
    lblStatus: TLabel;
    servicio_stc: TBDEdit;
    status_stc: TBDEdit;
    stStaus: TStaticText;
    lbl1: TLabel;
    lbl2: TLabel;
    QGastostipo: TStringField;
    QGastosfactura: TStringField;
    QGastosfecha: TDateField;
    QGastosproducto: TStringField;
    QGastosimporte: TFloatField;
    QNumPalets: TQuery;
    DSNumPalets: TDataSource;
    dbeNumPalets: TDBText;
    lblNumPalets: TLabel;
    QTransitosdestino: TStringField;
    QTransitoscentro: TStringField;
    QTransitosreferencia: TIntegerField;
    QTransitosfecha: TDateField;
    QTransitosmatricula: TStringField;
    QTransitoscod_transporte: TSmallintField;
    QTransitostransportista: TStringField;
    QTransitospalets: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure empresa_stcChange(Sender: TObject);
    procedure btnGastosClick(Sender: TObject);
    procedure QServiciosAfterOpen(DataSet: TDataSet);
    procedure QServiciosBeforeClose(DataSet: TDataSet);
    procedure btnAsignarClick(Sender: TObject);
    procedure btnSalidasClick(Sender: TObject);
    procedure status_stcChange(Sender: TObject);

  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

    function  GetNumServicio( const AEmpresa: string ): integer;

    procedure EstadoBotones( const AValor: integer );

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeLocalizar;
    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;
    function  MantenimientoGastos: boolean;
    function  MantenimientoSalidas: boolean;
  end;

implementation

uses UDMAuxDB, CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, DPreview, bSQLUtils, UDMConfig, UFMFacturasGastosTransitos,
  UFMTransitosGastosTransitos, UQRGastosTransitos,  CDAsignarGastosTransitos;

{$R *.DFM}

procedure TFMGastosTransitos.AbrirTablas;
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

procedure TFMGastosTransitos.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuery(DataSetMaestro);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMGastosTransitos.FormCreate(Sender: TObject);
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
 {+}DataSetMaestro := QServicios;

  //Lista de componentes
  Lista := TList.Create;
  PMaestro.GetTabOrderList(Lista);

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_servicios_transitos_c ';
 {+}where := ' WHERE empresa_stc=' + QUOTEDSTR('###');
 {+}Order := ' ORDER BY empresa_stc, servicio_stc desc';

  with QTransitos do
  begin
    SQL.Clear;
    SQL.Add(' select planta_destino_tc destino, ');
    SQL.Add('         centro_destino_tc centro, ');
    SQL.Add('         referencia_tc referencia, ');
    SQL.Add('         fecha_tc fecha, ');
    SQL.Add('         vehiculo_tc matricula, ');
    SQL.Add('         transporte_tc cod_transporte, ');
    SQL.Add('         ( select descripcion_t from frf_transportistas where empresa_t = empresa_stl and transporte_t = transporte_tc ) transportista, ');
    SQL.Add('         sum(palets_tl) palets  ');

    SQL.Add('  from frf_servicios_transitos_l, frf_transitos_c, frf_transitos_l ');

    SQL.Add('  where empresa_stl = :empresa_stc ');
    SQL.Add('  and servicio_stl = :servicio_stc ');

    SQL.Add('  and empresa_tc = :empresa_stc ');
    SQL.Add('  and centro_tc = centro_stl ');
    SQL.Add('  and referencia_tc = referencia_stl ');
    SQL.Add('  and fecha_tc = fecha_stl ');

    SQL.Add('  and empresa_tl = :empresa_stc ');
    SQL.Add('  and centro_tl = centro_stl ');
    SQL.Add('  and referencia_tl = referencia_stl ');
    SQL.Add('  and fecha_tl = fecha_stl ');

    SQL.Add('  group by 1,2,3,4,5,6 ');
    SQL.Add('  order by 1,2 ');
  end;

  with QNumPalets do
  begin
    SQL.Clear;
    SQL.Add(' select sum(n_palets_sl) palets ');
    SQL.Add(' from frf_salidas_servicios_venta, frf_transitos_l ');
    SQL.Add(' where empresa_stl = :empresa_stc ');
    SQL.Add('  and servicio_stl = :servicio_stc ');
    SQL.Add('  and empresa_sl = :empresa_stc ');
    SQL.Add('  and centro_sl = centro_stl ');
    SQL.Add('  and referencia_sl = referencia_stl ');
    SQL.Add('  and fecha_sl = fecha_stl ');
  end;

  with QGastos do
  begin
    SQL.Clear;
    SQL.Add(' select tipo_stg Tipo, ref_fac_stg factura, fecha_fac_stg fecha, ');
    SQL.Add('        producto_stg Producto, importe_stg Importe ');
    SQL.Add(' from frf_gastos_servicios_venta ');
    SQL.Add(' where empresa_stg = :empresa_stc ');
    SQL.Add(' and servicio_stg = :servicio_stc ');
    SQL.Add(' order by tipo_stg, producto_stg ');
    Prepare;
  end;

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;

     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_stc.Tag := kEmpresa;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnBrowse := AntesDeLocalizar;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;

     //Focos
  {+}FocoAltas := empresa_stc;
  {+}FocoModificar := observaciones_stc;
  {+}FocoLocalizar := empresa_stc;

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

end;

{+ CUIDADIN }


procedure TFMGastosTransitos.FormActivate(Sender: TObject);
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


procedure TFMGastosTransitos.FormDeactivate(Sender: TObject);
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

procedure TFMGastosTransitos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with QTransitos do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QGastos do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QNumPalets do
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

procedure TFMGastosTransitos.FormKeyDown(Sender: TObject; var Key: Word;
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
        if not observaciones_stc.Focused then
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
    Ord('G'):
      if ssAlt in Shift  then
          if not MantenimientoGastos then
            ShowMessage('Debe tener un servico seleccionado y en modo de visualización.');
    Ord('S'):
      if ssAlt in Shift  then
          if not MantenimientoSalidas then
            ShowMessage('Debe tener un servcio seleccionado y en modo de visualización.');
  end;
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

{+}//Sustituir por funcion generica

procedure TFMGastosTransitos.Filtro;
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

procedure TFMGastosTransitos.AnyadirRegistro;
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

procedure TFMGastosTransitos.ValidarEntradaMaestro;
var
  dFecha: TDateTime;
begin
  if stempresa.Caption = '' then
  begin
    raise Exception.Create('Falta el código de la empresa o es incorrecto.');
  end;
  if Trim(matricula_stc.Text) = '' then
  begin
    raise Exception.Create('Falta la matricula del vehículo.');
  end;
  if not tryStrToDate( fecha_stc.Text, dFecha ) then
  begin
    raise Exception.Create('Falta la fecha del servicio o es incorrecta.');
  end;
  if Estado = teAlta then
    QServicios.FieldByName('servicio_stc').AsInteger:= GetNumServicio( QServicios.FieldByName('empresa_stc').AsString );
end;

procedure TFMGastosTransitos.Previsualizar;
var
  QRGastosTransitos: TQRGastosTransitos;
begin
  //Crear el listado
  if not QServicios.IsEmpty then
  try
    QRGastosTransitos:= TQRGastosTransitos.Create(Application);
    try
      QRGastosTransitos.QServicios.SQL.Clear;
      QRGastosTransitos.QServicios.SQL.AddStrings(QServicios.SQL);
      QRGastosTransitos.QServicios.Open;

      PonLogoGrupoBonnysa(QRGastosTransitos);
      Preview(QRGastosTransitos);
    except
      FreeAndNil(QRGastosTransitos);
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

procedure TFMGastosTransitos.ARejillaFlotanteExecute(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBempresa);
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
//Evento que se produce cuando pulsamos modificar
//Aprovechar para modificar estado controles

procedure TFMGastosTransitos.AntesDeLocalizar;
begin
  servicio_stc.Enabled:= true;
  status_stc.Enabled:= true;
  PInferior.Enabled:= false;
end;

procedure TFMGastosTransitos.AntesDeInsertar;
begin
  empresa_stc.Text:= gsDefEmpresa;
  fecha_stc.Text:= DateToStr( Date );

  servicio_stc.Enabled:= False;
  status_stc.Enabled:= False;
  PInferior.Enabled:= false;
end;

procedure TFMGastosTransitos.AntesDeModificar;
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

  servicio_stc.Enabled:= False;
  status_stc.Enabled:= False;
  PInferior.Enabled:= false;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprovechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMGastosTransitos.AntesDeVisualizar;
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

  servicio_stc.Enabled:= True;
  status_stc.Enabled:= True;
  PInferior.Enabled:= True;
end;


procedure TFMGastosTransitos.RequiredTime(Sender: TObject;
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

procedure TFMGastosTransitos.empresa_stcChange(Sender: TObject);
begin
  stEmpresa.Caption := desEmpresa(empresa_stc.Text);
end;

function  TFMGastosTransitos.GetNumServicio( const AEmpresa: string ): integer;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(max(servicio_stc),0) + 1 num_servicio ');
    SQL.Add(' from frf_servicios_transitos_c ');
    SQL.Add(' where empresa_stc = :empresa ');
    ParamByName('empresa').AsString:= AEmpresa;
    Open;
    result:= FieldByName('num_servicio').AsInteger;
    Close;
  end;
end;

procedure TFMGastosTransitos.btnGastosClick(Sender: TObject);
begin
  if not MantenimientoGastos then
  begin
      ShowMessage('Debe tener una compra seleccionada y en modo de visualización.');
  end;
end;

procedure TFMGastosTransitos.btnSalidasClick(Sender: TObject);
begin
  //ShowMessage('Programa en desarrollo.');
  if not Mantenimientosalidas then
  begin
    ShowMessage('Debe tener una compra seleccionada y en modo de visualización.');
  end;
end;

function TFMGastosTransitos.MantenimientoGastos: boolean;
begin
  result:= false;
  if ( Estado = teConjuntoResultado ) and ( not DSMaestro.DataSet.IsEmpty )  then
  begin
    FMFacturasGastosTransitos := TFMFacturasGastosTransitos.Create(Self);
    try
      FMFacturasGastosTransitos.CargaParametros( empresa_stc.Text, StrToIntDef( servicio_stc.Text, 0), StrToDateDef( fecha_stc.Text, Date ) );
      FMFacturasGastosTransitos.ShowModal;
      if FMFacturasGastosTransitos.GastosModificados and ( QServicios.FieldByName('status_stc').AsInteger = 2 ) then
      begin
        QServicios.Edit;
        QServicios.FieldByName('status_stc').AsInteger:= 1;
        QServicios.Post;
      end;
      EstadoBotones( 1 );
      QGastos.Close;
      QGastos.Open;
      result:= True;
    finally
      FreeAndNil(FMFacturasGastosTransitos);
    end;
  end;
end;

function TFMGastosTransitos.MantenimientoSalidas: boolean;
begin
  result:= false;
  if ( Estado = teConjuntoResultado ) and ( not DSMaestro.DataSet.IsEmpty ) then
  begin
    FMTransitosGastosTransitos := TFMTransitosGastosTransitos.Create(Self);
    try
      FMTransitosGastosTransitos.CargaParametros( empresa_stc.Text, StrToIntDef( servicio_stc.Text, 0),
                                         StrToDateDef( fecha_stc.Text, Date ), matricula_stc.Text );
      FMTransitosGastosTransitos.ShowModal;
      if FMTransitosGastosTransitos.GastosModificados and ( QServicios.FieldByName('status_stc').AsInteger = 2 ) then
      begin
        QServicios.Edit;
        QServicios.FieldByName('status_stc').AsInteger:= 1;
        QServicios.Post;
      end;
      EstadoBotones( 1 );
      QTransitos.Close;
      QTransitos.Open;
      QNumPalets.Close;
      QNumPalets.Open;
      result:= True;
    finally
      FreeAndNil(FMTransitosGastosTransitos);
    end;
  end;
end;

procedure TFMGastosTransitos.QServiciosAfterOpen(DataSet: TDataSet);
begin
  QTransitos.Open;
  QGastos.Open;
  QNumPalets.Open;
end;

procedure TFMGastosTransitos.QServiciosBeforeClose(DataSet: TDataSet);
begin
  QTransitos.Close;
  QGastos.Close;
  QNumPalets.Close;
end;

procedure TFMGastosTransitos.btnAsignarClick(Sender: TObject);
var
  sAux: string;
begin
  ShowMessage('En desarrollo');
  Exit;
  
  if QServicios.FieldByName('status_stc').AsInteger <> 2 then
  begin
    if not QServicios.IsEmpty and ( QServicios.State = dsBrowse ) then
    begin
      DAsignarGastosTransitos:= TDAsignarGastosTransitos.Create( self );
      try
        if DAsignarGastosTransitos.RepercutirGastosServicio( empresa_stc.Text, StrToInt( servicio_stc.Text ), False, sAux ) then
        begin
          QServicios.Edit;
          QServicios.FieldByName('status_stc').AsInteger:= 2;
          QServicios.Post;
          EstadoBotones( 2 );
        end;
        ShowMessage( sAux );
      finally
        FreeAndNil( DAsignarGastosTransitos );
      end;
    end
    else
    begin
      ShowMessage('Por favor, seleccione un registro valido.');
    end;
  end
  else
  begin
    ShowMessage('Gastos ya asignados.');
  end;
end;

procedure TFMGastosTransitos.EstadoBotones( const AValor: integer );
begin

  //AValor =  0 -> nuevos
  //AValor =  1 -> reasignar
  //AValor =  2 -> asignados

  btnGastos.Enabled:= not QServicios.IsEmpty and ( QServicios.State = dsBrowse );
  btnSalidaS.Enabled:= btnGastos.Enabled;
  if ( AValor < 2 ) then
  begin
    btnAsignar.Enabled:= not QServicios.IsEmpty and ( QServicios.State = dsBrowse );
  end
  else
  begin
    btnAsignar.Enabled:= False;
  end;
end;

procedure TFMGastosTransitos.status_stcChange(Sender: TObject);
begin
  if status_stc.Text = '0' then
  begin
    stStaus.Caption:= 'NUEVO, GASTOS PENDIENTES ASIGNAR';
  end
  else
  if status_stc.Text = '1' then
  begin
    stStaus.Caption:= 'MODIFICADO, REASIGNAR GASTOS PENDIENTE';
  end
  else
  if status_stc.Text = '2' then
  begin
    stStaus.Caption:= 'GASTOS ASIGNADOS';
  end
  else
  begin
    stStaus.Caption:= '';
  end;
end;

end.
