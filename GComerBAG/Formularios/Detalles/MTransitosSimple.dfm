object FMTransitosSimple: TFMTransitosSimple
  Left = 380
  Top = 233
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  TR'#193'NSITOS'
  ClientHeight = 671
  ClientWidth = 975
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PTenerife: TPanel
    Left = 0
    Top = 325
    Width = 975
    Height = 126
    Align = alTop
    BevelInner = bvLowered
    Enabled = False
    TabOrder = 2
    Visible = False
    object BGBCategoria_tl: TBGridButton
      Left = 657
      Top = 40
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BGBCategoria_tlClick
      Control = categoria_tl
      Grid = RejillaFlotante
      GridAlignment = taDownLeft
      GridWidth = 280
      GridHeigth = 200
    end
    object Label7: TLabel
      Left = 24
      Top = 41
      Width = 85
      Height = 19
      AutoSize = False
      Caption = ' Marca'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label9: TLabel
      Left = 541
      Top = 41
      Width = 85
      Height = 19
      AutoSize = False
      Caption = ' Categor'#237'a'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label10: TLabel
      Left = 541
      Top = 66
      Width = 85
      Height = 19
      AutoSize = False
      Caption = ' Color'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object nom_gg: TLabel
      Left = 24
      Top = 66
      Width = 85
      Height = 19
      AutoSize = False
      Caption = ' Calibre'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label13: TLabel
      Left = 24
      Top = 16
      Width = 85
      Height = 19
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label14: TLabel
      Left = 541
      Top = 15
      Width = 85
      Height = 20
      AutoSize = False
      Caption = ' Art'#237'culo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBColor_tl: TBGridButton
      Left = 647
      Top = 65
      Width = 13
      Height = 21
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
      OnClick = BGBColor_tlClick
      Control = color_tl
      Grid = RejillaFlotante
      GridAlignment = taDownLeft
      GridWidth = 230
      GridHeigth = 200
    end
    object BGBProducto_tl: TBGridButton
      Left = 144
      Top = 15
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BGBProducto_tlClick
      Control = producto_tl
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object BGBMarca_tl: TBGridButton
      Left = 137
      Top = 40
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BGBMarca_tlClick
      Control = marca_tl
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object Label29: TLabel
      Left = 27
      Top = 91
      Width = 68
      Height = 19
      AutoSize = False
      Caption = ' Kilos'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBCalibre_tl: TBGridButton
      Left = 168
      Top = 65
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BGBCalibre_tlClick
      Control = calibre_tl
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object Label16: TLabel
      Left = 677
      Top = 92
      Width = 60
      Height = 19
      AutoSize = False
      Caption = ' Tipo Palet'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBTipoPalet: TBGridButton
      Left = 763
      Top = 91
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BGBTipoPaletClick
      Control = tipo_palet_tl
      Grid = RejillaFlotante
      GridAlignment = taDownLeft
      GridWidth = 280
      GridHeigth = 200
    end
    object Label17: TLabel
      Left = 543
      Top = 92
      Width = 85
      Height = 19
      AutoSize = False
      Caption = ' Palets'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label15: TLabel
      Left = 196
      Top = 66
      Width = 68
      Height = 19
      AutoSize = False
      Caption = ' Unds. caja'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label18: TLabel
      Left = 196
      Top = 91
      Width = 68
      Height = 19
      AutoSize = False
      Caption = ' Precio'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label11: TLabel
      Left = 348
      Top = 67
      Width = 85
      Height = 19
      AutoSize = False
      Caption = ' Cajas'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label19: TLabel
      Left = 348
      Top = 91
      Width = 68
      Height = 19
      AutoSize = False
      Caption = ' Importe'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object nomColorT: TStaticText
      Left = 677
      Top = 67
      Width = 275
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 13
    end
    object nomCategoriaT: TStaticText
      Left = 677
      Top = 42
      Width = 275
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 8
    end
    object nomMarcaT: TStaticText
      Left = 152
      Top = 42
      Width = 218
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 7
    end
    object nomEnvaseT: TStaticText
      Left = 732
      Top = 17
      Width = 220
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 4
    end
    object nomProductoT: TStaticText
      Left = 158
      Top = 17
      Width = 212
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object producto_tl: TBDEdit
      Left = 113
      Top = 15
      Width = 30
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = producto_tlChange
      DataField = 'producto_tl'
      DataSource = DSDetalle2
    end
    object marca_tl: TBDEdit
      Left = 113
      Top = 40
      Width = 22
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 2
      TabOrder = 5
      OnChange = marca_tlChange
      DataField = 'marca_tl'
      DataSource = DSDetalle2
    end
    object color_tl: TBDEdit
      Left = 630
      Top = 65
      Width = 14
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 1
      TabOrder = 12
      OnChange = color_tlChange
      DataField = 'color_tl'
      DataSource = DSDetalle2
    end
    object categoria_tl: TBDEdit
      Left = 630
      Top = 40
      Width = 22
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 2
      TabOrder = 6
      OnChange = categoria_tlChange
      DataField = 'categoria_tl'
      DataSource = DSDetalle2
    end
    object calibre_tl: TBDEdit
      Left = 113
      Top = 65
      Width = 54
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      CharCase = ecNormal
      MaxLength = 6
      TabOrder = 9
      DataField = 'calibre_tl'
      DataSource = DSDetalle2
    end
    object kilos_tl: TBDEdit
      Left = 113
      Top = 90
      Width = 78
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 8
      TabOrder = 14
      OnChange = kilos_tlChange
      DataField = 'kilos_tl'
      DataSource = DSDetalle2
    end
    object tipo_palet_tl: TBDEdit
      Left = 739
      Top = 91
      Width = 22
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 2
      TabOrder = 18
      OnChange = tipo_palet_tlChange
      DataField = 'tipo_palet_tl'
      DataSource = DSDetalle2
    end
    object stTipo_palet_tl: TStaticText
      Left = 776
      Top = 93
      Width = 176
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 19
    end
    object palets_tl: TBDEdit
      Left = 630
      Top = 91
      Width = 34
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 2
      TabOrder = 17
      OnChange = marca_tlChange
      DataField = 'palets_tl'
      DataSource = DSDetalle2
    end
    object unidades_caja_tl: TBDEdit
      Left = 270
      Top = 65
      Width = 29
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      InputType = itInteger
      MaxLength = 3
      TabOrder = 10
      DataField = 'unidades_caja_tl'
      DataSource = DSDetalle
    end
    object envase_tl: TcxDBTextEdit
      Left = 630
      Top = 15
      DataBinding.DataField = 'envase_tl'
      DataBinding.DataSource = DSDetalle2
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 9
      Properties.OnChange = envase_tlChange
      Style.BorderStyle = ebs3D
      Style.LookAndFeel.Kind = lfUltraFlat
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.Kind = lfUltraFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.Kind = lfUltraFlat
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.Kind = lfUltraFlat
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 2
      OnExit = envase_tlExit
      Width = 75
    end
    object ssEnvase: TSimpleSearch
      Left = 704
      Top = 15
      Width = 21
      Height = 21
      Hint = 'B'#250'squeda de Art'#237'culo'
      TabOrder = 3
      TabStop = False
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'MoneyTwins'
      OptionsImage.ImageIndex = 2
      OptionsImage.Images = FDM.ilxImagenes
      Titulo = 'Busqueda de Art'#237'culos'
      Tabla = 'frf_envases'
      Campos = <
        item
          Etiqueta = 'Art'#237'culo'
          Campo = 'envase_e'
          Ancho = 100
          Tipo = ctCadena
        end
        item
          Etiqueta = 'Descripci'#243'n'
          Campo = 'descripcion_e'
          Ancho = 400
          Tipo = ctCadena
        end>
      Database = 'BDProyecto'
      Join = 'fecha_baja_e is null'
      CampoResultado = 'envase_e'
      Enlace = envase_tl
      Tecla = 'F2'
      AntesEjecutar = ssEnvaseAntesEjecutar
      Concatenar = False
    end
    object precio_tl: TBDEdit
      Left = 271
      Top = 90
      Width = 58
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itReal
      MaxDecimals = 3
      MaxLength = 8
      TabOrder = 15
      OnChange = precio_tlChange
      DataField = 'precio_tl'
      DataSource = DSDetalle2
    end
    object cajas_tl: TBDEdit
      Left = 438
      Top = 66
      Width = 67
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itInteger
      MaxLength = 5
      TabOrder = 11
      OnChange = cajas_tlChange
      DataField = 'cajas_tl'
      DataSource = DSDetalle2
    end
    object importe_linea_tl: TBDEdit
      Left = 438
      Top = 90
      Width = 78
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itReal
      MaxDecimals = 2
      Enabled = False
      MaxLength = 8
      TabOrder = 16
      DataField = 'importe_linea_tl'
      DataSource = DSDetalle2
      Modificable = False
    end
  end
  object PRejilla: TPanel
    Left = 0
    Top = 451
    Width = 975
    Height = 220
    Align = alClient
    TabOrder = 3
    object RVisualizacion: TDBGrid
      Left = 1
      Top = 1
      Width = 973
      Height = 218
      TabStop = False
      Align = alClient
      DataSource = DSDetalle
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = RVisualizacionDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'producto_tl'
          Title.Caption = 'Producto'
          Width = 46
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'envase_tl'
          Title.Caption = 'Envase'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'desEnvase'
          Title.Caption = 'Descripci'#243'n'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'marca_tl'
          Title.Caption = 'Marca'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'categoria_tl'
          Title.Caption = 'Categoria'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'color_tl'
          Title.Caption = 'Color'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'calibre_tl'
          Title.Caption = 'Calibre'
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'unidades_caja_tl'
          Title.Alignment = taCenter
          Title.Caption = 'Und/Caj'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cajas_tl'
          Title.Alignment = taCenter
          Title.Caption = 'Cajas'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'kilos_tl'
          Title.Alignment = taCenter
          Title.Caption = 'Kilos'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'precio_tl'
          Title.Alignment = taCenter
          Title.Caption = 'Precio'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'importe_linea_tl'
          Title.Alignment = taCenter
          Title.Caption = 'Importe'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'palets_tl'
          Title.Alignment = taCenter
          Title.Caption = 'Palets'
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'tipo_palet_tl'
          Title.Alignment = taCenter
          Title.Caption = 'Tipo Palet'
          Visible = True
        end>
    end
  end
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 975
    Height = 325
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    BevelWidth = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LEmpresa_p: TLabel
      Left = 503
      Top = 71
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Centro Origen'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 49
      Top = 49
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa_tc: TBGridButton
      Left = 168
      Top = 47
      Width = 13
      Height = 22
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
      OnClick = BGBEmpresa_tcClick
      Control = empresa_tc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object Label3: TLabel
      Left = 656
      Top = 49
      Width = 92
      Height = 19
      AutoSize = False
      Caption = 'Fecha/Hora Salida'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 49
      Top = 116
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Transporte'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 49
      Top = 139
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Matricula'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBCentro_tc: TBGridButton
      Left = 607
      Top = 70
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BGBCentro_tcClick
      Control = centro_tc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object BGBTransporte_tc: TBGridButton
      Left = 167
      Top = 115
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BGBTransporte_tcClick
      Control = transporte_tc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object BCBCalendario: TBCalendarButton
      Left = 816
      Top = 48
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BCBCalendarioClick
      Control = fecha_tc
      Calendar = Calendario
      CalendarAlignment = taDownLeft
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object Referencia: TLabel
      Left = 503
      Top = 49
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Referencia'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 503
      Top = 116
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Buque'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 49
      Top = 161
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Puerto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label20: TLabel
      Left = 503
      Top = 93
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Centro Destino'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBCentro_destino_tc: TBGridButton
      Left = 607
      Top = 92
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BGBCentro_destino_tcClick
      Control = centro_destino_tc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object Label24: TLabel
      Left = 503
      Top = 161
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Transporte Bonnysa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label12: TLabel
      Left = 27
      Top = 210
      Width = 137
      Height = 19
      AutoSize = False
      Caption = ' Observaciones'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNumCMR: TLabel
      Left = 27
      Top = 232
      Width = 46
      Height = 19
      AutoSize = False
      Caption = ' CMR'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label8: TLabel
      Left = 656
      Top = 161
      Width = 92
      Height = 19
      AutoSize = False
      Caption = ' Fecha Entrada'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BCalendarButton1: TBCalendarButton
      Left = 816
      Top = 160
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BCBCalendarioClick
      Control = fecha_entrada_tc
      Calendar = Calendario
      CalendarAlignment = taDownLeft
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object BGBpuerto_tc: TBGridButton
      Left = 153
      Top = 160
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BGBpuerto_tcClick
      Control = puerto_tc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object lblNombre1: TLabel
      Left = 503
      Top = 139
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Destino'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblplanta_origen_tc: TLabel
      Left = 49
      Top = 71
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Planta Origen'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnplanta_origen_tc: TBGridButton
      Left = 168
      Top = 69
      Width = 13
      Height = 22
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
      OnClick = btnplanta_origen_tcClick
      Control = planta_origen_tc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object lblplanta_destino_tc: TLabel
      Left = 49
      Top = 93
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Planta Destino'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnplanta_destino_tc: TBGridButton
      Left = 168
      Top = 91
      Width = 13
      Height = 22
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
      OnClick = btnplanta_destino_tcClick
      Control = planta_destino_tc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object lblOrden: TLabel
      Left = 27
      Top = 256
      Width = 46
      Height = 19
      AutoSize = False
      Caption = ' Orden'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblStatus: TLabel
      Left = 27
      Top = 281
      Width = 46
      Height = 13
      Caption = ' STATUS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object lbl6: TLabel
      Left = 12
      Top = 184
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Cond. Pago (Incoterm)'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBincoterm_c: TBGridButton
      Left = 168
      Top = 182
      Width = 13
      Height = 22
      Hint = 'Pulse F2 para ver una lista de valores validos. '
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
      OnClick = BGBincoterm_cClick
      Control = incoterm_tc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object lbl7: TLabel
      Left = 507
      Top = 184
      Width = 75
      Height = 19
      AutoSize = False
      Caption = ' Plaza Entrega'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl4: TLabel
      Left = 502
      Top = 300
      Width = 108
      Height = 16
      AutoSize = False
      Caption = ' Precio Palet Plastico'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl5: TLabel
      Left = 698
      Top = 300
      Width = 99
      Height = 16
      AutoSize = False
      Caption = ' Precio Caja Platico'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object cbx_porte_bonny_tc: TComboBox
      Left = 583
      Top = 160
      Width = 72
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 19
      Visible = False
      OnKeyDown = cbx_porte_bonny_tcKeyDown
      Items.Strings = (
        'Todos'
        'Si'
        'No')
    end
    object centro_tc: TBDEdit
      Tag = 1
      Left = 583
      Top = 70
      Width = 22
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 1
      TabOrder = 6
      OnChange = centro_tcChange
      DataField = 'centro_tc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object centro_destino_tc: TBDEdit
      Tag = 1
      Left = 583
      Top = 92
      Width = 22
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 1
      TabOrder = 10
      OnChange = centro_destino_tcChange
      DataField = 'centro_destino_tc'
      DataSource = DSMaestro
    end
    object empresa_tc: TBDEdit
      Tag = 1
      Left = 129
      Top = 48
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = empresa_tcChange
      DataField = 'empresa_tc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object STEmpresa_tc: TStaticText
      Left = 184
      Top = 50
      Width = 230
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 4
    end
    object STCentro_tc: TStaticText
      Left = 623
      Top = 72
      Width = 245
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 8
    end
    object fecha_tc: TBDEdit
      Left = 748
      Top = 48
      Width = 67
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itDate
      TabOrder = 2
      DataField = 'fecha_tc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object transporte_tc: TBDEdit
      Left = 129
      Top = 115
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 13
      OnChange = transporte_tcChange
      DataField = 'transporte_tc'
      DataSource = DSMaestro
    end
    object vehiculo_tc: TBDEdit
      Left = 129
      Top = 138
      Width = 286
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 20
      TabOrder = 16
      DataField = 'vehiculo_tc'
      DataSource = DSMaestro
    end
    object STTransporte_tc: TStaticText
      Left = 183
      Top = 116
      Width = 231
      Height = 19
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 15
    end
    object referencia_tc: TBDEdit
      Left = 583
      Top = 48
      Width = 73
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itInteger
      MaxLength = 6
      TabOrder = 1
      DataField = 'referencia_tc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object buque_tc: TBDEdit
      Left = 583
      Top = 115
      Width = 286
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 14
      DataField = 'buque_tc'
      DataSource = DSMaestro
    end
    object destino_tc: TBDEdit
      Left = 583
      Top = 138
      Width = 286
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 17
      DataField = 'destino_tc'
      DataSource = DSMaestro
    end
    object STCentro_destino_tc: TStaticText
      Left = 623
      Top = 94
      Width = 245
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 12
    end
    object porte_bonny_tc: TDBCheckBox
      Left = 583
      Top = 161
      Width = 19
      Height = 17
      Caption = 'porte_bonny_tc'
      DataField = 'porte_bonny_tc'
      DataSource = DSMaestro
      TabOrder = 22
      ValueChecked = '1'
      ValueUnchecked = '0'
      OnEnter = porte_bonny_tcEnter
      OnExit = porte_bonny_tcExit
    end
    object nota_tc: TDBMemo
      Left = 168
      Top = 210
      Width = 695
      Height = 84
      Color = clWhite
      DataField = 'nota_tc'
      DataSource = DSMaestro
      TabOrder = 27
      OnEnter = nota_tcEnter
      OnExit = nota_tcExit
    end
    object n_cmr_tc: TBDEdit
      Left = 67
      Top = 231
      Width = 98
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itInteger
      MaxLength = 10
      TabOrder = 28
      DataField = 'n_cmr_tc'
      DataSource = DSMaestro
    end
    object fecha_entrada_tc: TBDEdit
      Left = 748
      Top = 160
      Width = 67
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itDate
      TabOrder = 20
      DataField = 'fecha_entrada_tc'
      DataSource = DSMaestro
    end
    object puerto_tc: TBDEdit
      Tag = 1
      Left = 129
      Top = 160
      Width = 22
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itInteger
      MaxLength = 1
      TabOrder = 18
      OnChange = puerto_tcChange
      DataField = 'puerto_tc'
      DataSource = DSMaestro
    end
    object stPuerto_tc: TStaticText
      Left = 169
      Top = 162
      Width = 245
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 23
    end
    object planta_origen_tc: TBDEdit
      Tag = 1
      Left = 129
      Top = 70
      Width = 38
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de planta origen es de obligada inserci'#243'n.'
      OnRequiredTime = empresa_tcRequiredTime
      ReadOnly = True
      MaxLength = 3
      TabOrder = 5
      OnChange = planta_origen_tcChange
      DataField = 'planta_origen_tc'
      DataSource = DSMaestro
      Modificable = False
    end
    object stplanta_origen_tc: TStaticText
      Left = 184
      Top = 72
      Width = 230
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 7
    end
    object planta_destino_tc: TBDEdit
      Tag = 1
      Left = 129
      Top = 92
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de la planta destino es de obligada inserci'#243'n.'
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 3
      TabOrder = 9
      OnChange = planta_destino_tcChange
      DataField = 'planta_destino_tc'
      DataSource = DSMaestro
    end
    object stplanta_destino_tc: TStaticText
      Left = 184
      Top = 94
      Width = 230
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 11
    end
    object n_orden_tc: TBDEdit
      Left = 67
      Top = 255
      Width = 98
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itInteger
      MaxLength = 10
      TabOrder = 29
      DataField = 'n_orden_tc'
      DataSource = DSMaestro
    end
    object hora_tc: TBDEdit
      Left = 829
      Top = 48
      Width = 39
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itHour
      MaxLength = 5
      TabOrder = 3
      DataField = 'hora_tc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object hora_entrada_tc: TBDEdit
      Left = 829
      Top = 160
      Width = 39
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itInteger
      MaxLength = 5
      TabOrder = 21
      DataField = 'hora_entrada_tc'
      DataSource = DSMaestro
      Modificable = False
    end
    object incoterm_tc: TBDEdit
      Left = 129
      Top = 183
      Width = 37
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 3
      TabOrder = 24
      OnChange = incoterm_tcChange
      DataField = 'incoterm_tc'
      DataSource = DSMaestro
    end
    object stIncoterm: TStaticText
      Left = 184
      Top = 185
      Width = 230
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 25
    end
    object plaza_incoterm_tc: TBDEdit
      Left = 583
      Top = 183
      Width = 135
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 26
      DataField = 'plaza_incoterm_tc'
      DataSource = DSMaestro
    end
    object precio_palet_plas_tc: TBDEdit
      Left = 611
      Top = 298
      Width = 67
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itReal
      MaxDecimals = 3
      MaxLength = 5
      TabOrder = 30
      OnChange = cajas_tlChange
      DataField = 'precio_palet_plas_tc'
      DataSource = DSMaestro
    end
    object precio_caja_plas_tc: TBDEdit
      Left = 797
      Top = 298
      Width = 67
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itReal
      MaxDecimals = 3
      MaxLength = 5
      TabOrder = 31
      OnChange = cajas_tlChange
      DataField = 'precio_caja_plas_tc'
      DataSource = DSMaestro
    end
  end
  object pnlBotones: TPanel
    Left = 688
    Top = 12
    Width = 176
    Height = 26
    TabOrder = 1
    object btnGastos: TSpeedButton
      Left = -1
      Top = 2
      Width = 85
      Height = 21
      Caption = 'Ver &Gastos'
      OnClick = btnGastosClick
    end
    object btnActivar: TSpeedButton
      Left = 90
      Top = 2
      Width = 85
      Height = 21
      Caption = 'Activar'
      OnClick = btnActivarClick
    end
  end
  object Calendario: TBCalendario
    Left = 583
    Top = 466
    Width = 182
    Height = 158
    Date = 36864.622104351850000000
    TabOrder = 4
    Visible = False
    WeekNumbers = True
    BControl = fecha_tc
  end
  object RejillaFlotante: TBGrid
    Left = 733
    Top = 490
    Width = 41
    Height = 57
    Color = clInfoBk
    DataSource = DMBaseDatos.DSQDespegables
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object DSDetalle: TDataSource
    DataSet = TTransitosL
    Left = 80
    Top = 424
  end
  object TTransitosL: TTable
    BeforeInsert = TTransitosLBeforeEdit
    BeforeEdit = TTransitosLBeforeEdit
    BeforePost = TTransitosLBeforePost
    OnCalcFields = TTransitosLCalcFields
    OnNewRecord = TTransitosLNewRecord
    DatabaseName = 'BDProyecto'
    IndexFieldNames = 'empresa_tl;centro_tl;referencia_tl;fecha_tl'
    MasterFields = 'empresa_tc;centro_tc;referencia_tc;fecha_tc'
    MasterSource = DSMaestro
    TableName = 'frf_transitos_l'
    Left = 8
    Top = 424
    object TTransitosLempresa_tl: TStringField
      FieldName = 'empresa_tl'
      FixedChar = True
      Size = 3
    end
    object TTransitosLcentro_tl: TStringField
      FieldName = 'centro_tl'
      FixedChar = True
      Size = 1
    end
    object TTransitosLreferencia_tl: TIntegerField
      FieldName = 'referencia_tl'
    end
    object TTransitosLfecha_tl: TDateField
      FieldName = 'fecha_tl'
    end
    object TTransitosLcentro_destino_tl: TStringField
      FieldName = 'centro_destino_tl'
      FixedChar = True
      Size = 1
    end
    object TTransitosLcentro_origen_tl: TStringField
      FieldName = 'centro_origen_tl'
      FixedChar = True
      Size = 1
    end
    object TTransitosLref_origen_tl: TIntegerField
      FieldName = 'ref_origen_tl'
    end
    object TTransitosLfecha_origen_tl: TDateField
      FieldName = 'fecha_origen_tl'
    end
    object TTransitosLproducto_tl: TStringField
      FieldName = 'producto_tl'
      FixedChar = True
      Size = 3
    end
    object TTransitosLenvase_tl: TStringField
      FieldName = 'envase_tl'
      FixedChar = True
      Size = 9
    end
    object TTransitosLenvaseold_tl: TStringField
      FieldName = 'envaseold_tl'
      FixedChar = True
      Size = 3
    end
    object TTransitosLmarca_tl: TStringField
      FieldName = 'marca_tl'
      FixedChar = True
      Size = 2
    end
    object TTransitosLcategoria_tl: TStringField
      FieldName = 'categoria_tl'
      FixedChar = True
      Size = 2
    end
    object TTransitosLcolor_tl: TStringField
      FieldName = 'color_tl'
      FixedChar = True
      Size = 1
    end
    object TTransitosLcalibre_tl: TStringField
      FieldName = 'calibre_tl'
      FixedChar = True
      Size = 10
    end
    object TTransitosLunidades_caja_tl: TIntegerField
      FieldName = 'unidades_caja_tl'
    end
    object TTransitosLcajas_tl: TIntegerField
      FieldName = 'cajas_tl'
    end
    object TTransitosLkilos_tl: TFloatField
      FieldName = 'kilos_tl'
    end
    object TTransitosLprecio_tl: TFloatField
      FieldName = 'precio_tl'
    end
    object TTransitosLimporte_linea_tl: TCurrencyField
      FieldName = 'importe_linea_tl'
      currency = False
    end
    object TTransitosLfederacion_tl: TStringField
      FieldName = 'federacion_tl'
      FixedChar = True
      Size = 1
    end
    object TTransitosLcosechero_tl: TSmallintField
      FieldName = 'cosechero_tl'
    end
    object TTransitosLplantacion_tl: TSmallintField
      FieldName = 'plantacion_tl'
    end
    object TTransitosLanyo_semana_tl: TStringField
      FieldName = 'anyo_semana_tl'
      FixedChar = True
      Size = 6
    end
    object TTransitosLtipo_palet_tl: TStringField
      FieldName = 'tipo_palet_tl'
      FixedChar = True
      Size = 2
    end
    object TTransitosLpalets_tl: TIntegerField
      FieldName = 'palets_tl'
    end
    object TTransitosLdesEnvase: TStringField
      FieldKind = fkCalculated
      FieldName = 'desEnvase'
      Calculated = True
    end
  end
  object QTransitosC: TQuery
    AfterOpen = QTransitosCAfterOpen
    BeforePost = QTransitosCBeforePost
    AfterPost = QTransitosCAfterPost
    AfterScroll = QTransitosCAfterScroll
    OnNewRecord = QTransitosCNewRecord
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_transitos_c'
      'ORDER BY empresa_tc')
    Left = 8
    Top = 8
  end
  object DSMaestro: TDataSource
    DataSet = QTransitosC
    Left = 40
    Top = 8
  end
  object DSDetalle2: TDataSource
    Left = 40
    Top = 425
  end
end
