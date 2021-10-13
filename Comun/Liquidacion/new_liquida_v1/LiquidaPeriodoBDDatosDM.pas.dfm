object DMLiquidaPeriodoBDDatros: TDMLiquidaPeriodoBDDatros
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 866
  Top = 255
  Height = 377
  Width = 796
  object qryAux: TQuery
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 43
  end
  object qrySemana: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 128
    Top = 43
  end
  object qryEntradas: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 208
    Top = 43
  end
  object qryCosecheros: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 128
    Top = 99
  end
  object qryPlantaciones: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 208
    Top = 99
  end
  object qryVentas: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 128
    Top = 163
  end
  object qryInventarios: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 208
    Top = 163
  end
  object qryTransitosSal: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 128
    Top = 219
  end
  object qryTransitosEnt: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 208
    Top = 219
  end
end
