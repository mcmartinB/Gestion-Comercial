object DLRiesgoCliente: TDLRiesgoCliente
  OldCreateOrder = False
  Height = 150
  Width = 215
  object QRiesgoCliente: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select cliente_fac_f, '
      
        '       (select max_riesgo_c from frf_clientes where empresa_c = ' +
        #39'050'#39' and cliente_c = cliente_fac_f) riesgo, '
      '       sum( importe_euros_f ) importe'
      'from frf_facturas'
      'where empresa_f = '#39'050'#39
      'and nvl(importe_cobrado_f,0) = 0'
      'group by 1,2'
      'order by cliente_fac_f')
    Left = 48
    Top = 24
  end
end
