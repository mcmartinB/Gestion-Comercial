object DMLiqProdVendido: TDMLiqProdVendido
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 513
  Width = 588
  object kmtSemana: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexFieldNames = 'keySem'
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
    Left = 48
    Top = 36
  end
  object dsSemana: TDataSource
    DataSet = kmtSemana
    Left = 136
    Top = 32
  end
  object kmtEntradas: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexFieldNames = 'keySem;cosecero'
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    MasterFields = 'keySem'
    DetailFields = 'keySem'
    MasterSource = dsSemana
    Version = '5.51'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 248
    Top = 28
  end
  object kmtSalidas: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexFieldNames = 'keySem;cosecero'
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    MasterFields = 'keySem'
    DetailFields = 'keySem'
    MasterSource = dsSemana
    Version = '5.51'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 336
    Top = 28
  end
  object qryNuevoCodigo: TQuery
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 179
  end
  object kmtAjuste: TkbmMemTable
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
    Left = 248
    Top = 84
  end
  object kmtInOut: TkbmMemTable
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
    Left = 336
    Top = 84
  end
  object kmtLiquidaDet: TkbmMemTable
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
    Left = 48
    Top = 92
  end
  object qryReportPlanta: TQuery
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 259
  end
  object qryReportCos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 144
    Top = 259
  end
  object qryResumen: TQuery
    DatabaseName = 'BDProyecto'
    Left = 232
    Top = 259
  end
  object qryALiquidar: TQuery
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 315
  end
  object qryTransitoLlanos: TQuery
    DatabaseName = 'dbLlanos'
    Left = 408
    Top = 299
  end
  object qryTransitoCentral: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 408
    Top = 251
  end
  object qryTransitoMoradas: TQuery
    DatabaseName = 'dbMoradas'
    Left = 408
    Top = 347
  end
end
