unit MTipoEntregas;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, Db, ExtCtrls,
  StdCtrls, Mask, DBCtrls, CMaestro, Buttons, ActnList, BSpeedButton, Grids,
  DBGrids, BGridButton, BGrid, BDEdit, ComCtrls, BEdit, dbTables;

type
  TFMTipoEntregas = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    LEmpresa_p: TLabel;
    tipo_et: TBDEdit;
    Label13: TLabel;
    descripcion_et: TBDEdit;
    LAno_semana_p: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    empresa_et: TBDEdit;
    Bevel1: TBevel;
    BGridButton1: TBGridButton;
    BGrid1: TBGrid;
    QTipoEntregas: TQuery;
    empresa_des: TLabel;
    ajuste_et: TDBCheckBox;
    dbgTipoEntradas: TDBGrid;
    qGuia: TQuery;
    dsGuia: TDataSource;
    sqluGuia: TUpdateSQL;
    QTipoEntregasempresa_et: TStringField;
    QTipoEntregastipo_et: TIntegerField;
    QTipoEntregasdescripcion_et: TStringField;
    QTipoEntregasajuste_et: TIntegerField;
    QTipoEntregasdes_ajuste: TStringField;
    dbtxtAjuste: TDBText;
    lbl1: TLabel;
    dbtxtMerma: TDBText;
    merma_et: TDBCheckBox;
    QTipoEntregasmerma_et: TIntegerField;
    QTipoEntregasdes_merma: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure empresa_etChange(Sender: TObject);
    procedure QTipoEntregasNewRecord(DataSet: TDataSet);
    procedure qGuiaAfterOpen(DataSet: TDataSet);
    procedure qGuiaBeforeClose(DataSet: TDataSet);
    procedure QTipoEntregasCalcFields(DataSet: TDataSet);
    procedure ajuste_etClick(Sender: TObject);
    procedure merma_etClick(Sender: TObject);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

    procedure DesTipoMerma;
    procedure DesTipoAjuste;
  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;
    procedure AntesDeLocalizar;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, UDMAuxDB, CReportes,
  CAuxiliarDB, Principal, LTipoEntregas, DError, DPreview, bSQLUtils, Variants;

{$R *.DFM}

procedure TFMTipoEntregas.AbrirTablas;
begin
     // Abrir tablas/Querys
  if not DataSetMaestro.Active then
  begin
    DataSetGuia.SQL.Clear;
    DataSetGuia.SQL.Add(Select);
    DataSetGuia.SQL.Add(Where);
    DataSetGuia.SQL.Add(Order);
    DataSetGuia.Open;
  end;
  //Estado inicial
  Registros := DataSetGuia.RecordCount;
  if registros > 0 then
    Registro := 1
  else
    Registro := 0;
  RegistrosInsertados := 0;
end;

