unit MComerciales;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BEdit, BDEdit,
  dbtables, DError, ComCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxDBEdit,
  SQLExprEdit, SQLExprStrEdit, Menus, cxButtons, Variants, dxSkinsCore,
  dxSkinFoggy, dxSkinBlue, dxSkinBlueprint, dxSkinMoneyTwins;

type
  TFMComerciales = class(TMaestroDetalle)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    lblComercial: TLabel;
    codigo_c: TBDEdit;
    descripcion_c: TBDEdit;
    qryComerciales: TQuery;
    qryClientes: TQuery;
    DSClientes: TDataSource;
    PageControl: TPageControl;
    tsClientes: TTabSheet;
    pnlClientes: TPanel;
    lblCliente: TLabel;
    cod_cliente_cc: TBDEdit;
    txtCliente: TStaticText;
    btnCliente: TBGridButton;
    RejillaFlotante: TBGrid;
    Label1: TLabel;
    cod_producto_cc: TBDEdit;
    btnProducto: TBGridButton;
    txtProducto: TStaticText;
    RClientes: TDBGrid;
    qryClientesAux: TQuery;
    tvDetalle: TcxGridDBTableView;
    lvDetalle: TcxGridLevel;
    cxGrid1: TcxGrid;
    tvCliente: TcxGridDBColumn;
    tvProducto: TcxGridDBColumn;
    AComerciales: TActionList;
    ARejillaFlotante: TAction;
    ADModificar: TAction;
    tvDesCliente: TcxGridDBColumn;
    tvDesProducto: TcxGridDBColumn;
    qryClientescod_comercial_cc: TStringField;
    qryClientescod_cliente_cc: TStringField;
    qryClientescod_producto_cc: TStringField;
    qryClientesdes_cliente: TStringField;
    qryClientesdes_producto: TStringField;
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
    //procedure cod_empresa_ccChange(Sender: TObject);
    procedure cod_cliente_ccChange(Sender: TObject);
    procedure cod_producto_ccChange(Sender: TObject);
    procedure cxFiltrarClick(Sender: TObject);
    procedure cxBorrarFiltroClick(Sender: TObject);
    procedure cxGrid1Enter(Sender: TObject);
    procedure cxGrid1Exit(Sender: TObject);
    procedure qryClientesCalcFields(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure qryClientesBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    sProducto: String;
    ListaComponentes, ListaDetalle: TList;
    Objeto: TObject;

    FRegistroABorrarComercialId: String;
    bAlta: boolean;

    procedure ValidarEntradaMaestro;
    procedure ValidarEntradaDetalle;
    procedure AntesDeBorrarMaestro;
    procedure AntesDeBorrarDetalle;
    procedure AbrirTablas;
    procedure CerrarTablas;
    function ValidarValues: boolean;
    function LoadData(AComercial: String): Boolean;
    function LoadDataC(ACliente: String): Boolean;

//    function  ActualizarFechaFinAlta ( const ACodigo, ACliente, AProducto: String; var VFechaFin: TDateTime ): boolean;

  protected
    //procedure AlBorrar;
    procedure DespuesDeBorrar;

    procedure SincronizarWeb; override;

  public

    { Public declarations }
    sComercial: String;

    FParamComercial: String;

    constructor Create(AOwner: TComponent; const Comercial: String); overload;

    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    procedure VerDetalle;
    procedure EditarDetalle;
    procedure CargarDatosEx(const AComer: String);


//   procedure DetalleModificar; override;
//   procedure DetalleAltas; override;
//   procedure DetalleBorrar; override;


//Listado
    procedure Previsualizar; override;
  end;

procedure ComercialDesdeProducto(const AOwner: TComponent; const AProducto: string);
procedure ComercialDesdeCliente(const AOwner: TComponent; const ACliente: string);

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, DPreview, UDMAuxDB, bSQLUtils,
  CMaestro, UDMConfig, SincronizacionBonny;

{$R *.DFM}

var FDProductoComercial: TFMComerciales;

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

procedure TFMComerciales.CargarDatosEx(const AComer: String);
begin
//  if DataSetMaestro.Active then Close;

  where := 'where codigo_c = ' + QuotedStr(AComer);
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
    Add(' select * from frf_clientes_comercial      ');
    Add('  where cod_comercial_cc = :codigo_c       ');
    Add('  order by cod_cliente_cc, cod_producto_cc ');
  end;

  with qryClientesAux.SQL do
  begin
    Clear;
    Add(' select * from frf_clientes_comercial   ');
    Add('  where cod_comercial_cc = :comercial   ');
    //Add('    and cod_empresa_cc = :empresa       ');
    Add('    and cod_cliente_cc = :cliente       ');
    Add('  order by cod_cliente_cc, cod_producto_cc, fecha_ini_cc desc  ');
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

  //cod_empresa_cc.Tag:= kEmpresa;
  cod_cliente_cc.Tag:= kCliente;
  cod_producto_cc.Tag:= kProducto;
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
  FPrincipal.AMModificar.ShortCut := Word('M');
  FPrincipal.AMLocalizar.ShortCut := Word('L');
  FPrincipal.AIPrevisualizar.ShortCut := Word('I');

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
    VK_ADD:
      begin
        nil;
      end;
    VK_SUBTRACT:
      begin
        nil;
      end;
  end;
end;


procedure TFMComerciales.FormShow(Sender: TObject);
begin
  if FParamComercial <> '' then
  begin
    Localizar;
    codigo_c.Text := FParamComercial;
    Aceptar
  end;

//  cxGrid1.SetFocus;
end;

function TFMComerciales.LoadData( AComercial: String): Boolean;
begin
  result := false;
  if qryClientes.Active then Close;

  if not qryClientes.Active then
  begin
    qryClientes.SQl.Clear;
    qryClientes.SQl.Add('Select * from frf_clientes_comercial');
    qryClientes.SQl.Add('where 1=1 ');
    if AComercial <> '' then
      qryClientes.SQl.Add('  and cod_comercial_cc ' + SQLEqualS(AComercial));

    result := OpenQuery(qryClientes);
  end;

end;

function TFMComerciales.LoadDataC( ACliente: String): Boolean;
begin
  result := false;
  if qryClientes.Active then Close;

  if not qryClientes.Active then
  begin
    qryClientes.SQl.Clear;
    qryClientes.SQl.Add('Select * from frf_clientes_comercial');
    qryClientes.SQl.Add('where 1=1 ');
    if ACliente <> '' then
      qryClientes.SQl.Add('  and cod_cliente_cc ' + SQLEqualS(ACliente));

    result := OpenQuery(qryClientes);
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

function TFMComerciales.ValidarValues: boolean;
begin
  ValidarValues := False;
  if (cod_cliente_cc.Text <> '') and (txtCliente.Caption = '') then
  begin
    raise Exception.Create('Falta el código del cliente o es incorrecto.');
  end;
  if (cod_producto_cc.Text <> '') and (txtProducto.Caption = '') then
  begin
    raise Exception.Create('Falta el código del producto o es incorrecto.');
  end;
  if (cod_cliente_cc.Text = '') and (cod_producto_cc.Text = '') then
  begin
    raise Exception.Create('Se debe indicar un cliente o un producto.');
  end;
  ValidarValues := True;

  {
  if TryStrToDate( fecha_ini_cc.Text, dFechaIni ) then
  begin
    ValidarValues:= True;
    //Calcular fecha fin
  end
  else
  begin
    ShowMessage('Fecha incorrecta.');
    fecha_ini_cc.SetFocus;
    ValidarValues:= False;
  end;
}
end;

procedure TFMComerciales.ValidarEntradaDetalle;
var
  sComercial: string;
begin
  if ValidarValues then
  begin
    with DMBaseDatos.QAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select cod_comercial_cc || '' - '' || descripcion_c comercial ');
      SQL.Add('from frf_clientes_comercial join frf_comerciales on codigo_c = cod_comercial_cc ');
      SQL.Add('where 1=1 ');
      if (cod_cliente_cc.Text <> '') and (cod_producto_cc.Text <> '') then
      begin
        SQL.Add('and cod_cliente_cc = :cliente ');
        SQL.Add('and cod_producto_cc = :producto ');
        ParamByName('cliente').AsString:= cod_cliente_cc.Text;
        ParamByName('producto').AsString:= cod_producto_cc.Text;
      end
      else
      if cod_producto_cc.Text <> '' then
      begin
        SQL.Add(' and cod_producto_cc = :producto ');
        SQl.Add(' and cod_cliente_cc is null      ');
        ParamByName('producto').AsString:= cod_producto_cc.Text;
      end
      else
      if cod_cliente_cc.Text <> '' then
      begin
        SQL.Add(' and cod_cliente_cc = :cliente ');
        SQL.Add(' and cod_producto_cc is null   ');
        ParamByName('cliente').AsString:= cod_cliente_cc.Text;
      end;

      Open;
      if not IsEmpty then //si encuentra un comercial
      begin
        sComercial:= FieldByName('comercial').AsString;
        Close;
        if (cod_cliente_cc.Text <> '') and (cod_producto_cc.Text <> '') then
        begin
          raise Exception.Create('El cliente y producto seleccionado ya está asignado al comercial -> ' + sComercial  );
          exit;
        end
        else
        if cod_producto_cc.Text <> '' then
          raise Exception.Create('El producto seleccionado ya está asignado al comercial -> ' + sComercial  )
        else
          raise Exception.Create('El cliente seleccionado ya está asignado al comercial -> ' + sComercial  );
      end
      else //si está vacío
        Close;
{
      if bAlta then
      begin
        dFechaFin := dFechaIni;
        if ActualizarFechaFinAlta( codigo_c.Text, cod_cliente_cc.Text, cod_producto_cc.Text, dFechaFin ) then
          qryClientes.FieldByName('fecha_fin_cc').AsDateTime:= dFechaFin;
      end;
}
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
    kCliente: DespliegaRejilla(btnCliente);
    kProducto: DespliegaRejilla(btnProducto);
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

{
function TFMComerciales.ActualizarFechaFinAlta(const ACodigo, ACliente, AProducto: String; var VFechaFin: TDateTime): boolean;
var
  bAnt: boolean;
begin
  bAnt:= False;
  result:= False;
  qryClientesAux.SQL.Clear;
  qryClientesAux.SQL.Add(' select * from frf_clientes_comercial   ');
  qryClientesAux.SQL.Add('  where cod_comercial_cc = :comercial   ');

  if ACliente <> '' then
  begin
    qryClientesAux.SQL.Add('    and cod_cliente_cc = :cliente       ');
    qryClientesAux.ParamByName('cliente').AsString := ACliente;
  end;

  if AProducto <> '' then
  begin
    qryClientesAux.SQL.Add('  and cod_producto_cc = :producto     ');
    qryClientesAux.ParamByName('producto').AsString := AProducto;
  end;

  qryClientesAux.SQL.Add('  order by cod_cliente_cc, cod_producto_cc, fecha_ini_cc desc ');
  qryClientesAux.ParamByName('comercial').AsString := ACodigo;

  qryClientesAux.Open;
  try
    if not qryClientesAux.IsEmpty then
    begin
      while ( qryClientesAux.FieldByName('fecha_ini_cc').AsDateTime < VFechaFin ) and
            ( not qryClientesAux.Eof ) do
      begin
        bAnt:= True;
        qryClientesAux.Next;
      end;
      if qryClientesAux.FieldByName('fecha_ini_cc').AsDateTime <> VFechaFin then
      begin
        if qryClientesAux.Eof then
        begin
          //Estoy en
          qryClientesAux.Edit;
          qryClientesAux.FieldByName('fecha_fin_cc').AsDateTime:= VFechaFin - 1;
          qryClientesAux.Post;
        end
        else
        begin
          //hay anterior
          if bAnt then
          begin
            qryClientesAux.Prior;
            qryClientesAux.Edit;
            qryClientesAux.FieldByName('fecha_fin_cc').AsDateTime:= VFechaFin - 1;
            qryClientesAux.Post;
            qryClientesAux.Next;
          end;
          //Hay siguiente
          if not qryClientesAux.Eof then
          begin
            VFechaFin:= qryClientesAux.FieldByName('fecha_ini_cc').AsDateTime - 1;
            result:= True;
          end;
        end;
      end;
    end;
  finally
    qryClientesAux.Close;
  end;
end;
}

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
end;

procedure TFMComerciales.EditarDetalle;
begin
  PanelDetalle.Enabled:= True;
  PanelDetalle.Visible:= True;
  PanelMaestro.Height:= 90;
  if PageControl.ActivePage = tsClientes then
  begin
    FocoDetalle:=cod_cliente_cc;  // antes FocoDetalle:=cod_empresa_cc;
    if EstadoDetalle <> tedModificar then
    begin
      qryClientes.Close;
      qryClientes.Open;
    end;
  end
  else
  begin
    //
  end;
end;

procedure TFMComerciales.qryClientesBeforePost(DataSet: TDataSet);
begin
  if qryClientes.FieldByName('cod_producto_cc').AsString = '' then
    qryClientes.FieldByName('cod_producto_cc').Value := Null;
  if qryClientes.FieldByName('cod_cliente_cc').AsString = '' then
    qryClientes.FieldByName('cod_cliente_cc').Value := Null;
end;

procedure TFMComerciales.qryClientesCalcFields(DataSet: TDataSet);
begin
  qryClientes.FieldByName('des_cliente').AsString:= desCliente( qryClientes.FieldByName('cod_cliente_cc').AsString);
  qryClientes.FieldByName('des_producto').AsString:= desProducto( '', qryClientes.Fieldbyname('cod_producto_cc').AsString);
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

//procedure TFMComerciales.cod_empresa_ccChange(Sender: TObject);
//begin
//  txtEmpresa.Caption:= desEmpresa( cod_empresa_cc.Text );
//  cod_cliente_ccChange( cod_cliente_cc );
//end;

procedure TFMComerciales.cod_producto_ccChange(Sender: TObject);
begin
  txtProducto.Caption:= desProducto( '', cod_producto_cc.Text );
end;

constructor TFMComerciales.Create(AOwner: TComponent; const Comercial: String);
begin
  FParamComercial := Comercial;
  inherited Create(AOwner);
end;

procedure TFMComerciales.cxBorrarFiltroClick(Sender: TObject);
begin
  with qryClientes do
  begin
    if Active then Close;

    SQL.Clear;
    SQL.Add(' select * from frf_clientes_comercial ');
    SQL.Add('  where cod_comercial_cc = :codigo_c  ');

    SQL.Add(' order by cod_cliente_cc, cod_producto_cc ');

    ParamByName('codigo_c').AsString := codigo_c.Text;
    Open;
  end;
end;

procedure TFMComerciales.cxFiltrarClick(Sender: TObject);
begin
  with qryClientes do
  begin
    if Active then Close;

    SQL.Clear;
    SQL.Add(' select * from frf_clientes_comercial ');
    SQL.Add('  where cod_comercial_cc = :codigo_c  ');
    SQL.Add(' order by cod_cliente_cc ');

    ParamByName('codigo_c').AsString := codigo_c.Text;
    Open;
  end;
end;

procedure TFMComerciales.cxGrid1Exit(Sender: TObject);
begin
  FPrincipal.AMModificar.ShortCut := Word('M');
  FPrincipal.AMLocalizar.ShortCut := Word('L');
  FPrincipal.AIPrevisualizar.ShortCut := Word('I');
end;

procedure TFMComerciales.cxGrid1Enter(Sender: TObject);
begin
  FPrincipal.AMModificar.ShortCut := 0;
  FPrincipal.AMLocalizar.ShortCut := 0;
  FPrincipal.AIPrevisualizar.ShortCut := 0;
end;

procedure TFMComerciales.DespuesDeBorrar;
begin
  SincroBonnyAurora.SincronizarComercial(FRegistroABorrarComercialId);
  SincroBonnyAurora.Sincronizar;
  FRegistroABorrarComercialId := '';
end;
{
procedure TFMComerciales.DetalleAltas;
begin
  cod_cliente_cc.Enabled := true;
  cod_producto_cc.Enabled := true;
  fecha_ini_cc.Enabled := true;
  bAlta := true;

  inherited DetalleAltas;

end;

procedure TFMComerciales.DetalleBorrar;
var
  dIniAux: TDateTime;
begin
  if not qryClientes.IsEmpty then
  begin
    if qryClientes.FieldByName('fecha_fin_cc').AsString = '' then
    begin
      qryClientes.Delete;
      if not qryClientes.IsEmpty then
      begin
        qryClientes.Prior;
        qryClientes.Edit;
        qryClientes.FieldByName('fecha_fin_cc').AsString:= '';
        qryClientes.Post;
      end;
    end
    else
    begin
      qryClientes.Delete;
      dIniAux:=  qryClientes.FieldByName('fecha_ini_cc').AsDateTime;
      qryClientes.Prior;
      if dIniAux <> qryClientes.FieldByName('fecha_ini_cc').AsDateTime then
      begin
        qryClientes.Edit;
        qryClientes.FieldByName('fecha_fin_cc').AsDateTime:= dIniAux - 1;
        qryClientes.Post;
      end;
    end;
    ShowMessage('Ficha borrada');
  end
  else
  begin
    ShowMessage('No hay ficha para borrar');
  end;
end;

procedure TFMComerciales.DetalleModificar;
begin
  cod_cliente_cc.Enabled := true;
  cod_producto_cc.Enabled := true;
  fecha_ini_cc.Enabled := false;
  bAlta := false;

  inherited DetalleModificar;

end;
}
procedure TFMComerciales.cod_cliente_ccChange(Sender: TObject);
begin
  txtCliente.Caption:= desCliente( cod_cliente_cc.Text );
end;

procedure ComercialDesdeProducto(const AOwner: TComponent; const AProducto: string);
Var FMComerciales : TFMComerciales;
begin
{
    FDProductoComercial:= TFMComerciales.Create(AOwner);
    try
      FDProductoComercial.LoadData (AProducto);
      FDProductoComercial.ShowModal;
    finally
      FreeAndNil(FDProductoComercial );
    end;

  with TFMComerciales.Create(nil) do
  begin
    sProducto := AProducto;

    if LoadData then
      ShowModal
    else
      Free;
  end;
}
end;

procedure ComercialDesdeCliente(const AOwner: TComponent; const ACliente: string);
begin
    FDProductoComercial:= TFMComerciales.Create(AOwner);
    try
      FDProductoComercial.LoadDataC (ACliente);
      FDProductoComercial.ShowModal;
    finally
      FreeAndNil(FDProductoComercial );
    end;
end;

end.
