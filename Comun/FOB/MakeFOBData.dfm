object DMMakeFOBData: TDMMakeFOBData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 700
  Width = 908
  object qryDatosAlbaran: TQuery
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
    Left = 72
    Top = 32
  end
  object DataSource: TDataSource
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
    Left = 248
    Top = 80
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
    Left = 240
    Top = 264
  end
  object QCosteEnvase: TQuery
    DatabaseName = 'BDProyecto'
    SessionName = 'Default'
    Left = 376
    Top = 80
  end
  object qryFacturasManuales: TQuery
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
    Left = 246
    Top = 137
  end
  object qryGastoAlbaran: TQuery
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
    Left = 243
    Top = 203
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
  object kmtCostesEnvasado: TkbmMemTable
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
    Left = 376
    Top = 209
  end
  object qryCosteSeccion: TQuery
    DatabaseName = 'BDProyecto'
    SessionName = 'Default'
    Left = 376
    Top = 136
  end
  object dbAuxSAT: TDatabase
    DatabaseName = 'dbAuxSAT'
    DriverName = 'INFORMIX'
    LoginPrompt = False
    Params.Strings = (
      'SERVER NAME=iserver1'
      'DATABASE NAME=comersat'
      'USER NAME=informix'
      'OPEN MODE=READ/WRITE'
      'SCHEMA CACHE SIZE=8'
      'LANGDRIVER=DB850ES0'
      'SQLQRYMODE=SERVER'
      'SQLPASSTHRU MODE=SHARED AUTOCOMMIT'
      'LOCK MODE=5'
      'DATE MODE=1'
      'DATE SEPARATOR=/'
      'SCHEMA CACHE TIME=-1'
      'MAX ROWS=-1'
      'BATCH COUNT=200'
      'ENABLE SCHEMA CACHE=FALSE'
      'SCHEMA CACHE DIR='
      'ENABLE BCD=FALSE'
      'LIST SYNONYMS=NONE'
      'DBNLS='
      'COLLCHAR='
      'BLOBS TO CACHE=64'
      'BLOB SIZE=32'
      'PASSWORD=informix')
    SessionName = 'Default'
    Left = 56
    Top = 440
  end
  object qryGastosTransitosSAT: TQuery
    DatabaseName = 'dbAuxSAT'
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
    Left = 115
    Top = 467
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
  object kmtTransitosSAT_BAG: TkbmMemTable
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
    Left = 184
    Top = 417
  end
  object qryKilosTransitosSAT: TQuery
    DatabaseName = 'dbAuxSAT'
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
    Left = 251
    Top = 467
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
  object qryTotalesBAG: TQuery
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
    Left = 371
    Top = 467
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
  object qryRelEnvases: TQuery
    DatabaseName = 'BDProyecto'
    SessionName = 'Default'
    Left = 248
    Top = 536
  end
  object qryCosteEnvaseSAT: TQuery
    DatabaseName = 'dbAuxSAT'
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
    Left = 115
    Top = 539
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
  object qryTablaMasterFOB: TQuery
    DatabaseName = 'dbMaster'
    RequestLive = True
    SQL.Strings = (
      'select * from tfob_data')
    Left = 72
    Top = 96
  end
  object qryCodFactura: TQuery
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
    Left = 480
    Top = 80
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
end
