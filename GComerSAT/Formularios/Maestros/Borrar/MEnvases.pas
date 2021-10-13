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
    lblNombre12: TLabel;
    descripcion2_e: TBDEdit;
    empresa_e: TBDEdit;
    producto_base_e: TBDEdit;
    STEmpresa_e: TStaticText;
    descripcion_pb: TBDEdit;
    RejillaFlotante: TBGrid;
    fecha_baja_e: TBDEdit;
    cbxVer: TComboBox;
    peso_variable_e: TDBCheckBox;
    pnlEnvaseCliente: TPanel;
    QEnvasesCliente: TQuery;
    lbl1: TLabel;
    precio_diario_e: TDBCheckBox;
    lblTipIva: TLabel;
    tipo_iva_e: TDBComboBox;
    lblDesTipoIva: TLabel;
    QEan13: TQuery;
    DSEan13: TDataSource;
    QClientes: TQuery;
    DSClientes: TDataSource;
    pgcControl: TPageControl;
    tsEan13: TTabSheet;
    dbgEan13: TDBGrid;
    tsClientes: TTabSheet;
    dbgClientes: TDBGrid;
    tsImagen: TTabSheet;
    Bevel1: TBevel;
    Image: TImage;
    btnAgrupacion: TBGridButton;
    lblTipoCaja: TLabel;
    tipo_caja_e: TBDEdit;
    btnTipoCaja: TBGridButton;
    env_comer_operador_e: TBDEdit;
    env_comer_producto_e: TBDEdit;
    des_env_comer: TStaticText;
    des_tipo_caja: TStaticText;
    btnEnvComerOperador: TBGridButton;
    btnEnvComerProducto: TBGridButton;
    lblEnvase: TLabel;
    txtOperador: TStaticText;
    unidades_variable_e: TDBCheckBox;
    lblAgrupaComer: TLabel;
    agrupa_comercial_e: TBDEdit;
    btnAgrupaComer: TBGridButton;
    lblMaster_c: TLabel;
    master_e: TBDEdit;
    btnMaster_c: TBGridButton;
    txtMaster_c: TStaticText;
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
    procedure DSMaestroStateChange(Sender: TObject);
    procedure DSMaestroDataChange(Sender: TObject; Field: TField);
    procedure FormDeactivate(Sender: TObject);
    procedure tipo_iva_eChange(Sender: TObject);
    procedure QEnvasesAfterOpen(DataSet: TDataSet);
    procedure QEnvasesBeforeClose(DataSet: TDataSet);
    procedure pnlPasarSGPClick(Sender: TObject);
    //procedure ACamposExecute(Sender: TObject);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;
    procedure BuscarEnvase( const AEmpresa, AProducto, AEnvase: string );
    procedure RefrescarEnvase;
    procedure GetEnvaseBDRemota( const ABDRemota: string; const AAlta: Boolean );

  public
    { Public declarations }
    procedure Altas; override;
    procedure MiAlta;
    procedure ClonarEnvase;
    procedure Modificar; override;
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeModificar;
    procedure AntesDeInsertar;
    procedure AntesDeVisualizar;
    procedure AntesDeLocalizar;
    procedure AntesDeBorrarMaestro;

    //Listado
    procedure Previsualizar; override;
    procedure PreviewListado( const AVerClientes: Boolean );
    procedure PreviewListadoClientes;
    procedure PreviewListadoSimple;
    procedure PreviewFicha;
  end;

//var
  //FMEnvases: TFMEnvases;

implementation

uses Variants, CVariables, CGestionPrincipal, UDMBaseDatos, CAuxiliarDB, Principal,
  LEnvasesClientes, LEnvasesSimple, DPreview, UDMAuxDB, bSQLUtils, CReportes, bDialogs, CliEnvases,
  UDMconfig, FichaListadoFD, EnvasesDL, UFEnvases, AdvertenciaFD, ImportarEnvasesFD,
  SeleccionarTipoAltaFD, ClonarEnvasesFD, SeleccionarAltaClonarFD, UComerToSgpDM;

