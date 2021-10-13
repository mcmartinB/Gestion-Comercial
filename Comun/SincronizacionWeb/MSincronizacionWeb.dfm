object FMSincronizacionWeb: TFMSincronizacionWeb
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'SINCRONIZACI'#211'N WEB'
  ClientHeight = 156
  ClientWidth = 402
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblProgreso: TLabel
    Left = 40
    Top = 25
    Width = 320
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Sincronizando <x> de <total>'
  end
  object btnCerrar: TBitBtn
    Left = 285
    Top = 107
    Width = 95
    Height = 25
    Caption = 'Cerrar'
    TabOrder = 2
    OnClick = btnCerrarClick
    Kind = bkCancel
  end
  object pb: TProgressBar
    Left = 40
    Top = 50
    Width = 320
    Height = 17
    TabOrder = 0
  end
  object btnSincronizar: TBitBtn
    Left = 184
    Top = 107
    Width = 95
    Height = 25
    Caption = 'Sincronizar'
    TabOrder = 1
    OnClick = btnSincronizarClick
    Kind = bkOK
  end
end
