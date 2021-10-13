unit UFMRecepcionPinyas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid,
  BDEdit, BEdit, dbTables, DError, BCalendarButton, ComCtrls, BCalendario,
  nbLabels;

type
  TFMRecepcionPinyas = class(TMaestroDetalle)
    DSMaestro: TDataSource;
    PMaestro: TPanel;
    RejillaFlotante: TBGrid;
    Calendario: TBCalendario;
    observaciones_rpc: TDBMemo;
    nbLabel24: TnbLabel;
    codigo_rpc: TBDEdit;
    lObservacion: TnbLabel;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    nbLabel5: TnbLabel;
    lblProveedor: TnbStaticText;
    lblEmpresa: TnbStaticText;
    btnFecha_llegada: TBCalendarButton;
    btnEmpresa_rpc: TBGridButton;
    btnProveedor_rpc: TBGridButton;
    nbLabel4: TnbLabel;
    nbLabel30: TnbLabel;
    btnCentroDestino: TBGridButton;
    lblCentroDestino: TnbStaticText;
    nbLabel31: TnbLabel;
    nbLabel33: TnbLabel;
    btnTransporte: TBGridButton;
    lblTransporte: TnbStaticText;
    empresa_rpc: TBDEdit;
    proveedor_rpc: TBDEdit;
    vehiculo_rpc: TBDEdit;
    anyo_rpc: TBDEdit;
    centro_rpc: TBDEdit;
    jaula_rpc: TBDEdit;
    transporte_rpc: TBDEdit;
    nbLabel3: TnbLabel;
    nbLabel20: TnbLabel;
    fecha_rpc: TBDEdit;
    semana_rpc: TBDEdit;
    nbLabel12: TnbLabel;
    peso_entrada_rpc: TBDEdit;
    nbLabel6: TnbLabel;
    peso_salida_rpc: TBDEdit;
    peso_carga_rpc: TLabel;
    DSDetalle: TDataSource;
    PDetalle: TPanel;
    PDetalle1: TPanel;
    nbLabel10: TnbLabel;
    nbLabelCajas: TnbLabel;
    nbLabelKilos: TnbLabel;
    nbLabel8: TnbLabel;
    btnFinca: TBGridButton;
    nbLabel9: TnbLabel;
    nbLabel14: TnbLabel;
    semana_rpl: TBDEdit;
    anyo_rpl: TBDEdit;
    lote_rpl: TBDEdit;
    finca_rpl: TBDEdit;
    pinyas_rpl: TBDEdit;
    kilos_rpl: TBDEdit;
    RVisualizacion1: TDBGrid;
    DSGastosEntregas: TDataSource;
    status_rpc: TBDEdit;
    cbbstatus_rpc: TComboBox;
    lblProducto_: TnbLabel;
    producto_rpc: TBDEdit;
    btnProducto: TBGridButton;
    stProducto: TnbStaticText;
    edtFechaHasta: TBEdit;
    lblFechaHasta: TnbLabel;
    btnFechaHasta: TBCalendarButton;
    nbLabel25: TnbLabel;
    almacen_rpl: TBDEdit;
    btnAlmacen: TBGridButton;
    lblAlmacen: TnbStaticText;
    lblCodigo1: TnbLabel;
    sector_rpl: TBDEdit;
    btnSector: TBGridButton;
    qryCab: TQuery;
    tblLin: TTable;
    lblFinca: TnbStaticText;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure empresa_rpcChange(Sender: TObject);
    procedure proveedor_rpcChange(Sender: TObject);
    procedure btnFecha_llegadaClick(Sender: TObject);
    procedure btnEmpresa_rpcClick(Sender: TObject);
    procedure btnProveedor_rpcClick(Sender: TObject);
    procedure almacen_rplChange(Sender: TObject);
    procedure btnTransporteClick(Sender: TObject);
    procedure centro_rpcChange(Sender: TObject);
    procedure transporte_rpcChange(Sender: TObject);
    procedure btnCentroDestinoClick(Sender: TObject);
    procedure btnAlmacenClick(Sender: TObject);
    procedure empresa_rpcRequiredTime(Sender: TObject; var isTime: Boolean);
    procedure btnFechaHastaClick(Sender: TObject);
    procedure producto_rpcChange(Sender: TObject);
    procedure btnProductoClick(Sender: TObject);
    procedure btnFincaClick(Sender: TObject);
    procedure btnSectorClick(Sender: TObject);
    procedure qryCabAfterPost(DataSet: TDataSet);
    procedure finca_rplChange(Sender: TObject);
    procedure tblLinAfterInsert(DataSet: TDataSet);
    procedure sector_rplChange(Sender: TObject);
    procedure semana_rplChange(Sender: TObject);
    procedure anyo_rplChange(Sender: TObject);
    procedure peso_entrada_rpcChange(Sender: TObject);
    procedure peso_salida_rpcChange(Sender: TObject);
    procedure tblLinAfterEdit(DataSet: TDataSet);
  private
    { Private declarations }
    Lista, ListaDetalle: TList;
    Objeto: TObject;
    rKilosLinea: Real;

    procedure ValidarEntradaMaestro;
    procedure ValidarEntradaDetalle;
    procedure VerDetalle;
    procedure EditarDetalle;
    procedure AbrirTablas;
    procedure CerrarTablas;

    procedure AntesDeVisualizar;
    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeLocalizar;
    procedure PreparaAlta;


    function GetLinea( const ACodigo: string ): Integer;
    function GetLote: string;
    function GetTaraCamion: real;
    function KilosGrabados( const AEntrega: string ): Real;

  public
    { Public declarations }
    procedure Borrar; override;

    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    //Listado
    procedure Previsualizar; override;
 end;



