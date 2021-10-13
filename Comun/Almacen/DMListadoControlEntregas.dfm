object DMListadoControlEntregasForm: TDMListadoControlEntregasForm
  OldCreateOrder = False
  Height = 423
  Width = 430
  object QListado: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select * '
      'from frf_entregas_c')
    Left = 72
    Top = 24
  end
end
