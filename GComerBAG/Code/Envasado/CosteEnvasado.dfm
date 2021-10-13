object FCosteEnvasado: TFCosteEnvasado
  Left = 605
  Top = 218
  ActiveControl = empresa_ec
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    COSTES DE ENVASADO POR KILO'
  ClientHeight = 617
  ClientWidth = 590
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
    Width = 590
    Height = 250
    Align = alTop
    TabOrder = 0
    object lblNombre1: TLabel
      Left = 53
      Top = 174
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Coste de Personal'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblCoste: TLabel
      Left = 53
      Top = 196
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Coste de Material'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblMes: TLabel
      Left = 53
      Top = 67
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Mes'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
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
    object lblProducto: TLabel
      Left = 53
      Top = 111
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
      Top = 152
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Art'#237'culo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbAnyo: TLabel
      Left = 53
      Top = 45
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'A'#241'o'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object des_mes: TnbStaticText
      Tag = 1
      Left = 208
      Top = 67
      Width = 245
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object des_empresa: TnbStaticText
      Left = 208
      Top = 23
      Width = 245
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object des_producto: TnbStaticText
      Left = 208
      Top = 111
      Width = 245
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object des_envase: TnbStaticText
      Left = 262
      Top = 152
      Width = 190
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object lblCentro: TLabel
      Left = 53
      Top = 89
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Centro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object des_centro: TnbStaticText
      Left = 208
      Top = 89
      Width = 245
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object lblGeneral: TLabel
      Left = 53
      Top = 219
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Coste Generales'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblEuroKg: TLabel
      Left = 213
      Top = 177
      Width = 45
      Height = 13
      Caption = 'Euros/Kg'
    end
    object lbl1: TLabel
      Left = 213
      Top = 199
      Width = 45
      Height = 13
      Caption = 'Euros/Kg'
    end
    object lbl2: TLabel
      Left = 213
      Top = 222
      Width = 45
      Height = 13
      Caption = 'Euros/Kg'
    end
    object personal_ec: TBDEdit
      Left = 156
      Top = 173
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'Introduce el coste del personal.'
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 4
      ShowDecimals = True
      MaxLength = 7
      TabOrder = 7
      DataField = 'personal_ec'
      DataSource = DSMaestro
    end
    object empresa_ec: TBDEdit
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
      OnChange = empresa_ecChange
      DataField = 'empresa_ec'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object anyo_ec: TBDEdit
      Tag = 1
      Left = 156
      Top = 44
      Width = 40
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce el a'#241'o.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 1
      DataField = 'anyo_ec'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object mes_ec: TBDEdit
      Tag = 1
      Left = 156
      Top = 66
      Width = 20
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce el mes.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 2
      TabOrder = 2
      OnChange = mes_ecChange
      DataField = 'mes_ec'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object producto_ec: TBDEdit
      Left = 156
      Top = 110
      Width = 40
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce el c'#243'digo del producto.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 4
      OnChange = producto_ecChange
      DataField = 'producto_ec'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object material_ec: TBDEdit
      Left = 156
      Top = 195
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'Introduce el coste del material.'
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 4
      ShowDecimals = True
      MaxLength = 7
      TabOrder = 8
      DataField = 'material_ec'
      DataSource = DSMaestro
    end
    object centro_ec: TBDEdit
      Left = 156
      Top = 88
      Width = 14
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce el c'#243'digo del centro.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 1
      TabOrder = 3
      OnChange = centro_ecChange
      DataField = 'centro_ec'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object general_ec: TBDEdit
      Left = 156
      Top = 218
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'Introduce el coste general.'
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 4
      ShowDecimals = True
      MaxLength = 7
      TabOrder = 9
      DataField = 'general_ec'
      DataSource = DSMaestro
    end
    object envase_ec: TcxDBTextEdit
      Left = 156
      Top = 150
      DataBinding.DataField = 'envase_ec'
      DataBinding.DataSource = DSMaestro
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 9
      Properties.OnChange = envase_ecChange
      Style.BorderStyle = ebs3D
      Style.LookAndFeel.Kind = lfUltraFlat
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.Kind = lfUltraFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.Kind = lfUltraFlat
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.Kind = lfUltraFlat
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 5
      OnExit = envase_ecExit
      Width = 75
    end
    object ssEnvase: TSimpleSearch
      Left = 231
      Top = 150
      Width = 21
      Height = 21
      Hint = 'B'#250'squeda de Art'#237'culo'
      TabOrder = 6
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
      Enlace = envase_ec
      Tecla = 'F2'
      AntesEjecutar = ssEnvaseAntesEjecutar
      Concatenar = False
    end
  end
  object dbgEnvasado: TDBGrid
    Left = 0
    Top = 250
    Width = 590
    Height = 367
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
        FieldName = 'envase_ec'
        Title.Alignment = taCenter
        Title.Caption = 'Art'#237'culo'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'des_envase'
        Title.Alignment = taCenter
        Title.Caption = 'Descripci'#243'n'
        Width = 217
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'personal_ec'
        Title.Alignment = taCenter
        Title.Caption = 'Personal'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'material_ec'
        Title.Alignment = taCenter
        Title.Caption = 'Material'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'general_ec'
        Title.Alignment = taCenter
        Title.Caption = 'General'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'coste_total'
        Title.Alignment = taCenter
        Title.Caption = 'Total'
        Visible = True
      end>
  end
  object DSMaestro: TDataSource
    DataSet = QCosteEnvases
    Left = 88
    Top = 328
  end
  object QCosteEnvases: TQuery
    OnCalcFields = QCosteEnvasesCalcFields
    DatabaseName = 'BDProyecto'
    DataSource = dsGuia
    RequestLive = True
    SQL.Strings = (
      'select * '
      'from frf_env_costes')
    Left = 56
    Top = 329
    object QCosteEnvasesanyo_ec: TSmallintField
      FieldName = 'anyo_ec'
      Origin = '"COMER.DESARROLLO".frf_envase_costes.anyo_ec'
    end
    object QCosteEnvasesmes_ec: TSmallintField
      FieldName = 'mes_ec'
      Origin = '"COMER.DESARROLLO".frf_envase_costes.mes_ec'
    end
    object QCosteEnvasesempresa_ec: TStringField
      FieldName = 'empresa_ec'
      Origin = '"COMER.DESARROLLO".frf_envase_costes.empresa_ec'
      FixedChar = True
      Size = 3
    end
    object QCosteEnvasescentro_ec: TStringField
      FieldName = 'centro_ec'
      Origin = 'COMERCIALIZACION.frf_env_costes.centro_ec'
      FixedChar = True
      Size = 1
    end
    object QCosteEnvasesenvase_ec: TStringField
      DisplayWidth = 9
      FieldName = 'envase_ec'
      Origin = '"COMER.DESARROLLO".frf_envase_costes.envase_ec'
      FixedChar = True
      Size = 9
    end
    object QCosteEnvasesproducto_ec: TStringField
      FieldName = 'producto_ec'
      Origin = '"COMER.DESARROLLO".frf_envase_costes.producto_ec'
      Size = 3
    end
    object QCosteEnvasesdes_envase: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_envase'
      Size = 30
      Calculated = True
    end
    object QCosteEnvasescoste_total: TFloatField
      FieldKind = fkCalculated
      FieldName = 'coste_total'
      Calculated = True
    end
    object QCosteEnvasesformato_ec: TStringField
      FieldName = 'formato_ec'
      Origin = 'BDPROYECTO.frf_env_costes.formato_ec'
      FixedChar = True
      Size = 5
    end
    object QCosteEnvasesmaterial_ec: TFloatField
      FieldName = 'material_ec'
      Origin = 'BDPROYECTO.frf_env_costes.material_ec'
    end
    object QCosteEnvasespersonal_ec: TFloatField
      FieldName = 'personal_ec'
      Origin = 'BDPROYECTO.frf_env_costes.personal_ec'
    end
    object QCosteEnvasesgeneral_ec: TFloatField
      FieldName = 'general_ec'
      Origin = 'BDPROYECTO.frf_env_costes.general_ec'
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
