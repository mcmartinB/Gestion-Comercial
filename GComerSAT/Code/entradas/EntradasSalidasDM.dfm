object DMEntradasSalidas: TDMEntradasSalidas
  OldCreateOrder = False
  Left = 481
  Top = 273
  Height = 235
  Width = 481
  object qrySalidas: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 53
    Top = 64
  end
  object qryAux: TQuery
    DatabaseName = 'BDProyecto'
    Left = 122
    Top = 15
  end
  object qryRemoto: TQuery
    DatabaseName = 'BDCentral'
    RequestLive = True
    Left = 294
    Top = 10
  end
  object qryAuxRemoto: TQuery
    DatabaseName = 'BDCentral'
    Left = 303
    Top = 64
  end
  object qryListado: TQuery
    DatabaseName = 'BDProyecto'
    Left = 49
    Top = 14
  end
end
