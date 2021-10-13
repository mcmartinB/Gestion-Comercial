unit MEntradasFruta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons, ActnList, ExtCtrls, DError,
  Grids, DBGrids, BGridButton, BGrid, BDEdit, BEdit, BCalendarButton, DBTables,
  ComCtrls, BCalendario, CVariables, BSpeedButton;

type
  TFMEntradasFruta = class(TMaestroDetalle)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    LEmpresa_p: TLabel;
    centro_ec: TBDEdit;
    BGBCentro_ec: TBGridButton;
    STCentro_ec: TStaticText;
    Label13: TLabel;
    Label1: TLabel;
    BGBEmpresa_ec: TBGridButton;
    empresa_ec: TBDEdit;
    STEmpresa_ec: TStaticText;
    Label2: TLabel;
    BGBProducto_ec: TBGridButton;
    producto_ec: TBDEdit;
    STProducto_ec: TStaticText;
    Label3: TLabel;
    transportista_ec: TBDEdit;
    Label4: TLabel;
    fecha_ec: TBDEdit;
    Label5: TLabel;
    hora_ec: TBDEdit;
    Label6: TLabel;
    total_palets_ec: TBDEdit;
    Label7: TLabel;
    total_cajas_ec: TBDEdit;
    Label8: TLabel;
    peso_bruto_ec: TBDEdit;
    Label9: TLabel;
    peso_neto_ec: TBDEdit;
    DSDetalle: TDataSource;
    BCBFecha_ec: TBCalendarButton;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    BGBTransportista_ec: TBGridButton;
    LAno_semana_p: TLabel;
    numero_entrada_ec: TBDEdit;
    STTransportista_ec: TStaticText;
    PDetalle: TPanel;
    PDetalleEdit: TPanel;
    Label15: TLabel;
    BGBCosechero_e2l: TBGridButton;
    Label16: TLabel;
    BGBPlantacion_e2l: TBGridButton;
    Label17: TLabel;
    Label18: TLabel;
    cosechero_e2l: TBDEdit;
    plantacion_e2l: TBDEdit;
    total_cajas_e2l: TBDEdit;
    total_kgs_e2l: TBDEdit;
    STCosechero_e2l: TStaticText;
    STPlantacion_e2l: TStaticText;
    RVisualizacion: TDBGrid;
    QTotalesLineas: TQuery;
    taraCamion: TLabel;
    linCajas: TLabel;
    linKilos: TLabel;
    taraPalets: TLabel;
    taraCajas: TLabel;
    taraTotal: TLabel;
    Label10: TLabel;
    sectores_e2l: TBDEdit;
    QEntradaFrutas: TQuery;
    TLinInFrutasOficina: TTable;
    TLinInFrutasOficinaempresa_e2l: TStringField;
    TLinInFrutasOficinacentro_e2l: TStringField;
    TLinInFrutasOficinanumero_entrada_e2l: TIntegerField;
    TLinInFrutasOficinacosechero_e2l: TSmallintField;
    TLinInFrutasOficinaplantacion_e2l: TSmallintField;
    TLinInFrutasOficinaano_sem_planta_e2l: TStringField;
    TLinInFrutasOficinatotal_cajas_e2l: TIntegerField;
    TLinInFrutasOficinatotal_kgs_e2l: TFloatField;
    TLinInFrutasOficinaproducto_e2l: TStringField;
    TLinInFrutasOficinasectores_e2l: TStringField;
    TLinInFrutasOficinades_cosechero: TStringField;
    TLinInFrutasOficinades_plantacion: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);

    procedure PonNombreLin(Sender: TObject);
    procedure PonNombreCab(Sender: TObject);
    procedure PonNombreCab1(Sender: TObject);
    procedure PonNombreCab2(Sender: TObject);

    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure centro_ecExit(Sender: TObject);
    procedure numero_entrada_ecExit(Sender: TObject);
    procedure EntrarEdit(Sender: TObject);
    procedure SalirEdit(Sender: TObject);
    procedure numero_entrada_ecEnter(Sender: TObject);
    procedure empresa_ecExit(Sender: TObject);
    procedure fecha_ecEnter(Sender: TObject);
    procedure total_cajas_e2lChange(Sender: TObject);
    procedure total_palets_ecChange(Sender: TObject);
    procedure total_cajas_ecChange(Sender: TObject);
    procedure peso_bruto_ecChange(Sender: TObject);
    procedure peso_neto_ecChange(Sender: TObject);
    procedure QEntradaFrutasBeforePost(DataSet: TDataSet);
    procedure QEntradaFrutasAfterPost(DataSet: TDataSet);
    procedure QEntradaFrutasPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TLinInFrutasOficinaCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    Fecha_e2l_aux_field: TDateField;

    cerrarTrans: boolean;

    ListaComponentes: TList;
    ListaDetalle: TList;
    Objeto: TObject;
    operacion: TEstadoDetalle;
    CantidadRegistros: Integer;
    avisar: boolean;
    fechaAnterior: TDate;

    numeroAlbaran: Integer;
    consulta: string;

    pesoCaja, pesoPalet: Real;
    cajasPalet: Integer;
    pesoCamion: Integer;

    cajas, palets, bruto, neto: Integer;

    procedure VerDetalle;
    procedure EditarDetalle;
    procedure ValidarEntradaDetalle;
    procedure RellenaClaveDetalle;
    procedure ValidarEntradaMaestro;
    procedure CambioRegistro;
    procedure AntesBorrarDetalle;
    procedure TotalesLineas;
    procedure AbrirTablas;
    procedure CerrarTablas;
    function NombrePlantacion(empresa, producto, cosechero, plantacion, fecha: string): string;
    (*function  NombrePlantacion2(empresa,producto,cosechero,plantacion,anyosemana:String):string;*)
    function Plantaciones(empresa, producto, cosechero, fecha: string): string;
    function FormatHora(hora: string): string;
    function ExistePlantacion: boolean;

    procedure BorrarDetalleOficina;
    procedure BorrarDetalleAlmacen;
    procedure BorrarEscandallo;

    procedure InfTaras;
    procedure ComprobarFechaLiquidacion;
  public

    manual: boolean;
    cabecera: TStringList;

    //SOBREESCRIBIR METODO
    procedure DetalleAltas; override;
    procedure Borrar; override;

    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;


    //Listado
    procedure Previsualizar; override;

    procedure IncrementaContador;
    procedure ModificarFecha;

    function GetNumeroDeAlbaran(empresa, centro: string; actualiza: Boolean): Integer;

    //procedure GuardarCabecera;
    procedure RestaurarCabecera; override;
    procedure ReintentarAlta; override;

    procedure TLinInFrutasOficinaAfterInsert(DataSet: TDataSet);
    procedure TLinInFrutasOficinaAfterPost(DataSet: TDataSet);
    procedure TLinInFrutasOficinaAfterDelete(DataSet: TDataSet);
    function ConsultaListado: string;
  end;

implementation

uses CGestionPrincipal, UDMBaseDatos, UDMAuxDB, CAuxiliarDB, CMaestro,
     DPreview, LEntradasFruta, bSQLUtils, bNumericUtils, Principal, CReportes;

{$R *.DFM}

procedure TFMEntradasFruta.AbrirTablas;
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

  if not DSDetalle.DataSet.Active then
    DSDetalle.DataSet.Open;

  if not QTotalesLineas.Active then
    QTotalesLineas.Open;

     //Estado inicial
  Registros := 0;
  if Registros > 0 then
    Registro := 1
  else
    Registros := 0;
  RegistrosInsertados := 0;
end;

