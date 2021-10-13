object FPrecioDiarioEnvases: TFPrecioDiarioEnvases
  Left = 311
  Top = 256
  ActiveControl = empresa_epd
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    PRECIO DIARIO POR ART'#205'CULOS (EUR/KG)'
  ClientHeight = 617
  ClientWidth = 704
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
    Width = 704
    Height = 186
    Align = alTop
    TabOrder = 0
    object lblNombre1: TLabel
      Left = 53
      Top = 140
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Precio'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblCoste: TLabel
      Left = 53
      Top = 23
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Fecha'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblEmpresa: TLabel
      Left = 53
      Top = 69
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblProducto: TLabel
      Left = 53
      Top = 92
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblEnvse: TLabel
      Left = 53
      Top = 115
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Art'#237'culo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object stEmpresa: TnbStaticText
      Left = 208
      Top = 69
      Width = 242
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object stProducto: TnbStaticText
      Left = 208
      Top = 92
      Width = 242
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object stEnvase: TnbStaticText
      Left = 260
      Top = 115
      Width = 190
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object lblEuroKg: TLabel
      Left = 286
      Top = 143
      Width = 32
      Height = 13
      Caption = 'Euros/'
    end
    object lblPvp: TLabel
      Left = 208
      Top = 140
      Width = 43
      Height = 19
      AutoSize = False
      Caption = 'PVP'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object precio_epd: TBDEdit
      Left = 156
      Top = 139
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'Introduce el coste del personal.'
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 4
      ShowDecimals = True
      MaxLength = 7
      TabOrder = 5
      DataField = 'precio_epd'
      DataSource = DSPrecioDiario
    end
    object empresa_epd: TBDEdit
      Left = 156
      Top = 68
      Width = 30
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'Ingtroduce el c'#243'digo de la empresa.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 1
      OnChange = empresa_epdChange
      DataField = 'empresa_epd'
      DataSource = DSPrecioDiario
      Modificable = False
      PrimaryKey = True
    end
    object producto_epd: TBDEdit
      Left = 156
      Top = 91
      Width = 30
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce el c'#243'digo del producto.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 2
      OnChange = producto_epdChange
      DataField = 'producto_epd'
      DataSource = DSPrecioDiario
      Modificable = False
      PrimaryKey = True
    end
    object fecha_epd: TBDEdit
      Left = 156
      Top = 22
      Width = 77
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'Introduce el coste del material.'
      OnRequiredTime = RequiredTime
      InputType = itDate
      ShowDecimals = True
      TabOrder = 0
      DataField = 'fecha_epd'
      DataSource = DSPrecioDiario
    end
    object und_factura_epd: TBDEdit
      Left = 320
      Top = 139
      Width = 18
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'Introduce el coste del personal.'
      OnRequiredTime = RequiredTime
      ShowDecimals = True
      MaxLength = 1
      TabOrder = 7
      DataField = 'und_factura_epd'
      DataSource = DSPrecioDiario
    end
    object pvp_epd: TBDEdit
      Left = 234
      Top = 139
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'Introduce el coste del personal.'
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 4
      ShowDecimals = True
      MaxLength = 7
      TabOrder = 6
      DataField = 'pvp_epd'
      DataSource = DSPrecioDiario
    end
    object envase_epd: TcxDBTextEdit
      Left = 156
      Top = 115
      DataBinding.DataField = 'envase_epd'
      DataBinding.DataSource = DSPrecioDiario
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 9
      Properties.OnChange = envase_epdChange
      Style.BorderStyle = ebs3D
      Style.LookAndFeel.Kind = lfUltraFlat
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.Kind = lfUltraFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.Kind = lfUltraFlat
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.Kind = lfUltraFlat
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 3
      OnExit = envase_epdExit
      Width = 75
    end
    object ssEnvase: TSimpleSearch
      Left = 231
      Top = 114
      Width = 21
      Height = 21
      Hint = 'B'#250'squeda de Art'#237'culo'
      TabOrder = 4
      TabStop = False
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'MoneyTwins'
      OptionsImage.ImageIndex = 2
      OptionsImage.Images = FDM.ilxImagenes
      Titulo = 'Busqueda de Art'#237'culos'
      Tabla = 'frf_envases'
      Campos = <
        item
          Etiqueta = 'Art'#237'culo'
          Campo = 'envase_e'
          Ancho = 100
          Tipo = ctCadena
        end
        item
          Etiqueta = 'Descripci'#243'n'
          Campo = 'descripcion_e'
          Ancho = 400
          Tipo = ctCadena
        end>
      Database = 'BDProyecto'
      Join = 'fecha_baja_e is null'
      CampoResultado = 'envase_e'
      Enlace = envase_epd
      Tecla = 'F2'
      AntesEjecutar = ssEnvaseAntesEjecutar
      Concatenar = False
    end
  end
  object dbgPrecios: TDBGrid
    Left = 0
    Top = 186
    Width = 704
    Height = 431
    Align = alClient
    DataSource = DSPrecioDiario
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
        FieldName = 'empresa_epd'
        Title.Alignment = taCenter
        Title.Caption = 'Empresa'
        Width = 55
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'centro_epd'
        Title.Alignment = taCenter
        Title.Caption = 'Centro'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'des_producto_epd'
        Title.Caption = 'Producto'
        Width = 109
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'des_envase_epd'
        Title.Caption = 'Des. Art'#237'culo'
        Width = 227
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_epd'
        Title.Caption = 'Fecha'
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'precio_epd'
        Title.Alignment = taRightJustify
        Title.Caption = 'Precio'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pvp_epd'
        Title.Alignment = taRightJustify
        Title.Caption = 'PVP'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'und_factura_epd'
        Title.Caption = 'Fact.Por'
        Visible = True
      end>
  end
  object pnlDiaCompleto: TPanel
    Left = 466
    Top = 2
    Width = 185
    Height = 41
    BevelOuter = bvNone
    TabOrder = 1
    object btnDiaCompleto: TButton
      Left = 58
      Top = 3
      Width = 125
      Height = 25
      Caption = 'Grabar D'#237'a Completo'
      TabOrder = 0
      OnClick = btnDiaCompletoClick
    end
  end
  object DSPrecioDiario: TDataSource
    DataSet = QPrecioDiario
    Left = 88
    Top = 328
  end
  object QPrecioDiario: TQuery
    OnCalcFields = QPrecioDiarioCalcFields
    DatabaseName = 'BDProyecto'
    DataSource = dsGuia
    RequestLive = True
    SQL.Strings = (
      'select * from frf_env_precio_diario')
    Left = 56
    Top = 329
    object QPrecioDiarioempresa_epd: TStringField
      FieldName = 'empresa_epd'
      Origin = 'BDPROYECTO.frf_env_precio_diario.empresa_epd'
      FixedChar = True
      Size = 3
    end
    object QPrecioDiarioenvase_epd: TStringField
      FieldName = 'envase_epd'
      Origin = 'BDPROYECTO.frf_env_precio_diario.envase_epd'
      FixedChar = True
      Size = 9
    end
    object QPrecioDiarioproducto_epd: TStringField
      FieldName = 'producto_epd'
      Origin = 'BDPROYECTO.frf_env_precio_diario.producto_epd'
      FixedChar = True
      Size = 3
    end
    object QPrecioDiariofecha_epd: TDateField
      FieldName = 'fecha_epd'
      Origin = 'BDPROYECTO.frf_env_precio_diario.fecha_epd'
    end
    object QPrecioDiarioprecio_epd: TFloatField
      FieldName = 'precio_epd'
      Origin = 'BDPROYECTO.frf_env_precio_diario.precio_epd'
    end
    object QPrecioDiariodes_envase_epd: TStringField
      DisplayWidth = 50
      FieldKind = fkCalculated
      FieldName = 'des_envase_epd'
      Size = 50
      Calculated = True
    end
    object QPrecioDiariound_factura_epd: TStringField
      FieldName = 'und_factura_epd'
      Origin = 'BDPROYECTO.frf_env_precio_diario.und_factura_epd'
      FixedChar = True
      Size = 1
    end
    object QPrecioDiariodes_producto_epd: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_producto_epd'
      Calculated = True
    end
    object QPrecioDiariocentro_epd: TStringField
      FieldName = 'centro_epd'
      Origin = 'BDPROYECTO.frf_env_precio_diario.centro_epd'
      FixedChar = True
      Size = 3
    end
    object QPrecioDiariopvp_epd: TFloatField
      FieldName = 'pvp_epd'
      Origin = '"COMER.BAG".frf_env_precio_diario.pvp_epd'
    end
  end
  object qGuia: TQuery
    CachedUpdates = True
    AfterOpen = qGuiaAfterOpen
    BeforeClose = qGuiaBeforeClose
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'SELECT empresa_emc, centro_emc, anyo_mes_emc FROM frf_env_mcoste' +
        's '
      ''
      'ORDER BY empresa_emc, centro_emc, anyo_mes_emc desc')
    UpdateObject = sqluGuia
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
