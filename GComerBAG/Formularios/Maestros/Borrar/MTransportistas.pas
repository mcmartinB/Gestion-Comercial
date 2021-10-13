unit MTransportistas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons, ActnList, BGrid,
  BSpeedButton, Grids, DBGrids, BGridButton, BDEdit, BCalendarButton, ComCtrls,
  BCalendario, BEdit, dbTables, DError;

type
  TFMTransportistas = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    RejillaFlotante: TBGrid;
    Ldescripcion: TLabel;
    descripcion_t: TBDEdit;
    LEmpresa_p: TLabel;
    empresa_t: TBDEdit;
    BGBEmpresa_t: TBGridButton;
    STEmpresa_t: TStaticText;
    Label13: TLabel;
    transporte_t: TBDEdit;
    LAno_semana_p: TLabel;
    Label1: TLabel;
    tara_t: TBDEdit;
    Label2: TLabel;
    codigo_almacen_t: TBDEdit;
    QTransportistas: TQuery;
    Label3: TLabel;
    direccion1_t: TBDEdit;
    Label4: TLabel;
    direccion2_t: TBDEdit;
    Label5: TLabel;
    cif_t: TBDEdit;
    Label6: TLabel;
    telefono_t: TBDEdit;
    Label7: TLabel;
    fax_t: TBDEdit;
    notas_t: TDBMemo;
    Label8: TLabel;
    Label9: TLabel;
    codigo_x3_t: TBDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure notas_tEnter(Sender: TObject);
    procedure notas_tExit(Sender: TObject);
    procedure transporte_tExit(Sender: TObject);
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

uses CVariables, CGestionPrincipal, UDMBaseDatos, UDMConfig,
  UDMAuxDB, CAuxiliarDB, Principal, DPreview, LTransportistas,
  bSQLUtils, CReportes, AdvertenciaFD;

{$R *.DFM}

procedure TFMTransportistas.AbrirTablas;
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

procedure TFMTransportistas.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMTransportistas.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := QTransportistas;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_transportistas ';
 {+}where := ' WHERE empresa_t=' + QuotedStr('###');
 {+}Order := ' ORDER BY empresa_t, transporte_t ';
     //Abrir tablas/Querys
  try
    AbrirTablas;
        //Habilitamos controles de Base de datos
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
  empresa_t.Tag := kEmpresa;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;
     //Focos
  {+}FocoAltas := empresa_t;
  {+}FocoModificar := descripcion_t;
  {+}FocoLocalizar := empresa_t;

end;

{+ CUIDADIN }

procedure TFMTransportistas.FormActivate(Sender: TObject);
begin
  if not DataSetMaestro.Active then Exit;
     //Formulario activo
  M := self;
  MD := nil;
     //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
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


procedure TFMTransportistas.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
end;

