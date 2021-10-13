object DDTransitosAduanaFicha: TDDTransitosAduanaFicha
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 632
  Top = 154
  Height = 411
  Width = 549
  object QKilosTransito: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSDatosAduana
    Left = 250
    Top = 80
  end
  object QKilosDetalle: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSDatosAduana
    Left = 368
    Top = 80
  end
  object QDatosCliente: TQuery
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 144
  end
  object DSDatosAduana: TDataSource
    DataSet = QDatosDepositoCab
    Left = 144
    Top = 32
  end
  object QDatosDepositoCab: TQuery
    AfterOpen = QDatosDepositoCabAfterOpen
    BeforeClose = QDatosDepositoCabBeforeClose
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 32
  end
  object QDatosDepositoLin: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSDatosAduana
    Left = 248
    Top = 32
  end
  object QDatosDepositoSal: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSDatosAduana
    Left = 368
    Top = 32
  end
  object QNumFacturaPlataforma: TQuery
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 224
  end
end
