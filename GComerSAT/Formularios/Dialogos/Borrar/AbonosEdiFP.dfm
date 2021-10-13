object FPAbonosEdi: TFPAbonosEdi
  Left = 274
  Top = 291
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    FACTURACI'#211'N EDI DE UN ABONO'
  ClientHeight = 173
  ClientWidth = 436
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
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BCalendarButton1: TBCalendarButton
    Left = 303
    Top = 50
    Width = 15
    Height = 22
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000000000000000001F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000000000000000000000001F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
    OnClick = BCalendarButton1Click
    Control = fecha
    Calendar = BCalendario1
    CalendarAlignment = taCenterCenter
    CalendarWidth = 193
    CalendarHeigth = 153
  end
  object BGridButton1: TBGridButton
    Left = 150
    Top = 27
    Width = 13
    Height = 21
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000000000000000001F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000000000000000000000001F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
    OnClick = BGridButton1Click
    Control = empresa
    Grid = RejillaFlotante
    GridAlignment = taDownRight
    GridWidth = 280
    GridHeigth = 200
  end
  object lblPedido: TLabel
    Left = 35
    Top = 76
    Width = 315
    Height = 13
    Caption = 
      'Pedido y albar'#225'n en blanco usa los grabados en gestion comercial' +
      '.'
  end
  object abono: TBEdit
    Left = 91
    Top = 51
    Width = 73
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itInteger
    MaxLength = 7
    TabOrder = 5
    OnChange = abonoChange
  end
  object StaticText1: TStaticText
    Left = 171
    Top = 53
    Width = 57
    Height = 17
    AutoSize = False
    Caption = 'Fecha'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 8
  end
  object StaticText4: TStaticText
    Left = 35
    Top = 53
    Width = 57
    Height = 17
    AutoSize = False
    Caption = 'Abono'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 7
  end
  object fecha: TBEdit
    Left = 231
    Top = 51
    Width = 73
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itDate
    MaxLength = 10
    TabOrder = 6
    OnChange = abonoChange
  end
  object BtnOk: TBitBtn
    Left = 202
    Top = 120
    Width = 92
    Height = 27
    Caption = '&Aceptar'
    ModalResult = 1
    TabOrder = 13
    TabStop = False
    OnClick = Button1Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BtnCancel: TBitBtn
    Left = 301
    Top = 120
    Width = 92
    Height = 27
    Caption = '&Cancelar'
    TabOrder = 14
    TabStop = False
    OnClick = BitBtn1Click
    Kind = bkCancel
  end
  object StaticText6: TStaticText
    Left = 35
    Top = 29
    Width = 57
    Height = 17
    AutoSize = False
    Caption = 'Empresa '
    Color = clBtnFace
    ParentColor = False
    TabOrder = 3
  end
  object empresa: TBEdit
    Left = 91
    Top = 27
    Width = 57
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 2
    OnChange = empresaChange
  end
  object nombreEmpresa: TStaticText
    Left = 171
    Top = 29
    Width = 226
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 4
  end
  object cbxSoloBorrar: TComboBox
    Left = 35
    Top = 123
    Width = 130
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 15
    Text = 'Crear factura EDI'
    Items.Strings = (
      'Crear factura EDI'
      'Borrar la factura EDI')
  end
  object txtPedido: TStaticText
    Left = 35
    Top = 91
    Width = 57
    Height = 17
    AutoSize = False
    Caption = 'Pedido'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 11
  end
  object edtPedido: TBEdit
    Left = 91
    Top = 89
    Width = 86
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itInteger
    MaxLength = 8
    TabOrder = 9
  end
  object txtAlbaran: TStaticText
    Left = 182
    Top = 91
    Width = 57
    Height = 17
    AutoSize = False
    Caption = 'Albar'#225'n'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 12
  end
  object edtAlbaran: TBEdit
    Left = 242
    Top = 89
    Width = 106
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 10
    TabOrder = 10
  end
  object RejillaFlotante: TBGrid
    Left = 328
    Top = 16
    Width = 50
    Height = 25
    Color = clInfoBk
    Options = [dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    BControl = empresa
  end
  object BCalendario1: TBCalendario
    Left = 399
    Top = 8
    Width = 193
    Height = 153
    Date = 36917.450595590280000000
    TabOrder = 0
    Visible = False
    WeekNumbers = True
    BControl = fecha
  end
end
