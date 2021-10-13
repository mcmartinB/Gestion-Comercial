unit MRemesas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, DBCtrls, CMaestroDetalle, Buttons, BCalendarButton,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  Db, ComCtrls, BCalendario, BEdit, DBTables, nbLabels;

type
  TFMRemesas = class(TMaestroDetalle)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    Bevel1: TBevel;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    LPlantacion_p: TLabel;
    moneda_cobro_r: TBDEdit;
    LFecha_inicio_p: TLabel;
    fecha_r: TBDEdit;
    BCFecha: TBCalendarButton;
    LEmpresa_p: TLabel;
    empresa_r: TBDEdit;
    BGEmpresa: TBGridButton;
    Label13: TLabel;
    ACampos: TAction;
    Label1: TLabel;
    referencia_r: TBDEdit;
    Label2: TLabel;
    banco_r: TBDEdit;
    BGBanco: TBGridButton;
    lblImporte: TLabel;
    importe_cobro_r: TBDEdit;
    Label4: TLabel;
    bruto_euros_r: TBDEdit;
    Label5: TLabel;        
    gastos_euros_r: TBDEdit;
    Label6: TLabel;
    liquido_euros_r: TBDEdit;
    BGMoneda: TBGridButton;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    DSDetalle: TDataSource;
    PTotales: TPanel;
    TotalRemesa: TBEdit;
    Label8: TLabel;
    Ldiff: TLabel;
    Panel1: TPanel;
    PDetalle: TPanel;
    Label7: TLabel;
    Rvisualizacion: TDBGrid;
    otros_r: TBDEdit;
    otros_euros_r: TBDEdit;
    Label9: TLabel;
    Label11: TLabel;
    cta_contable_r: TBDEdit;
    Label10: TLabel;
    BFacturas: TBEdit;
    contabilizado_r: TDBCheckBox;
    Label12: TLabel;
    QDetalle: TQuery;
    QRemesasExp: TQuery;
    Panel2: TPanel;
    Button1: TButton;
    factura_fr: TBDEdit;
    Label14: TLabel;
    fecha_factura_fr: TBDEdit;
    Label15: TLabel;
    importe_cobrado_fr: TBDEdit;
    Label3: TLabel;
    eTotal: TBEdit;
    eCambio: TBEdit;
    QDetalleTotal: TQuery;
    QImporteFactura: TQuery;
    QCobradoFactura: TQuery;
    QCobradoFacturaRemesa: TQuery;
    QRemesasExpempresa_r: TStringField;
    QRemesasExpreferencia_r: TIntegerField;
    QRemesasExpfecha_r: TDateField;
    QRemesasExpbanco_r: TStringField;
    QRemesasExpmoneda_cobro_r: TStringField;
    QRemesasExpimporte_cobro_r: TFloatField;
    QRemesasExpbruto_euros_r: TFloatField;
    QRemesasExpgastos_euros_r: TFloatField;
    QRemesasExpliquido_euros_r: TFloatField;
    QRemesasExprelacion_r: TStringField;
    QRemesasExpotros_r: TFloatField;
    QRemesasExpotros_euros_r: TFloatField;
    QRemesasExpcta_contable_r: TStringField;
    QRemesasExpcontabilizado_r: TStringField;
    QDetalleempresa_fr: TStringField;
    QDetallefactura_fr: TIntegerField;
    QDetallefecha_factura_fr: TDateField;
    QDetalleremesa_fr: TIntegerField;
    QDetallefecha_remesa_fr: TDateField;
    QDetalleimporte_cobrado_fr: TFloatField;
    QDetallecliente_fr: TStringField;
    QDetalleimporte_factura_fr: TFloatField;
    lblEmpresa: TnbStaticText;
    lblBanco: TnbStaticText;
    lblMoneda: TnbStaticText;
    QDetallemoneda_fr: TStringField;
    QFechaFactura: TQuery;
    QDetallecobrado_total_fr: TFloatField;
    QImporteFacturaRemesa: TQuery;
    lblEtiquetaDiasCobro: TLabel;
    lblDiasCobro: TLabel;
    notas_r: TDBMemo;
    lbl1: TLabel;
    QRemesasExpnotas_r: TStringField;
    lblEmpresa_: TLabel;
    empresa_fr: TBDEdit;
    strngfldQDetalleempresa_remesa_fr: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject;
      var isTime: Boolean);
    procedure empresa_rChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure QRemesasExpNewRecord(DataSet: TDataSet);
    procedure QRemesasExpAfterScroll(DataSet: TDataSet);
    procedure moneda_cobro_rChange(Sender: TObject);
    procedure QRemesasExpAfterOpen(DataSet: TDataSet);
    procedure QRemesasExpBeforeClose(DataSet: TDataSet);
    procedure importe_cobro_rChange(Sender: TObject);
    procedure bruto_euros_rChange(Sender: TObject);
    procedure gastos_euros_rChange(Sender: TObject);
    procedure QDetalleNewRecord(DataSet: TDataSet);
    procedure MCambiaFactura(Sender: TObject);
    procedure QDetalleAfterPost(DataSet: TDataSet);
    procedure QDetalleCalcFields(DataSet: TDataSet);
    procedure banco_rChange(Sender: TObject);
    procedure CambiarFechaFactura(Sender: TObject);

  private
    { Private declarations }
    ListaMaestro: TList;
    ListaDetalle: TList;
    Objeto: TObject;

    function  PonRemesa(empresa: string): string;

    procedure ValidarEntradaMaestro;
    procedure ValidarEntradaDetalle;
    procedure PutCambioImporte( const ADataSet: Boolean );
    procedure PutTotalesFacturas;
    function  ImportePendiente( const AEmpresa: string; const AFactura: Integer;
                                const AFecha: TDate; const AModificar: boolean;
                                var ATotalFactura: real ): real;
    function  FechaFactura( const AEmpresa: string; const AFactura: Integer; var VFecha: TDate ): boolean;


  public
    { Public declarations }
    oldBanco: string;
    iFacturas: integer;
    rTotalFacturas: real;

    procedure Filtro; override;
    procedure AnyadirRegistro; override;


    procedure AntesDeInsertar;
    procedure AntesDeLocalizar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;
    procedure VerDetalle;
    procedure EditarDetalle;
    procedure DetalleBorrar; override;
    procedure Borrar; override;
    procedure IncrementaRemesa;

    procedure QRemesasExpBeforePost(DataSet: TDataSet);


    //Listado
    procedure Previsualizar; override;

  protected
    {procedure Loaded; override;}

  end;


implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, bSQLUtils, bNumericUtils,
     CAuxiliarDB, Principal, DError, LRemesas, UDMAuxDB, DPreview, CReportes,
     UDMCambioMoneda, DSelectFactura, CMaestro, bMath, VAriants, UDMConfig;

{$R *.DFM}

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMRemesas.FormCreate(Sender: TObject);
begin
  //Variables globales
  M := Self; //Formulario maestro --> siempre es necesario
  MD := Self; //:=Self;  -->Formulario Maestro-Detalle


  LDiff.Caption := '';
  MultipleAltas := False;
  LineasObligadas := False;

  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := CalendarioFlotante;

     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
  PanelDetalle := PDetalle;
  RejillaVisualizacion := RVisualizacion;

     //***************************************************************
     //Fuente de datos maestro
  DataSetMaestro := QRemesasExp;
  DataSourceDetalle := DSDetalle;

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_remesas ';
 {+}where := ' WHERE empresa_r="###"';
 {+}Order := ' ORDER BY empresa_r,fecha_r DESC,referencia_r ';

  Registros := 0;
  Registro := 0;
  RegistrosInsertados := 0;


     //Lista de componentes, para optimizar recorrido
  ListaMaestro := TList.Create;
  PMaestro.GetTabOrderList(ListaMaestro);
  ListaDetalle := TList.Create;
  PDetalle.GetTabOrderList(ListaDetalle);

      //Sólo necesario si utilizamos la rejilla despegable
      //pero si no lo borras no pasa nada - deberias borrarlo
  DMBaseDatos.QDespegables.Tag := kNull;

{*RELLENAR, CONSTANTES EN CVariables}
     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_r.Tag := kEmpresa; //Para mostrar rejilla flotante
  banco_r.Tag := kBanco; //Para poner nombre rejilla
  moneda_cobro_r.Tag := kMoneda;
  fecha_r.Tag := kCalendar; //Para mostrar el calendario
  PMaestro.Tag := kMaestro; //Para poner todos los nombres
                                     //del panel maestro


{*DEJAR LAS QUE SEAN NECESARIAS}
     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnValidateDetailConstrains := ValidarEntradaDetalle;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnBrowse := AntesDeLocalizar;
  OnView := AntesDeVisualizar;
  OnViewDetail := VerDetalle;
  OnEditDetail := EditarDetalle;
  QRemesasExp.BeforePost := QRemesasExpBeforePost;
{*}
     //Focos
  FocoAltas := empresa_r;
  FocoModificar := importe_cobro_r;
  FocoLocalizar := empresa_r;
  FocoDetalle := empresa_fr;

     //Inicializar variables
  CalendarioFlotante.Date := Date;
  Rvisualizacion.Height := 245;

     //Muestra la barra de herramientas de Maestro/Detalle
     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> CVariables.tfMaestroDetalle then
  begin
    FormType := CVariables.tfMaestroDetalle;
    BHFormulario;
  end;


     //Abrir tablas
  DataSetMaestro.SQL.Clear;
  DataSetMaestro.SQL.Add(Select);
  DataSetMaestro.SQL.Add(Where);
  DataSetMaestro.SQL.Add(Order);

  with QDetalle do
  begin
    SQL.Clear;
    SQL.Add(' SELECT * ');
    SQL.Add(' FROM  frf_facturas_remesa ');
    SQL.Add(' WHERE empresa_remesa_fr = :empresa_r ');
    SQL.Add(' AND remesa_fr = :referencia_r ');
    SQL.Add(' AND fecha_remesa_fr = :fecha_r ');
    SQL.Add(' ORDER BY factura_fr ');
    if not Prepared then
      Prepare;
  end;
  with QDetalleTotal do
  begin
    SQL.Clear;
    SQL.Add(' SELECT count(*) facturas, sum(importe_cobrado_fr) cobrado, ');
      SQL.Add('        0 dias_cobro');
    SQL.Add(' FROM frf_facturas_remesa ');
    SQL.Add(' WHERE empresa_remesa_fr = :empresa_r ');
    SQL.Add(' AND remesa_fr = :referencia_r ');
    SQL.Add(' AND fecha_remesa_fr = :fecha_r ');
    SQL.Add(' AND remesa_fr <> 0 ');
    if not Prepared then
      Prepare;
  end;
  with QImporteFacturaRemesa do
  begin
    SQL.Clear;
    SQL.Add(' select cliente_fac_f cliente, importe_total_f importe , sum(importe_cobrado_fr) cobrado ');
    SQL.Add(' from frf_facturas, frf_facturas_remesa ');
    SQL.Add(' where empresa_f = :empresa ');
    SQL.Add(' and n_factura_f = :factura ');
    SQL.Add(' and fecha_factura_f = :fecha ');
    SQL.Add(' and empresa_fr = :empresa ');
    SQL.Add(' and factura_fr = :factura ');
    SQL.Add(' and fecha_factura_fr = :fecha ');
    SQL.Add(' group by 1,2 ');
    if not Prepared then
      Prepare;
  end;
  with QImporteFactura do
  begin
    SQL.Clear;
    SQL.Add(' select importe_total_f importe  ');
    SQL.Add(' from frf_facturas ');
    SQL.Add(' where empresa_f = :empresa ');
    SQL.Add(' and n_factura_f = :factura ');
    SQL.Add(' and fecha_factura_f = :fecha ');
    if not Prepared then
      Prepare;
  end;
  with QFechaFactura do
  begin
    SQL.Clear;
    SQL.Add(' select fecha_factura_f fecha , tipo_factura_f ');
    SQL.Add(' from frf_facturas ');
    SQL.Add(' where empresa_f = :empresa ');
    SQL.Add(' and n_factura_f = :factura ');
    SQL.Add(' and fecha_factura_f <= :fecha ');

    SQL.Add(' and ( ');
    SQL.Add('      ( (ABS(importe_total_f) - ');
    SQL.Add('        nvl( ABS((select sum(importe_cobrado_fr) ');
    SQL.Add('          from frf_facturas_remesa ');
    SQL.Add('        where empresa_fr = :empresa ');
    SQL.Add('          and factura_fr = :factura ');
    SQL.Add('          and fecha_factura_fr = fecha_factura_f)), 0) ) <> 0 ) ');
    SQL.Add('      or ');
    SQL.Add('      ( not exists ');
    SQL.Add('        (select * from frf_facturas_remesa ');
    SQL.Add('         where empresa_fr = :empresa ');
    SQL.Add('           and factura_fr = :factura ');
    SQL.Add('           and fecha_factura_fr = fecha_factura_f ) ) ');
    SQL.Add('     ) ');
    SQL.Add(' order by fecha_factura_f desc, tipo_factura_f asc ');

    if not Prepared then
      Prepare;
  end;
  with QCobradoFactura do
  begin
    SQL.Clear;
    SQL.Add(' select sum( importe_cobrado_fr ) cobrado ');
    SQL.Add(' from frf_facturas_remesa ');
    SQL.Add(' where empresa_fr = :empresa ');
    SQL.Add(' and factura_fr = :factura ');
    SQL.Add(' and fecha_factura_fr = :fecha ');
    if not Prepared then
      Prepare;
  end;
  with QCobradoFacturaRemesa do
  begin
    SQL.Clear;
    SQL.Add(' select sum( importe_cobrado_fr ) cobrado ');
    SQL.Add(' from frf_facturas_remesa ');
    SQL.Add(' where empresa_fr = :empresa ');
    SQL.Add(' and factura_fr = :factura ');
    SQL.Add(' and fecha_factura_fr = :fechaFactura ');
    SQL.Add(' and remesa_fr = :remesa ');
    SQL.Add(' and fecha_remesa_fr = :fechaRemesa ');
    if not Prepared then
      Prepare;
  end;

  try
    DataSetMaestro.Open;
  except
  end;

  //Visualizar estado inicial
  Visualizar;

  //Los dias de cobros ponderado con el importe solo lo visualizamos e bonde
  (*BONDE*)
  lblEtiquetaDiasCobro.Visible:= False;
  lblDiasCobro.Visible:= lblEtiquetaDiasCobro.Visible;
