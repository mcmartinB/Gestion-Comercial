unit MFederacionSalidas;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, Db, ExtCtrls,
  StdCtrls, Mask, DBCtrls, CMaestro, Buttons, ActnList, BSpeedButton, Grids,
  DBGrids, BGridButton, BGrid, BDEdit, ComCtrls, BEdit, dbTables, Menus,
  BCalendarButton, BCalendario;

type
  TFMFederacionSalidas = class(TMaestro)
    PMaestro: TPanel;
    Query: TQuery;
    DSQuery: TDataSource;
    eFechaDesde: TBEdit;
    eEmpresa: TBEdit;
    eProducto: TBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblEmpresa: TLabel;
    lblProducto: TLabel;
    Label4: TLabel;
    eFechaHasta: TBEdit;
    PBotonera: TPanel;
    btnSinAsignar: TSpeedButton;
    btnAsignada: TSpeedButton;
    btnTodos: TSpeedButton;
    Panel1: TPanel;
    btnRefrescar: TButton;
    BCBDesde: TBCalendarButton;
    BCBHasta: TBCalendarButton;
    CalendarioFlotante: TBCalendario;
    PanelTotales: TPanel;
    DBGrid: TDBGrid;
    lbxLeyenda: TListBox;
    lbxKilosTotales: TListBox;
    QTotalesFederacion: TQuery;
    Label5: TLabel;
    eCentro: TBEdit;
    lblCentro: TLabel;
    rbExporta: TRadioButton;
    rbNacional: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure DBGridColEnter(Sender: TObject);
    procedure eEmpresaChange(Sender: TObject);
    procedure eProductoChange(Sender: TObject);
    procedure QueryBeforePost(DataSet: TDataSet);
    procedure btnSinAsignarClick(Sender: TObject);
    procedure btnAsignadaClick(Sender: TObject);
    procedure btnTodosClick(Sender: TObject);
    procedure btnRefrescarClick(Sender: TObject);
    procedure DBGridTitleClick(Column: TColumn);
    procedure eFechaDesdeChange(Sender: TObject);
    procedure BCBDesdeClick(Sender: TObject);
    procedure QueryAfterPost(DataSet: TDataSet);
    procedure eCentroChange(Sender: TObject);
  private
    procedure ListarFederacionesGrid;

    procedure SinAsignar;
    procedure Asignados;
    procedure Todos;
    procedure TotalKilos;

  public
    { Public declarations }
    bakEmpresa, bakCentro, bakProducto, bakFechaDesde, bakFechaHasta: string;
    sAlbaran, sCliente, sVehiculo: string;

    procedure Localizar; override;
    procedure Visualizar; override;
    procedure CancelarLocalizar; override;

    procedure Filtro; override;
    procedure NewFiltro( const ANacional: Boolean );

    procedure Previsualizar; override;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, UDMAuxDB, CAuxiliarDB,
     Principal, DError, DPreview, bTimeUtils, DateUtils, DLAsignacionFederaciones;

{$R *.DFM}



procedure TFMFederacionSalidas.ListarFederacionesGrid;
begin
  //La fecha mas pequeña para todos los centros
  ConsultaPrepara(DMAuxDB.Qaux,
    ' Select codigo_f ' +
    ' from frf_federaciones ' +
    ' order by codigo_f ');
  with DMAuxDB.Qaux do
  begin
    ConsultaOpen(DMAuxDB.Qaux, False);
    DBGrid.Columns[7].PickList.Clear;
    while not EOF do
    begin
      DBGrid.Columns[7].PickList.Add(FieldByName('codigo_f').AsString);
      Next;
    end;
    Cancel;
    Close;
  end;
end;


procedure TFMFederacionSalidas.Visualizar;
begin
  inherited;
  if TForm(DBGrid.Owner).Visible = true then
    if Assigned(DBGrid) then
      if DBGrid.CanFocus then
        DBGrid.SetFocus;
  TotalKilos;
end;

procedure TFMFederacionSalidas.Localizar;
var
  dFecha: TDateTime;
