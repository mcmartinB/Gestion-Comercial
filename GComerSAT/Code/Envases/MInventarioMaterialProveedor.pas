unit MInventarioMaterialProveedor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbtables,
  DError, DBCtrls;

type
  TFMInventarioMaterialProveedor = class(TMaestro)
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    pnlMaestro: TPanel;
    QAjustes: TQuery;
    lbl1: TLabel;
    empresa_esm: TBDEdit;
    btnEmpresa: TBGridButton;
    txtEmpresa: TStaticText;
    lblLEmpresa_p: TLabel;
    centro_esm: TBDEdit;
    btnCentro: TBGridButton;
    txtCentro: TStaticText;
    lblNombre12: TLabel;
    cod_operador_esm: TBDEdit;
    btnOperador: TBGridButton;
    txtOperador: TStaticText;
    txtEnvase: TStaticText;
    btnEnvase: TBGridButton;
    cod_producto_esm: TBDEdit;
    lblEnvase: TLabel;
    lbl2: TLabel;
    fecha_esm: TBDEdit;
    btnFecha: TBCalendarButton;
    lbl3: TLabel;
    stock_esm: TBDEdit;
    lblHasta: TLabel;
    btnHasta: TBCalendarButton;
    edtHasta: TBEdit;
    lbl4: TLabel;
    nota_esm: TBDEdit;
    lblProveedor: TLabel;
    cod_proveedor_esm: TBDEdit;
    btnProveedor: TBGridButton;
    txtProveedor: TStaticText;
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
  CAuxiliarDB, Principal, LInventarioMaterialProveedor, DPreview, bSQLUtils, UDMConfig,
  UFProveedores;

{$R *.DFM}

procedure TFMInventarioMaterialProveedor.AbrirTablas;
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

procedure TFMInventarioMaterialProveedor.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuery(DataSetMaestro);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMInventarioMaterialProveedor.FormCreate(Sender: TObject);
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
 {+}Select := ' SELECT * FROM  frf_entregas_stock_mat ';
 {+}where := ' WHERE empresa_esm=' + QUOTEDSTR('###');
 {+}Order := ' ORDER BY fecha_esm desc, empresa_esm, centro_esm, cod_proveedor_esm, cod_operador_esm, cod_producto_esm ';

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;

     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_esm.Tag := kEmpresa;
  centro_esm.Tag := kCentro;
  cod_proveedor_esm.Tag := kProveedor;
  cod_operador_esm.Tag:= kEnvComerOperador;
  cod_producto_esm.Tag:= kEnvComerProducto;
  fecha_esm.Tag:= kCalendar;
  edtHasta.Tag:= kCalendar;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnEdit := AntesDeModificar;
  OnBrowse:= AntesDeLocalizar;
  OnView := AntesDeVisualizar;

     //Focos
  {+}FocoAltas := empresa_esm;
  {+}FocoModificar := stock_esm;
  {+}FocoLocalizar := empresa_esm;

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


procedure TFMInventarioMaterialProveedor.FormActivate(Sender: TObject);
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


procedure TFMInventarioMaterialProveedor.FormDeactivate(Sender: TObject);
begin
  Exit;

  //Desahabilitamos controles de Base de datos
  //mientras estamos desactivados
  DataSetMaestro.DisableControls;

 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;

  //CerrarTablas;
end;

procedure TFMInventarioMaterialProveedor.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMInventarioMaterialProveedor.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMInventarioMaterialProveedor.Filtro;
var
  Flag: Boolean;
  dIni, dFin: TDateTime;
begin
  where := '';
  Flag := false;

  if empresa_esm.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' empresa_esm LIKE ' + SQLFilter(empresa_esm.Text);
    flag := True;
  end;
  if centro_esm.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' centro_esm LIKE ' + SQLFilter(centro_esm.Text);
    flag := True;
  end;
  if cod_proveedor_esm.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' cod_proveedor_esm LIKE ' + SQLFilter(cod_proveedor_esm.Text);
    flag := True;
  end;
  if cod_operador_esm.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' cod_operador_esm LIKE ' + SQLFilter(cod_operador_esm.Text);
    flag := True;
  end;
  if cod_producto_esm.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' cod_producto_esm LIKE ' + SQLFilter(cod_producto_esm.Text);
    flag := True;
  end;

  if TryStrToDate( edtHasta.Text, dFin ) then
  begin
    if TryStrToDate( fecha_esm.Text, dIni ) then
    begin
      if dIni > dFin then
      begin
        if flag then
          where := where + ' and ';
        where := where + ' fecha_esm between ' + SQLDate(fecha_esm.Text) + ' and ' + SQLDate(edtHasta.Text);
        flag := True;
      end
      else
      begin
        if flag then
          where := where + ' and ';
        where := where + ' fecha_esm between ' + SQLDate(fecha_esm.Text) + ' and ' + SQLDate(edtHasta.Text);
        flag := True;
      end;
    end
    else
    begin
      if flag then
        where := where + ' and ';
      where := where + ' fecha_esm = ' + SQLDate(edtHasta.Text);
      flag := True;
    end;
  end
  else
  if TryStrToDate( fecha_esm.Text, dIni ) then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' fecha_esm = ' + SQLDate(fecha_esm.Text);
    flag := True;
  end;


  if stock_esm.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' stock_esm = ' + SQLNumeric(stock_esm.Text);
    flag := True;
  end;

  if nota_esm.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' nota_esm LIKE ' + SQLFilter(nota_esm.Text);
    flag := True;
  end;

  if flag then
    where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFMInventarioMaterialProveedor.AnyadirRegistro;
