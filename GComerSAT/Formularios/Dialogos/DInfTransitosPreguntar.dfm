object FDInfTransitosPreguntar: TFDInfTransitosPreguntar
  Left = 432
  Top = 291
  Width = 402
  Height = 119
  Caption = '   IMPRIMIR'
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
  object lblMsg: TLabel
    Left = 32
    Top = 20
    Width = 226
    Height = 13
    Caption = #191'DESEA IMPRIMIR EL CMR DEL TR'#193'NSITO?'
  end
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
end
