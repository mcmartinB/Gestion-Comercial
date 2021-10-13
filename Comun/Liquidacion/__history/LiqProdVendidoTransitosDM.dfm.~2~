object DMLiqProdVendidoTransitos: TDMLiqProdVendidoTransitos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 320
  Width = 576
  object qryTransitos: TQuery
    AfterOpen = qryTransitosAfterOpen
    BeforeClose = qryTransitosBeforeClose
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 40
    Top = 43
  end
  object qryTransitoEntra: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = dsTransitos
    Left = 196
    Top = 43
  end
  object dsTransitos: TDataSource
    DataSet = qryTransitos
    Left = 112
    Top = 40
  end
  object qryKilosTransito: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = dsTransitos
    Left = 196
    Top = 99
  end
end
