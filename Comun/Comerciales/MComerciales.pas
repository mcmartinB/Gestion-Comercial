unit MComerciales;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BEdit, BDEdit,
  dbtables, DError, ComCtrls;

type
  TFMComerciales = class(TMaestroDetalle)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    lblComercial: TLabel;
    AComerciales: TActionList;
    ARejillaFlotante: TAction;
    codigo_c: TBDEdit;
    descripcion_c: TBDEdit;
    qryComerciales: TQuery;
    qryClientes: TQuery;
    DSClientes: TDataSource;
    PageControl: TPageControl;
    tsClientes: TTabSheet;
    RClientes: TDBGrid;
    pnlClientes: TPanel;
    lblEmpresa: TLabel;
    cod_empresa_cc: TBDEdit;
    lblCliente: TLabel;
    cod_cliente_cc: TBDEdit;
    txtEmpresa: TStaticText;
    txtCliente: TStaticText;
    btnEmpresa: TBGridButton;
    btnCliente: TBGridButton;
    RejillaFlotante: TBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure qryComercialesAfterOpen(DataSet: TDataSet);
    procedure qryComercialesBeforeClose(DataSet: TDataSet);
    procedure qryClientesNewRecord(DataSet: TDataSet);
    procedure PageControlChange(Sender: TObject);
    procedure cod_empresa_ccChange(Sender: TObject);
    procedure cod_cliente_ccChange(Sender: TObject);
  private
    { Private declarations }
    ListaComponentes, ListaDetalle: TList;
    Objeto: TObject;

    FRegistroABorrarComercialId: String;

    procedure ValidarEntradaMaestro;
    procedure ValidarEntradaDetalle;
    procedure AntesDeBorrarMaestro;
    procedure AntesDeBorrarDetalle;
    procedure AbrirTablas;
    procedure CerrarTablas;

  protected
    //procedure AlBorrar;
    procedure DespuesDeBorrar;

    procedure SincronizarWeb; override;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    procedure VerDetalle;
    procedure EditarDetalle;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, DPreview, UDMAuxDB, bSQLUtils,
  CMaestro, UDMConfig, SincronizacionBonny;

{$R *.DFM}

procedure TFMComerciales.AbrirTablas;
begin
     // Abrir tablas/Querys
  if not DataSetMaestro.Active then
  begin
    DataSetMaestro.SQL.Clear;
    DataSetMaestro.SQL.Add(Select);
    DatasetMaestro.SQL.Add(Where);
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

procedure TFMComerciales.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

procedure TFMComerciales.FormCreate(Sender: TObject);
begin
  Top := 1;

  LineasObligadas:= False;
  ListadoObligado:= False;
  MultipleAltas:= false;

  //Variables globales
  M:=Self;
  MD:=Self;
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF :=nil;

  PageControl.ActivePage:= tsClientes;
  DataSourceDetalle:=DSClientes;
  RejillaVisualizacion := RClientes;
  PanelDetalle := pnlClientes;

  //Panel
  PanelMaestro := PMaestro;

  //Fuente de datos
  DataSetMaestro:=qryComerciales;

  Select := ' SELECT * FROM frf_comerciales ';
  where := ' WHERE codigo_c =' + QuotedStr('###');
  Order := ' ORDER BY descripcion_c ';
     //Para reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := kNull;
     //Abrir tablas/Querys

  with qryClientes.SQL do
  begin
    Clear;
    Add('select * from frf_clientes_comercial ');
    Add('where cod_comercial_cc = :codigo_c ');
    Add('order by cod_cliente_cc, cod_empresa_cc ');
  end;

  (* Otras paginas de datos
  with QProductos.SQL do
  begin
    Clear;
    Add('select * from frf_productos_proveedor ');
    Add('where empresa_pp = :empresa_p ');
    Add('  and proveedor_pp = :proveedor_p ');
    Add('order by empresa_pp, proveedor_pp, producto_pp, variedad_pp ');
  end;
  *)

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
  ListaComponentes := TList.Create;
  PMaestro.GetTabOrderList(ListaComponentes);
  ListaDetalle := TList.Create;
  ListaDetalle.Clear;
  PanelDetalle.GetTabOrderList(ListaDetalle);

  //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> CVariables.tfMaestro then
  begin
    FormType := tfMaestroDetalle;
    BHFormulario;
  end;
  Visualizar;
     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(pcNulo);

     //Validar entrada
  OnBeforeMasterDelete := AntesDeBorrarMaestro;
  OnBeforeDetailDelete := AntesDeBorrarDetalle;
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnValidateDetailConstrains := ValidarEntradaDetalle;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;

    // Sinconizacion Web - borrado
  //OnBeforeMasterDelete := AlBorrar;
  OnAfterMasterDeleted := DespuesDeBorrar;

  //Preparar panel de detalle
  OnViewDetail:=VerDetalle;
  OnEditDetail:=EditarDetalle;

     //Focos
  {+}FocoAltas := codigo_c;
  {+}FocoModificar := descripcion_c;
  {+}FocoLocalizar := codigo_c;

  cod_empresa_cc.Tag:= kEmpresa;
  cod_cliente_cc.Tag:= kCliente;
