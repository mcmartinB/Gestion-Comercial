object DMControlFob: TDMControlFob
  OldCreateOrder = False
  Left = 441
  Top = 227
  Height = 313
  Width = 499
  object QSalidas: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'select empresa_sl empresa, centro_salida_sl centro, fecha_sl fec' +
        'ha, n_albaran_sl referencia,  producto_sl producto,'
      '          0.0 kilos, 0.0 vendidos, 0 facturado'
      'from frf_salidas_l'
      'where empresa_sl = '#39'050'#39
      'and centro_salida_sl = '#39'6'#39
      'and centro_origen_sl = '#39'6'#39
      'and producto_sl = '#39'E'#39
      'and fecha_sl between '#39'21/2/2005'#39' and '#39'27/2/2005'#39
      'and ref_transitos_sl is null'
      ''
      
        'group by empresa_sl, centro_salida_sl, fecha_sl, n_albaran_sl, p' +
        'roducto_sl')
    Left = 56
    Top = 40
  end
  object CDSSalidas: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'empresa'
        Attributes = [faFixed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'centro'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'fecha'
        DataType = ftDate
      end
      item
        Name = 'referencia'
        DataType = ftInteger
      end
      item
        Name = 'producto'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'kilos'
        DataType = ftFloat
      end
      item
        Name = 'vendidos'
        DataType = ftFloat
      end
      item
        Name = 'facturado'
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'CDSSalidasIndexPrimaryKey'
        Fields = 'empresa;centro;fecha;referencia'
        Options = [ixPrimary, ixUnique]
      end>
    IndexName = 'CDSSalidasIndexPrimaryKey'
    Params = <>
    ProviderName = 'DSPSalidas'
    StoreDefs = True
    Left = 256
    Top = 40
    object CDSSalidasempresa: TStringField
      FieldName = 'empresa'
      FixedChar = True
      Size = 3
    end
    object CDSSalidascentro: TStringField
      FieldName = 'centro'
      FixedChar = True
      Size = 1
    end
    object CDSSalidasfecha: TDateField
      FieldName = 'fecha'
    end
    object CDSSalidasreferencia: TIntegerField
      FieldName = 'referencia'
    end
    object CDSSalidasproducto: TStringField
      DisplayWidth = 3
      FieldName = 'producto'
      FixedChar = True
      Size = 3
    end
    object CDSSalidaskilos: TFloatField
      FieldName = 'kilos'
      Precision = 2
    end
    object CDSSalidasvendidos: TFloatField
      FieldName = 'vendidos'
      Precision = 2
    end
    object CDSSalidasfacturado: TIntegerField
      FieldName = 'facturado'
    end
  end
  object DSSalidas: TDataSource
    AutoEdit = False
    DataSet = CDSSalidas
    Left = 344
    Top = 40
  end
  object DSPSalidas: TDataSetProvider
    DataSet = QSalidas
    Left = 152
    Top = 40
  end
  object QTransitos: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'select empresa_tl empresa, centro_tl centro, fecha_tl fecha, ref' +
        'erencia_tl referencia, producto_tl producto, 0.0 kilos, 0.0 vend' +
        'idos, 1 nivel'
      'from frf_transitos_l'
      'where empresa_tl = '#39'050'#39
      'and centro_tl = '#39'6'#39
      'and centro_origen_tl = '#39'6'#39
      'and producto_tl = '#39'E'#39
      'and fecha_tl between '#39'21/2/2005'#39' and '#39'27/2/2005'#39
      'and ref_origen_tl is null'
      ''
      
        'group by empresa_tl, centro_tl, fecha_tl, referencia_tl, product' +
        'o_tl')
    Left = 56
    Top = 96
  end
  object DSPTransitos: TDataSetProvider
    DataSet = QTransitos
    Left = 152
    Top = 96
  end
  object CDSTransitos: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'empresa'
        Attributes = [faFixed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'centro'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'fecha'
        DataType = ftDate
      end
      item
        Name = 'referencia'
        DataType = ftInteger
      end
      item
        Name = 'producto'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'kilos'
        DataType = ftFloat
      end
      item
        Name = 'vendidos'
        DataType = ftFloat
      end
      item
        Name = 'nivel'
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'CDSTransitosIndexPrimaryKey'
        Fields = 'empresa;centro;fecha;referencia'
        Options = [ixPrimary, ixUnique]
      end>
    IndexName = 'CDSTransitosIndexPrimaryKey'
    Params = <>
    ProviderName = 'DSPTransitos'
    StoreDefs = True
    Left = 256
    Top = 96
    object CDSTransitosempresa: TStringField
      FieldName = 'empresa'
      FixedChar = True
      Size = 3
    end
    object CDSTransitoscentro: TStringField
      FieldName = 'centro'
      FixedChar = True
      Size = 1
    end
    object CDSTransitosfecha: TDateField
      FieldName = 'fecha'
    end
    object CDSTransitosreferencia: TIntegerField
      FieldName = 'referencia'
    end
    object CDSTransitosproducto: TStringField
      DisplayWidth = 3
      FieldName = 'producto'
      FixedChar = True
      Size = 3
    end
    object CDSTransitoskilos: TFloatField
      FieldName = 'kilos'
      Precision = 2
    end
    object CDSTransitosvendidos: TFloatField
      FieldName = 'vendidos'
      Precision = 2
    end
    object CDSTransitosnivel: TIntegerField
      FieldName = 'nivel'
    end
  end
  object DSTransitos: TDataSource
    AutoEdit = False
    DataSet = CDSTransitos
    Left = 344
    Top = 96
  end
  object QSalidasTransito: TQuery
    DatabaseName = 'BDProyecto'
    Left = 56
    Top = 160
  end
  object QTransitosTransitos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 152
    Top = 160
  end
  object QSalidaFacturada: TQuery
    DatabaseName = 'BDProyecto'
    Left = 344
    Top = 160
  end
  object QKilosTransito: TQuery
    DatabaseName = 'BDProyecto'
    Left = 256
    Top = 160
  end
  object QKilosNoComerciales: TQuery
    DatabaseName = 'BDProyecto'
    Left = 56
    Top = 216
  end
end
