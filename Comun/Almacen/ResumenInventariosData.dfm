object DMResumenInventarios: TDMResumenInventarios
  OldCreateOrder = False
  Height = 498
  Width = 425
  object QInventarios: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 24
  end
  object cdsResumen2: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'empresa'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'centro'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'producto'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'fecha'
        DataType = ftDate
      end
      item
        Name = 'campo'
        DataType = ftFloat
      end
      item
        Name = 'intermedia1'
        DataType = ftFloat
      end
      item
        Name = 'intermedia2'
        DataType = ftFloat
      end
      item
        Name = 'tercera'
        DataType = ftFloat
      end
      item
        Name = 'destrio'
        DataType = ftFloat
      end
      item
        Name = 'envase'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'des_envase'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'expedicion_c1'
        DataType = ftFloat
      end
      item
        Name = 'expedicion_c2'
        DataType = ftFloat
      end
      item
        Name = 'primera'
        DataType = ftFloat
      end
      item
        Name = 'segunda'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 88
    Top = 80
    object strngfldResumenempresa: TStringField
      FieldName = 'empresa'
      Size = 3
    end
    object strngfldResumencentro: TStringField
      FieldName = 'centro'
      Size = 3
    end
    object strngfldResumenproducto: TStringField
      FieldName = 'producto'
      Size = 3
    end
    object dtfldResumenfecha: TDateField
      FieldName = 'fecha'
    end
    object fltfldResumencampo: TFloatField
      FieldName = 'campo'
    end
    object fltfldResumenintermedia1: TFloatField
      FieldName = 'intermedia1'
    end
    object fltfldResumenintermedia2: TFloatField
      FieldName = 'intermedia2'
    end
    object fltfldResumentercera: TFloatField
      FieldName = 'tercera'
    end
    object fltfldResumendestrio: TFloatField
      FieldName = 'destrio'
    end
    object strngfldResumendes_envase: TStringField
      FieldName = 'des_envase'
    end
    object fltfldResumenexpedicion_c1: TFloatField
      FieldName = 'expedicion_c1'
    end
    object fltfldResumenexpedicion_c2: TFloatField
      FieldName = 'expedicion_c2'
    end
    object fltfldResumenprimera: TFloatField
      FieldName = 'primera'
    end
    object fltfldResumensegunda: TFloatField
      FieldName = 'segunda'
    end
    object cdsResumen2envase: TStringField
      FieldName = 'envase'
      Size = 3
    end
  end
  object cdsResumen: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'empresa'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'centro'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'producto'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'fecha'
        DataType = ftDate
      end
      item
        Name = 'campo'
        DataType = ftFloat
      end
      item
        Name = 'intermedia1'
        DataType = ftFloat
      end
      item
        Name = 'intermedia2'
        DataType = ftFloat
      end
      item
        Name = 'tercera'
        DataType = ftFloat
      end
      item
        Name = 'destrio'
        DataType = ftFloat
      end
      item
        Name = 'envase'
        DataType = ftString
        Size = 9
      end
      item
        Name = 'des_envase'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'expedicion_c1'
        DataType = ftFloat
      end
      item
        Name = 'expedicion_c2'
        DataType = ftFloat
      end
      item
        Name = 'primera'
        DataType = ftFloat
      end
      item
        Name = 'segunda'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 312
    Top = 160
    Data = {
      580100009619E0BD01000000180000000F000000000003000000580107656D70
      7265736101004900000001000557494454480200020003000663656E74726F01
      004900000001000557494454480200020003000870726F647563746F01004900
      0000010005574944544802000200030005666563686104000600000000000563
      616D706F08000400000000000B696E7465726D65646961310800040000000000
      0B696E7465726D65646961320800040000000000077465726365726108000400
      00000000076465737472696F080004000000000006656E766173650100490000
      0001000557494454480200020009000A6465735F656E76617365010049000000
      01000557494454480200020014000D65787065646963696F6E5F633108000400
      000000000D65787065646963696F6E5F63320800040000000000077072696D65
      7261080004000000000007736567756E646108000400000000000000}
    object cdsResumenempresa: TStringField
      FieldName = 'empresa'
      Size = 3
    end
    object cdsResumencentro: TStringField
      FieldName = 'centro'
      Size = 3
    end
    object cdsResumenproducto: TStringField
      FieldName = 'producto'
      Size = 3
    end
    object cdsResumenfecha: TDateField
      FieldName = 'fecha'
    end
    object cdsResumencampo: TFloatField
      FieldName = 'campo'
    end
    object cdsResumenintermedia1: TFloatField
      FieldName = 'intermedia1'
    end
    object cdsResumenintermedia2: TFloatField
      FieldName = 'intermedia2'
    end
    object cdsResumentercera: TFloatField
      FieldName = 'tercera'
    end
    object cdsResumendestrio: TFloatField
      FieldName = 'destrio'
    end
    object cdsResumenenvase: TStringField
      FieldName = 'envase'
      Size = 9
    end
    object cdsResumendes_envase: TStringField
      FieldName = 'des_envase'
    end
    object cdsResumenexpedicion_c1: TFloatField
      FieldName = 'expedicion_c1'
    end
    object cdsResumenexpedicion_c2: TFloatField
      FieldName = 'expedicion_c2'
    end
    object cdsResumenprimera: TFloatField
      FieldName = 'primera'
    end
    object cdsResumensegunda: TFloatField
      FieldName = 'segunda'
    end
  end
end
