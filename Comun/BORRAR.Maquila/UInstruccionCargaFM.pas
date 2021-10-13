unit UInstruccionCargaFM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid,
  BDEdit, BEdit, dbTables, DError, BCalendarButton, ComCtrls, BCalendario,
  nbLabels;

type
  TFMInstruccionCarga = class(TMaestroDetalle)
    DSMaestro: TDataSource;
    PMaestro: TPanel;
    RejillaFlotante: TBGrid;
    Calendario: TBCalendario;
    observaciones_ic: TDBMemo;
    nbLabel24: TnbLabel;
    contador_ic: TBDEdit;
    lObservacion: TnbLabel;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    lblProveedor: TnbStaticText;
    lblEmpresa: TnbStaticText;
    btnFecha: TBCalendarButton;
    btnEmpresa: TBGridButton;
    btnProveedor: TBGridButton;
    empresa_ic: TBDEdit;
    proveedor_ic: TBDEdit;
    nbLabel3: TnbLabel;
    nbLabel20: TnbLabel;
    fecha_carga_ic: TBDEdit;
    DSDetalle: TDataSource;
    PDetalle: TPanel;
    PDetalle1: TPanel;
    nbLabel8: TnbLabel;
    btnProductoL: TBGridButton;
    nbLabel9: TnbLabel;
    nbLabel14: TnbLabel;
    producto_il: TBDEdit;
    linea_il: TBDEdit;
    palets_il: TBDEdit;
    RVisualizacion1: TDBGrid;
    DSGastosEntregas: TDataSource;
    status_ic: TBDEdit;
    cbbstatus_ic: TComboBox;
    edtFechaHasta: TBEdit;
    lblFechaHasta: TnbLabel;
    btnFechaHasta: TBCalendarButton;
    lblCodigo1: TnbLabel;
    calibre_il: TBDEdit;
    btnCalibre: TBGridButton;
    qryCab: TQuery;
    tblLin: TTable;
    lblProductoL: TnbStaticText;
    lblCodigo2: TnbLabel;
    almacen_ic: TBDEdit;
    btnAlmacen: TBGridButton;
    lblAlmacen: TnbStaticText;
    lblCodigo3: TnbLabel;
    matricula_ic: TBDEdit;
    lblCodigo4: TnbLabel;
    cajas_il: TBDEdit;
    lblCodigo5: TnbLabel;
    precio_caja_il: TBDEdit;
    lblCodigo6: TnbLabel;
    transporte_ic: TBDEdit;
    btnTransporte: TBGridButton;
    lblTransporte: TnbStaticText;
    etqProducto: TnbLabel;
    lblImporte: TLabel;
    lblCajasPalet: TLabel;
    lblCodigo7: TnbLabel;
    nbLabel4: TnbLabel;
    asignacion_il: TBDEdit;
    btnAsignacion: TBGridButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure empresa_icChange(Sender: TObject);
    procedure proveedor_icChange(Sender: TObject);
    procedure btnFechaClick(Sender: TObject);
    procedure btnEmpresaClick(Sender: TObject);
    procedure btnProveedorClick(Sender: TObject);
    procedure almacen_icChange(Sender: TObject);
    procedure btnAlmacenClick(Sender: TObject);
    procedure empresa_icRequiredTime(Sender: TObject; var isTime: Boolean);
    procedure btnFechaHastaClick(Sender: TObject);
    procedure btnTransporteClick(Sender: TObject);
    procedure btnProductoLClick(Sender: TObject);
    procedure btnCalibreClick(Sender: TObject);
    procedure tblLinAfterInsert(DataSet: TDataSet);
    procedure transporte_icChange(Sender: TObject);
    procedure producto_ilChange(Sender: TObject);
    procedure palets_ilChange(Sender: TObject);
    procedure cajas_ilChange(Sender: TObject);
    procedure precio_caja_ilChange(Sender: TObject);
    procedure btnAsignacionClick(Sender: TObject);
  private
    { Private declarations }
    Lista, ListaDetalle: TList;
    Objeto: TObject;
    bActualizar: Boolean;

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
  UInstruccionCargaQR, CReportes, CMaestro, UDMConfig,   UFProveedores,
  UFTransportistas;

