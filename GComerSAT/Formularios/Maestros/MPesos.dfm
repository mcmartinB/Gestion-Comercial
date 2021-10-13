object FMPesos: TFMPesos
  Left = 401
  Top = 245
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  PESOS DE CAJAS Y PALETS'
  ClientHeight = 348
  ClientWidth = 460
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
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 460
    Height = 348
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
      Left = 40
      Top = 45
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa_p: TBGridButton
      Left = 179
      Top = 43
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      Control = empresa_p
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 230
      GridHeigth = 132
    end
    object BGBCentro_p: TBGridButton
      Left = 179
      Top = 68
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      Control = centro_p
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 250
      GridHeigth = 132
    end
    object LCentro_p: TLabel
      Left = 40
      Top = 69
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Centro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LProducto_p: TLabel
      Left = 40
      Top = 93
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBProducto_p: TBGridButton
      Left = 179
      Top = 92
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      Control = producto_p
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 300
      GridHeigth = 240
    end
    object Label1: TLabel
      Left = 40
      Top = 167
      Width = 129
      Height = 19
      AutoSize = False
      Caption = ' Cajas por Palet'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblFormato: TLabel
      Left = 40
      Top = 117
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Formato'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblLogifruit: TLabel
      Left = 40
      Top = 144
      Width = 40
      Height = 13
      Caption = ' Logifruit'
    end
    object empresa_p: TBDEdit
      Tag = 1
      Left = 140
      Top = 44
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = PonNombre
      DataField = 'empresa_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object centro_p: TBDEdit
      Tag = 2
      Left = 140
      Top = 68
      Width = 22
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 1
      TabOrder = 2
      OnChange = PonNombre
      DataField = 'centro_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object producto_p: TBDEdit
      Tag = 3
      Left = 140
      Top = 92
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 4
      OnChange = PonNombre
      DataField = 'producto_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object STEmpresa_p: TStaticText
      Left = 201
      Top = 46
      Width = 217
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object STCentro_p: TStaticText
      Left = 201
      Top = 70
      Width = 217
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 3
    end
    object STProducto_p: TStaticText
      Left = 201
      Top = 94
      Width = 217
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 5
    end
    object GroupBox1: TGroupBox
      Left = 40
      Top = 195
      Width = 377
      Height = 73
      Caption = 'Pesos'
      TabOrder = 10
      object LPeso_palet_p: TLabel
        Left = 40
        Top = 29
        Width = 57
        Height = 19
        AutoSize = False
        Caption = ' Palet'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object LPeso_caja_p: TLabel
        Left = 199
        Top = 29
        Width = 57
        Height = 19
        AutoSize = False
        Caption = ' Caja'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object peso_palet_p: TBDEdit
        Left = 93
        Top = 28
        Width = 78
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        InputType = itReal
        MaxDecimals = 2
        MaxLength = 6
        TabOrder = 0
        DataField = 'peso_palet_p'
        DataSource = DSMaestro
      end
      object peso_caja_p: TBDEdit
        Left = 253
        Top = 28
        Width = 78
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        InputType = itReal
        MaxDecimals = 2
        MaxLength = 6
        TabOrder = 1
        DataField = 'peso_caja_p'
        DataSource = DSMaestro
      end
    end
    object cajas_palet_p: TBDEdit
      Left = 140
      Top = 166
      Width = 37
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 6
      TabOrder = 9
      DataField = 'cajas_palet_p'
      DataSource = DSMaestro
    end
    object formato_p: TBDEdit
      Tag = 3
      Left = 140
      Top = 116
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 3
      TabOrder = 6
      OnChange = PonNombre
      DataField = 'formato_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object descripcion_p: TBDEdit
      Tag = 3
      Left = 179
      Top = 116
      Width = 239
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 7
      OnChange = PonNombre
      DataField = 'descripcion_p'
      DataSource = DSMaestro
    end
    object logifruit_p: TDBCheckBox
      Left = 140
      Top = 142
      Width = 17
      Height = 17
      DataField = 'logifruit_p'
      DataSource = DSMaestro
      TabOrder = 8
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
  end
  object RejillaFlotante: TBGrid
    Left = 152
    Top = 253
    Width = 137
    Height = 132
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
    DataSet = QPesos
    Left = 40
    Top = 8
  end
  object ACosecheros: TActionList
    Top = 96
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QPesos: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_pesos Frf_pesos')
    Left = 8
    Top = 9
  end
end
