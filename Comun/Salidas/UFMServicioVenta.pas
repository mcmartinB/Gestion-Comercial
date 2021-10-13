unit UFMServicioVenta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbtables,
  DError, DBCtrls;

type
  TFMServicioVenta = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    Label13: TLabel;
    Label1: TLabel;
    empresa_sv: TBDEdit;
    BGBEmpresa_sv: TBGridButton;
    stEmpresa_sv: TStaticText;
    RejillaFlotante: TBGrid;
    QServicios: TQuery;
    observaciones_sv: TDBMemo;
    CalendarioFlotante: TBCalendario;
    LFecha: TLabel;
    fecha_sv: TBDEdit;
    BCBFecha_sv: TBCalendarButton;
    lblNombre1: TLabel;
    lblNombre3: TLabel;
    matricula_sv: TBDEdit;
    pBoton: TPanel;
    btnAsignar: TButton;
    btnGastos: TButton;
    DSSalidas: TDataSource;
    QSalidas: TQuery;
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
    servicio_sv: TBDEdit;
    status_sv: TBDEdit;
    stStaus: TStaticText;
    lbl1: TLabel;
    lbl2: TLabel;
    QGastostipo: TStringField;
    QGastosfactura: TStringField;
    QGastosfecha: TDateField;
    QGastosproducto: TStringField;
    QGastosimporte: TFloatField;
    QSalidasorigen: TStringField;
    QSalidasalbaran: TIntegerField;
    QSalidascliente: TStringField;
    QSalidassuministro: TStringField;
    QSalidasmatricula: TStringField;
    QSalidastransportista: TStringField;
    QSalidaspalets: TFloatField;
    QSalidaseuros: TFloatField;
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
    procedure empresa_svChange(Sender: TObject);
    procedure btnGastosClick(Sender: TObject);
    procedure QServiciosAfterOpen(DataSet: TDataSet);
    procedure QServiciosBeforeClose(DataSet: TDataSet);
    procedure btnAsignarClick(Sender: TObject);
    procedure btnSalidasClick(Sender: TObject);
    procedure status_svChange(Sender: TObject);

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
  CAuxiliarDB, Principal, DPreview, bSQLUtils, UDMConfig,
  UFMGastosServicioVenta, UFMSalidasServiciosVenta,
  UQRServicioVenta,  CDAsignarGastosServicioVenta, UDMCambioMoneda;

{$R *.DFM}

procedure TFMServicioVenta.AbrirTablas;
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