end;

procedure TFMRemesas.QRemesasExpAfterOpen(DataSet: TDataSet);
begin
  QDetalle.Open;
  QDetalleTotal.Open;
end;

procedure TFMRemesas.QRemesasExpBeforeClose(DataSet: TDataSet);
begin
  QDetalle.Close;
  QDetalleTotal.Close;
end;

procedure TFMRemesas.FormActivate(Sender: TObject);
begin
  Top := 1;
     //Si la tabla no esta abierta salimos
  if not DataSetMaestro.Active then Exit;
end;

procedure TFMRemesas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListaMaestro.Free;
  ListaDetalle.Free;

  DMBaseDatos.QDespegables.Tag := 0;
   //Cerramos todos los dataSet abiertos
  DMBaseDatos.DBBaseDatos.CloseDataSets;
   //Despreparamos querys preparadas explicitamente
  if QDetalle.Prepared then
    QDetalle.UnPrepare;
  if QDetalleTotal.Prepared then
    QDetalleTotal.UnPrepare;
  if QImporteFacturaRemesa.Prepared then
    QImporteFacturaRemesa.UnPrepare;
  if QImporteFactura.Prepared then
    QImporteFactura.UnPrepare;
  if QCobradoFactura.Prepared then
    QCobradoFactura.UnPrepare;


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


procedure TFMRemesas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    //Si la rejilla esta desplegada no hacemos nada
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
           //No hacemos nada
      Exit;
    //Si  el calendario esta desplegado no hacemos nada
  if (CalendarioFlotante <> nil) then
    if (CalendarioFlotante.Visible) then
            //No hacemos nada
      Exit;
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  case key of
    vk_Return, vk_down:
      begin
        if not notas_r.Focused then
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

procedure TFMRemesas.Filtro;
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
            where := where + ' ' + name + ' LIKE ' + '"' + Text + '"'
          else
            if InputType = itDate then
              where := where + ' ' + name + ' =' + SQLDate(Text)
            else
              if InputType = itReal then
                //where := where + ' ' + name + ' =' + '"' + StringReplace(Text, ',', '.', [rfReplaceAll, rfIgnoreCase]) + '"'
                where := where + ' ' + name + ' =' + StringReplace(Text, ',', '.', [rfReplaceAll, rfIgnoreCase])
              else
                //where := where + ' ' + name + ' =' + '"' + Text + '"';
                where := where + ' ' + name + ' =' +  Text ;
          flag := true;
        end;
      end;
    end;
  end;
  if flag then
  begin
    where := ' WHERE ' + where;
    (*
    where := where + ' and exists ' + #13 + #10 +
            ' ( select *                                 ' + #13 + #10 +
            '   from frf_facturas_remesa, frf_facturas ' + #13 + #10 +
            '   where empresa_r = empresa_remesa_fr ' + #13 + #10 +
            '     and referencia_r = remesa_fr                       ' + #13 + #10 +
            '     and fecha_r = fecha_remesa_fr ' + #13 + #10 +
            '     and empresa_fr = empresa_f ' + #13 + #10 +
            '     and factura_fr = n_factura_f ' + #13 + #10 +
            '     and fecha_factura_fr = fecha_factura_f ' + #13 + #10 +
            '     and cliente_fac_f = ''SAA'' ' + #13 + #10 +
            ' ) ';
    *)
  end
  else
  begin
    (*
    where := ' where exists ' + #13 + #10 +
            ' ( select *                                 ' + #13 + #10 +
            '   from frf_facturas_remesa, frf_facturas ' + #13 + #10 +
            '   where empresa_r = empresa_remesa_fr ' + #13 + #10 +
            '     and referencia_r = remesa_fr                       ' + #13 + #10 +
            '     and fecha_r = fecha_remesa_fr ' + #13 + #10 +
            '     and empresa_fr = empresa_f ' + #13 + #10 +
            '     and factura_fr = n_factura_f ' + #13 + #10 +
            '     and fecha_factura_fr = fecha_factura_f ' + #13 + #10 +
            '     and cliente_fac_f = ''SAA'' ' + #13 + #10 +
            ' ) ';
    *)
  end;
end;

//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que son insertados
//para, else fin usa los campos que marcamos como PrimaryKey


procedure TFMRemesas.AnyadirRegistro;
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
          if InputType = itDate then
            where := where + ' ' + name + ' =' + SQLDate(Text)
          else
            where := where + ' ' + name + ' =' + '"' + Text + '"';
          flag := true;
        end;
      end;
    end;
  end;
  where := where + ') ';
