object DMComerToSgp: TDMComerToSgp
  OldCreateOrder = False
  Height = 231
  Width = 582
  object qryComercial: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 56
  end
  object qrySGP: TQuery
    DatabaseName = 'DBSGP'
    RequestLive = True
    Left = 160
    Top = 56
  end
  object qrySGPAux: TQuery
    DatabaseName = 'DBSGP'
    RequestLive = True
    Left = 160
    Top = 112
  end
  object qryComerAux: TQuery
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 112
  end
end
