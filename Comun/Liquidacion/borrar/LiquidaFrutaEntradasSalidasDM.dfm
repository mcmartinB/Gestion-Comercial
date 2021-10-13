object DMLiquidaFrutaEntradasSalidas: TDMLiquidaFrutaEntradasSalidas
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 567
  Top = 233
  Height = 406
  Width = 406
  object kmtResumen: TkbmMemTable
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
    Top = 28
  end
  object kmtLiquidacion: TkbmMemTable
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
    Left = 58
    Top = 89
  end
  object qryEntradas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 66
    Top = 173
  end
  object qryEntradasCos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 64
    Top = 235
  end
  object qryKilosRet: TQuery
    DatabaseName = 'BDProyecto'
    Left = 177
    Top = 167
  end
  object qryInventarios: TQuery
    DatabaseName = 'BDProyecto'
    Left = 176
    Top = 227
  end
end
