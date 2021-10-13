unit EnvSeccionesContables;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, nbEdits, nbLabels,
  ExtCtrls, Buttons, ActnList, ComCtrls, ToolWin, DBCtrls, BSpeedButton,
  BGridButton, BEdit, BDEdit, BGrid;

type
  TFEnvSeccionesContables = class(TForm)
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
    centro_esc: TBDEdit;
    btnCentro: TBGridButton;
    txtCentro: TStaticText;
    seccion_esc: TBDEdit;
    btnSeccion: TBGridButton;
    txtSeccion: TStaticText;
    lblCodigo1: TnbLabel;
    lblCodigo2: TnbLabel;
    strngfldQueryempresa_esc: TStringField;
    strngfldQuerycentro_esc: TStringField;
    strngfldQueryenvase_esc: TStringField;
    strngfldQueryseccion_esc: TStringField;
    strngfldQuerydes_seccion_esc: TStringField;
    lblCodigo3: TnbLabel;
    empresa_esc: TBDEdit;
    lblEmpresa: TnbStaticText;
    procedure empresa_escChange(Sender: TObject);
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
    procedure centro_escChange(Sender: TObject);
    procedure seccion_escChange(Sender: TObject);
    procedure btnCentroClick(Sender: TObject);
    procedure btnSeccionClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure QueryCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    bInsertar: boolean;
    sProducto: string;
    function LoadData: Boolean;
  public
    { Public declarations }
  end;

procedure SeccionesContablesEnvase(const AEnvase, AProducto: string);

implementation

{$R *.dfm}

uses UDMBaseDatos, UDMAuxDB, bSQLUtils, Menus, CAuxiliarDB, CVariables;

procedure SeccionesContablesEnvase(const AEnvase,  AProducto: string);
begin
  with TFEnvSeccionesContables.Create(nil) do
  begin
    envase.Text := AEnvase;
    sProducto:= AProducto;

    if LoadData then
      ShowModal
    else
      Free;
  end;
end;

procedure TFEnvSeccionesContables.empresa_escChange(Sender: TObject);
begin
  lblEmpresa.Caption := desEmpresa(empresa_esc.Text);
end;

procedure TFEnvSeccionesContables.envaseChange(Sender: TObject);
begin
  lblEnvase.Caption := desEnvase(empresa_esc.Text, envase.Text);
end;

procedure TFEnvSeccionesContables.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Query.Close;
  Action := caFree;
end;

function TFEnvSeccionesContables.LoadData: Boolean;
begin
  result := false;
  if not Query.Active then
  begin
    Query.SQl.Clear;
    Query.SQl.Add('Select * from frf_env_sec_contables');
    Query.SQl.Add('where envase_esc ' + SQLEqualS(envase.Text));

    result := OpenQuery(Query);
  end;
end;

procedure TFEnvSeccionesContables.AAnyadirExecute(Sender: TObject);
begin
  empresa_esc.Enabled := true;
  centro_esc.Enabled := true;
  seccion_esc.Enabled := true;
  empresa_esc.SetFocus;
  Query.Insert;
  DBGrid.Top := 187;
  DBGrid.Height := 155;
  DBGrid.Enabled:= False;

  bInsertar:= true;
end;

procedure TFEnvSeccionesContables.ABorrarExecute(Sender: TObject);
begin
  Query.Delete;
end;

procedure TFEnvSeccionesContables.AModificarExecute(Sender: TObject);
begin
  empresa_esc.Enabled := true;
  centro_esc.Enabled := true;
  seccion_esc.Enabled := true;
  centro_esc.SetFocus;
  Query.Edit;
  DBGrid.Top := 187;
  DBGrid.Height := 155;
  DBGrid.Enabled:= False;

  bInsertar:= False;
end;

procedure TFEnvSeccionesContables.AAceptarExecute(Sender: TObject);
begin
  Query.Post;
  Query.Close;
  Query.Open;
  empresa_esc.Enabled := false;
  centro_esc.Enabled := false;
  seccion_esc.Enabled := false;
  DBGrid.Top := 80;
  DBGrid.Height := 249;
  DBGrid.Enabled:= True;
end;

procedure TFEnvSeccionesContables.ACancelarExecute(Sender: TObject);
begin
  Query.Cancel;
  empresa_esc.Enabled := false;
  centro_esc.Enabled := false;
  seccion_esc.Enabled := false;
  DBGrid.Top := 80;
  DBGrid.Height := 249;
  DBGrid.Enabled:= True;
end;

procedure TFEnvSeccionesContables.ACerrarExecute(Sender: TObject);
begin
  Close;
end;

procedure TFEnvSeccionesContables.ActionListUpdate(Action: TBasicAction;
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

procedure TFEnvSeccionesContables.FormCreate(Sender: TObject);
begin
  bInsertar:= true;

  DBGrid.Top := 80;
  DBGrid.Height := 249;

  ABorrar.ShortCut := ShortCut(VK_SUBTRACT, []);
  AAnyadir.ShortCut := ShortCut(VK_ADD, []);
  AModificar.ShortCut := ShortCut(Word('M'), []);
  AAceptar.ShortCut := ShortCut(VK_F1, []);

  empresa_esc.Tag:= kEmpresa;
  centro_esc.Tag:= kCentro;
  seccion_esc.Tag:= kSeccionContable;

end;

procedure TFEnvSeccionesContables.QueryBeforePost(DataSet: TDataSet);
begin
  Query.FieldByName('envase_esc').AsString := envase.Text;
end;

procedure TFEnvSeccionesContables.centro_escChange(Sender: TObject);
begin
  txtCentro.Caption:= desCentro( empresa_esc.Text, centro_esc.Text );
end;

procedure TFEnvSeccionesContables.seccion_escChange(Sender: TObject);
begin
  txtSeccion.Caption:= desSeccionContable( empresa_esc.Text, seccion_esc.Text );
end;

procedure TFEnvSeccionesContables.btnCentroClick(Sender: TObject);
begin
  DespliegaRejilla(btnCentro, [empresa_esc.Text]);
end;

procedure TFEnvSeccionesContables.btnSeccionClick(Sender: TObject);
begin
  DespliegaRejilla(btnSeccion, [empresa_esc.Text]);
end;

procedure TFEnvSeccionesContables.FormKeyDown(Sender: TObject;
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

procedure TFEnvSeccionesContables.QueryCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('des_seccion_esc').AsString:=
    desSeccionContable( DataSet.FieldByName('empresa_esc').AsString,
                        DataSet.FieldByName('seccion_esc').AsString )
end;

end.
