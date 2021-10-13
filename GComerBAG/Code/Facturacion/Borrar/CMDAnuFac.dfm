object DMDAnuFac: TDMDAnuFac
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 767
  Top = 239
  Height = 560
  Width = 330
  object QFactura: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 32
  end
  object QFacturaAbono: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 80
  end
  object QContAbonos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 144
    Top = 32
  end
  object QTipoIva: TQuery
    DatabaseName = 'BDProyecto'
    Left = 248
    Top = 32
  end
  object QInsertAbono: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 128
  end
  object QInsertAbonoTexto: TQuery
    DatabaseName = 'BDProyecto'
    Left = 144
    Top = 128
  end
  object QInsertFacturaAbono: TQuery
    DatabaseName = 'BDProyecto'
    Left = 144
    Top = 80
  end
  object QSalidasFactura: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 184
  end
  object QInsertSalidasFactura: TQuery
    DatabaseName = 'BDProyecto'
    Left = 144
    Top = 184
  end
  object QCabeceraEDI: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 289
  end
  object QInsertCabeceraEDI: TQuery
    DatabaseName = 'BDProyecto'
    Left = 144
    Top = 289
  end
  object QLineaEDI: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 336
  end
  object QInsertLineaEDI: TQuery
    DatabaseName = 'BDProyecto'
    Left = 144
    Top = 336
  end
  object QCabIvaEDI: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 384
  end
  object QInsertCabIvaEDI: TQuery
    DatabaseName = 'BDProyecto'
    Left = 144
    Top = 384
  end
  object QClienteEDI: TQuery
    DatabaseName = 'BDProyecto'
    Left = 144
    Top = 240
  end
  object QLinIvaEDI: TQuery
    DatabaseName = 'BDProyecto'
    Left = 40
    Top = 432
  end
  object QInsertLinIvaEDI: TQuery
    DatabaseName = 'BDProyecto'
    Left = 144
    Top = 432
  end
  object qryUpdateContador: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 251
    Top = 89
  end
end