implementation

//uses  bMath, UQREntregasMaset, CFPCamionEntrega, UFMEntregasCompra;

uses CVariables, CGestionPrincipal, UDMBaseDatos, CAuxiliarDB, bMath, bTimeUtils,
  Principal, UDMAuxDB, Variants, bSQLUtils, bTextUtils, Dpreview,
  UQREntregas, CReportes, CMaestro, UDMConfig,   UFTransportistas, UFProveedores,
  UMDEntregas ;

{$R *.DFM}


procedure TFMRecepcionPinyas.AbrirTablas;
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
  Registro := 1;
  Registros := 0;
  RegistrosInsertados := 0;
end;

procedure TFMRecepcionPinyas.CerrarTablas;
begin
  CloseAuxQuerys;
end;

procedure TFMRecepcionPinyas.FormCreate(Sender: TObject);
begin
  LineasObligadas := false;
  ListadoObligado := false;
  MultipleAltas := false;

  //Variables globales
  M := Self;
  MD := Self;
  gRF := RejillaFlotante;
  gCF := Calendario;

  //Panel
  PanelMaestro := PMaestro;
  PanelDetalle := PDetalle1;
  RejillaVisualizacion := RVisualizacion1;

  //Fuente de datos
  DataSetMaestro := qryCab;
  DataSourceDetalle := DSDetalle;

  (*TODO*)
  Select := 'select * From frf_recepcion_pinyas_c';
  where := ' Where codigo_rpc = ''###''';
  Order := ' Order by codigo_rpc DESC';

  //Abrir tablas/Querys
  try
    AbrirTablas;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      Close;
    end;
  end;

  //Lista de componentes
  Lista := TList.Create;
  PanelMaestro.GetTabOrderList(Lista);
  ListaDetalle := TList.Create;
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
  OnValidateDetailConstrains := ValidarEntradaDetalle;

  //Preparar panel de detalle
  OnViewDetail := VerDetalle;
  OnEditDetail := EditarDetalle;

  OnEdit:= PreparaAlta;
  OnView:= AntesDeVisualizar;
  OnInsert:= AntesDeInsertar;
  OnEdit:= AntesDeModificar;
  OnBrowse:= AntesDeLocalizar;

  (*TODO*)
  FocoAltas := empresa_rpc;
  FocoModificar := centro_rpc;
  FocoLocalizar := empresa_rpc;
  FocoDetalle := almacen_rpl;
  Calendario.Date := date;

  (*TODO*)
  //Constantes para las rejillas de l combo
  empresa_rpc.Tag:= kEmpresa;
  centro_rpc.Tag:= kCentro;
  proveedor_rpc.Tag:= kProveedor;
  producto_rpc.Tag:= kProducto;
  transporte_rpc.Tag:= kTransportista;
  fecha_rpc.Tag:= kCalendar;
  edtFechaHasta.Tag:= kCalendar;

  almacen_rpl.Tag:= kProveedorAlmacen;
  finca_rpl.Tag:= kFincaAlmacen;
  sector_rpl.Tag:= kSectorFinca;

  empresa_rpc.Change;
