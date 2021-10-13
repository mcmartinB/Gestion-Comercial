object FDInfSalidasPreguntar: TFDInfSalidasPreguntar
  Left = 617
  Top = 304
  Width = 402
  Height = 192
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
    Width = 229
    Height = 13
    Caption = #191'DESEA IMPRIMIR EL ALBAR'#193'N DE SALIDA?'
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
    TabOrder = 2
    OnClick = btnNoClick
  end
  object cbxFirma: TCheckBox
    Left = 32
    Top = 38
    Width = 97
    Height = 17
    Caption = 'Capturar Firma'
    TabOrder = 1
  end
  object cbxOriginalEmpresa: TCheckBox
    Left = 32
    Top = 52
    Width = 161
    Height = 17
    Caption = 'Imprimir Original Empresa'
    TabOrder = 3
  end
end
