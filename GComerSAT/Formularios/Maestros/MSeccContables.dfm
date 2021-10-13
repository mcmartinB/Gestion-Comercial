object FMSeccContables: TFMSeccContables
  Left = 268
  Top = 200
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = ' SECCIONES CONTABLES'
  ClientHeight = 231
  ClientWidth = 441
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
  OnCanResize = FormCanResize
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
    Width = 441
    Height = 231
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Lcomision: TLabel
      Left = 40
      Top = 105
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
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
    object LAno_semana_p: TLabel
      Left = 40
      Top = 75
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Centro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LCuenta: TLabel
      Left = 40
      Top = 135
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Secc. Contable'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBCentro: TBGridButton
      Left = 179
      Top = 74
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      Control = centro_sc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object BGBProducto: TBGridButton
      Left = 178
      Top = 105
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      Control = producto_sc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object BGBEmpresa: TBGridButton
      Left = 179
      Top = 45
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      Control = empresa_sc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object Label2: TLabel
      Left = 40
      Top = 165
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 238
      Top = 139
      Width = 150
      Height = 13
      Caption = '(ADONIX 10 caracteres resto 3)'
    end
    object producto_sc: TBDEdit
      Left = 141
      Top = 105
      Width = 36
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce el c'#243'digo del Producto.'
      OnRequiredTime = RequiredTime
      ShowDecimals = True
      MaxLength = 3
      TabOrder = 4
      OnChange = PonNombre
      DataField = 'producto_sc'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object sec_contable_sc: TBDEdit
      Left = 141
      Top = 135
      Width = 92
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce la Secci'#243'n Contable.'
      OnRequiredTime = RequiredTime
      MaxLength = 10
      TabOrder = 6
      DataField = 'sec_contable_sc'
      DataSource = DSMaestro
    end
    object descripcion_sc: TBDEdit
      Left = 140
      Top = 164
      Width = 253
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 7
      DataField = 'descripcion_sc'
      DataSource = DSMaestro
    end
    object STEmpresa: TStaticText
      Left = 194
      Top = 47
      Width = 196
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object STCentro: TStaticText
      Left = 194
      Top = 77
      Width = 196
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 3
    end
    object STProducto: TStaticText
      Left = 194
      Top = 107
      Width = 196
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 5
    end
    object centro_sc: TBDEdit
      Left = 141
      Top = 75
      Width = 36
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce el c'#243'digo del Centro.'
      OnRequiredTime = RequiredTime
      MaxLength = 1
      TabOrder = 2
      OnChange = PonNombre
      DataField = 'centro_sc'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object empresa_sc: TBDEdit
      Tag = 1
      Left = 141
      Top = 45
      Width = 36
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'Introduce el c'#243'digo de la Empresa.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = PonNombre
      DataField = 'empresa_sc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
  end
  object RejillaFlotante: TBGrid
    Left = 224
    Top = 5
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
    DataSet = QSeccContables
    Left = 86
    Top = 1
  end
  object ACosecheros: TActionList
    Left = 118
    Top = 1
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QSeccContables: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * '
      'FROM frf_secc_contables'
      'ORDER BY empresa_sc,centro_sc,producto_sc,sec_contable_sc'
      '')
    Left = 58
  end
end
