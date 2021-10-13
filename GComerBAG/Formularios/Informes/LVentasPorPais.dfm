object FLVentasPorPais: TFLVentasPorPais
  Left = 392
  Top = 165
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = ' LISTADOS DE VENTAS POR PA'#205'S'
  ClientHeight = 336
  ClientWidth = 501
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
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 501
    Height = 336
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 282
      Top = 275
      Width = 89
      Height = 25
      Action = BAceptar
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000FF0000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000000FF000000FFBF0000FF00000000BFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000000FF000000FFBF0000FF00000000BFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000000FF000000FF000000FFBF0000FF000000FFBF00000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000000FF000000FFBF0000FF000000FFBF0000FF000000FFBF00000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007F7F
        7F000000FF3F0000FFBF00000000FF00FF000000FF000000FFBF0000FF000000
        00BFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007F7F7F000000
        FF3F00000000FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000
        00BFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000
        FFBF00000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000
        FFBF00000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        FF000000FF00000000BFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF007F7F7F000000FF3F00000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF007F7F7F000000FF3F000000BFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000FF000000FF00000000BFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
    end
    object SpeedButton2: TSpeedButton
      Left = 379
      Top = 275
      Width = 89
      Height = 25
      Action = BCancelar
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FFBFFF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00
        FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
        FFBF0000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
        0000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
        FFBF00000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000000000000000000000000000FFFFFF00FF00FFBFFF00
        FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FFBFFF00
        FF0000000000000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
    end
    object GBEmpresa: TGroupBox
      Left = 35
      Top = 35
      Width = 430
      Height = 203
      TabOrder = 0
      object Label3: TLabel
        Left = 23
        Top = 65
        Width = 60
        Height = 19
        AutoSize = False
        Caption = ' Pa'#237's'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label1: TLabel
        Left = 23
        Top = 41
        Width = 60
        Height = 19
        AutoSize = False
        Caption = ' Empresa'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object BGBEmpresa: TBGridButton
        Left = 123
        Top = 40
        Width = 13
        Height = 21
        Action = ADesplegarRejilla
        Control = EEmpresa
        Grid = RejillaFlotante
        GridAlignment = taDownRight
        GridWidth = 280
        GridHeigth = 100
      end
      object BGBPais: TBGridButton
        Left = 123
        Top = 64
        Width = 13
        Height = 21
        Action = ADesplegarRejilla
        Control = EPais
        Grid = RejillaFlotante
        GridAlignment = taDownRight
        GridWidth = 280
        GridHeigth = 100
      end
      object Label2: TLabel
        Left = 23
        Top = 89
        Width = 60
        Height = 19
        AutoSize = False
        Caption = ' Producto'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object BGBProducto: TBGridButton
        Left = 123
        Top = 88
        Width = 13
        Height = 21
        Action = ADesplegarRejilla
        Control = EProducto
        Grid = RejillaFlotante
        GridAlignment = taDownRight
        GridWidth = 280
        GridHeigth = 100
      end
      object Label5: TLabel
        Left = 23
        Top = 114
        Width = 60
        Height = 19
        AutoSize = False
        Caption = ' Categor'#237'a'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label6: TLabel
        Left = 123
        Top = 117
        Width = 110
        Height = 13
        Caption = '(Optativo, vacio=todas)'
      end
      object Desde: TLabel
        Left = 23
        Top = 141
        Width = 60
        Height = 19
        AutoSize = False
        Caption = ' Desde el '
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object BCBDesde: TBCalendarButton
        Left = 171
        Top = 140
        Width = 17
        Height = 21
        Action = ADesplegarRejilla
        Control = MEDesde
        Calendar = CalendarioFlotante
        CalendarAlignment = taUpLeft
        CalendarWidth = 197
        CalendarHeigth = 153
      end
      object Label4: TLabel
        Left = 194
        Top = 141
        Width = 28
        Height = 19
        Alignment = taCenter
        AutoSize = False
        Caption = ' al'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object BCBHasta: TBCalendarButton
        Left = 309
        Top = 140
        Width = 17
        Height = 21
        Action = ADesplegarRejilla
        Control = MEHasta
        Calendar = CalendarioFlotante
        CalendarAlignment = taUpLeft
        CalendarWidth = 197
        CalendarHeigth = 153
      end
      object EPais: TBEdit
        Left = 89
        Top = 64
        Width = 24
        Height = 21
        ColorEdit = clMoneyGreen
        MaxLength = 3
        TabOrder = 2
        OnChange = PonNombre
      end
      object EEmpresa: TBEdit
        Left = 89
        Top = 40
        Width = 33
        Height = 21
        ColorEdit = clMoneyGreen
        Zeros = True
        MaxLength = 3
        TabOrder = 0
        OnChange = PonNombre
      end
      object STEmpresa: TStaticText
        Left = 137
        Top = 42
        Width = 267
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 1
      end
      object STPais: TStaticText
        Left = 137
        Top = 66
        Width = 267
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 3
      end
      object EProducto: TBEdit
        Left = 89
        Top = 88
        Width = 33
        Height = 21
        ColorEdit = clMoneyGreen
        MaxLength = 3
        TabOrder = 4
        OnChange = PonNombre
      end
      object STProducto: TStaticText
        Left = 137
        Top = 90
        Width = 267
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 5
      end
      object ECategoria: TBEdit
        Left = 89
        Top = 113
        Width = 24
        Height = 21
        ColorEdit = clMoneyGreen
        MaxLength = 2
        TabOrder = 6
        OnChange = PonNombre
      end
      object MEDesde: TBEdit
        Left = 89
        Top = 140
        Width = 81
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itDate
        MaxLength = 10
        TabOrder = 7
      end
      object MEHasta: TBEdit
        Left = 228
        Top = 140
        Width = 81
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itDate
        MaxLength = 10
        TabOrder = 8
      end
    end
  end
  object RejillaFlotante: TBGrid
    Left = 5
    Top = 263
    Width = 137
    Height = 135
    Color = clInfoBk
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object CalendarioFlotante: TBCalendario
    Left = 87
    Top = 272
    Width = 197
    Height = 153
    Date = 36717.406980127310000000
    TabOrder = 2
    Visible = False
    WeekNumbers = True
  end
  object ListaAcciones: TActionList
    Left = 8
    Top = 44
    object BAceptar: TAction
      Caption = 'Aceptar'
      ShortCut = 112
      OnExecute = BBAceptarClick
    end
    object BCancelar: TAction
      Caption = 'Cancelar'
      ShortCut = 27
      OnExecute = BBCancelarClick
    end
    object ADesplegarRejilla: TAction
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ADesplegarRejillaExecute
    end
  end
end
