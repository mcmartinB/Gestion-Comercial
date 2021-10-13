object DLRiesgo: TDLRiesgo
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 408
  Width = 278
  object qryRiesgo: TQuery
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 184
  end
  object kmtRiesgo: TkbmMemTable
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
    Left = 152
    Top = 96
  end
  object qryCliente: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 56
  end
  object qryAlbaranado: TQuery
    DatabaseName = 'BDProyecto'
    Left = 135
    Top = 186
  end
end
