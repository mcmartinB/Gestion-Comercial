object DLGastosEntregas: TDLGastosEntregas
  OldCreateOrder = False
  Height = 315
  Width = 370
  object QListado: TQuery
    AfterOpen = QListadoAfterOpen
    BeforeClose = QListadoBeforeClose
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select empresa_ec, proveedor_ec, fecha_llegada_ec, codigo_ec'
      'from frf_entregas_c'
      'where empresa_ec = :empresa'
      'and centro_llegada_ec = :centro'
      'and proveedor_ec = :proveedor'
      'and exists'
      '('
      'select *'
      'from frf_entregas_l'
      'where codigo_el = codigo_ec'
      'and producto_el = :producto'
      ')'
      'and exists'
      '('
      'select *'
      'from frf_gastos_entregas'
      'where codigo_ge = codigo_ec'
      'and nvl(pagado_ge,0) = 0'
      ')'
      'group by codigo_ec, empresa_ec, proveedor_ec, fecha_llegada_ec'
      'order by empresa_ec, proveedor_ec, codigo_ec')
    Left = 32
    Top = 40
    ParamData = <
      item
        DataType = ftString
        Name = 'empresa'
        ParamType = ptUnknown
        Value = #39'050'#39
      end
      item
        DataType = ftString
        Name = 'centro'
        ParamType = ptUnknown
        Value = #39'1'#39
      end
      item
        DataType = ftString
        Name = 'proveedor'
        ParamType = ptUnknown
        Value = #39'015'#39
      end
      item
        DataType = ftString
        Name = 'producto'
        ParamType = ptUnknown
        Value = #39'T'#39
      end>
  end
  object QDetalleGasto: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DataSource
    Left = 208
    Top = 104
  end
  object DataSource: TDataSource
    DataSet = QListado
    Left = 120
    Top = 40
  end
  object QDetalleLinea: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DataSource
    SQL.Strings = (
      
        'select producto_el, sum(kilos_el) kilos_el, round(sum(kilos_el*p' +
        'recio_kg_el),2) importe_el'
      'from frf_entregas_l'
      'where codigo_el = :codigo_ec'
      'group by producto_el'
      'order by producto_el')
    Left = 208
    Top = 40
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'codigo_ec'
        ParamType = ptUnknown
        Size = 13
      end>
  end
  object qryTabla: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select empresa_ec, proveedor_ec, fecha_llegada_ec, codigo_ec'
      'from frf_entregas_c'
      'where empresa_ec = :empresa'
      'and centro_llegada_ec = :centro'
      'and proveedor_ec = :proveedor'
      'and exists'
      '('
      'select *'
      'from frf_entregas_l'
      'where codigo_el = codigo_ec'
      'and producto_el = :producto'
      ')'
      'and exists'
      '('
      'select *'
      'from frf_gastos_entregas'
      'where codigo_ge = codigo_ec'
      'and nvl(pagado_ge,0) = 0'
      ')'
      'group by codigo_ec, empresa_ec, proveedor_ec, fecha_llegada_ec'
      'order by empresa_ec, proveedor_ec, codigo_ec')
    Left = 32
    Top = 91
    ParamData = <
      item
        DataType = ftString
        Name = 'empresa'
        ParamType = ptUnknown
        Value = #39'050'#39
      end
      item
        DataType = ftString
        Name = 'centro'
        ParamType = ptUnknown
        Value = #39'1'#39
      end
      item
        DataType = ftString
        Name = 'proveedor'
        ParamType = ptUnknown
        Value = #39'015'#39
      end
      item
        DataType = ftString
        Name = 'producto'
        ParamType = ptUnknown
        Value = #39'T'#39
      end>
  end
end