end;


//function semi-generica, introducir restricciones particulares donde se indica
//Conprueba que tengan valor todos los campos marcados como required

procedure TFMRemesas.ValidarEntradaMaestro;
var
  uno, dos: real;
  aux: string;
begin
  //Que no hayan campos vacios
  if Trim(empresa_r.Text) = '' then
  begin
    empresa_r.SetFocus;
    raise Exception.Create('Faltan Datos (Código de la empresa).');
  end;
  if Trim(referencia_r.Text) = '' then
  begin
    referencia_r.SetFocus;
    raise Exception.Create('Faltan Datos (Código de referencia).');
  end;
  if Trim(fecha_r.Text) = '' then
  begin
    fecha_r.SetFocus;
    raise Exception.Create('Faltan Datos (Fecha).');
  end;
  if Trim(banco_r.Text) = '' then
  begin
    banco_r.SetFocus;
    raise Exception.Create('Faltan Datos (Código del banco).');
  end;
  if Trim(moneda_cobro_r.Text) = '' then
  begin
    moneda_cobro_r.SetFocus;
    raise Exception.Create('Faltan Datos (Código de la moneda).');
  end;
  if (Trim(importe_cobro_r.Text) = '') (*or (Trim(importe_cobro_r.Text) = '0')*)then
  begin
    importe_cobro_r.SetFocus;
    raise Exception.Create('Faltan Datos (Importe cobro).');
  end;
  if (Trim(bruto_euros_r.Text) = '') (*or (Trim(bruto_euros_r.Text) = '0')*) then
  begin
    bruto_euros_r.SetFocus;
    raise Exception.Create('Faltan Datos (Bruto euros).');
  end;

    //**************************************************************
    //REstricciones Particulares
    //**************************************************************
  //Comprobar la validez de la empresa
  if Estado = teAlta then
    with DMBaseDatos.QGeneral do
    begin
      Tag := 0;
      Cancel;
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM frf_empresas ' +
        'WHERE empresa_e="' + empresa_r.Text + '"');
      try
        Open;
      except
        raise Exception.Create('Error: No se puede comprobar la validez del código de empresa.');
      end;

      if isEmpty then
      begin
        empresa_r.SetFocus;
        raise Exception.Create('Error: Código de empresa incorrecto.');
      end;
    end;

    //Comprobar la validez del banco
  with DMBaseDatos.QGeneral do
  begin
    Cancel;
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbancos ' +
      'WHERE banco_b="' + banco_r.Text + '"');
    try
      Open;
    except
      raise Exception.Create('Error: No se puede comprobar la validez del código de banco.');
    end;

    if isEmpty then
    begin
      banco_r.SetFocus;
      raise Exception.Create('Error: Código de banco incorrecto.');
    end;
  end;

    //Comprobar la validez de la moneda
  with DMBaseDatos.QGeneral do
  begin
    Cancel;
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM frf_monedas ' +
      'WHERE moneda_m="' + moneda_cobro_r.Text + '"');
    try
      Open;
    except
      raise Exception.Create('Error: No se puede comprobar la validez del código de moneda.');
    end;

    if isEmpty then
    begin
      moneda_cobro_r.SetFocus;
      raise Exception.Create('Error: Código de moneda incorrecto.');
    end;
  end;

  //El cambio de moneda debe estar grabado
  if not ChangeExist( moneda_cobro_r.Text, fecha_r.Text ) then
  begin
    bruto_euros_r.Text:= '0';
    Raise Exception.Create('Falta grabar el cambio de "' + moneda_cobro_r.Text + '" ' +
                           'del dia "' + fecha_r.Text + '".');
  end;

  //Comprobar que el numero no este repetido si lo hemos introducido
  //manualmente
  if Estado = teAlta then
      with DMBaseDatos.QGeneral do
      begin
        Cancel;
        Close;
        SQL.Clear;
        SQL.Add(' SELECT * FROM frf_remesas ' +
          ' WHERE referencia_r="' + referencia_r.Text + '"' +
          ' AND empresa_r="' + empresa_r.Text + '"');
        try
          Open;
        except
          raise Exception.Create('Error: No se puede comprobar la validez de la referéncia de remesas.');
        end;

        if not isEmpty then
        begin
          referencia_r.SetFocus;
          raise Exception.Create('Error: Referéncia de remesas duplicado.');
        end;
      end;

    //Rellenamos liquido
  aux:= StringReplace( bruto_euros_r.Text, '.', '', [rfReplaceAll, rfIgnoreCase]);
  if Trim(bruto_euros_r.Text) = '' then
    uno := 0
  else
  begin
    uno := StrToFloat(aux);
  end;
  aux:= StringReplace( gastos_euros_r.Text, '.', '', [rfReplaceAll, rfIgnoreCase]);
  if Trim(gastos_euros_r.Text) = '' then
    dos := 0
  else
  begin
    dos := StrToFloat(aux);
  end;

  DSMaestro.DataSet.FieldByName('liquido_euros_r').asstring :=
    FloatTostr(uno - dos);
  DSMaestro.DataSet.FieldByName('bruto_euros_r').asstring :=
    FloatTostr(uno);

  //SI hay importe para otras compensaciones debe haber cta. contable
  if StrToIntDef( otros_r.Text, 0 ) <> 0 then
  begin
    if Trim( cta_contable_r.Text ) = '' then
    begin
      if cta_contable_r.CanFocus then
        cta_contable_r.SetFocus;
      raise Exception.Create('Error: Falta la cuenta para otras compensaciones.');
    end;
  end;
end;

//**************************************************************
//IMPRESION: Introducir QuickReport
//**************************************************************

procedure TFMRemesas.Previsualizar;
begin
     //Crear el listado
  QRLRemesas := TQRLRemesas.Create(Application);
  PonLogoGrupoBonnysa(QRLRemesas, empresa_r.Text);
  Preview(QRLRemesas);
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar rejilla flotante (Formulario)
//   - Borrar Lista de acciones(Formulario)
//   - Borrar las funciones de esta seccion(Codigo)
//*****************************************************************************
//*****************************************************************************

procedure TFMRemesas.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGEmpresa);
    kMoneda: DespliegaRejilla(BGMoneda);
    kBanco: DespliegaRejilla(BGBanco, [empresa_r.text]);
    kCalendar: DespliegaCalendario(BCFecha);
  end;
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos altas
//Aprobrechar para modificar estado controles

