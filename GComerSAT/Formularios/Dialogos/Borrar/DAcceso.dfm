object FDAcceso: TFDAcceso
  Left = 809
  Top = 415
  ActiveControl = EUsuario
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = ' Conexi'#243'n Base de Datos'
  ClientHeight = 285
  ClientWidth = 289
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 1
    Top = 2
    Width = 287
    Height = 281
    Shape = bsFrame
  end
  object Image1: TImage
    Left = 3
    Top = 3
    Width = 283
    Height = 277
    Center = True
    Stretch = True
  end
  object BBevel2: TBevel
    Left = 15
    Top = 163
    Width = 258
    Height = 64
    Shape = bsBottomLine
    Style = bsRaised
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
    OnClick = BBAceptar2Click
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
    OnClick = BBCancelar2Click
  end
  object EClave: TEdit
    Left = 116
    Top = 199
    Width = 143
    Height = 21
    Color = clWhite
    PasswordChar = '*'
    TabOrder = 1
    OnEnter = EEntrar
    OnExit = ESalir
  end
  object EUsuario: TEdit
    Left = 116
    Top = 171
    Width = 143
    Height = 21
    Color = clWhite
    TabOrder = 0
    OnEnter = EEntrar
    OnExit = ESalir
  end
  object cbAlias: TComboBox
    Left = 26
    Top = 141
    Width = 235
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    TabStop = False
    OnChange = cbAliasChange
  end
  object TTable
    DatabaseName = 'BDProyecto'
    IndexFieldNames = 'usuario_u'
    TableName = 'frf_usuarios'
    Left = 344
    Top = 72
  end
  object QExisteUsuario: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select *'
      'from frf_usuarios'
      'where usuario_u=:usuario')
    Left = 32
    Top = 238
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'usuario'
        ParamType = ptUnknown
      end>
  end
end
