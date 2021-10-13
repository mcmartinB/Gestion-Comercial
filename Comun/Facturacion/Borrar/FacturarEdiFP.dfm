object FPFacturarEdi: TFPFacturarEdi
  Left = 537
  Top = 218
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '   TRANSFERENCIA DE FACTURAS EDI A FICHERO'
  ClientHeight = 330
  ClientWidth = 551
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
  object Bevel1: TBevel
    Left = 41
    Top = 35
    Width = 469
    Height = 208
    Style = bsRaised
  end
  object BCalendarButton1: TBCalendarButton
    Left = 315
    Top = 164
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
    Control = edtFecha
    Calendar = BCalendario1
    CalendarAlignment = taCenterCenter
    CalendarWidth = 193
    CalendarHeigth = 153
  end
  object BGridButton1: TBGridButton
    Left = 207
    Top = 67
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
    Control = edtEmpresa
    Grid = RejillaFlotante
    GridAlignment = taDownRight
    GridWidth = 280
    GridHeigth = 200
  end
  object StaticText2: TStaticText
    Left = 241
    Top = 125
    Width = 73
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = '  DESDE '
    Color = clBtnFace
    ParentColor = False
    TabOrder = 6
  end
  object StaticText3: TStaticText
    Left = 314
    Top = 125
    Width = 73
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = '  HASTA '
    Color = clBtnFace
    ParentColor = False
    TabOrder = 7
  end
  object edtFactHasta: TBEdit
    Left = 314
    Top = 142
    Width = 73
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itInteger
    MaxLength = 7
    TabOrder = 10
  end
  object edtFactDesde: TBEdit
    Left = 241
    Top = 142
    Width = 73
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itInteger
    MaxLength = 7
    TabOrder = 9
  end
  object StaticText1: TStaticText
    Left = 109
    Top = 144
    Width = 115
    Height = 17
    AutoSize = False
    Caption = 'Rango de facturas ..'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 11
  end
  object StaticText4: TStaticText
    Left = 109
    Top = 167
    Width = 130
    Height = 17
    AutoSize = False
    Caption = 'Fecha facturaci'#243'n EDI ..'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 13
  end
  object edtFecha: TBEdit
    Left = 241
    Top = 165
    Width = 73
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itDate
    MaxLength = 10
    TabOrder = 12
  end
  object BtnFind: TBitBtn
    Left = 396
    Top = 187
    Width = 20
    Height = 21
    TabOrder = 15
    TabStop = False
    OnClick = BtnFindClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      0400000000000001000000000000000000001000000010000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00303333333333
      333337F3333333333333303333333333333337F33FFFFF3FF3FF303300000300
      300337FF77777F77377330000BBB0333333337777F337F33333330330BB00333
      333337F373F773333333303330033333333337F3377333333333303333333333
      333337F33FFFFF3FF3FF303300000300300337FF77777F77377330000BBB0333
      333337777F337F33333330330BB00333333337F373F773333333303330033333
      333337F3377333333333303333333333333337FFFF3FF3FFF333000003003000
      333377777F77377733330BBB0333333333337F337F33333333330BB003333333
      333373F773333333333330033333333333333773333333333333}
    Layout = blGlyphTop
    NumGlyphs = 2
  end
  object edtRuta: TStaticText
    Left = 242
    Top = 189
    Width = 153
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    Caption = 'C:\aspedi\produccion\salida\'
    Color = clWhite
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
  end
  object BtnOk: TBitBtn
    Left = 313
    Top = 272
    Width = 92
    Height = 27
    Caption = '&Aceptar'
    ModalResult = 1
    TabOrder = 18
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
    Left = 417
    Top = 272
    Width = 92
    Height = 27
    Caption = '&Cancelar'
    TabOrder = 19
    TabStop = False
    OnClick = BitBtn1Click
    Kind = bkCancel
  end
  object StaticText5: TStaticText
    Left = 109
    Top = 189
    Width = 130
    Height = 17
    AutoSize = False
    Caption = 'Guardar ficheros en .. '
    Color = clBtnFace
    ParentColor = False
    TabOrder = 16
  end
  object StaticText6: TStaticText
    Left = 91
    Top = 69
    Width = 57
    Height = 17
    AutoSize = False
    Caption = 'Empresa '
    Color = clBtnFace
    ParentColor = False
    TabOrder = 1
  end
  object edtEmpresa: TBEdit
    Left = 148
    Top = 67
    Width = 57
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 0
    OnChange = edtEmpresaChange
  end
  object stEmpresa: TStaticText
    Left = 224
    Top = 69
    Width = 226
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 2
  end
  object lblCliente: TStaticText
    Left = 91
    Top = 93
    Width = 57
    Height = 17
    AutoSize = False
    Caption = 'Cliente'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 4
  end
  object edtCliente: TComboBox
    Left = 148
    Top = 91
    Width = 72
    Height = 21
    CharCase = ecUpperCase
    ItemHeight = 13
    TabOrder = 3
    Text = 'CBBCLIENTE'
    OnChange = edtClienteChange
  end
  object stCliente: TStaticText
    Left = 224
    Top = 93
    Width = 226
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 5
  end
  object RejillaFlotante: TBGrid
    Left = 512
    Top = 136
    Width = 50
    Height = 25
    Color = clInfoBk
    Options = [dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    BControl = edtEmpresa
  end
  object BCalendario1: TBCalendario
    Left = 511
    Top = 168
    Width = 193
    Height = 153
    Date = 36917.4985976736
    TabOrder = 14
    Visible = False
    WeekNumbers = True
    BControl = edtFecha
  end
end
