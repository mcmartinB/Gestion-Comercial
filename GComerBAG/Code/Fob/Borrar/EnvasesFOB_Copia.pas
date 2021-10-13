unit EnvasesFOB_Copia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Provider, DB, DBClient, DBTables, Grids,
  DBGrids, EnvasesFOBData, ActnList, ComCtrls, BCalendario, BGrid, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, nbEdits, nbCombos, nbButtons,
  ExtCtrls;

type
  TFEnvasesFob_Copia = class(TForm)
    btnCancel: TBitBtn;
    btnOk: TBitBtn;
    Lcategoria: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Desde: TLabel;
    Label14: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    STEmpresa: TStaticText;
    STProducto: TStaticText;
    cbxNacionalidad: TComboBox;
    empresa: TnbDBSQLCombo;
    producto: TnbDBSQLCombo;
    centroDesde: TnbDBSQLCombo;
    centroHasta: TnbDBSQLCombo;
    clienteDesde: TnbDBSQLCombo;
    clienteHasta: TnbDBSQLCombo;
    fechaDesde: TnbDBCalendarCombo;
    fechaHasta: TnbDBCalendarCombo;
    pais: TnbDBSQLCombo;
    cbxJuntarTE: TnbCheckBox;
    categoria: TnbDBAlfa;
    Label8: TLabel;
    Label9: TLabel;
    subPanel: TPanel;
    Bevel1: TBevel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    cbxEnvase: TCheckBox;
    cbxEnvasado: TCheckBox;
    cbxGasto: TCheckBox;
    cbxNuevo: TCheckBox;
    cbxNo036: TCheckBox;
    cbxAlb6Digitos: TCheckBox;
    Label15: TLabel;
    envase: TnbDBSQLCombo;
    Label16: TLabel;
    cbxVerAlbaran: TCheckBox;
    cbxVerCalibre: TCheckBox;
    lblNombre1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    function productoGetSQL: string;
    function centroDesdeGetSQL: string;
    function clienteDesdeGetSQL: string;
    procedure cbxNacionalidadChange(Sender: TObject);
    procedure cbxNacionalidadKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure empresaChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
    procedure cbxJuntarTEClick(Sender: TObject);
    procedure cbxNuevoClick(Sender: TObject);
    function envaseGetSQL: String;
  private
    { Private declarations }
    DMEnvasesFOBData: TDMEnvasesFOBData;

    procedure Previsualizar;
    procedure Previsualizar3;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses EnvasesFOBReport, EnvasesFOBReport3, UDMConfig,
     DPreview, Principal, CVariables, CGestionPrincipal,
     UDMAuxDB, CReportes, bTimeUtils;

procedure TFEnvasesFob_Copia.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;
  DMEnvasesFOBData := TDMEnvasesFOBData.Create(self);

  empresa.Text := gsDefEmpresa;
  producto.Text := gsDefProducto;
  centroDesde.Text := '1';
  centroHasta.Text := '6';
  fechaDesde.AsDate := Date - 7;
  fechaHasta.AsDate := Date - 1;
  clienteDesde.Text := '0';
  clienteHasta.Text := 'ZZZ';

  if pais.Enabled then
    TEdit(pais).Color := clWhite
  else
    TEdit(pais).Color := clSilver;


  if not DMConfig.EsLaFont then
  begin
    subPanel.Visible:= False;
    Height:= 288;
    cbxNo036.Checked:= False;
    cbxJuntarTE.Checked:= False;
    cbxJuntarTE.Visible:= False;
  end;
end;

procedure TFEnvasesFob_Copia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');

  //Liberamos memoria
  FreeAndNil(DMEnvasesFOBData);
  Action := caFree;
end;

procedure TFEnvasesFob_Copia.btnOkClick(Sender: TObject);
var
  sProducto, sPais: string;
