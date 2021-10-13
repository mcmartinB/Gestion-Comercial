
unit MEnvases;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, BDEdit,
  Db, ExtCtrls, StdCtrls, DBCtrls, CMaestro, ComCtrls,
  BEdit, DError, ActnList, Graphics, DBTables, Grids, DBGrids, BGrid,
  Buttons, BSpeedButton, BGridButton, jpeg;

type
  TFMEnvases = class(TMaestro)
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    ACampos: TAction;
    QEnvases: TQuery;
    PMaestro: TPanel;
    LEnvase_e: TLabel;
    LPeso_envase_e: TLabel;
    LDescripcion_e: TLabel;
    lblPeso: TLabel;
    lblNombre1: TLabel;
    lblNombre3: TLabel;
    lblNombre4: TLabel;
    lblNombre5: TLabel;
    lblNombre6: TLabel;
    BGBEmpresa_e: TBGridButton;
    lblNombre7: TLabel;
    BGBproducto_base_e: TBGridButton;
    lblNombre8: TLabel;
    lblNombre9: TLabel;
    lblEan13: TLabel;
    btnEan13_e: TBGridButton;
    cbxComercial: TComboBox;
    GroupBox1: TGroupBox;
    lblNombre10: TLabel;
    lblNombre11: TLabel;
    BGBtipo_unidad_e: TBGridButton;
    unidades_e: TBDEdit;
    tipo_unidad_e: TBDEdit;
    STTipo_unidad_e: TStaticText;
    envase_e: TBDEdit;
    peso_envase_e: TBDEdit;
    descripcion_e: TBDEdit;
    peso_neto_e: TBDEdit;
    agrupacion_e: TBDEdit;
    envase_comercial_e: TDBCheckBox;
    notas_e: TDBMemo;
    GroupBox2: TGroupBox;
    descripcion2_e: TBDEdit;
    empresa_e: TBDEdit;
    producto_base_e: TBDEdit;
    STEmpresa_e: TStaticText;
    RejillaFlotante: TBGrid;
    fecha_baja_e: TBDEdit;
    cbxVer: TComboBox;
    peso_variable_e: TDBCheckBox;
    ean13_e: TBDEdit;
    QEnvasesCliente: TQuery;
    lbl1: TLabel;
    precio_diario_e: TDBCheckBox;
    lblTipIva: TLabel;
    tipo_iva_e: TDBComboBox;
    lblDesTipoIva: TLabel;
    btnAgrupacion: TBGridButton;
    qryDesCliente: TQuery;
    dsDesCliente: TDataSource;
    qrySecContable: TQuery;
    dsSecContable: TDataSource;
    pgcDetalle: TPageControl;
    tsDescripcionCliente: TTabSheet;
    btnEnvaseCliente: TPanel;
    dbgDesCliente: TDBGrid;
    tsSeccionContable: TTabSheet;
    tsImagen: TTabSheet;
    Image: TImage;
    bvl1: TBevel;
    pnlSeccionContable: TPanel;
    dbgSeccionContable: TDBGrid;
    lbl2: TLabel;
    env_comer_operador_e: TBDEdit;
    btnEnvComerOperador: TBGridButton;
    txtOperador: TStaticText;
    txt_env_comer: TStaticText;
    btnEnvComerProducto: TBGridButton;
    env_comer_producto_e: TBDEdit;
    lblEnvase: TLabel;
    des_producto_base_e: TStaticText;
    lbl3: TLabel;
    linea_producto_e: TBDEdit;
    btnLinea_producto_e: TBGridButton;
    des_linea_producto_e: TStaticText;
    unidades_variable_e: TDBCheckBox;
    tsEcoembes: TTabSheet;
    pnlEcoembes: TPanel;
    dbgrdEcoembes: TDBGrid;
    qryEcoembes: TQuery;
    dsEcoembes: TDataSource;
    lblTipoEnvase: TLabel;
    tipo_e: TDBComboBox;
    lblDesTipoEnvase: TLabel;
    lblAgrupaComer: TLabel;
    agrupa_comercial_e: TBDEdit;
    btnAgrupaComer: TBGridButton;
    lblTipoCaja: TLabel;
    tipo_caja_e: TBDEdit;
    btnTipoCaja: TBGridButton;
    des_tipo_caja: TStaticText;
    lblMaster_c: TLabel;
    master_e: TBDEdit;
    txtMaster_c: TStaticText;
    QEan13: TQuery;
    DSEan13: TDataSource;
    tsEan13: TTabSheet;
    dbgEan13: TDBGrid;
    pnlPasarSGP: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject;
      var isTime: Boolean);
    procedure envase_comercial_eEnter(Sender: TObject);
    procedure envase_comercial_eExit(Sender: TObject);
    procedure notas_eEnter(Sender: TObject);
    procedure notas_eExit(Sender: TObject);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure producto_base_eChange(Sender: TObject);
    procedure EnvaseClienteClick(Sender: TObject);
    procedure DSMaestroDataChange(Sender: TObject; Field: TField);
    procedure FormDeactivate(Sender: TObject);
    procedure envase_eExit(Sender: TObject);
    procedure descripcion_eEnter(Sender: TObject);
    procedure QEnvasesAfterPost(DataSet: TDataSet);

    procedure QEnvasesAfterOpen(DataSet: TDataSet);
    procedure QEnvasesBeforeClose(DataSet: TDataSet);
    procedure pnlSeccionContableClick(Sender: TObject);
    procedure linea_producto_eChange(Sender: TObject);
    procedure pnlEcoembesClick(Sender: TObject);
    procedure tipo_eChange(Sender: TObject);
    procedure pnlPasarSGPClick(Sender: TObject);

    //procedure ACamposExecute(Sender: TObject);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure AntesDeBorrarMaestro;

    procedure AbrirTablas;
    procedure CerrarTablas;
    procedure BuscarEnvase( const AEmpresa, AProducto, AEnvase: string );
    procedure RefrescarEnvase;
    function  AbrirConexion: Boolean;
    procedure CerrarConexion;
    procedure GetEnvaseBDRemota( const ABDRemota: string; const AAlta: Boolean );


    procedure Changetipo_e;
    procedure Changetipo_iva_e;
  public
    { Public declarations }
    procedure Altas; override;
    procedure Modificar; override;
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeModificar;
    procedure AntesDeInsertar;
    procedure AntesDeVisualizar;
    procedure AntesDeLocalizar;

    //Listado
    procedure Previsualizar; override;
    procedure PreviewListado( const AVerClientes: Boolean );
    procedure PreviewFicha;
  end;