procedure TFMServicioVenta.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuery(DataSetMaestro);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMServicioVenta.FormCreate(Sender: TObject);
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
 {+}Select := ' SELECT * FROM frf_servicios_venta ';
 {+}where := ' WHERE empresa_sv=' + QUOTEDSTR('###');
 {+}Order := ' ORDER BY empresa_sv, servicio_sv desc';


 (*
  with QSalidas do
  begin
    SQL.Clear;
    SQL.Add(' select n_albaran_sc albaran, centro_salida_sc centro, fecha_sc fecha, cliente_sal_sc cliente, dir_sum_sc suministro ');

    SQL.Add(' from frf_salidas_servicios_venta, frf_salidas_c ');

    SQL.Add(' where empresa_ssv = :empresa_sv ');
    SQL.Add(' and servicio_ssv = :servicio_sv ');

    SQL.Add(' and empresa_sc = :empresa_sv ');
    SQL.Add(' and centro_salida_sc = centro_salida_ssv ');
    SQL.Add(' and n_albaran_sc = n_albaran_ssv ');
    SQL.Add(' and fecha_sc = fecha_ssv ');

    SQL.Add(' order by n_albaran_ssv ');

    Prepare;
  end;
  *)

  (*
  with QSalidas do
  begin
    SQL.Clear;
    SQL.Add(' select centro_salida_sc centro, n_albaran_sc albaran, ');
    SQL.Add('        cliente_sal_sc cliente, dir_sum_sc suministro, vehiculo_sc matricula, ');
    SQL.Add('        ( select descripcion_t from frf_transportistas where empresa_t = :empresa_sv and transporte_t = transporte_sc ) transportista, ');
    SQL.Add('        ( select sum(n_palets_sl)  ');
    SQL.Add('         from frf_salidas_l ');
    SQL.Add('         where empresa_sl = :empresa_sv ');
    SQL.Add('         and centro_salida_sl = centro_salida_ssv ');
    SQL.Add('         and fecha_sl = fecha_ssv ');
    SQL.Add('         and n_albaran_sl = n_albaran_ssv ) palets ');

    SQL.Add(' from frf_salidas_servicios_venta, frf_salidas_c ');

    SQL.Add(' where empresa_ssv = :empresa_sv ');
    SQL.Add(' and servicio_ssv = :servicio_sv ');

    SQL.Add(' and empresa_sc = :empresa_sv ');
    SQL.Add(' and centro_salida_sc = centro_salida_ssv ');
    SQL.Add(' and n_albaran_sc = n_albaran_ssv ');
    SQL.Add(' and fecha_sc = fecha_ssv ');

    SQL.Add(' order by n_albaran_sc ');
  end;
  *)
  with QSalidas do
  begin
    SQL.Clear;
    SQL.Add(' select centro_origen_sl origen, n_albaran_sc albaran, ');
    SQL.Add('         cliente_sal_sc cliente, dir_sum_sc suministro, vehiculo_sc matricula, ');
    SQL.Add('         ( select descripcion_t from frf_transportistas where transporte_t = transporte_sc ) transportista, ');
    SQL.Add('         sum(n_palets_sl) palets ');

    SQL.Add('  from frf_salidas_servicios_venta, frf_salidas_c, frf_Salidas_l ');

    SQL.Add('  where empresa_ssv = :empresa_sv ');
    SQL.Add('  and servicio_ssv = :servicio_sv ');

    SQL.Add('  and empresa_sc = :empresa_sv ');
    SQL.Add('  and centro_salida_sc = centro_salida_ssv ');
    SQL.Add('  and n_albaran_sc = n_albaran_ssv ');
    SQL.Add('  and fecha_sc = fecha_ssv ');

    SQL.Add('  and empresa_sl = :empresa_sv ');
    SQL.Add('  and centro_salida_sl = centro_salida_ssv ');
    SQL.Add('  and n_albaran_sl = n_albaran_ssv ');
    SQL.Add('  and fecha_sl = fecha_ssv ');

    SQL.Add('  group by 1,2,3,4,5,6 ');
    SQL.Add('  order by 1,2 ');
  end;

  with QNumPalets do
  begin
    SQL.Clear;
    SQL.Add(' select sum(n_palets_sl) palets ');
    SQL.Add(' from frf_salidas_servicios_venta, frf_Salidas_l ');
    SQL.Add(' where empresa_ssv = :empresa_sv ');
    SQL.Add('  and servicio_ssv = :servicio_sv ');
    SQL.Add('  and empresa_sl = :empresa_sv ');
    SQL.Add('  and centro_salida_sl = centro_salida_ssv ');
    SQL.Add('  and n_albaran_sl = n_albaran_ssv ');
    SQL.Add('  and fecha_sl = fecha_ssv ');
  end;

  with QGastos do
  begin
    SQL.Clear;
    SQL.Add(' select tipo_gsv Tipo, ref_fac_gsv factura, fecha_fac_gsv fecha, ');
    SQL.Add('        producto_gsv Producto, importe_gsv Importe ');
    SQL.Add(' from frf_gastos_servicios_venta ');
    SQL.Add(' where empresa_gsv = :empresa_sv ');
    SQL.Add(' and servicio_gsv = :servicio_sv ');
    SQL.Add(' order by tipo_gsv, producto_gsv ');
    Prepare;
  end;

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;

     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_sv.Tag := kEmpresa;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnBrowse := AntesDeLocalizar;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;

     //Focos
  {+}FocoAltas := empresa_sv;
  {+}FocoModificar := observaciones_sv;
  {+}FocoLocalizar := empresa_sv;

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


procedure TFMServicioVenta.FormActivate(Sender: TObject);
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


procedure TFMServicioVenta.FormDeactivate(Sender: TObject);
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

procedure TFMServicioVenta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with QSalidas do
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

