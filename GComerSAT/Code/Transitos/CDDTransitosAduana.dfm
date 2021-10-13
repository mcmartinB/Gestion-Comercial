object DDTransitosAduana: TDDTransitosAduana
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 301
  Width = 652
  object QDatosAduana: TQuery
    BeforePost = QDatosAduanaBeforePost
    DatabaseName = 'BDProyecto'
    Left = 72
    Top = 24
  end
  object DSDatosAduana: TDataSource
    DataSet = QDatosAduana
    Left = 160
    Top = 24
  end
  object QGetClave: TQuery
    DatabaseName = 'BDProyecto'
    Left = 64
    Top = 216
  end
  object qryTransportePuerto: TQuery
    DatabaseName = 'BDProyecto'
    Left = 75
    Top = 136
  end
end
