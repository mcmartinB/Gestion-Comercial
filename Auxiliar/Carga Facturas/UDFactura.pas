unit UDFactura;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DBTables, ImgList, Controls,
  cxGraphics;

type
  TDFactura = class(TDataModule)
    mtFacturas_Cab: TkbmMemTable;
    mtFacturas_Det: TkbmMemTable;
    mtFacturas_Gas: TkbmMemTable;
    mtFacturas_Bas: TkbmMemTable;
    dsFacturas_Cab: TDataSource;
    dsFacturas_Det: TDataSource;
    dsFacturas_Gas: TDataSource;
    dsFacturas_Bas: TDataSource;
    DataBase: TDatabase;
    ilxIFacturas: TcxImageList;
    QAux: TQuery;
    QGeneral: TQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DFactura: TDFactura;

implementation

{$R *.dfm}

procedure TDFactura.DataModuleCreate(Sender: TObject);
begin
  with mtFacturas_Cab do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('cod_factura_fc', ftString, 15, False);
    FieldDefs.Add('cod_empresa_fac_fc', ftString, 3, False);
    FieldDefs.Add('n_factura_fc', ftInteger, 0, False);
    FieldDefs.Add('fecha_factura_fc', ftDate, 0, False);
    FieldDefs.Add('impuesto_fc', ftString, 1, False);
    FieldDefs.Add('tipo_factura_fc', ftString, 3, False);
    FieldDefs.Add('automatica_fc', ftInteger, 0, False);
    FieldDefs.Add('anulacion_fc', ftInteger, 0, False);
    FieldDefs.Add('cod_factura_anula_fc', ftString, 15, False);
    FieldDefs.Add('cod_cliente_fc', ftString, 3, False);
    FieldDefs.Add('des_cliente_fc', ftString, 35, False);
    FieldDefs.Add('cta_cliente_fc', ftString, 10, False);
    FieldDefs.Add('nif_fc', ftString, 14, False);
    FieldDefs.Add('tipo_via_fc', ftString, 2, False);
    FieldDefs.Add('domicilio_fc', ftString, 40, False);
    FieldDefs.Add('poblacion_fc', ftString, 30, False);
    FieldDefs.Add('cod_postal_fc', ftString, 15, False);
    FieldDefs.Add('provincia_fc', ftString, 30, False);
    FieldDefs.Add('cod_pais_fc', ftString, 2, False);
    FieldDefs.Add('des_pais_fc', ftString, 30, False);
    FieldDefs.Add('notas_fc', ftString, 256, False);
    FieldDefs.Add('incoterm_fc', ftString, 3, False);
    FieldDefs.Add('plaza_incoterm_fc', ftString, 30, False);
    FieldDefs.Add('forma_pago_fc', ftString, 2, False);
    FieldDefs.Add('des_forma_pago_fc', ftString, 512, False);
    FieldDefs.Add('tipo_impuesto_fc', ftString, 2, False);
    FieldDefs.Add('des_tipo_impuesto_fc', ftString, 50, False);
    FieldDefs.Add('moneda_fc', ftString, 3, False);
    FieldDefs.Add('importe_linea_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_descuento_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_neto_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_impuesto_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_total_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_neto_euros_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_impuesto_euros_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_total_euros_fc', ftFloat, 0, False);
    FieldDefs.Add('prevision_cobro_fc', ftDate, 0, False);
    FieldDefs.Add('contabilizado_fc', ftString, 1, False);
    FieldDefs.Add('fecha_conta_fc', ftDate, 0, False);
    FieldDefs.Add('filename_conta_fc', ftString, 30, False);

    FieldDefs.Add('fac_interno_fc', ftInteger, 0, False);

    CreateTable;

  end;

  with mtFacturas_Det do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('cod_factura_fd', ftString, 15, False);
    FieldDefs.Add('num_linea_fd', ftInteger, 0, False);
    FieldDefs.Add('cod_empresa_albaran_fd', ftString, 3, False);
    FieldDefs.Add('cod_centro_albaran_fd', ftString, 3, False);
    FieldDefs.Add('n_albaran_fd', ftInteger, 0, False);
    FieldDefs.Add('fecha_albaran_fd', ftDate, 0, False);
    FieldDefs.Add('cod_cliente_albaran_fd', ftString, 3, False);
    FieldDefs.Add('cod_dir_sum_fd', ftString, 3, False);
    FieldDefs.Add('pedido_fd', ftString, 15, False);
    FieldDefs.Add('matricula_fd', ftString, 30, False);
    FieldDefs.Add('emp_procedencia_fd', ftString, 3, False);
    FieldDefs.Add('centro_origen_fd', ftString, 1, False);
    FieldDefs.Add('cod_producto_fd', ftString, 1, False);
    FieldDefs.Add('des_producto_fd', ftString, 30, False);
    FieldDefs.Add('cod_envase_fd', ftString, 3, False);
    FieldDefs.Add('des_envase_fd', ftString, 30, False);
    FieldDefs.Add('categoria_fd', ftString, 2, False);
    FieldDefs.Add('calibre_fd', ftString, 6, False);
    FieldDefs.Add('marca_fd', ftString, 2, False);
    FieldDefs.Add('nom_marca_fd', ftString, 30, False);
    FieldDefs.Add('cajas_fd', ftInteger, 0, False);
    FieldDefs.Add('unidades_caja_fd', ftInteger, 0, False);
    FieldDefs.Add('unidades_fd', ftInteger, 0, False);
    FieldDefs.Add('kilos_fd', ftFloat, 0, False);
    FieldDefs.Add('unidad_facturacion_fd', ftString, 3, False);
    FieldDefs.Add('precio_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_linea_fd', ftFloat, 0, False);
    FieldDefs.Add('cod_representante_fd', ftString, 3, False);
    FieldDefs.Add('porcentaje_comision_fd', ftFloat, 0, False);
    FieldDefs.Add('porcentaje_descuento_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_comision_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_descuento_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_total_descuento_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_neto_fd', ftFloat, 0, False);
    FieldDefs.Add('tasa_impuesto_fd', ftString, 1, False);
    FieldDefs.Add('porcentaje_impuesto_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_impuesto_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_total_fd', ftFloat, 0, False);

    FieldDefs.Add('cod_empresa_fac_fd', ftString, 3, False);
    FieldDefs.Add('fecha_fac_fd', ftDate, 0, False);
    FieldDefs.Add('fac_interno_fd', ftInteger, 0, False);
    FieldDefs.Add('cod_cliente_fac_fd', ftString, 3, False);
    FieldDefs.Add('moneda_fd', ftString, 3, False);
    FieldDefs.Add('tipo_iva_fd', ftString, 2, False);
    FieldDefs.Add('incoterm_fd', ftString, 3, False);
    FieldDefs.Add('plaza_incoterm_fd', ftString, 30, False);

    CreateTable;

  end;

  with mtFacturas_Gas do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('cod_factura_fg', ftString, 15, False);
    FieldDefs.Add('cod_empresa_albaran_fg', ftString, 3, False);
    FieldDefs.Add('cod_centro_albaran_fg', ftString, 3, False);
    FieldDefs.Add('n_albaran_fg', ftInteger, 0, False);
    FieldDefs.Add('fecha_albaran_fg', ftDate, 0, False);
    FieldDefs.Add('cod_tipo_gasto_fg', ftString, 3, False);
    FieldDefs.Add('des_tipo_gasto_fg', ftString, 30, False);
    FieldDefs.Add('importe_neto_fg', ftFloat, 0, False);
    FieldDefs.Add('tasa_impuesto_fg', ftString, 1, False);
    FieldDefs.Add('porcentaje_impuesto_fg', ftFloat, 0, False);
    FieldDefs.Add('importe_impuesto_fg', ftFloat, 0, False);
    FieldDefs.Add('importe_total_fg', ftFloat, 0, False);

    FieldDefs.Add('cod_empresa_fac_fg', ftString, 3, False);
    FieldDefs.Add('fecha_fac_fg', ftDate, 0, False);
    FieldDefs.Add('fac_interno_fg', ftInteger, 0, False);

    CreateTable;

  end;
  with mtFacturas_Bas do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('cod_factura_fb', ftString, 15, False);
    FieldDefs.Add('tasa_impuesto_fb', ftString, 1, False);
    FieldDefs.Add('porcentaje_impuesto_fb', ftFloat, 0, False);
    FieldDefs.Add('cajas_fb', ftInteger, 0, False);
    FieldDefs.Add('unidades_fb', ftInteger, 0, False);
    FieldDefs.Add('kilos_fb', ftFloat, 0, False);
    FieldDefs.Add('importe_neto_fb', ftFloat, 0, False);
    FieldDefs.Add('importe_impuesto_fb', ftFloat, 0, False);
    FieldDefs.Add('importe_total_fb', ftFloat, 0, False);

    FieldDefs.Add('cod_empresa_fac_fb', ftString, 3, False);
    FieldDefs.Add('fecha_fac_fb', ftDate, 0, False);
    FieldDefs.Add('fac_interno_fb', ftInteger, 0, False);

    CreateTable;

  end;
end;

end.
