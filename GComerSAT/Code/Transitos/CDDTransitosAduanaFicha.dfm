object DDTransitosAduanaFicha: TDDTransitosAduanaFicha
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 710
  Top = 229
  Height = 411
  Width = 549
  object QKilosTransito: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSDatosAduana
    Left = 194
    Top = 32
  end
  object DSDatosAduana: TDataSource
    DataSet = QDatosDepositoCab
    Left = 128
    Top = 56
  end
  object QDatosDepositoCab: TQuery
    AfterOpen = QDatosDepositoCabAfterOpen
    BeforeClose = QDatosDepositoCabBeforeClose
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 32
  end
end
