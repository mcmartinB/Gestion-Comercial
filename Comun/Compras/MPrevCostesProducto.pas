unit MPrevCostesProducto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbtables,
  DError, DBCtrls;

type
  TFMPrevCostesProducto = class(TMaestro)
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    pnlMaestro: TPanel;
    QAjustes: TQuery;
    lbl1: TLabel;
    empresa_pcp: TBDEdit;
    btnEmpresa: TBGridButton;
    stEmpresa: TStaticText;
    stProducto: TStaticText;
    btnProducto: TBGridButton;
    producto_pcp: TBDEdit;
    lblEnvase: TLabel;
    lbl2: TLabel;
    fecha_ini_pcp: TBDEdit;
    btnFechaIni: TBCalendarButton;
    lbl3: TLabel;
    coste_transporte_pcp: TBDEdit;
    lblHasta: TLabel;
    fecha_fin_pcp: TBDEdit;
    btnFechaFin: TBCalendarButton;
    lbl5: TLabel;
    coste_primera_pcp: TBDEdit;
    lbl4: TLabel;
    lbl6: TLabel;
    lblPrimera: TLabel;
    lbl7: TLabel;
    coste_extra_pcp: TBDEdit;
    lbl8: TLabel;
    coste_super_pcp: TBDEdit;
    lblResto: TLabel;
    coste_resto_pcp: TBDEdit;
    chkFichasActivas: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure PonNombre(Sender: TObject);
    procedure QAjustesAfterDelete(DataSet: TDataSet);
    procedure QAjustesAfterPost(DataSet: TDataSet);
    procedure QAjustesBeforeDelete(DataSet: TDataSet);
    procedure QAjustesBeforePost(DataSet: TDataSet);
    procedure QAjustesBeforeEdit(DataSet: TDataSet);
    procedure QAjustesBeforeInsert(DataSet: TDataSet);
  private
    { Private declarations }
    sEmpresa, sFechaIni, sProducto: string;

    (* INICIO: GESTION FECHA FIN *)

    dFechaIniNew: TDateTime;
    sEmpresaNew, sProductoNew: string;

    dFechaIniOld, dFechaFinOld: TDateTime;
    sEmpresaOld, sProductoOld: string;

    bAlta, bFechaFinOld: Boolean;

    procedure AltaPrevisionFechaFin( const AEmpresa, AProducto: string;
                               const AFechaIni: TDateTime );
    procedure BorrarPrevisionFechaFin( const AEmpresa, AProducto: string;
                               const AFechaIni, AFechaFin: TDateTime;
                               const AFlagFecha: Boolean );

    (* FIN: GESTION FECHA FIN *)

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
  CAuxiliarDB, Principal, LPrevCostesProducto, DPreview, bSQLUtils,
  UDMConfig, Variants;

{$R *.DFM}

procedure TFMPrevCostesProducto.AbrirTablas;
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

procedure TFMPrevCostesProducto.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuery(DataSetMaestro);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMPrevCostesProducto.FormCreate(Sender: TObject);
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
 {+}Select := ' SELECT * FROM  frf_prev_costes_producto ';
 {+}where := ' WHERE empresa_pcp=' + QUOTEDSTR('###');
 {+}Order := ' ORDER BY fecha_ini_pcp desc, empresa_pcp,  producto_pcp ';

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;

     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_pcp.Tag := kEmpresa;
  producto_pcp.Tag:= kProducto;
  fecha_ini_pcp.Tag:= kCalendar;
  fecha_fin_pcp.Tag:= kCalendar;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnInsert:= AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnBrowse:= AntesDeLocalizar;
  OnView := AntesDeVisualizar;

     //Focos
  {+}FocoAltas := empresa_pcp;
  {+}FocoModificar := coste_primera_pcp;
  {+}FocoLocalizar := empresa_pcp;

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


procedure TFMPrevCostesProducto.FormActivate(Sender: TObject);
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


procedure TFMPrevCostesProducto.FormDeactivate(Sender: TObject);
begin
  Exit;

  //Desahabilitamos controles de Base de datos
  //mientras estamos desactivados
  DataSetMaestro.DisableControls;

 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;

  //CerrarTablas;
