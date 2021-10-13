unit MInventarioEnvComerciales;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbtables,
  DError, DBCtrls;

type
  TFMInventarioEnvComerciales = class(TMaestro)
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    pnlMaestro: TPanel;
    QAjustes: TQuery;
    lbl1: TLabel;
    empresa_ecs: TBDEdit;
    btnEmpresa: TBGridButton;
    txtEmpresa: TStaticText;
    lblLEmpresa_p: TLabel;
    centro_ecs: TBDEdit;
    btnCentro: TBGridButton;
    txtCentro: TStaticText;
    lblNombre12: TLabel;
    cod_operador_ecs: TBDEdit;
    btnOperador: TBGridButton;
    txtOperador: TStaticText;
    txtEnvase: TStaticText;
    btnEnvase: TBGridButton;
    cod_producto_ecs: TBDEdit;
    lblEnvase: TLabel;
    lbl2: TLabel;
    fecha_ecs: TBDEdit;
    btnFecha: TBCalendarButton;
    lbl3: TLabel;
    stock_ecs: TBDEdit;
    lblHasta: TLabel;
    btnHasta: TBCalendarButton;
    edtHasta: TBEdit;
    lbl4: TLabel;
    nota_ecs: TBDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure PonNombre(Sender: TObject);
  private
    { Private declarations }

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeModificar;
    procedure AntesDeLocalizar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses UDMAuxDB, CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, LInventarioEnvComerciales, DPreview, bSQLUtils, UDMConfig;

{$R *.DFM}

procedure TFMInventarioEnvComerciales.AbrirTablas;
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

procedure TFMInventarioEnvComerciales.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuery(DataSetMaestro);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMInventarioEnvComerciales.FormCreate(Sender: TObject);
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
  PanelMaestro := pnlMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := QAjustes;

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM  frf_env_comer_stocks ';
 {+}where := ' WHERE empresa_ecs=' + QUOTEDSTR('###');
 {+}Order := ' ORDER BY empresa_ecs, fecha_ecs, centro_ecs, cod_operador_ecs, cod_producto_ecs ';

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;

     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_ecs.Tag := kEmpresa;
  centro_ecs.Tag := kCentro;
  cod_operador_ecs.Tag:= kEnvComerOperador;
  cod_producto_ecs.Tag:= kEnvComerProducto;
  fecha_ecs.Tag:= kCalendar;
  edtHasta.Tag:= kCalendar;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnEdit := AntesDeModificar;
  OnBrowse:= AntesDeLocalizar;
  OnView := AntesDeVisualizar;

     //Focos
  {+}FocoAltas := empresa_ecs;
  {+}FocoModificar := stock_ecs;
  {+}FocoLocalizar := empresa_ecs;

  //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  CalendarioFlotante.Date := Date;

  //Abrir tablas/Querys
  try
    AbrirTablas;
    Visualizar;
  except
    Close;
  end;
end;

{+ CUIDADIN }


procedure TFMInventarioEnvComerciales.FormActivate(Sender: TObject);
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
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := CalendarioFlotante;

     //Abrir tablas/Querys
  try
    AbrirTablas;
    Visualizar;
  except
    Close;
  end;
end;


procedure TFMInventarioEnvComerciales.FormDeactivate(Sender: TObject);
begin
  Exit;

  //Desahabilitamos controles de Base de datos
  //mientras estamos desactivados
  DataSetMaestro.DisableControls;

 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;

  //CerrarTablas;
end;

procedure TFMInventarioEnvComerciales.FormClose(Sender: TObject; var Action: TCloseAction);
begin
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

procedure TFMInventarioEnvComerciales.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{*}//Si la rejilla esta desplegada no hacemos nada
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
           //No hacemos nada
      Exit;
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

{+}//Sustituir por funcion generica

procedure TFMInventarioEnvComerciales.Filtro;
var
  Flag: Boolean;
  dIni, dFin: TDateTime;
begin
  where := '';
  Flag := false;

  if empresa_ecs.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' empresa_ecs LIKE ' + SQLFilter(empresa_ecs.Text);
    flag := True;
  end;
  if centro_ecs.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' centro_ecs LIKE ' + SQLFilter(centro_ecs.Text);
    flag := True;
  end;
  if cod_operador_ecs.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' cod_operador_ecs LIKE ' + SQLFilter(cod_operador_ecs.Text);
    flag := True;
  end;
  if cod_producto_ecs.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' cod_producto_ecs LIKE ' + SQLFilter(cod_producto_ecs.Text);
    flag := True;
  end;

  if TryStrToDate( edtHasta.Text, dFin ) then
  begin
    if TryStrToDate( fecha_ecs.Text, dIni ) then
    begin
      if dIni > dFin then
      begin
        if flag then
          where := where + ' and ';
        where := where + ' fecha_ecs between ' + SQLDate(fecha_ecs.Text) + ' and ' + SQLDate(edtHasta.Text);
        flag := True;
      end
      else
      begin
        if flag then
          where := where + ' and ';
        where := where + ' fecha_ecs between ' + SQLDate(fecha_ecs.Text) + ' and ' + SQLDate(edtHasta.Text);
        flag := True;
      end;
    end
    else
    begin
      if flag then
        where := where + ' and ';
      where := where + ' fecha_ecs = ' + SQLDate(edtHasta.Text);
      flag := True;
    end;
  end
  else
  if TryStrToDate( fecha_ecs.Text, dIni ) then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' fecha_ecs = ' + SQLDate(fecha_ecs.Text);
    flag := True;
  end;


  if stock_ecs.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' stock_ecs = ' + SQLNumeric(stock_ecs.Text);
    flag := True;
  end;

  if nota_ecs.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' nota_ecs LIKE ' + SQLFilter(nota_ecs.Text);
    flag := True;
  end;

  if flag then
    where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFMInventarioEnvComerciales.AnyadirRegistro;