procedure TFMEntradasFruta.CerrarTablas;
begin
  BorrarTemporal('temporal');

  CloseAuxQuerys;
  bnCloseQuerys([QTotalesLineas, TLinInFrutasOficina, QEntradaFrutas]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMEntradasFruta.FormCreate(Sender: TObject);
begin

  Fecha_e2l_aux_field := TDateField.Create(Self);

  Fecha_e2l_aux_field.FieldName := 'fecha_e2l';
  Fecha_e2l_aux_field.Name := TLinInFrutasOficina.Name +
    Fecha_e2l_aux_field.FieldName;
  Fecha_e2l_aux_field.Index := TLinInFrutasOficina.FieldCount;
  Fecha_e2l_aux_field.DataSet := TLinInFrutasOficina;
  TLinInFrutasOficina.FieldDefs.UpDate;

  LineasObligadas := true;
  ListadoObligado := false;
     // INICIO
     //Variables globales
  M := Self;
  MD := Self;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
     //PageControl.ActivePage:=TSResumen;
  PanelDetalle := PDetalleEdit;
  RejillaVisualizacion := RVisualizacion;
  cabecera := TStringList.Create;

     //Lista de componentes
  ListaComponentes := TList.Create;
  PMaestro.GetTabOrderList(ListaComponentes);
  ListaDetalle := TList.Create;
  PDetalleEdit.GetTabOrderList(ListaDetalle);

     //rejilla al tamaño maximo
  PDetalleEdit.Height := 0;
     //PanelMaestro.Height:=210;

  empresa_ec.ColorNormal := clWhite;
  centro_ec.ColorNormal := clWhite;
  producto_ec.ColorNormal := clWhite;
  numero_entrada_ec.ColorNormal := clWhite;

  Self.Caption := 'ENTRADAS DE FRUTA/CABECERA';

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> CVariables.tfMaestroDetalle then
  begin
    FormType := CVariables.tfMaestroDetalle;
    BHFormulario;
  end;
     //Inicialmente grupo de desplazamiento deshabilitado
  Visualizar;

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;
     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_ec.Tag := kEmpresa;
  centro_ec.Tag := kCentro;
  producto_ec.Tag := kProducto;
  cosechero_e2l.Tag := kCosechero;
  plantacion_e2l.Tag := kPlantacion;
  transportista_ec.Tag := kTransportista;
  fecha_ec.Tag := kCalendar;
     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnValidateDetailConstrains := ValidarEntradaDetalle;
  OnBeforeDetailDelete := AntesBorrarDetalle;
     //Eventos
  OnChangeMasterRecord := CambioRegistro;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnBrowse := AntesDeInsertar;
  OnView := AntesDeVisualizar;
  OnViewDetail := VerDetalle;
  OnEditDetail := EditarDetalle;

  TLinInFrutasOficina.AfterInsert := TLinInFrutasOficinaAfterInsert;
  TLinInFrutasOficina.AfterPost := TLinInFrutasOficinaAfterPost;
  TLinInFrutasOficina.AfterDelete := TLinInFrutasOficinaAfterDelete;

     //Focos
  {+}FocoAltas := empresa_ec;
  {+}FocoModificar := transportista_ec;
  {+}FocoLocalizar := numero_entrada_ec;
  FocoDetalle := cosechero_e2l;
      //Inicializacion de variables
  avisar := false;
  CalendarioFlotante.Date := Date;

     //Fuente de datos
 {+}DataSetMaestro := QEntradaFrutas;
  DataSourceDetalle := DSDetalle;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_entradas_c ';
 {+}where := ' WHERE empresa_ec=' + QuotedStr('###');
 {+}Order := ' ORDER BY empresa_ec, centro_ec, fecha_ec DESC, numero_entrada_ec ';
     //Abrir tablas/Querys
  try
       //Prepara query
    ConsultaPrepara(QTotalesLineas, ' select sum(total_cajas_e2l) cajas,sum(total_kgs_e2l) kilos' +
      ' from frf_entradas2_l where empresa_e2l=:empresa_ec ' +
      ' and centro_e2l=:centro_ec and numero_entrada_e2l=:numero_entrada_ec ' +
      ' and producto_e2l=:producto_ec and fecha_e2l=:fecha_ec ', True);
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

{+ CUIDADIN }

procedure TFMEntradasFruta.FormActivate(Sender: TObject);
begin
  if not DataSourceDetalle.DataSet.Active then Exit;
     //Variables globales
  M := Self;
  MD := Self;
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := CalendarioFlotante;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> CVariables.tfMaestroDetalle then
  begin
    FormType := CVariables.tfMaestroDetalle;
    BHFormulario;
  end;
     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(PCMaestro);
  BHGrupoDesplazamientoDetalle(PCDetalle);

     //Formulario maximizado
  Self.WindowState := wsMaximized;
end;


procedure TFMEntradasFruta.FormDeactivate(Sender: TObject);
begin
  gRF := nil;
  gCF := nil;
end;

procedure TFMEntradasFruta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListaComponentes.Free;
  ListaDetalle.Free;

  //Destruir lista de cadenas
  if cabecera <> nil then begin
    cabecera.Free;
    cabecera := nil;
  end;

     //Variables globales
  gRF := nil;
  gCF := nil;

     //Codigo de desactivacion
  CerrarTablas;

     //Restauramos barra de herramientas si es necesario
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

     //Desprepara query
  ConsultaDesPrepara(QTotalesLineas);

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMEntradasFruta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{*}//Si la rejilla esta desplegada no hacemos nada
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
           //No hacemos nada
      Exit;

{*}//Si  el calendario esta desplegado no hacemos nada
  if (CalendarioFlotante <> nil) then
    if (CalendarioFlotante.Visible) then
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

//...................... FILTRO LOCALIZACION .........................
//function generica, tiene mucha importancia que los datos esten en campos
//que hereden de TBEdit y que se llamen igual que el campo al que representan
//en la base de datos
//....................................................................

procedure TFMEntradasFruta.Filtro;
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
                           //where:=where + ' fecha_ec between ' + QuotedStr(fecha_ec.Text) + ' and ' + QuotedStr(DateToStr(StrToDate(fecha_ec.Text) + 6))
              where := where + ' ' + name + ' =' + SQLDate(Text)
            else
              where := where + ' ' + name + ' =' + SQLNumeric(Text);
          flag := true;
        end;
      end;
    end;
  end;
  if flag then where := ' WHERE ' + where;
  consulta := where;
end;

//...................... REGISTROS INSERTADOS .........................
//function generica, tiene mucha importancia que los datos esten en campos
//que hereden de TBDEdit y que se llamen igual que el campo al que representan
//en la base de datos. Si quieres que salgan aqui pon a True la propiedad
// PrimaryKey del componente.
//....................................................................

procedure TFMEntradasFruta.AnyadirRegistro;
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
  consulta := where;

  cajas := 0;
  palets := 0;
  bruto := 0;
  neto := 0;

  pesoCaja := 0;
  pesoPalet := 0;
  pesoCamion := 0;
  cajasPalet := 0;
end;

//...................... VALIDAR CAMPOS .........................
//function generica, tiene mucha importancia que los datos esten en campos
//que hereden de TBDEdit y que se llamen igual que el campo al que representan
//en la base de datos. Si quieres que salgan aqui pon a True la propiedad
// Required del componente y en RequiredMsg el mensaje que quieres mostrar
//....................................................................
// La funcion generica que realiza es comprobar que los campos que tienen
// datos por obligacion los tengan, en caso de querer hacer algo mas hay
// que implenentarlo, como comprobar la existencia de un valor en la base
// de datos
//....................................................................

procedure TFMEntradasFruta.ValidarEntradaMaestro;
var i: Integer;
begin
  ComprobarFechaLiquidacion;
  
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBEdit) then
    begin
      with Objeto as TBEdit do
      begin
        if Required and (Trim(Text) = '') then
        begin
          TBEdit(Objeto).setfocus;
          if Trim(RequiredMsg) <> '' then
            raise Exception.Create(RequiredMsg)
          else
            raise Exception.Create('Faltan datos de obligada inserción.');
        end;
      end;
    end;
  end;

  if Estado <> teModificar then
  begin
      //Existe el centro (empresa,centro)
    if desCentro(empresa_ec.Text, centro_ec.Text) = '' then
    begin
      empresa_ec.SetFocus;
      raise Exception.Create('El código de la empresa o del centro no son correctos.');
    end;

      //Existe la producto (empresa,producto)
    if desProducto(empresa_ec.Text, producto_ec.Text) = '' then
    begin
      producto_ec.SetFocus;
      raise Exception.Create('El código del producto no es correcto.');
    end;
  end;

      //Existe el transportista
  if desTransporte(empresa_ec.Text, transportista_ec.Text) = '' then
  begin
    transportista_ec.SetFocus;
    raise Exception.Create('El código del transporte no es correcto.');
  end;
