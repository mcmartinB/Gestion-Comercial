unit MTipoGastos;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbTables
  , DError;

type
  TFMTipogastos = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    LTipo_pago: TLabel;
    tipo_tg: TBDEdit;
    Label13: TLabel;
    descripcion_tg: TBDEdit;
    LDescripcion_tg: TLabel;
    Label1: TLabel;
    unidad_dist_tg: TDBComboBox;
    facturable_tg: TDBCheckBox;
    Label2: TLabel;
    QTiposGastos: TQuery;
    cta_venta_tg: TDBCheckBox;
    descontar_fob_tg: TDBCheckBox;
    lblCuentaVenta: TLabel;
    lblDescontarFob: TLabel;
    cbGasto_Transito_tg: TComboBox;
    gasto_transito_tg: TDBEdit;
    cbUnidad_dist_tg: TComboBox;
    lblAgrupacion: TLabel;
    agrupacion_contable_tg: TBDEdit;
    lblTipIva: TLabel;
    tipo_iva_tg: TDBComboBox;
    lblDesTipoIva: TLabel;
    lblNombre1: TLabel;
    agrupacion_tg: TBDEdit;
    btnAgrupacion: TBGridButton;
    RejillaFlotante: TBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure gasto_transito_tgChange(Sender: TObject);
    procedure cbGasto_Transito_tgChange(Sender: TObject);
    procedure tipo_iva_tgChange(Sender: TObject);
    procedure ARejillaFlotanteExecute(Sender: TObject);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

    function ObtenerCodigoTipoGastos: String;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;
    procedure ComboBusqueda;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, CReportes, UDMConfig,
  CAuxiliarDB, Principal, LTipoGastos, DPreview, bSQLUtils, UDMAuxDB;

{$R *.DFM}

procedure TFMTipogastos.AbrirTablas;
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
  if registros > 0 then
    Registro := 1
  else
    Registro := 0;
  RegistrosInsertados := 0;
end;

procedure TFMTipogastos.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMTipogastos.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := QTiposGastos;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_tipo_gastos ';
 {+}where := ' WHERE tipo_tg=' + QuotedStr('###');
 {+}Order := ' ORDER BY tipo_tg, descripcion_tg ';
     //Abrir tablas/Querys
  try
    AbrirTablas;
        //Habilitamos controles de Base de datos
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
  Visualizar;
     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(pcNulo);

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := kNull;
     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
//     empresa_t.Tag:=kEmpresa;
  agrupacion_tg.Tag:= kAgrupacionGasto;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnBrowse:= ComboBusqueda;
     //OnBrowse:=AntesDeInsertar;
  OnView := AntesDeVisualizar;
     //Focos
  {+}FocoAltas := descripcion_tg;
  {+}FocoModificar := descripcion_tg;
  {+}FocoLocalizar := tipo_tg;

  tipo_iva_tgChange(tipo_iva_tg);
end;

{+ CUIDADIN }

procedure TFMTipogastos.FormActivate(Sender: TObject);
begin
  if not DataSetMaestro.Active then Exit;
     //Formulario activo
  M := self;
  MD := nil;
     //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;


procedure TFMTipogastos.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
end;

procedure TFMTipogastos.FormClose(Sender: TObject; var Action: TCloseAction);
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
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMTipogastos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
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

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

{+}//Sustituir por funcion generica