//var
  //FMEnvases: TFMEnvases;

implementation

uses Variants, CVariables, CGestionPrincipal, UDMBaseDatos, CAuxiliarDB, Principal,
  LEnvases, DPreview, UDMAuxDB, bSQLUtils, CReportes, bDialogs, CliEnvases,
  UDMconfig, EnvSeccionesContables, EcoembesEnvasesFD, ImportarEnvasesFD,
  AdvertenciaFD, SeleccionarTipoAltaFD, FichaListadoFD, EnvasesDL, UFEnvases,
  UComerToSgpDM, CGlobal;

{$R *.DFM}


procedure TFMEnvases.BuscarEnvase( const AEmpresa, AProducto, AEnvase: string );
begin
 {+}Select := ' SELECT * FROM frf_envases ';
 if AProducto <> '' then
   {+}where := ' WHERE empresa_e=' + QuotedStr(AEmpresa) +
               ' and envase_e=' + QuotedStr(AEnvase) +
               ' and producto_base_e=' + AProducto
 else
   {+}where := ' WHERE empresa_e=' + QuotedStr(AEmpresa) +
               ' and envase_e=' + QuotedStr(AEnvase);
 {+}Order := ' ORDER BY empresa_e, producto_base_e, envase_e ';

 QEnvases.Close;
 AbrirTablas;
 Visualizar;
end;

procedure TFMEnvases.RefrescarEnvase;
var
  myBookMark: TBookmark;
begin
  myBookMark:= QEnvases.GetBookmark;
  QEnvases.Close;
  QEnvases.Open;
  QEnvases.GotoBookmark(myBookMark);
  QEnvases.FreeBookmark(myBookMark);
end;

procedure TFMEnvases.AbrirTablas;
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

  with qryDesCliente do
  begin
    SQL.Clear;
    SQL.Add(' select cliente_ce || '' - '' || nombre_c cliente, unidad_fac_ce unidad, descripcion_ce descripcion, ');
    SQL.Add('        caducidad_cliente_ce caducidad, min_vida_cliente_ce min_vida, max_vida_cliente_ce max_vida ');
    SQL.Add(' from frf_clientes_env join frf_clientes on empresa_ce = empresa_C and cliente_ce = cliente_c ');
    SQL.Add(' where empresa_ce = :empresa_e ');
    SQL.Add(' and envase_ce = :envase_e ');
  end;

  with qrySecContable do
  begin
    SQL.Clear;
    SQL.Add(' select centro_esc centro, seccion_esc seccion, descripcion_sc descripcion ');
    SQL.Add(' from frf_env_sec_contables, frf_secciones_contables ');
    SQL.Add(' where empresa_esc = :empresa_e ');
    SQL.Add(' and envase_esc = :envase_e ');
    SQL.Add(' and empresa_sc = :empresa_e ');
    SQL.Add(' and seccion_esc = seccion_sc ');
  end;

  with qryEcoembes do
  begin
    SQL.Clear;
    SQL.Add(' select fecha_ini_eco fecha_ini, case when ecoembes_eco = 0 then ''No'' else ''SI'' end ecoembes, importe_eco importe ');
    SQL.Add(' from frf_ecoembes ');
    SQL.Add(' where empresa_eco = :empresa_e ');
    SQL.Add(' and envase_eco = :envase_e ');
    SQL.Add(' and producto_base_eco = :producto_base_e ');
    SQL.Add(' order by fecha_ini_eco ');
  end;
end;

procedure TFMEnvases.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMEnvases.FormCreate(Sender: TObject);

