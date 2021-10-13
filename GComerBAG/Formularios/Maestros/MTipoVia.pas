unit MTipoVia;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid,
  BDEdit, BEdit, dbTables, DError;

type
  TFMTipoVia = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    via_v: TBDEdit;
    descripcion_v: TBDEdit;
    QTipoVias: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    FRegistroaBorrarTipoViaId: String;

    procedure ValidarEntradaMaestro;
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

uses CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  LTiposVia, CAuxiliarDB, Principal, DPreview, bSQLUtils,
  SincronizacionBonny;

{$R *.DFM}

procedure TFMTipoVia.AbrirTablas;
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
  Registros := DataSetMaestro.RecordCount;
  RegistrosInsertados := 0;
end;

procedure TFMTipoVia.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

procedure TFMTipoVia.DespuesDeBorrar;
begin
  SincroBonnyAurora.SincronizarViaTipo(FRegistroaBorrarTipoViaId);
  SincroBonnyAurora.Sincronizar;
  FRegistroaBorrarTipoViaId := '';
end;

procedure TFMTipoVia.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel
  PanelMaestro := PMaestro;

     //Fuente de datos
  DataSetMaestro := QTipoVias;
  Select := 'SELECT * FROM frf_vias ';
 {+}where := ' WHERE via_v= ' + QuotedStr('##');
  Order := 'ORDER BY via_v';
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
  PMaestro.GetTabOrderList(Lista);

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> CVariables.tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
  Visualizar;
     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(pcNulo);

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;

    // Sinconizacion Web - borrado
  OnBeforeMasterDelete := AlBorrar;
  OnAfterMasterDeleted := DespuesDeBorrar;

     //Focos
  {+}FocoAltas := via_v;
  {+}FocoModificar := via_v;
  {+}FocoLocalizar := via_v;
end;

{+ CUIDADIN }

procedure TFMTipoVia.FormActivate(Sender: TObject);
begin
  if not DataSetMaestro.Active then Exit;
     //Variables globales
  M := Self;
  MD := nil;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;

procedure TFMTipoVia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Lista.Free;
     {MODIFICAR}
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

procedure TFMTipoVia.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMTipoVia.Filtro;
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

procedure TFMTipoVia.AlBorrar;
begin
  FRegistroaBorrarTipoViaId := DSMaestro.DataSet.FieldByName('via_v').asString;
end;

procedure TFMTipoVia.AnyadirRegistro;
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

procedure TFMTipoVia.ValidarEntradaMaestro;
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
end;

procedure TFMTipoVia.Previsualizar;
var enclave: TBookMark;
begin
     //Crear el listado
  enclave := DatasetMaestro.GetBookmark;
  QRLTiposVia := TQRLTiposVia.Create(Application);
  PonLogoGrupoBonnysa( QRLTiposVia );
  QRLTiposVia.DataSet := QTipoVias;
  Preview(QRLTiposVia);
  DatasetMaestro.GotoBookmark(enclave);
  DatasetMaestro.FreeBookmark(enclave);
end;

procedure TFMTipoVia.SincronizarWeb;
begin
  SincroBonnyAurora.SincronizarViaTipo(DSMaestro.DataSet.FieldByName('via_v').asString);
  SincroBonnyAurora.Sincronizar;
end;

end.



