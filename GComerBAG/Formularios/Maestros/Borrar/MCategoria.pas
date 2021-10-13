unit MCategoria;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, Db, ExtCtrls,
  StdCtrls, DBCtrls, CMaestro, Grids, DBGrids, BDEdit, ComCtrls,
  BEdit, DError, ActnList;

type
  TFMCategoria = class(TMaestro)
    PMaestro: TPanel;
    Bevel1: TBevel;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    ACampos: TAction;
    STEmpresa_c: TStaticText;
    LEmpresa_p: TLabel;
    LProducto_p: TLabel;
    STProducto_c: TStaticText;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    LCategoria: TLabel;
    descripcion_c: TBDEdit;
    categoria_c: TBDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
//    procedure ACamposExecute(Sender: TObject);
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

procedure TFMCategoria.Cancelar;
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

procedure TFMCategoria.Aceptar;
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

procedure TFMCategoria.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := TFMProductos(Owner).QCategorias;

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

  FocoAltas := categoria_c;
  FocoModificar := descripcion_c;
end;

procedure TFMCategoria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     //Actvamos padre
  TFMProductos(Owner).Enabled := true;
  TFMProductos(Owner).RestituirEstados;
     // Cambia acci�n por defecto para Form hijas en una aplicaci�n MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMCategoria.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edici�n
    //               y entre los Campos de B�squeda en la localizaci�n
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

procedure TFMCategoria.ValidarEntradaMaestro;
begin
    //Que no hayan campos vacios
  if categoria_c.Text = '' then
  begin
    categoria_c.SetFocus;
    raise Exception.Create('Debe introducir un c�digo de categor�a...');
  end;
  if descripcion_c.Text = '' then
  begin
    descripcion_c.SetFocus;
    raise Exception.Create('Debe introducir la descripci�n de la categor�a...');
  end;
    //Rellenar clave
  with TFMProductos(Owner) do
  begin
    DataSetMaestro.FieldByName('empresa_c').AsString := empresa_p.Text;
    DataSetMaestro.FieldByName('producto_c').AsString := producto_p.Text;
  end;
end;


//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos altas
//Aprobrechar para modificar estado controles

procedure TFMCategoria.AntesDeInsertar;
begin
  DBgrid1.Enabled := false;
  categoria_c.Enabled := true;
  descripcion_c.Enabled := true;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMCategoria.AntesDeModificar;
begin
  DBgrid1.Enabled := false;
  categoria_c.Enabled := false;
  descripcion_c.Enabled := true;
end;

procedure TFMCategoria.AntesDeVisualizar;
begin
  DBgrid1.Enabled := true;
  categoria_c.Enabled := false;
  descripcion_c.Enabled := False;
  FPrincipal.AMLocalizar.Enabled := false;
  FPrincipal.AIPrevisualizar.Enabled := false;
end;

end.
