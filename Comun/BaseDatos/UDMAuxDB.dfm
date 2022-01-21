object DMAuxDB: TDMAuxDB
  OldCreateOrder = False
  Height = 430
  Width = 534
  object prc_cambio: TStoredProc
    DatabaseName = 'BDProyecto'
    StoredProcName = 'prc_cambio'
    Left = 43
    Top = 8
    ParamData = <
      item
        DataType = ftString
        Name = 'moneda'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'fecha'
        ParamType = ptInput
      end>
  end
  object QAux: TQuery
    DatabaseName = 'BDProyecto'
    Left = 176
    Top = 8
  end
  object qpr_cliente_es_de: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'SELECT pais_c pais, cod_postal_c[1,2] prov, es_comunitario_c com' +
        'u'
      'FROM frf_clientes Frf_clientes'
      'WHERE   (empresa_c = :empresa)  '
      '   AND  (cliente_c = :cliente)  ')
    Left = 40
    Top = 145
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'cliente'
        ParamType = ptUnknown
      end>
  end
  object qpr_centro_es_de: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT cod_postal_c[1,2] prov'
      'FROM frf_centros Frf_centros'
      'WHERE   (empresa_c = :empresa)  '
      '   AND  (centro_c = :centro)  ')
    Left = 40
    Top = 264
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
  object qpr_datos_impuestos: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'SELECT codigo_i, tipo_i, descripcion_i, general_i, reducido_i, s' +
        'uper_i'
      'FROM frf_impuestos Frf_impuestos'
      'WHERE  codigo_i = :impuesto')
    Left = 40
    Top = 328
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'impuesto'
        ParamType = ptUnknown
      end>
  end
  object TAux: TTable
    DatabaseName = 'BDProyecto'
    Left = 360
    Top = 96
  end
  object qpr_suminis_es_de: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select cod_postal_ds[1,2] prov'
      'from frf_dir_sum'
      'where empresa_ds=:empresa'
      'and cliente_ds=:cliente'
      'and dir_sum_ds=:dirsum')
    Left = 40
    Top = 201
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'cliente'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'dirsum'
        ParamType = ptUnknown
      end>
  end
  object qpr_nom_provincia: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select nombre_p '
      'from frf_provincias '
      'where codigo_p=:cod')
    Left = 160
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cod'
        ParamType = ptUnknown
      end>
  end
  object qpr_peso_caja_palet: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select peso_palet_p palet,peso_caja_p caja,cajas_palet_p cajas'
      'from frf_pesos'
      'where empresa_p=:empresa'
      'and centro_p=:centro'
      'and producto_p=:producto')
    Left = 160
    Top = 139
    ParamData = <
      item
        DataType = ftString
        Name = 'empresa'
        ParamType = ptInput
        Value = 50
      end
      item
        DataType = ftString
        Name = 'centro'
        ParamType = ptInput
        Value = 1
      end
      item
        DataType = ftString
        Name = 'producto'
        ParamType = ptInput
        Value = 'T'
      end>
  end
  object qpr_peso_camion: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select tara_c peso'
      'from frf_camion'
      'where camion_c=:camion')
    Left = 160
    Top = 195
    ParamData = <
      item
        DataType = ftString
        Name = 'camion'
        ParamType = ptInput
        Value = 1
      end>
  end
  object QDescripciones: TQuery
    DatabaseName = 'BDProyecto'
    Left = 240
    Top = 8
  end
  object QGeneral: TQuery
    DatabaseName = 'BDProyecto'
    Left = 312
    Top = 8
  end
  object QAjustesLiq: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select ajuste_al'
      'from frf_ajustes_liq'
      'where empresa_al = :empresa'
      'and cosechero_al = :cosechero'
      'and producto_al = :producto'
      'and categoria_al = :categoria'
      'and anyo_semana_al = :anyosemana')
    Left = 360
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'cosechero'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'producto'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'categoria'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'anyosemana'
        ParamType = ptUnknown
      end>
  end
  object qpr_recargo_equivalencia: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'SELECT codigo_i, tipo_i, descripcion_i, general_i, reducido_i, s' +
        'uper_i'
      'FROM frf_impuestos Frf_impuestos'
      'WHERE  codigo_i = :impuesto')
    Left = 200
    Top = 328
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'impuesto'
        ParamType = ptUnknown
      end>
  end
  object QArticulosDesglose: TQuery
    DatabaseName = 'BDProyecto'
    Left = 416
    Top = 296
  end
end
