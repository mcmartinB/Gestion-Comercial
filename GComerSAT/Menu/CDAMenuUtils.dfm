object DAMenuUtils: TDAMenuUtils
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 511
  Top = 230
  Height = 318
  Width = 530
  object QMenuLog: TQuery
    DatabaseName = 'BDProyecto'
    Left = 32
    Top = 24
  end
end