{$R *.DFM}


procedure TFMInstruccionCarga.AbrirTablas;
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

procedure TFMInstruccionCarga.CerrarTablas;
begin
  CloseAuxQuerys;
end;

procedure TFMInstruccionCarga.FormCreate(Sender: TObject);
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
  Select := 'select * From frf_inscarga_c ';
  where := ' Where contador_ic = -1';
  Order := ' Order by contador_ic DESC';

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
  FocoAltas := empresa_ic;
  FocoModificar := proveedor_ic;
  FocoLocalizar := empresa_ic;
  FocoDetalle := asignacion_il;
  Calendario.Date := date;

  (*TODO*)
  //Constantes para las rejillas de l combo
  empresa_ic.Tag:= kEmpresa;
  proveedor_ic.Tag:= kProveedor;
  almacen_ic.Tag:= kProveedorAlmacen;
  transporte_ic.Tag:= kTransportista;
  fecha_carga_ic.Tag:= kCalendar;
  edtFechaHasta.Tag:= kCalendar;

  producto_il.Tag:= kProveedorAlmacen;
  calibre_il.Tag:= kCalibre;

  empresa_ic.Change;
  bActualizar:= True;
end;

procedure TFMInstruccionCarga.PreparaAlta;
begin
  //contador_ac.Enabled:= False;
end;

procedure TFMInstruccionCarga.AntesDeVisualizar;
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

  status_ic.Enabled:= False;
  cbbstatus_ic.Enabled:= False;

  lblFechaHasta.Visible:= False;
  edtFechaHasta.Visible:= False;
  btnFechaHasta.Visible:= False;
end;

procedure TFMInstruccionCarga.AntesDeInsertar;
begin
  empresa_ic.Text:= '506';
  fecha_carga_ic.Text:= DateToStr( date );
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select nvl(max(contador_ic),0) contador');
    SQL.Add('from frf_inscarga_c');
    Open;
    contador_ic.Text:= IntToStr( FieldByname('contador').ASInteger + 1 );
    Close;
  end;
end;

procedure TFMInstruccionCarga.AntesDeModificar;
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

procedure TFMInstruccionCarga.AntesDeLocalizar;
begin
  status_ic.Enabled:= True;
  cbbstatus_ic.Enabled:= True;

  lblFechaHasta.Visible:= True;
  edtFechaHasta.Visible:= True;
  btnFechaHasta.Visible:= True;
  edtFechaHasta.Text:= '';
end;

procedure TFMInstruccionCarga.FormActivate(Sender: TObject);
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

