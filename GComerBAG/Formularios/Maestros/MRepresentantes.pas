unit MRepresentantes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, DBCtrls, CMaestro, Buttons, ActnList, Grids,
  BSpeedButton, DBGrids, BGridButton, BGrid, BDEdit, ComCtrls,
  DError, BEdit, DBTables;

type
  TFMRepresentantes = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    RejillaFlotante: TBGrid;
    representante_r: TBDEdit;
    LDescripcion_r: TLabel;
    Label13: TLabel;
    descripcion_r: TBDEdit;
    QRepresentantes: TQuery;
    DBGrid1: TDBGrid;
    QDescuentos: TQuery;
    DSDescuentos: TDataSource;
    QDescuentoscomision: TFloatField;
    QDescuentosinicio: TDateField;
    QDescuentosfin: TDateField;
    btnDescuentos: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject;
      var isTime: Boolean);
    procedure QRepresentantesAfterOpen(DataSet: TDataSet);
    procedure QRepresentantesBeforeClose(DataSet: TDataSet);
    procedure btnDescuentosClick(Sender: TObject);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    FRegistroABorrarRepresentanteId: String;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

  protected
    procedure AlBorrar;
    procedure DespuesDeBorrar;

    procedure SincronizarWeb; override;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeInsertar;
    procedure AntesDeLocalizar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses UDMAuxDB, CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, LRepresentantes, DPreview, bSQLUtils,
  ComisionRepresentanteFD, SincronizacionBonny;

{$R *.DFM}

procedure TFMRepresentantes.AbrirTablas;
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
  Registros := DataSetMaestro.RecordCount;
  if Registros > 0 then
    Registro := 1
  else
    Registro := 0;
  RegistrosInsertados := 0;
end;

procedure TFMRepresentantes.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

procedure TFMRepresentantes.DespuesDeBorrar;
begin
  SincroBonnyAurora.SincronizarRepresentante(FRegistroABorrarRepresentanteId);
  SincroBonnyAurora.Sincronizar;
  FRegistroABorrarRepresentanteId := '';
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMRepresentantes.FormCreate(Sender: TObject);
begin
  with QDescuentos do
  begin
    SQL.Clear;
    SQL.Add(' select comision_rc comision,  fecha_ini_rc inicio, fecha_fin_rc fin ');
    SQL.Add(' from frf_representantes_comision ');
    SQL.Add(' where representante_rc = :representante_r ');
    SQL.Add(' order by inicio desc ');
    if not Prepared then
      Prepare;
  end;


     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //***************************************************************
     //Fuente de datos maestro
     //CAMBIAR POR LA QUERY QUE LE TOQUE
 {+}DataSetMaestro := QRepresentantes;
     //***************************************************************

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_representantes ';
 {+}where := ' WHERE (representante_r= ' + QuotedStr('###') + ')';
 {+}Order := ' ORDER BY representante_r ';
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
     //Visualizar estado inicial
  Visualizar;

//DESCOMENTAR SI USAMOS REJILLA FLOTANTE
     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := kNull;

//RELLENAR, CONSTANTES EN CVariables

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
//DEJAR LAS QUE SEAN NECESARIAS
  OnInsert := AntesDeInsertar;
  OnBrowse := AntesDeLocalizar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;

    // Sinconizacion Web - borrado
  OnBeforeMasterDelete := AlBorrar;
  OnAfterMasterDeleted := DespuesDeBorrar;

     //Focos
  FocoAltas := representante_r;
  FocoModificar := descripcion_r;
  FocoLocalizar := representante_r;

end;

procedure TFMRepresentantes.FormActivate(Sender: TObject);
begin
  if not DataSetMaestro.Active then Exit;
     //Variables globales
  M := Self;
  MD := nil;
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;


procedure TFMRepresentantes.FormDeactivate(Sender: TObject);
begin
  gRF := nil;
end;

procedure TFMRepresentantes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with QDescuentos do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  Lista.Free;
     //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
     //Codigo de desactivacion
  CerrarTablas;

{*DEJAR LAS QUE TENIAN VALOR
     //Por si acaso el nuevo form no necesita rejilla
     gRF:=nil;
     gCF:=nil;
}
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;

end;

procedure TFMRepresentantes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//DEJAR SI EXISTE REJILLA
    //Si la rejilla esta desplegada no hacemos nada
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
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
//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que concuerdan
//con los capos que hemos rellenado

procedure TFMRepresentantes.Filtro;
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

procedure TFMRepresentantes.AnyadirRegistro;
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

procedure TFMRepresentantes.ValidarEntradaMaestro;
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
end;

//**************************************************************
//IMPRESION: Introducir QuickReport
//**************************************************************

procedure TFMRepresentantes.Previsualizar;
var enclave: TBookMark;
begin
     //Crear el listado
  enclave := DatasetMaestro.GetBookmark;
  QRLRepresentantes := TQRLRepresentantes.Create(Application);
  PonLogoGrupoBonnysa(QRLRepresentantes);
  QRLRepresentantes.DataSet := QRepresentantes;
  Preview(QRLRepresentantes);
  DatasetMaestro.GotoBookmark(enclave);
  DatasetMaestro.FreeBookmark(enclave);
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar rejilla flotante (Formulario)
//   - Borrar Lista de acciones(Formulario)
//   - Borrar las funciones de esta seccion(Codigo)
//*****************************************************************************
//*****************************************************************************

procedure TFMRepresentantes.ARejillaFlotanteExecute(Sender: TObject);
begin
end;
//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMRepresentantes.AlBorrar;
begin
  FRegistroABorrarRepresentanteId := DSMaestro.Dataset.FieldByName('representante_r').asString;
end;

procedure TFMRepresentantes.AntesDeInsertar;
begin
  btnDescuentos.Enabled:= false;
end;

procedure TFMRepresentantes.AntesDeLocalizar;
begin
  btnDescuentos.Enabled:= false;
end;

procedure TFMRepresentantes.AntesDeModificar;
var i: Integer;
begin
    //Deshabilitamos todos los componentes Modificable=False
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;
  btnDescuentos.Enabled:= false;
end;
//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMRepresentantes.AntesDeVisualizar;
var i: Integer;
begin
    //Resaturamos estado controles
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          if Enabled = false then Enabled := true;
  end;
  btnDescuentos.Enabled:= True;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMRepresentantes.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
end;

//Para saber cuando tenemos que obligar a que un campo sea requerido

procedure TFMRepresentantes.RequiredTime(Sender: TObject;
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

procedure TFMRepresentantes.SincronizarWeb;
begin
  SincroBonnyAurora.SincronizarRepresentante(DSMaestro.Dataset.FieldByName('representante_r').asString);
  SincroBonnyAurora.Sincronizar;
end;

procedure TFMRepresentantes.QRepresentantesAfterOpen(DataSet: TDataSet);
begin
  QDescuentos.Open;
end;

procedure TFMRepresentantes.QRepresentantesBeforeClose(DataSet: TDataSet);
begin
  QDescuentos.Close;
end;

procedure TFMRepresentantes.btnDescuentosClick(Sender: TObject);
begin
  if not QRepresentantes.IsEmpty and (QRepresentantes.State = dsBrowse) then
  begin
    ComisionRepresentanteFD.ExecuteComisionRepresentante( self, representante_r.Text );
    QDescuentos.Close;
    QDescuentos.Open;
  end;
end;

end.


