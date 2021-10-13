unit UFMFacturasEntregasPlatano;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbtables,
  DError, DBCtrls;

type
  TFMFacturasEntregasPlatano = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    Label13: TLabel;
    QFacturasPlatano: TQuery;
    CalendarioFlotante: TBCalendario;
    LFecha: TLabel;
    fecha_fpc: TBDEdit;
    BCBFecha_c: TBCalendarButton;
    lblNombre1: TLabel;
    n_factura_fpc: TBDEdit;
    lblNombre3: TLabel;
    lblNombre6: TLabel;
    DSEntregas: TDataSource;
    QEntregas: TQuery;
    PInferior: TPanel;
    DBGrid1: TDBGrid;
    lblAnyoSemana: TLabel;
    anyo_semana_fpc: TBDEdit;
    lblAnyoSemana2: TLabel;
    precio_fpc: TBDEdit;
    btnEntregas: TButton;
    lbl1: TLabel;
    receptor_fpc: TDBComboBox;
    lblIncremental: TEdit;
    producto_fpc: TDBComboBox;
    btnAsignarPrecio: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure QFacturasPlatanoBeforePost(DataSet: TDataSet);
    procedure QFacturasPlatanoAfterOpen(DataSet: TDataSet);
    procedure QFacturasPlatanoBeforeClose(DataSet: TDataSet);
    procedure btnEntregasClick(Sender: TObject);
    procedure anyo_semana_fpcChange(Sender: TObject);
    procedure btnAsignarPrecioClick(Sender: TObject);

  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;


    function  GetContadorFacturasPlatano( const AEmpresa: string ): integer;
    procedure CargaCombo;
    function  GetPrecioSemana( const AEmpresa, ASemana: string ): real;

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
    function  MantenimientoEntregas: boolean;
  end;

implementation

uses UDMAuxDB, CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal,  DPreview, bSQLUtils, UDMConfig, bTimeUtils,
  UQRFacturaEntregaPlatano, UFMEntregasFacturasPlatano, UFDPrecioFacturaPlatano;

{$R *.DFM}

procedure TFMFacturasEntregasPlatano.AbrirTablas;
begin
     // Abrir tablas/Querys
  if not DataSetMaestro.Active then
  try
    DataSetMaestro.SQL.Clear;
    DataSetMaestro.SQL.Add(Select);
    DataSetMaestro.SQL.Add(Where);
    DataSetMaestro.SQL.Add(Order);
    DataSetMaestro.Open;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      raise Exception.Create('No puedo abrir la tabla de cabecera.');
    end;
  end;

     //Estado inicial
  Registro := 1;
  Registros := 0;
  //Registros := DataSetMaestro.RecordCount;
  RegistrosInsertados := 0;
end;

procedure TFMFacturasEntregasPlatano.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuery(DataSetMaestro);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMFacturasEntregasPlatano.FormCreate(Sender: TObject);
begin

  M := self;
  MD := nil;
  MultiplesAltas := false;
     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(pcNulo);

     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
  PanelMaestro.Visible := false; {Hasta que no tengamos los datos}

     //Fuente de datos maestro
 {+}DataSetMaestro := QFacturasPlatano;

  //Lista de componentes
  Lista := TList.Create;
  PMaestro.GetTabOrderList(Lista);

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_facturas_platano_c ';
 {+}where := ' WHERE empresa_fpc=' + QUOTEDSTR('###');
 {+}Order := ' ORDER BY empresa_fpc, n_factura_fpc desc';


  with QEntregas do
  begin
    SQL.Clear;
    SQL.Add(' select codigo_ec entrega, proveedor_ec proveedor,  ');
    SQL.Add('         fecha_carga_ec carga, albaran_ec albaran, adjudicacion_ec conduce, ');
    SQL.Add('         barco_ec, vehiculo_ec matricula, producto_ec producto, ');
    SQL.Add('         (select sum(cajas_el) from frf_entregas_l where codigo_el = codigo_Ec ) cajas, ');
    SQL.Add('         (select sum(kilos_el) from frf_entregas_l where codigo_el = codigo_Ec ) kilos ');
    SQL.Add(' from frf_facturas_platano_l, frf_entregas_c ');
    SQL.Add(' where empresa_fpl = :empresa_fpc ');
    SQL.Add(' and n_factura_fpl = :n_factura_fpc ');
    SQL.Add(' and entrega_fpl = codigo_ec ');
    SQL.Add(' order by codigo_ec ');
    Prepare;
  end;

  //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;

  //Asignamos constantes a los componentes que los tienen
  //para facilitar distingirlos
  fecha_fpc.Tag:= kCalendar;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnBrowse := AntesDeLocalizar;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;

     //Focos
  {+}FocoAltas := fecha_fpc;
  {+}FocoModificar := fecha_fpc;
  {+}FocoLocalizar := n_factura_fpc;

  //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
  gCF := CalendarioFlotante;
  CalendarioFlotante.Date:= Date;
  gRF := nil;

  //Abrir tablas/Querys
  try
    AbrirTablas;
    Visualizar;
  except
    Close;
  end;
     //Desplegar(Self,439);
  if PanelMaestro.Visible = false then
    PanelMaestro.Visible := true;
