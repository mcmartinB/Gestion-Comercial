object DMLiquidaPeriodoTransitos: TDMLiquidaPeriodoTransitos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 823
  Top = 262
  Height = 213
  Width = 215
  object qryCosteSeccion: TQuery
    DatabaseName = 'BDProyecto'
    Left = 80
    Top = 75
  end
  object qryTransitos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 24
    Top = 19
  end
  object qryAux: TQuery
    DatabaseName = 'BDProyecto'
    Left = 104
    Top = 19
  end
end