procedure TFMRemesas.AntesDeInsertar;
begin
  factura_fr.Text := '';
  Rvisualizacion.Height := 245;
  importe_cobro_r.Text := '0';
  bruto_euros_r.Text := '0';
  gastos_euros_r.Text := '0';
  liquido_euros_r.Text := '0';
  otros_r.Text := '0';
  otros_euros_r.Text := '0';
  TotalRemesa.Text := '';
  lblDiasCobro.Caption:= '0';

  referencia_r.TabStop:= False;
  referencia_r.ReadOnly:= True;
  referencia_r.Required:= False;
  referencia_r.ColorNormal:= clBtnFace;
  referencia_r.ColorEdit:= clBtnFace;
  referencia_r.ColorDisable:= clBtnFace;
end;

procedure TFMRemesas.AntesDeLocalizar;
begin
  factura_fr.Text := '';
  Rvisualizacion.Height := 245;
  importe_cobro_r.Text := '';
  bruto_euros_r.Text := '';
  gastos_euros_r.Text := '';
  liquido_euros_r.Text := '';
  otros_r.Text := '';
  otros_euros_r.Text := '';
  TotalRemesa.Text := '';
  lblDiasCobro.Caption:= '0';

  referencia_r.TabStop:= True;
  referencia_r.ReadOnly:= False;
  referencia_r.Required:= False;
  referencia_r.ColorNormal:= clWhite;
  referencia_r.ColorEdit:= clMoneyGreen;
  referencia_r.ColorDisable:= clSilver;
end;

//Evento que se produce cuando pulsamos localizar
//Aprobrechar para modificar estado controles

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMRemesas.AntesDeModificar;
var
  i: Integer;
begin
  //Si la remesa esta asociada a una factura para la que ha
  //sido contabilizadao el cobro no se puede modificar
  if contabilizado_r.Checked = true then
  begin
    raise Exception.Create('No se pueden modificar remesas contabilizadas.');
  end;

    //Deshabilitamos todos los componentes Modificable=False
  for i := 0 to ListaMaestro.Count - 1 do
  begin
    Objeto := ListaMaestro.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;

end;


//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores
procedure TFMRemesas.AntesDeVisualizar;
var i: Integer;
begin
  factura_fr.Text := '';

  if (Estado = teConjuntoResultado) then
  begin
    if RegistrosInsertados > 0 then
    begin
      RegistrosInsertados := 0;
    end;
  end;

    //Restauramos estado controles
  for i := 0 to ListaMaestro.Count - 1 do
  begin
    Objeto := ListaMaestro.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        Enabled := true;
  end;

  PutCambioImporte( true );
  PutTotalesFacturas;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

//Para saber cuando tenemos que obligar a que un campo sea requerido

