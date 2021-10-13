object DLDepositoAduanasDOC: TDLDepositoAduanasDOC
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 889
  Top = 187
  Height = 336
  Width = 215
  object QTransitos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 32
    Top = 32
  end
  object mtTransitos: TkbmMemTable
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
    Left = 104
    Top = 32
  end
end
