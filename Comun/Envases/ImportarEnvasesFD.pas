unit ImportarEnvasesFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBTables, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit, BGrid, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlue,
  dxSkinBlueprint, dxSkinFoggy, dxSkinMoneyTwins, Menus, cxButtons, SimpleSearch,
  cxTextEdit, dxSkinBlack, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TFDImportarEnvases = class(TForm)
    btnImportar: TButton;
    btnAceptar: TButton;
    qryEnvases: TQuery;
    btnCancelar: TButton;
    bgrdRejillaFlotante: TBGrid;
    LEnvase_e: TLabel;
    lblNombre7: TLabel;
    producto_e: TBEdit;
    btnProducto: TBGridButton;
    txtProducto: TStaticText;
    txtEnvase: TStaticText;
    dbgrdEnvClientes: TDBGrid;
    qryEnvClientes: TQuery;
    dsEnvClientes: TDataSource;
    mmoIzq: TMemo;
    mmoDer: TMemo;
    dbgrdEan: TDBGrid;
    qryEan: TQuery;
    dsEan: TDataSource;
    envase_e: TcxTextEdit;
    ssEnvase: TSimpleSearch;
    procedure btnImportarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure producto_eChange(Sender: TObject);
    procedure envase_eChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure envase_eExit(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
  private
    { Private declarations }
    bAlta: boolean;
    sProducto, sEnvase: string;
    sBDRemota: string;
    procedure PutBaseDatosRemota(const BDRemota: string);
    procedure ParamToEdit(const AProducto, AEnvase: string; const AAlta: boolean);
    function EditToVar: Boolean;
    procedure VarToParam(var VProducto, VEnvase: string; var VAlta: boolean);
    procedure PreparaEntorno;
    function ImportarEnvase: boolean;
    procedure LoadQuerys;
    function CambioDeEstado(const ANew: Boolean): Boolean;
    procedure LoadMemos;
  public
    { Public declarations }
  end;

function ImportarEnvase(const AOwner: TComponent; const BDRemota: string; var VProducto, VEnvase: string; var VAlta: boolean): Integer;

implementation

{$R *.dfm}

uses
  CVariables, CAuxiliarDB, UDMAuxDB, AdvertenciaFD, ImportarEnvasesMD,
  bTextUtils;

var
  FDImportarEnvases: TFDImportarEnvases;

(*
   RESULT
   -1 -> no quiero importar ningun envase, cancelar
   0  -> envase importado correctamente
   >0 -> error en la importacion
*)
function ImportarEnvase(const AOwner: TComponent; const BDRemota: string; var VProducto, VEnvase: string; var VAlta: Boolean): Integer;
begin

  FDImportarEnvases := TFDImportarEnvases.Create(AOwner);
  try
    FDImportarEnvases.PutBaseDatosRemota(BDRemota);
    FDImportarEnvases.ParamToEdit(VProducto, VEnvase, VAlta);
    FDImportarEnvases.PreparaEntorno;
    Result := FDImportarEnvases.ShowModal;
    FDImportarEnvases.VarToParam(VProducto, VEnvase, VAlta);
  finally
    FreeAndNil(FDImportarEnvases);
  end;
end;

procedure TFDImportarEnvases.FormCreate(Sender: TObject);
begin
  envase_e.Tag := kEnvase;
  producto_e.Tag := kProducto;
end;

procedure TFDImportarEnvases.PutBaseDatosRemota(const BDRemota: string);
begin
  sBDRemota := BDRemota;
  qryEnvases.DatabaseName := sBDRemota;
  qryEnvClientes.DatabaseName := sBDRemota;
  qryEan.DatabaseName := sBDRemota;
end;

procedure TFDImportarEnvases.ssEnvaseAntesEjecutar(Sender: TObject);
begin
  ssEnvase.SQLAdi := '';
  if producto_e.Text <> '' then
    ssEnvase.SQLAdi := ' producto_e = ' + QuotedStr(producto_e.Text);
end;

procedure TFDImportarEnvases.ParamToEdit(const AProducto, AEnvase: string; const AAlta: boolean);
begin
  producto_e.Text := AProducto;
  envase_e.Text := AEnvase;
  bAlta := AAlta;
end;

procedure TFDImportarEnvases.VarToParam(var VProducto, VEnvase: string; var VAlta: boolean);
begin
  VProducto := sProducto;
  VEnvase := sEnvase;
  VAlta := bAlta;
end;

function TFDImportarEnvases.EditToVar: Boolean;
var
  bAux: Boolean;
begin
  if (producto_e.Text <> '') and (txtProducto.Caption = '') then
  begin
    ShowMessage('Código de producto incorrecto.');
    Result := False;
  end
  else if (envase_e.Text = '') then
  begin
    ShowMessage('Falta el código del artículo.');
    Result := False;
  end
  else
  begin

    //Hay cambio de estado

    bAux := txtEnvase.Caption = '';
    if bAux <> bAlta then
      Result := CambioDeEstado(bAux)
    else
      Result := True;
    if Result then
    begin
      sProducto := Trim(producto_e.Text);
      sEnvase := Trim(envase_e.Text);
    end;
  end;
end;

function TFDImportarEnvases.CambioDeEstado(const ANew: Boolean): Boolean;
begin
  //Pasa a alta
  if ANew then
  begin
    Result := AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: El artículo elegido no esta en la Base de Datos de origen', 'CAMBIO DE ESTADO A ALTA', 'Confirmo que quiero dar de alta el nuevo envase', 'Cambiar a ALTA') = mrIgnore;
    if Result then
    begin
      bAlta := ANew;
      btnAceptar.Caption := 'Insertar';
    end;
  end
  else
  //Pasa a modificar
  begin
    Result := AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: El artículo elegido ya existe en la Base de Datos de origen', 'CAMBIO DE ESTADO A ACTUALIZAR', 'Confirmo que quiero actualizar el artículo existente', 'Cambiar a ACTUALIZAR') = mrIgnore;
    if Result then
    begin
      bAlta := ANew;
      btnAceptar.Caption := 'Actualizar';
    end;
  end;
end;

procedure TFDImportarEnvases.PreparaEntorno;
begin
  btnImportar.Enabled := True;

  producto_e.Enabled := bAlta;
  btnProducto.Enabled := bAlta;
  envase_e.Enabled := bAlta;

  if bAlta then
  begin
    btnAceptar.Caption := 'Insertar';
    btnAceptar.Enabled := False;
  end
  else
  begin
    btnAceptar.Caption := 'Actualizar';
    btnAceptar.Enabled := False;
  end;
end;

procedure TFDImportarEnvases.btnImportarClick(Sender: TObject);
begin
  if EditToVar then
  begin
    btnAceptar.Enabled := ImportarEnvase;
  end
  else
  begin
    btnAceptar.Enabled := False;
  end;
end;

procedure TFDImportarEnvases.btnAceptarClick(Sender: TObject);
var
  sMsg: string;
begin
  if ImportarEnvasesMD.SincronizarEnvase(Self, sBDRemota, sProducto, sEnvase, bAlta, sMsg) then
  begin
    ModalResult := 1;
  end
  else
  begin
    ShowMessage(sMsg);
  end;
end;

procedure TFDImportarEnvases.btnCancelarClick(Sender: TObject);
begin
  ModalResult := -1;
end;

procedure TFDImportarEnvases.LoadQuerys;
begin
  with qryEnvases do
  begin
    SQL.Clear;
    SQL.Add('select producto_e producto, ');
    SQL.Add('       envase_e codigo, descripcion_e descripcion, ean13_e ean13, ');
    SQL.Add('       peso_envase_e peso_envase, peso_neto_e peso_fruta, ');
    SQL.Add('       case when peso_variable_e = 0 then ''No'' else ''Si'' end peso_variable, ');
    SQL.Add('       unidades_e, unidades_variable_e,  tipo_unidad_e, ');
    SQL.Add('       agrupacion_e, agrupa_comercial_e, linea_producto_e, ');
    SQL.Add('       env_comer_operador_e,  env_comer_producto_e, ');
    SQL.Add('       tipo_iva_e, fecha_baja_e ');
    SQL.Add('from frf_envases ');
    SQL.Add('where envase_e = :envase ');
    if sProducto <> '' then
      SQL.Add('and producto_e = :producto ');
  end;
  with qryEnvClientes do
  begin
    SQL.Clear;
    SQL.Add('select cliente_ce cliente, nombre_c nombre,');
    SQL.Add('       unidad_fac_ce factura_por, descripcion_ce descripcion_envase, variedad_ce variedad_envase, ');
    SQL.Add('       n_palets_ce palets, kgs_palet_ce kilos_palet');
    SQL.Add('from frf_clientes_env join frf_clientes on cliente_c = cliente_ce ');
    SQL.Add('where envase_ce = :envase ');
    if sProducto <> '' then
      SQL.Add('and producto_ce = :producto ');
  end;
  with qryEan do
  begin
    SQL.Clear;
    SQL.Add('select codigo_e codigo, marca_e marca, categoria_e categoria, calibre_e, descripcion_e descripcion   ');

    SQL.Add('from frf_ean13 ');
    SQL.Add('where envase_e = :envase ');
    if sProducto <> '' then
      SQL.Add('and productop_e = :producto ');
    SQL.Add('order by 1,2,3,4,5 ');
  end;
end;

function TFDImportarEnvases.ImportarEnvase: Boolean;
begin
  LoadQuerys;
  qryEnvases.ParamByName('envase').AsString := sEnvase;
  if sProducto <> '' then
    qryEnvases.ParamByName('producto').AsString := sProducto;
  qryEnvases.Open;
  if qryEnvases.IsEmpty then
  begin
    Result := False;
    ShowMessage('NO encontrado envase en la BD Remota');
  end
  else
  begin
    LoadMemos;
    qryEnvClientes.ParamByName('envase').AsString := sEnvase;
    if sProducto <> '' then
      qryEnvClientes.ParamByName('producto').AsString := sProducto;
    qryEnvClientes.Open;

    qryEan.ParamByName('envase').AsString := sEnvase;
    if sProducto <> '' then
      qryEan.ParamByName('producto').AsString := sProducto;
    qryEan.Open;

    Result := True;
  end;
end;

procedure TFDImportarEnvases.LoadMemos;
var
  i: Integer;
begin
  mmoIzq.Clear;
  mmoDer.Clear;
  mmoIzq.Font.Style := mmoIzq.Font.Style + [fsBold];
  i := 0;
  while i < qryEnvases.Fields.Count do
  begin
    mmoIzq.Lines.Add(UpperCase(qryEnvases.Fields[i].FieldName));
    mmoDer.Lines.Add(qryEnvases.Fields[i].AsString);
    inc(i);
  end;
end;

procedure TFDImportarEnvases.producto_eChange(Sender: TObject);
begin
  txtProducto.Caption := desProducto(gsDefEmpresa, producto_e.Text);
end;

procedure TFDImportarEnvases.envase_eChange(Sender: TObject);
begin
  txtEnvase.Caption := desEnvase(gsdefEmpresa, envase_e.Text);
end;

procedure TFDImportarEnvases.envase_eExit(Sender: TObject);
begin
  if EsNumerico(envase_e.Text) and (Length(envase_e.Text) <= 5) then
    if (envase_e.Text <> '') and (Length(envase_e.Text) < 9) then
      envase_e.Text := 'COM-' + Rellena(envase_e.Text, 5, '0');
end;

procedure TFDImportarEnvases.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (bgrdRejillaFlotante.Visible) then
           //No hacemos nada
    Exit;

  case Key of
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

procedure TFDImportarEnvases.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryEnvases.Close;
  qryEnvClientes.Close;
  qryEan.Close;
end;

end.

