object DMTablaTemporalFOB: TDMTablaTemporalFOB
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 700
  Width = 908
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
    FieldDefs = <
      item
        Name = 'cliente'
        Attributes = [faFixed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'albaran'
        DataType = ftInteger
      end
      item
        Name = 'envase'
        Attributes = [faFixed]
        DataType = ftString
        Size = 9
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
        Name = 'moneda'
        Attributes = [faFixed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'transito'
        DataType = ftInteger
      end
      item
        Name = 'kilos_producto'
        DataType = ftFloat
      end
      item
        Name = 'neto'
        DataType = ftFloat
      end>
    IndexDefs = <>
    IndexFieldNames = 'envase;cliente;albaran;calibre'
    Params = <>
    ProviderName = 'DataSetProvider'
    StoreDefs = True
    Left = 168
    Top = 24
    object strngfldClientDataSetempresa: TStringField
      FieldName = 'empresa'
      Size = 3
    end
    object ClientDataSetcentro_origen: TStringField
      FieldName = 'centro_origen'
      Size = 1
    end
    object ClientDataSetcentro: TStringField
      FieldName = 'centro'
      FixedChar = True
      Size = 1
    end
    object ClientDataSetcliente: TStringField
      FieldName = 'cliente'
      FixedChar = True
      Size = 3
    end
    object strngfldClientDataSetsuministro: TStringField
      FieldName = 'suministro'
      Size = 3
    end
    object ClientDataSetalbaran: TIntegerField
      FieldName = 'albaran'
    end
    object ClientDataSetfecha_albaran: TDateField
      FieldName = 'fecha_albaran'
    end
    object ClientDataSetpais: TStringField
      FieldName = 'pais'
    end
    object ClientDataSetfecha: TDateField
      FieldName = 'fecha'
    end
    object ClientDataSetproducto: TStringField
      DisplayWidth = 3
      FieldName = 'producto'
      Size = 3
    end
    object ClientDataSetagrupacion: TStringField
      DisplayWidth = 30
      FieldName = 'agrupacion'
      FixedChar = True
      Size = 30
    end
    object ClientDataSetlinea: TStringField
      FieldName = 'linea'
    end
    object strngfldClientDataSetperiodoFact: TStringField
      FieldName = 'periodoFact'
      Size = 30
    end
    object ClientDataSetenvase: TStringField
      DisplayWidth = 9
      FieldName = 'envase'
      FixedChar = True
      Size = 9
    end
    object ClientDataSetcategoria: TStringField
      FieldName = 'categoria'
      Size = 2
    end
    object ClientDataSetcalibre: TStringField
      FieldName = 'calibre'
      Size = 6
    end
    object ClientDataSetpalets_producto: TFloatField
      FieldName = 'palets_producto'
    end
    object ClientDataSetkilos_producto: TFloatField
      FieldName = 'kilos_producto'
    end
    object ClientDataSetcajas_producto: TFloatField
      FieldName = 'cajas_producto'
    end
    object fltfldClientDataSetunidades_producto: TFloatField
      FieldName = 'unidades_producto'
    end
    object ClientDataSetkilos_total: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'kilos_total'
    end
    object ClientDataSettransito: TIntegerField
      FieldName = 'transito'
    end
    object ClientDataSetkilos_transito: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'kilos_transito'
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
    object ClientDataSetimporte: TFloatField
      FieldName = 'importe'
    end
    object ClientDataSetimporte_total: TFloatField
      FieldName = 'importe_total'
    end
    object ClientDataSetcomision: TFloatField
      FieldName = 'comision'
    end
    object ClientDataSetdescuento: TFloatField
      FieldName = 'descuento'
    end
    object fltfldClientDataSetgasto_fac: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'gasto_fac'
    end
    object fltfldClientDataSetgasto_no_fac: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'gasto_no_fac'
    end
    object ClientDataSetgasto_comun: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'gasto_comun'
    end
    object ClientDataSetgasto_transito: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'gasto_transito'
    end
    object fltfldClientDataSetcoste_envase: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'coste_envase'
    end
    object fltfldClientDataSetcoste_seccion: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'coste_seccion'
    end
    object ClientDataSetcoste_envasado: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'coste_envasado'
    end
    object fltfldClientDataSetcoste_fruta: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'coste_fruta'
    end
    object fltfldClientDataSetcoste_estructura: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'coste_estructura'
    end
    object fltfldClientDataSetneto: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'neto'
    end
    object ClientDataSetfacturado: TIntegerField
      FieldName = 'facturado'
    end
    object strngfldClientDataSetcomercial: TStringField
      FieldName = 'comercial'
      Size = 3
    end
    object fltfldClientDataSetdes_fac_importe: TFloatField
      FieldName = 'des_fac_importe'
    end
    object fltfldClientDataSetdes_fac_kilos: TFloatField
      FieldName = 'des_fac_kilos'
    end
    object ClientDataSetdes_fac_pale: TFloatField
      FieldName = 'des_fac_pale'
    end
    object fltfldClientDataSetcomision_representante: TFloatField
      FieldName = 'comision_representante'
    end
    object fltfldClientDataSetdes_no_fac_importe: TFloatField
      FieldName = 'des_no_fac_importe'
    end
    object fltfldClientDataSetdes_no_fac_kilos: TFloatField
      FieldName = 'des_no_fac_kilos'
    end
    object ClientDataSetdes_no_fac_pale: TFloatField
      FieldName = 'des_no_fac_pale'
    end
    object ClientDataSetdes_no_fac_importe_neto: TFloatField
      FieldName = 'des_no_fac_importe_neto'
    end
    object fltfldClientDataSetayudas_fruta: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'ayudas_fruta'
    end
    object iClientDataSettipo_salida: TIntegerField
      FieldName = 'tipo_salida'
    end
    object ClientDataSetgas_no_facturable: TFloatField
      FieldName = 'gas_no_facturable'
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
    Top = 281
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
    Left = 64
    Top = 424
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
  object kmtAyudas: TkbmMemTable
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
    Left = 640
    Top = 401
  end
  object qryAyudasSAT: TQuery
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
    Left = 587
    Top = 451
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
  object qryDatosTransitos: TQuery
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
    Left = 643
    Top = 475
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
  object qryDatosClienteBAG: TQuery
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
    Left = 651
    Top = 531
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
  object qryDatosPlantaBAG: TQuery
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
    Left = 635
    Top = 323
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
  object qryAux: TQuery
    DatabaseName = 'BDProyecto'
    Left = 18
    Top = 95
  end
end
