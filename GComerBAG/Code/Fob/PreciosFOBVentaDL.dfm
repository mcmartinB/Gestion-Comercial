object DLPreciosFOBVenta: TDLPreciosFOBVenta
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 511
  Width = 714
  object QDatosAlbaran: TQuery
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
    Left = 408
    Top = 16
  end
  object mtDatosAlbaran: TkbmMemTable
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
    Left = 80
    Top = 24
  end
  object mtDatosAlbaranProducto: TkbmMemTable
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
    Left = 184
    Top = 24
  end
  object mtDescuentos: TkbmMemTable
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
    Left = 80
    Top = 88
  end
  object QClienteFac: TQuery
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
    Left = 408
    Top = 80
  end
  object QDescuento: TQuery
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
    Left = 488
    Top = 80
  end
  object QComision: TQuery
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
    Left = 560
    Top = 80
  end
  object QGastosAlbaran: TQuery
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
    Left = 408
    Top = 152
  end
  object QAbonosAlbaran: TQuery
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
    Left = 408
    Top = 208
  end
  object QCosteEnvase: TQuery
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
    Left = 408
    Top = 264
  end
  object QCambio: TQuery
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
    Left = 624
    Top = 80
  end
end
