unit MCostesEnvasado;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms, Dialogs, Db, ExtCtrls, BDEdit,
  StdCtrls, CMaestro, ComCtrls, BEdit, DError, Controls, DBTables, nbEdits,
  nbCombos, nbLabels, Grids, DBGrids, DBCtrls;

type
  TFMCostesEnvasado = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    LPlantacion_p: TLabel;
    empresa_epc: TBDEdit;
    LEmpresa_p: TLabel;
    centro_epc: TBDEdit;
    Label13: TLabel;
    QCostesEnvasado: TQuery;
    producto_epc: TBDEdit;
    productor_epc: TBDEdit;
    anyo_mes_epc: TBDEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    env_tcoste_epc: TnbDBSQLCombo;
    lblNombre1: TLabel;
    tipo_entrada_epc: TnbDBSQLCombo;
    QCostesEnvasadoempresa_epc: TStringField;
    QCostesEnvasadocentro_epc: TStringField;
    QCostesEnvasadoanyo_mes_epc: TStringField;
    QCostesEnvasadoenv_tcoste_epc: TStringField;
    QCostesEnvasadoproductor_epc: TSmallintField;
    QCostesEnvasadoproducto_epc: TStringField;
    QCostesEnvasadotipo_entrada_epc: TIntegerField;
    QCostesEnvasadodes_empresa: TStringField;
    QCostesEnvasadodes_centro: TStringField;
    QCostesEnvasadodes_producto: TStringField;
    QCostesEnvasadodes_productor: TStringField;
    QCostesEnvasadodes_tipo_entrada: TStringField;
    QCostesEnvasadodes_tipo_coste: TStringField;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBGrid1: TDBGrid;
    qGuia: TQuery;
    dsGuia: TDataSource;
    sqluGuia: TUpdateSQL;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject;
      var isTime: Boolean);
    function tipo_entrada_epcGetSQL: String;
    procedure QCostesEnvasadoCalcFields(DataSet: TDataSet);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure qGuiaAfterOpen(DataSet: TDataSet);
    procedure qGuiaBeforeClose(DataSet: TDataSet);
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

    procedure AntesDeLocalizar;
    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses CVariables, UDMBaseDatos, Principal, LCostesEnvasado, CReportes,
  CGestionPrincipal, DPreview, bSQLUtils, udmauxdb;

{$R *.DFM}

procedure TFMCostesEnvasado.AbrirTablas;
begin
  if not DataSetGuia.Active then
  begin
    DataSetGuia.SQL.Clear;
    DataSetGuia.SQL.Add(Select);
    DataSetGuia.SQL.Add(Where);
    DataSetGuia.SQL.Add(Order);
    DataSetGuia.Open;
  end;
     //Estado inicial
  Registro := 1;
  Registros := DataSetGuia.RecordCount;
  RegistrosInsertados := 0;
end;

procedure TFMCostesEnvasado.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetGuia]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMCostesEnvasado.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
  PMaestro.Height:= 101;

     //Fuente de datos maestro
    DataSetGuia := qGuia;
 {+}DataSetMaestro := QCostesEnvasado;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT empresa_epc, anyo_mes_epc, centro_epc, productor_epc, producto_epc FROM frf_env_pcostes ';
 {+}where := ' WHERE empresa_epc= ' + QuotedStr('##');
 {+}Order := ' GROUP BY empresa_epc, anyo_mes_epc, centro_epc, productor_epc, producto_epc ' +
             ' ORDER BY empresa_epc, anyo_mes_epc desc, centro_epc, productor_epc, producto_epc ';
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
     //Estado inicial
  Visualizar;
     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(pcNulo);


     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnInsert := AntesDeInsertar;
  OnBrowse := AntesDeLocalizar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;
     //Focos
  FocoAltas := empresa_epc;
  FocoModificar := empresa_epc;
  FocoLocalizar := empresa_epc;

end;