end;


{+ CUIDADIN }


procedure TFMFacturasEntregasPlatano.FormActivate(Sender: TObject);
begin
  Exit;

  DataSetMaestro.EnableControls;

  //if not DataSetMaestro.Active then Exit;
  //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;

     //Formulario activo
  M := self;
  MD := nil;

     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);

     //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
  gCF := CalendarioFlotante;
  gRF := nil;

     //Abrir tablas/Querys
  try
    AbrirTablas;
    Visualizar;
  except
    Close;
  end;
     //Desplegar(Self,439);
  if PanelMaestro.Visible = false then
    PanelMaestro.Visible := true;
end;


procedure TFMFacturasEntregasPlatano.FormDeactivate(Sender: TObject);
begin
  Exit;

  //Desahabilitamos controles de Base de datos
  //mientras estamos desactivados
  DataSetMaestro.DisableControls;

 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF := nil;

  //CerrarTablas;
end;

procedure TFMFacturasEntregasPlatano.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with QEntregas do
  begin
    Close;
    if Prepared then
      UnPrepare;
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

     //Formulario activo
  M := nil;
  MD := nil;
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMFacturasEntregasPlatano.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{*}//Si la rejilla esta desplegada no hacemos nada
   // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
   //               y entre los Campos de Búsqueda en la localización

  case key of
    vk_Return:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
    Ord('E'):
      if ssAlt in Shift  then
          if not MantenimientoEntregas then
            ShowMessage('Debe tener una compra seleccionada y en modo de visualización.');
  end;
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

{+}//Sustituir por funcion generica

procedure TFMFacturasEntregasPlatano.Filtro;
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

procedure TFMFacturasEntregasPlatano.AnyadirRegistro;
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

{+}//Sustituir por funcion generica

procedure TFMFacturasEntregasPlatano.ValidarEntradaMaestro;
var
  dFecha: TDateTime;
begin
  if Length(anyo_semana_fpc.Text) < 6 then
  begin
    raise Exception.Create('El Año/Semana debe ser de 6 digitos');
  end;
  if not tryStrToDate( fecha_fpc.Text, dFecha ) then
  begin
    raise Exception.Create('Falta la fecha de la factura o es incorrecta.');
  end;
  if Trim( receptor_fpc.Text ) = '' then
  begin
    raise Exception.Create('Falta el receptor de la compra.');
  end;
  if Trim( producto_fpc.Text ) = '' then
  begin
    raise Exception.Create('Falta el producto de la compra.');
  end;
end;

procedure TFMFacturasEntregasPlatano.Previsualizar;
var
  QRFacturaEntregaPlatano: TQRFacturaEntregaPlatano;
  rImporte, rTotal, rKilos: real;
  rAux: string;
  iCajas: Integer;