begin
  bakEmpresa := eEmpresa.text;
  bakCentro := eCentro.text;
  bakProducto := eProducto.text;
  bakFechaDesde := eFechaDesde.text;
  bakFechaHasta := eFechaHasta.text;

  eEmpresa.text := '050';
  eProducto.text := 'TOM';
  eCentro.text := '1';

  dFEcha:= LunesAnterior( Date );
  eFechaDesde.text := DateToStr( dFecha - 7 );
  eFechaHasta.text := DateToStr( dFecha - 1 );;

  inherited;
end;

procedure TFMFederacionSalidas.CancelarLocalizar;
begin
  eEmpresa.text := bakEmpresa;
  eCentro.text := bakCentro;
  eProducto.text := bakProducto;
  efechaDesde.text := bakFechaDesde;
  efechaHasta.text := bakFechaHasta;

  inherited;
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMFederacionSalidas.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;

  btnAltasActive := False;
  btnModificarActive := False;
  btnBorrarActive := False;

     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := Query;

     //Añadir lista de federaciones existentes a la columna
     //federacion del grid
  ListarFederacionesGrid;

     //CREAR TABLA TEMPORAL
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' CREATE TEMP TABLE tmp_asignar_fede ( ' +
      '  origen CHAR(1), ' +
      '  salida CHAR(1), ' +
      '  fecha DATE, ' +
      '  referencia INTEGER, ' +
               // Indicamos si proviene de una salida o de un transito
      '  tipo CHAR(1) DEFAULT "S" CHECK ((tipo = "S" ) OR (tipo = "T" )), ' +
      '  cliente CHAR(3), ' +
      '  desCliente CHAR(30), ' +
      '  vehiculo CHAR(20), ' +
      '  federacion CHAR(1), ' +
      '  kilos DECIMAL(10,2), ' +
               // Indicamos si mostramos o no el registro
      '  ver CHAR(1) DEFAULT "N" CHECK ((ver = "S" ) OR (ver = "N" )),' +
      '  pais char(2) ) ');
    ExecSQl;
  end;

  with QTotalesFederacion do
  begin
    SQL.Clear;
    (*TODO*)
    (* Unir "" con NULL en una sola linea *)
    SQL.Add(' select nvl(federacion,0) federacion, sum(kilos) kilos ');
    SQL.Add(' from tmp_asignar_fede ');
    SQL.Add(' group by 1 ');
    SQL.Add(' order by 1 ');
    Prepare;
  end;

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM tmp_asignar_fede ';
 {+}where := ' ';
 {+}Order := ' ORDER BY fecha DESC, tipo, referencia';

  try
    Query.SQL.Text := Select + Order;
    Query.Open;
  except
  end;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;

  Visualizar;

     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(pcNulo);

     //Focos
 {+}(* FocoAltas:=empresa_b;
{+}   FocoModificar:=descripcion_b;*)
  {+}FocoLocalizar := eCentro;

  lblEmpresa.Caption := '';
  lblProducto.Caption := '';
  lblCentro.Caption := '';

  sAlbaran := '';
  sCliente := '';
  sVehiculo := '';

  CalendarioFlotante.Date := Date;
  gRF := NIL;
  gCF := CalendarioFlotante;

  //Rellenar lisbox Leyenda
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('Select * from frf_federaciones order by codigo_f');
    Open;
    lbxLeyenda.Items.Add( 'FEDERACIONES ');
    lbxLeyenda.Items.Add( '---------------------- ');
    While not eof do
    begin
      lbxLeyenda.Items.Add( FieldByname('codigo_f').AsString + ' - ' + FieldByname('provincia_f').AsString);
      Next;
    end;
    Close;
  end;
  TotalKilos;
end;


procedure TFMFederacionSalidas.TotalKilos;
var
  rAcum: Real;