end;

procedure TFMPrevCostesProducto.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMPrevCostesProducto.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMPrevCostesProducto.Filtro;
var
  Flag: Boolean;
  dIni, dFin: TDateTime;
begin
  where := '';
  Flag := false;

  if empresa_pcp.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' empresa_pcp LIKE ' + SQLFilter(empresa_pcp.Text);
    flag := True;
  end;
  if producto_pcp.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' producto_pcp LIKE ' + SQLFilter(producto_pcp.Text);
    flag := True;
  end;

  if TryStrToDate( fecha_fin_pcp.Text, dFin ) then
  begin
    if TryStrToDate( fecha_ini_pcp.Text, dIni ) then
    begin
      if dIni > dFin then
      begin
        raise Exception.Create('Rango de fechas incorrecto.');
      end
      else
      begin
        if flag then
          where := where + ' and ';
        where := where + ' ( fecha_ini_pcp between ' + SQLDate(fecha_ini_pcp.Text) + ' and ' + SQLDate(fecha_fin_pcp.Text);
        where := where + '   or ';
        where := where + '   fecha_fin_pcp between ' + SQLDate(fecha_ini_pcp.Text) + ' and ' + SQLDate(fecha_fin_pcp.Text) + ')';
        flag := True;
      end;
    end
    else
    begin
      if flag then
        where := where + ' and ';
      where := where + ' fecha_fin_pcp = ' + SQLDate(fecha_fin_pcp.Text);
      flag := True;
    end;
  end
  else
  if TryStrToDate( fecha_ini_pcp.Text, dIni ) then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' fecha_ini_pcp = ' + SQLDate(fecha_ini_pcp.Text);
    flag := True;
  end;

  if coste_primera_pcp.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' coste_primera_pcp = ' + SQLNumeric(coste_primera_pcp.Text);
    flag := True;
  end;

  if coste_extra_pcp.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' coste_extra_pcp = ' + SQLNumeric(coste_extra_pcp.Text);
    flag := True;
  end;

  if coste_super_pcp.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' coste_super_pcp = ' + SQLNumeric(coste_super_pcp.Text);
    flag := True;
  end;

  if coste_resto_pcp.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' coste_resto_pcp = ' + SQLNumeric(coste_resto_pcp.Text);
    flag := True;
  end;

  if coste_transporte_pcp.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' coste_transporte_pcp = ' + SQLNumeric(coste_transporte_pcp.Text);
    flag := True;
  end;

  if chkFichasActivas.Checked then
  begin
    if flag then
      where := where + ' and ';
    where := where + ' fecha_fin_pcp is null ';
    flag := True;
  end;

  if flag then
    where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFMPrevCostesProducto.AnyadirRegistro;
begin
  if where <> '' then
    where := where + ' OR ('
  else
    where := ' WHERE (';

  if empresa_pcp.Text <> '' then
  begin
    where := where + ' empresa_pcp = ' + QuotedStr(empresa_pcp.Text);
  end;
  if producto_pcp.Text <> '' then
  begin
    where := where + ' and producto_pcp = ' + QuotedStr(producto_pcp.Text);
  end;
  if fecha_ini_pcp.Text <> '' then
  begin
    where := where + ' and fecha_ini_pcp = ' + SQLDate(fecha_ini_pcp.Text);
  end;
  where := where + ') ';
end;

{+}//Sustituir por funcion generica

procedure TFMPrevCostesProducto.ValidarEntradaMaestro;
var
    dAux: TDateTime;
    rAux: Extended;