procedure TFMTipoEntregas.CerrarTablas;
begin
     // Cerrar tabla
  bnCloseQuerys([DataSetGuia]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMTipoEntregas.FormCreate(Sender: TObject);
begin
  //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
  PMaestro.Height:= 57;

     //Fuente de datos maestro
    DataSetGuia := qGuia;
 {+}DataSetMaestro := QTipoEntregas;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT empresa_et FROM frf_entradas_tipo ';
 {+}where := ' WHERE empresa_et=' + QUOTEDSTR('###');
 {+}Order := ' group BY empresa_et ORDER BY empresa_et ';
     //Abrir tablas/Querys
  try
    AbrirTablas;
        //Habilitamos controles de Base de datos
  except
    on e: Exception do
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
  Visualizar;
     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(pcNulo);

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := kNull;
     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
//     empresa_t.Tag:=kEmpresa;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
     //OnInsert:=AntesDeInsertar;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnBrowse:=AntesDeLocalizar;
  OnView := AntesDeVisualizar;
     //Focos
  {+}FocoAltas := empresa_et;
  {+}FocoModificar := descripcion_et;
  {+}FocoLocalizar := empresa_et;

end;

{+ CUIDADIN }

procedure TFMTipoEntregas.FormActivate(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_SHOWNORMAL);
  if not DataSetMaestro.Active then Exit;
     //Formulario activo
  M := self;
  MD := nil;
     //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
  gRF := nil;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;


procedure TFMTipoEntregas.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
end;

procedure TFMTipoEntregas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Liberamos recursos
  Lista.Free;

     //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
     //Codigo de desactivacion
  CerrarTablas;
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMTipoEntregas.FormKeyDown(Sender: TObject; var Key: Word;
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

{+}//Sustituir por funcion generica

procedure TFMTipoEntregas.Filtro;
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
          if flag then where := where + ' AND ';
          if InputType = itChar then
            where := where + ' ' + Name + ' LIKE ' + SQLFilter(Text)
          else
            where := where + ' ' + Name + ' =' + QUOTEDSTR(Text);
          flag := True;
        end;
      end;
    end;
  end;

  if ajuste_et.State <> cbGrayed then
  begin
    if ajuste_et.State = cbUnchecked then
    begin
      if flag then where := where + ' AND ';
      where := where + ' ajuste_et = 0 ';
      flag := True;
    end
    else
    begin
      if flag then where := where + ' AND ';
      where := where + ' ajuste_et = 1 ';
      flag := True;
    end;
  end;

  if merma_et.State <> cbGrayed then
  begin
    if merma_et.State = cbUnchecked then
    begin
      if flag then where := where + ' AND ';
      where := where + ' merma_et = 0 ';
      flag := True;
    end
    else
    begin
      if flag then where := where + ' AND ';
      where := where + ' merma_et = 1 ';
      flag := True;
    end;
  end;

  if flag then where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFMTipoEntregas.AnyadirRegistro;
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
          if flag then where := where + ' AND ';
          where := where + ' ' + Name + ' =' + QUOTEDSTR(Text);
          flag := True;
        end;
      end;
    end;
  end;
  where := where + ') ';
end;

{+}//Sustituir por funcion generica

procedure TFMTipoEntregas.ValidarEntradaMaestro;
var i: Integer;
begin
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

procedure TFMTipoEntregas.Previsualizar;
begin
  QRLTipoEntregas := TQRLTipoEntregas.Create(Application);
  try
    PonLogoGrupoBonnysa(QRLTipoEntregas);
    QRLTipoEntregas.QListado.SQL.Clear;
    QRLTipoEntregas.QListado.SQL.Add('SELECT * FROM frf_entradas_tipo');
    QRLTipoEntregas.QListado.SQL.Add(where);
    QRLTipoEntregas.QListado.SQL.Add('ORDER BY empresa_et, tipo_et ');
    QRLTipoEntregas.QListado.Open;
  except
    FreeAndNil( QRLTipoEntregas );
    raise;
  end;
  Preview(QRLTipoEntregas);
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//****************************************************************************

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMTipoEntregas.AntesDeInsertar;
var i: Integer;
begin
  PMaestro.Height:= 164;
end;

procedure TFMTipoEntregas.AntesDeModificar;
var i: Integer;
begin
  PMaestro.Height:= 164;
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

procedure TFMTipoEntregas.AntesDeVisualizar;
var i: Integer;
begin
  PMaestro.Height:= 57;
    //Resaturar estado
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := True;
  end;
  ajuste_et.AllowGrayed:= False;
  merma_et.AllowGrayed:= False;
end;

procedure TFMTipoEntregas.AntesDeLocalizar;
begin
  PMaestro.Height:= 164;
  ajuste_et.AllowGrayed:= True;
  ajuste_et.State:= cbGrayed;
  merma_et.AllowGrayed:= True;
  merma_et.State:= cbGrayed;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMTipoEntregas.RequiredTime(Sender: TObject;
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

procedure TFMTipoEntregas.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  if NewHeight < 35 then
  begin
    ShowWindow(Application.Handle, SW_SHOWMINNOACTIVE);
    Resize := False;
  end;
end;

procedure TFMTipoEntregas.ARejillaFlotanteExecute(Sender: TObject);
begin
  if empresa_et.Focused then
    DespliegaRejilla(BGridButton1);
end;

procedure TFMTipoEntregas.empresa_etChange(Sender: TObject);
begin
  empresa_des.Caption := desEmpresa(empresa_et.Text);
end;

procedure TFMTipoEntregas.QTipoEntregasNewRecord(DataSet: TDataSet);
begin
  QTipoEntregas.FieldByName('ajuste_et').AsInteger:= 1;
  QTipoEntregas.FieldByName('merma_et').AsInteger:= 1;
end;

procedure TFMTipoEntregas.qGuiaAfterOpen(DataSet: TDataSet);
begin
  //Abrir detalle
  QTipoEntregas.SQL.Clear;
  QTipoEntregas.SQL.Add('SELECT * FROM frf_entradas_tipo ');
  if Trim(Where) <> '' then
  begin
    QTipoEntregas.SQL.Add( Where );
    QTipoEntregas.SQL.Add( ' and empresa_et = :empresa_et ');
  end
  else
  begin
    QTipoEntregas.SQL.Add( ' where empresa_et = :empresa_et ');
  end;
  QTipoEntregas.SQL.Add( ' ORDER BY tipo_et ');
  QTipoEntregas.Open;
end;

procedure TFMTipoEntregas.qGuiaBeforeClose(DataSet: TDataSet);
begin
  //cancelar cambios pendientes en la guia
  qGuia.CancelUpdates;
  //Cerrar detalle
  QTipoEntregas.Close;
end;

procedure TFMTipoEntregas.QTipoEntregasCalcFields(DataSet: TDataSet);
begin
  DesTipoAjuste;
  DesTipoMerma;
end;

procedure TFMTipoEntregas.ajuste_etClick(Sender: TObject);
begin
  if ( QTipoEntregas.State = dsInsert ) or ( QTipoEntregas.State = dsEdit ) then
  begin
    if ajuste_et.State = cbGrayed  then
    begin
      //QTipoEntregasdes_ajuste.AsString:= 'Indiferente';
      QTipoEntregasajuste_et.Clear;
    end
    else
    if ajuste_et.State = cbUnchecked then
    begin
      //QTipoEntregasdes_ajuste.AsString:= 'Escandallo';
      QTipoEntregasajuste_et.AsInteger:= 0;
    end
    else
    begin
      //QTipoEntregasdes_ajuste.AsString:= 'Salidas';
      QTipoEntregasajuste_et.AsInteger:= 1;
    end;
  end
end;

procedure TFMTipoEntregas.merma_etClick(Sender: TObject);
begin
  if ( QTipoEntregas.State = dsInsert ) or ( QTipoEntregas.State = dsEdit ) then
  begin
    if merma_et.State = cbGrayed  then
    begin
      //QTipoEntregasdes_merma.AsString:= 'Indiferente';
      QTipoEntregasmerma_et.Clear;
    end
    else
    if merma_et.State = cbUnchecked then
    begin
      //QTipoEntregasdes_merma.AsString:= 'Sin Merma';
      QTipoEntregasmerma_et.AsInteger:= 0;
    end
    else
    begin
      //QTipoEntregasdes_merma.AsString:= 'Con Merma';
      QTipoEntregasmerma_et.AsInteger:= 1;
    end;
  end
  else
end;

procedure TFMTipoEntregas.DesTipoMerma;
begin
  if ( QTipoEntregasmerma_et.Value <> null ) and ( merma_et.State <> cbGrayed ) then
  begin
    if QTipoEntregasmerma_et.AsInteger = 0 then
    begin
      QTipoEntregasdes_merma.AsString:= 'Sin Merma';
    end
    else
    begin
      QTipoEntregasdes_merma.AsString:= 'Con Merma';
    end;
  end
  else
  begin
    QTipoEntregasdes_merma.AsString:= '';
  end;
end;

procedure TFMTipoEntregas.DesTipoAjuste;
begin
  if ( QTipoEntregasajuste_et.Value <> null ) and ( ajuste_et.State <> cbGrayed ) then
  begin
    if QTipoEntregasajuste_et.AsInteger = 0 then
    begin
      QTipoEntregasdes_ajuste.AsString:= 'Escandallo';
    end
    else
    begin
      QTipoEntregasdes_ajuste.AsString:= 'Salidas';
    end;
  end
  else
  begin
    QTipoEntregasdes_ajuste.AsString:= '';
  end;
end;

end.
