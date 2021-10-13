object FDInfSalidasPreguntar: TFDInfSalidasPreguntar
  Left = 480
  Top = 337
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
    Width = 229
    Height = 13
    Caption = #191'DESEA IMPRIMIR EL ALBAR'#193'N DE SALIDA?'
  end
  object lblImpresora: TLabel
    Left = 32
    Top = 47
    Width = 46
    Height = 13
    Caption = 'Impresora'
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
  object cbxImpresora: TComboBox
    Left = 96
    Top = 43
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 2
    Text = 'Inyecci'#243'n'
    Items.Strings = (
      'Inyecci'#243'n'
      'Matricial')
  end
  object cbxFirma: TCheckBox
    Left = 32
    Top = 38
    Width = 97
    Height = 17
    Caption = 'Capturar Firma'
    TabOrder = 3
  end
  object cbxOriginalEmpresa: TCheckBox
    Left = 32
    Top = 55
    Width = 161
    Height = 17
    Caption = 'Imprimir Original Empresa'
    TabOrder = 4
  end
end
