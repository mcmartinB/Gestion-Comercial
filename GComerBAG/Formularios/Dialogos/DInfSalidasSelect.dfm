object FDInfSalidasSelect: TFDInfSalidasSelect
  Left = 235
  Top = 150
  Caption = '   '#191'DESEA IMPRIMIR EL ...?'
  ClientHeight = 197
  ClientWidth = 379
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
    Width = 379
    Height = 155
    Align = alClient
    TabOrder = 0
    ExplicitTop = 1
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
      Top = 57
      Width = 97
      Height = 17
      Caption = 'CMR'
      TabOrder = 6
    end
    object cbxProforma: TCheckBox
      Tag = 20
      Left = 31
      Top = 106
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
      Left = 100
      Top = 102
      Width = 85
      Height = 26
      Caption = 'Proforma'
      Checked = True
      TabOrder = 7
      TabStop = True
    end
    object rbDespacho: TRadioButton
      Left = 177
      Top = 106
      Width = 113
      Height = 17
      Caption = 'Despacho'
      TabOrder = 8
    end
    object cbxDeclaracion: TCheckBox
      Tag = 20
      Left = 31
      Top = 83
      Width = 169
      Height = 17
      Caption = 'Declaraci'#243'n Responsable'
      TabOrder = 9
    end
  end
  object PanelBotones: TPanel
    Left = 0
    Top = 155
    Width = 379
    Height = 42
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 126
    ExplicitWidth = 381
    object btnSi: TButton
      Left = 199
      Top = 6
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