{$R *.DFM}

procedure TFMEnvases.BuscarEnvase( const AEmpresa, AProducto, AEnvase: string );
begin
 {+}Select := ' SELECT * FROM frf_envases ';
 {+}where := ' WHERE empresa_e=' + QuotedStr(AEmpresa) +
             ' and envase_e=' + QuotedStr(AEnvase) +
             ' and producto_base_e=' + AProducto;
 {+}Order := ' ORDER BY empresa_e, envase_e ';

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
end;

procedure TFMEnvases.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMEnvases.FormCreate(Sender: TObject);
begin
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
  with QClientes.SQL do
  begin
    Clear;
    Add('select cliente_ce, unidad_fac_ce, descripcion_ce');
    Add('from frf_clientes_env');
    Add('where empresa_ce = :empresa_e');
    Add('and envase_cE = :envase_E');
    Add('and producto_base_ce = :producto_base_e');
    Add('order by 1');
  end;
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //***************************************************************
     //Fuente de datos maestro
     //CAMBIAR POR LA QUERY QUE LE TOQUE
 {+}DataSetMaestro := QEnvases;
     //***************************************************************

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_envases ';
 {+}where := ' WHERE envase_e=' + QuotedStr('###');
 {+}Order := ' ORDER BY empresa_e, envase_e ';
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
  master_e.Tag := kEnvase;
  producto_base_e.Tag := kProductobase;
  descripcion_pb.Tag := kProductobase;
  tipo_unidad_e.Tag := kTipoUnidad;
  agrupacion_e.Tag:= kAgrupacionEnvase;
  agrupa_comercial_e.Tag:= kAgrupacionComercial;
  tipo_caja_e.Tag := kTipoCaja;
  env_comer_operador_e.Tag := kEnvComerOperador;
  env_comer_producto_e.Tag := kEnvComerProducto;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnEdit := AntesDeModificar;
  OnInsert := AntesDeInsertar;
  OnView := AntesDeVisualizar;
  OnBrowse := AntesDeLocalizar;
  OnBeforeMasterDelete := AntesDeBorrarMaestro;

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

  tipo_iva_eChange(tipo_iva_e);

  pnlPasarSGP.Visible:= DMConfig.EsLosLLanos or DMConfig.EsLaFontEx;
  pnlEnvaseCliente.Visible:= DMConfig.EsLaFontEx;
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

  if tipo_iva_e.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    where := where + ' tipo_iva_e = ' + tipo_iva_e.Text;
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

  if Trim(env_comer_operador_e.Text) = '' then
    QEnvases.FieldByName('env_comer_operador_e').Value := null;
  if Trim(env_comer_producto_e.Text) = '' then
    QEnvases.FieldByName('env_comer_producto_e').Value := null;
  QEnvases.FieldByName('unidades_e').AsInteger:= StrToIntDef(unidades_e.Text,1);
  if QEnvases.FieldByName('unidades_e').AsInteger < 1 then
    QEnvases.FieldByName('unidades_e').AsInteger:= 1;

  //El maestro no puede otro que ya tenga maestro ni el mismo y tienen que tener
  //el mismo producto base
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
procedure TFMEnvases.PreviewListadoClientes;
var
  enclave: TBookMark;
begin
  //Crear el listado
  enclave := DataSetMaestro.GetBookmark;
  QRLEnvasesClientes := TQRLEnvasesClientes.Create(Application);
  PonLogoGrupoBonnysa(QRLEnvasesClientes);
  //QRLEnvases.DataSet := QEnvases;
  try
    try
      Preview(QRLEnvasesClientes);
    except
      FreeAndNil( QRLEnvasesClientes );
      raise;
    end;
  finally
    DataSetMaestro.GotoBookmark(enclave);
    DataSetMaestro.FreeBookmark(enclave);
    QEnvasesCliente.Close;
  end;
