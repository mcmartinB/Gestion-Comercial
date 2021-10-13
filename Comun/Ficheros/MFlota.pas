unit MFlota;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons, ActnList, BGrid,
  BSpeedButton, Grids, DBGrids, BGridButton, BDEdit, BCalendarButton, ComCtrls,
  BCalendario, BEdit, dbTables, DError;

type
  TFMFlota = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    RejillaFlotante: TBGrid;
    Ldescripcion: TLabel;
    descripcion_c: TBDEdit;
    camion_c: TBDEdit;
    LAno_semana_p: TLabel;
    QCamion: TQuery;
    notas_c: TDBMemo;
    Label8: TLabel;
    Label3: TLabel;
    tara_c: TBDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure notas_cEnter(Sender: TObject);
    procedure notas_cExit(Sender: TObject);
    procedure camion_cExit(Sender: TObject);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

   function ObtenerCodigoCamion: string;

   procedure GetCamionBDRemota( const ABDRemota: string; const AAlta: Boolean );
   procedure BuscarCamion( const ACamion: string );
   procedure RefrescarCamion;

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
  UDMAuxDB, CAuxiliarDB, Principal, DPreview, LCamiones,
  bSQLUtils, CReportes, AdvertenciaFD, ImportarCamionFD, SeleccionarAltaClonarFD;

{$R *.DFM}

procedure TFMFlota.AbrirTablas;
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

procedure TFMFlota.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

procedure TFMFlota.Clonar;
var scamion, sdescripcion, stara, notas: string;
begin
  scamion:= ObtenerCodigoCamion;
  sdescripcion:= descripcion_c.Text;
  stara:= tara_c.Text;
  notas:= notas_c.Text;

  inherited Altas;

  camion_c.Text := scamion;
  descripcion_c.Text := sdescripcion;
  tara_c.Text := stara;
  notas_c.Text := notas;
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMFlota.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := QCamion;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_camiones ';
 {+}Where := ' WHERE camion_c=0';
 {+}Order := ' ORDER BY camion_c ';
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
     //Focos
  {+}FocoAltas := descripcion_c;
  {+}FocoModificar := descripcion_c;
  {+}FocoLocalizar := camion_c;

end;

{+ CUIDADIN }

procedure TFMFlota.FormActivate(Sender: TObject);
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


procedure TFMFlota.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
end;

