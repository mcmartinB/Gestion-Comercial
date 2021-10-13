object FDInfSalidasSelect: TFDInfSalidasSelect
  Left = 235
  Top = 150
  Caption = '   '#191'DESEA IMPRIMIR EL ...?'
  ClientHeight = 162
  ClientWidth = 381
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
  object PanelCompleto: TPanel
    Left = 0
    Top = 0
    Width = 381
    Height = 120
    Align = alClient
    TabOrder = 0
    object cbxFirma: TCheckBox
      Tag = 10
      Left = 216
      Top = 14
      Width = 97
      Height = 17
      Caption = 'Capturar Firma'
      TabOrder = 2
    end
    object cbxAlbaran: TCheckBox
      Tag = 10
      Left = 32
      Top = 14
      Width = 97
      Height = 17
      TabOrder = 1
    end
    object cbxCartaPorte: TCheckBox
      Tag = 20
      Left = 32
      Top = 34
      Width = 169
      Height = 17
      Caption = 'Imprimir Carta Porte'
      TabOrder = 3
    end
    object cbxCMR: TCheckBox
      Tag = 10
      Left = 32
      Top = 55
      Width = 97
      Height = 17
      Caption = 'CMR'
      TabOrder = 6
    end
    object cbxProforma: TCheckBox
      Tag = 20
      Left = 32
      Top = 74
      Width = 62
      Height = 17
      Caption = 'Factura'
      TabOrder = 5
    end
    object cbxOriginalEmpresa: TCheckBox
      Left = 216
      Top = 34
      Width = 161
      Height = 17
      Caption = 'Imprimir Original Empresa'
      TabOrder = 4
    end
    object cbbIdiomaAlbaran: TComboBox
      Left = 48
      Top = 12
      Width = 145
      Height = 21
      Style = csDropDownList
      Color = clBtnFace
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'Imprimir Albar'#225'n Espa'#241'ol'
      Items.Strings = (
        'Imprimir Albar'#225'n Espa'#241'ol'
        'Imprimir Albar'#225'n Alem'#225'n'
        'Imprimir Albar'#225'n Ingl'#233's')
    end
    object rbProforma: TRadioButton
      Left = 92
      Top = 74
      Width = 80
      Height = 17
      Caption = 'Proforma'
      Checked = True
      TabOrder = 7
      TabStop = True
    end
    object rbDespacho: TRadioButton
      Left = 156
      Top = 74
      Width = 113
      Height = 17
      Caption = 'Despacho'
      TabOrder = 8
    end
  end
  object PanelBotones: TPanel
    Left = 0
    Top = 120
    Width = 381
    Height = 42
    Align = alBottom
    TabOrder = 1
    object btnSi: TButton
      Left = 199
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Si  (F1)'
      TabOrder = 0
      OnClick = btnSiClick
    end
    object btnNo: TButton
      Left = 280
      Top = 7
      Width = 75
      Height = 25
      Caption = 'No (Esc)'
      TabOrder = 1
      OnClick = btnNoClick
    end
  end
end
