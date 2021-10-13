object FDAdvertencia: TFDAdvertencia
  Left = 588
  Top = 199
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = '  ADVERTENCIA'
  ClientHeight = 180
  ClientWidth = 660
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object mmoMsg: TMemo
    Left = 8
    Top = 8
    Width = 642
    Height = 135
    Color = clBtnFace
    Lines.Strings = (
      'mmoMsg')
    ReadOnly = True
    TabOrder = 0
  end
  object chkIgnorarErrores: TCheckBox
    Left = 8
    Top = 152
    Width = 415
    Height = 17
    Caption = 'Confirmo que no hay errores'
    TabOrder = 3
    OnClick = chkIgnorarErroresClick
  end
  object btnAceptar: TButton
    Left = 575
    Top = 148
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = btnAceptarClick
  end
  object btnIgnorar: TButton
    Left = 432
    Top = 148
    Width = 140
    Height = 25
    Caption = 'Ignorar Advertencia'
    Enabled = False
    TabOrder = 1
    OnClick = btnIgnorarClick
  end
end
