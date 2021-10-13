object FMCostesEnvasadoMensual: TFMCostesEnvasadoMensual
  Left = 700
  Top = 194
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    IMPORTE COSTES MENSUALES DE SECCIONES'
  ClientHeight = 622
  ClientWidth = 458
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
    Width = 458
    Height = 159
    Align = alTop
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LPlantacion_p: TLabel
      Left = 40
      Top = 20
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LEmpresa_p: TLabel
      Left = 40
      Top = 43
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Centro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 40
      Top = 121
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Coste Kgs'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 40
      Top = 66
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' A'#241'o-Mes'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 40
      Top = 99
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Tipo Coste'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object desEmpresa_ce: TnbStaticText
      Left = 208
      Top = 20
      Width = 190
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object desCentro_ce: TnbStaticText
      Left = 208
      Top = 43
      Width = 190
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object desTipoCoste_ce: TnbStaticText
      Left = 208
      Top = 99
      Width = 190
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object empresa_emc: TBDEdit
      Left = 131
      Top = 20
      Width = 31
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de la marca es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = empresa_emcChange
      DataField = 'empresa_emc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object centro_emc: TBDEdit
      Tag = 1
      Left = 131
      Top = 43
      Width = 22
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 1
      TabOrder = 1
      OnChange = centro_emcChange
      DataField = 'centro_emc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object coste_kg_emc_epc: TBDEdit
      Tag = 1
      Left = 131
      Top = 121
      Width = 70
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 5
      MaxLength = 8
      TabOrder = 4
      DataField = 'coste_kg_emc'
      DataSource = DSMaestro
    end
    object anyo_mes_emc: TBDEdit
      Tag = 1
      Left = 131
      Top = 66
      Width = 62
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 6
      TabOrder = 2
      DataField = 'anyo_mes_emc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object env_tcoste_emc: TnbDBSQLCombo
      Left = 131
      Top = 99
      Width = 57
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      OnChange = env_tcoste_emcChange
      TabOrder = 3
      DataField = 'env_tcoste_emc'
      DataSource = DSMaestro
      DBLink = True
      SQL.Strings = (
        'select env_tcoste_etc, descripcion_etc'
        'from frf_env_tcostes'
        'order by env_tcoste_etc')
      DatabaseName = 'BDProyecto'
      FillAuto = True
      OnlyNumbers = False
      NumChars = 3
    end
  end
  object dbgCostes: TDBGrid
    Left = 0
    Top = 159
    Width = 458
    Height = 463
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
        FieldName = 'env_tcoste_emc'
        Title.Alignment = taCenter
        Title.Caption = 'Secci'#243'n'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'des_seccion'
        Title.Alignment = taCenter
        Title.Caption = 'Descripci'#243'n'
        Width = 240
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'coste_kg_emc'
        Title.Alignment = taCenter
        Title.Caption = 'Coste Kilo'
        Width = 85
        Visible = True
      end>
  end
  object DSMaestro: TDataSource
    DataSet = QCostesEnvasado
    Left = 88
    Top = 238
  end
  object QCostesEnvasado: TQuery
    OnCalcFields = QCostesEnvasadoCalcFields
    DatabaseName = 'BDProyecto'
    DataSource = dsGuia
    RequestLive = True
    SQL.Strings = (
      'select * from frf_env_mcostes')
    Left = 48
    Top = 239
    object QCostesEnvasadoempresa_emc: TStringField
      FieldName = 'empresa_emc'
      Origin = 'BDPROYECTO.frf_env_mcostes.empresa_emc'
      FixedChar = True
      Size = 3
    end
    object QCostesEnvasadocentro_emc: TStringField
      FieldName = 'centro_emc'
      Origin = 'BDPROYECTO.frf_env_mcostes.centro_emc'
      FixedChar = True
      Size = 1
    end
    object QCostesEnvasadoanyo_mes_emc: TStringField
      FieldName = 'anyo_mes_emc'
      Origin = 'BDPROYECTO.frf_env_mcostes.anyo_mes_emc'
      FixedChar = True
      Size = 6
    end
    object QCostesEnvasadoenv_tcoste_emc: TStringField
      FieldName = 'env_tcoste_emc'
      Origin = 'BDPROYECTO.frf_env_mcostes.env_tcoste_emc'
      FixedChar = True
      Size = 3
    end
    object QCostesEnvasadocoste_kg_emc: TFloatField
      FieldName = 'coste_kg_emc'
      Origin = 'BDPROYECTO.frf_env_mcostes.coste_kg_emc'
    end
    object QCostesEnvasadodes_seccion: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_seccion'
      Size = 30
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
    Left = 48
    Top = 199
  end
  object dsGuia: TDataSource
    DataSet = qGuia
    Left = 88
    Top = 198
  end
  object sqluGuia: TUpdateSQL
    Left = 128
    Top = 200
  end
end
