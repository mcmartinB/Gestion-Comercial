object FDGetFechaDiarioEnvases: TFDGetFechaDiarioEnvases
  Left = 792
  Top = 290
  BorderStyle = bsDialog
  Caption = '   IMPRIMIR'
  ClientHeight = 100
  ClientWidth = 409
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
    Left = 16
    Top = 12
    Width = 229
    Height = 13
    Caption = #191'DESEA IMPRIMIR EL ALBAR'#193'N DE SALIDA?'
  end
  object btnSi: TButton
    Left = 232
    Top = 55
    Width = 75
    Height = 25
    Caption = 'Si  (F1)'
    TabOrder = 1
    OnClick = btnSiClick
  end
  object btnNo: TButton
    Left = 312
    Top = 55
    Width = 75
    Height = 25
    Caption = 'No (Esc)'
    TabOrder = 2
    OnClick = btnNoClick
  end
  object edtFecha: TnbDBCalendarCombo
    Left = 16
    Top = 32
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '07/04/2011'
    Enabled = False
    TabOrder = 0
  end
end
