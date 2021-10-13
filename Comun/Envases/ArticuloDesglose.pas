unit ArticuloDesglose;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, nbEdits, nbLabels,
  ExtCtrls, Buttons, ActnList, ComCtrls, ToolWin, DBCtrls, BSpeedButton,
  BGridButton, BEdit, BDEdit, BGrid;

type
  TFArticuloDesglose = class(TForm)
    Panel1: TPanel;
    nbLabel3: TnbLabel;
    lblEnvase: TnbStaticText;
    envase: TnbDBAlfa;
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
    RejillaFlotante: TBGrid;
    lblCodigo1: TnbLabel;
    strngfldQueryarticulo_ad: TStringField;
    strngfldQueryproducto_ad: TStringField;
    strngfldQueryproducto_desglose_ad: TStringField;
    Label1: TLabel;
    producto_desglose_ad: TBDEdit;
    BGBProducto: TBGridButton;
    desProdDesglose: TStaticText;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    producto: TnbDBAlfa;
    lblProducto: TnbStaticText;
    porcentaje_ad: TBDEdit;
    Queryporcentaje_ad: TFloatField;
    QuerydescripProducto: TStringField;
    LPorcentaje: TLabel;
    procedure envaseChange(Sender: TObject);
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
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure BGBProductoClick(Sender: TObject);
    procedure productoChange(Sender: TObject);
    procedure producto_desglose_adChange(Sender: TObject);
  private
    { Private declarations }
    QAux: Tquery;
    bInsertar: boolean;
    sProducto: string;
    rPorcentaje: Real;

    function LoadData: Boolean;
    procedure CargaPorcentaje;
    function SuperaPorcentaje: boolean;
  public
    { Public declarations }
  end;

procedure ArticuloDesgloseM(const AEnvase, AProducto: string);

implementation

{$R *.dfm}

uses UDMBaseDatos, UDMAuxDB, bSQLUtils, Menus, CAuxiliarDB, CVariables;

procedure ArticuloDesgloseM(const AEnvase,  AProducto: string);
begin
  with TFArticuloDesglose.Create(nil) do
  begin
    envase.Text := AEnvase;
    producto.Text:= AProducto;

    if LoadData then
    begin
      CargaPorcentaje;
      ShowModal;
    end
    else
      Free;
  end;
end;

procedure TFArticuloDesglose.envaseChange(Sender: TObject);
begin
  lblEnvase.Caption := desEnvase('', envase.Text);
end;

procedure TFArticuloDesglose.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Query.Close;
  QAux.Close;
  Action := caFree;
end;

function TFArticuloDesglose.LoadData: Boolean;
begin
  result := false;
  if not Query.Active then
  begin
    Query.SQl.Clear;
    Query.SQl.Add('Select * from frf_articulos_desglose');
    Query.SQl.Add('where articulo_ad ' + SQLEqualS(envase.Text));

    result := OpenQuery(Query);
  end;
end;

procedure TFArticuloDesglose.productoChange(Sender: TObject);
begin
  lblProducto.Caption := desProducto('', producto.Text);
end;

procedure TFArticuloDesglose.producto_desglose_adChange(Sender: TObject);
begin
  desProdDesglose.Caption := desProducto('', producto_desglose_ad.Text);
end;

procedure TFArticuloDesglose.AAnyadirExecute(Sender: TObject);
begin
  producto_desglose_ad.Enabled := true;
  porcentaje_ad.Enabled := true;
  producto_desglose_ad.SetFocus;
  Query.Insert;
  DBGrid.Top := 176;
  DBGrid.Height := 169;
  DBGrid.Enabled:= False;
  LPorcentaje.Visible := false;

  bInsertar:= true;
end;

