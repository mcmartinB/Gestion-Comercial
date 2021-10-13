object FServicioConta: TFServicioConta
  OldCreateOrder = False
  DisplayName = 'ContaFacturas'
  OnExecute = ServiceExecute
  Height = 216
  Width = 388
  object Temporizador: TTimer
    Enabled = False
    Interval = 120000
    OnTimer = TemporizadorTimer
    Left = 80
    Top = 24
  end
end
