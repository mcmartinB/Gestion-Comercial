object FMProductos: TFMProductos
  Left = 343
  Top = 193
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  PRODUCTOS'
  ClientHeight = 583
  ClientWidth = 519
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 519
    Height = 356
    Align = alTop
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Lproducto_p: TLabel
      Left = 40
      Top = 33
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Ldescripcion_p: TLabel
      Left = 40
      Top = 86
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Ingles'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblEsTomate: TLabel
      Left = 272
      Top = 130
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Es Tomate'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblAleman: TLabel
      Left = 40
      Top = 109
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Alem'#225'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl2: TLabel
      Left = 40
      Top = 131
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Es Hortaliza'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre8: TLabel
      Left = 250
      Top = 156
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Fecha de Baja'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre9: TLabel
      Left = 246
      Top = 179
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Ver los Productos'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre1: TLabel
      Left = 231
      Top = 199
      Width = 105
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Area  '
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object btnArea: TBGridButton
      Left = 443
      Top = 197
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
      Control = area_p
      Grid = RejillaFlotante
      GridAlignment = taDownLeft
      GridWidth = 150
      GridHeigth = 100
    end
    object producto_p: TBDEdit
      Tag = 1
      Left = 134
      Top = 32
      Width = 35
      Height = 21
      Hint = 'Introduce el c'#243'digo del producto.'
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo de producto es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      DataField = 'producto_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object descripcion_p: TBDEdit
      Tag = 1
      Left = 184
      Top = 32
      Width = 232
      Height = 21
      Hint = 'Introduce la descripci'#243'n del producto.'
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'La descripci'#243'n del producto es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 1
      DataField = 'descripcion_p'
      DataSource = DSMaestro
    end
    object descripcion2_p: TBDEdit
      Left = 184
      Top = 85
      Width = 232
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 2
      DataField = 'descripcion2_p'
      DataSource = DSMaestro
    end
    object estomate_p: TDBCheckBox
      Left = 366
      Top = 132
      Width = 94
      Height = 17
      Caption = 'NO'
      DataField = 'estomate_p'
      DataSource = DSMaestro
      TabOrder = 5
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = estomate_pClick
    end
    object des_aleman_p: TBDEdit
      Left = 184
      Top = 108
      Width = 232
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 3
      DataField = 'des_aleman_p'
      DataSource = DSMaestro
    end
    object eshortaliza_p: TDBCheckBox
      Left = 135
      Top = 132
      Width = 90
      Height = 17
      Caption = 'No, es fruta'
      DataField = 'eshortaliza_p'
      DataSource = DSMaestro
      TabOrder = 4
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = eshortaliza_pClick
    end
    object pnlCostesAyudas: TPanel
      Left = 2
      Top = 230
      Width = 515
      Height = 124
      Align = alBottom
      TabOrder = 12
      object bvl1: TBevel
        Left = 35
        Top = 56
        Width = 387
        Height = 54
      end
      object lbl3: TLabel
        Left = 38
        Top = 21
        Width = 90
        Height = 19
        AutoSize = False
        Caption = ' Coste Prod. Peninsula'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lbl4: TLabel
        Left = 270
        Top = 21
        Width = 90
        Height = 19
        AutoSize = False
        Caption = ' Coste Prod. Tenerife'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lbl5: TLabel
        Left = 38
        Top = 6
        Width = 329
        Height = 13
        Caption = 
          'Los costes de producir en campo un kg de producto comercial 1'#170' y' +
          ' 2'#170
      end
      object lblEurKiloLocal: TLabel
        Left = 134
        Top = 86
        Width = 87
        Height = 19
        AutoSize = False
        Caption = ' Eur/kg'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lblporcentajeLocal: TLabel
        Left = 277
        Top = 86
        Width = 87
        Height = 19
        AutoSize = False
        Caption = ' % Importe venta'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lbl6: TLabel
        Left = 40
        Top = 64
        Width = 90
        Height = 19
        AutoSize = False
        Caption = ' Mercado Local'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lbl7: TLabel
        Left = 45
        Top = 46
        Width = 77
        Height = 13
        Caption = 'Ayudas Tenerife'
      end
      object lblEurKgExporta: TLabel
        Left = 40
        Top = 86
        Width = 90
        Height = 19
        AutoSize = False
        Caption = ' Tr'#225'nsitos/Exporta'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lbl9: TLabel
        Left = 134
        Top = 64
        Width = 87
        Height = 19
        AutoSize = False
        Caption = ' Eur/kg'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lbl10: TLabel
        Left = 276
        Top = 64
        Width = 87
        Height = 19
        AutoSize = False
        Caption = ' % Importe venta'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lbl8: TLabel
        Left = 187
        Top = 24
        Width = 33
        Height = 13
        Caption = 'Eur/kg'
      end
      object lbl11: TLabel
        Left = 425
        Top = 24
        Width = 33
        Height = 13
        Caption = 'Eur/kg'
      end
      object coste_peninsula_p: TBDEdit
        Tag = 1
        Left = 133
        Top = 20
        Width = 50
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
        OnRequiredTime = RequiredTime
        InputType = itReal
        MaxDecimals = 4
        MaxLength = 6
        TabOrder = 0
        DataField = 'coste_peninsula_p'
        DataSource = DSMaestro
      end
      object coste_tenerife_p: TBDEdit
        Tag = 1
        Left = 364
        Top = 20
        Width = 50
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
        OnRequiredTime = RequiredTime
        InputType = itReal
        MaxDecimals = 4
        MaxLength = 6
        TabOrder = 1
        DataField = 'coste_tenerife_p'
        DataSource = DSMaestro
      end
      object eur_kilo_tenerife_p: TBDEdit
        Tag = 1
        Left = 226
        Top = 63
        Width = 50
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
        OnRequiredTime = RequiredTime
        InputType = itReal
        MaxDecimals = 4
        MaxLength = 6
        TabOrder = 2
        DataField = 'eur_kilo_tenerife_p'
        DataSource = DSMaestro
      end
      object porcen_importe_tenerife_p: TBDEdit
        Tag = 1
        Left = 366
        Top = 63
        Width = 50
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
        OnRequiredTime = RequiredTime
        InputType = itReal
        MaxDecimals = 4
        MaxLength = 6
        TabOrder = 3
        DataField = 'porcen_importe_tenerife_p'
        DataSource = DSMaestro
      end
      object eur_kilo_transito_p: TBDEdit
        Tag = 1
        Left = 226
        Top = 85
        Width = 50
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
        OnRequiredTime = RequiredTime
        InputType = itReal
        MaxDecimals = 4
        MaxLength = 6
        TabOrder = 4
        DataField = 'eur_kilo_transito_p'
        DataSource = DSMaestro
      end
      object porcen_importe_transito_p: TBDEdit
        Tag = 1
        Left = 366
        Top = 85
        Width = 50
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
        OnRequiredTime = RequiredTime
        InputType = itReal
        MaxDecimals = 4
        MaxLength = 6
        TabOrder = 5
        DataField = 'porcen_importe_transito_p'
        DataSource = DSMaestro
      end
    end
    object fecha_baja_p: TBDEdit
      Left = 342
      Top = 155
      Width = 73
      Height = 21
      InputType = itDate
      TabOrder = 6
      DataField = 'fecha_baja_p'
      DataSource = DSMaestro
    end
    object cbxVer: TComboBox
      Left = 342
      Top = 177
      Width = 73
      Height = 21
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 8
      Text = 'Todos'
      Items.Strings = (
        'Todos'
        'De alta'
        'De baja')
    end
    object tipo_compra_p: TDBCheckBox
      Left = 42
      Top = 161
      Width = 167
      Height = 17
      Caption = 'Producto de Compra'
      DataField = 'tipo_compra_p'
      DataSource = DSMaestro
      TabOrder = 7
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object tipo_venta_p: TDBCheckBox
      Left = 42
      Top = 181
      Width = 167
      Height = 17
      Caption = 'Producto de Venta'
      DataField = 'tipo_venta_p'
      DataSource = DSMaestro
      TabOrder = 9
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object producto_desglose_p: TDBCheckBox
      Left = 42
      Top = 201
      Width = 167
      Height = 17
      Caption = 'Producto con Desglose'
      DataField = 'producto_desglose_p'
      DataSource = DSMaestro
      TabOrder = 10
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object area_p: TBDEdit
      Left = 342
      Top = 198
      Width = 100
      Height = 21
      ColorEdit = clMoneyGreen
      ReadOnly = True
      TabOrder = 11
      DataField = 'area_p'
      DataSource = DSMaestro
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 356
    Width = 519
    Height = 227
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 3
    OnChange = PageControlChange
    object tsCategorias: TTabSheet
      Caption = 'Categor'#237'as'
      object PCategorias: TPanel
        Left = 0
        Top = 0
        Width = 511
        Height = 57
        Align = alTop
        TabOrder = 0
        Visible = False
        object Label1: TLabel
          Left = 12
          Top = 20
          Width = 95
          Height = 19
          AutoSize = False
          Caption = ' C'#243'digo / Nombre'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object categoria_c: TBDEdit
          Left = 111
          Top = 19
          Width = 30
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 2
          TabOrder = 0
          DataField = 'categoria_c'
          DataSource = DSCategorias
          Modificable = False
          PrimaryKey = True
        end
        object descripcion_c: TBDEdit
          Left = 144
          Top = 19
          Width = 209
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 30
          TabOrder = 1
          DataField = 'descripcion_c'
          DataSource = DSCategorias
        end
      end
      object RCategorias: TDBGrid
        Left = 0
        Top = 57
        Width = 511
        Height = 142
        Align = alClient
        DataSource = DSCategorias
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
    object tsCalibres: TTabSheet
      Caption = 'Calibres'
      ImageIndex = 1
      object RCalibres: TDBGrid
        Left = 0
        Top = 65
        Width = 511
        Height = 134
        Align = alClient
        DataSource = DSCalibres
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object PCalibres: TPanel
        Left = 0
        Top = 0
        Width = 511
        Height = 65
        Align = alTop
        TabOrder = 0
        Visible = False
        object lblCalibre: TLabel
          Left = 12
          Top = 20
          Width = 95
          Height = 19
          AutoSize = False
          Caption = ' C'#243'digo '
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object calibre_c: TBDEdit
          Left = 113
          Top = 19
          Width = 68
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          CharCase = ecNormal
          MaxLength = 8
          TabOrder = 0
          DataField = 'calibre_c'
          DataSource = DSCalibres
          Modificable = False
          PrimaryKey = True
        end
      end
    end
    object tsColores: TTabSheet
      Caption = 'Colores'
      ImageIndex = 2
      object PColores: TPanel
        Left = 0
        Top = 0
        Width = 511
        Height = 57
        Align = alTop
        TabOrder = 0
        Visible = False
        object Label2: TLabel
          Left = 12
          Top = 20
          Width = 95
          Height = 19
          AutoSize = False
          Caption = ' C'#243'digo / Nombre'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object color_c: TBDEdit
          Left = 112
          Top = 19
          Width = 30
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 2
          TabOrder = 0
          DataField = 'color_c'
          DataSource = DSColores
          Modificable = False
          PrimaryKey = True
        end
        object BDEdit2: TBDEdit
          Left = 145
          Top = 19
          Width = 209
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 30
          TabOrder = 1
          DataField = 'descripcion_c'
          DataSource = DSColores
        end
      end
      object RColores: TDBGrid
        Left = 0
        Top = 57
        Width = 511
        Height = 142
        Align = alClient
        DataSource = DSColores
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
    object tsPaises: TTabSheet
      Caption = 'Pa'#237'ses'
      ImageIndex = 3
      object PPaises: TPanel
        Left = 0
        Top = 0
        Width = 511
        Height = 65
        Align = alTop
        TabOrder = 0
        Visible = False
        object Label3: TLabel
          Left = 12
          Top = 20
          Width = 95
          Height = 19
          AutoSize = False
          Caption = ' C'#243'digo '
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object btnpais: TBGridButton
          Left = 142
          Top = 19
          Width = 13
          Height = 22
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
          Control = pais_psp
          Grid = RejillaFlotante
          GridAlignment = taDownCenter
          GridWidth = 230
          GridHeigth = 200
        end
        object pais_psp: TBDEdit
          Left = 110
          Top = 19
          Width = 31
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 2
          TabOrder = 0
          OnChange = pais_pspChange
          DataField = 'pais_psp'
          DataSource = dsPaises
          Modificable = False
          PrimaryKey = True
        end
        object stPais: TStaticText
          Left = 157
          Top = 20
          Width = 244
          Height = 21
          AutoSize = False
          BorderStyle = sbsSunken
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
      end
      object RPaises: TDBGrid
        Left = 0
        Top = 65
        Width = 511
        Height = 134
        Align = alClient
        DataSource = dsPaises
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
    object tsVariedadCampo: TTabSheet
      Caption = 'Variedad Campo'
      ImageIndex = 4
      object PVariedadCampo: TPanel
        Left = 0
        Top = 0
        Width = 511
        Height = 57
        Align = alTop
        TabOrder = 0
        Visible = False
        object Label4: TLabel
          Left = 12
          Top = 20
          Width = 95
          Height = 19
          AutoSize = False
          Caption = ' C'#243'digo / Nombre'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object codigo_pv: TBDEdit
          Left = 110
          Top = 19
          Width = 30
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 2
          TabOrder = 0
          DataField = 'codigo_pv'
          DataSource = dsVariedadCampo
          Modificable = False
          PrimaryKey = True
        end
        object descripcion_pv: TBDEdit
          Left = 143
          Top = 19
          Width = 209
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 30
          TabOrder = 1
          DataField = 'descripcion_pv'
          DataSource = dsVariedadCampo
        end
      end
      object RVariedadCampo: TDBGrid
        Left = 0
        Top = 57
        Width = 511
        Height = 142
        Align = alClient
        DataSource = dsVariedadCampo
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
    object tsCostes: TTabSheet
      Caption = 'Costes Agrupaci'#243'n'
      ImageIndex = 6
      object dbgrdCostes: TDBGrid
        Left = 0
        Top = 43
        Width = 511
        Height = 156
        TabStop = False
        Align = alClient
        DataSource = dsCostesProducto
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object pnlCostes: TPanel
        Left = 0
        Top = 0
        Width = 511
        Height = 43
        Align = alTop
        TabOrder = 0
      end
      object btnCostes: TButton
        Left = 433
        Top = 3
        Width = 75
        Height = 36
        Caption = 'Costes'
        TabOrder = 1
        OnClick = btnCostesClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Comerciales'
      ImageIndex = 6
      object DBGrid1: TDBGrid
        Left = 0
        Top = 41
        Width = 511
        Height = 158
        TabStop = False
        Align = alClient
        DataSource = dsComercial
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'cod_comercial_cc'
            Title.Caption = 'Comercial'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'des_comercial'
            Title.Caption = 'Descripcion'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cod_cliente_cc'
            Title.Caption = 'Cliente'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cod_producto_cc'
            Title.Caption = 'Producto'
            Visible = True
          end>
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 511
        Height = 41
        Align = alTop
        TabOrder = 1
        object btnComercial: TBitBtn
          Left = 333
          Top = 8
          Width = 130
          Height = 27
          Caption = 'Mant. comerciales'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          TabStop = False
          OnClick = btnComercialClick
        end
      end
    end
  end
  object RejillaFlotante: TBGrid
    Left = 440
    Top = 29
    Width = 73
    Height = 97
    Color = clInfoBk
    DataSource = DMBaseDatos.DSQGeneral
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
    ColumnFind = 1
  end
  object pnlPasarSGP: TPanel
    Left = 184
    Top = 7
    Width = 232
    Height = 21
    Cursor = crHandPoint
    Caption = 'Pasar al SGP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    Visible = False
    OnClick = pnlPasarSGPClick
  end
  object DSMaestro: TDataSource
    DataSet = QProductos
    OnDataChange = DSMaestroDataChange
    Left = 72
  end
  object ACosecheros: TActionList
    Images = DMBaseDatos.ImgBotones
    Top = 104
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QProductos: TQuery
    AfterOpen = QProductosAfterOpen
    BeforeClose = QProductosBeforeClose
    BeforePost = QProductosBeforePost
    AfterScroll = QProductosAfterScroll
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM FRF_PRODUCTOS')
    Left = 40
  end
  object QCalibres: TQuery
    OnNewRecord = QCalibresNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      ''
      ' ')
    Left = 320
    Top = 520
  end
  object DSCalibres: TDataSource
    DataSet = QCalibres
    Left = 320
    Top = 488
  end
  object QCategorias: TQuery
    OnNewRecord = QCategoriasNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    Left = 144
    Top = 521
  end
  object DSCategorias: TDataSource
    DataSet = QCategorias
    Left = 144
    Top = 488
  end
  object QColores: TQuery
    OnNewRecord = QColoresNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      ''
      ' ')
    Left = 184
    Top = 520
  end
  object DSColores: TDataSource
    DataSet = QColores
    Left = 184
    Top = 489
  end
  object QPaises: TQuery
    OnNewRecord = QPaisesNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      'SELECT * '
      'FROM   frf_paises_producto')
    Left = 225
    Top = 520
  end
  object dsPaises: TDataSource
    DataSet = QPaises
    Left = 225
    Top = 488
  end
  object QVariedadCampo: TQuery
    OnNewRecord = QVariedadCampoNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      ''
      ' '
      ' ')
    Left = 277
    Top = 520
  end
  object dsVariedadCampo: TDataSource
    DataSet = QVariedadCampo
    Left = 277
    Top = 489
  end
  object qryCostesProducto: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'SELECT * FROM frf_monedas '
      'ORDER BY moneda_m, descripcion_m')
    Left = 360
    Top = 521
  end
  object dsCostesProducto: TDataSource
    DataSet = qryCostesProducto
    Left = 360
    Top = 490
  end
  object qryComercial: TQuery
    OnCalcFields = qryComercialCalcFields
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'SELECT * FROM frf_monedas '
      'ORDER BY moneda_m, descripcion_m')
    Left = 400
    Top = 521
    object qryComercialcod_comercial_cc: TStringField
      FieldName = 'cod_comercial_cc'
      Size = 3
    end
    object qryComercialdes_comercial: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_comercial'
      Size = 50
      Calculated = True
    end
    object qryComercialcod_cliente_cc: TStringField
      FieldName = 'cod_cliente_cc'
      Size = 9
    end
    object qryComercialcod_producto_cc: TStringField
      FieldName = 'cod_producto_cc'
      Size = 9
    end
  end
  object dsComercial: TDataSource
    DataSet = qryComercial
    Left = 400
    Top = 490
  end
end
