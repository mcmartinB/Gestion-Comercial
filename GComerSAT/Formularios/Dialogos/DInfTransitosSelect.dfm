object FDInfTransitosSelect: TFDInfTransitosSelect
  Left = 1036
  Top = 302
  Caption = '   '#191'DESEA IMPRIMIR EL ...?'
  ClientHeight = 151
  ClientWidth = 392
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
  object rbAlbaran: TRadioButton
    Left = 32
    Top = 21
    Width = 113
    Height = 17
    Caption = 'Albar'#225'n de Tr'#225'nsito'
    Checked = True
    TabOrder = 2
    TabStop = True
  end
  object rbCMR: TRadioButton
    Left = 32
    Top = 42
    Width = 57
    Height = 17
    Caption = 'CMR'
    TabOrder = 3
  end
  object rbFactura: TRadioButton
    Left = 32
    Top = 66
    Width = 113
    Height = 17
    Caption = 'Factura de Tr'#225'nsito'
    TabOrder = 4
  end
  object rbLame: TRadioButton
    Left = 32
    Top = 90
    Width = 113
    Height = 17
    Caption = 'Certificado LAME'
    TabOrder = 5
  end
end
