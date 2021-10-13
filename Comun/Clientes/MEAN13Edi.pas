unit MEAN13Edi;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, Db,
  ExtCtrls, StdCtrls, DBCtrls, Buttons, BSpeedButton,
  DBGrids, BGridButton, BGrid, BDEdit, ComCtrls, Graphics,
  BEdit, DError, ActnList, Grids, DBTables, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlueprint, dxSkinFoggy, Menus, cxButtons, SimpleSearch, cxTextEdit,
  cxDBEdit, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, Mask, dxSkinsdxBarPainter, cxLabel, nbLabels, cxGroupBox, dxBar, cxClasses,

  MEAN13EdiItem;

type
  TFMEAN13Edi = class(TForm)
    RejillaFlotante: TBGrid;
    DS: TDataSource;
    bmxBarManager: TdxBarManager;
    bmxPrincipal: TdxBar;
    dxLocalizar: TdxBarLargeButton;
    dxSalir: TdxBarLargeButton;
    dxAlta: TdxBarLargeButton;
    dxBaja: TdxBarLargeButton;
    pnlConsulta: TPanel;
    gbCriterios: TcxGroupBox;
    stCliente: TnbStaticText;
    cxLabel1: TcxLabel;
    edtCliente: TcxTextEdit;
    ssCliente: TSimpleSearch;
    pnlDatos: TPanel;
    dbgDetalle: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dxSalirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dxLocalizarClick(Sender: TObject);
    procedure pnlConsultaEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtClientePropertiesChange(Sender: TObject);
    procedure dxBajaClick(Sender: TObject);
    procedure dxAltaClick(Sender: TObject);
    procedure dbgDetalleDblClick(Sender: TObject);

  private
    FQuery: TQuery;
    FQueryCli: TQuery;
    FCliente: String;

    FMEAN13EdiItem: TFMEAN13EdiItem;

    procedure CreaQuery;
    procedure CrearCampos(ADataset: TDataset);
    procedure CrearCamposCalculados(ADataset: TDataset);
    procedure CrearCampoCalculado(const NombreCampo: String; Longitud: Integer; ADataset: TDataset);

    function EjecutaQuery: Boolean;
    function ExisteCliente(const CodCliente: String): Boolean;

    procedure CalcCampos(Dataset: TDataset);
    procedure EditarItem;


  protected
    procedure ActivarConsulta(AValor: boolean);
    procedure SincronizarWeb;


  public

  end;

implementation

uses
  Variants,

  UDMAuxDB,
  CVariables,
  CGestionPrincipal,
  UDMBaseDatos,
  bCodeUtils,
  CAuxiliarDB,
  Principal,
  DPreview,
  bSQLUtils,
  CReportes,
  LEAN13Edi,
  bTextUtils,
  SincronizacionBonny;

{$R *.DFM}


procedure TFMEAN13Edi.ActivarConsulta(AValor: boolean);
begin
  pnlConsulta.Enabled := AValor;
  dxLocalizar.Enabled := AValor;
  dxAlta.Enabled := not AValor;
  dxBaja.Enabled := not AValor;

  dbgDetalle.Enabled := not AValor;
end;

procedure TFMEAN13Edi.CalcCampos(Dataset: TDataset);
var
  empresa,
  envase,
  producto: String;
begin
  with Dataset do
  begin
    envase := FieldByName('envase_ee').asString;
    FieldByName('calArticuloDes').asString := DesEnvase('', envase);

    producto := DesProductoEnvase('-', envase);
    FieldByName('calProductoCod').asString := producto;
    FieldByName('calProductoDes').asString := DesProducto('-', producto);

    empresa := FieldByName('empresa_ee').asString;
    FieldByName('calEmpresaDes').asString := DesEmpresa(empresa);
    FieldByName('calComercialDes').asString := DesComercial(FieldByName('comercial_ee').asString);
    FieldByName('calCentroDes').asString := DesCentro(empresa, FieldByName('centro_ee').asString);
  end;
