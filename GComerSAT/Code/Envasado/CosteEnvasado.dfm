object FCosteEnvasado: TFCosteEnvasado
  Left = 278
  Top = 197
  ActiveControl = empresa_ec
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    COSTES DE ENVASADO POR KILO'
  ClientHeight = 446
  ClientWidth = 782
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
  object lbl6: TLabel
    Left = 404
    Top = 135
    Width = 100
    Height = 19
    AutoSize = False
    Caption = 'Promedio Envasado'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 782
    Height = 205
    Align = alTop
    TabOrder = 0
    object lblCoste: TLabel
      Left = 22
      Top = 139
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Coste Envasado'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblMes: TLabel
      Left = 377
      Top = 48
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Mes'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblEmpresa: TLabel
      Left = 22
      Top = 26
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblProducto: TLabel
      Left = 22
      Top = 71
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblEnvse: TLabel
      Left = 22
      Top = 117
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Art'#237'culo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbAnyo: TLabel
      Left = 22
      Top = 48
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
      Left = 532
      Top = 48
      Width = 190
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object des_empresa: TnbStaticText
      Left = 177
      Top = 26
      Width = 190
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object des_producto: TnbStaticText
      Left = 177
      Top = 71
      Width = 190
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object des_envase: TnbStaticText
      Left = 225
      Top = 117
      Width = 249
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object lblCentro: TLabel
      Left = 377
      Top = 26
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Centro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object des_centro: TnbStaticText
      Left = 532
      Top = 26
      Width = 190
      Height = 19
      About = 'NB 0.1/20020725'
    end
    object lblNombre1: TLabel
      Left = 22
      Top = 161
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Coste Secciones'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl1: TLabel
      Left = 216
      Top = 138
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Coste Material'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblTotal: TLabel
      Left = 216
      Top = 160
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Coste Total'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl2: TLabel
      Left = 569
      Top = 138
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Promedio Material'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl3: TLabel
      Left = 569
      Top = 160
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Promedio Total'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl4: TLabel
      Left = 377
      Top = 117
      Width = 343
      Height = 19
      Alignment = taCenter
      AutoSize = False
      Caption = 'Costes Promedio Anual'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl5: TLabel
      Left = 377
      Top = 160
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Promedio Secciones'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl7: TLabel
      Left = 377
      Top = 138
      Width = 100
      Height = 19
      AutoSize = False
      Caption = 'Promedio Envasado'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object empresa_ec: TBDEdit
      Left = 125
      Top = 25
      Width = 30
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
      Left = 125
      Top = 47
      Width = 40
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce el a'#241'o.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 2
      DataField = 'anyo_ec'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object mes_ec: TBDEdit
      Tag = 1
      Left = 480
      Top = 47
      Width = 20
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce el mes.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 2
      TabOrder = 3
      OnChange = mes_ecChange
      DataField = 'mes_ec'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object producto_ec: TBDEdit
      Left = 125
      Top = 70
      Width = 30
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
    object coste_ec: TBDEdit
      Left = 125
      Top = 138
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'Introduce el coste.'
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 4
      ShowDecimals = True
      MaxLength = 7
      TabOrder = 10
      DataField = 'coste_ec'
      DataSource = DSMaestro
    end
    object centro_ec: TBDEdit
      Left = 480
      Top = 25
      Width = 14
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce el c'#243'digo del centro.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 1
      TabOrder = 1
      OnChange = centro_ecChange
      DataField = 'centro_ec'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object secciones_ec: TBDEdit
      Left = 125
      Top = 160
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'Introduce el coste de las secciones.'
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 4
      ShowDecimals = True
      MaxLength = 7
      TabOrder = 14
      DataField = 'secciones_ec'
      DataSource = DSMaestro
    end
    object material_ec: TBDEdit
      Left = 318
      Top = 137
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'Introduce el coste.'
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 4
      ShowDecimals = True
      MaxLength = 7
      TabOrder = 7
      DataField = 'material_ec'
      DataSource = DSMaestro
    end
    object edttotal_ec: TBDEdit
      Left = 318
      Top = 159
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      ColorDisable = clBtnFace
      RequiredMsg = 'Introduce el coste.'
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 4
      ShowDecimals = True
      Enabled = False
      ReadOnly = True
      MaxLength = 7
      TabOrder = 11
      DataField = 'coste_total'
      DataSource = DSMaestro
    end
    object edt2: TBDEdit
      Left = 672
      Top = 137
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      ColorDisable = clBtnFace
      RequiredMsg = 'Introduce el coste.'
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 4
      ShowDecimals = True
      Enabled = False
      ReadOnly = True
      MaxLength = 7
      TabOrder = 9
      DataField = 'pmaterial_ec'
      DataSource = DSMaestro
    end
    object edtcoste_total: TBDEdit
      Left = 672
      Top = 159
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      ColorDisable = clBtnFace
      RequiredMsg = 'Introduce el coste.'
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 4
      ShowDecimals = True
      Enabled = False
      ReadOnly = True
      MaxLength = 7
      TabOrder = 13
      DataField = 'pcoste_total'
      DataSource = DSMaestro
    end
    object edtpcoste_ec: TBDEdit
      Left = 480
      Top = 137
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      ColorDisable = clBtnFace
      RequiredMsg = 'Introduce el coste.'
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 4
      ShowDecimals = True
      Enabled = False
      ReadOnly = True
      MaxLength = 7
      TabOrder = 8
      DataField = 'pcoste_ec'
      DataSource = DSMaestro
    end
    object edtpsecciones_ec: TBDEdit
      Left = 480
      Top = 159
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      ColorDisable = clBtnFace
      RequiredMsg = 'Introduce el coste.'
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 4
      ShowDecimals = True
      Enabled = False
      ReadOnly = True
      MaxLength = 7
      TabOrder = 12
      DataField = 'psecciones_ec'
      DataSource = DSMaestro
    end
    object envase_ec: TcxDBTextEdit
      Left = 125
      Top = 116
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
      Left = 200
      Top = 116
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
    Top = 205
    Width = 782
    Height = 241
    Align = alClient
    DataSource = DSMaestro
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
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
        FieldName = 'envase_ec'
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
        Width = 201
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'coste_ec'
        Title.Alignment = taCenter
        Title.Caption = 'Envasado'
        Width = 57
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'material_ec'
        Title.Alignment = taCenter
        Title.Caption = 'Material'
        Width = 57
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'secciones_ec'
        Title.Alignment = taCenter
        Title.Caption = 'Secciones'
        Width = 57
        Visible = True
      end
      item
        Color = clInfoBk
        Expanded = False
        FieldName = 'coste_total'
        Title.Alignment = taCenter
        Title.Caption = 'Total'
        Width = 57
        Visible = True
      end
      item
        Color = 13948116
        Expanded = False
        FieldName = 'pcoste_ec'
        Title.Alignment = taCenter
        Title.Caption = 'P.Envasado'
        Width = 57
        Visible = True
      end
      item
        Color = 13948116
        Expanded = False
        FieldName = 'pmaterial_ec'
        Title.Alignment = taCenter
        Title.Caption = 'P.Material'
        Width = 57
        Visible = True
      end
      item
        Color = 13948116
        Expanded = False
        FieldName = 'psecciones_ec'
        Title.Alignment = taCenter
        Title.Caption = 'P.Secciones'
        Width = 57
        Visible = True
      end
      item
        Color = 13948116
        Expanded = False
        FieldName = 'pcoste_total'
        Title.Alignment = taCenter
        Title.Caption = 'P.Total'
        Width = 57
        Visible = True
      end>
  end
  object pnlBotones: TPanel
    Left = 377
    Top = 71
    Width = 345
    Height = 38
    TabOrder = 1
    object lbl8: TLabel
      Left = 9
      Top = 13
      Width = 340
      Height = 13
      AutoSize = False
      Caption = 'Calculo Costes Promedio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnPromedioRegistro: TButton
      Left = 181
      Top = 7
      Width = 80
      Height = 25
      Caption = 'Seleccion'
      TabOrder = 0
      OnClick = btnPromedioRegistroClick
    end
    object btnTodos: TButton
      Left = 263
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Pendientes'
      TabOrder = 1
      OnClick = btnTodosClick
    end
  end
  object DSMaestro: TDataSource
    DataSet = QCosteEnvases
    Left = 88
    Top = 328
  end
  object QCosteEnvases: TQuery
    BeforePost = QCosteEnvasesBeforePost
    OnCalcFields = QCosteEnvasesCalcFields
    DatabaseName = 'BDProyecto'
    DataSource = dsGuia
    RequestLive = True
    SQL.Strings = (
      'select * '
      'from frf_env_costes')
    Left = 53
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
      FixedChar = True
      Size = 3
    end
    object QCosteEnvasescoste_ec: TFloatField
      FieldName = 'coste_ec'
      Origin = 'COMERCIALIZACION.frf_envase_costes.coste_ec'
    end
    object QCosteEnvasescostes_promedio_ec: TIntegerField
      FieldName = 'costes_promedio_ec'
      Origin = 'COMERCIALIZACION.frf_envase_costes.costes_promedio_ec'
    end
    object QCosteEnvasespcoste_ec: TFloatField
      FieldName = 'pcoste_ec'
      Origin = 'COMERCIALIZACION.frf_envase_costes.pcoste_ec'
    end
    object QCosteEnvasesmaterial_ec: TFloatField
      FieldName = 'material_ec'
      Origin = 'COMERCIALIZACION.frf_envase_costes.material_ec'
    end
    object QCosteEnvasespmaterial_ec: TFloatField
      FieldName = 'pmaterial_ec'
      Origin = 'COMERCIALIZACION.frf_envase_costes.pmaterial_ec'
    end
    object QCosteEnvasessecciones_ec: TFloatField
      FieldName = 'secciones_ec'
      Origin = 'BDPROYECTO.frf_env_costes.secciones_ec'
    end
    object QCosteEnvasespsecciones_ec: TFloatField
      FieldName = 'psecciones_ec'
      Origin = 'BDPROYECTO.frf_env_costes.psecciones_ec'
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
    object QCosteEnvasespcoste_total: TFloatField
      FieldKind = fkCalculated
      FieldName = 'pcoste_total'
      Calculated = True
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
