object DLSalidasSuministro: TDLSalidasSuministro
  OldCreateOrder = False
  Height = 208
  Width = 649
  object QSalidasSuministro: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select '
      '       dir_sum_sc suministro,'
      '       '#39'total'#39' guia,'
      
        '       (select estomate_p from frf_productos where empresa_p = e' +
        'mpresa_sc and producto_p = producto_sl) tomate,'
      '       producto_sl producto, '
      
        '       sum(cajas_sl) cajas, sum(kilos_sl) kilos, sum(importe_net' +
        'o_sl) importe'
      'from frf_salidas_c, frf_salidas_l'
      'where empresa_sc = empresa_sl '
      'and centro_salida_sc = centro_salida_sl'
      'and n_albaran_sc = n_albaran_sc'
      'and fecha_sc = fecha_sl'
      'and cliente_sal_sc = '#39'MER'#39
      'and fecha_sc between '#39'1/6/2005'#39' and '#39'30/6/2005'#39
      'group by 1, 2, 3, 4'
      'order by 1, 2, 3 DESC, 4 ')
    Left = 64
    Top = 24
  end
  object dlgSaveFile: TSaveDialog
    DefaultExt = 'csv'
    FileName = 'InformeSalidas'
    Filter = '*.csv|*.csv'
    Left = 168
    Top = 24
  end
end
