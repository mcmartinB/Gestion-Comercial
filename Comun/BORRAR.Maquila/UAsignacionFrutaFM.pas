unit UAsignacionFrutaFM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid,
  BDEdit, BEdit, dbTables, DError, BCalendarButton, ComCtrls, BCalendario,
  nbLabels;

type
  TFMAsignacionFruta = class(TMaestroDetalle)
    DSMaestro: TDataSource;
    PMaestro: TPanel;
    RejillaFlotante: TBGrid;
    Calendario: TBCalendario;
    observaciones_ac: TDBMemo;
    nbLabel24: TnbLabel;
    contador_ac: TBDEdit;
    lObservacion: TnbLabel;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    lblProveedor: TnbStaticText;
    lblEmpresa: TnbStaticText;
    btnFecha: TBCalendarButton;
    btnEmpresa: TBGridButton;
    btnProveedor: TBGridButton;
    empresa_ac: TBDEdit;
    proveedor_ac: TBDEdit;
    nbLabel3: TnbLabel;
    nbLabel20: TnbLabel;
    fecha_asignacion_ac: TBDEdit;
    DSDetalle: TDataSource;
    PDetalle: TPanel;
    PDetalle1: TPanel;
    nbLabel8: TnbLabel;
    btnProductoL: TBGridButton;
    nbLabel9: TnbLabel;
    nbLabel14: TnbLabel;
    producto_al: TBDEdit;
    linea_al: TBDEdit;
    palets_al: TBDEdit;
    RVisualizacion1: TDBGrid;
    DSGastosEntregas: TDataSource;
    status_ac: TBDEdit;
    cbbstatus_ac: TComboBox;
    edtFechaHasta: TBEdit;
    lblFechaHasta: TnbLabel;
    btnFechaHasta: TBCalendarButton;
    lblCodigo1: TnbLabel;
    calibre_al: TBDEdit;
    btnCalibre: TBGridButton;
    qryCab: TQuery;
    tblLin: TTable;
    lblProductoL: TnbStaticText;
    lblCodigo2: TnbLabel;
    almacen_ac: TBDEdit;
    btnAlmacen: TBGridButton;
    lblAlmacen: TnbStaticText;
    lblCodigo3: TnbLabel;
    asignacion_ac: TBDEdit;
    lblCodigo4: TnbLabel;
    cajas_al: TBDEdit;
    lblCodigo5: TnbLabel;
    precio_caja_al: TBDEdit;
    lblCodigo6: TnbLabel;
    producto_ac: TBDEdit;
    btnProducto: TBGridButton;
    lblProducto: TnbStaticText;
    etqProducto: TnbLabel;
    lblImporte: TLabel;
    lblCajasPalet: TLabel;
    lblCodigo7: TnbLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure empresa_acChange(Sender: TObject);
    procedure proveedor_acChange(Sender: TObject);
    procedure btnFechaClick(Sender: TObject);
    procedure btnEmpresaClick(Sender: TObject);
    procedure btnProveedorClick(Sender: TObject);
    procedure almacen_acChange(Sender: TObject);
    procedure btnAlmacenClick(Sender: TObject);
    procedure empresa_acRequiredTime(Sender: TObject; var isTime: Boolean);
    procedure btnFechaHastaClick(Sender: TObject);
    procedure btnProductoClick(Sender: TObject);
    procedure btnProductoLClick(Sender: TObject);
    procedure btnCalibreClick(Sender: TObject);
    procedure tblLinAfterInsert(DataSet: TDataSet);
    procedure producto_acChange(Sender: TObject);
    procedure producto_alChange(Sender: TObject);
    procedure palets_alChange(Sender: TObject);
    procedure cajas_alChange(Sender: TObject);
    procedure precio_caja_alChange(Sender: TObject);
  private
    { Private declarations }
    Lista, ListaDetalle: TList;
    Objeto: TObject;
    bActualizar: Boolean;
    sAsignacion: string;

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

    procedure RecalcularValores ( const ATipo, ACajas: Integer;  const APrecio, APalets: Real  );

  public
    { Public declarations }
    procedure Borrar; override;

    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    //Listado
    procedure Previsualizar; override;
 end;



implementation


