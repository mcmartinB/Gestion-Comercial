unit MCosAjustesFOB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons, BGrid, BDEdit,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, ComCtrls, BEdit, DError,
  DBTables;

type
  TFMCosAjustesFOB = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    RejillaFlotante: TBGrid;
    LEmpresa_p: TLabel;
    empresa_caf: TBDEdit;
    BGBEmpresa_caf: TBGridButton;
    LCosechero_p: TLabel;
    cosechero_caf: TBDEdit;
    BGBCosechero_caf: TBGridButton;
    STEmpresa_caf: TStaticText;
    STCosechero_caf: TStaticText;
    Label13: TLabel;
    anyosemana_caf: TBDEdit;
    LAno_semana_p: TLabel;
    LSuperficie_p: TLabel;
    ajuste_primera_caf: TBDEdit;
    ACampos: TAction;
    Label1: TLabel;
    producto_caf: TBDEdit;
    QAjusteFob: TQuery;
    BGBProducto_caf: TBGridButton;
    STProducto_caf: TStaticText;
    lblNombre1: TLabel;
    ajuste_segunda_caf: TBDEdit;
    lblNombre2: TLabel;
    ajuste_resto_caf: TBDEdit;
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
    procedure SalirEdit(Sender: TObject);
    procedure EntrarEdit(Sender: TObject);
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

    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, CReportes, CAuxiliarDB,
  Principal, DPreview, UDMAuxDB, bSQLUtils, LCosAjustesFOB;

{$R *.DFM}

procedure TFMCosAjustesFOB.AbrirTablas;
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
  if registros > 0 then
    Registro := 1
  else
    Registro := 0;
  RegistrosInsertados := 0;
end;

procedure TFMCosAjustesFOB.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMCosAjustesFOB.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := QAjusteFob;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_cos_ajuste_fob ';
 {+}where := ' WHERE empresa_caf=' + QuotedStr('###');
 {+}Order := ' ORDER BY empresa_caf, cosechero_caf, producto_caf, anyosemana_caf ';
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
  Visualizar;
     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(pcNulo);

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := kNull;
     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_caf.Tag := kEmpresa;
  cosechero_caf.Tag := kCosechero;
  producto_caf.Tag := kProducto;
     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnBrowse := AntesDeInsertar;
  OnView := AntesDeVisualizar;
     //Focos
 {+}FocoAltas := empresa_caf;
 {+}FocoModificar := ajuste_primera_caf;
 {+}FocoLocalizar := empresa_caf;
end;

procedure TFMCosAjustesFOB.FormActivate(Sender: TObject);
begin
  Top := 1;
  if not DataSetMaestro.Active then Exit;
     //Variables globales
  M := Self;
  MD := nil;
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := nil;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;

     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
     //Barra de estado y barra de herramientas
  BEEstado;
  BHEstado;
  Enabled := True;
end;


procedure TFMCosAjustesFOB.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF := nil;
end;

procedure TFMCosAjustesFOB.FormClose(Sender: TObject; var Action: TCloseAction);
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
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF := nil;

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMCosAjustesFOB.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{*}//Si la rejilla esta desplegada no hacemos nada
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

procedure TFMCosAjustesFOB.Filtro;
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

procedure TFMCosAjustesFOB.AnyadirRegistro;
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

procedure TFMCosAjustesFOB.ValidarEntradaMaestro;
var
  i, aux: Integer;
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
    //Comprobar que el año_semana tenga obligatoriamente 6 cifras
  if (length(anyosemana_caf.Text) < 6) then
  begin
    anyosemana_caf.SetFocus;
    raise Exception.Create('El año y la semana debe ser de 6 dígitos.');
  end;
    //Comprobar que las dos ultimas cifras del año_semana esten entre 01-53
  aux := StrToInt(Copy(anyosemana_caf.Text, 5, 2));
  if (aux < 1) or (aux > 53) then
  begin
    anyosemana_caf.SetFocus;
    raise Exception.Create('Las dos últimas cifras del año y la semana deben estar entre 01 y 53 ambos incluidos.');
  end;

    //Que no sea un cosechero del grupo
(*
    if ( empresa_caf.Text <> '' ) and ( cosechero_caf.Text <> '' ) then
    begin
      DMAuxDB.QAux.SQL.Clear;
      DMAuxDB.QAux.SQL.Add('select * from frf_cosecheros');
      DMAuxDB.QAux.SQL.Add('where empresa_c = ' + QuotedStr( empresa_caf.Text ) );
      DMAuxDB.QAux.SQL.Add('  and cosechero_c = ' + QuotedStr( cosechero_caf.Text ) );
      DMAuxDB.QAux.SQL.Add('  and pertenece_grupo_c = ''N'' ');
      try
        DMAuxDB.QAux.Open;
        if DMAuxDB.QAux.IsEmpty then
        begin
          cosechero_caf.SetFocus;
          raise Exception.Create('Sólo podemos grabar proveedores que no pertenezcan al grupo.');
        end;
      finally
        DMAuxDB.QAux.Close;
      end;
    end;
*)
end;

//**************************************************************
//IMPRESION: Introducir QuickReport
//**************************************************************

procedure TFMCosAjustesFOB.Previsualizar;
begin
  QRLCosAjustesFOB := TQRLCosAjustesFOB.Create(self);
  QRLCosAjustesFOB.QListado.SQL.Clear;
  QRLCosAjustesFOB.QListado.SQL.Add(Select + ' ' + Where + ' ' + Order);
  try
    QRLCosAjustesFOB.QListado.Open;
    PonLogoGrupoBonnysa(QRLCosAjustesFOB);
    Preview(QRLCosAjustesFOB);
  except
    QRLCosAjustesFOB.QListado.Close;
    FreeAndNil(QRLCosAjustesFOB);
  end;

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

procedure TFMCosAjustesFOB.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa_caf);
    kCosechero: DespliegaRejilla(BGBCosechero_caf, [empresa_caf.Text]);
    kProducto: DespliegaRejilla(BGBProducto_caf, [empresa_caf.Text]);
  end;
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos altas
//Aprobrechar para modificar estado controles

procedure TFMCosAjustesFOB.AntesDeInsertar;
begin
end;
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMCosAjustesFOB.AntesDeModificar;
var i: Integer;
begin
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

procedure TFMCosAjustesFOB.AntesDeVisualizar;
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
  STCosechero_caf.Caption := desCosechero(empresa_caf.Text, cosechero_caf.Text);
  STProducto_caf.Caption := desProducto(empresa_caf.Text, producto_caf.Text);
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMCosAjustesFOB.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa_caf.Caption := desEmpresa(empresa_caf.Text);
    kCosechero: STCosechero_caf.Caption := desCosechero(empresa_caf.Text, cosechero_caf.Text);
    kProducto: STProducto_caf.Caption := desProducto(empresa_caf.Text, producto_caf.Text);
  end;
end;

//Para saber cuando tenemos que obligar a que un campo sea requerido

procedure TFMCosAjustesFOB.RequiredTime(Sender: TObject;
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

//*****************************************************************
//MANTENIMIENTO DE CAMPOS
//*****************************************************************

procedure TFMCosAjustesFOB.SalirEdit(Sender: TObject);
begin
  BEMensajes('');
end;

procedure TFMCosAjustesFOB.EntrarEdit(Sender: TObject);
begin
  BEMensajes(TEdit(Sender).Hint);
end;

end.
