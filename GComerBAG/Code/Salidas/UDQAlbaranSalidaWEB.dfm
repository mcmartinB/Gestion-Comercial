object DQAlbaranSalidaWEB: TDQAlbaranSalidaWEB
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 271
  Width = 338
  object QAlbaranC: TQuery
    DatabaseName = 'BDProyecto'
    Left = 24
    Top = 16
  end
  object QDirAlbaran: TQuery
    DatabaseName = 'BDProyecto'
    Left = 24
    Top = 80
  end
  object QTransporte: TQuery
    ObjectView = True
    DatabaseName = 'BDProyecto'
    Left = 120
    Top = 12
  end
end
