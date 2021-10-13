unit UFLupas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  CMaestroDetalle, Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, DB, cxDBData,
  DBTables, dxBar, cxClasses, dxStatusBar,
  cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid,

  dxSkinsCore, dxSkinBlue, dxSkinFoggy, dxSkinscxPCPainter, dxSkinsdxStatusBarPainter,
  dxSkinsdxBarPainter, dxSkinBlueprint, dxSkinMoneyTwins;

type
  TcxGridTableControllerAccess = class (TcxGridTableController);

  TRParametrosCampo = record
    sNombreCampo, sTipoDato,  sCaption: string;
    iLength, iWidth: integer;
  end;

  TRParametrosFiltro = record
    sNombreFiltro: string
  end;

  TRParametrosLupa = record
    sNombreTabla: string;
    aRParametrosCampo: array of TRParametrosCampo;
    aRParametrosFiltro: array of TRParametrosFiltro;
  end;

  TFLupas = class(TForm)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxAceptar: TdxBarButton;
    dxCancelar: TdxBarButton;
    tvGridLupa: TcxGridDBTableView;
    lvGrid1Level1: TcxGridLevel;
    cxGrid: TcxGrid;
    DS: TDataSource;
    QBusqueda: TQuery;
    dxStatusBar1: TdxStatusBar;
    function MontarQueryEmpresa: String;
    procedure AbrirQueryEmpresa;
    procedure CargaParametrosEmpresa;

    function MontarQueryCliente: string;
    procedure AbrirQueryCliente;
    procedure CargaParametrosCliente(sEmpresa: string);

    function MontarQueryImpuesto: string;
    procedure AbrirQueryImpuesto;
    procedure CargaParametrosImpuesto;

    function MontarQueryMoneda: string;
    procedure AbrirQueryMoneda;
    procedure CargaParametrosMoneda;

    function MontarQueryCentro: string;
    procedure AbrirQueryCentro;
    procedure CargaParametrosCentro(sEmpresa: string);

    function MontarQuerySuministro: string;
    procedure AbrirQuerySuministro;
    procedure CargaParametrosSuministro(sEmpresa, sCliente: string);

    procedure tvGridLupaCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure dxCancelarClick(Sender: TObject);
    procedure dxAceptarClick(Sender: TObject);
    procedure cxGridEnter(Sender: TObject);



    procedure CrearRejilla;

  private
    { Private declarations }
  public
    vValorCampo: Variant;
    RParametrosLupa: TRParametrosLupa;

  end;

var
  FLupas: TFLupas;

implementation

uses UDFactura, CAuxiliarDB;

{$R *.dfm}

procedure TFLupas.AbrirQueryEmpresa;
begin
  if QBusqueda.Active then
  begin
    QBusqueda.Cancel;
    QBusqueda.Close;
  end;
  QBusqueda.SQL.Clear;
  QBusqueda.SQL.Text := MontarQueryEmpresa;
  try
    AbrirConsulta(QBusqueda);
  except
      //
  end;
end;

procedure TFLupas.tvGridLupaCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  vValorCampo := Sender.DataController.Values[Sender.DataController.FocusedRecordIndex, tcxGridDBColumn(Sender).Index];
  dxAceptarClick(Self);
end;

procedure TFLupas.dxCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TFLupas.dxAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOk;
end;

procedure TFLupas.cxGridEnter(Sender: TObject);
begin
  TcxGridTableControllerAccess(tvGridLupa.Controller).FindPanel.Edit.SetFocus;
end;

procedure TFLupas.CrearRejilla;
var i: integer;
    Columna : TcxGridDBColumn;
begin

  with RParametrosLupa do
  begin
    for i:= 0 to Length(aRParametrosCampo) -1 do
    begin
      Columna := tvGridLupa.CreateColumn();

      Columna.DataBinding.FieldName := aRParametrosCampo[i].sNombreCampo;
      Columna.Caption := aRParametrosCampo[i].sCaption;
      Columna.Width := aRParametrosCampo[i].iWidth;

    end;
  end;

end;

function TFLupas.MontarQueryEmpresa: String;
var i: integer;
    sCadenaSQL: string;
