object DLCartaTransito: TDLCartaTransito
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 250
  Width = 478
  object QAlbaranCab: TQuery
    DatabaseName = 'BDProyecto'
    Left = 64
    Top = 40
  end
  object QEmpresa: TQuery
    DatabaseName = 'BDProyecto'
    Left = 144
    Top = 40
  end
  object QTransportista: TQuery
    DatabaseName = 'BDProyecto'
    Left = 212
    Top = 42
  end
  object QAlbaranLin: TQuery
    DatabaseName = 'BDProyecto'
    Left = 64
    Top = 104
  end
  object QCargador: TQuery
    DatabaseName = 'BDProyecto'
    Left = 146
    Top = 107
  end
  object QOrigen: TQuery
    DatabaseName = 'BDProyecto'
    Left = 295
    Top = 103
  end
  object QDestino: TQuery
    DatabaseName = 'BDProyecto'
    Left = 290
    Top = 48
  end
end