uses CVariables, CGestionPrincipal, UDMBaseDatos, CAuxiliarDB, bMath, bTimeUtils,
  Principal, UDMAuxDB, Variants, bSQLUtils, bTextUtils, Dpreview,
  UAsignacionFrutaQR, CReportes, CMaestro, UDMConfig,   UFProveedores;

{$R *.DFM}


procedure TFMAsignacionFruta.AbrirTablas;
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

  tblLin.Open;

  //Estado inicial
  Registro := 1;
  Registros := 0;
  RegistrosInsertados := 0;
end;

procedure TFMAsignacionFruta.CerrarTablas;
begin
  CloseAuxQuerys;
end;

procedure TFMAsignacionFruta.FormCreate(Sender: TObject);
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
  Select := 'select * From frf_asignacion_c ';
  where := ' Where contador_ac = -1';
  Order := ' Order by contador_ac DESC';

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
  FocoAltas := empresa_ac;
  FocoModificar := proveedor_ac;
  FocoLocalizar := empresa_ac;
  FocoDetalle := calibre_al;
  Calendario.Date := date;

  (*TODO*)
  //Constantes para las rejillas de l combo
  empresa_ac.Tag:= kEmpresa;
  proveedor_ac.Tag:= kProveedor;
  almacen_ac.Tag:= kProveedorAlmacen;
  producto_ac.Tag:= kProducto;
  fecha_asignacion_ac.Tag:= kCalendar;
  edtFechaHasta.Tag:= kCalendar;

  producto_al.Tag:= kProveedorAlmacen;
  calibre_al.Tag:= kCalibre;

  empresa_ac.Change;
  bActualizar:= True;
end;

procedure TFMAsignacionFruta.PreparaAlta;
begin
  //contador_ac.Enabled:= False;
end;

procedure TFMAsignacionFruta.AntesDeVisualizar;
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

  status_ac.Enabled:= False;
  cbbstatus_ac.Enabled:= False;

  lblFechaHasta.Visible:= False;
  edtFechaHasta.Visible:= False;
  btnFechaHasta.Visible:= False;
end;

procedure TFMAsignacionFruta.AntesDeInsertar;
begin
  empresa_ac.Text:= '506';
  fecha_asignacion_ac.Text:= DateToStr( date );
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select nvl(max(contador_ac),0) contador');
    SQL.Add('from frf_asignacion_c');
    Open;
    contador_ac.Text:= IntToStr( FieldByname('contador').ASInteger + 1 );
    Close;
  end;
  sAsignacion:= '';
end;

procedure TFMAsignacionFruta.AntesDeModificar;
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
  sAsignacion:= asignacion_ac.Text;
end;

procedure TFMAsignacionFruta.AntesDeLocalizar;
begin
  status_ac.Enabled:= True;
  cbbstatus_ac.Enabled:= True;

  lblFechaHasta.Visible:= True;
  edtFechaHasta.Visible:= True;
  btnFechaHasta.Visible:= True;
  edtFechaHasta.Text:= '';
end;

procedure TFMAsignacionFruta.FormActivate(Sender: TObject);
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