begin
  sCadenaSQL := '';

  sCadenaSQL := ' SELECT DISTINCT ';
  with RParametrosLupa do
  begin
    for i:= 0 to Length(aRParametrosCampo) -1  do
    begin
      if aRParametrosCampo[i].sNombreCampo <> '' then
      begin
        sCadenaSQL := sCadenaSQL + aRParametrosCampo[i].sNombreCampo;

        if i < Length(aRParametrosCampo) -1 then
          sCadenaSQL := sCadenaSQL + ', ';
      end;
    end;

    sCadenaSQL := sCadenaSQL + ' FROM ' + sNombreTabla;
    sCadenaSQL := sCadenaSQL + ' WHERE 1=1 ';

    sCadenaSQL := sCadenaSQL + ' ORDER BY 1 ';
  end;

  result := sCadenaSQL;
end;

procedure TFLupas.CargaParametrosEmpresa;
var i: Integer;
begin
    //Inicializamos valores
  with RParametrosLupa do
  begin
    sNombreTabla :='';
    for i:= 0 to Length(aRParametrosCampo) - 1  do
    begin
      aRParametrosCampo[i].sNombreCampo := '';
      aRParametrosCampo[i].sTipoDato := '';
      aRParametrosCampo[i].sCaption := '';
      aRParametrosCampo[i].iLength := 0;
      aRParametrosCampo[i].iWidth := 0;
    end;
    for i:= 0 to Length (aRParametrosFiltro) -1 do
      aRParametrosFiltro[i].sNombreFiltro := '';

      //Asignar parametros Empresa
    sNombreTabla := 'frf_empresas';

    SetLength( aRParametrosCampo, 2);

      //Parametros Codigo
    aRParametrosCampo[0].sNombreCampo := 'empresa_e';
    aRParametrosCampo[0].sTipoDato := 'String';
    aRParametrosCampo[0].sCaption := 'CODIGO';
    aRParametrosCampo[0].iLength := 3;
    aRParametrosCampo[0].iWidth := 10;

      //Parametros Descripcion
    aRParametrosCampo[1].sNombreCampo := 'nombre_e';
    aRParametrosCampo[1].sTipoDato := 'String';
    aRParametrosCampo[1].sCaption := 'DESCRIPCION';
    aRParametrosCampo[1].iLength := 30;
    aRParametrosCampo[1].iWidth := 80;
  end;
end;

procedure TFLupas.AbrirQueryCliente;
begin
  if QBusqueda.Active then
  begin
    QBusqueda.Cancel;
    QBusqueda.Close;
  end;
  QBusqueda.SQL.Clear;
  QBusqueda.SQL.Text := MontarQueryCliente;
  try
    AbrirConsulta(QBusqueda);
  except
      //
  end;
end;

procedure TFLupas.CargaParametrosCliente(sEmpresa: string);
var i: Integer;
begin
    //Inicializamos valores
  with RParametrosLupa do
  begin
    sNombreTabla :='';
    for i:=0 to Length(aRParametrosCampo) - 1  do
    begin
      aRParametrosCampo[i].sNombreCampo := '';
      aRParametrosCampo[i].sTipoDato := '';
      aRParametrosCampo[i].sCaption := '';
      aRParametrosCampo[i].iLength := 0;
      aRParametrosCampo[i].iWidth := 0;
    end;

    for i:=0 to Length(aRParametrosFiltro) -1 do
      aRParametrosFiltro[i].sNombreFiltro := '';

      //Asignar parametros Clientes
    sNombreTabla := 'frf_clientes';

    SetLength( aRParametrosCampo, 3);
      //Parametros Codigo
    aRParametrosCampo[0].sNombreCampo := 'cliente_c';
    aRParametrosCampo[0].sTipoDato := 'String';
    aRParametrosCampo[0].sCaption := 'CLIENTE';
    aRParametrosCampo[0].iLength := 3;
    aRParametrosCampo[0].iWidth := 10;
      //Parametros Descripcion
    aRParametrosCampo[1].sNombreCampo := 'nombre_c';
    aRParametrosCampo[1].sTipoDato := 'String';
    aRParametrosCampo[1].sCaption := 'DESCRIPCION';
    aRParametrosCampo[1].iLength := 30;
    aRParametrosCampo[1].iWidth := 80;
      //Parametros NIF
    aRParametrosCampo[2].sNombreCampo := 'nif_c';
    aRParametrosCampo[2].sTipoDato := 'String';
    aRParametrosCampo[2].sCaption := 'CIF';
    aRParametrosCampo[2].iLength := 14;
    aRParametrosCampo[2].iWidth := 20;

    if sEmpresa <> '' then
    begin
      SetLength( aRParametrosFiltro, 1);
        //Filtro Empresa
      aRParametrosFiltro[0].sNombreFiltro := sEmpresa;
    end;
  end;
end;

