unit MPais;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, Db, ExtCtrls,
  StdCtrls, DBCtrls, CMaestro, Grids, DBGrids, BGrid, BDEdit, ComCtrls,
  BEdit, DError, ActnList, Buttons, BSpeedButton, BGridButton;

type
  TFMPais = class(TMaestro)
    PMaestro: TPanel;
    Bevel1: TBevel;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    ACampos: TAction;
    STEmpresa: TStaticText;
    LEmpresa_p: TLabel;
    LProducto_p: TLabel;
    STProducto: TStaticText;
    gridPais: TDBGrid;
    Label1: TLabel;
    LCategoria: TLabel;
    pais_psp: TBDEdit;
    stPais: TStaticText;
    RejillaFlotante: TBGrid;
    btnpais: TBGridButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pais_pspChange(Sender: TObject);
    procedure ARejillaFlotanteExecute(Sender: TObject);
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
  CAuxiliarDB, Principal, dbtables, MProductos,
  UDMAuxDB;

{$R *.DFM}

procedure TFMPais.Cancelar;
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

procedure TFMPais.Aceptar;
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

procedure TFMPais.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;

  pais_psp.Tag:= kPais;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := TFMProductos(Owner).qryPaises;

     //Texto estatico
  with TFMProductos(Owner) do
  begin
    STEmpresa.Caption := '  ' + empresa_p.Text + '  -  ' + STEmpresa_p.Caption;
    STProducto.Caption := '  ' + producto_p.Text + '     -  ' + descripcion_p.Text;
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

  FocoAltas := pais_psp;
  FocoModificar := pais_psp;
end;

procedure TFMPais.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     //Actvamos padre
  TFMProductos(Owner).Enabled := true;
  TFMProductos(Owner).RestituirEstados;
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMPais.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMPais.ValidarEntradaMaestro;
begin
    //Que no hayan campos vacios

  if stPais.Caption = '' then
  begin
    pais_psp.SetFocus;
    raise Exception.Create('Falta el codigo del país o es incorrecto.');
  end;
  with TFMProductos(Owner) do
  begin
    DataSetMaestro.FieldByName('empresa_psp').AsString := empresa_p.Text;
    DataSetMaestro.FieldByName('producto_psp').AsString := producto_p.Text;
  end;
end;


//Evento que se produce cuando pulsamos altas
//Aprobrechar para modificar estado controles

procedure TFMPais.AntesDeInsertar;
begin
  gridPais.Enabled := false;
  pais_psp.Enabled := true;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMPais.AntesDeModificar;
begin
  gridPais.Enabled := false;
  pais_psp.Enabled := True;
end;
//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMPais.AntesDeVisualizar;
begin
  gridPais.Enabled := true;
  pais_psp.Enabled := false;
  FPrincipal.AMLocalizar.Enabled := false;
  FPrincipal.AIPrevisualizar.Enabled := false;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************
procedure TFMPais.pais_pspChange(Sender: TObject);
begin
  stPais.Caption:= desPais( pais_psp.text );
end;

procedure TFMPais.ARejillaFlotanteExecute(Sender: TObject);
begin
  DespliegaRejilla( btnPais );
end;

end.
