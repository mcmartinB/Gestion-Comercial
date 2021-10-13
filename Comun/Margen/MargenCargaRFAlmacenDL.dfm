object DLMargenCargaRFAlmacen: TDLMargenCargaRFAlmacen
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 594
  Width = 824
  object qryEntregas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 329
    Top = 252
  end
  object dsEntregas: TDataSource
    DataSet = qryEntregasRF
    Left = 392
    Top = 81
  end
  object qryEntregasLin: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = dsEntregas
    Left = 373
    Top = 303
  end
  object dsEntregasLin: TDataSource
    DataSet = qryEntregasLin
    Left = 439
    Top = 308
  end
  object qryPaletsPB: TQuery
    DatabaseName = 'dbF17'
    DataSource = dsEntregas
    Left = 442
    Top = 63
  end
  object dsPaletsPB: TDataSource
    DataSet = qryPaletsPB
    Left = 496
    Top = 78
  end
  object qryOrdenCarga: TQuery
    DatabaseName = 'dbF17'
    Left = 575
    Top = 270
  end
  object qryEnvase: TQuery
    DatabaseName = 'dbF17'
    Left = 574
    Top = 322
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
    Left = 61
    Top = 47
  end
  object kmtEntregasCab: TkbmMemTable
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
    Left = 61
    Top = 118
  end
  object qryEntregasLineasLocal: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = dsEntregas
    Left = 444
    Top = 117
  end
  object qryFechaSalida: TQuery
    DatabaseName = 'dbF17'
    Left = 573
    Top = 376
  end
  object qryKilosTeoricosLinea: TQuery
    DatabaseName = 'BDProyecto'
    Left = 371
    Top = 416
  end
  object qrySalidasLin: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = dsEntregas
    Left = 371
    Top = 363
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
    Left = 143
    Top = 441
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
    Left = 78
    Top = 277
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
    Left = 77
    Top = 337
  end
  object qryKilosVariedadRF: TQuery
    DatabaseName = 'BDProyecto'
    Left = 575
    Top = 478
  end
  object qryEntregasFacturasLocal: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = dsEntregas
    Left = 443
    Top = 168
  end
  object kmtLineas: TkbmMemTable
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
    Left = 137
    Top = 47
  end
  object qryEntregasRF: TQuery
    DatabaseName = 'dbF17'
    Left = 337
    Top = 64
  end
  object kmtEntregasLin: TkbmMemTable
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
    MasterFields = 'entrega'
    DetailFields = 'entrega'
    MasterSource = DSEntregasLocal
    Version = '5.51'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 188
    Top = 119
  end
  object DSEntregasLocal: TDataSource
    DataSet = kmtEntregasCab
    Left = 126
    Top = 144
  end
  object qryTotalesRF: TQuery
    DatabaseName = 'dbF17'
    Left = 440
    Top = 9
  end
end
