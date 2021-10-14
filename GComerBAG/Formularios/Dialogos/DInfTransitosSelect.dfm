object FDInfTransitosSelect: TFDInfTransitosSelect
  Left = 714
  Top = 229
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
  object cbxAlbaran: TCheckBox
    Left = 32
    Top = 18
    Width = 135
    Height = 17
    Caption = 'Albar'#225'n de tr'#225'nsito'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object cbxCartaPorte: TCheckBox
    Left = 32
    Top = 50
    Width = 135
    Height = 17
    Caption = 'Carta de porte'
    TabOrder = 3
  end
  object cbxCMR: TCheckBox
    Left = 32
    Top = 82
    Width = 97
    Height = 17
    Caption = 'CMR'
    TabOrder = 4
  end
  object cbxFacturaTransito: TCheckBox
    Left = 32
    Top = 113
    Width = 113
    Height = 17
    Caption = 'Factura de Tr'#225'nsito'
    TabOrder = 5
  end
end
