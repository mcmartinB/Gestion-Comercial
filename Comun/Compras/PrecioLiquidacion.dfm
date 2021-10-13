object FPrecioLiquidacion: TFPrecioLiquidacion
  Left = 605
  Top = 218
  ActiveControl = empresa_pl
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '     GRABACION PRECIO PARA ENTREGAS DE PROVEEDOR A LIQUIDAR'
  ClientHeight = 617
  ClientWidth = 726
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
    Width = 726
    Height = 273
    Align = alTop
    TabOrder = 0
    ExplicitTop = -6
    object lblEmpresa: TLabel
      Left = 53
      Top = 23
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblEnvse: TLabel
      Left = 53
      Top = 150
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbAnyo: TLabel
      Left = 53
      Top = 67
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'A'#241'o Semana'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object des_empresa: TnbStaticText
      Left = 208
      Top = 23
      Width = 190
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object des_producto: TnbStaticText
      Left = 208
      Top = 150
      Width = 190
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object lblGeneral: TLabel
      Left = 53
      Top = 216
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Precio'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl2: TLabel
      Left = 213
      Top = 219
      Width = 45
      Height = 13
      Caption = 'Euros/Kg'
    end
    object lblProducto: TLabel
      Left = 53
      Top = 45
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Proveedor'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object des_proveedor: TnbStaticText
      Left = 208
      Top = 45
      Width = 190
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object lbl3: TLabel
      Left = 53
      Top = 172
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Categoria'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object des_categoria: TnbStaticText
      Left = 208
      Top = 172
      Width = 190
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object lbl1: TLabel
      Left = 53
      Top = 194
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Variedad'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object des_variedad: TnbStaticText
      Left = 208
      Top = 194
      Width = 190
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object empresa_pl: TBDEdit
      Left = 156
      Top = 22
      Width = 40
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'Ingtroduce el c'#243'digo de la empresa.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = empresa_plChange
      DataField = 'empresa_pl'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object anyo_semana_pl: TBDEdit
      Tag = 1
      Left = 156
      Top = 66
      Width = 85
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce el a'#241'o.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 6
      TabOrder = 2
      DataField = 'anyo_semana_pl'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object producto_pl: TBDEdit
      Left = 156
      Top = 149
      Width = 40
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'INtroduce el c'#243'digo del producto'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 3
      OnChange = producto_plChange
      DataField = 'producto_pl'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object precio_kg_pl: TBDEdit
      Left = 156
      Top = 215
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'Introduce el coste general.'
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 4
      ShowDecimals = True
      MaxLength = 7
      TabOrder = 6
      DataField = 'precio_kg_pl'
      DataSource = DSMaestro
    end
    object proveedor_pl: TBDEdit
      Left = 156
      Top = 44
      Width = 40
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce el c'#243'digo del producto.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 3
      TabOrder = 1
      OnChange = proveedor_plChange
      DataField = 'proveedor_pl'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object categoria_pl: TBDEdit
      Left = 156
      Top = 171
      Width = 40
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'INtroduce el c'#243'digo de la categoria.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 4
      OnChange = categoria_plChange
      DataField = 'categoria_pl'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object variedad_pl: TBDEdit
      Left = 156
      Top = 193
      Width = 40
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'INtroduce el c'#243'digo de la variedad'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 5
      OnChange = variedad_plChange
      DataField = 'variedad_pl'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
  end
  object dgbCostes: TDBGrid
    Left = 0
    Top = 273
    Width = 726
    Height = 344
    Align = alClient
    DataSource = DSMaestro
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'producto_pl'
        Title.Alignment = taCenter
        Title.Caption = 'Producto'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'des_producto'
        Title.Alignment = taCenter
        Title.Caption = 'Descripci'#243'n'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'categoria_pl'
        Title.Alignment = taCenter
        Title.Caption = 'Categoria'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'des_categoria'
        Title.Alignment = taCenter
        Title.Caption = 'Descripci'#243'n'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'variedad_pl'
        Title.Alignment = taCenter
        Title.Caption = 'Variedad'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'des_variedad'
        Title.Alignment = taCenter
        Title.Caption = 'Descripci'#243'n'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'precio_kg_pl'
        Title.Alignment = taCenter
        Title.Caption = 'Precio / Kg'
        Width = 61
        Visible = True
      end>
  end
  object DSMaestro: TDataSource
    DataSet = QPrecioLiquidacion
    Left = 88
    Top = 328
  end
  object QPrecioLiquidacion: TQuery
    AfterPost = QPrecioLiquidacionAfterPost
    OnCalcFields = QPrecioLiquidacionCalcFields
    DatabaseName = 'BDProyecto'
    DataSource = dsGuia
    RequestLive = True
    SQL.Strings = (
      'select * '
      'from frf_precio_liquidacion')
    Left = 56
    Top = 329
    object QPrecioLiquidacionempresa_pl: TStringField
      FieldName = 'empresa_pl'
      Origin = 'BDPROYECTO.frf_precio_liquidacion.empresa_pl'
      FixedChar = True
      Size = 3
    end
    object QPrecioLiquidacionproveedor_pl: TStringField
      FieldName = 'proveedor_pl'
      Origin = 'BDPROYECTO.frf_precio_liquidacion.proveedor_pl'
      FixedChar = True
      Size = 3
    end
    object iQPrecioLiquidacionanyo_semana_pl: TIntegerField
      FieldName = 'anyo_semana_pl'
      Origin = 'BDPROYECTO.frf_precio_liquidacion.anyo_semana_pl'
    end
    object QPrecioLiquidacionproducto_pl: TStringField
      FieldName = 'producto_pl'
      Origin = 'BDPROYECTO.frf_precio_liquidacion.producto_pl'
      FixedChar = True
      Size = 3
    end
    object QPrecioLiquidacioncategoria_pl: TStringField
      FieldName = 'categoria_pl'
      Origin = 'BDPROYECTO.frf_precio_liquidacion.categoria_pl'
      FixedChar = True
      Size = 2
    end
    object iQPrecioLiquidacionvariedad_pl: TIntegerField
      FieldName = 'variedad_pl'
      Origin = 'BDPROYECTO.frf_precio_liquidacion.variedad_pl'
    end
    object QPrecioLiquidacionprecio_kg_pl: TFloatField
      FieldName = 'precio_kg_pl'
      Origin = 'BDPROYECTO.frf_precio_liquidacion.precio_kg_pl'
    end
    object QPrecioLiquidaciondes_producto: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_producto'
      Calculated = True
    end
    object QPrecioLiquidaciondes_categoria: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_categoria'
      Calculated = True
    end
    object QPrecioLiquidaciondes_variedad: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_variedad'
      Calculated = True
    end
  end
  object qGuia: TQuery
    CachedUpdates = True
    AfterOpen = qGuiaAfterOpen
    BeforeClose = qGuiaBeforeClose
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'SELECT empresa_pl, proveedor_pl, anyo_semana_pl FROM frf_precio_' +
        'liquidacion'
      ''
      'ORDER BY  empresa_pl, proveedor_pl, anyo_semana_pl')
    Left = 56
    Top = 287
  end
  object dsGuia: TDataSource
    DataSet = qGuia
    Left = 88
    Top = 286
  end
  object sqluGuia: TUpdateSQL
    Left = 120
    Top = 288
  end
end
