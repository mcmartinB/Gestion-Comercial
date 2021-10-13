unit MFichFormasPago;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BEdit, BDEdit,
  dbtables, DError, ComCtrls;

type
  TFMFichFormasPago = class(TMaestroDetalle)
    PMaestro: TPanel;
    DSFormasPagoCab: TDataSource;
    Label10: TLabel;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    codigo_fpc: TBDEdit;
    descripcion_fpc: TBDEdit;
    QFormasPagoCab: TQuery;
    QFormasPagoDet: TQuery;
    DSFormasPagoDet: TDataSource;
    RejillaFlotante: TBGrid;
    Tipo: TLabel;
    lbl2: TLabel;
    codigo_adonix_fpc: TBDEdit;
    pnlPFormasPago: TPanel;
    Label1: TLabel;
    RFormasPago: TDBGrid;
    texto_fpd: TDBMemo;
    dlbllinea_fpd: TDBText;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure QFormasPagoCabAfterOpen(DataSet: TDataSet);
    procedure QFormasPagoCabBeforeClose(DataSet: TDataSet);
    procedure texto_fpdEnter(Sender: TObject);
    procedure texto_fpdExit(Sender: TObject);
  private
    { Private declarations }
    ListaComponentes, ListaDetalle: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure ValidarEntradaDetalle;
    procedure AntesDeBorrarMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    procedure VerDetalle;
    procedure EditarDetalle;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
     CAuxiliarDB, Principal, DPreview, UDMAuxDB, bSQLUtils,
     CMaestro, UDMConfig;

{$R *.DFM}

procedure TFMFichFormasPago.AbrirTablas;
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
  Registros := DataSetMaestro.RecordCount;
  if registros > 0 then
    Registro := 1
  else
    Registro := 0;
  RegistrosInsertados := 0;
end;

procedure TFMFichFormasPago.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

procedure TFMFichFormasPago.FormCreate(Sender: TObject);
begin
  Top := 1;

  LineasObligadas:= fALSE;
  ListadoObligado:= False;
  MultipleAltas:= false;

  //Variables globales
  M:=Self;
  MD:=Self;
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF :=nil;

  DataSourceDetalle:=DSFormasPagoDet;
  RejillaVisualizacion := RFormasPago;
  PanelDetalle := pnlPFormasPago;

  //Panel
  PanelMaestro := PMaestro;

  //Fuente de datos
  DataSetMaestro:=QFormasPagoCab;

  Select := ' SELECT * FROM fch_formas_pago_c ';
  where := ' WHERE codigo_fpc=' + QuotedStr('###');
  Order := ' ORDER BY codigo_fpc ';
     //Para reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := kNull;
     //Abrir tablas/Querys

  with QFormasPagoDet.SQL do
  begin
    Clear;
    Add('select * from fch_formas_pago_d ');
    Add('where codigo_fpd = :codigo_fpc ');
    Add('order by codigo_fpd, linea_fpd ');
  end;

  try
    AbrirTablas;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      Close;
      Exit;
    end;
  end;

     //Lista de componentes
  ListaComponentes := TList.Create;
  PMaestro.GetTabOrderList(ListaComponentes);
  ListaDetalle := TList.Create;
  ListaDetalle.Clear;
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
  OnBeforeMasterDelete := AntesDeBorrarMaestro;
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnValidateDetailConstrains := ValidarEntradaDetalle;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;

  //Preparar panel de detalle
  OnViewDetail:=VerDetalle;
  OnEditDetail:=EditarDetalle;

     //Focos
  {+}FocoAltas := codigo_fpc;
  {+}FocoModificar := descripcion_fpc;
  {+}FocoLocalizar := codigo_fpc;
end;

procedure TFMFichFormasPago.FormActivate(Sender: TObject);
begin
  if not DataSetMaestro.Active then Exit;
     //Variables globales
  M := Self;
  MD := Self;
  gRF := RejillaFlotante;
  gCF :=nil;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

  //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestroDetalle then
  begin
    FormType := tfMaestroDetalle;
    BHFormulario;
  end;
  BHGrupoDesplazamientoMaestro(PCMaestro);
  BHGrupoDesplazamientoDetalle(PCDetalle);
end;

procedure TFMFichFormasPago.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF :=nil;
end;


