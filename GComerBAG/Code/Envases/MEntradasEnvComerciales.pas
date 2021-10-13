unit MEntradasEnvComerciales;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbtables,
  DError, DBCtrls;

type
  TFMEntradasEnvComerciales = class(TMaestro)
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    pnlMaestro: TPanel;
    QAjustes: TQuery;
    lbl1: TLabel;
    empresa_ece: TBDEdit;
    btnEmpresa: TBGridButton;
    txtEmpresa: TStaticText;
    lblLEmpresa_p: TLabel;
    centro_ece: TBDEdit;
    btnCentro: TBGridButton;
    txtCentro: TStaticText;
    lblNombre12: TLabel;
    cod_operador_ece: TBDEdit;
    btnOperador: TBGridButton;
    txtOperador: TStaticText;
    txtEnvase: TStaticText;
    btnEnvase: TBGridButton;
    cod_producto_ece: TBDEdit;
    lblEnvase: TLabel;
    lbl2: TLabel;
    fecha_ece: TBDEdit;
    btnFecha: TBCalendarButton;
    lbl3: TLabel;
    cantidad_ece: TBDEdit;
    lblHasta: TLabel;
    btnHasta: TBCalendarButton;
    edtHasta: TBEdit;
    lblAlmacen: TLabel;
    cod_almacen_ece: TBDEdit;
    btnAlmacen: TBGridButton;
    txtAlmacen: TStaticText;
    lblNota: TLabel;
    referencia_ece: TBDEdit;
    lbl4: TLabel;
    nota_ece: TBDEdit;
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
    sEmpresa, sCentro, sOperador, sAlmacen, sFecha, sReferencia: string;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeLocalizar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses UDMAuxDB, CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, LEntradasEnvComerciales, DPreview, bSQLUtils, UDMConfig;

{$R *.DFM}

procedure TFMEntradasEnvComerciales.AbrirTablas;
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

procedure TFMEntradasEnvComerciales.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuery(DataSetMaestro);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMEntradasEnvComerciales.FormCreate(Sender: TObject);
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
 {+}Select := ' SELECT * FROM  frf_env_comer_entradas ';
 {+}where := ' WHERE empresa_ece=' + QUOTEDSTR('###');
 {+}Order := ' ORDER BY empresa_ece, fecha_ece, centro_ece, cod_operador_ece, cod_almacen_ece, cod_producto_ece ';

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;

     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_ece.Tag := kEmpresa;
  centro_ece.Tag := kCentro;
  cod_operador_ece.Tag:= kEnvComerOperador;
  cod_producto_ece.Tag:= kEnvComerProducto;
  cod_almacen_ece.Tag:= kEnvComerAlmacen;
  fecha_ece.Tag:= kCalendar;
  edtHasta.Tag:= kCalendar;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnInsert:= AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnBrowse:= AntesDeLocalizar;
  OnView := AntesDeVisualizar;

     //Focos
  {+}FocoAltas := empresa_ece;
  {+}FocoModificar := cantidad_ece;
  {+}FocoLocalizar := empresa_ece;

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


procedure TFMEntradasEnvComerciales.FormActivate(Sender: TObject);
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


procedure TFMEntradasEnvComerciales.FormDeactivate(Sender: TObject);
begin
  Exit;

  //Desahabilitamos controles de Base de datos
  //mientras estamos desactivados
  DataSetMaestro.DisableControls;

 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;

  //CerrarTablas;
end;

procedure TFMEntradasEnvComerciales.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMEntradasEnvComerciales.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMEntradasEnvComerciales.Filtro;
var
  Flag: Boolean;
  dIni, dFin: TDateTime;
