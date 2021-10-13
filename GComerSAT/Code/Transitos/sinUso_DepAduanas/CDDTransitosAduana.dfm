object DDTransitosAduana: TDDTransitosAduana
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 517
  Top = 239
  Height = 561
  Width = 756
  object QDatosAduana: TQuery
    AfterOpen = QDatosAduanaAfterOpen
    BeforeClose = QDatosAduanaBeforeClose
    BeforePost = QDatosAduanaBeforePost
    DatabaseName = 'BDProyecto'
    Left = 72
    Top = 24
  end
  object QKilosTransito: TQuery
    DatabaseName = 'BDProyecto'
    Left = 56
    Top = 368
  end
  object DSDatosAduana: TDataSource
    DataSet = QDatosAduana
    Left = 160
    Top = 24
  end
  object QDatosAduanaDetalle: TQuery
    BeforePost = QDatosAduanaDetalleBeforePost
    DatabaseName = 'BDProyecto'
    DataSource = DSDatosAduana
    Left = 232
    Top = 40
  end
  object QDatosAduanaSalidas: TQuery
    BeforePost = QDatosAduanaSalidasBeforePost
    DatabaseName = 'BDProyecto'
    DataSource = DSDatosAduana
    Left = 232
    Top = 104
  end
  object QGetClave: TQuery
    DatabaseName = 'BDProyecto'
    Left = 56
    Top = 304
  end
  object QKilosDetalle: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSDatosAduana
    Left = 232
    Top = 160
  end
  object QKilosSalidas: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSDatosAduana
    Left = 232
    Top = 216
  end
  object QKilosAlbaran: TQuery
    DatabaseName = 'BDProyecto'
    Left = 376
    Top = 368
  end
  object QGetLinea: TQuery
    DatabaseName = 'BDProyecto'
    Left = 152
    Top = 304
  end
  object QDatosAduanaSalidasAux: TQuery
    BeforePost = QDatosAduanaSalidasBeforePost
    DatabaseName = 'BDProyecto'
    DataSource = DSDatosAduana
    Left = 368
    Top = 104
  end
  object QDatosAduanaDetalleAux: TQuery
    BeforePost = QDatosAduanaDetalleBeforePost
    DatabaseName = 'BDProyecto'
    Left = 368
    Top = 32
  end
  object QKilosDetalleSalidas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 272
    Top = 368
  end
  object QKilosAlbaranAsignados: TQuery
    DatabaseName = 'BDProyecto'
    Left = 456
    Top = 368
  end
  object DSDatosAduanaDetalle: TDataSource
    DataSet = QDatosAduanaDetalle
    Left = 504
    Top = 32
  end
  object QKilosSalidasDetalle: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSDatosAduanaDetalle
    Left = 632
    Top = 32
  end
  object QKilosPendientes: TQuery
    DatabaseName = 'BDProyecto'
    Filtered = True
    OnFilterRecord = QKilosPendientesFilterRecord
    Left = 168
    Top = 368
  end
  object QKilosPendientesT: TQuery
    DatabaseName = 'BDProyecto'
    Filtered = True
    OnFilterRecord = QKilosPendientesFilterRecord
    Left = 168
    Top = 424
  end
  object qryTransportePuerto: TQuery
    DatabaseName = 'BDProyecto'
    Left = 75
    Top = 136
  end
end
