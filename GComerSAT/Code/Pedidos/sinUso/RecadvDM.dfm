object DMRecadv: TDMRecadv
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 837
  Top = 169
  Height = 448
  Width = 562
  object QMaestro: TQuery
    AfterOpen = QMaestroAfterOpen
    BeforeClose = QMaestroBeforeClose
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select * '
      'from frf_formatos')
    Left = 40
    Top = 32
  end
  object DSMaestro: TDataSource
    DataSet = QMaestro
    Left = 112
    Top = 32
  end
  object QDetalle: TQuery
    OnCalcFields = QDetalleCalcFields
    DatabaseName = 'BDProyecto'
    Filtered = True
    OnFilterRecord = QDetalleFilterRecord
    DataSource = DSMaestro
    SQL.Strings = (
      
        'select idcab_elr, idemb_elr, idlin_elr, ean_elr, refprov_elr, re' +
        'fcli_elr, cantace_elr, cantue_elr '
      'from edi_lincre')
    Left = 190
    Top = 88
    object QDetalleidcab_elr: TStringField
      FieldName = 'idcab_elr'
      Origin = 'BDPROYECTO.edi_lincre.idcab_elr'
      FixedChar = True
      Size = 10
    end
    object QDetalleidemb_elr: TStringField
      FieldName = 'idemb_elr'
      Origin = 'BDPROYECTO.edi_lincre.idemb_elr'
      FixedChar = True
      Size = 10
    end
    object QDetalleidlin_elr: TStringField
      FieldName = 'idlin_elr'
      Origin = 'BDPROYECTO.edi_lincre.idlin_elr'
      FixedChar = True
      Size = 10
    end
    object QDetalleean_elr: TStringField
      FieldName = 'ean_elr'
      Origin = 'BDPROYECTO.edi_lincre.ean_elr'
      FixedChar = True
      Size = 35
    end
    object QDetallerefprov_elr: TStringField
      FieldName = 'refprov_elr'
      Origin = 'BDPROYECTO.edi_lincre.refprov_elr'
      FixedChar = True
      Size = 35
    end
    object QDetallerefcli_elr: TStringField
      FieldName = 'refcli_elr'
      Origin = 'BDPROYECTO.edi_lincre.refcli_elr'
      FixedChar = True
      Size = 35
    end
    object QDetallecantace_elr: TFloatField
      FieldName = 'cantace_elr'
      Origin = 'BDPROYECTO.edi_lincre.cantace_elr'
    end
    object QDetallecantue_elr: TFloatField
      FieldName = 'cantue_elr'
      Origin = 'BDPROYECTO.edi_lincre.cantue_elr'
    end
    object QDetalleunidad_fac: TStringField
      FieldKind = fkCalculated
      FieldName = 'unidad_fac'
      Size = 1
      Calculated = True
    end
    object QDetalleenvase: TStringField
      FieldKind = fkCalculated
      FieldName = 'envase'
      Size = 30
      Calculated = True
    end
  end
  object QCantidades: TQuery
    OnCalcFields = QCantidadesCalcFields
    DatabaseName = 'BDProyecto'
    DataSource = DSDetalle
    SQL.Strings = (
      'select calif_enr, cantidad_enr, discrep_enr, razon_enr '
      'from edi_cantcre')
    Left = 326
    Top = 88
    object QCantidadescalif_enr: TStringField
      FieldName = 'calif_enr'
      Origin = 'BDPROYECTO.edi_cantcre.calif_enr'
      FixedChar = True
      Size = 3
    end
    object QCantidadescantidad_enr: TFloatField
      FieldName = 'cantidad_enr'
      Origin = 'BDPROYECTO.edi_cantcre.cantidad_enr'
    end
    object QCantidadesdiscrep_enr: TStringField
      FieldName = 'discrep_enr'
      Origin = 'BDPROYECTO.edi_cantcre.discrep_enr'
      FixedChar = True
      Size = 3
    end
    object QCantidadesrazon_enr: TStringField
      FieldName = 'razon_enr'
      Origin = 'BDPROYECTO.edi_cantcre.razon_enr'
      FixedChar = True
      Size = 3
    end
    object QCantidadescalificador: TStringField
      FieldKind = fkCalculated
      FieldName = 'calificador'
      Size = 30
      Calculated = True
    end
    object QCantidadesdiscrepancia: TStringField
      FieldKind = fkCalculated
      FieldName = 'discrepancia'
      Size = 30
      Calculated = True
    end
    object QCantidadesrazon: TStringField
      FieldKind = fkCalculated
      FieldName = 'razon'
      Size = 30
      Calculated = True
    end
  end
  object QObservaciones: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      
        'select idobs_eor, texto1_eor, texto2_eor, texto3_eor, texto4_eor' +
        ', texto5_eor '
      'from edi_obscabre')
    Left = 186
    Top = 32
    object QObservacionesidobs_eor: TStringField
      FieldName = 'idobs_eor'
      Origin = 'BDPROYECTO.edi_obscabre.idobs_eor'
      FixedChar = True
      Size = 10
    end
    object QObservacionestexto1_eor: TStringField
      FieldName = 'texto1_eor'
      Origin = 'BDPROYECTO.edi_obscabre.texto1_eor'
      FixedChar = True
      Size = 70
    end
    object QObservacionestexto2_eor: TStringField
      FieldName = 'texto2_eor'
      Origin = 'BDPROYECTO.edi_obscabre.texto2_eor'
      FixedChar = True
      Size = 70
    end
    object QObservacionestexto3_eor: TStringField
      FieldName = 'texto3_eor'
      Origin = 'BDPROYECTO.edi_obscabre.texto3_eor'
      FixedChar = True
      Size = 70
    end
    object QObservacionestexto4_eor: TStringField
      FieldName = 'texto4_eor'
      Origin = 'BDPROYECTO.edi_obscabre.texto4_eor'
      FixedChar = True
      Size = 70
    end
    object QObservacionestexto5_eor: TStringField
      FieldName = 'texto5_eor'
      Origin = 'BDPROYECTO.edi_obscabre.texto5_eor'
      FixedChar = True
      Size = 70
    end
  end
  object DSDetalle: TDataSource
    DataSet = QDetalle
    Left = 254
    Top = 88
  end
  object QOrigen: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select * '
      'from frf_formato_palets_c, frf_formato_palets_d'
      'where codigo_fpc = codigo_fpd')
    Left = 112
    Top = 295
  end
  object QFacturarA: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select * '
      'from frf_formato_palets_c, frf_formato_palets_d'
      'where codigo_fpc = codigo_fpd')
    Left = 40
    Top = 295
  end
  object QProveedor: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select * '
      'from frf_formato_palets_c, frf_formato_palets_d'
      'where codigo_fpc = codigo_fpd')
    Left = 184
    Top = 295
  end
  object QEnvase: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select max(descripcion_ce) descripcion, '
      '       max(unidad_fac_ce) unidad_fac, '
      '       count(distinct unidad_fac_ce) unidades_fac'
      'from frf_clientes_env, frf_envases'
      'where '#39'03828'#39' = SubStr(Trim(descripcion_ce),1,5) '
      'and empresa_ce = empresa_e'
      'and producto_base_ce = producto_base_e'
      'and envase_ce = envase_e'
      'and fecha_baja_e is null')
    Left = 256
    Top = 295
    object QEnvasedescripcion: TStringField
      FieldName = 'descripcion'
      Size = 30
    end
    object QEnvaseunidad_fac: TStringField
      FieldName = 'unidad_fac'
      FixedChar = True
      Size = 1
    end
    object QEnvaseunidades_fac: TFloatField
      FieldName = 'unidades_fac'
    end
  end
  object QAlbaranDet: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    Left = 192
    Top = 152
  end
end