begin
  //Rellenar lisbox Leyenda
  lbxKilosTotales.Clear;
  rAcum:= 0;
  with QTotalesFederacion do
  begin
    Open;
    lbxKilosTotales.Items.Add( 'TOTALES FEDERACIONES ');
    lbxKilosTotales.Items.Add( '---------------------------- ');
    While not eof do
    begin
      rAcum:= rAcum + FieldByname('kilos').AsFloat;
      if FieldByname('federacion').AsString = '' then
        lbxKilosTotales.Items.Add( '0 -> ' + FormatFloat( '#,##0.00', FieldByname('kilos').AsFloat ) )
      else
        lbxKilosTotales.Items.Add( FieldByname('federacion').AsString + ' -> ' + FormatFloat( '#,##0.00', FieldByname('kilos').AsFloat ) );
      Next;
    end;
    lbxKilosTotales.Items.Add( '---------------------------- ');
    lbxKilosTotales.Items.Add( 'TOTAL -> ' + FormatFloat( '#,##0.00', rAcum ) );
    Close;
  end;
end;

{+ CUIDADIN }

procedure TFMFederacionSalidas.FormActivate(Sender: TObject);
begin
  Top := 1;
  //Formulario activo
  M := self;
  MD := nil;

  //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
  gRF := nil;
  gcf := nil;

   //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;


procedure TFMFederacionSalidas.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gcf := nil;
end;

procedure TFMFederacionSalidas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   //Cierra query
  Query.Close;

   //DESTRUIR TABLA TEMPORAL
  if QTotalesFederacion.Prepared then
    QTotalesFederacion.UnPrepare;
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' DROP TABLE tmp_asignar_fede  ');
    ExecSQl;
  end;

   //Variables globales
  btnAltasActive := True;
  btnModificarActive := True;
  btnBorrarActive := True;

   //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

   // Cambia acción por defecto para Form hijas en una aplicación MDI
   // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;

  gRF := NIL;
  gCF := nil;
end;

procedure TFMFederacionSalidas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  case key of
    vk_Return, vk_down:
      begin
        if Estado <> teLocalizar then exit;
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        if Estado <> teLocalizar then exit;
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
  end;
end;


procedure TFMFederacionSalidas.Filtro;
begin
  NewFiltro( rbNacional.Checked );
end;

procedure TFMFederacionSalidas.NewFiltro( const ANacional: Boolean );
var
  dFechaIni, dFechaFin: TDateTime;
