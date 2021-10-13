unit MTransitosEnvComerciales;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbtables,
  DError, DBCtrls;

type
  TFMTransitosEnvComerciales = class(TMaestro)
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    pnlMaestro: TPanel;
    QTransitos: TQuery;
    lbl1: TLabel;
    empresa_ect: TBDEdit;
    btnEmpresa: TBGridButton;
    txtEmpresa: TStaticText;
    lblLEmpresa_p: TLabel;
    centro_ect: TBDEdit;
    btnCentro: TBGridButton;
    txtCentro: TStaticText;
    lblNombre12: TLabel;
    cod_operador_ect: TBDEdit;
    btnOperador: TBGridButton;
    txtOperador: TStaticText;
    txtEnvase: TStaticText;
    btnEnvase: TBGridButton;
    cod_producto_ect: TBDEdit;
    lblEnvase: TLabel;
    lbl2: TLabel;
    fecha_ect: TBDEdit;
    btnFecha: TBCalendarButton;
    lbl3: TLabel;
    cantidad_ect: TBDEdit;
    lblHasta: TLabel;
    btnHasta: TBCalendarButton;
    edtHasta: TBEdit;
    lblDestino: TLabel;
    centro_destino_ect: TBDEdit;
    btnDestino: TBGridButton;
    txtDestino: TStaticText;
    lblNota: TLabel;
    nota_ect: TBDEdit;
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
  CAuxiliarDB, Principal, LTransitosEnvComerciales, DPreview, bSQLUtils, UDMConfig;

{$R *.DFM}

procedure TFMTransitosEnvComerciales.AbrirTablas;
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

procedure TFMTransitosEnvComerciales.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuery(DataSetMaestro);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMTransitosEnvComerciales.FormCreate(Sender: TObject);
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
 {+}DataSetMaestro := QTransitos;

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM  frf_env_comer_transitos ';
 {+}where := ' WHERE empresa_ect=' + QUOTEDSTR('###');
 {+}Order := ' ORDER BY empresa_ect, fecha_ect, centro_ect, cod_operador_ect, cod_producto_ect ';

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;

     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_ect.Tag := kEmpresa;
  centro_ect.Tag := kCentro;
  centro_destino_ect.Tag := kCentro;
  cod_operador_ect.Tag:= kEnvComerOperador;
  cod_producto_ect.Tag:= kEnvComerProducto;
  fecha_ect.Tag:= kCalendar;
  edtHasta.Tag:= kCalendar;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnEdit := AntesDeModificar;
  OnBrowse:= AntesDeLocalizar;
  OnView := AntesDeVisualizar;

     //Focos
  {+}FocoAltas := empresa_ect;
  {+}FocoModificar := nota_ect;
  {+}FocoLocalizar := empresa_ect;

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


procedure TFMTransitosEnvComerciales.FormActivate(Sender: TObject);
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


procedure TFMTransitosEnvComerciales.FormDeactivate(Sender: TObject);
begin
  Exit;

  //Desahabilitamos controles de Base de datos
  //mientras estamos desactivados
  DataSetMaestro.DisableControls;

 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;

  //CerrarTablas;
end;

procedure TFMTransitosEnvComerciales.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMTransitosEnvComerciales.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMTransitosEnvComerciales.Filtro;
var
  Flag: Boolean;
  dIni, dFin: TDateTime;
begin
  where := '';
  Flag := false;

  if empresa_ect.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' empresa_ect LIKE ' + SQLFilter(empresa_ect.Text);
    flag := True;
  end;
  if centro_ect.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' centro_ect LIKE ' + SQLFilter(centro_ect.Text);
    flag := True;
  end;
  if centro_destino_ect.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' centro_destino_ect LIKE ' + SQLFilter(centro_destino_ect.Text);
    flag := True;
  end;
  if cod_operador_ect.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' cod_operador_ect LIKE ' + SQLFilter(cod_operador_ect.Text);
    flag := True;
  end;
  if cod_producto_ect.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' cod_producto_ect LIKE ' + SQLFilter(cod_producto_ect.Text);
    flag := True;
  end;

  if TryStrToDate( edtHasta.Text, dFin ) then
  begin
    if TryStrToDate( fecha_ect.Text, dIni ) then
    begin
      if dIni > dFin then
      begin
        if flag then
          where := where + ' and ';
        where := where + ' fecha_ect between ' + SQLDate(fecha_ect.Text) + ' and ' + SQLDate(edtHasta.Text);
        flag := True;
      end
      else
      begin
        if flag then
          where := where + ' and ';
        where := where + ' fecha_ect between ' + SQLDate(fecha_ect.Text) + ' and ' + SQLDate(edtHasta.Text);
        flag := True;
      end;
    end
    else
    begin
      if flag then
        where := where + ' and ';
      where := where + ' fecha_ect = ' + SQLDate(edtHasta.Text);
      flag := True;
    end;
  end
  else
  if TryStrToDate( fecha_ect.Text, dIni ) then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' fecha_ect = ' + SQLDate(fecha_ect.Text);
    flag := True;
  end;


  if cantidad_ect.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' cantidad_ect = ' + SQLNumeric(cantidad_ect.Text);
    flag := True;
  end;

  if nota_ect.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' nota_ect LIKE ' + SQLFilter(nota_ect.Text);
    flag := True;
  end;

  if flag then
    where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFMTransitosEnvComerciales.AnyadirRegistro;