end;

procedure TFMRecepcionPinyas.PreparaAlta;
begin
  codigo_rpc.Enabled:= False;
end;

procedure TFMRecepcionPinyas.AntesDeVisualizar;
var i: Integer;
begin
    //Resaturar estado
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := True;
  end;

  status_rpc.Enabled:= False;
  cbbstatus_rpc.Enabled:= False;

  lblFechaHasta.Visible:= False;
  edtFechaHasta.Visible:= False;
  btnFechaHasta.Visible:= False;
end;

procedure TFMRecepcionPinyas.AntesDeInsertar;
begin
  codigo_rpc.Enabled:= False;

  empresa_rpc.Text:= gsDefEmpresa;
  centro_rpc.Text:= gsDefCentro;
  fecha_rpc.Text:= DateToStr( date );

  peso_entrada_rpc.Text:= '0';
  peso_salida_rpc.Text:= '0';
end;

procedure TFMRecepcionPinyas.AntesDeModificar;
var
  i: integer;
begin
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;

end;

procedure TFMRecepcionPinyas.AntesDeLocalizar;
begin
  status_rpc.Enabled:= True;
  cbbstatus_rpc.Enabled:= True;

  lblFechaHasta.Visible:= True;
  edtFechaHasta.Visible:= True;
  btnFechaHasta.Visible:= True;
  edtFechaHasta.Text:= '';
end;

procedure TFMRecepcionPinyas.FormActivate(Sender: TObject);
begin
  if not DataSetMaestro.Active then Exit;

     //Variables globales
  M := Self;
  MD := Self;
  gRF := RejillaFlotante;
  gCF := Calendario;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestroDetalle then
  begin
    FormType := tfMaestroDetalle;
    BHFormulario;
  end;
  BHGrupoDesplazamientoMaestro(PCMaestro);
  BHGrupoDesplazamientoDetalle(PCDetalle);


     //Maximizamos si no lo esta
  if Self.WindowState <> wsMaximized then
  begin
    Self.WindowState := wsMaximized;
  end;
end;

procedure TFMRecepcionPinyas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Lista.Free;
  ListaDetalle.Free;

  //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

     // Cerrar tabla
  CerrarTablas;

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

{+ CUIDADIN }

