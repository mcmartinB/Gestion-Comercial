object DLAbonoDetalles: TDLAbonoDetalles
  OldCreateOrder = False
  Left = 602
  Top = 458
  Height = 233
  Width = 438
  object QListadoAbonoDetalles: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'select envase_pl envase, orden_occ orden, fecha_occ fecha, ean12' +
        '8_pl sscc, '
      '       n_albaran_occ albaran, cliente_sal_occ cliente, '
      '       sum(cajas_pl) Cajas, '
      '       sum( case when nvl(peso_pl,0) <> 0 then nvl(peso_pl,0) '
      
        '                 else cajas_pl * ( select peso_neto_e from frf_e' +
        'nvases where empresa_e = '#39'078'#39' and producto_base_e = producto_ba' +
        'se_pl and envase_e = envase_pl ) end ) kilos, '
      '       transporte_occ transportista '
      'from frf_orden_carga_c, frf_packing_list '
      ''
      'where empresa_occ = '#39'078'#39
      '  and fecha_occ between '#39'1/1/2001'#39' and '#39'1/1/2001'#39
      '  and orden_pl = orden_occ '
      
        'group by envase_pl, orden_occ, fecha_occ, ean128_pl, n_albaran_o' +
        'cc, cliente_sal_occ, transporte_occ '
      'order by envase_pl, orden_occ, fecha_occ, ean128_pl')
    Left = 88
    Top = 48
  end
end
