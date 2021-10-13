unit MEscandallo;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, Db, ExtCtrls,
  StdCtrls, Mask, DBCtrls, CMaestro, Buttons, ActnList, BSpeedButton, Grids,
  DBGrids, BGridButton, BGrid, BDEdit, ComCtrls, BEdit, dbTables,
  BCalendario, BCalendarButton, nbEdits, nbCombos;

type
  TFMEscandallo = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    Label13: TLabel;
    fecha_e: TBDEdit;
    LAno_semana_p: TLabel;
    Label5: TLabel;
    empresa_e: TBDEdit;
    Bevel1: TBevel;
    btgEmpresa: TBGridButton;
    RejillaFlotante: TBGrid;
    QEscandalloMaster: TQuery;
    empresa_des: TLabel;
    Label1: TLabel;
    centro_e: TBDEdit;
    btgCentro: TBGridButton;
    centro_des: TLabel;
    Bevel2: TBevel;
    Label4: TLabel;
    producto_e: TBDEdit;
    btgProducto: TBGridButton;
    producto_des: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label7: TLabel;
    btgCosechero: TBGridButton;
    cosechero_des: TLabel;
    cosechero_e: TBDEdit;
    Label9: TLabel;
    plantacion_e: TBDEdit;
    btgPlantacion: TBGridButton;
    plantacion_des: TLabel;
    Bevel5: TBevel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    porcen_primera_e: TBDEdit;
    LEmpresa_p: TLabel;
    porcen_segunda_e: TBDEdit;
    Label11: TLabel;
    porcen_tercera_e: TBDEdit;
    DBGrid1: TDBGrid;
    CalendarioFlotante: TBCalendario;
    btcFecha: TBCalendarButton;
    Label3: TLabel;
    numero_entrada_e: TBDEdit;
    QEscandalloMasterempresa_e: TStringField;
    QEscandalloMastercentro_e: TStringField;
    QEscandalloMasternumero_entrada_e: TIntegerField;
    QEscandalloMastercosechero_e: TSmallintField;
    QEscandalloMasterplantacion_e: TSmallintField;
    QEscandalloMasteranyo_semana_e: TStringField;
    QEscandalloMasterproducto_e: TStringField;
    QEscandalloMasterporcen_primera_e: TFloatField;
    QEscandalloMasterporcen_segunda_e: TFloatField;
    QEscandalloMasterporcen_tercera_e: TFloatField;
    QEscandalloMasterporcen_destrio_e: TFloatField;
    DSRejilla: TDataSource;
    QEscandalloMasterdes_plantacion_e: TStringField;
    QAnyoSemana: TQuery;
    lblNombre1: TLabel;
    tipo_entrada_e: TnbDBSQLCombo;
    stTipoEntrada: TStaticText;
    QEscandalloMastertipo_entrada_e: TIntegerField;
    lblNombre2: TLabel;
    lblKilosPrimera: TLabel;
    lblNombre4: TLabel;
    lblKilosSegunda: TLabel;
    lblNombre6: TLabel;
    lblKilosTercera: TLabel;
    Bevel6: TBevel;
    lblNombre3: TLabel;
    QKilosEntrada: TQuery;
    lblKilosTotales_: TLabel;
    lblKilosTotales: TLabel;
    lblDestrio: TLabel;
    porcen_destrio_e: TBDEdit;
    lblDestrioDes: TLabel;
    lblKilosDestrio: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure DSMaestroDataChange(Sender: TObject; Field: TField);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure QEscandalloMasterCalcFields(DataSet: TDataSet);
    function tipo_entrada_eGetSQL: String;
    procedure tipo_entrada_eChange(Sender: TObject);
    procedure numero_entrada_eChange(Sender: TObject);
  private
    { Private declarations }

    Fecha_e2l_aux_field: TDateField;

    Lista: TList;
    Objeto: TObject;

    sEmpresa, sCentro, sProducto, sFecha: string;
    sTipoEntrada, sCosechero, sPlantacion, sPrimera, sSegunda, sTercera, sDestrio: string;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;
    procedure Plantaciones(empresa, producto, cosechero, fecha: string);
    function  KilosProducto( var AKilos: real ): boolean;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;
    procedure CancelarAlta; override;

    procedure AntesDeModificar;
    procedure AntesDeInsertar;
    procedure AntesDeBorrar;
    procedure AntesDeLocalizar;    
    procedure AntesDeVisualizar;

    procedure ComprobarFechaLiquidacion;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, UDMAuxDB, CReportes,
  CAuxiliarDB, Principal, DError, DPreview, bSQLUtils,
  LEscandallo, Escandallo, UDMConfig;

