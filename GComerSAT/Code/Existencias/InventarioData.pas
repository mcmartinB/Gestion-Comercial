unit InventarioData;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMInventario = class(TDataModule)
    QInventarioCab: TQuery;
    QInventarioCabempresa_ic: TStringField;
    QInventarioCabcentro_ic: TStringField;
    QInventarioCabproducto_ic: TStringField;
    QInventarioCabkilos_cec_ic: TFloatField;
    QInventarioCabkilos_cim_c1_ic: TFloatField;
    QInventarioCabkilos_cim_c2_ic: TFloatField;
    QInventarioCabkilos_cia_c1_ic: TFloatField;
    QInventarioCabkilos_cia_c2_ic: TFloatField;
    QInventarioCabkilos_zd_c3_ic: TFloatField;
    QInventarioCabkilos_zd_d_ic: TFloatField;
    DSInventarioCab: TDataSource;
    QInventarioLin: TQuery;
    QInventarioCabdes_empresa: TStringField;
    QInventarioCabdes_centro: TStringField;
    QInventarioCabdes_producto: TStringField;
    QInventarioLinempresa_il: TStringField;
    QInventarioLincentro_il: TStringField;
    QInventarioLinproducto_il: TStringField;
    QInventarioLinenvase_il: TStringField;
    QInventarioLincajas_ce_c1_il: TIntegerField;
    QInventarioLinkilos_ce_c1_il: TFloatField;
    QInventarioLincajas_ce_c2_il: TIntegerField;
    QInventarioLinkilos_ce_c2_il: TFloatField;
    QInventarioCabnotas_ic: TStringField;
    QInventarioLindes_envase: TStringField;
    QInventarioLincalibre_il: TStringField;
    QInventarioCabkilos_ajuste_c1_ic: TFloatField;
    QInventarioCabkilos_ajuste_c2_ic: TFloatField;
    QInventarioCabkilos_ajuste_c3_ic: TFloatField;
    QInventarioCabkilos_ajuste_cd_ic: TFloatField;
    QInventarioCabkilos_ajuste_campo_ic: TFloatField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure QInventarioCabBeforeClose(DataSet: TDataSet);
    procedure QInventarioCabAfterOpen(DataSet: TDataSet);
    procedure QInventarioLinCalcFields(DataSet: TDataSet);
    procedure QInventarioCabCalcFields(DataSet: TDataSet);
    procedure QInventarioLinBeforePost(DataSet: TDataSet);
    procedure QInventarioLinAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    QInventarioCabfecha_ic: TDateField;
    QInventarioLinfecha_il: TDateField;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

procedure Create;
procedure Destroy;

var
  DMInventario: TDMInventario;

implementation

{$R *.dfm}

uses UDMAuxDB;

var
  instancias: Integer = 0;

procedure Create;
begin
  if DMInventario = nil then
    DMInventario := TDMInventario.Create(nil);
  Inc(InventarioData.instancias);
end;

procedure Destroy;
begin
  Dec(InventarioData.instancias);
  if instancias = 0 then
    FreeAndNil(DMInventario);
end;

constructor TDMInventario.Create(AOwner: TComponent);
begin
  inherited;
  QInventarioCabfecha_ic := TDateField.Create(Self);
  QInventarioLinfecha_il := TDateField.Create(Self);
  QInventarioCabfecha_ic.FieldName := 'fecha_ic';
  QInventarioCabfecha_ic.Name := QInventarioCab.Name +
    QInventarioCabfecha_ic.FieldName;
  QInventarioCabfecha_ic.Index := QInventarioCab.FieldCount;
  QInventarioCabfecha_ic.DataSet := QInventarioCab;
  QInventarioCab.FieldDefs.UpDate;

  QInventarioLinfecha_il.FieldName := 'fecha_il';
  QInventarioLinfecha_il.Name := QInventarioLin.Name +
    QInventarioLinfecha_il.FieldName;
  QInventarioLinfecha_il.Index := QInventarioLin.FieldCount;
  QInventarioLinfecha_il.DataSet := QInventarioLin;
  QInventarioLin.FieldDefs.UpDate;
end;

procedure TDMInventario.DataModuleDestroy(Sender: TObject);
begin
  QInventarioLin.Close;
  QInventarioCab.Close;
end;

procedure TDMInventario.QInventarioCabBeforeClose(DataSet: TDataSet);
begin
  QInventarioLin.Close;
end;

procedure TDMInventario.QInventarioCabAfterOpen(DataSet: TDataSet);
begin
  QInventarioLin.Open;
end;


procedure TDMInventario.QInventarioLinCalcFields(DataSet: TDataSet);
begin
  QInventarioLindes_envase.AsString := desEnvase(QInventarioLinempresa_il.AsString,
    QInventarioLinenvase_il.AsString);
end;

procedure TDMInventario.QInventarioCabCalcFields(DataSet: TDataSet);
begin
  QInventarioCabdes_empresa.AsString := desEmpresa(QInventarioCabempresa_ic.AsString);
  QInventarioCabdes_centro.AsString := desCentro(QInventarioCabempresa_ic.AsString,
    QInventarioCabcentro_ic.AsString);
  QInventarioCabdes_producto.AsString := desProducto(QInventarioCabempresa_ic.AsString,
    QInventarioCabproducto_ic.AsString);
end;

procedure TDMInventario.QInventarioLinBeforePost(DataSet: TDataSet);
begin
  QInventarioLinempresa_il.Value := QInventarioCabempresa_ic.Value;
  QInventarioLincentro_il.Value := QInventarioCabcentro_ic.Value;
  QInventarioLinproducto_il.Value := QInventarioCabproducto_ic.Value;
  QInventarioLinfecha_il.Value := QInventarioCabfecha_ic.Value;
end;

procedure TDMInventario.QInventarioLinAfterPost(DataSet: TDataSet);
begin
  DataSet.Close;
  DataSet.Open;
end;

end.
