unit MAjustesEnvComerciales;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbtables,
  DError, DBCtrls;

type
  TFMAjustesEnvComerciales = class(TMaestro)
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    pnlMaestro: TPanel;
    QAjustes: TQuery;
    lbl1: TLabel;
    empresa_ecc: TBDEdit;
    btnEmpresa: TBGridButton;
    txtEmpresa: TStaticText;
    lblLEmpresa_p: TLabel;
    centro_ecc: TBDEdit;
    btnCentro: TBGridButton;
    txtCentro: TStaticText;
    lblNombre12: TLabel;
    cod_operador_ecc: TBDEdit;
    btnOperador: TBGridButton;
    txtOperador: TStaticText;
    txtEnvase: TStaticText;
    btnEnvase: TBGridButton;
    cod_producto_ecc: TBDEdit;
    lblEnvase: TLabel;
    lbl2: TLabel;
    fecha_ecc: TBDEdit;
    btnFecha: TBCalendarButton;
    lbl3: TLabel;
    cantidad_ecc: TBDEdit;
    lblHasta: TLabel;
    btnHasta: TBCalendarButton;
    edtHasta: TBEdit;
    lblNota: TLabel;
    nota_ecc: TBDEdit;
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
  CAuxiliarDB, Principal, LAjustesEnvComerciales, DPreview, bSQLUtils, UDMConfig;

{$R *.DFM}

procedure TFMAjustesEnvComerciales.AbrirTablas;
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

procedure TFMAjustesEnvComerciales.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuery(DataSetMaestro);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMAjustesEnvComerciales.FormCreate(Sender: TObject);
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
 {+}Select := ' SELECT * FROM  frf_env_comer_correcciones ';
 {+}where := ' WHERE empresa_ecc=' + QUOTEDSTR('###');
 {+}Order := ' ORDER BY empresa_ecc, fecha_ecc, centro_ecc, cod_operador_ecc, cod_producto_ecc ';

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;

     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_ecc.Tag := kEmpresa;
  centro_ecc.Tag := kCentro;
  cod_operador_ecc.Tag:= kEnvComerOperador;
  cod_producto_ecc.Tag:= kEnvComerProducto;
  fecha_ecc.Tag:= kCalendar;
  edtHasta.Tag:= kCalendar;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnEdit := AntesDeModificar;
  OnBrowse:= AntesDeLocalizar;
  OnView := AntesDeVisualizar;

     //Focos
  {+}FocoAltas := empresa_ecc;
  {+}FocoModificar := cantidad_ecc;
  {+}FocoLocalizar := empresa_ecc;

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


procedure TFMAjustesEnvComerciales.FormActivate(Sender: TObject);
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


procedure TFMAjustesEnvComerciales.FormDeactivate(Sender: TObject);
begin
  Exit;

  //Desahabilitamos controles de Base de datos
  //mientras estamos desactivados
  DataSetMaestro.DisableControls;

 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;

  //CerrarTablas;
end;

procedure TFMAjustesEnvComerciales.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMAjustesEnvComerciales.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMAjustesEnvComerciales.Filtro;
var
  Flag: Boolean;
  dIni, dFin: TDateTime;
begin
  where := '';
  Flag := false;

  if empresa_ecc.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' empresa_ecc LIKE ' + SQLFilter(empresa_ecc.Text);
    flag := True;
  end;
  if centro_ecc.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' centro_ecc LIKE ' + SQLFilter(centro_ecc.Text);
    flag := True;
  end;
  if cod_operador_ecc.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' cod_operador_ecc LIKE ' + SQLFilter(cod_operador_ecc.Text);
    flag := True;
  end;
  if cod_producto_ecc.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' cod_producto_ecc LIKE ' + SQLFilter(cod_producto_ecc.Text);
    flag := True;
  end;

  if TryStrToDate( edtHasta.Text, dFin ) then
  begin
    if TryStrToDate( fecha_ecc.Text, dIni ) then
    begin
      if dIni > dFin then
      begin
        if flag then
          where := where + ' and ';
        where := where + ' fecha_ecc between ' + SQLDate(fecha_ecc.Text) + ' and ' + SQLDate(edtHasta.Text);
        flag := True;
      end
      else
      begin
        if flag then
          where := where + ' and ';
        where := where + ' fecha_ecc between ' + SQLDate(fecha_ecc.Text) + ' and ' + SQLDate(edtHasta.Text);
        flag := True;
      end;
    end
    else
    begin
      if flag then
        where := where + ' and ';
      where := where + ' fecha_ecc = ' + SQLDate(edtHasta.Text);
      flag := True;
    end;
  end
  else
  if TryStrToDate( fecha_ecc.Text, dIni ) then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' fecha_ecc = ' + SQLDate(fecha_ecc.Text);
    flag := True;
  end;


  if cantidad_ecc.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' cantidad_ecc = ' + SQLNumeric(cantidad_ecc.Text);
    flag := True;
  end;

  if nota_ecc.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' nota_ecc LIKE ' + SQLFilter(nota_ecc.Text);
    flag := True;
  end;

  if flag then
    where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFMAjustesEnvComerciales.AnyadirRegistro;