begin
  MultiplesAltas:= false;
     //Variables globales
  M := Self;
  MD := nil;

     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

  Ean13_e.Visible:= True;
  lblEan13.Visible:= True;
  btnEan13_e.Visible:= True;
  ean13_e.DataSource:= DSMaestro;

     //***************************************************************
     //Fuente de datos maestro
     //CAMBIAR POR LA QUERY QUE LE TOQUE
 {+}DataSetMaestro := QEnvases;
     //***************************************************************

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_envases ';
 {+}where := ' WHERE envase_e=' + QuotedStr('###');
 {+}Order := ' ORDER BY empresa_e, producto_base_e, envase_e ';
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

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Visualizar estado inicial
  Visualizar;

  empresa_e.Tag := kEmpresa;
  producto_base_e.Tag := kProductobase;
  tipo_unidad_e.Tag := kTipoUnidad;
  ean13_e.Tag := kEan13Envase;
  agrupacion_e.Tag:= kAgrupacionEnvase;
  env_comer_operador_e.Tag := kEnvComerOperador;
  env_comer_producto_e.Tag := kEnvComerProducto;
  linea_producto_e.Tag:= kLineaProducto;
  agrupa_comercial_e.Tag:= kAgrupacionComercial;
  tipo_caja_e.Tag := kTipoCaja;
  master_e.Tag := kEnvase;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnBeforeMasterDelete := AntesDeBorrarMaestro;
  OnEdit := AntesDeModificar;
  OnInsert := AntesDeInsertar;
  OnView := AntesDeVisualizar;
  OnBrowse := AntesDeLocalizar;

     //Focos
  FocoAltas := empresa_e;
  FocoModificar := descripcion_e;
  FocoLocalizar := empresa_e;

     //Lista de componentes
  Lista := TList.Create;
  PMaestro.GetTabOrderList(Lista);

  QEnvasesCliente.SQL.Clear;
  QEnvasesCliente.SQL.Add(' select cliente_ce, unidad_fac_ce, descripcion_ce, n_palets_ce, kgs_palet_ce ');
  QEnvasesCliente.SQL.Add(' from frf_clientes_env ');
  QEnvasesCliente.SQL.Add(' where empresa_ce = :empresa_e ');
  QEnvasesCliente.SQL.Add(' and producto_base_ce = :producto_base_e ');
  QEnvasesCliente.SQL.Add(' and envase_ce = :envase_e ');

  with QEan13.SQL do
  begin
    Clear;
    Add('select distinct codigo_e, descripcion_e');
    Add('from frf_ean13');
    Add('where empresa_e = :empresa_e');
    Add('and envase_E = :envase_E');
    Add('and producto_e = :producto_base_e');
    Add('and agrupacion_e = 2');
    Add('and fecha_baja_E is null');
    Add('order by 1');
  end;

  pgcDetalle.Enabled:= True;
  pgcDetalle.ActivePage:= tsDescripcionCliente;
  tsSeccionContable.TabVisible:= DMConfig.EsLaFont;
  btnEnvaseCliente.Enabled:= DMConfig.EsLaFont;
  if btnEnvaseCliente.Enabled then
  begin
    btnEnvaseCliente.Font.Color:= clBlue;
  end
  else
  begin
    btnEnvaseCliente.Font.Color:= clSilver;
  end;
  tipo_e.itemindex:= 0;
  if CGlobal.gProgramVersion = CGlobal.pvBAG then
    pnlPasarSGP.Visible:= False
  else
    pnlPasarSGP.Visible:= DMConfig.EsLosLLanos or DMConfig.EsLaFontEx;
end;

procedure TFMEnvases.FormActivate(Sender: TObject);
begin
  Top := 1;
  if not DataSetMaestro.Active then Exit;
     //Variables globales
  M := Self;
  MD := nil;

  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
//     gCF:=CalendarioFlotante;


     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;

procedure TFMEnvases.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CerrarConexion;
  Lista.Free;

  gRF := nil;
  gCF := nil;

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

procedure TFMEnvases.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
           //No hacemos nada
      Exit;

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

procedure TFMEnvases.Filtro;
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
        if name <> 'descripcion_pb' then
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

  if cbxVer.ItemIndex <> 0 then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    if cbxVer.ItemIndex = 1 then
      where := where + ' fecha_baja_e is null'
    else
      where := where + ' fecha_baja_e is not null';
  end;

  if tipo_iva_e.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    where := where + ' tipo_iva_e = ' + tipo_iva_e.Text;
  end;

  if tipo_e.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    where := where + ' tipo_e = ' + Copy(tipo_e.Text,1,1);
  end;

  if cbxComercial.ItemIndex <> 0 then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    if cbxComercial.ItemIndex = 1 then
      where := where + ' envase_comercial_e = ''S'''
    else
      where := where + ' envase_comercial_e = ''N''';
  end;

  if peso_variable_e.State <> cbGrayed then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    if peso_variable_e.Checked  then
      where := where + ' peso_variable_e <> 0'
    else
      where := where + ' peso_variable_e = 0';
  end;

  if unidades_variable_e.State <> cbGrayed then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    if unidades_variable_e.Checked  then
      where := where + ' unidades_variable_e <> 0'
    else
      where := where + ' unidades_variable_e = 0';
  end;

  if precio_diario_e.State <> cbGrayed then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    if precio_diario_e.Checked  then
      where := where + ' precio_diario_e <> 0'
    else
      where := where + ' precio_diario_e = 0';
  end;

  if flag then where := ' WHERE ' + where;
end;

//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que son insertados
//para, else fin usa los campos que marcamos como PrimaryKey

procedure TFMEnvases.AnyadirRegistro;
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


procedure TFMEnvases.AntesDeBorrarMaestro;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add(' and envase_sl = :envase ');
    ParamByName('empresa').AsString:= empresa_e.Text;
    ParamByName('envase').AsString:= envase_e.Text;
    Open;
    if not IsEmpty then
    begin
      Close;
      raise Exception.Create('No se puede borrar el envase, ya se han realizado ventas.');
    end;
    Close;
  end;

  if ( not qryDesCliente.IsEmpty ) or ( not qrySecContable.IsEmpty ) or
     ( not qryEcoembes.IsEmpty ) or ( not QEan13.IsEmpty ) then
  begin
    raise Exception.Create('No se puede borrar el envase, primero borre el detalle.');
  end;

end;