begin
  //QUE NO HALLA CAMPOS VACIOS
  if eEmpresa.Text = '' then
  begin
    eEmpresa.SetFocus;
    raise Exception.Create('Falta el código de la empresa ...');
  end;

  if eCentro.Text = '' then
  begin
    eCentro.SetFocus;
    raise Exception.Create('Falta el código del centro ...');
  end;

  if eProducto.Text = '' then
  begin
    eProducto.SetFocus;
    raise Exception.Create('Falta el código del producto ...');
  end;

  if not TryStrToDate( efechaDesde.Text, dFechaIni ) then
  begin
    efechaDesde.SetFocus;
    raise Exception.Create('Fecha de inicio incorrecta ...');
  end;

  if not TryStrToDate( efechaHasta.Text, dFechaFin ) then
  begin
    efechaHasta.SetFocus;
    raise Exception.Create('Fecha de inicio incorrecta ...');
  end;

  //INSERTAR DATOS TABLA PRINCIPAL
  with DMAuxDB.QAux do
  begin
    //LIMPIAR TABLA TEMPORAL
    SQL.Clear;
    SQL.Add(' DELETE FROM tmp_asignar_fede WHERE 1 = 1 ');
    ExecSQl;

    //INSERTAR SALIDAS
    SQL.Clear;
    SQL.Add(' insert into tmp_asignar_fede ' +
      ' (fecha, referencia, cliente, desCliente, origen, salida, ' +
      '  federacion, kilos, vehiculo, ver  ) ' +

      ' select fecha_sl, n_albaran_sl, cliente_sl, nombre_c, ' +
      '        centro_origen_sl, centro_salida_sl, federacion_sl, ' +
      '        sum(kilos_sl), vehiculo_sc, ' +
      '        case when (federacion_sl is null or federacion_sl = "") ' +
      '             then "N" else "S" end ' +

      ' from frf_salidas_c, frf_salidas_l, frf_clientes   ' +

      ' where empresa_sc = :empresa ' +
      '   and fecha_sc between :inicio and :fin ' +
      '   and   centro_salida_sc = :centro ' +
      '   and cliente_sal_sc = cliente_c ' +

      '   and empresa_sl = :empresa ' +
      '   and centro_salida_sl = centro_salida_sc ' +
      '   and fecha_sl = fecha_sc ' +
      '   and n_albaran_sl = n_albaran_sc ' +
      '   and producto_sl = :producto ');

      //QUE EL CLIENTE SEA EXTRANJERO
    if ANacional then
      SQL.Add('    and nvl(pais_c,''ES'') = ''ES'' ' )
    else
      SQL.Add('    and nvl(pais_c,''ES'') <> ''ES'' ' );

      //SALIDAS DIRECTAS
    SQL.Add('    and nvl(ref_transitos_sl, '''') = '''' ' +
      '   and nvl(es_transito_sc,0) = 0 ' +
      //QHE LA FRUTA NO SEA DE TENERIFE
      '   and centro_origen_sl = :centro ' +

      ' group by 1,2,3,4,5,6,7,9 ');

    ParamByName('empresa').AsString := eEmpresa.Text;
    ParamByName('producto').AsString := eProducto.Text;
    ParamByName('centro').AsString := eCentro.Text;
    //ParamByName('inicio').ASDateTime := StrToDate(efechaDesde.Text);
    //ParamByName('fin').ASDateTime := ParamByName('inicio').ASDateTime + 6;
    ParamByName('inicio').ASDateTime := dFechaIni;
    ParamByName('fin').ASDateTime := dFechaFin;
    ExecSQl;

    //INSERTAR TRANSITOS AL EXTRANJERO
    SQL.Clear;
    SQL.Add(' insert into tmp_asignar_fede ');
    SQL.Add(' (fecha, referencia, cliente, desCliente, origen, salida, ');
    SQL.Add('  federacion, kilos, vehiculo, ver, tipo )');

    SQL.Add(' select fecha_tl, referencia_tl, ');
    SQL.Add('   (select centro_c ');
    SQL.Add('   from frf_centros ');
    SQL.Add('   where empresa_c = :empresa ');
    SQL.Add('     and centro_c = centro_destino_tl), ');
    SQL.Add('   (select descripcion_c ');
    SQL.Add('   from frf_centros ');
    SQL.Add('   where empresa_c = :empresa ');
    SQL.Add('     and centro_c = centro_destino_tl), ');
    SQL.Add('   centro_origen_tl, centro_tl, federacion_tl, sum(kilos_tl), vehiculo_tc, ');
    SQL.Add('   case when (federacion_tl is null or federacion_tl = "") then "N" else "S" end, ');
    SQL.Add('   "T"');
    SQL.Add(' from frf_transitos_c, frf_transitos_l ');
    SQL.Add(' where empresa_tc = :empresa ');
    SQL.Add(' and   fecha_tc between :inicio and :fin ');
    SQL.Add(' and   centro_tc = :centro ');

    SQL.Add(' and centro_destino_tc in ');
    SQL.Add(' ( ');
    SQL.Add('  select centro_c ');
    SQL.Add('  from frf_centros ');
    SQL.Add('  where empresa_c = :empresa ');
    if ANacional then
      SQL.Add('    and nvl(pais_c,''ES'') = ''ES'' ')
    else
      SQL.Add('    and nvl(pais_c,''ES'') <> ''ES'' ');
    SQL.Add(' ) ');

    SQL.Add(' and empresa_tl = empresa_tc ');
    SQL.Add(' and centro_tl = centro_tc ');
    SQL.Add(' and referencia_tl = referencia_tc ');
    SQL.Add(' and fecha_tl = fecha_tc ');
    SQL.Add(' And producto_tl = :producto ');
    //Transito directo
    SQL.Add('   and nvl(ref_origen_tl,'''') = ''''  ');
    (*PARCHE*)//Que no sea de tenerife
    SQL.Add('   and centro_origen_tl = :centro  ');
    SQL.Add(' group by 1,2,3,4,5,6,7,9,10 ');

    ParamByName('empresa').AsString := eEmpresa.Text;
    ParamByName('producto').AsString := eProducto.Text;
    ParamByName('centro').AsString := eCentro.Text;
    //ParamByName('inicio').ASDateTime := StrToDate(efechaDesde.Text);
    //ParamByName('fin').ASDateTime := ParamByName('inicio').ASDateTime + 6;
    ParamByName('inicio').ASDateTime := dFechaIni;
    ParamByName('fin').ASDateTime := dFechaFin;
    ExecSQl;

  end;

  if btnSinAsignar.Down then
    SinAsignar
  else if btnAsignada.Down then
    Asignados
  else if btnTodos.Down then
    Todos;
