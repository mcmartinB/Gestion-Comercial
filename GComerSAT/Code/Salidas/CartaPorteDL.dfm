object DLCartaPorte: TDLCartaPorte
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
    Left = 176
    Top = 40
  end
  object QCliente: TQuery
    DatabaseName = 'BDProyecto'
    Left = 288
    Top = 40
  end
  object QDirSum: TQuery
    DatabaseName = 'BDProyecto'
    Left = 288
    Top = 104
  end
  object QTransportista: TQuery
    DatabaseName = 'BDProyecto'
    Left = 384
    Top = 40
  end
  object QAlbaranLin: TQuery
    DatabaseName = 'BDProyecto'
    Left = 64
    Top = 104
  end
  object QOperador: TQuery
    DatabaseName = 'BDProyecto'
    Left = 384
    Top = 96
  end
  object QCentro: TQuery
    DatabaseName = 'BDProyecto'
    Left = 176
    Top = 104
  end
end
