object DMPedidos: TDMPedidos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 307
  Width = 554
  object QMaestro: TQuery
    AfterOpen = QMaestroAfterOpen
    BeforeClose = QMaestroBeforeClose
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_pedido_cab'
      'WHERE empresa_pdc = '#39'###'#39
      'ORDER BY empresa_pdc, centro_pdc, pedido_pdc')
    Left = 32
    Top = 8
  end
  object DSEnlace: TDataSource
    DataSet = QMaestro
    Left = 120
    Top = 8
  end
  object TDetalle: TTable
    AfterPost = TDetalleAfterPost
    DatabaseName = 'BDProyecto'
    IndexFieldNames = 'empresa_pdd;centro_pdd;pedido_pdd'
    MasterFields = 'empresa_pdc;centro_pdc;pedido_pdc'
    MasterSource = DSEnlace
    TableName = 'frf_pedido_det'
    Left = 176
    Top = 8
  end
  object QNumeroPedido: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select max(nvl(pedido_pdc,0)) '
      'from frf_pedido_cab'
      'where empresa_pdc = :empresa'
      'and centro_pdc = :centro')
    Left = 40
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'centro'
        ParamType = ptUnknown
      end>
  end
  object QNumeroLinea: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select max(nvl(pedido_pdc,0)) '
      'from frf_pedido_cab'
      'where empresa_pdc = :empresa'
      'and centro_pdc = :centro')
    Left = 128
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'centro'
        ParamType = ptUnknown
      end>
  end
  object QUnidad: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select max(nvl(pedido_pdc,0)) '
      'from frf_pedido_cab'
      'where empresa_pdc = :empresa'
      'and centro_pdc = :centro')
    Left = 224
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'centro'
        ParamType = ptUnknown
      end>
  end
  object QSuministro: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select max(nvl(pedido_pdc,0)) '
      'from frf_pedido_cab'
      'where empresa_pdc = :empresa'
      'and centro_pdc = :centro')
    Left = 312
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'centro'
        ParamType = ptUnknown
      end>
  end
  object QListado: TQuery
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
    Left = 312
    Top = 8
  end
  object QNotas: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSNotas
    Left = 424
    Top = 8
  end
  object DSNotas: TDataSource
    DataSet = QListado
    Left = 368
    Top = 8
  end
  object QTotalDetalle: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSEnlace
    SQL.Strings = (
      'SELECT *'
      'FROM frf_pedido_cab'
      'WHERE empresa_pdc = '#39'###'#39
      'ORDER BY empresa_pdc, centro_pdc, pedido_pdc')
    Left = 176
    Top = 56
  end
end
