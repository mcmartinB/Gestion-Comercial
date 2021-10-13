object FMCostesIndirectos: TFMCostesIndirectos
  Left = 658
  Top = 242
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    IMPORTE COSTES INDIRECTOS'
  ClientHeight = 517
  ClientWidth = 492
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
    Width = 492
    Height = 186
    Align = alTop
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Bevel1: TBevel
      Left = 325
      Top = 83
      Width = 120
      Height = 19
    end
    object LPlantacion_p: TLabel
      Left = 40
      Top = 21
      Width = 122
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LEmpresa_p: TLabel
      Left = 40
      Top = 46
      Width = 122
      Height = 19
      AutoSize = False
      Caption = ' Centro Origen'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 40
      Top = 129
      Width = 122
      Height = 19
      AutoSize = False
      Caption = ' Coste Kg Producci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 40
      Top = 83
      Width = 122
      Height = 19
      AutoSize = False
      Caption = ' Fecha Desde'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object desEmpresa_ci: TnbStaticText
      Left = 222
      Top = 20
      Width = 223
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object desCentro_ci: TnbStaticText
      Left = 222
      Top = 45
      Width = 223
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object lblNombre1: TLabel
      Left = 40
      Top = 106
      Width = 122
      Height = 19
      AutoSize = False
      Caption = ' Coste Kg Comercial'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre2: TLabel
      Left = 40
      Top = 152
      Width = 122
      Height = 19
      AutoSize = False
      Caption = ' Coste Kg Administraci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre3: TLabel
      Left = 263
      Top = 83
      Width = 60
      Height = 19
      AutoSize = False
      Caption = ' Hasta'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object fecha_fin_ci: TDBText
      Left = 327
      Top = 84
      Width = 114
      Height = 17
      DataField = 'fecha_fin_ci'
      DataSource = DSMaestro
    end
    object produccion_ci: TBDEdit
      Tag = 1
      Left = 167
      Top = 128
      Width = 70
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 5
      MaxLength = 8
      TabOrder = 4
      DataField = 'produccion_ci'
      DataSource = DSMaestro
    end
    object empresa_ci: TnbDBSQLCombo
      Left = 167
      Top = 20
      Width = 51
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      OnChange = empresa_emcChange
      TabOrder = 0
      DataField = 'empresa_ci'
      DataSource = DSMaestro
      DBLink = True
      Modificable = False
      SQL.Strings = (
        'select empresa_e, nombre_e'
        'from frf_empresas'
        'order by 1')
      DatabaseName = 'BDProyecto'
      OnlyNumbers = False
    end
    object centro_origen_ci: TnbDBSQLCombo
      Left = 167
      Top = 44
      Width = 38
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      OnChange = centro_emcChange
      TabOrder = 1
      DataField = 'centro_origen_ci'
      DataSource = DSMaestro
      DBLink = True
      Modificable = False
      DatabaseName = 'BDProyecto'
      OnGetSQL = centro_origen_ciGetSQL
    end
    object fecha_ini_ci: TnbDBCalendarCombo
      Left = 167
      Top = 82
      Width = 90
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 2
      DataField = 'fecha_ini_ci'
      DataSource = DSMaestro
      DBLink = True
    end
    object comercial_ci: TBDEdit
      Tag = 1
      Left = 167
      Top = 105
      Width = 70
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 5
      MaxLength = 8
      TabOrder = 3
      DataField = 'comercial_ci'
      DataSource = DSMaestro
    end
    object administracion_ci: TBDEdit
      Tag = 1
      Left = 167
      Top = 151
      Width = 70
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 5
      MaxLength = 8
      TabOrder = 5
      DataField = 'administracion_ci'
      DataSource = DSMaestro
    end
  end
  object dbgCostes: TDBGrid
    Left = 0
    Top = 186
    Width = 492
    Height = 331
    TabStop = False
    Align = alClient
    DataSource = DSMaestro
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
        Alignment = taCenter
        Expanded = False
        FieldName = 'fecha_ini_ci'
        Title.Alignment = taCenter
        Title.Caption = 'Fecha Ini.'
        Width = 85
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'fecha_fin_ci'
        Title.Alignment = taCenter
        Title.Caption = 'Fecha Fin'
        Width = 85
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'comercial_ci'
        Title.Alignment = taCenter
        Title.Caption = 'Comercial'
        Width = 85
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'produccion_ci'
        Title.Alignment = taCenter
        Title.Caption = 'Producci'#243'n'
        Width = 85
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'administracion_ci'
        Title.Alignment = taCenter
        Title.Caption = 'Administraci'#243'n'
        Width = 85
        Visible = True
      end>
  end
  object DSMaestro: TDataSource
    DataSet = QCostesIndirectos
    Left = 80
    Top = 258
  end
  object QCostesIndirectos: TQuery
    BeforePost = QCostesIndirectosBeforePost
    DatabaseName = 'BDProyecto'
    DataSource = dsGuia
    RequestLive = True
    SQL.Strings = (
      'SELECT codigo_m, descripcion_m'
      'FROM frf_marcas Frf_marcas'
      'ORDER BY codigo_m')
    Left = 48
    Top = 257
  end
  object QAux: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT codigo_m, descripcion_m'
      'FROM frf_marcas Frf_marcas'
      'ORDER BY codigo_m')
    Left = 112
    Top = 257
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
    Left = 48
    Top = 223
  end
  object dsGuia: TDataSource
    DataSet = qGuia
    Left = 88
    Top = 222
  end
  object sqluGuia: TUpdateSQL
    Left = 128
    Top = 224
  end
end
