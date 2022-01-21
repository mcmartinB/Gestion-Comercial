object DLLiquidaEntrega: TDLLiquidaEntrega
  OldCreateOrder = False
  OnCreate = DMOnCreate
  OnDestroy = DataModuleDestroy
  Height = 594
  Width = 824
  object qryEntregas: TQuery
    AfterOpen = qryEntregasAfterOpen
    BeforeClose = qryEntregasBeforeClose
    DatabaseName = 'BDProyecto'
    Left = 387
    Top = 56
  end
  object dsEntregas: TDataSource
    DataSet = qryEntregas
    Left = 449
    Top = 56
  end
  object qryEntregasLin: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = dsEntregas
    Left = 383
    Top = 115
  end
  object dsEntregasLin: TDataSource
    DataSet = qryEntregasLin
    Left = 449
    Top = 120
  end
  object qryPaletsPB: TQuery
    DatabaseName = 'dbF17'
    DataSource = dsEntregas
    Left = 566
    Top = 55
  end
  object dsPaletsPB: TDataSource
    DataSet = qryPaletsPB
    Left = 620
    Top = 51
  end
  object qryOrdenCarga: TQuery
    DatabaseName = 'dbF17'
    Left = 566
    Top = 104
  end
  object qryEnvase: TQuery
    DatabaseName = 'dbF17'
    Left = 565
    Top = 156
  end
  object kmtPalet: TkbmMemTable
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
    Left = 72
    Top = 67
  end
  object kmtLiquidacion: TkbmMemTable
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
    Left = 75
    Top = 127
  end
  object kmtGastosTransito: TkbmMemTable
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
    Left = 179
    Top = 317
  end
  object qryGastosEntrega: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = dsEntregas
    Left = 382
    Top = 253
  end
  object qryFechaSalida: TQuery
    DatabaseName = 'dbF17'
    Left = 564
    Top = 210
  end
  object qryKilosTeoricosLinea: TQuery
    DatabaseName = 'BDProyecto'
    Left = 379
    Top = 307
  end
  object kmtResumen: TkbmMemTable
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
    Left = 74
    Top = 188
  end
  object qrySalidasLin: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = dsEntregas
    Left = 381
    Top = 175
  end
  object kmtTransitos: TkbmMemTable
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
    Left = 151
    Top = 69
  end
  object kmtPrecioFOB: TkbmMemTable
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
    Left = 86
    Top = 317
  end
  object kmtKilosTeoricos: TkbmMemTable
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
    Left = 85
    Top = 377
  end
  object qryKilosVariedadRF: TQuery
    DatabaseName = 'BDProyecto'
    Left = 566
    Top = 312
  end
  object qryEntregasProveedor: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = dsEntregas
    Left = 450
    Top = 266
  end
  object kmtClientes: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 2
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
    Left = 155
    Top = 186
  end
  object qryFechaAlbaranCliente: TQuery
    DatabaseName = 'dbF17'
    Left = 380
    Top = 410
  end
  object kmtResumen2: TkbmMemTable
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
    Left = 74
    Top = 244
  end
  object qryEuroKilo: TQuery
    DatabaseName = 'BDProyecto'
    Left = 510
    Top = 373
  end
  object kmtEuroKilo: TkbmMemTable
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
    Left = 195
    Top = 405
  end
  object kmtCostesProv: TkbmMemTable
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
    Left = 203
    Top = 485
  end
  object qryCostesProv: TQuery
    DatabaseName = 'BDProyecto'
    Left = 518
    Top = 437
  end
  object qryKilosDestrioTfe: TQuery
    DatabaseName = 'BDProyecto'
    Left = 518
    Top = 501
  end
  object kmtKilosDestrioTfe: TkbmMemTable
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
    Left = 197
    Top = 537
  end
  object qryAux: TQuery
    DatabaseName = 'BDProyecto'
    Left = 752
    Top = 128
  end
end
