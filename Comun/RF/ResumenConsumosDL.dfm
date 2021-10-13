object DLResumenConsumos: TDLResumenConsumos
  OldCreateOrder = False
  Left = 567
  Top = 219
  Height = 594
  Width = 824
  object qryTransito: TQuery
    DatabaseName = 'BDProyecto'
    Left = 160
    Top = 35
  end
  object kmtResumenEntregas: TkbmMemTable
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
    Left = 64
    Top = 109
  end
  object qryEntregasRF: TQuery
    DatabaseName = 'dbF17'
    Left = 58
    Top = 38
  end
  object kmtResumenClientes: TkbmMemTable
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
    Left = 66
    Top = 165
  end
end
