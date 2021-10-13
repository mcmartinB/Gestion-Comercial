unit MFederaciones;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DbTables, ExtCtrls, StdCtrls, Mask, CMaestro, BDEdit, ComCtrls,
  BEdit;

type
  TFMFederaciones = class(TMaestro)
    PMaestro: TPanel;
    LPlantacion_p: TLabel;
    codigo_f: TBDEdit;
    LEmpresa_p: TLabel;
    provincia_f: TBDEdit;
    Label13: TLabel;
    DSMaestro: TDataSource;
    QFederaciones: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    procedure AbrirTablas;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses CVariables, CGestionPrincipal, Principal, DError,
  UDMBaseDatos;

{$R *.DFM}

procedure TFMFederaciones.AbrirTablas;
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

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMFederaciones.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self; //Formulario maestro --> siempre es necesario
  MD := nil; //:=Self;  -->Formulario Maestro-Detalle

     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //***************************************************************
     //Fuente de datos maestr
  DataSetMaestro := QFederaciones;

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_federaciones ';
 {+}where := ' WHERE codigo_f="#"';
 {+}Order := ' ORDER BY codigo_f ';

     //Abrir tablas/Querys
  try
    AbrirTablas;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
              //si no podemos abrir la tabla cerramos el formulario
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


     //Focos
  FocoAltas := codigo_f;
  FocoModificar := codigo_f;
  FocoLocalizar := codigo_f;
end;

procedure TFMFederaciones.FormActivate(Sender: TObject);
begin
     //Si la tabla no esta abierta salimos
  if not DataSetMaestro.Active then Exit;
     //Variables globales
  M := Self;
  MD := nil;
     //Muestra la barra de herramientas de Maestro
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;


procedure TFMFederaciones.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMFederaciones.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMFederaciones.Filtro;
var Flag: Boolean;
begin
  where := '';
  Flag := false;

  if Trim(codigo_f.Text) <> '' then
  begin
    where := ' codigo_f = ' + '"' + codigo_f.Text + '"';
    flag := true;
  end;

  if Trim(codigo_f.Text) <> '' then
  begin
    if flag then where := where + ' and ';
    where := where + ' provincia_f = ' + '"' + provincia_f.Text + '"';
    flag := true;
  end;

  if flag then where := ' WHERE ' + where;
end;

procedure TFMFederaciones.AnyadirRegistro;
begin
  if where <> '' then where := where + ' OR ('
  else where := ' WHERE (';

  where := where + ' codigo_f = "' + codigo_f.Text + '" )';
end;


//**************************************************************
//IMPRESION: Introducir QuickReport
//**************************************************************

procedure TFMFederaciones.Previsualizar;
begin
//
end;

end.
