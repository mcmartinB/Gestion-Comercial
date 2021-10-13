object DLCargaDirecta: TDLCargaDirecta
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 366
  Width = 455
  object kmtPreciosVentaCarga: TkbmMemTable
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
    Top = 43
  end
  object qryVenta: TQuery
    DatabaseName = 'BDProyecto'
    Left = 67
    Top = 40
  end
  object qryCargasDirectas: TQuery
    DatabaseName = 'dbF17'
    Left = 70
    Top = 111
  end
end
