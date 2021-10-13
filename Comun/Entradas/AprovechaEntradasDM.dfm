object DMAprovechaEntradas: TDMAprovechaEntradas
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 362
  Width = 463
  object cdsAprovechaEntradas: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'key'
        DataType = ftString
        Size = 35
      end
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
        Name = 'grupo'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'fecha'
        DataType = ftInteger
      end
      item
        Name = 'numero'
        DataType = ftInteger
      end
      item
        Name = 'producto'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'rama_suelta'
        DataType = ftInteger
      end
      item
        Name = 'cosechero'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'plantacion'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'anyo_semana'
        DataType = ftInteger
      end
      item
        Name = 'cajas'
        DataType = ftInteger
      end
      item
        Name = 'kilos'
        DataType = ftFloat
      end
      item
        Name = 'kilos_primera'
        DataType = ftFloat
      end
      item
        Name = 'kilos_segunda'
        DataType = ftFloat
      end
      item
        Name = 'kilos_tercera'
        DataType = ftFloat
      end
      item
        Name = 'kilos_destrio'
        DataType = ftFloat
      end
      item
        Name = 'aprovecha_primera'
        DataType = ftFloat
      end
      item
        Name = 'aprovecha_segunda'
        DataType = ftFloat
      end
      item
        Name = 'aprovecha_tercera'
        DataType = ftFloat
      end
      item
        Name = 'aprovecha_destrio'
        DataType = ftFloat
      end
      item
        Name = 'aprovecha_merma'
        DataType = ftFloat
      end
      item
        Name = 'tiene_escandallo'
        DataType = ftBoolean
      end
      item
        Name = 'tiene_aprovecha'
        DataType = ftBoolean
      end
      item
        Name = 'sinasignar'
        DataType = ftFloat
      end>
    IndexDefs = <
      item
        Name = 'DEFAULT_ORDER'
      end
      item
        Name = 'CHANGEINDEX'
      end>
    IndexFieldNames = 'key'
    Params = <>
    StoreDefs = True
    Left = 80
    Top = 48
    Data = {
      700200009619E0BD0100000018000000190000000000030000007002036B6579
      010049000000010005574944544802000200230007656D707265736101004900
      000001000557494454480200020003000663656E74726F010049000000010005
      574944544802000200030005677275706F010049000000010005574944544802
      00020001000566656368610400010000000000066E756D65726F040001000000
      00000870726F647563746F01004900000001000557494454480200020003000B
      72616D615F7375656C7461040001000000000009636F7365636865726F010049
      00000001000557494454480200020003000A706C616E746163696F6E01004900
      000001000557494454480200020003000B616E796F5F73656D616E6104000100
      000000000563616A61730400010000000000056B696C6F730800040000000000
      0D6B696C6F735F7072696D65726108000400000000000D6B696C6F735F736567
      756E646108000400000000000D6B696C6F735F74657263657261080004000000
      00000D6B696C6F735F6465737472696F0800040000000000116170726F766563
      68615F7072696D6572610800040000000000116170726F76656368615F736567
      756E64610800040000000000116170726F76656368615F746572636572610800
      040000000000116170726F76656368615F6465737472696F0800040000000000
      0F6170726F76656368615F6D65726D610800040000000000107469656E655F65
      7363616E64616C6C6F02000300000000000F7469656E655F6170726F76656368
      6102000300000000000A73696E617369676E6172080004000000000001000D44
      454641554C545F4F524445520200820000000000}
    object strngfldAprovechaEntradaskey: TStringField
      FieldName = 'key'
      Size = 35
    end
    object strngfldAprovechaEntradasempresa: TStringField
      FieldName = 'empresa'
      Size = 3
    end
    object strngfldAprovechaEntradascentro: TStringField
      FieldName = 'centro'
      Size = 3
    end
    object strngfldAprovechaEntradasproducto: TStringField
      FieldName = 'producto'
      Size = 3
    end
    object intgrfldAprovechaEntradasrama_suelta: TIntegerField
      FieldName = 'rama_suelta'
    end
    object strngfldAprovechaEntradasgrupo: TStringField
      FieldName = 'grupo'
      Size = 1
    end
    object strngfldAprovechaEntradascosechero: TStringField
      FieldName = 'cosechero'
      Size = 3
    end
    object strngfldAprovechaEntradasplantacion: TStringField
      FieldName = 'plantacion'
      Size = 3
    end
    object intgrfldAprovechaEntradasanyo_semana: TIntegerField
      FieldName = 'anyo_semana'
    end
    object intgrfldAprovechaEntradasfecha: TIntegerField
      FieldName = 'fecha'
    end
    object intgrfldAprovechaEntradasnumero: TIntegerField
      FieldName = 'numero'
    end
    object intgrfldAprovechaEntradascajas: TIntegerField
      FieldName = 'cajas'
    end
    object fltfldAprovechaEntradaskilos: TFloatField
      FieldName = 'kilos'
    end
    object fltfldAprovechaEntradaskilos_primera: TFloatField
      FieldName = 'kilos_primera'
    end
    object fltfldAprovechaEntradaskilos_segunda: TFloatField
      FieldName = 'kilos_segunda'
    end
    object fltfldAprovechaEntradaskilos_tercera: TFloatField
      FieldName = 'kilos_tercera'
    end
    object fltfldAprovechaEntradaskilos_destrio: TFloatField
      FieldName = 'kilos_destrio'
    end
    object fltfldAprovechaEntradasaprovecha_primera: TFloatField
      FieldName = 'aprovecha_primera'
    end
    object fltfldAprovechaEntradasaprovecha_segunda: TFloatField
      FieldName = 'aprovecha_segunda'
    end
    object fltfldAprovechaEntradasaprovecha_tercera: TFloatField
      FieldName = 'aprovecha_tercera'
    end
    object fltfldAprovechaEntradasaprovecha_destrio: TFloatField
      FieldName = 'aprovecha_destrio'
    end
    object fltfldAprovechaEntradasaprovecha_merma: TFloatField
      FieldName = 'aprovecha_merma'
    end
    object blnfldAprovechaEntradastiene_escandallo: TBooleanField
      FieldName = 'tiene_escandallo'
    end
    object blnfldAprovechaEntradastiene_aprovecha: TBooleanField
      FieldName = 'tiene_aprovecha'
    end
    object cdsAprovechaEntradassinasignar: TFloatField
      FieldName = 'sinasignar'
    end
  end
  object qryEscandallo: TQuery
    DatabaseName = 'BDProyecto'
    Left = 88
    Top = 120
  end
  object qryAprovecha: TQuery
    DatabaseName = 'BDProyecto'
    Left = 88
    Top = 176
  end
end
