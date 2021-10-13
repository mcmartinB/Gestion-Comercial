object DMAprovechaResumen: TDMAprovechaResumen
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 498
  Width = 425
  object QInventarioCab: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 24
  end
  object QInventarioLin: TQuery
    DatabaseName = 'BDProyecto'
    Left = 136
    Top = 24
  end
  object QEntradas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 80
  end
  object QEscandallo: TQuery
    DatabaseName = 'BDProyecto'
    Left = 136
    Top = 80
  end
  object QSalidas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 136
  end
  object QTransitos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 136
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
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.51'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 40
    Top = 200
  end
end
