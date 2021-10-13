object FMProductos_: TFMProductos_
  Left = 574
  Top = 249
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  PRODUCTOS'
  ClientHeight = 519
  ClientWidth = 531
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
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 531
    Height = 192
    Align = alTop
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LEmpresa_p: TLabel
      Left = 40
      Top = 32
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa_p: TBGridButton
      Left = 170
      Top = 30
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
      Control = empresa_p
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 240
      GridHeigth = 130
    end
    object Lproducto_p: TLabel
      Left = 40
      Top = 79
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
      Top = 102
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Ingles'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblProductoBase: TLabel
      Left = 40
      Top = 56
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Producto Base'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblEsTomate: TLabel
      Left = 40
      Top = 148
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
      Top = 125
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Alem'#225'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object empresa_p: TBDEdit
      Tag = 1
      Left = 134
      Top = 31
      Width = 35
      Height = 21
      Hint = 'Introduce el c'#243'digo de la empresa.'
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = empresa_pChange
      DataField = 'empresa_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object STEmpresa_p: TStaticText
      Left = 184
      Top = 33
      Width = 232
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object producto_p: TBDEdit
      Tag = 1
      Left = 134
      Top = 78
      Width = 35
      Height = 21
      Hint = 'Introduce el c'#243'digo del producto.'
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo de producto es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 4
      DataField = 'producto_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object descripcion_p: TBDEdit
      Tag = 1
      Left = 184
      Top = 78
      Width = 232
      Height = 21
      Hint = 'Introduce la descripci'#243'n del producto.'
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'La descripci'#243'n del producto es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 5
      OnChange = descripcion_pChange
      DataField = 'descripcion_p'
      DataSource = DSMaestro
    end
    object descripcion2_p: TBDEdit
      Left = 184
      Top = 101
      Width = 232
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 6
      DataField = 'descripcion2_p'
      DataSource = DSMaestro
    end
    object producto_base_p: TBDEdit
      Tag = 1
      Left = 134
      Top = 55
      Width = 35
      Height = 21
      Hint = 'Introduce el c'#243'digo del producto base.'
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 3
      TabOrder = 2
      OnChange = producto_base_pChange
      OnEnter = producto_base_pEnter
      DataField = 'producto_base_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object txtProductoBase: TStaticText
      Left = 184
      Top = 57
      Width = 232
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 3
    end
    object estomate_p: TDBCheckBox
      Left = 134
      Top = 149
      Width = 97
      Height = 17
      Caption = 'NO'
      DataField = 'estomate_p'
      DataSource = DSMaestro
      TabOrder = 8
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = estomate_pClick
    end
    object des_aleman_p: TBDEdit
      Left = 184
      Top = 124
      Width = 232
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 7
      DataField = 'des_aleman_p'
      DataSource = DSMaestro
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 192
    Width = 531
    Height = 327
    ActivePage = tsVariedadCampo
    Align = alClient
    TabOrder = 3
    OnChange = PageControlChange
    object tsCategorias: TTabSheet
      Caption = 'Categor'#237'as'
      object PCategorias: TPanel
        Left = 0
        Top = 0
        Width = 523
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
        Width = 523
        Height = 230
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
        Width = 523
        Height = 222
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
        Width = 523
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
        Width = 523
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
        Width = 523
        Height = 230
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
        Width = 523
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
        Width = 523
        Height = 222
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
        Width = 523
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
        Width = 523
        Height = 242
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
    object tsEjercicios: TTabSheet
      Caption = 'Ejercicios'
      ImageIndex = 5
      object PEjercicios: TPanel
        Left = 0
        Top = 0
        Width = 523
        Height = 57
        Align = alTop
        TabOrder = 0
        Visible = False
        object lblEjercicios: TLabel
          Left = 12
          Top = 20
          Width = 95
          Height = 19
          AutoSize = False
          Caption = ' Centro'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object btnCentro: TBGridButton
          Left = 143
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
          Control = centro_e
          Grid = RejillaFlotante
          GridAlignment = taDownCenter
          GridWidth = 230
          GridHeigth = 200
        end
        object lbl1: TLabel
          Left = 343
          Top = 20
          Width = 70
          Height = 19
          AutoSize = False
          Caption = ' Fecha'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object centro_e: TBDEdit
          Left = 111
          Top = 19
          Width = 30
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 1
          TabOrder = 0
          OnChange = centro_eChange
          DataField = 'centro_e'
          DataSource = DSEjercicios
          Modificable = False
          PrimaryKey = True
        end
        object ejercicio_e: TBDEdit
          Left = 417
          Top = 19
          Width = 87
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          InputType = itDate
          MaxLength = 30
          TabOrder = 1
          DataField = 'ejercicio_e'
          DataSource = DSEjercicios
        end
        object txtCentro: TStaticText
          Left = 158
          Top = 20
          Width = 181
          Height = 21
          AutoSize = False
          BorderStyle = sbsSunken
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
        end
      end
      object REjercicios: TDBGrid
        Left = 0
        Top = 57
        Width = 523
        Height = 230
        Align = alClient
        DataSource = DSEjercicios
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
  end
  object RejillaFlotante: TBGrid
    Left = 440
    Top = 24
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
    OnClick = pnlPasarSGPClick
  end
  object DSMaestro: TDataSource
    DataSet = QProductos
    OnDataChange = DSMaestroDataChange
    Left = 232
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
    AfterPost = QProductosAfterPost
    AfterScroll = QProductosAfterScroll
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_cosecheros'
      'ORDER BY empresa_c, cosechero_c')
    Left = 200
  end
  object QCalibres: TQuery
    OnNewRecord = QCalibresNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      ''
      ' ')
    Left = 80
    Top = 312
  end
  object DSCalibres: TDataSource
    DataSet = QCalibres
    Left = 112
    Top = 312
  end
  object QCategorias: TQuery
    OnNewRecord = QCategoriasNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    Left = 16
    Top = 278
  end
  object DSCategorias: TDataSource
    DataSet = QCategorias
    Left = 48
    Top = 280
  end
  object QColores: TQuery
    OnNewRecord = QColoresNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      ''
      ' ')
    Left = 144
    Top = 344
  end
  object DSColores: TDataSource
    DataSet = QColores
    Left = 176
    Top = 345
  end
  object QPaises: TQuery
    OnNewRecord = QPaisesNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      'SELECT * '
      'FROM   frf_paises_producto')
    Left = 209
    Top = 376
  end
  object dsPaises: TDataSource
    DataSet = QPaises
    Left = 249
    Top = 377
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
    Left = 285
    Top = 408
  end
  object dsVariedadCampo: TDataSource
    DataSet = QVariedadCampo
    Left = 317
    Top = 409
  end
  object QEjercicios: TQuery
    OnNewRecord = QEjerciciosNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    Left = 349
    Top = 438
  end
  object DSEjercicios: TDataSource
    DataSet = QEjercicios
    Left = 379
    Top = 439
  end
end
