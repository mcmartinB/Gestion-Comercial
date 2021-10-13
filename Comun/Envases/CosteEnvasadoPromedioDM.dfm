object DMCosteEnvasadoPromedio: TDMCosteEnvasadoPromedio
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 338
  Width = 236
  object qryTotalesAnuales: TQuery
    DatabaseName = 'BDProyecto'
    Left = 52
    Top = 23
  end
  object qryRegistroCoste: TQuery
    DatabaseName = 'BDProyecto'
    Left = 51
    Top = 78
  end
  object qryActualizaRegsitro: TQuery
    DatabaseName = 'BDProyecto'
    Left = 142
    Top = 45
  end
  object qryEnvaseNuevo: TQuery
    DatabaseName = 'BDProyecto'
    Left = 142
    Top = 131
  end
  object qryPendientes: TQuery
    DatabaseName = 'BDProyecto'
    Left = 53
    Top = 178
  end
  object qryEnvasesNuevos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 140
    Top = 205
  end
end
