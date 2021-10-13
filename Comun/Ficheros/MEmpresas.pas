unit MEmpresas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, dbTables,
  BEdit, BDEdit, Grids, DBGrids, BGrid, Buttons, BSpeedButton, BGridButton,
  ActnList, ComCtrls, BCalendario, BCalendarButton, Derror;

type
  TFMEmpresas = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    empresa_e: TBDEdit;
    nif_e: TBDEdit;
    tipo_via_e: TBDEdit;
    domicilio_e: TBDEdit;
    poblacion_e: TBDEdit;
    cod_postal_e: TBDEdit;
    RejillaFlotante: TBGrid;
    BGBTipoVia: TBGridButton;
    ActionList1: TActionList;
    ARejillaDespegable: TAction;
    STProvincia: TStaticText;
    Label11: TLabel;
    codigo_ean_e: TBDEdit;
    QEmpresas: TQuery;
    Label4: TLabel;
    Label14: TLabel;
    ref_cobros_e: TBDEdit;
    cont_relfac_e: TBDEdit;
    Label10: TLabel;
    cont_entregas_e: TBDEdit;
    dbgContadores: TDBGrid;
    qryContadores: TQuery;
    dsContadores: TDataSource;
    pnl1: TPanel;
    btnContadores: TBitBtn;
    nombre_e: TBDEdit;
    Label6: TLabel;
    cont_giros_e: TBDEdit;
    Label9: TLabel;
    cont_remesas_giro_e: TBDEdit;
    lbl1: TLabel;
    BDEdit1: TBDEdit;
    lbl2: TLabel;
    BDEdit2: TBDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaDespegableExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure cod_postal_eChange(Sender: TObject);
    procedure btnContadoresClick(Sender: TObject);
    procedure QEmpresasAfterOpen(DataSet: TDataSet);
    procedure QEmpresasBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    FRegistroABorrarEmpresaId: String;

    procedure ValidarEntradaMaestro;
    procedure AntesDeModificar;
    procedure AntesDeInsertar;
    procedure AntesDeLocalizar;
    procedure AntesDeVisualizar;
    procedure AbrirTablas;
    procedure CerrarTablas;

  protected
    procedure AlBorrar;
    procedure DespuesDeBorrar;

    procedure SincronizarWeb; override;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;
    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses CVariables, CGestionPrincipal, LEmpresas, UDMBaseDatos, CReportes,
  Principal, CAuxiliarDB, DPreview, UDMAuxDB, bSQLUtils, ContadoresEmpresaFD,
  SincronizacionBonny;

{$R *.DFM}

procedure TFMEmpresas.AbrirTablas;
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

procedure TFMEmpresas.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

procedure TFMEmpresas.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel
  PanelMaestro := PMaestro;

//** DATOS
     //Fuente de datos
  DataSetMaestro := QEmpresas;
  Select := ' SELECT * FROM frf_empresas ';
 {+}where := ' WHERE empresa_e=' + QUOTEDSTR('###');
  Order := ' ORDER BY empresa_e ';
     //Para reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;

  with qryContadores do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_empresas_serie, frf_facturas_serie ');
    SQL.Add(' where cod_empresa_es = :empresa_e and cod_serie_fs = cod_serie_es and anyo_fs = anyo_es ');
    SQL.Add(' order by anyo_fs desc, cod_serie_fs  ');
    if not Prepared then
      Prepare;
  end;

  //Abrir tablas
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

//** INICIALIZACION II
     //Lista de componentes
  Lista := TList.Create;
  PMaestro.GetTabOrderList(Lista);
     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnInsert:= AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnBrowse := AntesDeLocalizar;
  OnView := AntesDeVisualizar;

    // Sinconizacion Web - borrado
  OnBeforeMasterDelete := AlBorrar;
  OnAfterMasterDeleted := DespuesDeBorrar;

     //Focos
  {+}FocoAltas := empresa_e;
  {+}FocoModificar := nombre_e;
  {+}FocoLocalizar := empresa_e;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
  Visualizar;
  BHGrupoDesplazamientoMaestro(pcNulo);

  tipo_via_e.Tag := kTipoVia;
  cod_postal_e.Tag := kCodPostal;
end;

procedure TFMEmpresas.FormActivate(Sender: TObject);
begin
     //Si las tablas no estan abiertas salimos
  if not DataSetMaestro.Active then
    Exit;
     //Variables globales
  M := Self;
  MD := nil;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
     //Muestra barra de heramientas correcta
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;

procedure TFMEmpresas.FormDeactivate(Sender: TObject);
begin
     //Por si el nuevo form no necesita rejilla
  gRF := nil;
end;

