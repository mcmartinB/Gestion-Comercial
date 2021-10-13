object FMTipoCostes: TFMTipoCostes
  Left = 596
  Top = 183
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  TIPO DE SECCIONES'
  ClientHeight = 600
  ClientWidth = 479
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
    Width = 479
    Height = 125
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
      Left = 41
      Top = 19
      Width = 92
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LEmpresa_p: TLabel
      Left = 41
      Top = 41
      Width = 92
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 41
      Top = 63
      Width = 92
      Height = 19
      AutoSize = False
      Caption = ' Aplicaci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 41
      Top = 84
      Width = 92
      Height = 19
      AutoSize = False
      Caption = ' Centro Aplicaci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 153
      Top = 87
      Width = 276
      Height = 13
      Caption = '(Optativo, centro a cuyos kilos de salida se aplica el coste)'
    end
    object env_tcoste_etc: TBDEdit
      Left = 134
      Top = 19
      Width = 31
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de la empresa es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      DataField = 'env_tcoste_etc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object descripcion_etc: TBDEdit
      Tag = 1
      Left = 134
      Top = 41
      Width = 286
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 1
      DataField = 'descripcion_etc'
      DataSource = DSMaestro
    end
    object aplic_primera_etc: TDBCheckBox
      Left = 134
      Top = 64
      Width = 33
      Height = 17
      Caption = '1'#170
      DataField = 'aplic_primera_etc'
      DataSource = DSMaestro
      TabOrder = 2
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object aplic_segunda_etc: TDBCheckBox
      Left = 175
      Top = 64
      Width = 33
      Height = 17
      Caption = '2'#170
      DataField = 'aplic_segunda_etc'
      DataSource = DSMaestro
      TabOrder = 3
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object aplic_tercera_etc: TDBCheckBox
      Left = 217
      Top = 64
      Width = 33
      Height = 17
      Caption = '3'#170
      DataField = 'aplic_tercera_etc'
      DataSource = DSMaestro
      TabOrder = 4
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object aplic_destrio_etc: TDBCheckBox
      Left = 259
      Top = 64
      Width = 57
      Height = 17
      Caption = 'Destrio'
      DataField = 'aplic_destrio_etc'
      DataSource = DSMaestro
      TabOrder = 5
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object centro_paso_etc: TBDEdit
      Left = 134
      Top = 84
      Width = 14
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 1
      TabOrder = 6
      DataField = 'centro_paso_etc'
      DataSource = DSMaestro
    end
  end
  object dbgTipoEntradas: TDBGrid
    Left = 0
    Top = 125
    Width = 479
    Height = 475
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
        FieldName = 'env_tcoste_etc'
        Title.Alignment = taCenter
        Title.Caption = 'Tipo'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descripcion_etc'
        Title.Caption = 'Descripci'#243'n'
        Width = 246
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'aplic_primera_etc'
        Title.Alignment = taCenter
        Title.Caption = '1'#170
        Width = 25
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'aplic_segunda_etc'
        Title.Alignment = taCenter
        Title.Caption = '2'#186
        Width = 25
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'aplic_tercera_etc'
        Title.Alignment = taCenter
        Title.Caption = '3'#170
        Width = 25
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'aplic_destrio_etc'
        Title.Alignment = taCenter
        Title.Caption = 'Des.'
        Width = 25
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'centro_paso_etc'
        Title.Alignment = taCenter
        Title.Caption = 'Centro'
        Width = 40
        Visible = True
      end>
  end
  object DSMaestro: TDataSource
    DataSet = QTipoCostes
    Left = 64
    Top = 8
  end
  object QTipoCostes: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT codigo_m, descripcion_m'
      'FROM frf_marcas Frf_marcas'
      'ORDER BY codigo_m')
    Left = 32
    Top = 9
  end
end
