object FMEnvases: TFMEnvases
  Left = 787
  Top = 132
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  ENVASES'
  ClientHeight = 627
  ClientWidth = 819
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
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 819
    Height = 627
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LEnvase_e: TLabel
      Left = 41
      Top = 55
      Width = 108
      Height = 17
      AutoSize = False
      Caption = ' C'#243'digo'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object LPeso_envase_e: TLabel
      Left = 433
      Top = 170
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' Peso Envase'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object LDescripcion_e: TLabel
      Left = 41
      Top = 78
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n Breve'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object lblPeso: TLabel
      Left = 41
      Top = 170
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' Peso Neto Producto'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre1: TLabel
      Left = 41
      Top = 101
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' Agrupaci'#243'n Costes'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre3: TLabel
      Left = 407
      Top = 329
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' Caja Cart'#243'n'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre4: TLabel
      Left = 41
      Top = 193
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre5: TLabel
      Left = 433
      Top = 78
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' Descrip. Ingl'#233's'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre6: TLabel
      Left = 41
      Top = 32
      Width = 108
      Height = 17
      AutoSize = False
      Caption = ' Empresa '
      Layout = tlCenter
    end
    object BGBEmpresa_e: TBGridButton
      Left = 196
      Top = 31
      Width = 13
      Height = 19
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
      Control = empresa_e
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 280
      GridHeigth = 200
    end
    object lblNombre7: TLabel
      Left = 433
      Top = 31
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' Producto Base'
      Layout = tlCenter
    end
    object BGBproducto_base_e: TBGridButton
      Left = 568
      Top = 30
      Width = 13
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
      Control = producto_base_e
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 280
      GridHeigth = 200
    end
    object lblNombre8: TLabel
      Left = 575
      Top = 329
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' Fecha de Baja'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre9: TLabel
      Left = 575
      Top = 350
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' Ver los Envases'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object lblEan13: TLabel
      Left = 39
      Top = 329
      Width = 108
      Height = 19
      Cursor = crAppStart
      AutoSize = False
      Caption = ' C'#243'digo EAN13'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object btnEan13_e: TBGridButton
      Left = 241
      Top = 329
      Width = 13
      Height = 19
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
      Control = ean13_e
      Grid = RejillaFlotante
      GridAlignment = taUpCenter
      GridWidth = 280
      GridHeigth = 200
    end
    object lbl1: TLabel
      Left = 39
      Top = 350
      Width = 108
      Height = 19
      Cursor = crAppStart
      AutoSize = False
      Caption = ' Precio Diario'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object lblTipIva: TLabel
      Left = 433
      Top = 57
      Width = 39
      Height = 13
      Caption = 'Tipo Iva'
    end
    object lblDesTipoIva: TLabel
      Left = 588
      Top = 57
      Width = 39
      Height = 13
      Caption = 'Tipo Iva'
    end
    object btnAgrupacion: TBGridButton
      Left = 414
      Top = 100
      Width = 13
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
      Control = agrupacion_e
      Grid = RejillaFlotante
      GridAlignment = taDownLeft
      GridWidth = 100
      GridHeigth = 200
    end
    object lbl3: TLabel
      Left = 41
      Top = 147
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' Linea Producto'
      Layout = tlCenter
    end
    object btnLinea_producto_e: TBGridButton
      Left = 196
      Top = 146
      Width = 13
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
      Control = linea_producto_e
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 280
      GridHeigth = 200
    end
    object lblTipoEnvase: TLabel
      Left = 433
      Top = 127
      Width = 63
      Height = 13
      Caption = ' Tipo Envase'
    end
    object lblDesTipoEnvase: TLabel
      Left = 594
      Top = 127
      Width = 46
      Height = 13
      Caption = 'NORMAL'
    end
    object lblAgrupaComer: TLabel
      Left = 433
      Top = 100
      Width = 108
      Height = 21
      AutoSize = False
      Caption = ' Agrupaci'#243'n Comercial'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object btnAgrupaComer: TBGridButton
      Left = 748
      Top = 100
      Width = 13
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
      Control = agrupa_comercial_e
      Grid = RejillaFlotante
      GridAlignment = taDownLeft
      GridWidth = 100
      GridHeigth = 200
    end
    object lblTipoCaja: TLabel
      Left = 41
      Top = 123
      Width = 108
      Height = 21
      AutoSize = False
      Caption = ' Tipo Caja'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object btnTipoCaja: TBGridButton
      Left = 238
      Top = 123
      Width = 13
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
      Control = tipo_caja_e
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 280
      GridHeigth = 200
    end
    object lblMaster_c: TLabel
      Left = 432
      Top = 146
      Width = 108
      Height = 21
      AutoSize = False
      Caption = ' Env.Maestro'
      Layout = tlCenter
    end
    object cbxComercial: TComboBox
      Left = 500
      Top = 328
      Width = 67
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 24
      Items.Strings = (
        'Todos'
        'Comercial'
        'No comercial')
    end
    object GroupBox1: TGroupBox
      Left = 39
      Top = 255
      Width = 353
      Height = 71
      Caption = ' Unidades '
      TabOrder = 21
      object lblNombre10: TLabel
        Left = 16
        Top = 20
        Width = 73
        Height = 19
        AutoSize = False
        Caption = ' N'#186' Unidades'
        Color = clBtnFace
        ParentColor = False
        Layout = tlCenter
      end
      object lblNombre11: TLabel
        Left = 16
        Top = 43
        Width = 73
        Height = 19
        AutoSize = False
        Caption = ' Tipo Unidad'
        Layout = tlCenter
      end
      object BGBtipo_unidad_e: TBGridButton
        Left = 131
        Top = 42
        Width = 13
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
        Control = tipo_unidad_e
        Grid = RejillaFlotante
        GridAlignment = taDownRight
        GridWidth = 280
        GridHeigth = 200
      end
      object unidades_e: TBDEdit
        Left = 88
        Top = 19
        Width = 46
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itInteger
        TabOrder = 0
        DataField = 'unidades_e'
        DataSource = DSMaestro
      end
      object tipo_unidad_e: TBDEdit
        Left = 88
        Top = 42
        Width = 41
        Height = 21
        ColorEdit = clMoneyGreen
        MaxLength = 3
        TabOrder = 2
        OnChange = PonNombre
        DataField = 'tipo_unidad_e'
        DataSource = DSMaestro
      end
      object STTipo_unidad_e: TStaticText
        Left = 147
        Top = 43
        Width = 197
        Height = 18
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 3
      end
      object unidades_variable_e: TDBCheckBox
        Left = 147
        Top = 21
        Width = 97
        Height = 17
        AllowGrayed = True
        Caption = 'Unidades Variable'
        DataField = 'unidades_variable_e'
        DataSource = DSMaestro
        TabOrder = 1
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
    end
    object envase_e: TBDEdit
      Left = 153
      Top = 53
      Width = 41
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 4
      OnExit = envase_eExit
      DataField = 'envase_e'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object peso_envase_e: TBDEdit
      Left = 545
      Top = 169
      Width = 46
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 3
      ShowDecimals = True
      MaxLength = 7
      TabOrder = 18
      DataField = 'peso_envase_e'
      DataSource = DSMaestro
    end
    object descripcion_e: TBDEdit
      Tag = 1
      Left = 153
      Top = 77
      Width = 274
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 6
      OnEnter = descripcion_eEnter
      DataField = 'descripcion_e'
      DataSource = DSMaestro
    end
    object peso_neto_e: TBDEdit
      Left = 152
      Top = 169
      Width = 46
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 3
      ShowDecimals = True
      MaxLength = 7
      TabOrder = 17
      DataField = 'peso_neto_e'
      DataSource = DSMaestro
    end
    object agrupacion_e: TBDEdit
      Left = 153
      Top = 100
      Width = 259
      Height = 21
      ColorEdit = clMoneyGreen
      ReadOnly = True
      TabOrder = 8
      DataField = 'agrupacion_e'
      DataSource = DSMaestro
    end
    object envase_comercial_e: TDBCheckBox
      Left = 500
      Top = 328
      Width = 17
      Height = 17
      Color = clBtnFace
      DataField = 'envase_comercial_e'
      DataSource = DSMaestro
      ParentColor = False
      TabOrder = 25
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnEnter = envase_comercial_eEnter
      OnExit = envase_comercial_eExit
    end
    object notas_e: TDBMemo
      Left = 153
      Top = 192
      Width = 608
      Height = 60
      DataField = 'notas_e'
      DataSource = DSMaestro
      TabOrder = 20
      WordWrap = False
      OnEnter = notas_eEnter
      OnExit = notas_eExit
    end
    object GroupBox2: TGroupBox
      Left = 408
      Top = 255
      Width = 353
      Height = 71
      Caption = ' Envase Retornable '
      TabOrder = 22
      object lbl2: TLabel
        Left = 13
        Top = 20
        Width = 55
        Height = 19
        AutoSize = False
        Caption = 'Operador'
        Color = clBtnFace
        ParentColor = False
        Layout = tlCenter
      end
      object btnEnvComerOperador: TBGridButton
        Left = 126
        Top = 19
        Width = 13
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
        Control = env_comer_operador_e
        Grid = RejillaFlotante
        GridAlignment = taDownLeft
        GridWidth = 220
        GridHeigth = 140
      end
      object btnEnvComerProducto: TBGridButton
        Left = 126
        Top = 42
        Width = 13
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
        Control = env_comer_producto_e
        Grid = RejillaFlotante
        GridAlignment = taDownLeft
        GridWidth = 220
        GridHeigth = 120
      end
      object lblEnvase: TLabel
        Left = 13
        Top = 43
        Width = 55
        Height = 19
        AutoSize = False
        Caption = 'Envase'
        Color = clBtnFace
        ParentColor = False
        Layout = tlCenter
      end
      object env_comer_operador_e: TBDEdit
        Left = 71
        Top = 19
        Width = 35
        Height = 21
        ColorEdit = clMoneyGreen
        MaxLength = 3
        TabOrder = 0
        OnChange = PonNombre
        DataField = 'env_comer_operador_e'
        DataSource = DSMaestro
      end
      object txtOperador: TStaticText
        Left = 140
        Top = 21
        Width = 201
        Height = 18
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 1
      end
      object txt_env_comer: TStaticText
        Left = 140
        Top = 44
        Width = 201
        Height = 18
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 3
      end
      object env_comer_producto_e: TBDEdit
        Left = 71
        Top = 42
        Width = 52
        Height = 21
        ColorEdit = clMoneyGreen
        MaxLength = 5
        TabOrder = 2
        OnChange = PonNombre
        DataField = 'env_comer_producto_e'
        DataSource = DSMaestro
      end
    end
    object descripcion2_e: TBDEdit
      Tag = 1
      Left = 544
      Top = 77
      Width = 217
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 7
      DataField = 'descripcion2_e'
      DataSource = DSMaestro
    end
    object empresa_e: TBDEdit
      Left = 153
      Top = 31
      Width = 41
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 3
      TabOrder = 0
      OnChange = PonNombre
      DataField = 'empresa_e'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object producto_base_e: TBDEdit
      Left = 545
      Top = 31
      Width = 21
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itInteger
      MaxLength = 2
      TabOrder = 2
      OnChange = producto_base_eChange
      DataField = 'producto_base_e'
      DataSource = DSMaestro
      Modificable = False
    end
    object STEmpresa_e: TStaticText
      Left = 212
      Top = 31
      Width = 215
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object fecha_baja_e: TBDEdit
      Left = 688
      Top = 328
      Width = 73
      Height = 21
      InputType = itDate
      TabOrder = 26
      DataField = 'fecha_baja_e'
      DataSource = DSMaestro
    end
    object cbxVer: TComboBox
      Left = 688
      Top = 351
      Width = 73
      Height = 21
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 28
      Text = 'Todos'
      Items.Strings = (
        'Todos'
        'De alta'
        'De baja')
    end
    object peso_variable_e: TDBCheckBox
      Left = 201
      Top = 171
      Width = 97
      Height = 17
      AllowGrayed = True
      Caption = 'Peso Variable'
      DataField = 'peso_variable_e'
      DataSource = DSMaestro
      TabOrder = 19
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object ean13_e: TBDEdit
      Left = 151
      Top = 328
      Width = 90
      Height = 21
      Cursor = crAppStart
      ColorEdit = clMoneyGreen
      MaxLength = 13
      TabOrder = 23
      DataField = 'ean13_e'
      DataSource = DSMaestro
    end
    object precio_diario_e: TDBCheckBox
      Left = 152
      Top = 351
      Width = 240
      Height = 17
      Caption = 'Marcar si queremos introducir su precio diario.'
      DataField = 'precio_diario_e'
      DataSource = DSMaestro
      TabOrder = 27
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object tipo_iva_e: TDBComboBox
      Left = 545
      Top = 53
      Width = 38
      Height = 21
      Style = csDropDownList
      DataField = 'tipo_iva_e'
      DataSource = DSMaestro
      ItemHeight = 13
      Items.Strings = (
        '0'
        '1'
        '2')
      TabOrder = 5
    end
    object des_producto_base_e: TStaticText
      Left = 584
      Top = 32
      Width = 177
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 3
    end
    object linea_producto_e: TBDEdit
      Left = 153
      Top = 146
      Width = 41
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      MaxLength = 2
      TabOrder = 13
      OnChange = linea_producto_eChange
      DataField = 'linea_producto_e'
      DataSource = DSMaestro
    end
    object des_linea_producto_e: TStaticText
      Left = 212
      Top = 148
      Width = 215
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 15
    end
    object tipo_e: TDBComboBox
      Left = 544
      Top = 123
      Width = 46
      Height = 21
      Style = csDropDownList
      DataField = 'tipo_e'
      DataSource = DSMaestro
      ItemHeight = 13
      Items.Strings = (
        '0'
        '1'
        '2')
      TabOrder = 11
      OnChange = tipo_eChange
    end
    object agrupa_comercial_e: TBDEdit
      Left = 544
      Top = 100
      Width = 201
      Height = 21
      ColorEdit = clMoneyGreen
      ReadOnly = True
      MaxLength = 30
      TabOrder = 9
      DataField = 'agrupa_comercial_e'
      DataSource = DSMaestro
    end
    object tipo_caja_e: TBDEdit
      Left = 153
      Top = 123
      Width = 81
      Height = 21
      ColorEdit = clMoneyGreen
      ReadOnly = True
      MaxLength = 9
      TabOrder = 10
      OnChange = PonNombre
      DataField = 'tipo_caja_e'
      DataSource = DSMaestro
    end
    object des_tipo_caja: TStaticText
      Left = 256
      Top = 124
      Width = 171
      Height = 18
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 12
    end
    object master_e: TBDEdit
      Left = 544
      Top = 146
      Width = 41
      Height = 21
      Hint = 'Envase maestro del grupo de envases compatibles.'
      TabStop = False
      ColorEdit = clMoneyGreen
      MaxLength = 3
      ShowHint = True
      TabOrder = 14
      OnChange = PonNombre
      DataField = 'master_e'
      DataSource = DSMaestro
    end
    object txtMaster_c: TStaticText
      Left = 589
      Top = 148
      Width = 158
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 16
    end
  end
  object pgcDetalle: TPageControl
    Left = 16
    Top = 411
    Width = 785
    Height = 201
    ActivePage = tsDescripcionCliente
    TabHeight = 15
    TabOrder = 3
    TabWidth = 70
    object tsDescripcionCliente: TTabSheet
      Caption = 'Des.Cliente'
      object btnEnvaseCliente: TPanel
        Left = 1
        Top = 1
        Width = 270
        Height = 24
        Cursor = crHandPoint
        Caption = 'Descripci'#243'n Cliente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = EnvaseClienteClick
      end
      object dbgDesCliente: TDBGrid
        Left = 0
        Top = 27
        Width = 777
        Height = 149
        Align = alBottom
        DataSource = dsDesCliente
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'cliente'
            Title.Caption = 'Cliente'
            Width = 240
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'unidad'
            Title.Alignment = taCenter
            Title.Caption = 'Und.Fact.'
            Width = 67
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descripcion'
            Title.Caption = 'Descripci'#243'n'
            Width = 185
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'caducidad'
            Title.Alignment = taRightJustify
            Title.Caption = 'Caducidad'
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'min_vida'
            Title.Alignment = taRightJustify
            Title.Caption = 'Min. Vida'
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'max_vida'
            Title.Alignment = taRightJustify
            Title.Caption = 'Max. Vida'
            Visible = True
          end>
      end
    end
    object tsSeccionContable: TTabSheet
      Caption = 'Sec. Contable'
      ImageIndex = 1
      object pnlSeccionContable: TPanel
        Left = 1
        Top = 1
        Width = 270
        Height = 24
        Cursor = crHandPoint
        Caption = 'Secciones Contables'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = pnlSeccionContableClick
      end
      object dbgSeccionContable: TDBGrid
        Left = 0
        Top = 27
        Width = 777
        Height = 149
        Align = alBottom
        DataSource = dsSecContable
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'centro'
            Title.Caption = 'Centro'
            Width = 23
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'seccion'
            Title.Caption = 'Secci'#243'n'
            Width = 69
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descripcion'
            Title.Caption = 'Descripci'#243'n'
            Width = 117
            Visible = True
          end>
      end
    end
    object tsEcoembes: TTabSheet
      Caption = 'Ecoembes'
      ImageIndex = 2
      object pnlEcoembes: TPanel
        Left = 1
        Top = 1
        Width = 270
        Height = 24
        Cursor = crHandPoint
        Caption = 'Ecoembes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = pnlEcoembesClick
      end
      object dbgrdEcoembes: TDBGrid
        Left = 0
        Top = 27
        Width = 777
        Height = 149
        Align = alBottom
        DataSource = dsEcoembes
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'centro'
            Title.Caption = 'Centro'
            Width = 23
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'seccion'
            Title.Caption = 'Secci'#243'n'
            Width = 69
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descripcion'
            Title.Caption = 'Descripci'#243'n'
            Width = 117
            Visible = True
          end>
      end
    end
    object tsImagen: TTabSheet
      Caption = 'Imagen'
      ImageIndex = 2
      object Image: TImage
        Left = 1
        Top = 2
        Width = 174
        Height = 169
        Center = True
        Proportional = True
        Stretch = True
      end
      object bvl1: TBevel
        Left = 0
        Top = 0
        Width = 176
        Height = 170
      end
    end
    object tsEan13: TTabSheet
      Caption = 'Ean13'
      ImageIndex = 4
      object dbgEan13: TDBGrid
        Left = 0
        Top = 0
        Width = 777
        Height = 176
        TabStop = False
        Align = alClient
        DataSource = DSEan13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
  end
  object RejillaFlotante: TBGrid
    Left = 763
    Top = 163
    Width = 113
    Height = 49
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
  end
  object pnlPasarSGP: TPanel
    Left = 16
    Top = 381
    Width = 139
    Height = 25
    Cursor = crHandPoint
    Caption = 'Pasar al SGP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = pnlPasarSGPClick
  end
  object DSMaestro: TDataSource
    DataSet = QEnvases
    OnDataChange = DSMaestroDataChange
    Left = 152
    Top = 8
  end
  object ACosecheros: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 216
    Top = 8
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
    object ACampos: TAction
      Caption = 'Mantenimiento de Campos (F3)'
      ImageIndex = 3
      ShortCut = 114
    end
  end
  object QEnvases: TQuery
    AfterOpen = QEnvasesAfterOpen
    BeforeClose = QEnvasesBeforeClose
    AfterPost = QEnvasesAfterPost
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 120
    Top = 8
  end
  object QEnvasesCliente: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 256
    Top = 8
  end
  object qryDesCliente: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 384
    Top = 424
  end
  object dsDesCliente: TDataSource
    DataSet = qryDesCliente
    OnDataChange = DSMaestroDataChange
    Left = 416
    Top = 424
  end
  object qrySecContable: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 384
    Top = 456
  end
  object dsSecContable: TDataSource
    DataSet = qrySecContable
    OnDataChange = DSMaestroDataChange
    Left = 416
    Top = 456
  end
  object qryEcoembes: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 384
    Top = 490
  end
  object dsEcoembes: TDataSource
    DataSet = qryEcoembes
    OnDataChange = DSMaestroDataChange
    Left = 416
    Top = 490
  end
  object QEan13: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 384
    Top = 528
  end
  object DSEan13: TDataSource
    DataSet = QEan13
    Left = 416
    Top = 528
  end
end