end;

procedure TFMComerciales.FormActivate(Sender: TObject);
begin
  if not DataSetMaestro.Active then Exit;
     //Variables globales
  M := Self;
  MD := Self;
  gRF := RejillaFlotante;
  gCF :=nil;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

  //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestroDetalle then
  begin
    FormType := tfMaestroDetalle;
    BHFormulario;
  end;
  BHGrupoDesplazamientoMaestro(PCMaestro);
  BHGrupoDesplazamientoDetalle(PCDetalle);
end;

procedure TFMComerciales.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF :=nil;
end;


procedure TFMComerciales.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListaComponentes.Free;
  ListaDetalle.Free;
     {MODIFICAR}
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
     // Cerrar tabla
  CerrarTablas;

     //Restauramos barra de herramientas
  if Fprincipal.MDIChildCount = 1 then
  begin
    if FormType <> tfDirector then
    begin
      FormType := tfDirector;
      BHFormulario;
    end;
  end;
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMComerciales.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
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

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

{+}//Sustituir por funcion generica

procedure TFMComerciales.Filtro;
var Flag: Boolean;
  i: Integer;
begin
  where := ''; Flag := false;
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
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
  if flag then where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFMComerciales.AnyadirRegistro;
var Flag: Boolean;
  i: Integer;
begin
  Flag := false;
  if where <> '' then where := where + ' OR ('
  else where := ' WHERE (';

  for i := 0 to ListaComponentes.Count - 1 do
  begin
    objeto := ListaComponentes.Items[i];
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

procedure TFMComerciales.ValidarEntradaMaestro;
var i: Integer;
begin
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
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
  if length( Trim(codigo_c.Text) ) <> 3 then
  begin
    raise Exception.Create('El código del comercial debe ser de tres dígitos.');
  end;
end;

procedure TFMComerciales.ValidarEntradaDetalle;
var
  sComercial: string;
begin
  //if ( qryClientes.State = dsInsert ) or ( qryClientes.State = dsEdit ) then
  begin
    if txtEmpresa.Caption = '' then
    begin
      raise Exception.Create('Falta el código de la empresa o es incorrecto.');
    end;
    if txtCliente.Caption = '' then
    begin
      raise Exception.Create('Falta el código del cliente o es incorrecto.');
    end;
    //Esta asignado ya

    DMBaseDatos.QAux.SQL.Clear;
    DMBaseDatos.QAux.SQL.Add('select cod_comercial_cc || '' - '' || descripcion_c comercial ');
    DMBaseDatos.QAux.SQL.Add('from frf_clientes_comercial ');
    DMBaseDatos.QAux.SQL.Add('     join frf_comerciales on codigo_c = cod_comercial_cc ');
    DMBaseDatos.QAux.SQL.Add('where cod_empresa_cc = :empresa ');
    DMBaseDatos.QAux.SQL.Add('and cod_cliente_cc = :cliente ');
    DMBaseDatos.QAux.ParamByName('empresa').AsString:= cod_empresa_cc.Text;
    DMBaseDatos.QAux.ParamByName('cliente').AsString:= cod_cliente_cc.Text;
    DMBaseDatos.QAux.Open;
    if not DMBaseDatos.QAux.IsEmpty then
    begin
      sComercial:= DMBaseDatos.QAux.FieldByName('comercial').AsString;
      DMBaseDatos.QAux.Close;
      raise Exception.Create('El cliente seleccionado ya esta asignado al comercial -> ' + sComercial  );
    end
    else
    begin
      DMBaseDatos.QAux.Close;
    end;
  end;
