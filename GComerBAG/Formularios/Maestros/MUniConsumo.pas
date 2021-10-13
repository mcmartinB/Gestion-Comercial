unit MUniConsumo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CMaestro, StdCtrls, BEdit, BDEdit, DB, DBTables, ExtCtrls, DBCtrls,
  ActnList, Grids, DBGrids, BGrid, Buttons, BSpeedButton, BGridButton;

type
  TFMUniConsumo = class(TMaestro)
    PMaestro: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblPesoProducto: TLabel;
    empresa_uc: TBDEdit;
    codigo_uc: TBDEdit;
    producto_uc: TBDEdit;
    descripcion1_uc: TBDEdit;
    peso_envase_uc: TBDEdit;
    peso_producto_uc: TBDEdit;
    descripcion2_uc: TDBMemo;
    RejillaFlotante: TBGrid;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    ACampos: TAction;
    BGBEmpresa_uc: TBGridButton;
    BGBProducto_uc: TBGridButton;
    DSMaestro: TDataSource;
    QUndConsumo: TQuery;
    descripcion_p: TBDEdit;
    STEmpresa_uc: TStaticText;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure producto_ucChange(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure descripcion_pChange(Sender: TObject);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;


  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeModificar;
    procedure AntesDeInsertar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;
  end;

//var
  //FMUniConsumo: TFMUniConsumo;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, LUndConsumo,
  CAuxiliarDB, Principal, DPreview, DError, UDMAuxDB, bSQLUtils,
  CReportes;

{$R *.DFM}

{ TFMUniConsumo }

procedure TFMUniConsumo.AbrirTablas;
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

procedure TFMUniConsumo.AntesDeInsertar;
begin
     // Cerrar tabla
//     if DataSetMaestro.Active then DataSetMaestro.Close;
end;

procedure TFMUniConsumo.AntesDeModificar;
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
  end
end;

procedure TFMUniConsumo.AntesDeVisualizar;
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

procedure TFMUniConsumo.AnyadirRegistro;
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

procedure TFMUniConsumo.CerrarTablas;
begin
     // Cerrar tabla
  if DataSetMaestro.Active then DataSetMaestro.Close;
end;

procedure TFMUniConsumo.descripcion_pChange(Sender: TObject);
begin
  //buscar descripcion
  descripcion_p.text := desProducto(empresa_uc.Text, producto_uc.Text);
end;

procedure TFMUniConsumo.Filtro;
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
        if name <> 'descripcion_p' then
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
  end;
  if flag then where := ' WHERE ' + where;
end;

procedure TFMUniConsumo.Previsualizar;
begin
  //Crear el listado
  QRLUndConsumo := TQRLUndConsumo.Create(Application);
  PonLogoGrupoBonnysa( QRLUndConsumo );
  DMBaseDatos.QListado.SQL.Text := QUndConsumo.SQL.Text;
  DMBaseDatos.QListado.Open;
  try
    Preview(QRLUndConsumo);
  finally
    DMBaseDatos.QListado.Close;
  end;
end;

procedure TFMUniConsumo.ValidarEntradaMaestro;
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
            raise Exception.Create('Faltan datos de obligada inserción.');
        end;

      end;
    end;
  end;
end;

procedure TFMUniConsumo.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //***************************************************************
     //Fuente de datos maestro
     //CAMBIAR POR LA QUERY QUE LE TOQUE
 {+}DataSetMaestro := QUndConsumo;
     //***************************************************************

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_und_consumo ';
 {+}where := ' WHERE empresa_uc=' + QuotedStr('###');
 {+}Order := ' ORDER BY empresa_uc, codigo_uc ';
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

     //para el despliegue de las rejillas
  empresa_uc.Tag := kEmpresa;
  producto_uc.Tag := kProducto;
  descripcion_p.Tag := kProducto;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnEdit := AntesDeModificar;
  OnInsert := AntesDeInsertar;
  OnView := AntesDeVisualizar;

     //Focos
  FocoAltas := empresa_uc;
  FocoModificar := empresa_uc;
  FocoLocalizar := empresa_uc;

end;

procedure TFMUniConsumo.FormActivate(Sender: TObject);
begin
  if not DataSetMaestro.Active then Exit;
  Top := 20;
     //Variables globales
  M := Self;
  MD := nil;

     //*DEJAR LAS NECESARIAS
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := nil;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;

procedure TFMUniConsumo.FormClose(Sender: TObject;
  var Action: TCloseAction);
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

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMUniConsumo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//DEJAR SI EXISTE REJILLA
    //Si la rejilla esta desplegada no hacemos nada
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
           //No hacemos nada
      Exit;


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

procedure TFMUniConsumo.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa_uc);
    kProducto: DespliegaRejilla(BGBproducto_uc, [empresa_uc.Text]);
  end;
end;

procedure TFMUniConsumo.producto_ucChange(Sender: TObject);
begin
  //buscar descripcion
  descripcion_p.text := desProducto(empresa_uc.Text, producto_uc.Text);
end;

procedure TFMUniConsumo.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  STEmpresa_uc.Caption := desEmpresa(empresa_uc.Text);
  descripcion_p.text := desProducto(empresa_uc.Text, producto_uc.Text);
end;

end.