end;

procedure TFMEntradasFruta.Previsualizar;
var
  QRLEntradasFruta: TQRLEntradasFruta;
begin
  QRLEntradasFruta := TQRLEntradasFruta.Create(Application);
  try
    ConsultaOpen(QRLEntradasFruta.QEntradasCab, ConsultaListado, false, false);
    ConsultaOpen(QRLEntradasFruta.QEntradasLin, false, false);
    QRLEntradasFruta.PrinterSettings.PrinterIndex := giPrintListados;
    PonLogoGrupoBonnysa( QRLEntradasFruta );
    Preview(QRLEntradasFruta);
  except
    QRLEntradasFruta.Free;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//*****************************************************************************

procedure TFMEntradasFruta.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa_ec);
    kCentro: DespliegaRejilla(BGBCentro_ec, [empresa_ec.text]);
    kProducto: DespliegaRejilla(BGBProducto_ec, [empresa_ec.text]);
    kTransportista: DespliegaRejilla(BGBTransportista_ec, [empresa_ec.text]);
    kCalendar: DespliegaCalendario(BCBFecha_ec);
    kCosechero: DespliegaRejilla(BGBCosechero_e2l, [empresa_ec.Text]);
    kPlantacion:
      begin
        RejillaFlotante.ColumnResult := 3;
        RejillaFlotante.ColumnFind := 4;
        QUERY := Plantaciones(empresa_ec.text, producto_ec.text, cosechero_e2l.Text, fecha_ec.text);
        plantacion_e2l.Tag := kOtros;
        DespliegaRejilla(BGBPlantacion_e2l, [empresa_ec.Text]);
        plantacion_e2l.Tag := kPlantacion;
      end;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************

//Evento que se produce cuando cambia el registro activo
//Tambien se genera cuando se muestra el primero

procedure TFMEntradasFruta.CambioRegistro;
begin
  TotalesLineas;
  if DSMaestro.State = dsBrowse then
  begin
    STEmpresa_ec.Caption := desEmpresa(empresa_ec.Text);
    STProducto_ec.Caption := desProducto(empresa_ec.Text, producto_ec.Text);
    STCentro_ec.Caption := desCentro(empresa_ec.Text, centro_ec.Text);
    STTransportista_ec.Caption := desTransporte(empresa_ec.Text, transportista_ec.Text);
  end;
end;

//Evento que se produce cuando pulsamos altas
//Aprobrechar para modificar estado controles

procedure TFMEntradasFruta.AntesDeInsertar;
begin
  if Estado = teAlta then
  begin
    fecha_ec.Text := DateTostr(date);
    hora_ec.Text := FormatHora(Copy(TimeTostr(time), 0, 5));
  end;

  //Rejilla en visualizacion
  VerDetalle;
  manual := false;

  cajas := 0;
  palets := 0;
  bruto := 0;
  neto := 0;

  pesoCaja := 0;
  pesoPalet := 0;
  pesoCamion := 0;
  cajasPalet := 0;
  peso_bruto_ec.Text := '';

  linCajas.Visible := False;
  linKilos.Visible := False;
  taraCamion.Visible := False;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMEntradasFruta.AntesDeModificar;
var i: Integer;
begin
  ComprobarFechaLiquidacion;

  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;
    //Guardar valores para ver si han sido modificados
  cajas := StrToInt(total_cajas_ec.Text);
  palets := StrToInt(total_palets_ec.Text);
  bruto := StrToInt(peso_bruto_ec.Text);
  neto := StrToInt(peso_neto_ec.Text);

  linCajas.Visible := False;
  linKilos.Visible := False;

  PesoCajasPalets(empresa_ec.Text, centro_ec.Text, producto_ec.Text,
    pesoCaja, pesoPalet, cajasPalet);
  cajas := StrToInt(total_cajas_ec.Text);
  palets := StrToInt(total_palets_ec.Text);
  pesoCamion := PesoTransporte(empresa_ec.Text, transportista_ec.Text);
  if pesoCamion = 0 then
    taraCamion.Visible := false
  else
  begin
    taraCamion.Caption := 'TARA = ' + IntToStr(Redondea(pesoCamion)) + ' Kgs';
    taraCamion.Visible := True;
  end;
  InfTaras;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMEntradasFruta.AntesDeVisualizar;
var i: Integer;
begin
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := true;
  end;
     //Borramos los nombres de la empresa, cosechero, ...
     //si el resultado de una busqueda fue vacio
  STProducto_ec.Caption := desProducto(empresa_ec.Text, producto_ec.Text);

  if TQuery(DSMaestro.DataSet).RecordCount = 0 then
  begin
    linCajas.Visible := False;
    linKilos.Visible := False;
  end
  else
  begin
    linCajas.Visible := true;
    linKilos.Visible := True;
  end;

  taraPalets.Visible := False;
  taraCajas.Visible := False;
  taraTotal.Visible := False;
end;

procedure TFMEntradasFruta.VerDetalle;
var i: integer;
begin
  LineasObligadas := true;
  for i := 0 to ListaDetalle.Count - 1 do
  begin
    Objeto := ListaDetalle.Items[i];
    if (Objeto is TBDEdit) then
    begin
      with Objeto as TBDEdit do
      begin
        if Modificable = false then
          Enabled := true;
      end;
    end;
  end;

  FocoDetalle := cosechero_e2l;

  PDetalleEdit.Height := 0;
  empresa_ec.ColorNormal := clWhite;
  centro_ec.ColorNormal := clWhite;
  producto_ec.ColorNormal := clWhite;
  numero_entrada_ec.ColorNormal := clWhite;

  Self.Caption := 'ENTRADAS DE FRUTA/CABECERA';

  operacion := tedEspera;
  TLinInFrutasOficina.Refresh;
end;


procedure TFMEntradasFruta.EditarDetalle;
var i: integer;
begin
  ComprobarFechaLiquidacion;

  if EstadoDetalle <> tedAlta then
  begin
    Operacion := tedModificar;
    STPlantacion_e2l.Caption := NombrePlantacion(
      empresa_ec.Text, producto_ec.Text,
      cosechero_e2l.Text, plantacion_e2l.Text,
      fecha_ec.Text);
    STCosechero_e2l.Caption := desCosechero(empresa_ec.Text, cosechero_e2l.Text);
  end;

  if EstadoDetalle <> tedAlta then
    for i := 0 to ListaDetalle.Count - 1 do
    begin
      Objeto := ListaDetalle.Items[i];
      if (Objeto is TBDEdit) then
      begin
        with Objeto as TBDEdit do
        begin
          if Modificable = false then
            Enabled := false;
        end;
      end;
    end;

  FocoDetalle := total_cajas_e2l;

     //rejilla al tamaño minimo
  PDetalleEdit.Height := 93;
  empresa_ec.ColorNormal := clSilver;
  centro_ec.ColorNormal := clSilver;
  producto_ec.ColorNormal := clSilver;
  numero_entrada_ec.ColorNormal := clSilver;

  Self.Caption := 'ENTRADAS DE FRUTA/LINEAS';
