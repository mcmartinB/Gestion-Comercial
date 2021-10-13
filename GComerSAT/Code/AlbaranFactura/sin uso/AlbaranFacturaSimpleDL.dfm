object DLAlbaranFacturaSimple: TDLAlbaranFacturaSimple
  OldCreateOrder = False
  Left = 494
  Top = 203
  Height = 150
  Width = 215
  object QAlbaranFactura: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'select moneda_sc, fecha_sc, n_albaran_sc, fecha_factura_sc, n_fa' +
        'ctura_sc, importe_neto_f, producto_sl, sum(kilos_sl) kilos_sl'
      'from frf_salidas, outer frf_facturas, frf_salidas_l'
      'where empresa_sc = '#39'050'#39
      'and cliente_sal_sc = '#39'FG'#39
      'and fecha_sc between '#39'1/3/2005'#39' and '#39'14/4/2005'#39
      'and empresa_f = '#39'050'#39
      'and n_factura_f = n_factura_sc'
      'and fecha_factura_f = fecha_factura_sc'
      'and empresa_sl = '#39'050'#39
      'and centro_salida_sl = centro_salida_sc'
      'and fecha_sl = fecha_sc'
      'and n_albaran_sl = n_albaran_sc'
      
        'group by moneda_sc, fecha_sc, n_albaran_sc, fecha_factura_sc, n_' +
        'factura_sc, importe_neto_f, producto_sl'
      'order by moneda_sc, fecha_sc, n_albaran_sc, producto_sl')
    Left = 48
    Top = 24
    object QAlbaranFacturamoneda_sc: TStringField
      FieldName = 'moneda_sc'
      FixedChar = True
      Size = 3
    end
    object QAlbaranFacturafecha_sc: TDateField
      FieldName = 'fecha_sc'
    end
    object QAlbaranFacturan_albaran_sc: TIntegerField
      FieldName = 'n_albaran_sc'
    end
    object QAlbaranFacturafecha_factura_sc: TDateField
      FieldName = 'fecha_factura_sc'
    end
    object QAlbaranFacturan_factura_sc: TIntegerField
      FieldName = 'n_factura_sc'
    end
    object QAlbaranFacturaimporte_neto_f: TFloatField
      FieldName = 'importe_neto_f'
    end
    object QAlbaranFacturaproducto_sl: TStringField
      DisplayWidth = 3
      FieldName = 'producto_sl'
      FixedChar = True
      Size = 3
    end
    object QAlbaranFacturakilos_sl: TFloatField
      FieldName = 'kilos_sl'
    end
  end
end
