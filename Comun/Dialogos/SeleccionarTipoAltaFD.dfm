object FDSeleccionarTipoAlta: TFDSeleccionarTipoAlta
  Left = 401
  Top = 250
  Width = 419
  Height = 216
  ActiveControl = rbNuevo
  Caption = '     SELECCIONAR TIPO ALTA'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object rbNuevo: TRadioButton
    Left = 25
    Top = 18
    Width = 200
    Height = 17
    Caption = 'Nuevo'
    Checked = True
    TabOrder = 1
    TabStop = True
    OnClick = rbImportarClick
  end
  object rbImportar: TRadioButton
    Left = 25
    Top = 40
    Width = 200
    Height = 17
    Caption = 'Importar de almac'#233'n'
    TabOrder = 2
    OnClick = rbImportarClick
  end
  object btnOk: TButton
    Left = 170
    Top = 10
    Width = 210
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancelar: TButton
    Left = 170
    Top = 40
    Width = 210
    Height = 25
    Caption = 'Cerrar'
    TabOrder = 3
    OnClick = btnCancelarClick
  end
  object pnlBD: TPanel
    Left = 25
    Top = 65
    Width = 355
    Height = 98
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 4
    object rbF17: TRadioButton
      Left = 25
      Top = 11
      Width = 200
      Height = 17
      Caption = 'F17 - Chanita'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbF18: TRadioButton
      Left = 25
      Top = 31
      Width = 200
      Height = 17
      Caption = 'F18 - P4H'
      TabOrder = 1
    end
    object rbF23: TRadioButton
      Left = 25
      Top = 50
      Width = 200
      Height = 17
      Caption = 'F23 - Tenerife'
      TabOrder = 2
    end
  end
end
