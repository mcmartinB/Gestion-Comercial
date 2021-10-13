object DMResumenProduccion: TDMResumenProduccion
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 905
  Top = 114
  Height = 338
  Width = 366
  object QInventarioCab: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 24
  end
  object QInventarioLin: TQuery
    DatabaseName = 'BDProyecto'
    Left = 128
    Top = 24
  end
  object QEntradas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 80
  end
  object QSalidas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 128
    Top = 80
  end
  object QTransitos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 136
  end
  object mtResumen: TkbmMemTable
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
    Left = 40
    Top = 200
  end
  object qryProductos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 168
    Top = 196
  end
  object kmtProductos: TkbmMemTable
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
    Left = 256
    Top = 196
  end
end
