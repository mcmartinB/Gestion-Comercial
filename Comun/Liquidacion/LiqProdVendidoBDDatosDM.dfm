object DMLiqProdVendidoBDDatos: TDMLiqProdVendidoBDDatos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 877
  Top = 353
  Height = 377
  Width = 796
  object qryAux: TQuery
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 51
  end
  object qrySemana: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 128
    Top = 51
  end
  object qryLiquidacion: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 224
    Top = 51
  end
end
