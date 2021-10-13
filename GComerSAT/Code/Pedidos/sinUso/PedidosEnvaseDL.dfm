object DLPedidosEnvase: TDLPedidosEnvase
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 390
  Top = 310
  Height = 233
  Width = 449
  object QAux: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select '
      
        '       empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_pedid' +
        'o_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, envase_pdd, categoria_pdd, calibre_pdd, col' +
        'or_pdd, unidad_pdd, sum(unidades_pdd) unidades_pdd'
      'from frf_pedido_cab cab, frf_pedido_det det'
      'where empresa_pdc = empresa_pdd'
      'and centro_pdc = centro_pdd'
      'and pedido_pdc = pedido_pdd'
      ''
      
        'group by empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_ped' +
        'ido_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, envase_pdd, categoria_pdd, calibre_pdd, col' +
        'or_pdd, unidad_pdd'
      ''
      
        'order by empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_ped' +
        'ido_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, unidad_pdd, envase_pdd, categoria_pdd, cali' +
        'bre_pdd, color_pdd')
    Left = 32
    Top = 16
  end
  object tListado: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '4.08b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 32
    Top = 120
  end
  object QKilosAlbaran: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select '
      
        '       empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_pedid' +
        'o_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, envase_pdd, categoria_pdd, calibre_pdd, col' +
        'or_pdd, unidad_pdd, sum(unidades_pdd) unidades_pdd'
      'from frf_pedido_cab cab, frf_pedido_det det'
      'where empresa_pdc = empresa_pdd'
      'and centro_pdc = centro_pdd'
      'and pedido_pdc = pedido_pdd'
      ''
      
        'group by empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_ped' +
        'ido_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, envase_pdd, categoria_pdd, calibre_pdd, col' +
        'or_pdd, unidad_pdd'
      ''
      
        'order by empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_ped' +
        'ido_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, unidad_pdd, envase_pdd, categoria_pdd, cali' +
        'bre_pdd, color_pdd')
    Left = 144
    Top = 16
  end
  object QCajasAlbaran: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select '
      
        '       empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_pedid' +
        'o_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, envase_pdd, categoria_pdd, calibre_pdd, col' +
        'or_pdd, unidad_pdd, sum(unidades_pdd) unidades_pdd'
      'from frf_pedido_cab cab, frf_pedido_det det'
      'where empresa_pdc = empresa_pdd'
      'and centro_pdc = centro_pdd'
      'and pedido_pdc = pedido_pdd'
      ''
      
        'group by empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_ped' +
        'ido_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, envase_pdd, categoria_pdd, calibre_pdd, col' +
        'or_pdd, unidad_pdd'
      ''
      
        'order by empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_ped' +
        'ido_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, unidad_pdd, envase_pdd, categoria_pdd, cali' +
        'bre_pdd, color_pdd')
    Left = 232
    Top = 16
  end
  object QUnidadesAlbaran: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select '
      
        '       empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_pedid' +
        'o_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, envase_pdd, categoria_pdd, calibre_pdd, col' +
        'or_pdd, unidad_pdd, sum(unidades_pdd) unidades_pdd'
      'from frf_pedido_cab cab, frf_pedido_det det'
      'where empresa_pdc = empresa_pdd'
      'and centro_pdc = centro_pdd'
      'and pedido_pdc = pedido_pdd'
      ''
      
        'group by empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_ped' +
        'ido_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, envase_pdd, categoria_pdd, calibre_pdd, col' +
        'or_pdd, unidad_pdd'
      ''
      
        'order by empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_ped' +
        'ido_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, unidad_pdd, envase_pdd, categoria_pdd, cali' +
        'bre_pdd, color_pdd')
    Left = 328
    Top = 16
  end
  object tTemporal: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '4.08b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 32
    Top = 72
  end
  object QKilosAlbaranEx: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select '
      
        '       empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_pedid' +
        'o_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, envase_pdd, categoria_pdd, calibre_pdd, col' +
        'or_pdd, unidad_pdd, sum(unidades_pdd) unidades_pdd'
      'from frf_pedido_cab cab, frf_pedido_det det'
      'where empresa_pdc = empresa_pdd'
      'and centro_pdc = centro_pdd'
      'and pedido_pdc = pedido_pdd'
      ''
      
        'group by empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_ped' +
        'ido_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, envase_pdd, categoria_pdd, calibre_pdd, col' +
        'or_pdd, unidad_pdd'
      ''
      
        'order by empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_ped' +
        'ido_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, unidad_pdd, envase_pdd, categoria_pdd, cali' +
        'bre_pdd, color_pdd')
    Left = 144
    Top = 64
  end
  object QCajasAlbaranEx: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select '
      
        '       empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_pedid' +
        'o_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, envase_pdd, categoria_pdd, calibre_pdd, col' +
        'or_pdd, unidad_pdd, sum(unidades_pdd) unidades_pdd'
      'from frf_pedido_cab cab, frf_pedido_det det'
      'where empresa_pdc = empresa_pdd'
      'and centro_pdc = centro_pdd'
      'and pedido_pdc = pedido_pdd'
      ''
      
        'group by empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_ped' +
        'ido_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, envase_pdd, categoria_pdd, calibre_pdd, col' +
        'or_pdd, unidad_pdd'
      ''
      
        'order by empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_ped' +
        'ido_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, unidad_pdd, envase_pdd, categoria_pdd, cali' +
        'bre_pdd, color_pdd')
    Left = 232
    Top = 64
  end
  object QUnidadesAlbaranEx: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select '
      
        '       empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_pedid' +
        'o_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, envase_pdd, categoria_pdd, calibre_pdd, col' +
        'or_pdd, unidad_pdd, sum(unidades_pdd) unidades_pdd'
      'from frf_pedido_cab cab, frf_pedido_det det'
      'where empresa_pdc = empresa_pdd'
      'and centro_pdc = centro_pdd'
      'and pedido_pdc = pedido_pdd'
      ''
      
        'group by empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_ped' +
        'ido_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, envase_pdd, categoria_pdd, calibre_pdd, col' +
        'or_pdd, unidad_pdd'
      ''
      
        'order by empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_ped' +
        'ido_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, unidad_pdd, envase_pdd, categoria_pdd, cali' +
        'bre_pdd, color_pdd')
    Left = 320
    Top = 64
  end
  object QProductoAlbaran: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select '
      
        '       empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_pedid' +
        'o_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, envase_pdd, categoria_pdd, calibre_pdd, col' +
        'or_pdd, unidad_pdd, sum(unidades_pdd) unidades_pdd'
      'from frf_pedido_cab cab, frf_pedido_det det'
      'where empresa_pdc = empresa_pdd'
      'and centro_pdc = centro_pdd'
      'and pedido_pdc = pedido_pdd'
      ''
      
        'group by empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_ped' +
        'ido_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, envase_pdd, categoria_pdd, calibre_pdd, col' +
        'or_pdd, unidad_pdd'
      ''
      
        'order by empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_ped' +
        'ido_pdc, cliente_pdc, dir_suministro_pdc, '
      
        '       producto_pdd, unidad_pdd, envase_pdd, categoria_pdd, cali' +
        'bre_pdd, color_pdd')
    Left = 144
    Top = 120
  end
end