begin
  //Crear el listado
  DMBaseDatos.QListado.SQL.Clear;
  DMBaseDatos.QListado.SQL.Add('select * from frf_facturas_platano_c where empresa_fpc = :empresa and n_factura_fpc = :factura');
  DMBaseDatos.QListado.ParamByName('empresa').AsString := 'BAG';
  DMBaseDatos.QListado.ParamByName('factura').AsInteger := StrToIntDef( n_factura_fpc.Text, 0 );
  try
    DMBaseDatos.QListado.Open;
    if not DMBaseDatos.QListado.IsEmpty then
    begin
      QRFacturaEntregaPlatano:= TQRFacturaEntregaPlatano.Create(Application);

      //Matriculas
      rAux:= '';
      DMAuxDB.QAux.SQL.Clear;
      DMAuxDB.QAux.SQL.Add('select vehiculo_ec ');
      DMAuxDB.QAux.SQL.Add('from  frf_facturas_platano_l, frf_entregas_c ');
      DMAuxDB.QAux.SQL.Add('where empresa_fpl = :empresa ');
      DMAuxDB.QAux.SQL.Add('and n_factura_fpl = :factura ');
      DMAuxDB.QAux.SQL.Add('and codigo_ec = entrega_fpl ');
      DMAuxDB.QAux.SQL.Add('group by vehiculo_ec ');
      DMAuxDB.QAux.SQL.Add('order by vehiculo_ec ');
      DMAuxDB.QAux.ParamByName('empresa').AsString := 'BAG';
      DMAuxDB.QAux.ParamByName('factura').AsInteger := StrToIntDef( n_factura_fpc.Text, 0 );
      DMAuxDB.QAux.Open;
      while not DMAuxDB.QAux.Eof do
      begin
        if rAux = '' then
          rAux:= DMAuxDB.QAux.FieldByName('vehiculo_ec').AsString
        else
          rAux:= rAux + '     ' + DMAuxDB.QAux.FieldByName('vehiculo_ec').AsString;
        DMAuxDB.QAux.Next;
      end;
      DMAuxDB.QAux.Close;

      QRFacturaEntregaPlatano.qrmMatricula.Lines.Add( rAux  );

      //Kilos y cajas
      rTotal:= 0;
      DMAuxDB.QAux.SQL.Clear;
      DMAuxDB.QAux.SQL.Add('select barco_ec,  descripcion_p, categoria_el, descripcion_c,   ');
      DMAuxDB.QAux.SQL.Add('       sum(cajas_el) cajas, sum(kilos_el) kilos, precio_el ');
      DMAuxDB.QAux.SQL.Add('from  frf_facturas_platano_l ');
      DMAuxDB.QAux.SQL.Add('      join frf_entregas_c on codigo_ec = entrega_fpl ');
      DMAuxDB.QAux.SQL.Add('      join frf_entregas_l on codigo_el = codigo_ec ');
      DMAuxDB.QAux.SQL.Add('      join frf_productos on producto_el = producto_p ');
      DMAuxDB.QAux.SQL.Add('      left join frf_categorias on producto_el = producto_c and categoria_el = categoria_c ');
      DMAuxDB.QAux.SQL.Add('where empresa_fpl = :empresa ');
      DMAuxDB.QAux.SQL.Add('and n_factura_fpl = :factura ');
      DMAuxDB.QAux.SQL.Add('group by barco_ec,  descripcion_p, categoria_el, descripcion_c, precio_el ');
      DMAuxDB.QAux.SQL.Add('order by barco_ec, categoria_el ');

      DMAuxDB.QAux.ParamByName('empresa').AsString := 'BAG';
      DMAuxDB.QAux.ParamByName('factura').AsInteger := StrToIntDef( n_factura_fpc.Text, 0 );
      DMAuxDB.QAux.Open;
      iCajas:= 0;
      rKilos:= 0;
      if (n_factura_fpc.Text = '2559') then
      begin
        QRFacturaEntregaPlatano.qrmBuque.Lines.Add( 'NEUBURG' );
        QRFacturaEntregaPlatano.qrmBuque.Lines.Add( 'NEUBURG' );
        QRFacturaEntregaPlatano.qrmBuque.Lines.Add( 'NEUBURG' );
        QRFacturaEntregaPlatano.qrmBuque.Lines.Add( 'NEUBURG' );

        QRFacturaEntregaPlatano.qrmProducto.Lines.Add( 'PLATANO CANARIO' );
        QRFacturaEntregaPlatano.qrmProducto.Lines.Add( 'PLATANO CANARIO' );
        QRFacturaEntregaPlatano.qrmProducto.Lines.Add( 'PLATANO CANARIO' );
        QRFacturaEntregaPlatano.qrmProducto.Lines.Add( 'PLATANO CANARIO' );

        QRFacturaEntregaPlatano.qrmCategoria.Lines.Add( 'PRIMERA' );
        QRFacturaEntregaPlatano.qrmCategoria.Lines.Add( 'EXTRA' );
        QRFacturaEntregaPlatano.qrmCategoria.Lines.Add( 'SUPEREXTRA' );
        QRFacturaEntregaPlatano.qrmCategoria.Lines.Add( 'SUPEREXTRA' );

        QRFacturaEntregaPlatano.qrmCajas.Lines.Add( '280' );
        QRFacturaEntregaPlatano.qrmCajas.Lines.Add( '270' );
        QRFacturaEntregaPlatano.qrmCajas.Lines.Add( '270' );
        QRFacturaEntregaPlatano.qrmCajas.Lines.Add( '558' );
        iCajas:=  280 +  270 + 270  + 558;

        QRFacturaEntregaPlatano.qrmPeso.Lines.Add( FormatFloat( '#,##0.00', 1540 ) );
        QRFacturaEntregaPlatano.qrmPeso.Lines.Add( FormatFloat( '#,##0.00', 4320 ) );
        QRFacturaEntregaPlatano.qrmPeso.Lines.Add( FormatFloat( '#,##0.00', 4320 ) );
        QRFacturaEntregaPlatano.qrmPeso.Lines.Add( FormatFloat( '#,##0.00', 9518 ) );
        rKilos:= 1540 + 4320 + 4320 + 9518;

        QRFacturaEntregaPlatano.qrmUnidad.Lines.Add( ' kgs' );
        QRFacturaEntregaPlatano.qrmUnidad.Lines.Add( ' kgs' );
        QRFacturaEntregaPlatano.qrmUnidad.Lines.Add( ' kgs' );
        QRFacturaEntregaPlatano.qrmUnidad.Lines.Add( ' kgs' );

        QRFacturaEntregaPlatano.qrmPrecio.Lines.Add( FormatFloat( '#,##0.000 €', 0.336 ) );
        QRFacturaEntregaPlatano.qrmPrecio.Lines.Add( FormatFloat( '#,##0.000 €', 0.558 ) );
        QRFacturaEntregaPlatano.qrmPrecio.Lines.Add( FormatFloat( '#,##0.000 €', 0.620 ) );
        QRFacturaEntregaPlatano.qrmPrecio.Lines.Add( FormatFloat( '#,##0.000 €', 0.603 ) );

        QRFacturaEntregaPlatano.qrmImporte.Lines.Add( FormatFloat( '#,##0.00 €', 517.74 ) );
        QRFacturaEntregaPlatano.qrmImporte.Lines.Add( FormatFloat( '#,##0.00 €', 2410.56 ) );
        QRFacturaEntregaPlatano.qrmImporte.Lines.Add( FormatFloat( '#,##0.00 €', 2678.40 ) );
        QRFacturaEntregaPlatano.qrmImporte.Lines.Add( FormatFloat( '#,##0.00 €', 5739.35 ) );

        rTotal:= 11346.05;
      end
      else
      while not DMAuxDB.QAux.Eof do
      begin
        QRFacturaEntregaPlatano.qrmBuque.Lines.Add( DMAuxDB.QAux.FieldByName('barco_ec').AsString );
        QRFacturaEntregaPlatano.qrmCajas.Lines.Add( DMAuxDB.QAux.FieldByName('cajas').AsString );
        iCajas:= iCajas + DMAuxDB.QAux.FieldByName('cajas').AsInteger;
        if DMAuxDB.QAux.FieldByName('descripcion_c').AsString <> '' then
          QRFacturaEntregaPlatano.qrmCategoria.Lines.Add( DMAuxDB.QAux.FieldByName('descripcion_c').AsString )
        else
          QRFacturaEntregaPlatano.qrmCategoria.Lines.Add( DMAuxDB.QAux.FieldByName('categoria_el').AsString );
        if Trim( DMAuxDB.QAux.FieldByName('descripcion_p').AsString ) = 'PLATANO' then
          QRFacturaEntregaPlatano.qrmProducto.Lines.Add( 'PLATANO CANARIO' )
        else
          QRFacturaEntregaPlatano.qrmProducto.Lines.Add( DMAuxDB.QAux.FieldByName('descripcion_p').AsString );
        QRFacturaEntregaPlatano.qrmPeso.Lines.Add( FormatFloat( '#,##0.00', DMAuxDB.QAux.FieldByName('kilos').AsFloat ) );
        rKilos:= rKilos + DMAuxDB.QAux.FieldByName('kilos').AsFloat;
        QRFacturaEntregaPlatano.qrmUnidad.Lines.Add( ' kgs' );
        QRFacturaEntregaPlatano.qrmPrecio.Lines.Add( FormatFloat( '#,##0.000 €', DMAuxDB.QAux.FieldByName('precio_el').AsFloat ) );

        if (n_factura_fpc.Text = '2559') and  (DMAuxDB.QAux.FieldByName('categoria_el').AsString  = '1') then
          rImporte:= 517.74
        else
          rImporte:= DMAuxDB.QAux.FieldByName('kilos').AsFloat * DMAuxDB.QAux.FieldByName('precio_el').AsFloat;
        QRFacturaEntregaPlatano.qrmImporte.Lines.Add( FormatFloat( '#,##0.00 €', rImporte ) );
        rTotal:= rTotal + rImporte;
        DMAuxDB.QAux.Next;
      end;
      DMAuxDB.QAux.Close;

      QRFacturaEntregaPlatano.qrlblcajas.Caption:= FormatFloat( '#,##0', iCajas );
      QRFacturaEntregaPlatano.qrlblpeso.Caption:= FormatFloat( '#,##0.00', rKilos );
      QRFacturaEntregaPlatano.qrlblimporte.Caption:= FormatFloat( '#,##0.00', rTotal );

      QRFacturaEntregaPlatano.qrlNeto.Caption:= FormatFloat( '#,##0.00 €', rTotal );
      QRFacturaEntregaPlatano.qrlIgic.Caption:= FormatFloat( '#,##0.00 €', 0 );
      QRFacturaEntregaPlatano.qrlTotal.Caption:= FormatFloat( '#,##0.00 €', rTotal );

      try
        //PonLogoGrupoBonnysa(QRFacturaEntregaPlatano);
        Preview(QRFacturaEntregaPlatano);
      except
        FreeAndNil(QRFacturaEntregaPlatano);
        Raise;
      end;
    end;
  finally
    DMBaseDatos.QListado.Close;
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

