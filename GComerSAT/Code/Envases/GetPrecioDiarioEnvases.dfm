object FDGetPrecioDiarioEnvases: TFDGetPrecioDiarioEnvases
  Left = 660
  Top = 259
  Width = 463
  Height = 150
  ActiveControl = ePrecio
  Caption = '   PRECIO DIARIO POR ENVASES'
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
    Width = 137
    Height = 13
    Caption = 'DESCRIPCION DE ENVASE'
  end
  object lblUnidad: TLabel
    Left = 156
    Top = 44
    Width = 93
    Height = 13
    Caption = 'Unidad Facturacion'
  end
  object lblPrecio: TLabel
    Left = 32
    Top = 44
    Width = 33
    Height = 13
    Caption = ' Precio'
  end
  object lblPvp: TLabel
    Left = 32
    Top = 68
    Width = 24
    Height = 13
    Caption = ' PVP'
  end
  object btnSi: TButton
    Left = 289
    Top = 84
    Width = 75
    Height = 25
    Caption = 'Si  (F1)'
    TabOrder = 3
    OnClick = btnSiClick
  end
  object btnNo: TButton
    Left = 369
    Top = 84
    Width = 75
    Height = 25
    Caption = 'No (Esc)'
    TabOrder = 4
    OnClick = btnNoClick
  end
  object cbbUnidadFact: TComboBox
    Left = 252
    Top = 40
    Width = 41
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 1
    TabOrder = 1
    Text = 'K'
    Items.Strings = (
      'C'
      'K'
      'U')
  end
  object ePrecio: TnbDBNumeric
    Left = 76
    Top = 40
    Width = 73
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 0
    NumIntegers = 6
    NumDecimals = 3
  end
  object ePvp: TnbDBNumeric
    Left = 76
    Top = 64
    Width = 73
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 2
    NumIntegers = 6
    NumDecimals = 3
  end
end
