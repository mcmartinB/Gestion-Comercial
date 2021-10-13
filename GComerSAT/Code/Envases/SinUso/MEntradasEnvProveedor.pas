unit MEntradasEnvProveedor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbtables,
  DError, DBCtrls;

type
  TFMEntradasEnvProveedor = class(TMaestro)
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    pnlMaestro: TPanel;
    lblNombre12: TLabel;
    cod_operador_em: TBDEdit;
    btnOperador: TBGridButton;
    txtOperador: TStaticText;
    txtEnvase: TStaticText;
    btnEnvase: TBGridButton;
    cod_producto_em: TBDEdit;
    lblEnvase: TLabel;
    lbl3: TLabel;
    entrada_em: TBDEdit;
    lblNota: TLabel;
    codigo_em: TBDEdit;
    lbl4: TLabel;
    notas_em: TBDEdit;
    lblSalida: TLabel;
    salida_em: TBDEdit;
    lblEmpresa: TLabel;
    lblCentro: TLabel;
    empresa_em: TBDEdit;
    centro_em: TBDEdit;
    btnEmpresa: TBGridButton;
    btnCentro: TBGridButton;
    txtEmpresa: TStaticText;
    txtCentro: TStaticText;
    lblProveedor: TLabel;
    cod_proveedor_em: TBDEdit;
    btnProveedor: TBGridButton;
    txtProveedor: TStaticText;
    lbl2: TLabel;
    fecha_em: TBDEdit;
    Label1: TLabel;
    btnFecha: TBCalendarButton;
    DSMaestro: TDataSource;
    QAjustes: TQuery;
    btnAlbaran: TBGridButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure PonNombre(Sender: TObject);
    procedure codigo_emExit(Sender: TObject);

  private
    { Private declarations }
    sEmpresa, sCentro, sProveedor, sFecha: string;
    sOperador, sReferencia: string;

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
  CAuxiliarDB, Principal, LEntradasEnvProveedor, DPreview, bSQLUtils, UDMConfig,
  UFProveedores, UFAlbaranProveedor;

{$R *.DFM}

procedure TFMEntradasEnvProveedor.AbrirTablas;
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

procedure TFMEntradasEnvProveedor.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuery(DataSetMaestro);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMEntradasEnvProveedor.FormCreate(Sender: TObject);
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
 {+}Select := ' SELECT * FROM  frf_entregas_mat ';
 {+}where := ' WHERE empresa_em=' + QUOTEDSTR('###');
 {+}Order := '';//' ORDER BY fecha_em desc, empresa_em, centro_em, cod_proveedor_em, cod_operador_em, cod_producto_em ';

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;

     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_em.Tag:= kEmpresa;
  centro_em.Tag:= kCentro;
  cod_proveedor_em.Tag:= kProveedor;
  fecha_em.Tag:= kCalendar;
  cod_operador_em.Tag:= kEnvComerOperador;
  cod_producto_em.Tag:= kEnvComerProducto;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnInsert:= AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnBrowse:= AntesDeLocalizar;
  OnView := AntesDeVisualizar;

     //Focos
  {+}FocoAltas := empresa_em;
  {+}FocoModificar := entrada_em;
  {+}FocoLocalizar := empresa_em;

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


procedure TFMEntradasEnvProveedor.FormActivate(Sender: TObject);
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


procedure TFMEntradasEnvProveedor.FormDeactivate(Sender: TObject);
begin
  Exit;

  //Desahabilitamos controles de Base de datos
  //mientras estamos desactivados
  DataSetMaestro.DisableControls;

 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;

  //CerrarTablas;
end;

procedure TFMEntradasEnvProveedor.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMEntradasEnvProveedor.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMEntradasEnvProveedor.Filtro;
var
  Flag: Boolean;
begin
  where := '';
  Flag := false;

  if empresa_em.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' empresa_em LIKE ' + SQLFilter(empresa_em.Text);
    flag := True;
  end;
  if centro_em.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' centro_em LIKE ' + SQLFilter(centro_em.Text);
    flag := True;
  end;

  if cod_proveedor_em.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' cod_proveedor_em LIKE ' + SQLFilter(cod_proveedor_em.Text);
    flag := True;
  end;
  if fecha_em.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' fecha_em = ' + SQLFilter(fecha_em.Text);
    flag := True;
  end;


  if cod_operador_em.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' cod_operador_em LIKE ' + SQLFilter(cod_operador_em.Text);
    flag := True;
  end;
  if cod_producto_em.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' cod_producto_em LIKE ' + SQLFilter(cod_producto_em.Text);
    flag := True;
  end;


  if entrada_em.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' entrada_em = ' + SQLNumeric(entrada_em.Text);
    flag := True;
  end;
  if salida_em.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' salida_em = ' + SQLNumeric(salida_em.Text);
    flag := True;
  end;


  if notas_em.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' notas_em LIKE ' + SQLFilter(notas_em.Text);
    flag := True;
  end;

  if codigo_em.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' codigo_em LIKE ' + SQLFilter(codigo_em.Text);
    flag := True;
  end;


  if flag then
    where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFMEntradasEnvProveedor.AnyadirRegistro;