end;


//...................... VALIDAR CAMPOS .........................
//function generica, tiene mucha importancia que los datos esten en campos
//que hereden de TBDEdit y que se llamen igual que el campo al que representan
//en la base de datos. Si quieres que salgan aqui pon a True la propiedad
// Required del componente y en RequiredMsg el mensaje que quieres mostrar
//....................................................................
// La funcion generica que realiza es comprobar que los campos que tienen
// datos por obligacion los tengan, en caso de querer hacer algo mas hay
// que implenentarlo, como comprobar la existencia de un valor en la base
// de datos
//....................................................................

procedure TFMEntradasFruta.ValidarEntradaDetalle;
var i: Integer;
begin
  for i := 0 to ListaDetalle.Count - 1 do
  begin
    Objeto := ListaDetalle.Items[i];
    if (Objeto is TBDEdit) then
    begin
      with Objeto as TBDEdit do
      begin
        if {Required and}(Trim(Text) = '') then
        begin
          if Name <> 'sectores_e2l' then
          begin
            if Trim(RequiredMsg) <> '' then
              raise Exception.Create(RequiredMsg)
            else
              raise Exception.Create('Faltan datos de obligada inserción..');
          end;
          TBEdit(Objeto).setfocus;
        end;
      end;
    end;
  end;

    //Completamos la clave primaria
  if estadoDetalle <> tedModificar then
    RellenaClaveDetalle;

  if EstadoDetalle <> tedModificar then
  begin
         //Comprobar la existencia de la plantacion
    if not ExistePlantacion then raise Exception.Create('No existe o no esta dada de alta la plantación. ');
  end;
end;

procedure TFMEntradasFruta.RellenaClaveDetalle;
var anoseman: string;
begin
  //empresa
  if Trim(empresa_ec.Text) = '' then
    raise Exception.Create('Faltan datos de la cabecera.');
  DataSourceDetalle.DataSet.FieldByName('empresa_e2l').AsString := empresa_ec.Text;

  //centro
  if Trim(centro_ec.Text) = '' then
    raise Exception.Create('Faltan datos de la cabecera.');
  DataSourceDetalle.DataSet.FieldByName('centro_e2l').AsString := centro_ec.Text;

  //numero de entrada
  if Trim(numero_entrada_ec.Text) = '' then
    raise Exception.Create('Faltan datos de la cabecera.');
  DataSourceDetalle.DataSet.FieldByName('numero_entrada_e2l').AsString := numero_entrada_ec.Text;

  //Año semana
  anoseman := CalcularAnoSemana(empresa_ec.Text, producto_ec.Text,
    cosechero_e2l.Text, plantacion_e2l.Text, fecha_ec.Text);
  if Trim(anoseman) = '' then
    raise Exception.Create('No puedo calcular el Año/Semana de la plantación.');
  DataSourceDetalle.DataSet.FieldByName('ano_sem_planta_e2l').AsString := anoseman;

  //Fecha de la entrada
  DataSourceDetalle.DataSet.FieldByName('fecha_e2l').AsString := fecha_ec.text;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMEntradasFruta.PonNombreLin(Sender: TObject);
begin
  if DSDetalle.State <> dsInsert then Exit;

  if ((gRF <> nil) and gRF.Visible) or
    ((gCF <> nil) and gCF.Visible) then
    Exit;
  case TComponent(Sender).Tag of
    kPlantacion:
      begin
        STPlantacion_e2l.Caption := NombrePlantacion(
          empresa_ec.Text, producto_ec.Text,
          cosechero_e2l.Text, plantacion_e2l.Text,
          fecha_ec.Text);
      end;
    kCosechero:
      begin
        STCosechero_e2l.Caption := desCosechero(empresa_ec.Text, cosechero_e2l.Text);
      end;
  end;
end;

procedure TFMEntradasFruta.PonNombreCab(Sender: TObject);
begin
  if Estado = teLocalizar then
    PonNombreCab1(Sender)
  else
    PonNombreCab2(Sender);
end;

procedure TFMEntradasFruta.PonNombreCab1(Sender: TObject);
begin
  if ((gRF <> nil) and gRF.Visible) or
    ((gCF <> nil) and gCF.Visible) then
    Exit;
  case TComponent(Sender).Tag of
    kEmpresa:
      begin
        STEmpresa_ec.Caption := desEmpresa(empresa_ec.Text);
        STCentro_ec.Caption := desCentro(empresa_ec.Text, centro_ec.Text);
      end;
    kProducto:
      STProducto_ec.Caption := desProducto(empresa_ec.Text, producto_ec.Text);
    kCentro:
      STCentro_ec.Caption := desCentro(empresa_ec.Text, centro_ec.Text);
    kTransportista:
      STTransportista_ec.Caption := desTransporte(empresa_ec.Text, transportista_ec.Text);
  end;
end;

procedure TFMEntradasFruta.PonNombreCab2(Sender: TObject);
begin
  if ((gRF <> nil) and gRF.Visible) or
    ((gCF <> nil) and gCF.Visible) then
    Exit;
  case TComponent(Sender).Tag of
    kEmpresa:
      begin
        STEmpresa_ec.Caption := desEmpresa(empresa_ec.Text);
        STCentro_ec.Caption := desCentro(empresa_ec.Text, centro_ec.Text);
        PesoCajasPalets(empresa_ec.Text, centro_ec.Text, producto_ec.Text,
          pesoCaja, pesoPalet, cajasPalet);
        total_palets_ec.Change;
      end;
    kProducto:
      begin
        STProducto_ec.Caption := desProducto(empresa_ec.Text, producto_ec.Text);
        PesoCajasPalets(empresa_ec.Text, centro_ec.Text, producto_ec.Text,
          pesoCaja, pesoPalet, cajasPalet);
        total_palets_ec.Change;
      end;
    kCentro:
      begin
        STCentro_ec.Caption := desCentro(empresa_ec.Text, centro_ec.Text);
        PesoCajasPalets(empresa_ec.Text, centro_ec.Text, producto_ec.Text,
          pesoCaja, pesoPalet, cajasPalet);
        total_palets_ec.Change;
      end;
    kTransportista:
      begin
        STTransportista_ec.Caption := desTransporte(empresa_ec.Text, transportista_ec.Text);
        pesoCamion := PesoTransporte(empresa_ec.Text, transportista_ec.Text);
        if pesoCamion = 0 then
          taraCamion.Visible := false
        else
        begin
          taraCamion.Caption := 'TARA = ' + IntToStr(Redondea(pesoCamion)) + ' Kgs';
          taraCamion.Visible := True;
        end;
        peso_bruto_ec.Change;
      end;
  end;
end;

procedure TFMEntradasFruta.RequiredTime(Sender: TObject;
  var isTime: Boolean);
begin
  isTime := false;
  if TBEdit(Sender).CanFocus then
  begin
    if (Estado = teLocalizar) then
      Exit;
    if (gRF <> nil) and (gRf.Visible = true) then
      Exit;
    if (gCF <> nil) and (gCf.Visible = true) then
      Exit;
    isTime := true;
  end;
end;

procedure TFMEntradasFruta.DetalleAltas;
var
   //aux1,aux2:String;
  aux3: TEstadoDetalle;
