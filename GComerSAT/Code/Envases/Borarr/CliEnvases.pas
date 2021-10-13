unit CliEnvases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, nbEdits, nbLabels,
  ExtCtrls, Buttons, ActnList, ComCtrls, ToolWin, DBCtrls;

type
  TFCliEnvases = class(TForm)
    Panel1: TPanel;
    nbLabel1: TnbLabel;
    lblEmpresa: TnbStaticText;
    empresa: TnbDBAlfa;
    nbLabel5: TnbLabel;
    descripcion: TnbDBAlfa;
    DBGrid: TDBGrid;
    Query: TQuery;
    DataSource: TDataSource;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton8: TToolButton;
    ToolButton7: TToolButton;
    ActionList: TActionList;
    AAnyadir: TAction;
    ABorrar: TAction;
    AModificar: TAction;
    AAceptar: TAction;
    ACancelar: TAction;
    ACerrar: TAction;
    Queryempresa_ce: TStringField;
    Queryproducto_base_ce: TSmallintField;
    Queryenvase_ce: TStringField;
    Querycliente_ce: TStringField;
    Queryunidad_fac_ce: TStringField;
    Querydescripcion_ce: TStringField;
    nbLabel6: TnbLabel;
    unidad_fac_ce: TComboBox;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    productoBase_: TnbDBAlfa;
    envase: TnbDBAlfa;
    lblProductoBase: TnbStaticText;
    lblEnvase: TnbStaticText;
    nbLabel4: TnbLabel;
    cliente: TnbDBAlfa;
    lblCliente: TnbStaticText;
    DBGridPalets: TDBGrid;
    nbLabel7: TnbLabel;
    nbLabel8: TnbLabel;
    n_palets_ce: TnbDBAlfa;
    kgs_palet_ce: TnbDBAlfa;
    Queryn_palets_ce: TSmallintField;
    Querykgs_palet_ce: TSmallintField;
    procedure empresaChange(Sender: TObject);
    procedure productoBase_Change(Sender: TObject);
    procedure envaseChange(Sender: TObject);
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
  private
    { Private declarations }
    function LoadData: Boolean;
  public
    { Public declarations }
  end;

procedure DescripcionEnvaseCliente(const AEmpresa, ACliente: string);

implementation

{$R *.dfm}

uses UDMBaseDatos, UDMAuxDB, bSQLUtils, Menus;

procedure DescripcionEnvaseCliente(const AEmpresa, ACliente: string);
begin
  with TFCliEnvases.Create(nil) do
  begin
    empresa.Text := AEmpresa;
    cliente.Text := ACliente;

    if LoadData then
      ShowModal
    else
      Free;
  end;
end;

procedure TFCliEnvases.empresaChange(Sender: TObject);
begin
  lblEmpresa.Caption := desEmpresa(empresa.Text);
end;

procedure TFCliEnvases.productoBase_Change(Sender: TObject);
begin
  lblProductoBase.Caption := desProductoBase(empresa.Text, productoBase_.Text);
end;

procedure TFCliEnvases.envaseChange(Sender: TObject);
begin
  lblEnvase.Caption := desEnvase(empresa.Text, envase.Text);
end;

procedure TFCliEnvases.clienteChange(Sender: TObject);
begin
  lblCliente.Caption := desCliente(empresa.Text, cliente.Text);
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
    Query.SQl.Add('where empresa_ce ' + SQLEqualS(empresa.Text));
    Query.SQl.Add('  and cliente_ce ' + SQLEqualS(cliente.Text));

    result := OpenQuery(Query);
  end;
end;

procedure TFCliEnvases.AAnyadirExecute(Sender: TObject);
begin
  productoBase_.Enabled := true;
  envase.Enabled := true;
  descripcion.Enabled := true;
  unidad_fac_ce.Enabled := true;
  unidad_fac_ce.ItemIndex:= 0;
  n_palets_ce.Enabled := true;
  kgs_palet_ce.Enabled := true;
  productoBase_.SetFocus;
  Query.Insert;
  DBGrid.Top := 223;
  DBGrid.Height := 208;
  DBGrid.Enabled:= False;
  DBGridPalets.Top := 223;
  DBGridPalets.Height := 208;
  DBGridPalets.Enabled:= False;
end;

procedure TFCliEnvases.ABorrarExecute(Sender: TObject);
begin
  Query.Delete;
end;

procedure TFCliEnvases.AModificarExecute(Sender: TObject);
begin
  productoBase_.Enabled := true;
  envase.Enabled := true;
  descripcion.Enabled := true;
  unidad_fac_ce.Enabled := true;
  if Queryunidad_fac_ce.AsString = 'K' then
    unidad_fac_ce.ItemIndex:= 0
  else
  if Queryunidad_fac_ce.AsString = 'U' then
    unidad_fac_ce.ItemIndex:= 1
  else
  if Queryunidad_fac_ce.AsString = 'C' then
    unidad_fac_ce.ItemIndex:= 2;
  n_palets_ce.Enabled := true;
  kgs_palet_ce.Enabled := true;    
  descripcion.SetFocus;
  Query.Edit;
  DBGrid.Top := 223;
  DBGrid.Height := 208;
  DBGrid.Enabled:= False;
  DBGridPalets.Top := 223;
  DBGridPalets.Height := 208;
  DBGridPalets.Enabled:= False;
end;

procedure TFCliEnvases.AAceptarExecute(Sender: TObject);
begin
  Query.Post;
  Query.Close;
  Query.Open;
  productoBase_.Enabled := false;
  envase.Enabled := false;
  descripcion.Enabled := false;
  unidad_fac_ce.Enabled := False;
  n_palets_ce.Enabled := False;
  kgs_palet_ce.Enabled := False;
  DBGrid.Top := 112;
  DBGrid.Height := 319;
  DBGrid.Enabled:= True;
  DBGridPalets.Top := 112;
  DBGridPalets.Height := 319;
  DBGridPalets.Enabled:= True;
end;

procedure TFCliEnvases.ACancelarExecute(Sender: TObject);
begin
  Query.Cancel;
  productoBase_.Enabled := false;
  envase.Enabled := false;
  descripcion.Enabled := false;
  unidad_fac_ce.Enabled := False;
  n_palets_ce.Enabled := false;
  kgs_palet_ce.Enabled := False;
  DBGrid.Top := 112;
  DBGrid.Height := 319;
  DBGrid.Enabled:= True;
  DBGridPalets.Top := 112;
  DBGridPalets.Height := 319;
  DBGridPalets.Enabled:= True;
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
  DBGrid.Top := 112;
  DBGrid.Height := 319;
  DBGridPalets.Top := 112;
  DBGridPalets.Height := 319;

  ABorrar.ShortCut := ShortCut(VK_SUBTRACT, []);
  AAnyadir.ShortCut := ShortCut(VK_ADD, []);
  AModificar.ShortCut := ShortCut(Word('M'), []);
  AAceptar.ShortCut := ShortCut(VK_F1, []);
end;

procedure TFCliEnvases.QueryBeforePost(DataSet: TDataSet);
begin
  Query.FieldByName('empresa_ce').AsString := empresa.Text;
  Query.FieldByName('cliente_ce').AsString := cliente.Text;
  Queryunidad_fac_ce.AsString:= copy( unidad_fac_ce.Items[unidad_fac_ce.ItemIndex], 1, 1 );
end;

end.