procedure TFMFlota.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMFlota.FormKeyDown(Sender: TObject; var Key: Word;
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
        if not notas_c.Focused then
        begin
          Key := 0;
          PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        end;
      end;
    vk_up:
      begin
        if not notas_c.Focused then
        begin
          Key := 0;
          PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        end;
      end;
  end;
end;

procedure TFMFlota.GetCamionBDRemota(const ABDRemota: string; const AAlta: Boolean);
var
  sCamion: string;
  iValue: Integer;
  bAlta: Boolean;
begin
  if AAlta then
    sCamion:= ''
  else
    sCamion:= camion_c.Text;
  bAlta:= AAlta;

  iValue:= ImportarCamion( Self, ABDRemota, sCamion );
  case iValue of
      -1: //Operacion cancelada
          begin end;
       1: begin
            if bAlta then
            begin
              BuscarCamion( sCamion );
              //ShowMessage('Alta de envase correcta.');
            end
            else
            begin
              RefrescarCamion;
              //ShowMessage('Modificación de envase correcta.');
            end;
          end;
       else ShowMessage('Error ' + IntToStr( iValue ) + ' al importar el camión.');
  end;
end;

procedure TFMFlota.MiAlta;
var
  iTipo: Integer;
begin
  if QCamion.IsEmpty then
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

procedure TFMFlota.Modificar;
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
      GetCamionBDRemota( 'BDCentral', False );
    end
    else
    begin
      if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Cualquier cambio que realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer modificaciones locales', 'Modificar Camión') = mrIgnore then
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

procedure TFMFlota.Filtro;
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

procedure TFMFlota.AnyadirRegistro;
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

procedure TFMFlota.ValidarEntradaMaestro;
var
  i: Integer;
  sAux: string;
begin
  if StrToInt(tara_c.Text) <= 0 then
    raise Exception.Create('La Tara tiene que ser mayor que cero.');

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
    SQL.Add(' select first 1 camion_c ');
    SQL.Add(' from frf_camiones ');
    SQL.Add(' where descripcion_c = ' + QuotedStr( descripcion_c.Text ) );
    Open;
    if not IsEmpty then
    begin
      if FieldByName('camion_c').AsString <> camion_c.Text then
      begin
        sAux:= 'Ya hay un camión con la misma descripción y diferente código (' + FieldByName('camion_c').AsString + ').';
        Close;
        raise Exception.Create( sAux );
      end;
    end;
    Close;
  end;

end;


procedure TFMFlota.Previsualizar;
var enclave: TBookMark;
begin
  enclave := DatasetMaestro.GetBookmark;
  QRLCamiones := TQRLCamiones.Create(Application);
  PonLogoGrupoBonnysa(QRLCamiones);
  QRLCamiones.DataSet := QCamion;
  Preview(QRLCamiones);
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

procedure TFMFlota.BuscarCamion(const ACamion: string);
begin
 {+}Select := ' SELECT * FROM frf_camiones ';
 {+}where := ' WHERE camion_c =' + ACamion;
 {+}Order := ' ORDER BY camion_c ';

 QCamion.Close;
 AbrirTablas;
 Visualizar;
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
procedure TFMFlota.Altas;
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
      GetCamionBDRemota( 'BDCentral', True );
    end
    else
    begin
      if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Recuerde que cualquier cambio que se realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer altas locales', 'Nuevo Camion') = mrIgnore then
        MiAlta;
    end;
  end;
end;

procedure TFMFlota.AntesDeInsertar;
begin
  //Deshabilitamos el campo camion_c, se genera codigo automatico
  camion_c.Enabled := False;
  camion_c.Text := ObtenerCodigoCamion;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMFlota.AntesDeModificar;
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

procedure TFMFlota.AntesDeVisualizar;
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

procedure TFMFlota.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
end;

procedure TFMFlota.RefrescarCamion;
var
  myBookMark: TBookmark;
begin
  myBookMark:= QCamion.GetBookmark;
  QCamion.Close;
  QCamion.Open;
  QCamion.GotoBookmark(myBookMark);
  QCamion.FreeBookmark(myBookMark);
end;

procedure TFMFlota.RequiredTime(Sender: TObject;
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

procedure TFMFlota.notas_cEnter(Sender: TObject);
begin
  notas_c.Color:= clMoneyGreen;
end;

procedure TFMFlota.notas_cExit(Sender: TObject);
begin
  notas_c.Color:= clWhite;
end;

function TFMFlota.ObtenerCodigoCamion: string;
var iCamion: Integer;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select max(camion_c) camion from frf_camiones ');

    Open;
    if IsEmpty then
      iCamion := 1
    else
    begin
      iCamion := fieldbyname('camion').AsInteger + 1;
    end;

    Result := IntToStr(iCamion);

    Close;
  end;
end;

procedure TFMFlota.camion_cExit(Sender: TObject);
begin
  //Buscar si esta grabado y rellenar datos
  if ( Trim( camion_c.Text ) <> '' ) and ( Estado = teAlta ) then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 * ');
    SQL.Add(' from frf_camiones ');
    SQL.Add(' where camion_c = ' + Trim( camion_c.Text ) );
    Open;
    if not IsEmpty then
    begin
      if MessageDlg( 'Ya hay un camión con este código, ¿desea rellenar los campos de la ficha actual con sus datos?.' , mtWarning, [mbYes, mbNo], 0 ) = mrYes then
       begin
         descripcion_c.Text:= FieldByName('descripcion_c').AsString;
         tara_c.Text:= FieldByName('tara_c').AsString;
         notas_c.Text:= FieldByName('notas_c').AsString;
       end;
    end;
    Close;
  end;
end;

end.


