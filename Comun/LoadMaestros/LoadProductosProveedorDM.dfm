object DMLoadProductosProveedor: TDMLoadProductosProveedor
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 311
  Width = 482
  object qryProductosProveedorCentral: TQuery
    DatabaseName = 'BDCentral'
    Left = 121
    Top = 40
  end
  object qryProductosProveedorLocal: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 234
    Top = 64
  end
end
