unit MProductos_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BEdit, BDEdit,
  dbtables, DError, ComCtrls;

type
  TFMProductos_ = class(TMaestroDetalle)
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
    LEmpresa_p: TLabel;
    BGBEmpresa_p: TBGridButton;
    Lproducto_p: TLabel;
    Ldescripcion_p: TLabel;
    empresa_p: TBDEdit;
    STEmpresa_p: TStaticText;
    producto_p: TBDEdit;
    descripcion_p: TBDEdit;
    descripcion2_p: TBDEdit;
    QCalibres: TQuery;
    DSCalibres: TDataSource;
    QCategorias: TQuery;
    DSCategorias: TDataSource;
    lblCalibre: TLabel;
    calibre_c: TBDEdit;
    lblProductoBase: TLabel;
    producto_base_p: TBDEdit;
    txtProductoBase: TStaticText;
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
    tsEjercicios: TTabSheet;
    lblEsTomate: TLabel;
    estomate_p: TDBCheckBox;
    QVariedadCampo: TQuery;
    dsVariedadCampo: TDataSource;
    PVariedadCampo: TPanel;
    Label4: TLabel;
    codigo_pv: TBDEdit;
    descripcion_pv: TBDEdit;
    RVariedadCampo: TDBGrid;
    QEjercicios: TQuery;
    DSEjercicios: TDataSource;
    PEjercicios: TPanel;
    lblEjercicios: TLabel;
    centro_e: TBDEdit;
    ejercicio_e: TBDEdit;
    REjercicios: TDBGrid;
    txtCentro: TStaticText;
    btnCentro: TBGridButton;
    lbl1: TLabel;
    pnlPasarSGP: TPanel;
    lblAleman: TLabel;
    des_aleman_p: TBDEdit;
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
    procedure empresa_pChange(Sender: TObject);
    procedure QCategoriasNewRecord(DataSet: TDataSet);
    procedure QCalibresNewRecord(DataSet: TDataSet);
    procedure QProductosBeforePost(DataSet: TDataSet);
    procedure producto_base_pChange(Sender: TObject);
    procedure descripcion_pChange(Sender: TObject);
    procedure producto_base_pEnter(Sender: TObject);
    procedure QColoresNewRecord(DataSet: TDataSet);
    procedure pais_pspChange(Sender: TObject);
    procedure QPaisesNewRecord(DataSet: TDataSet);
    procedure QProductosAfterScroll(DataSet: TDataSet);
    procedure estomate_pClick(Sender: TObject);
    procedure QVariedadCampoNewRecord(DataSet: TDataSet);
    procedure QEjerciciosNewRecord(DataSet: TDataSet);
    procedure centro_eChange(Sender: TObject);
    procedure pnlPasarSGPClick(Sender: TObject);
    procedure DSMaestroDataChange(Sender: TObject; Field: TField);
    procedure QProductosAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    ListaComponentes, ListaDetalle: TList;
    Objeto: TObject;
    bFlag: Boolean;

    procedure ValidarEntradaMaestro;
    procedure AntesDeBorrarMaestro;
    procedure ValidarEntradaDetalle;
    procedure AntesDeBorrarDetalle;
    procedure AbrirTablas;
    procedure CerrarTablas;

    procedure BorrarActivo;

    procedure GetProductoBDRemota( const ABDRemota: string; const AAlta: Boolean );
    procedure BuscarProducto( const AEmpresa, AProducto: string );
    procedure RefrescarProducto;

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
  ImportarProductosFD, UComerToSgpDM;

{$R *.DFM}

procedure TFMProductos_.AbrirTablas;
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

procedure TFMProductos_.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

