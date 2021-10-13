object DLLiquidaKilos: TDLLiquidaKilos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 737
  Top = 254
  Height = 467
  Width = 604
  object qryAux: TQuery
    DatabaseName = 'BDProyecto'
    Left = 143
    Top = 22
  end
  object qryLocal: TQuery
    DatabaseName = 'BDProyecto'
    Left = 146
    Top = 79
  end
  object qryRemoto: TQuery
    DatabaseName = 'BDProyecto'
    Left = 151
    Top = 135
  end
  object kmtKilos: TkbmMemTable
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
    Left = 65
    Top = 24
  end
  object qryEnvase: TQuery
    DatabaseName = 'BDProyecto'
    Left = 231
    Top = 79
  end
end
