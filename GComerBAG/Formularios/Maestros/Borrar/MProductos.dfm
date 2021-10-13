object FMProductos: TFMProductos
  Left = 569
  Top = 244
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  PRODUCTOS'
  ClientHeight = 384
  ClientWidth = 789
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
    Width = 789
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
      Left = 58
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
      GridAlignment = taDownCenter
      GridWidth = 240
      GridHeigth = 130
    end
    object Lproducto_p: TLabel
      Left = 58
      Top = 67
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Ldescripcion_p: TLabel
      Left = 58
      Top = 97
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n Aux.'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object empresa_p: TBDEdit
      Tag = 1
      Left = 122
      Top = 36
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
      Left = 122
      Top = 66
      Width = 35
      Height = 21
      Hint = 'Introduce el c'#243'digo del producto.'
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo de producto es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 2
      OnExit = producto_pExit
      DataField = 'producto_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object descripcion_p: TBDEdit
      Tag = 1
      Left = 173
      Top = 66
      Width = 232
      Height = 21
      Hint = 'Introduce la descripci'#243'n del producto.'
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'La descripci'#243'n del producto es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 3
      DataField = 'descripcion_p'
      DataSource = DSMaestro
    end
    object descripcion2_p: TBDEdit
      Left = 173
      Top = 96
      Width = 232
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 4
      DataField = 'descripcion2_p'
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
    TabOrder = 2
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
    TabOrder = 3
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
    TabOrder = 4
    TabStop = False
    OnClick = btnColClick
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
  object GCat: TDBGrid
    Left = 129
    Top = 191
    Width = 186
    Height = 162
    TabStop = False
    DataSource = DSCategory
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 7
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
    TabOrder = 6
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
    Left = 21
    Top = 358
    Width = 97
    Height = 17
    Caption = 'Calibre'
    Checked = True
    State = cbChecked
    TabOrder = 10
    OnClick = CBCalClick
  end
  object CBCat: TCheckBox
    Left = 129
    Top = 358
    Width = 97
    Height = 17
    Caption = 'Categoria'
    Checked = True
    State = cbChecked
    TabOrder = 11
    OnClick = CBCatClick
  end
  object chkPais: TCheckBox
    Left = 529
    Top = 358
    Width = 97
    Height = 17
    Caption = 'Pa'#237's'
    Checked = True
    State = cbChecked
    TabOrder = 13
    OnClick = chkPaisClick
  end
  object btnPaises: TBitBtn
    Left = 529
    Top = 166
    Width = 235
    Height = 25
    Caption = '&Pa'#237's'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    TabStop = False
    OnClick = btnPaisesClick
  end
  object dbgrdPaises: TDBGrid
    Left = 529
    Top = 191
    Width = 235
    Height = 162
    TabStop = False
    DataSource = dsPaises
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
        FieldName = 'empresa_psp'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'producto_psp'
        Visible = False
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'pais_psp'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Title.Caption = 'Pa'#237's'
        Title.Color = cl3DLight
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 52
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'des_pais'
        Title.Caption = 'Descripci'#243'n'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 144
        Visible = True
      end>
  end
  object CBCol: TCheckBox
    Left = 315
    Top = 358
    Width = 97
    Height = 17
    Caption = 'Color'
    Checked = True
    State = cbChecked
    TabOrder = 12
    OnClick = CBColClick
  end
  object RejillaFlotante: TBGrid
    Left = 544
    Top = 2
    Width = 137
    Height = 135
    Color = clInfoBk
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    BControl = empresa_p
  end
  object DSMaestro: TDataSource
    DataSet = QProductos
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
    DataSet = QColores
    Left = 424
    Top = 241
  end
  object QProductos: TQuery
    BeforePost = QProductosBeforePost
    AfterPost = QProductosAfterPost
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT*'
      'FROM frf_productos Frf_productos')
    Left = 16
    Top = 120
  end
  object QColores: TQuery
    BeforePost = QCalibresBeforePost
    AfterPost = QColoresAfterPost
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      ''
      ' ')
    Left = 392
    Top = 240
  end
  object QCategorias: TQuery
    BeforePost = QCalibresBeforePost
    AfterPost = QCategoriasAfterPost
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    Left = 192
    Top = 238
  end
  object QCalibres: TQuery
    BeforePost = QCalibresBeforePost
    AfterPost = QCalibresAfterPost
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      ''
      ' ')
    Left = 64
    Top = 240
  end
  object QCalibresAux: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT empresa_c,producto_c,calibre_c'
      'FROM   frf_calibres Frf_calibres'
      'WHERE  (empresa_c=:empresa_p)'
      'AND    (producto_c=:producto_p)'
      'ORDER BY calibre_c'
      ' '
      ' ')
    Left = 64
    Top = 270
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'empresa_p'
        ParamType = ptUnknown
      end
      item
        DataType = ftFixedChar
        Name = 'producto_p'
        ParamType = ptUnknown
      end>
  end
  object QCategoriasAux: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_categorias Frf_categorias'
      'WHERE (empresa_c=:empresa_p)'
      'AND   (producto_c=:producto_p)'
      'ORDER BY categoria_c')
    Left = 192
    Top = 268
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'empresa_p'
        ParamType = ptUnknown
      end
      item
        DataType = ftFixedChar
        Name = 'producto_p'
        ParamType = ptUnknown
      end>
  end
  object QColoresAux: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT empresa_c,producto_c,color_c,descripcion_c'
      'FROM   frf_colores Frf_color'
      'WHERE  (empresa_c=:empresa_p)'
      'AND    (producto_c=:producto_p)'
      'ORDER BY color_c'
      ' '
      ' ')
    Left = 392
    Top = 270
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'empresa_p'
        ParamType = ptUnknown
      end
      item
        DataType = ftFixedChar
        Name = 'producto_p'
        ParamType = ptUnknown
      end>
  end
  object dsPaises: TDataSource
    DataSet = qryPaises
    Left = 584
    Top = 233
  end
  object qryPaises: TQuery
    BeforePost = QCalibresBeforePost
    AfterPost = qryPaisesAfterPost
    OnCalcFields = qryPaisesCalcFields
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      'SELECT * '
      'FROM   frf_paises_producto')
    Left = 544
    Top = 232
    object strngfldPaisesempresa_psp: TStringField
      FieldName = 'empresa_psp'
      Origin = '"COMER.BAG".frf_paises_producto.empresa_psp'
      FixedChar = True
      Size = 3
    end
    object strngfldPaisesproducto_psp: TStringField
      FieldName = 'producto_psp'
      Origin = '"COMER.BAG".frf_paises_producto.producto_psp'
      FixedChar = True
      Size = 1
    end
    object strngfldPaisespais_psp: TStringField
      FieldName = 'pais_psp'
      Origin = '"COMER.BAG".frf_paises_producto.pais_psp'
      FixedChar = True
      Size = 2
    end
    object strngfldPaisesdes_pais: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_pais'
      Size = 30
      Calculated = True
    end
  end
  object qryPaisesAux: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT empresa_c,producto_c,color_c,descripcion_c'
      'FROM   frf_colores Frf_color'
      'WHERE  (empresa_c=:empresa_p)'
      'AND    (producto_c=:producto_p)'
      'ORDER BY color_c'
      ' '
      ' ')
    Left = 544
    Top = 270
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'empresa_p'
        ParamType = ptUnknown
      end
      item
        DataType = ftFixedChar
        Name = 'producto_p'
        ParamType = ptUnknown
      end>
  end
end
