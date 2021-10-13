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
    Label13: TLabel;
    transporte_t: TBDEdit;
    LAno_semana_p: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    QTransportistas: TQuery;
    direccion1_t: TBDEdit;
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

    FRegistroABorrarTransportistaId: String;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

   function ObtenerCodigoTransporte: string;

   procedure GetTransportistaBDRemota( const ABDRemota: string; const AAlta: Boolean );
   procedure BuscarTransportista( const ATransportista: string );
   procedure RefrescarTransportista;

  protected
    procedure AlBorrar;
    procedure DespuesDeBorrar;

    procedure SincronizarWeb; override;


  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;

    procedure MiAlta;
    procedure Altas; override;
    procedure Modificar; override;
    procedure Clonar;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, UDMConfig,
  UDMAuxDB, CAuxiliarDB, Principal, DPreview, LTransportistas,
  bSQLUtils, CReportes, AdvertenciaFD, ImportarTransportistaFD, SeleccionarAltaClonarFD,
  SincronizacionBonny;

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

procedure TFMTransportistas.Clonar;
var stransporte, scif, sdescripcion, sdireccion1, sdireccion2, stelefono,
    sfax, scodigo_x3, notas: string;
begin
  stransporte:= ObtenerCodigoTransporte;
  scif:= cif_t.Text;
  sdescripcion:= descripcion_t.Text;
  sdireccion1:= direccion1_t.Text;
  sdireccion2:= direccion2_t.Text;
  stelefono:= telefono_t.Text;
  sfax:= fax_t.Text;
  scodigo_x3:= codigo_x3_t.Text;
  notas:= notas_t.Text;

  inherited Altas;

  transporte_t.Text := stransporte;
  cif_t.Text := scif;
  descripcion_t.Text := sdescripcion;
  direccion1_t.Text := sdireccion1;
  direccion2_t.Text := sdireccion2;
  telefono_t.Text := stelefono;
  fax_t.Text := sfax;
  codigo_x3_t.Text := scodigo_x3;
  notas_t.Text := notas;
end;

procedure TFMTransportistas.DespuesDeBorrar;
begin
  SincroBonnyAurora.SincronizarTranportista(FRegistroABorrarTransportistaId);
  SincroBonnyAurora.Sincronizar;
  FRegistroABorrarTransportistaId := '';
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
 {+}Where := ' WHERE transporte_t=0';
 {+}Order := ' ORDER BY transporte_t ';
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

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;

    // Sinconizacion Web - borrado
  OnBeforeMasterDelete := AlBorrar;
  OnAfterMasterDeleted := DespuesDeBorrar;

     //Focos
  {+}FocoAltas := descripcion_t;
  {+}FocoModificar := descripcion_t;
  {+}FocoLocalizar := transporte_t;

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

procedure TFMTransportistas.GetTransportistaBDRemota(const ABDRemota: string; const AAlta: Boolean);
var
  sTransportista: string;
  iValue: Integer;
  bAlta: Boolean;
begin
  if AAlta then
    sTransportista:= ''
  else
    sTransportista:= transporte_t.Text;
  bAlta:= AAlta;

  iValue:= ImportarTransportista( Self, ABDRemota, sTransportista );
  case iValue of
      -1: //Operacion cancelada
          begin end;
       1: begin
            if bAlta then
            begin
              BuscarTransportista( sTransportista );
              //ShowMessage('Alta de envase correcta.');
            end
            else
            begin
              RefrescarTransportista;
              //ShowMessage('Modificación de envase correcta.');
            end;
          end;
       else ShowMessage('Error ' + IntToStr( iValue ) + ' al importar el Transportista.');
  end;
end;

procedure TFMTransportistas.MiAlta;
var
  iTipo: Integer;
begin
  if QTransportistas.IsEmpty then
  begin
    inherited Altas;
  end
  else
  begin
    if Estado <> teAlta then
    begin
      if SeleccionarAltaClonarFD.SeleccionarTipoAlta( Self, iTipo ) = mrOk then
      begin
        if iTipo = 0 then
        begin
          inherited Altas;
        end
        else
        begin
          Clonar;
        end;
      end;
    end
    else
    begin
      Clonar;
    end;
  end;