{$R *.DFM}

procedure TFMEscandallo.AbrirTablas;
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
     //Estado inicial
  Registros := 0;
  if registros > 0 then
    Registro := 1
  else
    Registro := 0;
  RegistrosInsertados := 0;
end;

procedure TFMEscandallo.CerrarTablas;
begin
     // Cerrar tabla
  if DataSetMaestro.Active then DataSetMaestro.Close;
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMEscandallo.FormCreate(Sender: TObject);
begin
  with QKilosEntrada do
  begin
    SQL.Clear;
    SQL.Add( 'select total_kgs_e2l kilos ');
    SQL.Add( 'from frf_entradas2_l ');
    SQL.Add( 'where empresa_e2l = :empresa_e ');
    SQL.Add( '  and centro_e2l = :centro_e ');
    SQL.Add( '  and numero_entrada_e2l = :numero_entrada_e ');
    SQL.Add( '  and fecha_e2l = :fecha_e ');
    SQL.Add( '  and cosechero_e2l = :cosechero_e ');
    SQL.Add( '  and plantacion_e2l = :plantacion_e ');
    SQL.Add( '  and ano_sem_planta_e2l = :anyo_semana_e ');
    Prepare;
  end;

  with QAnyoSemana do
  begin
    SQL.Clear;
    SQL.Add( 'select ano_sem_planta_e2l ');
    SQL.Add( 'from frf_entradas2_l ');
    SQL.Add( 'where empresa_e2l = :empresa ');
    SQL.Add( 'and centro_e2l = :centro ');
    SQL.Add( 'and numero_entrada_e2l = :entrada ');
    SQL.Add( 'and fecha_e2l = :fecha ');
    SQL.Add( 'and cosechero_e2l = :cosechero ');
    SQL.Add( 'and plantacion_e2l = :plantacion ');
    SQL.Add( 'and producto_e2l = :producto ');
  end;

  Fecha_e2l_aux_field := TDateField.Create(Self);
  Fecha_e2l_aux_field.FieldName := 'fecha_e';
  Fecha_e2l_aux_field.Name := QEscandalloMaster.Name +
    Fecha_e2l_aux_field.FieldName;
  Fecha_e2l_aux_field.Index := QEscandalloMaster.FieldCount;
  Fecha_e2l_aux_field.DataSet := QEscandalloMaster;
  QEscandalloMaster.FieldDefs.UpDate;

     //Variables globales
  M := Self;
  MD := nil;
  gRF := RejillaFlotante;
  gCF := CalendarioFlotante;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := QEscandalloMaster;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_escandallo ';
 {+}where := ' WHERE empresa_e=' + QUOTEDSTR('###');
 {+}Order := ' ORDER BY empresa_e, centro_e, fecha_e desc, producto_e ';
     //Abrir tablas/Querys
  try
    AbrirTablas;
        //Habilitamos controles de Base de datos
  except
    on e: Exception do
    begin
      ShowError(e);
      Close;
      Exit;
    end;
  end;

     //Lista de componentes
  Lista := TList.Create;
  PMaestro.GetTabOrderList(Lista);

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
  Visualizar;
     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(pcNulo);

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := kNull;
     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_e.Tag := kEmpresa;
  centro_e.Tag := kCentro;
  producto_e.Tag := kProducto;
  cosechero_e.Tag := kCosechero;
  plantacion_e.Tag := kPlantacion;
  tipo_entrada_e.Tag := kTipoEntrada;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnBrowse := AntesDeLocalizar;
  OnView := AntesDeVisualizar;
  OnBeforeMasterDelete:= AntesDeBorrar;
     //Focos
  {+}FocoAltas := empresa_e;
  {+}FocoModificar := porcen_primera_e;
  {+}FocoLocalizar := empresa_e;

  CalendarioFlotante.Date := Date;
end;

{+ CUIDADIN }

procedure TFMEscandallo.FormActivate(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_SHOWNORMAL);
  if not DataSetMaestro.Active then Exit;
     //Formulario activo
  M := self;
  MD := nil;
     //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
  gRF := RejillaFlotante;
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


