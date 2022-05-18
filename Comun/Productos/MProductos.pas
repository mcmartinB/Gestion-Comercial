unit MProductos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BEdit, BDEdit,
  dbtables, DError, ComCtrls, CUAMenuUtils;

type
  TFMProductos = class(TMaestroDetalle)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;                                               
    QProductos: TQuery;
    PageControl: TPageControl;
    tsCategorias: TTabSheet;
    tsCalibres: TTabSheet;
    PCategorias: TPanel;
    Label1: TLabel;
    categoria_c: TBDEdit;
    descripcion_c: TBDEdit;
    RCategorias: TDBGrid;
    RCalibres: TDBGrid;
    PCalibres: TPanel;
    RejillaFlotante: TBGrid;
    Lproducto_p: TLabel;
    Ldescripcion_p: TLabel;
    producto_p: TBDEdit;
    descripcion_p: TBDEdit;
    descripcion2_p: TBDEdit;
    QCalibres: TQuery;
    DSCalibres: TDataSource;
    QCategorias: TQuery;
    DSCategorias: TDataSource;
    lblCalibre: TLabel;
    calibre_c: TBDEdit;
    QColores: TQuery;
    DSColores: TDataSource;
    tsColores: TTabSheet;
    PColores: TPanel;
    Label2: TLabel;
    color_c: TBDEdit;
    BDEdit2: TBDEdit;
    RColores: TDBGrid;
    tsPaises: TTabSheet;
    PPaises: TPanel;
    Label3: TLabel;
    pais_psp: TBDEdit;
    RPaises: TDBGrid;
    btnpais: TBGridButton;
    stPais: TStaticText;
    QPaises: TQuery;
    dsPaises: TDataSource;
    tsVariedadCampo: TTabSheet;
    lblEsTomate: TLabel;
    estomate_p: TDBCheckBox;
    QVariedadCampo: TQuery;
    dsVariedadCampo: TDataSource;
    PVariedadCampo: TPanel;
    Label4: TLabel;
    codigo_pv: TBDEdit;
    descripcion_pv: TBDEdit;
    RVariedadCampo: TDBGrid;
    pnlPasarSGP: TPanel;
    lblAleman: TLabel;
    des_aleman_p: TBDEdit;
    tsCostes: TTabSheet;
    dbgrdCostes: TDBGrid;
    qryCostesProducto: TQuery;
    dsCostesProducto: TDataSource;
    pnlCostes: TPanel;
    btnCostes: TButton;
    lbl2: TLabel;
    eshortaliza_p: TDBCheckBox;
    pnlCostesAyudas: TPanel;
    bvl1: TBevel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lblEurKiloLocal: TLabel;
    lblporcentajeLocal: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lblEurKgExporta: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl8: TLabel;
    lbl11: TLabel;
    coste_peninsula_p: TBDEdit;
    coste_tenerife_p: TBDEdit;
    eur_kilo_tenerife_p: TBDEdit;
    porcen_importe_tenerife_p: TBDEdit;
    eur_kilo_transito_p: TBDEdit;
    porcen_importe_transito_p: TBDEdit;
    lblNombre8: TLabel;
    fecha_baja_p: TBDEdit;
    lblNombre9: TLabel;
    cbxVer: TComboBox;
    tipo_compra_p: TDBCheckBox;
    tipo_venta_p: TDBCheckBox;
    producto_desglose_p: TDBCheckBox;
    TabSheet1: TTabSheet;
    DBGrid1: TDBGrid;
    qryComercial: TQuery;
    dsComercial: TDataSource;
    qryComercialcod_comercial_cc: TStringField;
    qryComercialcod_cliente_cc: TStringField;
    qryComercialcod_producto_cc: TStringField;
    qryComercialdes_comercial: TStringField;
    Panel1: TPanel;
    btnComercial: TBitBtn;
    lblNombre1: TLabel;
    area_p: TBDEdit;
    btnArea: TBGridButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure QProductosAfterOpen(DataSet: TDataSet);
    procedure QProductosBeforeClose(DataSet: TDataSet);
    procedure PageControlChange(Sender: TObject);
    procedure QCategoriasNewRecord(DataSet: TDataSet);
    procedure QCalibresNewRecord(DataSet: TDataSet);
    procedure QProductosBeforePost(DataSet: TDataSet);
    procedure QColoresNewRecord(DataSet: TDataSet);
    procedure pais_pspChange(Sender: TObject);
    procedure QPaisesNewRecord(DataSet: TDataSet);
    procedure QProductosAfterScroll(DataSet: TDataSet);
    procedure estomate_pClick(Sender: TObject);
    procedure QVariedadCampoNewRecord(DataSet: TDataSet);
    procedure pnlPasarSGPClick(Sender: TObject);
    procedure DSMaestroDataChange(Sender: TObject; Field: TField);
    procedure btnCostesClick(Sender: TObject);
    procedure eshortaliza_pClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnProductoComercialClick(Sender: TObject);
    procedure qryComercialCalcFields(DataSet: TDataSet);
    procedure btnComercialClick(Sender: TObject);
  private
    { Private declarations }
    ListaComponentes, ListaDetalle: TList;
    Objeto: TObject;
    bFlag: Boolean;

    FRegistroABorrarProductoId: String;
    FRegistroABorrarCategoriaId: String;
    FRegistroABorrarColorId: String;
    FRegistroABorrarCalibreId: String;

    procedure ValidarEntradaMaestro;
    procedure AntesDeBorrarMaestro;
    procedure ValidarEntradaDetalle;
    procedure AntesDeBorrarDetalle;
    procedure DespuesDeBorrarDetalle;    
    procedure AbrirTablas;
    procedure CerrarTablas;

    procedure BorrarActivo;

    procedure GetProductoBDRemota( const ABDRemota: string; const AAlta: Boolean );
    procedure BuscarProducto( const AEmpresa, AProducto: string );
    procedure RefrescarProducto;

  protected
    procedure SincronizarWeb; override;
    procedure SincronizarDetalleWeb; override;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;
    procedure AntesDeLocalizar;

    procedure VerDetalle;
    procedure EditarDetalle;

    //Listado
    procedure Previsualizar; override;
    procedure Borrar; override;

    procedure Altas; override;
    procedure Modificar; override;
    procedure DetalleModificar; override;
    procedure DetalleAltas; override;

  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, DPreview, UDMAuxDB, bSQLUtils,
  CMaestro, UDMConfig, LProducto, AdvertenciaFD,
  ImportarProductosFD, UComerToSgpDM, CGlobal, CostesAgrupaProductoFD,
  SincronizacionBonny, MComerciales;

