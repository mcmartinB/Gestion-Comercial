object FDInfSalidasSelectSimple: TFDInfSalidasSelectSimple
  Left = 488
  Top = 230
  Width = 408
  Height = 128
  Caption = '   '#191'DESEA IMPRIMIR EL ...?'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object btnSi: TButton
    Left = 288
    Top = 14
    Width = 75
    Height = 25
    Caption = 'Si  (F1)'
    TabOrder = 0
    OnClick = btnSiClick
  end
  object btnNo: TButton
    Left = 288
    Top = 41
    Width = 75
    Height = 25
    Caption = 'No (Esc)'
    TabOrder = 1
    OnClick = btnNoClick
  end
  object cbxAlbaran: TCheckBox
    Left = 24
    Top = 18
    Width = 185
    Height = 17
    Caption = 'El albar'#225'n de salida'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object cbxCarta: TCheckBox
    Left = 24
    Top = 36
    Width = 177
    Height = 17
    Caption = 'La carta de porte'
    TabOrder = 3
  end
end