end;

procedure TFMTransportistas.Modificar;
begin
  if DMConfig.EsLaFontEx then
  begin
    inherited Modificar;
  end
  else
  begin
    //inherited Modificar;
    if DMBaseDatos.AbrirConexionCentral then
    begin
      GetTransportistaBDRemota( 'BDCentral', False );
    end
    else
    begin
      if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Cualquier cambio que realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer modificaciones locales', 'Modificar Transportista') = mrIgnore then
        inherited Modificar;
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
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 transporte_t ');
    SQL.Add(' from frf_transportistas ');
    SQL.Add(' where descripcion_t = ' + QuotedStr( descripcion_t.Text ) );
    Open;
    if not IsEmpty then
    begin
      if FieldByName('transporte_t').AsString <> transporte_t.Text then
      begin
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

procedure TFMTransportistas.BuscarTransportista(const ATransportista: string);
begin
 {+}Select := ' SELECT * FROM frf_transportistas ';
 {+}where := ' WHERE transporte_t =' + ATransportista;
 {+}Order := ' ORDER BY transporte_t ';

 QTransportistas.Close;
 AbrirTablas;
 Visualizar;
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
procedure TFMTransportistas.AlBorrar;
begin
  FRegistroABorrarTransportistaId := DSMaestro.DataSet.FieldByName('transporte_t').asString;
end;

procedure TFMTransportistas.Altas;
begin
  if DMConfig.EsLaFontEx then
  begin
    MiAlta;
  end
  else
  begin
    //inherited Altas;
    if DMBaseDatos.AbrirConexionCentral then
    begin
      GetTransportistaBDRemota( 'BDCentral', True );
    end
    else
    begin
      if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Recuerde que cualquier cambio que se realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer altas locales', 'Nuevo Transportista') = mrIgnore then
        MiAlta;
    end;
  end;
end;

procedure TFMTransportistas.AntesDeInsertar;
begin
  //Deshabilitamos el campo transporte_t, se genera codigo automatico
  transporte_t.Enabled := False;
  transporte_t.Text := ObtenerCodigoTransporte;
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
end;

procedure TFMTransportistas.RefrescarTransportista;
var
  myBookMark: TBookmark;
begin
  myBookMark:= QTransportistas.GetBookmark;
  QTransportistas.Close;
  QTransportistas.Open;
  QTransportistas.GotoBookmark(myBookMark);
  QTransportistas.FreeBookmark(myBookMark);
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

procedure TFMTransportistas.SincronizarWeb;
begin
  SincroBonnyAurora.SincronizarTranportista(DSMaestro.DataSet.FieldByName('transporte_t').asString);
  SincroBonnyAurora.Sincronizar;
end;

procedure TFMTransportistas.notas_tEnter(Sender: TObject);
begin
  notas_t.Color:= clMoneyGreen;
end;

procedure TFMTransportistas.notas_tExit(Sender: TObject);
begin
  notas_t.Color:= clWhite;
end;

function TFMTransportistas.ObtenerCodigoTransporte: string;
var iTransporte: Integer;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select max(transporte_t) transporte from frf_transportistas ');

    Open;
    if IsEmpty then
      iTransporte := 1
    else
    begin
      iTransporte := fieldbyname('transporte').AsInteger + 1;
    end;

    Result := IntToStr(iTransporte);

    Close;
  end;
end;

procedure TFMTransportistas.transporte_tExit(Sender: TObject);
begin
  //Buscar si esta grabado y rellenar datos
  if ( Trim( transporte_t.Text ) <> '' ) and ( Estado = teAlta ) then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 * ');
    SQL.Add(' from frf_transportistas ');
    SQL.Add(' where transporte_t = ' + Trim( transporte_t.Text ) );
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
         notas_t.Text:= FieldByName('notas_t').AsString;
       end;
    end;
    Close;
  end;
end;

end.


