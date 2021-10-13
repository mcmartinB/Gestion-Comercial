object FMProductos: TFMProductos
  Left = 311
  Top = 240
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  PRODUCTOS'
  ClientHeight = 384
  ClientWidth = 938
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
    Width = 938
    Height = 384
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LEmpresa_p: TLabel
      Left = 37
      Top = 37
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa_p: TBGridButton
      Left = 159
      Top = 35
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
      GridAlignment = taDownRight
      GridWidth = 240
      GridHeigth = 100
    end
    object Lproducto_p: TLabel
      Left = 37
      Top = 59
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Ldescripcion_p: TLabel
      Left = 37
      Top = 82
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblBase: TLabel
      Left = 159
      Top = 59
      Width = 29
      Height = 19
      AutoSize = False
      Caption = ' Base'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnBase: TBGridButton
      Left = 217
      Top = 58
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
      Control = producto_base_p
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 240
      GridHeigth = 85
    end
    object lbl1: TLabel
      Left = 37
      Top = 104
      Width = 90
      Height = 19
      AutoSize = False
      Caption = 'Des. Ingles'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl2: TLabel
      Left = 37
      Top = 127
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Des. Aleman'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object empresa_p: TBDEdit
      Tag = 1
      Left = 131
      Top = 36
      Width = 30
      Height = 21
      Hint = 'Introduce el c'#243'digo de la empresa.'
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = PonNombre
      DataField = 'empresa_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object STEmpresa_p: TStaticText
      Left = 173
      Top = 38
      Width = 232
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object producto_p: TBDEdit
      Tag = 1
      Left = 131
      Top = 58
      Width = 30
      Height = 21
      Hint = 'Introduce el c'#243'digo del producto.'
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo de producto es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 3
      DataField = 'producto_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object descripcion_p: TBDEdit
      Tag = 1
      Left = 131
      Top = 81
      Width = 276
      Height = 21
      Hint = 'Introduce la descripci'#243'n del producto.'
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'La descripci'#243'n del producto es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 7
      DataField = 'descripcion_p'
      DataSource = DSMaestro
    end
    object estomate_p: TDBRadioGroup
      Left = 454
      Top = 38
      Width = 187
      Height = 37
      Hint = 'Seleccione si el producto sigue tratamiento de tomate o no.'
      Caption = ' '#191' Es Tomate ? '
      Color = clBtnFace
      Columns = 2
      DataField = 'estomate_p'
      DataSource = DSMaestro
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      Items.Strings = (
        'S'#237
        'No')
      ParentColor = False
      ParentFont = False
      TabOrder = 2
      Values.Strings = (
        'S'
        'N')
    end
    object descripcion2_p: TBDEdit
      Left = 131
      Top = 103
      Width = 276
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 8
      DataField = 'descripcion2_p'
      DataSource = DSMaestro
    end
    object STProductoBase: TStaticText
      Left = 232
      Top = 60
      Width = 173
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 5
    end
    object es_propio_p: TDBCheckBox
      Left = 454
      Top = 116
      Width = 97
      Height = 17
      Caption = 'Producto Socio'
      DataField = 'socio_p'
      DataSource = DSMaestro
      TabOrder = 9
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object tipo_liquida_p: TDBRadioGroup
      Left = 454
      Top = 77
      Width = 187
      Height = 37
      Hint = 'Seleccione si el producto sigue tratamiento de tomate o no.'
      Caption = ' Liquidaci'#243'n por '
      Color = clBtnFace
      Columns = 2
      DataField = 'tipo_liquida_p'
      DataSource = DSMaestro
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      Items.Strings = (
        'Salida'
        'Escandallo')
      ParentColor = False
      ParentFont = False
      TabOrder = 6
      Values.Strings = (
        'S'
        'E')
    end
    object gridVariedad: TDBGrid
      Left = 529
      Top = 191
      Width = 212
      Height = 162
      TabStop = False
      DataSource = dsVariedad
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 11
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'empresa_pv'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'producto_pv'
          Visible = False
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'codigo_pv'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'digo'
          Title.Color = cl3DLight
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 43
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descripcion_pv'
          Title.Alignment = taCenter
          Title.Caption = 'Descripci'#243'n'
          Title.Color = cl3DLight
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 152
          Visible = True
        end>
    end
    object chkVariedad: TCheckBox
      Left = 587
      Top = 358
      Width = 97
      Height = 17
      Caption = 'Variedad'
      Checked = True
      State = cbChecked
      TabOrder = 12
      OnClick = chkVariedadClick
    end
    object producto_base_p: TBDEdit
      Tag = 1
      Left = 191
      Top = 58
      Width = 25
      Height = 21
      Hint = 'Introduce el c'#243'digo del producto.'
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo de producto es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 4
      OnChange = PonNombre
      DataField = 'producto_base_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object edtdescripcion2_p: TBDEdit
      Left = 131
      Top = 126
      Width = 276
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 10
      DataField = 'des_aleman_p'
      DataSource = DSMaestro
    end
  end
  object BtnCal: TBitBtn
    Left = 22
    Top = 166
    Width = 106
    Height = 25
    Caption = '&Calibres'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    TabStop = False
    OnClick = BtnCalClick
  end
  object BtnCat: TBitBtn
    Left = 128
    Top = 166
    Width = 185
    Height = 25
    Caption = 'Ca&tegor'#237'a'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    TabStop = False
    OnClick = btn_CategoryokClick
  end
  object btnCol: TBitBtn
    Left = 315
    Top = 166
    Width = 213
    Height = 25
    Caption = 'C&olor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    TabStop = False
    OnClick = btnColClick
  end
  object BtnEje: TBitBtn
    Left = 743
    Top = 166
    Width = 165
    Height = 25
    Caption = '&Ejercicios'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    TabStop = False
    OnClick = BtnEjeClick
  end
  object GEje: TDBGrid
    Left = 743
    Top = 191
    Width = 164
    Height = 162
    TabStop = False
    DataSource = DSEjercicios
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 11
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'empresa_e'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'producto_e'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'centro_e'
        Title.Alignment = taCenter
        Title.Caption = 'Centros'
        Title.Color = cl3DLight
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ejercicio_e'
        Title.Alignment = taCenter
        Title.Caption = 'Ejercicios'
        Title.Color = cl3DLight
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 79
        Visible = True
      end>
  end
  object GCat: TDBGrid
    Left = 129
    Top = 191
    Width = 186
    Height = 162
    TabStop = False
    DataSource = DSCategory
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 9
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'empresa_c'
        Title.Alignment = taCenter
        Title.Caption = 'Empresa'
        Title.Color = cl3DLight
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'producto_c'
        Title.Alignment = taCenter
        Title.Caption = 'Producto'
        Title.Color = cl3DLight
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = False
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'categoria_c'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Title.Caption = 'Categor'#237'a'
        Title.Color = cl3DLight
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descripcion_c'
        Title.Alignment = taCenter
        Title.Caption = 'Descripci'#243'n'
        Title.Color = cl3DLight
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 103
        Visible = True
      end>
  end
  object GCal: TDBGrid
    Left = 21
    Top = 191
    Width = 107
    Height = 162
    TabStop = False
    DataSource = DSSize
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'empresa_c'
        Title.Alignment = taCenter
        Title.Caption = 'Empresa'
        Title.Color = cl3DLight
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'producto_c'
        Title.Alignment = taCenter
        Title.Caption = 'Producto'
        Title.Color = cl3DLight
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = False
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'calibre_c'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Title.Caption = 'Calibre'
        Title.Color = cl3DLight
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 90
        Visible = True
      end>
  end
  object CBCal: TCheckBox
    Left = 40
    Top = 358
    Width = 97
    Height = 17
    Caption = 'Calibre'
    Checked = True
    State = cbChecked
    TabOrder = 13
    OnClick = CBCalClick
  end
  object CBCat: TCheckBox
    Left = 176
    Top = 358
    Width = 97
    Height = 17
    Caption = 'Categoria'
    Checked = True
    State = cbChecked
    TabOrder = 14
    OnClick = CBCatClick
  end
  object CBCol: TCheckBox
    Left = 372
    Top = 358
    Width = 97
    Height = 17
    Caption = 'Color'
    Checked = True
    State = cbChecked
    TabOrder = 15
    OnClick = CBColClick
  end
  object CBEje: TCheckBox
    Left = 776
    Top = 350
    Width = 97
    Height = 17
    Caption = 'Ejercicios'
    Checked = True
    State = cbChecked
    TabOrder = 12
    OnClick = CBEjeClick
  end
  object btnVariedad: TBitBtn
    Left = 529
    Top = 166
    Width = 213
    Height = 25
    Caption = '&Variedad'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    TabStop = False
    OnClick = btnVariedadClick
  end
  object GCol: TDBGrid
    Left = 315
    Top = 191
    Width = 212
    Height = 162
    TabStop = False
    DataSource = DSColor
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 10
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'empresa_c'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'producto_c'
        Visible = False
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'color_c'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Title.Caption = 'Color'
        Title.Color = cl3DLight
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 43
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descripcion_c'
        Title.Alignment = taCenter
        Title.Caption = 'Descripci'#243'n'
        Title.Color = cl3DLight
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 152
        Visible = True
      end>
  end
  object RejillaFlotante: TBGrid
    Left = 776
    Top = 35
    Width = 137
    Height = 107
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
    BControl = empresa_p
  end
  object pnlPasarSGP: TPanel
    Left = 454
    Top = 6
    Width = 187
    Height = 25
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
    Left = 48
    Top = 136
  end
  object AProductos: TActionList
    Top = 96
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object DSSize: TDataSource
    DataSet = QCalibres
    Left = 96
    Top = 240
  end
  object DSCategory: TDataSource
    DataSet = QCategorias
    Left = 232
    Top = 240
  end
  object DSColor: TDataSource
    DataSet = QColor
    Left = 424
    Top = 241
  end
  object DSEjercicios: TDataSource
    DataSet = QEjercicios
    Left = 828
    Top = 239
  end
  object QEjercicios: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    Left = 798
    Top = 238
  end
  object QProductos: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT*'
      'FROM frf_productos Frf_productos')
    Left = 16
    Top = 120
  end
  object QColor: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      ''
      ' '
      ' ')
    Left = 392
    Top = 240
  end
  object QCategorias: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      '')
    Left = 192
    Top = 238
  end
  object QCalibres: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      ''
      ' '
      ' ')
    Left = 64
    Top = 240
  end
  object qryVariedad: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      ''
      ' '
      ' ')
    Left = 592
    Top = 240
  end
  object dsVariedad: TDataSource
    DataSet = qryVariedad
    Left = 624
    Top = 241
  end
end
