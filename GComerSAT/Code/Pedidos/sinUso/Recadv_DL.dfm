object DLRecadv_: TDLRecadv_
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 638
  Top = 216
  Height = 270
  Width = 474
  object QCabecera: TQuery
    AfterOpen = QCabeceraAfterOpen
    BeforeClose = QCabeceraBeforeClose
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select empresa_ecr, idcab_ecr, numcon_ecr, tipo_ecr, '
      
        '       funcion_ecr, fecdoc_ecr, fecrec_ecr, numalb_ecr, numped_e' +
        'cr, '
      
        '       origen_ecr, matric_ecr, destino_ecr, proveedor_ecr, fcarg' +
        'a_ecr ,'
      '       aqsfac_ecr '
      'From edi_cabcre')
    Left = 40
    Top = 32
    object QCabeceraempresa_ecr: TStringField
      FieldName = 'empresa_ecr'
      Origin = 'BDPROYECTO.edi_cabcre.empresa_ecr'
      FixedChar = True
      Size = 3
    end
    object QCabeceraidcab_ecr: TStringField
      FieldName = 'idcab_ecr'
      Origin = 'BDPROYECTO.edi_cabcre.idcab_ecr'
      FixedChar = True
      Size = 10
    end
    object QCabeceranumcon_ecr: TStringField
      FieldName = 'numcon_ecr'
      Origin = 'BDPROYECTO.edi_cabcre.numcon_ecr'
      FixedChar = True
      Size = 35
    end
    object QCabeceratipo_ecr: TStringField
      FieldName = 'tipo_ecr'
      Origin = 'BDPROYECTO.edi_cabcre.tipo_ecr'
      FixedChar = True
      Size = 3
    end
    object QCabecerafuncion_ecr: TStringField
      FieldName = 'funcion_ecr'
      Origin = 'BDPROYECTO.edi_cabcre.funcion_ecr'
      FixedChar = True
      Size = 3
    end
    object QCabecerafecdoc_ecr: TDateField
      FieldName = 'fecdoc_ecr'
      Origin = 'BDPROYECTO.edi_cabcre.fecdoc_ecr'
    end
    object QCabecerafecrec_ecr: TDateField
      FieldName = 'fecrec_ecr'
      Origin = 'BDPROYECTO.edi_cabcre.fecrec_ecr'
    end
    object QCabeceranumalb_ecr: TStringField
      FieldName = 'numalb_ecr'
      Origin = 'BDPROYECTO.edi_cabcre.numalb_ecr'
      FixedChar = True
      Size = 35
    end
    object QCabeceranumped_ecr: TStringField
      FieldName = 'numped_ecr'
      Origin = 'BDPROYECTO.edi_cabcre.numped_ecr'
      FixedChar = True
      Size = 35
    end
    object QCabeceraorigen_ecr: TStringField
      FieldName = 'origen_ecr'
      Origin = 'BDPROYECTO.edi_cabcre.origen_ecr'
      FixedChar = True
      Size = 17
    end
    object QCabeceramatric_ecr: TStringField
      FieldName = 'matric_ecr'
      Origin = 'BDPROYECTO.edi_cabcre.matric_ecr'
      FixedChar = True
      Size = 35
    end
    object QCabeceradestino_ecr: TStringField
      FieldName = 'destino_ecr'
      Origin = 'BDPROYECTO.edi_cabcre.destino_ecr'
      FixedChar = True
      Size = 17
    end
    object QCabeceraproveedor_ecr: TStringField
      FieldName = 'proveedor_ecr'
      Origin = 'BDPROYECTO.edi_cabcre.proveedor_ecr'
      FixedChar = True
      Size = 17
    end
    object QCabecerafcarga_ecr: TDateField
      FieldName = 'fcarga_ecr'
      Origin = 'BDPROYECTO.edi_cabcre.fcarga_ecr'
    end
    object QCabeceraaqsfac_ecr: TStringField
      FieldName = 'aqsfac_ecr'
      Origin = 'BDPROYECTO.edi_cabcre.aqsfac_ecr'
      FixedChar = True
      Size = 17
    end
  end
  object DSMaestro: TDataSource
    DataSet = QCabecera
    Left = 112
    Top = 32
  end
  object QDetalle: TQuery
    OnCalcFields = QDetalleCalcFields
    DatabaseName = 'BDProyecto'
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
end