begin
  if where <> '' then
    where := where + ' OR ('
  else
    where := ' WHERE (';

  if empresa_ect.Text <> '' then
  begin
    where := where + ' empresa_ect = ' + QuotedStr(empresa_ect.Text);
  end;
  if centro_ect.Text <> '' then
  begin
    where := where + ' and centro_ect = ' + QuotedStr(centro_ect.Text);
  end;
  if centro_destino_ect.Text <> '' then
  begin
    where := where + ' and centro_destino_ect = ' + QuotedStr(centro_destino_ect.Text);
  end;
  if cod_operador_ect.Text <> '' then
  begin
    where := where + ' and cod_operador_ect = ' + QuotedStr(cod_operador_ect.Text);
  end;
  if cod_producto_ect.Text <> '' then
  begin
    where := where + ' and cod_producto_ect = ' + QuotedStr(cod_producto_ect.Text);
  end;
  if fecha_ect.Text <> '' then
  begin
    where := where + ' and fecha_ect = ' + SQLDate(fecha_ect.Text);
  end;
  where := where + ') ';
end;

{+}//Sustituir por funcion generica

procedure TFMTransitosEnvComerciales.ValidarEntradaMaestro;
var
  dAux : TDateTime;
begin
  if TxtEmpresa.Caption = '' then
  begin
    empresa_ect.Focused;
    raise Exception.Create('Falta el código de la empresa o es incorrecto.');
  end;
  if txtCentro.Caption = '' then
  begin
    centro_ect.Focused;
    raise Exception.Create('Falta el código del centro o es incorrecto.');
  end;
  if txtDestino.Caption = '' then
  begin
    centro_destino_ect.Focused;
    raise Exception.Create('Falta el código del destino o es incorrecto.');
  end;
  if txtOperador.Caption = '' then
  begin
    cod_operador_ect.Focused;
    raise Exception.Create('Falta el código del operador o es incorrecto.');
  end;
  if txtEnvase.Caption = '' then
  begin
    cod_producto_ect.Focused;
    raise Exception.Create('Falta el código del artículo o es incorrecto.');
  end;
  if not TryStrToDate( fecha_ect.Text, dAux ) then
  begin
    fecha_ect.Focused;
    raise Exception.Create('Falta la fecha del ajuste o es incorrectao.');
  end;
  if cantidad_ect.Text = '' then
  begin
    cantidad_ect.Text:= '0';
  end;

end;

procedure TFMTransitosEnvComerciales.Previsualizar;
begin
  //Crear el listado
  DMBaseDatos.QListado.SQL.Clear;
  DMBaseDatos.QListado.SQL.Add( Select );
  DMBaseDatos.QListado.SQL.Add( Where );
  DMBaseDatos.QListado.SQL.Add( ' order by empresa_ect, centro_ect, centro_destino_ect, cod_operador_ect, cod_producto_ect, fecha_ect ');
  try
    DMBaseDatos.QListado.Open;
    QRLTransitosEnvComerciales := TQRLTransitosEnvComerciales.Create(Application);
    try
      PonLogoGrupoBonnysa(QRLTransitosEnvComerciales);
      Preview(QRLTransitosEnvComerciales);
    except
      FreeAndNil(QRLTransitosEnvComerciales);
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

procedure TFMTransitosEnvComerciales.ARejillaFlotanteExecute(Sender: TObject);
begin
  if ActiveControl <> nil then
  case ActiveControl.Tag of
    kEmpresa:
    begin
      DespliegaRejilla(btnEmpresa);
    end;
    kCentro:
    begin
      if centro_ect.Focused then
         DespliegaRejilla(btnCentro, [empresa_ect.Text])
      else
      if centro_destino_ect.Focused then
        DespliegaRejilla(btnDestino, [empresa_ect.Text]);
    end;
    kEnvComerOperador: DespliegaRejilla(btnOperador);
    kEnvComerProducto: DespliegaRejilla(btnEnvase,[cod_operador_ect.Text]);
    kCalendar:
    begin
      if fecha_ect.Focused then
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

procedure TFMTransitosEnvComerciales.AntesDeModificar;
begin
  //
end;

procedure TFMTransitosEnvComerciales.AntesDeLocalizar;
begin
  lblHasta.Visible:= True;
  edtHasta.Visible:= True;
  btnHasta.Visible:= True;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprovechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMTransitosEnvComerciales.AntesDeVisualizar;
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

procedure TFMTransitosEnvComerciales.RequiredTime(Sender: TObject;
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

procedure TFMTransitosEnvComerciales.PonNombre(Sender: TObject);
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
        txtEmpresa.Caption := desEmpresa(empresa_ect.Text);
        txtCentro.Caption := desCentro(empresa_ect.Text, centro_ect.Text);
        txtDestino.Caption := desCentro(empresa_ect.Text, centro_destino_ect.Text);
      end;
    kCentro:
      if TEdit( Sender ).Name = 'centro_ect' then
        txtCentro.Caption := desCentro(empresa_ect.Text, centro_ect.Text)
      else
        txtDestino.Caption := desCentro(empresa_ect.Text, centro_destino_ect.Text);
    kEnvComerOperador:
    begin
      txtOperador.Caption := desEnvComerOperador(cod_operador_ect.Text );
      txtEnvase.Caption := desEnvComerProducto(cod_operador_ect.Text, cod_producto_ect.Text );
    end;
    kEnvComerProducto:
      txtEnvase.Caption := desEnvComerProducto(cod_operador_ect.Text, cod_producto_ect.Text );
  end;
end;

end.
