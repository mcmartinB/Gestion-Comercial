unit MCuentasCorreo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, DError, DBTables;

type
  TFMCuentasCorreo = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    lblDescripcion: TLabel;
    descripcion_ccc: TBDEdit;
    smtp_ccc: TBDEdit;
    lblSmtp: TLabel;
    lblClave: TLabel;
    clave_ccc: TBDEdit;
    QCuentas: TQuery;
    lblIdentificador: TLabel;
    identificador_ccc: TBDEdit;
    lblCodigo: TLabel;
    codigo_ccc: TBDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure descripcion_cccRequiredTime(Sender: TObject; var isTime: Boolean);
    procedure QCuentasNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

    function  GetCodigo: Integer;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;

    procedure ActivarCuenta( const ACuenta: integer );
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  LCampos, CAuxiliarDB, Principal, DPreview, bSQLUtils;

{$R *.DFM}

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMCuentasCorreo.AbrirTablas;
begin
     // Abrir tablas/Querys
  if not DataSetMaestro.Active then
  begin
    DataSetMaestro.SQL.Clear;
    DataSetMaestro.SQL.Add(Select);
    DatasetMaestro.SQL.Add(Where);
    DataSetMaestro.SQL.Add(Order);
    DataSetMaestro.Open;
  end;
     //Estado inicial
  Registro := 1;
  Registros := DataSetMaestro.RecordCount;
  RegistrosInsertados := 0;
end;

procedure TFMCuentasCorreo.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuery(DataSetMaestro);
end;

procedure TFMCuentasCorreo.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
  DataSetMaestro := QCuentas;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
  Select := ' SELECT * FROM cnf_cuentas_correo ';
  where := ' WHERE codigo_ccc = -999 ';
  Order := ' ORDER BY codigo_ccc ';
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

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;
     //Focos
  {+}FocoAltas := descripcion_ccc;
  {+}FocoModificar := descripcion_ccc;
  {+}FocoLocalizar := codigo_ccc;

end;

{+ CUIDADIN }

procedure TFMCuentasCorreo.FormActivate(Sender: TObject);
begin
  if not DataSetMaestro.Active then Exit;
     //Variables globales
  M := Self;
  MD := nil;
  gRF := nil;
  gCF:= nil;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;

procedure TFMCuentasCorreo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Lista.Free;

  //Habilitamos padre
  TForm(Owner).Enabled := True;
  FormType := tfOther;
  BHFormulario;

  //Cerramos tablas
  CerrarTablas;

  // Cambia acción por defecto para Form hijas en una aplicación MDI
  // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMCuentasCorreo.FormKeyDown(Sender: TObject; var Key: Word;
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

{+}//Sustituir por funcion generica

procedure TFMCuentasCorreo.Filtro;
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

procedure TFMCuentasCorreo.AnyadirRegistro;
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

procedure TFMCuentasCorreo.ValidarEntradaMaestro;
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


procedure TFMCuentasCorreo.Previsualizar;
begin
  ShowMessage('Sin listado.');
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMCuentasCorreo.AntesDeModificar;
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

procedure TFMCuentasCorreo.AntesDeVisualizar;
var i: Integer;
begin
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

procedure TFMCuentasCorreo.descripcion_cccRequiredTime(Sender: TObject;
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

function TFMCuentasCorreo.GetCodigo: Integer;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add( 'select max(codigo_ccc) from cnf_cuentas_correo');
    Open;
    result:= Fields[0].AsInteger + 1;
    Close;
  end;
end;

procedure TFMCuentasCorreo.QCuentasNewRecord(DataSet: TDataSet);
begin
  if Estado <> teLocalizar then
    QCuentas.FieldByName('codigo_ccc').AsInteger:= GetCodigo;
end;

procedure TFMCuentasCorreo.ActivarCuenta( const ACuenta: integer );
begin
  Select := ' SELECT * FROM cnf_cuentas_correo ';
  where := ' WHERE codigo_ccc = ' + IntToStr( ACuenta );
  Order := ' ORDER BY codigo_ccc ';

  DataSetMaestro.SQL.Clear;
  DataSetMaestro.SQL.Add(Select);
  DatasetMaestro.SQL.Add(Where);
  DataSetMaestro.SQL.Add(Order);
  DataSetMaestro.Open;

  //Estado inicial
  Registro := 1;
  Registros := DataSetMaestro.RecordCount;
  RegistrosInsertados := 0;

  Visualizar;
end;

end.
