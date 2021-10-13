unit MCostesIndirectos;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms, Dialogs, Db, ExtCtrls, BDEdit,
  StdCtrls, CMaestro, ComCtrls, BEdit, DError, Controls, DBTables, nbEdits,
  nbCombos, nbLabels, DBCtrls, Grids, DBGrids;

type
  TFMCostesIndirectos = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    LPlantacion_p: TLabel;
    LEmpresa_p: TLabel;
    Label13: TLabel;
    QCostesIndirectos: TQuery;
    produccion_ci: TBDEdit;
    Label1: TLabel;
    Label3: TLabel;
    desEmpresa_ci: TnbStaticText;
    desCentro_ci: TnbStaticText;
    empresa_ci: TnbDBSQLCombo;
    centro_origen_ci: TnbDBSQLCombo;
    fecha_ini_ci: TnbDBCalendarCombo;
    lblNombre1: TLabel;
    comercial_ci: TBDEdit;
    lblNombre2: TLabel;
    administracion_ci: TBDEdit;
    QAux: TQuery;
    lblNombre3: TLabel;
    fecha_fin_ci: TDBText;
    Bevel1: TBevel;
    dbgCostes: TDBGrid;
    qGuia: TQuery;
    dsGuia: TDataSource;
    sqluGuia: TUpdateSQL;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject;
      var isTime: Boolean);
    procedure empresa_emcChange(Sender: TObject);
    procedure centro_emcChange(Sender: TObject);
    function centro_origen_ciGetSQL: String;
    procedure QCostesIndirectosBeforePost(DataSet: TDataSet);
    procedure qGuiaAfterOpen(DataSet: TDataSet);
    procedure qGuiaBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

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
  end;

implementation

uses CVariables, UDMBaseDatos, Principal, LCostesIndirectos, CReportes,
  CGestionPrincipal, DPreview, bSQLUtils, udmauxdb, CGlobal;

{$R *.DFM}

procedure TFMCostesIndirectos.AbrirTablas;
begin
  if not DataSetGuia.Active then
  begin
    DataSetGuia.SQL.Clear;
    DataSetGuia.SQL.Add(Select);
    DataSetGuia.SQL.Add(Where);
    DataSetGuia.SQL.Add(Order);
    DataSetGuia.Open;
  end;
     //Estado inicial
  Registro := 1;
  Registros := DataSetGuia.RecordCount;
  RegistrosInsertados := 0;
end;

procedure TFMCostesIndirectos.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetGuia]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMCostesIndirectos.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
  PMaestro.Height:= 82;

     //Fuente de datos maestro
    DataSetGuia := qGuia;
 {+}DataSetMaestro := QCostesIndirectos;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT empresa_ci, centro_origen_ci FROM frf_costes_indirectos ';
 {+}where := ' WHERE empresa_ci = ' + QuotedStr('##');
 {+}Order := ' GROUP BY empresa_ci, centro_origen_ci ORDER BY empresa_ci, centro_origen_ci  ';
     //Abrir tablas/Querys
  try
    AbrirTablas;
  except
    on e: EDBEngineError do
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
     //Estado inicial
  Visualizar;
     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(pcNulo);


     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnBrowse := AntesDeLocalizar;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;
     //Focos
  FocoAltas := empresa_ci;
  FocoModificar := comercial_ci;
  FocoLocalizar := empresa_ci;


  if CGlobal.gProgramVersion = CGlobal.pvBag then
  begin
    dbgCostes.Columns[2].Title.Caption:= 'Coste Estructural';
    dbgCostes.Columns[3].Visible:= False;
    dbgCostes.Columns[4].Visible:= False;

    lblNombre1.Caption:= 'Coste Kg Estructural';
    Label1.Visible:= False;
    lblNombre2.Visible:= False;
    produccion_ci.Visible:= False;
    administracion_ci.Visible:= False;

    Caption:= '    IMPORTE COSTES ESTRUCTURA';
  end;
end;

procedure TFMCostesIndirectos.FormActivate(Sender: TObject);
begin
  if not DataSetMaestro.Active then Exit;
  //Variables globales
  M := Self;
  MD := nil;

  //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;

  //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;


