object FDInfSalidasSelect: TFDInfSalidasSelect
  Left = 700
  Top = 160
  Caption = '   '#191'DESEA IMPRIMIR EL ...?'
  ClientHeight = 242
  ClientWidth = 425
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
    Width = 425
    Height = 206
    Align = alTop
    TabOrder = 0
    ExplicitTop = -2
    object cbxFirma: TCheckBox
      Tag = 10
      Left = 216
      Top = 27
      Width = 97
      Height = 17
      Caption = 'Capturar Firma'
      TabOrder = 2
    end
    object cbxAlbaran: TCheckBox
      Tag = 10
      Left = 32
      Top = 27
      Width = 97
      Height = 17
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object cbxCartaPorte: TCheckBox
      Tag = 20
      Left = 32
      Top = 47
      Width = 169
      Height = 17
      Caption = 'Imprimir Carta Porte'
      TabOrder = 3
    end
    object cbxCMR: TCheckBox
      Tag = 10
      Left = 32
      Top = 68
      Width = 97
      Height = 17
      Caption = 'CMR'
      TabOrder = 5
    end
    object cbxProforma: TCheckBox
      Tag = 20
      Left = 32
      Top = 87
      Width = 58
      Height = 17
      Caption = 'Factura'
      TabOrder = 6
    end
    object cbxOriginalEmpresa: TCheckBox
      Left = 216
      Top = 47
      Width = 161
      Height = 17
      Caption = 'Imprimir Original Empresa'
      TabOrder = 4
    end
    object rbProforma: TRadioButton
      Left = 91
      Top = 87
      Width = 80
      Height = 17
      Caption = 'Proforma'
      Checked = True
      TabOrder = 7
      TabStop = True
    end
    object rbDespacho: TRadioButton
      Left = 156
      Top = 87
      Width = 113
      Height = 17
      Caption = 'Despacho'
      TabOrder = 8
    end
    object cbbIdiomaAlbaran: TComboBox
      Left = 48
      Top = 25
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
    object cbxLame: TCheckBox
      Tag = 20
      Left = 32
      Top = 130
      Width = 169
      Height = 12
      Caption = 'Certificado L.A.M.E.'
      TabOrder = 9
    end
    object cbxDeclaracion: TCheckBox
      Tag = 20
      Left = 32
      Top = 107
      Width = 169
      Height = 17
      Caption = 'Declaraci'#243'n Responsable'
      TabOrder = 10
    end
  end
  object PanelBotones: TPanel
    Left = 0
    Top = 206
    Width = 425
    Height = 36
    Align = alBottom
    TabOrder = 1
    object btnSi: TButton
      Left = 240
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Si  (F1)'
      TabOrder = 0
      OnClick = btnSiClick
    end
    object btnNo: TButton
      Left = 320
      Top = 4
      Width = 75
      Height = 25
      Caption = 'No (Esc)'
      TabOrder = 1
      OnClick = btnNoClick
    end
  end
end