procedure TFMRecepcionPinyas.FormKeyDown(Sender: TObject; var Key: Word;
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
    vk_f2:
    begin
      if empresa_rpc.Focused then btnempresa_rpc.Click
      else if proveedor_rpc.Focused then btnproveedor_rpc.Click
      else if producto_rpc.Focused then btnProducto.Click
      else if centro_rpc.Focused then btnCentroDestino.Click
      else if transporte_rpc.Focused then btnTransporte.Click
      else if fecha_rpc.Focused then btnFecha_llegada.Click
      else if edtFechaHasta.Focused then btnFechaHasta.Click
      else if almacen_rpl.Focused then btnAlmacen.Click
      else if sector_rpl.Focused then btnSector.Click
      else if finca_rpl.Focused then btnFinca.Click;
    end;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

procedure TFMRecepcionPinyas.Filtro;
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
        if ( Trim(Text) <> '' ) and ( name <> 'fecha_rpc' ) and ( name <> 'edtFechaHasta' ) then
        begin
          if flag then where := where + ' and ';
          if InputType = itChar then
          begin
            //if name = 'proveedor_rpc' then
            //  where := where + ' proveedor_rpc LIKE ''%' + Text + '%'' '
            //else
              where := where + ' ' + name + ' LIKE ' + SQLFilter(Text);
          end
          else
            if InputType = itDate then
            begin
              where := where + ' ' + name + ' =' + SQLDate(Text)
            end
            else
              where := where + ' ' + name + ' =' + Text;
          flag := True;
        end;
      end;
    end;
  end;

  if fecha_rpc.Text <> '' then
  begin
    if flag then where := where + ' and ';
    if edtFechaHasta.Text <> '' then
    begin
      where := where + ' fecha_rpc between ' + SQLDate(fecha_rpc.Text) + ' and ' + SQLDate(edtFechaHasta.Text);
    end
    else
    begin
      where := where + ' fecha_rpc = ' + SQLDate(fecha_rpc.Text);
    end;
    flag:= TRue;
  end;

  if flag then where := ' WHERE ' + where;
end;

procedure TFMRecepcionPinyas.AnyadirRegistro;
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

function GetCodigoEntrega( const AEmpresa, ACentro, AFecha: string ): string;
var
  iDia, iMes, iAnyo, iCont: word;
  dFecha: TDateTime;
begin
  //Codigo entrada --> EEECAA-contador
  //EEE -> Empresa
  //C -> Codigo centro llegada
  //AA -> Año

  result:= AEmpresa;
  result:= result + ACentro;
  dFecha:= StrToDateDef( AFecha, Date );
  DecodeDate( dFecha, iAnyo, iMes, iDia );

  if dFecha >= EncodeDate(iAnyo, 7, 1 ) then
  begin
    iAnyo:= iAnyo + 1;
  end;
  result:= result + Copy( IntToStr( iAnyo ), 3, 2 );
  result:= result + '-';


  with DMAuxDB.QAux do
  begin
    SQL.Clear;
      SQL.Add('select cont_recepcion_pinyas_c ');
      SQL.Add('from frf_centros ');
      SQL.Add('where empresa_c = :empresa ');
      SQL.Add('and centro_c = :centro ');
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('centro').AsString:= ACentro;
    try
      Open;
      iCont:= FieldByName('cont_recepcion_pinyas_c').AsInteger + 1;
    finally
      Close;
    end;
  end;

  result:= result + Rellena( IntToStr( iCont ), 5, '0', taLeftJustify );
end;

procedure TFMRecepcionPinyas.qryCabAfterPost(DataSet: TDataSet);
begin
  if Estado = teAlta then
  begin
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add('update frf_centros ');
      SQL.Add('set cont_recepcion_pinyas_c = cont_recepcion_pinyas_c + 1');
      SQL.Add('where empresa_c = :empresa ');
      SQL.Add('and centro_c = :centro ');
      ParamByName('empresa').AsString:= DataSet.FieldByName('empresa_rpc').AsString;
      ParamByName('centro').AsString:= DataSet.FieldByName('centro_rpc').AsString;
      ExecSQL;
    end;
  end;
end;


procedure TFMRecepcionPinyas.ValidarEntradaMaestro;
var
  i, iAux: Integer;
  dFecha: TdateTime;
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

  //Anyo/semana
  iAux:= StrToIntDef( anyo_rpc.Text, 0 );
  if ( iAux < CurrentYear - 20 ) or ( iAux > CurrentYear + 20 ) then
  begin
    raise Exception.Create('Falta el año o es incorrecto.');
  end;
  iAux:= StrToIntDef( semana_rpc.Text, 0 );
  if ( iAux < 1 ) or ( iAux > 53 ) then
  begin
    raise Exception.Create('Falta la semana o es incorrecta.');
  end;

  //Fecha de llegada
  if not TryStrToDate( fecha_rpc.Text, dFecha ) then
    raise Exception.Create('Faltan fecha de llegada o es incorrecta.');

  //PONER CODIGO
  if DSMaestro.DataSet.State = dsInsert then
  begin
    DSMaestro.DataSet.FieldByName('codigo_rpc').AsString:= GetCodigoEntrega( empresa_rpc.Text, centro_rpc.Text, fecha_rpc.Text );
  end;

  if status_rpc.Text = '' then
    DSMaestro.DataSet.FieldByName('status_rpc').Asinteger:= 0;
end;

function TFMRecepcionPinyas.GetLinea( const ACodigo: string ): Integer;
begin
    DMAuxDB.QAux.SQL.Clear;
    DMAuxDB.QAux.SQL.Add('select nvl(max(linea_rpl),0) linea');
    DMAuxDB.QAux.SQL.Add('from frf_recepcion_pinyas_l ');
    DMAuxDB.QAux.SQL.Add('where codigo_rpl = :codigo ');
    DMAuxDB.QAux.ParamByName('codigo').AsString:= ACodigo;
    DMAuxDB.QAux.Open;
    try
      Result:= DMAuxDB.QAux.FieldByName('linea').AsInteger + 1;
    finally
      DMAuxDB.QAux.Close;
    end;
end;

function TFMRecepcionPinyas.GetLote: string;

begin
  if ( tblLin.State = dsEdit ) or ( tblLin.State = dsInsert ) then
  begin
     //07 semana , 14 año, 00 empaquetado sat, 830 el código del "sector-finca"
     //semana
     if Length( semana_rpl.Text ) = 2 then
       result:= semana_rpl.Text
     else
     if Length( semana_rpl.Text ) = 1 then
       result:= '0' + semana_rpl.Text
     else
       result:= '00';

     //año
     if Length( anyo_rpl.Text ) = 4 then
       result:= result + Copy( anyo_rpl.Text, 3, 2 )
     else
     if Length( anyo_rpl.Text ) = 3then
       result:= result + Copy( anyo_rpl.Text, 2, 2 )
     else
     if Length( anyo_rpl.Text ) = 2 then
       result:= result + anyo_rpl.Text
     else
     if Length( anyo_rpl.Text ) = 1 then
       result:= result +  '0' + anyo_rpl.Text
     else
       result:= result + Copy( IntToStr( CurrentYear ), 3, 2 );

     //empaquetado sat
     result:= result + '00';

     //Sector finca
     if Length( sector_rpl.Text ) = 3 then
       result:= result + sector_rpl.Text
     else
     if Length( sector_rpl.Text ) = 2 then
       result:= result + '0' + sector_rpl.Text
     else
     if Length( sector_rpl.Text ) = 1 then
       result:= result + '00' + sector_rpl.Text
     else
       result:= result + '000';
  end;
end;

procedure TFMRecepcionPinyas.sector_rplChange(Sender: TObject);
begin
  if ( tblLin.State = dsEdit ) or ( tblLin.State = dsInsert ) then
    lote_rpl.Text:= GetLote;
end;

procedure TFMRecepcionPinyas.semana_rplChange(Sender: TObject);
begin
  if ( tblLin.State = dsEdit ) or ( tblLin.State = dsInsert ) then
    lote_rpl.Text:= GetLote;
end;

procedure TFMRecepcionPinyas.anyo_rplChange(Sender: TObject);
begin
  if ( tblLin.State = dsEdit ) or ( tblLin.State = dsInsert ) then
    lote_rpl.Text:= GetLote;
end;

function TFMRecepcionPinyas.KilosGrabados( const AEntrega: string ): Real;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select sum( kilos_rpl ) kilos ');
    SQL.Add('  from frf_recepcion_pinyas_l ');
    SQL.Add(' where codigo_rpl = :entrega  ');
    ParamByName('entrega').AsString:= AEntrega;
    Open;
    Result:= FieldByName('kilos').AsFloat;
    Close;
  end;
end;

procedure TFMRecepcionPinyas.ValidarEntradaDetalle;
var
  iAux: Integer;
  rAux, rKilos: Real;
begin
  //Almacen, finca, sector
  if lblTransporte.Caption = '' then
    raise Exception.Create('Falta el código del cosechero o es incorrecto.');
  if lblFinca.Caption = '' then
    raise Exception.Create('Falta el código de la finca o es incorrecto.');
  if desProveedorSector( empresa_rpc.Text, proveedor_rpc.Text, almacen_rpl.Text, finca_rpl.Text, sector_rpl.Text ) = '' then
    raise Exception.Create('Falta el código del sector o es incorrecto.');

  //Total piñas y kilos
  if pinyas_rpl.Text = '' then
    raise Exception.Create('Falta número de piñas de platano de la linea.');
  if kilos_rpl.Text = '' then
    raise Exception.Create('Falta número de kilos de platano de la linea.');

  //Control que el maximo de kilos no supere el destrio del camion
  rAux:= GetTaraCamion;
  if rAux > 0 then
  begin
     rKilos:= StrToFloat( kilos_rpl.Text );
     if rKilos > rAux then
     begin
       raise Exception.Create('Los kilos de la linea no pueden ser superior al destare del camión.');
     end
     ELSE
     begin
       rKilos:= KilosGrabados( codigo_rpc.Text ) + rKilos - rKilosLinea;
       if rKilos > rAux then
       begin
         raise Exception.Create('El sumatorio de los kilos de la linea no pueden ser superior al destare del camión.');
       end
     end;
  end;

  //lote
  if lote_rpl.Text = '' then
    raise Exception.Create('Falta el lote de la linea.');

  //Anyo/semana
  iAux:= StrToIntDef( anyo_rpl.Text, 0 );
  if ( iAux < CurrentYear - 20 ) or ( iAux > CurrentYear + 20 ) then
  begin
    raise Exception.Create('Falta el año o es incorrecto.');
  end;
  iAux:= StrToIntDef( semana_rpl.Text, 0 );
  if ( iAux < 1 ) or ( iAux > 53 ) then
  begin
    raise Exception.Create('Falta la semana o es incorrecta.');
  end;
end;

procedure TFMRecepcionPinyas.tblLinAfterInsert(DataSet: TDataSet);
begin
  tblLin.FieldByName('codigo_rpl').AsString:= qryCab.FieldByName('codigo_rpc').AsString;
  tblLin.FieldByName('linea_rpl').AsInteger:= GetLinea( qryCab.FieldByName('codigo_rpc').AsString );
  tblLin.FieldByName('empresa_rpl').AsInteger:= GetLinea( qryCab.FieldByName('empresa_rpc').AsString );
  tblLin.FieldByName('proveedor_rpl').AsInteger:= GetLinea( qryCab.FieldByName('proveedor_rpc').AsString );
  tblLin.FieldByName('anyo_rpl').AsString:= qryCab.FieldByName('anyo_rpc').AsString;
  tblLin.FieldByName('semana_rpl').AsInteger:= qryCab.FieldByName('semana_rpc').AsInteger;

  rKilosLinea:= 0;
end;

procedure TFMRecepcionPinyas.tblLinAfterEdit(DataSet: TDataSet);
begin
  rKilosLinea:= tblLin.FieldByName('kilos_rpl').AsFloat;
end;

procedure TFMRecepcionPinyas.Previsualizar;
begin
(*
  QREntregas := TQREntregas.Create(self);
  QREntregas.ReportTitle := self.Caption;
  MDEntregas.PutSQL( RegistroActual );
  try
    try
      MDEntregas.QListEntregasC.Open;
      MDEntregas.TListEntregasL.Open;


      if not ( DMConfig.EsLaFont ) then
      begin
        MDEntregas.QueryPacking( False );
        MDEntregas.TListPackingList.Open;
        MDEntregas.TListFechasPacking.Open;
        MDEntregas.TListStatusPacking.Open;
        MDEntregas.TListCalibrePacking.Open;
      end;


      MDEntregas.TListGastosEntregas.Open;

      PonLogoGrupoBonnysa( QREntregas, empresa_rpc.Text );
      //QREntregas.PonBarCode( codigo_rpc.Text );
      Preview(QREntregas);
    finally
      if not ( DMConfig.EsLaFont) then
      begin
        MDEntregas.TListCalibrePacking.Close;
        MDEntregas.TListStatusPacking.Close;
        MDEntregas.TListFechasPacking.Close;
        MDEntregas.TListPackingList.Close;
      end;
      MDEntregas.TListGastosEntregas.Close;

      MDEntregas.TListEntregasL.Close;
      MDEntregas.QListEntregasC.Close;
    end;
  except
    FreeAndNil(QREntregas);
    raise;
  end;
*)
end;


procedure TFMRecepcionPinyas.VerDetalle;
begin
  PanelDetalle.visible := False;

  PMaestro.Height:= 273;
  //observaciones_rpc.Visible:= True;
  //lObservacion.Visible:= True;

end;

procedure TFMRecepcionPinyas.EditarDetalle;
begin
  FocoDetalle := almacen_rpl;
  PanelDetalle.visible := True;

  //observaciones_rpc.Visible:= False;
  //lObservacion.Visible:= False;
  PMaestro.Height:= 273;
end;


procedure TFMRecepcionPinyas.Borrar;
begin
  //Que no tenga rf asociada
  (*
  with DMAuxDB.QAux do
  begin
    SQL.Clear;

    SQL.Add(' select * ');
    SQL.Add(' from frf_gastos_entregas ');
    SQL.Add(' where codigo_ge = :codigo ');
    ParamByname('codigo').AsString:=  MDEntregas.QEntregasC.FieldBYname('codigo_rpc').AsString;
    try
      try
        Open;
        if not IsEmpty then
        begin
          ShowMessage('No se puede borrar la entrega por que tiene una gastos asociados. ');
          Exit;
        end;
      finally
        Close;
      end;
    except
      //Ignoramos error
    end;
  end;
  *)

  inherited Borrar;
end;


procedure TFMRecepcionPinyas.empresa_rpcChange(Sender: TObject);
begin
  lblEmpresa.Caption := desEmpresa(empresa_rpc.Text);
  centro_rpc.Change;
  proveedor_rpc.Change;
  producto_rpc.Change;
  transporte_rpc.Change;
end;

procedure TFMRecepcionPinyas.centro_rpcChange(Sender: TObject);
begin
  lblCentroDestino.Caption := desCentro(empresa_rpc.Text, centro_rpc.Text);
end;

procedure TFMRecepcionPinyas.proveedor_rpcChange(Sender: TObject);
begin
  lblProveedor.Caption := desProveedor(empresa_rpc.Text, proveedor_rpc.Text);
end;

procedure TFMRecepcionPinyas.producto_rpcChange(Sender: TObject);
begin
  stProducto.Caption:= desProducto(empresa_rpc.Text, producto_rpc.Text);
end;

procedure TFMRecepcionPinyas.transporte_rpcChange(Sender: TObject);
begin
  lblTransporte.Caption := desTransporte(empresa_rpc.Text, transporte_rpc.Text);
end;

function TFMRecepcionPinyas.GetTaraCamion: real;
begin
  Result:=  qryCab.fieldbyName('peso_entrada_rpc').AsFloat - qryCab.fieldbyName('peso_salida_rpc').AsFloat;
end;

procedure TFMRecepcionPinyas.peso_entrada_rpcChange(Sender: TObject);
begin
  peso_carga_rpc.Caption:= FormatFloat( '#,##0.00', GetTaraCamion );
end;

procedure TFMRecepcionPinyas.peso_salida_rpcChange(Sender: TObject);
begin
  peso_carga_rpc.Caption:= FormatFloat( '#,##0.00', GetTaraCamion );
end;

procedure TFMRecepcionPinyas.almacen_rplChange(Sender: TObject);
begin
  lblAlmacen.Caption := desProveedorAlmacen(empresa_rpc.Text, proveedor_rpc.Text, almacen_rpl.Text);
end;

procedure TFMRecepcionPinyas.finca_rplChange(Sender: TObject);
begin
   lblFinca.Caption := desProveedorFinca(empresa_rpc.Text, proveedor_rpc.Text, almacen_rpl.Text, finca_rpl.Text );
end;

procedure TFMRecepcionPinyas.btnFecha_llegadaClick(Sender: TObject);
begin
  if fecha_rpc.Focused then
    DespliegaCalendario( btnFecha_llegada );
end;

procedure TFMRecepcionPinyas.btnFechaHastaClick(Sender: TObject);
begin
  if edtFechaHasta.Focused then
    DespliegaCalendario( btnFechaHasta );
end;

procedure TFMRecepcionPinyas.btnempresa_rpcClick(Sender: TObject);
begin
  if empresa_rpc.Focused then
    DespliegaRejilla( btnEmpresa_rpc);
end;

procedure TFMRecepcionPinyas.btnCentroDestinoClick(Sender: TObject);
begin
  if centro_rpc.Focused then
    DespliegaRejilla( btnCentroDestino, [empresa_rpc.Text] );
end;

procedure TFMRecepcionPinyas.btnProductoClick(Sender: TObject);
begin
  if producto_rpc.Focused then
    DespliegaRejilla( btnProducto, [empresa_rpc.Text] );
end;

procedure TFMRecepcionPinyas.btnproveedor_rpcClick(Sender: TObject);
var
  sResult: string;
begin
  if proveedor_rpc.Focused then
  if SeleccionaProveedor( self, proveedor_rpc, empresa_rpc.Text, sResult ) then
  begin
    proveedor_rpc.Text:= sResult;
  end;
  //DespliegaRejilla( btnproveedor_rpc, [empresa_rpc.Text] );
end;

procedure TFMRecepcionPinyas.btnTransporteClick(Sender: TObject);
var
  sResult: String;
begin
  if transporte_rpc.Focused then
  if SeleccionaTransportista( self, transporte_rpc, empresa_rpc.Text, sResult ) then
  begin
    transporte_rpc.Text:= sResult;
  end;
  //DespliegaRejilla( btnTransporte, [empresa_rpc.text] );
end;


procedure TFMRecepcionPinyas.btnAlmacenClick(Sender: TObject);
begin
  if almacen_rpl.Focused then
    DespliegaRejilla( btnAlmacen, [empresa_rpc.Text, proveedor_rpc.Text] );
end;

procedure TFMRecepcionPinyas.btnFincaClick(Sender: TObject);
begin
  if finca_rpl.Focused then
    DespliegaRejilla( btnFinca, [empresa_rpc.Text, proveedor_rpc.Text, almacen_rpl.Text] );
end;

procedure TFMRecepcionPinyas.btnSectorClick(Sender: TObject);
begin
  if sector_rpl.Focused then
    DespliegaRejilla( btnSector, [empresa_rpc.Text, proveedor_rpc.Text, almacen_rpl.Text, finca_rpl.Text] );
end;


procedure TFMRecepcionPinyas.empresa_rpcRequiredTime(Sender: TObject;
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

(*
procedure TFMRecepcionPinyas.RVisualizacion1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  sAux: string;
begin
  if DataCol = 0 then
  begin
    sAux:= DSDetalle.DataSet.FieldByName('almacen_rpl').AsString + ' -  ' +
           desProveedorAlmacen( empresa_rpc.Text, proveedor_rpc.Text,
                        DSDetalle.DataSet.FieldByName('almacen_rpl').AsString );
    if ( gdSelected in State ) or ( gdFocused in State ) then
    begin
      if RVisualizacion1.Focused then
        RVisualizacion1.Canvas.Brush.Color := clMenuHighlight
      else
        RVisualizacion1.Canvas.Brush.Color := clWhite;
    end
    else
    begin
      RVisualizacion1.Canvas.Brush.Color := clWhite;
    end;

    RVisualizacion1.Canvas.TextRect(Rect,Rect.Left, Rect.Top, sAux);
  end
  else
  if DataCol = 4 then
  begin
    sAux:= DSDetalle.DataSet.FieldByName('variedad_el').AsString + ' -  ' +
           DesVariedad( empresa_rpc.Text, proveedor_rpc.Text,
                        DSDetalle.DataSet.FieldByName('producto_el').AsString,
                        DSDetalle.DataSet.FieldByName('variedad_el').AsString );
    if ( gdSelected in State ) or ( gdFocused in State ) then
    begin
      if RVisualizacion1.Focused then
        RVisualizacion1.Canvas.Brush.Color := clMenuHighlight
      else
        RVisualizacion1.Canvas.Brush.Color := clWhite;
    end
    else
    begin
      RVisualizacion1.Canvas.Brush.Color := clWhite;
    end;

    RVisualizacion1.Canvas.TextRect(Rect,Rect.Left, Rect.Top, sAux);

  end
  else
  if DataCol = 10 then
  begin
    if not DSDetalle.DataSet.IsEmpty then
    begin
      case DSDetalle.DataSet.FieldByName('unidad_precio_el').AsInteger of
        1: sAux:= 'CAJA';
        2: sAux:= 'UNIDAD';
        else
           sAux:= 'KILO';
      end;
    end
    else
    begin
      sAux:= '';
    end;
    if ( gdSelected in State ) or ( gdFocused in State ) then
    begin
      if RVisualizacion1.Focused then
        RVisualizacion1.Canvas.Brush.Color := clMenuHighlight
      else
        RVisualizacion1.Canvas.Brush.Color := clWhite;
    end
    else
    begin
      RVisualizacion1.Canvas.Brush.Color := clWhite;
    end;

    RVisualizacion1.Canvas.TextRect(Rect,Rect.Left, Rect.Top, sAux);

  end
  else
  begin
    RVisualizacion1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;
*)

end.