begin
  case cbxNacionalidad.ItemIndex of
    0: sPais := '';
    1: sPais := 'NACIONAL';
    2: sPais := 'EXTRANJERO';
    3: sPais := pais.Text;
  end;

  if cbxJuntarTE.Checked and ((producto.Text = 'E') or (producto.Text = 'T')) then
    sProducto := 'TE'
  else
    sProducto := producto.Text;

    if cbxNuevo.Checked then
    begin
      DMEnvasesFOBData.ClientDataSet.IndexFieldNames:= 'cliente;envase';
    end
    else
    begin
      DMEnvasesFOBData.ClientDataSet.IndexFieldNames:= 'envase;cliente';
    end;

  if DMEnvasesFOBData.ObtenerDatos(empresa.Text, centroDesde.Text, centroHasta.Text, fechaDesde.Text, fechaHasta.Text,
    envase.Text, clienteDesde.Text, clienteHasta.Text, sProducto, sPais, categoria.Text,
    cbxGasto.Checked, cbxNo036.Checked, cbxEnvase.Checked, cbxEnvasado.Checked, cbxAlb6Digitos.Checked,
    cbxVerAlbaran.Checked, cbxVerCalibre.Checked ) then
  begin
    if cbxNuevo.Checked then
    begin
      with DMEnvasesFOBData.ClientDataSet do
      begin
        IndexFieldNames:= '';
        First;
        while not EOF do
        begin
          Edit;
          FieldByName('envase').AsString:= copy( AnyoSemana( FieldByName('fecha').AsDateTime ), 3, 4 );
          Post;
          Next;
        end;
        IndexFieldNames:= 'cliente;envase';
      end;
      //DMEnvasesFOBData.ClientDataSet.Refresh;
      Previsualizar3;
    end
    else
    begin
      Previsualizar;
    end;
  end
  else
  begin
    ShowMessage('Sin Datos.');
  end;
end;

procedure TFEnvasesFob_Copia.Previsualizar;
var
  QREnvasesFOBReport: TQREnvasesFOBReport;
begin
  QREnvasesFOBReport := TQREnvasesFOBReport.Create(Application);
  PonLogoGrupoBonnysa(QREnvasesFOBReport, empresa.Text);
  QREnvasesFOBReport.sEmpresa := empresa.Text;
  QREnvasesFOBReport.bGasto:= cbxGasto.Checked;
  QREnvasesFOBReport.bEnvase:= cbxEnvase.Checked;
  QREnvasesFOBReport.bEnvasado:= cbxEnvasado.Checked;
  QREnvasesFOBReport.bImprimirDetalle:= cbxVerAlbaran.Checked;
  QREnvasesFOBReport.bImprimirCalibre:= cbxVerCalibre.Checked;

  if cbxVerCalibre.Checked and not cbxVerAlbaran.Checked then
  begin
    QREnvasesFOBReport.QRGroup2.Expression:= '[envase]+[cliente]+[calibre]';
  end
  else
  begin
    QREnvasesFOBReport.QRGroup2.Expression:= '[envase]+[cliente]';
  end;

  if centroDesde.Text <> centroHasta.Text then
    QREnvasesFOBReport.LCentro.Caption := 'CENTROS DESDE ' + centroDesde.Text + ' HASTA ' + centroHasta.Text
  else
    QREnvasesFOBReport.LCentro.Caption := centroDesde.Text + ' ' + desCentro(empresa.Text, centroDesde.Text);
  if cbxJuntarTE.Checked and ((producto.Text = 'E') or (producto.Text = 'T')) then
    QREnvasesFOBReport.LProducto.Caption := 'TE TOMATE'
  else
    QREnvasesFOBReport.LProducto.Caption := producto.Text + ' ' + desProducto(empresa.Text, producto.Text);
  QREnvasesFOBReport.LPeriodo.Caption := fechaDesde.Text + ' a ' + fechaHasta.Text;
  if categoria.Text <> '' then
  begin
    case StrToInt(Categoria.Text) of
      1: QREnvasesFOBReport.LCategoria.Caption := 'CATEGORÍA: PRIMERA';
      2: QREnvasesFOBReport.LCategoria.Caption := 'CATEGORÍA: SEGUNDA';
      3: QREnvasesFOBReport.LCategoria.Caption := 'CATEGORÍA: TERCERA';
    else QREnvasesFOBReport.LCategoria.Caption := 'CATEGORÍA: ' + Trim(Categoria.Text);
    end;
  end
  else
  begin
    QREnvasesFOBReport.LCategoria.Caption := 'CATEGORÍA: TODAS';
  end;
  Preview(QREnvasesFOBReport);
end;

procedure TFEnvasesFob_Copia.Previsualizar3;
var
  QREnvasesFOBReport3: TQREnvasesFOBReport3;
