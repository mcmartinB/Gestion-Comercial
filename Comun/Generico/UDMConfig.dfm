object DMConfig: TDMConfig
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 388
  Width = 436
  object QUsuarios: TQuery
    DatabaseName = 'BDProyecto'
    Left = 56
    Top = 80
  end
  object QAccesos: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 56
    Top = 136
  end
  object QImpresoras: TQuery
    DatabaseName = 'BDProyecto'
    Left = 56
    Top = 200
  end
  object QCuentaCorreo: TQuery
    DatabaseName = 'BDProyecto'
    Left = 136
    Top = 80
  end
  object QAltaImpresoras: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 144
    Top = 200
  end
  object QInstalacion: TQuery
    DatabaseName = 'BDProyecto'
    Left = 56
    Top = 32
  end
  object QDirectorios: TQuery
    DatabaseName = 'BDProyecto'
    Left = 56
    Top = 264
  end
  object QLogon: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 304
    Top = 80
  end
  object QAux: TQuery
    DatabaseName = 'BDProyecto'
    Left = 224
    Top = 16
  end
  object QDatosUsu: TQuery
    DatabaseName = 'BDProyecto'
    Left = 280
    Top = 160
  end
end