begin
     //Evento antes de permitir la entrada de datos
  try
    aux3 := EstadoDetalle;
    EstadoDetalle := tedAlta;
    EditarDetalle;
    EstadoDetalle := aux3;
  except
    Exit;
  end;

     //La primera insercion de la tanda
  if Estado <> teOperacionDetalle then
  begin
          //estado detalle
    if Estado = teAlta then
    begin
      EstadoDetalle := tedAltaRegresoMaestro;
    end
    else
    begin
      EstadoDetalle := tedAlta;
    end;
          //estado maestro
    Estado := teOperacionDetalle;

    DetallesInsertados := 0;
    BEEstado;
    BHEstado;

    PanelMaestro.Enabled := false;
    PanelDetalle.Enabled := true;
    RejillaVisualizacion.Enabled := false;

  end
  else
    LineasObligadas := True;


  Operacion := EstadoDetalle;

     //Todas la inserciones
  DataSourceDetalle.DataSet.Insert;

  Self.ActiveControl := cosechero_e2l;
end;

function TieneEntregaAsociada( const AEmpresa, ACentro: string; const AEntrada: integer; const AFecha: TDateTime ): boolean;
begin
  ConsultaPrepara(DMAuxDB.QAux, ' select * from frf_entregas_rel ' +
    ' where empresa_er=:empresa ' +
    ' and centro_er=:centro ' +
    ' and fecha_entrada_er=:fecha ' +
    ' and numero_entrada_er=:entrada');

  DMAuxDB.QAux.ParamByName('empresa').AsString := AEmpresa;
  DMAuxDB.QAux.ParamByName('centro').AsString := ACentro;
  DMAuxDB.QAux.ParamByName('fecha').AsDateTime := AFecha;
  DMAuxDB.QAux.ParamByName('entrada').Asinteger := AEntrada;

  DMAuxDB.QAux.Open;
  result:= not DMAuxDB.QAux.isEmpty;
  DMAuxDB.QAux.Close;
end;

procedure TFMEntradasFruta.Borrar;
var botonPulsado: Word;
begin
  ComprobarFechaLiquidacion;

  if TieneEntregaAsociada( empresa_ec.Text, centro_ec.text, strtoint(numero_entrada_ec.text), strtodate (fecha_ec.text)) then
  begin
    ShowError(' Entrada asociada a una entrega de proveedor, no se puede borrar.');
    Exit;
  end;

  //Borrar maestro y el otro detalle
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

  if botonpulsado = mrYes then
  begin
       //Abrir transaccion
    if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
    begin
      ShowError(' En este momento no se puede borrar la entrada de fruta seleccionada, por favor intentelo mas tarde.');
      visualizar;
      exit;
    end;
    try
      BorrarDetalleAlmacen;
      BorrarEscandallo;
      BorrarDetalleOficina;
      DataSetMaestro.Delete;
    except
      on e: EDBEngineError do
      begin
        CancelarTransaccion(DMBaseDatos.DBBaseDatos);
        DataSetMaestro.EnableControls;
        ShowError(e);
        Visualizar;
        Exit;
      end;
    end;
    AceptarTransaccion(DMBaseDatos.DBBaseDatos);

    if Registro = Registros then Registro := Registro - 1;
    Registros := Registros - 1;
  end;

     //Por ultimo visualizamos resultado
  Visualizar;
end;

function TFMEntradasFruta.NombrePlantacion(empresa, producto, cosechero, plantacion, fecha: string): string;
var
  anyosemana: string;
  aux: string;
begin
  if (Trim(empresa) <> '') and (Trim(cosechero) <> '') and
    (Trim(producto) <> '') and (Trim(plantacion) <> '') and
    (plantacion_e2l.Enabled = True)
    then
  begin
    anyoSemana := CalcularAnoSemana(empresa, producto, cosechero, plantacion,
      fecha);
    if anyoSemana = '' then
    begin
      NombrePlantacion := '';
      Exit;
    end;
    aux := ' SELECT DISTINCT  ano_semana_p, descripcion_p ' +
      ' FROM frf_plantaciones ' +
      ' WHERE empresa_p=' + QuotedStr(empresa) + ' ' +
      '    AND producto_p=' + QuotedStr(producto) + ' ' +
      '    AND cosechero_p=' + cosechero +
      '    AND plantacion_p=' + plantacion +
      '    AND ano_semana_p=' + anyosemana;
    if ConsultaOpen(DMAuxDB.QAux, aux) = 1 then
      NombrePlantacion := DMAuxDB.QAux.FieldByName('descripcion_p').AsString
    else
      NombrePlantacion := '';
  end
  else
    NombrePlantacion := '';
end;

(*function TFMEntradasFruta.NombrePlantacion2(empresa,producto,cosechero,plantacion,anyosemana:String):string;
var
  aux:string;
begin
     if (Trim(empresa)<>'') and (Trim(cosechero)<>'') and
        (Trim(producto)<>'') and (Trim(plantacion)<>'') and
        (plantacion_e2l.Enabled=True)
     then
     begin
       if anyoSemana='' then
       begin
         NombrePlantacion2:='';
         Exit;
       end;
       aux:=' SELECT DISTINCT  ano_semana_p, descripcion_p '+
                  ' FROM frf_plantaciones '+
                  ' WHERE empresa_p='+QuotedStr(empresa)+' '+
                  '    AND producto_p='+QuotedStr(producto)+' '+
                  '    AND cosechero_p='+cosechero+
                  '    AND plantacion_p='+plantacion+
                  '    AND ano_semana_p='+anyosemana ;
       if ConsultaOpen(DMAuxDB.QAux,aux)=1 then
          NombrePlantacion2:=DMAuxDB.QAux.FieldByName('descripcion_p').AsString
       else
          NombrePlantacion2:='';
     end
     else
       NombrePlantacion2:='';
end;*)

function TFMEntradasFruta.Plantaciones(empresa, producto, cosechero, fecha: string): string;
var
  aux: TstringList;
begin
  aux := TStringList.Create;

  aux.Add(' SELECT p.empresa_p, p.producto_p, p.cosechero_p, p.plantacion_p, p.descripcion_p, ');
  aux.Add('        p.ano_semana_p ');
  aux.Add(' FROM frf_plantaciones p ');
  aux.Add(' WHERE  p.empresa_p = ' + QuotedStr(empresa));
  aux.Add('   AND p.producto_p = ' + QuotedStr(producto));
  if Trim(Cosechero) <> '' then
    aux.Add('   AND p.cosechero_p= ' + QuotedStr(cosechero));
  aux.Add('   AND p.ano_semana_p = (SELECT MAX(t.ano_semana_p) ');
  aux.Add('       FROM frf_plantaciones t ');
  aux.Add('       WHERE t.empresa_p= p.empresa_p ');
  aux.Add('         AND t.producto_p= p.producto_p ');
  aux.Add('         AND t.cosechero_p= p.cosechero_p ');
  aux.Add('         AND t.plantacion_p = p.plantacion_p ) ');
  aux.Add('   AND fecha_inicio_p < ' + QuotedStr(fecha));
  aux.Add('   AND fecha_fin_p is null ');
  aux.Add(' ORDER BY p.empresa_p, p.producto_p, p.cosechero_p, p.plantacion_p ');
  result := aux.Text;
  freeandnil(aux);
end;

function TFMEntradasFruta.FormatHora(hora: string): string;
begin
  if copy(hora, 5, 1) = ':' then
    FormatHora := copy(hora, 1, 4)
  else
    FormatHora := hora;
end;

procedure TFMEntradasFruta.AntesBorrarDetalle;
begin
  ComprobarFechaLiquidacion;
  //Guardamos numero de registros para saber si al final borramos
  CantidadRegistros := DataSourceDetalle.DataSet.RecordCount;
  operacion := tedBorrar;
end;

function TFMEntradasFruta.ExistePlantacion: boolean;
begin
  if Trim(CalcularAnoSemana(empresa_ec.Text, producto_ec.Text,
    cosechero_e2l.Text, plantacion_e2l.Text, fecha_ec.Text)) = ''
    then
    ExistePlantacion := false
  else
    ExistePlantacion := true;
