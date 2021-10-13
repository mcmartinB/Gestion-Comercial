unit ReclamacionesFM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons, ActnList, BGrid,
  BSpeedButton, Grids, DBGrids, BGridButton, BDEdit, BCalendarButton, ComCtrls,
  BCalendario, BEdit, dbTables, DError;

type
  TFMReclamaciones = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    lblEmpresa: TLabel;
    empresa_rcl: TBDEdit;
    STEmpresa: TStaticText;
    Label13: TLabel;
    cliente_rcl: TBDEdit;
    lblCliente: TLabel;
    lblReclamacion: TLabel;
    n_reclamacion_rcl: TBDEdit;
    lblEmail: TLabel;
    email_rcl: TBDEdit;
    lblNombre: TLabel;
    nombre_rcl: TBDEdit;
    observacion_rcl: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    n_pedido_rcl: TBDEdit;
    Label3: TLabel;
    n_albaran_rcl: TBDEdit;
    Label4: TLabel;
    Label5: TLabel;
    fecha_albaran_rcl: TBDEdit;
    producto_rcl: TBDEdit;
    Label6: TLabel;
    idioma_rcl: TBDEdit;
    Label7: TLabel;
    caj_kgs_uni_rcl: TBDEdit;
    cantidad_rcl: TBDEdit;
    porc_rajado_rcl: TBDEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    porc_mancha_rcl: TBDEdit;
    porc_moho_rcl: TBDEdit;
    porc_blando_rcl: TBDEdit;
    porc_otros_rcl: TBDEdit;
    porc_color_rcl: TBDEdit;
    descripcion_otros_rcl: TDBMemo;
    Label17: TLabel;
    n_devolucion_rcl: TBDEdit;
    t_devolucion_rcl: TDBMemo;
    Label18: TLabel;
    n_reseleccion_rcl: TBDEdit;
    t_reseleccion_rcl: TDBMemo;
    Label19: TLabel;
    n_otros_rcl: TBDEdit;
    t_otros_rcl: TDBMemo;
    Label16: TLabel;
    cbxUnidad: TComboBox;
    Button1: TButton;
    Label8: TLabel;
    notas_exporta_rcl: TDBMemo;
    Bevel1: TBevel;
    Bevel2: TBevel;
    STCliente: TStaticText;
    StProducto: TStaticText;
    Button2: TButton;
    cbxIdiomas: TComboBox;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    lblDevolucion: TLabel;
    lblReseleccion: TLabel;
    lblOtros: TLabel;
    Label26: TLabel;
    fecha_rcl: TBDEdit;
    Label27: TLabel;
    hora_rcl: TBDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure PonNombreEmpresa(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure cbxUnidadChange(Sender: TObject);
    procedure caj_kgs_uni_rclChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PonNombreCliente(Sender: TObject);
    procedure PonNombreProducto(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure cbxIdiomasChange(Sender: TObject);
    procedure idioma_rclChange(Sender: TObject);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;
    bPrimeraVez: Boolean;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeModificar;
    procedure AntesDeInsertar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;

    procedure Borrar; Override;
    procedure BorrarActivo;
    procedure BorrarImagen( const ANombre: string );
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos,
     UDMAuxDB, CAuxiliarDB, Principal, DPreview, bSQLUtils, CReportes,
     ReclamacionesQM, ReclamaFotosFD, WEBDM, BajarReclamacionesFD,
     SelecFotosFD, ReclamaFotosQD, UDMConfig;

{$R *.DFM}

procedure TFMReclamaciones.AbrirTablas;
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

procedure TFMReclamaciones.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMReclamaciones.FormCreate(Sender: TObject);
begin
  DMWEB:= TDMWEB.Create( Self );

     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := DMWEB.QReclamaciones;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_reclamaciones ';
 {+}where := ' WHERE empresa_rcl=' + QuotedStr('###');
 {+}Order := ' ORDER BY empresa_rcl, fecha_rcl desc, n_reclamacion_rcl ';

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
  empresa_rcl.Tag := kEmpresa;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnEdit := AntesDeModificar;
  OnInsert:= AntesDEInsertar;
  OnView := AntesDeVisualizar;
     //Focos
  {+}FocoAltas := cliente_rcl;
  {+}FocoModificar := email_rcl;
  {+}FocoLocalizar := empresa_rcl;


  bPrimeraVez:= True;

  cbxUnidad.ItemIndex:= -1;
  cbxIdiomas.ItemIndex:= -1;
  lblDevolucion.Caption:= '';
  lblReseleccion.Caption:= '';
  lblOtros.Caption:= '';
end;

{+ CUIDADIN }

procedure TFMReclamaciones.FormActivate(Sender: TObject);
var
  FDBajarReclamaciones: TFDBajarReclamaciones;
begin
  //Formulario activo
  M := self;
  MD := nil;
     //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
  gRF := nil;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);

  //La primera vez miramos a ver si hay reclamaciones pendientes
  if bPrimeraVez and ( DMConfig.iNivelReclamaciones > 1 )then
  begin
    DMWEB.QReclamaciones.DisableControls;

    try
      FDBajarReclamaciones:= TFDBajarReclamaciones.Create( Application );
      FDBajarReclamaciones.ShowModal;
    finally
      FreeAndNil( FDBajarReclamaciones );
    end;
  end;


  if bPrimeraVez then
  begin
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
    bPrimeraVez:= False;
  end;

  DMWEB.QReclamaciones.EnableControls;
end;


procedure TFMReclamaciones.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
end;

procedure TFMReclamaciones.FormClose(Sender: TObject; var Action: TCloseAction);
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
  FreeAndNil( DMWEB );
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMReclamaciones.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  if not( ActiveControl is TDBMemo ) then
  begin
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
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

{+}//Sustituir por funcion generica

procedure TFMReclamaciones.Filtro;
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

procedure TFMReclamaciones.AnyadirRegistro;
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

procedure TFMReclamaciones.ValidarEntradaMaestro;
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
          if CanFocus then
            Focused;
          if Trim(RequiredMsg) <> '' then
          begin
            raise Exception.Create(RequiredMsg)
          end
          else
          begin
            raise Exception.Create('Faltan datos de obligada inserción.');
          end;
        end;
      end;
    end;
  end;
end;


procedure TFMReclamaciones.Previsualizar;
var
  Anyo, Mes, Dia: Word;
begin
  DMWEB.QListado.SQL.Clear;
  DMWEB.QListado.SQL.Add( ' Select * ');
  DMWEB.QListado.SQL.Add( ' From frf_reclamaciones ');
  DMWEB.QListado.SQL.Add( ' Where empresa_rcl = :empresa ');
  DMWEB.QListado.SQL.Add( '   and cliente_rcl = :cliente ');
  DMWEB.QListado.SQL.Add( '   and n_reclamacion_rcl = :reclama ');
  DMWEB.QListado.ParamByName('empresa').AsString:= DMWEB.QReclamacionesempresa_rcl.AsString;
  DMWEB.QListado.ParamByName('cliente').AsString:= DMWEB.QReclamacionescliente_rcl.AsString;
  DMWEB.QListado.ParamByName('reclama').AsString:= DMWEB.QReclamacionesn_reclamacion_rcl.AsString;
  DMWEB.QListado.Open;

  QMReclamaciones := TQMReclamaciones.Create(Application);
  PonLogoGrupoBonnysa(QMReclamaciones);
  QMReclamaciones.lblEmpresa.Caption:= desEmpresa( empresa_rcl.Text );
  DecodeDate( DMWEB.QReclamacionesfecha_rcl.AsDateTime, Anyo, Mes, Dia );
  QMReclamaciones.ReportTitle:= 'RECLAMACION - ' + DMWEB.QReclamacionesn_reclamacion_rcl.AsString + '/' + IntToStr( Anyo );
  Preview(QMReclamaciones);

  DMWEB.QListado.Close;
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//*****************************************************************************

procedure TFMReclamaciones.ARejillaFlotanteExecute(Sender: TObject);
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

procedure TFMReclamaciones.AntesDeModificar;
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

procedure TFMReclamaciones.AntesDeInsertar;
begin
  if Estado = teAlta then
  begin
    idioma_rcl.Text:= 'ES';
    cbxIdiomas.ItemIndex:= 0;
    caj_kgs_uni_rcl.Text:= 'C';
    cbxUnidad.ItemIndex:= 0;
    //QReclamacionesempresa_rcl.AsString:= '050';
    //QReclamacionesn_reclamacion_rcl.AsInteger:= GetNumeroReclamacion;
    empresa_rcl.Text:= '050';
    n_reclamacion_rcl.Text:= IntToStr( DMWEB.GetNumeroReclamacion );
    DMWEB.bAlta:= True;
  end;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMReclamaciones.AntesDeVisualizar;
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

procedure TFMReclamaciones.RequiredTime(Sender: TObject;
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

procedure TFMReclamaciones.Button1Click(Sender: TObject);
var
  FDReclamaFotos: TFDReclamaFotos;
begin
  if Estado = teConjuntoResultado then
  begin
    with DMWEB.QReclamaFotos.SQL do
    begin
      Clear;
      Add(' SELECT * ');
      Add(' FROM frf_reclama_fotos ');
      Add(' WHERE empresa_rft = :empresa ');
      Add('   AND cliente_rft = :cliente ');
      Add('   AND n_reclamacion_rft = :reclama ');
    end;

    DMWEB.QReclamaFotos.ParamByName('empresa').AsString:=
      DMWEB.QReclamacionesEmpresa_rcl.AsString;
    DMWEB.QReclamaFotos.ParamByName('cliente').AsString:=
      DMWEB.QReclamacionescliente_rcl.AsString;
    DMWEB.QReclamaFotos.ParamByName('reclama').AsInteger:=
      DMWEB.QReclamacionesn_reclamacion_rcl.AsInteger;

    DMWEB.QReclamaFotos.Open;
    if not DMWEB.QReclamaFotos.IsEmpty then
    begin
      FDReclamaFotos:= TFDReclamaFotos.Create( self );
      FDReclamaFotos.Top:= 21;
      FDReclamaFotos.Left:= 21;
      FDReclamaFotos.CargarImagen;
      FDReclamaFotos.ShowModal;
    end;
    DMWEB.QReclamaFotos.Close;
  end;
end;

procedure TFMReclamaciones.BorrarImagen( const ANombre: string );
var
  sAux: string;
begin
  sAux:= kLocalDir + ANombre + '.jpg';
  if FileExists( sAux ) then
  try
    DeleteFile( sAux );
  except
  end;
end;

procedure TFMReclamaciones.BorrarActivo;
begin
  with DMWEB.QReclamaFotos do
  begin
    SQL.Clear;
    SQL.Add(' SELECT * ');
    SQL.Add(' FROM frf_reclama_fotos ');
    SQL.Add(' WHERE empresa_rft = :empresa ');
    SQL.Add('   AND cliente_rft = :cliente ');
    SQL.Add('   AND n_reclamacion_rft = :reclama ');

    ParamByName('empresa').AsString:= DMWEB.QReclamacionesEmpresa_rcl.AsString;
    ParamByName('cliente').AsString:= DMWEB.QReclamacionescliente_rcl.AsString;
    ParamByName('reclama').AsInteger:= DMWEB.QReclamacionesn_reclamacion_rcl.AsInteger;
  end;

  DMWEB.QReclamaFotos.Open;
  while not DMWEB.QReclamaFotos.EOF do
  begin
    BorrarImagen( DMWEB.QReclamaFotosfichero_rft.AsString );
    DMWEB.QReclamaFotos.Delete;
  end;
  DMWEB.QReclamaFotos.Close;

  DMWEB.QReclamaciones.Delete;
  if Registro = Registros then Registro := Registro - 1;
  Registros := Registros - 1;  
end;

procedure TFMReclamaciones.Borrar;
var botonPulsado: Word;
begin
  //Barra estado
  Estado := teBorrar;
  BEEstado;
  BHEstado;

  botonPulsado := MessageDlg('¿Desea borrar la reclamación seleccionada?',
    mtConfirmation, [mbYes, mbNo], 0);
  if botonPulsado = mrYes then
  try
    BorrarActivo;
  except
    on E: EDBEngineError do
    begin
      ShowError(e);
    end;
  end;

  //Por ultimo visualizamos resultado
  Visualizar;
end;

procedure TFMReclamaciones.PonNombreEmpresa(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(empresa_rcl.Text);
end;

procedure TFMReclamaciones.PonNombreCliente(Sender: TObject);
begin
  STCliente.Caption := DMWEB.desCliente(cliente_rcl.Text);
end;

procedure TFMReclamaciones.PonNombreProducto(Sender: TObject);
begin
  StProducto.Caption := DMWEB.DesProducto(producto_rcl.Text);
end;

procedure TFMReclamaciones.Button2Click(Sender: TObject);
var
  iAnyo, iMes, iDia: Word;
  sTitulo: string;
  bImprimir: Boolean;
  bImprimirFotos: array [0..9] of boolean;
  QDReclamaFotos: TQDReclamaFotos;
begin
  DecodeDate( DMWEB.QReclamacionesfecha_rcl.AsDateTime, iAnyo, iMes, iDia );
  sTitulo:='IMAGENES RECLAMACION - ' +
      DMWEB.QReclamacionesn_reclamacion_rcl.AsString + '/' + IntToStr( iAnyo );

  if Estado = teConjuntoResultado then
  begin
    with DMWEB.QReclamaFotos.SQL do
    begin
      Clear;
      Add(' SELECT * ');
      Add(' FROM frf_reclama_fotos ');
      Add(' WHERE empresa_rft = :empresa ');
      Add('   AND cliente_rft = :cliente ');
      Add('   AND n_reclamacion_rft = :reclama ');
    end;

    DMWEB.QReclamaFotos.ParamByName('empresa').AsString:=
      DMWEB.QReclamacionesEmpresa_rcl.AsString;
    DMWEB.QReclamaFotos.ParamByName('cliente').AsString:=
      DMWEB.QReclamacionescliente_rcl.AsString;
    DMWEB.QReclamaFotos.ParamByName('reclama').AsInteger:=
      DMWEB.QReclamacionesn_reclamacion_rcl.AsInteger;

    DMWEB.QReclamaFotos.Open;
    if not DMWEB.QReclamaFotos.IsEmpty then
    begin
      SelecFotosFD.ImprimirFotosReclama( sTitulo, bImprimir, bImprimirFotos );

      if bImprimir then
      begin
        QDReclamaFotos:= TQDReclamaFotos.Create( application );
        QDReclamaFotos.ImprimirFotos( bImprimirFotos );
        QDReclamaFotos.ReportTitle:= sTitulo;
        try
          Preview(QDReclamaFotos);
        except
          FreeAndNil( QDReclamaFotos );
          DMWEB.QReclamaFotos.Close;
          raise;
        end;
      end;
    end;
    DMWEB.QReclamaFotos.Close;
  end;
end;

procedure TFMReclamaciones.cbxUnidadChange(Sender: TObject);
begin
  if caj_kgs_uni_rcl.DataSource.State in [ dsInsert, dsEdit ] then
  begin
    caj_kgs_uni_rcl.Text:= Copy(cbxUnidad.Items[cbxUnidad.ItemIndex],1,1);
  end;
end;

procedure TFMReclamaciones.caj_kgs_uni_rclChange(Sender: TObject);
begin
  if UpperCase(caj_kgs_uni_rcl.Text) = 'C' then
    cbxUnidad.ItemIndex:= 0
  else
  if UpperCase(caj_kgs_uni_rcl.Text) = 'K' then
    cbxUnidad.ItemIndex:= 1
  else
  if UpperCase(caj_kgs_uni_rcl.Text) = 'U' then
    cbxUnidad.ItemIndex:= 2
  else
  begin
    if ( caj_kgs_uni_rcl.DataSource.State in [ dsInsert, dsEdit ] ) and
       ( Estado <> teLocalizar ) then
    begin
      caj_kgs_uni_rcl.Text:= 'C';
      cbxUnidad.ItemIndex:= 0;
    end
    else
    begin
      cbxUnidad.ItemIndex:= -1;
    end
  end;
  lblDevolucion.Caption:= cbxUnidad.Items[cbxUnidad.Itemindex];
  lblReseleccion.Caption:= cbxUnidad.Items[cbxUnidad.Itemindex];
  lblOtros.Caption:= cbxUnidad.Items[cbxUnidad.Itemindex];
end;

procedure TFMReclamaciones.cbxIdiomasChange(Sender: TObject);
begin
  if idioma_rcl.DataSource.State in [ dsInsert, dsEdit ] then
  begin
    case cbxIdiomas.ItemIndex of
      0: idioma_rcl.Text:= 'es';
      1: idioma_rcl.Text:= 'en';
      2: idioma_rcl.Text:= 'de';
    end;
  end;
end;

procedure TFMReclamaciones.idioma_rclChange(Sender: TObject);
begin
  if idioma_rcl.Text = 'es' then
    cbxIdiomas.ItemIndex:= 0
  else
  if idioma_rcl.Text = 'en' then
    cbxIdiomas.ItemIndex:= 1
  else
  if idioma_rcl.Text = 'de' then
    cbxIdiomas.ItemIndex:= 2
  else
  begin
    if ( idioma_rcl.DataSource.State in [ dsInsert, dsEdit ] ) and
       ( Estado <> teLocalizar ) then
    begin
      idioma_rcl.Text:= 'es';
      cbxIdiomas.ItemIndex:= 0;
    end
    else
    begin
      cbxIdiomas.ItemIndex:= -1;
    end;
  end;
end;

end.