function TFLupas.MontarQueryCliente: string;
var i: integer;
    sCadenaSQL: string;
begin
  sCadenaSQL := '';

  sCadenaSQL := ' SELECT DISTINCT ';
  with RParametrosLupa do
  begin
    for i:= 0 to Length(aRParametrosCampo) -1  do
    begin
      if aRParametrosCampo[i].sNombreCampo <> '' then
      begin
        sCadenaSQL := sCadenaSQL + aRParametrosCampo[i].sNombreCampo;

        if i < Length(aRParametrosCampo) -1 then
          sCadenaSQL := sCadenaSQL + ', ';
      end;
    end;

    sCadenaSQL := sCadenaSQL + ' FROM ' + sNombreTabla;
    sCadenaSQL := sCadenaSQL + ' WHERE 1=1 ';

//    sCadenaSQL := sCadenaSQL + ' AND empresa_c = ' + QuotedStr(aRParametrosFiltro[0].sNombreFiltro);

    sCadenaSQL := sCadenaSQL + ' ORDER BY 1 ';
  end;

  result := sCadenaSQL;
end;

procedure TFLupas.AbrirQueryImpuesto;
begin
  if QBusqueda.Active then
  begin
    QBusqueda.Cancel;
    QBusqueda.Close;
  end;
  QBusqueda.SQL.Clear;
  QBusqueda.SQL.Text := MontarQueryImpuesto;
  try
    AbrirConsulta(QBusqueda);
  except
      //
  end;
end;

procedure TFLupas.CargaParametrosImpuesto;
var i:integer;
begin
    //Inicializamos valores
  with RParametrosLupa do
  begin
    sNombreTabla :='';
    for i:= 0 to Length(aRParametrosCampo) - 1  do
    begin
      aRParametrosCampo[i].sNombreCampo := '';
      aRParametrosCampo[i].sTipoDato := '';
      aRParametrosCampo[i].sCaption := '';
      aRParametrosCampo[i].iLength := 0;
      aRParametrosCampo[i].iWidth := 0;
    end;
    for i:= 0 to Length (aRParametrosFiltro) -1 do
      aRParametrosFiltro[i].sNombreFiltro := '';

      //Asignar parametros Impuesto
    sNombreTabla := 'frf_impuestos';

    SetLength( aRParametrosCampo, 2);

      //Parametros Codigo
    aRParametrosCampo[0].sNombreCampo := 'codigo_i';
    aRParametrosCampo[0].sTipoDato := 'String';
    aRParametrosCampo[0].sCaption := 'IMPUESTO';
    aRParametrosCampo[0].iLength := 2;
    aRParametrosCampo[0].iWidth := 10;

      //Parametros Descripcion
    aRParametrosCampo[1].sNombreCampo := 'descripcion_i';
    aRParametrosCampo[1].sTipoDato := 'String';
    aRParametrosCampo[1].sCaption := 'DESCRIPCION';
    aRParametrosCampo[1].iLength := 30;
    aRParametrosCampo[1].iWidth := 80;
  end;
end;

function TFLupas.MontarQueryImpuesto: string;
var i:integer;
    sCadenaSQL: string;
begin
  sCadenaSQL := '';

  sCadenaSQL := ' SELECT DISTINCT ';
  with RParametrosLupa do
  begin
    for i:= 0 to Length(aRParametrosCampo) -1  do
    begin
      if aRParametrosCampo[i].sNombreCampo <> '' then
      begin
        sCadenaSQL := sCadenaSQL + aRParametrosCampo[i].sNombreCampo;

        if i < Length(aRParametrosCampo) -1 then
          sCadenaSQL := sCadenaSQL + ', ';
      end;
    end;

    sCadenaSQL := sCadenaSQL + ' FROM ' + sNombreTabla;
    sCadenaSQL := sCadenaSQL + ' WHERE 1=1 ';

    sCadenaSQL := sCadenaSQL + ' ORDER BY 2 ';
  end;

  result := sCadenaSQL;
end;

procedure TFLupas.AbrirQueryMoneda;
begin
  if QBusqueda.Active then
  begin
    QBusqueda.Cancel;
    QBusqueda.Close;
  end;
  QBusqueda.SQL.Clear;
  QBusqueda.SQL.Text := MontarQueryMoneda;
  try
    AbrirConsulta(QBusqueda);
  except
      //
  end;
end;

