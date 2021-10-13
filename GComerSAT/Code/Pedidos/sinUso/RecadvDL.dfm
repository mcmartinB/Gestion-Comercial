object DLRecadv: TDLRecadv
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 813
  Top = 174
  Height = 543
  Width = 355
  object QLin: TQuery
    DatabaseName = 'BDProyecto'
    Filtered = True
    OnFilterRecord = QLinFilterRecord
    DataSource = DSCab
    Left = 120
    Top = 16
  end
  object QCab: TQuery
    AfterOpen = QCabAfterOpen
    BeforeClose = QCabBeforeClose
    DatabaseName = 'BDProyecto'
    Left = 16
    Top = 16
  end
  object QObs: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCab
    Left = 184
    Top = 16
  end
  object DSCab: TDataSource
    DataSet = QCab
    Left = 64
    Top = 16
  end
  object QAlbaranDet: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCab
    Left = 120
    Top = 72
  end
  object QLinList: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCAbList
    Left = 128
    Top = 288
  end
  object QCabList: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCab
    Left = 24
    Top = 288
  end
  object QObsList: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCAbList
    Left = 192
    Top = 288
  end
  object DSCAbList: TDataSource
    DataSet = QCabList
    Left = 72
    Top = 288
  end
  object QAlbaranCabList: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCAbList
    Left = 128
    Top = 336
  end
  object QAlbaranDetList: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCAbList
    Left = 224
    Top = 336
  end
  object QCajasLogifruit: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCab
    Left = 120
    Top = 128
  end
  object QPalets: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCab
    Left = 120
    Top = 184
  end
end