end;


procedure TFMFederacionSalidas.SinAsignar;
begin
  Query.Filter := 'ver = ' + QuotedStr('N');
end;

procedure TFMFederacionSalidas.Asignados;
begin
  Query.Filter :=  'ver = ' + QuotedStr('S');
end;

procedure TFMFederacionSalidas.Todos;
begin
  Query.Filter := '';
end;

procedure TFMFederacionSalidas.DBGridColEnter(Sender: TObject);
begin
  //Sólo dejamos movernos por la columna editable
  if DBGrid.SelectedIndex <> 7 then
    DBGrid.SelectedIndex := 7;
end;

procedure TFMFederacionSalidas.eEmpresaChange(Sender: TObject);
begin
  lblEmpresa.Caption := desEmpresa(eEmpresa.Text);
end;

procedure TFMFederacionSalidas.eCentroChange(Sender: TObject);
begin
  lblCentro.Caption := desCentro(eEmpresa.Text, eCentro.Text);
end;

procedure TFMFederacionSalidas.eProductoChange(Sender: TObject);
begin
  lblProducto.Caption := desProducto(eEmpresa.Text, eProducto.Text);
end;

procedure TFMFederacionSalidas.QueryBeforePost(DataSet: TDataSet);
begin
  //Actualizar salida
  with DMAuxDB.QAux do
  begin
    if (DataSet.fieldbyname('federacion').AsString = '') or
      (DataSet.fieldbyname('federacion').AsString = ' ') then
    begin
      if DataSet.fieldbyname('tipo').AsString = 'S' then
      begin
        //Salida
        SQL.Clear;
        SQL.Add(' update frf_salidas_l ' +
          ' set federacion_sl = NULL ' +
          ' where empresa_sl = :empresa ' +
          '   and centro_salida_sl = :salida ' +
          '   and centro_origen_sl = :origen ' +
          '   and n_albaran_sl = :referencia ' +
          '   and fecha_sl = :fecha ' +
          '   and producto_sl = :producto ');
        SQL.Add('   and nvl(ref_transitos_sl,'''') = ''''  ');
      end
      else
      begin
        //Transito
        SQL.Clear;
        SQL.Add(' update frf_transitos_l ' +
          ' set federacion_tl = NULL ' +
          ' where empresa_tl = :empresa' +
          '   and centro_tl = :salida' +
          '   and centro_origen_tl = :origen' +
          '   and referencia_tl = :referencia' +
          '   and fecha_tl = :fecha' +
          '   and producto_tl = :producto');
        SQL.Add('   and nvl(ref_origen_tl,'''') = ''''  ');
      end;
    end
    else
    begin
      if DataSet.fieldbyname('tipo').AsString = 'S' then
      begin
        //Salida
        SQL.Clear;
        SQL.Add(' update frf_salidas_l ' +
          ' set federacion_sl = ' + QuotedStr(DataSet.fieldbyname('federacion').AsString) +
          ' where empresa_sl = :empresa ' +
          '   and centro_salida_sl = :salida ' +
          '   and centro_origen_sl = :origen ' +
          '   and n_albaran_sl = :referencia ' +
          '   and fecha_sl = :fecha ' +
          '   and producto_sl = :producto ');
        SQL.Add('   and nvl(ref_transitos_sl,'''') = ''''  ');
      end
      else
      begin
        //Transito
        SQL.Clear;
        SQL.Add(' update frf_transitos_l ' +
          ' set federacion_tl = ' + QuotedStr(DataSet.fieldbyname('federacion').AsString) +
          ' where empresa_tl = :empresa' +
          '   and centro_tl = :salida' +
          '   and centro_origen_tl = :origen' +
          '   and referencia_tl = :referencia' +
          '   and fecha_tl = :fecha' +
          '   and producto_tl = :producto');
        SQL.Add('   and nvl(ref_origen_tl,'''') = ''''  ');
      end;
    end;

    ParamByName('empresa').AsString := eEmpresa.text;
    ParamByName('salida').AsString := DataSet.fieldbyname('salida').AsString;
    ParamByName('origen').AsString := DataSet.fieldbyname('origen').AsString;
    ParamByName('referencia').AsString := DataSet.fieldbyname('referencia').AsString;
    ParamByName('fecha').AsDateTime := DataSet.fieldbyname('fecha').AsDateTime;
    ParamByName('producto').AsString := eProducto.text;

    try
      ExecSQL;
    except
      ShowError(' Problemas al actualizar la federación de la Base de Datos ... ');
      Abort;
    end;
  end;
