(*#HACER#20040718.PepeBrotons*)
(*Tipo impuesto(IVA-IGIC), no deberia ser sustituido por todos los tipos de impuestos
  que tenemos, (REGIONAL,COMUNITARIO,EXTRA / IVA,IGIC)
*)
unit MCentros;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbtables,
  DError, DBCtrls;

type
  TFMCentros = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    direccion_c: TBDEdit;
    empresa_c: TBDEdit;
    BGBEmpresa_c: TBGridButton;
    STEmpresa_c: TStaticText;
    descripcion_c: TBDEdit;
    centro_c: TBDEdit;
    RejillaFlotante: TBGrid;
    GroupBox1: TGroupBox;
    cont_entradas_c: TBDEdit;
    cont_albaranes_c: TBDEdit;
    Label6: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    cont_transitos_c: TBDEdit;
    poblacion_c: TBDEdit;
    cod_postal_c: TBDEdit;
    Label9: TLabel;
    Label10: TLabel;
    STProvincia: TStaticText;
    Label11: TLabel;
    sec_dif_cambio_c: TBDEdit;
    Label12: TLabel;
    cont_faccontrol_c: TBDEdit;
    QCentros: TQuery;
    tipo_impuesto_c: TComboBox;
    Label14: TLabel;
    pais_c: TBDEdit;
    STPais: TStaticText;
    Label15: TLabel;
    email_c: TBDEdit;
    lblMsgContadores: TLabel;
    lblNombre1: TLabel;
    cont_compras_c: TBDEdit;
    pnlBoton: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure DSMaestroDataChange(Sender: TObject; Field: TField);
    procedure tipo_impuesto_cChange(Sender: TObject);
    procedure tipo_impuesto_cEnter(Sender: TObject);
    procedure tipo_impuesto_cExit(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pais_cChange(Sender: TObject);
    procedure QCentrosAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    FRegistroABorrarEmpresaId: String;
    FRegistroABorrarCentroId: String;

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

    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses UDMAuxDB, CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, LCentros, DPreview, bSQLUtils, UDMConfig,
  SincronizacionBonny;

{$R *.DFM}

procedure TFMCentros.AbrirTablas;
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

procedure TFMCentros.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuery(DataSetMaestro);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMCentros.FormCreate(Sender: TObject);
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
  PanelMaestro := PMaestro;
  PanelMaestro.Visible := false; {Hasta que no tengamos los datos}

     //Fuente de datos maestro
 {+}DataSetMaestro := QCentros;

  //Lista de componentes
  Lista := TList.Create;
  PMaestro.GetTabOrderList(Lista); 

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_centros ';
 {+}where := ' WHERE empresa_c=' + QUOTEDSTR('###');
 {+}Order := ' ORDER BY empresa_c, centro_c ';

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;

     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_c.Tag := kEmpresa;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;

    // Sinconizacion Web - borrado
  OnBeforeMasterDelete := AlBorrar;
  OnAfterMasterDeleted := DespuesDeBorrar;

     //Focos
  {+}FocoAltas := empresa_c;
  {+}FocoModificar := descripcion_c;
  {+}FocoLocalizar := empresa_c;

  //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

  //Abrir tablas/Querys
  try
    AbrirTablas;
    Visualizar;
  except
    Close;
  end;
     //Desplegar(Self,439);
  if PanelMaestro.Visible = false then
    PanelMaestro.Visible := true;
end;

{+ CUIDADIN }


procedure TFMCentros.FormActivate(Sender: TObject);
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

     //Abrir tablas/Querys
  try
    AbrirTablas;
    Visualizar;
  except
    Close;
  end;
     //Desplegar(Self,439);
  if PanelMaestro.Visible = false then
    PanelMaestro.Visible := true;
end;


procedure TFMCentros.FormDeactivate(Sender: TObject);
begin
  Exit;

  //Desahabilitamos controles de Base de datos
  //mientras estamos desactivados
  DataSetMaestro.DisableControls;

 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;

  //CerrarTablas;
end;

procedure TFMCentros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Liberamos recursos
  Lista.Free;

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

procedure TFMCentros.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{*}//Si la rejilla esta desplegada no hacemos nada
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
           //No hacemos nada
      Exit;
  if tipo_impuesto_c.DroppedDown then
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
    vk_f2:
      begin
        if tipo_impuesto_c.Focused then
        begin
          tipo_impuesto_c.DroppedDown := not tipo_impuesto_c.DroppedDown;
        end;
      end;
  end;
end;

procedure TFMCentros.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_f2:
      begin
        if ActiveControl.Name = tipo_impuesto_c.Name then
        begin
          tipo_impuesto_c.DroppedDown := not tipo_impuesto_c.DroppedDown;
        end;
      end;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

{+}//Sustituir por funcion generica

procedure TFMCentros.Filtro;
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

{+}//sustituir por funcion generica

procedure TFMCentros.AnyadirRegistro;
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

{+}//Sustituir por funcion generica

procedure TFMCentros.ValidarEntradaMaestro;
var i: Integer;
begin
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

procedure TFMCentros.Previsualizar;
begin
  //Crear el listado
  DMBaseDatos.QListado.SQL.Clear;
  DMBaseDatos.QListado.SQL.AddStrings(QCentros.SQL);
  try
    DMBaseDatos.QListado.Open;
    QRLCentros := TQRLCentros.Create(Application);
    try
      PonLogoGrupoBonnysa(QRLCentros);
      Preview(QRLCentros);
    except
      FreeAndNil(QRLCentros);
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

procedure TFMCentros.ARejillaFlotanteExecute(Sender: TObject);
begin
  if empresa_c.Focused then
    DespliegaRejilla(BGBEmpresa_c);
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

procedure TFMCentros.AlBorrar;
begin
  FRegistroABorrarEmpresaId := DSMaestro.DataSet.FieldByName('empresa_c').asString;
  FRegistroABorrarCentroId := DSMaestro.DataSet.FieldByName('centro_c').asString;
end;

procedure TFMCentros.AntesDeModificar;
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
//Aprovechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMCentros.AntesDeVisualizar;
var i: Integer;
begin
    //Resaturar estado
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := True;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************
//Pone el nombre de la empresa al desplazarse por la tabla.

procedure TFMCentros.RequiredTime(Sender: TObject;
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

procedure TFMCentros.SincronizarWeb;
var
  empresaId: String;
  centroId: String;
begin
  empresaId := DSMaestro.DataSet.FieldByName('empresa_c').asString;
  centroId := DSMaestro.DataSet.FieldByName('centro_c').asString;
  SincroBonnyAurora.SincronizarCentro(empresaId, centroId);
  SincroBonnyAurora.Sincronizar;
end;

procedure TFMCentros.DespuesDeBorrar;
begin
  SincroBonnyAurora.SincronizarCentro(FRegistroABorrarEmpresaId, FRegistroABorrarCentroId);
  SincroBonnyAurora.Sincronizar;
  FRegistroABorrarEmpresaId := '';
  FRegistroABorrarCentroId := '';
end;

procedure TFMCentros.DSMaestroDataChange(Sender: TObject; Field: TField);
begin
  STEmpresa_c.Caption := desEmpresa(empresa_c.Text);
  if pais_c.Text = 'ES' then
    STProvincia.Caption := desProvincia(cod_postal_c.Text)
  else
    STProvincia.Caption:= '';
  STPais.Caption := desPais(pais_c.Text);

  if QCentros.FieldByName('tipo_impuesto_c').AsString = 'IVA' then
    tipo_impuesto_c.ItemIndex := 0
  else
    if QCentros.FieldByName('tipo_impuesto_c').AsString = 'IGIC' then
      tipo_impuesto_c.ItemIndex := 1
    else
      if QCentros.FieldByName('tipo_impuesto_c').AsString = 'EXEN' then
        tipo_impuesto_c.ItemIndex := 2
      else
        tipo_impuesto_c.ItemIndex := -1;
end;

procedure TFMCentros.tipo_impuesto_cChange(Sender: TObject);
begin
  if QCentros.State in [dsEdit, dsInsert] then
  begin
    if tipo_impuesto_c.ItemIndex = 0 then
      QCentros.FieldByName('tipo_impuesto_c').AsString := 'IVA'
    else
      if tipo_impuesto_c.ItemIndex = 1 then
        QCentros.FieldByName('tipo_impuesto_c').AsString := 'IGIC'
      else
        if tipo_impuesto_c.ItemIndex = 2 then
          QCentros.FieldByName('tipo_impuesto_c').AsString := 'EXEN'
        else
          QCentros.FieldByName('tipo_impuesto_c').AsString := '';
  end;
end;

procedure TFMCentros.tipo_impuesto_cEnter(Sender: TObject);
begin
  tipo_impuesto_c.Color := $00C0DCC0;
end;

procedure TFMCentros.tipo_impuesto_cExit(Sender: TObject);
begin
  tipo_impuesto_c.Color := clWhite;
end;

procedure TFMCentros.pais_cChange(Sender: TObject);
begin
  if pais_c.Text = 'ES' then
    STProvincia.Caption := desProvincia(cod_postal_c.Text)
  else
    STProvincia.Caption := '';
  STPais.Caption := desPais(pais_c.Text);
end;

procedure TFMCentros.QCentrosAfterInsert(DataSet: TDataSet);
begin
  if Estado = teAlta then
  begin
    cont_entradas_c.Text:= '0';
    cont_albaranes_c.Text:= '0';
    cont_transitos_c.Text:= '0';
    cont_faccontrol_c.Text:= '0';
    tipo_impuesto_c.ItemIndex:= 0;
    DataSet.FieldByName('tipo_impuesto_c').AsString:= 'I';
  end;
end;

end.
