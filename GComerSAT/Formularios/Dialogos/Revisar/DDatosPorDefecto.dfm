object FDDatosPorDefecto: TFDDatosPorDefecto
  Left = 606
  Top = 238
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  DATOS POR DEFECTO'
  ClientHeight = 262
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    430
    262)
  PixelsPerInch = 96
  TextHeight = 13
  object LEmpresa: TLabel
    Left = 31
    Top = 26
    Width = 70
    Height = 19
    AutoSize = False
    Caption = 'Empresa'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object LCentro: TLabel
    Left = 31
    Top = 54
    Width = 70
    Height = 19
    AutoSize = False
    Caption = 'Centro'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object BGBEmpresa: TBGridButton
    Left = 154
    Top = 24
    Width = 13
    Height = 22
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
    Grid = RejillaFlotante
    GridAlignment = taDownCenter
    GridWidth = 240
    GridHeigth = 130
  end
  object BGBCentro: TBGridButton
    Left = 154
    Top = 53
    Width = 13
    Height = 22
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
    Grid = RejillaFlotante
    GridAlignment = taDownCenter
    GridWidth = 240
    GridHeigth = 130
  end
  object LProducto: TLabel
    Left = 31
    Top = 83
    Width = 70
    Height = 19
    AutoSize = False
    Caption = 'Producto'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object BGBProducto: TBGridButton
    Left = 154
    Top = 81
    Width = 13
    Height = 22
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
    Grid = RejillaFlotante
    GridAlignment = taDownCenter
    GridWidth = 240
    GridHeigth = 130
  end
  object BGBCliente: TBGridButton
    Left = 154
    Top = 110
    Width = 13
    Height = 22
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
    Grid = RejillaFlotante
    GridAlignment = taDownCenter
    GridWidth = 240
    GridHeigth = 130
  end
  object lblNombre2: TLabel
    Left = 31
    Top = 111
    Width = 70
    Height = 19
    AutoSize = False
    Caption = 'Cliente'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object btnAceptar: TSpeedButton
    Left = 223
    Top = 216
    Width = 88
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Aceptar'
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
    Left = 314
    Top = 216
    Width = 89
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancelar'
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
    OnClick = BBCancelarClick
  end
  object lblNota: TLabel
    Left = 73
    Top = 156
    Width = 288
    Height = 19
    AutoSize = False
    Caption = 'Estos datos son necesarios para selccionar distintos listados '
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblNot2: TLabel
    Left = 73
    Top = 174
    Width = 152
    Height = 13
    Caption = 'segun la empresa seleccionada.'
  end
  object bvl1: TBevel
    Left = 56
    Top = 152
    Width = 321
    Height = 41
  end
  object edtEmpresa: TBEdit
    Left = 108
    Top = 25
    Width = 45
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    MaxLength = 3
    TabOrder = 1
    OnChange = PonNombre
  end
  object stEmpresa: TStaticText
    Left = 170
    Top = 27
    Width = 221
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 2
  end
  object edtCentro: TBEdit
    Left = 108
    Top = 53
    Width = 45
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 3
    OnChange = PonNombre
  end
  object edtProducto: TBEdit
    Left = 108
    Top = 82
    Width = 45
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 5
    OnChange = PonNombre
  end
  object edtCliente: TBEdit
    Left = 108
    Top = 110
    Width = 45
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 7
    OnChange = PonNombre
  end
  object stCentro: TStaticText
    Left = 170
    Top = 55
    Width = 221
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 4
  end
  object stProducto: TStaticText
    Left = 170
    Top = 84
    Width = 221
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 6
  end
  object stCliente: TStaticText
    Left = 170
    Top = 112
    Width = 221
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 8
  end
  object RejillaFlotante: TBGrid
    Left = 407
    Top = 18
    Width = 137
    Height = 135
    Color = clInfoBk
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object ListaAcciones: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 168
    Top = 211
    object ADesplegarRejilla: TAction
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ADesplegarRejillaExecute
    end
  end
end