{$R *.DFM}

procedure TFMProductos.AbrirTablas;
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

procedure TFMProductos.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

procedure TFMProductos.FormShow(Sender: TObject);
begin
  Top := 1;
end;

procedure TFMProductos.FormCreate(Sender: TObject);
begin
  LineasObligadas:= False;
  ListadoObligado:= False;
  MultipleAltas:= false;

  //Variables globales
  M:=Self;
  MD:=Self;
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF :=nil;

  PageControl.ActivePage:= tsCategorias;
  DataSourceDetalle:=DSCategorias;
  RejillaVisualizacion := RCategorias;
  PanelDetalle := PCategorias;

  //Panel
  PanelMaestro := PMaestro;

  //Fuente de datos
  DataSetMaestro:=QProductos;

  Select := ' SELECT * FROM frf_productos ';
  where  := ' WHERE producto_p=' + QuotedStr('###');
  Order  := ' ORDER BY producto_p ';

  //Para reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := kNull;
  //Abrir tablas/Querys

  with QCategorias.SQL do
  begin
    Clear;
    Add('select * from frf_categorias ');
    Add('where producto_c = :producto_p ');
    Add('ORDER BY categoria_c');
  end;

  with QCalibres.SQL do
  begin
    Clear;
    Add('select * from frf_calibres ');
    Add('where producto_c = :producto_p ');
    Add('ORDER BY calibre_c');
  end;

  with QColores do
  begin
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM   frf_colores Frf_color ');
    SQL.Add('WHERE  (producto_c=:producto_p) ');
    SQL.Add('ORDER BY color_c');
  end;

  with QPaises do
  begin
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM   frf_paises_producto ');
    SQL.Add('WHERE  (producto_psp=:producto_p) ');
    SQL.Add('ORDER BY pais_psp');
  end;

  with QVariedadCampo do
  begin
    SQL.Clear;
    SQL.Add(' SELECT producto_pv,codigo_pv,descripcion_pv ');
    SQL.Add(' FROM   frf_productos_variedad ');
    SQL.Add(' WHERE  (producto_pv=:producto_p) ');
    SQL.Add(' ORDER BY codigo_pv ');
  end;

  with qryCostesProducto do
  begin
    SQL.clear;
    SQL.Add(' select  agrupacion_cap agrupacion, centro_cap centro, fecha_ini_cap fecha,  ');
    SQL.Add('         coste_directo_cap + coste_material_cap + coste_seccion_cap coste_total ');
    SQL.Add(' from frf_costes_agrupa_prod ');
    SQL.Add(' where producto_cap = :producto_p ');
    SQL.Add(' order by 3, 1, 2 ');
  end;

  with qryComercial do
  begin
    SQL.clear;
    SQL.Add(' select  * ');
    SQL.Add(' from frf_clientes_comercial');
    SQL.Add(' where cod_producto_cc = :producto_p ');
  end;

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
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnBeforeMasterDelete := AntesDeBorrarMaestro;
  OnValidateDetailConstrains := ValidarEntradaDetalle;
  OnBeforeDetailDelete := AntesDeBorrarDetalle;
  OnAfterDetailDeleted := DespuesDeBorrarDetalle;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;
  OnBrowse:= AntesDeLocalizar;

  //Preparar panel de detalle
  OnViewDetail:=VerDetalle;
  OnEditDetail:=EditarDetalle;

     //Focos
  {+}FocoAltas := producto_p;
  {+}FocoModificar := descripcion_p;
  {+}FocoLocalizar := producto_p;

  pais_psp.Tag:= kPais;
  area_p.Tag := kArea;
  bFlag:= False;

  if CGlobal.gProgramVersion = CGlobal.pvSAT then
  begin
