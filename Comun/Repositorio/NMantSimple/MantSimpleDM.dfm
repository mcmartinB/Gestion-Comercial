object DMMantSimple: TDMMantSimple
  OldCreateOrder = False
  Left = 439
  Top = 215
  Height = 205
  Width = 211
  object QMaestro: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_cost_portes')
    Left = 40
    Top = 16
    object QMaestroempresa_csp: TStringField
      FieldName = 'empresa_csp'
      Origin = 'COMERCIALIZACION.frf_cost_portes.empresa_csp'
      FixedChar = True
      Size = 3
    end
    object QMaestrotransporte_csp: TSmallintField
      FieldName = 'transporte_csp'
      Origin = 'COMERCIALIZACION.frf_cost_portes.transporte_csp'
    end
    object QMaestrocliente_csp: TStringField
      FieldName = 'cliente_csp'
      Origin = 'COMERCIALIZACION.frf_cost_portes.cliente_csp'
      FixedChar = True
      Size = 3
    end
    object QMaestrodir_sum_csp: TStringField
      FieldName = 'dir_sum_csp'
      Origin = 'COMERCIALIZACION.frf_cost_portes.dir_sum_csp'
      FixedChar = True
      Size = 3
    end
    object QMaestroimporte_csp: TFloatField
      FieldName = 'importe_csp'
      Origin = 'COMERCIALIZACION.frf_cost_portes.importe_csp'
    end
  end
  object QListado: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'SELECT empresa_t, transporte_t, descripcion_t, tara_t, codigo_al' +
        'macen_t'
      'FROM frf_transportistas Frf_transportistas'
      'ORDER BY empresa_t, transporte_t')
    Left = 40
    Top = 72
  end
  object QDirSum: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      '')
    Left = 104
    Top = 72
  end
end
