unit EnvasesFOB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Provider, DB, DBClient, DBTables, Grids,
  DBGrids, EnvasesFOBData, ActnList, ComCtrls, BCalendario, BGrid, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, nbEdits, nbCombos, nbButtons,
  ExtCtrls;

type
  TFEnvasesFob = class(TForm)
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
    edtCentroOrigen: TnbDBSQLCombo;
    edtCentroDestino: TnbDBSQLCombo;
    clienteDesde: TnbDBSQLCombo;
    clienteHasta: TnbDBSQLCombo;
    fechaDesde: TnbDBCalendarCombo;
    fechaHasta: TnbDBCalendarCombo;
    pais: TnbDBSQLCombo;
    cbxJuntarTE: TnbCheckBox;
    categoria: TnbDBAlfa;
    Label8: TLabel;
    Label9: TLabel;
    subPanel1: TPanel;
    Bevel1: TBevel;
    Label13: TLabel;
    chkEnvase: TCheckBox;
    chkSecciones: TCheckBox;
    cbxGasto: TCheckBox;
    cbxNo036: TCheckBox;
    Label15: TLabel;
    envase: TnbDBSQLCombo;
    Label16: TLabel;
    lblNombre1: TLabel;
    subPanel2: TPanel;
    Bevel2: TBevel;
    lblNombre5: TLabel;
    cbxAgruparPor: TCheckBox;
    cbxAlb6Digitos: TCheckBox;
    cbxVerAlbaran: TCheckBox;
    cbxVerCalibre: TCheckBox;
    rbAnyoSemana: TRadioButton;
    rbClienteAnyoSemana: TRadioButton;
    lblCentroOrigen: TLabel;
    lblCentroDestino: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    function productoGetSQL: string;
    function edtCentroOrigenGetSQL: string;
    function clienteDesdeGetSQL: string;
    procedure cbxNacionalidadChange(Sender: TObject);
    procedure cbxNacionalidadKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure empresaChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
    procedure cbxJuntarTEClick(Sender: TObject);
    procedure cbxAgruparPorClick(Sender: TObject);
    function envaseGetSQL: String;
    procedure edtCentroOrigenChange(Sender: TObject);
    procedure edtCentroDestinoChange(Sender: TObject);
  private
    { Private declarations }
    DMEnvasesFOBData: TDMEnvasesFOBData;

    procedure Previsualizar;
    procedure Previsualizar3;
    procedure PrevisualizarFOBSemanal;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


uses EnvasesFOBReport, EnvasesFOBReport3, RFOBSemanal, UDMConfig,
     DPreview, Principal, CVariables, CGestionPrincipal,
     UDMAuxDB, CReportes, bTimeUtils;

procedure TFEnvasesFob.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;
  DMEnvasesFOBData := TDMEnvasesFOBData.Create(self);

  empresa.Text := gsDefEmpresa;
  producto.Text := gsDefProducto;
  edtCentroOrigen.Text := gsDefCentro;
  edtCentroOrigenChange( edtCentroOrigen );
  edtCentroDestino.Text := '';
  edtCentroDestinoChange( edtCentroDestino );

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
    subPanel1.Visible:= False;
    subPanel2.Top:= subPanel1.Top;
    Height:= 385;
    cbxNo036.Checked:= False;
    Caption:= '    Listado de Ventas FOB por Envases.';
  end;
end;

procedure TFEnvasesFob.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFEnvasesFob.btnOkClick(Sender: TObject);
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

    if cbxAgruparPor.Checked then
    begin
      if rbAnyoSemana.Checked then
      begin
        DMEnvasesFOBData.ClientDataSet.IndexFieldNames:= 'anyosemana'
      end
      else
      begin
        DMEnvasesFOBData.ClientDataSet.IndexFieldNames:= 'cliente;anyosemana';
      end;
    end
    else
    begin
      DMEnvasesFOBData.ClientDataSet.IndexFieldNames:= 'envase;cliente';
    end;

  if DMEnvasesFOBData.ObtenerDatosInf(empresa.Text, edtCentroOrigen.Text, edtCentroDestino.Text, fechaDesde.Text, fechaHasta.Text,
    envase.Text, clienteDesde.Text, clienteHasta.Text, sProducto, sPais, categoria.Text,
    cbxGasto.Checked, cbxNo036.Checked, chkEnvase.Checked, chkSecciones.Checked, cbxAlb6Digitos.Checked,
    cbxVerAlbaran.Checked, cbxVerCalibre.Checked, cbxAgruparPor.Checked ) then
  begin
    if cbxAgruparPor.Checked then
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
        if rbAnyoSemana.Checked then
          IndexFieldNames:= 'anyosemana'
        else
          IndexFieldNames:= 'cliente;anyosemana';
        First;
      end;
      if rbAnyoSemana.Checked then
        PrevisualizarFOBSemanal
      else
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

