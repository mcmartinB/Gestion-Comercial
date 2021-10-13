object DLGenerarRemesaCobro: TDLGenerarRemesaCobro
  OldCreateOrder = False
  Left = 436
  Top = 217
  Height = 256
  Width = 369
  object qryAux: TQuery
    DatabaseName = 'BDProyecto'
    Left = 32
    Top = 24
  end
  object qryFacturas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 112
    Top = 24
  end
  object qryOrdenante: TQuery
    DatabaseName = 'BDProyecto'
    Left = 200
    Top = 24
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Ficheros de Texto | *.txt|*.txt'
    Left = 272
    Top = 24
  end
end
