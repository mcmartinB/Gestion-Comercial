object DMCosteMedioCompraFruta: TDMCosteMedioCompraFruta
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 913
  Top = 306
  Height = 287
  Width = 519
  object cdsCosteMedioCompra: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'empresa;producto'
    Params = <>
    Left = 64
    Top = 40
    object strngfldCosteMedioCompraempresa: TStringField
      FieldName = 'empresa'
      Size = 3
    end
    object strngfldCosteMedioCompraproducto: TStringField
      FieldName = 'producto'
      Size = 3
    end
    object dtfldCosteMedioComprafecha_ini: TDateField
      FieldName = 'fecha_ini'
    end
    object dtfldCosteMedioComprafecha_fin: TDateField
      FieldName = 'fecha_fin'
    end
    object intgrfldCosteMedioComprakilos: TIntegerField
      FieldName = 'kilos'
    end
    object fltfldCosteMedioCompraimporte: TFloatField
      FieldName = 'importe'
    end
    object fltfldCosteMedioCompragastos: TFloatField
      FieldName = 'gastos'
    end
    object fltfldCosteMedioCompraprecio: TFloatField
      FieldName = 'precio'
    end
  end
  object qryEntregas: TQuery
    DatabaseName = 'BDProyecto'
    SessionName = 'Default'
    SQL.Strings = (
      
        'SELECT cliente_sl cliente, n_albaran_sc albaran, envase_sl envas' +
        'e,'
      
        '       centro_salida_sc centro, fecha_sc fecha, moneda_sc moneda' +
        ','
      '       CASE WHEN producto_sl = '#39'E'#39' THEN 1 ELSE 0 END Transito,'
      '       SUM(kilos_sl) kilos_producto,'
      '       SUM(importe_neto_sl)*(1-(NVL(comision_r,0)/100)) neto'
      ''
      
        'FROM frf_salidas_c, frf_salidas_l, frf_clientes, frf_representan' +
        'tes'
      ''
      'WHERE empresa_sc = '#39'tpm'#39
      ''
      ''
      'group by cliente_sl, n_albaran_sc, envase_sl,'
      '       centro_salida_sc, fecha_sc, moneda_sc, comision_r, 7')
    Left = 176
    Top = 104
  end
  object qryGastos: TQuery
    DatabaseName = 'BDProyecto'
    SessionName = 'Default'
    SQL.Strings = (
      
        'SELECT cliente_sl cliente, n_albaran_sc albaran, envase_sl envas' +
        'e,'
      
        '       centro_salida_sc centro, fecha_sc fecha, moneda_sc moneda' +
        ','
      '       CASE WHEN producto_sl = '#39'E'#39' THEN 1 ELSE 0 END Transito,'
      '       SUM(kilos_sl) kilos_producto,'
      '       SUM(importe_neto_sl)*(1-(NVL(comision_r,0)/100)) neto'
      ''
      
        'FROM frf_salidas_c, frf_salidas_l, frf_clientes, frf_representan' +
        'tes'
      ''
      'WHERE empresa_sc = '#39'tpm'#39
      ''
      ''
      'group by cliente_sl, n_albaran_sc, envase_sl,'
      '       centro_salida_sc, fecha_sc, moneda_sc, comision_r, 7')
    Left = 288
    Top = 104
  end
  object qryFechaIni: TQuery
    DatabaseName = 'BDProyecto'
    SessionName = 'Default'
    SQL.Strings = (
      
        'SELECT cliente_sl cliente, n_albaran_sc albaran, envase_sl envas' +
        'e,'
      
        '       centro_salida_sc centro, fecha_sc fecha, moneda_sc moneda' +
        ','
      '       CASE WHEN producto_sl = '#39'E'#39' THEN 1 ELSE 0 END Transito,'
      '       SUM(kilos_sl) kilos_producto,'
      '       SUM(importe_neto_sl)*(1-(NVL(comision_r,0)/100)) neto'
      ''
      
        'FROM frf_salidas_c, frf_salidas_l, frf_clientes, frf_representan' +
        'tes'
      ''
      'WHERE empresa_sc = '#39'tpm'#39
      ''
      ''
      'group by cliente_sl, n_albaran_sc, envase_sl,'
      '       centro_salida_sc, fecha_sc, moneda_sc, comision_r, 7')
    Left = 64
    Top = 104
  end
end
