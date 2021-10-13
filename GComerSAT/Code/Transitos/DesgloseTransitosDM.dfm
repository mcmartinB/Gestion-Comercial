object DMDesgloseTransitos: TDMDesgloseTransitos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 872
  Top = 183
  Height = 349
  Width = 289
  object mtTransito: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'empresa'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'centro_salida'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'centro_destino'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'producto'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'kilos_transito'
        DataType = ftFloat
      end
      item
        Name = 'kilos_salidos'
        DataType = ftFloat
      end>
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
    OnCalcFields = mtTransitoCalcFields
    Left = 64
    Top = 32
    object mtTransitoempresa: TStringField
      FieldName = 'empresa'
      Size = 3
    end
    object mtTransitocentro_salida: TStringField
      FieldName = 'centro_salida'
      Size = 1
    end
    object mtTransitocentro_destino: TStringField
      FieldName = 'centro_destino'
      Size = 1
    end
    object mtKilosTransitotransito: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'transito'
      Calculated = True
    end
    object mtTransitofecha: TDateField
      FieldKind = fkCalculated
      FieldName = 'fecha'
      Calculated = True
    end
    object mtTransitoproducto: TStringField
      DisplayWidth = 3
      FieldName = 'producto'
      FixedChar = True
      Size = 3
    end
    object mtTransitokilos_transito: TFloatField
      FieldName = 'kilos_transito'
      DisplayFormat = '#,##0.00'
    end
    object mtTransitokilos_salidos: TFloatField
      FieldName = 'kilos_salidos'
      DisplayFormat = '#,##0.00'
    end
    object mtTransitokilos_pendientes: TFloatField
      FieldKind = fkCalculated
      FieldName = 'kilos_pendientes'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
  end
  object mtSalidasTransito: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'empresa_sl'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'centro_salida_sl'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'n_albaran_sl'
        DataType = ftInteger
      end
      item
        Name = 'fecha_sl'
        DataType = ftDate
      end
      item
        Name = 'cliente_sal_sc'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'dir_sum_sc'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'producto_sl'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'envase_sl'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'categoria_sl'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'calibre_sl'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'n_factura_sc'
        DataType = ftInteger
      end
      item
        Name = 'fecha_factura_sc'
        DataType = ftDate
      end
      item
        Name = 'kilos_sl'
        DataType = ftFloat
      end>
    IndexDefs = <>
    SortFields = 
      'empresa_sl;centro_salida_sl;producto_sl;n_albaran_sl;fecha_sl;en' +
      'vase_sl'
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '4.08b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 64
    Top = 80
    object mtSalidasTransitoempresa_sl: TStringField
      FieldName = 'empresa_sl'
      FixedChar = True
      Size = 3
    end
    object mtSalidasTransitocentro_salida_sl: TStringField
      FieldName = 'centro_salida_sl'
      FixedChar = True
      Size = 1
    end
    object mtSalidasTransiton_albaran_sl: TIntegerField
      FieldName = 'n_albaran_sl'
    end
    object mtSalidasTransitofecha_sl: TDateField
      FieldName = 'fecha_sl'
    end
    object mtSalidasTransitocliente_sal_sc: TStringField
      FieldName = 'cliente_sal_sc'
      FixedChar = True
      Size = 3
    end
    object mtSalidasTransitodir_sum_sc: TStringField
      FieldName = 'dir_sum_sc'
      FixedChar = True
      Size = 3
    end
    object mtSalidasTransitoproducto_sl: TStringField
      DisplayWidth = 3
      FieldName = 'producto_sl'
      FixedChar = True
      Size = 3
    end
    object mtSalidasTransitoenvase_sl: TStringField
      FieldName = 'envase_sl'
      FixedChar = True
      Size = 3
    end
    object mtSalidasTransitocategoria_sl: TStringField
      FieldName = 'categoria_sl'
      FixedChar = True
      Size = 2
    end
    object mtSalidasTransitocalibre_sl: TStringField
      FieldName = 'calibre_sl'
      FixedChar = True
      Size = 6
    end
    object mtSalidasTransiton_factura_sc: TIntegerField
      FieldName = 'n_factura_sc'
    end
    object mtSalidasTransitofecha_factura_sc: TDateField
      FieldName = 'fecha_factura_sc'
    end
    object mtSalidasTransitokilos_sl: TFloatField
      FieldName = 'kilos_sl'
    end
  end
  object mtTransitosTransito: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'empresa_tl'
        Attributes = [faFixed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'centro_tl'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'referencia_tl'
        DataType = ftInteger
      end
      item
        Name = 'fecha_tl'
        DataType = ftDate
      end
      item
        Name = 'producto_tl'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'kilos_tl'
        DataType = ftFloat
      end>
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
    Left = 64
    Top = 128
    object mtTransitosTransitoempresa_tl: TStringField
      FieldName = 'empresa_tl'
      FixedChar = True
      Size = 3
    end
    object mtTransitosTransitocentro_tl: TStringField
      FieldName = 'centro_tl'
      FixedChar = True
      Size = 1
    end
    object mtTransitosTransitoreferencia_tl: TIntegerField
      FieldName = 'referencia_tl'
    end
    object mtTransitosTransitofecha_tl: TDateField
      FieldName = 'fecha_tl'
    end
    object mtTransitosTransitoproducto_tl: TStringField
      DisplayWidth = 3
      FieldName = 'producto_tl'
      FixedChar = True
      Size = 3
    end
    object mtTransitosTransitokilos_tl: TFloatField
      FieldName = 'kilos_tl'
    end
  end
  object QAux: TQuery
    DatabaseName = 'BDProyecto'
    Left = 64
    Top = 192
  end
  object mtTransitoAux: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'empresa'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'centro_salida'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'centro_destino'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'producto'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'kilos_transito'
        DataType = ftFloat
      end
      item
        Name = 'kilos_salidos'
        DataType = ftFloat
      end>
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
    OnCalcFields = mtTransitoAuxCalcFields
    Left = 160
    Top = 32
    object mtTransitoAuxempresa: TStringField
      FieldName = 'empresa'
      Size = 3
    end
    object mtTransitoAuxcentro_salida: TStringField
      FieldName = 'centro_salida'
      Size = 1
    end
    object mtTransitoAuxcentro_destino: TStringField
      FieldName = 'centro_destino'
      Size = 1
    end
    object mtTransitoAuxtransito: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'transito'
      Calculated = True
    end
    object mtTransitoAuxfecha: TDateField
      FieldKind = fkCalculated
      FieldName = 'fecha'
      Calculated = True
    end
    object mtTransitoAuxproducto: TStringField
      DisplayWidth = 3
      FieldName = 'producto'
      FixedChar = True
      Size = 3
    end
    object mtTransitoAuxkilos_transito: TFloatField
      FieldName = 'kilos_transito'
      DisplayFormat = '#,##0.00'
    end
    object mtTransitoAuxkilos_salidos: TFloatField
      FieldName = 'kilos_salidos'
      DisplayFormat = '#,##0.00'
    end
    object mtTransitoAuxkilos_pendientes: TFloatField
      FieldKind = fkCalculated
      FieldName = 'kilos_pendientes'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
  end
end