procedure TFMFacturasEntregasPlatano.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kCalendar: DespliegaCalendario(BCBFecha_c);
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
//Evento que se produce cuando pulsamos modificar
//Aprovechar para modificar estado controles

procedure TFMFacturasEntregasPlatano.AntesDeLocalizar;
begin
  PInferior.Enabled:= false;
  CargaCombo;
end;

procedure TFMFacturasEntregasPlatano.AntesDeInsertar;
begin
  lblIncremental.Visible:= True;
  n_factura_fpc.Visible:= False;
  n_factura_fpc.Text:= '0';
  fecha_fpc.Text:= DateToStr( Date );
  PInferior.Enabled:= false;
  CargaCombo;
  DSMaestro.DataSet.FieldByName('receptor_fpc').AsString:= receptor_fpc.Items[ 0 ];
  DSMaestro.DataSet.FieldByName('producto_fpc').AsString:= producto_fpc.Items[ 0 ];
  anyo_semana_fpc.Text:= AnyoSemana( Date );
end;

procedure TFMFacturasEntregasPlatano.AntesDeModificar;
var i: Integer;
begin
  CargaCombo;
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;
  PInferior.Enabled:= false;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprovechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMFacturasEntregasPlatano.AntesDeVisualizar;
var i: Integer;
begin
    //Resaturar estado
  n_factura_fpc.Visible:= True;
  lblIncremental.Visible:= False;

  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := True;
  end;

  PInferior.Enabled:= True;
