object DLDeclaracionResponsable: TDLDeclaracionResponsable
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 218
  Width = 287
  object QDeclaracion: TQuery
    AutoCalcFields = False
    DatabaseName = 'BDProyecto'
    Left = 56
    Top = 24
  end
  object QTotalAlbaran: TQuery
    DatabaseName = 'BDProyecto'
    Left = 56
    Top = 72
  end
end