begin
  if where <> '' then
    where := where + ' OR ('
  else
    where := ' WHERE (';

  if cod_operador_em.Text <> '' then
  begin
    where := where + ' cod_operador_em = ' + QuotedStr(cod_operador_em.Text);
  end;
  if cod_producto_em.Text <> '' then
  begin
    where := where + ' and cod_producto_em = ' + QuotedStr(cod_producto_em.Text);
  end;
  if codigo_em.Text <> '' then
  begin
    where := where + ' and codigo_em = ' + QuotedStr(codigo_em.Text);
  end;

  if empresa_em.Text <> '' then
  begin
    where := where + ' and empresa_em = ' + QuotedStr(empresa_em.Text);
  end;
  if centro_em.Text <> '' then
  begin
    where := where + ' and centro_em = ' + QuotedStr(centro_em.Text);
  end;
  if cod_proveedor_em.Text <> '' then
  begin
    where := where + ' and cod_proveedor_em = ' + QuotedStr(cod_proveedor_em.Text);
  end;
  if fecha_em.Text <> '' then
  begin
    where := where + ' and fecha_em = ' + QuotedStr(fecha_em.Text);
  end;

  where := where + ') ';
end;

{+}//Sustituir por funcion generica

procedure TFMEntradasEnvProveedor.ValidarEntradaMaestro;
var
  dAux: TDateTime;
begin
  if txtEmpresa.Caption = '' then
  begin
    empresa_em.Focused;
    raise Exception.Create('Falta el código de la empresa o es incorrecto.');
  end;
  if txtCentro.Caption = '' then
  begin
    centro_em.Focused;
    raise Exception.Create('Falta el código del centro o es incorrecto.');
  end;
  if txtProveedor.Caption = '' then
  begin
    cod_proveedor_em.Focused;
    raise Exception.Create('Falta el código del proveedor o es incorrecto.');
  end;
  if not tryStrToDate( fecha_em.Text, dAux ) then
  begin
    fecha_em.Focused;
    raise Exception.Create('Falta la fecha del movimiento de material o es incorrecta.');
  end;

  if codigo_em.Text = '' then
  begin
    codigo_em.Focused;
    raise Exception.Create('Falta el código de la entrega.');
  end;
  if txtOperador.Caption = '' then
  begin
    cod_operador_em.Focused;
    raise Exception.Create('Falta el código del operador o es incorrecto.');
  end;
  if txtEnvase.Caption = '' then
  begin
    cod_producto_em.Focused;
    raise Exception.Create('Falta el código del envase o es incorrecto.');
  end;
  if entrada_em.Text = '' then
  begin
    entrada_em.Text:= '0';
  end;
  if salida_em.Text = '' then
  begin
    salida_em.Text:= '0';
  end;

  sReferencia:= codigo_em.Text;
  sOperador:= cod_operador_em.Text;
  sEmpresa:= empresa_em.Text;
  sCentro:= centro_em.Text;
  sProveedor:= cod_proveedor_em.Text;
  sFecha:= fecha_em.Text;

  //Comprobar referencia
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' SELECT * ' );
    SQL.Add(' FROM  frf_entregas_c ' );
    SQL.Add(' where empresa_ec = :empresa ' );
    SQL.Add(' and proveedor_ec =  :proveedor ' );
    SQL.Add(' and albaran_ec = :albaran ' );
    SQL.Add(' and fecha_carga_ec = :fecha ' );
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('proveedor').AsString:= sProveedor;
    ParamByName('albaran').AsString:= sReferencia;
    ParamByName('fecha').AsDateTime:= dAux;
    Open;
    try
      if IsEmpty then
      begin
        if MessageDlg('No se ha encontrado el albaran "' + sReferencia + '" del proveedor ' +  sProveedor + ' del día ' + sFecha + '.' + #13 + #10 +
                    '¿Seguro que desea continuar?', mtWarning, [mbYes, mbNo], 0 ) = mrNo then
        begin
          Abort;
        end;
      end;
    finally
      Close;
    end;
  end;
end;