end;


procedure TFMFacturasEntregasPlatano.RequiredTime(Sender: TObject;
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

function  TFMFacturasEntregasPlatano.GetContadorFacturasPlatano( const AEmpresa: string ): integer;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(max(n_factura_fpc),0) n_factura ');
    SQL.Add(' from frf_facturas_platano_c ');
    SQL.Add(' where empresa_fpc = :empresa_fpc ');
    ParamByName('empresa_fpc').AsString:= AEmpresa;
    Open;
    result:= FieldByName('n_factura').AsInteger + 1;
    Close;
  end;
end;


procedure TFMFacturasEntregasPlatano.QFacturasPlatanoBeforePost(DataSet: TDataSet);
begin
  if Estado = teAlta then
    DataSet.FieldByName('n_factura_fpc').AsInteger:= GetContadorFacturasPlatano( 'BAG' );
end;

procedure TFMFacturasEntregasPlatano.btnEntregasClick(Sender: TObject);
begin
  //ShowMessage('Programa en desarrollo.');
  if not MantenimientoEntregas then
  begin
    ShowMessage('Debe tener una compra seleccionada y en modo de visualización.');
  end;
end;

function TFMFacturasEntregasPlatano.MantenimientoEntregas: boolean;
begin
  result:= false;
  if ( Estado = teConjuntoResultado ) and ( not DSMaestro.DataSet.IsEmpty ) then
  begin
    FMEntregasFacturasPlatano := TFMEntregasFacturasPlatano.Create(Self);
    try
      FMEntregasFacturasPlatano.CargaParametros( 'BAG', StrToIntDef( n_factura_fpc.Text, 0 ),
                                                 StrToDateDef( fecha_fpc.Text, date ), anyo_semana_fpc.Text );
      FMEntregasFacturasPlatano.ShowModal;
      QEntregas.Close;
      QEntregas.Open;
      result:= True;
    finally
      FreeAndNil(FMEntregasFacturasPlatano);
    end;
  end;
end;

procedure TFMFacturasEntregasPlatano.QFacturasPlatanoAfterOpen(DataSet: TDataSet);
begin
  QEntregas.Open;
end;

procedure TFMFacturasEntregasPlatano.QFacturasPlatanoBeforeClose(DataSet: TDataSet);
begin
  QEntregas.Close;
end;

procedure TFMFacturasEntregasPlatano.CargaCombo;
begin
  with DMAuxDB.QAux do
  begin
    Sql.Clear;
    SQl.Add( 'select receptor_fpc, count(*) ');
    SQl.Add( 'from frf_facturas_platano_c ');
    SQl.Add( 'group by receptor_fpc ');
    SQl.Add( 'order by 2 desc ');
    Open;
    receptor_fpc.Items.Clear;
    while not Eof do
    begin
      receptor_fpc.Items.Add( FieldByName('receptor_fpc').AsString );
      Next;
    end;
    Close;

    Sql.Clear;
    SQl.Add( 'select producto_fpc, count(*) ');
    SQl.Add( 'from frf_facturas_platano_c ');
    SQl.Add( 'group by producto_fpc ');
    SQl.Add( 'order by 2 desc ');
    Open;
    producto_fpc.Items.Clear;
    while not Eof do
    begin
      producto_fpc.Items.Add( FieldByName('producto_fpc').AsString );
      Next;
    end;
    Close;
  end;
end;

function TFMFacturasEntregasPlatano.GetPrecioSemana( const AEmpresa, ASemana: string ): real;
begin
  result:= 0;
  //Sacar el precio de la semana
  with DMAuxDB.QAux do
  begin
    Sql.Clear;
    SQl.Add( 'select precio_fpc , count(*) ');
    SQl.Add( 'from frf_facturas_platano_c ');
    SQl.Add( 'where empresa_fpc = :empresa ');
    SQl.Add( 'and anyo_semana_fpc = :anyosemana ');
    SQl.Add( 'and precio_fpc <> 0 ');
    SQl.Add( 'group by precio_fpc ');
    SQl.Add( 'order by 2 desc ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('anyosemana').AsString := ASemana;
    Open;
    if not IsEmpty then
    begin
      result:= FieldByName('precio_fpc').AsFloat;
    end;
    Close;
  end;
end;

procedure TFMFacturasEntregasPlatano.anyo_semana_fpcChange(
  Sender: TObject);
var
  rAux: real;
begin
  if ( DSMaestro.DataSet.State <> dsBrowse ) and ( Estado <> teLocalizar ) then
  begin
    rAux:= GetPrecioSemana( 'BAG', anyo_semana_fpc.Text );
    if rAux <> 0 then
      precio_fpc.Text:= FloatToStr( rAux );
  end;
end;

procedure TFMFacturasEntregasPlatano.btnAsignarPrecioClick(
  Sender: TObject);
begin
  UFDPrecioFacturaPlatano.PrecioFacturaPlatano( self, 'BAG', anyo_semana_fpc.Text );
end;

end.
