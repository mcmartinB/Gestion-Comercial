object DMFacturacion: TDMFacturacion
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 789
  Top = 248
  Height = 693
  Width = 824
  object QCabeceraFactura: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT tmp_facturas_c.factura_tfc, tmp_facturas_c.usuario_tfc,'
      '       tmp_facturas_c.fecha_tfc, tmp_facturas_c.cod_empresa_tfc,'
      
        '       tmp_facturas_c.cod_client_sal_tfc, tmp_facturas_c.cod_cli' +
        'ente_tfc,'
      
        '       tmp_facturas_c.nom_cliente_tfc, tmp_facturas_c.tipo_via_t' +
        'fc,'
      
        '       tmp_facturas_c.domicilio_tfc, tmp_facturas_c.poblacion_tf' +
        'c,'
      
        '       tmp_facturas_c.cod_postal_tfc, tmp_facturas_c.provincia_t' +
        'fc,'
      
        '       frf_clientes.pais_c, tmp_facturas_c.pais_tfc, tmp_factura' +
        's_c.nif_tfc,'
      
        '       tmp_facturas_c.descuento_tfc, tmp_facturas_c.comision_tfc' +
        ','
      '       tmp_facturas_c.cod_iva_tfc, tmp_facturas_c.porc_iva_tfc,'
      
        '       tmp_facturas_c.tipo_iva_tfc, tmp_facturas_c.descrip_iva_t' +
        'fc,'
      
        '       tmp_facturas_c.cod_moneda_tfc, tmp_facturas_c.cta_cliente' +
        '_tfc,'
      
        '       tmp_facturas_c.forma_pago_tfc, tmp_facturas_c.tipo_factur' +
        'a_tfc,'
      
        '       tmp_facturas_c.concepto_tfc, tmp_facturas_c.importe_neto_' +
        'tfc,'
      
        '       tmp_facturas_c.gasto_total_tfc, tmp_facturas_c.n_factura_' +
        'tfc,'
      
        '       tmp_facturas_c.nota_albaran_tfc, tmp_facturas_c.incoterm_' +
        'tfc,'
      
        '       tmp_facturas_c.plaza_incoterm_tfc, tmp_facturas_c.porte_b' +
        'onny_tfc,'
      
        '       Frf_forma_pago.descripcion_fp, Frf_forma_pago.descripcion' +
        '2_fp,'
      
        '       Frf_forma_pago.descripcion3_fp, Frf_forma_pago.descripcio' +
        'n4_fp,'
      
        '       Frf_forma_pago.descripcion5_fp, Frf_forma_pago.descripcio' +
        'n6_fp,'
      
        '       Frf_forma_pago.descripcion7_fp, Frf_forma_pago.descripcio' +
        'n8_fp,'
      '       Frf_forma_pago.descripcion9_fp'
      'FROM tmp_facturas_c, frf_clientes, OUTER frf_forma_pago'
      
        'WHERE  (tmp_facturas_c.forma_pago_tfc = frf_forma_pago.codigo_fp' +
        ')'
      'AND (frf_clientes.empresa_c=tmp_facturas_c.cod_empresa_tfc)'
      'AND (frf_clientes.cliente_c=tmp_facturas_c.cod_cliente_tfc)'
      'AND (tmp_facturas_c.usuario_tfc=:usuario)'
      'ORDER BY factura_tfc'
      ' ')
    Left = 40
    Top = 46
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'usuario'
        ParamType = ptUnknown
      end>
  end
  object DSCabeceraFactura: TDataSource
    DataSet = QCabeceraFactura
    Left = 96
    Top = 14
  end
  object QLineaGastos: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCabeceraFactura
    SQL.Strings = (
      'SELECT *'
      'FROM tmp_gastos_fac '
      'WHERE  factura_tg = :factura_tfc '
      'AND       (usuario_tg=:usuario_tfc)'
      ''
      'ORDER BY fecha_alb_tg,albaran_tg, tipo_tg')
    Left = 136
    Top = 118
    ParamData = <
      item
        DataType = ftInteger
        Name = 'factura_tfc'
        ParamType = ptUnknown
      end
      item
        DataType = ftFixedChar
        Name = 'usuario_tfc'
        ParamType = ptUnknown
      end>
  end
  object QLineaFactura: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCabeceraFactura
    SQL.Strings = (
      
        'SELECT  cod_empresa_tf, factura_tf,fecha_alb_tf,vehiculo_tf,alba' +
        'ran_tf, centro_salida_tf,'
      '        cod_producto_tf,cod_dir_sum_tf,pedido_tf,'
      '        MAX(producto_tf) as producto_tf,'
      '        MAX(producto2_tf) as producto2_tf,'
      '        cod_envase_tf,'
      '        MAX(envase_tf) as envase_tf,'
      '        MAX(descripcion2_e) as descripcion2_e,'
      '        MAX(envase_comer_tf) as envase_comer_tf,'
      '        categoria_tf,calibre_tf,'
      '        unidad_medida_tf,precio_unidad_tf,'
      '        SUM(cajas_tf) as cajas_tf,'
      '        SUM(kilos_tf) as kilos_tf,'
      '        SUM(unidades_tf) as unidades_tf,'
      '        SUM(precio_neto_tf) as precio_neto_tf,'
      '        nom_marca_tf, tipo_iva_tf'
      'FROM'
      '       tmp_facturas_l'
      'WHERE'
      '       (factura_tf=:factura_tfc)'
      'AND'
      '       (usuario_tf=:usuario_tfc)'
      
        'GROUP BY cod_empresa_tf, factura_tf,fecha_alb_tf,vehiculo_tf,alb' +
        'aran_tf,  centro_salida_tf,'
      '        cod_producto_tf,cod_dir_sum_tf,pedido_tf,'
      '        cod_envase_tf,categoria_tf,calibre_tf,'
      '        unidad_medida_tf,precio_unidad_tf,nom_marca_tf,'
      '        tipo_iva_tf'
      'ORDER BY'
      
        '       fecha_alb_tf, pedido_tf, albaran_tf, cod_dir_sum_tf, cod_' +
        'producto_tf, cod_envase_tf'
      '')
    Left = 136
    Top = 62
    ParamData = <
      item
        DataType = ftInteger
        Name = 'factura_tfc'
        ParamType = ptUnknown
      end
      item
        DataType = ftFixedChar
        Name = 'usuario_tfc'
        ParamType = ptUnknown
      end>
  end
  object QBuscaSalida: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCabeceraFactura
    SQL.Strings = (
      
        'SELECT DISTINCT cod_empresa_tf,albaran_tf,fecha_alb_tf,centro_sa' +
        'lida_tf, cod_emp_factura_tf'
      'FROM tmp_facturas_l'
      'WHERE  factura_tf= :factura_tfc '
      'AND       usuario_tf=:usuario_tfc')
    Left = 128
    Top = 174
    ParamData = <
      item
        DataType = ftInteger
        Name = 'factura_tfc'
        ParamType = ptUnknown
      end
      item
        DataType = ftFixedChar
        Name = 'usuario_tfc'
        ParamType = ptUnknown
      end>
  end
  object QFacturaEnviada: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'select *'
      'from frf_fac_enviadas')
    Left = 432
    Top = 192
    object QFacturaEnviadaempresa_fe: TStringField
      FieldName = 'empresa_fe'
      Origin = 'frf_fac_enviadas.empresa_fe'
      Size = 3
    end
    object QFacturaEnviadacliente_fac_fe: TStringField
      FieldName = 'cliente_fac_fe'
      Origin = 'frf_fac_enviadas.cliente_fac_fe'
      Size = 3
    end
    object QFacturaEnviadan_fac_desde_fe: TIntegerField
      FieldName = 'n_fac_desde_fe'
      Origin = 'frf_fac_enviadas.n_fac_desde_fe'
    end
    object QFacturaEnviadan_fac_hasta_fe: TIntegerField
      FieldName = 'n_fac_hasta_fe'
      Origin = 'frf_fac_enviadas.n_fac_hasta_fe'
    end
    object QFacturaEnviadafecha_factura_fe: TDateField
      FieldName = 'fecha_factura_fe'
      Origin = 'frf_fac_enviadas.fecha_factura_fe'
    end
    object QFacturaEnviadahora_env_fe: TStringField
      FieldName = 'hora_env_fe'
      Origin = 'frf_fac_enviadas.hora_env_fe'
      Size = 8
    end
    object QFacturaEnviadafecha_env_fe: TDateField
      FieldName = 'fecha_env_fe'
      Origin = 'frf_fac_enviadas.fecha_env_fe'
    end
    object QFacturaEnviadapdf_factura_fe: TBlobField
      FieldName = 'pdf_factura_fe'
      Origin = 'frf_fac_enviadas.pdf_factura_fe'
      Size = 1
    end
  end
  object QAux: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      '')
    Left = 48
    Top = 264
  end
  object QCabFactura: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT factura_tfc, usuario_tfc, fecha_tfc, cod_empresa_tfc,'
      
        '       cod_cliente_tfc, nom_cliente_tfc, tipo_via_tfc, domicilio' +
        '_tfc, '
      '       poblacion_tfc, cod_postal_tfc, provincia_tfc, '
      '       pais_tfc, nif_tfc, descuento_tfc, comision_tfc,'
      '       cod_iva_tfc, porc_iva_tfc, tipo_iva_tfc, descrip_iva_tfc,'
      '       cod_moneda_tfc, importe_neto_tfc,'
      '       n_factura_tfc, pais_c, cta_cliente_tfc'
      'FROM tmp_facturas_c, frf_clientes'
      'WHERE  (usuario_tfc = :usuario)'
      'AND (empresa_c = cod_empresa_tfc)'
      'AND (cliente_c = cod_cliente_tfc)'
      'AND Exists ( select * from tmp_facturas_l'
      
        '             where usuario_tf = usuario_tfc and factura_tf = fac' +
        'tura_tfc'
      '               and cod_empresa_tf <> cod_procede_tf )'
      'ORDER BY factura_tfc')
    Left = 272
    Top = 198
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'usuario'
        ParamType = ptUnknown
      end>
  end
  object DSFacturas: TDataSource
    DataSet = QCabFactura
    Left = 272
    Top = 246
  end
  object QLinFactura: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSFacturas
    SQL.Strings = (
      'select'
      '       cod_procede_tf socio_tfl,'
      '       cod_producto_tf producto_tfl,'
      '       sum(kilos_tf) kilos_tfl,'
      '       sum(precio_neto_tf) importe_tfl'
      'from tmp_facturas_l'
      'where usuario_tf = :usuario_tfc'
      'and factura_tf = :factura_tfc'
      'group by cod_procede_tf, cod_producto_tf'
      'order by cod_procede_tf, cod_producto_tf')
    Left = 352
    Top = 198
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'usuario_tfc'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'factura_tfc'
        ParamType = ptUnknown
      end>
  end
  object QGasFactura: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSFacturas
    SQL.Strings = (
      'select sum(importe_tg) importe_tgf'
      'from tmp_gastos_fac'
      'where usuario_tg = :usuario_tfc'
      'and factura_tg = :factura_tfc')
    Left = 352
    Top = 246
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'usuario_tfc'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'factura_tfc'
        ParamType = ptUnknown
      end>
  end
  object QGetFacturaAnulacion: TQuery
    DatabaseName = 'BDProyecto'
    Left = 120
    Top = 368
  end
  object QGetAbonoAnulacion: TQuery
    DatabaseName = 'BDProyecto'
    Left = 240
    Top = 368
  end
  object QRangoFacturas: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT tmp_facturas_c.factura_tfc, tmp_facturas_c.usuario_tfc,'
      '       tmp_facturas_c.fecha_tfc, tmp_facturas_c.cod_empresa_tfc,'
      
        '       tmp_facturas_c.cod_client_sal_tfc, tmp_facturas_c.cod_cli' +
        'ente_tfc,'
      
        '       tmp_facturas_c.nom_cliente_tfc, tmp_facturas_c.tipo_via_t' +
        'fc,'
      
        '       tmp_facturas_c.domicilio_tfc, tmp_facturas_c.poblacion_tf' +
        'c,'
      
        '       tmp_facturas_c.cod_postal_tfc, tmp_facturas_c.provincia_t' +
        'fc,'
      
        '       frf_clientes.pais_c, tmp_facturas_c.pais_tfc, tmp_factura' +
        's_c.nif_tfc,'
      
        '       tmp_facturas_c.descuento_tfc, tmp_facturas_c.comision_tfc' +
        ','
      '       tmp_facturas_c.cod_iva_tfc, tmp_facturas_c.porc_iva_tfc,'
      
        '       tmp_facturas_c.tipo_iva_tfc, tmp_facturas_c.descrip_iva_t' +
        'fc,'
      
        '       tmp_facturas_c.cod_moneda_tfc, tmp_facturas_c.cta_cliente' +
        '_tfc,'
      
        '       tmp_facturas_c.forma_pago_tfc, tmp_facturas_c.tipo_factur' +
        'a_tfc,'
      
        '       tmp_facturas_c.concepto_tfc, tmp_facturas_c.importe_neto_' +
        'tfc,'
      
        '       tmp_facturas_c.gasto_total_tfc, tmp_facturas_c.n_factura_' +
        'tfc,'
      '       tmp_facturas_c.nota_albaran_tfc,'
      
        '       Frf_forma_pago.descripcion_fp, Frf_forma_pago.descripcion' +
        '2_fp,'
      
        '       Frf_forma_pago.descripcion3_fp, Frf_forma_pago.descripcio' +
        'n4_fp,'
      
        '       Frf_forma_pago.descripcion5_fp, Frf_forma_pago.descripcio' +
        'n6_fp'
      'FROM tmp_facturas_c, frf_clientes, OUTER frf_forma_pago'
      
        'WHERE  (tmp_facturas_c.forma_pago_tfc = frf_forma_pago.codigo_fp' +
        ')'
      'AND (frf_clientes.empresa_c=tmp_facturas_c.cod_empresa_tfc)'
      'AND (frf_clientes.cliente_c=tmp_facturas_c.cod_cliente_tfc)'
      'AND (tmp_facturas_c.usuario_tfc=:usuario)'
      'ORDER BY factura_tfc'
      ' ')
    Left = 448
    Top = 342
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'usuario'
        ParamType = ptUnknown
      end>
  end
  object QFacturasIva: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT usuario_tfc, cod_empresa_tfc, factura_tfc, fecha_tfc,'
      '       comision_tfc, descuento_tfc, cod_moneda_tfc'
      ''
      'FROM tmp_facturas_c'
      ''
      'WHERE cod_empresa_tfc = :empresa'
      'AND fecha_tfc = :fecha'
      'AND factura_tfc = :factura'
      'AND usuario_tfc=:usuario')
    Left = 160
    Top = 566
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'factura'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'usuario'
        ParamType = ptUnknown
      end>
  end
  object DSFacturasIva: TDataSource
    DataSet = QFacturasIva
    Left = 248
    Top = 566
  end
  object QCosteEstadistico: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT tmp_facturas_c.factura_tfc, tmp_facturas_c.usuario_tfc,'
      '       tmp_facturas_c.fecha_tfc, tmp_facturas_c.cod_empresa_tfc,'
      
        '       tmp_facturas_c.cod_client_sal_tfc, tmp_facturas_c.cod_cli' +
        'ente_tfc,'
      
        '       tmp_facturas_c.nom_cliente_tfc, tmp_facturas_c.tipo_via_t' +
        'fc,'
      
        '       tmp_facturas_c.domicilio_tfc, tmp_facturas_c.poblacion_tf' +
        'c,'
      
        '       tmp_facturas_c.cod_postal_tfc, tmp_facturas_c.provincia_t' +
        'fc,'
      
        '       frf_clientes.pais_c, tmp_facturas_c.pais_tfc, tmp_factura' +
        's_c.nif_tfc,'
      
        '       tmp_facturas_c.descuento_tfc, tmp_facturas_c.comision_tfc' +
        ','
      '       tmp_facturas_c.cod_iva_tfc, tmp_facturas_c.porc_iva_tfc,'
      
        '       tmp_facturas_c.tipo_iva_tfc, tmp_facturas_c.descrip_iva_t' +
        'fc,'
      
        '       tmp_facturas_c.cod_moneda_tfc, tmp_facturas_c.cta_cliente' +
        '_tfc,'
      
        '       tmp_facturas_c.forma_pago_tfc, tmp_facturas_c.tipo_factur' +
        'a_tfc,'
      
        '       tmp_facturas_c.concepto_tfc, tmp_facturas_c.importe_neto_' +
        'tfc,'
      
        '       tmp_facturas_c.gasto_total_tfc, tmp_facturas_c.n_factura_' +
        'tfc,'
      '       tmp_facturas_c.nota_albaran_tfc,'
      
        '       Frf_forma_pago.descripcion_fp, Frf_forma_pago.descripcion' +
        '2_fp,'
      
        '       Frf_forma_pago.descripcion3_fp, Frf_forma_pago.descripcio' +
        'n4_fp,'
      
        '       Frf_forma_pago.descripcion5_fp, Frf_forma_pago.descripcio' +
        'n6_fp'
      'FROM tmp_facturas_c, frf_clientes, OUTER frf_forma_pago'
      
        'WHERE  (tmp_facturas_c.forma_pago_tfc = frf_forma_pago.codigo_fp' +
        ')'
      'AND (frf_clientes.empresa_c=tmp_facturas_c.cod_empresa_tfc)'
      'AND (frf_clientes.cliente_c=tmp_facturas_c.cod_cliente_tfc)'
      'AND (tmp_facturas_c.usuario_tfc=:usuario)'
      'ORDER BY factura_tfc'
      ' ')
    Left = 736
    Top = 46
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'usuario'
        ParamType = ptUnknown
      end>
  end
  object QCosteKgPlataforma: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT tmp_facturas_c.factura_tfc, tmp_facturas_c.usuario_tfc,'
      '       tmp_facturas_c.fecha_tfc, tmp_facturas_c.cod_empresa_tfc,'
      
        '       tmp_facturas_c.cod_client_sal_tfc, tmp_facturas_c.cod_cli' +
        'ente_tfc,'
      
        '       tmp_facturas_c.nom_cliente_tfc, tmp_facturas_c.tipo_via_t' +
        'fc,'
      
        '       tmp_facturas_c.domicilio_tfc, tmp_facturas_c.poblacion_tf' +
        'c,'
      
        '       tmp_facturas_c.cod_postal_tfc, tmp_facturas_c.provincia_t' +
        'fc,'
      
        '       frf_clientes.pais_c, tmp_facturas_c.pais_tfc, tmp_factura' +
        's_c.nif_tfc,'
      
        '       tmp_facturas_c.descuento_tfc, tmp_facturas_c.comision_tfc' +
        ','
      '       tmp_facturas_c.cod_iva_tfc, tmp_facturas_c.porc_iva_tfc,'
      
        '       tmp_facturas_c.tipo_iva_tfc, tmp_facturas_c.descrip_iva_t' +
        'fc,'
      
        '       tmp_facturas_c.cod_moneda_tfc, tmp_facturas_c.cta_cliente' +
        '_tfc,'
      
        '       tmp_facturas_c.forma_pago_tfc, tmp_facturas_c.tipo_factur' +
        'a_tfc,'
      
        '       tmp_facturas_c.concepto_tfc, tmp_facturas_c.importe_neto_' +
        'tfc,'
      
        '       tmp_facturas_c.gasto_total_tfc, tmp_facturas_c.n_factura_' +
        'tfc,'
      '       tmp_facturas_c.nota_albaran_tfc,'
      
        '       Frf_forma_pago.descripcion_fp, Frf_forma_pago.descripcion' +
        '2_fp,'
      
        '       Frf_forma_pago.descripcion3_fp, Frf_forma_pago.descripcio' +
        'n4_fp,'
      
        '       Frf_forma_pago.descripcion5_fp, Frf_forma_pago.descripcio' +
        'n6_fp'
      'FROM tmp_facturas_c, frf_clientes, OUTER frf_forma_pago'
      
        'WHERE  (tmp_facturas_c.forma_pago_tfc = frf_forma_pago.codigo_fp' +
        ')'
      'AND (frf_clientes.empresa_c=tmp_facturas_c.cod_empresa_tfc)'
      'AND (frf_clientes.cliente_c=tmp_facturas_c.cod_cliente_tfc)'
      'AND (tmp_facturas_c.usuario_tfc=:usuario)'
      'ORDER BY factura_tfc'
      ' ')
    Left = 736
    Top = 102
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'usuario'
        ParamType = ptUnknown
      end>
  end
  object QLineaIva: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSFacturasIva
    SQL.Strings = (
      'SELECT  '
      '  tipo_iva_tf iva, precio_neto_tf neto'
      'FROM'
      '  tmp_facturas_l'
      'WHERE'
      '   (factura_tf=:factura_tfc)'
      'AND'
      '  (usuario_tf=:usuario_tfc)'
      ''
      'ORDER BY iva'
      ''
      ''
      ''
      '')
    Left = 368
    Top = 566
    ParamData = <
      item
        DataType = ftInteger
        Name = 'factura_tfc'
        ParamType = ptUnknown
      end
      item
        DataType = ftFixedChar
        Name = 'usuario_tfc'
        ParamType = ptUnknown
      end>
  end
  object QGastoIva: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSFacturasIva
    SQL.Strings = (
      'SELECT '
      '  iva_tg iva, importe_tg neto'
      'FROM'
      '   tmp_gastos_fac '
      'WHERE  '
      '  factura_tg = :factura_tfc '
      'AND     '
      '   (usuario_tg=:usuario_tfc)'
      ''
      'order by iva')
    Left = 464
    Top = 566
    ParamData = <
      item
        DataType = ftInteger
        Name = 'factura_tfc'
        ParamType = ptUnknown
      end
      item
        DataType = ftFixedChar
        Name = 'usuario_tfc'
        ParamType = ptUnknown
      end>
  end
end
