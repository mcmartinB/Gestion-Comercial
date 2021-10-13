object DMServiciosEntrega: TDMServiciosEntrega
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 612
  Top = 245
  Height = 269
  Width = 744
  object QCambiarStatus: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSSelectLineas
    Left = 232
    Top = 32
  end
  object QGastosServicio: TQuery
    AfterOpen = QGastosServicioAfterOpen
    BeforeClose = QGastosServicioBeforeClose
    DatabaseName = 'BDProyecto'
    Left = 32
    Top = 32
  end
  object DSSelectLineas: TDataSource
    DataSet = QGastosServicio
    Left = 128
    Top = 32
  end
  object mtAuxGastos: TkbmMemTable
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
    Left = 488
    Top = 88
  end
  object DSGastos: TDataSource
    DataSet = mtAuxGastos
    Left = 600
    Top = 80
  end
  object QSelectEntregas: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSSelectLineas
    Left = 232
    Top = 88
  end
  object QSumEntregas: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSSelectLineas
    Left = 232
    Top = 152
  end
  object QGastosEntregas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 600
    Top = 32
  end
  object QBorrarGastosEntregas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 488
    Top = 32
  end
  object qryNumLinea: TQuery
    DatabaseName = 'BDProyecto'
    Left = 32
    Top = 152
  end
  object qryDesServicio: TQuery
    DatabaseName = 'BDProyecto'
    Left = 32
    Top = 88
  end
end
