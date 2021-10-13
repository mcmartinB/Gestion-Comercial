object DMCosteEstructural: TDMCosteEstructural
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 661
  Top = 161
  Height = 287
  Width = 519
  object qryCostes: TQuery
    DatabaseName = 'dbMaster'
    SessionName = 'Default'
    SQL.Strings = (
      
        'SELECT cliente_sl cliente, n_albaran_sc albaran, envase_sl envas' +
        'e,'
      
        '       centro_salida_sc centro, fecha_sc fecha, moneda_sc moneda' +
        ','
      '       CASE WHEN producto_sl = '#39'E'#39' THEN 1 ELSE 0 END Transito,'
      '       SUM(kilos_sl) kilos_producto,'
      '       SUM(importe_neto_sl)*(1-(NVL(comision_r,0)/100)) neto'
      ''
      
        'FROM frf_salidas_c, frf_salidas_l, frf_clientes, frf_representan' +
        'tes'
      ''
      'WHERE empresa_sc = '#39'tpm'#39
      ''
      ''
      'group by cliente_sl, n_albaran_sc, envase_sl,'
      '       centro_salida_sc, fecha_sc, moneda_sc, comision_r, 7')
    Left = 200
    Top = 32
  end
  object cdsCostesEstructurales: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'empresa'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'centro'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'comercial'
        DataType = ftFloat
      end
      item
        Name = 'produccion'
        DataType = ftFloat
      end
      item
        Name = 'administracion'
        DataType = ftFloat
      end
      item
        Name = 'estructura'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    BeforePost = cdsCostesEstructuralesBeforePost
    Left = 88
    Top = 48
    Data = {
      A00000009619E0BD010000001800000006000000000003000000A00007656D70
      7265736101004900000001000557494454480200020003000663656E74726F01
      0049000000010005574944544802000200030009636F6D65726369616C080004
      00000000000A70726F64756363696F6E08000400000000000E61646D696E6973
      74726163696F6E08000400000000000A65737472756374757261080004000000
      00000000}
    object strngfldCostesEstructuralesempresa: TStringField
      FieldName = 'empresa'
      Size = 3
    end
    object strngfldCostesEstructuralescentro: TStringField
      FieldName = 'centro'
      Size = 3
    end
    object fltfldCostesEstructuralescomercial: TFloatField
      FieldName = 'comercial'
    end
    object fltfldCostesEstructuralesproduccion: TFloatField
      FieldName = 'produccion'
    end
    object fltfldCostesEstructuralesadministracion: TFloatField
      FieldName = 'administracion'
    end
    object fltfldCostesEstructuralesestructura: TFloatField
      FieldName = 'estructura'
    end
  end
end
