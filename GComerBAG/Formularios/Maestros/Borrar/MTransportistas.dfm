object FMTransportistas: TFMTransportistas
  Left = 598
  Top = 257
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  TRANSPORTISTAS'
  ClientHeight = 356
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
    Width = 493
    Height = 356
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
      Top = 78
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LEmpresa_p: TLabel
      Left = 39
      Top = 29
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa_t: TBGridButton
      Left = 179
      Top = 27
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      Control = empresa_t
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 240
      GridHeigth = 150
    end
    object LAno_semana_p: TLabel
      Left = 39
      Top = 54
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' Transporte'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 39
      Top = 103
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' Direcci'#243'n 1'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 39
      Top = 127
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' Direcci'#243'n 2'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 39
      Top = 176
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' Tara'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 245
      Top = 176
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo de Almac'#233'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 245
      Top = 54
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' CIF'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 39
      Top = 152
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' Tel'#233'fono'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label7: TLabel
      Left = 245
      Top = 152
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' Fax'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label8: TLabel
      Left = 39
      Top = 232
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' Clausulas'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label9: TLabel
      Left = 39
      Top = 200
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo X3'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object descripcion_t: TBDEdit
      Left = 140
      Top = 77
      Width = 304
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 4
      DataField = 'descripcion_t'
      DataSource = DSMaestro
    end
    object empresa_t: TBDEdit
      Tag = 1
      Left = 140
      Top = 28
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = PonNombre
      DataField = 'empresa_t'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object STEmpresa_t: TStaticText
      Left = 194
      Top = 30
      Width = 250
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object transporte_t: TBDEdit
      Left = 140
      Top = 53
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del transporte es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 2
      OnExit = transporte_tExit
      DataField = 'transporte_t'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object tara_t: TBDEdit
      Left = 140
      Top = 175
      Width = 97
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 10
      TabOrder = 9
      DataField = 'tara_t'
      DataSource = DSMaestro
    end
    object codigo_almacen_t: TBDEdit
      Left = 348
      Top = 175
      Width = 97
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 11
      TabOrder = 10
      DataField = 'codigo_almacen_t'
      DataSource = DSMaestro
    end
    object direccion1_t: TBDEdit
      Left = 140
      Top = 102
      Width = 304
      Height = 21
      Hint = 'direccion1_t'
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 40
      TabOrder = 5
      DataField = 'direccion1_t'
      DataSource = DSMaestro
    end
    object direccion2_t: TBDEdit
      Left = 140
      Top = 126
      Width = 304
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 40
      TabOrder = 6
      DataField = 'direccion2_t'
      DataSource = DSMaestro
    end
    object cif_t: TBDEdit
      Left = 348
      Top = 53
      Width = 97
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 10
      TabOrder = 3
      DataField = 'cif_t'
      DataSource = DSMaestro
    end
    object telefono_t: TBDEdit
      Left = 140
      Top = 151
      Width = 97
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 9
      TabOrder = 7
      DataField = 'telefono_t'
      DataSource = DSMaestro
    end
    object fax_t: TBDEdit
      Left = 348
      Top = 151
      Width = 97
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 9
      TabOrder = 8
      DataField = 'fax_t'
      DataSource = DSMaestro
    end
    object notas_t: TDBMemo
      Left = 40
      Top = 256
      Width = 407
      Height = 89
      DataField = 'notas_t'
      DataSource = DSMaestro
      TabOrder = 11
      OnEnter = notas_tEnter
      OnExit = notas_tExit
    end
    object codigo_x3_t: TBDEdit
      Left = 140
      Top = 200
      Width = 88
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 10
      TabOrder = 12
      DataField = 'codigo_x3_t'
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
    DataSet = QTransportistas
    Left = 48
    Top = 8
  end
  object ACosecheros: TActionList
    Left = 368
    Top = 120
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QTransportistas: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      
        'SELECT empresa_t, transporte_t, descripcion_t, tara_t, codigo_al' +
        'macen_t'
      'FROM frf_transportistas Frf_transportistas'
      'ORDER BY empresa_t, transporte_t')
    Left = 16
    Top = 8
  end
end
