object DLListPackingOrden: TDLListPackingOrden
  OldCreateOrder = False
  Left = 805
  Top = 218
  Height = 233
  Width = 438
  object QListadoOrdenCarga: TQuery
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
    object QListadoOrdenCargaenvase: TStringField
      FieldName = 'envase'
      FixedChar = True
      Size = 3
    end
    object QListadoOrdenCargaorden: TIntegerField
      FieldName = 'orden'
    end
    object QListadoOrdenCargafecha: TDateField
      FieldName = 'fecha'
    end
    object QListadoOrdenCargasscc: TStringField
      FieldName = 'sscc'
      FixedChar = True
    end
    object QListadoOrdenCargaalbaran: TIntegerField
      FieldName = 'albaran'
    end
    object QListadoOrdenCargacliente: TStringField
      FieldName = 'cliente'
      FixedChar = True
      Size = 3
    end
    object QListadoOrdenCargacajas: TFloatField
      FieldName = 'cajas'
    end
    object QListadoOrdenCargakilos: TFloatField
      FieldName = 'kilos'
    end
    object QListadoOrdenCargatransportista: TSmallintField
      FieldName = 'transportista'
    end
  end
end
