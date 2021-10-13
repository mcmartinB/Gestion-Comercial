object FDInfTransitosSelect: TFDInfTransitosSelect
  Left = 714
  Top = 229
  Caption = '   '#191'DESEA IMPRIMIR EL ...?'
  ClientHeight = 108
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
    TabOrder = 5
    OnClick = btnNoClick
  end
  object rbAlbaran: TRadioButton
    Left = 32
    Top = 21
    Width = 113
    Height = 17
    Caption = 'Albar'#225'n de tr'#225'nsito'
    Checked = True
    TabOrder = 1
    TabStop = True
  end
  object rbCMR: TRadioButton
    Left = 32
    Top = 59
    Width = 57
    Height = 17
    Caption = 'CMR'
    TabOrder = 3
    TabStop = True
  end
  object rbCartaPorte: TRadioButton
    Left = 32
    Top = 40
    Width = 135
    Height = 17
    Caption = 'Carta de porte'
    TabOrder = 2
    TabStop = True
  end
  object rbFacturaTrans: TRadioButton
    Left = 32
    Top = 75
    Width = 113
    Height = 17
    Caption = 'Factura de Tr'#225'nsito'
    TabOrder = 4
    TabStop = True
  end
end
