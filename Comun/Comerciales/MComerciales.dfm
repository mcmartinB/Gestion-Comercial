object FMComerciales: TFMComerciales
  Left = 822
  Top = 226
  BorderIcons = []
  Caption = '  COMERCIALES'
  ClientHeight = 497
  ClientWidth = 515
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 515
    Height = 90
    Align = alTop
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lblComercial: TLabel
      Left = 43
      Top = 38
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo/Nombre'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object codigo_c: TBDEdit
      Left = 128
      Top = 37
      Width = 30
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      DataField = 'codigo_c'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object descripcion_c: TBDEdit
      Left = 162
      Top = 37
      Width = 235
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 1
      DataField = 'descripcion_c'
      DataSource = DSMaestro
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 90
    Width = 515
    Height = 407
    ActivePage = tsClientes
    Align = alClient
    TabOrder = 2
    OnChange = PageControlChange
    object tsClientes: TTabSheet
      Caption = 'Clientes'
      ImageIndex = 1
      object pnlClientes: TPanel
        Left = 0
        Top = 0
        Width = 507
        Height = 65
        Align = alTop
        TabOrder = 0
        Visible = False
        object lblCliente: TLabel
          Left = 6
          Top = 8
          Width = 69
          Height = 19
          AutoSize = False
          Caption = ' Cliente'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object btnCliente: TBGridButton
          Left = 109
          Top = 7
          Width = 13
          Height = 21
          Hint = 'Pulse F2 para ver una lista de valores validos. '
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
          OnClick = ARejillaFlotanteExecute
          Control = cod_cliente_cc
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 280
          GridHeigth = 160
        end
        object Label1: TLabel
          Left = 6
          Top = 30
          Width = 69
          Height = 19
          AutoSize = False
          Caption = ' Producto'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object btnProducto: TBGridButton
          Left = 109
          Top = 29
          Width = 13
          Height = 21
          Hint = 'Pulse F2 para ver una lista de valores validos. '
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
          OnClick = ARejillaFlotanteExecute
          Control = cod_producto_cc
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 280
          GridHeigth = 160
        end
        object cod_cliente_cc: TBDEdit
          Left = 78
          Top = 7
          Width = 30
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 3
          TabOrder = 0
          OnChange = cod_cliente_ccChange
          DataField = 'cod_cliente_cc'
          DataSource = DSClientes
          Modificable = False
        end
        object txtCliente: TStaticText
          Left = 124
          Top = 9
          Width = 293
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 1
        end
        object cod_producto_cc: TBDEdit
          Left = 78
          Top = 29
          Width = 30
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 3
          TabOrder = 2
          OnChange = cod_producto_ccChange
          DataField = 'cod_producto_cc'
          DataSource = DSClientes
          Modificable = False
        end
        object txtProducto: TStaticText
          Left = 124
          Top = 31
          Width = 293
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 3
        end
      end
      object RClientes: TDBGrid
        Left = 0
        Top = 65
        Width = 507
        Height = 314
        Align = alClient
        DataSource = DSClientes
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Visible = False
        Columns = <
          item
            Expanded = False
            FieldName = 'cod_cliente_cc'
            Title.Alignment = taCenter
            Title.Caption = 'Cliente'
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cod_producto_cc'
            Title.Alignment = taCenter
            Title.Caption = 'Producto'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cod_empresa_cc'
            Title.Alignment = taCenter
            Title.Caption = 'Empresa'
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'fecha_ini_cc'
            Title.Alignment = taCenter
            Title.Caption = 'Fecha Inicial'
            Width = 90
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'fecha_fin_cc'
            Title.Alignment = taCenter
            Title.Caption = 'Fecha Final'
            Width = 90
            Visible = True
          end>
      end
      object cxGrid1: TcxGrid
        Left = 0
        Top = 65
        Width = 507
        Height = 314
        Align = alClient
        TabOrder = 2
        OnEnter = cxGrid1Enter
        OnExit = cxGrid1Exit
        object tvDetalle: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          FindPanel.DisplayMode = fpdmAlways
          DataController.DataSource = DSClientes
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          Filtering.ColumnAddValueItems = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          object tvCliente: TcxGridDBColumn
            Caption = 'Cliente'
            DataBinding.FieldName = 'cod_cliente_cc'
            HeaderGlyphAlignmentHorz = taCenter
            MinWidth = 62
            Options.AutoWidthSizable = False
            Options.HorzSizing = False
            Width = 62
          end
          object tvDesCliente: TcxGridDBColumn
            Caption = 'Descripcion'
            DataBinding.FieldName = 'des_cliente'
            Width = 169
          end
          object tvProducto: TcxGridDBColumn
            Caption = 'Producto'
            DataBinding.FieldName = 'cod_producto_cc'
            HeaderGlyphAlignmentHorz = taCenter
            MinWidth = 75
            Options.AutoWidthSizable = False
            Options.HorzSizing = False
            Width = 75
          end
          object tvDesProducto: TcxGridDBColumn
            Caption = 'Descripcion'
            DataBinding.FieldName = 'des_producto'
            Width = 199
          end
        end
        object lvDetalle: TcxGridLevel
          GridView = tvDetalle
        end
      end
    end
  end
  object RejillaFlotante: TBGrid
    Left = 592
    Top = 16
    Width = 73
    Height = 97
    Color = clInfoBk
    DataSource = DMBaseDatos.DSQGeneral
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
    ColumnFind = 1
  end
  object DSMaestro: TDataSource
    DataSet = qryComerciales
    Left = 360
    Top = 16
  end
  object qryComerciales: TQuery
    AutoCalcFields = False
    AfterOpen = qryComercialesAfterOpen
    BeforeClose = qryComercialesBeforeClose
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 328
    Top = 16
  end
  object qryClientes: TQuery
    BeforePost = qryClientesBeforePost
    OnCalcFields = qryClientesCalcFields
    OnNewRecord = qryClientesNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    Left = 328
    Top = 48
    object qryClientescod_comercial_cc: TStringField
      FieldName = 'cod_comercial_cc'
      Size = 3
    end
    object qryClientescod_cliente_cc: TStringField
      FieldName = 'cod_cliente_cc'
      Size = 9
    end
    object qryClientescod_producto_cc: TStringField
      FieldName = 'cod_producto_cc'
      Size = 9
    end
    object qryClientesdes_cliente: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_cliente'
      Size = 50
      Calculated = True
    end
    object qryClientesdes_producto: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_producto'
      Size = 30
      Calculated = True
    end
  end
  object DSClientes: TDataSource
    DataSet = qryClientes
    Left = 360
    Top = 48
  end
  object qryClientesAux: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    Left = 402
    Top = 17
  end
  object AComerciales: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 123
    Top = 458
    object ARejillaFlotante: TAction
      Caption = 'ARejillaFlotante'
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
    object ADModificar: TAction
      Caption = 'ADModificar'
      ShortCut = 77
    end
  end
end