end;

procedure TFMEntradasFruta.SalirEdit(Sender: TObject);
begin
  BEMensajes('');
end;

procedure TFMEntradasFruta.EntrarEdit(Sender: TObject);
begin
  BEMensajes(TEdit(Sender).Hint);
end;

procedure TFMEntradasFruta.numero_entrada_ecEnter(Sender: TObject);
begin
  if not manual then
    if Trim(numero_entrada_ec.Text) = '' then
      numeroAlbaran := 0
    else
      numeroAlbaran := strtoint(numero_entrada_ec.Text);
end;

procedure TFMEntradasFruta.numero_entrada_ecExit(Sender: TObject);
begin
     //comprobar que si introducimos un numero a mano que no sea mayor
     //que el contador almacenado en centros
  if not manual then
    if (numeroAlbaran = 0) or
      (numeroAlbaran <> strtoint(numero_entrada_ec.Text)) then
    begin
      manual := true;
    end
    else
    begin
      manual := false;
    end;
end;


function TFMEntradasFruta.GetNumeroDeAlbaran(empresa, centro: string; actualiza: Boolean): Integer;
begin
  with DMAuxDB.QDescripciones do
  begin
    SQL.Text := ' select cont_entradas_c from frf_centros ' +
      ' where empresa_c=' + QuotedStr(empresa) + ' ' +
      ' and centro_c=' + QuotedStr(centro);
    try
      try
        Open;
        if IsEmpty then Result := 1
        else Result := Fields[0].AsInteger;
      except
        Result := 1;
      end;
    finally
      Cancel;
      Close;
    end;
  end;

  if actualiza then
  begin
    with DMAuxDB.QDescripciones do
    begin
      SQL.Text := ' update  frf_centros  set cont_entradas_c = ' + IntToStr(Result + 1) +
        ' where empresa_c=' + QuotedStr(empresa) + ' ' +
        ' and centro_c=' + QuotedStr(centro);
      ExecSQL;
    end;
  end;
end;

procedure TFMEntradasFruta.empresa_ecExit(Sender: TObject);
begin
  if not manual then
    if (Trim(empresa_ec.Text) <> '') and
      (Trim(centro_ec.Text) <> '') and
      (Estado = teAlta) and
      (DSMaestro.State <> dsBrowse) then
    begin
      numeroAlbaran := GetNumeroDeAlbaran(empresa_ec.Text, centro_ec.Text, false);
      numero_entrada_ec.Text := IntToStr(numeroAlbaran);
    end;
end;

procedure TFMEntradasFruta.centro_ecExit(Sender: TObject);
begin
  if not manual then
    if (Trim(empresa_ec.Text) <> '') and
      (Trim(centro_ec.Text) <> '') and
      (Estado = teAlta) and
      (DSMaestro.State <> dsBrowse) then
    begin
      numeroAlbaran := GetNumeroDeAlbaran(empresa_ec.Text, centro_ec.Text, false);
      numero_entrada_ec.Text := IntToStr(numeroAlbaran);
    end;
end;

procedure TFMEntradasFruta.IncrementaContador;
begin
     //Numero de albaran
     //numero_entrada_ec.Text:=
  if not manual then
    DSMaestro.DataSet.FieldByName('numero_entrada_ec').AsString :=
      IntToStr(GetNumeroDeAlbaran(
      empresa_ec.Text,
      centro_ec.Text, true));
end;

procedure TFMEntradasFruta.fecha_ecEnter(Sender: TObject);
begin
  if DSMaestro.State = dsEdit then
  begin
    if fechaAnterior <> StrToDate('1/1/1001') then
    begin
      try
        fechaAnterior := StrToDate(fecha_ec.Text);
      except
             //Continue;
      end;
    end;
  end;
end;

procedure TFMEntradasFruta.ModificarFecha;
var
  fecha: TDate;
  aux: string;
begin
     //Modificacion en cascada de la fecha
  try
    fecha := StrToDate(fecha_ec.Text)
  except
    fecha_ec.SetFocus;
    raise Exception.Create('Fecha Incorrecta.');
  end;

  if fechaAnterior <> fecha then
  begin
    with DMAuxDB.QAux do
    begin
         //Actualizamos fecha
      SQL.clear;
      SQL.Add(' Update frf_entradas2_l set ' +
        ' fecha_e2l=:fecha ' +
        ' WHERE  empresa_e2l =' + quotedStr(empresa_ec.Text) +
        ' AND centro_e2l =' + quotedStr(centro_ec.Text) +
        ' AND numero_entrada_e2l =' + quotedStr(numero_entrada_ec.Text));
      ParamByName('fecha').asdatetime := StrToDate(fecha_ec.Text);
      try
        ExecSQL;
      except
        raise Exception.Create('No puedo modificar la fecha del detalle.');
      end;

         //Actualizamos año-semana por si acaso
      aux := ' (SELECT MAX(ano_semana_p) ano_semana ' +
        ' FROM frf_plantaciones ' +
        ' WHERE empresa_p=empresa_e2l ' +
        ' AND producto_p= producto_e2l ' +
        ' AND cosechero_p= cosechero_e2l ' +
        ' AND plantacion_p= plantacion_e2l ' +
        ' AND fecha_inicio_p<=fecha_e2l) ';
      SQL.Clear;
      SQL.Add(' Update frf_entradas2_l set ' +
        ' ano_sem_planta_e2l=' + aux +
        ' WHERE  empresa_e2l =' + quotedStr(empresa_ec.Text) +
        ' AND centro_e2l =' + quotedStr(centro_ec.Text) +
        ' AND numero_entrada_e2l =' + quotedStr(numero_entrada_ec.Text));
      try
        ExecSQL;
      except
        raise Exception.Create('Error al actualizar año-semana de la plantacion.');
      end;
         //Refrescamos datos rejilla
      DSDetalle.DataSet.Close;
      DSDetalle.DataSet.Open;
    end;
  end;
end;

procedure TFMEntradasFruta.RestaurarCabecera;
begin
  DSMaestro.DataSet.Insert;
  with cabecera do
  begin
    DSMaestro.DataSet.FieldByName('empresa_ec').AsString := strings[0];
    DSMaestro.DataSet.FieldByName('centro_ec').AsString := Strings[1];
    DSMaestro.DataSet.FieldByName('producto_ec').AsString := Strings[2];
    DSMaestro.DataSet.FieldByName('numero_entrada_ec').AsString := Strings[3];
    DSMaestro.DataSet.FieldByName('transportista_ec').AsString := Strings[4];
    DSMaestro.DataSet.FieldByName('fecha_ec').AsString := Strings[5];
    DSMaestro.DataSet.FieldByName('hora_ec').AsString := Strings[6];
    DSMaestro.DataSet.FieldByName('total_palets_ec').AsString := Strings[7];
    DSMaestro.DataSet.FieldByName('total_cajas_ec').AsString := Strings[8];
    DSMaestro.DataSet.FieldByName('peso_bruto_ec').AsString := Strings[9];
    DSMaestro.DataSet.FieldByName('peso_neto_ec').AsString := Strings[10];
  end;
end;

{procedure TFMEntradasFruta.GuardarCabecera;
begin
     with cabecera do
     begin
       Clear;
       Add(empresa_ec.Text);
       Add(centro_ec.Text);
       Add(producto_ec.Text);
       Add(numero_entrada_ec.Text);
       Add(transportista_ec.Text);
       Add(fecha_ec.Text);
       Add(hora_ec.Text);
       Add(total_palets_ec.Text);
       Add(total_cajas_ec.Text);
       Add(peso_bruto_ec.Text);
       Add(peso_neto_ec.Text);
     end;
end;}