begin
  if stEmpresa.Caption = '' then
  begin
    empresa_pcp.Focused;
    raise Exception.Create('Falta el código de le empresa o es incorrecto.');
  end;
  if stProducto.Caption = '' then
  begin
    producto_pcp.Focused;
    raise Exception.Create('Falta el código del producto o es incorrecto.');
  end;
  if not TryStrToDate( fecha_ini_pcp.Text, dAux ) then
  begin
    fecha_ini_pcp.Focused;
    raise Exception.Create('Falta la fecha del inicio o es incorrecta.');
  end;

  if not TryStrToFloat(coste_primera_pcp.Text, rAux ) then
  begin
    coste_primera_pcp.Focused;
    raise Exception.Create('Falta el coste de la primera o es incorrecto.');
  end;

  if not TryStrToFloat(coste_extra_pcp.Text, rAux ) then
  begin
    coste_extra_pcp.Focused;
    raise Exception.Create('Falta el coste de la extra o es incorrecto.');
  end;

  if not TryStrToFloat(coste_super_pcp.Text, rAux ) then
  begin
    coste_super_pcp.Focused;
    raise Exception.Create('Falta el coste de la super o es incorrecto.');
  end;

  if not TryStrToFloat(coste_resto_pcp.Text, rAux ) then
  begin
    coste_resto_pcp.Focused;
    raise Exception.Create('Falta el coste del resto o es incorrecto.');
  end;
  QAjustes.FieldByname('coste_platano10_pcp').AsFloat:= QAjustes.FieldByname('coste_resto_pcp').AsFloat;
  QAjustes.FieldByname('coste_platanost_pcp').AsFloat:= QAjustes.FieldByname('coste_resto_pcp').AsFloat;

  if not TryStrToFloat(coste_transporte_pcp.Text, rAux ) then
  begin
    coste_transporte_pcp.Focused;
    raise Exception.Create('Falta el coste del transporte o es incorrecto.');
  end;

  sEmpresa:= empresa_pcp.Text;
  sProducto:= producto_pcp.Text;
  sFechaIni:= fecha_ini_pcp.Text;

end;

procedure TFMPrevCostesProducto.Previsualizar;
begin
  //Crear el listado
  DMBaseDatos.QListado.SQL.Clear;
  DMBaseDatos.QListado.SQL.Add( Select );
  DMBaseDatos.QListado.SQL.Add( Where );
  DMBaseDatos.QListado.SQL.Add( ' order by empresa_pcp, producto_pcp, fecha_ini_pcp ');
  try
    DMBaseDatos.QListado.Open;
    QRLPrevCostesProducto := TQRLPrevCostesProducto.Create(Application);
    try
      //PonLogoGrupoBonnysa(QRLPrevCostesProducto);
      Preview(QRLPrevCostesProducto);
    except
      FreeAndNil(QRLPrevCostesProducto);
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

procedure TFMPrevCostesProducto.ARejillaFlotanteExecute(Sender: TObject);
begin
  if ActiveControl <> nil then
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kProducto: DespliegaRejilla(btnProducto,[empresa_pcp.text]);
    kCalendar:
    begin
      if fecha_ini_pcp.Focused then
        DespliegaCalendario(btnFechaIni)
      else
      if fecha_fin_pcp.Focused then
        DespliegaCalendario(btnFechaFin);
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

procedure TFMPrevCostesProducto.AntesDeInsertar;
begin
  //
  empresa_pcp.Text:= sEmpresa;
  producto_pcp.Text:= sProducto;
  fecha_ini_pcp.Text:= sFechaIni;
  //producto_pcp.Text:= sProducto;
end;

procedure TFMPrevCostesProducto.AntesDeModificar;
begin
  //
end;

procedure TFMPrevCostesProducto.AntesDeLocalizar;
begin
  lblHasta.Enabled:= True;
  fecha_fin_pcp.Enabled:= True;
  btnFechaFin.Enabled:= True;
  chkFichasActivas.Checked:= false;
  chkFichasActivas.Visible:= True;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprovechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMPrevCostesProducto.AntesDeVisualizar;
begin
  lblHasta.Enabled:= False;
  fecha_fin_pcp.Enabled:= False;
  btnFechaFin.Enabled:= False;
  chkFichasActivas.Visible:= False;

  sEmpresa:= '';
  sProducto:= '';
  sFechaIni:= '';
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************
//Pone el nombre de la empresa al desplazarse por la tabla.

