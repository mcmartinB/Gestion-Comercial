object DLMargenBeneficiosCentral: TDLMargenBeneficiosCentral
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 657
  Width = 1033
  object mtPaletsConfeccionados: TkbmMemTable
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
    Left = 240
    Top = 150
  end
  object mtPaletsProveedor: TkbmMemTable
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
    Left = 240
    Top = 94
  end
  object QAux: TQuery
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
    Left = 56
    Top = 24
  end
  object mtResumen: TkbmMemTable
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
    Left = 56
    Top = 94
  end
  object DSMaster: TDataSource
    DataSet = mtResumen
    Left = 144
    Top = 96
  end
  object mtPrecios: TkbmMemTable
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
    Left = 240
    Top = 206
  end
  object QImportes: TQuery
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
  object mtEntregas: TkbmMemTable
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
    Left = 56
    Top = 158
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
    Left = 344
    Top = 272
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
    Left = 240
    Top = 270
  end
  object QCajasRF: TQuery
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
    Left = 240
    Top = 24
  end
  object QCostePrevisto: TQuery
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
    Left = 440
    Top = 208
  end
  object qryKilosTeoricosCaja: TQuery
    DatabaseName = 'BDProyecto'
    Left = 237
    Top = 360
  end
end