procedure TFMInstruccionCarga.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMInstruccionCarga.FormKeyDown(Sender: TObject; var Key: Word;
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
      if empresa_ic.Focused then btnEmpresa.Click
      else if proveedor_ic.Focused then btnProveedor.Click
      else if almacen_ic.Focused then btnAlmacen.Click
      else if transporte_ic.Focused then btnTransporte.Click
      else if fecha_carga_ic.Focused then btnFecha.Click
      else if edtFechaHasta.Focused then btnFechaHasta.Click
      else if producto_il.Focused then btnProductoL.Click
      else if calibre_il.Focused then btnCalibre.Click;
    end;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

procedure TFMInstruccionCarga.Filtro;
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
        if ( Trim(Text) <> '' ) and ( name <> 'fecha_carga_ic' ) and ( name <> 'edtFechaHasta' ) then
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

  if fecha_carga_ic.Text <> '' then
  begin
    if flag then where := where + ' and ';
    if edtFechaHasta.Text <> '' then
    begin
      where := where + ' fecha_carga_ic between ' + SQLDate(fecha_carga_ic.Text) + ' and ' + SQLDate(edtFechaHasta.Text);
    end
    else
    begin
      where := where + ' fecha_carga_ic = ' + SQLDate(fecha_carga_ic.Text);
    end;
    flag:= TRue;
  end;

  if flag then where := ' WHERE ' + where;
end;

procedure TFMInstruccionCarga.AnyadirRegistro;
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


procedure TFMInstruccionCarga.ValidarEntradaMaestro;
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

  if lblTransporte.Caption = '' then
  begin
    raise Exception.Create('Falta el código del transportista o es icorrecto.');
  end;

  if not TryStrToDate( fecha_carga_ic.Text, dFecha ) then
  begin
    raise Exception.Create('Falta la fecha de carga o es icorrecta.');
  end;

  (*
  if Trim(matricula_ic.Text) = '' then
  begin
    raise Exception.Create('Falta la matricula de la asiganción.');
  end;
  *)

  if status_ic.Text = '' then
    status_ic.Text:= '0';
end;

procedure TFMInstruccionCarga.ValidarEntradaDetalle;
var
  iAux: Integer;
  rAux: Double;
begin
  //Comprobar la asignacion

  //Control no pner menos kilos que los que hay
  if Trim( calibre_il.Text ) = '' then
  begin
    raise Exception.Create('Falta el calibre.');
  end;
  if not TryStrToFloat( palets_il.Text, rAux ) then
  begin
    raise Exception.Create('Falta el número de palets o dato icorrecto.');
  end;
  if rAux <=0 then
  begin
    raise Exception.Create('El número de palets debe ser superior a 0.');
  end;

  if not TryStrToInt( cajas_il.Text, iAux ) then
  begin
    raise Exception.Create('Falta el número de cajas o dato icorrecto.');
  end;
  if iAux <=0 then
  begin
    raise Exception.Create('El número de cajas debe ser superior a 0.');
  end;

  if not TryStrToFloat( cajas_il.Text, rAux ) then
  begin
    raise Exception.Create('Falta el precio por caja o dato icorrecto.');
  end;
end;

procedure TFMInstruccionCarga.Previsualizar;
var
  QRInstruccionCarga: TQRInstruccionCarga;
begin
  QRInstruccionCarga := TQRInstruccionCarga.Create(self);
  QRInstruccionCarga.ReportTitle := self.Caption;
  try
    Preview(QRInstruccionCarga);
  except
    FreeAndNil(QRInstruccionCarga);
    raise;
  end;
end;


procedure TFMInstruccionCarga.VerDetalle;
begin
  PanelDetalle.visible := False;
end;

procedure TFMInstruccionCarga.EditarDetalle;
begin
  FocoDetalle := calibre_il;
  PanelDetalle.visible := True;
end;


procedure TFMInstruccionCarga.Borrar;
begin
  //Que no tenga instruciones de carga y entregas asociada
  inherited Borrar;
end;


procedure TFMInstruccionCarga.empresa_icChange(Sender: TObject);
begin
  lblEmpresa.Caption := desEmpresa(empresa_ic.Text);
  proveedor_ic.Change;
  almacen_ic.Change;
  transporte_ic.Change;
  producto_il.Change;
end;

procedure TFMInstruccionCarga.proveedor_icChange(Sender: TObject);
begin
  lblProveedor.Caption := desProveedor(empresa_ic.Text, proveedor_ic.Text);
end;

procedure TFMInstruccionCarga.transporte_icChange(Sender: TObject);
begin
  lblTransporte.Caption:= desTransporte(empresa_ic.Text, transporte_ic.Text);
end;

procedure TFMInstruccionCarga.producto_ilChange(Sender: TObject);
begin
  lblProductoL.Caption:= desProducto(empresa_ic.Text, producto_il.Text);
  if producto_il.Text = 'K' then
    lblCajasPalet.Caption:= ' X 100'
  else
  if producto_il.Text = 'O' then
    lblCajasPalet.Caption:= ' X 160';
end;

procedure TFMInstruccionCarga.almacen_icChange(Sender: TObject);
begin
  lblAlmacen.Caption := desProveedorAlmacen(empresa_ic.Text, proveedor_ic.Text, almacen_ic.Text);
end;

procedure TFMInstruccionCarga.btnFechaClick(Sender: TObject);
begin
  if fecha_carga_ic.Focused then
    DespliegaCalendario( btnFecha );
end;

procedure TFMInstruccionCarga.btnFechaHastaClick(Sender: TObject);
begin
  if edtFechaHasta.Focused then
    DespliegaCalendario( btnFechaHasta );
end;

procedure TFMInstruccionCarga.btnEmpresaClick(Sender: TObject);
begin
  if empresa_ic.Focused then
    DespliegaRejilla( btnEmpresa);
end;

procedure TFMInstruccionCarga.btnTransporteClick(Sender: TObject);
var
  sAux: string;
begin
  if transporte_ic.Focused then
  begin
    sAux:= transporte_ic.Text;
    if SeleccionaTransportista( self, transporte_ic, empresa_ic.Text, sAux ) then
    begin
      transporte_ic.Text:= sAux;
    end;
  end
end;

procedure TFMInstruccionCarga.btnAsignacionClick(Sender: TObject);
begin
(*
select asignacion_ac asignacion, fecha_asignacion_ac fecha,
       producto_al producto, calibre_al calibre,
       sum(cajas_al) cajas,
       sum(cajas_al)- nvl( ( select sum(cajas_il) From frf_inscarga_l
              where asignacion_il = fecha_asignacion_ac
                and producto_il = producto_al
                and calibre_il = calibre_al ),0 ) stock_cajas,
       sum(palets_al) palets,
       sum(palets_al) - nvl( ( select sum(palets_il) From frf_inscarga_l
              where asignacion_il = fecha_asignacion_ac
                and producto_il = producto_al
                and calibre_il = calibre_al ),0 ) stock_palets
from frf_asignacion_c, frf_asignacion_l
where empresa_ac = '506'
and proveedor_ac = '036'
and almacen_ac = 1
and fecha_asignacion_ac between '16/4/2014' and '16/5/2014'
and contador_ac = contador_al
group by asignacion_ac, fecha_asignacion_ac, producto_al, calibre_al
order by asignacion_ac, calibre_al
*)
end;

procedure TFMInstruccionCarga.btnProveedorClick(Sender: TObject);
var
  sResult: string;
begin
  if proveedor_ic.Focused then
  if SeleccionaProveedor( self, proveedor_ic, empresa_ic.Text, sResult ) then
  begin
    proveedor_ic.Text:= sResult;
  end;
  //DespliegaRejilla( btnproveedor_rpc, [empresa_rpc.Text] );
end;

procedure TFMInstruccionCarga.btnAlmacenClick(Sender: TObject);
begin
  if almacen_ic.Focused then
    DespliegaRejilla( btnAlmacen, [empresa_ic.Text, proveedor_ic.Text] );
end;

procedure TFMInstruccionCarga.btnProductoLClick(Sender: TObject);
begin
  if producto_il.Focused then
    DespliegaRejilla( btnProductoL, [empresa_ic.Text] );
end;

procedure TFMInstruccionCarga.btnCalibreClick(Sender: TObject);
begin
  if calibre_il.Focused then
    DespliegaRejilla( btnCalibre, [empresa_ic.Text, producto_il.Text] );
end;


procedure TFMInstruccionCarga.empresa_icRequiredTime(Sender: TObject;
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
CREATE TABLE informix.frf_inscarga_c (
  contador_ic INTEGER NOT NULL,
  empresa_ic CHAR(3) NOT NULL,
  proveedor_ic CHAR(3) NOT NULL,
  almacen_ic INTEGER NOT NULL,
  fecha_carga_ic DATE NOT NULL,
  transporte_ic SMALLINT,
  matricula_ic CHAR(30),
  observaciones_ic CHAR(255),
  status_ic INTEGER NOT NULL
)

ALTER TABLE informix.frf_inscarga_c ADD CONSTRAINT
 PRIMARY KEY (contador_ic) 
 CONSTRAINT informix.pinscarga_c

ALTER TABLE informix.frf_inscarga_c ADD CONSTRAINT 
 FOREIGN KEY (empresa_ic,proveedor_ic,almacen_ic)
 REFERENCES info.frf_proveedores_almacen
 CONSTRAINT informix.aproveedores_ilmacen_ic


DROP TABLE DROP TABLE frf_inscarga_l;;
CREATE TABLE informix.frf_inscarga_l (
  contador_il INTEGER NOT NULL,
  linea_il INTEGER NOT NULL,
  asignacion_il CHAR(12) NOT NULL,
  empresa_il CHAR(3) NOT NULL,
  producto_il CHAR(1) NOT NULL,
  calibre_il CHAR(6) NOT NULL,
  precio_caja_il DECIMAL(9,5),
  palets_il INTEGER NOT NULL,
  cajas_il INTEGER NOT NULL
)

ALTER TABLE informix.frf_inscarga_l ADD CONSTRAINT
 PRIMARY KEY (contador_il,linea_il)
 CONSTRAINT informix.pinscarga_l

ALTER TABLE informix.frf_inscarga_l ADD CONSTRAINT
 FOREIGN KEY (contador_il)
 REFERENCES informix.frf_inscarga_c
 CONSTRAINT informix.ainscarga_il

ALTER TABLE informix.frf_inscarga_l ADD CONSTRAINT
 FOREIGN KEY (empresa_il,producto_il,calibre_il)
 REFERENCES info.frf_calibres
 CONSTRAINT informix.acalibres_il
*)

procedure TFMInstruccionCarga.tblLinAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('contador_il').AsString:= contador_ic.Text;
  DataSet.FieldByName('empresa_il').AsString:= empresa_ic.Text;

  //Contador
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select nvl(max(linea_il),0) linea');
    SQL.Add('from frf_inscarga_l');
    SQL.Add('where contador_il = :contador ');
    ParamByName('contador').AsInteger:= qryCab.FieldByName('contador_ic').AsInteger;
    Open;
    tblLin.FieldByName('linea_il').AsInteger:= FieldByname('linea').ASInteger + 1;
    Close;
  end;
end;

procedure TFMInstruccionCarga.RecalcularValores ( const ATipo, ACajas: Integer;  const APrecio, APalets: Real  );
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
      palets_il.Text:= FormatFloat( '#0.00', APalets );
    if ATipo <> 1 then
      cajas_il.Text:= FormatFloat( '#0', ACajas );
    if ATipo <> 2 then
      precio_caja_il.Text:= FormatFloat( '#0.00', APrecio );
  end;

  bActualizar:= True;
end;

procedure TFMInstruccionCarga.palets_ilChange(Sender: TObject);
var
  rPalets, rPrecio: Double;
  iCajas: Integer;
begin
  if not bActualizar then
    Exit;
  bActualizar:= False;

  rPalets:= StrToFloatDef( palets_il.Text, 0 );
  if producto_il.Text = 'K' then
    iCajas:= Trunc(rPalets * 100)
  else
  if producto_il.Text = 'O' then
    iCajas:= Trunc(rPalets * 160)
  else
    iCajas:= StrToIntDef( cajas_il.Text, 0 );
  rPrecio:= StrToFloatDef( precio_caja_il.Text, 0 );

  RecalcularValores ( 0, iCajas, rPrecio, rPalets );
end;

procedure TFMInstruccionCarga.cajas_ilChange(Sender: TObject);
var
  rPalets, rPrecio: Double;
  iCajas: Integer;
begin
  if not bActualizar then
    Exit;
  bActualizar:= False;

  iCajas:= StrToIntDef( cajas_il.Text, 0 );
  if producto_il.Text = 'K' then
    rPalets:= bRoundTo(iCajas / 100, 2)
  else
  if producto_il.Text = 'O' then
    rPalets:= bRoundTo(iCajas / 160, 2)
  else
    rPalets:= StrToFloatDef( palets_il.Text, 0 );

  rPrecio:= StrToFloatDef( precio_caja_il.Text, 0 );

  RecalcularValores ( 1, iCajas, rPrecio, rPalets );
end;

procedure TFMInstruccionCarga.precio_caja_ilChange(Sender: TObject);
var
  rPalets, rPrecio: Double;
  iCajas: Integer;
begin
  if not bActualizar then
    Exit;
  bActualizar:= False;

  iCajas:= StrToIntDef( cajas_il.Text, 0 );
  rPalets:= StrToFloatDef( palets_il.Text, 0 );
  rPrecio:= StrToFloatDef( precio_caja_il.Text, 0 );

  RecalcularValores ( 2, iCajas, rPrecio, rPalets );
end;

end.