procedure TFMCostesEnvasado.FormActivate(Sender: TObject);
begin
  if not DataSetMaestro.Active then Exit;
     //Variables globales
  M := Self;
  MD := nil;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;


procedure TFMCostesEnvasado.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMCostesEnvasado.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMCostesEnvasado.Filtro;
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
    end
    else
    begin
      if (objeto is TnbDBSQLCombo) then
      begin
        with Objeto as TnbDBSQLCombo do
        begin
          if Trim(Text) <> '' then
          begin
            if flag then where := where + ' and ';
            where := where + ' ' + name + ' = ' + QuotedStr(Text);
            flag := True;
          end;
        end;
      end;
    end;
  end;

  (*
  if tipo_entrada_e.Text <> '' then
  begin
    if flag then where := where + ' and ';
    where := where + ' tipo_entrada_e = ' + tipo_entrada_e.Text;
    flag:= True;
  end;
  *)

  if flag then where := ' WHERE ' + where;
end;

//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que son insertados
//para, else fin usa los campos que marcamos como PrimaryKey

procedure TFMCostesEnvasado.AnyadirRegistro;
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

procedure TFMCostesEnvasado.ValidarEntradaMaestro;
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

  //**************************************************************
  //REstricciones Particulares
  //**************************************************************
  if tipo_entrada_epc.Text = '' then
    raise Exception.Create('Faltan datos de obligada inserción.');
end;

//**************************************************************
//IMPRESION: Introducir QuickReport
//**************************************************************

procedure TFMCostesEnvasado.Previsualizar;
begin
     //Crear el listado
  QRLCostesEnvasado := TQRLCostesEnvasado.Create(Application);
  PonLogoGrupoBonnysa(QRLCostesEnvasado, empresa_epc.text);
  QRLCostesEnvasado.QCostesEnvasado.SQL.Clear;
  QRLCostesEnvasado.QCostesEnvasado.SQL.Add('SELECT empresa_epc, centro_epc,  producto_epc, descripcion_p, ');
  QRLCostesEnvasado.QCostesEnvasado.SQL.Add('       productor_epc, nombre_c, anyo_mes_epc, env_tcoste_epc, descripcion_etc, ');
  QRLCostesEnvasado.QCostesEnvasado.SQL.Add('       tipo_entrada_epc,  descripcion_et');
  QRLCostesEnvasado.QCostesEnvasado.SQL.Add('FROM frf_env_pcostes, frf_productos, frf_cosecheros, frf_env_tcostes, frf_entradas_tipo ');
  if Where <> '' then
  begin
    QRLCostesEnvasado.QCostesEnvasado.SQL.Add(WHERE);
    QRLCostesEnvasado.QCostesEnvasado.SQL.Add('and empresa_epc = empresa_p ');
  end
  else
  begin
    QRLCostesEnvasado.QCostesEnvasado.SQL.Add('WHERE empresa_epc = empresa_p ');
  end;
  QRLCostesEnvasado.QCostesEnvasado.SQL.Add('and producto_epc = producto_p ');
  QRLCostesEnvasado.QCostesEnvasado.SQL.Add('and empresa_epc = empresa_c ');
  QRLCostesEnvasado.QCostesEnvasado.SQL.Add('and productor_epc = cosechero_c ');
  QRLCostesEnvasado.QCostesEnvasado.SQL.Add('and env_tcoste_epc = env_tcoste_etc ');

  QRLCostesEnvasado.QCostesEnvasado.SQL.Add('and empresa_et = empresa_epc ');
  QRLCostesEnvasado.QCostesEnvasado.SQL.Add('and tipo_et = tipo_entrada_epc ');

  QRLCostesEnvasado.QCostesEnvasado.SQL.Add('ORDER BY empresa_epc, anyo_mes_epc desc, centro_epc, productor_epc, producto_epc, producto_epc, tipo_entrada_epc, env_tcoste_epc ');
  QRLCostesEnvasado.QCostesEnvasado.Open;
  Preview(QRLCostesEnvasado);
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMCostesEnvasado.AntesDeLocalizar;
begin
  PMaestro.Height:= 145;
