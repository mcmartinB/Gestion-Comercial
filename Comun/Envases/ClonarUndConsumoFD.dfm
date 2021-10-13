object FDClonarUndConsumo: TFDClonarUndConsumo
  Left = 656
  Top = 306
  Caption = '  Clonar Unidad de Consumo'
  ClientHeight = 207
  ClientWidth = 503
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lblNombre6: TLabel
    Left = 9
    Top = 16
    Width = 108
    Height = 17
    AutoSize = False
    Caption = ' Empresa '
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblNombre7: TLabel
    Left = 9
    Top = 35
    Width = 108
    Height = 17
    AutoSize = False
    Caption = ' Producto'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object LEnvase_e: TLabel
    Left = 9
    Top = 57
    Width = 108
    Height = 17
    AutoSize = False
    Caption = ' C'#243'digo Envase'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lbl1: TLabel
    Left = 11
    Top = 145
    Width = 108
    Height = 17
    AutoSize = False
    Caption = ' C'#243'digo Envase'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object btnAceptar: TButton
    Left = 382
    Top = 84
    Width = 100
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 0
    TabStop = False
    OnClick = btnAceptarClick
  end
  object rbCambiar: TRadioButton
    Left = 9
    Top = 97
    Width = 289
    Height = 22
    Caption = 'Cambiar Producto de la Unidad de Consumo'
    Checked = True
    TabOrder = 1
    TabStop = True
  end
  object rbBorrar: TRadioButton
    Left = 9
    Top = 116
    Width = 289
    Height = 17
    Caption = 'No pasar la unidad de consumo al envase nuevo'
    TabOrder = 2
  end
  object empresa_e: TBEdit
    Left = 121
    Top = 12
    Width = 41
    Height = 21
    ColorEdit = clMoneyGreen
    ColorNormal = clBtnFace
    ReadOnly = True
    MaxLength = 3
    TabOrder = 3
  end
  object producto_e: TBEdit
    Left = 121
    Top = 34
    Width = 41
    Height = 21
    ColorEdit = clMoneyGreen
    ColorNormal = clBtnFace
    ReadOnly = True
    MaxLength = 3
    TabOrder = 4
  end
  object envase_e: TBEdit
    Left = 121
    Top = 55
    Width = 41
    Height = 21
    ColorEdit = clMoneyGreen
    ColorNormal = clBtnFace
    Zeros = True
    ReadOnly = True
    MaxLength = 3
    TabOrder = 5
  end
  object txtEmpresa: TStaticText
    Left = 180
    Top = 16
    Width = 215
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 6
  end
  object txtProducto: TStaticText
    Left = 180
    Top = 36
    Width = 215
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 7
  end
  object txtEnvase: TStaticText
    Left = 180
    Top = 57
    Width = 215
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 8
  end
  object txtDesEnvase: TStaticText
    Left = 182
    Top = 145
    Width = 215
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 9
  end
  object edt_envase: TBEdit
    Left = 123
    Top = 143
    Width = 41
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    MaxLength = 3
    TabOrder = 10
  end
  object rbNoPasar: TRadioButton
    Left = 9
    Top = 84
    Width = 289
    Height = 17
    Caption = 'No pasar la unidad de consumo al envase nuevo'
    TabOrder = 11
  end
end
