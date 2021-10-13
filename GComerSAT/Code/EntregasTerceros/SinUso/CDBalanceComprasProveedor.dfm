object DBalanceComprasProveedor: TDBalanceComprasProveedor
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 704
  Top = 210
  Height = 433
  Width = 696
  object QGastosEntregas: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSEntregas
    Left = 200
    Top = 32
  end
  object QSalidasEntregas: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSEntregas
    Left = 200
    Top = 96
  end
  object QEntregas: TQuery
    AfterOpen = QEntregasAfterOpen
    BeforeClose = QEntregasBeforeClose
    DatabaseName = 'BDProyecto'
    Left = 24
    Top = 32
  end
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
    Left = 16
    Top = 192
  end
  object DataSetProvider: TDataSetProvider
    DataSet = Query
    Left = 96
    Top = 192
  end
  object ClientDataSet: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'envase;cliente;albaran;calibre'
    Params = <>
    ProviderName = 'DataSetProvider'
    Left = 176
    Top = 192
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
  object QCambio: TQuery
    DatabaseName = 'BDProyecto'
    SessionName = 'Default'
    SQL.Strings = (
      'select first 1 fecha_ce, cambio_ce'
      'from frf_cambios_euros'
      'where moneda_ce = :moneda'
      'and fecha_ce < :fecha'
      'order by fecha_ce desc')
    Left = 16
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'moneda'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha'
        ParamType = ptUnknown
      end>
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
    Left = 64
    Top = 248
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
    Left = 120
    Top = 248
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
    Left = 328
    Top = 248
  end
  object QCosteEnvase: TQuery
    DatabaseName = 'BDProyecto'
    SessionName = 'Default'
    Left = 416
    Top = 248
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
    Left = 240
    Top = 248
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
  object mtSalidasValoradas: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexFieldNames = 'entrega'
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    MasterFields = 'entrega'
    DetailFields = 'entrega'
    MasterSource = DSEntregas
    Version = '4.08b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 312
    Top = 96
  end
  object DSEntregas: TDataSource
    DataSet = QEntregas
    Left = 112
    Top = 32
  end
end
