unit SobrepesoEnvasado;

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
  dxSkinXmas2008Blue;

type
  TFSobrepesoEnvasado = class(TMaestro)
    DSMaestro: TDataSource;
    QCosteEnvases: TQuery;
    PMaestro: TPanel;
    lblPeso: TLabel;
    lblMes: TLabel;
    lblEmpresa: TLabel;
    lblEnvase: TLabel;
    lblAnyo: TLabel;
    peso_es: TBDEdit;
    mes_es: TBDEdit;
    empresa_es: TBDEdit;
    anyo_es: TBDEdit;
    des_mes: TnbStaticText;
    des_empresa: TnbStaticText;
    des_envase: TnbStaticText;
    QCosteEnvasesempresa_es: TStringField;
    QCosteEnvasesanyo_es: TSmallintField;
    QCosteEnvasesmes_es: TSmallintField;
    QCosteEnvasesenvase_es: TStringField;
    QCosteEnvasespeso_es: TFloatField;
    lblProducto: TLabel;
    producto_es: TBDEdit;
    des_producto: TnbStaticText;
    Label1: TLabel;
    dbgEnvasado: TDBGrid;
    qGuia: TQuery;
    dsGuia: TDataSource;
    sqluGuia: TUpdateSQL;
    QCosteEnvasesdes_envase: TStringField;
    QCosteEnvasesproducto_es: TStringField;
    envase_es: TcxDBTextEdit;
    ssEnvase: TSimpleSearch;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure empresa_esChange(Sender: TObject);
    procedure envase_esChange(Sender: TObject);
    procedure mes_esChange(Sender: TObject);
    procedure producto_esChange(Sender: TObject);
    procedure QCosteEnvasesCalcFields(DataSet: TDataSet);
    procedure qGuiaAfterOpen(DataSet: TDataSet);
    procedure qGuiaBeforeClose(DataSet: TDataSet);
    procedure envase_esExit(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;
    empresa, anyo, mes, producto: string;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeLocalizar;
    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, UDMAuxDB, CReportes,
  CAuxiliarDB, Principal, DError, DPreview, bSQLUtils, bTimeUtils, bTextUtils;

{$R *.DFM}

procedure TFSobrepesoEnvasado.AbrirTablas;
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

procedure TFSobrepesoEnvasado.CerrarTablas;
begin
     // Cerrar tabla
  if DataSetGuia.Active then DataSetGuia.Close;
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFSobrepesoEnvasado.FormCreate(Sender: TObject);
begin
  des_empresa.Caption := '';
  des_envase.Caption := '';
  des_producto.Caption := '';
  des_mes.Caption := '';

     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
  PMaestro.Height:= 124;

     //Fuente de datos maestro
    DataSetGuia := qGuia; 
 {+}DataSetMaestro := QCosteEnvases;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT empresa_es, anyo_es, mes_es, producto_es FROM frf_env_sobrepeso ';
 {+}where := ' WHERE anyo_es= 1000 ';
 {+}Order := ' GROUP BY empresa_es, anyo_es, mes_es, producto_es '  +
             ' ORDER BY anyo_es desc, mes_es desc, empresa_es, producto_es ';
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
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnBrowse:=AntesDeLocalizar;
  OnView := AntesDeVisualizar;
     //Focos
  {+}FocoAltas := empresa_es;
  {+}FocoModificar := peso_es;
  {+}FocoLocalizar := empresa_es;

end;

{+ CUIDADIN }

procedure TFSobrepesoEnvasado.FormActivate(Sender: TObject);
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
end;


procedure TFSobrepesoEnvasado.FormClose(Sender: TObject; var Action: TCloseAction);
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

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFSobrepesoEnvasado.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFSobrepesoEnvasado.Filtro;
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
  if flag then where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFSobrepesoEnvasado.AnyadirRegistro;
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

procedure TFSobrepesoEnvasado.ValidarEntradaMaestro;
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

  empresa := empresa_es.Text;
  anyo := anyo_es.Text;
  mes := mes_es.Text;
  producto:= producto_es.Text;

  //comprobar que envase-producto correcto
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_envases ');
    SQL.Add(' where ( producto_e = :producto or producto_e is null ) ');
    SQL.Add(' and envase_e = :envase ');
    ParamByname('producto').AsString:= producto_es.Text;
    ParamByname('envase').AsString:= envase_es.Text;

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
  //Comprobar que el artículo se vendio en ese año-mes
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

procedure TFSobrepesoEnvasado.Previsualizar;
begin
  //
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

procedure TFSobrepesoEnvasado.AntesDeLocalizar;
begin
  PMaestro.Height:= 188;
end;

procedure TFSobrepesoEnvasado.AntesDeInsertar;
begin
  PMaestro.Height:= 188;
  if empresa = '' then
  begin
    FocoAltas := empresa_es;
  end
  else
  begin
    QCosteEnvases.FieldByName('empresa_es').AsString:= empresa;
    QCosteEnvases.FieldByName('anyo_es').AsString:= anyo;
    QCosteEnvases.FieldByName('mes_es').AsString:= mes;
    QCosteEnvases.FieldByName('producto_es').AsString:= producto;
    FocoAltas := producto_es;
  end;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFSobrepesoEnvasado.AntesDeModificar;
var i: Integer;
begin
  PMaestro.Height:= 188;
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

procedure TFSobrepesoEnvasado.AntesDeVisualizar;
var i: Integer;
begin
  PMaestro.Height:= 124;
    //Resaturar estado
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := True;
  end;
  empresa := '';
  anyo := '';
  mes := '';
  producto:= '';
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFSobrepesoEnvasado.RequiredTime(Sender: TObject;
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

procedure TFSobrepesoEnvasado.ssEnvaseAntesEjecutar(Sender: TObject);
begin
    ssEnvase.SQLAdi := '';
    if producto_es.Text <> '' then
      ssEnvase.SQLAdi := ' producto_e = ' +  QuotedStr(producto_es.Text);
end;

procedure TFSobrepesoEnvasado.empresa_esChange(Sender: TObject);
begin
  if QCosteEnvases.State = dsBrowse then
    des_empresa.Caption := desEmpresa(QCosteEnvasesempresa_es.Value)
  else
    des_empresa.Caption := desEmpresa(empresa_es.Text);
end;

procedure TFSobrepesoEnvasado.envase_esChange(Sender: TObject);
begin
  if QCosteEnvases.State = dsBrowse then
    des_envase.Caption := desEnvase(QCosteEnvasesempresa_es.Text, QCosteEnvasesenvase_es.Value)
  else
    des_envase.Caption := desEnvase(empresa_es.Text, envase_es.Text);
end;

procedure TFSobrepesoEnvasado.envase_esExit(Sender: TObject);
begin
  if EsNumerico(envase_es.Text) and (Length(envase_es.Text) <= 5) then
    if (envase_es.Text <> '' ) and (Length(envase_es.Text) < 9) then
      envase_es.Text := 'COM-' + Rellena( envase_es.Text, 5, '0');
end;

procedure TFSobrepesoEnvasado.mes_esChange(Sender: TObject);
begin
  if QCosteEnvases.State = dsBrowse then
    des_mes.Caption := desMes(QCosteEnvasesmes_es.Value)
  else
    des_mes.Caption := desMes(mes_es.Text);
end;

procedure TFSobrepesoEnvasado.producto_esChange(Sender: TObject);
begin
  if QCosteEnvases.State = dsBrowse then
    des_producto.Caption := desProducto(QCosteEnvasesempresa_es.Value,
      QCosteEnvasesproducto_es.AsString)
  else
    des_producto.Caption := desProducto(empresa_es.Text,
      producto_es.Text);

end;

procedure TFSobrepesoEnvasado.QCosteEnvasesCalcFields(DataSet: TDataSet);
begin
  QCosteEnvasesdes_envase.AsString:= desEnvase( QCosteEnvasesempresa_es.AsString, QCosteEnvasesenvase_es.AsString );
end;

procedure TFSobrepesoEnvasado.qGuiaAfterOpen(DataSet: TDataSet);
begin
  //Abrir detalle
  QCosteEnvases.SQL.Clear;
  QCosteEnvases.SQL.Add('SELECT * FROM frf_env_sobrepeso ');
  if Trim(Where) <> '' then
  begin
    QCosteEnvases.SQL.Add( Where );
    QCosteEnvases.SQL.Add( ' and empresa_es = :empresa_es ');
  end
  else
  begin
    QCosteEnvases.SQL.Add( ' where empresa_es = :empresa_es ');
  end;
  QCosteEnvases.SQL.Add( ' and anyo_es = :anyo_es ');
  QCosteEnvases.SQL.Add( ' and mes_es = :mes_es ');
  QCosteEnvases.SQL.Add( ' and producto_es = :producto_es ');
  QCosteEnvases.SQL.Add( ' ORDER BY envase_es ');
  QCosteEnvases.Open;
end;

procedure TFSobrepesoEnvasado.qGuiaBeforeClose(DataSet: TDataSet);
begin
  //cancelar cambios pendientes en la guia
  qGuia.CancelUpdates;
  //Cerrar detalle
  QCosteEnvases.Close;
end;

end.
