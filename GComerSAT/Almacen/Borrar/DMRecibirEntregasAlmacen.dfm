object FDMRecibirEntregasAlmacen: TFDMRecibirEntregasAlmacen
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 544
  Top = 227
  Height = 366
  Width = 589
  object QEntregaCab: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSEntregas
    RequestLive = True
    Left = 256
    Top = 152
  end
  object QEntregaCabRemoto: TQuery
    DatabaseName = 'BDCentral'
    RequestLive = True
    Left = 56
    Top = 88
  end
  object QEntregaLin: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSEntregas
    RequestLive = True
    Left = 336
    Top = 152
  end
  object QEntregaLinRemota: TQuery
    DatabaseName = 'BDCentral'
    DataSource = DSEntregas
    Left = 256
    Top = 88
  end
  object DSEntregas: TDataSource
    DataSet = QEntregaCabRemoto
    Left = 168
    Top = 88
  end
  object QEntregasPendientes: TQuery
    DatabaseName = 'BDCentral'
    Left = 56
    Top = 24
  end
  object QBorrarCabRemoto: TQuery
    DatabaseName = 'BDCentral'
    Left = 56
    Top = 232
  end
  object QBorrarLinRemoto: TQuery
    DatabaseName = 'BDCentral'
    Left = 160
    Top = 232
  end
  object QEntregaEntRemota: TQuery
    DatabaseName = 'BDCentral'
    DataSource = DSEntregas
    Left = 368
    Top = 88
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'codigo_ec'
        ParamType = ptUnknown
        Size = 13
      end>
  end
  object QEntregaEnt: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSEntregas
    RequestLive = True
    Left = 408
    Top = 152
  end
  object QEntregaPalRemota: TQuery
    DatabaseName = 'BDCentral'
    DataSource = DSEntregas
    Left = 480
    Top = 88
  end
  object QEntregaPal: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSEntregas
    RequestLive = True
    Left = 480
    Top = 152
  end
  object QBorrarEntRemoto: TQuery
    DatabaseName = 'BDCentral'
    Left = 256
    Top = 232
  end
  object QBorrarPalRemoto: TQuery
    DatabaseName = 'BDCentral'
    Left = 352
    Top = 232
  end
end