procedure TFMProductos_.FormCreate(Sender: TObject);
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
    Add('where empresa_c = :empresa_p ');
    Add('  and producto_c = :producto_p ');
    Add('ORDER BY categoria_c');
  end;

  with QCalibres.SQL do
  begin
    Clear;
    Add('select * from frf_calibres ');
    Add('where empresa_c = :empresa_p ');
    Add('  and producto_c = :producto_p ');
    Add('ORDER BY calibre_c');
  end;

  with QColores do
  begin
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM   frf_colores Frf_color ');
    SQL.Add('WHERE  (empresa_c=:empresa_p) ');
    SQL.Add('AND    (producto_c=:producto_p) ');
    SQL.Add('ORDER BY color_c');
  end;

  with QPaises do
  begin
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM   frf_paises_producto ');
    SQL.Add('WHERE  (empresa_psp=:empresa_p) ');
    SQL.Add('AND    (producto_psp=:producto_p) ');
    SQL.Add('ORDER BY pais_psp');
  end;

  with QVariedadCampo do
  begin
    SQL.Clear;
    SQL.Add(' SELECT empresa_pv,producto_pv,codigo_pv,descripcion_pv ');
    SQL.Add(' FROM   frf_productos_variedad ');
    SQL.Add(' WHERE  (empresa_pv=:empresa_p) ');
    SQL.Add(' AND    (producto_pv=:producto_p) ');
    SQL.Add(' ORDER BY codigo_pv ');
  end;

  with QEjercicios do
  begin
    SQL.Clear;
    SQL.Add(' SELECT empresa_e, producto_e, centro_e, ejercicio_e ');
    SQL.Add(' FROM frf_ejercicios Frf_ejercicios ');
    SQL.Add(' WHERE   (empresa_e =:empresa_p)    ');
    SQL.Add('    AND  (producto_e =:producto_p) ');
    SQL.Add(' ORDER BY empresa_e, producto_e, centro_e, ejercicio_e ');
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
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;
  OnBrowse:= AntesDeLocalizar;

  //Preparar panel de detalle
  OnViewDetail:=VerDetalle;
  OnEditDetail:=EditarDetalle;

     //Focos
  {+}FocoAltas := empresa_p;
  {+}FocoModificar := descripcion_p;
  {+}FocoLocalizar := empresa_p;

  empresa_p.Tag:= kEmpresa;
  producto_base_p.Tag:= kProductoBase;
  pais_psp.Tag:= kPais;
  centro_e.Tag:= kCentro;
  bFlag:= False;

  pnlPasarSGP.Visible:= DMConfig.EsLosLLanos or DMConfig.EsLaFontEx;
end;

procedure TFMProductos_.FormActivate(Sender: TObject);
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

procedure TFMProductos_.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF :=nil;
end;


procedure TFMProductos_.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMProductos_.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMProductos_.Filtro;
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

procedure TFMProductos_.AnyadirRegistro;
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

procedure TFMProductos_.Altas;
var
  iTipo: Integer;
  sBD: string;
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

procedure TFMProductos_.Modificar;
var
  iTipo: Integer;
  sBD: string;
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

procedure TFMProductos_.GetProductoBDRemota( const ABDRemota: string; const AAlta: Boolean );
var
  sEmpresa, sProducto: string;
  iValue: Integer;
  bAlta: Boolean;
begin
  sEmpresa:= empresa_p.Text;
  if AAlta then
    sProducto:= ''
  else
    sProducto:= producto_p.Text;
  bAlta:= AAlta;

  iValue:= ImportarProducto( Self, ABDRemota, sEmpresa, sProducto, bAlta );
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

procedure TFMProductos_.BuscarProducto( const AEmpresa, AProducto: string );
begin
 {+}Select := ' SELECT * FROM frf_productos ';
 {+}where := ' WHERE empresa_p=' + QuotedStr(AEmpresa) +
             ' and producto_p=' + QuotedStr(AProducto);
 {+}Order := ' ORDER BY empresa_p, producto_p ';

 QProductos.Close;
 AbrirTablas;
 Visualizar;
end;

procedure TFMProductos_.RefrescarProducto;
var
  myBookMark: TBookmark;
begin
  myBookMark:= QProductos.GetBookmark;
  QProductos.Close;
  QProductos.Open;
  QProductos.GotoBookmark(myBookMark);
  QProductos.FreeBookmark(myBookMark);
end;


procedure TFMProductos_.DetalleModificar;
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

procedure TFMProductos_.DetalleAltas;
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