end;

procedure TFMEnvases.PreviewListadoSimple;
var
  enclave: TBookMark;
begin
  //Crear el listado
  enclave := DataSetMaestro.GetBookmark;
  QRLEnvasesSimple := TQRLEnvasesSimple.Create(Application);
  PonLogoGrupoBonnysa(QRLEnvasesSimple);
  //QRLEnvases.DataSet := QEnvases;
  try
    try
      Preview(QRLEnvasesSimple);
    except
      FreeAndNil( QRLEnvasesSimple);
      raise;
    end;
  finally
    DataSetMaestro.GotoBookmark(enclave);
    DataSetMaestro.FreeBookmark(enclave);
  end;
end;

procedure TFMEnvases.PreviewListado( const AVerClientes: Boolean );
begin
  if AVerClientes then
    PreviewListadoClientes
  else
    PreviewListadoSimple;
end;

procedure TFMEnvases.PreviewFicha;
begin
  if QEnvases.FieldByname('empresa_e').AsString <> '' then
    ShowFichaEnvase( Self, QEnvases.FieldByname('empresa_e').AsString,
                           QEnvases.FieldByname('envase_e').AsString,
                           QEnvases.FieldByname('producto_base_e').AsInteger );
end;

procedure TFMEnvases.Previsualizar;
begin
  //PreviewListado;
  //Exit;

  case FichaOrListado( Self ) of
    1: PreviewFicha;
    2: PreviewListado( False );
    3: PreviewListado( True );
  end;
end;



//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//******************************************************************* **********
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

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

  if ( not QClientes.IsEmpty ) or ( not QEan13.IsEmpty )  then
  begin
    raise Exception.Create('No se puede borrar el envase, primero borre el detalle.');
  end;
end;

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
  tipo_iva_eChange(tipo_iva_e);
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

procedure TFMEnvases.Modificar;
var
  iTipo: Integer;
  sBD: string;
begin
  if DMConfig.EsLaFontEx then
  begin
    if DMBaseDatos.GetPermiso( gsCodigo, 'imp_env_almacen' ) = 1 then
    begin
      if SeleccionarTipoAltaFD.SeleccionarTipoAlta( Self, iTipo, sBD,
                               '     SELECCIONAR TIPO ACTUALIZACIÓN', 'Editar Registro Local' ) = mrOk then
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
    inherited Modificar;
  end
  else
  begin
    //inherited Modificar;
    if DMBaseDatos.AbrirConexionCentral then
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
  if DMConfig.EsLaFontEx then
  begin
    MiAlta;
    (*
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
      MiAlta;
    end;
    *)
  end
  else
  begin
    //inherited Altas;
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

procedure TFMEnvases.MiAlta;
var
  iTipo: integer;
begin
  if not DataSetMaestro.IsEmpty then
  begin
    if SeleccionarAltaClonarFD.SeleccionarTipoAlta( Self, iTipo ) = mrOk then
    begin
      case iTipo of
        0: inherited Altas;
        1: ClonarEnvase;
      end;
    end;
  end
  else
  begin
    inherited Altas;
  end;
end;

procedure TFMEnvases.ClonarEnvase;
var
  sEmpresa, Sproducto, sEnvase: string;
begin
  sEmpresa:= DataSetMaestro.FieldByName('empresa_e').AsString;
  Sproducto:= DataSetMaestro.FieldByName('producto_base_e').AsString;
  sEnvase:= DataSetMaestro.FieldByName('envase_e').AsString;
  if ClonarEnvasesFD.ClonarEnvase( sEmpresa, Sproducto, sEnvase ) = 1 then
  begin
    BuscarEnvase( sEmpresa, Sproducto, sEnvase );
  end;
end;