procedure TFMFichFormasPago.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListaComponentes.Free;
  ListaDetalle.Free;
     {MODIFICAR}
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
     // Cerrar tabla
  CerrarTablas;

     //Restauramos barra de herramientas
  if Fprincipal.MDIChildCount = 1 then
  begin
    if FormType <> tfDirector then
    begin
      FormType := tfDirector;
      BHFormulario;
    end;
  end;
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMFichFormasPago.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    //Si la rejilla esta desplegada no hacemos nada
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
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

{+}//Sustituir por funcion generica

procedure TFMFichFormasPago.Filtro;
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

procedure TFMFichFormasPago.AnyadirRegistro;
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
end;

{+}//Sustituir por funcion generica

procedure TFMFichFormasPago.ValidarEntradaMaestro;
var i: Integer;
begin
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
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
end;

function NuevaLinea( const ACodigo: string ): string;
var
  sAux: string;
  iAux: Integer;
begin
  Result:= '00';
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select max(linea_fpd) max_linea ');
    SQL.Add(' from fch_formas_pago_d ');
    SQL.Add(' where codigo_fpd = :codigo ');
    ParamByName('codigo').AsString:= ACodigo;
    Open;
    try
      if not IsEmpty then
      begin
        sAux:= FieldByName('max_linea').AsString;
        if TryStrToInt( sAux, iAux ) then
        begin
          Inc( iAux );
          if iAux < 10 then
          begin
            Result:= '0' + IntToStr( iAux );
          end
          else
          if iAux < 100 then
          begin
            Result:= IntToStr( iAux );
          end
          else
          begin
            raise Exception.Create('No pude haber mas de 100 cuentas por banco.');
          end;
        end;
      end;
    finally
      Close;
    end;
  end;
end;

procedure TFMFichFormasPago.ValidarEntradaDetalle;
begin
  //
  QFormasPagoDet.FieldByName('codigo_fpd').AsString:=
    QFormasPagoCab.FieldByName('codigo_fpc').AsString;
  QFormasPagoDet.FieldByName('linea_fpd').AsString:=
    NuevaLinea( QFormasPagoCab.FieldByName('codigo_fpc').AsString );
end;

procedure TFMFichFormasPago.Previsualizar;
//var
//  QRLProveedoresEx: TQRLProveedoresEx;
//  bAlmacenes, bProductos: boolean;
begin
(*
  if LDProveedores.VisualizarDetalle( self, bAlmacenes, bProductos ) then
  begin
    QRLProveedoresEx := TQRLProveedoresEx.Create(Application);
    try
      QRLProveedoresEx.MontarListado( Where, bAlmacenes, bProductos );
      PonLogoGrupoBonnysa(QRLProveedoresEx);
      Preview(QRLProveedoresEx);
    except
      FreeAndNil(QRLProveedoresEx);
    end;
  end;
*)
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//*****************************************************************************

procedure TFMFichFormasPago.ARejillaFlotanteExecute(Sender: TObject);
begin
(*
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
  end;
*)
end;

procedure TFMFichFormasPago.AntesDeInsertar;
begin
  //Nada
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMFichFormasPago.AntesDeModificar;
var i: Integer;
begin
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;
end;


//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMFichFormasPago.AntesDeVisualizar;
var i: Integer;
begin
    //Restauramos estado
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          if Enabled = false then Enabled := true;
  end;
end;

procedure TFMFichFormasPago.AntesDeBorrarMaestro;
begin
  if not QFormasPagoDet.IsEmpty then
  begin
    raise Exception.Create('No se puede borrar la forma de pago, primero borre el detalle.');
  end;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMFichFormasPago.RequiredTime(Sender: TObject; var isTime: Boolean);
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

procedure TFMFichFormasPago.QFormasPagoCabAfterOpen(DataSet: TDataSet);
begin
  QFormasPagoDet.Open;
end;

procedure TFMFichFormasPago.QFormasPagoCabBeforeClose(DataSet: TDataSet);
begin
  QFormasPagoDet.Close;
end;

procedure TFMFichFormasPago.VerDetalle;
begin
  PanelDetalle.Enabled:= false;
end;

procedure TFMFichFormasPago.EditarDetalle;
begin
  PanelDetalle.Enabled:= TRUE;
  begin
    FocoDetalle:=texto_fpd;
  end
end;

procedure TFMFichFormasPago.texto_fpdEnter(Sender: TObject);
begin
  texto_fpd.Color:= clMoneyGreen;
end;

procedure TFMFichFormasPago.texto_fpdExit(Sender: TObject);
begin
  texto_fpd.Color:= clWhite;
end;

end.
