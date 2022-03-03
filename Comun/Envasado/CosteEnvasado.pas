unit CosteEnvasado;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, Db, ExtCtrls,
  StdCtrls, Mask, DBCtrls, CMaestro, Buttons, ActnList, BSpeedButton, Grids,
  DBGrids, BGridButton, BGrid, BDEdit, ComCtrls, BEdit, dbTables, nbLabels,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinBlueprint, dxSkinFoggy, Menus, cxButtons,
  SimpleSearch, cxTextEdit, cxDBEdit, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, kbmMemTable, kbmMemCSVStreamFormat;

type
  TFCosteEnvasado = class(TMaestro)
    DSMaestro: TDataSource;
    QCosteEnvases: TQuery;
    QCosteEnvasesanyo_ec: TSmallintField;
    QCosteEnvasesmes_ec: TSmallintField;
    QCosteEnvasesempresa_ec: TStringField;
    QCosteEnvasesenvase_ec: TStringField;
    PMaestro: TPanel;
    lblCoste: TLabel;
    lblMes: TLabel;
    lblEmpresa: TLabel;
    lblProducto: TLabel;
    lblEnvse: TLabel;
    lbAnyo: TLabel;
    coste_ec: TBDEdit;
    mes_ec: TBDEdit;
    empresa_ec: TBDEdit;
    producto_ec: TBDEdit;
    anyo_ec: TBDEdit;
    des_mes: TnbStaticText;
    des_empresa: TnbStaticText;
    des_producto: TnbStaticText;
    des_envase: TnbStaticText;
    QCosteEnvasescentro_ec: TStringField;

    QCosteEnvasescoste_ec: TFloatField;
    QCosteEnvasesmaterial_ec: TFloatField;
    QCosteEnvasessecciones_ec: TFloatField;
    QCosteEnvasescoste_total: TFloatField;
    QCosteEnvasescostes_promedio_ec: TIntegerField;
    QCosteEnvasespcoste_ec: TFloatField;
    QCosteEnvasespmaterial_ec: TFloatField;
    QCosteEnvasespsecciones_ec: TFloatField;
    QCosteEnvasespcoste_total: TFloatField;

    lblCentro: TLabel;
    centro_ec: TBDEdit;
    des_centro: TnbStaticText;
    lblNombre1: TLabel;
    secciones_ec: TBDEdit;
    dbgEnvasado: TDBGrid;
    qGuia: TQuery;
    dsGuia: TDataSource;
    sqluGuia: TUpdateSQL;
    QCosteEnvasesdes_envase: TStringField;
    lbl1: TLabel;
    material_ec: TBDEdit;
    lblTotal: TLabel;
    edttotal_ec: TBDEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    edt2: TBDEdit;
    edtcoste_total: TBDEdit;
    lbl5: TLabel;
    edtpcoste_ec: TBDEdit;
    edtpsecciones_ec: TBDEdit;
    lbl7: TLabel;
    pnlBotones: TPanel;
    btnPromedioRegistro: TButton;
    btnTodos: TButton;
    lbl8: TLabel;
    QCosteEnvasesproducto_ec: TStringField;
    envase_ec: TcxDBTextEdit;
    ssEnvase: TSimpleSearch;
    btnCargarCSV: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure empresa_ecChange(Sender: TObject);
    procedure producto_ecChange(Sender: TObject);
    procedure envase_ecChange(Sender: TObject);
    procedure mes_ecChange(Sender: TObject);
    procedure centro_ecChange(Sender: TObject);
    procedure QCosteEnvasesCalcFields(DataSet: TDataSet);
    procedure qGuiaAfterOpen(DataSet: TDataSet);
    procedure qGuiaBeforeClose(DataSet: TDataSet);
    procedure QCosteEnvasesBeforePost(DataSet: TDataSet);
    procedure btnPromedioRegistroClick(Sender: TObject);
    procedure btnTodosClick(Sender: TObject);
    procedure envase_ecExit(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
    procedure btnCargarCSVClick(Sender: TObject);
    procedure CargarDatosCSV(FileName : string);
    procedure InsertarNuevosCostes(registros : TStringList);
    function Comprobaciones(KEmpresa, KEnvase, KProducto, KAnyo, KMes, KCentro, KEnvasado, KMaterial, KSeccion : string) : Boolean;
    function CheckExisteRegistros(registro : string): boolean;
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    sEmpresa, sAnyo, sMes, sCentro, sProducto: string;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;
    procedure Actualizar;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeLocalizar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;
    procedure AntesDeInsertar;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, UDMAuxDB, CReportes,
  CAuxiliarDB, Principal, DError, bSQLUtils, bTimeUtils,
  bDialogs, CosteEnvasadoPromedioDM, bTextUtils;

{$R *.DFM}

procedure TFCosteEnvasado.AbrirTablas;
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

procedure TFCosteEnvasado.CerrarTablas;
begin
     // Cerrar tabla
  if DataSetGuia.Active then DataSetGuia.Close;
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFCosteEnvasado.FormCreate(Sender: TObject);
begin
  des_empresa.Caption := '';
  des_centro.Caption := '';
  des_envase.Caption := '';
  des_producto.Caption := '';
  des_mes.Caption := '';

     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
  PMaestro.Height:= 180;

     //Fuente de datos maestro
    DataSetGuia := qGuia;
 {+}DataSetMaestro := QCosteEnvases;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT anyo_ec, mes_ec, empresa_ec, centro_ec, producto_ec FROM frf_env_costes ';
 {+}where := ' WHERE anyo_ec= 1000 ';
 {+}Order := ' GROUP BY anyo_ec, mes_ec, empresa_ec, centro_ec, producto_ec ' +
             ' ORDER BY anyo_ec desc, mes_ec desc, empresa_ec, centro_ec, producto_ec ';
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
  OnEdit := AntesDeModificar;
  OnBrowse:=AntesDeLocalizar;
  OnView := AntesDeVisualizar;
  OnInsert := AntesDeInsertar;
     //Focos
  {+}FocoAltas := empresa_ec;
  {+}FocoModificar := coste_ec;
  {+}FocoLocalizar := empresa_ec;

end;

{+ CUIDADIN }

procedure TFCosteEnvasado.FormActivate(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_SHOWNORMAL);
  if not DataSetMaestro.Active then Exit;
     //Formulario activo
  M := self;
  MD := nil;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
  Top:= 1;
end;


procedure TFCosteEnvasado.FormClose(Sender: TObject; var Action: TCloseAction);
var
  iRegistros: Integer;
begin
  if CosteEnvasadoPromedioDM.PromedioPendientes( iRegistros ) then
  begin
    //ShowMessage( 'Actualizados ' + IntToStr( iRegistros ) + ' registros.' )
  end
  else
  begin
    //ShowMessage( 'Todos los costes ya estaban calculados. ' );
  end;

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

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFCosteEnvasado.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFCosteEnvasado.Filtro;
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
        if Enabled then
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
    end
    else if (Objeto is TcxDBTextEdit) then
    begin
      with Objeto as TcxDBTextEdit do
      begin
        if Enabled then
        if Trim(Text) <> '' then
        begin
          if flag then where := where + ' AND ';
            where := where + ' ' + Name + ' LIKE ' + SQLFilter(Text);
          flag := True;
        end;
      end;
    end;
  end;
  if flag then where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFCosteEnvasado.AnyadirRegistro;
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

procedure TFCosteEnvasado.ValidarEntradaMaestro;
var
  flag: Boolean;
  i: Integer;
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

  sEmpresa:= empresa_ec.Text;
  sAnyo:= anyo_ec.Text;
  sMes:= mes_ec.Text;
  sCentro:= centro_ec.Text;
  sProducto:= producto_ec.Text;
  FocoAltas:= envase_ec;

  //comprobar que envase-producto correcto
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_envases ');
    SQL.Add(' where ( producto_e = :producto or producto_e is null ) ');
    SQL.Add(' and envase_e = :envase ');
    ParamByname('producto').AsString:= sProducto;
    ParamByname('envase').AsString:= envase_ec.Text;

    Open;
    flag:= IsEmpty;
    Close;
    if flag then
    begin
      raise Exception.Create(' El artículo-producto no es correcto.');
    end;
  end;

  (*
    RELENTIZA BASTANTE LA INSERCION, NO ACTIVAR SI NO SE PIDE
  //Comprobar que el envase se vendio en ese año-mes
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where empresa_sl ' + SQLEqualS( empresa_ec.Text ) );
    SQL.Add(' and producto_sl IN ');
    SQL.Add(' (SELECT producto_p ');
    SQL.Add('  FROM frf_productos ');
    SQL.Add('  WHERE empresa_p ' + SQLEqualS( empresa_ec.Text ) );
    SQL.Add('  AND producto_base_p ' + SQLEqualS( producto_base_ec.Text ) );
    SQL.Add(' ) ');
    SQL.Add(' and envase_sl ' + SQLEqualS( envase_ec.Text ) );
    SQL.Add(' and YEAR(fecha_sl)  ' + SQLEqualN( anyo_ec.Text ) );
    SQL.Add(' and MONTH(fecha_sl)  ' + SQLEqualN( mes_ec.Text ) );

    Open;
    flag:= IsEmpty;
    Close;
    if flag then
    begin
      raise Exception.Create(' El artículo ' +  QuotedSTr(envase_ec.Text) + ' no fue utilizado en ' +
                       desMes( mes_ec.Text ) + ' del ' + anyo_ec.Text);
    end;
  end;
  *)
end;

procedure TFCosteEnvasado.Previsualizar;
begin
  //
  Informar('Sin listado.');
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
procedure TFCosteEnvasado.AntesDeLocalizar;
begin
  PMaestro.Height:= 180;
  pnlBotones.Enabled:= False;
end;

procedure TFCosteEnvasado.AntesDeModificar;
var i: Integer;
begin
  pnlBotones.Enabled:= False;
//  btnCargarCSV.Enabled := False;
  PMaestro.Height:= 250;
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

procedure TFCosteEnvasado.AntesDeVisualizar;
var i: Integer;
begin
  pnlBotones.Enabled:= True;
  PMaestro.Height:= 180;
    //Resaturar estado
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := True;
  end;

  sEmpresa:= '';
  sAnyo:= '';
  sMes:= '';
  sCentro:= '';
  sProducto:= '';
  FocoAltas := empresa_ec;
end;

procedure TFCosteEnvasado.AntesDeInsertar;
begin
  PMaestro.Height:= 250;
  empresa_ec.Text:= sEmpresa;
  anyo_ec.Text:= sAnyo;
  mes_ec.Text:= sMes;
  centro_ec.Text:= sCentro;
  producto_ec.Text:= sProducto;
  pnlBotones.Enabled:= False;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFCosteEnvasado.RequiredTime(Sender: TObject;
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

procedure TFCosteEnvasado.ssEnvaseAntesEjecutar(Sender: TObject);
begin
    ssEnvase.SQLAdi := '';
    if producto_ec.Text <> '' then
      ssEnvase.SQLAdi := ' producto_e = ' +  QuotedStr(producto_ec.Text);
end;

procedure TFCosteEnvasado.empresa_ecChange(Sender: TObject);
begin
  if QCosteEnvases.State = dsBrowse then
    des_empresa.Caption := desEmpresa(QCosteEnvasesempresa_ec.Value)
  else
    des_empresa.Caption := desEmpresa(empresa_ec.Text);
end;

procedure TFCosteEnvasado.producto_ecChange(Sender: TObject);
begin
  if QCosteEnvases.State = dsBrowse then
    des_producto.Caption := desProducto(QCosteEnvasesempresa_ec.Value,
      QCosteEnvasesproducto_ec.AsString)
  else
    des_producto.Caption := desProducto(empresa_ec.Text,
      producto_ec.Text);
end;

procedure TFCosteEnvasado.envase_ecChange(Sender: TObject);
begin
  if QCosteEnvases.State = dsBrowse then
    des_envase.Caption := desEnvase(QCosteEnvasesempresa_ec.Value,
      QCosteEnvasesenvase_ec.Value)
  else
    des_envase.Caption := desEnvase(empresa_ec.text, envase_ec.Text);
end;

procedure TFCosteEnvasado.envase_ecExit(Sender: TObject);
begin
  if EsNumerico(envase_ec.Text) and (Length(envase_ec.Text) <= 5) then
    if (envase_ec.Text <> '' ) and (Length(envase_ec.Text) < 9) then
      envase_ec.Text := 'COM-' + Rellena( envase_ec.Text, 5, '0');
end;

procedure TFCosteEnvasado.mes_ecChange(Sender: TObject);
begin
  if QCosteEnvases.State = dsBrowse then
    des_mes.Caption := desMes(QCosteEnvasesmes_ec.Value)
  else
    des_mes.Caption := desMes(mes_ec.Text);
end;

procedure TFCosteEnvasado.centro_ecChange(Sender: TObject);
begin
  if QCosteEnvases.State = dsBrowse then
    des_centro.Caption := desCentro(QCosteEnvasesempresa_ec.Value,
      QCosteEnvasescentro_ec.AsString)
  else
    des_centro.Caption := desCentro(empresa_ec.Text, centro_ec.Text);
end;

procedure TFCosteEnvasado.QCosteEnvasesCalcFields(DataSet: TDataSet);
begin
  QCosteEnvasesdes_envase.AsString:= desEnvase( QCosteEnvasesempresa_ec.AsString, QCosteEnvasesenvase_ec.AsString );
  QCosteEnvasescoste_total.AsFloat:= QCosteEnvasescoste_ec.AsFloat + QCosteEnvasesmaterial_ec.AsFloat +  QCosteEnvasessecciones_ec.AsFloat ;
  QCosteEnvasespcoste_total.AsFloat:= QCosteEnvasespcoste_ec.AsFloat + QCosteEnvasespmaterial_ec.AsFloat +  QCosteEnvasespsecciones_ec.AsFloat ;
end;

procedure TFCosteEnvasado.qGuiaAfterOpen(DataSet: TDataSet);
begin
  //Abrir detalle
  QCosteEnvases.SQL.Clear;
  QCosteEnvases.SQL.Add('SELECT * FROM frf_env_costes ');
  if Trim(Where) <> '' then
  begin
    QCosteEnvases.SQL.Add( Where );
    QCosteEnvases.SQL.Add( ' and empresa_ec = :empresa_ec ');
  end
  else
  begin
    QCosteEnvases.SQL.Add( ' where empresa_ec = :empresa_ec ');
  end;
  QCosteEnvases.SQL.Add( ' and anyo_ec = :anyo_ec ');
  QCosteEnvases.SQL.Add( ' and mes_ec = :mes_ec ');
  QCosteEnvases.SQL.Add( ' and centro_ec = :centro_ec ');
  QCosteEnvases.SQL.Add( ' and producto_ec = :producto_ec ');
  QCosteEnvases.SQL.Add( ' ORDER BY envase_ec ');
  QCosteEnvases.Open;
end;

procedure TFCosteEnvasado.qGuiaBeforeClose(DataSet: TDataSet);
begin
  //cancelar cambios pendientes en la guia
  qGuia.CancelUpdates;
  //Cerrar detalle
  QCosteEnvases.Close;
end;

procedure TFCosteEnvasado.QCosteEnvasesBeforePost(DataSet: TDataSet);
begin
  if coste_ec.Text = '' then
    QCosteEnvasescoste_ec.AsFloat:= 0;
  if material_ec.Text = '' then
    QCosteEnvasesmaterial_ec.AsFloat:= 0;
  if secciones_ec.Text = '' then
    QCosteEnvasessecciones_ec.AsFloat:= 0;
  QCosteEnvasescostes_promedio_ec.AsFloat:= 0;
end;

procedure TFCosteEnvasado.Actualizar;
var
  Bookmark: TBookmark;
begin
  Bookmark:= QCosteEnvases.GetBookmark;
  QCosteEnvases.Close;
  QCosteEnvases.Open;
  QCosteEnvases.GotoBookmark( Bookmark );
  QCosteEnvases.FreeBookmark( Bookmark );
end;

procedure TFCosteEnvasado.btnPromedioRegistroClick(Sender: TObject);
var
  sMsg: string;
begin
  if not QCosteEnvases.IsEmpty then
  begin
    if CosteEnvasadoPromedioDM.PromedioRegistro( Self, QCosteEnvases.FieldByName('empresa_ec').AsString,
         QCosteEnvases.FieldByName('centro_ec').AsString, QCosteEnvases.FieldByName('envase_ec').AsString,
         QCosteEnvases.FieldByName('producto_ec').AsString, QCosteEnvases.FieldByName('producto_base_ec').AsInteger, QCosteEnvases.FieldByName('anyo_ec').AsInteger,
         QCosteEnvases.FieldByName('mes_ec').AsInteger, 1, sMsg ) then
    begin
      ShowMessage( 'Proceso finalizado correctamente.' );
      Actualizar;
    end
    else
    begin
      ShowMessage( sMsg );
    end;
  end
  else
  begin
    ShowMessage( 'Seleccione primero un envase valido.' );
  end;
end;

procedure TFCosteEnvasado.btnTodosClick(Sender: TObject);
var
  iRegistros: Integer;
begin
  if CosteEnvasadoPromedioDM.PromedioPendientes( iRegistros ) then
  begin
    Actualizar;
    ShowMessage( 'Actualizados ' + IntToStr( iRegistros ) + ' registros.' )
  end
  else
    ShowMessage( 'Todos los costes ya estaban calculados. ' );
end;

procedure TFCosteEnvasado.btnCargarCSVClick(Sender: TObject);
var
  sFile : string;
begin
  with TOpenDialog.Create(nil) do
  try
    Title := '  Abrir CSV.';
    Filter := 'Comma Separed File (*.csv)|*.csv';// + 'Documento EXCEL (*.xlsx)|*.xlsx|'; //'All filters ' + '(*.*)|*.*';//
    InitialDir := 'C:\';
    if not Execute() then
      ShowMessage('Debe seleccionar un archivo para iniciar la carga de valores.')
    else
    begin
      if FileExists(FileName) then
      begin
        sFile := FileName;
        CargarDatosCSV(sFile);
      end;
   end;
  finally
    Free;
  end;
end;

procedure TFCosteEnvasado.CargarDatosCSV(FileName : string);
var
  Registros : TStringList;
begin
  Registros := TStringList.Create;
  Registros.CommaText := ';';
  Registros.LoadFromFile(FileName);
  InsertarNuevosCostes(Registros);
end;


procedure  TFCosteEnvasado.InsertarNuevosCostes(registros : TStringList);
var
  KEmpresa, KEnvase, KProducto, KAnyo, KMes, KCentro, KEnvasado, KMaterial, KSeccion : string;
  QInsert: TQuery;
  sentencia, sentenciaComprobacion : string;
  puntero: Integer;
  sAux : String;

begin
  sentencia := ' insert into frf_env_costes(empresa_ec, anyo_ec, mes_ec, centro_ec, envase_ec, producto_ec, coste_ec, material_ec, secciones_ec) '
             + ' values(:empresa, :anyo, :mes, :centro, :envase, :producto, :envasado, :material, :seccion) ';
  QInsert := TQuery.Create(nil);
  QInsert.DatabaseName := 'BDProyecto';
  QInsert.SQL.Text := sentencia;

  for puntero := 0 to registros.Count - 1 do
  begin
    sAux := registros[puntero];
    //si existe el registro
    if not CheckExisteRegistros(sAux) then
       raise Exception.Create('Ya hay registros para el mes ' + Copy(sAux, 10, 2) + ' y año ' + Copy(sAux, 5, 4) + #10#13 +'. Revise los datos del regisro número ' + IntToStr( puntero+1 ) + '.');
    sAux := '';
  end;

  try
    //abrir transacción
    if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
      raise Exception.Create('Error al abrir transaccion en BD.');

    for puntero := 0 to registros.Count - 1 do
    begin
      sAux := registros[puntero];
      KEmpresa  := Copy(sAux, 1, 3);
      KAnyo     := Copy(sAux, 5, 4);
      KMes      := Copy(sAux, 10, 2);
      KCentro   := Copy(sAux, 13, 1);
      KEnvase   := Copy(sAux, 15, 9);
      KProducto := Copy(sAux, 25, 3);
      KEnvasado := Copy(sAux, 29, 6);
      KMaterial := Copy(sAux, 36, 6);
      KSeccion  := Copy(sAux, 43, 6);

      if Comprobaciones(KEmpresa, KEnvase, KProducto, KAnyo, KMes, KCentro, KEnvasado, KMaterial, KSeccion) then
      begin
        CancelarTransaccion(DMBaseDatos.DBBaseDatos);
        Exit;
      end
      else
      begin
        with QInsert do
        begin
          ParamByName('empresa').AsString := KEmpresa;
          ParamByName('anyo').AsInteger := strtoint(KAnyo);
          ParamByName('mes').AsInteger := strtoint(KMes);
          ParamByName('centro').AsInteger := strtoint(KCentro);
          ParamByName('envase').AsString := KEnvase;
          ParamByName('producto').AsString := KProducto;
          ParamByName('envasado').AsFloat := StrToFloat(KEnvasado);
          ParamByName('material').AsFloat := StrToFloat(KMaterial);
          ParamByName('seccion').AsFloat := StrToFloat(KSeccion);
          ExecSQL;
        end;
      end;
    end;  //fin bucle
      //aceptar transacción
      AceptarTransaccion(DMBaseDatos.DBBaseDatos);
      ShowMessage('Se han insertado ' + inttostr(puntero) + ' nuevos costes.');
    except
    on e: Exception do
      begin
        if DMBaseDatos.DBBaseDatos.InTransaction then
        begin
          CancelarTransaccion(DMBaseDatos.DBBaseDatos);
          ShowMessage('Error en la carga de datos. Revisar que la empresa tenga 3 dígitos, ' + #10#13 +
                      'el mes tenga 2 dígitos y los costes de envasado material y sección tengan 4 decimales.');

        end;

    end;
  end;
end;

function TFCosteEnvasado.Comprobaciones(KEmpresa, KEnvase, KProducto, KAnyo, KMes, KCentro, KEnvasado, KMaterial, KSeccion : string) : Boolean;
var
  status : Boolean;
begin
  //comprobar la empresa
  status := False;
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_empresas where empresa_e = ' + Quotedstr(KEmpresa));
    Open;
    if IsEmpty then
    begin
      ShowMessage('La empresa ' + KEmpresa + ' no existe.');
      result := True;
    end;
  end;

  //comprobar que el mes sea >= 1 y <= 12
  if (strtoint(KMes) <= 0) or (strtoint(KMes) >= 13) then
  begin
    ShowMessage('El mes ' + KMes + ' no es correcto.');
    result := True;
  end;

  //comprobar que el año sea correcto
  if length(KAnyo) <> 4 then
  begin
    ShowMessage('El año es incorrecto, has introducido : ' + KAnyo);
    result := True;
  end;

  //comprobar costes sean > 0
  if (strtofloat(KEnvasado) < 0) and (strtofloat(KMaterial) < 0) and (strtofloat(KSeccion) < 0) then
  begin
    ShowMessage('Hay algún coste que es negativo: ' + #13 + 'Envasado = ' + KEnvasado + #13
                                                          + 'Material = ' + KMaterial + #13
                                                          + 'Seccion = ' + KSeccion);
    result := True;
  end;

  //comprobar centro
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_centros where centro_c = ' + Quotedstr(KCentro));
    Open;
    if IsEmpty then
    begin
      ShowMessage('El centro ' + KCentro + ' no existe.');
      result := True;
    end;
  end;

  //comprobar envase
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_envases where envase_e = ' + Quotedstr(KEnvase));
    Open;
    if IsEmpty then
    begin
      ShowMessage('El envase ' + KEnvase + ' no existe.');
      result := True;
    end;
  end;

  //comprobar producto
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_productos where producto_p = ' + Quotedstr(KProducto));
    Open;
    if IsEmpty then
    begin
      ShowMessage('El Producto ' + KProducto + ' no existe.');
      result := True;
    end;
  end;

end;

function TFCosteEnvasado.CheckExisteRegistros(registro : string): boolean;
var
  sentenciaComprobacion : string;
  QComprobacion : TQuery;
begin
  sentenciaComprobacion := 'select count(*) as total from frf_env_costes where anyo_ec = :anyo and mes_ec = :mes';
  QComprobacion := TQuery.Create(nil);
  with QComprobacion do
  begin
    DatabaseName := 'BDProyecto';
    SQL.Text := sentenciaComprobacion;
    ParamByName('anyo').asInteger := StrToInt(Copy(registro, 5, 4));
    ParamByName('mes').asInteger := StrToInt(Copy(registro, 10, 2));
    Open;
    if (FieldByName('total').asInteger = 0) then
      result := true
    else
      result := false;
  end;
end;

end.
