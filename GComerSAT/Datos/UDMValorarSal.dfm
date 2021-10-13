object DMValorarSal: TDMValorarSal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 392
  Width = 579
  object qrySalidasDet: TQuery
    DatabaseName = 'BDProyecto'
    Left = 122
    Top = 28
  end
  object qryCambioFactura: TQuery
    DatabaseName = 'BDProyecto'
    Left = 282
    Top = 28
  end
  object qryCambioAlbaran: TQuery
    DatabaseName = 'BDProyecto'
    Left = 381
    Top = 27
  end
  object qrySalidasCab: TQuery
    DatabaseName = 'BDProyecto'
    Left = 36
    Top = 34
  end
  object qryDescuento: TQuery
    DatabaseName = 'BDProyecto'
    Left = 41
    Top = 94
  end
  object qryComision: TQuery
    DatabaseName = 'BDProyecto'
    Left = 125
    Top = 92
  end
  object qryGastos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 195
    Top = 28
  end
  object qryProductoBase: TQuery
    DatabaseName = 'BDProyecto'
    Left = 41
    Top = 158
  end
  object qryCosteEnvasado: TQuery
    DatabaseName = 'BDProyecto'
    Left = 216
    Top = 90
  end
  object qryAbonos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 435
    Top = 83
  end
  object qryOtrosCostes: TQuery
    DatabaseName = 'BDProyecto'
    Left = 331
    Top = 91
  end
  object qrySalTransitos: TQuery
    DatabaseName = 'BDProyecto'
    Left = 44
    Top = 258
  end
end
