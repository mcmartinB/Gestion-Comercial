object FMEnvasesComerciales: TFMEnvasesComerciales
  Left = 549
  Top = 225
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  GESTION ENVASES COMERCIALES/RETORNABLES'
  ClientHeight = 463
  ClientWidth = 594
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
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 594
    Height = 89
    Align = alTop
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lblCodigo: TLabel
      Left = 24
      Top = 20
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo Operador'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LDescripcion_m: TLabel
      Left = 24
      Top = 43
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object cod_operador_eco: TBDEdit
      Left = 112
      Top = 19
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      MaxLength = 3
      TabOrder = 0
      DataField = 'cod_operador_eco'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object des_operador_eco: TBDEdit
      Left = 112
      Top = 42
      Width = 233
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 1
      DataField = 'des_operador_eco'
      DataSource = DSMaestro
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 89
    Width = 594
    Height = 374
    ActivePage = tsAlmacenes
    Align = alClient
    TabIndex = 0
    TabOrder = 2
    OnChange = PageControlChange
    object tsAlmacenes: TTabSheet
      Caption = 'Almacenes'
      object PAlmacenes: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 57
        Align = alTop
        TabOrder = 0
        Visible = False
        object Label1: TLabel
          Left = 72
          Top = 20
          Width = 101
          Height = 19
          AutoSize = False
          Caption = ' Almac'#233'n / Nombre'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object cod_almacen_eca: TBDEdit
          Left = 177
          Top = 19
          Width = 30
          Height = 21
          ColorEdit = clMoneyGreen
          Zeros = True
          OnRequiredTime = RequiredTime
          MaxLength = 3
          TabOrder = 0
          DataField = 'cod_almacen_eca'
          DataSource = dsAlmacenes
          Modificable = False
          PrimaryKey = True
        end
        object des_almacen_eca: TBDEdit
          Left = 210
          Top = 19
          Width = 209
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 30
          TabOrder = 1
          DataField = 'des_almacen_eca'
          DataSource = dsAlmacenes
        end
      end
      object RAlmacenes: TDBGrid
        Left = 0
        Top = 57
        Width = 586
        Height = 289
        Align = alClient
        DataSource = dsAlmacenes
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'cod_almacen_eca'
            Title.Caption = 'Almac'#233'n'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'des_almacen_eca'
            Title.Caption = 'Nombre'
            Width = 374
            Visible = True
          end>
      end
    end
    object tsEnvases: TTabSheet
      Caption = 'Envases'
      ImageIndex = 1
      object RProductos: TDBGrid
        Left = 0
        Top = 57
        Width = 586
        Height = 289
        Align = alClient
        DataSource = DSProductos
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'cod_producto_ecp'
            Title.Caption = 'C'#243'digo'
            Width = 76
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'des_producto_ecp'
            Title.Caption = 'Descripci'#243'n'
            Width = 452
            Visible = True
          end>
      end
      object PProductos: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 57
        Align = alTop
        TabOrder = 0
        Visible = False
        object lbl1: TLabel
          Left = 67
          Top = 20
          Width = 108
          Height = 19
          AutoSize = False
          Caption = ' C'#243'digo / Descripci'#243'n'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object cod_producto_ecp: TBDEdit
          Left = 177
          Top = 19
          Width = 55
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 5
          TabOrder = 0
          DataField = 'cod_producto_ecp'
          DataSource = DSProductos
          Modificable = False
          PrimaryKey = True
        end
        object des_producto_ecp: TBDEdit
          Left = 235
          Top = 19
          Width = 209
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 30
          TabOrder = 1
          DataField = 'des_producto_ecp'
          DataSource = DSProductos
        end
      end
    end
  end
  object RejillaFlotante: TBGrid
    Left = 512
    Top = 16
    Width = 73
    Height = 57
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
    DataSet = QOperadores
    Left = 288
    Top = 8
  end
  object ACosecheros: TActionList
    Images = DMBaseDatos.ImgBotones
    Top = 104
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QOperadores: TQuery
    AfterOpen = QOperadoresAfterOpen
    BeforeClose = QOperadoresBeforeClose
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_cosecheros'
      'ORDER BY empresa_c, cosechero_c')
    Left = 256
    Top = 8
  end
  object QAlmacenes: TQuery
    OnNewRecord = QAlmacenesNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_proveedores_almacen')
    Left = 104
    Top = 368
  end
  object dsAlmacenes: TDataSource
    DataSet = QAlmacenes
    Left = 136
    Top = 368
  end
  object QProductos: TQuery
    OnNewRecord = QProductosNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_productos_proveedor'
      '')
    Left = 368
    Top = 368
  end
  object DSProductos: TDataSource
    DataSet = QProductos
    Left = 400
    Top = 368
  end
end
