unit Inventario;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, Graphics,
  Db, ComCtrls, BCalendario, Grids, DBGrids, Qrctrls, ActnList,
  BGrid, StdCtrls, BEdit, BDEdit, ExtCtrls, DBCtrls, BGridButton, Buttons,
  BSpeedButton, BCalendarButton, CMaestroDetalle, DBTables, QuickRpt,
  nbLabels, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlueprint, dxSkinFoggy, Menus,
  cxButtons, SimpleSearch, cxTextEdit, cxDBEdit, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TFInventario = class(TMaestroDetalle)
    PMaestro: TPanel;
    Panel1: TPanel;
    PDetalle: TPanel;
    DSMaestro: TDataSource;
    DSDetalle: TDataSource;
    LEmpresa_p: TLabel;
    LAno_semana_p: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    lbl_kilos_cim: TLabel;
    lbl_kilos_cia: TLabel;
    lbl_kilos_zd: TLabel;
    lbl_kilos_cim_c1_ic: TLabel;
    lbl_kilos_zd_c3_ic: TLabel;
    lbl_kilos_cim_c2_ic: TLabel;
    lbl_kilos_zd_d_ic: TLabel;
    centro_ic: TBDEdit;
    producto_ic: TBDEdit;
    fecha_ic: TBDEdit;
    kilos_cec_ic: TBDEdit;
    empresa_ic: TBDEdit;
    kilos_cim_c1_ic: TBDEdit;
    kilos_cia_c1_ic: TBDEdit;
    kilos_zd_c3_ic: TBDEdit;
    kilos_cim_c2_ic: TBDEdit;
    kilos_cia_c2_ic: TBDEdit;
    kilos_zd_d_ic: TBDEdit;
    RejillaDetalle: TDBGrid;
    lblKilos2: TLabel;
    lblKilos1: TLabel;
    kilos_ce_c2_il: TBDEdit;
    kilos_ce_c1_il: TBDEdit;
    Label15: TLabel;
    Label16: TLabel;
    notas_ic: TDBMemo;
    Label1: TLabel;
    Bevel5: TBevel;
    lblCajas2: TLabel;
    lblCajas1: TLabel;
    cajas_ce_c2_il: TBDEdit;
    cajas_ce_c1_il: TBDEdit;
    lblDesEnvase: TnbStaticText;
    lbl_des_empresa: TnbStaticText;
    lbl_des_producto: TnbStaticText;
    lbl_des_centro: TnbStaticText;
    lblCalibre: TLabel;
    calibre_il: TBDEdit;
    lblCalibreIOptativo: TLabel;
    kilos_ajuste_c1_ic: TBDEdit;
    kilos_ajuste_c2_ic: TBDEdit;
    lblAjustes: TLabel;
    lbl1: TLabel;
    kilos_ajuste_c3_ic: TBDEdit;
    kilos_ajuste_cd_ic: TBDEdit;
    kilos_ajuste_campo_ic: TBDEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    bvl1: TBevel;
    bvl2: TBevel;
    bvl3: TBevel;
    envase_il: TcxDBTextEdit;
    ssEnvase: TSimpleSearch;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RequiredTime(Sender: TObject;
      var isTime: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure envase_ilChange(Sender: TObject);
    procedure cajas_ce_c1_ilChange(Sender: TObject);
    procedure cajas_ce_c2_ilChange(Sender: TObject);
    procedure notas_icEnter(Sender: TObject);
    procedure notas_icExit(Sender: TObject);
    procedure empresa_icChange(Sender: TObject);
    procedure centro_icChange(Sender: TObject);
    procedure producto_icChange(Sender: TObject);
    procedure envase_ilExit(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
  private
    { Private declarations }
    ListaMaestro: TList;
    ListaDetalle: TList;
    Objeto: TObject;
    rKilosEnvase: real;
    iAnchoPanel: integer;

    procedure AbrirTablas;
    procedure ValidarEntradaMaestro;
    procedure ValidarEntradaDetalle;
    procedure ActualizarKilos;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeModificar;
    procedure AntesDeVisualizar;
    procedure AntesDeInsertar;
    procedure EditarDetalle;
    procedure VerDetalle;

    //Listado
    procedure Previsualizar; override;
  end;

var
  FInventario: TFInventario;

implementation

uses CVariables, CGestionPrincipal, DError, CAuxiliarDB, Principal, CReportes,
  DPreview, UDMBaseDatos, UDMAuxDB, bSQLUtils, InventarioData, InventarioReport,
  CMaestro, Variants, UDMConfig, bTextUtils;

{$R *.DFM}

procedure TFInventario.AbrirTablas;
begin
     // Abrir tablas/Querys
  if not DataSetMaestro.Active then
  begin
    DataSetMaestro.SQL.Clear;
    DataSetMaestro.SQL.Add(Select);
    DataSetMaestro.SQL.Add(Where);
    DataSetMaestro.SQL.Add(Order);
    DataSetMaestro.Open;
         //DataSourceDetalle.DataSet.Open;
  end;
     //Estado inicial
  Registros := 0;
  if registros > 0 then
    Registro := 1
  else
    Registro := 0;
  RegistrosInsertados := 0;
end;


//************************** CREAMOS EL FORMULARIO ************************

procedure TFInventario.FormCreate(Sender: TObject);
begin
  InventarioData.Create;

  LineasObligadas := false; //Podemos tener cabecera sin Lines

     //Variables globales
  M := Self; //Formulario maestro --> siempre es necesario
  MD := Self; //:=Self;  -->Formulario Maestro-Detalle

  gRF := nil;
  gCF := nil;

     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
  PanelDetalle := PDetalle;

     //***************************************************************
     //Fuente de datos maestro
  DataSetMaestro := DMInventario.QInventarioCab;
  DataSourceDetalle := DSDetalle;
  RejillaVisualizacion := RejillaDetalle;

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_inventarios_c ';
 {+}where := ' WHERE empresa_ic=' + QUOTEDSTR('###');
 {+}Order := ' ORDER BY fecha_ic desc, empresa_ic, centro_ic, producto_ic ';

     //Estado inicial
  Registros := 0;
  Registro := 0;
  RegistrosInsertados := 0;

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

     //Lista de componentes, para optimizar recorrido
  ListaMaestro := TList.Create;
  PMaestro.GetTabOrderList(ListaMaestro);
  ListaDetalle := TList.Create;
  PDetalle.GetTabOrderList(ListaDetalle);

      //Sólo necesario si utilizamos la rejilla despegable
      //pero si no lo borras no pasa nada - deberias borrarlo
  DMBAseDatos.QDespegables.Tag := kNull;

  PMaestro.Tag := kMaestro;

{*DEJAR LAS QUE SEAN NECESARIAS}
     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnValidateDetailConstrains := ValidarEntradaDetalle;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;
  OnInsert := AntesDeInsertar;
  OnBrowse := AntesDeInsertar;
  OnEditDetail := EditarDetalle;
  onViewDetail := verDetalle;


     //Focos
  FocoAltas := empresa_ic;
  FocoModificar := kilos_cec_ic;
  FocoLocalizar := empresa_ic;
  FocoDetalle := envase_il;

     //Inicializar variables
  PDetalle.Height := 32;


     //Muestra la barra de herramientas de Maestro/Detalle
     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> CVariables.tfMaestroDetalle then
  begin
    FormType := CVariables.tfMaestroDetalle;
    BHFormulario;
  end;


  //Visualizar estado inicial
  Visualizar;
  if ( DMConfig.EsLaFont ) or ( DMConfig.EsLasMoradas ) then
  begin
    iAnchoPanel:= 143;
  end
  else
  begin
    calibre_il.Visible:= false;
    lblCalibreIOptativo.Visible:= false;
    lblCalibre.Visible:= false;
    lblCajas1.Top:= 62;
    cajas_ce_c1_il.Top:= 61;
    lblKilos1.Top:= 62;
    kilos_ce_c1_il.Top:= 61;
    lblCajas2.Top:= 85;
    cajas_ce_c2_il.Top:= 84;
    lblKilos2.Top:= 85;
    kilos_ce_c2_il.Top:= 84;
    iAnchoPanel:= 120;
  end;
end;

procedure TFInventario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListaMaestro.Free;
  ListaDetalle.Free;
  FreeAndNil(DMInventario);

  //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  //Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF := nil;

  // Cambia acción por defecto para Form hijas en una aplicación MDI
  // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFInventario.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
 case key of
    vk_Return, vk_down:
      begin
        if not notas_ic.Focused then
        begin
          Key := 0;
          PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        end;
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

procedure TFInventario.Filtro;
var Flag: Boolean;
  i: Integer;
begin
  where := ''; Flag := false;
  for i := 0 to ListaMaestro.Count - 1 do
  begin
    Objeto := ListaMaestro.Items[i];
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

//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que son insertados
//para, else fin usa los campos que marcamos como PrimaryKey

procedure TFInventario.AnyadirRegistro;
var Flag: Boolean;
  i: Integer;
begin
  Flag := false;
  if where <> '' then where := where + ' OR ('
  else where := ' WHERE (';

  for i := 0 to ListaMaestro.Count - 1 do
  begin
    objeto := ListaMaestro.Items[i];
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

procedure TFInventario.ValidarEntradaMaestro;
begin
  (*TODO*)
    //Que no hayan campos vacios
   { if Trim(empresa_pc.Text)='' then
    begin
       empresa_pc.SetFocus;
       raise Exception.Create('Faltan Datos.');
    end;
    if Trim(centro_pc.Text)='' then
    begin
       centro_pc.SetFocus;
       raise Exception.Create('Faltan Datos.');
    end;
    if Trim(producto_pc.Text)='' then
    begin
       producto_pc.SetFocus;
       raise Exception.Create('Faltan Datos.');
    end;
    if Trim(fecha_pc.Text)='' then
    begin
       fecha_pc.SetFocus;
       raise Exception.Create('Faltan Datos.');
    end;
    }
    if Trim(kilos_cec_ic.Text)  = '' then
      DMInventario.QInventarioCab.FieldByName('kilos_cec_ic').AsFloat:= 0;
    if Trim(kilos_cim_c1_ic.Text)  = '' then
      DMInventario.QInventarioCab.FieldByName('kilos_cim_c1_ic').AsFloat:= 0;
    if Trim(kilos_cim_c2_ic.Text)  = '' then
      DMInventario.QInventarioCab.FieldByName('kilos_cim_c2_ic').AsFloat:= 0;
    if Trim(kilos_cia_c1_ic.Text)  = '' then
      DMInventario.QInventarioCab.FieldByName('kilos_cia_c1_ic').AsFloat:= 0;
    if Trim(kilos_cia_c2_ic.Text)  = '' then
      DMInventario.QInventarioCab.FieldByName('kilos_cia_c2_ic').AsFloat:= 0;
    if Trim(kilos_zd_c3_ic.Text)  = '' then
      DMInventario.QInventarioCab.FieldByName('kilos_zd_c3_ic').AsFloat:= 0;
    if Trim(kilos_zd_d_ic.Text)  = '' then
      DMInventario.QInventarioCab.FieldByName('kilos_zd_d_ic').AsFloat:= 0;
end;

procedure TFInventario.ValidarEntradaDetalle;
var
  sAux: String;
begin
  //Que exista el calibre
  if Trim(calibre_il.Text) = '' then
  begin
    DMInventario.QInventarioLin.FieldByName('calibre_il').Value:= NULL;
  end;

  if Trim(cajas_ce_c1_il.Text)  = '' then
    DMInventario.QInventarioLin.FieldByName('cajas_ce_c1_il').AsFloat:= 0;
  if Trim(kilos_ce_c1_il.Text)  = '' then
    DMInventario.QInventarioLin.FieldByName('kilos_ce_c1_il').AsFloat:= 0;
  if Trim(cajas_ce_c2_il.Text)  = '' then
    DMInventario.QInventarioLin.FieldByName('cajas_ce_c2_il').AsFloat:= 0;
  if Trim(kilos_ce_c2_il.Text)  = '' then
    DMInventario.QInventarioLin.FieldByName('kilos_ce_c2_il').AsFloat:= 0;

  //Que el artículo este dado de alta para el producto seleccionado
  sAux := desEnvaseProducto( empresa_ic.Text,envase_il.Text, producto_ic.Text);
  if sAux = '' then
  begin
    raise Exception.Create('Envase no valido para el producto seleccionado.');
  end;
end;

procedure ConfeccionadoDia( const AEmpresa, ACentro, AProducto: string;
                            const AFecha: TDateTime;
                            var   AConfeccionadoCat1, AConfeccionadoCat2: Real;
                            var   ASalidasCat1, ASalidasCat2: Real;
                            var   ATransitosCat1, ATransitosCat2: Real;
                            var   AExistenciasCat1, AExistenciasCat2: Real );
var
  Query: TQuery;
begin
  Query:= TQuery.Create( nil );
  Query.DatabaseName:= 'BDProyecto';

  try
    Query.SQL.Add(' select sum(kilos_ce_c1_il) cat1, sum(kilos_ce_c2_il) cat2 ');
    Query.SQL.Add(' from frf_inventarios_c, frf_inventarios_l ');
    Query.SQL.Add(' where empresa_ic = :empresa ');
    Query.SQL.Add(' and centro_ic = :centro ');
    Query.SQL.Add(' and fecha_ic = :fecha ');
    Query.SQL.Add(' and producto_ic = :producto ');

    Query.SQL.Add(' and empresa_il = empresa_ic ');
    Query.SQL.Add(' and centro_il = centro_ic ');
    Query.SQL.Add(' and producto_il = producto_ic ');
    Query.SQL.Add(' and fecha_il = fecha_ic; ');

    //HAY EN LA CAMARA DE EXPEDICIONES
    Query.ParamByName('empresa').AsString:= AEmpresa;
    Query.ParamByName('centro').AsString:= ACentro;
    Query.ParamByName('producto').AsString:= AProducto;
    Query.ParamByName('fecha').AsDate:= AFecha;

    Query.Open;
    AConfeccionadoCat1:= Query.fieldByName('cat1').AsFloat;
    AConfeccionadoCat2:= Query.fieldByName('cat2').AsFloat;
    Query.Close;

    //MENOS KILOS HABIAN CAMARA EXPEDICIONES
    Query.ParamByName('fecha').AsDate:= AFecha-1;

    Query.Open;
    AExistenciasCat1:= Query.fieldByName('cat1').AsFloat;
    AExistenciasCat2:= Query.fieldByName('cat2').AsFloat;
    AConfeccionadoCat1:= AConfeccionadoCat1 - AExistenciasCat1;
    AConfeccionadoCat2:= AConfeccionadoCat2 - AExistenciasCat2;
    Query.Close;


    //MAS KILOS SALIDA DIRECTA
    Query.SQL.Clear;
    Query.SQL.Add(' select sum(kilos_sl) kilos ');
    Query.SQL.Add(' from frf_salidas_c, frf_salidas_l ');

    Query.SQL.Add(' where empresa_sc = :empresa ');
    Query.SQL.Add(' and centro_salida_sc = :centro ');
    Query.SQL.Add(' and fecha_sc = :fecha ');
    Query.SQL.Add(' and es_transito_sc = 0 ');

    Query.SQL.Add(' and empresa_sl = :empresa ');
    Query.SQL.Add(' and centro_salida_sl = :centro ');
    Query.SQL.Add(' and n_albaran_sl = n_albaran_sc ');
    Query.SQL.Add(' and fecha_sl = :fecha ');
    Query.SQL.Add(' and centro_origen_sl = :centro ');

    Query.SQL.Add(' and producto_sl = :producto ');
    Query.SQL.Add(' and categoria_sl = :categoria ');

    Query.ParamByName('empresa').AsString:= AEmpresa;
    Query.ParamByName('centro').AsString:= ACentro;
    Query.ParamByName('producto').AsString:= AProducto;
    Query.ParamByName('fecha').AsDate:= AFecha;
    Query.ParamByName('categoria').AsString:= '1';
    Query.Open;

    ASalidasCat1:= Query.fieldByName('kilos').AsFloat;
    AConfeccionadoCat1:= AConfeccionadoCat1 + ASalidasCat1;
    Query.Close;

    Query.ParamByName('categoria').AsString:= '2';
    Query.Open;

    ASalidasCat2:= Query.fieldByName('kilos').AsFloat;
    AConfeccionadoCat2:= AConfeccionadoCat2 + ASalidasCat2;
    Query.Close;

    //MAS KILOS TRANSITO DIRECTO
    Query.SQL.Clear;
    Query.SQL.Add(' select sum(kilos_tl) kilos');
    Query.SQL.Add(' from frf_transitos_l ');
    Query.SQL.Add(' where empresa_tl = :empresa ');
    Query.SQL.Add(' and centro_tl = :centro ');
    Query.SQL.Add(' and centro_origen_tl = :centro ');
    Query.SQL.Add(' and fecha_tl = :fecha ');
    Query.SQL.Add(' and producto_tl = :producto ');
    Query.SQL.Add(' and categoria_tl = :categoria ');

    Query.ParamByName('empresa').AsString:= AEmpresa;
    Query.ParamByName('centro').AsString:= ACentro;
    Query.ParamByName('producto').AsString:= AProducto;
    Query.ParamByName('fecha').AsDate:= AFecha;
    Query.ParamByName('categoria').AsString:= '1';
    Query.Open;

    ATransitosCat1:= Query.fieldByName('kilos').AsFloat;
    AConfeccionadoCat1:= AConfeccionadoCat1 + ATransitosCat1;
    Query.Close;

    Query.ParamByName('categoria').AsString:= '2';
    Query.Open;

    ATransitosCat2:= Query.fieldByName('kilos').AsFloat;
    AConfeccionadoCat2:= AConfeccionadoCat2 + ATransitosCat2;
    Query.Close;

  finally
    FreeAndNil( Query );
  end;
end;


procedure TFInventario.Previsualizar;
var
  QRInventario: TQRInventario;
  conf1, conf2, sal1, sal2, tran1, tran2, exis1, exis2: Real;
begin
  DSDetalle.Enabled := false;
  QRInventario := TQRInventario.Create(Self);
  try
    PonLogoGrupoBonnysa(QRInventario, empresa_ic.Text);
    conf1:= 0;
    conf2:= 0;
    ConfeccionadoDia( empresa_ic.Text, centro_ic.Text, producto_ic.Text, StrToDate( fecha_ic.Text ) ,
                    conf1, conf2, sal1, sal2, tran1, tran2, exis1, exis2 );
    QRInventario.LoadConfeccionado( conf1, conf2, sal1, sal2, tran1, tran2, exis1, exis2 );
    Preview(QRInventario);
    DSDetalle.DataSet.First;
    DSDetalle.Enabled := true;
  except
    FreeAndNil(QRInventario);
    DSDetalle.DataSet.First;
    DSDetalle.Enabled := true;
    Raise;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//*****************************************************************************
//*****************************************************************************

procedure TFInventario.AntesDeVisualizar;
var i: Integer;
begin
  PDetalle.Height := 32;

    //Restauramos estado controles
  for i := 0 to ListaMaestro.Count - 1 do
  begin
    Objeto := ListaMaestro.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          if Enabled = false then Enabled := true;
  end;
end;

procedure TFInventario.AntesDeInsertar;
begin
  PDetalle.Height := 32;
end;

procedure TFInventario.AntesDeModificar;
var i: Integer;
begin
  for i := 0 to ListaMaestro.Count - 1 do
  begin
    Objeto := ListaMaestro.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;
end;

procedure TFInventario.EditarDetalle;
begin
  PDetalle.Height := iAnchoPanel;
end;

procedure TFInventario.VerDetalle;
begin
  PDetalle.Height := 32;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************
//Para saber cuando tenemos que obligar a que un campo sea requerido

procedure TFInventario.RequiredTime(Sender: TObject;
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


procedure TFInventario.ssEnvaseAntesEjecutar(Sender: TObject);
begin
    ssEnvase.SQLAdi := '';
    if producto_ic.Text <> '' then
      ssEnvase.SQLAdi := ' producto_e = ' +  QuotedStr(producto_ic.Text);
end;

procedure TFInventario.FormActivate(Sender: TObject);
begin
  Top := 1;
end;

procedure TFInventario.FormDestroy(Sender: TObject);
begin
  InventarioData.Destroy;
end;

procedure TFInventario.envase_ilChange(Sender: TObject);
begin
  rKilosEnvase:= KilosEnvase(empresa_ic.Text, envase_il.Text, producto_ic.Text );
    lblDesEnvase.Caption:= desEnvase(empresa_ic.Text, envase_il.Text);
  if DataSourceDetalle.DataSet.State in [dsInsert, dsEdit] then
  begin
    ActualizarKilos;
//    lblDesEnvase.Caption:= desEnvase(empresa_ic.Text, envase_il.Text);
  end;
end;

procedure TFInventario.envase_ilExit(Sender: TObject);
begin
  if EsNumerico(envase_il.Text) and (Length(envase_il.Text) <= 5) then
    if (envase_il.Text <> '' ) and (Length(envase_il.Text) < 9) then
      envase_il.Text := 'COM-' + Rellena( envase_il.Text, 5, '0');
end;

procedure TFInventario.ActualizarKilos;
var
  bFlag1, bFlag2: boolean;
  iAux: integer;
begin
  bFlag1:= true;
  bFlag2:= true;
  if ( trim( cajas_ce_c2_il.Text ) = '' ) then
  begin
    kilos_ce_c2_il.Text:= '';
    bFlag2:= False;
  end
  else
  if ( strtoint( cajas_ce_c2_il.Text ) = 0 ) then
  begin
    kilos_ce_c2_il.Text:= '0';
    bFlag2:= False;
  end;

  if ( trim( cajas_ce_c1_il.Text ) = '' ) then
  begin
    kilos_ce_c1_il.Text:= '';
    bFlag1:= False;
  end
  else
  if ( strtoint( cajas_ce_c1_il.Text ) = 0 ) then
  begin
    kilos_ce_c1_il.Text:= '0';
    bFlag1:= False;
  end;

  if rKilosEnvase <> 0 then
  begin
    if bFlag2 then
    begin
      iAux:= strtoint( cajas_ce_c2_il.Text );
      kilos_ce_c2_il.Text:= FloatToStr( iAux * rKilosEnvase );
    end;
    if bFlag1 then
    begin
      iAux:= strtoint( cajas_ce_c1_il.Text );
      kilos_ce_c1_il.Text:= FloatToStr( iAux * rKilosEnvase );
    end;
  end;
end;

procedure TFInventario.cajas_ce_c1_ilChange(Sender: TObject);
begin
  if DataSourceDetalle.DataSet.State in [dsInsert, dsEdit] then
    ActualizarKilos;
end;

procedure TFInventario.cajas_ce_c2_ilChange(Sender: TObject);
begin
  if DataSourceDetalle.DataSet.State in [dsInsert, dsEdit] then
    ActualizarKilos;
end;

procedure TFInventario.notas_icEnter(Sender: TObject);
begin
  notas_ic.Color:= clMoneyGreen;
end;

procedure TFInventario.notas_icExit(Sender: TObject);
begin
  notas_ic.Color:= clWhite;
end;

procedure TFInventario.empresa_icChange(Sender: TObject);
begin
  lbl_des_empresa.Caption:= desEmpresa(empresa_ic.Text);
end;

procedure TFInventario.centro_icChange(Sender: TObject);
begin
  lbl_des_centro.Caption:= desCentro(empresa_ic.Text, centro_ic.Text);
end;

procedure TFInventario.producto_icChange(Sender: TObject);
begin
  lbl_des_producto.Caption:= desProducto(empresa_ic.Text, producto_ic.Text);
end;

end.
