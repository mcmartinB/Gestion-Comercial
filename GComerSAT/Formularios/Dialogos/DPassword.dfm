object FDPassword: TFDPassword
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Usuario/Password'
  ClientHeight = 283
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 1
    Top = 1
    Width = 285
    Height = 280
    Center = True
    Stretch = True
  end
  object LUsuario: TLabel
    Left = 26
    Top = 175
    Width = 76
    Height = 13
    Caption = 'Usuario .....: '
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object LClave: TLabel
    Left = 26
    Top = 201
    Width = 73
    Height = 13
    Caption = 'Clave  .......:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object BBevel2: TBevel
    Left = 15
    Top = 163
    Width = 258
    Height = 64
    Shape = bsBottomLine
    Style = bsRaised
  end
  object cbAlias: TComboBox
    Left = 26
    Top = 141
    Width = 234
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
    TabStop = False
    OnChange = cbAliasChange
  end
  object EUsuario: TEdit
    Left = 116
    Top = 171
    Width = 143
    Height = 21
    Color = clWhite
    TabOrder = 1
  end
  object EClave: TEdit
    Left = 116
    Top = 199
    Width = 143
    Height = 21
    Color = clWhite
    PasswordChar = '*'
    TabOrder = 2
  end
  object BAceptar: TButton
    Left = 85
    Top = 238
    Width = 91
    Height = 32
    Caption = 'Aceptar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BAceptarClick
  end
  object BCancelar: TButton
    Left = 181
    Top = 238
    Width = 91
    Height = 32
    Caption = 'Cancelar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = BCancelarClick
  end
end