end;

procedure TFMComerciales.Previsualizar;
begin
  (*TODO*)
  (*
  if LDProveedores.VisualizarDetalle( self, bAlmacenes, bProductos ) then
  begin
    QRLProveedoresEx := TQRLProveedoresEx.Create(Application);
    try
      QRLProveedoresEx.MontarListado( Where, bAlmacenes, bProductos );
      PonLogoGrupoBonnysa(QRLProveedoresEx);
      Preview(QRLProveedoresEx);
    except
      FreeAndNil(QRLProveedoresEx);
    end;
  end;
  *)
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//*****************************************************************************

procedure TFMComerciales.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCliente: DespliegaRejilla(btnCliente, [cod_empresa_cc.Text]);
  end;
end;

procedure TFMComerciales.AntesDeInsertar;
begin
  //Nada
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMComerciales.AntesDeModificar;
var i: Integer;
begin
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;
end;


//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMComerciales.AntesDeVisualizar;
var i: Integer;
begin
    //Restauramos estado
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          if Enabled = false then Enabled := true;
  end;
end;

procedure TFMComerciales.AntesDeBorrarMaestro;
begin
  if ( not qryClientes.IsEmpty )  then
  begin
    raise Exception.Create('No se puede borrar el comercial, primero borre el detalle.');
  end
  else
    FRegistroABorrarComercialId := DSMaestro.DataSet.FieldByName('codigo_c').AsString;

end;

procedure TFMComerciales.AntesDeBorrarDetalle;
begin
  if PageControl.ActivePage = tsClientes then
  begin
    //Validaciones referenciales
  end;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMComerciales.RequiredTime(Sender: TObject; var isTime: Boolean);
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

procedure TFMComerciales.SincronizarWeb;
begin
  SincroBonnyAurora.SincronizarComercial(DSMaestro.Dataset.FieldByName('codigo_c').asString);
  SincroBonnyAurora.Sincronizar;
end;

procedure TFMComerciales.qryComercialesAfterOpen(DataSet: TDataSet);
begin
  qryClientes.Open;
end;

procedure TFMComerciales.qryComercialesBeforeClose(DataSet: TDataSet);
begin
  qryClientes.Close;
end;

procedure TFMComerciales.VerDetalle;
begin
  PanelDetalle.Enabled:= false;
  PanelDetalle.Visible:= false;
  PanelMaestro.Height:= 90;
  tsClientes.TabVisible:= True;
  //tsProductos.TabVisible:= True;
end;

procedure TFMComerciales.EditarDetalle;
begin
  PanelDetalle.Enabled:= True;
  PanelDetalle.Visible:= True;
  PanelMaestro.Height:= 90;
  if PageControl.ActivePage = tsClientes then
  begin
    FocoDetalle:=cod_empresa_cc;
    if EstadoDetalle <> tedModificar then
    begin
      qryClientes.Close;
      qryClientes.Open;
    end;
    //tsProductos.TabVisible:= False;
  end
  else
  begin
    //
  end;
end;

procedure TFMComerciales.qryClientesNewRecord(DataSet: TDataSet);
begin
  qryClientes.FieldByName('cod_comercial_cc').AsString := qryComerciales.FieldByName('codigo_c').AsString;
end;


procedure TFMComerciales.PageControlChange(Sender: TObject);
begin
  if PageControl.ActivePage = tsClientes then
  begin
    DataSourceDetalle:=DSClientes;
    RejillaVisualizacion := RClientes;
    PanelDetalle := pnlClientes;
  end
  else
  begin
    //
  end;
  ListaDetalle.Clear;
  PanelDetalle.GetTabOrderList(ListaDetalle);
end;

procedure TFMComerciales.cod_empresa_ccChange(Sender: TObject);
begin
  txtEmpresa.Caption:= desEmpresa( cod_empresa_cc.Text );
  cod_cliente_ccChange( cod_cliente_cc );
end;

procedure TFMComerciales.DespuesDeBorrar;
begin
  SincroBonnyAurora.SincronizarComercial(FRegistroABorrarComercialId);
  SincroBonnyAurora.Sincronizar;
  FRegistroABorrarComercialId := '';
end;

procedure TFMComerciales.cod_cliente_ccChange(Sender: TObject);
begin
  txtCliente.Caption:= desCliente( cod_cliente_cc.Text );
end;


end.
