object DLVentasFobCliente: TDLVentasFobCliente
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 376
  Width = 523
  object Query: TQuery
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
    Left = 8
    Top = 16
  end
  object DataSetProvider: TDataSetProvider
    DataSet = Query
    Left = 88
    Top = 16
  end
  object ClientDataSet: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'envase;cliente;albaran;calibre'
    Params = <>
    ProviderName = 'DataSetProvider'
    Left = 168
    Top = 16
    object ClientDataSetcliente: TStringField
      FieldName = 'cliente'
      FixedChar = True
      Size = 3
    end
    object ClientDataSetproducto: TStringField
      DisplayWidth = 3
      FieldName = 'producto'
      Size = 3
    end
    object ClientDataSetalbaran: TIntegerField
      FieldName = 'albaran'
    end
    object ClientDataSetenvase: TStringField
      DisplayWidth = 3
      FieldName = 'envase'
      FixedChar = True
      Size = 3
    end
    object ClientDataSetcentro: TStringField
      FieldName = 'centro'
      FixedChar = True
      Size = 1
    end
    object ClientDataSetfecha: TDateField
      FieldName = 'fecha'
    end
    object ClientDataSetmoneda: TStringField
      FieldName = 'moneda'
      FixedChar = True
      Size = 3
    end
    object ClientDataSetcambio: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'cambio'
    end
    object ClientDataSetcategoria: TStringField
      FieldName = 'categoria'
      Size = 2
    end
    object ClientDataSetcalibre: TStringField
      FieldName = 'calibre'
      Size = 6
    end
    object ClientDataSetkilos_producto: TFloatField
      FieldName = 'kilos_producto'
    end
    object ClientDataSetkilos_transito: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'kilos_transito'
    end
    object ClientDataSetkilos_total: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'kilos_total'
    end
    object ClientDataSetneto: TFloatField
      FieldName = 'neto'
    end
    object ClientDataSetgasto_comun: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'gasto_comun'
    end
    object ClientDataSetgasto_transito: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'gasto_transito'
    end
    object ClientDataSetcoste_envase: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'coste_envase'
    end
    object ClientDataSettransito: TIntegerField
      FieldName = 'transito'
    end
    object ClientDataSetcoste_envasado: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'coste_envasado'
    end
    object ClientDataSetcentro_origen: TStringField
      FieldName = 'centro_origen'
      Size = 1
    end
    object ClientDataSetcoste_seccion: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'coste_seccion'
    end
  end
  object DataSource: TDataSource
    DataSet = ClientDataSet
    Left = 248
    Top = 16
  end
  object QKilos: TQuery
    DatabaseName = 'BDProyecto'
    SessionName = 'Default'
    SQL.Strings = (
      'select sum(kilos_sl) total,'
      
        '       sum(case when producto_sl = '#39'E'#39' then kilos_sl else 0 end)' +
        ' transito'
      'from frf_salidas_l'
      'where empresa_sl = :empresa'
      'and centro_salida_sl = :centro'
      'and n_albaran_sl = :albaran'
      'and fecha_sl = :fecha')
    Left = 56
    Top = 72
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
        Name = 'albaran'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha'
        ParamType = ptUnknown
      end>
  end
  object QGastosGenerales: TQuery
    DatabaseName = 'BDProyecto'
    SessionName = 'Default'
    SQL.Strings = (
      
        'select SUM((CASE WHEN tipo_g <> '#39'011'#39' and tipo_g <> '#39'012'#39' THEN i' +
        'mporte_g ELSE 0 END) *'
      
        '           (CASE WHEN facturable_tg = '#39'S'#39' THEN -1 ELSE 1 END)) g' +
        'asto_comun,'
      
        '       SUM((CASE WHEN tipo_g = '#39'011'#39' or tipo_g = '#39'012'#39'THEN impor' +
        'te_g ELSE 0 END) *'
      
        '           (CASE WHEN facturable_tg = '#39'S'#39' THEN -1 ELSE 1 END))ga' +
        'sto_transito'
      'from frf_gastos, frf_tipo_gastos'
      'where empresa_g = :empresa'
      'and centro_salida_g = :centro'
      'and n_albaran_g = :albaran'
      'and fecha_g = :fecha'
      'and tipo_tg = tipo_g '
      'and descontar_fob_tg = '#39'S'#39)
    Left = 112
    Top = 72
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
        Name = 'albaran'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha'
        ParamType = ptUnknown
      end>
  end
  object QProductoBase: TQuery
    DatabaseName = 'BDProyecto'
    SessionName = 'Default'
    Left = 320
    Top = 72
  end
  object QCosteEnvase: TQuery
    DatabaseName = 'BDProyecto'
    SessionName = 'Default'
    Left = 408
    Top = 72
  end
  object QGastosProducto: TQuery
    DatabaseName = 'BDProyecto'
    SessionName = 'Default'
    SQL.Strings = (
      
        'select SUM((CASE WHEN tipo_g <> '#39'011'#39' and tipo_g <> '#39'012'#39' THEN i' +
        'mporte_g ELSE 0 END) *'
      
        '           (CASE WHEN facturable_tg = '#39'S'#39' THEN -1 ELSE 1 END)) g' +
        'asto_comun,'
      
        '       SUM((CASE WHEN tipo_g = '#39'011'#39' or tipo_g = '#39'012'#39'THEN impor' +
        'te_g ELSE 0 END) *'
      
        '           (CASE WHEN facturable_tg = '#39'S'#39' THEN -1 ELSE 1 END))ga' +
        'sto_transito'
      'from frf_gastos, frf_tipo_gastos'
      'where empresa_g = :empresa'
      'and centro_salida_g = :centro'
      'and n_albaran_g = :albaran'
      'and fecha_g = :fecha'
      'and tipo_tg = tipo_g '
      'and descontar_fob_tg = '#39'S'#39)
    Left = 232
    Top = 72
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
        Name = 'albaran'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha'
        ParamType = ptUnknown
      end>
  end
  object mtListado: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
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
    Left = 56
    Top = 136
  end
end
