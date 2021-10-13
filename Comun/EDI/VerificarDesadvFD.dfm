object FDVerificarDesadv: TFDVerificarDesadv
  Left = 522
  Top = 396
  Width = 582
  Height = 466
  Caption = 'Verificar Datos Desadv'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblTexto: TLabel
    Left = 8
    Top = 17
    Width = 37
    Height = 13
    Caption = 'lblTexto'
  end
  object btnOk: TButton
    Left = 410
    Top = 391
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 491
    Top = 391
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object dbgrdResumen: TDBGrid
    Left = 8
    Top = 47
    Width = 554
    Height = 329
    DataSource = dsResumen
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object chkConfirmo: TCheckBox
    Left = 8
    Top = 395
    Width = 308
    Height = 17
    Caption = 'Confirmo que lo  que aparece como cargado es correcto.'
    TabOrder = 3
    OnClick = chkConfirmoClick
  end
  object dsResumen: TDataSource
    Left = 37
    Top = 78
  end
end
