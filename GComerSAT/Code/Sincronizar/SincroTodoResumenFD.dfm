object FDSincroTodoResumen: TFDSincroTodoResumen
  Left = 286
  Top = 172
  BorderStyle = bsDialog
  Caption = '    RESUMEN SINCRONIZACION'
  ClientHeight = 552
  ClientWidth = 489
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  DesignSize = (
    489
    552)
  PixelsPerInch = 96
  TextHeight = 13
  object lblEstado: TLabel
    Left = 9
    Top = 16
    Width = 98
    Height = 13
    Caption = 'Mensajes de estado.'
  end
  object Bevel1: TBevel
    Left = 16
    Top = 42
    Width = 321
    Height = 57
  end
  object mmoResumen: TMemo
    Left = 0
    Top = 112
    Width = 489
    Height = 440
    Align = alBottom
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object btnCerrar: TButton
    Left = 406
    Top = 10
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cerrar'
    TabOrder = 1
    OnClick = btnCerrarClick
  end
  object btnEnviar: TButton
    Left = 249
    Top = 10
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Enviar'
    TabOrder = 2
    OnClick = btnEnviarClick
  end
  object btnImprimir: TButton
    Left = 328
    Top = 10
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Imprimir'
    TabOrder = 3
    OnClick = btnImprimirClick
  end
  object cbxPasados: TCheckBox
    Left = 383
    Top = 61
    Width = 67
    Height = 17
    Caption = 'Pasados'
    TabOrder = 4
    OnClick = cbxPasadosClick
  end
  object cbxErroneos: TCheckBox
    Left = 383
    Top = 45
    Width = 67
    Height = 17
    Caption = 'Erroneos'
    Checked = True
    State = cbChecked
    TabOrder = 5
    OnClick = cbxPasadosClick
  end
  object cbxDuplicados: TCheckBox
    Left = 383
    Top = 77
    Width = 81
    Height = 17
    Caption = 'Duplicados'
    TabOrder = 6
    OnClick = cbxPasadosClick
  end
  object cbxEntradas: TCheckBox
    Left = 37
    Top = 50
    Width = 93
    Height = 17
    Caption = 'Entradas'
    Checked = True
    State = cbChecked
    TabOrder = 7
    OnClick = cbxPasadosClick
  end
  object cbxEscandallos: TCheckBox
    Left = 227
    Top = 50
    Width = 93
    Height = 17
    Caption = 'Escandallos'
    Checked = True
    State = cbChecked
    TabOrder = 8
    OnClick = cbxPasadosClick
  end
  object cbxSalidas: TCheckBox
    Left = 131
    Top = 50
    Width = 93
    Height = 17
    Caption = 'Salidas'
    Checked = True
    State = cbChecked
    TabOrder = 9
    OnClick = cbxPasadosClick
  end
  object cbxTransitos: TCheckBox
    Left = 35
    Top = 74
    Width = 93
    Height = 17
    Caption = 'Tr'#225'nsitos'
    Checked = True
    State = cbChecked
    TabOrder = 10
    OnClick = cbxPasadosClick
  end
  object cbxInventarios: TCheckBox
    Left = 131
    Top = 74
    Width = 93
    Height = 17
    Caption = 'Inventarios'
    Checked = True
    State = cbChecked
    TabOrder = 11
    OnClick = cbxPasadosClick
  end
  object cbxConfeccionado: TCheckBox
    Left = 227
    Top = 74
    Width = 93
    Height = 17
    Caption = 'Confeccionado'
    Checked = True
    State = cbChecked
    TabOrder = 12
    OnClick = cbxPasadosClick
  end
  object IdSMTP: TIdSMTP
    Host = 'smtp.e.telefonica.net'
    Password = 'sba111'
    SASLMechanisms = <>
    Left = 168
    Top = 393
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 200
    Top = 393
  end
end
