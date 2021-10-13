object FSobrepesoEnvasado: TFSobrepesoEnvasado
  Left = 647
  Top = 236
  ActiveControl = empresa_es
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'SOBREPESO DE ENVASADO POR KILOGRAMO'
  ClientHeight = 570
  ClientWidth = 439
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
    Width = 439
    Height = 188
    Align = alTop
    TabOrder = 0
    object lblPeso: TLabel
      Left = 28
      Top = 148
      Width = 75
      Height = 19
      AutoSize = False
      Caption = 'Sobrepeso'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblMes: TLabel
      Left = 28
      Top = 65
      Width = 75
      Height = 19
      AutoSize = False
      Caption = 'Mes'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblEmpresa: TLabel
      Left = 28
      Top = 19
      Width = 75
      Height = 19
      AutoSize = False
      Caption = 'Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblEnvase: TLabel
      Left = 28
      Top = 125
      Width = 75
      Height = 19
      AutoSize = False
      Caption = 'Art'#237'culo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblAnyo: TLabel
      Left = 28
      Top = 41
      Width = 75
      Height = 19
      AutoSize = False
      Caption = 'A'#241'o'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object des_mes: TnbStaticText
      Tag = 1
      Left = 150
      Top = 64
      Width = 248
      Height = 21
      Caption = 'des_mes'
      About = 'NB 0.1/20020725'
    end
    object des_empresa: TnbStaticText
      Left = 142
      Top = 18
      Width = 190
      Height = 21
      Caption = 'des_empresa'
      About = 'NB 0.1/20020725'
    end
    object des_envase: TnbStaticText
      Left = 208
      Top = 124
      Width = 190
      Height = 21
      Caption = 'des_envase'
      About = 'NB 0.1/20020725'
    end
    object lblProducto: TLabel
      Left = 28
      Top = 88
      Width = 75
      Height = 19
      AutoSize = False
      Caption = 'Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object des_producto: TnbStaticText
      Left = 150
      Top = 87
      Width = 248
      Height = 21
      Caption = 'des_producto'
      About = 'NB 0.1/20020725'
    end
    object Label1: TLabel
      Left = 159
      Top = 151
      Width = 123
      Height = 13
      Caption = '(Porcentaje por kilogramo)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object empresa_es: TBDEdit
      Left = 108
      Top = 18
      Width = 30
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'Introduce el c'#243'digo de la empresa.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = empresa_esChange
      DataField = 'empresa_es'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object anyo_es: TBDEdit
      Tag = 1
      Left = 108
      Top = 41
      Width = 40
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce el a'#241'o. '
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 1
      DataField = 'anyo_es'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object mes_es: TBDEdit
      Tag = 1
      Left = 108
      Top = 64
      Width = 20
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce el mes. '
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 2
      TabOrder = 2
      OnChange = mes_esChange
      DataField = 'mes_es'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object producto_es: TBDEdit
      Left = 108
      Top = 87
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce el c'#243'digo del mes.'
      MaxLength = 3
      TabOrder = 3
      OnChange = producto_esChange
      DataField = 'producto_es'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object peso_es: TBDEdit
      Left = 107
      Top = 147
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'Introduce la comisi'#243'n de cambio'
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 2
      ShowDecimals = True
      MaxLength = 7
      TabOrder = 6
      DataField = 'peso_es'
      DataSource = DSMaestro
    end
    object envase_es: TcxDBTextEdit
      Left = 107
      Top = 124
      DataBinding.DataField = 'envase_es'
      DataBinding.DataSource = DSMaestro
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 9
      Properties.OnChange = envase_esChange
      Style.BorderStyle = ebs3D
      Style.LookAndFeel.Kind = lfUltraFlat
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.Kind = lfUltraFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.Kind = lfUltraFlat
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.Kind = lfUltraFlat
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 4
      OnExit = envase_esExit
      Width = 75
    end
    object ssEnvase: TSimpleSearch
      Left = 182
      Top = 124
      Width = 21
      Height = 21
      Hint = 'B'#250'squeda de Art'#237'culo'
      TabOrder = 5
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
      Enlace = envase_es
      Tecla = 'F2'
      AntesEjecutar = ssEnvaseAntesEjecutar
      Concatenar = False
    end
  end
  object dbgEnvasado: TDBGrid
    Left = 0
    Top = 188
    Width = 439
    Height = 382
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
        FieldName = 'envase_es'
        Title.Alignment = taCenter
        Title.Caption = 'Art'#237'culo'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'des_envase'
        Title.Alignment = taCenter
        Title.Caption = 'Descripci'#243'n'
        Width = 240
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'peso_es'
        Title.Alignment = taCenter
        Title.Caption = 'Sobrepeso'
        Visible = True
      end>
  end
  object DSMaestro: TDataSource
    DataSet = QCosteEnvases
    Left = 88
    Top = 320
  end
  object QCosteEnvases: TQuery
    OnCalcFields = QCosteEnvasesCalcFields
    DatabaseName = 'BDProyecto'
    DataSource = dsGuia
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_env_sobrepeso')
    Left = 56
    Top = 321
    object QCosteEnvasesempresa_es: TStringField
      FieldName = 'empresa_es'
      Origin = 'COMERCIALIZACION.frf_env_sobrepeso.empresa_es'
      FixedChar = True
      Size = 3
    end
    object QCosteEnvasesanyo_es: TSmallintField
      FieldName = 'anyo_es'
      Origin = 'COMERCIALIZACION.frf_env_sobrepeso.anyo_es'
    end
    object QCosteEnvasesmes_es: TSmallintField
      FieldName = 'mes_es'
      Origin = 'COMERCIALIZACION.frf_env_sobrepeso.mes_es'
    end
    object QCosteEnvasesenvase_es: TStringField
      DisplayWidth = 9
      FieldName = 'envase_es'
      Origin = 'COMERCIALIZACION.frf_env_sobrepeso.envase_es'
      FixedChar = True
      Size = 9
    end
    object QCosteEnvasespeso_es: TFloatField
      FieldName = 'peso_es'
      Origin = 'COMERCIALIZACION.frf_env_sobrepeso.peso_es'
    end
    object QCosteEnvasesdes_envase: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_envase'
      Size = 30
      Calculated = True
    end
    object QCosteEnvasesproducto_es: TStringField
      FieldName = 'producto_es'
      Origin = 'COMERCIALIZACION.frf_env_sobrepeso.producto_es'
      FixedChar = True
      Size = 3
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
