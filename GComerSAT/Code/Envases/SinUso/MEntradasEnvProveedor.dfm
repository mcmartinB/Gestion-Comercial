object FMEntradasEnvProveedor: TFMEntradasEnvProveedor
  Left = 440
  Top = 247
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    ENTRADAS/SALIDAS MATERIAL PROVEEDOR'
  ClientHeight = 336
  ClientWidth = 533
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
  object pnlMaestro: TPanel
    Left = 0
    Top = 0
    Width = 533
    Height = 336
    Align = alClient
    TabOrder = 0
    object lblNombre12: TLabel
      Left = 46
      Top = 167
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Operador'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnOperador: TBGridButton
      Left = 181
      Top = 166
      Width = 14
      Height = 21
      Action = ARejillaFlotante
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
      Control = cod_operador_em
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 180
      GridHeigth = 160
    end
    object btnEnvase: TBGridButton
      Left = 181
      Top = 191
      Width = 14
      Height = 21
      Action = ARejillaFlotante
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
      Control = cod_producto_em
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 120
    end
    object lblEnvase: TLabel
      Left = 46
      Top = 192
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Envase'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl3: TLabel
      Left = 46
      Top = 216
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Entrada'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNota: TLabel
      Left = 46
      Top = 145
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Alb.Proveedor'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl4: TLabel
      Left = 46
      Top = 266
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Observaci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblSalida: TLabel
      Left = 46
      Top = 241
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Salida'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblEmpresa: TLabel
      Left = 46
      Top = 47
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblCentro: TLabel
      Left = 46
      Top = 71
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Centro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnEmpresa: TBGridButton
      Left = 181
      Top = 46
      Width = 14
      Height = 21
      Action = ARejillaFlotante
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
      Control = empresa_em
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 180
      GridHeigth = 160
    end
    object btnCentro: TBGridButton
      Left = 181
      Top = 70
      Width = 14
      Height = 21
      Action = ARejillaFlotante
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
      Control = centro_em
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 120
    end
    object lblProveedor: TLabel
      Left = 46
      Top = 96
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Proveedor'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnProveedor: TBGridButton
      Left = 181
      Top = 95
      Width = 14
      Height = 21
      Action = ARejillaFlotante
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
      Control = cod_proveedor_em
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 180
      GridHeigth = 160
    end
    object lbl2: TLabel
      Left = 46
      Top = 121
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Fecha Carga'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 22
      Top = 12
      Width = 486
      Height = 13
      Caption = 
        'NOTA: Estos datos se pueden grabar en el mantenimiento de entreg' +
        'as de proveedor, pesta'#241'a Material.'
    end
    object btnFecha: TBCalendarButton
      Left = 209
      Top = 121
      Width = 17
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
        FF00FF00FF007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
        7F007F7F7F007F7F7F007F7F7F007F7F7F00FF00FF00FF00FF00FF00FF00FF00
        FF0000000000000000007F000000000000007F0000007F000000000000007F00
        000000000000000000007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
        FF00FFFFFF00000000000000000000000000FFFFFF0000000000000000000000
        0000BFBFBF00FFFFFF007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
        FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00BFBFBF00FFFFFF00BFBF
        BF0000000000FFFFFF007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
        FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0000000000FFFFFF007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
        FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000
        0000BFBFBF00FFFFFF007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
        FF00FFFFFF000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
        FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000
        000000000000FFFFFF007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
        FF00FFFFFF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
        BF00BFBFBF00FFFFFF007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
        FF00000000000000000000000000000000000000000000000000000000000000
        00000000000000000000FF00FF00FF00FF00FF00FF007F7F7F00}
      Control = fecha_em
      Calendar = CalendarioFlotante
      CalendarAlignment = taDownLeft
      CalendarWidth = 197
      CalendarHeigth = 145
    end
    object btnAlbaran: TBGridButton
      Left = 223
      Top = 144
      Width = 14
      Height = 21
      Action = ARejillaFlotante
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
      Control = codigo_em
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 180
      GridHeigth = 160
    end
    object cod_operador_em: TBDEdit
      Left = 128
      Top = 166
      Width = 36
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 8
      OnChange = PonNombre
      DataField = 'cod_operador_em'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object txtOperador: TStaticText
      Left = 195
      Top = 168
      Width = 285
      Height = 18
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 9
    end
    object txtEnvase: TStaticText
      Left = 195
      Top = 193
      Width = 285
      Height = 18
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 11
    end
    object cod_producto_em: TBDEdit
      Left = 128
      Top = 191
      Width = 51
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 5
      TabOrder = 10
      OnChange = PonNombre
      DataField = 'cod_producto_em'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object entrada_em: TBDEdit
      Left = 128
      Top = 215
      Width = 48
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itInteger
      MaxLength = 6
      TabOrder = 12
      DataField = 'entrada_em'
      DataSource = DSMaestro
    end
    object codigo_em: TBDEdit
      Left = 128
      Top = 144
      Width = 93
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 12
      TabOrder = 7
      OnChange = PonNombre
      OnExit = codigo_emExit
      DataField = 'codigo_em'
      DataSource = DSMaestro
      Modificable = False
    end
    object notas_em: TBDEdit
      Left = 128
      Top = 265
      Width = 246
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 14
      OnChange = PonNombre
      DataField = 'notas_em'
      DataSource = DSMaestro
    end
    object salida_em: TBDEdit
      Left = 128
      Top = 240
      Width = 48
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itInteger
      MaxLength = 6
      TabOrder = 13
      DataField = 'salida_em'
      DataSource = DSMaestro
    end
    object empresa_em: TBDEdit
      Left = 128
      Top = 46
      Width = 36
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = PonNombre
      DataField = 'empresa_em'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object centro_em: TBDEdit
      Left = 128
      Top = 70
      Width = 51
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 5
      TabOrder = 2
      OnChange = PonNombre
      DataField = 'centro_em'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object txtEmpresa: TStaticText
      Left = 195
      Top = 48
      Width = 285
      Height = 18
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object txtCentro: TStaticText
      Left = 195
      Top = 72
      Width = 285
      Height = 18
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 3
    end
    object cod_proveedor_em: TBDEdit
      Left = 128
      Top = 95
      Width = 36
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 4
      OnChange = PonNombre
      DataField = 'cod_proveedor_em'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object txtProveedor: TStaticText
      Left = 195
      Top = 97
      Width = 285
      Height = 18
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 5
    end
    object fecha_em: TBDEdit
      Left = 128
      Top = 120
      Width = 78
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'La fecha de la salida es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itDate
      MaxLength = 10
      TabOrder = 6
      OnChange = PonNombre
      DataField = 'fecha_em'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
  end
  object RejillaFlotante: TBGrid
    Left = 511
    Top = 185
    Width = 42
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
  object CalendarioFlotante: TBCalendario
    Left = 506
    Top = 31
    Width = 177
    Height = 136
    AutoSize = True
    Date = 36748.6618043056
    ShowToday = False
    TabOrder = 1
    Visible = False
    WeekNumbers = True
  end
  object ACosecheros: TActionList
    Left = 359
    Top = 30
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object DSMaestro: TDataSource
    DataSet = QAjustes
    Left = 327
    Top = 38
  end
  object QAjustes: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 288
    Top = 40
  end
end
