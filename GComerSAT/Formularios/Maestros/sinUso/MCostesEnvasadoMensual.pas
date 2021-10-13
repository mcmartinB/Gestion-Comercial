unit MCostesEnvasadoMensual;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms, Dialogs, Db, ExtCtrls, BDEdit,
  StdCtrls, CMaestro, ComCtrls, BEdit, DError, Controls, DBTables, nbEdits,
  nbCombos, nbLabels, Grids, DBGrids;

type
  TFMCostesEnvasadoMensual = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    LPlantacion_p: TLabel;
    empresa_emc: TBDEdit;
    LEmpresa_p: TLabel;
    centro_emc: TBDEdit;
    Label13: TLabel;
    QCostesEnvasado: TQuery;
    coste_kg_emc_epc: TBDEdit;
    anyo_mes_emc: TBDEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    env_tcoste_emc: TnbDBSQLCombo;
    desEmpresa_ce: TnbStaticText;
    desCentro_ce: TnbStaticText;
    desTipoCoste_ce: TnbStaticText;
    dbgCostes: TDBGrid;
    qGuia: TQuery;
    dsGuia: TDataSource;
    sqluGuia: TUpdateSQL;
    QCostesEnvasadoempresa_emc: TStringField;
    QCostesEnvasadocentro_emc: TStringField;
    QCostesEnvasadoanyo_mes_emc: TStringField;
    QCostesEnvasadoenv_tcoste_emc: TStringField;
    QCostesEnvasadocoste_kg_emc: TFloatField;
    QCostesEnvasadodes_seccion: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject;
      var isTime: Boolean);
    procedure empresa_emcChange(Sender: TObject);
    procedure centro_emcChange(Sender: TObject);
    procedure env_tcoste_emcChange(Sender: TObject);
    procedure qGuiaAfterOpen(DataSet: TDataSet);
    procedure qGuiaBeforeClose(DataSet: TDataSet);
    procedure QCostesEnvasadoCalcFields(DataSet: TDataSet);
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

uses CVariables, UDMBaseDatos, Principal, LCostesEnvasadoMensual, CReportes,
  CGestionPrincipal, DPreview, bSQLUtils, udmauxdb;

{$R *.DFM}

procedure TFMCostesEnvasadoMensual.AbrirTablas;
begin
     // Abrir tablas/Querys
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

procedure TFMCostesEnvasadoMensual.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetGuia]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMCostesEnvasadoMensual.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
  PMaestro.Height:= 99;

     //Fuente de datos maestro
 {+}//DataSetMaestro := QCostesEnvasado;
    DataSetGuia := qGuia;
 {+}DataSetMaestro := QCostesEnvasado;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT empresa_emc, centro_emc, anyo_mes_emc FROM frf_env_mcostes ';
 {+}where := ' WHERE empresa_emc= ' + QuotedStr('###');
 {+}Order := ' GROUP BY empresa_emc, centro_emc, anyo_mes_emc  ' + #13 + #10 +
             ' ORDER BY empresa_emc, anyo_mes_emc desc, centro_emc  ' ;
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
  FocoAltas := empresa_emc;
  FocoModificar := env_tcoste_emc;
  FocoLocalizar := empresa_emc;

end;

procedure TFMCostesEnvasadoMensual.FormActivate(Sender: TObject);
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

  Top:= 1;
end;


procedure TFMCostesEnvasadoMensual.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMCostesEnvasadoMensual.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMCostesEnvasadoMensual.Filtro;
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
    begin
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
      end;
    end;
  end;
  if flag then where := ' WHERE ' + where;
end;

//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que son insertados
//para, else fin usa los campos que marcamos como PrimaryKey

procedure TFMCostesEnvasadoMensual.AnyadirRegistro;
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
          if flag then where := where + ' and ';
          if InputType = itChar then
            where := where + ' ' + name + ' =' + SQLFilter(Text)
          else
            if InputType = itDate then
              where := where + ' ' + name + ' =' + SQLDate(Text)
            else
              where := where + ' ' + name + ' =' + Text;
          flag := True;
        end;
      end;
    end;
  end;
  where := where + ') ';
end;


//function semi-generica, introducir restricciones particulares donde se indica
//Conprueba que tengan valor todos los campos marcados como required

procedure TFMCostesEnvasadoMensual.ValidarEntradaMaestro;
var i: Integer;
begin
    //Que no hayan campos vacios
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

    //**************************************************************
    //REstricciones Particulares
    //**************************************************************
    //Ninguna
end;

