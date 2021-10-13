unit MEAN13;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, Db,
  ExtCtrls, StdCtrls, DBCtrls, CMaestro, Buttons, BSpeedButton,
  DBGrids, BGridButton, BGrid, BDEdit, ComCtrls, Graphics,
  BEdit, DError, ActnList, Grids, DBTables;

type
  TFMEAN13 = class(TMaestro)
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    Label13: TLabel;
    ACampos: TAction;
    QEan13: TQuery;
    PMaestro: TPanel;
    LCodigo_e: TLabel;
    LEmpresa_e: TLabel;
    BGBEmpresa_e: TBGridButton;
    Label1: TLabel;
    Label2: TLabel;
    DBRGAgrupacion: TDBRadioGroup;
    RejillaFlotante: TBGrid;
    codigo_e: TBDEdit;
    empresa_e: TBDEdit;
    STEmpresa_e: TStaticText;
    descripcion_e: TBDEdit;
    cbxAgrupacion: TComboBox;
    ean14_e: TBDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject;
      var isTime: Boolean);
    procedure PonNombre(Sender: TObject);
    procedure codigo_eKeyPress(Sender: TObject; var Key: Char);
    //    procedure ACamposExecute(Sender: TObject);
  private
    { Private declarations }
    ListaComponentes: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure AntesDeBorrar;
    procedure AbrirTablas;
    procedure CerrarTablas;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;
    procedure AntesDeLocalizar;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses UDMAuxDB, CVariables, CGestionPrincipal, UDMBaseDatos, bCodeUtils,
  CAuxiliarDB, Principal, LEAN13, DPreview, bSQLUtils, CReportes, UDMConfig;

{$R *.DFM}

procedure TFMEAN13.AbrirTablas;
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

procedure TFMEAN13.CerrarTablas;
begin
  if DMBaseDatos.QDespegables.Active then
    DMBaseDatos.QDespegables.Tag := 0;
  //Cerramos todos los dataSet abiertos
  DMBaseDatos.DBBaseDatos.CloseDataSets;
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMEAN13.FormCreate(Sender: TObject);
begin
  //Variables globales
  M := Self;
  MD := nil;
  //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

  //***************************************************************
  //Fuente de datos maestro
  //CAMBIAR POR LA QUERY QUE LE TOQUE
{+}DataSetMaestro := QEan13;
  //***************************************************************

  //Intrucciones para sacar los datos (inicialmente consulta vacia)
{+}Select := ' SELECT * FROM frf_ean13 ';
  {+}where := ' WHERE codigo_e=' + QuotedStr('###');
  {+}Order := ' ORDER BY codigo_e ';
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
       //Asignamos constantes a los componentes que los tienen
       //para facilitar distingirlos
  empresa_e.Tag := kEmpresa;

  //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  //DEJAR LAS QUE SEAN NECESARIAS
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;
  OnBrowse := AntesDeLocalizar;
  OnBeforeMasterDelete:= AntesDeBorrar;

  //Focos
  FocoAltas := empresa_e;
  FocoModificar := descripcion_e;
  FocoLocalizar := empresa_e;

  {*     //Inicializar variables
       CalendarioFlotante.Date:=Date;
  }

  ListaComponentes := TList.Create;
  PMaestro.GetTabOrderList(ListaComponentes);
end;

procedure TFMEAN13.FormActivate(Sender: TObject);
begin
  //Si la tabla no esta abierta salimos
  if not DataSetMaestro.Active then
    Exit;
  //Variables globales
  M := Self;
  MD := nil;
  //DEJAR LAS NECESARIAS
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  //     gCF:=CalendarioFlotante;

       //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
  //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;

procedure TFMEAN13.FormDeactivate(Sender: TObject);
begin
  {*DEJAR LAS QUE TENIAN VALOR
     //Por si acaso el nuevo form no necesita rejilla
     gRF:=nil;
     gCF:=nil;
  }
end;

procedure TFMEAN13.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListaComponentes.Free;

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

procedure TFMEAN13.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //DEJAR SI EXISTE REJILLA
      //Si la rejilla esta desplegada no hacemos nada
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
      //No hacemos nada
      Exit;

  {*DEJAR SI EXISTE CALENDARIO
      //Si  el calendario esta desplegado no hacemos nada
      if (CalendarioFlotante<>nil) then
           if (CalendarioFlotante.Visible) then
              //No hacemos nada
              Exit;
  }

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

procedure TFMEAN13.Filtro;
var
  Flag: Boolean;
  i: Integer;
begin
  where := '';
  Flag := false;
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBEdit) then
    begin
      with Objeto as TBEdit do
      begin
        if Name <> 'descripcion_pb' then
        begin
          if Trim(Text) <> '' then
          begin
            if flag then
              where := where + ' and ';
            if InputType = itChar then
              where := where + ' ' + name + ' LIKE ' + SQLFilter(Text)
            else if InputType = itDate then
              where := where + ' ' + name + ' =' + SQLDate(Text)
            else
              where := where + ' ' + name + ' =' + SQLNumeric(Text);
            flag := True;
          end;
        end;
      end;
    end;
  end;

  if cbxAgrupacion.ItemIndex <> 0 then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    case cbxAgrupacion.ItemIndex of
      1: where := where + ' agrupacion_e = 0';
      2: where := where + ' agrupacion_e = 1';
      3: where := where + ' agrupacion_e = 2';
    end;
  end;

  if flag then
    where := ' WHERE ' + where;