begin
  QREnvasesFOBReport3 := TQREnvasesFOBReport3.Create(Application);
  PonLogoGrupoBonnysa(QREnvasesFOBReport3, empresa.Text);
  QREnvasesFOBReport3.sEmpresa := empresa.Text;
  QREnvasesFOBReport3.bGasto:= cbxGasto.Checked;
  QREnvasesFOBReport3.bEnvase:= cbxEnvase.Checked;
  QREnvasesFOBReport3.bEnvasado:= cbxEnvasado.Checked;
  if centroDesde.Text <> centroHasta.Text then
    QREnvasesFOBReport3.LCentro.Caption := 'CENTROS DESDE ' + centroDesde.Text + ' HASTA ' + centroHasta.Text
  else
    QREnvasesFOBReport3.LCentro.Caption := centroDesde.Text + ' ' + desCentro(empresa.Text, centroDesde.Text);
  if cbxJuntarTE.Checked and ((producto.Text = 'E') or (producto.Text = 'T')) then
    QREnvasesFOBReport3.LProducto.Caption := 'TE TOMATE'
  else
    QREnvasesFOBReport3.LProducto.Caption := producto.Text + ' ' + desProducto(empresa.Text, producto.Text);
  QREnvasesFOBReport3.LPeriodo.Caption := fechaDesde.Text + ' a ' + fechaHasta.Text;
  if categoria.Text <> '' then
  begin
    case StrToInt(Categoria.Text) of
      1: QREnvasesFOBReport3.LCategoria.Caption := 'CATEGORÍA: PRIMERA';
      2: QREnvasesFOBReport3.LCategoria.Caption := 'CATEGORÍA: SEGUNDA';
      3: QREnvasesFOBReport3.LCategoria.Caption := 'CATEGORÍA: TERCERA';
    else QREnvasesFOBReport3.LCategoria.Caption := 'CATEGORÍA: ' + Trim(Categoria.Text);
    end;
  end
  else
  begin
    QREnvasesFOBReport3.LCategoria.Caption := 'CATEGORÍA: TODAS';
  end;
  Preview(QREnvasesFOBReport3);
end;

procedure TFEnvasesFob_Copia.btnCancelClick(Sender: TObject);
begin
  Close;
end;

function TFEnvasesFob_Copia.productoGetSQL: string;
begin
  if empresa.Text <> '' then
    result := 'select producto_p, descripcion_p from frf_productos where empresa_p = ' +
      empresa.GetSQLText + ' order by producto_p '
  else
    result := 'select producto_p, descripcion_p from frf_productos order by producto_p ';
end;

function TFEnvasesFob_Copia.centroDesdeGetSQL: string;
begin
  if empresa.Text <> '' then
    result := 'select centro_c, descripcion_c from frf_centros where empresa_c = ' +
      empresa.GetSQLText + ' order by centro_c '
  else
    result := 'select centro_c, descripcion_c from frf_centros order by centro_c ';
end;

function TFEnvasesFob_Copia.envaseGetSQL: String;
begin
  if empresa.Text <> '' then
    result := 'select envase_e, descripcion_e from frf_envases where empresa_e = ' +
      empresa.GetSQLText + ' order by envase_e '
  else
    result := 'select envase_e, descripcion_e from frf_envases order by envase_e ';
end;

function TFEnvasesFob_Copia.clienteDesdeGetSQL: string;
begin
  if empresa.Text <> '' then
    result := 'select cliente_c, nombre_c from frf_clientes where empresa_c = ' +
      empresa.GetSQLText + ' order by cliente_c '
  else
    result := 'select cliente_c, nombre_c from frf_clientes order by cliente_c ';
end;

procedure TFEnvasesFob_Copia.cbxNacionalidadChange(Sender: TObject);
begin
  pais.Enabled := TComboBox(sender).ItemIndex = 3;
  if pais.Enabled then
    TEdit(pais).Color := clWhite
  else
    TEdit(pais).Color := clSilver;
end;

procedure TFEnvasesFob_Copia.cbxNacionalidadKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_return then PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
end;

procedure TFEnvasesFob_Copia.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_f1 then btnOk.Click else
    if Key = vk_escape then btnCancel.Click;
end;

procedure TFEnvasesFob_Copia.empresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(empresa.Text);
end;

procedure TFEnvasesFob_Copia.productoChange(Sender: TObject);
begin
  STProducto.Caption := desProducto(empresa.Text, producto.Text);
end;

procedure TFEnvasesFob_Copia.cbxJuntarTEClick(Sender: TObject);
begin
  if cbxJuntarTE.Checked then
  begin
    cbxEnvasado.Enabled:= False;
    cbxEnvasado.Checked := False;
  end
  else
  begin
    cbxEnvasado.Enabled:= True;
  end;
end;

procedure TFEnvasesFob_Copia.cbxNuevoClick(Sender: TObject);
begin
  if cbxNuevo.Checked then
  begin
    cbxVerAlbaran.Enabled:= False;
    cbxVerAlbaran.Checked:= False;
    cbxVerCalibre.Enabled:= False;
    cbxVerCalibre.Checked:= False;
  end
  else
  begin
    cbxVerAlbaran.Enabled:= True;
    cbxVerCalibre.Enabled:= True;
  end;
end;

end.
