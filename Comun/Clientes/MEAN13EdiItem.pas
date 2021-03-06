unit MEAN13EdiItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlue,
  dxSkinBlueprint, dxSkinFoggy, dxSkinMoneyTwins, Menus, ActnList, Mask, DBCtrls, StdCtrls, cxButtons, SimpleSearch,
  cxTextEdit, cxDBEdit, BEdit, BDEdit, Buttons, BSpeedButton, BGridButton, ExtCtrls, DB,
  Grids, DBGrids, BGrid, dxSkinBlack, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TFMEAN13EdiItem = class(TForm)
    btCancelar: TcxButton;
    DS: TDataSource;
    LCodigo_e: TLabel;
    LEnvase_e: TLabel;
    LEmpresa_e: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    lblDun14: TLabel;
    BGBEan13_ee: TBGridButton;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ean13_ee: TBDEdit;
    descripcion_ee: TBDEdit;
    fecha_baja_ee: TBDEdit;
    dun14_ee: TBDEdit;
    envase_ee: TcxDBTextEdit;
    ssEnvase: TSimpleSearch;
    dbeProducto: TDBEdit;
    dbeProductoDescripcion: TDBEdit;
    DBEdit3: TDBEdit;
    dbeEmpresaDescripcion: TDBEdit;
    dbeComercialDescripcion: TDBEdit;
    dbeCentroDescripcion: TDBEdit;
    ssCentro: TSimpleSearch;
    dbeCentro: TcxDBTextEdit;
    ssComercial: TSimpleSearch;
    dbeComercial: TcxDBTextEdit;
    ssEmpresa: TSimpleSearch;
    dbeEmpresa: TcxDBTextEdit;
    ActionList: TActionList;
    ACancelar: TAction;
    AAceptar: TAction;
    btAceptar: TcxButton;
    RejillaFlotante: TBGrid;
    procedure btCancelarClick(Sender: TObject);
    procedure btAceptarClick(Sender: TObject);
    procedure ssCentroAntesEjecutar(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ean13_eeKeyPress(Sender: TObject; var Key: Char);
    procedure envase_eeExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BGBEan13_eeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    FDataset: TDataset;

    procedure SetDataset(const Value: TDataset);

  public

    property Dataset: TDataset read FDataset write SetDataset;
  end;

var
  FMEAN13EdiItem: TFMEAN13EdiItem;

implementation

uses
  bCodeUtils,
  bTextUtils,
  cVariables, cAuxiliarDB;

{$R *.dfm}

procedure TFMEAN13EdiItem.BGBEan13_eeClick(Sender: TObject);
begin
  if ean13_ee.Focused then
    DespliegaRejilla( BGBEan13_ee, [dbeEmpresa.Text, envase_ee.Text] );
end;

procedure TFMEAN13EdiItem.btAceptarClick(Sender: TObject);
begin
  // Empresa
  dbeEmpresa.PostEditValue;
  if Trim(DS.Dataset.FieldByName('empresa_ee').asString) = '' then
  begin
    dbeEmpresa.SetFocus;
    Exit;
  end;
  // Cliente

  // Envase
  envase_ee.PostEditValue;
  if Trim(DS.Dataset.FieldByName('envase_ee').asString) = '' then
  begin
    envase_ee.SetFocus;
    Exit;
  end;

  // ean
  if Trim(ean13_ee.Text) = '' then
  begin
    ean13_ee.SetFocus;
    Exit;
  end;

  if Length(ean13_ee.Text) <> 13 then
  begin
    ean13_ee.SetFocus;
    ShowMessage('Longitud para C?digo EAN13 no v?lido. Debe tener 13 d?gitos.');
    Exit
  end;

{
    //Codigo ean 13 valido
  if DigitoControlEAN13(ean13_ee.Text) = False then
  begin
    ean13_ee.SetFocus;
    ShowMessage('C?digo EAN13 no v?lido.');
    Exit
  end;
 }

  // Descripcion
  if Trim(descripcion_ee.Text) = '' then
  begin
    descripcion_ee.SetFocus;
    Exit;
  end;


  ModalResult := mrOk;
end;

procedure TFMEAN13EdiItem.btCancelarClick(Sender: TObject);
var
  resp: integer;
begin
  if DS.State in dsEditModes then
  begin
    resp := MessageBox(Self.Handle, PChar('?Desea guardar los cambios realizados?'), PChar(Self.Caption),
      MB_ICONQUESTION + MB_YESNOCANCEL + MB_DEFBUTTON2);

    if resp = ID_YES then
      ModalResult := mrOk
    else if resp = ID_NO then
      ModalResult := mrCancel;
  end
  else
    ModalResult := mrCancel;
end;

procedure TFMEAN13EdiItem.ean13_eeKeyPress(Sender: TObject; var Key: Char);
begin
{
  if ((key < '0') or (key > '9')) and (key <> char(vk_back)) then
  begin
    Key := char(0);
  end;
}
end;

procedure TFMEAN13EdiItem.envase_eeExit(Sender: TObject);
begin
  if DS.State in dsEditModes then
    if EsNumerico(envase_ee.Text) and (Length(envase_ee.Text) <= 5) then
      if (envase_ee.Text <> '' ) and (Length(envase_ee.Text) < 9) then
      begin
        envase_ee.Text := 'COM-' + Rellena( envase_ee.Text, 5, '0');
        envase_ee.PostEditValue;
        DS.Dataset.FieldByName('empresa_ee').asstring := dbeProducto.Text;
      end;
end;

procedure TFMEAN13EdiItem.FormCreate(Sender: TObject);
begin
  ean13_ee.Tag := kEan13Envase;
end;

procedure TFMEAN13EdiItem.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFMEAN13EdiItem.FormShow(Sender: TObject);
begin
  envase_ee.SetFocus;
end;

procedure TFMEAN13EdiItem.SetDataset(const Value: TDataset);
begin
  FDataset := Value;
  DS.DataSet := FDataset;
end;

procedure TFMEAN13EdiItem.ssCentroAntesEjecutar(Sender: TObject);
begin
  ssCentro.SQLAdi := 'empresa_c = ' + QuotedStr(DS.Dataset.FieldByName('empresa_ee').asstring);
end;

end.
