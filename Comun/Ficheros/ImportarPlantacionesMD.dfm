object DMImportarPlantaciones: TDMImportarPlantaciones
  OldCreateOrder = False
  Left = 810
  Top = 247
  Height = 476
  Width = 392
  object qryRemoto: TQuery
    DatabaseName = 'BDCentral'
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 153
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
end
