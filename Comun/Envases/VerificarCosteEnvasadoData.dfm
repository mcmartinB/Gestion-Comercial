object DMVerificarCosteEnvasado: TDMVerificarCosteEnvasado
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 302
  Width = 579
  object MemTable: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'categoria'
        Attributes = [faRequired]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'envase'
        Attributes = [faRequired]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'actual'
        DataType = ftFloat
      end
      item
        Name = 'nacional'
        DataType = ftFloat
      end
      item
        Name = 'exportacion'
        DataType = ftFloat
      end
      item
        Name = 'transitos'
        DataType = ftFloat
      end
      item
        Name = 'anterior'
        DataType = ftFloat
      end>
    IndexDefs = <>
    SortFields = 'categoria;envase'
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
    Top = 96
  end
  object qrySalidas: TQuery
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
    Left = 56
    Top = 24
  end
  object qryCostes: TQuery
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
    Left = 128
    Top = 24
  end
end