procedure TFMRemesas.RequiredTime(Sender: TObject;
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

procedure TFMRemesas.ValidarEntradaDetalle;
var
  iFactura: integer;
  dFecha: TDateTime;
  rACobrar, rCobrado, rTotalFactura: Real;
begin
  iFactura:= StrToIntDef( factura_fr.Text, 0 );
  if iFactura = 0 then
  begin
    factura_fr.SetFocus;
    raise Exception.Create('Falta el número de la factura.');
  end
  else
  begin
    if ( Length( fecha_factura_fr.Text ) = 10 ) and
      TryStrToDate( fecha_factura_fr.Text, dFecha ) then
    begin

      if referencia_r.Text <> '0' then
      if ( referencia_r.Text <> '0' ) and ( dFecha > TDate( QRemesasExpfecha_r.AsDateTime ) ) then
      begin
        if MessageDlg('La fecha de la factura/abono es superior a la de la remesa.' + #13 + #10 +
                      '¿Seguro que quiere continuar?', mtConfirmation, mbOKCancel, 0 ) = mrCancel then
        begin
          factura_fr.SetFocus;
          Abort;
        end;
        //Si es un abono (valor negativo), dejar pasar
        (*
        if StrToFloatDef( importe_cobrado_fr.Text, 0 ) > 0 then
        begin
          factura_fr.SetFocus;
          Close;
          raise Exception.Create('Error: la fecha de la factura no debe ser superior a la de la remesa.');
        end;
        *)
      end;

      //Comprobar la validez de la moneda
      if referencia_r.Text <> '0' then
      with DMBaseDatos.QGeneral do
      begin
        Cancel;
        Close;
        SQL.Clear;
        SQL.Add(' SELECT moneda_f FROM frf_facturas ');
        SQL.Add(' WHERE empresa_f = :empresa ');
        SQL.Add('   and n_factura_f = :factura ');
        SQL.Add('   and fecha_factura_f = :fecha ');
        ParamByName('empresa').AsString:= empresa_fr.Text;
        ParamByName('factura').AsInteger:= iFactura;
        ParamByName('fecha').AsDateTime:= dFecha;
        try
          Open;
        except
          factura_fr.SetFocus;
          Close;
          raise Exception.Create('Error: No se puede comprobar la validez del código de moneda.');
        end;

        if isEmpty then
        begin
          factura_fr.SetFocus;
          Close;
          raise Exception.Create('Error: Factura inexistente.');
        end
        else
        begin
          if FieldByName('moneda_f').AsString <> moneda_cobro_r.Text then
          begin
            factura_fr.SetFocus;
            Close;
            raise Exception.Create('Error: No coincide la moneda de la factura con la de la remesa.');
          end;
        end;
        Close;
      end;

      if TryStrToFloat( importe_cobrado_fr.Text, double( rACobrar ) ) then
      begin
        rCobrado:= ImportePendiente( empresa_fr.Text, iFactura, dFecha, ( QDetalle.State = dsEdit ), rTotalFactura );

        if ( rACobrar = 0 ) and ( rTotalFactura <> 0 )then
        begin
           importe_cobrado_fr.SetFocus;
           raise Exception.Create('El importe a cobrar no puede ser 0.');
        end;

        if bRoundTo(Abs(rACobrar),-2) > bRoundTo(Abs(rCobrado),-2) then
        begin
          importe_cobrado_fr.SetFocus;
          raise Exception.Create('El importe a cobrar es superior al pendiente de la factura.');
        end;
      end
      else
      begin
        importe_cobrado_fr.SetFocus;
        raise Exception.Create('Importe a cobrar de la factura incorrecto.');
      end;
    end
    else
    begin
      fecha_factura_fr.SetFocus;
      raise Exception.Create('La fecha de la factura es incorrecta.');
    end;
  end;
end;

procedure TFMRemesas.VerDetalle;
begin
  Rvisualizacion.Height := 245;
  Rvisualizacion.Enabled := true;
  Button1.Enabled := true;

  QDetalle.Close;
  QDetalle.Open;
end;

procedure TFMRemesas.EditarDetalle;
begin
  if contabilizado_r.Checked = true then
  begin
    raise Exception.Create('No se pueden modificar remesas contabilizadas.');
  end;
  if ( referencia_r.Text = '0' ) and not gbEnlaceContable then
  begin
    raise Exception.Create('Error: Solo los contables pueden añadir facturas a la remesa 0.');
  end;

  Rvisualizacion.Height := 196;
  Rvisualizacion.Enabled := false;
  Button1.Enabled := false;
  if EstadoDetalle = tedModificar then
  begin
    FocoDetalle := importe_cobrado_fr;
  end
  else
  begin
    FocoDetalle := empresa_fr;
  end;
  empresa_fr.Text:= empresa_r.Text;
end;

procedure TFMRemesas.DetalleBorrar;
begin
  //Si la remesa esta asociada a una factura
  //contabilizada no se puede modificar
  if contabilizado_r.Checked = true then
  begin
    ShowError('No se puede borrar ni modificar una remesa que tiene una factura cobrada y contabilizada.');
  end
  else
  begin
    inherited;
    //Por ultimo visualizamos resultado
    Visualizar;
    PutTotalesFacturas;
  end;
end;

procedure TFMRemesas.Borrar;
begin
    //Si la remesa esta asociada a una factura
    //contabilizada no se puede modificar
  if contabilizado_r.Checked = true then
  begin
    ShowError('No se puede borrar una remesa que tiene una factura cobrada y contabilizada.');
    Exit;
  end;

  inherited;
  //Por ultimo visualizamos resultado
  Visualizar;
end;

function TFMRemesas.PonRemesa(empresa: string): string;
var
  aux: Integer;
begin
  //REFERENCIA REMESA
  with DMBaseDatos.QGeneral do
  begin
    Tag := kNull;
    Close;
    SQL.Clear;
    SQL.Add(' select ref_cobros_e from frf_empresas' +
      ' where empresa_e=:empresa ');
    ParamByName('empresa').AsString := empresa_r.Text;
    Open;
    if isEmpty then
    begin
      PonRemesa := 'FALTA';
      Exit;
    end;

    Aux := FieldByName('ref_cobros_e').AsInteger;
    PonRemesa := IntToStr(Aux + 1);
  end;
end;


procedure TFMRemesas.IncrementaRemesa;
var
  aux: Integer;
begin
  //INCREMENTAR REFERENCIA REMESAS
  with DMBaseDatos.QGeneral do
  begin
    Tag := kNull;
    Close;
    SQL.Clear;
    SQL.Add(' select ref_cobros_e from frf_empresas' +
      ' where empresa_e=:empresa ');
    ParamByName('empresa').AsString := empresa_r.Text;
    Open;
    if isEmpty then
    begin
      raise Exception.Create('Error al intentar conseguir el numero de referencia.');
    end;

    Aux := FieldByName('ref_cobros_e').AsInteger;
    if not (Aux + 1 = StrToInt(Referencia_r.Text)) then
    DSMaestro.DataSet.FieldByName('referencia_r').AsString := IntToStr(Aux + 1);

    SQL.Clear;
    SQL.Add(' update frf_empresas set ref_cobros_e=:nuevo  ' +
      ' where empresa_e=:empresa ');
    ParamByName('empresa').AsString := empresa_r.Text;
    ParamByName('nuevo').AsString := IntToStr(Aux + 1);
    ExecSql;
    if RowsAffected <> 1 then
    begin
      raise Exception.Create('Error al intentar conseguir el numero de referencia.');
    end;
  end;
end;

procedure TFMRemesas.empresa_rChange(Sender: TObject);
begin
  lblEmpresa.Caption:= desEmpresa( empresa_r.Text );
  lblBanco.Caption:= desBanco( banco_r.Text );
  if ( lblEmpresa.Caption <> '' ) and ( Estado = teAlta ) then
    referencia_r.Text := PonRemesa(Empresa_r.Text);
end;


procedure TFMRemesas.QRemesasExpBeforePost(DataSet: TDataSet);
begin
  if DataSet.State = dsInsert then IncrementaRemesa;
end;


procedure TFMRemesas.Button1Click(Sender: TObject);
begin
  if referencia_r.Text = '0' then
  begin
    if QRemesasExp.FieldByName('contabilizado_r').AsString = 'S' then
    begin
      QRemesasExp.Edit;
      QRemesasExp.FieldByName('contabilizado_r').AsString := 'N';
      QRemesasExp.Post;
      Button1.Caption := 'Contabilizar';
    end;
    ShowMessage('La remesa 0 no se puede contabilizar.');
  end
  else
  if gbEnlaceContable then
  begin
    if QRemesasExp.IsEmpty or (QRemesasExp.State <> dsBrowse) then
    begin
      Button1.Enabled := false;
      exit;
    end;
    if Button1.Caption = 'Contabilizar' then
    begin
      QRemesasExp.Edit;
      QRemesasExp.FieldByName('contabilizado_r').AsString := 'S';
      QRemesasExp.Post;
      Button1.Caption := 'Descontabilizar';
    end
    else
    begin
      QRemesasExp.Edit;
      QRemesasExp.FieldByName('contabilizado_r').AsString := 'N';
      QRemesasExp.Post;
      Button1.Caption := 'Contabilizar';
    end
  end
  else
  begin
    ShowMessage(' Acción solo permitida a los usuarios de contabilidad.' + #13 + #10 +
                ' Por favor, pongase en contacto con alguien del departamento contable.     ');
  end;
end;

procedure TFMRemesas.QRemesasExpNewRecord(DataSet: TDataSet);
begin
  if Estado <> teLocalizar then
    QRemesasExp.FieldByName('contabilizado_r').AsString := 'N';
end;

procedure TFMRemesas.moneda_cobro_rChange(Sender: TObject);
begin
  lblMoneda.Caption:= desMoneda( moneda_cobro_r.Text );
  if Trim(moneda_cobro_r.Text) = '' then
  begin
    lblImporte.Caption:= ' Importe';
  end
  else
  begin
    lblImporte.Caption:= ' Importe (' + moneda_cobro_r.Text + ')';
  end;
end;


procedure TFMRemesas.PutTotalesFacturas;
var
  rDif: real;
begin
  BFacturas.Text:= QDetalleTotal.FieldByName('facturas').AsString;
  TotalRemesa.Text:= QDetalleTotal.FieldByName('cobrado').AsString;
  if QDetalleTotal.FieldByName('cobrado').AsFloat <> 0 then
  begin
    lblDiasCobro.Caption:= FormatFloat('#,##0.00', QDetalleTotal.FieldByName('dias_cobro').AsFloat /
                           QDetalleTotal.FieldByName('cobrado').AsFloat );
  end
  else
  begin
    lblDiasCobro.Caption:= '';
  end;

  rDif:= bRoundTo( QDetalleTotal.FieldByName('cobrado').AsFloat, -2 ) -
        bRoundTo( ( QRemesasExp.FieldByName('importe_cobro_r').AsFloat +
                        QRemesasExp.FieldByName('otros_r').AsFloat ), -2 );

  if referencia_r.Text = '0' then
  begin
    TotalRemesa.ColorNormal:= clWhite;
    TotalRemesa.Font.Color:= clBlack;
    Ldiff.Caption:= '';
  end
  else
  begin
    if rDif = 0 then
    begin
      TotalRemesa.ColorNormal:= clWhite;
      TotalRemesa.Font.Color:= clBlack;
      Ldiff.Caption:= '';
    end
    else
    if rDif > 0 then
    begin
      TotalRemesa.ColorNormal:= clRed;
      TotalRemesa.Font.Color:= clBlack;
      Ldiff.Caption:= FormatFloat( '#0.00', rDif );
      Ldiff.Font.Color:= clRed;
    end
    else
    begin
      TotalRemesa.ColorNormal:= clBlue;
      TotalRemesa.Font.Color:= clWhite;
      Ldiff.Caption:= FormatFloat( '#0.00', rDif );
      Ldiff.Font.Color:= clBlue;
    end;
  end;
end;



procedure TFMRemesas.PutCambioImporte( const ADataSet: Boolean );
var
  rImporteCobro, rBrutoEuros, rGastosEuros, rOtros: Real;
  rFactor: Real;
  rLiquidosEuros, rOtrosEuros: Real;
  rTotal: Real;
begin
  if ADataSet then
  begin
    rImporteCobro:= QRemesasExpimporte_cobro_r.AsFloat;
    rOtros:= QRemesasExpotros_r.AsFloat;
    rBrutoEuros:= QRemesasExpbruto_euros_r.AsFloat;
    rGastosEuros:= QRemesasExpgastos_euros_r.AsFloat;
  end
  else
  begin
    if Trim( importe_cobro_r.Text ) = '' then
    begin
      rImporteCobro:= 0;
    end
    else
    begin
      rImporteCobro:= StrToFloatDef( Trim( importe_cobro_r.Text ), 0 );
    end;
    if Trim( bruto_euros_r.Text ) = '' then
    begin
      rBrutoEuros:= 0;
    end
    else
    begin
      rBrutoEuros:= StrToFloatDef( Trim( bruto_euros_r.Text ), 0 );
    end;
    if Trim( gastos_euros_r.Text ) = '' then
    begin
      rGastosEuros:= 0;
    end
    else
    begin
      rGastosEuros:= StrToFloatDef( Trim( gastos_euros_r.Text ), 0 );
    end;
    if Trim( otros_r.Text ) = '' then
    begin
      rOtros:= 0;
    end
    else
    begin
      rOtros:= StrToFloatDef( Trim( otros_r.Text ), 0 );
    end;
  end;

  if rImporteCobro = 0 then
  begin
    rFactor:= 1;
  end
  else
  begin
    rFactor:= rBrutoEuros / rImporteCobro;
  end;

  if ( Estado = teModificar ) or ( Estado = teAlta ) then
  begin
    rLiquidosEuros:= rBrutoEuros - rGastosEuros;
    rOtrosEuros:= rFactor * rOtros;
    liquido_euros_r.Text:= FormatFloat( '#0.00', rLiquidosEuros );
    otros_euros_r.Text:= FormatFloat( '#0.00', rOtrosEuros );
  end;

  rTotal:= rImporteCobro + rOtros;

  if ( Estado = teLocalizar ) and not ADataSet then
  begin
    eTotal.Text:= '';
    eCambio.Text:= '';
  end
  else
  begin
    eTotal.Text:= FormatFloat( '#0.00', rTotal );
    eCambio.Text:= FormatFloat( '#0.000', rFactor );
  end;
end;

procedure TFMRemesas.importe_cobro_rChange(Sender: TObject);
var
  iAux: Double;
  dAux: TDateTime;
begin
  if ( Estado = teModificar ) or ( Estado = teAlta ) then
  begin
    if moneda_cobro_r.Text = 'EUR' then
    begin
      bruto_euros_r.Text:= importe_cobro_r.Text;
    end
    else
    begin
      if TryStrToFloat( importe_cobro_r.Text, iAux ) then
      begin
        if TryStrToDate( fecha_r.Text, dAux ) then
          iAux:= ChangeToEuro( moneda_cobro_r.Text, fecha_r.Text, iAux, 2)
        else
          iAux:= 0;
      end
      else
      begin
        iAux:= 0;
      end;
      bruto_euros_r.Text:= FormatFloat( '#0.00', iAux );
    end;
    PutCambioImporte( false );
  end;
end;

procedure TFMRemesas.bruto_euros_rChange(Sender: TObject);
begin
  if ( Estado = teModificar ) or ( Estado = teAlta ) then
  begin
    if moneda_cobro_r.Text = 'EUR' then
    begin
      importe_cobro_r.Text:= bruto_euros_r.Text;
    end;
    PutCambioImporte( false );
  end;
end;

procedure TFMRemesas.gastos_euros_rChange(Sender: TObject);
begin
  if ( Estado = teModificar ) or ( Estado = teAlta ) then
  //if ( QRemesasExp.State = dsInsert ) or ( QRemesasExp.State = dsEdit ) then
  begin
    PutCambioImporte( false );
  end;
end;

procedure TFMRemesas.QRemesasExpAfterScroll(DataSet: TDataSet);
begin
  if not (QRemesasExp.IsEmpty or (QRemesasExp.State <> dsBrowse)) then
  begin
    Button1.Enabled := true;
    if contabilizado_r.Checked then
      Button1.Caption := 'Descontabilizar'
    else
      Button1.Caption := 'Contabilizar';
  end
  else
  begin
    Button1.Enabled := false;
  end;
  PutCambioImporte( false );
  PutTotalesFacturas;
end;

procedure TFMRemesas.QDetalleNewRecord(DataSet: TDataSet);
begin
  QDetalle.FieldByName('empresa_fr').AsString := QRemesasExp.FieldByName('empresa_r').AsString;
  QDetalle.FieldByName('empresa_remesa_fr').AsString := QRemesasExp.FieldByName('empresa_r').AsString;
  QDetalle.FieldByName('remesa_fr').AsString := QRemesasExp.FieldByName('referencia_r').AsString;
  QDetalle.FieldByName('fecha_remesa_fr').AsString := QRemesasExp.FieldByName('fecha_r').AsString;
end;

function  TFMRemesas.FechaFactura( const AEmpresa: string; const AFactura: Integer; var VFecha: TDate ): boolean;
begin
  with QFechaFactura do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('factura').AsInteger:= AFactura;
    ParamByName('fecha').AsDate:= VFecha;
    Open;
    if not IsEmpty then
    begin
      VFecha:= FieldByName('fecha').AsDateTime;
      result:= True;
    end
    else
    begin
      result:= False;
    end;

    Close;
  end;
end;

(*TODO*)
//Parametros remesa
function TFMRemesas.ImportePendiente( const AEmpresa: string; const AFactura: Integer;
                                      const AFecha: TDate; const AModificar: boolean;
                                      var ATotalFactura: real ): real;

begin
  with QImporteFactura do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('factura').AsInteger:= AFactura;
    ParamByName('fecha').AsDate:= AFecha;
    Open;
    ATotalFactura:= FieldByName('importe').AsFloat;
    Close;
  end;
  with QCobradoFactura do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('factura').AsInteger:= AFactura;
    ParamByName('fecha').AsDate:= AFecha;
    Open;
    result:= ATotalFactura - FieldByName('cobrado').AsFloat;
    Close;
  end;
  if AModificar then
  begin
    with QCobradoFacturaRemesa do
    begin
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('factura').AsInteger:= AFactura;
      ParamByName('fechaFactura').AsDate:= AFecha;
      ParamByName('remesa').AsInteger:= QRemesasExp.FieldByName('referencia_r').AsInteger;
      ParamByName('fechaRemesa').AsDate:= QRemesasExp.FieldByName('fecha_r').AsDateTime;
      Open;
      result:= result + FieldByName('cobrado').AsFloat;
      Close;
    end;
  end;
end;

procedure TFMRemesas.MCambiaFactura(Sender: TObject);
var
  iFactura, iRemesa: integer;
  dFecha: TDateTime;
begin
  if Estado = teOperacionDetalle then
  begin
    iRemesa:= StrToIntDef( referencia_r.Text, 0 );
    iFactura:= StrToIntDef( factura_fr.Text, 0 );
    if iFactura = 0 then
    begin
      importe_cobrado_fr.Text:= '';
    end
    else
    begin
      (*
      if Length( fecha_factura_fr.Text ) = 10 then
      begin
        dFecha:= StrTodate( fecha_factura_fr.Text);
      end
      else
      *)
      begin
        if iRemesa = 0 then
          dFecha:= Date
        else
          dFecha:= TDate(QRemesasExpfecha_r.AsDateTime) + 30;
      end;

      if FechaFactura( empresa_fr.Text, iFactura, TDate(dFecha) ) then
      begin
        fecha_factura_fr.Text:= FormatDateTime('dd/mm/yyyy', dFecha );
        //rImporte:= ImportePendiente( empresa_r.Text, iFactura, dFecha, ( QDetalle.State = dsEdit ), rTotalFactura );
        //importe_cobrado_fr.Text:= FloatToStr( rImporte );
      end
      else
      begin
        fecha_factura_fr.Text:= '';
        importe_cobrado_fr.Text:= '';
      end;
    end;
  end;
end;

procedure TFMRemesas.CambiarFechaFactura(Sender: TObject);
var
  iFactura: integer;
  //iRemesa: integer;
  dFecha: TDateTime;
  rImporte, rTotalFactura: Real;
begin
  if Estado = teOperacionDetalle then
  begin
    if Length( fecha_factura_fr.Text ) = 10 then
    begin
      //iRemesa:= StrToIntDef( referencia_r.Text, 0 );
      iFactura:= StrToIntDef( factura_fr.Text, 0 );
      dFecha:= StrToDate( fecha_factura_fr.Text );
      if FechaFactura( empresa_fr.Text, iFactura, TDate(dFecha) ) then
      begin
        if TDate(dFecha) = TDate(StrToDate( fecha_factura_fr.Text )) then
        begin
          rImporte:= ImportePendiente( empresa_fr.Text, iFactura, dFecha, ( QDetalle.State = dsEdit ), rTotalFactura );
        end
        else
        begin
          rImporte:= 0;
        end;
        importe_cobrado_fr.Text:= FloatToStr( rImporte );
      end;
    end;
  end;
end;

procedure TFMRemesas.QDetalleAfterPost(DataSet: TDataSet);
begin
  QDetalleTotal.Close;
  QDetalleTotal.Open;
  PutTotalesFacturas;
end;

procedure TFMRemesas.QDetalleCalcFields(DataSet: TDataSet);
begin
  with QImporteFacturaRemesa do
  begin
    ParamByName('empresa').AsString:= QDetalleempresa_fr.AsString;
    ParamByName('factura').AsInteger:= QDetallefactura_fr.AsInteger;
    ParamByName('fecha').AsDate:= QDetallefecha_factura_fr.AsDateTime;
    Open;
    QDetallecliente_fr.AsString:= FieldByName('cliente').AsString;
    QDetalleimporte_factura_fr.AsFloat:= FieldByName('importe').AsFloat;
    QDetallecobrado_total_fr.AsFloat:= FieldByName('cobrado').AsFloat;
    QDetallemoneda_fr.Asstring:= moneda_cobro_r.Text;
    Close;
  end;
end;

procedure TFMRemesas.banco_rChange(Sender: TObject);
begin
  lblBanco.Caption:= desBanco( banco_r.Text );
end;


end.