//**************************************************************
//IMPRESION: Introducir QuickReport
//**************************************************************

procedure TFMCostesEnvasadoMensual.Previsualizar;
begin
     //Crear el listado
  QRLCostesEnvasadoMensual := TQRLCostesEnvasadoMensual.Create(Application);
  PonLogoGrupoBonnysa(QRLCostesEnvasadoMensual);
  QRLCostesEnvasadoMensual.QCostesEnvasado.SQL.Clear;
  QRLCostesEnvasadoMensual.QCostesEnvasado.SQL.Add('SELECT empresa_emc, centro_emc,  anyo_mes_emc, ');
  QRLCostesEnvasadoMensual.QCostesEnvasado.SQL.Add('       env_tcoste_emc, descripcion_etc, coste_kg_emc ');
  QRLCostesEnvasadoMensual.QCostesEnvasado.SQL.Add('FROM frf_env_mcostes, frf_env_tcostes ');
  if Where <> '' then
  begin
    QRLCostesEnvasadoMensual.QCostesEnvasado.SQL.Add( WHERE );
    QRLCostesEnvasadoMensual.QCostesEnvasado.SQL.Add('and env_tcoste_emc = env_tcoste_etc ');
  end
  else
  begin
    QRLCostesEnvasadoMensual.QCostesEnvasado.SQL.Add('WHERE env_tcoste_emc = env_tcoste_etc ');
  end;
  QRLCostesEnvasadoMensual.QCostesEnvasado.SQL.Add('ORDER BY empresa_emc, anyo_mes_emc desc, centro_emc, env_tcoste_emc ');

  QRLCostesEnvasadoMensual.QCostesEnvasado.Open;
  Preview(QRLCostesEnvasadoMensual);
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMCostesEnvasadoMensual.AntesDeLocalizar;
begin
  PMaestro.Height:= 159;
end;

procedure TFMCostesEnvasadoMensual.AntesDeInsertar;
begin
  PMaestro.Height:= 159;
end;

procedure TFMCostesEnvasadoMensual.AntesDeModificar;
var i: Integer;
begin
  PMaestro.Height:= 159;
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

procedure TFMCostesEnvasadoMensual.AntesDeVisualizar;
var i: Integer;
begin
  PMaestro.Height:= 99;
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

procedure TFMCostesEnvasadoMensual.RequiredTime(Sender: TObject;
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

procedure TFMCostesEnvasadoMensual.empresa_emcChange(Sender: TObject);
begin
  desEmpresa_ce.Caption := desEmpresa(empresa_emc.Text);
  desCentro_ce.Caption := desCentro(empresa_emc.Text, centro_emc.Text);
end;

procedure TFMCostesEnvasadoMensual.centro_emcChange(Sender: TObject);
begin
  desCentro_ce.Caption := desCentro(empresa_emc.Text, centro_emc.Text);
end;

procedure TFMCostesEnvasadoMensual.env_tcoste_emcChange(Sender: TObject);
begin
  desTipoCoste_ce.Caption := desTipoCoste(env_tcoste_emc.Text);
end;

procedure TFMCostesEnvasadoMensual.qGuiaAfterOpen(DataSet: TDataSet);
begin
  //Abrir detalle
  QCostesEnvasado.SQL.Clear;
  QCostesEnvasado.SQL.Add('select * from frf_env_mcostes ');
  if Trim(Where) <> '' then
  begin
    QCostesEnvasado.SQL.Add( Where );
    QCostesEnvasado.SQL.Add( ' and empresa_emc = :empresa_emc ');
  end
  else
  begin
    QCostesEnvasado.SQL.Add( ' where empresa_emc = :empresa_emc ');
  end;
  QCostesEnvasado.SQL.Add( ' and centro_emc = :centro_emc ');
  QCostesEnvasado.SQL.Add( ' and anyo_mes_emc = :anyo_mes_emc ');
  QCostesEnvasado.SQL.Add( ' ORDER BY env_tcoste_emc ');
  QCostesEnvasado.Open;
end;

procedure TFMCostesEnvasadoMensual.qGuiaBeforeClose(DataSet: TDataSet);
begin
  //cancelar cambios pendientes en la guia
  qGuia.CancelUpdates;
  //Cerrar detalle
  QCostesEnvasado.Close;
end;

procedure TFMCostesEnvasadoMensual.QCostesEnvasadoCalcFields(
  DataSet: TDataSet);
begin
  QCostesEnvasadodes_seccion.AsString:= desTipoCoste( QCostesEnvasadoenv_tcoste_emc.AsString );
end;

end.