procedure TFMProductos_.ValidarEntradaMaestro;
begin
  //Empresa
  if STEmpresa_p.Caption = '' then
    raise Exception.Create('Falta el código de la empresa o es incorrecto.');
  if producto_base_p.Text = '' then
    raise Exception.Create('Falta el código del producto base.');
  if producto_p.Text = '' then
    raise Exception.Create('Falta el código del producto.');
  if descripcion_p.Text = '' then
    raise Exception.Create('Falta la descripción del producto.');
  if estomate_p.State = cbGrayed then
    raise Exception.Create('Por favor marque si el producto es tomate o no.');

  if QProductos.State = dsInsert then
  begin
  //Comprobar que no este dado de alta el producto
    with DMBaseDatos.QGeneral do
    begin
      SQL.Clear;
      if Pos('F', empresa_p.Text ) = 1 then
      begin
        SQL.Add(' select * from frf_productos where substr(empresa_p,1,1) = ''F'' and producto_p = :producto');
      end
      else
      if ( empresa_p.Text = '050') or ( empresa_p.Text = '080' ) then
      begin
        SQL.Add('select * from frf_productos where empresa_p in(''080'',''050'') and producto_p = :producto');
      end
      else
      begin
        SQL.Add('select *  from frf_productos where empresa_p = :empresa and producto_p = :producto');
        ParamByName('empresa').AsString:= empresa_p.Text;
      end;
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


procedure TFMProductos_.Borrar;
var botonPulsado: Word;
begin
     //Barra estado
  Estado := teBorrar;
  EstadoDetalle := tedOperacionMaestro;
  BEEstado;
  BHEstado;

     //preguntar si realmente queremos borrar
  botonPulsado := mrNo;
  if application.MessageBox('Esta usted seguro de querer borrar la cabecera con todas sus lineas?',
    '  ATENCIÓN !', MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2) = IDOK then
    botonPulsado := mrYes;

  if botonPulsado = mrYes then
    BorrarActivo;
     //Por ultimo visualizamos resultado
  Visualizar;
end;

procedure TFMProductos_.BorrarActivo;
var
  sEmpresa, sProductoBase: string;
begin
  //Borrar detalle

  QCategorias.First;
  while not QCategorias.Eof do
  begin
    QCategorias.Delete;
  end;

  QCalibres.First;
  while not QCalibres.Eof do
  begin
    QCalibres.Delete;
  end;

  QColores.First;
  while not QColores.Eof do
  begin
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

  QEjercicios.First;
  while not QEjercicios.Eof do
  begin
    QEjercicios.Delete;
  end;

  sEmpresa:= empresa_p.Text;
  sProductoBase:= producto_base_p.Text;

  QProductos.Delete;

  with DMBaseDatos.QGeneral do
  begin
    SQL.Clear;
    SQL.Add('delete from frf_productos_base where empresa_pb = :empresa and producto_base_pb = :producto_base ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('producto_base').AsString:= sProductoBase;
    ExecSql;
  end;
end;


procedure TFMProductos_.ValidarEntradaDetalle;
begin
(*
  if ( QProductos.State = dsInsert ) or ( QProductos.State = dsEdit ) then
  begin
    if peso_paleta_pp.Text = '' then
      QProductos.FieldByName('peso_paleta_pp').AsInteger:=  0;
    if peso_cajas_pp.Text = '' then
      QProductos.FieldByName('peso_cajas_pp').AsInteger:=  0;
    if cajas_paleta_pp.Text = '' then
      QProductos.FieldByName('cajas_paleta_pp').AsInteger:=  0;
    if unidades_caja_pp.Text = '' then
      QProductos.FieldByName('unidades_caja_pp').AsInteger:=  0;
  end;
*)
end;

procedure TFMProductos_.AntesDeBorrarMaestro;
begin

(*
  if ( not QAlmacenes.IsEmpty ) or ( not QProductos.IsEmpty ) then
  begin
    raise Exception.Create('No se puede borrar la proveedor, primero borre el detalle.');
  end;
*)
end;

procedure TFMProductos_.AntesDeBorrarDetalle;
begin
(*
  if PageControl.ActivePage = tsProductos then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_entregas_l ');
    SQL.Add(' where empresa_el = :empresa ');
    SQL.Add(' and proveedor_el = :proveedor ');
    SQL.Add(' and producto_el = :producto ');
    SQL.Add(' and variedad_el = :variedad ');
    ParamByName('empresa').AsString:= empresa_p.Text;
    ParamByName('proveedor').AsString:= proveedor_p.Text;
    ParamByName('producto').AsString:= producto_pp.Text;
    ParamByName('variedad').AsString:= variedad_pp.Text;
    Open;
    if not IsEmpty then
    begin
      Close;
      raise Exception.Create('No se puede borrar la variedad, ya esta utilizada en las entregas del proveedor.');
    end;
    Close;

    SQL.Clear;
    SQL.Add(' select * from rf_palet_pb ');
    SQL.Add(' where empresa = :empresa ');
    SQL.Add(' and proveedor = :proveedor ');
    SQL.Add(' and producto = :producto ');
    SQL.Add(' and variedad = :variedad ');
    ParamByName('empresa').AsString:= empresa_p.Text;
    ParamByName('proveedor').AsString:= proveedor_p.Text;
    ParamByName('producto').AsString:= producto_pp.Text;
    ParamByName('variedad').AsString:= variedad_pp.Text;
    Open;
    if not IsEmpty then
    begin
      Close;
      raise Exception.Create('No se puede borrar la variedad, ya esta utilizada en la RF.');

    end;
    Close;
  end;
*)
end;

procedure TFMProductos_.Previsualizar;
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
  QRLProducto.EjercicioDataSet:= QEjercicios;

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

procedure TFMProductos_.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa_p);
    kPais: DespliegaRejilla(btnpais);
    kCentro: DespliegaRejilla(btnCentro,[empresa_p.Text]);
  end;
