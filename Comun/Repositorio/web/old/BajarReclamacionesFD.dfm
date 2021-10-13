object FDBajarReclamaciones: TFDBajarReclamaciones
  Left = 260
  Top = 293
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    BAJAR RECLAMACIONES'
  ClientHeight = 118
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    450
    118)
  PixelsPerInch = 96
  TextHeight = 13
  object lblMensaje: TLabel
    Left = 24
    Top = 24
    Width = 57
    Height = 13
    Caption = 'MENSAJES'
  end
  object btnBajar: TButton
    Left = 271
    Top = 70
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Bajar'
    Enabled = False
    TabOrder = 0
    OnClick = btnBajarClick
  end
  object btnCerrar: TButton
    Left = 351
    Top = 70
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cerrar'
    TabOrder = 1
    OnClick = btnCerrarClick
  end
end
