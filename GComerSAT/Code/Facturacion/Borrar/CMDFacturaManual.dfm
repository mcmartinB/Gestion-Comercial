object DMDFacturaManual: TDMDFacturaManual
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 562
  Top = 246
  Height = 219
  Width = 453
  object QContadores: TQuery
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 24
  end
  object QCliente: TQuery
    DatabaseName = 'BDProyecto'
    Left = 120
    Top = 24
  end
  object QImpuesto: TQuery
    DatabaseName = 'BDProyecto'
    Left = 184
    Top = 24
  end
  object QFactura: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 48
    Top = 80
  end
  object QFacturaManual: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 120
    Top = 80
  end
  object QDetalleFactura: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 208
    Top = 80
  end
  object QExisteFactura: TQuery
    DatabaseName = 'BDProyecto'
    Left = 320
    Top = 24
  end
  object QFechaInferior: TQuery
    DatabaseName = 'BDProyecto'
    Left = 344
    Top = 72
  end
  object QFechaSuperior: TQuery
    DatabaseName = 'BDProyecto'
    Left = 360
    Top = 120
  end
  object QRecargo: TQuery
    DatabaseName = 'BDProyecto'
    Left = 241
    Top = 27
  end
  object qryUpdateContador: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 49
    Top = 133
  end
end
