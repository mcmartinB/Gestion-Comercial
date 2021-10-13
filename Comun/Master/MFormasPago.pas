unit MFormasPago;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, ComCtrls,
  Db, ExtCtrls, StdCtrls, CMaestro, Buttons, BDEdit, BEdit, DError,
  DBTables, BSpeedButton, BGridButton;

type
  TFMFormaPago = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    LCodigo_fp: TLabel;
    codigo_fp: TBDEdit;
    LDias_cobro_fp: TLabel;
    dias_cobro_fp: TBDEdit;
    LDescripcion_fp: TLabel;
    descripcion_fp: TBDEdit;
    Label13: TLabel;
    descripcion2_fp: TBDEdit;
    descripcion3_fp: TBDEdit;
    descripcion4_fp: TBDEdit;
    descripcion5_fp: TBDEdit;
    descripcion6_fp: TBDEdit;
    QFormaPago: TQuery;
    Label1: TLabel;
    forma_pago_adonix_fp: TBDEdit;
    descripcion7_fp: TBDEdit;
    descripcion8_fp: TBDEdit;
    descripcion9_fp: TBDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject;
      var isTime: Boolean);
//    procedure ACamposExecute(Sender: TObject);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    FRegistroABorrarFormaPagoId: String;

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

uses CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  Principal, LFormaPago, DPreview, bSQLUtils, CAuxiliarDB, UDMAuxDB,
  SincronizacionBonny;

{$R *.DFM}

procedure TFMFormaPago.AbrirTablas;
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

procedure TFMFormaPago.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

procedure TFMFormaPago.DespuesDeBorrar;
begin
  SincroBonnyAurora.SincronizarFormaPago(FRegistroABorrarFormaPagoId);
  SincroBonnyAurora.Sincronizar;
  FRegistroABorrarFormaPagoId := '';
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMFormaPago.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //***************************************************************
     //Fuente de datos maestro
     //CAMBIAR POR LA QUERY QUE LE TOQUE
 {+}DataSetMaestro := QFormaPago;
     //***************************************************************

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_forma_pago ';
 {+}where := ' WHERE codigo_fp=' + QuotedStr('###');
 {+}Order := ' ORDER BY codigo_fp';
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

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
//DEJAR LAS QUE SEAN NECESARIAS
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;

    // Sinconizacion Web - borrado
  OnBeforeMasterDelete := AlBorrar;
  OnAfterMasterDeleted := DespuesDeBorrar;

     //Focos
  FocoAltas := codigo_fp;
  FocoModificar := descripcion_fp;
  FocoLocalizar := codigo_fp;

{
     //Inicializar variables
     CalendarioFlotante.Date:=Date;
}
end;

procedure TFMFormaPago.FormActivate(Sender: TObject);
begin
     //Si la tabla no esta abierta salimos
  if not DataSetMaestro.Active then Exit;
     //Variables globales
  M := Self;
  MD := nil;
{*DEJAR LAS NECESARIAS
     gRF :=RejillaFlotante;
     RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
     gCF:=CalendarioFlotante;
}

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;

procedure TFMFormaPago.FormClose(Sender: TObject; var Action: TCloseAction);
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

{*DEJAR LAS QUE TENIAN VALOR
     //Por si acaso el nuevo form no necesita rejilla
     gRF:=nil;
     gCF:=nil;
}
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMFormaPago.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMFormaPago.Filtro;
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

procedure TFMFormaPago.AnyadirRegistro;
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

procedure TFMFormaPago.ValidarEntradaMaestro;
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
            raise Exception.Create('Dato necesario.');
        end;

      end;
    end;
  end;

  if forma_pago_adonix_fp.Text = '' then
  begin
    forma_pago_adonix_fp.SetFocus;
    raise Exception.Create('Falta la forma de pago Adonix.');
  end;

    //**************************************************************
    //REstricciones Particulares
    //**************************************************************
{*INSERTAR LAS NECESARIAS
    //Comprobar que el año_semana tenga obligatoriamente 6 cifras
    if (length(ano_semana_p.Text)<6)  then
    begin
         ano_semana_p.SetFocus;
         raise Exception.Create('El año y la semana de la plantacion debe set de 6 dígitos.');
    end;
    //Comprobar que las dos ultimas cifras del año_semana esten entre 00-53
    aux:=StrToInt(Copy(ano_semana_p.Text,5,2));
    if (aux<0) and (aux>53)  then
    begin
         ano_semana_p.SetFocus;
         raise Exception.Create('Las dos últimas cifras del año y la semana de la plantacion deben estar entre 00 y 53 ambos incluidos.');
    end;
}
end;

//**************************************************************
//IMPRESION: Introducir QuickReport
//**************************************************************

procedure TFMFormaPago.Previsualizar;
var enclave: TBookMark;
begin
     //Crear el listado
  enclave := DataSetMaestro.GetBookmark;
  QRLFormaPago := TQRLFormaPago.Create(Application);
  PonLogoGrupoBonnysa(QRLFormaPago);
  QRLFormaPago.DataSet := QFormaPago;
  Preview(QRLFormaPago);
  DataSetMaestro.GotoBookmark(enclave);
  DataSetMaestro.FreeBookmark(enclave);
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

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMFormaPago.AlBorrar;
begin
  FRegistroABorrarFormaPagoId := DSMaestro.DataSet.FieldByName('codigo_fp').asString;
end;

procedure TFMFormaPago.AntesDeModificar;
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
end;
//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMFormaPago.AntesDeVisualizar;
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
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************
//Para saber cuando tenemos que obligar a que un campo sea requerido

procedure TFMFormaPago.RequiredTime(Sender: TObject;
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

procedure TFMFormaPago.SincronizarWeb;
begin
  SincroBonnyAurora.SincronizarFormaPago(DSMaestro.DataSet.FieldByName('codigo_fp').asString);
  SincroBonnyAurora.Sincronizar;
end;

end.