procedure TFArticuloDesglose.ABorrarExecute(Sender: TObject);
var sMsg: string;
begin
  sMsg:= '¿Desea borrar la linea de desglose para el ARtículo?';
  if MessageDlg( sMsg, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Query.Delete;
    CargaPorcentaje;
  end;
end;

procedure TFArticuloDesglose.AModificarExecute(Sender: TObject);
begin
  producto_desglose_ad.Enabled := true;
  porcentaje_ad.Enabled := true;
  producto_desglose_ad.SetFocus;
  Query.Edit;
  DBGrid.Top := 176;
  DBGrid.Height := 169;
  DBGrid.Enabled:= False;
  LPorcentaje.Visible := False;

  bInsertar:= False;
end;

procedure TFArticuloDesglose.BGBProductoClick(Sender: TObject);
begin
  producto_desglose_ad.Tag := kProducto;
  DespliegaRejilla(BGBProducto);
end;

procedure TFArticuloDesglose.CargaPorcentaje;
begin
  rPorcentaje := 0;
  with QAux do
  begin
    if Active then Close;

    DatabaseName := 'BDProyecto';
    SQL.Clear;
    SQL.Add(' select sum(porcentaje_ad) TotalPorcentaje from frf_articulos_desglose ');
    SQL.Add('  where articulo_ad = :articulo ');

    ParamByName('articulo').AsString := envase.Text;

    Open;
    if not IsEmpty then
      rPorcentaje :=  FieldByName('TotalPorcentaje').AsFloat;
  end;

  if rPorcentaje > 100 then
    LPorcentaje.Font.Color := clRed
  else
    LPorcentaje.Font.Color := clWindowText;
  LPorcentaje.Caption := FloatToStr(rPorcentaje) + '%';
end;

function TFArticuloDesglose.SuperaPorcentaje: boolean;
begin
  CargaPorcentaje;
  if rPorcentaje > 100 then
    Result := True
  else
    Result := False;
end;

procedure TFArticuloDesglose.AAceptarExecute(Sender: TObject);
begin
  Query.Post;
  Query.Close;
  Query.Open;
  CargaPorcentaje;
  producto_desglose_ad.Enabled := false;
  porcentaje_ad.Enabled := false;
  DBGrid.Top := 116;
  DBGrid.Height := 249;
  DBGrid.Enabled:= True;
  LPorcentaje.Visible := True;
end;

procedure TFArticuloDesglose.ACancelarExecute(Sender: TObject);
begin
  Query.Cancel;
  CargaPorcentaje;
  producto_desglose_ad.Enabled := false;
  porcentaje_ad.Enabled := false;
  DBGrid.Top := 116;
  DBGrid.Height := 249;
  DBGrid.Enabled:= True;
  LPorcentaje.Visible := True;
end;

procedure TFArticuloDesglose.ACerrarExecute(Sender: TObject);
begin
  if SuperaPorcentaje then
  begin
  ShowMessage('Atención! El porcentaje de distribución no debe superar el 100% ');
  exit;
  end;

  Close;
end;

procedure TFArticuloDesglose.ActionListUpdate(Action: TBasicAction;
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

procedure TFArticuloDesglose.FormCreate(Sender: TObject);
begin
  bInsertar:= true;

  DBGrid.Top := 116;
  DBGrid.Height := 249;

  ABorrar.ShortCut := ShortCut(VK_SUBTRACT, []);
  AAnyadir.ShortCut := ShortCut(VK_ADD, []);
  AModificar.ShortCut := ShortCut(Word('M'), []);
  AAceptar.ShortCut := ShortCut(VK_F1, []);

  producto_desglose_ad.Tag:= kProducto;

  QAux := TQuery.Create(Self);
end;

procedure TFArticuloDesglose.QueryBeforePost(DataSet: TDataSet);
begin
  Query.FieldByName('articulo_ad').AsString := envase.Text;
  Query.FieldByName('producto_ad').AsString := producto.Text;
end;

procedure TFArticuloDesglose.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
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

procedure TFArticuloDesglose.QueryCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('descripProducto').AsString:=
    desProducto( '', DataSet.FieldByName('producto_desglose_ad').AsString );
end;

end.
