object DMCambioMoneda: TDMCambioMoneda
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 585
  Top = 212
  Height = 456
  Width = 572
  object QChangeAux_Borrar: TQuery
    Left = 392
    Top = 48
  end
  object QChange: TQuery
    Left = 48
    Top = 56
  end
  object QAlbaran: TQuery
    Left = 48
    Top = 120
  end
  object QFactura: TQuery
    Left = 128
    Top = 120
  end
  object QRemesa: TQuery
    Left = 208
    Top = 120
  end
  object QCambioFactura: TQuery
    Left = 48
    Top = 176
  end
  object qryX3Cambio: TADOQuery
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
    Left = 400
    Top = 216
  end
  object qryGrabarCambio: TQuery
    Left = 128
    Top = 192
  end
  object qryX3FacturaOrigen: TADOQuery
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
    Left = 400
    Top = 288
  end
end
