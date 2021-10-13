unit ServiciosEntregaFM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbtables,
  DError, DBCtrls;

type
  TFMServiciosEntrega = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    Label13: TLabel;
    RejillaFlotante: TBGrid;
    QServicios: TQuery;
    observaciones_sec: TDBMemo;
    CalendarioFlotante: TBCalendario;
    LFecha: TLabel;
    fecha_sec: TBDEdit;
    btnfecha_sec: TBCalendarButton;
    lblNombre1: TLabel;
    lblNombre3: TLabel;
    matricula_sec: TBDEdit;
    pBoton: TPanel;
    btnAsignar: TButton;
    btnGastos: TButton;
    DSSalidas: TDataSource;
    QEntregas: TQuery;
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
    servicio_sec: TBDEdit;
    status_sec: TBDEdit;
    stStaus: TStaticText;
    lbl1: TLabel;
    lbl2: TLabel;
    QNumPalets: TQuery;
    DSNumPalets: TDataSource;
    dbeNumPalets: TDBText;
    lblNumPalets: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure btnGastosClick(Sender: TObject);
    procedure QServiciosAfterOpen(DataSet: TDataSet);
    procedure QServiciosBeforeClose(DataSet: TDataSet);
    procedure btnAsignarClick(Sender: TObject);
    procedure btnSalidasClick(Sender: TObject);
    procedure status_secChange(Sender: TObject);

  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

    function  GetNumServicio: integer;

    procedure EstadoBotones( const AValor: integer );

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeLocalizar;
    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;
    procedure AntesDeBorrar;

    //Listado
    procedure Previsualizar; override;
    function  MantenimientoGastos: boolean;
    function  MantenimientoEntregas: boolean;
  end;

implementation

uses UDMAuxDB, CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, DPreview, bSQLUtils, UDMConfig, ServiciosEntregaDM,
  ServiciosEntregaDetalleFM, ServiciosEntregaRM,  ServiciosEntregaGastosFM,
  UDMCambioMoneda;

{$R *.DFM}

procedure TFMServiciosEntrega.AbrirTablas;
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

procedure TFMServiciosEntrega.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuery(DataSetMaestro);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMServiciosEntrega.FormCreate(Sender: TObject);
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
 {+}Select := ' SELECT * FROM frf_servicios_entrega_c ';
 {+}where := ' WHERE servicio_sec= -1 ';
 {+}Order := ' ORDER BY fecha_sec desc, matricula_sec ';


  with QEntregas do
  begin
    SQL.Clear;
    SQL.Add(' select  empresa_ec empresa, codigo_ec entrega, ');
    SQL.Add('         proveedor_Ec cod_proveedor, ( select nombre_p from frf_proveedores ');
    SQL.Add('                                       where empresa_p = empresa_ec and proveedor_p = proveedor_ec ) proveedor, ');
    SQL.Add('         almacen_El cod_almacen, ( select nombre_pa from frf_proveedores_almacen ');
    SQL.Add('                                   where empresa_pa = empresa_ec and proveedor_pa = proveedor_ec and almacen_pa = almacen_el ) almacen, ');
    SQL.Add('         vehiculo_ec matricula, ');
    SQL.Add('         transporte_ec cod_transporte, transporte_ec || '' - '' || ( select descripcion_t from frf_transportistas ');
    SQL.Add('                                                                   where empresa_t = empresa_ec and transporte_t = transporte_ec ) transporte, ');
    SQL.Add('         producto_el cod_producto, ( select descripcion_p from frf_productos ');
    SQL.Add('                                     where empresa_p = empresa_ec and producto_p = producto_el ) producto, ');
    SQL.Add('         sum(palets_el) palets, ');
    SQL.Add('         sum(cajas_el) cajas, ');
    SQL.Add('         sum(kilos_el) kilos ');

    SQL.Add(' from frf_servicios_entrega_l, frf_entregas_c, frf_entregas_l ');

    SQL.Add(' where servicio_sel = :servicio_sec ');
    SQL.Add(' and codigo_ec = entrega_sel ');
    SQL.Add(' and codigo_el = codigo_ec ');
    SQL.Add(' group by empresa, entrega, matricula, cod_transporte, transporte, cod_producto, ');
    SQL.Add('           producto, cod_proveedor, proveedor, cod_almacen, almacen ');
    SQL.Add(' order by entrega ');
  end;

  with QNumPalets do
  begin
    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add(' --        producto_el producto, ');
    SQL.Add('         sum(palets_el) palets, ');
    SQL.Add('         sum(cajas_el) cajas, ');
    SQL.Add('         sum(kilos_el) kilos ');

    SQL.Add(' from frf_servicios_entrega_l, frf_entregas_l ');
    SQL.Add(' where servicio_sel = :servicio_sec ');
    SQL.Add(' and codigo_el = entrega_sel ');

    SQL.Add(' --group by 1 ');
  end;

  with QGastos do
  begin
    SQL.Clear;
    SQL.Add(' select tipo_seg Tipo, ref_fac_seg factura, fecha_fac_seg fecha, ');
    SQL.Add('        importe_seg Importe ');
    SQL.Add(' from frf_servicios_entrega_g ');
    SQL.Add(' where servicio_seg = :servicio_sec ');
    SQL.Add(' order by tipo_seg ');
    Prepare;
  end;

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;

     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnBrowse := AntesDeLocalizar;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;
  OnBeforeMasterDelete:= AntesDeBorrar;

     //Focos
  {+}FocoAltas := fecha_sec;
  {+}FocoModificar := fecha_sec;
  {+}FocoLocalizar := servicio_sec;

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


