unit MColor;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, Db, ExtCtrls,
  StdCtrls, DBCtrls, CMaestro, Grids, DBGrids, BGrid, BDEdit, ComCtrls,
  BEdit, DError, ActnList;

type
  TFMColor = class(TMaestro)
    PMaestro: TPanel;
    Bevel1: TBevel;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    ACampos: TAction;
    STEmpresa_c: TStaticText;
    LEmpresa_p: TLabel;
    LProducto_p: TLabel;
    STProducto_c: TStaticText;
    gridColor: TDBGrid;
    Label1: TLabel;
    LCategoria: TLabel;
    color_c: TBDEdit;
    descripcion_c: TBDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
    { Public declarations }
    procedure Cancelar; override;
    procedure Aceptar; override;
    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;
    procedure ValidarEntradaMaestro;
  end;

var
  emp, prod, descEmp, descProd: string;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos,
  CAuxiliarDB, Principal, dbtables, MProductos;

{$R *.DFM}

procedure TFMColor.Cancelar;
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

procedure TFMColor.Aceptar;
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

procedure TFMColor.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := TFMProductos(Owner).QColores;

     //Texto estatico
  with TFMProductos(Owner) do
  begin
    STEmpresa_c.Caption := '  ' + empresa_p.Text + '  -  ' + STEmpresa_p.Caption;
    STProducto_c.Caption := '  ' + producto_p.Text + '     -  ' + descripcion_p.Text;
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

  FocoAltas := color_c;
  FocoModificar := descripcion_c;
end;

procedure TFMColor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     //Actvamos padre
  TFMProductos(Owner).Enabled := true;
  TFMProductos(Owner).RestituirEstados;
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMColor.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMColor.ValidarEntradaMaestro;
begin
    //Que no hayan campos vacios

  if color_c.Text = '' then
  begin
    color_c.SetFocus;
    raise Exception.Create('Debe introducir un código de color...');
  end;
  if descripcion_c.Text = '' then
  begin
    descripcion_c.SetFocus;
    raise Exception.Create('Debe introducir la descripción del color...');
  end;
  with TFMProductos(Owner) do
  begin
    DataSetMaestro.FieldByName('empresa_c').AsString := empresa_p.Text;
    DataSetMaestro.FieldByName('producto_c').AsString := producto_p.Text;
  end;
end;


//Evento que se produce cuando pulsamos altas
//Aprobrechar para modificar estado controles

procedure TFMColor.AntesDeInsertar;
begin
  gridColor.Enabled := false;
  color_c.Enabled := true;
  descripcion_c.Enabled := true;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMColor.AntesDeModificar;
begin
  gridColor.Enabled := false;
  color_c.Enabled := false;
  descripcion_c.Enabled := true;
end;
//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMColor.AntesDeVisualizar;
begin
  gridColor.Enabled := true;
  color_c.Enabled := false;
  descripcion_c.Enabled := false;
  FPrincipal.AMLocalizar.Enabled := false;
  FPrincipal.AIPrevisualizar.Enabled := false;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************
end.
