object DMFacturasSinContabilizar: TDMFacturasSinContabilizar
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 295
  Width = 548
  object qryFacturas: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'select cod_factura_fc, cod_empresa_fac_fc, n_factura_fc, fecha_f' +
        'actura_fc, '
      
        '       cod_cliente_fc, cta_cliente_fc, des_cliente_fc, moneda_fc' +
        ','
      '       importe_neto_fc, importe_neto_euros_fc, '
      '       importe_total_fc, importe_total_euros_fc'
      '       '
      'from tfacturas_cab'
      'where fecha_factura_fc between '#39'1/1/2017'#39' and '#39'31/1/2017'#39
      'and cod_empresa_fac_fc = '#39'050'#39)
    Left = 48
    Top = 48
  end
  object cdsFacturas: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspFacturas'
    Left = 192
    Top = 48
    object strngfldFacturascod_factura_fc: TStringField
      FieldName = 'cod_factura_fc'
      FixedChar = True
      Size = 15
    end
    object strngfldFacturascod_empresa_fac_fc: TStringField
      FieldName = 'cod_empresa_fac_fc'
      FixedChar = True
      Size = 3
    end
    object cdsFacturasn_factura_fc: TIntegerField
      FieldName = 'n_factura_fc'
    end
    object dtfldFacturasfecha_factura_fc: TDateField
      FieldName = 'fecha_factura_fc'
    end
    object strngfldFacturascod_cliente_fc: TStringField
      FieldName = 'cod_cliente_fc'
      FixedChar = True
      Size = 3
    end
    object strngfldFacturascta_cliente_fc: TStringField
      FieldName = 'cta_cliente_fc'
      FixedChar = True
      Size = 10
    end
    object strngfldFacturasdes_cliente_fc: TStringField
      FieldName = 'des_cliente_fc'
      FixedChar = True
      Size = 35
    end
    object strngfldFacturasmoneda_fc: TStringField
      FieldName = 'moneda_fc'
      FixedChar = True
      Size = 3
    end
    object fltfldFacturasimporte_neto_fc: TFloatField
      FieldName = 'importe_neto_fc'
    end
    object fltfldFacturasimporte_neto_euros_fc: TFloatField
      FieldName = 'importe_neto_euros_fc'
    end
    object fltfldFacturasimporte_total_fc: TFloatField
      FieldName = 'importe_total_fc'
    end
    object fltfldFacturasimporte_total_euros_fc: TFloatField
      FieldName = 'importe_total_euros_fc'
    end
    object fltfldFacturasimporte_conta_neto_fc: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'importe_conta_neto_fc'
    end
  end
  object dsFacturas: TDataSource
    DataSet = cdsFacturas
    Left = 256
    Top = 48
  end
  object dspFacturas: TDataSetProvider
    DataSet = qryFacturas
    Left = 112
    Top = 56
  end
  object aqryX3Factura: TADOQuery
    Connection = DMBaseDatos.conX3
    Parameters = <
      item
        Name = 'moneda'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'fecha'
        DataType = ftDateTime
        Value = Null
      end>
    Left = 48
    Top = 128
  end
end
