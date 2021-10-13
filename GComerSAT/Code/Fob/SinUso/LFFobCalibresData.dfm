object FFobCalibresData: TFFobCalibresData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 507
  Top = 301
  Height = 427
  Width = 520
  object QSalidas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 136
  end
  object kbmSalidasLin: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexFieldNames = 'cab'
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    MasterFields = 'cab'
    MasterSource = DSSalidas
    Version = '4.08b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 176
    Top = 32
  end
  object kbmSalidasCab: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '4.08b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 48
    Top = 32
  end
  object DSSalidas: TDataSource
    DataSet = kbmSalidasCab
    Left = 112
    Top = 48
  end
  object QGastos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 184
  end
  object QCosteEnvase: TQuery
    DatabaseName = 'BDProyecto'
    SessionName = 'Default'
    Left = 264
    Top = 176
  end
  object QProductoBase: TQuery
    DatabaseName = 'BDProyecto'
    SessionName = 'Default'
    Left = 264
    Top = 128
  end
  object QDescuentos: TQuery
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
    Left = 110
    Top = 136
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
  object kbmDescuentos: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '4.08b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 110
    Top = 184
  end
  object kbmPorCalibres: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '4.08b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 44
    Top = 272
  end
end
