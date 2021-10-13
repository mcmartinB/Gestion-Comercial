object DMLComHisSemVen: TDMLComHisSemVen
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 430
  Top = 226
  Height = 337
  Width = 291
  object kbmListado: TkbmMemTable
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
    Left = 56
    Top = 32
  end
  object QHistorico: TQuery
    DatabaseName = 'BDProyecto'
    Left = 184
    Top = 32
  end
  object QMonedaHistorico: TQuery
    DatabaseName = 'BDProyecto'
    Left = 184
    Top = 88
  end
  object QSoloKilos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 184
    Top = 208
  end
  object QActual: TQuery
    DatabaseName = 'BDProyecto'
    Left = 184
    Top = 144
  end
end
