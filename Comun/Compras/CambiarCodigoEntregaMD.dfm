object DMCambiarCodigoEntrega: TDMCambiarCodigoEntrega
  OldCreateOrder = False
  Left = 888
  Top = 249
  Height = 476
  Width = 392
  object qryDestino: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 121
    Top = 115
  end
  object qryOrigen: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 45
    Top = 117
  end
  object qryAux: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 45
    Top = 53
  end
end
