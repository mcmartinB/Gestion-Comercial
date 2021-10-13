object DMImportarClientes: TDMImportarClientes
  OldCreateOrder = False
  Height = 476
  Width = 392
  object qryCabRemoto: TQuery
    DatabaseName = 'BDCentral'
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 169
    Top = 43
  end
  object qryCabLocal: TQuery
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
    Left = 59
    Top = 171
  end
  object qryDetRemoto: TQuery
    DatabaseName = 'BDCentral'
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 175
    Top = 107
  end
  object qryDetLocal: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 58
    Top = 107
  end
end