procedure TFEnvasesFob.Previsualizar;
var
  QREnvasesFOBReport: TQREnvasesFOBReport;
begin
  QREnvasesFOBReport := TQREnvasesFOBReport.Create(Application);
  PonLogoGrupoBonnysa(QREnvasesFOBReport, empresa.Text);

  if not DMConfig.EsLaFont then
  begin
    QREnvasesFOBReport.lblTitulo.Caption:= 'VENTAS FOB POR ENVASE';
  end;

  QREnvasesFOBReport.sEmpresa := empresa.Text;
  QREnvasesFOBReport.bGasto:= cbxGasto.Checked;
  QREnvasesFOBReport.bEnvase:= chkEnvase.Checked;
  QREnvasesFOBReport.bSecciones:= chkSecciones.Checked;
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


  if edtCentroOrigen.Text = '' then
    QREnvasesFOBReport.qrlOrigen.Caption := 'ORIGEN TODOS LOS CENTROS'
  else
    QREnvasesFOBReport.qrlOrigen.Caption := 'ORIGEN ' + lblCentroOrigen.Caption;

  if edtCentroDestino.Text = '' then
    QREnvasesFOBReport.qrlDestino.Caption := 'DESTINO TODOS LOS CENTROS'
  else
    QREnvasesFOBReport.qrlDestino.Caption := 'DESTINO ' + lblCentroOrigen.Caption;

  if cbxJuntarTE.Checked and ((producto.Text = 'E') or (producto.Text = 'T')) then
    QREnvasesFOBReport.qrlLProducto.Caption := 'TE TOMATE'
  else
    QREnvasesFOBReport.qrlLProducto.Caption := producto.Text + ' ' + desProducto(empresa.Text, producto.Text);
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

procedure TFEnvasesFob.Previsualizar3;
var
  QREnvasesFOBReport3: TQREnvasesFOBReport3;
begin
  QREnvasesFOBReport3 := TQREnvasesFOBReport3.Create(Application);
  PonLogoGrupoBonnysa(QREnvasesFOBReport3, empresa.Text);
  QREnvasesFOBReport3.sEmpresa := empresa.Text;
  QREnvasesFOBReport3.bGasto:= cbxGasto.Checked;
  QREnvasesFOBReport3.bEnvase:= chkEnvase.Checked;
  QREnvasesFOBReport3.bSecciones:= chkSecciones.Checked;

  if edtCentroOrigen.Text = '' then
    QREnvasesFOBReport3.qrlOrigen.Caption := 'ORIGEN TODOS LOS CENTROS'
  else
    QREnvasesFOBReport3.qrlOrigen.Caption := 'ORIGEN ' + lblCentroOrigen.Caption;

  if edtCentroDestino.Text = '' then
    QREnvasesFOBReport3.qrlDestino.Caption := 'DESTINO TODOS LOS CENTROS'
  else
    QREnvasesFOBReport3.qrlDestino.Caption := 'DESTINO ' + lblCentroOrigen.Caption;

  if cbxJuntarTE.Checked and ((producto.Text = 'E') or (producto.Text = 'T')) then
    QREnvasesFOBReport3.qrlLProducto.Caption := 'TE TOMATE'
  else
    QREnvasesFOBReport3.qrlLProducto.Caption := producto.Text + ' ' + desProducto(empresa.Text, producto.Text);
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

procedure TFEnvasesFob.PrevisualizarFOBSemanal;
var
  QRFOBSemanal: TQRFOBSemanal;
