unit MTipoCostes;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms, Dialogs, Db, ExtCtrls, BDEdit,
  StdCtrls, CMaestro, ComCtrls, BEdit, DError, Controls, DBTables, DBCtrls,
  Grids, DBGrids;

type
  TFMTipoCostes = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    LPlantacion_p: TLabel;
    env_tcoste_etc: TBDEdit;
    LEmpresa_p: TLabel;
    descripcion_etc: TBDEdit;
    Label13: TLabel;
    QTipoCostes: TQuery;
    Label1: TLabel;
    aplic_primera_etc: TDBCheckBox;
    aplic_segunda_etc: TDBCheckBox;
    aplic_tercera_etc: TDBCheckBox;
    aplic_destrio_etc: TDBCheckBox;
    Label2: TLabel;
    centro_paso_etc: TBDEdit;
    Label3: TLabel;
    dbgTipoEntradas: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject;
      var isTime: Boolean);
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
    procedure AntesDeModificar;
    procedure AntesDeInsertar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses CVariables, UDMBaseDatos, Principal, LTipoCostes, CReportes,
  CGestionPrincipal, DPreview, bSQLUtils;

{$R *.DFM}

procedure TFMTipoCostes.AbrirTablas;
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
  Registro := 1;
  Registros := DataSetMaestro.RecordCount;
  RegistrosInsertados := 0;
end;

procedure TFMTipoCostes.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMTipoCostes.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
  PMaestro.Height:= 0;

     //Fuente de datos maestro
 {+}DataSetMaestro := QTipoCostes;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_env_tcostes ';
 {+}where := ' WHERE env_tcoste_etc= ' + QuotedStr('##');
 {+}Order := ' ORDER BY env_tcoste_etc ';
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
  FocoAltas := env_tcoste_etc;
  FocoModificar := descripcion_etc;
  FocoLocalizar := env_tcoste_etc;

end;

procedure TFMTipoCostes.FormActivate(Sender: TObject);
begin
  Top:= 1;

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


procedure TFMTipoCostes.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMTipoCostes.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMTipoCostes.Filtro;
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
    end;
  end;
  if flag then where := ' WHERE ' + where;
end;

//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que son insertados
//para, else fin usa los campos que marcamos como PrimaryKey

procedure TFMTipoCostes.AnyadirRegistro;
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

procedure TFMTipoCostes.ValidarEntradaMaestro;
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

procedure TFMTipoCostes.Previsualizar;
var enclave: TBookMark;
begin
     //Crear el listado
  enclave := DataSetMaestro.GetBookmark;
  QRLTipoCostes := TQRLTipoCostes.Create(Application);
  PonLogoGrupoBonnysa(QRLTipoCostes);
  QRLTipoCostes.DataSet := QTipoCostes;
  Preview(QRLTipoCostes);
  DataSetMaestro.GotoBookmark(enclave);
  DataSetMaestro.FreeBookmark(enclave);
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************

procedure TFMTipoCostes.AntesDeLocalizar;
begin
  PMaestro.Height:= 125;
end;

procedure TFMTipoCostes.AntesDeInsertar;
begin
  PMaestro.Height:= 125;
  aplic_primera_etc.Checked := False;
  aplic_segunda_etc.Checked := False;
  aplic_tercera_etc.Checked := False;
  aplic_destrio_etc.Checked := False;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMTipoCostes.AntesDeModificar;
var i: Integer;
begin
  PMaestro.Height:= 125;
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

procedure TFMTipoCostes.AntesDeVisualizar;
var i: Integer;
begin
  PMaestro.Height:= 0;
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

procedure TFMTipoCostes.RequiredTime(Sender: TObject;
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

end.