procedure TFMAsignacionFruta.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMAsignacionFruta.FormKeyDown(Sender: TObject; var Key: Word;
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
      if empresa_ac.Focused then btnEmpresa.Click
      else if proveedor_ac.Focused then btnProveedor.Click
      else if almacen_ac.Focused then btnAlmacen.Click
      else if producto_ac.Focused then btnProducto.Click
      else if fecha_asignacion_ac.Focused then btnFecha.Click
      else if edtFechaHasta.Focused then btnFechaHasta.Click
      else if producto_al.Focused then btnProductoL.Click
      else if calibre_al.Focused then btnCalibre.Click;
    end;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

procedure TFMAsignacionFruta.Filtro;
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
        if ( Trim(Text) <> '' ) and ( name <> 'fecha_asignacion_ac' ) and ( name <> 'edtFechaHasta' ) then
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

  if fecha_asignacion_ac.Text <> '' then
  begin
    if flag then where := where + ' and ';
    if edtFechaHasta.Text <> '' then
    begin
      where := where + ' fecha_asignacion_ac between ' + SQLDate(fecha_asignacion_ac.Text) + ' and ' + SQLDate(edtFechaHasta.Text);
    end
    else
    begin
      where := where + ' fecha_asignacion_ac = ' + SQLDate(fecha_asignacion_ac.Text);
    end;
    flag:= TRue;
  end;

  if flag then where := ' WHERE ' + where;
end;

procedure TFMAsignacionFruta.AnyadirRegistro;
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


procedure TFMAsignacionFruta.ValidarEntradaMaestro;
var
  dFecha: TdateTime;
begin
  //empresa valida
  if lblEmpresa.Caption = '' then
  begin
    raise Exception.Create('Falta el código de la empresa o es icorrecto.');
  end;

  if lblProveedor.Caption = '' then
  begin
    raise Exception.Create('Falta el código del proveedor o es icorrecto.');
  end;

  if lblAlmacen.Caption = '' then
  begin
    raise Exception.Create('Falta el código del almacén o es icorrecto.');
  end;

  if lblProducto.Caption = '' then
  begin
    raise Exception.Create('Falta el código del producto o es icorrecto.');
  end;

  if not TryStrToDate( fecha_asignacion_ac.Text, dFecha ) then
  begin
    raise Exception.Create('Falta la fecha de asiganción o es icorrecta.');
  end;

  if Trim(asignacion_ac.Text) = '' then
  begin
    raise Exception.Create('Falta la referencia de la asiganción.');
  end;

  //Comprobar que no este duplicada la signacion
  if sAsignacion <> asignacion_ac.Text then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select * ');
    SQL.Add('from frf_asignacion_c');
    SQL.Add('where asignacion_ac = :asignacion ');
    ParamByName('asignacion').AsString:= asignacion_ac.Text;
    Open;
    try
      if not IsEmpty then
      begin
        raise Exception.Create('La referencia de la asiganción esta duplicada.');
      end;
    finally
      Close;
    end;
  end;

  if status_ac.Text = '' then
    status_ac.Text:= '0';
end;

procedure TFMAsignacionFruta.ValidarEntradaDetalle;
var
  iAux: Integer;
  rAux: Double;
begin
  //Control no pner menos kilos que los que hay
  if Trim( calibre_al.Text ) = '' then
  begin
    raise Exception.Create('Falta el calibre.');
  end;
  if not TryStrToFloat( palets_al.Text, rAux ) then
  begin
    raise Exception.Create('Falta el número de palets o dato icorrecto.');
  end;
  if rAux <=0 then
  begin
    raise Exception.Create('El número de palets debe ser superior a 0.');
  end;

  if not TryStrToInt( cajas_al.Text, iAux ) then
  begin
    raise Exception.Create('Falta el número de cajas o dato icorrecto.');
  end;
  if iAux <=0 then
  begin
    raise Exception.Create('El número de cajas debe ser superior a 0.');
  end;

  if not TryStrToFloat( cajas_al.Text, rAux ) then
  begin
    raise Exception.Create('Falta el precio por caja o dato icorrecto.');
  end;
end;

procedure TFMAsignacionFruta.Previsualizar;
var
  QRAsignacionFruta: TQRAsignacionFruta;
begin
  QRAsignacionFruta := TQRAsignacionFruta.Create(self);
  QRAsignacionFruta.ReportTitle := self.Caption;
  try
    Preview(QRAsignacionFruta);
  except
    FreeAndNil(QRAsignacionFruta);
    raise;
  end;
end;


procedure TFMAsignacionFruta.VerDetalle;
begin
  PanelDetalle.visible := False;
end;

procedure TFMAsignacionFruta.EditarDetalle;
begin
  FocoDetalle := calibre_al;
  PanelDetalle.visible := True;
end;


procedure TFMAsignacionFruta.Borrar;
begin
  //Que no tenga instruciones de carga y entregas asociada
  inherited Borrar;
end;


procedure TFMAsignacionFruta.empresa_acChange(Sender: TObject);
begin
  lblEmpresa.Caption := desEmpresa(empresa_ac.Text);
  proveedor_ac.Change;
  producto_ac.Change;
  producto_al.Change;
  almacen_ac.Change;
end;

procedure TFMAsignacionFruta.proveedor_acChange(Sender: TObject);
begin
  lblProveedor.Caption := desProveedor(empresa_ac.Text, proveedor_ac.Text);
end;

procedure TFMAsignacionFruta.producto_acChange(Sender: TObject);
begin
  lblProducto.Caption:= desProducto(empresa_ac.Text, producto_ac.Text);
end;

procedure TFMAsignacionFruta.producto_alChange(Sender: TObject);
begin
  lblProductoL.Caption:= desProducto(empresa_ac.Text, producto_al.Text);
  if producto_al.Text = 'K' then
    lblCajasPalet.Caption:= ' X 100'
  else
  if producto_al.Text = 'O' then
    lblCajasPalet.Caption:= ' X 160';
end;

procedure TFMAsignacionFruta.almacen_acChange(Sender: TObject);
begin
  lblAlmacen.Caption := desProveedorAlmacen(empresa_ac.Text, proveedor_ac.Text, almacen_ac.Text);
end;

procedure TFMAsignacionFruta.btnFechaClick(Sender: TObject);
begin
  if fecha_asignacion_ac.Focused then
    DespliegaCalendario( btnFecha );
end;

procedure TFMAsignacionFruta.btnFechaHastaClick(Sender: TObject);
begin
  if edtFechaHasta.Focused then
    DespliegaCalendario( btnFechaHasta );
end;

procedure TFMAsignacionFruta.btnEmpresaClick(Sender: TObject);
begin
  if empresa_ac.Focused then
    DespliegaRejilla( btnEmpresa);
end;

procedure TFMAsignacionFruta.btnProductoClick(Sender: TObject);
begin
  if producto_ac.Focused then
    DespliegaRejilla( btnProducto, [empresa_ac.Text] );
end;

procedure TFMAsignacionFruta.btnProveedorClick(Sender: TObject);
var
  sResult: string;
begin
  if proveedor_ac.Focused then
  if SeleccionaProveedor( self, proveedor_ac, empresa_ac.Text, sResult ) then
  begin
    proveedor_ac.Text:= sResult;
  end;
  //DespliegaRejilla( btnproveedor_rpc, [empresa_rpc.Text] );
end;

procedure TFMAsignacionFruta.btnAlmacenClick(Sender: TObject);
begin
  if almacen_ac.Focused then
    DespliegaRejilla( btnAlmacen, [empresa_ac.Text, proveedor_ac.Text] );
end;

procedure TFMAsignacionFruta.btnProductoLClick(Sender: TObject);
begin
  if producto_al.Focused then
    DespliegaRejilla( btnProductoL, [empresa_ac.Text] );
end;

procedure TFMAsignacionFruta.btnCalibreClick(Sender: TObject);
begin
  if calibre_al.Focused then
    DespliegaRejilla( btnCalibre, [empresa_ac.Text, producto_al.Text] );
end;


procedure TFMAsignacionFruta.empresa_acRequiredTime(Sender: TObject;
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

(*

DROP TABLE frf_asignacion_c;
CREATE TABLE frf_asignacion_c (
  contador_ac INTEGER NOT NULL,
  empresa_ac CHAR(3) NOT NULL,

  proveedor_ac CHAR(3) NOT NULL,
  almacen_ac INTEGER NOT NULL,
  asignacion_ac CHAR(12) NOT NULL,
  fecha_asignacion_ac DATE NOT NULL,

  producto_ac CHAR(1) NOT NULL,
  observaciones_ac CHAR(255),
  status_ac INTEGER DEFAULT 0 NOT NULL
)

ALTER TABLE frf_asignacion_c ADD CONSTRAINT
 PRIMARY KEY (contador_ac)
 CONSTRAINT pasignacion_c

ALTER TABLE frf_asignacion_c ADD CONSTRAINT
 FOREIGN KEY (empresa_ac,proveedor_ac,almacen_ac)
 REFERENCES frf_proveedores_almacen
 CONSTRAINT aproveedores_almacen_ac


DROP TABLE frf_asignacion_l;
CREATE TABLE frf_asignacion_l (
  contador_al INTEGER NOT NULL,
  linea_al INTEGER NOT NULL,
  empresa_al CHAR(3) NOT NULL,
  producto_al CHAR(1) NOT NULL,
  calibre_al CHAR(6)NOT NULL,
  precio_caja_al DECIMAL(5,2),
  palets_al DECIMAL(6,2),
  cajas_al INTEGER NOT NULL
)

ALTER TABLE frf_asignacion_l ADD CONSTRAINT
 PRIMARY KEY (contador_al, linea_al)
 CONSTRAINT pasignacion_l

ALTER TABLE frf_asignacion_l ADD CONSTRAINT
 FOREIGN KEY (contador_al)
 REFERENCES frf_asignacion_c
 CONSTRAINT aasignacion_al

ALTER TABLE frf_asignacion_l ADD CONSTRAINT
 FOREIGN KEY (empresa_al,producto_al,calibre_al)
 REFERENCES frf_calibres
 CONSTRAINT acalibres_al
*)

procedure TFMAsignacionFruta.tblLinAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('contador_al').AsString:= contador_ac.Text;
  DataSet.FieldByName('empresa_al').AsString:= empresa_ac.Text;
  DataSet.FieldByName('producto_al').AsString:= producto_ac.Text;

  //Contador
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select nvl(max(linea_al),0) linea');
    SQL.Add('from frf_asignacion_l');
    SQL.Add('where contador_al = :contador ');
    ParamByName('contador').AsInteger:= qryCab.FieldByName('contador_ac').AsInteger;
    Open;
    tblLin.FieldByName('linea_al').AsInteger:= FieldByname('linea').ASInteger + 1;
    Close;
  end;
end;

procedure TFMAsignacionFruta.RecalcularValores ( const ATipo, ACajas: Integer;  const APrecio, APalets: Real  );
var
  iCajasPalet: Integer;
  rImporte: Real;
begin
  rImporte:= APrecio * ACajas;
  if APalets <> 0 then
  begin
    iCajasPalet:= Trunc( ACajas / APalets );
  end
  else
  begin
    iCajasPalet:= 0;
  end;
  lblCajasPalet.Caption:= FormatFloat( '#,##0', iCajasPalet );
  lblImporte.Caption:= FormatFloat( '#,##0.00', rImporte );

  if ( DSDetalle.DataSet.State = dsInsert ) or ( DSDetalle.DataSet.State = dsEdit ) then
  begin
    if ATipo <> 0 then
      palets_al.Text:= FormatFloat( '#0.00', APalets );
    if ATipo <> 1 then
      cajas_al.Text:= FormatFloat( '#0', ACajas );
    if ATipo <> 2 then
      precio_caja_al.Text:= FormatFloat( '#0.00', APrecio );
  end;

  bActualizar:= True;
end;

procedure TFMAsignacionFruta.palets_alChange(Sender: TObject);
var
  rPalets, rPrecio: Double;
  iCajas: Integer;
begin
  if not bActualizar then
    Exit;
  bActualizar:= False;

  rPalets:= StrToFloatDef( palets_al.Text, 0 );
  if producto_al.Text = 'K' then
    iCajas:= Trunc(rPalets * 100)
  else
  if producto_al.Text = 'O' then
    iCajas:= Trunc(rPalets * 160)
  else
    iCajas:= StrToIntDef( cajas_al.Text, 0 );
  rPrecio:= StrToFloatDef( precio_caja_al.Text, 0 );

  RecalcularValores ( 0, iCajas, rPrecio, rPalets );
end;

procedure TFMAsignacionFruta.cajas_alChange(Sender: TObject);
var
  rPalets, rPrecio: Double;
  iCajas: Integer;
begin
  if not bActualizar then
    Exit;
  bActualizar:= False;

  iCajas:= StrToIntDef( cajas_al.Text, 0 );
  if producto_al.Text = 'K' then
    rPalets:= bRoundTo(iCajas / 100, 2)
  else
  if producto_al.Text = 'O' then
    rPalets:= bRoundTo(iCajas / 160, 2)
  else
    rPalets:= StrToFloatDef( palets_al.Text, 0 );

  rPrecio:= StrToFloatDef( precio_caja_al.Text, 0 );

  RecalcularValores ( 1, iCajas, rPrecio, rPalets );
end;

procedure TFMAsignacionFruta.precio_caja_alChange(Sender: TObject);
var
  rPalets, rPrecio: Double;
  iCajas: Integer;
begin
  if not bActualizar then
    Exit;
  bActualizar:= False;

  iCajas:= StrToIntDef( cajas_al.Text, 0 );
  rPalets:= StrToFloatDef( palets_al.Text, 0 );
  rPrecio:= StrToFloatDef( precio_caja_al.Text, 0 );

  RecalcularValores ( 2, iCajas, rPrecio, rPalets );
end;

end.

