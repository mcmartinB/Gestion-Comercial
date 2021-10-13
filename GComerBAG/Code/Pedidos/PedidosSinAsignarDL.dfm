object DLPedidosSinAsignar: TDLPedidosSinAsignar
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 725
  Top = 223
  Height = 186
  Width = 226
  object QPedidosSinAsignar: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select max(nvl(pedido_pdc,0)) '
      'from frf_pedido_cab'
      'where empresa_pdc = :empresa'
      'and centro_pdc = :centro')
    Left = 48
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'centro'
        ParamType = ptUnknown
      end>
  end
end