begin
  if where <> '' then
    where := where + ' OR ('
  else
    where := ' WHERE (';

  if empresa_ecc.Text <> '' then
  begin
    where := where + ' empresa_ecc = ' + QuotedStr(empresa_ecc.Text);
  end;
  if centro_ecc.Text <> '' then
  begin
    where := where + ' and centro_ecc = ' + QuotedStr(centro_ecc.Text);
  end;
  if cod_operador_ecc.Text <> '' then
  begin
    where := where + ' and cod_operador_ecc = ' + QuotedStr(cod_operador_ecc.Text);
  end;
  if cod_producto_ecc.Text <> '' then
  begin
    where := where + ' and cod_producto_ecc = ' + QuotedStr(cod_producto_ecc.Text);
  end;
  if fecha_ecc.Text <> '' then
  begin
    where := where + ' and fecha_ecc = ' + SQLDate(fecha_ecc.Text);
  end;
  where := where + ') ';
end;

{+}//Sustituir por funcion generica

procedure TFMAjustesEnvComerciales.ValidarEntradaMaestro;
var
  dAux : TDateTime;
begin
  if TxtEmpresa.Caption = '' then
  begin
    empresa_ecc.Focused;
    raise Exception.Create('Falta el código de le empresa o es incorrecto.');
  end;
  if txtCentro.Caption = '' then
  begin
    centro_ecc.Focused;
    raise Exception.Create('Falta el código del centro o es incorrecto.');
  end;
  if txtOperador.Caption = '' then
  begin
    cod_operador_ecc.Focused;
    raise Exception.Create('Falta el código del operador o es incorrecto.');
  end;
  if txtEnvase.Caption = '' then
  begin
    cod_producto_ecc.Focused;
    raise Exception.Create('Falta el código del envase o es incorrecto.');
  end;
  if not TryStrToDate( fecha_ecc.Text, dAux ) then
  begin
    fecha_ecc.Focused;
    raise Exception.Create('Falta la fecha del ajuste o es incorrectao.');
  end;
  if cantidad_ecc.Text = '' then
  begin
    cantidad_ecc.Text:= '0';
  end;

end;

procedure TFMAjustesEnvComerciales.Previsualizar;
begin
  //Crear el listado
  DMBaseDatos.QListado.SQL.Clear;
  DMBaseDatos.QListado.SQL.Add( Select );
  DMBaseDatos.QListado.SQL.Add( Where );
  DMBaseDatos.QListado.SQL.Add( ' order by empresa_ecc, centro_ecc, cod_operador_ecc, cod_producto_ecc, fecha_ecc ');
  try
    DMBaseDatos.QListado.Open;
    QRLAjustesEnvComerciales := TQRLAjustesEnvComerciales.Create(Application);
    try
      PonLogoGrupoBonnysa(QRLAjustesEnvComerciales);
      Preview(QRLAjustesEnvComerciales);
    except
      FreeAndNil(QRLAjustesEnvComerciales);
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

procedure TFMAjustesEnvComerciales.ARejillaFlotanteExecute(Sender: TObject);
begin
  if ActiveControl <> nil then
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCentro: DespliegaRejilla(btnCentro, [empresa_ecc.Text]);
    kEnvComerOperador: DespliegaRejilla(btnOperador);
    kEnvComerProducto: DespliegaRejilla(btnEnvase,[cod_operador_ecc.Text]);
    kCalendar:
    begin
      if fecha_ecc.Focused then
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

procedure TFMAjustesEnvComerciales.AntesDeModificar;
begin
  //
end;

procedure TFMAjustesEnvComerciales.AntesDeLocalizar;
begin
  lblHasta.Visible:= True;
  edtHasta.Visible:= True;
  btnHasta.Visible:= True;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprovechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMAjustesEnvComerciales.AntesDeVisualizar;
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

procedure TFMAjustesEnvComerciales.RequiredTime(Sender: TObject;
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

procedure TFMAjustesEnvComerciales.PonNombre(Sender: TObject);
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
        txtEmpresa.Caption := desEmpresa(empresa_ecc.Text);
        txtCentro.Caption := desCentro(empresa_ecc.Text, centro_ecc.Text);
      end;
    kCentro:
      txtCentro.Caption := desCentro(empresa_ecc.Text, centro_ecc.Text);
    kEnvComerOperador:
    begin
      txtOperador.Caption := desEnvComerOperador(cod_operador_ecc.Text );
      txtEnvase.Caption := desEnvComerProducto(cod_operador_ecc.Text, cod_producto_ecc.Text );
    end;
    kEnvComerProducto:
      txtEnvase.Caption := desEnvComerProducto(cod_operador_ecc.Text, cod_producto_ecc.Text );
  end;
end;

end.
