object DMLiquidarEntradasSalidasPeriodo: TDMLiquidarEntradasSalidasPeriodo
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 671
  Top = 236
  Height = 394
  Width = 750
  object qryEntradasSalidas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 52
    Top = 114
  end
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
end