procedure TFLupas.CargaParametrosMoneda;
var i:Integer;
begin
    //Inicializamos valores
  with RParametrosLupa do
  begin
    sNombreTabla :='';
    for i:= 0 to Length(aRParametrosCampo) - 1  do
    begin
      aRParametrosCampo[i].sNombreCampo := '';
      aRParametrosCampo[i].sTipoDato := '';
      aRParametrosCampo[i].sCaption := '';
      aRParametrosCampo[i].iLength := 0;
      aRParametrosCampo[i].iWidth := 0;
    end;
    for i:= 0 to Length (aRParametrosFiltro) -1 do
      aRParametrosFiltro[i].sNombreFiltro := '';

      //Asignar parametros Moneda
    sNombreTabla := 'frf_monedas';

    SetLength( aRParametrosCampo, 2);

      //Parametros Codigo
    aRParametrosCampo[0].sNombreCampo := 'moneda_m';
    aRParametrosCampo[0].sTipoDato := 'String';
    aRParametrosCampo[0].sCaption := 'MONEDA';
    aRParametrosCampo[0].iLength := 2;
    aRParametrosCampo[0].iWidth := 10;

      //Parametros Descripcion
    aRParametrosCampo[1].sNombreCampo := 'descripcion_m';
    aRParametrosCampo[1].sTipoDato := 'String';
    aRParametrosCampo[1].sCaption := 'DESCRIPCION';
    aRParametrosCampo[1].iLength := 30;
    aRParametrosCampo[1].iWidth := 80;
  end;
end;

function TFLupas.MontarQueryMoneda: string;
var i: integer;
    sCadenaSQL: string;
begin
  sCadenaSQL := '';

  sCadenaSQL := ' SELECT DISTINCT ';
  with RParametrosLupa do
  begin
    for i:= 0 to Length(aRParametrosCampo) -1  do
    begin
      if aRParametrosCampo[i].sNombreCampo <> '' then
      begin
        sCadenaSQL := sCadenaSQL + aRParametrosCampo[i].sNombreCampo;

        if i < Length(aRParametrosCampo) -1 then
          sCadenaSQL := sCadenaSQL + ', ';
      end;
    end;

    sCadenaSQL := sCadenaSQL + ' FROM ' + sNombreTabla;
    sCadenaSQL := sCadenaSQL + ' WHERE 1=1 ';

    sCadenaSQL := sCadenaSQL + ' ORDER BY 2 ';
  end;

  result := sCadenaSQL;
end;

procedure TFLupas.AbrirQueryCentro;
begin
  if QBusqueda.Active then
  begin
    QBusqueda.Cancel;
    QBusqueda.Close;
  end;
  QBusqueda.SQL.Clear;
  QBusqueda.SQL.Text := MontarQueryCentro;
  try
    AbrirConsulta(QBusqueda);
  except
      //
  end;
end;

procedure TFLupas.CargaParametrosCentro(sEmpresa: string);
var i:integer;
begin
    //Inicializamos valores
  with RParametrosLupa do
  begin
    sNombreTabla :='';
    for i:= 0 to Length(aRParametrosCampo) - 1  do
    begin
      aRParametrosCampo[i].sNombreCampo := '';
      aRParametrosCampo[i].sTipoDato := '';
      aRParametrosCampo[i].sCaption := '';
      aRParametrosCampo[i].iLength := 0;
      aRParametrosCampo[i].iWidth := 0;
    end;
    for i:= 0 to Length (aRParametrosFiltro) -1 do
      aRParametrosFiltro[i].sNombreFiltro := '';

      //Asignar parametros Centro
    sNombreTabla := 'frf_centros';

    SetLength( aRParametrosCampo, 2);

      //Parametros Codigo
    aRParametrosCampo[0].sNombreCampo := 'centro_c';
    aRParametrosCampo[0].sTipoDato := 'String';
    aRParametrosCampo[0].sCaption := 'CENTRO';
    aRParametrosCampo[0].iLength := 1;
    aRParametrosCampo[0].iWidth := 10;

      //Parametros Descripcion
    aRParametrosCampo[1].sNombreCampo := 'descripcion_c';
    aRParametrosCampo[1].sTipoDato := 'String';
    aRParametrosCampo[1].sCaption := 'DESCRIPCION';
    aRParametrosCampo[1].iLength := 30;
    aRParametrosCampo[1].iWidth := 80;

    if sEmpresa <> '' then
    begin
      SetLength( aRParametrosFiltro, 1);
        //Filtro Empresa
      aRParametrosFiltro[0].sNombreFiltro := sEmpresa;
    end;

  end;
end;

function TFLupas.MontarQueryCentro: string;
var i: integer;
    sCadenaSQL: string;
