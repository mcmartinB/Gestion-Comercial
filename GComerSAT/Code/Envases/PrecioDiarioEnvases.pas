unit PrecioDiarioEnvases;

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
  TFPrecioDiarioEnvases = class(TMaestro)
    DSPrecioDiario: TDataSource;
    QPrecioDiario: TQuery;
    PMaestro: TPanel;
    lblCoste: TLabel;
    lblEmpresa: TLabel;
    lblProducto: TLabel;
    lblEnvse: TLabel;
    fecha_epd: TBDEdit;
    empresa_epd: TBDEdit;
    producto_epd: TBDEdit;
    stEmpresa: TnbStaticText;
    stProducto: TnbStaticText;
    stEnvase: TnbStaticText;
    lblNombre1: TLabel;
    precio_epd: TBDEdit;
    dbgPrecios: TDBGrid;
    qGuia: TQuery;
    dsGuia: TDataSource;
    sqluGuia: TUpdateSQL;
    lblEuroKg: TLabel;
    pnlDiaCompleto: TPanel;
    btnDiaCompleto: TButton;
    QPrecioDiarioempresa_epd: TStringField;
    QPrecioDiarioenvase_epd: TStringField;
    QPrecioDiariofecha_epd: TDateField;
    QPrecioDiarioprecio_epd: TFloatField;
    QPrecioDiariodes_envase_epd: TStringField;
    und_factura_epd: TBDEdit;
    QPrecioDiariound_factura_epd: TStringField;
    QPrecioDiariodes_producto_epd: TStringField;
    QPrecioDiariocentro_epd: TStringField;
    lblPvp: TLabel;
    pvp_epd: TBDEdit;
    QPrecioDiariopvp_epd: TFloatField;
    QPrecioDiarioproducto_epd: TStringField;
    envase_epd: TcxDBTextEdit;
    ssEnvase: TSimpleSearch;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure empresa_epdChange(Sender: TObject);
    procedure producto_epdChange(Sender: TObject);
    procedure envase_epdChange(Sender: TObject);
    procedure QPrecioDiarioCalcFields(DataSet: TDataSet);
    procedure qGuiaAfterOpen(DataSet: TDataSet);
    procedure qGuiaBeforeClose(DataSet: TDataSet);
    procedure btnDiaCompletoClick(Sender: TObject);
    procedure envase_epdExit(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    sFecha: string;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

    procedure PedirPreciosDiarios( const APlanta, ACentro: string; const AFecha: TDateTime; const ATieneDatos: boolean );
    procedure GetPrecioDiario( const AEmpresa, ACentro, AEnvase, AProducto: string; const AFecha: TDateTime; var VPrecio, VPvp: double; var VUnidad: string );
    procedure InsertarPrecioDiario( const AEmpresa, ACentro, AEnvase, AProducto: string; const AFecha: TDateTime; const APrecio, APvp: real; const AUnidad: string );
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
  bDialogs, LPrecioDiarioEnvases, DPreview, GetPrecioDiarioEnvases,
  GetFechaDiarioEnvases, bTextUtils;

{$R *.DFM}

procedure TFPrecioDiarioEnvases.AbrirTablas;
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

procedure TFPrecioDiarioEnvases.CerrarTablas;
begin
     // Cerrar tabla
  if DataSetGuia.Active then DataSetGuia.Close;
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFPrecioDiarioEnvases.FormCreate(Sender: TObject);
begin
  stEmpresa.Caption := '';
  stEnvase.Caption := '';
  stProducto.Caption := '';

     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
  PMaestro.Height:= 65;

     //Fuente de datos maestro
    DataSetGuia := qGuia;
 {+}DataSetMaestro := QPrecioDiario;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT fecha_epd, empresa_epd FROM frf_env_precio_diario ';
 {+}where := ' WHERE fecha_epd = ''1/1/1492'' ';
 {+}Order := ' GROUP BY fecha_epd, empresa_epd ' +
             ' ORDER BY fecha_epd, empresa_epd desc ';
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
  {+}FocoAltas := fecha_epd;
  {+}FocoModificar := precio_epd;
  {+}FocoLocalizar := fecha_epd;

end;

{+ CUIDADIN }

procedure TFPrecioDiarioEnvases.FormActivate(Sender: TObject);
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


procedure TFPrecioDiarioEnvases.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFPrecioDiarioEnvases.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFPrecioDiarioEnvases.Filtro;
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

procedure TFPrecioDiarioEnvases.AnyadirRegistro;
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

procedure TFPrecioDiarioEnvases.ValidarEntradaMaestro;
(*
var
  flag: Boolean
*)
var i: Integer;
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

  sFecha:= fecha_epd.Text;
  FocoAltas:= empresa_epd;

  if ( und_factura_epd.Text <> 'K' ) and ( und_factura_epd.Text <> 'U' ) and ( und_factura_epd.Text <> 'C' ) then
  begin
    raise Exception.Create('Unidad de afcturacion incorrecta, solo puede se U,K, o C.');
  end;

  //comprobar que existe el envase para el producto seleccionado
  with DMBaseDatos.QAux do
  begin
    SQl.Clear;
    SQl.Add(' select descripcion_e from frf_envases ');
    SQl.Add(' where envase_e= :envase ');
    SQl.Add(' and producto_e = :producto ');
    ParamByName('envase').AsString:=  envase_epd.Text;
    ParamByName('producto').AsString:= producto_epd.Text;
    Open;
    if IsEmpty then
    begin
      Close;
      raise Exception.Create('Envase incorrecto [' + empresa_epd.Text + '-' +
                                                   envase_epd.Text + '-' +
                                                   producto_epd.Text + '].');
    end;
    Close;
  end;
end;

procedure TFPrecioDiarioEnvases.Previsualizar;
begin
  QRLPrecioDiarioEnvases := TQRLPrecioDiarioEnvases.Create(Application);
  PonLogoGrupoBonnysa(QRLPrecioDiarioEnvases);

  QRLPrecioDiarioEnvases.QListado.SQL.Clear;
  QRLPrecioDiarioEnvases.QListado.SQL.Add(' SELECT * ');
  QRLPrecioDiarioEnvases.QListado.SQL.Add(' FROM frf_env_precio_diario, frf_envases ');
  QRLPrecioDiarioEnvases.QListado.SQl.Add(' where envase_e= envase_epd ');
  QRLPrecioDiarioEnvases.QListado.SQl.Add(' and producto_e = producto_epd ');
  QRLPrecioDiarioEnvases.QListado.SQL.Add( ' ORDER BY fecha_epd, empresa_epd, centro_epd, descripcion_e ');

  try
    QRLPrecioDiarioEnvases.QListado.Open;
    Preview(QRLPrecioDiarioEnvases);
  except
    QRLPrecioDiarioEnvases.QListado.Close;
    FreeAndNil( QRLPrecioDiarioEnvases );
  end;
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
procedure TFPrecioDiarioEnvases.AntesDeLocalizar;
begin
  PMaestro.Height:= 186;
end;

procedure TFPrecioDiarioEnvases.AntesDeModificar;
var i: Integer;
begin
  PMaestro.Height:= 186;
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

procedure TFPrecioDiarioEnvases.AntesDeVisualizar;
var i: Integer;
begin
  PMaestro.Height:= 65;
    //Resaturar estado
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := True;
  end;

  sFecha:= '';
  FocoAltas := fecha_epd;
end;

procedure TFPrecioDiarioEnvases.AntesDeInsertar;
begin
  PMaestro.Height:= 186;
  fecha_epd.Text:= sFecha;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFPrecioDiarioEnvases.RequiredTime(Sender: TObject;
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

procedure TFPrecioDiarioEnvases.ssEnvaseAntesEjecutar(Sender: TObject);
begin
    ssEnvase.SQLAdi := '';
    if producto_epd.Text <> '' then
      ssEnvase.SQLAdi := ' producto_e = ' +  QuotedStr(producto_epd.Text);
end;

procedure TFPrecioDiarioEnvases.empresa_epdChange(Sender: TObject);
begin
  if QPrecioDiario.State = dsBrowse then
    stEmpresa.Caption := desEmpresa( QPrecioDiario.FieldByName('empresa_epd').AsString )
  else
    stEmpresa.Caption := desEmpresa(empresa_epd.Text);
end;

procedure TFPrecioDiarioEnvases.producto_epdChange(Sender: TObject);
begin
  if QPrecioDiario.State = dsBrowse then
    stProducto.Caption := desProducto( QPrecioDiario.FieldByName('empresa_epd').AsString,
                                       QPrecioDiario.FieldByName('producto_epd').AsString )
  else
    stProducto.Caption := desProducto(empresa_epd.Text, producto_epd.Text);
end;

procedure TFPrecioDiarioEnvases.envase_epdChange(Sender: TObject);
begin
  if QPrecioDiario.State = dsBrowse then
    stEnvase.Caption := desEnvaseProducto( QPrecioDiario.FieldByName('empresa_epd').AsString,
                                           QPrecioDiario.FieldByName('envase_epd').AsString,
                                           QPrecioDiario.FieldByName('producto_epd').AsString )
  else
    stEnvase.Caption := desEnvaseProducto(empresa_epd.text, envase_epd.Text, producto_epd.Text);
end;

procedure TFPrecioDiarioEnvases.envase_epdExit(Sender: TObject);
begin
  if EsNumerico(envase_epd.Text) and (Length(envase_epd.Text) <= 5) then
    if (envase_epd.Text <> '' ) and (Length(envase_epd.Text) < 9) then
      envase_epd.Text := 'COM-' + Rellena( envase_epd.Text, 5, '0');
end;

procedure TFPrecioDiarioEnvases.QPrecioDiarioCalcFields(DataSet: TDataSet);
begin
  QPrecioDiariodes_envase_epd.AsString:= QPrecioDiarioenvase_epd.AsString + ' - ' +
    desEnvaseProducto( QPrecioDiarioempresa_epd.AsString, QPrecioDiarioenvase_epd.AsString, QPrecioDiarioproducto_epd.AsString );
  QPrecioDiariodes_producto_epd.AsString:= QPrecioDiarioproducto_epd.AsString + ' - ' +
    desProducto( QPrecioDiarioempresa_epd.AsString, QPrecioDiarioproducto_epd.AsString );
end;

procedure TFPrecioDiarioEnvases.qGuiaAfterOpen(DataSet: TDataSet);
begin
  //Abrir detalle
  QPrecioDiario.SQL.Clear;
  QPrecioDiario.SQL.Add('SELECT * FROM frf_env_precio_diario ');
  if Trim(Where) <> '' then
  begin
    QPrecioDiario.SQL.Add( Where );
    QPrecioDiario.SQL.Add( ' and fecha_epd = :fecha_epd ');
  end
  else
  begin
    QPrecioDiario.SQL.Add( ' where fecha_epd = :fecha_epd ');
  end;
  QPrecioDiario.SQL.Add( ' and empresa_epd = :empresa_epd ');
  QPrecioDiario.SQL.Add( ' ORDER BY centro_epd, producto_epd, envase_epd ');
  QPrecioDiario.Open;
end;

procedure TFPrecioDiarioEnvases.qGuiaBeforeClose(DataSet: TDataSet);
begin
  //cancelar cambios pendientes en la guia
  qGuia.CancelUpdates;
  //Cerrar detalle
  QPrecioDiario.Close;
end;

procedure TFPrecioDiarioEnvases.btnDiaCompletoClick(Sender: TObject);
var
  sPlanta, sCentro: string;
  dFecha: TDateTime;
begin
  if ( Estado = teConjuntoResultado)  or ( Estado = teEspera ) then
  begin
    sPlanta:= gsDefEmpresa;
    if InputQuery('PRECIOS DIARIOS POR ARTICULOS', 'Introduce planta', sPlanta ) then
    begin
      sCentro:= gsDefCentro;
      if InputQuery('PRECIOS DIARIOS POR ARTICULOS', 'Introduce centro', sCentro ) then
      begin
        sPlanta:= UpperCase( sPlanta );
        sCentro:= UpperCase( sCentro );

        dFecha:= Date + 1;
        if GetFechaDiarioEnvases.Preguntar( 'PRECIOS DIARIOS POR ARTICULOS', 'Introduce fecha', dFecha ) then
        begin
          with DMAuxDB.QAux do
          begin
            SQL.Clear;
            SQL.Add(' select * from frf_env_precio_diario ');
            SQL.Add(' where fecha_epd = :fecha ');
            SQL.Add(' and empresa_epd = :planta ');
            SQL.Add(' and centro_epd = :centro ');
            ParamByName('planta').AsString:= sPlanta;
            ParamByName('centro').AsString:= sCentro;
            ParamByName('fecha').AsDate:= dFecha;
            Open;
            PedirPreciosDiarios( sPlanta, sCentro, dFecha, not IsEmpty );
            Close;
          end;

          DataSetGuia.Close;
          where := ' WHERE fecha_epd = ' + QuotedStr( DateToStr( dFEcha ) ) + ' and empresa_epd = ' + QuotedStr( sPlanta );
          AbrirTablas;
          Visualizar;
        end;
      end;
    end;
  end;
end;

procedure TFPrecioDiarioEnvases.PedirPreciosDiarios( const APlanta, ACentro: string; const AFecha: TDateTime; const ATieneDatos: boolean );
var
  sUnidad: string;
  rPrecio, rPvp: double;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select envase_e, descripcion_e, producto_e ');
    SQL.Add(' from frf_envases ');
    SQL.Add(' where precio_diario_e = 1 ');
    SQL.Add(' and not exists ');
    SQL.Add(' ( ');
    SQL.Add('   select * from frf_env_precio_diario ');
    SQL.Add('   where empresa_epd = :planta ');
    SQL.Add('     and centro_epd = :centro ');
    SQL.Add('     and envase_epd = envase_e ');
    SQL.Add('     and producto_epd = producto_e ');
    SQL.Add('     and fecha_epd = :fecha ');
    SQL.Add(' ) ');
    SQL.Add(' order by 3,2,1 ');
    ParamByName('fecha').AsDate:= AFecha;
    ParamByName('planta').AsString:= APlanta;
    ParamByName('centro').AsString:= ACentro;
    Open;
    if not IsEmpty then
    begin
      if ATieneDatos then
        ShowMessage('Parte de los precios ya estan grabados, solo se pediran los no grabados.');
    end
    else
    begin
      if ATieneDatos then
        ShowMessage('Todos los precios ya estan grabados.')
      else
        ShowMessage('Marque primero los artículos para los que quiere grabar el precio diario.');
    end;

    while not Eof do
    begin
      GetPrecioDiario( APlanta, ACentro, FieldByName('envase_e').AsString, FieldByName('producto_e').AsString, AFecha, rPrecio, rPvp, sUnidad );
      if GetPrecioDiarioEnvases.Preguntar( APlanta + '/' + ACentro + ' PRECIOS DIARIOS POR ARTICULOS (' + DateToStr( AFecha ) + ')',
                                          'Precio ' + FieldByName('descripcion_e').AsString + ' (' +
                                          FieldByName('envase_e').AsString + ') ', rPrecio, rPvp, sUnidad ) then
      begin
        InsertarPrecioDiario( APlanta, ACentro, FieldByName('envase_e').AsString, FieldByName('producto_e').AsString, AFecha, rPrecio, rPvp, sUnidad );
      end;
      Next;
    end;
    Close;
  end;
end;

procedure TFPrecioDiarioEnvases.GetPrecioDiario( const AEmpresa, ACentro, AEnvase, AProducto: string; const AFecha: TDateTime; var VPrecio, VPvp: double; var VUnidad: string );
begin
  with DMAuxDB.QGeneral do
  begin
    SQL.Clear;
    SQL.Add(' select fecha_epd, precio_epd, pvp_epd, und_factura_epd from frf_env_precio_diario ');
    SQL.Add(' where empresa_epd = :empresa ');
    SQL.Add('   and centro_epd = :centro ');
    SQL.Add('   and envase_epd = :envase ');
    SQL.Add('   and producto_epd = :producto ');
    SQL.Add('   and fecha_epd <= :fecha ');
    SQL.Add(' order by 1 desc ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('envase').AsString:= AEnvase;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('fecha').AsDate:= AFecha;
    Open;
    if IsEmpty then
    begin
      VPrecio:= 0;
      VPvp:= 0;
      VUnidad:= 'K';
    end
    else
    begin
      VPrecio:= FieldByName('precio_epd').AsFloat;
      VPvp:= FieldByName('pvp_epd').AsFloat;
      VUnidad:= FieldByName('und_factura_epd').AsString;
    end;
    Close;
  end;
end;

procedure TFPrecioDiarioEnvases.InsertarPrecioDiario( const AEmpresa, ACentro, AEnvase, AProducto: string; const AFecha: TDateTime; const APrecio, APvp: real; const AUnidad: string );
begin
  with DMAuxDB.QGeneral do
  begin
    SQL.Clear;
    SQL.Add(' insert into frf_env_precio_diario ( empresa_epd, centro_epd, envase_epd, producto_epd, fecha_epd, precio_epd, pvp_epd, und_factura_epd ) ');
    SQL.Add(' values (:empresa, :centro, :envase, :producto, :fecha, :precio, :pvp, :unidad ) ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('envase').AsString:= AEnvase;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('fecha').AsDate:= AFecha;
    ParamByName('precio').AsFloat:= APrecio;
    ParamByName('pvp').AsFloat:= APvp;
    ParamByName('unidad').AsString:= AUnidad;
    ExecSQL;
  end;
end;

end.
