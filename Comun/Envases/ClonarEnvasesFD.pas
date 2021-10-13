unit ClonarEnvasesFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBTables, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit, BGrid, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlueprint,
  dxSkinFoggy, Menus, cxButtons, SimpleSearch, cxTextEdit, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TFDClonarEnvases = class(TForm)
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
    lbl1: TLabel;
    lbl2: TLabel;
    btn1: TBGridButton;
    edt_producto: TBEdit;
    txtProducto2: TStaticText;
    txtDesEnvase: TStaticText;
    lblNuevo: TLabel;
    chkBaja: TCheckBox;
    envase_e: TcxTextEdit;
    ssEnvase: TSimpleSearch;
    edt_envase: TcxTextEdit;
    ssEnvase2: TSimpleSearch;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure producto_eChange(Sender: TObject);
    procedure envase_eChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edt_productoChange(Sender: TObject);
    procedure edt_envaseChange(Sender: TObject);
    procedure envase_eExit(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
    procedure edt_envaseExit(Sender: TObject);
    procedure ssEnvase2AntesEjecutar(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sProducto, sEnvase, sNewProducto, sNewEnvase: string;
    sBDRemota: string;

    procedure ParamToEdit( const AEmpresa, AProducto, AEnvase: string );
    function  ValidarParams: Boolean;
    procedure VarToParam( var VEmpresa, VProducto, VEnvase: string );
    function  ClonarEnvase: boolean;
    procedure LoadQuerys;
    procedure LoadMemos;


  public
    { Public declarations }
  end;

  function ClonarEnvase( var VEmpresa, VProducto, VEnvase: string ): Integer;



implementation

{$R *.dfm}

uses
  CVariables, CAuxiliarDB, UDMAuxDB, AdvertenciaFD, ClonarEnvasesMD, bTextUtils;

var
  FDClonarEnvases: TFDClonarEnvases;

(*
   RESULT
   -1 -> no quiero Clonar ningun envase, cancelar
   0  -> envase importado correctamente
   >0 -> error en la importacion
*)
function ClonarEnvase( var VEmpresa, VProducto, VEnvase: string ): Integer;
begin
  Application.CreateForm(TFDClonarEnvases, FDClonarEnvases);
  try
    FDClonarEnvases.ParamToEdit( VEmpresa, VProducto, VEnvase );
    FDClonarEnvases.ClonarEnvase;
    Result:= FDClonarEnvases.ShowModal;
    FDClonarEnvases.VarToParam( VEmpresa, VProducto, VEnvase );
  finally
    FreeAndNil( FDClonarEnvases );
  end;
end;

procedure TFDClonarEnvases.FormCreate(Sender: TObject);
begin
  envase_e.Tag := kEnvase;
  edt_envase.Tag := kEnvase;
  producto_e.Tag := kProducto;
  edt_producto.Tag := kProducto;
  chkBaja.State:= cbGrayed;
end;


procedure TFDClonarEnvases.ParamToEdit( const AEmpresa, AProducto, AEnvase: string );
var
  i: Integer;
  sAux: string;
begin
  producto_e.Text:= AProducto;
  envase_e.Text:= AEnvase;
  sEmpresa:= gsDefEmpresa;
  sProducto:= Trim( producto_e.Text );
  sEnvase:= Trim( envase_e.Text );
  chkBaja.Caption:= 'Dar de baja el artículo "' + AEnvase + '"';
{
  DMAuxDB.QAux.SQL.Clear;
  DMAuxDB.QAux.SQL.Add('select envase_e from frf_envases where empresa_e = :empresa ');
  DMAuxDB.QAux.ParamByName('empresa').AsString:= AEmpresa;
  DMAuxDB.QAux.Open;
  for i := 1 to 999 do
  begin
    sAux:= FormatFloat('000',i);
    if not DMAuxDB.QAux.Locate('envase_e',sAux, [] ) then
      edt_envase.Items.Add(sAux)
  end;
  DMAuxDB.QAux.Close;
}
end;

procedure TFDClonarEnvases.VarToParam( var VEmpresa, VProducto, VEnvase: string );
begin
  VEmpresa:= sEmpresa;
  VProducto:= sNewProducto;
  VEnvase:= sNewEnvase;
end;

function  TFDClonarEnvases.ValidarParams: Boolean;
begin
  Result:= False;
  if chkBaja.State = cbGrayed then
  begin
    ShowMessage('Se tiene que marcar la casilla de selección para dar de baja el artículo o desmarcar para manterlo.');
  end
  else
  if  ( txtProducto.Caption = '' ) then
  begin
    ShowMessage('Falta el código de producto o es  incorrecto.');
  end
  else
  if ( Length( edt_envase.Text ) <> 3 )  then
  begin
    ShowMessage('El código del artículo tiene que tener 3 digitos.');
  end
  else
  if ( txtDesEnvase.Caption <> '' )  then
  begin
    ShowMessage('El código del artículo nuevo ya ha sido utilizado.');
  end
  else
  if ( envase_e.Text = edt_envase.Text ) then
  begin
    ShowMessage('El código del artículo inicial no puede ser igual al nuevo.');
  end
  else
  begin
    sNewProducto:= Trim( edt_producto.Text );
    sNewEnvase:= Trim( edt_envase.Text );
    Result:= True;
  end;
end;


procedure TFDClonarEnvases.btnAceptarClick(Sender: TObject);
var
  sMsg: string;
begin
  if ValidarParams then
  begin
    if ClonarEnvasesMD.ClonarEnvase( sEmpresa, sProducto, sEnvase, sNewProducto, sNewEnvase, chkBaja.Checked, sMsg ) then
    begin
      ModalResult:= 1;
    end
    else
    begin
      ShowMessage( sMsg );
    end;
  end;
end;

procedure TFDClonarEnvases.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= -1;
end;

procedure TFDClonarEnvases.LoadQuerys;
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
    SQL.Add('where empresa_ce = :empresa ');
    SQL.Add('and envase_ce = :envase ');
    if sProducto <> '' then
      SQL.Add('and producto_ce = :producto ');
  end;
  with qryEan do
  begin
    SQL.Clear;
    SQL.Add('select codigo_e codigo, marca_e marca, categoria_e categoria, calibre_e, descripcion_e descripcion   ');

    SQL.Add('from frf_ean13 ');
    SQL.Add('where empresa_e = :empresa ');
    SQL.Add('and envase_e = :envase ');
    if sProducto <> '' then
      SQL.Add('and producto_e = :producto ');
   SQL.Add('order by 1,2,3,4,5 ');
  end;
end;

function TFDClonarEnvases.ClonarEnvase: Boolean;
begin
  LoadQuerys;
  qryEnvases.ParamByName('empresa').AsString:= sEmpresa;
  qryEnvases.ParamByName('envase').AsString:= sEnvase;
  if sProducto <> '' then
    qryEnvases.ParamByName('producto').AsString:= sProducto;
  qryEnvases.Open;
  if qryEnvases.IsEmpty then
  begin
    Result:= False;
    ShowMessage('NO encontrado envase en la BD Remota');
  end
  else
  begin
    LoadMemos;
    qryEnvClientes.ParamByName('empresa').AsString:= sEmpresa;
    qryEnvClientes.ParamByName('envase').AsString:= sEnvase;
    if sProducto <> '' then
      qryEnvClientes.ParamByName('producto').AsString:= sProducto;
    qryEnvClientes.Open;

    qryEan.ParamByName('empresa').AsString:= sEmpresa;
    qryEan.ParamByName('envase').AsString:= sEnvase;
    if sProducto <> '' then
      qryEan.ParamByName('producto').AsString:= sProducto;
    qryEan.Open;

    Result:= True;
  end;
end;

procedure TFDClonarEnvases.LoadMemos;
var
  i: Integer;
begin
  mmoIzq.Clear;
  mmoDer.Clear;
  mmoIzq.Font.Style:= mmoIzq.Font.Style + [fsBold];
  i:= 0;
  while i < qryEnvases.Fields.Count do
  begin
    mmoIzq.Lines.Add( UpperCase(qryEnvases.Fields[i].FieldName) );
    mmoDer.Lines.Add( qryEnvases.Fields[i].AsString );
    inc( i );
  end;
end;

procedure TFDClonarEnvases.producto_eChange(Sender: TObject);
begin
  txtProducto.Caption := desProducto(gsDefEmpresa, producto_e.Text);
end;

procedure TFDClonarEnvases.ssEnvase2AntesEjecutar(Sender: TObject);
begin
    ssEnvase2.SQLAdi := '';
    if edt_producto.Text <> '' then
      ssEnvase2.SQLAdi := ' producto_e = ' +  QuotedStr(edt_producto.Text);
end;

procedure TFDClonarEnvases.ssEnvaseAntesEjecutar(Sender: TObject);
begin
    ssEnvase.SQLAdi := '';
    if producto_e.Text <> '' then
      ssEnvase.SQLAdi := ' producto_e = ' +  QuotedStr(producto_e.Text);
end;

procedure TFDClonarEnvases.envase_eChange(Sender: TObject);
begin
  txtEnvase.Caption := desEnvase(gsDefEmpresa, envase_e.Text);
end;

procedure TFDClonarEnvases.envase_eExit(Sender: TObject);
begin
  if EsNumerico(envase_e.Text) and (Length(envase_e.Text) <= 5) then
    if (envase_e.Text <> '' ) and (Length(envase_e.Text) < 9) then
      envase_e.Text := 'COM-' + Rellena( envase_e.Text, 5, '0');

end;

procedure TFDClonarEnvases.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (bgrdRejillaFlotante.Visible) then
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

procedure TFDClonarEnvases.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryEnvases.Close;
  qryEnvClientes.Close;
  qryEan.Close;
end;

procedure TFDClonarEnvases.edt_productoChange(Sender: TObject);
begin
  txtProducto.Caption:= desProducto( gsDefEmpresa, edt_producto.Text );
end;

procedure TFDClonarEnvases.edt_envaseChange(Sender: TObject);
begin
  txtDesEnvase.Caption:= desEnvase( gsDefEmpresa, edt_envase.Text );
end;

procedure TFDClonarEnvases.edt_envaseExit(Sender: TObject);
begin
  if EsNumerico(edt_envase.Text) and (Length(edt_envase.Text) <= 5) then
    if (edt_envase.Text <> '' ) and (Length(edt_envase.Text) < 9) then
      edt_envase.Text := 'COM-' + Rellena( edt_envase.Text, 5, '0');

end;

end.
