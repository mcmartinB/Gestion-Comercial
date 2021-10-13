object FMSeccContables: TFMSeccContables
  Left = 268
  Top = 200
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = ' SECCIONES CONTABLES'
  ClientHeight = 187
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
    Height = 187
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
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
    object LCuenta: TLabel
      Left = 40
      Top = 72
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Secc. Contable'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
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
      Top = 99
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object seccion_sc: TBDEdit
      Left = 141
      Top = 71
      Width = 92
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce la Secci'#243'n Contable.'
      OnRequiredTime = RequiredTime
      MaxLength = 10
      TabOrder = 3
      DataField = 'seccion_sc'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object descripcion_sc: TBDEdit
      Left = 140
      Top = 98
      Width = 253
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 2
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
    TabOrder = 0
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
  object qryLineas: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'SELECT * '
      'FROM frf_secc_contables'
      'ORDER BY empresa_sc,centro_sc,producto_sc,sec_contable_sc'
      '')
    Left = 153
    Top = 1
  end
  object dsLineas: TDataSource
    DataSet = qryLineas
    Left = 189
    Top = 3
  end
end