procedure TFMEnvases.ValidarEntradaMaestro;
var
  i: Integer;
  sAux: string;
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
  if ean13_e.Text = ''  then
    DSMaestro.DataSet.FieldByName('ean13_e').Value:= NULL;

  if agrupacion_e.Text = '' then
  begin
     if agrupacion_e.CanFocus then
       agrupacion_e.SetFocus;
     raise Exception.Create('Es necesario introducir una agrupación.');
  end;

  if agrupa_comercial_e.Text = '' then
  begin
     if agrupa_comercial_e.CanFocus then
       agrupa_comercial_e.SetFocus;
     raise Exception.Create('Es necesario introducir una agrupación comercial.');
  end;

  (*BAG*)
  //Buscar si esta grabado
  sAux:= '';
  if ( Estado = teAlta ) and ( Copy( Trim( empresa_e.Text ),1,1) = 'F' )then
  begin
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add(' select first 1 * ');
      SQL.Add(' from frf_envases ');
      SQL.Add(' where empresa_e = ' + QuotedStr( Trim( empresa_e.Text ) ) );
      SQL.Add(' and envase_e = ' + QuotedStr( Trim( envase_e.Text ) ) );
      SQL.Add(' and producto_base_e = ' + Trim( producto_base_e.Text ) );
      Open;
      if not IsEmpty then
      begin
        sAux:= 'Envase duplicado. (' + Trim( empresa_e.Text ) + '-' + QuotedStr( Trim( envase_e.Text ) ) + '-' + Trim( des_producto_base_e.Caption ) + '-' + Trim( descripcion_e.Text )  + ').';
        Close;
        raise Exception.Create( sAux );
      end;
      Close;

      sAux:= '';
      SQL.Clear;
      SQL.Add(' select first 1 * ');
      SQL.Add(' from frf_envases ');
      SQL.Add(' where empresa_e matches ''F*'' ');
      SQL.Add(' and envase_e = ' + QuotedStr( Trim( envase_e.Text ) ) );
      SQL.Add(' and producto_base_e <> ' + Trim( producto_base_e.Text ) );
      Open;
      if not IsEmpty then
      begin
        if FieldByName('descripcion_e').AsString <> descripcion_e.Text then
        begin
          sAux:= sAux + #13 + #10 + 'Ya hay un envase con el mismo código y diferente producto base (' + desProductoBase( empresa_e.Text, FieldByName('producto_base_e').AsString ) + ').';
          //Close;
          //raise Exception.Create( sAux );
        end;
      end;
      Close;

      SQL.Clear;
      SQL.Add(' select first 1 * ');
      SQL.Add(' from frf_envases ');
      SQL.Add(' where empresa_e matches ''F*'' ');
      SQL.Add(' and envase_e = ' + QuotedStr( Trim( envase_e.Text ) ) );
      SQL.Add(' and producto_base_e = ' + Trim( producto_base_e.Text ) );
      Open;
      if not IsEmpty then
      begin
        if FieldByName('descripcion_e').AsString <> descripcion_e.Text then
        begin
          sAux:= sAux + #13 + #10 +  'Ya hay un envase con el mismo código y diferente descripción (' + FieldByName('descripcion_e').AsString + ').';
          //Close;
          //raise Exception.Create( sAux );
        end;
      end;
      Close;

      SQL.Clear;
      SQL.Add(' select first 1 * ');
      SQL.Add(' from frf_envases ');
      SQL.Add(' where empresa_e matches ''F*'' ');
      SQL.Add(' and descripcion_e = ' + QuotedStr( Trim( descripcion_e.Text ) ) );
      Open;
      if not IsEmpty then
      begin
        if ( FieldByName('envase_e').AsString <> envase_e.Text ) or
           ( FieldByName('producto_base_e').AsString <> producto_base_e.Text ) then
        begin
          sAux:= sAux + #13 + #10 +  'Ya hay un envase con la misma descripción y diferente código (' + FieldByName('envase_e').AsString + '-' + Trim( des_producto_base_e.Caption ) + ').';
          //Close;
          //raise Exception.Create( sAux );
        end;
      end;
      Close;

      if sAux <> '' then
      begin
        if VerAdvertencia( Self, sAux ) = mrOk then
          Abort;
      end;
    end;
  end;

  if Trim(env_comer_operador_e.Text) = '' then
    QEnvases.FieldByName('env_comer_operador_e').Value := null;
  if Trim(env_comer_producto_e.Text) = '' then
    QEnvases.FieldByName('env_comer_producto_e').Value := null;

  if des_linea_producto_e.Caption = '' then
  begin
    linea_producto_e.SetFocus;
    raise Exception.Create( 'Es necesaria incluir la línea de producto (Mantenimiento Ficheros/Productos - Líneas )' );
  end;

  if lblDesTipoIva.Caption = '' then
  begin
    tipo_unidad_e.SetFocus;
    raise Exception.Create( 'Es necesario indicar el tipo de IVA ' + #13 + #10 +
                            '0 - Superreducido, productos frescos ' + #13 + #10 +
                            '1 - Reducido, cuarta gama ' + #13 + #10 +
                            '2 - General, otros ' + #13 + #10 +
                            'Para cualquier duda pongase en contacto con el departamento de comercial. ' );
  end;


  if unidades_e.Text = '' then
  begin
    unidades_e.Text:= '0';
    QEnvases.FieldByName('unidades_e').AsInteger:= 0;
  end;
  (*
  QEnvases.FieldByName('unidades_e').AsInteger:= StrToIntDef(unidades_e.Text,0);
  if QEnvases.FieldByName('unidades_e').AsInteger < 1 then
    QEnvases.FieldByName('unidades_e').AsInteger:= 1;
  *)

    if Trim( master_e.Text ) <> '' then
  begin
    if master_e.Text = envase_e.Text then
    begin
      raise Exception.Create('El envase no puede ser maestro de si mismo.');
    end;
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add('select producto_base_e ');
      SQL.Add('from frf_envases ');
      SQL.Add('where empresa_e = :empresa ');
      SQL.Add('and envase_E = :envase ');
      ParamByName('empresa').AsString:= empresa_e.Text;
      ParamByName('envase').AsString:= master_e.Text;
      Open;
      if not IsEmpty then
      begin
        if FieldByName('producto_base_e').AsString <> producto_base_e.Text then
        begin
          Close;
          raise Exception.Create('El maestro debe tener el mismo producto base.');
        end
        else
        begin
          Close;
        end;
      end
      else
      begin
        Close;
        raise Exception.Create('No existe el envase maestro.');
      end;



      SQL.Clear;
      SQL.Add('select master_e ');
      SQL.Add('from frf_envases ');
      SQL.Add('where empresa_e = :empresa ');
      SQL.Add('and envase_E = :envase ');
      SQL.Add('and master_e is not null ');
      ParamByName('empresa').AsString:= empresa_e.Text;
      ParamByName('envase').AsString:= master_e.Text;
      Open;
      if not IsEmpty then
      begin
        sAux:= FieldByName('master_e').AsString;
        Close;
        raise Exception.Create('El maestro no puede ser un envase que ya tiene maestro [' + sAux + '].');
      end;
      Close;
    end;
  end
  else
  begin
    QEnvases.FieldByName('master_e').Value:= Null;
  end;