procedure TFMEnvases.AntesDeInsertar;
begin
  envase_comercial_e.Field.Value := 'N';
  unidades_variable_e.Checked:= False;
  precio_diario_e.Checked:= False;
  peso_variable_e.Checked:= False;

  peso_variable_e.AllowGrayed:= False;
  unidades_variable_e.AllowGrayed:= False;
  precio_diario_e.AllowGrayed:= False;
  tipo_iva_eChange(tipo_iva_e);
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
  tipo_iva_eChange(tipo_iva_e);
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
  tipo_iva_eChange(tipo_iva_e);
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
    kTipoUnidad: DespliegaRejilla(BGBtipo_unidad_e, [empresa_e.Text, producto_base_e.Text]);
    kAgrupacionEnvase: DespliegaRejilla( btnAgrupacion );
    kAgrupacionComercial: DespliegaRejilla( btnAgrupaComer );
    kTipoCaja: DespliegaRejilla(btnTipoCaja);
    kEnvComerOperador: DespliegaRejilla(btnEnvComerOperador);
    kEnvComerProducto: DespliegaRejilla(btnEnvComerProducto,[env_comer_operador_e.Text]);
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
        descripcion_pb.text := desProductoBase(empresa_e.Text, producto_base_e.Text);
      end;
    kTipoUnidad: STTipo_unidad_e.Caption := desTipoUnidad(empresa_e.Text, tipo_unidad_e.text, producto_base_e.Text);
    kTipoCaja: des_tipo_caja.Caption := desTipoCaja(tipo_caja_e.Text);
    kEnvComerOperador:
    begin
      txtOperador.Caption := desEnvComerOperador(env_comer_operador_e.Text );
      des_env_comer.Caption := desEnvComerProducto(env_comer_operador_e.Text, env_comer_producto_e.Text );
    end;
    kEnvComerProducto: des_env_comer.Caption := desEnvComerProducto(env_comer_operador_e.Text, env_comer_producto_e.Text );
    kEnvase:  txtMaster_c.Caption:= desEnvase( empresa_e.Text, master_e.Text );
  end;
end;

procedure TFMEnvases.producto_base_eChange(Sender: TObject);
begin
  //buscar descripcion
  descripcion_pb.text := desProductoBase(empresa_e.Text, producto_base_e.Text);
end;

procedure TFMEnvases.EnvaseClienteClick(Sender: TObject);
begin
  if not QEnvases.IsEmpty and (QEnvases.State = dsBrowse) then
  begin
    EnvaseClientePorEnvase(empresa_e.Text, producto_base_e.Text, envase_e.Text);
  end;
end;

procedure TFMEnvases.DSMaestroStateChange(Sender: TObject);
begin
  if not QEnvases.IsEmpty and (QEnvases.State = dsBrowse) then
  begin
    pnlEnvaseCliente.Font.Color := clBlue;
    pnlPasarSGP.Font.Color := clBlue;
  end
  else
  begin
    pnlEnvaseCliente.Font.Color := clGray;
    pnlPasarSGP.Font.Color := clGray;
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
end;

procedure TFMEnvases.FormDeactivate(Sender: TObject);
begin
  gRF := nil;
  gCF := nil;
end;

procedure TFMEnvases.tipo_iva_eChange(Sender: TObject);
begin
  if tipo_iva_e.Text = '' then
  begin
    lblDesTipoIva.Caption:= '';
  end
  else
  if tipo_iva_e.Text = '0' then
  begin
    lblDesTipoIva.Caption:= 'Superreducido';
  end
  else
  if tipo_iva_e.Text = '1' then
  begin
    lblDesTipoIva.Caption:= 'Reducido';
  end
  else
  if tipo_iva_e.Text = '2' then
  begin
    lblDesTipoIva.Caption:= 'General';
  end;
end;

procedure TFMEnvases.QEnvasesAfterOpen(DataSet: TDataSet);
begin
  QEan13.Open;
  QClientes.Open;
end;

procedure TFMEnvases.QEnvasesBeforeClose(DataSet: TDataSet);
begin
  QEan13.Close;
  QClientes.Close;
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
