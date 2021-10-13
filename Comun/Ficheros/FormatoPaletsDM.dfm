object DMFormatoPalets: TDMFormatoPalets
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 330
  Width = 333
  object QMaestro: TQuery
    AfterOpen = QMaestroAfterOpen
    BeforeClose = QMaestroBeforeClose
    BeforePost = QMaestroBeforePost
    AfterPost = QMaestroAfterPost
    OnPostError = QMaestroPostError
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'select * '
      'from frf_formatos')
    Left = 40
    Top = 32
  end
  object QListado: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select * '
      'from frf_formato_palets_c, frf_formato_palets_d'
      'where codigo_fpc = codigo_fpd')
    Left = 40
    Top = 168
  end
  object DSMaestro: TDataSource
    DataSet = QMaestro
    Left = 112
    Top = 32
  end
  object QDetalle: TQuery
    BeforePost = QDetalleBeforePost
    AfterPost = QDetalleAfterPost
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      'select * from frf_formatos_cli')
    Left = 176
    Top = 32
  end
  object QInsertContador: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_cost_portes')
    Left = 128
    Top = 96
  end
  object QUpdateContador: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_cost_portes')
    Left = 224
    Top = 96
  end
  object QSelectContador: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_cost_portes')
    Left = 40
    Top = 96
  end
end