procedure TFMCostesIndirectos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Lista.Free;
     //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
     //Codigo de desactivacion
  CerrarTablas;

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMCostesIndirectos.FormKeyDown(Sender: TObject; var Key: Word;
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
//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que concuerdan
//con los capos que hemos rellenado

procedure TFMCostesIndirectos.Filtro;
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
    end
    else
    if (objeto is TnbDBSQLCombo) then
    begin
      with Objeto as TnbDBSQLCombo do
      begin
        if Trim(Text) <> '' then
        begin
          if flag then where := where + ' and ';
          where := where + ' ' + name + ' = ' + QuotedStr(Text);
          flag := True;
        end;
      end;
    end
    else
    if (objeto is TnbDBCalendarCombo) then
    begin
      with Objeto as TnbDBCalendarCombo do
      begin
        if Trim(Text) <> '' then
        begin
          if flag then where := where + ' and ';
          where := where + ' ' + name + ' = ' + QuotedStr(Text);
          flag := True;
        end;
      end;
    end;
  end;
  if flag then where := ' WHERE ' + where;
end;

//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que son insertados
//para, else fin usa los campos que marcamos como PrimaryKey

procedure TFMCostesIndirectos.AnyadirRegistro;
begin
  if where <> '' then where := where + ' OR ('
  else where := ' WHERE (';
  where := where + ' empresa_ci =' + QuotedStr( empresa_ci.Text );
  where := where + ' and centro_origen_ci =' + QuotedStr( centro_origen_ci.Text );
  where := where + ' and fecha_ini_ci =' + SQLDate( fecha_ini_ci.Text );
  where := where + ') ';
end;


//function semi-generica, introducir restricciones particulares donde se indica
//Conprueba que tengan valor todos los campos marcados como required

procedure TFMCostesIndirectos.ValidarEntradaMaestro;
var
  dAux: TDateTime;
  rAux: Extended;
begin
  if desEmpresa_ci.Caption = '' then
  begin
    empresa_ci.SetFocus;
    raise Exception.Create('Falta el código de la empresa o es incorrecto.');
  end;
  if desCentro_ci.Caption = '' then
  begin
    centro_origen_ci.SetFocus;
    raise Exception.Create('Falta el código del centro o es incorrecto.');
  end;
  if not TryStrToDate( fecha_ini_ci.Text, dAux ) then
  begin
    fecha_ini_ci.SetFocus;
    raise Exception.Create('Falta la fecha de inicio o es incorrecta.');
  end;
  if not TryStrToFloat( comercial_ci.Text, rAux ) then
  begin
    comercial_ci.SetFocus;
    raise Exception.Create('Falta o es incorrecto el coste comercial.');
  end;
  if CGlobal.gProgramVersion = CGlobal.pvSAT then
  begin
    if not TryStrToFloat( produccion_ci.Text, rAux ) then
    begin
      produccion_ci.SetFocus;
      raise Exception.Create('Falta o es incorrecto el coste de producción.');
    end;
    if not TryStrToFloat( administracion_ci.Text, rAux ) then
    begin
      administracion_ci.SetFocus;
      raise Exception.Create('Falta o es incorrecto el coste administrativo.');
    end;
  end
  else
  begin
    produccion_ci.Text:= '0';
    administracion_ci.Text:= '0';
  end;

  with QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_costes_indirectos ');
    SQL.Add(' where empresa_ci = :empresa ');
    SQL.Add('   and centro_origen_ci = :centro ');
    SQL.Add('   and fecha_ini_ci = :fecha ');
    ParamByName('empresa').AsString:= empresa_ci.Text;
    ParamByName('centro').AsString:= centro_origen_ci.Text;
    ParamByName('fecha').AsDateTime:= fecha_ini_ci.AsDate;
    Open;
    if not IsEmpty then
    begin
      Close;
      empresa_ci.SetFocus;
      raise Exception.Create('Registro duplicado (Empresa/Centro/Fecha).');
    end;
    Close;
  end;
end;

//**************************************************************
//IMPRESION: Introducir QuickReport
//**************************************************************

procedure TFMCostesIndirectos.Previsualizar;
begin
     //Crear el listado
  QRLCostesIndirectos := TQRLCostesIndirectos.Create(Application);
  PonLogoGrupoBonnysa(QRLCostesIndirectos);
  QRLCostesIndirectos.QCostesEnvasado.SQL.Clear;
  QRLCostesIndirectos.QCostesEnvasado.SQL.Add('SELECT *');
  QRLCostesIndirectos.QCostesEnvasado.SQL.Add('FROM frf_costes_indirectos ');
  QRLCostesIndirectos.QCostesEnvasado.SQL.Add(WHERE);
  QRLCostesIndirectos.QCostesEnvasado.SQL.Add('ORDER BY empresa_ci, centro_origen_ci, fecha_ini_ci desc ');
  QRLCostesIndirectos.QCostesEnvasado.Open;
  Preview( QRLCostesIndirectos );
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMCostesIndirectos.AntesDeLocalizar;
begin
  PMaestro.Height:= 186;
end;

procedure TFMCostesIndirectos.AntesDeInsertar;
begin
  PMaestro.Height:= 186;
end;

procedure TFMCostesIndirectos.AntesDeModificar;
var i: Integer;
begin
  PMaestro.Height:= 186;
    //Deshabilitamos todos los componentes Modificable=False
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;
end;
//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMCostesIndirectos.AntesDeVisualizar;
var i: Integer;
begin
  PMaestro.Height:= 82;
    //Resaturamos estado controles
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          if Enabled = false then Enabled := true;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************
//Para saber cuando tenemos que obligar a que un campo sea requerido

procedure TFMCostesIndirectos.RequiredTime(Sender: TObject;
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

procedure TFMCostesIndirectos.empresa_emcChange(Sender: TObject);
begin
  desEmpresa_ci.Caption := desEmpresa(empresa_ci.Text);
  desCentro_ci.Caption := desCentro(empresa_ci.Text, centro_origen_ci.Text);
end;

procedure TFMCostesIndirectos.centro_emcChange(Sender: TObject);
begin
  desCentro_ci.Caption := desCentro(empresa_ci.Text, centro_origen_ci.Text);
end;

function TFMCostesIndirectos.centro_origen_ciGetSQL: String;
begin
  if empresa_ci.Text <> '' then
  begin
    result:= 'select centro_c, descripcion_c ';
    result:= result + ' from frf_centros ';
    result:= result + ' where empresa_c = ''' + empresa_ci.Text + '''';
    result:= result + ' order by 1 ';
  end
  else
  begin
    result:= 'select centro_c, descripcion_c ';
    result:= result + ' from frf_centros ';
    result:= result + ' order by 1 ';
  end;
end;

procedure TFMCostesIndirectos.QCostesIndirectosBeforePost(DataSet: TDataSet);
begin
  with QAux do
  begin
    //Fecha de fin nuevo registro
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_costes_indirectos ');
    SQL.Add(' where empresa_ci = :empresa ');
    SQL.Add('   and centro_origen_ci = :centro ');
    SQL.Add('   and fecha_ini_ci < :fecha ');
    SQL.Add(' order by fecha_ini_ci desc ');
    ParamByName('empresa').AsString:= DataSet.FieldByName('empresa_ci').AsString;
    ParamByName('centro').AsString:= DataSet.FieldByName('centro_origen_ci').AsString;
    ParamByName('fecha').AsDateTime:= DataSet.FieldByName('fecha_ini_ci').AsDateTime;
    Open;
    if not IsEmpty then
    begin
      if FieldByName('fecha_fin_ci').AsString <> '' then
      begin
        DataSet.FieldByName('fecha_fin_ci').AsDateTime:=
          FieldByName('fecha_fin_ci').AsDateTime;
      end;
      Edit;
      FieldByName('fecha_fin_ci').AsDateTime:= DataSet.FieldByName('fecha_ini_ci').AsDateTime - 1;
      Post;
    end
    else
    begin
      Close;
      SQL.Clear;
      SQL.Add(' select * ');
      SQL.Add(' from frf_costes_indirectos ');
      SQL.Add(' where empresa_ci = :empresa ');
      SQL.Add('   and centro_origen_ci = :centro ');
      SQL.Add('   and fecha_ini_ci > :fecha ');
      SQL.Add(' order by fecha_ini_ci asc ');
      ParamByName('empresa').AsString:= DataSet.FieldByName('empresa_ci').AsString;
      ParamByName('centro').AsString:= DataSet.FieldByName('centro_origen_ci').AsString;
      ParamByName('fecha').AsDateTime:= DataSet.FieldByName('fecha_ini_ci').AsDateTime;
      Open;
      if not IsEmpty then
      begin
        DataSet.FieldByName('fecha_fin_ci').AsDateTime:=
          FieldByName('fecha_ini_ci').AsDateTime - 1;
      end
    end;
    Close;
  end;
end;

procedure TFMCostesIndirectos.qGuiaAfterOpen(DataSet: TDataSet);
begin
  //Abrir detalle
  QCostesIndirectos.SQL.Clear;
  QCostesIndirectos.SQL.Add('select * from frf_costes_indirectos ');
  if Trim(Where) <> '' then
  begin
    QCostesIndirectos.SQL.Add( Where );
    QCostesIndirectos.SQL.Add( ' and empresa_ci = :empresa_ci ');
  end
  else
  begin
    QCostesIndirectos.SQL.Add( ' where empresa_ci = :empresa_ci ');
  end;
  QCostesIndirectos.SQL.Add( ' and centro_origen_ci = :centro_origen_ci ');
  QCostesIndirectos.SQL.Add( ' ORDER BY fecha_ini_ci desc ');
  QCostesIndirectos.Open;
end;

procedure TFMCostesIndirectos.qGuiaBeforeClose(DataSet: TDataSet);
begin
  //cancelar cambios pendientes en la guia
  qGuia.CancelUpdates;
  //Cerrar detalle
  QCostesIndirectos.Close;
end;

end.