//    pnlPasarSGP.Visible:= DMConfig.EsLosLLanos or DMConfig.EsLaFontEx;
    pnlCostesAyudas.Visible:= True;
  end
  else
  begin
//    pnlPasarSGP.Visible:= False;
    pnlCostesAyudas.Visible:= False;
    PMaestro.Height:= PMaestro.Height - pnlCostesAyudas.Height;
  end;
end;

procedure TFMProductos.FormActivate(Sender: TObject);
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
  QProductos.Close;
  QProductos.Open;
end;

procedure TFMProductos.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF :=nil;
end;


procedure TFMProductos.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMProductos.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMProductos.Filtro;
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

  if cbxVer.ItemIndex <> 0 then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    if cbxVer.ItemIndex = 1 then
      where := where + ' fecha_baja_p is null'
    else
      where := where + ' fecha_baja_p is not null';
  end;


  if flag then where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFMProductos.AnyadirRegistro;
var
  Flag: Boolean;
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

procedure TFMProductos.Altas;
(*
var
  iTipo: Integer;
  sBD: string;
*)
begin
  if DMConfig.EsLaFontEx then
  begin
    inherited Altas;
    (*
    if DMBaseDatos.GetPermiso( gsCodigo, 'imp_cli_almacen' ) = 1 then
    begin
      if SeleccionarTipoAltaFD.SeleccionarTipoAlta( Self, iTipo, sBD ) = mrOk then
      begin
        case iTipo of
          0: inherited Altas;
          1: GetClienteBDRemota( sBD, True );
        end;
      end
    end
    else
    begin
      inherited Altas;
    end;
    *)
  end
  else
  begin
    begin
      if DMBaseDatos.AbrirConexionCentral then
      begin
        GetProductoBDRemota( 'BDCentral', True );
      end
      else
      begin
        if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Recuerde que cualquier cambio que se realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer altas locales', 'Nuevo Envase') = mrIgnore then
          inherited Altas;
      end;
    end;
  end;
end;

procedure TFMProductos.Modificar;
(*
var
  iTipo: Integer;
  sBD: string;
*)
begin
  if DMConfig.EsLaFontEx then
  begin
    inherited Modificar;
    (*
    if DMBaseDatos.GetPermiso( gsCodigo, 'imp_cli_almacen' ) = 1 then
    begin
      if SeleccionarTipoAltaFD.SeleccionarTipoAlta( Self, iTipo, sBD,
                               '     SELECCIONAR TIPO ACTUALIZACIÓN', 'Editar Registro Local' ) = mrOk then
      begin
        case iTipo of
          0: inherited Modificar;
          1: GetClienteBDRemota( sBD, False );
        end;
      end
    end
    else
    begin
      inherited Modificar;
    end;
    *)
  end
  else
  begin
    begin
      if DMBaseDatos.AbrirConexionCentral then
      begin
        GetProductoBDRemota( 'BDCentral', False );
      end
      else
      begin
        if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Cualquier cambio que realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer modificaciones locales', 'Modificar Envase') = mrIgnore then
          inherited Modificar;
      end;
    end;
  end;
end;

procedure TFMProductos.GetProductoBDRemota( const ABDRemota: string; const AAlta: Boolean );
var
  sEmpresa, sProducto: string;
  iValue: Integer;
  bAlta: Boolean;
begin
  if AAlta then
    sProducto:= ''
  else
    sProducto:= producto_p.Text;
  bAlta:= AAlta;

  iValue:= ImportarProducto( Self, ABDRemota, sProducto, bAlta );
  case iValue of
      -1: //Operacion cancelada
          begin end;
       1: begin
            if bAlta then
            begin
              BuscarProducto( sEmpresa, sProducto );
              //ShowMessage('Alta de envase correcta.');
            end
            else
            begin
              RefrescarProducto;
              //ShowMessage('Modificación de envase correcta.');
            end;
          end;
       else ShowMessage('Error ' + IntToStr( iValue ) + ' al importar el producto.');
  end;