procedure TFMEmpresas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with qryContadores do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  Lista.Free;
     //Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
     // Cerrar tabla
  CerrarTablas;
     //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  // Cambia acci�n por defecto para Form hijas en una aplicaci�n MDI
  // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;


procedure TFMEmpresas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    //Si la rejilla esta desplegada no hacemos nada
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
           //No hacemos nada
      Exit;

    // Tecla ENTER - Cambio entre los Controles de Datos en modo edici�n
    //               y entre los Campos de B�squeda en la localizaci�n
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

{+}//funcion generica

procedure TFMEmpresas.Filtro;
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

{+}//funcion generica

procedure TFMEmpresas.AnyadirRegistro;
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

procedure TFMEmpresas.ValidarEntradaMaestro;
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
          begin
            ActiveControl := Objeto as TBEdit;
            raise Exception.Create(RequiredMsg);
          end
          else
          begin
            ActiveControl := Objeto as TBEdit;
            raise Exception.Create('Faltan datos de obligada inserci�n.');
          end;
        end;

      end;
    end;
  end;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMEmpresas.AntesDeModificar;
var i: Integer;
begin
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;
  btnContadores.Enabled:= false;
end;

procedure TFMEmpresas.AlBorrar;
begin
  FRegistroABorrarEmpresaId := DSMaestro.DataSet.FieldByName('empresa_e').asString;
end;

procedure TFMEmpresas.AntesDeInsertar;
begin
  btnContadores.Enabled:= false;
end;

procedure TFMEmpresas.AntesDeLocalizar;
begin
  btnContadores.Enabled:= false;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMEmpresas.AntesDeVisualizar;
var i: Integer;
begin
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          if Enabled = false then Enabled := true;
  end;
  btnContadores.Enabled:= True;
end;

procedure TFMEmpresas.Previsualizar;
begin
     //Crear el listado
  try
        //Crear y abrir consulta
    with DMBaseDatos.QListado do
    begin
      if Active then
      begin
        Cancel;
        Close;
      end;
      SQl.Clear;
      SQL.Add(' SELECT empresa_e, nombre_e, nif_e, tipo_via_e, ' +
        '        domicilio_e, poblacion_e, cod_postal_e, nombre_p, ' +
        '        codigo_ean_e ' +
        ' FROM frf_empresas, frf_provincias ');
      if where <> '' then
        SQL.Add(where + ' AND ( cod_postal_e[1,2] = codigo_p)')
      else
        SQL.Add(' WHERE ( cod_postal_e[1,2] = codigo_p)');
      SQL.Add(' ORDER BY nombre_e ');
      try
        Open;
                //RecordCount;
        First;
      except
        MessageDlg('Error al generar el listado.', mtError, [mbOK], 0);
        exit;
      end;
    end;
    QRLEmpresas := TQRLEmpresas.Create(Application);
    try
      PonLogoGrupoBonnysa(QRLEmpresas);
      //QRLEmpresas.DataSet := QEmpresas;
      QRLEmpresas.DataSet := DMBaseDatos.QListado;
      Preview(QRLEmpresas);
    except
      FreeAndNil( QRLEmpresas );
      raise;
    end;
  finally
    DMBaseDatos.QListado.Cancel;
    DMBaseDatos.QListado.Close;
  end;
end;


procedure TFMEmpresas.ARejillaDespegableExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kTipoVia: DespliegaRejilla(BGBTipoVia);
  end;
end;

procedure TFMEmpresas.RequiredTime(Sender: TObject; var isTime: Boolean);
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

procedure TFMEmpresas.SincronizarWeb;
begin
  SincroBonnyAurora.SincronizarEmpresa(DSMaestro.DataSet.FieldByName('empresa_e').asString);
  SincroBonnyAurora.Sincronizar;
end;

procedure TFMEmpresas.cod_postal_eChange(Sender: TObject);
begin
  STprovincia.Caption := desProvincia(cod_postal_e.Text);
end;

procedure TFMEmpresas.DespuesDeBorrar;
begin
  SincroBonnyAurora.SincronizarEmpresa(FRegistroABorrarEmpresaId);
  SincroBonnyAurora.Sincronizar;
  FRegistroABorrarEmpresaId := '';
end;

procedure TFMEmpresas.btnContadoresClick(Sender: TObject);
begin
  if not QEmpresas.IsEmpty and (QEmpresas.State = dsBrowse) then
  begin
    //Nuevo
    ContadoresEmpresaFD.ExecuteContadoresSerie( self, empresa_e.Text  );
    qryContadores.Close;
    qryContadores.Open;
  end;
end;

procedure TFMEmpresas.QEmpresasAfterOpen(DataSet: TDataSet);
begin
  qryContadores.Open;
end;

procedure TFMEmpresas.QEmpresasBeforeClose(DataSet: TDataSet);
begin
  qryContadores.Close;
end;

end.

