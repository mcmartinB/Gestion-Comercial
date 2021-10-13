object DAsignarGastosServicioVenta: TDAsignarGastosServicioVenta
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 569
  Width = 744
  object QCambiarStatus: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSSelectLineas
    Left = 240
    Top = 96
  end
  object QGastosServicioLin: TQuery
    AfterOpen = QGastosServicioLinAfterOpen
    BeforeClose = QGastosServicioLinBeforeClose
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 96
  end
  object DSSelectLineas: TDataSource
    DataSet = QGastosServicioLin
    Left = 136
    Top = 96
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
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.51'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 544
    Top = 144
  end
  object DSGastos: TDataSource
    DataSet = mtAuxGastos
    Left = 544
    Top = 200
  end
  object QSelectSalidasTodas: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSSelectLineas
    Left = 240
    Top = 152
  end
  object QSumSalidasTodas: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSSelectLineas
    Left = 240
    Top = 216
  end
  object QSelectSalidasProducto: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSSelectLineas
    Left = 360
    Top = 152
  end
  object QSumSalidasProducto: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSSelectLineas
    Left = 360
    Top = 216
  end
  object QGastosSalidas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 536
    Top = 80
  end
  object QBorrarGastosSalidas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 536
    Top = 24
  end
  object QProductosCentro: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 304
  end
  object QFechasLiquida: TQuery
    DatabaseName = 'BDProyecto'
    Left = 136
    Top = 304
  end
  object QSalidasLiquidadas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 232
    Top = 304
  end
  object qSelectSalidasCab: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = dsSalidasTodas
    Left = 360
    Top = 96
  end
  object dsSalidasTodas: TDataSource
    DataSet = QSelectSalidasTodas
    Left = 136
    Top = 152
  end
end