begin
  where := '';
  Flag := false;

  if empresa_ece.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' empresa_ece LIKE ' + SQLFilter(empresa_ece.Text);
    flag := True;
  end;
  if centro_ece.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' centro_ece LIKE ' + SQLFilter(centro_ece.Text);
    flag := True;
  end;
  if cod_operador_ece.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' cod_operador_ece LIKE ' + SQLFilter(cod_operador_ece.Text);
    flag := True;
  end;
  if cod_almacen_ece.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' cod_almacen_ece LIKE ' + SQLFilter(cod_almacen_ece.Text);
    flag := True;
  end;
  if cod_producto_ece.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' cod_producto_ece LIKE ' + SQLFilter(cod_producto_ece.Text);
    flag := True;
  end;

  if TryStrToDate( edtHasta.Text, dFin ) then
  begin
    if TryStrToDate( fecha_ece.Text, dIni ) then
    begin
      if dIni > dFin then
      begin
        if flag then
          where := where + ' and ';
        where := where + ' fecha_ece between ' + SQLDate(fecha_ece.Text) + ' and ' + SQLDate(edtHasta.Text);
        flag := True;
      end
      else
      begin
        if flag then
          where := where + ' and ';
        where := where + ' fecha_ece between ' + SQLDate(fecha_ece.Text) + ' and ' + SQLDate(edtHasta.Text);
        flag := True;
      end;
    end
    else
    begin
      if flag then
        where := where + ' and ';
      where := where + ' fecha_ece = ' + SQLDate(edtHasta.Text);
      flag := True;
    end;
  end
  else
  if TryStrToDate( fecha_ece.Text, dIni ) then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' fecha_ece = ' + SQLDate(fecha_ece.Text);
    flag := True;
  end;


  if cantidad_ece.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' cantidad_ece = ' + SQLNumeric(cantidad_ece.Text);
    flag := True;
  end;

  if nota_ece.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' nota_ece LIKE ' + SQLFilter(nota_ece.Text);
    flag := True;
  end;

  if referencia_ece.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' referencia_ece LIKE ' + SQLFilter(referencia_ece.Text);
    flag := True;
  end;


  if flag then
    where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFMEntradasEnvComerciales.AnyadirRegistro;
begin
  if where <> '' then
    where := where + ' OR ('
  else
    where := ' WHERE (';

  if empresa_ece.Text <> '' then
  begin
    where := where + ' empresa_ece = ' + QuotedStr(empresa_ece.Text);
  end;
  if centro_ece.Text <> '' then
  begin
    where := where + ' and centro_ece = ' + QuotedStr(centro_ece.Text);
  end;
  if cod_operador_ece.Text <> '' then
  begin
    where := where + ' and cod_operador_ece = ' + QuotedStr(cod_operador_ece.Text);
  end;
  if cod_almacen_ece.Text <> '' then
  begin
    where := where + ' and cod_almacen_ece = ' + QuotedStr(cod_almacen_ece.Text);
  end;
  if cod_producto_ece.Text <> '' then
  begin
    where := where + ' and cod_producto_ece = ' + QuotedStr(cod_producto_ece.Text);
  end;
  if fecha_ece.Text <> '' then
  begin
    where := where + ' and fecha_ece = ' + SQLDate(fecha_ece.Text);
  end;
  where := where + ') ';
end;

{+}//Sustituir por funcion generica

procedure TFMEntradasEnvComerciales.ValidarEntradaMaestro;
var
  dAux : TDateTime;
begin
  if TxtEmpresa.Caption = '' then
  begin
    empresa_ece.Focused;
    raise Exception.Create('Falta el código de le empresa o es incorrecto.');
  end;
  if txtCentro.Caption = '' then
  begin
    centro_ece.Focused;
    raise Exception.Create('Falta el código del centro o es incorrecto.');
  end;
  if txtOperador.Caption = '' then
  begin
    cod_operador_ece.Focused;
    raise Exception.Create('Falta el código del operador o es incorrecto.');
  end;
  if txtEnvase.Caption = '' then
  begin
    cod_producto_ece.Focused;
    raise Exception.Create('Falta el código del envase o es incorrecto.');
  end;
  if txtAlmacen.Caption = '' then
  begin
    cod_almacen_ece.Focused;
    raise Exception.Create('Falta el código del almacén o es incorrecto.');
  end;
  if not TryStrToDate( fecha_ece.Text, dAux ) then
  begin
    fecha_ece.Focused;
    raise Exception.Create('Falta la fecha del ajuste o es incorrectao.');
  end;
  if referencia_ece.Text = '' then
  begin
    referencia_ece.Focused;
    raise Exception.Create('Falta la referencia de la entrada.');
  end;
  if cantidad_ece.Text = '' then
  begin
    cantidad_ece.Text:= '0';
  end;

  sEmpresa:= empresa_ece.Text;
  sCentro:= centro_ece.Text;
  sOperador:= cod_operador_ece.Text;
  sAlmacen:= cod_almacen_ece.Text;
  sFecha:= fecha_ece.Text;
  sReferencia:= referencia_ece.Text;