end;

procedure TFMCostesEnvasado.AntesDeInsertar;
begin
  PMaestro.Height:= 145;
end;

procedure TFMCostesEnvasado.AntesDeModificar;
var i: Integer;
begin
  PMaestro.Height:= 145;
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

procedure TFMCostesEnvasado.AntesDeVisualizar;
var i: Integer;
begin
    PMaestro.Height:= 101;
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

procedure TFMCostesEnvasado.RequiredTime(Sender: TObject;
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

function TFMCostesEnvasado.tipo_entrada_epcGetSQL: String;
begin
  result:= '';
  if empresa_epc.Text <> '' then
  begin
    result:= result + 'select tipo_et tipo, descripcion_et descripcion ';
    result:= result + 'from frf_entradas_tipo ';
    result:= result + 'where empresa_et = ' + QuotedStr( empresa_epc.Text );
    result:= result + 'group by tipo_et, descripcion_et ';
    result:= result + 'order by tipo_et ';
  end
  else
  begin
    result:= result + 'select tipo_et tipo, descripcion_et descripcion ';
    result:= result + 'from frf_entradas_tipo ';
    result:= result + 'group by tipo_et, descripcion_et ';
    result:= result + 'order by tipo_et ';
  end;
end;

procedure TFMCostesEnvasado.QCostesEnvasadoCalcFields(DataSet: TDataSet);
begin
  QCostesEnvasadodes_empresa.AsString := desEmpresa(QCostesEnvasadoempresa_epc.AsString);
  QCostesEnvasadodes_centro.AsString := desCentro(QCostesEnvasadoempresa_epc.AsString, QCostesEnvasadocentro_epc.AsString);
  QCostesEnvasadodes_productor.AsString := desCosechero(QCostesEnvasadoempresa_epc.AsString, QCostesEnvasadoproductor_epc.AsString);
  QCostesEnvasadodes_producto.AsString := desProducto(QCostesEnvasadoempresa_epc.AsString, QCostesEnvasadoproducto_epc.AsString);
  QCostesEnvasadodes_tipo_coste.AsString := desTipoCoste(QCostesEnvasadoenv_tcoste_epc.AsString);
  QCostesEnvasadodes_tipo_entrada.AsString := desTipoEntrada(QCostesEnvasadoempresa_epc.AsString, QCostesEnvasadotipo_entrada_epc.AsString);
end;

procedure TFMCostesEnvasado.DBGrid1DblClick(Sender: TObject);
begin
  Modificar;
end;

procedure TFMCostesEnvasado.qGuiaAfterOpen(DataSet: TDataSet);
begin
  //Abrir detalle
  QCostesEnvasado.SQL.Clear;
  QCostesEnvasado.SQL.Add('select * from frf_env_pcostes ');
  if Trim(Where) <> '' then
  begin
    QCostesEnvasado.SQL.Add( Where );
    QCostesEnvasado.SQL.Add( ' and empresa_epc = :empresa_epc ');
  end
  else
  begin
    QCostesEnvasado.SQL.Add( ' where empresa_epc = :empresa_epc ');
  end;
  QCostesEnvasado.SQL.Add( ' and centro_epc = :centro_epc ');
  QCostesEnvasado.SQL.Add( ' and anyo_mes_epc = :anyo_mes_epc ');
  QCostesEnvasado.SQL.Add( ' and productor_epc = :productor_epc ');
  QCostesEnvasado.SQL.Add( ' and producto_epc = :producto_epc ');
  QCostesEnvasado.SQL.Add( ' ORDER BY producto_epc, tipo_entrada_epc, env_tcoste_epc ');
  QCostesEnvasado.Open;
end;

procedure TFMCostesEnvasado.qGuiaBeforeClose(DataSet: TDataSet);
begin
  //cancelar cambios pendientes en la guia
  qGuia.CancelUpdates;
  //Cerrar detalle
  QCostesEnvasado.Close;
end;

end.
