object DLRiesgoAgingX3: TDLRiesgoAgingX3
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 795
  Top = 203
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
    FilterOptions = []
    Version = '4.08b'
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