end;

procedure TFMProductos.BuscarProducto( const AEmpresa, AProducto: string );
begin
 {+}Select := ' SELECT * FROM frf_productos ';
 {+}where := ' WHERE producto_p=' + QuotedStr(AProducto);
 {+}Order := ' ORDER BY producto_p ';

 QProductos.Close;
 AbrirTablas;
 Visualizar;
end;

procedure TFMProductos.RefrescarProducto;
var
  myBookMark: TBookmark;
begin
  myBookMark:= QProductos.GetBookmark;
  QProductos.Close;
  QProductos.Open;
  QProductos.GotoBookmark(myBookMark);
  QProductos.FreeBookmark(myBookMark);
end;


procedure TFMProductos.DetalleModificar;
begin
  if DMConfig.EsLaFontEx then
  begin
    inherited DetalleModificar;
  end
  else
  begin
    //inherited Altas;
    if DMBaseDatos.AbrirConexionCentral then
    begin
      GetProductoBDRemota( 'BDCentral', False );
    end
    else
    begin
      if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Recuerde que cualquier cambio que se realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer altas locales', 'Nuevo Envase') = mrIgnore then
        inherited DetalleModificar;
    end;
  end;
end;

procedure TFMProductos.DespuesDeBorrarDetalle;
begin
  if DatasourceDetalle = DSCategorias then
  begin
    SincroBonnyAurora.SincronizarCategoria(FRegistroABorrarProductoId, FRegistroABorrarCategoriaId);
    SincroBonnyAurora.Sincronizar;
    FRegistroABorrarProductoId := '';
    FRegistroABorrarCategoriaId := '';
  end
  else if DatasourceDetalle = DSColores then
  begin
    SincroBonnyAurora.SincronizarColor(FRegistroABorrarProductoId, FRegistroABorrarColorId);
    SincroBonnyAurora.Sincronizar;
    FRegistroABorrarProductoId := '';
    FRegistroABorrarColorId := '';
  end
  else if DatasourceDetalle = DSCalibres then
  begin
    SincroBonnyAurora.SincronizarCalibre(FRegistroABorrarProductoId, FRegistroABorrarCalibreId);
    SincroBonnyAurora.Sincronizar;
    FRegistroABorrarProductoId := '';
    FRegistroABorrarCalibreId := '';
  end
end;

procedure TFMProductos.DetalleAltas;
begin
  if DMConfig.EsLaFontEx then
  begin
    inherited DetalleAltas;
  end
  else
  begin
    //inherited Altas;
    if DMBaseDatos.AbrirConexionCentral then
    begin
      GetProductoBDRemota( 'BDCentral', False );
    end
    else
    begin
      if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Recuerde que cualquier cambio que se realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer altas locales', 'Nuevo Envase') = mrIgnore then
        inherited DetalleAltas;
    end;
  end;
end;

procedure TFMProductos.ValidarEntradaMaestro;
begin
  //Empresa
  if producto_p.Text = '' then
    raise Exception.Create('Falta el código del producto.');
  if descripcion_p.Text = '' then
    raise Exception.Create('Falta la descripción del producto.');


  if QProductos.FieldByName('eshortaliza_p').AsString = '' then
    raise Exception.Create('Por favor marque si el producto es hortaliza o no.');
  if QProductos.FieldByName('eshortaliza_p').AsString = 'N' then
   QProductos.FieldByName('estomate_p').AsString:= 'N'
  else
  begin
    if QProductos.FieldByName('estomate_p').AsString = '' then
      raise Exception.Create('Por favor marque si el producto es tomate o no.');
  end;

  if QProductos.Fieldbyname('tipo_compra_p').AsString = '' then
      raise Exception.Create('Por favor marque si el producto es de compra o no.');

  if QProductos.Fieldbyname('tipo_venta_p').AsString = '' then
      raise Exception.Create('Por favor marque si el producto es de venta o no.');

  if QProductos.Fieldbyname('area_p').AsString = '' then
      raise Exception.Create('Se debe selecionar un area para el producto..');


  if QProductos.State = dsInsert then
  begin
  //Comprobar que no este dado de alta el producto
    with DMBaseDatos.QGeneral do
    begin
      SQL.Clear;
      SQL.Add('select *  from frf_productos where producto_p = :producto');
      ParamByName('producto').AsString:= producto_p.Text;
      Open;
      if not IsEmpty then
      begin
        Close;
        raise Exception.Create('El código del producto seleccionado ya esta dado de alta en el sistema.');
      end
      else
      begin
        Close;
      end;
    end;
  end;
