object DMRecepcionForm: TDMRecepcionForm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 879
  Top = 212
  Height = 703
  Width = 804
  object QTransito: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 40
    Top = 24
  end
  object QTransitoRemoto: TQuery
    DatabaseName = 'BDCentral'
    RequestLive = True
    SQL.Strings = (
      '')
    Left = 120
    Top = 24
  end
  object QLinea: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 40
    Top = 131
  end
  object QLineaRemota: TQuery
    DatabaseName = 'BDCentral'
    DataSource = DSTransitoRemoto
    SQL.Strings = (
      '')
    UniDirectional = True
    Left = 120
    Top = 131
  end
  object QPaletPbRemota: TQuery
    DatabaseName = 'BDCentral'
    DataSource = DSTransitoRemoto
    Left = 120
    Top = 204
  end
  object QBorrarPaletPb: TQuery
    DatabaseName = 'BDCentral'
    DataSource = DSTransitoRemoto
    Left = 120
    Top = 260
  end
  object DSTransitoRemoto: TDataSource
    DataSet = QTransitoRemoto
    Left = 120
    Top = 80
  end
  object QPaletPbLocal: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSTransitoRemoto
    RequestLive = True
    Left = 48
    Top = 188
  end
  object QPaletCabLocal: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 296
    Top = 41
  end
  object QPaletDetLocal: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 296
    Top = 113
  end
  object QBorrarPaletCabLocal: TQuery
    DatabaseName = 'BDProyecto'
    Left = 304
    Top = 193
  end
  object QBorrarPaletDetLocal: TQuery
    DatabaseName = 'BDProyecto'
    Left = 304
    Top = 257
  end
  object QPaletCabRemota: TQuery
    DatabaseName = 'BDCentral'
    SQL.Strings = (
      '')
    Left = 432
    Top = 41
  end
  object QPaletDetRemota: TQuery
    DatabaseName = 'BDCentral'
    Left = 432
    Top = 113
  end
end