end;

procedure TFMFederacionSalidas.btnSinAsignarClick(Sender: TObject);
begin
  SinAsignar;
end;

procedure TFMFederacionSalidas.btnAsignadaClick(Sender: TObject);
begin
  Asignados;
end;

procedure TFMFederacionSalidas.btnTodosClick(Sender: TObject);
begin
  Todos;
end;

procedure TFMFederacionSalidas.btnRefrescarClick(Sender: TObject);
begin
  if ( eEmpresa.Text <> '' ) and ( Query.state = dsBrowse ) then
  begin
    ActiveControl := nil;
    if Query.Active then
    begin
      Query.DisableControls;
      Filtro;
      Query.Close;
      Query.Open;
      Query.EnableControls;
      TotalKilos;
    end;
  end;
end;

procedure TFMFederacionSalidas.DBGridTitleClick(Column: TColumn);
begin
  //ORDENAR POR
  if Pos(UpperCase(Column.FieldName), UpperCase(order)) <> 0 then
  begin
    //Comparamos los ultimos 4 caracteres de filtro para saber si ordenamos
    //de forma ascendente o descendente
    if 'DESC' = UpperCase(copy(trim(order), length(Trim(order)) - 3, 4)) then
    begin
      Order := ' ORDER BY ' + Column.FieldName;
    end
    else
    begin
      Order := ' ORDER BY ' + Column.FieldName + ' DESC';
    end;
  end
  else
  begin
    Order := ' ORDER BY ' + Column.FieldName;
  end;
  try
    Query.DisableControls;
    Query.Close;
    Query.SQL.Text := Select + Order;
    Query.Open;
    Query.EnableControls;
  except
  end;
end;

procedure TFMFederacionSalidas.eFechaDesdeChange(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if TryStrToDate( eFechaDesde.Text, dFecha ) then
  begin
    eFechaHasta.Text:= DateToStr( dFecha + 6 );
  end;
end;

procedure TFMFederacionSalidas.BCBDesdeClick(Sender: TObject);
begin
  if eFechaDesde.Focused then
    DespliegaCalendario(BCBDesde)
  else
    DespliegaCalendario(BCBDesde);
end;

procedure TFMFederacionSalidas.QueryAfterPost(DataSet: TDataSet);
begin
  TotalKilos;
end;

procedure TFMFederacionSalidas.Previsualizar;
begin
  if not Query.IsEmpty then
  begin
    DMLAsignacionFederaciones:= TDMLAsignacionFederaciones.Create( self );
    try
      DMLAsignacionFederaciones.ListadoAsignacionFederaciones(
        eEmpresa.Text, eCentro.Text, eProducto.Text, StrToDate(eFechaDesde.Text), StrToDate(eFechaHasta.Text), rbNacional.Checked );
    finally
      FreeAndNil( DMLAsignacionFederaciones );
    end
  end;
end;

end.
