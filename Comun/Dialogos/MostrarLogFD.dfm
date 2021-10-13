object FDMostrarLog: TFDMostrarLog
  Left = 334
  Top = 201
  Width = 419
  Height = 544
  Caption = 'VER FICHERO LOG'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    411
    510)
  PixelsPerInch = 96
  TextHeight = 13
  object mmoLog: TMemo
    Left = 0
    Top = 0
    Width = 411
    Height = 467
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'RESULTADO SINCRONIZACION'
      '------------------------')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object btnExit: TButton
    Left = 9
    Top = 477
    Width = 393
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cerrar'
    TabOrder = 1
    OnClick = btnExitClick
  end
end