procedure TFMEntradasFruta.ReintentarAlta;
begin
     //Estado
  Estado := teAlta;
  EstadoDetalle := tedOperacionMaestro;
  BEEstado;
  BHEstado;
  PanelMaestro.Enabled := True;
  PanelDetalle.Enabled := False;

  if Assigned(FOnEdit) then FOnEdit;

     //Poner foco
  Self.ActiveControl := FocoModificar;
end;

//**************************************************************************//
//                                                                          //
//                           EVENTOS TABLAS                                 //
//                                                                          //
//**************************************************************************//
//Insertar producto en las lineas

procedure TFMEntradasFruta.TLinInFrutasOficinaAfterInsert(DataSet: TDataSet);
begin
  {TEMPORAL}
  TLinInFrutasOficina.FieldByName('producto_e2l').AsString := producto_ec.Text;
end;

//**************************************************************************//
//**************************************************************************//
function TFMEntradasFruta.ConsultaListado: string;
var texto: string;
begin
  texto := 'SELECT empresa_ec, nombre_e, centro_ec, descripcion_c, producto_ec, descripcion_p, ' +
    ' numero_entrada_ec, transportista_ec, total_cajas_ec, fecha_ec, ' +
    ' total_palets_ec, peso_bruto_ec, peso_neto_ec ';
  texto := texto + ' FROM frf_entradas_c, frf_empresas, frf_centros, frf_productos ';
  if Consulta <> '' then
  begin
    texto := texto + CONSULTA + //Esta variable viene del proc FILTRO
        ' AND empresa_ec = empresa_e AND empresa_ec = empresa_c AND centro_ec = centro_c ' +
        ' AND empresa_ec = empresa_p AND producto_ec = producto_p ';
  end
  else
  begin
      texto := texto + ' WHERE empresa_ec = empresa_e AND empresa_ec = empresa_c AND centro_ec = centro_c ' +
        'AND empresa_ec = empresa_p AND producto_ec = producto_p';
  end;
  texto := texto + ' ORDER BY empresa_ec, centro_ec, producto_ec, numero_entrada_ec';
  ConsultaListado := Texto;
end;

procedure TFMEntradasFruta.TotalesLineas;
var
  sAuxCajas, sAuxKilos: String;
  auxCajas: integer;
  auxKilos: Real;
begin
  with QTotalesLineas do
  begin
    try
      sAuxCajas:= StringReplace(total_cajas_ec.Text,'.','',[rfReplaceAll, rfIgnoreCase]);
      //sAuxCajas:= StringReplace(sAuxCajas,',','.',[rfReplaceAll, rfIgnoreCase]);
      auxCajas := StrToInt(sAuxCajas);
      sAuxKilos:= StringReplace(peso_neto_ec.Text,'.','',[rfReplaceAll, rfIgnoreCase]);
      //sAuxKilos:= StringReplace(sAuxKilos,',','.',[rfReplaceAll, rfIgnoreCase]);
      auxKilos := StrToFloat(sAuxKilos);
    except
      linCajas.Visible := False;
      linKilos.Visible := False;
      Exit;
    end;

    //CAJAS EN LAS LINEAS
    auxCajas := auxCajas - FieldByName('cajas').AsInteger;
    if auxCajas < 0 then
      linCajas.Caption := 'Sobran ' + IntToStr(-1 * auxCajas) + ' cajas en las lineas.'
    else
      linCajas.Caption := 'Faltan ' + IntToStr(auxCajas) + ' cajas en las lineas.';
    if auxCajas = 0 then
      linCajas.Visible := False
    else
      linCajas.Visible := True;

    //KIL=S EN LAS LINEAS
    auxKilos := auxKilos - FieldByName('kilos').AsFloat;
    if auxKilos < 0 then
      linKilos.Caption := 'Sobran ' + FloatToStr(-1 * auxKilos) + ' Kgs en las lineas.'
    else
      linKilos.Caption := 'Faltan ' + FloatToStr(auxKilos) + ' Kgs en las lineas.';
    if auxKilos = 0 then
      linKilos.Visible := False
    else
      linKilos.Visible := true;
  end;
end;

procedure TFMEntradasFruta.total_cajas_e2lChange(Sender: TObject);
var kilos_cajas_c, kilos_l: real;
begin
  //El calculo sólo lo hago cuando la fuente de datos es editable
  if (DSDetalle.DataSet.State <> dsInsert) and
    (DSDetalle.DataSet.State <> dsEdit) then Exit;

    //calculo de los kilos automaticamente partiendo de los kilos y cajas de la cabecera
  if Trim(total_cajas_e2l.Text) <> '' then
  begin
    if (Trim(peso_neto_ec.Text) <> '') and (Trim(total_cajas_ec.Text) <> '') then
    begin
      kilos_cajas_c := StrToFloat(peso_neto_ec.Text) / StrToInt(total_cajas_ec.Text);
      kilos_l := kilos_cajas_c * StrToInt(total_cajas_e2l.Text);
      DSDetalle.DataSet.FieldByName('total_kgs_e2l').AsString := IntToStr(Trunc(kilos_l));
        //total_kgs_e2l.Text:= IntToStr(Trunc(kilos_l));
    end;
  end
  else
    DSDetalle.DataSet.FieldByName('total_kgs_e2l').AsString := '';
      //total_kgs_e2l.Text:='';
end;

procedure TFMEntradasFruta.total_palets_ecChange(Sender: TObject);
begin
  //El calculo sólo lo hago cuando la fuente de datos es editable
  if (DSMaestro.DataSet.State <> dsInsert) and
    (DSMaestro.DataSet.State <> dsEdit) then Exit;

  if (total_palets_ec.Text) <> '' then
    palets := StrToInt(total_palets_ec.Text)
  else
    palets := 0;

  cajas := palets * cajasPalet;
  if IntToStr(cajas) <> total_cajas_ec.Text then
  begin
    if cajas <> 0 then
      DSMaestro.DataSet.FieldByName('total_cajas_ec').AsString := IntToStr(cajas)
    else
      DSMaestro.DataSet.FieldByName('total_cajas_ec').AsString := '';
  end
  else
  begin
    total_cajas_ec.Change;
  end;

  InfTaras;
end;

procedure TFMEntradasFruta.total_cajas_ecChange(Sender: TObject);
begin
  //El calculo sólo lo hago cuando la fuente de datos es editable
  if (DSMaestro.DataSet.State <> dsInsert) and
    (DSMaestro.DataSet.State <> dsEdit) then Exit;

  if (total_cajas_ec.Text) <> '' then
    cajas := StrToInt(total_cajas_ec.Text)
  else
    cajas := 0;

  peso_bruto_ec.Change;

  InfTaras;
end;

procedure TFMEntradasFruta.peso_bruto_ecChange(Sender: TObject);
begin
  //El calculo sólo lo hago cuando la fuente de datos es editable
  if (DSMaestro.DataSet.State <> dsInsert) and
    (DSMaestro.DataSet.State <> dsEdit) then Exit;

  if (peso_bruto_ec.Text) <> '' then
  begin
    bruto := StrToInt(peso_bruto_ec.Text);
  end
  else
    bruto := 0;

  neto := bruto - pesoCamion - Redondea(palets * pesoPalet) - Redondea(cajas * pesoCaja);
  if neto <> 0 then
    DSMaestro.DataSet.FieldByName('peso_neto_ec').AsString := IntToStr(neto)
  else
    DSMaestro.DataSet.FieldByName('peso_neto_ec').AsString := '';

  InfTaras;
end;

