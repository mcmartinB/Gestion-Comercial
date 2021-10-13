object FDMRecibirEntregasCentral: TFDMRecibirEntregasCentral
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 458
  Top = 190
  Height = 288
  Width = 589
  object QEntregaCab: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSEntregas
    RequestLive = True
    SQL.Strings = (
      'select * '
      'from frf_entregas_c '
      'where codigo_ec = :codigo_ec')
    Left = 352
    Top = 104
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'codigo_ec'
        ParamType = ptUnknown
        Size = 13
      end>
  end
  object QEntregaCabRemoto: TQuery
    DatabaseName = 'BDCentral'
    RequestLive = True
    SQL.Strings = (
      'select * '
      'from frf_entregas_c')
    Left = 56
    Top = 104
  end
  object QEntregaLin: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSEntregas
    RequestLive = True
    SQL.Strings = (
      'select * '
      'from frf_entregas_l')
    Left = 448
    Top = 104
  end
  object QEntregaLinRemota: TQuery
    DatabaseName = 'BDCentral'
    DataSource = DSEntregas
    SQL.Strings = (
      'select * '
      'from frf_entregas_l '
      'where codigo_el = :codigo_ec')
    UniDirectional = True
    Left = 248
    Top = 104
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'codigo_ec'
        ParamType = ptUnknown
        Size = 13
      end>
  end
  object DSEntregas: TDataSource
    DataSet = QEntregaCabRemoto
    Left = 160
    Top = 104
  end
  object QEntregasPendientes: TQuery
    DatabaseName = 'BDCentral'
    Left = 56
    Top = 24
  end
end
