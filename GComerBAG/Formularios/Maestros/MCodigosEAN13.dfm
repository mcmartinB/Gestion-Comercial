object FCodigosMEAN13: TFCodigosMEAN13
  Left = 706
  Top = 211
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    C'#211'DIGOS EAN13 DE ART'#205'CULOS'
  ClientHeight = 440
  ClientWidth = 475
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
  OnDeactivate = FormDeactivate
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
    Width = 475
    Height = 440
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LCodigo_e: TLabel
      Left = 45
      Top = 60
      Width = 73
      Height = 19
      AutoSize = False
      Caption = ' Ean 13'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LEnvase_e: TLabel
      Left = 45
      Top = 261
      Width = 86
      Height = 19
      AutoSize = False
      Caption = ' Art'#237'culo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LProducto_e: TLabel
      Left = 45
      Top = 285
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBProducto_e: TBGridButton
      Left = 402
      Top = 284
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      Enabled = False
      Control = productop_e
      Grid = RejillaFlotante
      GridAlignment = taDownLeft
      GridWidth = 230
      GridHeigth = 120
    end
    object BGBEnvase_e: TBGridButton
      Left = 208
      Top = 261
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Control = envase_e
      Grid = RejillaFlotante
      GridAlignment = taUpRight
      GridWidth = 190
      GridHeigth = 130
    end
    object LMarca_e: TLabel
      Left = 45
      Top = 308
      Width = 73
      Height = 19
      AutoSize = False
      Caption = ' Marca'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LCalibre_e: TLabel
      Left = 45
      Top = 335
      Width = 73
      Height = 19
      AutoSize = False
      Caption = ' Calibre'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBMarca_e: TBGridButton
      Left = 176
      Top = 309
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Control = marca_e
      Grid = RejillaFlotante
      GridAlignment = taUpRight
      GridWidth = 190
      GridHeigth = 100
    end
    object BGbCalibre_e: TBGridButton
      Left = 195
      Top = 335
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Control = calibre_e
      Grid = RejillaFlotante
      GridAlignment = taUpRight
      GridWidth = 190
      GridHeigth = 100
    end
    object LEmpresa_e: TLabel
      Left = 45
      Top = 35
      Width = 73
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa_e: TBGridButton
      Left = 186
      Top = 35
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Control = empresa_e
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 200
      GridHeigth = 130
    end
    object Label1: TLabel
      Left = 45
      Top = 83
      Width = 73
      Height = 26
      AutoSize = False
      Caption = ' Descripci'#243'n'#13#10' Abreviada'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 45
      Top = 109
      Width = 73
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 261
      Top = 364
      Width = 86
      Height = 19
      AutoSize = False
      Caption = ' Fecha de Baja'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 261
      Top = 388
      Width = 86
      Height = 19
      AutoSize = False
      Caption = ' Ver los Envases'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblean14: TLabel
      Left = 247
      Top = 58
      Width = 55
      Height = 21
      AutoSize = False
      Caption = ' EAN 14'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object DBRGAgrupacion: TDBRadioGroup
      Left = 45
      Top = 190
      Width = 372
      Height = 63
      Caption = ' Agrupaci'#243'n '
      Columns = 3
      DataField = 'agrupacion_e'
      DataSource = DSMaestro
      Items.Strings = (
        'Unidad Consumo'
        'De 1'#186' Nivel (Caja)'
        'De 2'#186' Nivel (Palet)')
      ParentBackground = True
      TabOrder = 8
      TabStop = True
      Values.Strings = (
        '1'
        '2'
        '3')
      OnChange = DBRGAgrupacionChange
    end
    object codigo_e: TBDEdit
      Left = 135
      Top = 59
      Width = 105
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 13
      TabOrder = 2
      OnKeyPress = codigo_eKeyPress
      DataField = 'codigo_e'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object envase_e: TBDEdit
      Left = 135
      Top = 261
      Width = 75
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = RequiredTime
      MaxLength = 9
      TabOrder = 10
      OnChange = PonNombre
      OnExit = envase_eExit
      DataField = 'envase_e'
      DataSource = DSMaestro
    end
    object marca_e: TBDEdit
      Left = 135
      Top = 309
      Width = 23
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 2
      TabOrder = 13
      OnChange = PonNombre
      DataField = 'marca_e'
      DataSource = DSMaestro
    end
    object calibre_e: TBDEdit
      Left = 135
      Top = 335
      Width = 57
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      CharCase = ecNormal
      TabOrder = 15
      DataField = 'calibre_e'
      DataSource = DSMaestro
    end
    object STEnvase_e: TStaticText
      Left = 222
      Top = 262
      Width = 195
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 11
    end
    object STMarca_e: TStaticText
      Left = 190
      Top = 310
      Width = 227
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 14
    end
    object empresa_e: TBDEdit
      Left = 135
      Top = 35
      Width = 49
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      MaxLength = 3
      TabOrder = 0
      OnChange = PonNombre
      DataField = 'empresa_e'
      DataSource = DSMaestro
    end
    object STEmpresa_e: TStaticText
      Left = 210
      Top = 35
      Width = 207
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object descripcion_e: TBDEdit
      Left = 135
      Top = 84
      Width = 282
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      CharCase = ecNormal
      MaxLength = 50
      TabOrder = 4
      DataField = 'descripcion_e'
      DataSource = DSMaestro
    end
    object descripcion2_e: TBDEdit
      Left = 135
      Top = 109
      Width = 279
      Height = 21
      ColorEdit = clMoneyGreen
      CharCase = ecNormal
      TabOrder = 5
      DataField = 'descripcion2_e'
      DataSource = DSMaestro
    end
    object DBMemo1: TDBMemo
      Left = 135
      Top = 109
      Width = 282
      Height = 73
      DataField = 'descripcion2_e'
      DataSource = DSMaestro
      TabOrder = 6
      OnEnter = DBMemo1Enter
      OnExit = DBMemo1Exit
    end
    object descripcion_p: TBDEdit
      Tag = -1
      Left = 176
      Top = 285
      Width = 227
      Height = 21
      ColorEdit = clMoneyGreen
      Enabled = False
      ReadOnly = True
      TabOrder = 9
    end
    object fecha_baja_e: TBDEdit
      Left = 344
      Top = 363
      Width = 73
      Height = 21
      InputType = itDate
      TabOrder = 16
      DataField = 'fecha_baja_e'
      DataSource = DSMaestro
    end
    object cbxVer: TComboBox
      Left = 344
      Top = 387
      Width = 73
      Height = 21
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 17
      Text = 'Todos'
      Items.Strings = (
        'Todos'
        'De alta'
        'De baja')
    end
    object cbxAgrupacion: TComboBox
      Left = 135
      Top = 188
      Width = 83
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 7
      Text = 'Todos'
      Visible = False
      Items.Strings = (
        'Todos'
        'Unidad'
        'De 1'#186' Nivel'
        'De 2'#186' Nivel')
    end
    object ean14_e: TBDEdit
      Left = 312
      Top = 58
      Width = 105
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      MaxLength = 14
      TabOrder = 3
      OnKeyPress = codigo_eKeyPress
      DataField = 'ean14_e'
      DataSource = DSMaestro
    end
    object productop_e: TBDEdit
      Left = 135
      Top = 285
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 12
      OnChange = PonNombre
      DataField = 'productop_e'
      DataSource = DSMaestro
    end
  end
  object RejillaFlotante: TBGrid
    Left = 88
    Top = 1
    Width = 137
    Height = 25
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
  end
  object DSMaestro: TDataSource
    DataSet = QEan13
    OnStateChange = DSMaestroStateChange
    Top = 80
  end
  object ACosecheros: TActionList
    Top = 40
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
  object QEan13: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_ean13'
      'ORDER BY codigo_e')
  end
end
