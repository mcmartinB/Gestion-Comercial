object FMClientes_Edi: TFMClientes_Edi
  Left = 417
  Top = 168
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = ' C'#211'DIGOS EDI DE CLIENTES'
  ClientHeight = 311
  ClientWidth = 405
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
    Width = 405
    Height = 311
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Lcomision: TLabel
      Left = 40
      Top = 106
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' Direcci'#243'n suministro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LEmpresa_p: TLabel
      Left = 40
      Top = 46
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LAno_semana_p: TLabel
      Left = 40
      Top = 76
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' Cliente'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 40
      Top = 136
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo EDI'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 40
      Top = 166
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' A quien se factura'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 40
      Top = 196
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' Quien pide'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 40
      Top = 226
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' Quien recibe'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 40
      Top = 256
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' Quien paga'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa_ce: TBGridButton
      Left = 192
      Top = 45
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Control = empresa_ce
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 280
      GridHeigth = 200
    end
    object BGBCliente_ce: TBGridButton
      Left = 192
      Top = 75
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Control = cliente_ce
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 280
      GridHeigth = 200
    end
    object BGBDir_sum_ce: TBGridButton
      Left = 192
      Top = 105
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Control = dir_sum_ce
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 280
      GridHeigth = 200
    end
    object dir_sum_ce: TBDEdit
      Left = 157
      Top = 105
      Width = 36
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduzca la direcci'#243'n de suministro'
      OnRequiredTime = RequiredTime
      ShowDecimals = True
      MaxLength = 3
      TabOrder = 4
      OnChange = PonNombre
      DataField = 'dir_sum_ce'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object empresa_ce: TBDEdit
      Tag = 1
      Left = 157
      Top = 45
      Width = 36
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'Introduzca el c'#243'digo del banco. '
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = PonNombre
      DataField = 'empresa_ce'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object cliente_ce: TBDEdit
      Left = 157
      Top = 75
      Width = 36
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduzca el c'#243'digo de cliente'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 2
      OnChange = PonNombre
      DataField = 'cliente_ce'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object codigo_edi_ce: TBDEdit
      Left = 157
      Top = 135
      Width = 100
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduzca un c'#243'digo EDI (obligatorio 13 caracteres)'
      OnRequiredTime = RequiredTime
      MaxLength = 13
      TabOrder = 6
      OnExit = SalidaCodigos
      OnKeyPress = SoloNumeros
      DataField = 'codigo_ce'
      DataSource = DSMaestro
    end
    object aquiensefactura_ce: TBDEdit
      Left = 157
      Top = 165
      Width = 100
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduzca el c'#243'digo (obligatorio 13 caracteres)'
      OnRequiredTime = RequiredTime
      MaxLength = 13
      TabOrder = 7
      OnExit = SalidaCodigos
      OnKeyPress = SoloNumeros
      DataField = 'aquiensefactura_ce'
      DataSource = DSMaestro
    end
    object quienpide_ce: TBDEdit
      Left = 157
      Top = 195
      Width = 100
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduzca el c'#243'digo(obligatorio 13 caracteres)'
      OnRequiredTime = RequiredTime
      MaxLength = 13
      TabOrder = 8
      OnExit = SalidaCodigos
      OnKeyPress = SoloNumeros
      DataField = 'quienpide_ce'
      DataSource = DSMaestro
    end
    object quienrecibe_ce: TBDEdit
      Left = 157
      Top = 225
      Width = 100
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduzca el c'#243'digo (obligatorio 13 caracteres)'
      OnRequiredTime = RequiredTime
      MaxLength = 13
      TabOrder = 9
      OnExit = SalidaCodigos
      OnKeyPress = SoloNumeros
      DataField = 'quienrecibe_ce'
      DataSource = DSMaestro
    end
    object quienpaga_ce: TBDEdit
      Left = 157
      Top = 255
      Width = 100
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduzca el c'#243'digo (obligatorio 13 caracteres)'
      OnRequiredTime = RequiredTime
      MaxLength = 13
      TabOrder = 10
      OnExit = SalidaCodigos
      OnKeyPress = SoloNumeros
      DataField = 'quienpaga_ce'
      DataSource = DSMaestro
    end
    object STEmpresa_ce: TStaticText
      Left = 216
      Top = 45
      Width = 150
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object STCliente_ce: TStaticText
      Left = 216
      Top = 75
      Width = 150
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 3
    end
    object STDir_sum_ce: TStaticText
      Left = 216
      Top = 105
      Width = 150
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 5
    end
  end
  object RejillaFlotante: TBGrid
    Left = 264
    Top = 144
    Width = 113
    Height = 49
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
  end
  object DSMaestro: TDataSource
    DataSet = QClientes_Edi
    Left = 48
    Top = 8
  end
  object ACosecheros: TActionList
    Left = 88
    Top = 8
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QClientes_Edi: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_clientes_edi'
      'ORDER BY empresa_ce, cliente_ce, dir_sum_ce')
    Left = 13
    Top = 8
  end
end