procedure TFMServicioVenta.FormKeyDown(Sender: TObject; var Key: Word;
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
        if not observaciones_sv.Focused then
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

procedure TFMServicioVenta.Filtro;
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

procedure TFMServicioVenta.AnyadirRegistro;
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

procedure TFMServicioVenta.ValidarEntradaMaestro;
var
  dFecha: TDateTime;
begin
  if stempresa_sv.Caption = '' then
  begin
    raise Exception.Create('Falta el código de la empresa o es incorrecto.');
  end;
  if Trim(matricula_sv.Text) = '' then
  begin
    raise Exception.Create('Falta la matricula del vehículo.');
  end;
  if not tryStrToDate( fecha_sv.Text, dFecha ) then
  begin
    raise Exception.Create('Falta la fecha del servicio o es incorrecta.');
  end;
  if Estado = teAlta then
    QServicios.FieldByName('servicio_sv').AsInteger:= GetNumServicio( QServicios.FieldByName('empresa_sv').AsString );
end;

procedure TFMServicioVenta.Previsualizar;
var
  QRServicioVenta: TQRServicioVenta;
begin
  //Crear el listado
  if not QServicios.IsEmpty then
  try
    QRServicioVenta:= TQRServicioVenta.Create(Application);
    try
      QRServicioVenta.QServicios.SQL.Clear;
      QRServicioVenta.QServicios.SQL.AddStrings(QServicios.SQL);
      QRServicioVenta.QServicios.Open;

      PonLogoGrupoBonnysa(QRServicioVenta);
      Preview(QRServicioVenta);
    except
      FreeAndNil(QRServicioVenta);
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

procedure TFMServicioVenta.ARejillaFlotanteExecute(Sender: TObject);
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBempresa_sv);
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

procedure TFMServicioVenta.AntesDeLocalizar;
begin
  servicio_sv.Enabled:= true;
  status_sv.Enabled:= true;
  PInferior.Enabled:= false;
end;

procedure TFMServicioVenta.AntesDeInsertar;
begin
  empresa_sv.Text:= gsDefEmpresa;
  fecha_sv.Text:= DateToStr( Date );

  servicio_sv.Enabled:= False;
  status_sv.Enabled:= False;
  PInferior.Enabled:= false;
end;

procedure TFMServicioVenta.AntesDeModificar;
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

  servicio_sv.Enabled:= False;
  status_sv.Enabled:= False;
  PInferior.Enabled:= false;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprovechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMServicioVenta.AntesDeVisualizar;
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

  servicio_sv.Enabled:= True;
  status_sv.Enabled:= True;
  PInferior.Enabled:= True;
end;


