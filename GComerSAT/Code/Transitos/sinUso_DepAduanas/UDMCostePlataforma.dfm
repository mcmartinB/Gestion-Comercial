object DMCostePlataforma: TDMCostePlataforma
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 824
  Top = 245
  Height = 536
  Width = 548
  object QSalidasDeposito: TQuery
    CachedUpdates = True
    DatabaseName = 'BDProyecto'
    Left = 160
    Top = 32
  end
  object QSalidas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 72
    Top = 32
  end
  object mtSalidasDeposito: TkbmMemTable
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
    Left = 72
    Top = 88
  end
  object QUpdateLinea: TQuery
    CachedUpdates = True
    DatabaseName = 'BDProyecto'
    Left = 72
    Top = 144
  end
end