end;

procedure TFMProductos_.AntesDeInsertar;
begin
  (*
  if not DMConfig.EsLaFont then
  begin
    ShowMessage('Antes de dar de alta un nuevo proveedor, recuerde darlo de alta antes en la central.');
  end;
  *)
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMProductos_.AntesDeModificar;
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

procedure TFMProductos_.AntesDeVisualizar;
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

procedure TFMProductos_.AntesDeLocalizar;
begin
  //
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMProductos_.RequiredTime(Sender: TObject; var isTime: Boolean);
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

procedure TFMProductos_.QProductosAfterOpen(DataSet: TDataSet);
begin
  QCalibres.Open;
  QCategorias.Open;
  QColores.Open;
  QPaises.Open;
  QEjercicios.Open;
  QVariedadCampo.Open;
end;

procedure TFMProductos_.QProductosBeforeClose(DataSet: TDataSet);
begin
  QCalibres.Close;
  QCategorias.Close;
  QColores.Close;
  QPaises.Close;
  QEjercicios.Close;
  QVariedadCampo.Close;
end;

procedure TFMProductos_.VerDetalle;
begin
  PanelDetalle.Enabled:= false;
  PanelDetalle.Visible:= false;
  tsCategorias.TabVisible:= True;
  tsCalibres.TabVisible:= True;
  tsColores.TabVisible:= True;
  tsPaises.TabVisible:= True;
  tsEjercicios.TabVisible:= True;
  tsVariedadCampo.TabVisible:= True;
end;

procedure TFMProductos_.EditarDetalle;
begin
  PanelDetalle.Enabled:= TRUE;
  PanelDetalle.Visible:= True;
  if PageControl.ActivePage = tsCategorias then
  begin
    FocoDetalle:=categoria_c;
    tsPaises.TabVisible:= False;
    tsCalibres.TabVisible:= False;
    tsColores.TabVisible:= False;
    tsEjercicios.TabVisible:= False;
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
    tsEjercicios.TabVisible:= False;
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
    tsEjercicios.TabVisible:= False;
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
    tsEjercicios.TabVisible:= False;
    tsVariedadCampo.TabVisible:= False;
    tsColores.TabVisible:= False;
    if EstadoDetalle <> tedModificar then
    begin
      QPaises.Close;
      QPaises.Open;
    end;
  end
  else
  if PageControl.ActivePage = tsEjercicios then
  begin
    FocoDetalle:=centro_e;
    tsCategorias.TabVisible:= False;
    tsCalibres.TabVisible:= False;
    tsPaises.TabVisible:= False;
    tsVariedadCampo.TabVisible:= False;
    tsColores.TabVisible:= False;
    if EstadoDetalle <> tedModificar then
    begin
      QEjercicios.Close;
      QEjercicios.Open;
    end;
  end
  else
  if PageControl.ActivePage = tsVariedadCampo then
  begin
    FocoDetalle:=codigo_pv;
    tsCategorias.TabVisible:= False;
    tsCalibres.TabVisible:= False;
    tsEjercicios.TabVisible:= False;
    tsPaises.TabVisible:= False;
    tsColores.TabVisible:= False;
    if EstadoDetalle <> tedModificar then
    begin
      QVariedadCampo.Close;
      QVariedadCampo.Open;
    end;
  end;
