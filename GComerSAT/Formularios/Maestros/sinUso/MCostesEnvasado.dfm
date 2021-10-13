object FMCostesEnvasado: TFMCostesEnvasado
  Left = 625
  Top = 160
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    SECCIONES POR PROVEEDOR'
  ClientHeight = 524
  ClientWidth = 812
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
    Width = 812
    Height = 141
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
      Top = 21
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LEmpresa_p: TLabel
      Left = 384
      Top = 21
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Centro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 384
      Top = 65
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 40
      Top = 65
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Productor'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 40
      Top = 43
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' A'#241'o-Mes'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 384
      Top = 102
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Secci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre1: TLabel
      Left = 40
      Top = 102
      Width = 80
      Height = 18
      AutoSize = False
      Caption = ' Tipo Entrada'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object DBText1: TDBText
      Left = 190
      Top = 24
      Width = 190
      Height = 13
      DataField = 'des_empresa'
      DataSource = DSMaestro
    end
    object DBText2: TDBText
      Left = 534
      Top = 68
      Width = 190
      Height = 13
      DataField = 'des_producto'
      DataSource = DSMaestro
    end
    object DBText3: TDBText
      Left = 190
      Top = 107
      Width = 190
      Height = 13
      DataField = 'des_tipo_entrada'
      DataSource = DSMaestro
    end
    object DBText4: TDBText
      Left = 534
      Top = 24
      Width = 190
      Height = 13
      DataField = 'des_centro'
      DataSource = DSMaestro
    end
    object DBText5: TDBText
      Left = 192
      Top = 68
      Width = 190
      Height = 13
      DataField = 'des_productor'
      DataSource = DSMaestro
    end
    object DBText6: TDBText
      Left = 536
      Top = 105
      Width = 190
      Height = 13
      DataField = 'des_tipo_coste'
      DataSource = DSMaestro
    end
    object empresa_epc: TBDEdit
      Left = 131
      Top = 20
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de la marca es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      DataField = 'empresa_epc'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object centro_epc: TBDEdit
      Tag = 1
      Left = 475
      Top = 20
      Width = 22
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 1
      TabOrder = 1
      DataField = 'centro_epc'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object producto_epc: TBDEdit
      Tag = 1
      Left = 475
      Top = 64
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 4
      DataField = 'producto_epc'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object productor_epc: TBDEdit
      Tag = 1
      Left = 131
      Top = 64
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 3
      TabOrder = 3
      DataField = 'productor_epc'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object anyo_mes_epc: TBDEdit
      Tag = 1
      Left = 131
      Top = 42
      Width = 62
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 6
      TabOrder = 2
      DataField = 'anyo_mes_epc'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object env_tcoste_epc: TnbDBSQLCombo
      Left = 475
      Top = 101
      Width = 57
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 6
      DataField = 'env_tcoste_epc'
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
    object tipo_entrada_epc: TnbDBSQLCombo
      Left = 131
      Top = 101
      Width = 49
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 5
      DataField = 'tipo_entrada_epc'
      DataSource = DSMaestro
      DBLink = True
      SQL.Strings = (
        'select tipo_et tipo, descripcion_et descripcion '
        'from frf_entradas_tipo'
        'order by tipo_et')
      DatabaseName = 'BDProyecto'
      OnGetSQL = tipo_entrada_epcGetSQL
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 141
    Width = 812
    Height = 383
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
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'tipo_entrada_epc'
        Title.Alignment = taCenter
        Title.Caption = 'Tipo'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'des_tipo_entrada'
        Title.Alignment = taCenter
        Title.Caption = 'Descripci'#243'n'
        Width = 200
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'env_tcoste_epc'
        Title.Alignment = taCenter
        Title.Caption = 'Secci'#243'n'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'des_tipo_coste'
        Title.Alignment = taCenter
        Title.Caption = 'Descripci'#243'n'
        Width = 200
        Visible = True
      end>
  end
  object DSMaestro: TDataSource
    DataSet = QCostesEnvasado
    Left = 112
    Top = 240
  end
  object QCostesEnvasado: TQuery
    OnCalcFields = QCostesEnvasadoCalcFields
    DatabaseName = 'BDProyecto'
    DataSource = dsGuia
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_env_pcostes')
    Left = 80
    Top = 241
    object QCostesEnvasadoempresa_epc: TStringField
      FieldName = 'empresa_epc'
      Origin = 'BDPROYECTO.frf_env_pcostes.empresa_epc'
      FixedChar = True
      Size = 3
    end
    object QCostesEnvasadocentro_epc: TStringField
      FieldName = 'centro_epc'
      Origin = 'BDPROYECTO.frf_env_pcostes.centro_epc'
      FixedChar = True
      Size = 1
    end
    object QCostesEnvasadoanyo_mes_epc: TStringField
      FieldName = 'anyo_mes_epc'
      Origin = 'BDPROYECTO.frf_env_pcostes.anyo_mes_epc'
      FixedChar = True
      Size = 6
    end
    object QCostesEnvasadoenv_tcoste_epc: TStringField
      FieldName = 'env_tcoste_epc'
      Origin = 'BDPROYECTO.frf_env_pcostes.env_tcoste_epc'
      FixedChar = True
      Size = 3
    end
    object QCostesEnvasadoproductor_epc: TSmallintField
      FieldName = 'productor_epc'
      Origin = 'BDPROYECTO.frf_env_pcostes.productor_epc'
    end
    object QCostesEnvasadoproducto_epc: TStringField
      DisplayWidth = 3
      FieldName = 'producto_epc'
      Origin = 'BDPROYECTO.frf_env_pcostes.producto_epc'
      FixedChar = True
      Size = 3
    end
    object QCostesEnvasadotipo_entrada_epc: TIntegerField
      FieldName = 'tipo_entrada_epc'
      Origin = 'BDPROYECTO.frf_env_pcostes.tipo_entrada_epc'
    end
    object QCostesEnvasadodes_empresa: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_empresa'
      Size = 30
      Calculated = True
    end
    object QCostesEnvasadodes_centro: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_centro'
      Size = 30
      Calculated = True
    end
    object QCostesEnvasadodes_producto: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_producto'
      Size = 30
      Calculated = True
    end
    object QCostesEnvasadodes_productor: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_productor'
      Size = 30
      Calculated = True
    end
    object QCostesEnvasadodes_tipo_entrada: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_tipo_entrada'
      Size = 30
      Calculated = True
    end
    object QCostesEnvasadodes_tipo_coste: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_tipo_coste'
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
    Left = 80
    Top = 207
  end
  object dsGuia: TDataSource
    DataSet = qGuia
    Left = 120
    Top = 206
  end
  object sqluGuia: TUpdateSQL
    Left = 160
    Top = 208
  end
end
