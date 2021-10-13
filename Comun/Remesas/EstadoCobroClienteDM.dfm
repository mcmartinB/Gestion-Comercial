object DMEstadoCobroCliente: TDMEstadoCobroCliente
  OldCreateOrder = False
  Height = 361
  Width = 386
  object qryFacturas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 32
  end
  object cdsFacturas: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dtstprvdrFacturas'
    Left = 192
    Top = 40
    object strngfldFacturascod_empresa_fac_fc: TStringField
      FieldName = 'cod_empresa_fac_fc'
      FixedChar = True
      Size = 3
    end
    object strngfldFacturascta_cliente_fc: TStringField
      FieldName = 'cta_cliente_fc'
      FixedChar = True
      Size = 10
    end
    object strngfldFacturascod_cliente_fc: TStringField
      FieldName = 'cod_cliente_fc'
      FixedChar = True
      Size = 3
    end
    object dtfldFacturasfecha_factura_fc: TDateField
      FieldName = 'fecha_factura_fc'
    end
    object strngfldFacturascod_factura_fc: TStringField
      FieldName = 'cod_factura_fc'
      FixedChar = True
      Size = 15
    end
    object strngfldFacturasmoneda_fc: TStringField
      FieldName = 'moneda_fc'
      FixedChar = True
      Size = 3
    end
    object fltfldFacturasimporte_neto_fc: TFloatField
      FieldName = 'importe_neto_fc'
    end
    object fltfldFacturasimporte_total_fc: TFloatField
      FieldName = 'importe_total_fc'
    end
    object fltfldFacturasimporte_neto_euros_fc: TFloatField
      FieldName = 'importe_neto_euros_fc'
    end
    object fltfldFacturasimporte_total_euros_fc: TFloatField
      FieldName = 'importe_total_euros_fc'
    end
    object dtfldFacturasfecha_fac_ini_fc: TDateField
      FieldName = 'fecha_fac_ini_fc'
    end
    object dtfldFacturasprevision_cobro_fc: TDateField
      FieldName = 'prevision_cobro_fc'
    end
    object dtfldFacturasprevision_tesoreria_fc: TDateField
      FieldName = 'prevision_tesoreria_fc'
    end
    object fltfldFacturasimporte_cobrado: TFloatField
      FieldName = 'importe_cobrado'
    end
    object dtfldFacturasfecha_vencimiento_rc: TDateField
      FieldName = 'fecha_vencimiento_rc'
    end
    object fltfldFacturaspendiente_cobro: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'pendiente_cobro'
    end
  end
  object dtstprvdrFacturas: TDataSetProvider
    DataSet = qryFacturas
    Left = 120
    Top = 64
  end
  object cdsFacturasCobro: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cod_empresa_fac_fc'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'cta_cliente_fc'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'cod_cliente_fc'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'fecha_factura_fc'
        DataType = ftDate
      end
      item
        Name = 'cod_factura_fc'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'moneda_fc'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'importe_neto_fc'
        DataType = ftFloat
      end
      item
        Name = 'importe_total_fc'
        DataType = ftFloat
      end
      item
        Name = 'importe_neto_euros_fc'
        DataType = ftFloat
      end
      item
        Name = 'importe_total_euros_fc'
        DataType = ftFloat
      end
      item
        Name = 'fecha_fac_ini_fc'
        DataType = ftDate
      end
      item
        Name = 'prevision_cobro_fc'
        DataType = ftDate
      end
      item
        Name = 'prevision_tesoreria_fc'
        DataType = ftDate
      end
      item
        Name = 'importe_cobrado'
        DataType = ftFloat
      end
      item
        Name = 'fecha_vencimiento_rc'
        DataType = ftDate
      end
      item
        Name = 'remesado'
        DataType = ftFloat
      end
      item
        Name = 'cobrado'
        DataType = ftFloat
      end
      item
        Name = 'pendiente'
        DataType = ftFloat
      end
      item
        Name = 'previsto_cobro'
        DataType = ftFloat
      end
      item
        Name = 'previsto_tesoreria'
        DataType = ftFloat
      end
      item
        Name = 'no_remesado'
        DataType = ftFloat
      end
      item
        Name = 'importe'
        DataType = ftFloat
      end>
    IndexDefs = <
      item
        Name = 'DEFAULT_ORDER'
      end
      item
        Name = 'CHANGEINDEX'
      end>
    IndexFieldNames = 'moneda_fc;cod_cliente_fc'
    Params = <>
    StoreDefs = True
    Left = 192
    Top = 112
    Data = {
      760200009619E0BD010000001800000016000000000003000000760212636F64
      5F656D70726573615F6661635F66630100490000000100055749445448020002
      0003000E6374615F636C69656E74655F66630100490000000100055749445448
      020002000A000E636F645F636C69656E74655F66630100490000000100055749
      4454480200020003001066656368615F666163747572615F6663040006000000
      00000E636F645F666163747572615F6663010049000000010005574944544802
      0002000F00096D6F6E6564615F66630100490000000100055749445448020002
      0003000F696D706F7274655F6E65746F5F6663080004000000000010696D706F
      7274655F746F74616C5F6663080004000000000015696D706F7274655F6E6574
      6F5F6575726F735F6663080004000000000016696D706F7274655F746F74616C
      5F6575726F735F666308000400000000001066656368615F6661635F696E695F
      6663040006000000000012707265766973696F6E5F636F62726F5F6663040006
      000000000016707265766973696F6E5F7465736F72657269615F666304000600
      000000000F696D706F7274655F636F627261646F080004000000000014666563
      68615F76656E63696D69656E746F5F726304000600000000000872656D657361
      646F080004000000000007636F627261646F08000400000000000970656E6469
      656E746508000400000000000E707265766973746F5F636F62726F0800040000
      00000012707265766973746F5F7465736F726572696108000400000000000B6E
      6F5F72656D657361646F080004000000000007696D706F727465080004000000
      000001000D44454641554C545F4F524445520200820000000000}
    object StringField2: TStringField
      FieldName = 'cta_cliente_fc'
      FixedChar = True
      Size = 10
    end
    object StringField1: TStringField
      FieldName = 'cod_empresa_fac_fc'
      FixedChar = True
      Size = 3
    end
    object StringField3: TStringField
      FieldName = 'cod_cliente_fc'
      FixedChar = True
      Size = 3
    end
    object DateField1: TDateField
      FieldName = 'fecha_factura_fc'
    end
    object StringField4: TStringField
      FieldName = 'cod_factura_fc'
      FixedChar = True
      Size = 15
    end
    object StringField5: TStringField
      FieldName = 'moneda_fc'
      FixedChar = True
      Size = 3
    end
    object FloatField1: TFloatField
      FieldName = 'importe_neto_fc'
    end
    object FloatField2: TFloatField
      FieldName = 'importe_total_fc'
    end
    object FloatField3: TFloatField
      FieldName = 'importe_neto_euros_fc'
    end
    object FloatField4: TFloatField
      FieldName = 'importe_total_euros_fc'
    end
    object DateField2: TDateField
      FieldName = 'fecha_fac_ini_fc'
    end
    object DateField3: TDateField
      FieldName = 'prevision_cobro_fc'
    end
    object DateField4: TDateField
      FieldName = 'prevision_tesoreria_fc'
    end
    object FloatField5: TFloatField
      FieldName = 'importe_cobrado'
    end
    object DateField5: TDateField
      FieldName = 'fecha_vencimiento_rc'
    end
    object fltfldFacturasCobroremesado: TFloatField
      FieldName = 'remesado'
    end
    object fltfldFacturasCobrono_remesado: TFloatField
      FieldName = 'no_remesado'
    end
    object fltfldFacturasCobrocobrado: TFloatField
      FieldName = 'cobrado'
    end
    object fltfldFacturasCobropendiente: TFloatField
      FieldName = 'pendiente'
    end
    object fltfldFacturasCobroprevisto_cobro: TFloatField
      FieldName = 'previsto_cobro'
    end
    object fltfldFacturasCobroprevisto_tesoreria: TFloatField
      FieldName = 'previsto_tesoreria'
    end
    object cdsFacturasCobroimporte: TFloatField
      FieldName = 'importe'
    end
  end
end