begin
  sCadenaSQL := '';

  sCadenaSQL := ' SELECT DISTINCT ';
  with RParametrosLupa do
  begin
    for i:= 0 to Length(aRParametrosCampo) -1  do
    begin
      if aRParametrosCampo[i].sNombreCampo <> '' then
      begin
        sCadenaSQL := sCadenaSQL + aRParametrosCampo[i].sNombreCampo;

        if i < Length(aRParametrosCampo) -1 then
          sCadenaSQL := sCadenaSQL + ', ';
      end;
    end;

    sCadenaSQL := sCadenaSQL + ' FROM ' + sNombreTabla;
    sCadenaSQL := sCadenaSQL + ' WHERE 1=1 ';

    sCadenaSQL := sCadenaSQL + ' AND empresa_c = ' + QuotedStr(aRParametrosFiltro[0].sNombreFiltro);

    sCadenaSQL := sCadenaSQL + ' ORDER BY 1 ';
  end;

  result := sCadenaSQL;
end;

procedure TFLupas.CargaParametrosSuministro(sEmpresa, sCliente: string);
var i: integer;
begin
    //Inicializamos valores
  with RParametrosLupa do
  begin
    sNombreTabla :='';
    for i:=0 to Length(aRParametrosCampo) - 1  do
    begin
      aRParametrosCampo[i].sNombreCampo := '';
      aRParametrosCampo[i].sTipoDato := '';
      aRParametrosCampo[i].sCaption := '';
      aRParametrosCampo[i].iLength := 0;
      aRParametrosCampo[i].iWidth := 0;
    end;

    for i:=0 to Length(aRParametrosFiltro) -1 do
      aRParametrosFiltro[i].sNombreFiltro := '';

      //Asignar parametros Direccion Suministro
    sNombreTabla := 'frf_dir_sum';

    SetLength( aRParametrosCampo, 2);
      //Parametros Codigo
    aRParametrosCampo[0].sNombreCampo := 'dir_sum_ds';
    aRParametrosCampo[0].sTipoDato := 'String';
    aRParametrosCampo[0].sCaption := 'DIR. SUMINISTRO';
    aRParametrosCampo[0].iLength := 3;
    aRParametrosCampo[0].iWidth := 10;
      //Parametros Descripcion
    aRParametrosCampo[1].sNombreCampo := 'nombre_ds';
    aRParametrosCampo[1].sTipoDato := 'String';
    aRParametrosCampo[1].sCaption := 'DESCRIPCION';
    aRParametrosCampo[1].iLength := 50;
    aRParametrosCampo[1].iWidth := 80;

    if (sEmpresa <> '') or (sCliente <> '') then
    begin
      SetLength( aRParametrosFiltro, 2);
        //Filtro Empresa
      if sEmpresa <> '' then
        aRParametrosFiltro[0].sNombreFiltro := sEmpresa;
      if sCliente <> '' then
        aRParametrosFiltro[1].sNombreFiltro := sCliente;
    end;
  end;
end;

procedure TFLupas.AbrirQuerySuministro;
begin
  if QBusqueda.Active then
  begin
    QBusqueda.Cancel;
    QBusqueda.Close;
  end;
  QBusqueda.SQL.Clear;
  QBusqueda.SQL.Text := MontarQuerySuministro;
  try
    AbrirConsulta(QBusqueda);
  except
      //
  end;
end;

function TFLupas.MontarQuerySuministro: string;
var i: integer;
    sCadenaSQL: string;
begin
  sCadenaSQL := '';

  sCadenaSQL := ' SELECT DISTINCT ';
  with RParametrosLupa do
  begin
    for i:= 0 to Length(aRParametrosCampo) -1  do
    begin
      if aRParametrosCampo[i].sNombreCampo <> '' then
      begin
        sCadenaSQL := sCadenaSQL + aRParametrosCampo[i].sNombreCampo;

        if i < Length(aRParametrosCampo) -1 then
          sCadenaSQL := sCadenaSQL + ', ';
      end;
    end;

    sCadenaSQL := sCadenaSQL + ' FROM ' + sNombreTabla;
    sCadenaSQL := sCadenaSQL + ' WHERE 1=1 ';

    sCadenaSQL := sCadenaSQl + ' AND cliente_ds = ' + QuotedStr(aRParametrosFiltro[1].sNombreFiltro);

    sCadenaSQL := sCadenaSQL + ' ORDER BY 1 ';
  end;

  result := sCadenaSQL;
end;

end.