procedure TFMEntradasEnvProveedor.Previsualizar;
begin
  //Crear el listado
  DMBaseDatos.QListado.SQL.Clear;
  DMBaseDatos.QListado.SQL.Add( Select );
  DMBaseDatos.QListado.SQL.Add( Where );
  DMBaseDatos.QListado.SQL.Add( ' order by empresa_em, centro_em, cod_proveedor_em, cod_operador_em, cod_producto_em, fecha_em ');
  try
    DMBaseDatos.QListado.Open;
    QRLEntradasEnvProveedor := TQRLEntradasEnvProveedor.Create(Application);
    try
      PonLogoGrupoBonnysa(QRLEntradasEnvProveedor);
      Preview(QRLEntradasEnvProveedor);
    except
      FreeAndNil(QRLEntradasEnvProveedor);
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

procedure TFMEntradasEnvProveedor.ARejillaFlotanteExecute(Sender: TObject);
var
  sResult: string;
begin
  if ActiveControl <> nil then
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCentro: DespliegaRejilla(btnCentro,[empresa_Em.Text]);
    kProveedor:
    begin
      if SeleccionaProveedor( self, cod_proveedor_em, empresa_em.Text, sResult ) then
      begin
        cod_proveedor_em.Text:= sResult;
      end;
    end;
    kEnvComerOperador: DespliegaRejilla(btnOperador);
    kEnvComerProducto: DespliegaRejilla(btnEnvase,[cod_operador_em.Text]);
    kCalendar: DespliegaCalendario(btnFecha);
    else
    begin
      if codigo_em.Focused then
      if SeleccionaAlbaranProveedor( self, codigo_em, empresa_em.Text, cod_proveedor_em.Text, fecha_em.Text, sResult ) then
      begin
        codigo_em.Text:= sResult;
      end;
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

procedure TFMEntradasEnvProveedor.AntesDeInsertar;
begin
  //
  cod_operador_em.Text:= sOperador;
  codigo_em.Text:= sReferencia;
  empresa_em.Text:= sEmpresa;
  centro_em.Text:= sCentro;
  cod_proveedor_em.Text:= sProveedor;
  fecha_em.Text:= sFecha;
end;

procedure TFMEntradasEnvProveedor.AntesDeModificar;
begin
  //
end;

procedure TFMEntradasEnvProveedor.AntesDeLocalizar;
begin
  //
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprovechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMEntradasEnvProveedor.AntesDeVisualizar;
begin
  //

  sOperador:= '';
  sReferencia:= '';
  sEmpresa:= '';
  sCentro:= '';
  sProveedor:= '';
  sFecha:= '';
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************
//Pone el nombre de la empresa al desplazarse por la tabla.

procedure TFMEntradasEnvProveedor.RequiredTime(Sender: TObject;
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

procedure TFMEntradasEnvProveedor.PonNombre(Sender: TObject);
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
      txtEmpresa.Caption:= desEmpresa( empresa_em.Text );
      txtCentro.Caption:= desCentro( empresa_em.Text, centro_em.Text );
      txtProveedor.Caption:= desProveedor( empresa_em.Text, cod_proveedor_em.Text );
    end;
    kCentro:
    begin
      txtCentro.Caption:= desCentro( empresa_em.Text, centro_em.Text );
    end;
    kProveedor:
    begin
      txtProveedor.Caption:= desProveedor( empresa_em.Text, cod_proveedor_em.Text );
    end;
    kEnvComerOperador:
    begin
      txtOperador.Caption := desEnvComerOperador(cod_operador_em.Text );
      txtEnvase.Caption := desEnvComerProducto(cod_operador_em.Text, cod_producto_em.Text );
    end;
    kEnvComerProducto:
      txtEnvase.Caption := desEnvComerProducto(cod_operador_em.Text, cod_producto_em.Text );
  end;
end;


procedure TFMEntradasEnvProveedor.codigo_emExit(Sender: TObject);
begin
  if ( Estado = teAlta ) and ( Trim( codigo_em.Text ) <> '' ) and ( Trim( empresa_em.Text ) = '' ) then
  begin
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add('select * from frf_entregas_c where codigo_Ec = :codigo');
      ParamByName('codigo').AsString:= Trim( codigo_em.Text );
      Open;
      if not IsEmpty then
      begin
        empresa_em.Text:= FieldByName('empresa_ec').AsString;
        centro_em.Text:= FieldByName('centro_llegada_ec').AsString;
        cod_proveedor_em.Text:= FieldByName('proveedor_ec').AsString;
        fecha_em.Text:= FieldByName('fecha_llegada_ec').AsString;
      end;
      Close;
    end;
  end;
end;

end.
