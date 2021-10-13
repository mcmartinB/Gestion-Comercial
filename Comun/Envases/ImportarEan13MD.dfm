object DMImportarEan13: TDMImportarEan13
  OldCreateOrder = False
  Height = 476
  Width = 392
  object qryRemoto: TQuery
    DatabaseName = 'BDCentral'
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 169
    Top = 43
  end
  object qryLocal: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 53
    Top = 45
  end
  object qryAuxLocal: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 51
    Top = 107
  end
end
