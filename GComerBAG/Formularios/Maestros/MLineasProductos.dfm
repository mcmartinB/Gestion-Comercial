object FMLineasProductos: TFMLineasProductos
  Left = 377
  Top = 214
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = ' L'#205'NEAS PRODUCTO'
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
    object LCuenta: TLabel
      Left = 40
      Top = 57
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' L'#205'nea Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 40
      Top = 84
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object linea_producto_lp: TBDEdit
      Left = 141
      Top = 56
      Width = 26
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce la Secci'#243'n Contable.'
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 0
      DataField = 'linea_producto_lp'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object descripcion_lp: TBDEdit
      Left = 140
      Top = 83
      Width = 253
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 1
      DataField = 'descripcion_lp'
      DataSource = DSMaestro
    end
  end
  object RejillaFlotante: TBGrid
    Left = 224
    Top = -6
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
    DataSet = QLineasProducto
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
    end
  end
  object QLineasProducto: TQuery
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
