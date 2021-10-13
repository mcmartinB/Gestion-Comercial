object DMRecepcionEntregasForm: TDMRecepcionEntregasForm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 401
  Top = 207
  Height = 423
  Width = 589
  object QEntregasCab: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSEntregas
    RequestLive = True
    SQL.Strings = (
      'select * '
      'from frf_entregas_c '
      'where codigo_ec = :codigo_ec')
    Left = 328
    Top = 72
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'codigo_ec'
        ParamType = ptUnknown
        Size = 13
      end>
  end
  object QEntregasCabRemoto: TQuery
    DatabaseName = 'BDCentral'
    RequestLive = True
    SQL.Strings = (
      'select * '
      'from frf_entregas_c')
    Left = 184
    Top = 24
  end
  object QEntregasLin: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'select * '
      'from frf_entregas_l')
    Left = 424
    Top = 72
  end
  object QEntregasLinRemota: TQuery
    DatabaseName = 'BDCentral'
    DataSource = DSEntregas
    SQL.Strings = (
      'select * '
      'from frf_entregas_l '
      'where codigo_el = :codigo_ec')
    UniDirectional = True
    Left = 328
    Top = 24
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'codigo_ec'
        ParamType = ptUnknown
        Size = 13
      end>
  end
  object DSEntregas: TDataSource
    DataSet = QEntregasCabRemoto
    Left = 256
    Top = 48
  end
  object QEntregasPendientes: TQuery
    DatabaseName = 'BDCentral'
    Left = 56
    Top = 24
  end
  object DSEntregasPendientes: TDataSource
    DataSet = QEntregasPendientes
    Left = 56
    Top = 72
  end
end