end;


procedure TFMProductos_.QCategoriasNewRecord(DataSet: TDataSet);
begin
  QCategorias.FieldByName('empresa_c').AsString := QProductos.FieldByName('empresa_p').AsString;
  QCategorias.FieldByName('producto_c').AsString := QProductos.FieldByName('producto_p').AsString;
end;

procedure TFMProductos_.QCalibresNewRecord(DataSet: TDataSet);
begin
  QCalibres.FieldByName('empresa_c').AsString := QProductos.FieldByName('empresa_p').AsString;
  QCalibres.FieldByName('producto_c').AsString := QProductos.FieldByName('producto_p').AsString;
end;

procedure TFMProductos_.QColoresNewRecord(DataSet: TDataSet);
begin
  QColores.FieldByName('empresa_c').AsString := QProductos.FieldByName('empresa_p').AsString;
  QColores.FieldByName('producto_c').AsString := QProductos.FieldByName('producto_p').AsString;
end;

procedure TFMProductos_.QPaisesNewRecord(DataSet: TDataSet);
begin
  QPaises.FieldByName('empresa_psp').AsString := QProductos.FieldByName('empresa_p').AsString;
  QPaises.FieldByName('producto_psp').AsString := QProductos.FieldByName('producto_p').AsString;
end;

procedure TFMProductos_.QVariedadCampoNewRecord(DataSet: TDataSet);
begin
  QVariedadCampo.FieldByName('empresa_pv').AsString := QProductos.FieldByName('empresa_p').AsString;
  QVariedadCampo.FieldByName('producto_pv').AsString := QProductos.FieldByName('producto_p').AsString;
end;

procedure TFMProductos_.QEjerciciosNewRecord(DataSet: TDataSet);
begin
  QEjercicios.FieldByName('empresa_e').AsString := QProductos.FieldByName('empresa_p').AsString;
  QEjercicios.FieldByName('producto_e').AsString := QProductos.FieldByName('producto_p').AsString;
end;

procedure TFMProductos_.PageControlChange(Sender: TObject);
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
  if PageControl.ActivePage = tsEjercicios then
  begin
    DataSourceDetalle:=DSEjercicios;
    RejillaVisualizacion := REjercicios;
    PanelDetalle := PEjercicios;
  end
  else
  if PageControl.ActivePage = tsVariedadCampo then
  begin
    DataSourceDetalle:=DSVariedadCampo;
    RejillaVisualizacion := RVariedadCampo;
    PanelDetalle := PVariedadCampo;
  end;
  ListaDetalle.Clear;
  PanelDetalle.GetTabOrderList(ListaDetalle);

  if ( EstadoDetalle  = tedConjuntoResultado ) and ( DataSourceDetalle.DataSet.IsEmpty ) then
    EstadoDetalle := tedNoConjuntoResultado
  else
  if ( EstadoDetalle  = tedNoConjuntoResultado ) and ( not DataSourceDetalle.DataSet.IsEmpty ) then
    EstadoDetalle  :=  tedConjuntoResultado;
  BHGrupoAccionDetalle( Estado, EstadoDetalle );
end;

procedure TFMProductos_.empresa_pChange(Sender: TObject);
begin
  STEmpresa_p.Caption:= desEmpresa( empresa_p.Text );
  producto_base_pChange( producto_base_p );
end;

procedure TFMProductos_.QProductosBeforePost(DataSet: TDataSet);
var
  bAux: Boolean;
begin
  //QProductos.FieldByName('estomate_p').AsString:= 'N';
  QProductos.FieldByName('tipo_liquida_p').AsString:= 'S';
  QProductos.FieldByName('socio_p').AsInteger:= 1;
  QProductos.FieldByName('tipo_iva_p').AsInteger:= 0;
  QProductos.FieldByName('valorar_entrega_por_kilos_p').AsInteger:= 1;

  //Comprobar producto base
  with DMBaseDatos.QGeneral do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_productos_base where empresa_pb = :empresa and producto_base_pb = :producto_base ');
    ParamByName('empresa').AsString:= empresa_p.Text;
    ParamByName('producto_base').AsString:= producto_base_p.Text;
    bAux:= RequestLive;
    RequestLive:= True;
    Open;
    if IsEmpty then
    begin
      //Dar de alta producto bse
      Insert;
      FieldByName('empresa_pb').AsString:= empresa_p.Text;
      FieldByName('producto_base_pb').AsString:= producto_base_p.Text;
      //FieldByName('producto_pb').AsString:= producto_p.Text;
      FieldByName('agrupacion_pb').AsString:= '';
      FieldByName('descripcion_pb').AsString:= descripcion_p.Text;
      FieldByName('descripcion2_pb').AsString:= descripcion2_p.Text;
      FieldByName('estomate_pb').AsString:= 'N';
      Post;
    end;
    Close;
    RequestLive:= bAux;
  end;
