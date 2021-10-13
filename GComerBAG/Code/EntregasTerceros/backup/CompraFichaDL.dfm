object DLCompraFicha: TDLCompraFicha
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 827
  Top = 307
  Height = 311
  Width = 402
  object qCompras: TQuery
    AfterOpen = qComprasAfterOpen
    BeforeClose = qComprasBeforeClose
    DatabaseName = 'BDProyecto'
    Left = 56
    Top = 48
  end
  object dsCompras: TDataSource
    DataSet = qCompras
    Left = 128
    Top = 48
  end
  object qGastosEntregas: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = dsCompras
    Left = 208
    Top = 160
  end
  object qEntregasCompras: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = dsCompras
    Left = 208
    Top = 104
  end
  object qGastosCompras: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = dsCompras
    Left = 208
    Top = 48
  end
end
