object TransitosList_MD: TTransitosList_MD
  OldCreateOrder = False
  Height = 453
  Width = 542
  object QTransitos: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'select empresa_tl empresa, centro_tl centro, fecha_tl fecha, ref' +
        'erencia_tl referencia,'
      '       producto_tl producto, 0.0 kilos, 0.0 vendidos'
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
    Left = 40
    Top = 32
  end
  object DSPTransitos: TDataSetProvider
    DataSet = QTransitos
    Left = 136
    Top = 32
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
    Left = 240
    Top = 32
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
    end
    object CDSTransitosvendidos: TFloatField
      FieldName = 'vendidos'
    end
  end
  object DSTransitos: TDataSource
    AutoEdit = False
    DataSet = CDSTransitos
    Left = 328
    Top = 32
  end
  object QSalidasTransito: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 96
  end
  object QTransitosTransitos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 152
    Top = 96
  end
  object QDesgloseSalidas: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSTransitos
    SQL.Strings = (
      
        'select empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl,  cl' +
        'iente_sl, categoria_sl, n_factura_sc, fecha_factura_sc, sum(kilo' +
        's_sl) kilos_sl'
      'from frf_salidas_c, frf_salidas_l'
      'where fecha_sl = '#39'1/1/2005'#39
      'and empresa_sc = empresa_sl'
      'and centro_salida_sc = centro_salida_sl'
      'and n_albaran_sc = n_albaran_sl'
      'and fecha_sc = fecha_sl'
      
        'group by empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, c' +
        'liente_sl, categoria_sl, n_factura_sc, fecha_factura_sc')
    Left = 253
    Top = 93
  end
  object mtSalidasIndirectas: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'empresa'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'origen'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'transito'
        DataType = ftInteger
      end
      item
        Name = 'fecha_transito'
        DataType = ftDate
      end
      item
        Name = 'salida'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'albaran'
        DataType = ftInteger
      end
      item
        Name = 'fecha_albaran'
        DataType = ftDate
      end
      item
        Name = 'producto'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'cliente'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'categoria'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'kilos'
        DataType = ftFloat
      end>
    IndexFieldNames = 'empresa;origen;transito;fecha_transito'
    IndexName = 'mtSalidasIndirectasIndex'
    IndexDefs = <
      item
        Name = 'mtSalidasIndirectasIndex'
        Fields = 'empresa;origen;transito;fecha_transito'
      end>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    MasterFields = 'empresa;centro;referencia;fecha'
    MasterSource = DSTransitos
    Version = '5.51'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 160
    Top = 336
    object mtSalidasIndirectasempresa: TStringField
      FieldName = 'empresa'
      Size = 3
    end
    object mtSalidasIndirectasorigen: TStringField
      FieldName = 'origen'
      Size = 1
    end
    object mtSalidasIndirectastransito: TIntegerField
      FieldName = 'transito'
    end
    object mtSalidasIndirectasfecha_transito: TDateField
      FieldName = 'fecha_transito'
    end
    object mtSalidasIndirectassalida: TStringField
      FieldName = 'salida'
      Size = 1
    end
    object mtSalidasIndirectasalbaran: TIntegerField
      FieldName = 'albaran'
    end
    object mtSalidasIndirectasfecha_albaran: TDateField
      FieldName = 'fecha_albaran'
    end
    object mtSalidasIndirectasproducto: TStringField
      DisplayWidth = 3
      FieldName = 'producto'
      Size = 3
    end
    object mtSalidasIndirectascliente: TStringField
      FieldName = 'cliente'
      Size = 3
    end
    object mtSalidasIndirectascategoria: TStringField
      FieldName = 'categoria'
      Size = 2
    end
    object mtSalidasIndirectaskilos: TFloatField
      FieldName = 'kilos'
    end
  end
  object QTransitosIndirectos: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'select empresa_tl, centro_tl, centro_origen_tl, fecha_tl, refere' +
        'ncia_tl, producto_tl, sum(kilos_tl) kilos_tl'
      'from frf_transitos_l'
      'where empresa_tl = :empresa '
      'and centro_origen_tl = :centro'
      'and ref_origen_tl = :transito'
      'and fecha_origen_tl = :fecha'
      'and producto_tl = :producto'
      
        'group by empresa_tl, centro_tl, centro_origen_tl, fecha_tl, refe' +
        'rencia_tl, producto_tl'
      
        'order by empresa_tl, centro_tl, centro_origen_tl, fecha_tl, refe' +
        'rencia_tl, producto_tl')
    Left = 160
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'centro'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'transito'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'producto'
        ParamType = ptUnknown
      end>
  end
  object QTransitosEnTransitosIndirectos: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'select empresa_tl, centro_origen_tl, fecha_origen_tl, ref_origen' +
        '_tl, producto_tl, sum(kilos_tl) kilos_tl'
      'from frf_transitos_l'
      'where empresa_tl = :empresa'
      'and centro_tl = :centro'
      'and referencia_tl = :transito'
      'and fecha_tl = :fecha'
      'and producto_tl = :producto'
      'and ref_origen_tl is not null'
      
        'group by empresa_tl, centro_origen_tl, fecha_origen_tl, ref_orig' +
        'en_tl, producto_tl'
      
        'order by empresa_tl, centro_origen_tl, fecha_origen_tl, ref_orig' +
        'en_tl, producto_tl')
    Left = 160
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'centro'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'transito'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'producto'
        ParamType = ptUnknown
      end>
  end
  object QSalidasTransitosIndirectos: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'select empresa_sl, centro_salida_sl, fecha_sl, n_albaran_sl, pro' +
        'ducto_sl, cliente_sl, categoria_sl, sum(kilos_sl) kilos_sl '
      'from frf_salidas_l'
      'where empresa_sl = :empresa'
      'and centro_origen_sl = :centro'
      'and ref_transitos_sl = :transito'
      'and fecha_sl between :fechaini and :fechafin'
      'and producto_sl = :producto'
      
        'group by empresa_sl, centro_salida_sl, fecha_sl, n_albaran_sl, p' +
        'roducto_sl, cliente_sl, categoria_sl'
      
        'order by empresa_sl, centro_salida_sl, fecha_sl, n_albaran_sl, p' +
        'roducto_sl, cliente_sl, categoria_sl')
    Left = 160
    Top = 280
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'centro'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'transito'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fechaini'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fechafin'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'producto'
        ParamType = ptUnknown
      end>
  end
  object QDesgloseTransitos: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSTransitos
    SQL.Strings = (
      
        'select centro_tl centro, referencia_tl referencia, fecha_tl fech' +
        'a_tl, centro_destino_tl destino, categoria_tl categoria, sum(kil' +
        'os_tl) kilos'
      'from frf_transitos_l'
      
        'group by centro_tl, referencia_tl, fecha_tl, categoria_tl, centr' +
        'o_destino_tl')
    Left = 349
    Top = 93
    object QDesgloseTransitoscentro: TStringField
      FieldName = 'centro'
      Origin = 'COMERCIALIZACION.frf_transitos_l.centro_tl'
      FixedChar = True
      Size = 1
    end
    object QDesgloseTransitosreferencia: TIntegerField
      FieldName = 'referencia'
      Origin = 'COMERCIALIZACION.frf_transitos_l.referencia_tl'
    end
    object QDesgloseTransitosfecha_tl: TDateField
      FieldName = 'fecha_tl'
      Origin = 'COMERCIALIZACION.frf_transitos_l.fecha_tl'
    end
    object QDesgloseTransitosdestino: TStringField
      FieldName = 'destino'
      Origin = 'COMERCIALIZACION.frf_transitos_l.centro_destino_tl'
      FixedChar = True
      Size = 1
    end
    object QDesgloseTransitoscategoria: TStringField
      FieldName = 'categoria'
      Origin = 'COMERCIALIZACION.frf_transitos_l.categoria_tl'
      FixedChar = True
      Size = 2
    end
    object QDesgloseTransitoskilos: TFloatField
      FieldName = 'kilos'
      Origin = 'COMERCIALIZACION.frf_transitos_l.kilos_tl'
    end
  end
end
