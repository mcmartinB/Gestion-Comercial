object DMLoadAlmacenProveedor: TDMLoadAlmacenProveedor
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 311
  Width = 482
  object qryAlmacenProveedorCentral: TQuery
    DatabaseName = 'BDCentral'
    Left = 56
    Top = 40
  end
  object qryAlmacenProveedorLocal: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 152
    Top = 57
  end
end
