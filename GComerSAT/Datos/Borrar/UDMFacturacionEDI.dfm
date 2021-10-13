object DMFacturacionEDI: TDMFacturacionEDI
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 512
  Top = 107
  Height = 581
  Width = 760
  object DSCabeceraEdi: TDataSource
    DataSet = QCabeceraEdi
    Left = 88
    Top = 216
  end
  object QCabeceraEdi: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSFacClientesEdi
    SQL.Strings = (
      'SELECT DISTINCT'
      'Tmp_facturas_c.cod_empresa_tfc cod_empresa, '
      'Tmp_facturas_c.cod_cliente_tfc cod_cliente, '
      'Tmp_facturas_c.factura_tfc ,'
      'Tmp_facturas_c.usuario_tfc ,'
      'Tmp_facturas_c.n_factura_tfc factura,'
      'Frf_empresas_1.codigo_ean_e vendedor,'
      'Frf_empresas_1.codigo_ean_e cobrador,'
      'Frf_clientes_edi_1.quienpide_ce comprador,'
      'Frf_clientes_edi_1.quienrecibe_ce receptor,'
      'Frf_clientes_edi_1.aquiensefactura_ce cliente,'
      'Frf_clientes_edi_1.quienpaga_ce pagador,'
      'Tmp_facturas_l.pedido_tf pedido,'
      'Tmp_facturas_c.fecha_tfc fecha,'
      'Frf_clientes.nombre_c razon_social,'
      'Frf_clientes.domicilio_fac_c domicilio,'
      'Frf_clientes.poblacion_fac_c ciudad,'
      'Frf_clientes.cod_postal_fac_c cod_postal,'
      'Frf_clientes.nif_c nif,'
      'Tmp_facturas_l.albaran_tf albaran,'
      'Tmp_facturas_c.importe_neto_tfc neto,'
      
        '(Tmp_facturas_c.importe_neto_tfc * Tmp_facturas_c.porc_iva_tfc) ' +
        ' / 100  impuestos,'
      'Tmp_facturas_c.cod_moneda_tfc moneda,'
      'tmp_facturas_c.porc_iva_tfc porc_impuesto'
      'FROM'
      'tmp_facturas_c Tmp_facturas_c,'
      'frf_empresas Frf_empresas_1,'
      'tmp_facturas_l Tmp_facturas_l,'
      'frf_clientes Frf_clientes,'
      'frf_clientes_edi'
      'Frf_clientes_edi_1'
      'WHERE'
      
        '        (Tmp_facturas_c.cod_empresa_tfc = Frf_empresas_1.empresa' +
        '_e)'
      '   AND  (Tmp_facturas_c.factura_tfc = Tmp_facturas_l.factura_tf)'
      
        '   AND  (Tmp_facturas_c.cod_empresa_tfc = Tmp_facturas_l.cod_emp' +
        'resa_tf)'
      
        '   AND  (Tmp_facturas_l.cod_empresa_tf = Frf_clientes_edi_1.empr' +
        'esa_ce)'
      
        '   AND  (Tmp_facturas_l.cod_cliente_sal_tf = Frf_clientes_edi_1.' +
        'cliente_ce)'
      
        '   AND  (Tmp_facturas_l.cod_dir_sum_tf = Frf_clientes_edi_1.dir_' +
        'sum_ce)'
      
        '   AND  (Tmp_facturas_c.cod_empresa_tfc = Frf_clientes.empresa_c' +
        ')'
      
        '   AND  (Tmp_facturas_c.cod_cliente_tfc = Frf_clientes.cliente_c' +
        ')'
      '   AND  (tmp_facturas_c.n_factura_tfc=:FacturaNumero)'
      '   AND  (Frf_clientes.edi_c = '#39'S'#39')'
      'ORDER BY'
      '     factura'
      ''
      ''
      '')
    Left = 88
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FacturaNumero'
        ParamType = ptUnknown
      end>
  end
  object QLineasEdi: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCabeceraEdi
    SQL.Strings = (
      'SELECT '
      '      Tmp_facturas_l.cod_empresa_tf,'
      '      Tmp_facturas_l.cod_producto_tf,'
      '       Tmp_facturas_l.producto_tf,'
      '       Tmp_facturas_l.kilos_tf,'
      '       Tmp_facturas_l.unidades_tf,'
      '       Tmp_facturas_l.unidad_medida_tf,'
      '       Tmp_facturas_l.precio_unidad_tf,'
      '       Tmp_facturas_l.categoria_tf,'
      '       Frf_impuestos.tipo_i,'
      '       Tmp_facturas_l.cajas_tf,'
      '       Frf_envases.descripcion_e,'
      '       Frf_envases.envase_e'
      'FROM Tmp_facturas_l, Frf_impuestos, Frf_envases'
      'WHERE  (Tmp_facturas_l.cod_iva_tf = Frf_impuestos.codigo_i)'
      '   AND  (Tmp_facturas_l.usuario_tf = :usuario_tfc)'
      '   AND  (Tmp_facturas_l.factura_tf = :factura_tfc)'
      '   AND  (Frf_envases.empresa_e = Tmp_facturas_l.cod_empresa_tf)'
      '   AND  (Frf_envases.envase_e = Tmp_facturas_l.cod_envase_tf)'
      ''
      ''
      ''
      ''
      ' '
      ' '
      ' ')
    Left = 144
    Top = 272
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
  object QFacClientesEDI: TQuery
    AfterOpen = QFacClientesEDIAfterOpen
    BeforeClose = QFacClientesEDIBeforeClose
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT DISTINCT'
      'Tmp_facturas_c.cod_empresa_tfc empresa,'
      'Tmp_facturas_c.n_factura_tfc factura,'
      'Tmp_facturas_c.fecha_tfc fecha'
      'FROM'
      'tmp_facturas_c Tmp_facturas_c,'
      'frf_clientes Frf_clientes'
      'WHERE'
      '     (Tmp_facturas_c.cod_empresa_tfc = Frf_clientes.empresa_c)'
      
        '   AND  (Tmp_facturas_c.cod_cliente_tfc = Frf_clientes.cliente_c' +
        ')'
      '   AND  (Frf_clientes.edi_c = '#39'S'#39')'
      'ORDER BY'
      '     factura')
    Left = 40
    Top = 40
  end
  object DSFacClientesEdi: TDataSource
    DataSet = QFacClientesEDI
    Left = 40
    Top = 96
  end
  object QGastosEDI: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCabeceraEdi
    SQL.Strings = (
      'SELECT sum(importe_tg) importe'
      'FROM tmp_gastos_fac '
      'WHERE  factura_tg = :factura_tfc '
      'AND       (usuario_tg=:usuario_tfc)')
    Left = 144
    Top = 380
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
  object QAux: TQuery
    AfterOpen = QFacClientesEDIAfterOpen
    BeforeClose = QFacClientesEDIBeforeClose
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT DISTINCT'
      'Tmp_facturas_c.cod_empresa_tfc empresa,'
      'Tmp_facturas_c.n_factura_tfc factura,'
      'Tmp_facturas_c.fecha_tfc fecha'
      'FROM'
      'tmp_facturas_c Tmp_facturas_c,'
      'frf_clientes Frf_clientes'
      'WHERE'
      '     (Tmp_facturas_c.cod_empresa_tfc = Frf_clientes.empresa_c)'
      
        '   AND  (Tmp_facturas_c.cod_cliente_tfc = Frf_clientes.cliente_c' +
        ')'
      '   AND  (Frf_clientes.edi_c = '#39'S'#39')'
      'ORDER BY'
      '     factura')
    Left = 304
    Top = 40
  end
end
