object DLMargenBVentas: TDLMargenBVentas
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 657
  Width = 1033
  object kmtVentasClientes: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.51'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 208
    Top = 22
  end
  object QCostesEnvasado: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'SELECT rf_palet_pb.entrega, frf_proveedores.nombre_p, frf_produc' +
        'tos.descripcion_p,'
      
        '       frf_productos_proveedor.descripcion_breve_pp, rf_palet_pb' +
        '.categoria, rf_palet_pb.calibre,'
      '       Count(*) Palets,'
      '       Sum(rf_palet_pb.peso_bruto) Peso,'
      '       Sum(rf_palet_pb.cajas) cajas'
      
        'FROM   frf_productos, frf_productos_proveedor, frf_proveedores, ' +
        'rf_palet_pb '
      'WHERE rf_palet_pb.empresa = frf_proveedores.empresa_p '
      '  AND rf_palet_pb.proveedor = frf_proveedores.proveedor_p '
      '  AND rf_palet_pb.empresa = frf_productos_proveedor.empresa_pp '
      
        '  AND rf_palet_pb.producto = frf_productos_proveedor.producto_pp' +
        ' '
      
        '  AND rf_palet_pb.proveedor = frf_productos_proveedor.proveedor_' +
        'pp '
      
        '  AND rf_palet_pb.variedad = frf_productos_proveedor.variedad_pp' +
        ' '
      '  AND rf_palet_pb.empresa = frf_productos.empresa_p '
      '  AND rf_palet_pb.producto = frf_productos.producto_p '
      '  AND rf_palet_pb.status='#39'S'#39
      
        'GROUP BY rf_palet_pb.entrega, frf_proveedores.nombre_p, frf_prod' +
        'uctos.descripcion_p, frf_productos_proveedor.descripcion_breve_p' +
        'p, rf_palet_pb.categoria, rf_palet_pb.calibre'
      'ORDER BY frf_productos.descripcion_p, rf_palet_pb.calibre ')
    Left = 224
    Top = 160
  end
  object mtCostesEnvasado: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.51'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 280
    Top = 86
  end
  object qryGastosAlbaran: TQuery
    DatabaseName = 'BDProyecto'
    Left = 101
    Top = 112
  end
  object qryKilosALbaran: TQuery
    DatabaseName = 'BDProyecto'
    Left = 165
    Top = 136
  end
  object qrySalidas: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'SELECT rf_palet_pb.entrega, frf_proveedores.nombre_p, frf_produc' +
        'tos.descripcion_p,'
      
        '       frf_productos_proveedor.descripcion_breve_pp, rf_palet_pb' +
        '.categoria, rf_palet_pb.calibre,'
      '       Count(*) Palets,'
      '       Sum(rf_palet_pb.peso_bruto) Peso,'
      '       Sum(rf_palet_pb.cajas) cajas'
      
        'FROM   frf_productos, frf_productos_proveedor, frf_proveedores, ' +
        'rf_palet_pb '
      'WHERE rf_palet_pb.empresa = frf_proveedores.empresa_p '
      '  AND rf_palet_pb.proveedor = frf_proveedores.proveedor_p '
      '  AND rf_palet_pb.empresa = frf_productos_proveedor.empresa_pp '
      
        '  AND rf_palet_pb.producto = frf_productos_proveedor.producto_pp' +
        ' '
      
        '  AND rf_palet_pb.proveedor = frf_productos_proveedor.proveedor_' +
        'pp '
      
        '  AND rf_palet_pb.variedad = frf_productos_proveedor.variedad_pp' +
        ' '
      '  AND rf_palet_pb.empresa = frf_productos.empresa_p '
      '  AND rf_palet_pb.producto = frf_productos.producto_p '
      '  AND rf_palet_pb.status='#39'S'#39
      
        'GROUP BY rf_palet_pb.entrega, frf_proveedores.nombre_p, frf_prod' +
        'uctos.descripcion_p, frf_productos_proveedor.descripcion_breve_p' +
        'p, rf_palet_pb.categoria, rf_palet_pb.calibre'
      'ORDER BY frf_productos.descripcion_p, rf_palet_pb.calibre ')
    Left = 40
    Top = 88
  end
  object kmtGastosAlbaran: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.51'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 352
    Top = 110
  end
  object kmtVentas: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.51'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 40
    Top = 22
  end
  object qryAbonos: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'SELECT rf_palet_pb.entrega, frf_proveedores.nombre_p, frf_produc' +
        'tos.descripcion_p,'
      
        '       frf_productos_proveedor.descripcion_breve_pp, rf_palet_pb' +
        '.categoria, rf_palet_pb.calibre,'
      '       Count(*) Palets,'
      '       Sum(rf_palet_pb.peso_bruto) Peso,'
      '       Sum(rf_palet_pb.cajas) cajas'
      
        'FROM   frf_productos, frf_productos_proveedor, frf_proveedores, ' +
        'rf_palet_pb '
      'WHERE rf_palet_pb.empresa = frf_proveedores.empresa_p '
      '  AND rf_palet_pb.proveedor = frf_proveedores.proveedor_p '
      '  AND rf_palet_pb.empresa = frf_productos_proveedor.empresa_pp '
      
        '  AND rf_palet_pb.producto = frf_productos_proveedor.producto_pp' +
        ' '
      
        '  AND rf_palet_pb.proveedor = frf_productos_proveedor.proveedor_' +
        'pp '
      
        '  AND rf_palet_pb.variedad = frf_productos_proveedor.variedad_pp' +
        ' '
      '  AND rf_palet_pb.empresa = frf_productos.empresa_p '
      '  AND rf_palet_pb.producto = frf_productos.producto_p '
      '  AND rf_palet_pb.status='#39'S'#39
      
        'GROUP BY rf_palet_pb.entrega, frf_proveedores.nombre_p, frf_prod' +
        'uctos.descripcion_p, frf_productos_proveedor.descripcion_breve_p' +
        'p, rf_palet_pb.categoria, rf_palet_pb.calibre'
      'ORDER BY frf_productos.descripcion_p, rf_palet_pb.calibre ')
    Left = 288
    Top = 184
  end
  object dsVentas: TDataSource
    DataSet = kmtVentas
    Left = 112
    Top = 24
  end
  object qryCostesEstructura: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'SELECT rf_palet_pb.entrega, frf_proveedores.nombre_p, frf_produc' +
        'tos.descripcion_p,'
      
        '       frf_productos_proveedor.descripcion_breve_pp, rf_palet_pb' +
        '.categoria, rf_palet_pb.calibre,'
      '       Count(*) Palets,'
      '       Sum(rf_palet_pb.peso_bruto) Peso,'
      '       Sum(rf_palet_pb.cajas) cajas'
      
        'FROM   frf_productos, frf_productos_proveedor, frf_proveedores, ' +
        'rf_palet_pb '
      'WHERE rf_palet_pb.empresa = frf_proveedores.empresa_p '
      '  AND rf_palet_pb.proveedor = frf_proveedores.proveedor_p '
      '  AND rf_palet_pb.empresa = frf_productos_proveedor.empresa_pp '
      
        '  AND rf_palet_pb.producto = frf_productos_proveedor.producto_pp' +
        ' '
      
        '  AND rf_palet_pb.proveedor = frf_productos_proveedor.proveedor_' +
        'pp '
      
        '  AND rf_palet_pb.variedad = frf_productos_proveedor.variedad_pp' +
        ' '
      '  AND rf_palet_pb.empresa = frf_productos.empresa_p '
      '  AND rf_palet_pb.producto = frf_productos.producto_p '
      '  AND rf_palet_pb.status='#39'S'#39
      
        'GROUP BY rf_palet_pb.entrega, frf_proveedores.nombre_p, frf_prod' +
        'uctos.descripcion_p, frf_productos_proveedor.descripcion_breve_p' +
        'p, rf_palet_pb.categoria, rf_palet_pb.calibre'
      'ORDER BY frf_productos.descripcion_p, rf_palet_pb.calibre ')
    Left = 344
    Top = 208
  end
  object kmtCostesEstructura: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.51'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 432
    Top = 150
  end
end
