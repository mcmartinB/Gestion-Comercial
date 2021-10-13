object DMActualizarDiasCobro: TDMActualizarDiasCobro
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 805
  Top = 260
  Height = 332
  Width = 354
  object qryFacturas: TQuery
    DatabaseName = 'dbMaster'
    SQL.Strings = (
      'SELECT factura_tf,usuario_tf,cod_iva_tf[1,1] as impuesto, '
      'cod_empresa_tf,cod_cliente_fac_tf,cod_dir_sum_tf, '
      'pedido_tf,albaran_tf,fecha_alb_tf,cod_pais_tf, '
      'centro_salida_tf, moneda_tf '
      'FROM tmp_facturas_l '
      
        'ORDER BY  impuesto desc,cod_empresa_tf,cod_cliente_fac_tf,cod_di' +
        'r_sum_tf,fecha_alb_tf,albaran_tf')
    Left = 32
    Top = 22
  end
  object qryDiasTesoreriaCliente: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT factura_tf,usuario_tf,cod_iva_tf[1,1] as impuesto, '
      'cod_empresa_tf,cod_cliente_fac_tf,cod_dir_sum_tf, '
      'pedido_tf,albaran_tf,fecha_alb_tf,cod_pais_tf, '
      'centro_salida_tf, moneda_tf '
      'FROM tmp_facturas_l '
      
        'ORDER BY  impuesto desc,cod_empresa_tf,cod_cliente_fac_tf,cod_di' +
        'r_sum_tf,fecha_alb_tf,albaran_tf')
    Left = 128
    Top = 22
  end
  object qryDiasCobroFactura: TQuery
    DatabaseName = 'dbMaster'
    SQL.Strings = (
      'SELECT factura_tf,usuario_tf,cod_iva_tf[1,1] as impuesto, '
      'cod_empresa_tf,cod_cliente_fac_tf,cod_dir_sum_tf, '
      'pedido_tf,albaran_tf,fecha_alb_tf,cod_pais_tf, '
      'centro_salida_tf, moneda_tf '
      'FROM tmp_facturas_l '
      
        'ORDER BY  impuesto desc,cod_empresa_tf,cod_cliente_fac_tf,cod_di' +
        'r_sum_tf,fecha_alb_tf,albaran_tf')
    Left = 248
    Top = 22
  end
  object qryUpdatefactura: TQuery
    DatabaseName = 'dbMaster'
    SQL.Strings = (
      'SELECT factura_tf,usuario_tf,cod_iva_tf[1,1] as impuesto, '
      'cod_empresa_tf,cod_cliente_fac_tf,cod_dir_sum_tf, '
      'pedido_tf,albaran_tf,fecha_alb_tf,cod_pais_tf, '
      'centro_salida_tf, moneda_tf '
      'FROM tmp_facturas_l '
      
        'ORDER BY  impuesto desc,cod_empresa_tf,cod_cliente_fac_tf,cod_di' +
        'r_sum_tf,fecha_alb_tf,albaran_tf')
    Left = 40
    Top = 102
  end
  object qryFacturaAsociada: TQuery
    DatabaseName = 'dbMaster'
    SQL.Strings = (
      'SELECT factura_tf,usuario_tf,cod_iva_tf[1,1] as impuesto, '
      'cod_empresa_tf,cod_cliente_fac_tf,cod_dir_sum_tf, '
      'pedido_tf,albaran_tf,fecha_alb_tf,cod_pais_tf, '
      'centro_salida_tf, moneda_tf '
      'FROM tmp_facturas_l '
      
        'ORDER BY  impuesto desc,cod_empresa_tf,cod_cliente_fac_tf,cod_di' +
        'r_sum_tf,fecha_alb_tf,albaran_tf')
    Left = 152
    Top = 102
  end
  object qryFacturaAlbaran: TQuery
    DatabaseName = 'dbMaster'
    SQL.Strings = (
      'SELECT factura_tf,usuario_tf,cod_iva_tf[1,1] as impuesto, '
      'cod_empresa_tf,cod_cliente_fac_tf,cod_dir_sum_tf, '
      'pedido_tf,albaran_tf,fecha_alb_tf,cod_pais_tf, '
      'centro_salida_tf, moneda_tf '
      'FROM tmp_facturas_l '
      
        'ORDER BY  impuesto desc,cod_empresa_tf,cod_cliente_fac_tf,cod_di' +
        'r_sum_tf,fecha_alb_tf,albaran_tf')
    Left = 256
    Top = 102
  end
  object qryFacturaFechas: TQuery
    DatabaseName = 'dbMaster'
    SQL.Strings = (
      'SELECT factura_tf,usuario_tf,cod_iva_tf[1,1] as impuesto, '
      'cod_empresa_tf,cod_cliente_fac_tf,cod_dir_sum_tf, '
      'pedido_tf,albaran_tf,fecha_alb_tf,cod_pais_tf, '
      'centro_salida_tf, moneda_tf '
      'FROM tmp_facturas_l '
      
        'ORDER BY  impuesto desc,cod_empresa_tf,cod_cliente_fac_tf,cod_di' +
        'r_sum_tf,fecha_alb_tf,albaran_tf')
    Left = 40
    Top = 174
  end
  object qryAbonosSinFactura: TQuery
    DatabaseName = 'dbMaster'
    SQL.Strings = (
      'SELECT factura_tf,usuario_tf,cod_iva_tf[1,1] as impuesto, '
      'cod_empresa_tf,cod_cliente_fac_tf,cod_dir_sum_tf, '
      'pedido_tf,albaran_tf,fecha_alb_tf,cod_pais_tf, '
      'centro_salida_tf, moneda_tf '
      'FROM tmp_facturas_l '
      
        'ORDER BY  impuesto desc,cod_empresa_tf,cod_cliente_fac_tf,cod_di' +
        'r_sum_tf,fecha_alb_tf,albaran_tf')
    Left = 152
    Top = 174
  end
  object qryUpdatefacturaAsociada: TQuery
    DatabaseName = 'dbMaster'
    SQL.Strings = (
      'SELECT factura_tf,usuario_tf,cod_iva_tf[1,1] as impuesto, '
      'cod_empresa_tf,cod_cliente_fac_tf,cod_dir_sum_tf, '
      'pedido_tf,albaran_tf,fecha_alb_tf,cod_pais_tf, '
      'centro_salida_tf, moneda_tf '
      'FROM tmp_facturas_l '
      
        'ORDER BY  impuesto desc,cod_empresa_tf,cod_cliente_fac_tf,cod_di' +
        'r_sum_tf,fecha_alb_tf,albaran_tf')
    Left = 256
    Top = 190
  end
  object qryDiasCobroCliente: TQuery
    DatabaseName = 'dbMaster'
    SQL.Strings = (
      'SELECT factura_tf,usuario_tf,cod_iva_tf[1,1] as impuesto, '
      'cod_empresa_tf,cod_cliente_fac_tf,cod_dir_sum_tf, '
      'pedido_tf,albaran_tf,fecha_alb_tf,cod_pais_tf, '
      'centro_salida_tf, moneda_tf '
      'FROM tmp_facturas_l '
      
        'ORDER BY  impuesto desc,cod_empresa_tf,cod_cliente_fac_tf,cod_di' +
        'r_sum_tf,fecha_alb_tf,albaran_tf')
    Left = 96
    Top = 238
  end
  object qryUpdateFacAnula: TQuery
    DatabaseName = 'dbMaster'
    SQL.Strings = (
      'SELECT factura_tf,usuario_tf,cod_iva_tf[1,1] as impuesto, '
      'cod_empresa_tf,cod_cliente_fac_tf,cod_dir_sum_tf, '
      'pedido_tf,albaran_tf,fecha_alb_tf,cod_pais_tf, '
      'centro_salida_tf, moneda_tf '
      'FROM tmp_facturas_l '
      
        'ORDER BY  impuesto desc,cod_empresa_tf,cod_cliente_fac_tf,cod_di' +
        'r_sum_tf,fecha_alb_tf,albaran_tf')
    Left = 208
    Top = 238
  end
end