procedure TFMServicioVenta.RequiredTime(Sender: TObject;
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

procedure TFMServicioVenta.empresa_svChange(Sender: TObject);
begin
  stempresa_sv.Caption := desEmpresa(empresa_sv.Text);
end;

function  TFMServicioVenta.GetNumServicio( const AEmpresa: string ): integer;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(max(servicio_sv),0) + 1 num_servicio ');
    SQL.Add(' from frf_servicios_venta ');
    SQL.Add(' where empresa_sv = :empresa ');
    ParamByName('empresa').AsString:= AEmpresa;
    Open;
    result:= FieldByName('num_servicio').AsInteger;
    Close;
  end;
end;

procedure TFMServicioVenta.btnGastosClick(Sender: TObject);
begin
  if not MantenimientoGastos then
  begin
      ShowMessage('Debe tener una compra seleccionada y en modo de visualización.');
  end;
end;

procedure TFMServicioVenta.btnSalidasClick(Sender: TObject);
begin
  //ShowMessage('Programa en desarrollo.');
  if not Mantenimientosalidas then
  begin
    ShowMessage('Debe tener una compra seleccionada y en modo de visualización.');
  end;
end;

function TFMServicioVenta.MantenimientoGastos: boolean;
begin
  result:= false;
  if ( Estado = teConjuntoResultado ) and ( not DSMaestro.DataSet.IsEmpty )  then
  begin
    FMGastosServicioVenta := TFMGastosServicioVenta.Create(Self);
    try
      FMGastosServicioVenta.CargaParametros( empresa_sv.Text, StrToIntDef( servicio_sv.Text, 0), StrToDateDef( fecha_sv.Text, Date ) );
      FMGastosServicioVenta.ShowModal;
      if FMGastosServicioVenta.GastosModificados and ( QServicios.FieldByName('status_sv').AsInteger = 2 ) then
      begin
        QServicios.Edit;
        QServicios.FieldByName('status_sv').AsInteger:= 1;
        QServicios.Post;
      end;
      EstadoBotones( 1 );
      QGastos.Close;
      QGastos.Open;
      result:= True;
    finally
      FreeAndNil(FMGastosServicioVenta);
    end;
  end;
end;

function TFMServicioVenta.MantenimientoSalidas: boolean;
begin
  result:= false;
  if ( Estado = teConjuntoResultado ) and ( not DSMaestro.DataSet.IsEmpty ) then
  begin
    FMSalidasServiciosVenta := TFMSalidasServiciosVenta.Create(Self);
    try
      FMSalidasServiciosVenta.CargaParametros( empresa_sv.Text, StrToIntDef( servicio_sv.Text, 0),
                                         StrToDateDef( fecha_sv.Text, Date ), matricula_sv.Text );
      FMSalidasServiciosVenta.ShowModal;
      if FMSalidasServiciosVenta.GastosModificados and ( QServicios.FieldByName('status_sv').AsInteger = 2 ) then
      begin
        QServicios.Edit;
        QServicios.FieldByName('status_sv').AsInteger:= 1;
        QServicios.Post;
      end;
      EstadoBotones( 1 );
      QSalidas.Close;
      QSalidas.Open;
      QNumPalets.Close;
      QNumPalets.Open;
      result:= True;
    finally
      FreeAndNil(FMSalidasServiciosVenta);
    end;
  end;
end;

procedure TFMServicioVenta.QServiciosAfterOpen(DataSet: TDataSet);
begin
  QSalidas.Open;
  QGastos.Open;
  QNumPalets.Open;
end;

procedure TFMServicioVenta.QServiciosBeforeClose(DataSet: TDataSet);
begin
  QSalidas.Close;
  QGastos.Close;
  QNumPalets.Close;
end;

function UnidadDist: string;
begin
  result:= '';
  InputQuery('REPERCUTIR GASTOS POR ',
             'K -> Kilos ' + #13 + #10 + 
             'Vacio o otro valor -> Unidad grabada en tipo gastos ', result );
  Result:= UpperCase( Result );
  if ( Result <> 'K' ) then
    Result:= '';
end;

procedure TFMServicioVenta.btnAsignarClick(Sender: TObject);
var
  sAux: string;
begin
  if QServicios.FieldByName('status_sv').AsInteger <> 2 then
  begin
    if not QServicios.IsEmpty and ( QServicios.State = dsBrowse ) then
    begin
      DAsignarGastosServicioVenta:= TDAsignarGastosServicioVenta.Create( self );
      try
        if DAsignarGastosServicioVenta.RepercutirGastosServicio( empresa_sv.Text, StrToInt( servicio_Sv.Text ),
                                                                 UnidadDist, False, sAux ) then
        begin
          QServicios.Edit;
          QServicios.FieldByName('status_sv').AsInteger:= 2;
          QServicios.Post;
          EstadoBotones( 2 );
        end;
        ShowMessage( sAux );
      finally
        FreeAndNil( DAsignarGastosServicioVenta );
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

procedure TFMServicioVenta.EstadoBotones( const AValor: integer );
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

procedure TFMServicioVenta.status_svChange(Sender: TObject);
begin
  if status_sv.Text = '0' then
  begin
    stStaus.Caption:= 'NUEVO, GASTOS PENDIENTES ASIGNAR';
  end
  else
  if status_sv.Text = '1' then
  begin
    stStaus.Caption:= 'MODIFICADO, REASIGNAR GASTOS PENDIENTE';
  end
  else
  if status_sv.Text = '2' then
  begin
    stStaus.Caption:= 'GASTOS ASIGNADOS';
  end
  else
  begin
    stStaus.Caption:= '';
  end;
end;

end.
