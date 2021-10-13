object FMEAN13: TFMEAN13
  Left = 807
  Top = 245
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    C'#211'DIGOS EAN13 DE ART'#205'CULOS'
  ClientHeight = 275
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
  Position = poMainFormCenter
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
    Width = 590
    Height = 275
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LCodigo_e: TLabel
      Left = 70
      Top = 77
      Width = 73
      Height = 21
      AutoSize = False
      Caption = ' EAN 13'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LEmpresa_e: TLabel
      Left = 70
      Top = 49
      Width = 73
      Height = 21
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa_e: TBGridButton
      Left = 208
      Top = 49
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Control = empresa_e
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 200
      GridHeigth = 130
    end
    object Label1: TLabel
      Left = 70
      Top = 105
      Width = 73
      Height = 21
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 70
      Top = 209
      Width = 73
      Height = 21
      AutoSize = False
      Caption = ' EAN 14'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object DBRGAgrupacion: TDBRadioGroup
      Left = 70
      Top = 139
      Width = 467
      Height = 63
      Caption = ' Agrupaci'#243'n '
      Columns = 3
      DataField = 'agrupacion_e'
      DataSource = DSMaestro
      Items.Strings = (
        'Unidad Consumo'
        'De 1'#186' Nivel (Caja)'
        'De 2'#186' Nivel (Formato Palet)')
      ParentBackground = True
      TabOrder = 6
      TabStop = True
      Values.Strings = (
        '0'
        '1'
        '2')
    end
    object RejillaFlotante: TBGrid
      Left = 296
      Top = 17
      Width = 137
      Height = 25
      Color = clInfoBk
      FixedColor = clInfoText
      Options = [dgTabs, dgRowSelect, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Visible = False
    end
    object codigo_e: TBDEdit
      Left = 157
      Top = 77
      Width = 105
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 13
      TabOrder = 3
      OnKeyPress = codigo_eKeyPress
      DataField = 'codigo_e'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object empresa_e: TBDEdit
      Left = 157
      Top = 49
      Width = 49
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      MaxLength = 3
      TabOrder = 1
      OnChange = PonNombre
      DataField = 'empresa_e'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object STEmpresa_e: TStaticText
      Left = 229
      Top = 49
      Width = 207
      Height = 21
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 2
    end
    object descripcion_e: TBDEdit
      Left = 157
      Top = 105
      Width = 280
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      CharCase = ecNormal
      MaxLength = 50
      TabOrder = 4
      DataField = 'descripcion_e'
      DataSource = DSMaestro
    end
    object cbxAgrupacion: TComboBox
      Left = 157
      Top = 133
      Width = 83
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      Visible = False
      Items.Strings = (
        'Todos'
        'Unidad'
        'Caja'
        'Formato')
    end
    object ean14_e: TBDEdit
      Left = 157
      Top = 209
      Width = 105
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 14
      TabOrder = 7
      OnKeyPress = codigo_eKeyPress
      DataField = 'ean14_e'
      DataSource = DSMaestro
    end
  end
  object DSMaestro: TDataSource
    DataSet = QEan13
    Left = 64
    Top = 16
  end
  object ACosecheros: TActionList
    Left = 96
    Top = 16
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
    object ACampos: TAction
      Caption = 'Mantenimiento de Campos (F3)'
      ImageIndex = 3
      ShortCut = 114
    end
  end
  object QEan13: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_ean13'
      'ORDER BY codigo_e')
    Left = 32
    Top = 16
  end
end
