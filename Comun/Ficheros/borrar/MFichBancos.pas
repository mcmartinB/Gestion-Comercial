unit MFichBancos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BEdit, BDEdit,
  dbtables, DError, ComCtrls;

type
  TFMFichBancos = class(TMaestroDetalle)
    PMaestro: TPanel;
    DSBancosCab: TDataSource;
    Label10: TLabel;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    empresa_bnc: TBDEdit;
    descripcion_bnc: TBDEdit;
    QBancosCab: TQuery;
    QBancosDet: TQuery;
    DSBancosDet: TDataSource;
    RejillaFlotante: TBGrid;
    Tipo: TLabel;
    lbl2: TLabel;
    codigo_bnc: TBDEdit;
    pnlBancos: TPanel;
    Label1: TLabel;
    RBancos: TDBGrid;
    linea_bnd: TDBText;
    iban_bnd: TBDEdit;
    direccion_bnd: TBDEdit;
    poblacion_bnd: TBDEdit;
    lbl1: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    swift_bnd: TBDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure QBancosCabAfterOpen(DataSet: TDataSet);
    procedure QBancosCabBeforeClose(DataSet: TDataSet);
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

procedure TFMFichBancos.AbrirTablas;
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

procedure TFMFichBancos.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

procedure TFMFichBancos.FormCreate(Sender: TObject);
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

  DataSourceDetalle:=DSBancosDet;
  RejillaVisualizacion := RBancos;
  PanelDetalle := pnlBancos;

  //Panel
  PanelMaestro := PMaestro;

  //Fuente de datos
  DataSetMaestro:=QBancosCab;

  Select := ' SELECT * FROM fch_bancos_c ';
  where := ' WHERE empresa_bnc=' + QuotedStr('###');
  Order := ' ORDER BY empresa_bnc, codigo_bnc ';
     //Para reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := kNull;
     //Abrir tablas/Querys

  with QBancosDet.SQL do
  begin
    Clear;
    Add('select * from fch_bancos_d ');
    Add('where empresa_bnd = :empresa_bnc ');
    Add('  and codigo_bnd = :codigo_bnc ');
    Add('order by empresa_bnd, codigo_bnd, linea_bnd ');
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
  {+}FocoAltas := empresa_bnc;
  {+}FocoModificar := descripcion_bnc;
  {+}FocoLocalizar := empresa_bnc;
end;

procedure TFMFichBancos.FormActivate(Sender: TObject);
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

procedure TFMFichBancos.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF :=nil;
end;


procedure TFMFichBancos.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMFichBancos.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMFichBancos.Filtro;
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

procedure TFMFichBancos.AnyadirRegistro;
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

procedure TFMFichBancos.ValidarEntradaMaestro;
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

function NuevaLinea( const AEmpresa, ACodigo: string ): string;
var
  sAux: string;
  iAux: Integer;
begin
  Result:= '00';
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select max(linea_bnd) max_linea ');
    SQL.Add(' from fch_bancos_d ');
    SQL.Add(' where empresa_bnd = :empresa ');
    SQL.Add(' and codigo_bnd = :codigo ');
    ParamByName('empresa').AsString:= AEmpresa;
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
            raise Exception.Create('No pude haber mas de 100 formas de pago por tipo.');
          end;
        end;
      end;
    finally
      Close;
    end;
  end;
end;

procedure TFMFichBancos.ValidarEntradaDetalle;
begin
  //
  QBancosDet.FieldByName('empresa_bnd').AsString:=
    QBancosCab.FieldByName('empresa_bnc').AsString;
  QBancosDet.FieldByName('codigo_bnd').AsString:=
    QBancosCab.FieldByName('codigo_bnc').AsString;
  QBancosDet.FieldByName('linea_bnd').AsString:=
    NuevaLinea( QBancosCab.FieldByName('empresa_bnc').AsString, QBancosCab.FieldByName('codigo_bnc').AsString );
end;

procedure TFMFichBancos.Previsualizar;
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

procedure TFMFichBancos.ARejillaFlotanteExecute(Sender: TObject);
begin
(*
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
  end;
*)
end;

procedure TFMFichBancos.AntesDeInsertar;
begin
  //Nada
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMFichBancos.AntesDeModificar;
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

procedure TFMFichBancos.AntesDeVisualizar;
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

procedure TFMFichBancos.AntesDeBorrarMaestro;
begin
  if not QBancosDet.IsEmpty then
  begin
    raise Exception.Create('No se puede borrar la forma de pago, primero borre el detalle.');
  end;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMFichBancos.RequiredTime(Sender: TObject; var isTime: Boolean);
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

procedure TFMFichBancos.QBancosCabAfterOpen(DataSet: TDataSet);
begin
  QBancosDet.Open;
end;

procedure TFMFichBancos.QBancosCabBeforeClose(DataSet: TDataSet);
begin
  QBancosDet.Close;
end;

procedure TFMFichBancos.VerDetalle;
begin
  PanelDetalle.Enabled:= false;
end;

procedure TFMFichBancos.EditarDetalle;
begin
  PanelDetalle.Enabled:= TRUE;
  begin
    FocoDetalle:=swift_bnd;
  end
end;

end.
