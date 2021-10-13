object DMMaster: TDMMaster
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 283
  Width = 416
  object qryDescripciones: TQuery
    DatabaseName = 'dbMaster'
    SQL.Strings = (
      'SELECT * FROM frf_forma_pago'
      'ORDER BY  codigo_fp')
    Left = 40
    Top = 24
  end
  object qryDespegables: TQuery
    DatabaseName = 'dbMaster'
    SQL.Strings = (
      'SELECT * FROM frf_forma_pago'
      'ORDER BY  codigo_fp')
    Left = 40
    Top = 96
  end
  object dsDespegables: TDataSource
    DataSet = qryDespegables
    Left = 104
    Top = 110
  end
  object qryAux: TQuery
    DatabaseName = 'dbMaster'
    SQL.Strings = (
      'SELECT * FROM frf_forma_pago'
      'ORDER BY  codigo_fp')
    Left = 128
    Top = 24
  end
  object qryImporteLineas: TQuery
    DatabaseName = 'dbMaster'
    SQL.Strings = (
      'SELECT * FROM frf_forma_pago'
      'ORDER BY  codigo_fp')
    Left = 248
    Top = 24
  end
  object qryImportesGastos: TQuery
    DatabaseName = 'dbMaster'
    SQL.Strings = (
      'SELECT * FROM frf_forma_pago'
      'ORDER BY  codigo_fp')
    Left = 248
    Top = 88
  end
end