end;

//**************************************************************
//IMPRESION: Introducir QuickReport
//**************************************************************

procedure TFMEnvases.Previsualizar;
begin
  case FichaOrListado( Self ) of
    1: PreviewFicha;
    2: PreviewListado( False );
    3: PreviewListado( True );
  end;
end;

procedure TFMEnvases.PreviewListado( const AVerClientes: Boolean );
var
  enclave: TBookMark;
begin
  //Crear el listado
  enclave := DataSetMaestro.GetBookmark;
  QRLEnvases := TQRLEnvases.Create(Application);
  PonLogoGrupoBonnysa(QRLEnvases);
  //QRLEnvases.DataSet := QEnvases;
  if AVerClientes then
    QEnvasesCliente.Open;
  try
    try
      Preview(QRLEnvases);
    except
      FreeAndNil( QRLEnvases );
      raise;
    end;
  finally
    DataSetMaestro.GotoBookmark(enclave);
    DataSetMaestro.FreeBookmark(enclave);
    QEnvasesCliente.Close;
  end;
end;

procedure TFMEnvases.PreviewFicha;
begin
  if QEnvases.FieldByname('empresa_e').AsString <> '' then
    ShowFichaEnvase( Self, QEnvases.FieldByname('empresa_e').AsString,
                           QEnvases.FieldByname('envase_e').AsString,
                           QEnvases.FieldByname('producto_base_e').AsInteger );
end;


//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMEnvases.AntesDeModificar;
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
  end;

  peso_variable_e.AllowGrayed:= False;
  unidades_variable_e.AllowGrayed:= False;
  precio_diario_e.AllowGrayed:= False;

  pgcDetalle.Enabled:= False;
end;

procedure TFMEnvases.GetEnvaseBDRemota( const ABDRemota: string; const AAlta: Boolean );
var
  sEmpresa, sProducto, sEnvase: string;
  iValue: Integer;
  bAlta: Boolean;
begin
  sEmpresa:= empresa_e.Text;
  sProducto:= producto_base_e.Text;
  if AAlta then
    sEnvase:= ''
  else
    sEnvase:= envase_e.Text;
  bAlta:= AAlta;

  iValue:= ImportarEnvase( Self, ABDRemota, sEmpresa, sProducto, sEnvase, bAlta );
  case iValue of
      -1: //Operacion cancelada
          begin end;
       1: begin
            if bAlta then
            begin
              BuscarEnvase( sEmpresa, sProducto, sEnvase );
              //ShowMessage('Alta de envase correcta.');
            end
            else
            begin
              RefrescarEnvase;
              //ShowMessage('Modificación de envase correcta.');
            end;
          end;
       else ShowMessage('Error ' + IntToStr( iValue ) + ' al importar el envase.');
  end;
end;

procedure TFMEnvases.CerrarConexion;
begin
  if DMBaseDatos.BDCentral.Connected then
  begin
    DMBaseDatos.BDCentral.Connected:= False;
  end;
end;

function  TFMEnvases.AbrirConexion: Boolean;
begin
  if DMBaseDatos.BDCentral.Connected then
  begin
    Result:= True;
  end
  else
  begin
    try
      DMBaseDatos.BDCentral.Connected:= True;
      Result:= True;
    except
      Result:= False;
    end;
  end;
end;

procedure TFMEnvases.Modificar;
var
  iTipo: Integer;
  sBD: string;
begin
  //inherited Modificar;
  if DMConfig.EsLaFont then
  begin
    if DMBaseDatos.GetPermiso( gsCodigo, 'imp_env_almacen' ) = 1 then
    begin
      if SeleccionarTipoAltaFD.SeleccionarTipoAlta( Self, iTipo, sBD,
                                '     SELECCIONAR TIPO ACTUALIZACIÓN', 'Editar Registro Local'  ) = mrOk then
      begin
        case iTipo of
          0: inherited Modificar;
          1: GetEnvaseBDRemota( sBD, False );
        end;
      end
    end
    else
    begin
      inherited Modificar;
    end;
  end
  else
  begin
    if AbrirConexion then
    begin
      GetEnvaseBDRemota( 'BDCentral', False );
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

procedure TFMEnvases.Altas;
var
  iTipo: Integer;
  sBD: string;
begin
  //inherited Altas;
  if DMConfig.EsLaFontEx then
  begin
    if DMBaseDatos.GetPermiso( gsCodigo, 'imp_env_almacen' ) = 1 then
    begin
      if SeleccionarTipoAltaFD.SeleccionarTipoAlta( Self, iTipo, sBD ) = mrOk then
      begin
        case iTipo of
          0: inherited Altas;
          1: GetEnvaseBDRemota( sBD, True );
        end;
      end
    end
    else
    begin
      inherited Altas;
    end;
  end
  else
  begin
    if DMBaseDatos.AbrirConexionCentral then
    begin
      GetEnvaseBDRemota( 'BDCentral', True );
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

