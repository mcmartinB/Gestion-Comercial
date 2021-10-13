object DMInventario: TDMInventario
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Height = 262
  Width = 397
  object QInventarioCab: TQuery
    AfterOpen = QInventarioCabAfterOpen
    BeforeClose = QInventarioCabBeforeClose
    OnCalcFields = QInventarioCabCalcFields
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      ' SELECT * FROM frf_inventarios_c '
      ' WHERE empresa_ic='#39'###'#39
      ' ORDER BY fecha_ic desc, empresa_ic, centro_ic, producto_ic ')
    Left = 40
    Top = 18
    object QInventarioCabempresa_ic: TStringField
      FieldName = 'empresa_ic'
      Origin = 'COMERCIALIZACION.frf_inventarios_c.empresa_ic'
      FixedChar = True
      Size = 3
    end
    object QInventarioCabcentro_ic: TStringField
      FieldName = 'centro_ic'
      Origin = 'COMERCIALIZACION.frf_inventarios_c.centro_ic'
      FixedChar = True
      Size = 1
    end
    object QInventarioCabproducto_ic: TStringField
      DisplayWidth = 3
      FieldName = 'producto_ic'
      Origin = 'COMERCIALIZACION.frf_inventarios_c.producto_ic'
      FixedChar = True
      Size = 3
    end
    object QInventarioCabkilos_cec_ic: TFloatField
      FieldName = 'kilos_cec_ic'
      Origin = 'COMERCIALIZACION.frf_inventarios_c.kilos_cec_ic'
      DisplayFormat = '#0.00'
    end
    object QInventarioCabkilos_cim_c1_ic: TFloatField
      FieldName = 'kilos_cim_c1_ic'
      Origin = 'COMERCIALIZACION.frf_inventarios_c.kilos_cim_c1_ic'
      DisplayFormat = '#0.00'
    end
    object QInventarioCabkilos_cim_c2_ic: TFloatField
      FieldName = 'kilos_cim_c2_ic'
      Origin = 'COMERCIALIZACION.frf_inventarios_c.kilos_cim_c2_ic'
      DisplayFormat = '#0.00'
    end
    object QInventarioCabkilos_cia_c1_ic: TFloatField
      FieldName = 'kilos_cia_c1_ic'
      Origin = 'COMERCIALIZACION.frf_inventarios_c.kilos_cia_c1_ic'
      DisplayFormat = '#0.00'
    end
    object QInventarioCabkilos_cia_c2_ic: TFloatField
      FieldName = 'kilos_cia_c2_ic'
      Origin = 'COMERCIALIZACION.frf_inventarios_c.kilos_cia_c2_ic'
      DisplayFormat = '#0.00'
    end
    object QInventarioCabkilos_zd_c3_ic: TFloatField
      FieldName = 'kilos_zd_c3_ic'
      Origin = 'COMERCIALIZACION.frf_inventarios_c.kilos_zd_c3_ic'
      DisplayFormat = '#0.00'
    end
    object QInventarioCabkilos_zd_d_ic: TFloatField
      FieldName = 'kilos_zd_d_ic'
      Origin = 'COMERCIALIZACION.frf_inventarios_c.kilos_zd_d_ic'
      DisplayFormat = '#0.00'
    end
    object QInventarioCabdes_empresa: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_empresa'
      Size = 30
      Calculated = True
    end
    object QInventarioCabdes_centro: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_centro'
      Size = 30
      Calculated = True
    end
    object QInventarioCabdes_producto: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_producto'
      Size = 30
      Calculated = True
    end
    object QInventarioCabnotas_ic: TStringField
      FieldName = 'notas_ic'
      Origin = '"COMER.DESARROLLO".frf_inventarios_c.notas_ic'
      Size = 255
    end
    object QInventarioCabkilos_ajuste_c1_ic: TFloatField
      FieldName = 'kilos_ajuste_c1_ic'
    end
    object QInventarioCabkilos_ajuste_c2_ic: TFloatField
      FieldName = 'kilos_ajuste_c2_ic'
    end
    object QInventarioCabkilos_ajuste_c3_ic: TFloatField
      FieldName = 'kilos_ajuste_c3_ic'
    end
    object QInventarioCabkilos_ajuste_cd_ic: TFloatField
      FieldName = 'kilos_ajuste_cd_ic'
    end
    object QInventarioCabkilos_ajuste_campo_ic: TFloatField
      FieldName = 'kilos_ajuste_campo_ic'
    end
  end
  object DSInventarioCab: TDataSource
    DataSet = QInventarioCab
    Left = 144
    Top = 17
  end
  object QInventarioLin: TQuery
    BeforePost = QInventarioLinBeforePost
    AfterPost = QInventarioLinAfterPost
    OnCalcFields = QInventarioLinCalcFields
    DatabaseName = 'BDProyecto'
    DataSource = DSInventarioCab
    RequestLive = True
    SQL.Strings = (
      'select *'
      'from frf_inventarios_l'
      'where empresa_il = :empresa_ic'
      'and centro_il = :centro_ic'
      'and producto_il = :producto_ic'
      'and fecha_il = :fecha_ic')
    Left = 255
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa_ic'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'centro_ic'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'producto_ic'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha_ic'
        ParamType = ptUnknown
      end>
    object QInventarioLinempresa_il: TStringField
      FieldName = 'empresa_il'
      Origin = '"COMER.DESARROLLO".frf_inventarios_l.empresa_il'
      FixedChar = True
      Size = 3
    end
    object QInventarioLincentro_il: TStringField
      FieldName = 'centro_il'
      Origin = '"COMER.DESARROLLO".frf_inventarios_l.centro_il'
      FixedChar = True
      Size = 1
    end
    object QInventarioLinproducto_il: TStringField
      DisplayWidth = 3
      FieldName = 'producto_il'
      Origin = '"COMER.DESARROLLO".frf_inventarios_l.producto_il'
      FixedChar = True
      Size = 3
    end
    object QInventarioLinenvase_il: TStringField
      DisplayWidth = 9
      FieldName = 'envase_il'
      Origin = '"COMER.DESARROLLO".frf_inventarios_l.envase_il'
      FixedChar = True
      Size = 9
    end
    object QInventarioLincajas_ce_c1_il: TIntegerField
      FieldName = 'cajas_ce_c1_il'
      Origin = '"COMER.DESARROLLO".frf_inventarios_l.cajas_ce_c1_il'
    end
    object QInventarioLinkilos_ce_c1_il: TFloatField
      FieldName = 'kilos_ce_c1_il'
      Origin = '"COMER.DESARROLLO".frf_inventarios_l.kilos_ce_c1_il'
    end
    object QInventarioLincajas_ce_c2_il: TIntegerField
      FieldName = 'cajas_ce_c2_il'
      Origin = '"COMER.DESARROLLO".frf_inventarios_l.cajas_ce_c2_il'
    end
    object QInventarioLinkilos_ce_c2_il: TFloatField
      FieldName = 'kilos_ce_c2_il'
      Origin = '"COMER.DESARROLLO".frf_inventarios_l.kilos_ce_c2_il'
    end
    object QInventarioLindes_envase: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_envase'
      Size = 30
      Calculated = True
    end
    object QInventarioLincalibre_il: TStringField
      FieldName = 'calibre_il'
      Origin = 'COMERCIALIZACION.frf_inventarios_l.calibre_il'
      FixedChar = True
      Size = 6
    end
  end
end
