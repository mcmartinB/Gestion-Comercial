object DLRecadvImportar: TDLRecadvImportar
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 472
  Top = 180
  Height = 221
  Width = 541
  object QInsert: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 88
    Top = 96
  end
  object QAux: TQuery
    DatabaseName = 'BDProyecto'
    Left = 88
    Top = 40
  end
  object mtCab: TkbmMemTable
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
    Left = 160
    Top = 40
  end
end