end;

procedure TFMEntradasEnvComerciales.Previsualizar;
begin
  //Crear el listado
  DMBaseDatos.QListado.SQL.Clear;
  DMBaseDatos.QListado.SQL.Add( Select );
  DMBaseDatos.QListado.SQL.Add( Where );
  DMBaseDatos.QListado.SQL.Add( ' order by empresa_ece, centro_ece, cod_operador_ece, cod_almacen_ece, cod_producto_ece, fecha_ece ');
  try
    DMBaseDatos.QListado.Open;
    QRLEntradasEnvComerciales := TQRLEntradasEnvComerciales.Create(Application);
    try
      PonLogoGrupoBonnysa(QRLEntradasEnvComerciales);
      Preview(QRLEntradasEnvComerciales);
    except
      FreeAndNil(QRLEntradasEnvComerciales);
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

procedure TFMEntradasEnvComerciales.ARejillaFlotanteExecute(Sender: TObject);
begin
  if ActiveControl <> nil then
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCentro: DespliegaRejilla(btnCentro, [empresa_ece.Text]);
    kEnvComerOperador: DespliegaRejilla(btnOperador);
    kEnvComerAlmacen: DespliegaRejilla(btnAlmacen,[cod_operador_ece.Text]);
    kEnvComerProducto: DespliegaRejilla(btnEnvase,[cod_operador_ece.Text]);
    kCalendar:
    begin
      if fecha_ece.Focused then
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

procedure TFMEntradasEnvComerciales.AntesDeInsertar;
begin
  //
  empresa_ece.Text:= sEmpresa;
  centro_ece.Text:= sCentro;
  cod_operador_ece.Text:= sOperador;
  cod_almacen_ece.Text:= sAlmacen;
  fecha_ece.Text:= sFecha;
  referencia_ece.Text:= sReferencia;
end;

procedure TFMEntradasEnvComerciales.AntesDeModificar;
begin
  //
end;

procedure TFMEntradasEnvComerciales.AntesDeLocalizar;
begin
  lblHasta.Visible:= True;
  edtHasta.Visible:= True;
  btnHasta.Visible:= True;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprovechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMEntradasEnvComerciales.AntesDeVisualizar;
begin
  edtHasta.Text:= '';
  lblHasta.Visible:= False;
  edtHasta.Visible:= False;
  btnHasta.Visible:= False;

  sEmpresa:= '';
  sCentro:= '';
  sOperador:= '';
  sAlmacen:= '';
  sFecha:= '';
  sReferencia:= '';
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************
//Pone el nombre de la empresa al desplazarse por la tabla.

procedure TFMEntradasEnvComerciales.RequiredTime(Sender: TObject;
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

procedure TFMEntradasEnvComerciales.PonNombre(Sender: TObject);
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
        txtEmpresa.Caption := desEmpresa(empresa_ece.Text);
        txtCentro.Caption := desCentro(empresa_ece.Text, centro_ece.Text);
      end;
    kCentro:
      txtCentro.Caption := desCentro(empresa_ece.Text, centro_ece.Text);
    kEnvComerOperador:
    begin
      txtOperador.Caption := desEnvComerOperador(cod_operador_ece.Text );
      txtEnvase.Caption := desEnvComerProducto(cod_operador_ece.Text, cod_producto_ece.Text );
      txtAlmacen.Caption := desEnvComerAlmacen(cod_operador_ece.Text, cod_almacen_ece.Text );
    end;
    kEnvComerProducto:
      txtEnvase.Caption := desEnvComerProducto(cod_operador_ece.Text, cod_producto_ece.Text );
    kEnvComerAlmacen:
      txtAlmacen.Caption := desEnvComerAlmacen(cod_operador_ece.Text, cod_almacen_ece.Text );
  end;
end;

end.
