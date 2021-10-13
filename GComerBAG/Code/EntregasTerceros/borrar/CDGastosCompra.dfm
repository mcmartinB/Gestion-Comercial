object DGastosCompra: TDGastosCompra
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 402
  Top = 344
  Height = 569
  Width = 744
  object QUpdateStatus: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSSelectLineas
    Left = 240
    Top = 96
  end
  object QSelectLineas: TQuery
    AfterOpen = QSelectLineasAfterOpen
    BeforeClose = QSelectLineasBeforeClose
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 96
  end
  object DSSelectLineas: TDataSource
    DataSet = QSelectLineas
    Left = 136
    Top = 96
  end
  object kbmGastos: TkbmMemTable
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
    Left = 536
    Top = 144
  end
  object DSGastos: TDataSource
    DataSet = kbmGastos
    Left = 544
    Top = 200
  end
  object QSelectEntregas: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSSelectLineas
    Left = 240
    Top = 152
  end
  object QSumEntregas: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSSelectLineas
    Left = 240
    Top = 216
  end
  object QNumLinea: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 288
  end
  object QGastosEntregas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 536
    Top = 80
  end
  object QBorrarGastosEntregas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 536
    Top = 24
  end
end