procedure TFMServiciosEntrega.FormActivate(Sender: TObject);
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


procedure TFMServiciosEntrega.FormDeactivate(Sender: TObject);
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

procedure TFMServiciosEntrega.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with QEntregas do
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

procedure TFMServiciosEntrega.FormKeyDown(Sender: TObject; var Key: Word;
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
        if not observaciones_sec.Focused then
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
    Ord('E'):
      if ssAlt in Shift  then
          if not MantenimientoEntregas then
            ShowMessage('Debe tener un servcio seleccionado y en modo de visualización.');
  end;
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

{+}//Sustituir por funcion generica

procedure TFMServiciosEntrega.Filtro;
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

procedure TFMServiciosEntrega.AnyadirRegistro;
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

procedure TFMServiciosEntrega.ValidarEntradaMaestro;
var
  dFecha: TDateTime;
begin
  if Trim(matricula_sec.Text) = '' then
  begin
    raise Exception.Create('Falta la matricula del vehículo.');
  end;
  if not tryStrToDate( fecha_sec.Text, dFecha ) then
  begin
    raise Exception.Create('Falta la fecha del servicio o es incorrecta.');
  end;
  if Estado = teAlta then
  begin
    QServicios.FieldByName('servicio_sec').AsInteger:= GetNumServicio;
    QServicios.FieldByName('status_sec').AsInteger:= 0;
  end;

end;

procedure TFMServiciosEntrega.Previsualizar;
var
  RMServiciosEntrega: TRMServiciosEntrega;
begin
  //Crear el listado
  if not QServicios.IsEmpty then
  try
    RMServiciosEntrega:= TRMServiciosEntrega.Create(Application);
    try
      RMServiciosEntrega.QServicios.SQL.Clear;
      RMServiciosEntrega.QServicios.SQL.AddStrings(QServicios.SQL);
      RMServiciosEntrega.QServicios.Open;

      PonLogoGrupoBonnysa(RMServiciosEntrega);
      Preview(RMServiciosEntrega);
    except
      FreeAndNil(RMServiciosEntrega);
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

procedure TFMServiciosEntrega.ARejillaFlotanteExecute(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  (*
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBempresa_sv);
  end;
  *)
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

procedure TFMServiciosEntrega.AntesDeLocalizar;
begin
  servicio_sec.Enabled:= true;
  status_sec.Enabled:= true;
  PInferior.Enabled:= false;
end;

procedure TFMServiciosEntrega.AntesDeInsertar;
begin
  fecha_sec.Text:= DateToStr( Date );

  servicio_sec.Enabled:= False;
  status_sec.Enabled:= False;
  PInferior.Enabled:= false;
end;

procedure TFMServiciosEntrega.AntesDeModificar;
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

  servicio_sec.Enabled:= False;
  status_sec.Enabled:= False;
  PInferior.Enabled:= false;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprovechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMServiciosEntrega.AntesDeVisualizar;
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

  servicio_sec.Enabled:= True;
  status_sec.Enabled:= True;
  PInferior.Enabled:= True;
end;

procedure TFMServiciosEntrega.AntesDeBorrar;
begin
  if ( not QGastos.IsEmpty ) or ( not QEntregas.IsEmpty ) then
  begin
    if ( not QGastos.IsEmpty ) and ( not QEntregas.IsEmpty ) then
    begin
      raise Exception.Create('Antes de borrar el servicio borre los gastos y entregas asociados');
    end
    else
    if ( not QGastos.IsEmpty )  then
    begin
      raise Exception.Create('Antes de borrar el servicio borre los gastos asociados');
    end
    else
    begin
      raise Exception.Create('Antes de borrar el servicio borre las entregas asociados');
    end
  end
  else
  begin
    DMServiciosEntrega:= TDMServiciosEntrega.Create( self );
    try
      DMServiciosEntrega.BorrarGastosServicio( QServicios.FieldByname('servicio_sec').AsInteger );
    finally
      FreeAndNil( DMServiciosEntrega );
    end;
  end;
end;

procedure TFMServiciosEntrega.RequiredTime(Sender: TObject;
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

function  TFMServiciosEntrega.GetNumServicio: integer;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(max(servicio_sec),0) + 1 num_servicio ');
    SQL.Add(' from frf_servicios_entrega_c ');
    Open;
    result:= FieldByName('num_servicio').AsInteger;
    Close;
  end;
end;

procedure TFMServiciosEntrega.btnGastosClick(Sender: TObject);
begin
  if not MantenimientoGastos then
  begin
      ShowMessage('Debe tener una compra seleccionada y en modo de visualización.');
  end;
end;

procedure TFMServiciosEntrega.btnSalidasClick(Sender: TObject);
begin
  //ShowMessage('Programa en desarrollo.');
  if not MantenimientoEntregas then
  begin
    ShowMessage('Debe tener una compra seleccionada y en modo de visualización.');
  end;
end;

function TFMServiciosEntrega.MantenimientoGastos: boolean;
begin
  result:= false;
  if ( Estado = teConjuntoResultado ) and ( not DSMaestro.DataSet.IsEmpty )  then
  begin
    FMServiciosEntregaGastos := TFMServiciosEntregaGastos.Create(Self);
    try
      FMServiciosEntregaGastos.CargaParametros( StrToIntDef( servicio_sec.Text, 0), StrToDateDef( fecha_sec.Text, Date ) );
      FMServiciosEntregaGastos.ShowModal;
      if FMServiciosEntregaGastos.GastosModificados and ( QServicios.FieldByName('status_sec').AsInteger = 2 ) then
      begin
        QServicios.Edit;
        QServicios.FieldByName('status_sec').AsInteger:= 1;
        QServicios.Post;
      end;
      EstadoBotones( 1 );
      QGastos.Close;
      QGastos.Open;
      result:= True;
    finally
      FreeAndNil(FMServiciosEntregaGastos);
    end;
  end;
end;

function TFMServiciosEntrega.MantenimientoEntregas: boolean;
begin
  result:= false;
  if ( Estado = teConjuntoResultado ) and ( not DSMaestro.DataSet.IsEmpty ) then
  begin
    FMServiciosEntregaDetalle := TFMServiciosEntregaDetalle.Create(Self);
    try
      FMServiciosEntregaDetalle.CargaParametros( StrToIntDef( servicio_sec.Text, 0),
                                         StrToDateDef( fecha_sec.Text, Date ), matricula_sec.Text );
      FMServiciosEntregaDetalle.ShowModal;
      if FMServiciosEntregaDetalle.GastosModificados and ( QServicios.FieldByName('status_sec').AsInteger = 2 ) then
      begin
        QServicios.Edit;
        QServicios.FieldByName('status_sec').AsInteger:= 1;
        QServicios.Post;
      end;
      EstadoBotones( 1 );
      QEntregas.Close;
      QEntregas.Open;
      QNumPalets.Close;
      QNumPalets.Open;
      result:= True;
    finally
      FreeAndNil(FMServiciosEntregaDetalle);
    end;
  end;
end;

procedure TFMServiciosEntrega.QServiciosAfterOpen(DataSet: TDataSet);
begin
  QEntregas.Open;
  QGastos.Open;
  QNumPalets.Open;
end;

procedure TFMServiciosEntrega.QServiciosBeforeClose(DataSet: TDataSet);
begin
  QEntregas.Close;
  QGastos.Close;
  QNumPalets.Close;
end;

function UnidadDist: string;
begin
  result:= '';
  InputQuery('REPERCUTIR GASTOS POR ',
             'P -> Palets ' + #13 + #10 + 'C -> Cajas ' + #13 + #10 +
             'K -> Kilos ' + #13 + #10 + 'I -> Importe ' + #13 + #10 +
             'Vacio o otro valor -> Unidad grabada en tipo gastos ', result );
  Result:= UpperCase( Result );
  if ( Result <> 'P' ) and ( Result <> 'C' ) and ( Result <> 'K' ) and ( Result <> 'I' ) then
    Result:= '';
end;

procedure TFMServiciosEntrega.btnAsignarClick(Sender: TObject);
var
  sAux: string;
begin
  if QServicios.FieldByName('status_sec').AsInteger <> 2 then
  begin
    if not QServicios.IsEmpty and ( QServicios.State = dsBrowse ) then
    begin
      DMServiciosEntrega:= TDMServiciosEntrega.Create( self );
      try
        if DMServiciosEntrega.RepercutirGastosServicio( StrToInt( servicio_sec.Text ),
                                                                 UnidadDist, False, True, sAux ) then
        begin
          QServicios.Edit;
          QServicios.FieldByName('status_sec').AsInteger:= 2;
          QServicios.Post;
          EstadoBotones( 2 );
        end;
        ShowMessage( sAux );
      finally
        FreeAndNil( DMServiciosEntrega );
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

procedure TFMServiciosEntrega.EstadoBotones( const AValor: integer );
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

procedure TFMServiciosEntrega.status_secChange(Sender: TObject);
begin
  if status_sec.Text = '0' then
  begin
    stStaus.Caption:= 'NUEVO, GASTOS PENDIENTES ASIGNAR';
  end
  else
  if status_sec.Text = '1' then
  begin
    stStaus.Caption:= 'MODIFICADO, REASIGNAR GASTOS PENDIENTE';
  end
  else
  if status_sec.Text = '2' then
  begin
    stStaus.Caption:= 'GASTOS ASIGNADOS';
  end
  else
  begin
    stStaus.Caption:= '';
  end;
end;

end.
