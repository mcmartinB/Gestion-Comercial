object DMLiqAsignaTransitos: TDMLiqAsignaTransitos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 464
  Width = 826
  object qryKilosTransitos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 72
    Top = 43
  end
  object qrySalidasTransitos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 72
    Top = 107
  end
  object qryCambiaSalidas: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 72
    Top = 171
  end
end
