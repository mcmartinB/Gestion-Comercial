object FArticuloDesglose: TFArticuloDesglose
  Left = 617
  Top = 154
  ActiveControl = DBGrid
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'DESGLOSE DE PRODUCTOS POR ARTICULO'
  ClientHeight = 346
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblCodigo1: TnbLabel
    Left = 22
    Top = 144
    Width = 60
    Height = 21
    Caption = 'Porcentaje'
    About = 'NB 0.1/20020725'
  end
  object Label1: TLabel
    Left = 24
    Top = 117
    Width = 65
    Height = 19
    AutoSize = False
    Caption = ' Producto'
    Layout = tlCenter
  end
  object BGBProducto: TBGridButton
    Left = 125
    Top = 117
    Width = 15
    Height = 21
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
    OnClick = BGBProductoClick
    Control = producto_desglose_ad
    Grid = RejillaFlotante
    GridAlignment = taDownCenter
    GridWidth = 280
    GridHeigth = 200
  end
  object nbLabel1: TnbLabel
    Left = 137
    Top = 144
    Width = 15
    Height = 21
    Caption = '%'
    About = 'NB 0.1/20020725'
  end
  object LPorcentaje: TLabel
    Left = 386
    Top = 101
    Width = 71
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'LPorcentaje'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 29
    Width = 475
    Height = 61
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 1
    object nbLabel3: TnbLabel
      Left = 24
      Top = 10
      Width = 100
      Height = 21
      Caption = 'Art'#237'culo'
      About = 'NB 0.1/20020725'
    end
    object lblEnvase: TnbStaticText
      Left = 164
      Top = 10
      Width = 298
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object nbLabel2: TnbLabel
      Left = 24
      Top = 35
      Width = 100
      Height = 21
      Caption = 'Producto'
      About = 'NB 0.1/20020725'
    end
    object lblProducto: TnbStaticText
      Left = 129
      Top = 35
      Width = 298
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object envase: TnbDBAlfa
      Left = 88
      Top = 10
      Width = 75
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      OnChange = envaseChange
      Enabled = False
      TabOrder = 0
    end
    object producto: TnbDBAlfa
      Left = 88
      Top = 35
      Width = 40
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      OnChange = productoChange
      Enabled = False
      TabOrder = 1
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 475
    Height = 29
    ButtonHeight = 21
    ButtonWidth = 50
    Caption = 'ToolBar1'
    ShowCaptions = True
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = AAnyadir
    end
    object ToolButton2: TToolButton
      Left = 50
      Top = 0
      Action = AModificar
    end
    object ToolButton3: TToolButton
      Left = 100
      Top = 0
      Action = ABorrar
    end
    object ToolButton4: TToolButton
      Left = 150
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object ToolButton5: TToolButton
      Left = 158
      Top = 0
      Action = AAceptar
    end
    object ToolButton6: TToolButton
      Left = 208
      Top = 0
      Action = ACancelar
    end
    object ToolButton8: TToolButton
      Left = 258
      Top = 0
      Width = 8
      Caption = 'ToolButton8'
      ImageIndex = 6
      Style = tbsSeparator
    end
    object ToolButton7: TToolButton
      Left = 266
      Top = 0
      Action = ACerrar
    end
  end
  object RejillaFlotante: TBGrid
    Left = 398
    Top = 187
    Width = 113
    Height = 49
    Color = clInfoBk
    DataSource = DMBaseDatos.DSQDespegables
    Options = [dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object producto_desglose_ad: TBDEdit
    Left = 88
    Top = 117
    Width = 37
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 4
    OnChange = producto_desglose_adChange
    DataField = 'producto_desglose_ad'
    DataSource = DataSource
    Modificable = False
  end
  object desProdDesglose: TStaticText
    Left = 142
    Top = 119
    Width = 163
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 5
  end
  object porcentaje_ad: TBDEdit
    Left = 88
    Top = 144
    Width = 52
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 2
    MaxLength = 5
    TabOrder = 6
    OnChange = producto_desglose_adChange
    DataField = 'porcentaje_ad'
    DataSource = DataSource
    Modificable = False
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 176
    Width = 475
    Height = 169
    TabStop = False
    DataSource = DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'producto_desglose_ad'
        Title.Alignment = taCenter
        Title.Caption = 'Prod. Desglose'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descripProducto'
        Title.Alignment = taCenter
        Title.Caption = 'Descripci'#243'n'
        Width = 280
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'porcentaje_ad'
        Title.Alignment = taCenter
        Title.Caption = 'Porcentaje (%)'
        Visible = True
      end>
  end
  object Query: TQuery
    BeforePost = QueryBeforePost
    OnCalcFields = QueryCalcFields
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'Select * from frf_articulos_desglose')
    Left = 32
    Top = 233
    object strngfldQueryarticulo_ad: TStringField
      DisplayWidth = 9
      FieldName = 'articulo_ad'
      Origin = '"COMER.BAG".frf_articulos_desglose.articulo_ad'
      FixedChar = True
      Size = 9
    end
    object strngfldQueryproducto_ad: TStringField
      DisplayWidth = 3
      FieldName = 'producto_ad'
      Origin = '"COMER.BAG".frf_articulos_desglose.producto_ad'
      FixedChar = True
      Size = 3
    end
    object strngfldQueryproducto_desglose_ad: TStringField
      DisplayWidth = 3
      FieldName = 'producto_desglose_ad'
      Origin = '"COMER.BAG".frf_articulos_desglose.producto_desglose_ad'
      FixedChar = True
      Size = 3
    end
    object Queryporcentaje_ad: TFloatField
      FieldName = 'porcentaje_ad'
    end
    object QuerydescripProducto: TStringField
      FieldKind = fkCalculated
      FieldName = 'descripProducto'
      Size = 60
      Calculated = True
    end
  end
  object DataSource: TDataSource
    AutoEdit = False
    DataSet = Query
    Left = 64
    Top = 233
  end
  object ActionList: TActionList
    OnUpdate = ActionListUpdate
    Left = 432
    Top = 104
    object AAnyadir: TAction
      Caption = 'A'#241'adir'
      ShortCut = 187
      OnExecute = AAnyadirExecute
    end
    object ABorrar: TAction
      Caption = 'Borrar'
      ShortCut = 111
      OnExecute = ABorrarExecute
    end
    object AModificar: TAction
      Caption = 'Modificar'
      ShortCut = 77
      OnExecute = AModificarExecute
    end
    object AAceptar: TAction
      Caption = 'Aceptar'
      ShortCut = 112
      OnExecute = AAceptarExecute
    end
    object ACancelar: TAction
      Caption = 'Cancelar'
      ShortCut = 27
      OnExecute = ACancelarExecute
    end
    object ACerrar: TAction
      Caption = 'Cerrar'
      OnExecute = ACerrarExecute
    end
  end
end
