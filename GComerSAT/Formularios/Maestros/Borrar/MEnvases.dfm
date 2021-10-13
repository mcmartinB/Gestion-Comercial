object FMEnvases: TFMEnvases
  Left = 158
  Top = 430
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  ENVASES'
  ClientHeight = 550
  ClientWidth = 800
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
    Width = 800
    Height = 550
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
      Top = 43
      Width = 108
      Height = 21
      AutoSize = False
      Caption = ' C'#243'digo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LPeso_envase_e: TLabel
      Left = 432
      Top = 117
      Width = 108
      Height = 21
      AutoSize = False
      Caption = ' Peso Envase'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LDescripcion_e: TLabel
      Left = 41
      Top = 68
      Width = 108
      Height = 21
      AutoSize = False
      Caption = ' Descripci'#243'n Breve'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblPeso: TLabel
      Left = 41
      Top = 142
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' Peso Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre1: TLabel
      Left = 432
      Top = 92
      Width = 108
      Height = 21
      AutoSize = False
      Caption = ' Agrupaci'#243'n Costes'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre3: TLabel
      Left = 399
      Top = 301
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Caja Cart'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre4: TLabel
      Left = 41
      Top = 167
      Width = 108
      Height = 21
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre5: TLabel
      Left = 432
      Top = 68
      Width = 108
      Height = 21
      AutoSize = False
      Caption = ' Descrip. Ingl'#233's'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre6: TLabel
      Left = 41
      Top = 18
      Width = 108
      Height = 21
      AutoSize = False
      Caption = ' Empresa '
      Layout = tlCenter
    end
    object BGBEmpresa_e: TBGridButton
      Left = 196
      Top = 19
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
      Left = 432
      Top = 18
      Width = 108
      Height = 21
      AutoSize = False
      Caption = ' Producto Base'
      Layout = tlCenter
    end
    object BGBproducto_base_e: TBGridButton
      Left = 735
      Top = 18
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
      Left = 567
      Top = 301
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' Fecha de Baja'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre9: TLabel
      Left = 399
      Top = 322
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Ver los Envases'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl1: TLabel
      Left = 39
      Top = 301
      Width = 108
      Height = 19
      Cursor = crAppStart
      AutoSize = False
      Caption = ' Precio Diario'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblTipIva: TLabel
      Left = 432
      Top = 47
      Width = 39
      Height = 13
      Caption = 'Tipo Iva'
    end
    object lblDesTipoIva: TLabel
      Left = 586
      Top = 47
      Width = 39
      Height = 13
      Caption = 'Tipo Iva'
    end
    object btnAgrupacion: TBGridButton
      Left = 629
      Top = 92
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
    object lblTipoCaja: TLabel
      Left = 41
      Top = 117
      Width = 108
      Height = 21
      AutoSize = False
      Caption = ' Tipo Caja'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnTipoCaja: TBGridButton
      Left = 237
      Top = 117
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
    object lblAgrupaComer: TLabel
      Left = 41
      Top = 92
      Width = 108
      Height = 21
      AutoSize = False
      Caption = ' Agrupaci'#243'n Comercial'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnAgrupaComer: TBGridButton
      Left = 344
      Top = 92
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
    object lblMaster_c: TLabel
      Left = 432
      Top = 141
      Width = 108
      Height = 21
      AutoSize = False
      Caption = ' Env.Maestro'
      Layout = tlCenter
    end
    object btnMaster_c: TBGridButton
      Left = 543
      Top = 142
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
      Control = master_e
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 280
      GridHeigth = 200
    end
    object cbxComercial: TComboBox
      Left = 492
      Top = 300
      Width = 67
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 20
      Items.Strings = (
        'Todos'
        'Carton'
        'No carton')
    end
    object GroupBox1: TGroupBox
      Left = 39
      Top = 227
      Width = 353
      Height = 69
      Caption = ' Unidades '
      TabOrder = 18
      object lblNombre10: TLabel
        Left = 16
        Top = 18
        Width = 73
        Height = 19
        AutoSize = False
        Caption = ' N'#186' Unidades'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lblNombre11: TLabel
        Left = 16
        Top = 40
        Width = 73
        Height = 19
        AutoSize = False
        Caption = ' Tipo Unidad'
        Layout = tlCenter
      end
      object BGBtipo_unidad_e: TBGridButton
        Left = 131
        Top = 38
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
        Top = 16
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
        Top = 38
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
        Top = 39
        Width = 197
        Height = 18
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 3
      end
      object unidades_variable_e: TDBCheckBox
        Left = 147
        Top = 18
        Width = 126
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
      Top = 43
      Width = 41
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 4
      DataField = 'envase_e'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object peso_envase_e: TBDEdit
      Left = 544
      Top = 117
      Width = 46
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 3
      ShowDecimals = True
      MaxLength = 7
      TabOrder = 11
      DataField = 'peso_envase_e'
      DataSource = DSMaestro
    end
    object descripcion_e: TBDEdit
      Tag = 1
      Left = 154
      Top = 68
      Width = 271
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 6
      DataField = 'descripcion_e'
      DataSource = DSMaestro
    end
    object peso_neto_e: TBDEdit
      Left = 151
      Top = 141
      Width = 46
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 3
      ShowDecimals = True
      MaxLength = 7
      TabOrder = 13
      DataField = 'peso_neto_e'
      DataSource = DSMaestro
    end
    object agrupacion_e: TBDEdit
      Left = 544
      Top = 92
      Width = 81
      Height = 21
      ColorEdit = clMoneyGreen
      ReadOnly = True
      TabOrder = 9
      DataField = 'agrupacion_e'
      DataSource = DSMaestro
    end
    object envase_comercial_e: TDBCheckBox
      Left = 492
      Top = 302
      Width = 17
      Height = 17
      Color = clBtnFace
      DataField = 'envase_comercial_e'
      DataSource = DSMaestro
      ParentColor = False
      TabOrder = 23
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnEnter = envase_comercial_eEnter
      OnExit = envase_comercial_eExit
    end
    object notas_e: TDBMemo
      Left = 151
      Top = 166
      Width = 596
      Height = 60
      DataField = 'notas_e'
      DataSource = DSMaestro
      TabOrder = 17
      WordWrap = False
      OnEnter = notas_eEnter
      OnExit = notas_eExit
    end
    object GroupBox2: TGroupBox
      Left = 399
      Top = 227
      Width = 353
      Height = 69
      Caption = ' Envase Comercial '
      TabOrder = 19
      object lblNombre12: TLabel
        Left = 16
        Top = 21
        Width = 55
        Height = 19
        AutoSize = False
        Caption = 'Operador'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object btnEnvComerOperador: TBGridButton
        Left = 129
        Top = 20
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
        Left = 129
        Top = 43
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
        Left = 16
        Top = 44
        Width = 55
        Height = 19
        AutoSize = False
        Caption = 'Envase'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object env_comer_operador_e: TBDEdit
        Left = 74
        Top = 20
        Width = 35
        Height = 21
        ColorEdit = clMoneyGreen
        MaxLength = 3
        TabOrder = 0
        OnChange = PonNombre
        DataField = 'env_comer_operador_e'
        DataSource = DSMaestro
      end
      object env_comer_producto_e: TBDEdit
        Left = 74
        Top = 43
        Width = 52
        Height = 21
        ColorEdit = clMoneyGreen
        MaxLength = 5
        TabOrder = 2
        OnChange = PonNombre
        DataField = 'env_comer_producto_e'
        DataSource = DSMaestro
      end
      object des_env_comer: TStaticText
        Left = 143
        Top = 44
        Width = 201
        Height = 18
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 3
      end
      object txtOperador: TStaticText
        Left = 143
        Top = 22
        Width = 201
        Height = 18
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 1
      end
    end
    object descripcion2_e: TBDEdit
      Tag = 1
      Left = 544
      Top = 68
      Width = 204
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 7
      DataField = 'descripcion2_e'
      DataSource = DSMaestro
    end
    object empresa_e: TBDEdit
      Left = 153
      Top = 18
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
      Top = 18
      Width = 16
      Height = 21
      TabStop = False
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
      Top = 20
      Width = 215
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 3
    end
    object descripcion_pb: TBDEdit
      Left = 544
      Top = 18
      Width = 190
      Height = 21
      ColorEdit = clMoneyGreen
      ReadOnly = True
      TabOrder = 1
      Modificable = False
    end
    object fecha_baja_e: TBDEdit
      Left = 680
      Top = 300
      Width = 73
      Height = 21
      InputType = itDate
      TabOrder = 21
      DataField = 'fecha_baja_e'
      DataSource = DSMaestro
    end
    object cbxVer: TComboBox
      Left = 492
      Top = 321
      Width = 67
      Height = 21
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 24
      Text = 'Todos'
      Items.Strings = (
        'Todos'
        'De alta'
        'De baja')
    end
    object peso_variable_e: TDBCheckBox
      Left = 201
      Top = 143
      Width = 97
      Height = 17
      AllowGrayed = True
      Caption = 'Peso Variable'
      DataField = 'peso_variable_e'
      DataSource = DSMaestro
      TabOrder = 15
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object precio_diario_e: TDBCheckBox
      Left = 152
      Top = 302
      Width = 241
      Height = 17
      Caption = 'Marcar si queremos introducir su precio diario.'
      DataField = 'precio_diario_e'
      DataSource = DSMaestro
      TabOrder = 22
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object tipo_iva_e: TDBComboBox
      Left = 544
      Top = 43
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
      OnChange = tipo_iva_eChange
    end
    object tipo_caja_e: TBDEdit
      Left = 153
      Top = 117
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
      Left = 252
      Top = 118
      Width = 174
      Height = 18
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 12
    end
    object agrupa_comercial_e: TBDEdit
      Left = 153
      Top = 92
      Width = 189
      Height = 21
      ColorEdit = clMoneyGreen
      ReadOnly = True
      MaxLength = 30
      TabOrder = 8
      DataField = 'agrupa_comercial_e'
      DataSource = DSMaestro
    end
    object master_e: TBDEdit
      Left = 544
      Top = 141
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
      Top = 143
      Width = 158
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 16
    end
  end
  object pnlEnvaseCliente: TPanel
    Left = 182
    Top = 321
    Width = 174
    Height = 25
    Cursor = crHandPoint
    Caption = 'Descripci'#243'n Cliente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = EnvaseClienteClick
  end
  object pgcControl: TPageControl
    Left = 18
    Top = 346
    Width = 767
    Height = 186
    ActivePage = tsEan13
    MultiLine = True
    TabOrder = 4
    TabPosition = tpLeft
    object tsEan13: TTabSheet
      Caption = 'Ean13'
      object dbgEan13: TDBGrid
        Left = 0
        Top = 0
        Width = 740
        Height = 178
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
    object tsClientes: TTabSheet
      Caption = 'Clientes'
      ImageIndex = 1
      object dbgClientes: TDBGrid
        Left = 0
        Top = 0
        Width = 289
        Height = 178
        TabStop = False
        Align = alClient
        DataSource = DSClientes
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
    object tsImagen: TTabSheet
      Caption = 'Imagen'
      ImageIndex = 2
      object Bevel1: TBevel
        Left = 113
        Top = 3
        Width = 176
        Height = 173
      end
      object Image: TImage
        Left = 115
        Top = 5
        Width = 174
        Height = 171
        Center = True
        Proportional = True
        Stretch = True
      end
    end
  end
  object RejillaFlotante: TBGrid
    Left = 781
    Top = 62
    Width = 113
    Height = 124
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
    Left = 39
    Top = 321
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
    OnStateChange = DSMaestroStateChange
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
  object QEan13: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 320
    Top = 368
  end
  object DSEan13: TDataSource
    DataSet = QEan13
    Left = 352
    Top = 368
  end
  object QClientes: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'SELECT * FROM frf_envases'
      'ORDER BY envase_e, descripcion_e')
    Left = 320
    Top = 400
  end
  object DSClientes: TDataSource
    DataSet = QClientes
    Left = 352
    Top = 400
  end
end