end;

procedure TFMEAN13Edi.CreaQuery;
begin
  // Query principal
  FQuery := TQuery.Create(Self);
  with FQuery do
  begin
    DatabaseName := 'BDProyecto';
    RequestLive := True;

    SQL.Add('select *                                ');
    SQL.Add('  from frf_ean13_edi                    ');
    SQL.Add(' where cliente_fac_ee = :cliente_fac_ee ');
    SQL.Add(' order by envase_ee, empresa_ee         ');

    ParamByName('cliente_fac_ee').DataType := ftString;
    OnCalcFields := CalcCampos;
  end;

  CrearCampos(FQuery);
  CrearCamposCalculados(FQuery);

  // Query auxiliar
  FQueryCli := TQuery.Create(Self);
  with FQueryCli do
  begin
    DatabaseName := 'BDProyecto';
    SQL.Add('select nombre_c               ');
    SQL.Add('  from frf_clientes           ');
    SQL.Add(' where cliente_c = :cliente_c ');

    ParamByName('cliente_c').DataType := ftString;
  end;

end;

procedure TFMEAN13Edi.CrearCampoCalculado(const NombreCampo: String; Longitud: Integer; ADataset: TDataset);
begin
  with TStringField.Create(ADataset) do
  begin
    Calculated := true;
    Name:= ADataset.Name + NombreCampo;
    FieldName:= NombreCampo;
    DataSet := ADataset;
    size := Longitud;
  end;
end;

procedure TFMEAN13Edi.CrearCampos(ADataset: TDataset);
var
  i: integer;
begin
  with ADataset do
  begin
    FieldDefs.Update;
    for i := 0 to FieldDefs.Count - 1 do
      FieldDefs[i].CreateField(ADataset);
  end;
end;

procedure TFMEAN13Edi.CrearCamposCalculados(ADataset: TDataset);
begin
  CrearCampoCalculado('calArticuloDes', 30, ADataset);
  CrearCampoCalculado('calProductoCod', 30, ADataset);
  CrearCampoCalculado('calProductoDes', 30, ADataset);
  CrearCampoCalculado('calEmpresaDes', 30, ADataset);
  CrearCampoCalculado('calComercialDes', 30, ADataset);
  CrearCampoCalculado('calCentroDes', 30, ADataset);
end;

procedure TFMEAN13Edi.dbgDetalleDblClick(Sender: TObject);
begin
  EditarItem;
end;

procedure TFMEAN13Edi.dxAltaClick(Sender: TObject);
begin
  DS.Dataset.Append;
  DS.Dataset.FieldByName('cliente_fac_ee').asString := FCliente;
  EditarItem;
end;

procedure TFMEAN13Edi.dxBajaClick(Sender: TObject);
var
  resp: integer;
  empresa_ee,
  cliente_fac_ee,
  envase_ee: String;
begin
  if not DS.DataSet.isEmpty then
  begin
    resp := MessageBox(Self.Handle, PChar('¿Desea borrar el registro seleccionado?'), PChar(Self.Caption),
      MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2);

    if resp = ID_YES then
    begin
      empresa_ee := DS.DataSet.FieldByName('empresa_ee').asString;
      cliente_fac_ee := DS.DataSet.FieldByName('cliente_fac_ee').asString;
      envase_ee := DS.DataSet.FieldByName('envase_ee').asString;

      DS.Dataset.Delete;

      SincroBonnyAurora.SincronizarEan13Edi(empresa_ee, cliente_fac_ee, envase_ee);
      SincroBonnyAurora.Sincronizar;
    end;
  end;
end;

procedure TFMEAN13Edi.dxLocalizarClick(Sender: TObject);
begin
  FCliente := edtCliente.Text;

  // Comprobar que existe el cliente
  if ExisteCliente(FCliente) then
  begin
    EjecutaQuery;
    ActivarConsulta(False);
    dbgDetalle.SetFocus;
  end
  else
  begin
    stCliente.Caption := 'NO EXISTE';
    edtCliente.SetFocus;
  end;
