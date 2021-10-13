object FMTipoEntregas: TFMTipoEntregas
  Left = 642
  Top = 239
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = '  TIPO DE ENTRADAS'
  ClientHeight = 413
  ClientWidth = 457
  Color = clBtnFace
  Constraints.MinHeight = 50
  Constraints.MinWidth = 130
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  Visible = True
  OnActivate = FormActivate
  OnCanResize = FormCanResize
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
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
    Width = 457
    Height = 164
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
      Left = 193
      Top = 23
      Width = 210
      Height = 17
    end
    object LEmpresa_p: TLabel
      Left = 47
      Top = 58
      Width = 86
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LAno_semana_p: TLabel
      Left = 47
      Top = 80
      Width = 86
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 47
      Top = 122
      Width = 86
      Height = 19
      AutoSize = False
      Caption = ' Ajuste'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 47
      Top = 22
      Width = 86
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGridButton1: TBGridButton
      Left = 177
      Top = 21
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00000000BFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FF00000000000000000000000000FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00000000000000000000000000000000000000
        00BFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      Control = empresa_et
      Grid = BGrid1
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object empresa_des: TLabel
      Left = 196
      Top = 24
      Width = 202
      Height = 15
      AutoSize = False
    end
    object dbtxtAjuste: TDBText
      Left = 160
      Top = 123
      Width = 81
      Height = 17
      DataField = 'des_ajuste'
      DataSource = DSMaestro
    end
    object lbl1: TLabel
      Left = 47
      Top = 101
      Width = 86
      Height = 19
      AutoSize = False
      Caption = ' Merma'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object dbtxtMerma: TDBText
      Left = 160
      Top = 102
      Width = 73
      Height = 17
      DataField = 'des_merma'
      DataSource = DSMaestro
    end
    object tipo_et: TBDEdit
      Tag = 1
      Left = 141
      Top = 57
      Width = 21
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'Introduce el c'#243'digo del banco. '
      OnRequiredTime = RequiredTime
      MaxLength = 1
      TabOrder = 1
      DataField = 'tipo_et'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object descripcion_et: TBDEdit
      Left = 141
      Top = 79
      Width = 265
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce la descripci'#243'n del banco.'
      OnRequiredTime = RequiredTime
      MaxLength = 35
      TabOrder = 2
      DataField = 'descripcion_et'
      DataSource = DSMaestro
    end
    object empresa_et: TBDEdit
      Tag = 1
      Left = 141
      Top = 22
      Width = 36
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'Introduce el c'#243'digo del banco. '
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = empresa_etChange
      DataField = 'empresa_et'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object ajuste_et: TDBCheckBox
      Left = 141
      Top = 123
      Width = 19
      Height = 17
      DataField = 'ajuste_et'
      DataSource = DSMaestro
      TabOrder = 4
      ValueChecked = '1'
      ValueUnchecked = '0'
      OnClick = ajuste_etClick
    end
    object merma_et: TDBCheckBox
      Left = 141
      Top = 102
      Width = 19
      Height = 17
      DataField = 'ajuste_et'
      DataSource = DSMaestro
      TabOrder = 3
      ValueChecked = '1'
      ValueUnchecked = '0'
      OnClick = merma_etClick
    end
  end
  object BGrid1: TBGrid
    Left = 182
    Top = 69
    Width = 50
    Height = 25
    Color = clInfoBk
    Options = [dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    BControl = empresa_et
  end
  object dbgTipoEntradas: TDBGrid
    Left = 0
    Top = 164
    Width = 457
    Height = 249
    TabStop = False
    Align = alClient
    DataSource = DSMaestro
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
        Expanded = False
        FieldName = 'tipo_et'
        Title.Alignment = taCenter
        Title.Caption = 'Tipo'
        Width = 45
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descripcion_et'
        Title.Alignment = taCenter
        Title.Caption = 'Descripci'#243'n'
        Width = 236
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'des_merma'
        Title.Alignment = taCenter
        Title.Caption = 'Merma'
        Width = 65
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'des_ajuste'
        Title.Alignment = taCenter
        Title.Caption = 'Ajuste'
        Width = 65
        Visible = True
      end>
  end
  object DSMaestro: TDataSource
    DataSet = QTipoEntregas
    Left = 56
    Top = 240
  end
  object ACosecheros: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 352
    Top = 8
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QTipoEntregas: TQuery
    OnCalcFields = QTipoEntregasCalcFields
    OnNewRecord = QTipoEntregasNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = dsGuia
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_entradas_tipo')
    Left = 24
    Top = 241
    object QTipoEntregasempresa_et: TStringField
      FieldName = 'empresa_et'
      Origin = 'BDPROYECTO.frf_entradas_tipo.empresa_et'
      FixedChar = True
      Size = 3
    end
    object QTipoEntregastipo_et: TIntegerField
      FieldName = 'tipo_et'
      Origin = 'BDPROYECTO.frf_entradas_tipo.tipo_et'
    end
    object QTipoEntregasdescripcion_et: TStringField
      FieldName = 'descripcion_et'
      Origin = 'BDPROYECTO.frf_entradas_tipo.descripcion_et'
      FixedChar = True
      Size = 30
    end
    object QTipoEntregasajuste_et: TIntegerField
      FieldName = 'ajuste_et'
      Origin = 'BDPROYECTO.frf_entradas_tipo.ajuste_et'
    end
    object QTipoEntregasdes_ajuste: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_ajuste'
      Size = 30
      Calculated = True
    end
    object QTipoEntregasmerma_et: TIntegerField
      FieldName = 'merma_et'
      Origin = 'BDPROYECTO.frf_entradas_tipo.merma_et'
    end
    object QTipoEntregasdes_merma: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_merma'
      Size = 11
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
    Left = 24
    Top = 207
  end
  object dsGuia: TDataSource
    DataSet = qGuia
    Left = 56
    Top = 206
  end
  object sqluGuia: TUpdateSQL
    Left = 88
    Top = 208
  end
end