procedure TFMEnvases.AntesDeInsertar;
begin
  envase_comercial_e.Field.Value := 'N';
  unidades_variable_e.Checked:= False;
  peso_variable_e.Checked:= False;
  precio_diario_e.Checked:= False;

  peso_variable_e.AllowGrayed:= False;
  unidades_variable_e.AllowGrayed:= False;  
  precio_diario_e.AllowGrayed:= False;
  tipo_iva_e.Text:= '';
  tipo_iva_e.ItemIndex:= 0;

  pgcDetalle.Enabled:= False;

  tipo_e.Text:= '0';
  tipo_e.ItemIndex:= 0;
end;

procedure TFMEnvases.AntesDeLocalizar;
begin
  cbxVer.ItemIndex := 0;
  cbxVer.Enabled := True;

  envase_comercial_e.Visible:= False;
  cbxComercial.ItemIndex:= 0;
  cbxComercial.Visible:= True;

  peso_variable_e.AllowGrayed:= True;
  unidades_variable_e.AllowGrayed:= True;  
  precio_diario_e.AllowGrayed:= True;

  pgcDetalle.Enabled:= False;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMEnvases.AntesDeVisualizar;
var i: Integer;
begin
  cbxVer.Enabled := False;

    //Resaturamos estado controles
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          if Enabled = false then Enabled := true;
  end;

  envase_comercial_e.Visible:= True;
  cbxComercial.Visible:= False;
  peso_variable_e.AllowGrayed:= False;
  unidades_variable_e.AllowGrayed:= False;  
  precio_diario_e.AllowGrayed:= False;

  pgcDetalle.Enabled:= True;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************


//Para saber cuando tenemos que obligar a que un campo sea requerido

procedure TFMEnvases.RequiredTime(Sender: TObject;
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

procedure TFMEnvases.envase_comercial_eEnter(Sender: TObject);
begin
  envase_comercial_e.Color := clHighlight;
end;

procedure TFMEnvases.envase_comercial_eExit(Sender: TObject);
begin
  envase_comercial_e.Color := clBtnFace;
end;

procedure TFMEnvases.notas_eEnter(Sender: TObject);
begin
  KeyPreview := false;
end;

procedure TFMEnvases.notas_eExit(Sender: TObject);
begin
  KeyPreview := True;
end;

procedure TFMEnvases.ARejillaFlotanteExecute(Sender: TObject);
var
  sAux: string;
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa_e);
    kProductoBase: DespliegaRejilla(BGBproducto_base_e, [empresa_e.Text]);
    kLineaProducto: DespliegaRejilla(btnLinea_producto_e);
    kTipoUnidad: DespliegaRejilla(BGBtipo_unidad_e, [empresa_e.Text, producto_base_e.Text]);
    kEan13Envase: DespliegaRejilla(btnEan13_e, [empresa_e.Text]);
    kAgrupacionEnvase: DespliegaRejilla( btnAgrupacion );
    kEnvComerOperador: DespliegaRejilla(btnEnvComerOperador);
    kEnvComerProducto: DespliegaRejilla(btnEnvComerProducto,[env_comer_operador_e.Text]);
    kAgrupacionComercial: DespliegaRejilla( btnAgrupaComer );
    kTipoCaja: DespliegaRejilla(btnTipoCaja);
    kEnvase:
    begin
      sAux:= master_e.Text;
      if SeleccionaEnvases( self, master_e, empresa_e.Text, sAux ) then
      begin
        master_e.Text:= sAux;
      end;
    end;    
  end;
end;

procedure TFMEnvases.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa:
      begin
        STEmpresa_e.Caption := desEmpresa(empresa_e.Text);
        des_producto_base_e.Caption := desProductoBase(empresa_e.Text, producto_base_e.Text);
      end;
    kTipoUnidad: STTipo_unidad_e.Caption := desTipoUnidad(empresa_e.Text, tipo_unidad_e.text, producto_base_e.Text );
    kEnvComerOperador:
    begin
      txtOperador.Caption := desEnvComerOperador(env_comer_operador_e.Text );
      txt_env_comer.Caption := desEnvComerProducto(env_comer_operador_e.Text, env_comer_producto_e.Text );
    end;
    kEnvComerProducto: txt_env_comer.Caption := desEnvComerProducto(env_comer_operador_e.Text, env_comer_producto_e.Text );
    kTipoCaja: des_tipo_caja.Caption := desTipoCaja(tipo_caja_e.Text);
    kEnvase:  txtMaster_c.Caption:= desEnvase( empresa_e.Text, master_e.Text );
  end;
end;

procedure TFMEnvases.producto_base_eChange(Sender: TObject);
begin
  //buscar descripcion
  des_producto_base_e.Caption := desProductoBase(empresa_e.Text, producto_base_e.Text);
end;

procedure TFMEnvases.EnvaseClienteClick(Sender: TObject);
begin
  if not QEnvases.IsEmpty and (QEnvases.State = dsBrowse) then
  begin
    EnvaseClientePorEnvase(empresa_e.Text, producto_base_e.Text, envase_e.Text);
    qryDesCliente.Close;
    qryDesCliente.Open;
  end;
end;

procedure TFMEnvases.DSMaestroDataChange(Sender: TObject; Field: TField);
var
  ImagenNom: string;
