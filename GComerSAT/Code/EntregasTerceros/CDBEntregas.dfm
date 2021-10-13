object DBEntregas: TDBEntregas
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 607
  Top = 147
  Height = 253
  Width = 670
  object QKeyAlbaran: TQuery
    Left = 56
    Top = 24
  end
  object QGetAlbaran: TQuery
    Left = 136
    Top = 24
  end
  object QCajasPaletsPB: TQuery
    Left = 136
    Top = 96
  end
  object QPaletsPB: TQuery
    RequestLive = True
    Left = 56
    Top = 96
  end
  object QTaraPaletaPB: TQuery
    Left = 216
    Top = 96
  end
  object QLineas: TQuery
    RequestLive = True
    Left = 56
    Top = 160
  end
  object QCajasLineas: TQuery
    Left = 136
    Top = 160
  end
  object QEntregas: TQuery
    Left = 380
    Top = 96
  end
  object QKilosLineas: TQuery
    Left = 224
    Top = 160
  end
  object QKilosVariedad: TQuery
    Left = 312
    Top = 160
  end
  object QLineasSinKilos: TQuery
    Left = 408
    Top = 160
  end
end
