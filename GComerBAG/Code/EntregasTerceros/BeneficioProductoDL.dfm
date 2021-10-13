object DLBeneficioProducto: TDLBeneficioProducto
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 537
  Width = 438
  object QListadoStock: TQuery
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
    Left = 48
    Top = 48
  end
  object TMemGastos: TkbmMemTable
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
    Left = 256
    Top = 56
  end
  object QFacturas: TQuery
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
    Left = 128
    Top = 48
  end
  object QEntregas: TQuery
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
    Left = 128
    Top = 104
  end
  object QSalidas: TQuery
    AfterOpen = QSalidasAfterOpen
    BeforeClose = QSalidasBeforeClose
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
    Left = 48
    Top = 224
  end
  object QGastosProductos: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSSalidas
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
    Left = 200
    Top = 280
  end
  object QSalidasProductos: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSSalidas
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
    Left = 200
    Top = 224
  end
  object DSSalidas: TDataSource
    DataSet = QSalidas
    Left = 120
    Top = 224
  end
  object mtSalidas: TkbmMemTable
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
    Left = 312
    Top = 256
  end
  object QCosteSalidas: TQuery
    AfterOpen = QCosteSalidasAfterOpen
    BeforeClose = QCosteSalidasBeforeClose
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
    Left = 48
    Top = 360
  end
  object QCosteEnvases: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCostes
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
    Left = 200
    Top = 360
  end
  object DSCostes: TDataSource
    DataSet = QCosteSalidas
    Left = 120
    Top = 360
  end
  object mtCostes: TkbmMemTable
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
    Left = 312
    Top = 360
  end
end
