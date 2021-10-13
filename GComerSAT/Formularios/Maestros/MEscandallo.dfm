object FMEscandallo: TFMEscandallo
  Left = 573
  Top = 169
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  MANTENIMIENTO DE ESCANDALLOS'
  ClientHeight = 539
  ClientWidth = 751
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
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label13: TLabel
    Left = 37
    Top = 75
    Width = 90
    Height = 19
    AutoSize = False
    Caption = 'Empresa'
    Color = cl3DLight
    ParentColor = False
  end
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 751
    Height = 252
    Align = alTop
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Bevel6: TBevel
      Left = 32
      Top = 199
      Width = 646
      Height = 33
    end
    object Bevel5: TBevel
      Left = 511
      Top = 105
      Width = 202
      Height = 17
    end
    object Bevel4: TBevel
      Left = 159
      Top = 105
      Width = 208
      Height = 17
    end
    object cosechero_des: TLabel
      Left = 162
      Top = 106
      Width = 203
      Height = 15
      AutoSize = False
    end
    object Bevel2: TBevel
      Left = 511
      Top = 33
      Width = 210
      Height = 17
    end
    object Bevel3: TBevel
      Left = 159
      Top = 81
      Width = 210
      Height = 17
    end
    object Bevel1: TBevel
      Left = 159
      Top = 33
      Width = 208
      Height = 17
    end
    object LAno_semana_p: TLabel
      Left = 388
      Top = 56
      Width = 70
      Height = 19
      AutoSize = False
      Caption = ' Fecha'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 34
      Top = 32
      Width = 70
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btgEmpresa: TBGridButton
      Left = 140
      Top = 31
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      Control = empresa_e
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object empresa_des: TLabel
      Left = 162
      Top = 34
      Width = 203
      Height = 15
      AutoSize = False
    end
    object Label1: TLabel
      Left = 388
      Top = 32
      Width = 70
      Height = 19
      AutoSize = False
      Caption = ' Centro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btgCentro: TBGridButton
      Left = 477
      Top = 31
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      Control = centro_e
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object centro_des: TLabel
      Left = 514
      Top = 34
      Width = 202
      Height = 15
      AutoSize = False
    end
    object Label4: TLabel
      Left = 34
      Top = 80
      Width = 70
      Height = 19
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btgProducto: TBGridButton
      Left = 140
      Top = 79
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      Control = producto_e
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object producto_des: TLabel
      Left = 162
      Top = 82
      Width = 202
      Height = 15
      AutoSize = False
    end
    object Label7: TLabel
      Left = 34
      Top = 104
      Width = 70
      Height = 19
      AutoSize = False
      Caption = ' Cosechero'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btgCosechero: TBGridButton
      Left = 140
      Top = 103
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      Control = cosechero_e
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object Label9: TLabel
      Left = 388
      Top = 104
      Width = 70
      Height = 19
      AutoSize = False
      Caption = ' Plantaci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btgPlantacion: TBGridButton
      Left = 486
      Top = 103
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      Control = plantacion_e
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object plantacion_des: TLabel
      Left = 514
      Top = 106
      Width = 199
      Height = 15
      AutoSize = False
    end
    object btcFecha: TBCalendarButton
      Left = 527
      Top = 55
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = ARejillaFlotanteExecute
      Control = fecha_e
      Calendar = CalendarioFlotante
      CalendarAlignment = taCenterCenter
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object Label3: TLabel
      Left = 34
      Top = 56
      Width = 70
      Height = 19
      AutoSize = False
      Caption = ' Entrada'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre1: TLabel
      Left = 388
      Top = 80
      Width = 70
      Height = 18
      AutoSize = False
      Caption = ' Tipo Entrada'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre2: TLabel
      Left = 40
      Top = 210
      Width = 60
      Height = 13
      AutoSize = False
      Caption = 'Primera:'
    end
    object lblKilosPrimera: TLabel
      Left = 98
      Top = 210
      Width = 60
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,00'
    end
    object lblNombre4: TLabel
      Left = 166
      Top = 210
      Width = 60
      Height = 13
      AutoSize = False
      Caption = 'Segunda:'
    end
    object lblKilosSegunda: TLabel
      Left = 225
      Top = 210
      Width = 60
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,00'
    end
    object lblNombre6: TLabel
      Left = 293
      Top = 210
      Width = 60
      Height = 13
      AutoSize = False
      Caption = 'Tercera:'
    end
    object lblKilosTercera: TLabel
      Left = 351
      Top = 210
      Width = 60
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,00'
    end
    object lblNombre3: TLabel
      Left = 45
      Top = 192
      Width = 31
      Height = 13
      Caption = 'KILOS'
    end
    object lblKilosTotales_: TLabel
      Left = 546
      Top = 210
      Width = 60
      Height = 13
      AutoSize = False
      Caption = 'TOTALES:'
    end
    object lblKilosTotales: TLabel
      Left = 610
      Top = 210
      Width = 60
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,00'
    end
    object lblDestrioDes: TLabel
      Left = 420
      Top = 210
      Width = 60
      Height = 13
      AutoSize = False
      Caption = 'Destr'#237'o:'
    end
    object lblKilosDestrio: TLabel
      Left = 478
      Top = 210
      Width = 60
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,00'
    end
    object fecha_e: TBDEdit
      Left = 459
      Top = 55
      Width = 66
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      InputType = itDate
      MaxLength = 35
      TabOrder = 3
      DataField = 'fecha_e'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object empresa_e: TBDEdit
      Tag = 1
      Left = 107
      Top = 31
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      DataField = 'empresa_e'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object centro_e: TBDEdit
      Tag = 1
      Left = 459
      Top = 31
      Width = 17
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 1
      TabOrder = 1
      DataField = 'centro_e'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object producto_e: TBDEdit
      Tag = 1
      Left = 107
      Top = 79
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 4
      DataField = 'producto_e'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object cosechero_e: TBDEdit
      Tag = 1
      Left = 107
      Top = 103
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 3
      TabOrder = 7
      DataField = 'cosechero_e'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object plantacion_e: TBDEdit
      Tag = 1
      Left = 459
      Top = 103
      Width = 27
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 3
      TabOrder = 8
      DataField = 'plantacion_e'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object GroupBox1: TGroupBox
      Left = 31
      Top = 136
      Width = 647
      Height = 49
      Caption = ' Porcentajes en tanto por cien '
      TabOrder = 9
      object Label2: TLabel
        Left = 73
        Top = 20
        Width = 89
        Height = 19
        AutoSize = False
        Caption = 'Primera'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object LEmpresa_p: TLabel
        Left = 216
        Top = 20
        Width = 90
        Height = 19
        AutoSize = False
        Caption = 'Segunda'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label11: TLabel
        Left = 362
        Top = 20
        Width = 89
        Height = 19
        AutoSize = False
        Caption = 'Tercera'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lblDestrio: TLabel
        Left = 507
        Top = 20
        Width = 89
        Height = 19
        AutoSize = False
        Caption = 'Destr'#237'o'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object porcen_primera_e: TBDEdit
        Left = 121
        Top = 19
        Width = 41
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        InputType = itReal
        MaxDecimals = 2
        MaxLength = 6
        TabOrder = 0
        DataField = 'porcen_primera_e'
        DataSource = DSMaestro
      end
      object porcen_segunda_e: TBDEdit
        Tag = 1
        Left = 265
        Top = 19
        Width = 41
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        InputType = itReal
        MaxDecimals = 2
        MaxLength = 6
        TabOrder = 1
        DataField = 'porcen_segunda_e'
        DataSource = DSMaestro
      end
      object porcen_tercera_e: TBDEdit
        Left = 410
        Top = 19
        Width = 41
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        InputType = itReal
        MaxDecimals = 2
        MaxLength = 6
        TabOrder = 2
        DataField = 'porcen_tercera_e'
        DataSource = DSMaestro
      end
      object porcen_destrio_e: TBDEdit
        Left = 555
        Top = 19
        Width = 41
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        InputType = itReal
        MaxDecimals = 2
        MaxLength = 6
        TabOrder = 3
        DataField = 'porcen_destrio_e'
        DataSource = DSMaestro
      end
    end
    object numero_entrada_e: TBDEdit
      Left = 107
      Top = 55
      Width = 66
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 8
      TabOrder = 2
      OnChange = numero_entrada_eChange
      DataField = 'numero_entrada_e'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object tipo_entrada_e: TnbDBSQLCombo
      Left = 459
      Top = 79
      Width = 49
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      OnChange = tipo_entrada_eChange
      TabOrder = 5
      DataField = 'tipo_entrada_e'
      DataSource = DSMaestro
      DBLink = True
      SQL.Strings = (
        'select tipo_et tipo, descripcion_et descripcion '
        'from frf_entradas_tipo'
        'order by tipo_et')
      DatabaseName = 'BDProyecto'
      OnGetSQL = tipo_entrada_eGetSQL
    end
    object stTipoEntrada: TStaticText
      Left = 511
      Top = 81
      Width = 208
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 6
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 252
    Width = 751
    Height = 287
    TabStop = False
    Align = alClient
    DataSource = DSRejilla
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'empresa_e'
        Title.Alignment = taCenter
        Title.Caption = 'Empr.'
        Width = 32
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'centro_e'
        Title.Alignment = taCenter
        Title.Caption = 'Cent.'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'numero_entrada_e'
        Title.Alignment = taCenter
        Title.Caption = 'Entrada'
        Width = 54
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'fecha_e'
        Title.Alignment = taCenter
        Title.Caption = 'Fecha'
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'producto_e'
        Title.Alignment = taCenter
        Title.Caption = 'Prod.'
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cosechero_e'
        Title.Alignment = taCenter
        Title.Caption = 'Cosec.'
        Width = 39
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'des_plantacion_e'
        Title.Alignment = taCenter
        Title.Caption = 'Plantaci'#243'n'
        Width = 203
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'anyo_semana_e'
        Title.Alignment = taCenter
        Title.Caption = 'A'#241'o/Sem.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'porcen_primera_e'
        Title.Alignment = taCenter
        Title.Caption = '% 1'#170
        Width = 47
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'porcen_segunda_e'
        Title.Alignment = taCenter
        Title.Caption = '% 2'#170
        Width = 47
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'porcen_tercera_e'
        Title.Alignment = taCenter
        Title.Caption = '% 3'#170
        Width = 47
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'porcen_destrio_e'
        Title.Alignment = taCenter
        Title.Caption = '% Des.'
        Width = 47
        Visible = True
      end>
  end
  object RejillaFlotante: TBGrid
    Left = 214
    Top = 5
    Width = 50
    Height = 25
    Color = clInfoBk
    DataSource = DMBaseDatos.DSQDespegables
    Options = [dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    BControl = empresa_e
  end
  object CalendarioFlotante: TBCalendario
    Left = 712
    Top = 96
    Width = 197
    Height = 153
    Date = 37816.629539872690000000
    TabOrder = 2
    Visible = False
  end
  object DSMaestro: TDataSource
    DataSet = QEscandalloMaster
    OnDataChange = DSMaestroDataChange
    Left = 48
  end
  object ACosecheros: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 352
    Top = 8
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QEscandalloMaster: TQuery
    OnCalcFields = QEscandalloMasterCalcFields
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'select * '
      'from frf_escandallo')
    Left = 16
    Top = 1
    object QEscandalloMasterempresa_e: TStringField
      FieldName = 'empresa_e'
      Origin = 'COMERCIALIZACION.frf_escandallo.empresa_e'
      FixedChar = True
      Size = 3
    end
    object QEscandalloMastercentro_e: TStringField
      FieldName = 'centro_e'
      Origin = 'COMERCIALIZACION.frf_escandallo.centro_e'
      FixedChar = True
      Size = 1
    end
    object QEscandalloMasternumero_entrada_e: TIntegerField
      FieldName = 'numero_entrada_e'
      Origin = 'COMERCIALIZACION.frf_escandallo.numero_entrada_e'
    end
    object QEscandalloMastercosechero_e: TSmallintField
      FieldName = 'cosechero_e'
      Origin = 'COMERCIALIZACION.frf_escandallo.cosechero_e'
    end
    object QEscandalloMasterplantacion_e: TSmallintField
      FieldName = 'plantacion_e'
      Origin = 'COMERCIALIZACION.frf_escandallo.plantacion_e'
    end
    object QEscandalloMasteranyo_semana_e: TStringField
      FieldName = 'anyo_semana_e'
      Origin = 'COMERCIALIZACION.frf_escandallo.anyo_semana_e'
      FixedChar = True
      Size = 6
    end
    object QEscandalloMasterproducto_e: TStringField
      FieldName = 'producto_e'
      Origin = 'COMERCIALIZACION.frf_escandallo.producto_e'
      FixedChar = True
      Size = 3
    end
    object QEscandalloMasterporcen_primera_e: TFloatField
      FieldName = 'porcen_primera_e'
      Origin = 'COMERCIALIZACION.frf_escandallo.porcen_primera_e'
      DisplayFormat = '#0.00'
    end
    object QEscandalloMasterporcen_segunda_e: TFloatField
      FieldName = 'porcen_segunda_e'
      Origin = 'COMERCIALIZACION.frf_escandallo.porcen_segunda_e'
      DisplayFormat = '#0.00'
    end
    object QEscandalloMasterporcen_tercera_e: TFloatField
      FieldName = 'porcen_tercera_e'
      Origin = 'COMERCIALIZACION.frf_escandallo.porcen_tercera_e'
      DisplayFormat = '#0.00'
    end
    object QEscandalloMasterporcen_destrio_e: TFloatField
      FieldName = 'porcen_destrio_e'
      Origin = 'COMERCIALIZACION.frf_escandallo.porcen_destrio_e'
      DisplayFormat = '#0.00'
    end
    object QEscandalloMasterdes_plantacion_e: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_plantacion_e'
      Size = 30
      Calculated = True
    end
    object QEscandalloMastertipo_entrada_e: TIntegerField
      FieldName = 'tipo_entrada_e'
      Origin = 'BDPROYECTO.frf_escandallo.tipo_entrada_e'
    end
  end
  object DSRejilla: TDataSource
    DataSet = QEscandalloMaster
    OnDataChange = DSMaestroDataChange
    Left = 104
  end
  object QAnyoSemana: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select ano_sem_planta_e2l'
      'from frf_entradas2_l'
      'where empresa_e2l = :empresa'
      'and centro_e2l = :centro'
      'and numero_entrada_e2l = :entrada'
      'and fecha_e2l = :fecha'
      'and cosechero_e2l = :cosechero'
      'and plantacion_e2l = :plantacion'
      'and producto_e2l = :producto')
    Left = 16
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'centro'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'entrada'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'cosechero'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'plantacion'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'producto'
        ParamType = ptUnknown
      end>
  end
  object QKilosEntrada: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'select ano_sem_planta_e2l'
      'from frf_entradas2_l'
      'where empresa_e2l = :empresa'
      'and centro_e2l = :centro'
      'and numero_entrada_e2l = :entrada'
      'and fecha_e2l = :fecha'
      'and cosechero_e2l = :cosechero'
      'and plantacion_e2l = :plantacion'
      'and producto_e2l = :producto')
    Left = 56
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'centro'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'entrada'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'cosechero'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'plantacion'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'producto'
        ParamType = ptUnknown
      end>
  end
end
