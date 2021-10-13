unit MCalibres;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, Db, ExtCtrls,
  StdCtrls, DBCtrls, CMaestro, Grids, DBGrids, BGridButton, BDEdit, ComCtrls,
  BEdit, DError;

type
  TFMCalibre = class(TMaestro)
    PMaestro: TPanel;
    Bevel1: TBevel;
    LCalibre: TLabel;
    Lproducto: TLabel;
    LEmpresa_p: TLabel;
    STEmpresa_c: TStaticText;
    Label13: TLabel;
    STProducto_c: TStaticText;
    gridCalibre: TDBGrid;
    calibre_c: TBDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  public
    { Public declarations }
    procedure AntesDeInsertar;
    procedure AntesDeVisualizar;
    procedure ValidarEntradaMaestro;
    procedure Cancelar; override;
    procedure Aceptar; override;
  end;

var
  emp, prod, descEmp, descProd: string;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos,
  CAuxiliarDB, Principal, dbtables, MProductos;

{$R *.DFM}

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMCalibre.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
     //Fuente de datos maestro
 {+}DataSetMaestro := TFMProductos(Owner).QCalibres;

     //Texto estatico
  with TFMProductos(Owner) do
  begin
    STEmpresa_c.Caption := '  ' + empresa_p.Text + '  -  ' + STEmpresa_p.Caption;
    STProducto_c.Caption := '  ' + producto_p.Text + '     -  ' + descripcion_p.Text;
  end;

     //Validar entrada
  OnInsert := AntesDeInsertar;
  OnBrowse := AntesDeInsertar;
  OnView := AntesDeVisualizar;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
  RegistrosInsertados := 0;
  Registros := DataSeTMaestro.RecordCount;
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

     //Focos
  FocoAltas := calibre_c;
  gridCalibre.Enabled := true;
end;

procedure TFMCalibre.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     //Actvamos padre
  TFMProductos(Owner).Enabled := true;
  TFMProductos(Owner).RestituirEstados;
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMCalibre.ValidarEntradaMaestro;
begin
    //Que no hayan campos vacios
  if calibre_c.Text = '' then
  begin
    calibre_c.SetFocus;
    raise Exception.Create('Debe introducir un calibre...');
  end;
    //Rellenar clave
  with TFMProductos(Owner) do
  begin
    DataSetMaestro.FieldByName('empresa_c').AsString := empresa_p.Text;
    DataSetMaestro.FieldByName('producto_c').AsString := producto_p.Text;
  end;
end;

//Evento que se produce cuando pulsamos altas
//Aprobrechar para modificar estado controles

procedure TFMCalibre.AntesDeInsertar;
begin
  gridCalibre.Enabled := false;
  calibre_c.Enabled := true;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMCalibre.AntesDeVisualizar;
begin
  gridCalibre.Enabled := true;
  calibre_c.Enabled := false;
  FPrincipal.AMLocalizar.Enabled := false;
  FPrincipal.AMModificar.Enabled := false;
  FPrincipal.AIPrevisualizar.Enabled := false;
end;

procedure TFMCalibre.Cancelar;
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

procedure TFMCalibre.Aceptar;
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

end.
