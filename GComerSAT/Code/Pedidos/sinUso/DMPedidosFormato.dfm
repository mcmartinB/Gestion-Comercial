object dtmMPedidosFormato: TdtmMPedidosFormato
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 665
  Top = 171
  Height = 362
  Width = 554
  object QMaestro: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_pedido_cab'
      'WHERE empresa_pdc = '#39'###'#39
      'ORDER BY empresa_pdc, centro_pdc, pedido_pdc')
    Left = 40
    Top = 8
    object QMaestroempresa_pdc: TStringField
      FieldName = 'empresa_pdc'
      Origin = 'BDPROYECTO.frf_pedido_cab.empresa_pdc'
      FixedChar = True
      Size = 3
    end
    object QMaestrocentro_pdc: TStringField
      FieldName = 'centro_pdc'
      Origin = 'BDPROYECTO.frf_pedido_cab.centro_pdc'
      FixedChar = True
      Size = 1
    end
    object QMaestropedido_pdc: TIntegerField
      FieldName = 'pedido_pdc'
      Origin = 'BDPROYECTO.frf_pedido_cab.pedido_pdc'
    end
    object QMaestrofecha_pdc: TDateField
      FieldName = 'fecha_pdc'
      Origin = 'BDPROYECTO.frf_pedido_cab.fecha_pdc'
    end
    object QMaestroref_pedido_pdc: TStringField
      FieldName = 'ref_pedido_pdc'
      Origin = 'BDPROYECTO.frf_pedido_cab.ref_pedido_pdc'
    end
    object QMaestrocliente_pdc: TStringField
      FieldName = 'cliente_pdc'
      Origin = 'BDPROYECTO.frf_pedido_cab.cliente_pdc'
      FixedChar = True
      Size = 3
    end
    object QMaestrodir_suministro_pdc: TStringField
      FieldName = 'dir_suministro_pdc'
      Origin = 'BDPROYECTO.frf_pedido_cab.dir_suministro_pdc'
      FixedChar = True
      Size = 3
    end
    object QMaestromoneda_pdc: TStringField
      FieldName = 'moneda_pdc'
      Origin = 'BDPROYECTO.frf_pedido_cab.moneda_pdc'
      FixedChar = True
      Size = 3
    end
    object QMaestroobservaciones_pdc: TStringField
      FieldName = 'observaciones_pdc'
      Origin = 'BDPROYECTO.frf_pedido_cab.observaciones_pdc'
      Size = 160
    end
    object QMaestroanulado_pdc: TIntegerField
      FieldName = 'anulado_pdc'
      Origin = 'BDPROYECTO.frf_pedido_cab.anulado_pdc'
    end
    object QMaestromotivo_anulacion_pdc: TStringField
      FieldName = 'motivo_anulacion_pdc'
      Origin = 'BDPROYECTO.frf_pedido_cab.motivo_anulacion_pdc'
      FixedChar = True
      Size = 30
    end
    object QMaestrofinalizado_pdc: TIntegerField
      FieldName = 'finalizado_pdc'
      Origin = 'BDPROYECTO.frf_pedido_cab.finalizado_pdc'
    end
  end
  object DSEnlace: TDataSource
    DataSet = QMaestro
    Left = 120
    Top = 8
  end
  object TDetalle: TTable
    OnCalcFields = TDetalleCalcFields
    DatabaseName = 'BDProyecto'
    IndexFieldNames = 'empresa_pdd;centro_pdd;pedido_pdd'
    MasterFields = 'empresa_pdc;centro_pdc;pedido_pdc'
    MasterSource = DSEnlace
    TableName = 'frf_pedido_det'
    Left = 176
    Top = 8
    object TDetalleempresa_pdd: TStringField
      FieldName = 'empresa_pdd'
      Required = True
      FixedChar = True
      Size = 3
    end
    object TDetallecentro_pdd: TStringField
      FieldName = 'centro_pdd'
      Required = True
      FixedChar = True
      Size = 1
    end
    object TDetallepedido_pdd: TIntegerField
      FieldName = 'pedido_pdd'
      Required = True
    end
    object TDetallelinea_pdd: TIntegerField
      FieldName = 'linea_pdd'
      Required = True
    end
    object TDetalleproducto_pdd: TStringField
      FieldName = 'producto_pdd'
      Required = True
      FixedChar = True
      Size = 1
    end
    object TDetalleproducto_base_pdd: TSmallintField
      FieldName = 'producto_base_pdd'
    end
    object TDetalleformato_cliente_pdd: TStringField
      FieldName = 'formato_cliente_pdd'
      FixedChar = True
      Size = 16
    end
    object TDetalleenvase_pdd: TStringField
      FieldName = 'envase_pdd'
      Required = True
      FixedChar = True
      Size = 3
    end
    object TDetallemarca_pdd: TStringField
      FieldName = 'marca_pdd'
      FixedChar = True
      Size = 2
    end
    object TDetallecategoria_pdd: TStringField
      FieldName = 'categoria_pdd'
      Required = True
      FixedChar = True
      Size = 2
    end
    object TDetallecalibre_pdd: TStringField
      FieldName = 'calibre_pdd'
      Required = True
      FixedChar = True
      Size = 6
    end
    object TDetallecolor_pdd: TStringField
      FieldName = 'color_pdd'
      Required = True
      FixedChar = True
      Size = 1
    end
    object TDetallecantidad_pdd: TFloatField
      FieldName = 'cantidad_pdd'
    end
    object TDetalleunidad_pdd: TStringField
      FieldName = 'unidad_pdd'
      Required = True
      FixedChar = True
      Size = 1
    end
    object TDetallepalets_pdd: TIntegerField
      FieldName = 'palets_pdd'
    end
    object TDetallecajas_pdd: TIntegerField
      FieldName = 'cajas_pdd'
    end
    object TDetalleunidades_pdd: TIntegerField
      FieldName = 'unidades_pdd'
      Required = True
    end
    object TDetallekilos_pdd: TFloatField
      FieldName = 'kilos_pdd'
    end
    object TDetallecajas_aservir_pdd: TIntegerField
      FieldName = 'cajas_aservir_pdd'
    end
    object TDetalleprecio_pdd: TFloatField
      FieldName = 'precio_pdd'
    end
    object TDetalleunidad_precio_pdd: TStringField
      FieldName = 'unidad_precio_pdd'
      FixedChar = True
      Size = 3
    end
    object TDetalletipo_iva_pdd: TStringField
      FieldName = 'tipo_iva_pdd'
      FixedChar = True
      Size = 2
    end
    object TDetalleporc_iva_pdd: TFloatField
      FieldName = 'porc_iva_pdd'
    end
    object TDetalleimporte_neto_pdd: TFloatField
      FieldName = 'importe_neto_pdd'
    end
    object TDetalleiva_pdd: TFloatField
      FieldName = 'iva_pdd'
    end
    object TDetalleimporte_total_pdd: TFloatField
      FieldName = 'importe_total_pdd'
    end
    object TDetalledesFormatoCli: TStringField
      FieldKind = fkCalculated
      FieldName = 'desFormatoCli'
      Size = 30
      Calculated = True
    end
    object TDetalledesUnidadPedido: TStringField
      FieldKind = fkCalculated
      FieldName = 'desUnidadPedido'
      Size = 10
      Calculated = True
    end
    object TDetallecajas_servidas: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'cajas_servidas'
      Calculated = True
    end
  end
  object QNumeroPedido: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select max(nvl(pedido_pdc,0)) '
      'from frf_pedido_cab'
      'where empresa_pdc = :empresa'
      'and centro_pdc = :centro')
    Left = 40
    Top = 64
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
    Left = 120
    Top = 64
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
    Left = 296
    Top = 144
  end
  object QNotas: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSNotas
    Left = 408
    Top = 144
  end
  object DSNotas: TDataSource
    DataSet = QListado
    Left = 352
    Top = 144
  end
  object QSuministro: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select max(nvl(pedido_pdc,0)) '
      'from frf_pedido_cab'
      'where empresa_pdc = :empresa'
      'and centro_pdc = :centro')
    Left = 200
    Top = 64
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
  object QAux: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select max(nvl(pedido_pdc,0)) '
      'from frf_pedido_cab'
      'where empresa_pdc = :empresa'
      'and centro_pdc = :centro')
    Left = 40
    Top = 120
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
  object QCajasServidas: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT *'
      'FROM frf_pedido_cab'
      'WHERE empresa_pdc = '#39'###'#39
      'ORDER BY empresa_pdc, centro_pdc, pedido_pdc')
    Left = 216
    Top = 248
  end
  object QCajasAServir: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT *'
      'FROM frf_pedido_cab'
      'WHERE empresa_pdc = '#39'###'#39
      'ORDER BY empresa_pdc, centro_pdc, pedido_pdc')
    Left = 120
    Top = 248
  end
  object QPedidoAServir: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT *'
      'FROM frf_pedido_cab'
      'WHERE empresa_pdc = '#39'###'#39
      'ORDER BY empresa_pdc, centro_pdc, pedido_pdc')
    Left = 40
    Top = 248
  end
  object QIncedencia: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT *'
      'FROM frf_pedido_cab'
      'WHERE empresa_pdc = '#39'###'#39
      'ORDER BY empresa_pdc, centro_pdc, pedido_pdc')
    Left = 376
    Top = 248
  end
  object QObservacion: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT *'
      'FROM frf_pedido_cab'
      'WHERE empresa_pdc = '#39'###'#39
      'ORDER BY empresa_pdc, centro_pdc, pedido_pdc')
    Left = 296
    Top = 248
  end
  object QCajasServidasLinea: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT *'
      'FROM frf_pedido_cab'
      'WHERE empresa_pdc = '#39'###'#39
      'ORDER BY empresa_pdc, centro_pdc, pedido_pdc')
    Left = 392
    Top = 40
  end
end
