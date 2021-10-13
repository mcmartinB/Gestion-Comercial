object DLComprobacionRetirada: TDLComprobacionRetirada
  OldCreateOrder = False
  Height = 206
  Width = 356
  object QAlbaranFactura: TQuery
    DatabaseName = 'BDProyecto'
    Filtered = True
    SQL.Strings = (
      '  select empresa_fac_sc,'
      '         serie_fac_sc, '
      '         n_factura_sc, '
      '         fecha_factura_sc, '
      '         cliente_fac_sc, '
      ''
      '         ( select porc_impuesto_f'
      '         from frf_facturas '
      '         where empresa_f = '#39'050'#39' '
      '           and fecha_factura_f = fecha_factura_sc '
      '           and n_factura_f = n_factura_sc ) por_iva,'
      ''
      '         ( select importe_neto_f neto '
      '         from frf_facturas '
      '         where empresa_f = '#39'050'#39' '
      '           and fecha_factura_f = fecha_factura_sc '
      '           and n_factura_f = n_factura_sc ) neto,'
      ''
      '         ( select total_impuesto_f neto '
      '         from frf_facturas '
      '         where empresa_f = '#39'050'#39' '
      '           and fecha_factura_f = fecha_factura_sc '
      '           and n_factura_f = n_factura_sc ) iva,'
      ''
      '         ( select importe_total_f neto '
      '         from frf_facturas '
      '         where empresa_f = '#39'050'#39' '
      '           and fecha_factura_f = fecha_factura_sc '
      '           and n_factura_f = n_factura_sc ) total,'
      ''
      '         ( select importe_euros_f neto '
      '         from frf_facturas'
      '         where empresa_f = '#39'050'#39' '
      '           and fecha_factura_f = fecha_factura_sc '
      '           and n_factura_f = n_factura_sc ) euros,'
      ''
      
        '         sum( case when producto_sl in ( select producto_p from ' +
        'frf_productos where empresa_p = '#39'050'#39' and estomate_p = '#39'S'#39' ) the' +
        'n kilos_sl else 0 end ) kilos_producto'
      ''
      '  from frf_salidas_c, frf_salidas_l '
      '  where empresa_sc = '#39'050'#39' '
      '  and fecha_sc between '#39'1/10/2005'#39' and '#39'1/10/2005'#39' '
      ''
      '  and n_factura_sc is not null '
      ''
      '  and empresa_sl = '#39'050'#39' '
      '  and centro_salida_sl = centro_salida_sc '
      '  and fecha_sl = fecha_sc '
      '  and n_albaran_sl = n_albaran_sc '
      ''
      ''
      
        '  group by n_factura_sc, fecha_factura_sc, cliente_fac_sc, 4, 5,' +
        ' 6, 7, 8'
      
        '  having sum( case when producto_sl in ( select producto_p from ' +
        'frf_productos where empresa_p = '#39'050'#39' and estomate_p = '#39'S'#39' ) the' +
        'n kilos_sl else 0 end ) > 0 '
      '  order by n_factura_sc, fecha_factura_sc, cliente_fac_sc')
    Left = 48
    Top = 24
  end
  object mtAlbaranFactura: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'factura'
        DataType = ftInteger
      end
      item
        Name = 'fecha'
        DataType = ftDate
      end
      item
        Name = 'cliente'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'nombre'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'importe'
        DataType = ftFloat
      end
      item
        Name = 'impuesto'
        DataType = ftFloat
      end
      item
        Name = 'kilos'
        DataType = ftFloat
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.51'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 152
    Top = 24
    object mtAlbaranFacturaempresa: TStringField
      FieldName = 'empresa'
      Size = 3
    end
    object mtAlbaranFacturaserie: TStringField
      FieldName = 'serie'
      Size = 3
    end
    object mtAlbaranFacturafactura: TIntegerField
      FieldName = 'factura'
    end
    object mtAlbaranFacturafecha: TDateField
      FieldName = 'fecha'
    end
    object mtAlbaranFacturacod_factura: TStringField
      FieldName = 'cod_factura'
      Size = 15
    end
    object mtAlbaranFacturacliente: TStringField
      FieldName = 'cliente'
      Size = 3
    end
    object mtAlbaranFacturanombre: TStringField
      FieldName = 'nombre'
      Size = 50
    end
    object mtAlbaranFacturaimporte: TFloatField
      FieldName = 'importe'
    end
    object mtAlbaranFacturaimpuesto: TFloatField
      FieldName = 'impuesto'
    end
    object mtAlbaranFacturakilos: TFloatField
      FieldName = 'kilos'
    end
    object mtAlbaranFacturaimporte_st: TFloatField
      FieldName = 'importe_st'
    end
    object mtAlbaranFacturaimpuesto_st: TFloatField
      FieldName = 'impuesto_st'
    end
    object mtAlbaranFacturakilos_st: TFloatField
      FieldName = 'kilos_st'
    end
  end
  object QGastoAlbaran: TQuery
    DatabaseName = 'BDProyecto'
    Filtered = True
    SQL.Strings = (
      '  select empresa_fac_sc,'
      '         serie_fac_sc, '
      '         n_factura_sc, '
      '         fecha_factura_sc, '
      '         cliente_fac_sc, '
      ''
      '         ( select porc_impuesto_f'
      '         from frf_facturas '
      '         where empresa_f = '#39'050'#39' '
      '           and fecha_factura_f = fecha_factura_sc '
      '           and n_factura_f = n_factura_sc ) por_iva,'
      ''
      '         ( select importe_neto_f neto '
      '         from frf_facturas '
      '         where empresa_f = '#39'050'#39' '
      '           and fecha_factura_f = fecha_factura_sc '
      '           and n_factura_f = n_factura_sc ) neto,'
      ''
      '         ( select total_impuesto_f neto '
      '         from frf_facturas '
      '         where empresa_f = '#39'050'#39' '
      '           and fecha_factura_f = fecha_factura_sc '
      '           and n_factura_f = n_factura_sc ) iva,'
      ''
      '         ( select importe_total_f neto '
      '         from frf_facturas '
      '         where empresa_f = '#39'050'#39' '
      '           and fecha_factura_f = fecha_factura_sc '
      '           and n_factura_f = n_factura_sc ) total,'
      ''
      '         ( select importe_euros_f neto '
      '         from frf_facturas'
      '         where empresa_f = '#39'050'#39' '
      '           and fecha_factura_f = fecha_factura_sc '
      '           and n_factura_f = n_factura_sc ) euros,'
      ''
      
        '         sum( case when producto_sl in ( select producto_p from ' +
        'frf_productos where empresa_p = '#39'050'#39' and estomate_p = '#39'S'#39' ) the' +
        'n kilos_sl else 0 end ) kilos_producto'
      ''
      '  from frf_salidas_c, frf_salidas_l '
      '  where empresa_sc = '#39'050'#39' '
      '  and fecha_sc between '#39'1/10/2005'#39' and '#39'1/10/2005'#39' '
      ''
      '  and n_factura_sc is not null '
      ''
      '  and empresa_sl = '#39'050'#39' '
      '  and centro_salida_sl = centro_salida_sc '
      '  and fecha_sl = fecha_sc '
      '  and n_albaran_sl = n_albaran_sc '
      ''
      ''
      
        '  group by n_factura_sc, fecha_factura_sc, cliente_fac_sc, 4, 5,' +
        ' 6, 7, 8'
      
        '  having sum( case when producto_sl in ( select producto_p from ' +
        'frf_productos where empresa_p = '#39'050'#39' and estomate_p = '#39'S'#39' ) the' +
        'n kilos_sl else 0 end ) > 0 '
      '  order by n_factura_sc, fecha_factura_sc, cliente_fac_sc')
    Left = 48
    Top = 88
  end
  object QAlbaranAgrupado: TQuery
    DatabaseName = 'BDProyecto'
    Left = 153
    Top = 88
  end
end
