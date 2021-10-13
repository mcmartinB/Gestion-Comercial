object DLControlAduanas: TDLControlAduanas
  OldCreateOrder = False
  Left = 584
  Top = 221
  Height = 150
  Width = 215
  object QTransitos: TQuery
    DatabaseName = 'BDProyecto'
    OnFilterRecord = QTransitosFilterRecord
    Left = 32
    Top = 32
  end
end