procedure TFMEscandallo.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF := nil;
end;

procedure TFMEscandallo.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  with QKilosEntrada do
  begin
    if Prepared then
      Unprepare;
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
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF := nil;
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMEscandallo.FormKeyDown(Sender: TObject; var Key: Word;
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
  end;
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

procedure TFMEscandallo.CancelarAlta;
begin
  inherited;
  sEmpresa := '';
  sCentro := '';
  sProducto := '';
  sFecha := '';
  sTipoEntrada:= '';
  sCosechero:= '';
  sPlantacion:= '';
  sPrimera:= '';
  sSegunda:= '';
  sTercera:= '';
  sDestrio:= '';
end;

{+}//Sustituir por funcion generica

procedure TFMEscandallo.Filtro;
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
          if flag then where := where + ' AND ';
          if InputType = itChar then
            where := where + ' ' + Name + ' LIKE ' + SQLFilter(Text)
          else
            where := where + ' ' + Name + ' =' + QUOTEDSTR(Text);
          flag := True;
        end;
      end;
    end;
  end;

  if tipo_entrada_e.Text <> '' then
  begin
    if flag then where := where + ' and ';
    where := where + ' tipo_entrada_e = ' + tipo_entrada_e.Text;
    flag:= True;
  end;

  if flag then where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFMEscandallo.AnyadirRegistro;
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
          if flag then where := where + ' AND ';
          where := where + ' ' + Name + ' =' + QUOTEDSTR(Text);
          flag := True;
        end;
      end;
    end;
  end;
  where := where + ') ';
end;

{+}//Sustituir por funcion generica

procedure TFMEscandallo.ComprobarFechaLiquidacion;
begin
  //lIQUIDACION DEFINITOVA
end;

procedure TFMEscandallo.ValidarEntradaMaestro;
var i: Integer;
  aux: real;
  auxString: string;
begin
  ComprobarFechaLiquidacion;

  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
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

  //Tipo entrada
  if tipo_entrada_e.Text = '' then
  begin
    tipo_entrada_e.Text := '0';
  end
  else
  begin
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add(' select * ');
      SQL.Add(' from frf_entradas_tipo ');
      SQL.Add(' where empresa_et = :empresa ');
      SQL.Add(' and tipo_et = :tipo ');
      ParamByName('empresa').AsString:= empresa_e.Text;
      ParamByName('tipo').AsInteger:= StrToInt( tipo_entrada_e.Text );
      Open;
      if IsEmpty then
      begin
        Close;
        raise Exception.Create('El tipo de entrada no es correcto.');
      end;
      Close;
    end;
  end;

  //la suma de los porcentajes debe ser 100
  aux := 0;
  if Trim(porcen_primera_e.Text) = '' then
    porcen_primera_e.Text := '0';
  aux := aux + StrToFloat(porcen_primera_e.Text);
  if Trim(porcen_segunda_e.Text) = '' then
    porcen_segunda_e.Text := '0';
  aux := aux + StrToFloat(porcen_segunda_e.Text);
  if Trim(porcen_tercera_e.Text) = '' then
    porcen_tercera_e.Text := '0';
  aux := aux + StrToFloat(porcen_tercera_e.Text);
  if Trim(porcen_destrio_e.Text) = '' then
    porcen_destrio_e.Text := '0';
  aux := aux + StrToFloat(porcen_destrio_e.Text);

  auxString := FloatToStr(aux);
  if (auxString <> '100') (*and (auxString <> '0')*) then
  begin
    raise Exception.Create('La suma de los porcentajes debe ser 100.');
  end;

  if tipo_entrada_e.Text = '1'  then
  begin
    //Seleccionado
    if Trunc( StrToFloatDef( porcen_primera_e.Text, 0 ) ) <> 100 then
    begin
      raise Exception.Create('El procentaje de 1ª para el producto seleccionado debe ser del 100%.');
    end;
  end;
  if tipo_entrada_e.Text = '2'  then
  begin
    //Industria
    if Trunc( StrToFloatDef( porcen_tercera_e.Text, 0 ) ) <> 100 then
    begin
      raise Exception.Create('El procentaje de 3ª para el producto industria debe ser del 100%.');
    end;
  end;

  sEmpresa := empresa_e.Text;
  sCentro := centro_e.Text;
  sProducto := producto_e.Text;
  sFecha := fecha_e.Text;
  sTipoEntrada:= tipo_entrada_e.Text;
  sCosechero:= cosechero_e.Text;
  sPlantacion:= plantacion_e.Text;
  sPrimera:= porcen_primera_e.Text;
  sSegunda:= porcen_segunda_e.Text;
  sTercera:= porcen_tercera_e.Text;
  sDestrio:= porcen_destrio_e.Text;

  with QAnyoSemana do
  begin
    ParamByName('empresa').AsString:= empresa_e.Text;
    ParamByName('centro').AsString:= centro_e.Text;
    ParamByName('fecha').AsString:= fecha_e.Text;
    ParamByName('entrada').AsString:= numero_entrada_e.Text;
    ParamByName('cosechero').AsString:= cosechero_e.Text;
    ParamByName('plantacion').AsString:= plantacion_e.Text;
    ParamByName('producto').AsString:= producto_e.Text;
    Open;
    if IsEmpty then
    begin
      Close;
      raise Exception.Create('Error, falta la entrada a la que va asociada el escandallo.');
    end;
    QEscandalloMaster.FieldByName('anyo_semana_e').AsString :=  FieldByName('ano_sem_planta_e2l').AsString;
    Close;
  end;
end;

procedure TFMEscandallo.Previsualizar;
begin
  QRLEscandallo := TQRLEscandallo.Create(Application);
  PonLogoGrupoBonnysa(QRLEscandallo, empresa_e.Text);

  DMBaseDatos.QListado.SQL.Text :=
    ' SELECT empresa_e, centro_e, ' +
    '       numero_entrada_e, fecha_e, tipo_entrada_e, ' +
    '       (SELECT sum(total_kgs_e2l) from frf_entradas2_l ' +
    '        WHERE empresa_e2l = empresa_e and centro_e2l = centro_e ' +
    '          AND numero_entrada_e2l = numero_entrada_e ' +
    '          AND fecha_e2l = fecha_e) kilos, ' +

  '       producto_e, ' +
    '       (SELECT descripcion_p from frf_productos ' +
    '        WHERE producto_p = producto_e) des_producto, ' +

  '       cosechero_e, ' +
    '       (SELECT nombre_c from frf_cosecheros ' +
    '        WHERE empresa_c = empresa_e ' +
    '          AND cosechero_c = cosechero_e) des_cosechero, ' +

  '       plantacion_e, anyo_semana_e, ' +
    '       (SELECT descripcion_p from frf_plantaciones ' +
    '        WHERE ano_semana_p = anyo_semana_e and empresa_p = empresa_e ' +
    '          AND producto_p = producto_e and cosechero_p = cosechero_e ' +
    '          AND plantacion_p = plantacion_e ) des_plantacion, ' +

  '       porcen_primera_e, porcen_segunda_e, porcen_tercera_e, porcen_destrio_e ' +
    ' FROM frf_escandallo ' + where +
    ' ORDER BY empresa_e, centro_e, fecha_e desc, producto_e, cosechero_e, ' +
    '          plantacion_e, numero_entrada_e ';

  try
    DMBaseDatos.QListado.Open;
    Preview(QRLEscandallo);
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
//****************************************************************************

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles
procedure TFMEscandallo.AntesDeBorrar;
begin
  ComprobarFechaLiquidacion;
end;

procedure TFMEscandallo.AntesDeModificar;
var i: Integer;
begin
  ComprobarFechaLiquidacion;

  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;
end;

procedure TFMEscandallo.AntesDeLocalizar;
begin
  DSRejilla.Enabled := false;
end;

procedure TFMEscandallo.AntesDeInsertar;
var
  primera, segunda, tercera, destrio: string;
begin
  empresa_e.Text := sEmpresa;
  centro_e.Text := sCentro;
  producto_e.Text := sProducto;
  fecha_e.Text := sFecha;
  tipo_entrada_e.Text := sTipoEntrada;
  cosechero_e.Text := sCosechero;
  plantacion_e.Text := sPlantacion;
  porcen_primera_e.Text := sPrimera;
  porcen_segunda_e.Text := sSegunda;
  porcen_tercera_e.Text := sTercera;
  porcen_destrio_e.Text := sDestrio;

  if DMConfig.EsLasMoradas then
  begin
    GetEscandallo(primera, segunda, tercera, destrio );

    porcen_primera_e.Text := primera;
    porcen_segunda_e.Text := segunda;
    porcen_tercera_e.Text := tercera;
    porcen_destrio_e.Text := destrio;
  end;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMEscandallo.AntesDeVisualizar;
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
  DSRejilla.Enabled := True;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMEscandallo.RequiredTime(Sender: TObject;
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

procedure TFMEscandallo.Plantaciones(empresa, producto, cosechero, fecha: string);
var
  sAux: string;
begin
  RejillaFlotante.ColumnResult := 3;
  RejillaFlotante.ColumnFind := 4;

  with DMBaseDatos.QDespegables do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    BorrarTemporal('temporal');

    SQL.Clear;
    SQL.Add(' SELECT DISTINCT  empresa_p, producto_p, cosechero_p, plantacion_p, MAX(ano_semana_p) as ano_semana_p ' +
      ' FROM frf_plantaciones ');

    sAux := '';
    if Trim(empresa) <> '' then
    begin
      sAux := sAux + ' WHERE empresa_p = ' + QuotedStr(empresa) + ' ';
    end;
    if Trim(producto) <> '' then
    begin
      if sAux = '' then
      begin
        sAux := sAux + ' WHERE producto_p = ' + QuotedStr(producto) + ' ';
      end
      else
      begin
        sAux := sAux + ' AND producto_p = ' + QuotedStr(producto) + ' ';
      end;
    end;
    if Trim(Cosechero) <> '' then
    begin
      if sAux = '' then
      begin
        sAux := sAux + ' WHERE cosechero_p = ' + cosechero;
      end
      else
      begin
        sAux := sAux + ' AND cosechero_p = ' + cosechero;
      end;
    end;
    if Trim(fecha) <> '' then
    begin
      if sAux = '' then
      begin
        sAux := sAux + ' WHERE fecha_inicio_p < ' + SQLDate(fecha) + ' ';
      end
      else
      begin
        sAux := sAux + ' AND fecha_inicio_p < ' + SQLDate(fecha) + ' ';
      end;
    end;
    SQL.Add(sAux);

    SQL.Add(' GROUP BY empresa_p, producto_p, cosechero_p, plantacion_p ' +
      ' ORDER BY empresa_p, producto_p, cosechero_p, plantacion_p ' +
      ' INTO TEMP temporal ');
    ExecSQL;

    SQL.Clear;
    QUERY := ' SELECT p.empresa_p, p.producto_p, p.cosechero_p, p.plantacion_p, p.descripcion_p ' +
      ' FROM frf_plantaciones p, temporal t ' +
      ' WHERE  p.empresa_p=t.empresa_p ' +
      '    AND p.producto_p=t.producto_p ' +
      '    AND p.cosechero_p=t.cosechero_p ' +
      '    AND p.plantacion_p=t.plantacion_p ' +
      '    AND p.ano_semana_p=t.ano_semana_p ' +
      ' ORDER BY p.empresa_p, p.producto_p, p.cosechero_p, p.plantacion_p ';
  end;

  plantacion_e.Tag := kOtros;
  DespliegaRejilla(btgPlantacion);
  plantacion_e.Tag := kPlantacion;
end;

procedure TFMEscandallo.ARejillaFlotanteExecute(Sender: TObject);
begin
  if empresa_e.Focused then DespliegaRejilla(btgEmpresa)
  else
    if centro_e.Focused then DespliegaRejilla(btgCentro, [empresa_e.Text])
    else
      if producto_e.Focused then DespliegaRejilla(btgProducto, [empresa_e.Text])
      else
        if cosechero_e.Focused then DespliegaRejilla(btgCosechero, [empresa_e.Text])
        else
          if plantacion_e.Focused then Plantaciones(empresa_e.Text, producto_e.Text,
              cosechero_e.Text, fecha_e.Text)
          else
            if fecha_e.Focused then DespliegaCalendario(btcFecha);
end;

procedure TFMEscandallo.DSMaestroDataChange(Sender: TObject; Field: TField);
begin
  empresa_des.Caption := desEmpresa(empresa_e.Text);
  producto_des.Caption := desProducto(empresa_e.Text, producto_e.Text);
  centro_des.Caption := desCentro(empresa_e.Text, centro_e.Text);
  cosechero_des.Caption := desCosechero(empresa_e.Text, cosechero_e.Text);
  plantacion_des.Caption := desPlantacionEx(empresa_e.Text, producto_e.Text,
                                            cosechero_e.Text, plantacion_e.Text, fecha_e.Text);
  stTipoEntrada.Caption:= desTipoEntrada(empresa_e.Text, tipo_entrada_e.Text);
end;

procedure TFMEscandallo.DBGrid1DblClick(Sender: TObject);
begin
  Modificar;
end;

(*
               QEscandalloMasterplantacion_e.AsString + '/ ' +
               desPlantacion(
                 QEscandalloMasterempresa_e.AsString,
                 QEscandalloMasterproducto_e.AsString,
                 QEscandalloMastercosechero_e.AsString,
                 QEscandalloMasterplantacion_e.AsString,
                 QEscandalloMasteranyo_semana_e.AsString
               )
*)

procedure TFMEscandallo.QEscandalloMasterCalcFields(DataSet: TDataSet);
begin
  QEscandalloMasterdes_plantacion_e.AsString := QEscandalloMasterplantacion_e.Text + ' / ' +
    desPlantacion(QEscandalloMasterempresa_e.Text,
    QEscandalloMasterproducto_e.Text,
    QEscandalloMastercosechero_e.Text,
    QEscandalloMasterplantacion_e.Text,
    QEscandalloMasteranyo_semana_e.Text);
end;

function TFMEscandallo.tipo_entrada_eGetSQL: String;
begin
  result:= '';
  if empresa_e.Text <> '' then
  begin
    result:= result + 'select tipo_et tipo, descripcion_et descripcion ';
    result:= result + 'from frf_entradas_tipo ';
    result:= result + 'where empresa_et = ' + QuotedStr( empresa_e.Text );
    result:= result + 'group by tipo_et, descripcion_et ';
    result:= result + 'order by tipo_et ';
  end
  else
  begin
    result:= result + 'select tipo_et tipo, descripcion_et descripcion ';
    result:= result + 'from frf_entradas_tipo ';
    result:= result + 'group by tipo_et, descripcion_et ';
    result:= result + 'order by tipo_et ';
  end;
end;

procedure TFMEscandallo.tipo_entrada_eChange(Sender: TObject);
begin
  if ( DSMaestro.DataSet.State = dsInsert ) or ( DSMaestro.DataSet.State = dsEdit ) then
  begin
    stTipoEntrada.Caption:= desTipoEntrada(empresa_e.Text, tipo_entrada_e.Text);
  end;
end;

function TFMEscandallo.KilosProducto( var AKilos: real ): boolean;
begin
  result:= false;
  AKilos:= 0;

  if QEscandalloMaster.State = dsBrowse then
  with QKilosEntrada do
  begin
    Open;
    if not IsEmpty then
    begin
      AKilos:= FieldByName('kilos').AsFloat;
      result:= True;
    end;
    Close;
  end;

end;

procedure TFMEscandallo.numero_entrada_eChange(Sender: TObject);
var
  AKilos: Real;
begin
  if KilosProducto( AKilos ) then
  begin
    lblKilosPrimera.Caption:= FormatFloat( '#,##0.00', ( AKilos * QEscandalloMasterporcen_primera_e.AsFloat ) / 100 );
    lblKilosSegunda.Caption:= FormatFloat( '#,##0.00', ( AKilos * QEscandalloMasterporcen_segunda_e.AsFloat ) / 100 );
    lblKilosTercera.Caption:= FormatFloat( '#,##0.00', ( AKilos * QEscandalloMasterporcen_tercera_e.AsFloat ) / 100 );
    lblKilosDestrio.Caption:= FormatFloat( '#,##0.00', ( AKilos * QEscandalloMasterporcen_destrio_e.AsFloat ) / 100 );
    lblKilosTotales.Caption:= FormatFloat( '#,##0.00', AKilos  );
  end
  else
  begin
    lblKilosPrimera.Caption:= '0,00';
    lblKilosSegunda.Caption:= '0,00';
    lblKilosTercera.Caption:= '0,00';
    lblKilosDestrio.Caption:= '0,00';
    lblKilosTotales.Caption:= '0,00';
  end;

end;

end.
