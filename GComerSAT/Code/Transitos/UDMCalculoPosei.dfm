object DMCalculoPosei: TDMCalculoPosei
  OldCreateOrder = False
  Height = 366
  Width = 499
  object QTransito: TQuery
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 16
  end
  object QPacking: TQuery
    DatabaseName = 'dbLlanos'
    Left = 104
    Top = 16
  end
  object QAlbaran: TQuery
    DatabaseName = 'BDProyecto'
    Left = 160
    Top = 16
  end
  object QFactura: TQuery
    DatabaseName = 'BDProyecto'
    Left = 216
    Top = 16
  end
  object QPosei: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 48
    Top = 176
  end
  object QBorrarPosei: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 104
    Top = 176
  end
  object QAlbaranResto: TQuery
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 80
  end
  object QAux: TQuery
    DatabaseName = 'BDProyecto'
    Left = 264
    Top = 184
  end
  object QDescProducto: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 264
  end
  object QDescCliente: TQuery
    DatabaseName = 'BDProyecto'
    Left = 120
    Top = 264
  end
  object QDescCentro: TQuery
    DatabaseName = 'BDProyecto'
    Left = 200
    Top = 264
  end
  object QGastoAlbaran: TQuery
    DatabaseName = 'BDProyecto'
    Left = 281
    Top = 264
  end
  object QAlbaranAgrupado: TQuery
    DatabaseName = 'BDProyecto'
    Left = 369
    Top = 264
  end
  object kmtAlbPartidos: TkbmMemTable
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
    Left = 408
    Top = 136
    object kmtAlbPartidosempresa_alb: TStringField
      FieldName = 'empresa_alb'
      Size = 3
    end
    object kmtAlbPartidoscentro_alb: TStringField
      FieldName = 'centro_alb'
      Size = 1
    end
    object kmtAlbPartidosnumero_alb: TIntegerField
      FieldName = 'numero_alb'
    end
    object kmtAlbPartidosfecha_alb: TDateTimeField
      FieldName = 'fecha_alb'
    end
    object kmtAlbPartidosempresa_fac_alb: TStringField
      FieldName = 'empresa_fac_alb'
      Size = 3
    end
    object kmtAlbPartidosserie_fac_alb: TStringField
      FieldName = 'serie_fac_alb'
      Size = 3
    end
    object kmtAlbPartidosnumero_fac_alb: TIntegerField
      FieldName = 'numero_fac_alb'
    end
    object kmtAlbPartidosfecha_fac_alb: TDateTimeField
      FieldName = 'fecha_fac_alb'
    end
    object kmtAlbPartidosproducto_alb: TStringField
      FieldName = 'producto_alb'
      Size = 3
    end
    object kmtAlbPartidoscajas_alb: TIntegerField
      FieldName = 'cajas_alb'
    end
    object kmtAlbPartidoskilos_alb: TCurrencyField
      FieldName = 'kilos_alb'
    end
  end
  object QAlbaranDirecto: TQuery
    DatabaseName = 'BDProyecto'
    Left = 120
    Top = 80
  end
  object kmtInforme: TkbmMemTable
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
    Left = 408
    Top = 32
    object kmtInformedefinitivo: TStringField
      FieldName = 'definitivo'
      Size = 1
    end
    object kmtInformeanyo_p: TIntegerField
      FieldName = 'anyo'
    end
    object kmtInformesemestre_p: TIntegerField
      FieldName = 'semestre'
    end
    object kmtInformeproducto_p: TStringField
      FieldName = 'producto'
      Size = 3
    end
    object StringField1: TStringField
      FieldName = 'empresa_transito'
      Size = 3
    end
    object kmtInformecentro_transito_p: TStringField
      FieldName = 'centro_transito'
      Size = 1
    end
    object kmtInformeref_transito_p: TIntegerField
      FieldName = 'ref_transito'
    end
    object kmtInformefecha_transito_p: TDateField
      FieldName = 'fecha_transito'
    end
    object kmtInformecajas_transito_p: TIntegerField
      FieldName = 'cajas_transito'
    end
    object kmtInformekilos_transito_p: TCurrencyField
      FieldName = 'kilos_transito'
    end
    object kmtInformedua_salida: TStringField
      FieldName = 'dua_salida'
    end
    object kmtInformefecha_llegada: TDateField
      FieldName = 'fecha_llegada'
    end
    object kmtInformedua_llegada: TStringField
      FieldName = 'dua_llegada'
    end
    object kmtInformen_albaran: TIntegerField
      FieldName = 'n_albaran'
    end
    object kmtInformecodigo_factura_p: TStringField
      FieldName = 'codigo_factura'
      Size = 15
    end
    object kmtInformefecha_factura: TDateField
      FieldName = 'fecha_factura'
    end
    object kmtInformecajas: TIntegerField
      FieldName = 'cajas'
    end
    object kmtInformekilos: TCurrencyField
      FieldName = 'kilos'
    end
    object kmtInformeimporte: TCurrencyField
      FieldName = 'importe'
    end
    object kmtInformeimporte_factura: TCurrencyField
      FieldName = 'importe_factura'
    end
  end
  object QConsulta: TQuery
    DatabaseName = 'BDProyecto'
    Left = 448
    Top = 232
  end
  object QDeposito: TQuery
    DatabaseName = 'BDProyecto'
    Left = 216
    Top = 72
  end
  object kmtControl: TkbmMemTable
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
    Left = 408
    Top = 88
    object kmtControldefinitivo: TStringField
      FieldName = 'definitivo'
      Size = 1
    end
    object StringField3: TStringField
      FieldName = 'empresa_transito'
      Size = 3
    end
    object StringField4: TStringField
      FieldName = 'centro_transito'
      Size = 1
    end
    object IntegerField3: TIntegerField
      FieldName = 'ref_transito'
    end
    object DateField1: TDateField
      FieldName = 'fecha_transito'
    end
    object StringField2: TStringField
      FieldName = 'producto'
      Size = 3
    end
    object CurrencyField1: TCurrencyField
      FieldName = 'kilos_transito'
    end
    object CurrencyField2: TCurrencyField
      FieldName = 'kilos_factura'
    end
    object kmtControldiferencia: TFloatField
      FieldName = 'diferencia'
    end
  end
  object QPoseiTemp: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 176
    Top = 176
  end
  object QPoseiTemp2: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 232
    Top = 144
  end
  object kmtOficial: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'definitivo'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'anyo'
        DataType = ftInteger
      end
      item
        Name = 'semestre'
        DataType = ftInteger
      end
      item
        Name = 'producto'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'des_producto'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'cod_empresa_fac'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'n_factura'
        DataType = ftInteger
      end
      item
        Name = 'fecha_factura'
        DataType = ftDate
      end
      item
        Name = 'codigo_factura'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'codigo_pais'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'nif_cliente'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'cod_cliente'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'des_cliente'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'cajas'
        DataType = ftInteger
      end
      item
        Name = 'kilos'
        DataType = ftCurrency
      end
      item
        Name = 'importe'
        DataType = ftCurrency
      end>
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
    Left = 328
    Top = 32
    object StringField5: TStringField
      FieldName = 'definitivo'
      Size = 1
    end
    object kmtOficialanyo: TIntegerField
      FieldName = 'anyo'
    end
    object kmtOficialsemestre: TIntegerField
      FieldName = 'semestre'
    end
    object kmtOficialagrupacion: TIntegerField
      FieldName = 'agrupacion'
    end
    object kmtOficialdes_agrupacion: TStringField
      FieldName = 'des_agrupacion'
      Size = 50
    end
    object StringField6: TStringField
      FieldName = 'producto'
      Size = 3
    end
    object kmtOficialdes_producto: TStringField
      FieldName = 'des_producto'
      Size = 30
    end
    object kmtOficialcod_empresa_fac: TStringField
      FieldName = 'cod_empresa_fac'
      Size = 3
    end
    object kmtOficialn_factura_fc: TIntegerField
      FieldName = 'n_factura'
    end
    object kmtOficialfecha_factura: TDateField
      FieldName = 'fecha_factura'
    end
    object StringField11: TStringField
      FieldName = 'codigo_factura'
      Size = 15
    end
    object kmtOficialcodigo_pais: TStringField
      FieldName = 'codigo_pais'
      Size = 2
    end
    object kmtOficialdes_pais: TStringField
      FieldName = 'des_pais'
      Size = 30
    end
    object kmtOficialdes_provincia: TStringField
      FieldName = 'des_provincia'
      Size = 30
    end
    object kmtOficialnif_cliente: TStringField
      FieldName = 'nif_cliente'
      Size = 14
    end
    object kmtOficialcod_cliente: TStringField
      FieldName = 'cod_cliente'
      Size = 3
    end
    object kmtOficialdes_cliente: TStringField
      FieldName = 'des_cliente'
      Size = 50
    end
    object IntegerField6: TIntegerField
      FieldName = 'cajas'
    end
    object CurrencyField4: TCurrencyField
      FieldName = 'kilos'
    end
    object CurrencyField5: TCurrencyField
      FieldName = 'importe'
    end
  end
end