end;

procedure TFMEAN13Edi.dxSalirClick(Sender: TObject);
begin
  if dbgDetalle.Enabled then
  begin
    ActivarConsulta(True);
    edtCliente.SetFocus;
  end
  else
    Close;
end;

procedure TFMEAN13Edi.EditarItem;
var
  Cliente,
  Articulo,
  Empresa: String;
begin
  FMEAN13EdiItem.Dataset := DS.Dataset;

  if FMEAN13EdiItem.ShowModal = mrOk then
  begin
    if DS.State in dsEditModes then
    begin
      Cliente := DS.Dataset.FieldByName('cliente_fac_ee').asString;
      Articulo := DS.Dataset.FieldByName('envase_ee').asString;
      Empresa := DS.Dataset.FieldByName('empresa_ee').asString;
      try
        DS.DataSet.DisableControls;
        try
          if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
            raise Exception.Create('Error al abrir transaccion en BD.');

          FQuery.Post;
          AceptarTransaccion(DMBaseDatos.DBBaseDatos);

          SincronizarWeb;
          EjecutaQuery;
          DS.DataSet.Locate('empresa_ee;cliente_fac_ee;envase_ee', VarArrayOf([ Empresa, Cliente, Articulo ]), []);
        except
          on E: Exception do
          begin
            FQuery.Cancel;
            if DMBaseDatos.DBBaseDatos.InTransaction then
              CancelarTransaccion(DMBaseDatos.DBBaseDatos);
            raise;
          end;
        end;
      finally
        DS.DataSet.EnableControls;
      end;
    end;
  end
  else
    if DS.State in dsEditModes then
      DS.Dataset.Cancel;
end;

procedure TFMEAN13Edi.edtClientePropertiesChange(Sender: TObject);
begin
  stCliente.Caption := desCliente(edtCliente.Text);
end;

function TFMEAN13Edi.EjecutaQuery: Boolean;
begin
  with FQuery do
  begin
    if Active then
      Close;
    ParamByName('cliente_fac_ee').asString := FCliente;
    Open;
    Result := not isEmpty;
  end;
end;

function TFMEAN13Edi.ExisteCliente(const CodCliente: String): Boolean;
begin
  with FQueryCli do
  begin
    if Active then
      Close;
    ParamByName('cliente_c').asString := CodCliente;
    Open;
    Result := not isEmpty;
    Close;
  end;
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMEAN13Edi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  BEMensajes('');
  Action := caFree;
end;

procedure TFMEAN13Edi.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  CreaQuery;
  DS.Dataset := FQuery;

  FMEAN13EdiItem := TFMEAN13EdiItem.Create(Self);
end;

procedure TFMEAN13Edi.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_F1:
    begin
      if dxLocalizar.Enabled then  dxLocalizarClick(Self)
      else if dxAlta.Enabled then dxAltaClick(Self);
    end;
    $0D, $28: //vk_return,vk_down
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;
    $26: //vk_up
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        Exit;
      end;
    VK_ESCAPE:
    begin
     dxSalirClick(Self);
    end;
  end;
end;

procedure TFMEAN13Edi.FormShow(Sender: TObject);
begin
  ActivarConsulta(True);

  edtCliente.SetFocus;
end;

procedure TFMEAN13Edi.pnlConsultaEnter(Sender: TObject);
begin
  FCliente := '';
  if FQuery.Active then
    FQuery.Close;
end;

procedure TFMEAN13Edi.SincronizarWeb;
begin
  SincroBonnyAurora.SincronizarEan13Edi(
    DS.DataSet.FieldByName('empresa_ee').asString,
    DS.DataSet.FieldByName('cliente_fac_ee').asString,
    DS.DataSet.FieldByName('envase_ee').asString);
  SincroBonnyAurora.Sincronizar;
end;

end.
