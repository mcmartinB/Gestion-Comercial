object DMAlbaranesAsociadosFac: TDMAlbaranesAsociadosFac
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 372
  Width = 407
  object qryAlbaranes: TQuery
    DatabaseName = 'dbMaster'
    SQL.Strings = (
      'SELECT * FROM frf_forma_pago'
      'ORDER BY  codigo_fp')
    Left = 72
    Top = 120
  end
end
