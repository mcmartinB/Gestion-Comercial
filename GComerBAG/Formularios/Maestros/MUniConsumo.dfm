object FMUniConsumo: TFMUniConsumo
  Left = 350
  Top = 254
  ActiveControl = empresa_uc
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = ' UNIDADES DE CONSUMO'
  ClientHeight = 361
  ClientWidth = 514
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
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 514
    Height = 361
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 60
      Top = 46
      Width = 80
      Height = 13
      AutoSize = False
      Caption = 'Empresa '
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 60
      Top = 72
      Width = 80
      Height = 13
      AutoSize = False
      Caption = 'C'#243'digo'
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 60
      Top = 124
      Width = 80
      Height = 13
      AutoSize = False
      Caption = 'Descripci'#243'n'
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 60
      Top = 166
      Width = 80
      Height = 13
      AutoSize = False
      Caption = 'Notas'
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 60
      Top = 227
      Width = 80
      Height = 13
      AutoSize = False
      Caption = 'Peso Envase'
      Layout = tlCenter
    end
    object lblPesoProducto: TLabel
      Left = 60
      Top = 255
      Width = 80
      Height = 13
      AutoSize = False
      Caption = 'Peso Producto'
      Layout = tlCenter
    end
    object BGBEmpresa_uc: TBGridButton
      Left = 176
      Top = 45
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
      Control = empresa_uc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object BGBProducto_uc: TBGridButton
      Left = 404
      Top = 95
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
      Control = producto_uc
      Grid = RejillaFlotante
      GridAlignment = taDownLeft
      GridWidth = 280
      GridHeigth = 200
    end
    object Label3: TLabel
      Left = 60
      Top = 98
      Width = 80
      Height = 13
      AutoSize = False
      Caption = 'Producto'
      Layout = tlCenter
    end
    object empresa_uc: TBDEdit
      Left = 145
      Top = 45
      Width = 32
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      MaxLength = 3
      TabOrder = 0
      OnChange = ponNombre
      DataField = 'empresa_uc'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object codigo_uc: TBDEdit
      Left = 145
      Top = 70
      Width = 32
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      MaxLength = 3
      TabOrder = 2
      DataField = 'codigo_uc'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object producto_uc: TBDEdit
      Left = 145
      Top = 95
      Width = 15
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      MaxLength = 3
      TabOrder = 4
      OnChange = producto_ucChange
      DataField = 'producto_uc'
      DataSource = DSMaestro
    end
    object descripcion1_uc: TBDEdit
      Left = 145
      Top = 121
      Width = 272
      Height = 21
      ColorEdit = clMoneyGreen
      TabOrder = 5
      DataField = 'descripcion1_uc'
      DataSource = DSMaestro
    end
    object peso_envase_uc: TBDEdit
      Left = 145
      Top = 225
      Width = 56
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 3
      ShowDecimals = True
      MaxLength = 7
      TabOrder = 7
      DataField = 'peso_envase_uc'
      DataSource = DSMaestro
    end
    object peso_producto_uc: TBDEdit
      Left = 145
      Top = 251
      Width = 56
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 3
      ShowDecimals = True
      MaxLength = 7
      TabOrder = 8
      DataField = 'peso_producto_uc'
      DataSource = DSMaestro
    end
    object descripcion2_uc: TDBMemo
      Left = 145
      Top = 148
      Width = 272
      Height = 72
      DataField = 'descripcion2_uc'
      DataSource = DSMaestro
      TabOrder = 6
      WantReturns = False
    end
    object descripcion_p: TBDEdit
      Left = 145
      Top = 95
      Width = 258
      Height = 21
      ColorEdit = clMoneyGreen
      ReadOnly = True
      TabOrder = 3
      OnChange = descripcion_pChange
      DataField = 'producto_uc'
      DataSource = DSMaestro
    end
    object STEmpresa_uc: TStaticText
      Left = 192
      Top = 47
      Width = 215
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
  end
  object RejillaFlotante: TBGrid
    Left = 304
    Top = 246
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
  object ACosecheros: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 240
    Top = 64
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
    object ACampos: TAction
      Caption = 'Mantenimiento de Campos (F3)'
      ShortCut = 114
    end
  end
  object DSMaestro: TDataSource
    DataSet = QUndConsumo
    Left = 304
    Top = 64
  end
  object QUndConsumo: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'select * from frf_und_consumo'
      'order by 1,2')
    Left = 272
    Top = 64
  end
end