begin
  if where <> '' then
    where := where + ' OR ('
  else
    where := ' WHERE (';

  if empresa_ecs.Text <> '' then
  begin
    where := where + ' empresa_ecs = ' + QuotedStr(empresa_ecs.Text);
  end;
  if centro_ecs.Text <> '' then
  begin
    where := where + ' and centro_ecs = ' + QuotedStr(centro_ecs.Text);
  end;
  if cod_operador_ecs.Text <> '' then
  begin
    where := where + ' and cod_operador_ecs = ' + QuotedStr(cod_operador_ecs.Text);
  end;
  if cod_producto_ecs.Text <> '' then
  begin
    where := where + ' and cod_producto_ecs = ' + QuotedStr(cod_producto_ecs.Text);
  end;
  if fecha_ecs.Text <> '' then
  begin
    where := where + ' and fecha_ecs = ' + SQLDate(fecha_ecs.Text);
  end;
  where := where + ') ';
end;

{+}//Sustituir por funcion generica

procedure TFMInventarioEnvComerciales.ValidarEntradaMaestro;
var
  dAux : TDateTime;
begin
  if TxtEmpresa.Caption = '' then
  begin
    empresa_ecs.Focused;
    raise Exception.Create('Falta el código de le empresa o es incorrecto.');
  end;
  if txtCentro.Caption = '' then
  begin
    centro_ecs.Focused;
    raise Exception.Create('Falta el código del centro o es incorrecto.');
  end;
  if txtOperador.Caption = '' then
  begin
    cod_operador_ecs.Focused;
    raise Exception.Create('Falta el código del operador o es incorrecto.');
  end;
  if txtEnvase.Caption = '' then
  begin
    cod_producto_ecs.Focused;
    raise Exception.Create('Falta el código del envase o es incorrecto.');
  end;
  if not TryStrToDate( fecha_ecs.Text, dAux ) then
  begin
    fecha_ecs.Focused;
    raise Exception.Create('Falta la fecha del ajuste o es incorrectao.');
  end;
  if stock_ecs.Text = '' then
  begin
    stock_ecs.Text:= '0';
  end;

end;

procedure TFMInventarioEnvComerciales.Previsualizar;
begin
  //Crear el listado
  DMBaseDatos.QListado.SQL.Clear;
  DMBaseDatos.QListado.SQL.Add( Select );
  DMBaseDatos.QListado.SQL.Add( Where );
  DMBaseDatos.QListado.SQL.Add( ' order by empresa_ecs, centro_ecs, cod_operador_ecs, cod_producto_ecs, fecha_ecs ');
  try
    DMBaseDatos.QListado.Open;
    QRLInventarioEnvComerciales := TQRLInventarioEnvComerciales.Create(Application);
    try
      PonLogoGrupoBonnysa(QRLInventarioEnvComerciales);
      Preview(QRLInventarioEnvComerciales);
    except
      FreeAndNil(QRLInventarioEnvComerciales);
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

procedure TFMInventarioEnvComerciales.ARejillaFlotanteExecute(Sender: TObject);
begin
  if ActiveControl <> nil then
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCentro: DespliegaRejilla(btnCentro, [empresa_ecs.Text]);
    kEnvComerOperador: DespliegaRejilla(btnOperador);
    kEnvComerProducto: DespliegaRejilla(btnEnvase,[cod_operador_ecs.Text]);
    kCalendar:
    begin
      if fecha_ecs.Focused then
        DespliegaCalendario(btnFecha)
      else
      if edtHasta.Focused then
        DespliegaCalendario(btnHasta);
    end;
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

procedure TFMInventarioEnvComerciales.AntesDeModificar;
begin
  //
end;

procedure TFMInventarioEnvComerciales.AntesDeLocalizar;
begin
  lblHasta.Visible:= True;
  edtHasta.Visible:= True;
  btnHasta.Visible:= True;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprovechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMInventarioEnvComerciales.AntesDeVisualizar;
begin
  edtHasta.Text:= '';
  lblHasta.Visible:= False;
  edtHasta.Visible:= False;
  btnHasta.Visible:= False;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************
//Pone el nombre de la empresa al desplazarse por la tabla.

procedure TFMInventarioEnvComerciales.RequiredTime(Sender: TObject;
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

procedure TFMInventarioEnvComerciales.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa:
      begin
        txtEmpresa.Caption := desEmpresa(empresa_ecs.Text);
        txtCentro.Caption := desCentro(empresa_ecs.Text, centro_ecs.Text);
      end;
    kCentro:
      txtCentro.Caption := desCentro(empresa_ecs.Text, centro_ecs.Text);
    kEnvComerOperador:
    begin
      txtOperador.Caption := desEnvComerOperador(cod_operador_ecs.Text );
      txtEnvase.Caption := desEnvComerProducto(cod_operador_ecs.Text, cod_producto_ecs.Text );
    end;
    kEnvComerProducto:
      txtEnvase.Caption := desEnvComerProducto(cod_operador_ecs.Text, cod_producto_ecs.Text );
  end;
end;

end.
