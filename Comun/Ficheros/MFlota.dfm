object FMFlota: TFMFlota
  Left = 598
  Top = 257
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  FLOTA DE CAMIONES'
  ClientHeight = 282
  ClientWidth = 493
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
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 493
    Height = 282
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Ldescripcion: TLabel
      Left = 39
      Top = 62
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LAno_semana_p: TLabel
      Left = 39
      Top = 38
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' Transporte'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label8: TLabel
      Left = 39
      Top = 128
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' Clausulas'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 39
      Top = 87
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' Tara'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object descripcion_c: TBDEdit
      Left = 140
      Top = 61
      Width = 304
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 1
      DataField = 'descripcion_c'
      DataSource = DSMaestro
    end
    object camion_c: TBDEdit
      Left = 140
      Top = 37
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del transporte es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 0
      OnExit = camion_cExit
      DataField = 'camion_c'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object notas_c: TDBMemo
      Left = 40
      Top = 152
      Width = 407
      Height = 89
      DataField = 'notas_c'
      DataSource = DSMaestro
      TabOrder = 3
      OnEnter = notas_cEnter
      OnExit = notas_cExit
    end
    object tara_c: TBDEdit
      Left = 140
      Top = 86
      Width = 97
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxDecimals = 2
      MaxLength = 10
      TabOrder = 2
      DataField = 'tara_c'
      DataSource = DSMaestro
    end
  end
  object RejillaFlotante: TBGrid
    Left = 453
    Top = 14
    Width = 83
    Height = 150
    Color = clInfoBk
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object DSMaestro: TDataSource
    DataSet = QCamion
    Left = 456
    Top = 16
  end
  object ACosecheros: TActionList
    Left = 456
    Top = 80
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
    end
  end
  object QCamion: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      
        'SELECT empresa_t, transporte_t, descripcion_t, tara_t, codigo_al' +
        'macen_t'
      'FROM frf_transportistas Frf_transportistas'
      'ORDER BY empresa_t, transporte_t')
    Left = 456
    Top = 48
  end
end
