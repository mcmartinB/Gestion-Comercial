object DLAging: TDLAging
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 228
  Width = 278
  object qryAging: TQuery
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 24
  end
  object kmtAging: TkbmMemTable
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
    Left = 128
    Top = 24
  end
  object qryCliente: TQuery
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 96
  end
end
