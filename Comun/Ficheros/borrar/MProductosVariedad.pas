unit MProductosVariedad;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, Db, ExtCtrls,
  StdCtrls, DBCtrls, CMaestro, Grids, DBGrids, BGrid, BDEdit, ComCtrls,
  BEdit, DError, ActnList;

type
  TFMProductosVariedad = class(TMaestro)
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
    codigo_pv: TBDEdit;
    descripcion_pv: TBDEdit;
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

procedure TFMProductosVariedad.Cancelar;
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

procedure TFMProductosVariedad.Aceptar;
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

procedure TFMProductosVariedad.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := TFMProductos(Owner).qryVariedad;

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

  FocoAltas := codigo_pv;
  FocoModificar := descripcion_pv;
end;

procedure TFMProductosVariedad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     //Actvamos padre
  TFMProductos(Owner).Enabled := true;
  TFMProductos(Owner).RestituirEstados;
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMProductosVariedad.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMProductosVariedad.ValidarEntradaMaestro;
begin
    //Que no hayan campos vacios

  if codigo_pv.Text = '' then
  begin
    codigo_pv.SetFocus;
    raise Exception.Create('Debe introducir un código de variedad...');
  end;
  if descripcion_pv.Text = '' then
  begin
    descripcion_pv.SetFocus;
    raise Exception.Create('Debe introducir la descripción de la variedad...');
  end;
  with TFMProductos(Owner) do
  begin
    DataSetMaestro.FieldByName('empresa_pv').AsString := empresa_p.Text;
    DataSetMaestro.FieldByName('producto_pv').AsString := producto_p.Text;
  end;
end;


//Evento que se produce cuando pulsamos altas
//Aprobrechar para modificar estado controles

procedure TFMProductosVariedad.AntesDeInsertar;
begin
  gridColor.Enabled := false;
  codigo_pv.Enabled := true;
  descripcion_pv.Enabled := true;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMProductosVariedad.AntesDeModificar;
begin
  gridColor.Enabled := false;
  codigo_pv.Enabled := false;
  descripcion_pv.Enabled := true;
end;
//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMProductosVariedad.AntesDeVisualizar;
begin
  gridColor.Enabled := true;
  codigo_pv.Enabled := false;
  descripcion_pv.Enabled := false;
  FPrincipal.AMLocalizar.Enabled := false;
  FPrincipal.AIPrevisualizar.Enabled := false;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************
end.
