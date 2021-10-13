object DLAlbaranAPedido: TDLAlbaranAPedido
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 915
  Top = 170
  Height = 308
  Width = 627
  object QCabSalida: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'SELECT cliente_sl cliente_sal_sc, fecha_sl, categoria_sl, SUM(ca' +
        'jas_sl)as cajas,'
      
        '       SUM(kilos_sl)as kilos,n_albaran_sl, empresa_sl, envase_sl' +
        ','
      '       dir_sum_sc'
      ''
      'FROM frf_salidas_l, frf_salidas_c, frf_clientes'
      ''
      'WHERE'
      '        (empresa_sl = :empresa)'
      '   AND  (centro_origen_sl = :centro)'
      '   AND  (fecha_sl BETWEEN :fecha_d AND :fecha_h)'
      '   AND  (producto_sl = :producto)'
      '   AND  (cliente_sl BETWEEN :cliente_d AND :cliente_h)'
      ''
      '   AND  (empresa_sc = :empresa)'
      '   AND  (centro_salida_sc = centro_salida_sl)'
      '   AND  (n_albaran_sc = n_albaran_sl)'
      '   AND  (fecha_sc = fecha_sl)'
      '   AND  (fecha_sc BETWEEN :fecha_d AND :fecha_h)'
      '   AND  (cliente_sal_sc BETWEEN :cliente_d AND :cliente_h)'
      ''
      '   AND  (empresa_c = :empresa)'
      '   AND  (cliente_c = cliente_sl)'
      '   AND  (pais_c = '#39'ES'#39')'
      ''
      
        'GROUP BY cliente_sl,n_albaran_sl, fecha_sl, categoria_sl, empres' +
        'a_sl, envase_sl, dir_sum_sc'
      'ORDER BY cliente_sl, dir_sum_sc, fecha_sl,n_albaran_sl,envase_sl')
    Left = 32
    Top = 70
    ParamData = <
      item
        DataType = ftString
        Name = 'empresa'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'centro'
        ParamType = ptUnknown
      end
      item
        DataType = ftDate
        Name = 'fecha_d'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'fecha_h'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'producto'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'cliente_d'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cliente_h'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'empresa'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'fecha_d'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'fecha_h'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'cliente_d'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cliente_h'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'empresa'
        ParamType = ptInput
      end>
  end
  object DSCabEntradas: TDataSource
    DataSet = QCabSalida
    Left = 112
    Top = 72
  end
  object QLinSalida: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCabEntradas
    SQL.Strings = (
      
        'SELECT cliente_sl cliente_sal_sc, fecha_sl, categoria_sl, SUM(ca' +
        'jas_sl)as cajas,'
      
        '       SUM(kilos_sl)as kilos,n_albaran_sl, empresa_sl, envase_sl' +
        ','
      '       dir_sum_sc'
      ''
      'FROM frf_salidas_l, frf_salidas_c, frf_clientes'
      ''
      'WHERE'
      '        (empresa_sl = :empresa)'
      '   AND  (centro_origen_sl = :centro)'
      '   AND  (fecha_sl BETWEEN :fecha_d AND :fecha_h)'
      '   AND  (producto_sl = :producto)'
      '   AND  (cliente_sl BETWEEN :cliente_d AND :cliente_h)'
      ''
      '   AND  (empresa_sc = :empresa)'
      '   AND  (centro_salida_sc = centro_salida_sl)'
      '   AND  (n_albaran_sc = n_albaran_sl)'
      '   AND  (fecha_sc = fecha_sl)'
      '   AND  (fecha_sc BETWEEN :fecha_d AND :fecha_h)'
      '   AND  (cliente_sal_sc BETWEEN :cliente_d AND :cliente_h)'
      ''
      '   AND  (empresa_c = :empresa)'
      '   AND  (cliente_c = cliente_sl)'
      '   AND  (pais_c = '#39'ES'#39')'
      ''
      
        'GROUP BY cliente_sl,n_albaran_sl, fecha_sl, categoria_sl, empres' +
        'a_sl, envase_sl, dir_sum_sc'
      'ORDER BY cliente_sl, dir_sum_sc, fecha_sl,n_albaran_sl,envase_sl')
    Left = 192
    Top = 70
    ParamData = <
      item
        DataType = ftString
        Name = 'empresa'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'centro'
        ParamType = ptUnknown
      end
      item
        DataType = ftDate
        Name = 'fecha_d'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'fecha_h'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'producto'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'cliente_d'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cliente_h'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'empresa'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'fecha_d'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'fecha_h'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'cliente_d'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cliente_h'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'empresa'
        ParamType = ptInput
      end>
  end
  object QCabPedido: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCabEntradas
    RequestLive = True
    SQL.Strings = (
      
        'SELECT cliente_sl cliente_sal_sc, fecha_sl, categoria_sl, SUM(ca' +
        'jas_sl)as cajas,'
      
        '       SUM(kilos_sl)as kilos,n_albaran_sl, empresa_sl, envase_sl' +
        ','
      '       dir_sum_sc'
      ''
      'FROM frf_salidas_l, frf_salidas_c, frf_clientes'
      ''
      'WHERE'
      '        (empresa_sl = :empresa)'
      '   AND  (centro_origen_sl = :centro)'
      '   AND  (fecha_sl BETWEEN :fecha_d AND :fecha_h)'
      '   AND  (producto_sl = :producto)'
      '   AND  (cliente_sl BETWEEN :cliente_d AND :cliente_h)'
      ''
      '   AND  (empresa_sc = :empresa)'
      '   AND  (centro_salida_sc = centro_salida_sl)'
      '   AND  (n_albaran_sc = n_albaran_sl)'
      '   AND  (fecha_sc = fecha_sl)'
      '   AND  (fecha_sc BETWEEN :fecha_d AND :fecha_h)'
      '   AND  (cliente_sal_sc BETWEEN :cliente_d AND :cliente_h)'
      ''
      '   AND  (empresa_c = :empresa)'
      '   AND  (cliente_c = cliente_sl)'
      '   AND  (pais_c = '#39'ES'#39')'
      ''
      
        'GROUP BY cliente_sl,n_albaran_sl, fecha_sl, categoria_sl, empres' +
        'a_sl, envase_sl, dir_sum_sc'
      'ORDER BY cliente_sl, dir_sum_sc, fecha_sl,n_albaran_sl,envase_sl')
    Left = 192
    Top = 126
    ParamData = <
      item
        DataType = ftString
        Name = 'empresa'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'centro'
        ParamType = ptUnknown
      end
      item
        DataType = ftDate
        Name = 'fecha_d'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'fecha_h'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'producto'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'cliente_d'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cliente_h'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'empresa'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'fecha_d'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'fecha_h'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'cliente_d'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cliente_h'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'empresa'
        ParamType = ptInput
      end>
  end
  object QLinPedido: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      
        'SELECT cliente_sl cliente_sal_sc, fecha_sl, categoria_sl, SUM(ca' +
        'jas_sl)as cajas,'
      
        '       SUM(kilos_sl)as kilos,n_albaran_sl, empresa_sl, envase_sl' +
        ','
      '       dir_sum_sc'
      ''
      'FROM frf_salidas_l, frf_salidas_c, frf_clientes'
      ''
      'WHERE'
      '        (empresa_sl = :empresa)'
      '   AND  (centro_origen_sl = :centro)'
      '   AND  (fecha_sl BETWEEN :fecha_d AND :fecha_h)'
      '   AND  (producto_sl = :producto)'
      '   AND  (cliente_sl BETWEEN :cliente_d AND :cliente_h)'
      ''
      '   AND  (empresa_sc = :empresa)'
      '   AND  (centro_salida_sc = centro_salida_sl)'
      '   AND  (n_albaran_sc = n_albaran_sl)'
      '   AND  (fecha_sc = fecha_sl)'
      '   AND  (fecha_sc BETWEEN :fecha_d AND :fecha_h)'
      '   AND  (cliente_sal_sc BETWEEN :cliente_d AND :cliente_h)'
      ''
      '   AND  (empresa_c = :empresa)'
      '   AND  (cliente_c = cliente_sl)'
      '   AND  (pais_c = '#39'ES'#39')'
      ''
      
        'GROUP BY cliente_sl,n_albaran_sl, fecha_sl, categoria_sl, empres' +
        'a_sl, envase_sl, dir_sum_sc'
      'ORDER BY cliente_sl, dir_sum_sc, fecha_sl,n_albaran_sl,envase_sl')
    Left = 272
    Top = 126
    ParamData = <
      item
        DataType = ftString
        Name = 'empresa'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'centro'
        ParamType = ptUnknown
      end
      item
        DataType = ftDate
        Name = 'fecha_d'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'fecha_h'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'producto'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'cliente_d'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cliente_h'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'empresa'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'fecha_d'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'fecha_h'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'cliente_d'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cliente_h'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'empresa'
        ParamType = ptInput
      end>
  end
  object QNumeroPedido: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'SELECT cliente_sl cliente_sal_sc, fecha_sl, categoria_sl, SUM(ca' +
        'jas_sl)as cajas,'
      
        '       SUM(kilos_sl)as kilos,n_albaran_sl, empresa_sl, envase_sl' +
        ','
      '       dir_sum_sc'
      ''
      'FROM frf_salidas_l, frf_salidas_c, frf_clientes'
      ''
      'WHERE'
      '        (empresa_sl = :empresa)'
      '   AND  (centro_origen_sl = :centro)'
      '   AND  (fecha_sl BETWEEN :fecha_d AND :fecha_h)'
      '   AND  (producto_sl = :producto)'
      '   AND  (cliente_sl BETWEEN :cliente_d AND :cliente_h)'
      ''
      '   AND  (empresa_sc = :empresa)'
      '   AND  (centro_salida_sc = centro_salida_sl)'
      '   AND  (n_albaran_sc = n_albaran_sl)'
      '   AND  (fecha_sc = fecha_sl)'
      '   AND  (fecha_sc BETWEEN :fecha_d AND :fecha_h)'
      '   AND  (cliente_sal_sc BETWEEN :cliente_d AND :cliente_h)'
      ''
      '   AND  (empresa_c = :empresa)'
      '   AND  (cliente_c = cliente_sl)'
      '   AND  (pais_c = '#39'ES'#39')'
      ''
      
        'GROUP BY cliente_sl,n_albaran_sl, fecha_sl, categoria_sl, empres' +
        'a_sl, envase_sl, dir_sum_sc'
      'ORDER BY cliente_sl, dir_sum_sc, fecha_sl,n_albaran_sl,envase_sl')
    Left = 32
    Top = 14
    ParamData = <
      item
        DataType = ftString
        Name = 'empresa'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'centro'
        ParamType = ptUnknown
      end
      item
        DataType = ftDate
        Name = 'fecha_d'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'fecha_h'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'producto'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'cliente_d'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cliente_h'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'empresa'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'fecha_d'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'fecha_h'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'cliente_d'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cliente_h'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'empresa'
        ParamType = ptInput
      end>
  end
end