begin
  //ruta:= '\\192.168.5.65\Documentos\Envasados\RADIO FRECUENCIA\RADIO FRECUENCIA\CATALOGO FOTOS PREVIAS\SERIE 1\';
  //Cargar imagen
    ImagenNom := 'IMG_0' + envase_e.Text + '.jpg';
    if FileExists(gsDirActual + '\imagenes\' + ImagenNom) then
    begin
      Image.Picture.LoadFromFile(gsDirActual + '\imagenes\' + ImagenNom);
      Image.Show;
    end
    else
    begin
      Image.Hide;
    end;
  Changetipo_e;
  Changetipo_iva_e;


  if not QEnvases.IsEmpty and (QEnvases.State = dsBrowse) then
  begin
    pnlPasarSGP.Font.Color := clBlue;
  end
  else
  begin
    pnlPasarSGP.Font.Color := clGray;
  end;
end;

procedure TFMEnvases.FormDeactivate(Sender: TObject);
begin
  gRF := nil;
  gCF := nil;
end;

procedure TFMEnvases.envase_eExit(Sender: TObject);
begin
  (*BAG*)
  //Buscar si esta grabado y rellenar datos
  if ( Trim( empresa_e.Text ) <> '' ) and ( Copy( Trim( empresa_e.Text ),1,1) = 'F' ) and ( Trim( envase_E.Text ) <> '' ) and ( Estado = teAlta ) then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 * ');
    SQL.Add(' from frf_envases ');
    SQL.Add(' where empresa_e matches ''F*'' ');
    SQL.Add(' and envase_e = ' + QuotedStr( Trim( envase_e.Text ) ) );

    Open;
    if not IsEmpty then
    begin
      if MessageDlg( 'Ya hay un envase con este código y con producto ' + desProductoBase( empresa_e.Text, FieldByName('producto_base_e').AsString ) +
                     ', ¿desea rellenar los campos de la ficha actual con sus datos?.' , mtWarning, [mbYes, mbNo], 0 ) = mrYes then
       begin
         producto_base_e.Text:= FieldByName('producto_base_e').AsString;
         descripcion_e.Text:= FieldByName('descripcion_e').AsString;
         descripcion2_e.Text:= FieldByName('descripcion2_e').AsString;
         agrupacion_e.Text:= FieldByName('agrupacion_e').AsString;
         peso_envase_e.Text:= FieldByName('peso_envase_e').AsString;
         peso_neto_e.Text:= FieldByName('peso_neto_e').AsString;
         peso_variable_e.Checked:= FieldByName('peso_variable_e').AsString = '1';
         unidades_variable_e.Checked:= FieldByName('unidades_variable_e').AsString = '1';
         precio_diario_e.Checked:= FieldByName('precio_diario_e').AsString = '1';
         notas_e.Text:= FieldByName('notas_e').AsString;
         unidades_e.Text:= FieldByName('unidades_e').AsString;
         tipo_unidad_e.Text:= FieldByName('tipo_unidad_e').AsString;
         ean13_e.Text:= FieldByName('ean13_e').AsString;
         envase_comercial_e.Checked:= FieldByName('envase_comercial_e').AsString = 'S';
         fecha_baja_e.Text:= FieldByName('fecha_baja_e').AsString;
         tipo_iva_e.Text:= FieldByName('tipo_iva_e').AsString;
         tipo_e.ItemIndex:= FieldByName('tipo_e').AsInteger;
       end;
    end;
    Close;
  end;
end;

procedure TFMEnvases.descripcion_eEnter(Sender: TObject);
begin
  (*BAG*)
  //Buscar si esta grabado y rellenar datos
  if ( Trim( empresa_e.Text ) <> '' ) and ( Copy( Trim( empresa_e.Text ),1,1) = 'F' ) and ( Trim( envase_E.Text ) <> '' ) and
     ( Trim( producto_base_e.Text ) <> '' ) and ( Trim( descripcion_e.Text ) = '' ) and
     ( Estado = teAlta ) then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 * ');
    SQL.Add(' from frf_envases ');
    SQL.Add(' where empresa_e matches ''F*'' ');
    SQL.Add(' and envase_e = ' + QuotedStr( Trim( envase_e.Text ) ) );
    SQL.Add(' and producto_base_e = ' + Trim( producto_base_e.Text ) );

    Open;
    if not IsEmpty then
    begin
      if MessageDlg( 'Ya hay un envase con este código y producto, ¿desea rellenar los campos de la ficha actual con sus datos?.' , mtWarning, [mbYes, mbNo], 0 ) = mrYes then
       begin
         descripcion_e.Text:= FieldByName('descripcion_e').AsString;
         descripcion2_e.Text:= FieldByName('descripcion2_e').AsString;
         agrupacion_e.Text:= FieldByName('agrupacion_e').AsString;
         peso_envase_e.Text:= FieldByName('peso_envase_e').AsString;
         peso_neto_e.Text:= FieldByName('peso_neto_e').AsString;
         peso_variable_e.Checked:= FieldByName('peso_variable_e').AsString = '1';
         unidades_variable_e.Checked:= FieldByName('unidades_variable_e').AsString = '1';
         precio_diario_e.Checked:= FieldByName('precio_diario_e').AsString = '1';
         notas_e.Text:= FieldByName('notas_e').AsString;
         unidades_e.Text:= FieldByName('unidades_e').AsString;
         tipo_unidad_e.Text:= FieldByName('tipo_unidad_e').AsString;
         ean13_e.Text:= FieldByName('ean13_e').AsString;
         envase_comercial_e.Checked:= FieldByName('envase_comercial_e').AsString = 'S';
         fecha_baja_e.Text:= FieldByName('fecha_baja_e').AsString;
         tipo_iva_e.Text:= FieldByName('tipo_iva_e').AsString;
         tipo_e.ItemIndex:= FieldByName('tipo_e').AsInteger;
       end;
    end;
    Close;
  end;
end;

procedure TFMEnvases.QEnvasesAfterPost(DataSet: TDataSet);
var
  sEmpresa, sAux: string;
begin
  (*BAG*)
  if Estado = teAlta then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 * ');
    SQL.Add(' from frf_envases ');
    SQL.Add(' where empresa_e <> ' + QuotedStr( DataSet.FieldByName('empresa_e').AsString ) );
    SQL.Add(' and empresa_e matches ''F*'' ');
    SQL.Add(' and envase_e = ' + QuotedStr( DataSet.FieldByName('envase_e').AsString ) );
    SQL.Add(' and producto_base_e = ' + DataSet.FieldByName('producto_base_e').AsString );
    Open;

    if not IsEmpty then
    begin
      sEmpresa:= FieldByName('empresa_e').AsString;
      Close;
      SQL.Clear;
      SQL.Add(' select * ');
      SQL.Add(' from frf_clientes_env ');
      SQL.Add(' where empresa_ce = ' + QuotedStr( sEmpresa  ) );
      SQL.Add(' and producto_base_ce = ' + DataSet.FieldByName('producto_base_e').AsString );
      SQL.Add(' and envase_ce = ' + QuotedStr( DataSet.FieldByName('envase_e').AsString ) );
      Open;
      sAux:= '';
      while not Eof do
      begin
        if not QEnvasesCliente.Active then
        begin
          sAux:= QEnvasesCliente.SQL.Text;
          QEnvasesCliente.sql.Clear;
          QEnvasesCliente.sql.Add( 'select * from frf_clientes_env' );
          QEnvasesCliente.Open;
        end;
        QEnvasesCliente.Insert;
        QEnvasesCliente.FieldByName('empresa_ce').AsString:= DataSet.FieldByName('empresa_e').AsString;
        QEnvasesCliente.FieldByName('envase_ce').AsString:= FieldByName('envase_ce').AsString;
        QEnvasesCliente.FieldByName('producto_base_ce').AsString:= FieldByName('producto_base_ce').AsString;
        QEnvasesCliente.FieldByName('cliente_ce').AsString:= FieldByName('cliente_ce').AsString;
        QEnvasesCliente.FieldByName('unidad_fac_ce').AsString:= FieldByName('unidad_fac_ce').AsString;
        QEnvasesCliente.FieldByName('descripcion_ce').AsString:= FieldByName('descripcion_ce').AsString;
        QEnvasesCliente.FieldByName('n_palets_ce').AsInteger:= FieldByName('n_palets_ce').AsInteger;
        QEnvasesCliente.FieldByName('kgs_palet_ce').AsFloat:= FieldByName('kgs_palet_ce').AsFloat;
        QEnvasesCliente.Post;
        Next;
      end;
      Close;
      if QEnvasesCliente.Active and ( sAux <> '' ) then
      begin
        QEnvasesCliente.Close;
        QEnvasesCliente.sql.Clear;
        QEnvasesCliente.sql.Add( sAux );
      end;
    end;
  end;
end;

procedure TFMEnvases.Changetipo_iva_e;
begin
  if tipo_iva_e.Text = '' then
  begin
    lblDesTipoIva.Caption:= '';
  end
  else
  if tipo_iva_e.Text = '0' then
  begin
    lblDesTipoIva.Caption:= 'Superreducido, producto fresco';
  end
  else
  if tipo_iva_e.Text = '1' then
  begin
    lblDesTipoIva.Caption:= 'Reducido, cuarta gama';
  end
  else
  if tipo_iva_e.Text = '2' then
  begin
    lblDesTipoIva.Caption:= 'General';
  end;
end;

procedure TFMEnvases.Changetipo_e;
begin
  if tipo_e.Text = '' then
  begin
    lblDesTipoEnvase.Caption:= '';
  end
  else
  if Copy(tipo_e.Text,1,1) = '0' then
  begin
    lblDesTipoEnvase.Caption:= 'NORMAL';
  end
  else
  if Copy(tipo_e.Text,1,1) = '1' then
  begin
    lblDesTipoEnvase.Caption:= 'CABECERA MULTIPRODUCTO';
  end
  else
  if Copy(tipo_e.Text,1,1) = '2' then
  begin
    lblDesTipoEnvase.Caption:= 'DETALLE MULTIPRODUCTO';
  end;
end;

procedure TFMEnvases.QEnvasesAfterOpen(DataSet: TDataSet);
begin
  qryDesCliente.Open;
  qrySecContable.Open;
  qryEcoembes.Open;
  QEan13.Open;
end;

procedure TFMEnvases.QEnvasesBeforeClose(DataSet: TDataSet);
begin
  qryDesCliente.Close;
  qrySecContable.Close;
  qryEcoembes.Close;
  QEan13.Close;
end;

procedure TFMEnvases.pnlSeccionContableClick(Sender: TObject);
begin
  if not QEnvases.IsEmpty and (QEnvases.State = dsBrowse) then
  begin
    SeccionesContablesEnvase( empresa_e.Text, envase_e.Text, producto_base_e.Text );
    qrySecContable.Close;
    qrySecContable.Open;
  end;
end;

procedure TFMEnvases.linea_producto_eChange(Sender: TObject);
begin
  des_linea_producto_e.Caption:= DesLineaProducto( linea_producto_e.Text );
end;

procedure TFMEnvases.pnlEcoembesClick(Sender: TObject);
begin
  if not QEnvases.IsEmpty and (QEnvases.State = dsBrowse) then
  begin
    EcoembesEnvasesFD.ExecuteEcoembesEnvases( self, empresa_e.Text, envase_e.Text, producto_base_e.Text );
    qryEcoembes.Close;
    qryEcoembes.Open;
  end;
end;



procedure TFMEnvases.tipo_eChange(Sender: TObject);
begin
 Changetipo_e;
end;

procedure TFMEnvases.pnlPasarSGPClick(Sender: TObject);
begin
  if not QEnvases.IsEmpty and (QEnvases.State = dsBrowse) then
  begin
    //Copiar envase en el SGP
    if UComerToSgpDM.PasarEnvase( empresa_e.Text, envase_e.Text ) then
    begin
      ShowMessage('Programa finalizado con éxito.');
    end
    else
    begin
      ShowMessage('Error al pasar al SGP el envase seleccionado.');
    end;
  end;
end;

end.
