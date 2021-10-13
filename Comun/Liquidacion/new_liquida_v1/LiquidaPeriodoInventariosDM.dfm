object DMLiquidaPeriodoInventarios: TDMLiquidaPeriodoInventarios
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 782
  Top = 278
  Height = 375
  Width = 495
  object qryAux: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 35
  end
end
