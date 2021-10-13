object FMEntradasFruta: TFMEntradasFruta
  Left = 206
  Top = 190
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  ENTRADAS DE FRUTA - CABECERA'
  ClientHeight = 469
  ClientWidth = 813
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
  WindowState = wsMaximized
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
    Width = 813
    Height = 209
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    BevelWidth = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object linCajas: TLabel
      Left = 221
      Top = 167
      Width = 87
      Height = 13
      Caption = 'Cajas en las lineas'
      Visible = False
    end
    object taraCajas: TLabel
      Left = 222
      Top = 167
      Width = 44
      Height = 13
      Caption = 'taraCajas'
      Visible = False
    end
    object LEmpresa_p: TLabel
      Left = 397
      Top = 68
      Width = 78
      Height = 18
      AutoSize = False
      Caption = ' Centro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBCentro_ec: TBGridButton
      Left = 513
      Top = 67
      Width = 13
      Height = 20
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
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00000000BFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FF00000000000000000000000000FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00000000000000000000000000000000000000
        00BFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
      Control = centro_ec
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 250
      GridHeigth = 200
    end
    object Label1: TLabel
      Left = 45
      Top = 68
      Width = 78
      Height = 18
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa_ec: TBGridButton
      Left = 161
      Top = 67
      Width = 13
      Height = 20
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
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00000000BFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FF00000000000000000000000000FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00000000000000000000000000000000000000
        00BFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
      Control = empresa_ec
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object Label2: TLabel
      Left = 45
      Top = 93
      Width = 78
      Height = 18
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBProducto_ec: TBGridButton
      Left = 161
      Top = 92
      Width = 13
      Height = 20
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
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00000000BFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FF00000000000000000000000000FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00000000000000000000000000000000000000
        00BFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
      Control = producto_ec
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 240
      GridHeigth = 200
    end
    object Label3: TLabel
      Left = 45
      Top = 119
      Width = 78
      Height = 18
      AutoSize = False
      Caption = ' Transportista'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 397
      Top = 93
      Width = 78
      Height = 18
      AutoSize = False
      Caption = ' Fecha'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 570
      Top = 93
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Hora'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 45
      Top = 145
      Width = 78
      Height = 18
      AutoSize = False
      Caption = ' Total Palets'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label7: TLabel
      Left = 222
      Top = 145
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Total Cajas'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label8: TLabel
      Left = 400
      Top = 145
      Width = 78
      Height = 18
      AutoSize = False
      Caption = ' Peso Bruto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label9: TLabel
      Left = 577
      Top = 145
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Peso Neto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BCBFecha_ec: TBCalendarButton
      Left = 550
      Top = 92
      Width = 13
      Height = 20
      Hint = 'Pulse F2 para desplegar un calendario.. '
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
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00000000BFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FF00000000000000000000000000FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00000000000000000000000000000000000000
        00BFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
      Control = fecha_ec
      Calendar = CalendarioFlotante
      CalendarAlignment = taDownRight
      CalendarWidth = 197
      CalendarHeigth = 152
    end
    object BGBTransportista_ec: TBGridButton
      Left = 161
      Top = 118
      Width = 13
      Height = 20
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
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00000000BFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FF00000000000000000000000000FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00000000000000000000000000000000000000
        00BFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
      Control = transportista_ec
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 300
      GridHeigth = 200
    end
    object LAno_semana_p: TLabel
      Left = 45
      Top = 41
      Width = 90
      Height = 18
      AutoSize = False
      Caption = ' N'#186' Entrada'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object taraCamion: TLabel
      Left = 400
      Top = 122
      Width = 38
      Height = 13
      Caption = 'TARA ='
      Visible = False
    end
    object linKilos: TLabel
      Left = 578
      Top = 167
      Width = 83
      Height = 13
      Caption = 'Kilos en las lineas'
      Visible = False
    end
    object taraPalets: TLabel
      Left = 45
      Top = 167
      Width = 47
      Height = 13
      Caption = 'taraPalets'
      Visible = False
    end
    object taraTotal: TLabel
      Left = 400
      Top = 167
      Width = 42
      Height = 13
      Caption = 'taraTotal'
      Visible = False
    end
    object centro_ec: TBDEdit
      Tag = 1
      Left = 475
      Top = 67
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de centro es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 1
      TabOrder = 1
      OnChange = PonNombreCab
      OnExit = centro_ecExit
      DataField = 'centro_ec'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object STCentro_ec: TStaticText
      Left = 527
      Top = 69
      Width = 208
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 11
    end
    object empresa_ec: TBDEdit
      Tag = 1
      Left = 123
      Top = 67
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = PonNombreCab
      OnExit = empresa_ecExit
      DataField = 'empresa_ec'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object STEmpresa_ec: TStaticText
      Left = 175
      Top = 69
      Width = 208
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 12
    end
    object producto_ec: TBDEdit
      Tag = 1
      Left = 123
      Top = 92
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de producto es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 1
      TabOrder = 2
      OnChange = PonNombreCab
      DataField = 'producto_ec'
      DataSource = DSMaestro
      Modificable = False
    end
    object STProducto_ec: TStaticText
      Left = 175
      Top = 94
      Width = 208
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 13
    end
    object transportista_ec: TBDEdit
      Left = 123
      Top = 118
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del transportista es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 5
      OnChange = PonNombreCab
      DataField = 'transportista_ec'
      DataSource = DSMaestro
    end
    object fecha_ec: TBDEdit
      Left = 475
      Top = 92
      Width = 74
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'La fecha de la entrada es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itDate
      MaxLength = 10
      TabOrder = 3
      OnEnter = fecha_ecEnter
      DataField = 'fecha_ec'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object hora_ec: TBDEdit
      Left = 648
      Top = 92
      Width = 87
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'La hora de la entrada es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 5
      TabOrder = 4
      DataField = 'hora_ec'
      DataSource = DSMaestro
    end
    object total_palets_ec: TBDEdit
      Left = 123
      Top = 144
      Width = 79
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El numero de palets es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      TabOrder = 6
      OnChange = total_palets_ecChange
      DataField = 'total_palets_ec'
      DataSource = DSMaestro
    end
    object total_cajas_ec: TBDEdit
      Left = 300
      Top = 144
      Width = 79
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El n'#250'mero total de cajas es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      TabOrder = 7
      OnChange = total_cajas_ecChange
      DataField = 'total_cajas_ec'
      DataSource = DSMaestro
    end
    object peso_bruto_ec: TBDEdit
      Left = 478
      Top = 144
      Width = 79
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'El peso bruto de la entrada es de obligada inserci'#243'n.'
      InputType = itInteger
      MaxLength = 10
      TabOrder = 8
      OnChange = peso_bruto_ecChange
      DataField = 'peso_bruto_ec'
      DataSource = DSMaestro
    end
    object peso_neto_ec: TBDEdit
      Left = 656
      Top = 144
      Width = 79
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El peso neto de la entrada es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 10
      TabOrder = 9
      OnChange = peso_neto_ecChange
      DataField = 'peso_neto_ec'
      DataSource = DSMaestro
    end
    object numero_entrada_ec: TBDEdit
      Left = 123
      Top = 40
      Width = 87
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El n'#250'mero de entrada es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      TabOrder = 10
      OnEnter = numero_entrada_ecEnter
      OnExit = numero_entrada_ecExit
      DataField = 'numero_entrada_ec'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object STTransportista_ec: TStaticText
      Left = 175
      Top = 120
      Width = 208
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 14
    end
  end
  object CalendarioFlotante: TBCalendario
    Left = 401
    Top = 248
    Width = 177
    Height = 153
    AutoSize = True
    Date = 36748.4141748148
    ShowToday = False
    TabOrder = 1
    Visible = False
    WeekNumbers = True
    BControl = fecha_ec
  end
  object RejillaFlotante: TBGrid
    Left = 8
    Top = 56
    Width = 41
    Height = 57
    Color = clInfoBk
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object PDetalle: TPanel
    Left = 0
    Top = 209
    Width = 813
    Height = 260
    Align = alClient
    TabOrder = 3
    object PDetalleEdit: TPanel
      Left = 1
      Top = 1
      Width = 811
      Height = 93
      Align = alTop
      BevelInner = bvLowered
      TabOrder = 0
      object Label15: TLabel
        Left = 120
        Top = 15
        Width = 68
        Height = 18
        AutoSize = False
        Caption = ' Cosechero'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object BGBCosechero_e2l: TBGridButton
        Left = 228
        Top = 14
        Width = 13
        Height = 20
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
          FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
          FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
          FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
          FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
          FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00000000BFFF00FF00FF00
          FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FFBFFF00FF00FF00FF00000000000000000000000000FF00
          FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FFBFFF00FF00000000000000000000000000000000000000
          00BFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
          000000000000FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
          FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
          FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        ParentShowHint = False
        ShowHint = True
        Control = cosechero_e2l
        Grid = RejillaFlotante
        GridAlignment = taDownRight
        GridWidth = 300
        GridHeigth = 200
      end
      object Label16: TLabel
        Left = 120
        Top = 36
        Width = 68
        Height = 18
        AutoSize = False
        Caption = ' Plantaci'#243'n'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object BGBPlantacion_e2l: TBGridButton
        Left = 228
        Top = 35
        Width = 13
        Height = 20
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
          FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
          FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
          FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
          FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
          FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00000000BFFF00FF00FF00
          FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FFBFFF00FF00FF00FF00000000000000000000000000FF00
          FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FFBFFF00FF00000000000000000000000000000000000000
          00BFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
          000000000000FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
          FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
          FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        ParentShowHint = False
        ShowHint = True
        Control = plantacion_e2l
        Grid = RejillaFlotante
        GridAlignment = taDownCenter
        GridWidth = 355
        GridHeigth = 200
      end
      object Label17: TLabel
        Left = 480
        Top = 15
        Width = 68
        Height = 18
        AutoSize = False
        Caption = ' Cajas'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label18: TLabel
        Left = 480
        Top = 37
        Width = 68
        Height = 18
        AutoSize = False
        Caption = ' Kilos'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label10: TLabel
        Left = 120
        Top = 57
        Width = 68
        Height = 18
        AutoSize = False
        Caption = ' Sectores'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object cosechero_e2l: TBDEdit
        Tag = 1
        Left = 190
        Top = 14
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El c'#243'digo de cosechero es de obligada inserci'#243'n.'
        OnRequiredTime = RequiredTime
        InputType = itInteger
        MaxLength = 3
        TabOrder = 0
        OnChange = PonNombreLin
        DataField = 'cosechero_e2l'
        DataSource = DSDetalle
        Modificable = False
        PrimaryKey = True
      end
      object plantacion_e2l: TBDEdit
        Tag = 1
        Left = 190
        Top = 35
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El c'#243'digo de plantaci'#243'n es de obligada inserci'#243'n.'
        OnRequiredTime = RequiredTime
        InputType = itInteger
        MaxLength = 3
        TabOrder = 1
        OnChange = PonNombreLin
        DataField = 'plantacion_e2l'
        DataSource = DSDetalle
        Modificable = False
        PrimaryKey = True
      end
      object total_cajas_e2l: TBDEdit
        Left = 551
        Top = 14
        Width = 85
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El n'#250'mero de cajas del palet es de obligada inserci'#243'n.'
        OnRequiredTime = RequiredTime
        InputType = itInteger
        TabOrder = 3
        OnChange = total_cajas_e2lChange
        DataField = 'total_cajas_e2l'
        DataSource = DSDetalle
      end
      object total_kgs_e2l: TBDEdit
        Left = 551
        Top = 36
        Width = 85
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El c'#243'digo del palet es de obligada inserci'#243'n.'
        OnRequiredTime = RequiredTime
        InputType = itReal
        MaxDecimals = 2
        MaxLength = 13
        TabOrder = 4
        DataField = 'total_kgs_e2l'
        DataSource = DSDetalle
      end
      object STCosechero_e2l: TStaticText
        Left = 243
        Top = 16
        Width = 210
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        Caption = 'STCosechero_e2l'
        TabOrder = 5
      end
      object STPlantacion_e2l: TStaticText
        Left = 243
        Top = 38
        Width = 210
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        Caption = 'STPlantacion_e2l'
        TabOrder = 6
      end
      object sectores_e2l: TBDEdit
        Left = 190
        Top = 56
        Width = 85
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 10
        TabOrder = 2
        DataField = 'sectores_e2l'
        DataSource = DSDetalle
      end
    end
    object RVisualizacion: TDBGrid
      Left = 1
      Top = 94
      Width = 811
      Height = 165
      Align = alClient
      DataSource = DSDetalle
      Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ano_sem_planta_e2l'
          Title.Alignment = taCenter
          Title.Caption = 'A'#241'o/Sem.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cosechero_e2l'
          Title.Caption = ' '
          Width = 33
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'des_cosechero'
          Title.Alignment = taCenter
          Title.Caption = 'Cosechero'
          Width = 178
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'plantacion_e2l'
          Title.Caption = ' '
          Width = 34
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'des_plantacion'
          Title.Alignment = taCenter
          Title.Caption = 'Plantaci'#243'n'
          Width = 227
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sectores_e2l'
          Title.Alignment = taCenter
          Title.Caption = 'Sectores'
          Width = 71
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'total_cajas_e2l'
          Title.Alignment = taCenter
          Title.Caption = 'Cajas'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'total_kgs_e2l'
          Title.Alignment = taCenter
          Title.Caption = 'Kgs.'
          Visible = True
        end>
    end
  end
  object DSMaestro: TDataSource
    DataSet = QEntradaFrutas
    Left = 296
    Top = 8
  end
  object ACosecheros: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 504
    Top = 8
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object DSDetalle: TDataSource
    DataSet = TLinInFrutasOficina
    Left = 360
    Top = 8
  end
  object QTotalesLineas: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    Left = 536
    Top = 8
  end
  object QEntradaFrutas: TQuery
    BeforePost = QEntradaFrutasBeforePost
    AfterPost = QEntradaFrutasAfterPost
    OnPostError = QEntradaFrutasPostError
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      
        'SELECT empresa_ec, centro_ec, numero_entrada_ec, producto_ec, fe' +
        'cha_ec, hora_ec, transportista_ec, total_cajas_ec, total_palets_' +
        'ec, peso_bruto_ec, peso_neto_ec'
      'FROM frf_entradas_c Frf_entradas_c'
      'ORDER BY empresa_ec, centro_ec, numero_entrada_ec')
    Left = 264
    Top = 8
  end
  object TLinInFrutasOficina: TTable
    OnCalcFields = TLinInFrutasOficinaCalcFields
    DatabaseName = 'BDProyecto'
    IndexFieldNames = 'empresa_e2l;centro_e2l;numero_entrada_e2l;fecha_e2l'
    MasterFields = 'empresa_ec;centro_ec;numero_entrada_ec;fecha_ec'
    MasterSource = DSMaestro
    TableName = 'frf_entradas2_l'
    Left = 328
    Top = 8
    object TLinInFrutasOficinaempresa_e2l: TStringField
      FieldName = 'empresa_e2l'
      Required = True
      FixedChar = True
      Size = 3
    end
    object TLinInFrutasOficinacentro_e2l: TStringField
      FieldName = 'centro_e2l'
      Required = True
      FixedChar = True
      Size = 1
    end
    object TLinInFrutasOficinanumero_entrada_e2l: TIntegerField
      FieldName = 'numero_entrada_e2l'
      Required = True
    end
    object TLinInFrutasOficinacosechero_e2l: TSmallintField
      FieldName = 'cosechero_e2l'
      Required = True
    end
    object TLinInFrutasOficinaplantacion_e2l: TSmallintField
      FieldName = 'plantacion_e2l'
      Required = True
    end
    object TLinInFrutasOficinaano_sem_planta_e2l: TStringField
      FieldName = 'ano_sem_planta_e2l'
      Required = True
      FixedChar = True
      Size = 6
    end
    object TLinInFrutasOficinatotal_cajas_e2l: TIntegerField
      FieldName = 'total_cajas_e2l'
    end
    object TLinInFrutasOficinatotal_kgs_e2l: TFloatField
      FieldName = 'total_kgs_e2l'
      Required = True
    end
    object TLinInFrutasOficinaproducto_e2l: TStringField
      FieldName = 'producto_e2l'
      FixedChar = True
      Size = 1
    end
    object TLinInFrutasOficinasectores_e2l: TStringField
      FieldName = 'sectores_e2l'
      FixedChar = True
      Size = 10
    end
    object TLinInFrutasOficinades_cosechero: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_cosechero'
      Size = 30
      Calculated = True
    end
    object TLinInFrutasOficinades_plantacion: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_plantacion'
      Size = 30
      Calculated = True
    end
  end
end