procedure TFMEntradasFruta.peso_neto_ecChange(Sender: TObject);
begin
  //El calculo sólo lo hago cuando la fuente de datos es editable
  if (DSMaestro.DataSet.State <> dsInsert) and
    (DSMaestro.DataSet.State <> dsEdit) then Exit;

  if (peso_neto_ec.Text) <> '' then
  begin
    neto := StrToInt(peso_neto_ec.Text);
  end
  else
    neto := 0;

  bruto := neto + pesoCamion + Redondea(palets * pesoPalet) + Redondea(cajas * pesoCaja);
  if bruto <> 0 then
    DSMaestro.DataSet.FieldByName('peso_bruto_ec').AsString := IntToStr(bruto)
  else
    DSMaestro.DataSet.FieldByName('peso_bruto_ec').AsString := '';

  InfTaras;
end;

procedure TFMEntradasFruta.InfTaras;
var
  pesoPalets, pesoCajas, pesoTotal: Integer;
begin
  //Tara palets
  if (palets > 0) and (pesoPalet > 0) then
  begin
    pesoPalets := Redondea(palets * pesoPalet);
    taraPalets.Caption := 'Tara Palets: ' + IntToStr(palets) + ' X ' +
      FloatToStr(pesoPalet) + ' = ' +
      IntToStr(pesoPalets) + ' Kgs';
    taraPalets.Visible := True;
  end
  else
  begin
    pesoPalets := 0;
    taraPalets.Visible := False;
  end;

  //Tara cajas
  if (cajas > 0) and (pesoCaja > 0) then
  begin
    pesocajas := Redondea(cajas * pesoCaja);
    taraCajas.Caption := 'Tara Cajas: ' + IntToStr(cajas) + ' X ' +
      FloatToStr(pesoCaja) + ' = ' +
      IntToStr(pesoCajas) + ' Kgs';
    taraCajas.Visible := True;
  end
  else
  begin
    pesocajas := 0;
    taraCajas.Visible := False;
  end;

  //Tara TOTAL
  if (pesoCajas > 0) or (pesoPalets > 0) or (pesoCamion > 0) then
  begin
    pesoTotal := pesoCajas + pesoPalets + PesoCamion;
    taraTotal.Caption := 'Tara Total: ' + IntToStr(pesoTotal) + ' Kgs (Camion+Palets+Cajas)';
    taraTotal.Visible := True;
  end
  else
  begin
    taraTotal.Visible := False;
  end;
end;

procedure TFMEntradasFruta.BorrarDetalleAlmacen;
begin
  ConsultaPrepara(DMAuxDB.QAux, ' Delete from frf_entradas1_l ' +
    ' where empresa_e1l=:empresa ' +
    ' and centro_e1l=:centro ' +
    ' and fecha_e1l=:fecha ' +
    ' and numero_entrada_e1l=:entrada');

  DMAuxDB.QAux.ParamByName('empresa').AsString := empresa_ec.Text;
  DMAuxDB.QAux.ParamByName('centro').AsString := centro_ec.Text;
  DMAuxDB.QAux.ParamByName('fecha').AsDateTime := StrToDate(fecha_ec.Text);
  DMAuxDB.QAux.ParamByName('entrada').AsString := numero_entrada_ec.Text;

  ConsultaExec(DMAuxDB.QAux, False, True);
end;

procedure TFMEntradasFruta.BorrarDetalleOficina;
begin
  ConsultaPrepara(DMAuxDB.QAux, ' Delete from frf_entradas2_l ' +
    ' where empresa_e2l=:empresa ' +
    ' and centro_e2l=:centro ' +
    ' and fecha_e2l=:fecha ' +
    ' and numero_entrada_e2l=:entrada');

  DMAuxDB.QAux.ParamByName('empresa').AsString := empresa_ec.Text;
  DMAuxDB.QAux.ParamByName('centro').AsString := centro_ec.Text;
  DMAuxDB.QAux.ParamByName('fecha').AsDateTime := StrToDate(fecha_ec.Text);
  DMAuxDB.QAux.ParamByName('entrada').AsString := numero_entrada_ec.Text;

  ConsultaExec(DMAuxDB.QAux, False, True);
end;

procedure TFMEntradasFruta.BorrarEscandallo;
begin
  ConsultaPrepara(DMAuxDB.QAux, ' Delete from frf_escandallo ' +
    ' where empresa_e=:empresa ' +
    ' and centro_e=:centro ' +
    ' and fecha_e=:fecha ' +
    ' and numero_entrada_e=:entrada');

  DMAuxDB.QAux.ParamByName('empresa').AsString := empresa_ec.Text;
  DMAuxDB.QAux.ParamByName('centro').AsString := centro_ec.Text;
  DMAuxDB.QAux.ParamByName('fecha').AsDateTime := StrToDate(fecha_ec.Text);
  DMAuxDB.QAux.ParamByName('entrada').AsString := numero_entrada_ec.Text;

  ConsultaExec(DMAuxDB.QAux, False, True);
end;

procedure TFMEntradasFruta.TLinInFrutasOficinaAfterDelete(DataSet: TDataSet);
begin
  QTotalesLineas.Close;
  QTotalesLineas.Open;
  TotalesLineas;
end;

procedure TFMEntradasFruta.TLinInFrutasOficinaAfterPost(DataSet: TDataSet);
begin
  QTotalesLineas.Close;
  QTotalesLineas.Open;
  TotalesLineas;
end;

procedure TFMEntradasFruta.ComprobarFechaLiquidacion;
var
  dFecha, dLiquida: TDateTime;
begin
  dFecha:= StrToDate( fecha_ec.Text );
  dLiquida:= GetFechaUltimaLiquidacion( empresa_ec.Text, centro_ec.Text, producto_ec.Text );
  if dFecha < dLiquida then
  begin
    ShowMessage('No se puede añadir/modificar/borrar una entrega con fecha anterior a la ultima liquidación definitiva (' +
                DateToStr( dLiquida ) +  ').');
    Abort;
  end;
end;

procedure TFMEntradasFruta.QEntradaFrutasBeforePost(DataSet: TDataSet);
begin
  cerrarTrans := false;
  if DataSet.State = dsInsert then
  begin
    try
      FPrincipal.formEntradasFruta.IncrementaContador;
    except
      Abort;
    end;
  end;
  if DataSet.State = dsEdit then
  begin
    if AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
    begin
      cerrarTrans := true;
      try
        FPrincipal.formEntradasFruta.ModificarFecha;
        DMBaseDatos.DBBaseDatos.Commit;
      except
        on e: Exception do
        begin
          DMBaseDatos.DBBaseDatos.RollBack;
          raise Exception.Create('No puedo modificar la fecha del detalle.');
        end;
      end;
    end
    else
    begin
      raise Exception.Create('No puedo modificar la fecha del detalle.');
    end;
  end;
end;

procedure TFMEntradasFruta.QEntradaFrutasAfterPost(DataSet: TDataSet);
begin
  if cerrarTrans then
  begin
    cerrarTrans := false;
       //Modificacion con éxito
    AceptarTransaccion(DMBaseDatos.DBBaseDatos);
  end;
end;

procedure TFMEntradasFruta.QEntradaFrutasPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  if cerrarTrans then
  begin
    cerrarTrans := false;
       //Modificacion erronea
    CancelarTransaccion(DMBaseDatos.DBBaseDatos);
  end;
end;

procedure TFMEntradasFruta.TLinInFrutasOficinaCalcFields(
  DataSet: TDataSet);
begin
  DataSet.FieldByName('des_cosechero').AsString := desCosechero(
    DataSet.FieldByName('empresa_e2l').AsString,
    DataSet.FieldByName('cosechero_e2l').AsString);
  DataSet.FieldByName('des_plantacion').AsString := desPlantacion(
    DataSet.FieldByName('empresa_e2l').AsString,
    DataSet.FieldByName('producto_e2l').AsString,
    DataSet.FieldByName('cosechero_e2l').AsString,
    DataSet.FieldByName('plantacion_e2l').AsString,
    DataSet.FieldByName('ano_sem_planta_e2l').AsString);
end;


end.

