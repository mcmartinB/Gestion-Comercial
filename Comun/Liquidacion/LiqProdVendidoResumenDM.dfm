object DMLiqProdVendidoResumen: TDMLiqProdVendidoResumen
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 408
  Width = 726
  object qrySemanas: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 40
    Top = 51
  end
  object qryResumen: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = dsSemanas
    Left = 168
    Top = 59
  end
  object dsSemanas: TDataSource
    DataSet = qrySemanas
    Left = 104
    Top = 80
  end
end
