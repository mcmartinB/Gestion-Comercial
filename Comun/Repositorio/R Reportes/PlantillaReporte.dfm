object FPlantillaReporte: TFPlantillaReporte
  Left = 297
  Top = 297
  ActiveControl = edtAnyo
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    TITULO  REPORTE'
  ClientHeight = 518
  ClientWidth = 708
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  DesignSize = (
    708
    518)
  PixelsPerInch = 96
  TextHeight = 13
  object btnAceptar: TSpeedButton
    Left = 522
    Top = 481
    Width = 88
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Listado'
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
    OnClick = btnAceptarClick
  end
  object btnCancelar: TSpeedButton
    Left = 613
    Top = 481
    Width = 89
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cerrar'
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
    OnClick = btnCancelarClick
  end
  object nbLabel1: TnbLabel
    Left = 43
    Top = 23
    Width = 77
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object nbLabel2: TnbLabel
    Left = 43
    Top = 164
    Width = 77
    Height = 21
    Caption = 'A'#241'o/Mes'
    About = 'NB 0.1/20020725'
  end
  object des_empresa: TnbStaticText
    Left = 177
    Top = 23
    Width = 190
    Height = 21
    Caption = 'des_empresa'
    About = 'NB 0.1/20020725'
  end
  object des_mes: TnbStaticText
    Left = 184
    Top = 164
    Width = 190
    Height = 21
    Caption = 'des_mes'
    About = 'NB 0.1/20020725'
  end
  object nbLabel4: TnbLabel
    Left = 43
    Top = 48
    Width = 77
    Height = 21
    Caption = 'Centro'
    About = 'NB 0.1/20020725'
  end
  object des_centro: TnbStaticText
    Left = 177
    Top = 48
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object lblProducto: TnbLabel
    Left = 43
    Top = 73
    Width = 77
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object des_producto: TnbStaticText
    Left = 177
    Top = 73
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object btnFechaIni: TBCalendarButton
    Left = 198
    Top = 138
    Width = 17
    Height = 21
    Action = ADesplegarRejilla
    Glyph.Data = {
      E2020000424DE20200000000000042000000280000001C0000000C0000000100
      100003000000A002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7CEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3D
      EF3D1F7C1F7CFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F1F7C
      1F7C000000000F0000000F000F0000000F00000000000F00EF3D1F7CEF3DEF3D
      EF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DFF7F1F7C1F7CFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F0F00EF3D1F7CEF3DFF7F1F7CFF7FFF7FFF7F
      1F7CFF7FFF7FFF7F1F7CEF3DFF7F1F7C1F7CFF7F000000000000FF7F00000000
      0000F75EFF7F0F00EF3D1F7CEF3DFF7FEF3DEF3DEF3D1F7CEF3DEF3DEF3D1F7C
      FF7FEF3DFF7F1F7C1F7CFF7FFF7F0000FF7FFF7FF75EFF7FF75E0000FF7F0F00
      EF3D1F7CEF3DFF7F1F7CEF3DFF7F1F7C1F7C1F7C1F7CEF3DFF7FEF3DFF7F1F7C
      1F7CFF7FFF7F0000FF7FFF7FFF7FFF7FFF7F0000FF7F0F00EF3D1F7CEF3DFF7F
      1F7CEF3DFF7F1F7C1F7CFF7FFF7FEF3D1F7CEF3DFF7F1F7C1F7CFF7FFF7F0000
      FF7FFF7F000000000000F75EFF7F0F00EF3D1F7CEF3DFF7F1F7CEF3DFF7F1F7C
      EF3DEF3DEF3D1F7C1F7CEF3DFF7F1F7C1F7CFF7F00000000FF7FFF7F0000FF7F
      FF7FFF7FFF7F0F00EF3D1F7CEF3DFF7FEF3DEF3DFF7F1F7CEF3DFF7FFF7FFF7F
      FF7FEF3DFF7F1F7C1F7CFF7FFF7F0000FF7FFF7F0000000000000000FF7F0F00
      EF3D1F7CEF3DFF7F1F7CEF3D1F7C1F7CEF3DEF3DEF3DEF3D1F7CEF3DFF7F1F7C
      1F7CFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0F00EF3D1F7CEF3DFF7F
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CEF3DFF7F1F7C1F7CFF7FF75EF75E
      F75EF75EF75EF75EF75EF75EFF7F0F00EF3D1F7CEF3DFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FEF3DFF7F1F7C1F7C0000000000000000000000000000
      0000000000001F7C1F7C1F7CEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3D
      EF3DEF3D1F7C}
    NumGlyphs = 2
    Control = edtFechaIni
    Calendar = CalendarioFlotante
    CalendarAlignment = taCenterRight
    CalendarWidth = 177
    CalendarHeigth = 140
  end
  object btnFechaFin: TBCalendarButton
    Left = 327
    Top = 138
    Width = 17
    Height = 21
    Action = ADesplegarRejilla
    Glyph.Data = {
      E2020000424DE20200000000000042000000280000001C0000000C0000000100
      100003000000A002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7CEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3D
      EF3D1F7C1F7CFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F1F7C
      1F7C000000000F0000000F000F0000000F00000000000F00EF3D1F7CEF3DEF3D
      EF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DFF7F1F7C1F7CFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F0F00EF3D1F7CEF3DFF7F1F7CFF7FFF7FFF7F
      1F7CFF7FFF7FFF7F1F7CEF3DFF7F1F7C1F7CFF7F000000000000FF7F00000000
      0000F75EFF7F0F00EF3D1F7CEF3DFF7FEF3DEF3DEF3D1F7CEF3DEF3DEF3D1F7C
      FF7FEF3DFF7F1F7C1F7CFF7FFF7F0000FF7FFF7FF75EFF7FF75E0000FF7F0F00
      EF3D1F7CEF3DFF7F1F7CEF3DFF7F1F7C1F7C1F7C1F7CEF3DFF7FEF3DFF7F1F7C
      1F7CFF7FFF7F0000FF7FFF7FFF7FFF7FFF7F0000FF7F0F00EF3D1F7CEF3DFF7F
      1F7CEF3DFF7F1F7C1F7CFF7FFF7FEF3D1F7CEF3DFF7F1F7C1F7CFF7FFF7F0000
      FF7FFF7F000000000000F75EFF7F0F00EF3D1F7CEF3DFF7F1F7CEF3DFF7F1F7C
      EF3DEF3DEF3D1F7C1F7CEF3DFF7F1F7C1F7CFF7F00000000FF7FFF7F0000FF7F
      FF7FFF7FFF7F0F00EF3D1F7CEF3DFF7FEF3DEF3DFF7F1F7CEF3DFF7FFF7FFF7F
      FF7FEF3DFF7F1F7C1F7CFF7FFF7F0000FF7FFF7F0000000000000000FF7F0F00
      EF3D1F7CEF3DFF7F1F7CEF3D1F7C1F7CEF3DEF3DEF3DEF3D1F7CEF3DFF7F1F7C
      1F7CFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0F00EF3D1F7CEF3DFF7F
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CEF3DFF7F1F7C1F7CFF7FF75EF75E
      F75EF75EF75EF75EF75EF75EFF7F0F00EF3D1F7CEF3DFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FEF3DFF7F1F7C1F7C0000000000000000000000000000
      0000000000001F7C1F7C1F7CEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3DEF3D
      EF3DEF3D1F7C}
    NumGlyphs = 2
    Control = edtFechaFin
    Calendar = CalendarioFlotante
    CalendarAlignment = taCenterRight
    CalendarWidth = 177
    CalendarHeigth = 140
  end
  object lblCodigo1: TnbLabel
    Left = 43
    Top = 138
    Width = 77
    Height = 21
    Caption = 'Fecha Desde'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo2: TnbLabel
    Left = 217
    Top = 138
    Width = 37
    Height = 21
    Caption = 'Hasta'
    About = 'NB 0.1/20020725'
  end
  object btnEmpresa: TBGridButton
    Left = 156
    Top = 23
    Width = 13
    Height = 21
    Action = ADesplegarRejilla
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
    Control = edtEmpresa
    Grid = rejillaFlotante
    GridAlignment = taDownRight
    GridWidth = 280
    GridHeigth = 100
  end
  object btnProducto: TBGridButton
    Left = 156
    Top = 73
    Width = 13
    Height = 21
    Action = ADesplegarRejilla
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
    Control = edtProducto
    Grid = rejillaFlotante
    GridAlignment = taDownRight
    GridWidth = 280
    GridHeigth = 120
  end
  object btnCentro: TBGridButton
    Left = 156
    Top = 48
    Width = 13
    Height = 21
    Action = ADesplegarRejilla
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
    Control = edtCentro
    Grid = rejillaFlotante
    GridAlignment = taDownRight
    GridWidth = 280
    GridHeigth = 100
  end
  object lblCliente: TnbLabel
    Left = 44
    Top = 98
    Width = 77
    Height = 21
    Caption = 'Cliente'
    About = 'NB 0.1/20020725'
  end
  object btnCliente: TBGridButton
    Left = 157
    Top = 98
    Width = 13
    Height = 21
    Action = ADesplegarRejilla
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
    Control = edtCliente
    Grid = rejillaFlotante
    GridAlignment = taDownRight
    GridWidth = 280
    GridHeigth = 120
  end
  object des_cliente: TnbStaticText
    Left = 178
    Top = 98
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object edtEmpresa: TBEdit
    Left = 124
    Top = 23
    Width = 29
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    MaxLength = 3
    TabOrder = 1
    OnChange = edtEmpresaChange
  end
  object edtAnyo: TBEdit
    Left = 125
    Top = 164
    Width = 36
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itInteger
    MaxLength = 4
    TabOrder = 8
  end
  object edtMes: TBEdit
    Left = 163
    Top = 164
    Width = 18
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itInteger
    MaxLength = 2
    TabOrder = 9
    OnChange = edtMesChange
  end
  object edtCentro: TBEdit
    Left = 124
    Top = 48
    Width = 29
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    MaxLength = 1
    TabOrder = 2
    OnChange = edtCentroChange
  end
  object edtProducto: TBEdit
    Left = 124
    Top = 73
    Width = 29
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    MaxLength = 1
    TabOrder = 3
    OnChange = edtProductoChange
  end
  object CalendarioFlotante: TBCalendario
    Left = 429
    Top = 19
    Width = 177
    Height = 140
    Date = 36717.4829093287
    ShowToday = False
    TabOrder = 0
    Visible = False
    WeekNumbers = True
  end
  object edtFechaIni: TBEdit
    Left = 125
    Top = 138
    Width = 70
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itDate
    TabOrder = 6
  end
  object edtFechaFin: TBEdit
    Left = 257
    Top = 138
    Width = 70
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itDate
    TabOrder = 7
  end
  object rejillaFlotante: TBGrid
    Left = 434
    Top = 94
    Width = 137
    Height = 135
    Color = clInfoBk
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object edtCliente: TBEdit
    Left = 125
    Top = 98
    Width = 29
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    MaxLength = 1
    TabOrder = 5
    OnChange = edtClienteChange
  end
  object ListaAcciones: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 400
    Top = 20
    object BAceptar: TAction
      Caption = 'Aceptar'
      ShortCut = 112
      OnExecute = btnAceptarClick
    end
    object BCancelar: TAction
      Caption = 'Cancelar'
      ShortCut = 27
      OnExecute = btnCancelarClick
    end
    object ADesplegarRejilla: TAction
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ADesplegarRejillaExecute
    end
  end
end
