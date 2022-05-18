unit CliEnvases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, nbEdits, nbLabels,
  ExtCtrls, Buttons, ActnList, ComCtrls, ToolWin, DBCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinBlue, dxSkinBlueprint, dxSkinFoggy, dxSkinMoneyTwins,
  Menus, cxButtons, SimpleSearch, cxTextEdit, cxDBEdit,
  cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView,
  cxGrid, BSpeedButton, BGridButton, BEdit, BDEdit, BGrid, dError;

type
  TFCliEnvases = class(TForm)
    Panel1: TPanel;
    nbLabel1: TnbLabel;
    lblEmpresa: TnbStaticText;
    empresa: TnbDBAlfa;
    ToolBar1: TToolBar;
    btnAlta: TToolButton;
    btnModificar: TToolButton;
    btnBorrar: TToolButton;
    ToolButton4: TToolButton;
    btnAceptar: TToolButton;
    btnCancelar: TToolButton;
    ToolButton8: TToolButton;
    btnCerrar: TToolButton;
    nbLabel4: TnbLabel;
    cliente: TnbDBAlfa;
    lblCliente: TnbStaticText;
    nbLabel5: TnbLabel;
    nbLabel6: TnbLabel;
    nbLabel3: TnbLabel;
    lblEnvase: TnbStaticText;
    nbLabel7: TnbLabel;
    nbLabel8: TnbLabel;
    unidad_fac_ce: TComboBox;
    descripcion: TnbDBAlfa;
    n_palets_ce: TnbDBAlfa;
    kgs_palet_ce: TnbDBAlfa;
    Query: TQuery;
    Queryempresa_ce: TStringField;
    Queryenvase_ce: TStringField;
    Querycliente_ce: TStringField;
    Queryunidad_fac_ce: TStringField;
    Querydescripcion_ce: TStringField;
    Queryn_palets_ce: TSmallintField;
    Querykgs_palet_ce: TSmallintField;
    DataSource: TDataSource;
    ActionList: TActionList;
    AAnyadir: TAction;
    ABorrar: TAction;
    AModificar: TAction;
    AAceptar: TAction;
    ACancelar: TAction;
    ACerrar: TAction;
    nbLabel2: TnbLabel;
    nbLabel9: TnbLabel;
    nbLabel10: TnbLabel;
    min_vida_cliente_ce: TnbDBAlfa;
    max_vida_cliente_ce: TnbDBAlfa;
    caducidad_cliente_ce: TnbDBAlfa;
    intgrfldQuerycaducidad_cliente_ce: TIntegerField;
    intgrfldQuerymin_vida_cliente_ce: TIntegerField;
    intgrfldQuerymax_vida_cliente_ce: TIntegerField;
    lbl1: TLabel;
    strngfldQuerydes_envase: TStringField;
    nbLabel11: TnbLabel;
    producto_ce: TnbDBAlfa;
    lblProducto: TnbStaticText;
    Queryproducto_ce: TStringField;
    envase: TcxDBTextEdit;
    ssEnvase: TSimpleSearch;
    nbLabel12: TnbLabel;
    variedad: TnbDBAlfa;
    Queryvariedad_ce: TStringField;
    nbLabel13: TnbLabel;
    ref_cliente_ce: TnbDBAlfa;
    Queryref_cliente_ce: TStringField;
    nbLabel15: TnbLabel;
    dun14_ce: TnbDBAlfa;
    cxGrid1: TcxGrid;
    tvDetalle: TcxGridDBTableView;
    tvEmpresa: TcxGridDBColumn;
    tvProducto: TcxGridDBColumn;
    tvEnvase: TcxGridDBColumn;
    tvCliente: TcxGridDBColumn;
    tvDescripcion: TcxGridDBColumn;
    tvRefCliente: TcxGridDBColumn;
    tvVariedad: TcxGridDBColumn;
    tvUndFacturacion: TcxGridDBColumn;
    tvCaducidad: TcxGridDBColumn;
    tvMinVida: TcxGridDBColumn;
    tvMaxVida: TcxGridDBColumn;
    tvPalets: TcxGridDBColumn;
    tvKgPalets: TcxGridDBColumn;
    lvDetalle: TcxGridLevel;
    centro_ce: TBDEdit;
    BGBCentro: TBGridButton;
    lblDesCentro: TStaticText;
    nbLabel16: TnbLabel;
    Querycentro_ce: TStringField;
    Querydun14_ce: TStringField;
    RejillaFlotante: TBGrid;
    ARejillaFlotante: TAction;
    nbLabel18: TnbLabel;
    tipo_palet_ce: TBDEdit;
    BGBTipoPalet: TBGridButton;
    lblDesTipoPalet: TStaticText;
    nbLabel19: TnbLabel;
    cajas_palet_ce: TnbDBAlfa;
    tvDun14: TcxGridDBColumn;
    tvCentro: TcxGridDBColumn;
    tvComercial: TcxGridDBColumn;
    tvTipoPalet: TcxGridDBColumn;
    Querycajas_palet_ce: TIntegerField;
    Querytipo_palet_ce: TStringField;
    tvCajaPalet: TcxGridDBColumn;
    procedure empresaChange(Sender: TObject);
    procedure clienteChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AAnyadirExecute(Sender: TObject);
    procedure ABorrarExecute(Sender: TObject);
    procedure AModificarExecute(Sender: TObject);
    procedure AAceptarExecute(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure ACerrarExecute(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure QueryBeforePost(DataSet: TDataSet);
    procedure envaseChange(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure producto_ceChange(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure envaseExit(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
    procedure cxGrid1Enter(Sender: TObject);
    procedure cxGrid1Exit(Sender: TObject);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure ponNombre(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCliente, sEnvase: string;
    function LoadData: Boolean;
    function  VerificarDatos: boolean;

  public
    { Public declarations }
  end;

procedure EnvaseClientePorCliente(const AEmpresa, ACliente: string);
procedure EnvaseClientePorEnvase( const AEmpresa, AProducto, AEnvase: string);

implementation

{$R *.dfm}

uses UDMBaseDatos, UDMAuxDB, bSQLUtils, bTextUtils, SincronizacionBonny, cvariables, CAuxiliarDB;

procedure EnvaseClientePorCliente(const AEmpresa, ACliente: string);
begin
  with TFCliEnvases.Create(nil) do
  begin
    sEmpresa := AEmpresa;
    sCliente := ACliente;
    sEnvase:= '';

    if LoadData then
      ShowModal
    else
      Free;
  end;
end;

procedure EnvaseClientePorEnvase(const AEmpresa, AProducto, AEnvase: string);
begin
  with TFCliEnvases.Create(nil) do
  begin
    sEmpresa := AEmpresa;
    sEnvase := AEnvase;
    sCliente:= '';

    if LoadData then
      ShowModal
    else
      Free;
  end;
end;

procedure TFCliEnvases.empresaChange(Sender: TObject);
begin
  lblEmpresa.Caption := desEmpresa(empresa.Text);
  clienteChange( cliente );
  envaseChange( envase );
  PonNombre (centro_ce);
end;

procedure TFCliEnvases.clienteChange(Sender: TObject);
begin
  lblCliente.Caption := desCliente(cliente.Text);
end;

procedure TFCliEnvases.cxGrid1Enter(Sender: TObject);
begin
//  AModificar.ShortCut := TexttoShortCut('');
end;

procedure TFCliEnvases.cxGrid1Exit(Sender: TObject);
begin
//  AModificar.ShortCut := ShortCut(Word('M'), []);
end;

procedure TFCliEnvases.DataSourceDataChange(Sender: TObject; Field: TField);
begin

  if Queryunidad_fac_ce.AsString = 'K' then
    unidad_fac_ce.ItemIndex:= 0
  else
  if Queryunidad_fac_ce.AsString = 'U' then
    unidad_fac_ce.ItemIndex:= 1
  else
  if Queryunidad_fac_ce.AsString = 'C' then
    unidad_fac_ce.ItemIndex:= 2;

end;

procedure TFCliEnvases.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Query.Close;
  Action := caFree;
end;

function TFCliEnvases.LoadData: Boolean;
begin
  result := false;
  if not Query.Active then
  begin
    Query.SQl.Clear;
    Query.SQl.Add('Select * from frf_clientes_env');
    Query.SQl.Add('where 1=1 ');
    if sCliente <> '' then
      Query.SQl.Add('  and cliente_ce ' + SQLEqualS(sCliente));
    if sEnvase <> '' then
      Query.SQl.Add('  and envase_ce ' + SQLEqualS(sEnvase));

    result := OpenQuery(Query);
  end;
end;


procedure TFCliEnvases.AAnyadirExecute(Sender: TObject);
begin

  Query.Insert;

  Panel1.Enabled:= True;
  unidad_fac_ce.ItemIndex:= 0;

  Query.FieldByName('empresa_ce').AsString:=  sEmpresa;
  empresa.Text:= sEmpresa;
//  empresa.Enabled:= False;

  if sCliente <> '' then
  begin
    Query.FieldByName('cliente_ce').AsString:=  sCliente;
    cliente.Text:= sCliente;
    cliente.Enabled:= False;
  end
  else
  begin
    cliente.Enabled:= True;
//    cliente.SetFocus;
  end;

  if sEnvase <> '' then
  begin
    Query.FieldByName('envase_ce').AsString:=  sEnvase;
    envase.Text:= sEnvase;
    envase.Enabled:= False;
  end
  else
  begin
    envase.Enabled:= True;
//    envase.SetFocus;
  end;

  empresa.SetFocus;

  btnAlta.Enabled:= False;
  btnBorrar.Enabled:= False;
  btnModificar.Enabled:= False;
  btnCerrar.Enabled:= False;

  btnAceptar.Enabled:= True;
  btnCancelar.Enabled:= True;
end;

procedure TFCliEnvases.ABorrarExecute(Sender: TObject);
var
  empresaId,
  productoId,
  envaseId,
  clienteId: String;
begin
  if not Query.IsEmpty then
  begin
    empresaId := Query.FieldByName('empresa_ce').asString;
    productoId := Query.FieldByName('producto_ce').asString;
    envaseId := Query.FieldByName('envase_ce').asString;
    clienteId := Query.FieldByName('cliente_ce').asString;

    Query.Delete;
    SincroBonnyAurora.SincronizarUnidadFacturacion(empresaId, productoId, envaseId, clienteId);
    SincroBonnyAurora.Sincronizar;
  end;
end;

procedure TFCliEnvases.AModificarExecute(Sender: TObject);
begin
  if Queryunidad_fac_ce.AsString = 'K' then
    unidad_fac_ce.ItemIndex:= 0
  else
  if Queryunidad_fac_ce.AsString = 'U' then
    unidad_fac_ce.ItemIndex:= 1
  else
  if Queryunidad_fac_ce.AsString = 'C' then
    unidad_fac_ce.ItemIndex:= 2;

  Query.Edit;

  Panel1.Enabled:= True;
  empresa.Enabled:= False;
  producto_ce.Enabled:= False;
  ////
  if sCliente <> '' then
  begin
    cliente.Enabled:= False;
  end
  else
  begin
    cliente.Enabled:= True;
    cliente.SetFocus;
  end;
  if sEnvase <> '' then
  begin
    envase.Enabled:= False;
  end
  else
  begin
    envase.Enabled:= True;
    envase.SetFocus;
  end;

  btnAlta.Enabled:= False;
  btnBorrar.Enabled:= False;
  btnModificar.Enabled:= False;
  btnCerrar.Enabled:= False;

  btnAceptar.Enabled:= True;
  btnCancelar.Enabled:= True;
end;

procedure TFCliEnvases.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kCentro: DespliegaRejilla(BGBCentro, [empresa.Text]);
    kTipoPalet: DespliegaRejilla(BGBTipoPalet);
  end;

end;

procedure TFCliEnvases.AAceptarExecute(Sender: TObject);
begin
    //si no se inserta una referencia de cliente, tomará el valor del envase
    if ref_cliente_ce.Text = '' then
      Query.FieldByName('ref_cliente_ce').AsString :=  Query.FieldByName('envase_ce').AsString;

  if not VerificarDatos then exit;

  Query.Post;
  SincroBonnyAurora.SincronizarUnidadFacturacion(
    Query.FieldByName('empresa_ce').asString,
    Query.FieldByName('producto_ce').asString,
    Query.FieldByName('envase_ce').asString,
    Query.FieldByName('cliente_ce').asString);
  SincroBonnyAurora.Sincronizar;

  Query.Close;
  Query.Open;

  Panel1.Enabled:= False;
  empresa.Enabled:= True;
  cliente.Enabled:= True;
  envase.Enabled:= True;


  btnAlta.Enabled:= True;
  btnBorrar.Enabled:= True;
  btnModificar.Enabled:= True;
  btnCerrar.Enabled:= True;

  btnAceptar.Enabled:= False;
  btnCancelar.Enabled:= False;
end;

procedure TFCliEnvases.ACancelarExecute(Sender: TObject);
begin
  Query.Cancel;
  
  Panel1.Enabled:= False;
  empresa.Enabled:= True;
  cliente.Enabled:= True;
  envase.Enabled:= True;


  btnAlta.Enabled:= True;
  btnBorrar.Enabled:= True;
  btnModificar.Enabled:= True;
  btnCerrar.Enabled:= True;

  btnAceptar.Enabled:= False;
  btnCancelar.Enabled:= False;
end;


procedure TFCliEnvases.ACerrarExecute(Sender: TObject);
begin
  Close;
end;

procedure TFCliEnvases.ActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  AAceptar.Enabled := Query.State in [dsEdit, dsInsert];
  ACancelar.Enabled := Query.State in [dsEdit, dsInsert];
  AAnyadir.Enabled := Query.State in [dsBrowse];
  AModificar.Enabled := (Query.State in [dsBrowse]) and (not Query.IsEmpty);
  ABorrar.Enabled := (Query.State in [dsBrowse]) and (not Query.IsEmpty);
  ACerrar.Enabled := Query.State in [dsBrowse];

  if ACerrar.Enabled then
  begin
    ACerrar.ShortCut := ShortCut(vk_escape, []);
    ACancelar.ShortCut := 0;
  end
  else
  begin
    ACancelar.ShortCut := ShortCut(vk_escape, []);
    ACerrar.ShortCut := 0;
  end;
end;

procedure TFCliEnvases.FormCreate(Sender: TObject);
begin
  //ABorrar.ShortCut := ShortCut(VK_SUBTRACT, []);
  //AAnyadir.ShortCut := ShortCut(VK_ADD, []);
  //AModificar.ShortCut := ShortCut(Word('M'), []);
  AAceptar.ShortCut := ShortCut(VK_F1, []);
  centro_ce.Tag := kCentro;
  tipo_palet_ce.Tag := kTipoPalet;

end;

procedure TFCliEnvases.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{*}//Si la rejilla esta desplegada no hacemos nada
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
           //No hacemos nada
      Exit;

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

procedure TFCliEnvases.FormShow(Sender: TObject);
begin
  cxGrid1.SetFocus;
end;

procedure TFCliEnvases.QueryBeforePost(DataSet: TDataSet);
begin
  Queryunidad_fac_ce.AsString:= copy( unidad_fac_ce.Items[unidad_fac_ce.ItemIndex], 1, 1 );
end;

procedure TFCliEnvases.envaseChange(Sender: TObject);
var
  sAux: string;
begin
  lblEnvase.Caption:= desEnvase(empresa.Text, envase.Text );
  if ( lblEnvase.Caption <> '' ) and ( ( Query.State = dsInsert ) or ( Query.State = dsEdit ) ) then
  begin
    sAux:= GetProductoEnvase( empresa.Text, envase.Text);
    if sAux <> '' then
    begin
      Query.FieldByName('producto_ce').AsString:= sAux;
      producto_ce.Text:= sAux;
    end;
  end;
  producto_ceChange( producto_ce );
end;

procedure TFCliEnvases.envaseExit(Sender: TObject);
begin
  if EsNumerico(envase.Text) and (Length(envase.Text) <= 5) then
    if (envase.Text <> '' ) and (Length(envase.Text) < 9) then
      envase.Text := 'COM-' + Rellena( envase.Text, 5, '0');
end;

procedure TFCliEnvases.QueryCalcFields(DataSet: TDataSet);
begin
  if Trim(Query.FieldByName('descripcion_ce').AsString) <> '' then
    Query.FieldByName('des_Envase').AsString:= Query.FieldByName('descripcion_ce').AsString
  else
    Query.FieldByName('des_Envase').AsString:= desEnvase( Query.FieldByName('empresa_ce').AsString, Query.FieldByName('envase_ce').AsString);

{
  if Trim(Query.FieldByName('descripcion_ce').AsString) <> '' then
    Query.FieldByName('des_Envase').AsString:= Query.FieldByName('descripcion_ce').AsString
  else
    Query.FieldByName('des_Envase').AsString:= lblEnvase.caption;
}
end;

procedure TFCliEnvases.ssEnvaseAntesEjecutar(Sender: TObject);
begin
    ssEnvase.SQLAdi := '';
    if producto_ce.Text <> '' then
      ssEnvase.SQLAdi := ' producto_e = ' +  QuotedStr(producto_ce.Text);
end;

function TFCliEnvases.VerificarDatos: boolean;
begin
  //Comprobar si los campos se han rellenado correctamente
  Result := False;

  if (centro_ce.Text <> '') and (lblDesCentro.Caption = '') then
  begin
    ShowError('El código del centro es incorrecto.');
    centro_ce.SetFocus;
  end
  else
  if (tipo_palet_ce.Text <> '') and (lblDesTipoPalet.Caption = '') then
  begin
    ShowError('El código de palet es incorrecto.');
    tipo_palet_ce.SetFocus;
  end
  else
    result := True;

end;

procedure TFCliEnvases.producto_ceChange(Sender: TObject);
begin
  lblProducto.Caption:= desProducto( empresa.Text, producto_ce.Text );
end;

procedure TFCliEnvases.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kCentro:lblDesCentro.Caption := desCentro(Query.FieldByName('empresa_ce').AsString, centro_ce.Text);
    kTipoPalet: lblDesTipoPalet.Caption := desTipoPalet(tipo_palet_ce.Text );
  end;
end;


end.