procedure TFMTransportistas.FormClose(Sender: TObject; var Action: TCloseAction);
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
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMTransportistas.FormKeyDown(Sender: TObject; var Key: Word;
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
        if not notas_t.Focused then
        begin
          Key := 0;
          PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        end;
      end;
    vk_up:
      begin
        if not notas_t.Focused then
        begin
          Key := 0;
          PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
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

procedure TFMTransportistas.Filtro;
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

procedure TFMTransportistas.AnyadirRegistro;
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

procedure TFMTransportistas.ValidarEntradaMaestro;
var
  i: Integer;
  sAux: string;
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

  //Buscar si esta grabado
  if Copy(empresa_t.Text,1,1) = 'F' then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_t, descripcion_t ');
    SQL.Add(' from frf_transportistas ');
    SQL.Add(' where empresa_t matches ''F*'' ');
    SQL.Add(' and empresa_t <> ' + QuotedStr( empresa_t.Text ) );
    SQL.Add(' and transporte_t = ' + transporte_t.Text );
    Open;
    if not IsEmpty then
    begin
      if FieldByName('descripcion_t').AsString <> descripcion_t.Text then
      begin

        sAux:= 'Ya hay un transportista con el mismo código y diferente descripción (' + FieldByName('empresa_t').AsString + ' - '  +
                                                                                         FieldByName('descripcion_t').AsString + ').';
        Close;
        if AdvertenciaFD.VerAdvertencia(Self, sAux, 'ADVERTENCIA','Confirmo que quiero continuar con el cambio.' ) <> mrIgnore then
          Abort;
      end;
    end;
    Close;

    //cambiarlo en todos ....  ¿Preguntar?
  end;
  if Copy(empresa_t.Text,1,1) = 'F' then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 transporte_t ');
    SQL.Add(' from frf_transportistas ');
    SQL.Add(' where empresa_t matches ''F*'' ');
    SQL.Add(' and empresa_t <> ' + QuotedStr( empresa_t.Text ) );
    SQL.Add(' and descripcion_t = ' + QuotedStr( descripcion_t.Text ) );
    Open;
    if not IsEmpty then
    begin
      if FieldByName('transporte_t').AsString <> transporte_t.Text then
      begin
        (*
        sAux:= 'Ya hay un transportista con la misma descripción y diferente código (' + FieldByName('transporte_t').AsString + ').' + #13 + #10 +
               '¿Seguro que quiere continuar?';
        Close;
        if MessageDlg( sAux , mtWarning, [mbYes, mbNo], 0 ) = mrNo then
          Abort;
        *)
        sAux:= 'Ya hay un transportista con la misma descripción y diferente código (' + FieldByName('transporte_t').AsString + ').';
        Close;
        raise Exception.Create( sAux );
      end;
    end;
    Close;
  end;

end;


procedure TFMTransportistas.Previsualizar;
var enclave: TBookMark;
begin
  enclave := DatasetMaestro.GetBookmark;
  QRLTransportistas := TQRLTransportistas.Create(Application);
  PonLogoGrupoBonnysa(QRLTransportistas);
  QRLTransportistas.DataSet := QTransportistas;
  Preview(QRLTransportistas);
  DatasetMaestro.GotoBookmark(enclave);
  DatasetMaestro.FreeBookmark(enclave);
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//*****************************************************************************

procedure TFMTransportistas.ARejillaFlotanteExecute(Sender: TObject);
begin
  if empresa_t.Focused then
    DespliegaRejilla(BGBEmpresa_t);
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
procedure TFMTransportistas.AntesDeInsertar;
begin
  if not DMConfig.EsLaFont then
  begin
    ShowMessage('Antes de dar de alta un nuevo transportista, recuerde darlo de alta antes en la central.');
  end;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMTransportistas.AntesDeModificar;
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

procedure TFMTransportistas.AntesDeVisualizar;
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

procedure TFMTransportistas.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  STEmpresa_t.Caption := desEmpresa(empresa_t.Text);
end;

procedure TFMTransportistas.RequiredTime(Sender: TObject;
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

procedure TFMTransportistas.notas_tEnter(Sender: TObject);
begin
  notas_t.Color:= clMoneyGreen;
end;

procedure TFMTransportistas.notas_tExit(Sender: TObject);
begin
  notas_t.Color:= clWhite;
end;

procedure TFMTransportistas.transporte_tExit(Sender: TObject);
begin
  //Buscar si esta grabado y rellenar datos
  if ( Copy(Trim( empresa_t.Text ),1,1) = 'F' ) and ( Trim( transporte_t.Text ) <> '' ) and ( Estado = teAlta ) then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 * ');
    SQL.Add(' from frf_transportistas ');
    SQL.Add(' where empresa_t matches ''F*'' ');
    SQL.Add(' and transporte_t = ' + Trim( transporte_t.Text ) );
    Open;
    if not IsEmpty then
    begin
      if MessageDlg( 'Ya hay un transportista con este código, ¿desea rellenar los campos de la ficha actual con sus datos?.' , mtWarning, [mbYes, mbNo], 0 ) = mrYes then
       begin
         cif_t.Text:= FieldByName('cif_t').AsString;
         descripcion_t.Text:= FieldByName('descripcion_t').AsString;
         direccion1_t.Text:= FieldByName('direccion1_t').AsString;
         direccion2_t.Text:= FieldByName('direccion2_t').AsString;
         telefono_t.Text:= FieldByName('telefono_t').AsString;
         fax_t.Text:= FieldByName('fax_t').AsString;
         tara_t.Text:= FieldByName('tara_t').AsString;
         notas_t.Text:= FieldByName('notas_t').AsString;
       end;
    end;
    Close;
  end;
end;

end.


