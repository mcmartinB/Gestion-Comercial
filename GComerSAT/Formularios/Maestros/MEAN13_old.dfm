object FMEAN13_old: TFMEAN13_old
  Left = 435
  Top = 275
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    C'#211'DIGOS EAN13 DE ART'#205'CULOS'
  ClientHeight = 476
  ClientWidth = 522
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
    Width = 522
    Height = 476
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
      Left = 67
      Top = 45
      Width = 73
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo '
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LEnvase_e: TLabel
      Left = 67
      Top = 373
      Width = 86
      Height = 19
      AutoSize = False
      Caption = ' Art'#237'culo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LProducto_e: TLabel
      Left = 67
      Top = 103
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBProductop_e: TBGridButton
      Left = 421
      Top = 102
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      Control = productop_e
      Grid = RejillaFlotante
      GridAlignment = taDownLeft
      GridWidth = 230
      GridHeigth = 120
    end
    object BGBEnvase_e: TBGridButton
      Left = 235
      Top = 373
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
      Left = 67
      Top = 129
      Width = 73
      Height = 19
      AutoSize = False
      Caption = ' Marca'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LCalibre_e: TLabel
      Left = 67
      Top = 159
      Width = 73
      Height = 19
      AutoSize = False
      Caption = ' Calibre'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBMarca_e: TBGridButton
      Left = 181
      Top = 130
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
      Left = 233
      Top = 159
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
      Left = 67
      Top = 73
      Width = 73
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa_e: TBGridButton
      Left = 208
      Top = 73
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
      Left = 67
      Top = 189
      Width = 73
      Height = 26
      AutoSize = False
      Caption = ' Descripci'#243'n'#13#10' Abreviada'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 67
      Top = 224
      Width = 73
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 67
      Top = 404
      Width = 86
      Height = 19
      AutoSize = False
      Caption = ' Fecha de Baja'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 275
      Top = 404
      Width = 86
      Height = 19
      AutoSize = False
      Caption = ' Ver los Envases'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl1: TLabel
      Left = 270
      Top = 44
      Width = 56
      Height = 21
      AutoSize = False
      Caption = ' EAN 14'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object DBRGAgrupacion: TDBRadioGroup
      Left = 69
      Top = 303
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
      TabOrder = 13
      TabStop = True
      Values.Strings = (
        '1'
        '2'
        '3')
      OnChange = DBRGAgrupacionChange
    end
    object codigo_e: TBDEdit
      Left = 157
      Top = 44
      Width = 105
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 13
      TabOrder = 0
      OnKeyPress = codigo_eKeyPress
      DataField = 'codigo_e'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object envase_e: TBDEdit
      Left = 157
      Top = 373
      Width = 75
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = RequiredTime
      MaxLength = 9
      TabOrder = 14
      OnChange = PonNombre
      DataField = 'envase_e'
      DataSource = DSMaestro
    end
    object productop_e: TBDEdit
      Tag = 1
      Left = 157
      Top = 103
      Width = 20
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 5
      OnChange = productop_eChange
      DataField = 'productop_e'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object marca_e: TBDEdit
      Left = 157
      Top = 130
      Width = 23
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 2
      TabOrder = 6
      OnChange = PonNombre
      DataField = 'marca_e'
      DataSource = DSMaestro
    end
    object calibre_e: TBDEdit
      Left = 157
      Top = 159
      Width = 73
      Height = 21
      ColorEdit = clMoneyGreen
      CharCase = ecNormal
      MaxLength = 10
      TabOrder = 8
      DataField = 'calibre_e'
      DataSource = DSMaestro
    end
    object STEnvase_e: TStaticText
      Left = 251
      Top = 374
      Width = 190
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 15
    end
    object STMarca_e: TStaticText
      Left = 196
      Top = 131
      Width = 238
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 7
    end
    object empresa_e: TBDEdit
      Left = 157
      Top = 73
      Width = 49
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      MaxLength = 3
      TabOrder = 2
      OnChange = PonNombre
      DataField = 'empresa_e'
      DataSource = DSMaestro
    end
    object STEmpresa_e: TStaticText
      Left = 229
      Top = 73
      Width = 207
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 3
    end
    object descripcion_e: TBDEdit
      Left = 156
      Top = 190
      Width = 280
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      CharCase = ecNormal
      MaxLength = 50
      TabOrder = 9
      DataField = 'descripcion_e'
      DataSource = DSMaestro
    end
    object descripcion2_e: TBDEdit
      Left = 156
      Top = 222
      Width = 279
      Height = 21
      ColorEdit = clMoneyGreen
      CharCase = ecNormal
      TabOrder = 11
      DataField = 'descripcion2_e'
      DataSource = DSMaestro
    end
    object DBMemo1: TDBMemo
      Left = 156
      Top = 222
      Width = 279
      Height = 73
      DataField = 'descripcion2_e'
      DataSource = DSMaestro
      TabOrder = 10
      OnEnter = DBMemo1Enter
      OnExit = DBMemo1Exit
    end
    object descripcion_pb: TBDEdit
      Tag = -1
      Left = 157
      Top = 103
      Width = 262
      Height = 21
      ColorEdit = clMoneyGreen
      ReadOnly = True
      TabOrder = 4
    end
    object fecha_baja_e: TBDEdit
      Left = 157
      Top = 403
      Width = 73
      Height = 21
      InputType = itDate
      TabOrder = 16
      DataField = 'fecha_baja_e'
      DataSource = DSMaestro
    end
    object cbxVer: TComboBox
      Left = 365
      Top = 403
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
      Left = 142
      Top = 301
      Width = 83
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 12
      Text = 'Todos'
      Visible = False
      Items.Strings = (
        'Todos'
        'Unidad'
        'De 1'#186' Nivel'
        'De 2'#186' Nivel')
    end
    object ean14_e: TBDEdit
      Left = 331
      Top = 44
      Width = 105
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = RequiredTime
      MaxLength = 14
      TabOrder = 1
      OnKeyPress = codigo_eKeyPress
      DataField = 'ean14_e'
      DataSource = DSMaestro
    end
  end
  object RejillaFlotante: TBGrid
    Left = 128
    Top = 17
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
    Left = 32
    Top = 40
  end
  object ACosecheros: TActionList
    Left = 32
    Top = 72
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
    Left = 32
    Top = 8
  end
end