end;


procedure TFMProductos.btnComercialClick(Sender: TObject);
Var FMComerciales: TFMComerciales;
    sComercial: String;
begin
  sComercial := qryComercial.FieldByName('cod_comercial_cc').AsString;
  LockWindowUpdate(Self.Handle);
  try
   FMComerciales := TFMComerciales.Create(Application, sComercial);
  finally
    LockWindowUpdate(0);
  end;
end;

procedure TFMProductos.Borrar;
var botonPulsado: Word;
begin
     //Barra estado
  Estado := teBorrar;
  EstadoDetalle := tedOperacionMaestro;
  BEEstado;
  BHEstado;

     //preguntar si realmente queremos borrar
  botonPulsado := mrNo;

  if VerAdvertencia( Self, #13 + #10 + ' ¿Esta usted seguro de querer borrar el producto con todas sus lineas asociadas?', '    BORRAR PRODUCTO',
                     'Quiero borrar el producto completo', 'Borrar Producto'  ) = mrIgnore then
  //if application.MessageBox('Esta usted seguro de querer borrar la cabecera con todas sus lineas?',
  //  '  ATENCIÓN !', MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2) = IDOK then
    botonPulsado := mrYes;

  if botonPulsado = mrYes then
  begin
    if not DMBaseDatos.DBBaseDatos.InTransaction then
    begin
      DMBaseDatos.DBBaseDatos.StartTransaction;
      try
        BorrarActivo;
        DMBaseDatos.DBBaseDatos.Commit;
        Visualizar;
      except
        on e:exception do
        begin
          DMBaseDatos.DBBaseDatos.Rollback;
          Visualizar;
          ShowMessage( 'ERROR:' +#13+#10 + e.Message );
        end;
      end;
    end
    else
    begin
      ShowMessage( 'ERROR:' +#13+#10 + 'No se puede abrir una transacción, por favor intentelo mas tarde.' );
    end;
  end;
end;

procedure TFMProductos.BorrarActivo;
var
  sProducto, sProductoBase: string;
  bBorrarBase: Boolean;
  productoId: String;
begin
  //Borrar detalle

  QCategorias.First;
  while not QCategorias.Eof do
  begin
    SincroBonnyAurora.SincronizarCategoria(
      QCategorias.FieldByName('producto_c').asString,
      QCategorias.FieldByName('categoria_c').asString);
    QCategorias.Delete;
  end;

  QCalibres.First;
  while not QCalibres.Eof do
  begin
    SincroBonnyAurora.SincronizarCalibre(
      QCalibres.FieldByName('producto_c').asString,
      QCalibres.FieldByName('calibre_c').asString);
    QCalibres.Delete;
  end;

  QColores.First;
  while not QColores.Eof do
  begin
    SincroBonnyAurora.SincronizarColor(
      QColores.FieldByName('producto_c').asString,
      QColores.FieldByName('color_c').asString);
    QColores.Delete;
  end;

  QPaises.First;
  while not QPaises.Eof do
  begin
    QPaises.Delete;
  end;

  QVariedadCampo.First;
  while not QVariedadCampo.Eof do
  begin
    QVariedadCampo.Delete;
  end;


  sProducto:= producto_p.Text;

  productoId := QProductos.FieldByName('producto_p').asString;
  QProductos.Delete;

  SincroBonnyAurora.SincronizarProducto(productoId);
  SincroBonnyAurora.Sincronizar;
{
  with DMBaseDatos.QGeneral do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_productos where producto_base_p1 = :producto_base');
    ParamByName('producto_base').AsString:= sProductoBase;
    Open;
    bBorrarBase:= IsEmpty;
    Close;
  end;

  if bBorrarBase then
  with DMBaseDatos.QGeneral do
  begin
    SQL.Clear;
    SQL.Add('delete from frf_productos_base where producto_base_pb = :producto_base ');
    ParamByName('producto_base').AsString:= sProductoBase;
    ExecSql;
  end;
}
end;


procedure TFMProductos.ValidarEntradaDetalle;
begin
end;

procedure TFMProductos.AntesDeBorrarMaestro;
begin
end;

procedure TFMProductos.AntesDeBorrarDetalle;
begin
  if DatasourceDetalle = DSCategorias then
  begin
    FRegistroABorrarProductoId := DSCategorias.DataSet.FieldByName('producto_c').asString;
    FRegistroABorrarCategoriaId := DSCategorias.DataSet.FieldByName('categoria_c').asString;
  end
  else if DatasourceDetalle = DSColores then
  begin
    FRegistroABorrarProductoId := DSColores.DataSet.FieldByName('producto_c').asString;
    FRegistroABorrarColorId := DSColores.DataSet.FieldByName('color_c').asString;
  end
  else if DatasourceDetalle = DSCalibres then
  begin
    FRegistroABorrarProductoId := DSCalibres.DataSet.FieldByName('producto_c').asString;
    FRegistroABorrarCalibreId := DSCalibres.DataSet.FieldByName('calibre_c').asString;
  end
end;

procedure TFMProductos.Previsualizar;
var
  marcador: TBookmark;
begin
  marcador := DSMaestro.DataSet.GetBookmark;
  //Crear el listado
  QRLProducto := TQRLProducto.Create(Application);
  PonLogoGrupoBonnysa(QRLProducto);

  QRLProducto.DataSet := QProductos;
  QRLProducto.ColorDataSet := QColores;
  QRLProducto.CalibreDataSet := QCalibres;
  QRLProducto.CategoriaDataSet := QCategorias;
  QRLProducto.PaisDataSet := QPaises;
  QRLProducto.VariedadDataSet:= QVariedadCampo;

  Preview(QRLProducto);
  DSMaestro.DataSet.GotoBookmark(marcador);
  DSMaestro.DataSet.FreeBookmark(marcador);
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//*****************************************************************************

procedure TFMProductos.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kPais: DespliegaRejilla( btnpais );
    kArea: DespliegaRejilla( btnArea );
  end;
end;

procedure TFMProductos.AntesDeInsertar;
begin
  (*
  if not DMConfig.EsLaFont then
  begin
    ShowMessage('Antes de dar de alta un nuevo proveedor, recuerde darlo de alta antes en la central.');
  end;
  *)
  estomate_p.Checked:= False;
  QProductos.Fieldbyname('tipo_compra_p').AsString := 'N';
  QProductos.Fieldbyname('tipo_venta_p').AsString := 'S';
  QProductos.FieldByName('producto_desglose_p').AsString := 'N';
//  tipo_compra_p.Checked:= False;
//  tipo_venta_p.Checked:= True;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMProductos.AntesDeModificar;
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

procedure TFMProductos.AntesDeVisualizar;
var i: Integer;
begin
  cbxVer.Enabled := False;

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

procedure TFMProductos.AntesDeLocalizar;
begin
  //
  cbxVer.ItemIndex := 0;
  cbxVer.Enabled := True;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMProductos.RequiredTime(Sender: TObject; var isTime: Boolean);
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

procedure TFMProductos.SincronizarDetalleWeb;
var
  productoId,
  categoriaId,
  calibreId,
  colorId: String;
begin
  if DatasourceDetalle = DSCategorias then
  begin
    productoId := DSCategorias.DataSet.FieldByName('producto_c').asString;
    categoriaId := DSCategorias.DataSet.FieldByName('categoria_c').asString;
    SincroBonnyAurora.SincronizarCategoria(productoId, categoriaId);
    SincroBonnyAurora.Sincronizar;
  end
  else if DatasourceDetalle = DSColores then
  begin
    productoId := DSColores.DataSet.FieldByName('producto_c').asString;
    colorId := DSColores.DataSet.FieldByName('color_c').asString;
    SincroBonnyAurora.SincronizarColor(productoId, colorId);
    SincroBonnyAurora.Sincronizar;
  end
  else if DatasourceDetalle = DSCalibres then
  begin
    productoId := DSCalibres.DataSet.FieldByName('producto_c').asString;
    calibreId := DSCalibres.DataSet.FieldByName('calibre_c').asString;
    SincroBonnyAurora.SincronizarCalibre(productoId, calibreId);
    SincroBonnyAurora.Sincronizar;
  end
end;

procedure TFMProductos.SincronizarWeb;
begin
  SincroBonnyAurora.SincronizarProducto(DSMaestro.Dataset.FieldByName('producto_p').asString);
  SincroBonnyAurora.Sincronizar;
end;

procedure TFMProductos.QProductosAfterOpen(DataSet: TDataSet);
begin
  QCalibres.Open;
  QCategorias.Open;
  QColores.Open;
  QPaises.Open;
  QVariedadCampo.Open;
  qryCostesProducto.Open;
  qryComercial.Open;
end;

procedure TFMProductos.QProductosBeforeClose(DataSet: TDataSet);
begin
  QCalibres.Close;
  QCategorias.Close;
  QColores.Close;
  QPaises.Close;
  QVariedadCampo.Close;
  qryCostesProducto.Close;
  qryComercial.Close;
end;

procedure TFMProductos.VerDetalle;
begin
  PanelDetalle.Enabled:= false;
  PanelDetalle.Visible:= false;
  tsCategorias.TabVisible:= True;
  tsCalibres.TabVisible:= True;
  tsColores.TabVisible:= True;
  tsPaises.TabVisible:= True;
  tsVariedadCampo.TabVisible:= True;
end;

procedure TFMProductos.EditarDetalle;
begin
  PanelDetalle.Enabled:= TRUE;
  PanelDetalle.Visible:= True;
  if PageControl.ActivePage = tsCategorias then
  begin
    FocoDetalle:=categoria_c;
    tsPaises.TabVisible:= False;
    tsCalibres.TabVisible:= False;
    tsColores.TabVisible:= False;
    tsVariedadCampo.TabVisible:= False;
    if EstadoDetalle <> tedModificar then
    begin
      QCategorias.Close;
      QCategorias.Open;
    end;
  end
  else
  if PageControl.ActivePage = tsCalibres then
  begin
    FocoDetalle:=calibre_c;
    tsCategorias.TabVisible:= False;
    tsPaises.TabVisible:= False;
    tsColores.TabVisible:= False;
    tsVariedadCampo.TabVisible:= False;
    if EstadoDetalle <> tedModificar then
    begin
      QCalibres.Close;
      QCalibres.Open;
    end;
  end
  else
  if PageControl.ActivePage = tsColores then
  begin
    FocoDetalle:=color_c;
    tsCategorias.TabVisible:= False;
    tsCalibres.TabVisible:= False;
    tsPaises.TabVisible:= False;
    tsVariedadCampo.TabVisible:= False;
    if EstadoDetalle <> tedModificar then
    begin
      QColores.Close;
      QColores.Open;
    end;
  end
  else
  if PageControl.ActivePage = tsPaises then
  begin
    FocoDetalle:=pais_psp;
    tsCategorias.TabVisible:= False;
    tsCalibres.TabVisible:= False;
    tsVariedadCampo.TabVisible:= False;
    tsColores.TabVisible:= False;
    if EstadoDetalle <> tedModificar then
    begin
      QPaises.Close;
      QPaises.Open;
    end;
  end
  else
  if PageControl.ActivePage = tsVariedadCampo then
  begin
    FocoDetalle:=codigo_pv;
    tsCategorias.TabVisible:= False;
    tsCalibres.TabVisible:= False;
    tsPaises.TabVisible:= False;
    tsColores.TabVisible:= False;
    if EstadoDetalle <> tedModificar then
    begin
      QVariedadCampo.Close;
      QVariedadCampo.Open;
    end;
  end;
end;


procedure TFMProductos.QCategoriasNewRecord(DataSet: TDataSet);
begin
  QCategorias.FieldByName('producto_c').AsString := QProductos.FieldByName('producto_p').AsString;
end;

procedure TFMProductos.QCalibresNewRecord(DataSet: TDataSet);
begin
  QCalibres.FieldByName('producto_c').AsString := QProductos.FieldByName('producto_p').AsString;
end;

procedure TFMProductos.QColoresNewRecord(DataSet: TDataSet);
begin
  QColores.FieldByName('producto_c').AsString := QProductos.FieldByName('producto_p').AsString;
end;

procedure TFMProductos.QPaisesNewRecord(DataSet: TDataSet);
begin
  QPaises.FieldByName('producto_psp').AsString := QProductos.FieldByName('producto_p').AsString;
end;

procedure TFMProductos.QVariedadCampoNewRecord(DataSet: TDataSet);
begin
  QVariedadCampo.FieldByName('producto_pv').AsString := QProductos.FieldByName('producto_p').AsString;
end;

procedure TFMProductos.PageControlChange(Sender: TObject);
begin
  if PageControl.ActivePage = tsCategorias then
  begin
    DataSourceDetalle:=DSCategorias;
    RejillaVisualizacion := RCategorias;
    PanelDetalle := PCategorias;
  end
  else
  if PageControl.ActivePage = tsColores then
  begin
    DataSourceDetalle:=DSColores;
    RejillaVisualizacion := RColores;
    PanelDetalle := PColores;
  end
  else
  if PageControl.ActivePage = tsPaises then
  begin
    DataSourceDetalle:=DSPaises;
    RejillaVisualizacion := RPaises;
    PanelDetalle := PPaises;
  end
  else
  if PageControl.ActivePage = tsCalibres then
  begin
    DataSourceDetalle:=DSCalibres;
    RejillaVisualizacion := RCalibres;
    PanelDetalle := PCalibres;
  end
  else
  if PageControl.ActivePage = tsVariedadCampo then
  begin
    DataSourceDetalle:=DSVariedadCampo;
    RejillaVisualizacion := RVariedadCampo;
    PanelDetalle := PVariedadCampo;
  end
  else
  if PageControl.ActivePage = tsCostes then
  begin
    DataSourceDetalle:=dsCostesProducto;
    RejillaVisualizacion := dbgrdCostes;
    PanelDetalle := pnlCostes;
  end;

  ListaDetalle.Clear;
  PanelDetalle.GetTabOrderList(ListaDetalle);

  if PanelDetalle <> pnlCostes then
  begin
      if ( ( EstadoDetalle  = tedConjuntoResultado ) or ( EstadoDetalle  = tedEspera ) )  and ( DataSourceDetalle.DataSet.IsEmpty ) then
      EstadoDetalle := tedNoConjuntoResultado
    else
    if ( ( EstadoDetalle  = tedNoConjuntoResultado ) or ( EstadoDetalle  = tedEspera ) ) and ( not DataSourceDetalle.DataSet.IsEmpty ) then
      EstadoDetalle  :=  tedConjuntoResultado;
    BHGrupoAccionDetalle( Estado, EstadoDetalle );
  end
  else
  begin
    EstadoDetalle  :=  tedEspera;
    BHGrupoAccionDetalle( Estado, EstadoDetalle );
  end;
end;

procedure TFMProductos.QProductosBeforePost(DataSet: TDataSet);
begin
  //QProductos.FieldByName('estomate_p').AsString:= 'N';
  QProductos.FieldByName('tipo_liquida_p').AsString:= 'S';
  QProductos.FieldByName('socio_p').AsInteger:= 1;
  QProductos.FieldByName('tipo_iva_p').AsInteger:= 0;
  QProductos.FieldByName('valorar_entrega_por_kilos_p').AsInteger:= 1;
end;

procedure TFMProductos.qryComercialCalcFields(DataSet: TDataSet);
begin
  qryComercial.FieldByName('des_comercial').AsString:= desComercial(qryComercial.FieldByName('cod_comercial_cc').AsString);
end;

procedure TFMProductos.pais_pspChange(Sender: TObject);
begin
  stPais.Caption:= desPais( pais_psp.Text );
end;

procedure TFMProductos.QProductosAfterScroll(DataSet: TDataSet);
begin
  estomate_pClick( estomate_p );
  eshortaliza_pClick( estomate_p );
end;


procedure TFMProductos.pnlPasarSGPClick(Sender: TObject);
begin
  if not QProductos.IsEmpty and (QProductos.State = dsBrowse) then
  begin
    //Copiar envase en el SGP
    if UComerToSgpDM.PasarProducto( gsDefEmpresa, producto_p.Text ) then
    begin
      ShowMessage('Programa finalizado con éxito.');
    end
    else
    begin
      ShowMessage('Error al pasar al SGP el producto seleccionado.');
    end;
  end;
end;

procedure TFMProductos.DSMaestroDataChange(Sender: TObject;
  Field: TField);
begin
  if not QProductos.IsEmpty and (QProductos.State = dsBrowse) then
  begin
    pnlPasarSGP.Font.Color := clBlue;
  end
  else
  begin
    pnlPasarSGP.Font.Color := clGray;
  end;
end;

procedure TFMProductos.btnCostesClick(Sender: TObject);
begin
  if QProductos.IsEmpty then
    ShowMessage('Seleccione primero un producto.')
  else
  begin
    CostesAgrupaProductoFD.ExecuteCosteProducto( self, gsDefEmpresa, producto_p.Text,
      qryCostesProducto.FieldByName('agrupacion').AsString, qryCostesProducto.FieldByName('centro').AsString );
    qryCostesProducto.close;
    qryCostesProducto.Open;
  end;
end;

procedure TFMProductos.btnProductoComercialClick(Sender: TObject);
begin
  if not QProductos.IsEmpty and (QProductos.State = dsBrowse) then
  begin
    ComercialDesdeProducto(Self, producto_p.Text );
    qryComercial.Close;
    qryComercial.Open;
  end
  else
  begin
    ShowMessage('Seleccione primero un producto');
  end;
end;

procedure TFMProductos.estomate_pClick(Sender: TObject);
begin
  if estomate_p.Checked then
  begin
    estomate_p.Caption:= 'Si es tomate';
  end
  else
  begin
    estomate_p.Caption:= 'No es tomate';
  end;
end;

procedure TFMProductos.eshortaliza_pClick(Sender: TObject);
begin
  if eshortaliza_p.Checked then
  begin
    eshortaliza_p.Caption:= 'Si, es hortaliza';
    estomate_p.Enabled:= True;
  end
  else
  begin
    estomate_p.Enabled:= False;
    estomate_p.Checked:= False;
    eshortaliza_p.Caption:= 'No, es fruta';
  end;
end;

end.


