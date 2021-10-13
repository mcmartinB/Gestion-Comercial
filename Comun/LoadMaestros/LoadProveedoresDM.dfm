object DMLoadProveedores: TDMLoadProveedores
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 311
  Width = 482
  object qryProveedorCentral: TQuery
    DatabaseName = 'BDCentral'
    Left = 65
    Top = 33
  end
  object qryAlmacenProveedorCentral: TQuery
    DatabaseName = 'BDCentral'
    Left = 67
    Top = 82
  end
  object qryProductoProveedorCentral: TQuery
    DatabaseName = 'BDCentral'
    Left = 71
    Top = 129
  end
  object qryProveedorLocal: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 250
    Top = 29
  end
  object qryAlmacenProveedorLocal: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 254
    Top = 80
  end
  object qryProductoProveedorLocal: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 256
    Top = 132
  end
end
