object DPFacturarEdi: TDPFacturarEdi
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 761
  Top = 277
  Height = 250
  Width = 768
  object QCabEdi: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT *'
      'FROM frf_facturas_edi_c '
      'WHERE factura_fec  BETWEEN  :desde  AND :hasta '
      'AND fecha_factura_fec = :fecha'
      'AND vendedor_fec = :vendedor')
    Left = 54
    Top = 103
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'desde'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'hasta'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'vendedor'
        ParamType = ptUnknown
      end>
  end
  object DSCabEdi: TDataSource
    DataSet = QCabEdi
    Left = 150
    Top = 103
  end
  object QLinEdi: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCabEdi
    SQL.Strings = (
      'SELECT *'
      'FROM frf_facturas_edi_l '
      'WHERE vendedor_fel=:vendedor_fec'
      'AND factura_fel=:factura_fec'
      'AND fecha_factura_fel=:fecha_factura_fec')
    Left = 246
    Top = 103
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'vendedor_fec'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'factura_fec'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha_factura_fec'
        ParamType = ptUnknown
      end>
  end
  object QLinIva: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCabEdi
    SQL.Strings = (
      'SELECT *'
      'FROM frf_impues_edi_l Frf_impues_edi_l'
      'WHERE vendedor_iel=:vendedor_fec'
      'AND factura_iel=:factura_fec'
      'AND fecha_factura_iel=:fecha_factura_fec')
    Left = 334
    Top = 103
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'vendedor_fec'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'factura_fec'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha_factura_fec'
        ParamType = ptUnknown
      end>
  end
  object QCabIva: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSCabEdi
    SQL.Strings = (
      'SELECT *'
      'FROM frf_impues_edi_l Frf_impues_edi_l'
      'WHERE vendedor_iel=:vendedor_fec'
      'AND factura_iel=:factura_fec'
      'AND fecha_factura_iel=:fecha_factura_fec')
    Left = 422
    Top = 103
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'vendedor_fec'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'factura_fec'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha_factura_fec'
        ParamType = ptUnknown
      end>
  end
  object QClienteEDI: TQuery
    DatabaseName = 'BDProyecto'
    Left = 342
    Top = 23
  end
  object QClientesEDI: TQuery
    DatabaseName = 'BDProyecto'
    Left = 254
    Top = 23
  end
  object QImpuestoFactura: TQuery
    DatabaseName = 'BDProyecto'
    Left = 150
    Top = 23
  end
  object QueryVendedor: TQuery
    DatabaseName = 'BDProyecto'
    Left = 54
    Top = 23
  end
end