begin
  QRFOBSemanal := TQRFOBSemanal.Create(Application);
  PonLogoGrupoBonnysa(QRFOBSemanal, empresa.Text);
  QRFOBSemanal.sEmpresa := empresa.Text;

  if edtCentroOrigen.Text = '' then
    QRFOBSemanal.qrlOrigen.Caption := 'ORIGEN TODOS LOS CENTROS'
  else
    QRFOBSemanal.qrlOrigen.Caption := 'ORIGEN ' + lblCentroOrigen.Caption;

  if edtCentroDestino.Text = '' then
    QRFOBSemanal.qrlDestino.Caption := 'DESTINO TODOS LOS CENTROS'
  else
    QRFOBSemanal.qrlDestino.Caption := 'DESTINO ' + lblCentroOrigen.Caption;

  if cbxJuntarTE.Checked and ((producto.Text = 'E') or (producto.Text = 'T')) then
    QRFOBSemanal.LProducto.Caption := 'TE TOMATE'
  else
    QRFOBSemanal.LProducto.Caption := producto.Text + ' ' + desProducto(empresa.Text, producto.Text);
  QRFOBSemanal.LPeriodo.Caption := fechaDesde.Text + ' a ' + fechaHasta.Text;
  if categoria.Text <> '' then
  begin
    case StrToInt(Categoria.Text) of
      1: QRFOBSemanal.LCategoria.Caption := 'CATEGORÍA: PRIMERA';
      2: QRFOBSemanal.LCategoria.Caption := 'CATEGORÍA: SEGUNDA';
      3: QRFOBSemanal.LCategoria.Caption := 'CATEGORÍA: TERCERA';
    else QRFOBSemanal.LCategoria.Caption := 'CATEGORÍA: ' + Trim(Categoria.Text);
    end;
  end
  else
  begin
    QRFOBSemanal.LCategoria.Caption := 'CATEGORÍA: TODAS';
  end;
  Preview(QRFOBSemanal);
end;

procedure TFEnvasesFob.btnCancelClick(Sender: TObject);
begin
  Close;
end;

function TFEnvasesFob.productoGetSQL: string;
begin
  if empresa.Text <> '' then
    result := 'select producto_p, descripcion_p from frf_productos where empresa_p = ' +
      empresa.GetSQLText + ' order by producto_p '
  else
    result := 'select producto_p, descripcion_p from frf_productos order by producto_p ';
end;

function TFEnvasesFob.edtCentroOrigenGetSQL: string;
begin
  if empresa.Text <> '' then
    result := 'select centro_c, descripcion_c from frf_centros where empresa_c = ' +
      empresa.GetSQLText + ' order by centro_c '
  else
    result := 'select centro_c, descripcion_c from frf_centros order by centro_c ';
end;

function TFEnvasesFob.envaseGetSQL: String;
begin
  if empresa.Text <> '' then
    result := 'select envase_e, descripcion_e from frf_envases where empresa_e = ' +
      empresa.GetSQLText + ' order by envase_e '
  else
    result := 'select envase_e, descripcion_e from frf_envases order by envase_e ';
end;

function TFEnvasesFob.clienteDesdeGetSQL: string;
begin
  if empresa.Text <> '' then
    result := 'select cliente_c, nombre_c from frf_clientes where empresa_c = ' +
      empresa.GetSQLText + ' order by cliente_c '
  else
    result := 'select cliente_c, nombre_c from frf_clientes order by cliente_c ';
end;

procedure TFEnvasesFob.cbxNacionalidadChange(Sender: TObject);
begin
  pais.Enabled := TComboBox(sender).ItemIndex = 3;
  if pais.Enabled then
    TEdit(pais).Color := clWhite
  else
    TEdit(pais).Color := clSilver;
end;

procedure TFEnvasesFob.cbxNacionalidadKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_return then PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
end;

procedure TFEnvasesFob.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_f1 then btnOk.Click else
    if Key = vk_escape then btnCancel.Click;
end;

procedure TFEnvasesFob.empresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(empresa.Text);
end;

procedure TFEnvasesFob.productoChange(Sender: TObject);
begin
  STProducto.Caption := desProducto(empresa.Text, producto.Text);
end;

procedure TFEnvasesFob.cbxJuntarTEClick(Sender: TObject);
begin
  if cbxJuntarTE.Checked then
  begin
    chkSecciones.Enabled:= False;
    chkSecciones.Checked := False;
  end
  else
  begin
    chkSecciones.Enabled:= True;
  end;
end;

procedure TFEnvasesFob.cbxAgruparPorClick(Sender: TObject);
begin
  if cbxAgruparPor.Checked then
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

procedure TFEnvasesFob.edtCentroOrigenChange(Sender: TObject);
begin
  if edtCentroOrigen.Text = '' then
  begin
    lblCentroOrigen.Caption:= 'Vacio todos los centros';
  end
  else
  begin
    lblCentroOrigen.Caption:= desCentro( empresa.Text, edtCentroOrigen.Text);
  end;
end;

procedure TFEnvasesFob.edtCentroDestinoChange(Sender: TObject);
begin
  if edtCentroDestino.Text = '' then
  begin
    lblCentroDestino.Caption:= 'Vacio todos los centros';
  end
  else
  begin
    lblCentroDestino.Caption:= desCentro( empresa.Text, edtCentroOrigen.Text);
  end;
end;

end.
