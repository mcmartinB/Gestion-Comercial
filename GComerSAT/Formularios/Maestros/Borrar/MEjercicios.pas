unit MEjercicios;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, ExtCtrls,
  Db, StdCtrls, Mask, DBCtrls, CMaestro, Buttons, BSpeedButton, Grids, DBGrids,
  BGridButton, BGrid, BDEdit, BCalendarButton, ComCtrls, BCalendario,
  BEdit, DError, ActnList;

type
  TFMEjercicios = class(TMaestro)
    PMaestro: TPanel;
    Bevel1: TBevel;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    STEmpresa_c: TStaticText;
    LEmpresa_p: TLabel;
    LProducto_p: TLabel;
    STProducto_c: TStaticText;
    gridEjercicios: TDBGrid;
    Label1: TLabel;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    STCentro_e: TStaticText;
    centro_e: TBDEdit;
    BGBECentro_e: TBGridButton;
    LCentro: TLabel;
    BCBFecha_inicio_p: TBCalendarButton;
    ejercicio_e: TBDEdit;
    LInicio_ejercicio_p: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeydown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DesplegarRejilla(Sender: TObject);
    procedure PonNombre(Sender: TObject);

  public
    procedure Cancelar; override;
    procedure Aceptar; override;
    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;
    procedure ValidarEntradaMaestro;

  private
    codEmpresa: string;
  end;

var
  emp, prod, descEmp, descProd: string;

implementation

uses UDMAuxDB, CVariables, CGestionPrincipal, UDMBaseDatos,
  CAuxiliarDB, Principal, dbtables, MProductos;

{$R *.DFM}

procedure TFMEjercicios.Cancelar;
begin
  case Estado of
    teAlta:
      begin
               //Cancelamos
        DataSeTMaestro.Cancel;
               //Cuantos datos estamos visualizando actualment
        Registros := DataSeTMaestro.RecordCount;
        if Registros = 0 then Registro := 0
        else Registro := 1;
        Visualizar;
      end;
    teLocalizar: CancelarLocalizar;
    teModificar: CancelarModificar;
  end;
end;

procedure TFMEjercicios.Aceptar;
begin
  case Estado of
    teAlta:
      begin
        try
          ValidarEntradaMaestro;
        except
          on E: Exception do
          begin
            ShowError(E);
            Exit;
          end;
        end;
        try
          DataSeTMaestro.Post;
                  //Refrescar datos
          DataSeTMaestro.Close;
          DataSeTMaestro.Open;
        except
          on e: EDBengineError do
          begin
            ShowError(e);
            Exit;
          end;
        end;
        RegistrosInsertados := RegistrosInsertados + 1;
               //Hasta que no cancelemos daremos altas
        Altas;
      end;
    teLocalizar: AceptarLocalizar;
    teModificar: AceptarModificar;
  end;
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMEjercicios.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := TFMProductos(Owner).QEjercicios;

     //Texto estatico
  with TFMProductos(Owner) do
  begin
    STEmpresa_c.Caption := '  ' + empresa_p.Text + '  -  ' + STEmpresa_p.Caption;
    STProducto_c.Caption := '  ' + producto_p.Text + '     -  ' + descripcion_p.Text;
    codEmpresa := empresa_p.Text;
  end;

     //Validar entrada
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
  RegistrosInsertados := 0;
  Registros := DataSetMaestro.RecordCount;
  if Registros <> 0 then
  begin
    Registro := 1;
    DataSetMaestro.First;
    PCMaestro := pcInicio;
  end
  else
  begin
    Registro := 0;
    PCMaestro := pcNulo;
  end;

     //Visualizar estado inicial
  Visualizar;

  centro_e.Tag := kCentro;
  ejercicio_e.Tag := kCalendar;
  FocoAltas := centro_e;
  FocoModificar := ejercicio_e;
end;


procedure TFMEjercicios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     //Actvamos padre
  TFMProductos(Owner).Enabled := true;
  TFMProductos(Owner).RestituirEstados;

  CloseAuxQuerys;

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMEjercicios.FormKeydown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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


//function semi-generica, introducir restricciones particulares donde se indica
//Conprueba que tengan valor todos los campos marcados como required

procedure TFMEjercicios.ValidarEntradaMaestro;
begin
    //Que no hayan campos vacios
    //Que no hayan campos vacios
  if centro_e.Text = '' then
  begin
    centro_e.SetFocus;
    raise Exception.Create('Debe introducir un código de centro...');
  end;
  if ejercicio_e.Text = '' then
  begin
    ejercicio_e.SetFocus;
    raise Exception.Create('Debe introducir la fecha de inicio del ejecicio...');
  end;
  with TFMProductos(Owner) do
  begin
    DataSetMaestro.FieldByName('empresa_e').AsString := empresa_p.Text;
    DataSetMaestro.FieldByName('producto_e').AsString := producto_p.Text;
  end;
end;

//Evento que se produce cuando pulsamos altas
//Aprobrechar para modificar estado controles

procedure TFMEjercicios.AntesDeInsertar;
begin
  gridEjercicios.Enabled := False;
  centro_e.Enabled := true;
  ejercicio_e.Enabled := true;
  BCBFecha_inicio_p.Enabled := true;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMEjercicios.AntesDeModificar;
begin
  gridEjercicios.Enabled := False;
  centro_e.Enabled := False;
  ejercicio_e.Enabled := true;
  BCBFecha_inicio_p.Enabled := True;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMEjercicios.AntesDeVisualizar;
begin
  gridEjercicios.Enabled := True;
  ejercicio_e.Enabled := false;
  centro_e.Enabled := false;
  BCBFecha_inicio_p.Enabled := false;
  FPrincipal.AMLocalizar.Enabled := false;
  FPrincipal.AIPrevisualizar.Enabled := False;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMEjercicios.DesplegarRejilla(Sender: TObject);
begin
  case ActiveControl.Tag of
    kCentro: DespliegaRejilla(BGBECentro_e, [codEmpresa]);
    kCalendar: DespliegaCalendario(BCBFecha_inicio_p);
  end;
end;


procedure TFMEjercicios.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  STCentro_e.Caption := desCentro(TFMProductos(Owner).empresa_p.Text, centro_e.Text);
end;

end.
