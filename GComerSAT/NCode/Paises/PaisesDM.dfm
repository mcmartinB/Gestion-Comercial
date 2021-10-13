object DMPaises: TDMPaises
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 960
  Top = 145
  Height = 148
  Width = 243
  object QMaestro: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'select * '
      'from frf_paises')
    Left = 40
    Top = 32
  end
  object QListado: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select * '
      'from frf_paises')
    Left = 120
    Top = 32
  end
end