procedure TFMPrevCostesProducto.RequiredTime(Sender: TObject;
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

procedure TFMPrevCostesProducto.PonNombre(Sender: TObject);
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
        stEmpresa.Caption := desEmpresa(empresa_pcp.Text);
        stProducto.Caption := desProducto(empresa_pcp.Text, producto_pcp.Text );
      end;

    kProducto:
      stProducto.Caption := desProducto(empresa_pcp.Text, producto_pcp.Text );

  end;
end;

procedure TFMPrevCostesProducto.QAjustesBeforeDelete(DataSet: TDataSet);
begin
  sEmpresaOld:= QAjustes.FieldByName('empresa_pcp').AsString;
  sProductoOld:= QAjustes.FieldByName('producto_pcp').AsString;
  dFechaIniOld:= QAjustes.FieldByName('fecha_ini_pcp').AsDateTime;
  if QAjustes.FieldByName('fecha_fin_pcp').Value = Null then
  begin
    bFechaFinOld:= False
  end
  else
  begin
    bFechaFinOld:= True;
    dFechaFinOld:= QAjustes.FieldByName('fecha_fin_pcp').AsDateTime;
  end;
end;

procedure TFMPrevCostesProducto.QAjustesAfterDelete(DataSet: TDataSet);
begin
  BorrarPrevisionFechaFin( sEmpresaOld, sProductoOld, dFechaIniOld, dFechaFinOld, bFechaFinOld );
end;

procedure TFMPrevCostesProducto.BorrarPrevisionFechaFin( const AEmpresa, AProducto: string;
                                  const AFechaIni, AFechaFin: TDateTime;
                                  const AFlagFecha: Boolean );
var
  dAux: TDateTime;
begin
  //Corregir fecha fin
  with DMAuxDB.QAux do
  begin
     //hay registros por abajo
     SQL.Clear;
     SQL.Add(' select * ');
     SQL.Add(' from frf_prev_costes_producto ');
     SQL.Add(' where empresa_pcp = :empresa ');
     SQL.Add(' and producto_pcp = :producto ');
     SQL.Add(' and fecha_ini_pcp < :fecha ');
     SQL.Add(' order by fecha_ini_pcp desc ');
     ParamByName('empresa').AsString:= AEmpresa;
     ParamByName('producto').AsString:= AProducto;
     ParamByName('fecha').AsDateTime:= AFechaIni;
     Open;
     if not IsEmpty then
     begin
       //Actualizar fecha fin registro recien encontrado
       dAux:= FieldByName('fecha_ini_pcp').AsDateTime;
       Close;

       SQL.Clear;
       SQL.Add(' update frf_prev_costes_producto ');
       if AFlagFecha  then
         SQL.Add(' set fecha_fin_pcp = :fecha_fin ')
       else
         SQL.Add(' set fecha_fin_pcp = NULL ');
       SQL.Add(' where empresa_pcp = :empresa ');
       SQL.Add(' and producto_pcp = :producto ');
       SQL.Add(' and fecha_ini_pcp = :fecha ');
       ParamByName('empresa').AsString:= AEmpresa;
       ParamByName('producto').AsString:= AProducto;
       ParamByName('fecha').AsDateTime:= dAux;
       if AFlagFecha then
         ParamByName('fecha_fin').AsDateTime:= AFechaFin;
       ExecSQL;
     end
     else
     begin
       Close;
     end;

  end;
end;

procedure TFMPrevCostesProducto.QAjustesBeforeInsert(DataSet: TDataSet);
begin
  bAlta:= False;
end;

procedure TFMPrevCostesProducto.QAjustesBeforeEdit(DataSet: TDataSet);
begin
  bAlta:= False;
  sEmpresaOld:= QAjustes.FieldByName('empresa_pcp').AsString;
  sProductoOld:= QAjustes.FieldByName('producto_pcp').AsString;
  dFechaIniOld:= QAjustes.FieldByName('fecha_ini_pcp').AsDateTime;
  if QAjustes.FieldByName('fecha_fin_pcp').Value = Null then
  begin
    bFechaFinOld:= False
  end
  else
  begin
    bFechaFinOld:= True;
    dFechaFinOld:= QAjustes.FieldByName('fecha_fin_pcp').AsDateTime;
  end;
end;

procedure TFMPrevCostesProducto.QAjustesBeforePost(DataSet: TDataSet);
begin
  sEmpresaNew:= QAjustes.FieldByName('empresa_pcp').AsString;
  sProductoNew:= QAjustes.FieldByName('producto_pcp').AsString;
  dFechaIniNew:= QAjustes.FieldByName('fecha_ini_pcp').AsDateTime;
end;

procedure TFMPrevCostesProducto.QAjustesAfterPost(DataSet: TDataSet);
begin
  if bAlta then
  begin
    AltaPrevisionFechaFin( sEmpresaNew, sProductoNew, dFechaIniNew );
  end
  else
  begin
    BorrarPrevisionFechaFin( sEmpresaOld, sProductoOld, dFechaIniOld, dFechaFinOld, bFechaFinOld );
    AltaPrevisionFechaFin( sEmpresaNew, sProductoNew, dFechaIniNew );
  end;
end;

procedure TFMPrevCostesProducto.AltaPrevisionFechaFin( const AEmpresa, AProducto: string;
                               const AFechaIni: TDateTime );
var
  dAux: TDateTime;
begin
  //Corregir fecha fin
  with DMAuxDB.QAux do
  begin
     //hay registros por arriba
     SQL.Clear;
     SQL.Add(' select * ');
     SQL.Add(' from frf_prev_costes_producto ');
     SQL.Add(' where empresa_pcp = :empresa ');
     SQL.Add(' and producto_pcp = :producto ');
     SQL.Add(' and fecha_ini_pcp > :fecha ');
     SQL.Add(' order by fecha_ini_pcp asc ');
     ParamByName('empresa').AsString:= AEmpresa;
     ParamByName('producto').AsString:= AProducto;
     ParamByName('fecha').AsDateTime:= AFechaIni;
     Open;
     if not IsEmpty then
     begin
       //Actualizar fecha fin nuevo registro
       dAux:= FieldByName('fecha_ini_pcp').AsDateTime;
       Close;

       SQL.Clear;
       SQL.Add(' update frf_prev_costes_producto ');
       SQL.Add(' set fecha_fin_pcp = :fecha_fin ');
       SQL.Add(' where empresa_pcp = :empresa ');
       SQL.Add(' and producto_pcp = :producto ');
       SQL.Add(' and fecha_ini_pcp = :fecha ');
       ParamByName('empresa').AsString:= AEmpresa;
       ParamByName('producto').AsString:= AProducto;
       ParamByName('fecha').AsDateTime:= AFechaIni;
       ParamByName('fecha_fin').AsDateTime:= dAux - 1;
       ExecSQL;
     end
     else
     begin
       Close;
     end;


     //hay registros por abajo
     SQL.Clear;
     SQL.Add(' select * ');
     SQL.Add(' from frf_prev_costes_producto ');
     SQL.Add(' where empresa_pcp = :empresa ');
     SQL.Add(' and producto_pcp = :producto ');
     SQL.Add(' and fecha_ini_pcp < :fecha ');
     SQL.Add(' order by fecha_ini_pcp desc ');
     ParamByName('empresa').AsString:= AEmpresa;
     ParamByName('producto').AsString:= AProducto;
     ParamByName('fecha').AsDateTime:= AFechaIni;
     Open;
     if not IsEmpty then
     begin
       //Actualizar fecha fin registro recien encontrado
       dAux:= FieldByName('fecha_ini_pcp').AsDateTime;
       Close;

       SQL.Clear;
       SQL.Add(' update frf_prev_costes_producto ');
       SQL.Add(' set fecha_fin_pcp = :fecha_fin ');
       SQL.Add(' where empresa_pcp = :empresa ');
       SQL.Add(' and producto_pcp = :producto ');
       SQL.Add(' and fecha_ini_pcp = :fecha ');
       ParamByName('empresa').AsString:= AEmpresa;
       ParamByName('producto').AsString:= AProducto;
       ParamByName('fecha').AsDateTime:= dAux;
       ParamByName('fecha_fin').AsDateTime:= AFechaIni - 1;
       ExecSQL;
     end
     else
     begin
       Close;
     end;
  end;
end;

end.