end;

//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que son insertados
//para, else fin usa los campos que marcamos como PrimaryKey

procedure TFMEAN13.AnyadirRegistro;
var
  Flag: Boolean;
  i: Integer;
begin
  Flag := false;
  if where <> '' then
    where := where + ' OR ('
  else
    where := ' WHERE (';

  for i := 0 to ListaComponentes.Count - 1 do
  begin
    objeto := ListaComponentes.Items[i];
    if (objeto is TBDEdit) then
    begin
      with objeto as TBDEdit do
      begin
        if PrimaryKey and (Trim(Text) <> '') then
        begin
          if flag then
            where := where + ' and ';
          if InputType = itChar then
            where := where + ' ' + name + ' =' + SQLFilter(Text)
          else if InputType = itDate then
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

procedure TFMEAN13.ValidarEntradaMaestro;
begin
  //Codigo ean 13 valido
  if DigitoControlEAN13(codigo_e.Text) = False then
  begin
    raise Exception.Create('Código EAN13 no válido.');
  end;
end;

//**************************************************************
//IMPRESION: Introducir QuickReport
//**************************************************************

procedure TFMEAN13.Previsualizar;
var
  sAux: string;
begin
  //Crear el listado
  try
    with DMBaseDatos.QListado do
    begin
      if Active then
      begin
        Cancel;
        Close;
      end;
      SQL.Clear;
      SQL.Add('SELECT e13.empresa_e, emp.nombre_e, e13.codigo_e, e13.descripcion_e, ' +
              '       e13.agrupacion_e, e13.ean14_e ' +
            ' FROM   frf_ean13 e13, frf_empresas emp ');
      if where <> '' then
      begin
        sAux := StringReplace(where, 'empresa_e', 'e13.empresa_e',
          [rfReplaceAll, rfIgnoreCase]);
        SQL.Add(sAux + ' and emp.empresa_e = e13.empresa_e');
      end
      else
        SQL.Add(' where emp.empresa_e = e13.empresa_e');
      SQL.Add(' ORDER BY e13.empresa_e, e13.codigo_e ');
      try
        Open;
        RecordCount;
      except
        MessageDlg('Error al crear el listado.', mtError, [mbOK], 0);
        Exit;
      end;
    end;
    QRLEan13 := TQRLEan13.Create(Application);
    PonLogoGrupoBonnysa(QRLEan13);
    Preview(QRLEan13);
  finally
    DMBaseDatos.QListado.Cancel;
    DMBaseDatos.QListado.Close;
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

procedure TFMEAN13.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa_e);
  end;
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMEAN13.AntesDeBorrar;
begin
  with DMAuxDB.QAux do
  begin
    if not DMConfig.EsLaFont then
    begin
      SQL.Clear;
      SQL.Add(' select * from rf_palet_pc_det ');
      SQL.Add(' where ean13_det = :ean13 ');
      ParamByName('ean13').AsString:= codigo_e.Text;
      Open;
      if not IsEmpty then
      begin
        Close;
        raise Exception.Create('No se puede borrar el código EAN, ya esta utilizado en la RF.');
      end;
      Close;
    end;

    SQL.Clear;
    SQL.Add(' select * from frf_productos_proveedor ');
    SQL.Add(' where codigo_ean_pp = :ean13 ');
    ParamByName('ean13').AsString:= codigo_e.Text;
    Open;
    if not IsEmpty then
    begin
      Close;
      raise Exception.Create('No se puede borrar el código EAN, ya esta utilizado en las variedades del proveedor.');
    end;
    Close;

  end;
end;

procedure TFMEAN13.AntesDeInsertar;
begin
  empresa_e.Text:= gsDefEmpresa;
  DBRGAgrupacion.ItemIndex := 1;
  QEan13.FieldByName('agrupacion_e').AsInteger := 2;
end;

procedure TFMEAN13.AntesDeModificar;
var
  i: Integer;
begin
  //Deshabilitamos todos los componentes Modificable=False
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;
end;

procedure TFMEAN13.AntesDeLocalizar;
begin
  cbxAgrupacion.ItemIndex := 0;
  cbxAgrupacion.Visible := True;
  DBRGAgrupacion.Enabled := False;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMEAN13.AntesDeVisualizar;
var
  i: Integer;
begin
  //Resaturamos estado controles
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          if Enabled = false then
            Enabled := true;
  end;
  cbxAgrupacion.Visible := False;
  DBRGAgrupacion.Enabled := True;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMEAN13.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa:
      begin
        STEmpresa_e.Caption := desEmpresa(empresa_e.Text);
      end;
  end;
end;

//Para saber cuando tenemos que obligar a que un campo sea requerido

procedure TFMEAN13.RequiredTime(Sender: TObject;
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

procedure TFMEAN13.codigo_eKeyPress(Sender: TObject; var Key: Char);
begin
  if ((key < '0') or (key > '9')) and (key <> char(vk_back)) then
  begin
    Key := char(0);
  end;
end;

end.
