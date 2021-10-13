object MDPutEscandalloSemanal: TMDPutEscandalloSemanal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 869
  Top = 287
  Height = 310
  Width = 324
  object qryEntradas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 32
  end
  object qryEscandallos: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 40
    Top = 88
  end
  object qryNuevos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 112
    Top = 32
  end
end