begin
  if where <> '' then
    where := where + ' OR ('
  else
    where := ' WHERE (';

  if empresa_esm.Text <> '' then
  begin
    where := where + ' empresa_esm = ' + QuotedStr(empresa_esm.Text);
  end;
  if centro_esm.Text <> '' then
  begin
    where := where + ' and centro_esm = ' + QuotedStr(centro_esm.Text);
  end;
  if cod_proveedor_esm.Text <> '' then
  begin
    where := where + ' and cod_proveedor_esm = ' + QuotedStr(cod_proveedor_esm.Text);
  end;
  if cod_operador_esm.Text <> '' then
  begin
    where := where + ' and cod_operador_esm = ' + QuotedStr(cod_operador_esm.Text);
  end;
  if cod_producto_esm.Text <> '' then
  begin
    where := where + ' and cod_producto_esm = ' + QuotedStr(cod_producto_esm.Text);
  end;
  if fecha_esm.Text <> '' then
  begin
    where := where + ' and fecha_esm = ' + SQLDate(fecha_esm.Text);
  end;
  where := where + ') ';
end;

{+}//Sustituir por funcion generica

procedure TFMInventarioMaterialProveedor.ValidarEntradaMaestro;
var
  dAux : TDateTime;
begin
  if TxtEmpresa.Caption = '' then
  begin
    empresa_esm.Focused;
    raise Exception.Create('Falta el código de le empresa o es incorrecto.');
  end;
  if txtCentro.Caption = '' then
  begin
    centro_esm.Focused;
    raise Exception.Create('Falta el código del centro o es incorrecto.');
  end;
  if txtProveedor.Caption = '' then
  begin
    cod_proveedor_esm.Focused;
    raise Exception.Create('Falta el código del proveedor o es incorrecto.');
  end;
  if txtOperador.Caption = '' then
  begin
    cod_operador_esm.Focused;
    raise Exception.Create('Falta el código del operador o es incorrecto.');
  end;
  if txtEnvase.Caption = '' then
  begin
    cod_producto_esm.Focused;
    raise Exception.Create('Falta el código del artículo o es incorrecto.');
  end;
  if not TryStrToDate( fecha_esm.Text, dAux ) then
  begin
    fecha_esm.Focused;
    raise Exception.Create('Falta la fecha del ajuste o es incorrectao.');
  end;
  if stock_esm.Text = '' then
  begin
    stock_esm.Text:= '0';
  end;

end;

procedure TFMInventarioMaterialProveedor.Previsualizar;
begin
  //Crear el listado
  DMBaseDatos.QListado.SQL.Clear;
  DMBaseDatos.QListado.SQL.Add( Select );
  DMBaseDatos.QListado.SQL.Add( Where );
  DMBaseDatos.QListado.SQL.Add( ' order by empresa_esm, centro_esm, cod_proveedor_esm, cod_operador_esm, cod_producto_esm, fecha_esm ');
  try
    DMBaseDatos.QListado.Open;
    QRLInventarioMaterialProveedor := TQRLInventarioMaterialProveedor.Create(Application);
    try
      PonLogoGrupoBonnysa(QRLInventarioMaterialProveedor );
      Preview(QRLInventarioMaterialProveedor);
    except
      FreeAndNil(QRLInventarioMaterialProveedor);
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

procedure TFMInventarioMaterialProveedor.ARejillaFlotanteExecute(Sender: TObject);
var
  sResult: string;
begin
  if ActiveControl <> nil then
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCentro: DespliegaRejilla(btnCentro, [empresa_esm.Text]);
    kProveedor:
    begin
      if SeleccionaProveedor( self, cod_proveedor_esm, empresa_esm.Text, sResult ) then
      begin
        cod_proveedor_esm.Text:= sResult;
      end;
    end;
    kEnvComerOperador: DespliegaRejilla(btnOperador);
    kEnvComerProducto: DespliegaRejilla(btnEnvase,[cod_operador_esm.Text]);
    kCalendar:
    begin
      if fecha_esm.Focused then
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

procedure TFMInventarioMaterialProveedor.AntesDeModificar;
begin
  empresa_esm.Enabled:= False;
  centro_esm.Enabled:= False;
end;

procedure TFMInventarioMaterialProveedor.AntesDeLocalizar;
begin
  lblHasta.Visible:= True;
  edtHasta.Visible:= True;
  btnHasta.Visible:= True;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprovechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMInventarioMaterialProveedor.AntesDeVisualizar;
begin
  edtHasta.Text:= '';
  lblHasta.Visible:= False;
  edtHasta.Visible:= False;
  btnHasta.Visible:= False;

  empresa_esm.Enabled:= True;
  centro_esm.Enabled:= True;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************
//Pone el nombre de la empresa al desplazarse por la tabla.

procedure TFMInventarioMaterialProveedor.RequiredTime(Sender: TObject;
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

procedure TFMInventarioMaterialProveedor.PonNombre(Sender: TObject);
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
        txtEmpresa.Caption := desEmpresa(empresa_esm.Text);
        txtCentro.Caption := desCentro(empresa_esm.Text, centro_esm.Text);
        txtProveedor.Caption := desCentro(empresa_esm.Text, cod_proveedor_esm.Text);
      end;
    kCentro:
      txtCentro.Caption := desCentro(empresa_esm.Text, centro_esm.Text);
    kProveedor:
      txtProveedor.Caption := desProveedor(empresa_esm.Text, cod_proveedor_esm.Text);
    kEnvComerOperador:
    begin
      txtOperador.Caption := desEnvComerOperador(cod_operador_esm.Text );
      txtEnvase.Caption := desEnvComerProducto(cod_operador_esm.Text, cod_producto_esm.Text );
    end;
    kEnvComerProducto:
      txtEnvase.Caption := desEnvComerProducto(cod_operador_esm.Text, cod_producto_esm.Text );
  end;
end;

end.
