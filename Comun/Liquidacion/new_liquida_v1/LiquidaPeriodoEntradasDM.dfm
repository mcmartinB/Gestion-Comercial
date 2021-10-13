object DMLiquidaPeriodoEntradas: TDMLiquidaPeriodoEntradas
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 667
  Top = 247
  Height = 324
  Width = 549
  object qryEntradasCos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 43
  end
  object qryAux: TQuery
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 107
  end
end