procedure TFMTipogastos.Filtro;
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
    end;
  end;

  if cbUnidad_dist_tg.ItemIndex > 0 then
  begin
    if flag then where := where + ' and ';
    where := where + ' Unidad_dist_tg = ' + QuotedStr( cbUnidad_dist_tg.Items[cbUnidad_dist_tg.ItemIndex] );
    flag := True;
  end;

  if cbGasto_Transito_tg.ItemIndex < 3 then
  begin
    if flag then where := where + ' and ';
    where := where + ' gasto_Transito_tg = ' + IntToStr( cbGasto_Transito_tg.ItemIndex ) ;
    flag := True;
  end;

  if cta_venta_tg.State <> cbGrayed then
  begin
    if flag then where := where + ' and ';
    if cta_venta_tg.Checked then
      where := where + ' cta_venta_tg = ''S'' '
    else
      where := where + ' cta_venta_tg = ''N'' ';
    flag := True;
  end;

  if descontar_fob_tg.State <> cbGrayed then
  begin
    if flag then where := where + ' and ';
    if descontar_fob_tg.Checked then
      where := where + ' descontar_fob_tg = ''S'' '
    else
      where := where + ' descontar_fob_tg = ''N'' ';
    flag := True;
  end;

  if facturable_tg.State <> cbGrayed then
  begin
    if flag then where := where + ' and ';
    if facturable_tg.Checked then
      where := where + ' facturable_tg = ''S'' '
    else
      where := where + ' facturable_tg = ''N'' ';
    flag := True;
  end;

  if tipo_iva_tg.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    where := where + ' tipo_iva_tg = ' + tipo_iva_tg.Text;
  end;



  if flag then where := ' WHERE ' + where;

//    where:='';Flag:=false;
//    if self.tipo_tg.Text <> '' then
//    Begin
//         Flag := True;
//         where := 'WHERE tipo_tg Like ' + SQLFilter(tipo_tg.Text);
//    End;
end;

{+}//sustituir por funcion generica

procedure TFMTipogastos.AnyadirRegistro;
var Flag: Boolean;
  i: Integer;
begin
  Flag := false;
    //facturable_tg.ItemIndex := 0;
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

{+}//Sustituir por funcion generica

procedure TFMTipogastos.ValidarEntradaMaestro;
var i: Integer;
begin

  if trim(tipo_tg.Text) = '' then
  begin
    tipo_tg.SetFocus;
    raise Exception.Create('Debe introducir el código del tipo de Gasto...');
  end;
  if trim(descripcion_tg.Text) = '' then
  begin
    descripcion_tg.SetFocus;
    raise Exception.Create('Debe introducir la descripción de Tipo de Gasto...');
  end;
  if trim(unidad_dist_tg.Text) = '' then
  begin
    unidad_dist_tg.SetFocus;
    raise Exception.Create('Debe introducir la unidad de Distribución...');
  end;
  if trim(unidad_dist_tg.Text) = '' then
  begin
    unidad_dist_tg.SetFocus;
    raise Exception.Create('Debe introducir la unidad de Distribución...');
  end;

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

  if agrupacion_tg.Text = '' then
  begin
     if agrupacion_tg.CanFocus then
       agrupacion_tg.SetFocus;
     raise Exception.Create('Es necesario introducir una agrupación.');
  end;
end;

procedure TFMTipogastos.Previsualizar;
var
  enclave: TBookMark;
begin
  enclave := DataSetMaestro.GetBookmark;
  QRLTiposGastos := TQRLTiposGastos.Create(Application);
  PonLogoGrupoBonnysa(QRLTiposGastos);
  QRLTiposGastos.DataSet := QTiposGastos;
  Preview(QRLTiposGastos);
  DataSetMaestro.GotoBookmark(enclave);
  DataSetMaestro.FreeBookmark(enclave);
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

procedure TFMTipogastos.AntesDeModificar;
var i: Integer;
begin
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;
  tipo_iva_tgChange(tipo_iva_tg);
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMTipogastos.AntesDeVisualizar;
var i: Integer;
begin
  cbGasto_Transito_tg.Items.Clear;
  cbGasto_Transito_tg.Items.Add('Gasto Salida');
  cbGasto_Transito_tg.Items.Add('Gasto Tránsito');
  cbGasto_Transito_tg.Items.Add('Gasto Compra');
  gasto_transito_tgChange(gasto_transito_tg);

  cbUnidad_dist_tg.Visible:= False;
  Unidad_dist_tg.Visible:= True;

  //Resaturar estado
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := True;
  end;
  tipo_iva_tgChange(tipo_iva_tg);
end;

