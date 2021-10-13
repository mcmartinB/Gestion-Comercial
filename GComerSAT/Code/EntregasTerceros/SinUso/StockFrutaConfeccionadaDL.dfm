object DLStockFrutaConfeccionada: TDLStockFrutaConfeccionada
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Left = 534
  Top = 175
  Height = 205
  Width = 438
  object QListadoConfeccionado: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'select x1.ean13_det, x2.producto_e, x2.envase_e, x2.descripcion_' +
        'e, '
      '       count(distinct x0.ean128_cab) palets, '
      '       sum(x1.unidades_det) cajas,'
      '       sum(nvl(x1.peso_det,0)) kilos'
      'from   rf_palet_pc_cab x0, '
      '       rf_palet_pc_det x1,'
      '       frf_ean13 x2'
      'Where  x0.empresa_cab = '#39'078'#39
      '  and  x0.centro_cab = '#39'1'#39
      '  and  x0.status_cab in ('#39'S'#39','#39'P'#39')'
      '  and  x1.ean128_det = x0.ean128_cab'
      '  and  x2.empresa_e = '#39'078'#39
      '  and  x2.codigo_e = x1.ean13_det'
      '  and  x2.calibre_e = x1.calibre_det  '
      
        'group by x1.ean13_det, x2.producto_e, x2.envase_e, x2.descripcio' +
        'n_e')
    Left = 96
    Top = 48
  end
end