end;

procedure TFMProductos_.QProductosAfterPost(DataSet: TDataSet);
var
  bAux: Boolean;
begin
  with DMBaseDatos.QGeneral do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_productos_base where empresa_pb = :empresa and producto_base_pb = :producto_base and producto_pb is null');
    ParamByName('empresa').AsString:= empresa_p.Text;
    ParamByName('producto_base').AsString:= producto_base_p.Text;
    bAux:= RequestLive;
    RequestLive:= True;
    Open;
    if not IsEmpty then
    begin
      //Dar de alta producto bse
      Edit;
      FieldByName('producto_pb').AsString:= producto_p.Text;
      Post;
    end;
    Close;
    RequestLive:= bAux;
  end;
end;

procedure TFMProductos_.producto_base_pChange(Sender: TObject);
begin
  txtProductoBase.Caption:= desProductoBase( empresa_p.Text, producto_base_p.Text );
  bFlag:= txtProductoBase.Caption <> '';
  descripcion_pChange( descripcion_p );
end;

procedure TFMProductos_.descripcion_pChange(Sender: TObject);
begin
  if not bFlag then
  begin
    txtProductoBase.Caption:= descripcion_p.Text;
  end;
end;

procedure TFMProductos_.producto_base_pEnter(Sender: TObject);
begin
  if ( Estado = teAlta ) and ( producto_base_p.Text = '') then
  begin
    with DMBaseDatos.QGeneral do
    begin
      SQL.Clear;
      if Pos('F', empresa_p.Text ) = 1 then
      begin
        SQL.Add('select nvl(max(producto_base_pb),0) producto_base from frf_productos_base where substr(empresa_pb,1,1) = ''F'' ');
      end
      else
      if ( empresa_p.Text = '050') or ( empresa_p.Text = '080' ) then
      begin
        SQL.Add('select nvl(max(producto_base_pb),0) producto_base from frf_productos_base where empresa_pb in(''080'',''050'') ');
      end
      else
      begin
        SQL.Add('select nvl(max(producto_base_pb),0) producto_base from frf_productos_base where empresa_pb = :empresa ');
        ParamByName('empresa').AsString:= empresa_p.Text;
      end;
      Open;
      producto_base_p.Text:= IntToStr( FieldByName('producto_base').AsInteger + 1 );
      Close;
    end;
  end;
end;

procedure TFMProductos_.pais_pspChange(Sender: TObject);
begin
  stPais.Caption:= desPais( pais_psp.Text );
end;

procedure TFMProductos_.QProductosAfterScroll(DataSet: TDataSet);
begin
  estomate_pClick( estomate_p );
end;

procedure TFMProductos_.estomate_pClick(Sender: TObject);
begin
  if estomate_p.Checked then
    estomate_p.Caption:= 'SI'
  else
    estomate_p.Caption:= 'NO';
end;


procedure TFMProductos_.centro_eChange(Sender: TObject);
begin
  txtCentro.Caption:= desCentro( empresa_p.Text, centro_e.Text );
end;

procedure TFMProductos_.pnlPasarSGPClick(Sender: TObject);
begin
  if not QProductos.IsEmpty and (QProductos.State = dsBrowse) then
  begin
    //Copiar envase en el SGP
    if UComerToSgpDM.PasarProducto( empresa_p.Text, producto_p.Text ) then
    begin
      ShowMessage('Programa finalizado con éxito.');
    end
    else
    begin
      ShowMessage('Error al pasar al SGP el producto seleccionado.');
    end;
  end;
end;

procedure TFMProductos_.DSMaestroDataChange(Sender: TObject;
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

end.