procedure TFMTipogastos.ComboBusqueda;
begin
  cbGasto_Transito_tg.Items.Clear;
  cbGasto_Transito_tg.Items.Add('Gasto Salida');
  cbGasto_Transito_tg.Items.Add('Gasto Tránsito');
  cbGasto_Transito_tg.Items.Add('Gasto Compra');
  cbGasto_Transito_tg.Items.Add('Todos los gastos');
  cbGasto_Transito_tg.ItemIndex:= 3;

  cbUnidad_dist_tg.ItemIndex:= 0;
  cbUnidad_dist_tg.Visible:= True;
  Unidad_dist_tg.Visible:= False;

  tipo_iva_tgChange(tipo_iva_tg);
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMTipogastos.RequiredTime(Sender: TObject;
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

procedure TFMTipogastos.AntesDeInsertar;
begin

  tipo_tg.Enabled := False;
  tipo_tg.Text := ObtenerCodigoTipoGastos;

  cta_venta_tg.Checked := False;
  facturable_tg.Checked := False;
  descontar_fob_tg.Checked := False;
  unidad_dist_tg.ItemIndex:= 1;

  QTiposGastos.FieldByName('cta_venta_tg').AsString := 'N';
  QTiposGastos.FieldByName('facturable_tg').AsString := 'N';
  QTiposGastos.FieldByName('descontar_fob_tg').AsString := 'N';
  QTiposGastos.FieldByName('unidad_dist_tg').AsString :=
    unidad_dist_tg.Items[ unidad_dist_tg.ItemIndex ];;

  QTiposGastos.FieldByName('gasto_transito_tg').AsInteger := 0;
  gasto_transito_tg.Text:= '0';
  cbGasto_Transito_tg.ItemIndex:= 0;

  tipo_iva_tg.Text:= '2';
  tipo_iva_tgChange(tipo_iva_tg);
end;

procedure TFMTipogastos.gasto_transito_tgChange(Sender: TObject);
begin
  facturable_tg.Enabled:= gasto_transito_tg.Text <> '2';
  tipo_iva_tg.Enabled:= facturable_tg.Enabled;
  cta_venta_tg.Enabled:= facturable_tg.Enabled;
  descontar_fob_tg.Enabled:= facturable_tg.Enabled;
  if DSMaestro.State = dsBrowse then
  begin
    if gasto_transito_tg.Text = '' then
    begin
      cbGasto_Transito_tg.ItemIndex:= -1;
    end
    else
    begin
      cbGasto_Transito_tg.ItemIndex:= StrToInt( gasto_transito_tg.Text );
    end;
  end
  else
  begin
    if ( DSMaestro.State = dsInsert ) or ( DSMaestro.State = dsEdit ) then
    begin
      if Estado <> teLocalizar then
      begin
        facturable_tg.Checked:= false;
        cta_venta_tg.Checked:= false;
        descontar_fob_tg.Checked:= false;
      end;
    end;
  end;
end;

function TFMTipogastos.ObtenerCodigoTipoGastos: String;
var iTipoGasto: Integer;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select max(tipo_tg) tipoGasto from frf_tipo_gastos ');

    Open;
    if IsEmpty then
      iTipoGasto := 1
    else
    begin
      iTipoGasto := fieldbyname('tipoGasto').AsInteger + 1;
    end;

//    Result := IntToStr(iTipoGasto);
    Result := FormatFloat('000',iTipoGasto);

    Close;
  end;
end;

procedure TFMTipogastos.cbGasto_Transito_tgChange(Sender: TObject);
begin
  if ( DSMaestro.State = dsInsert ) or ( DSMaestro.State = dsEdit ) then
  begin
    gasto_transito_tg.Text:= IntToStr( cbGasto_Transito_tg.ItemIndex );
  end;
end;

procedure TFMTipogastos.tipo_iva_tgChange(Sender: TObject);
begin
  if tipo_iva_tg.Text = '' then
  begin
    lblDesTipoIva.Caption:= '';
  end
  else
  if tipo_iva_tg.Text = '0' then
  begin
    lblDesTipoIva.Caption:= 'Superreducido';
  end
  else
  if tipo_iva_tg.Text = '1' then
  begin
    lblDesTipoIva.Caption:= 'Reducido';
  end
  else
  if tipo_iva_tg.Text = '2' then
  begin
    lblDesTipoIva.Caption:= 'General';
  end;
end;

procedure TFMTipogastos.ARejillaFlotanteExecute(Sender: TObject);
begin
  DespliegaRejilla( btnAgrupacion );
end;

end.


