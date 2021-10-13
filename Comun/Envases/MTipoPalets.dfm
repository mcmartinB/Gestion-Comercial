object FMTipoPalets: TFMTipoPalets
  Left = 738
  Top = 266
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  TIPO DE PALETS'
  ClientHeight = 243
  ClientWidth = 427
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
    Width = 427
    Height = 243
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LCodigo_tp: TLabel
      Left = 40
      Top = 39
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LDescripcion_tp: TLabel
      Left = 40
      Top = 62
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 40
      Top = 85
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' Peso Palet'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre12: TLabel
      Left = 40
      Top = 130
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' Agente/Env. Comer.'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnEnvComerOperador: TBGridButton
      Left = 192
      Top = 129
      Width = 13
      Height = 21
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000000000000000001F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000000000000000000000001F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      OnClick = btnEnvComerOperadorClick
      Control = env_comer_operador_tp
      Grid = RejillaFlotante
      GridAlignment = taUpLeft
      GridWidth = 200
      GridHeigth = 100
    end
    object btnEnvComerProducto: TBGridButton
      Left = 258
      Top = 129
      Width = 13
      Height = 21
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000000000000000001F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000000000000000000000001F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      OnClick = btnEnvComerProductoClick
      Control = env_comer_producto_tp
      Grid = RejillaFlotante
      GridAlignment = taUpLeft
      GridWidth = 200
      GridHeigth = 100
    end
    object lblEsPlastico: TLabel
      Left = 40
      Top = 107
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' Es Palet Plastico'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 260
      Top = 85
      Width = 69
      Height = 19
      AutoSize = False
      Caption = 'C'#243'digo LPR'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 40
      Top = 174
      Width = 108
      Height = 19
      AutoSize = False
      Caption = 'Tipo de Palet'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object codigo_tp: TBDEdit
      Left = 156
      Top = 39
      Width = 31
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 0
      DataField = 'codigo_tp'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object descripcion_tp: TBDEdit
      Tag = 1
      Left = 156
      Top = 62
      Width = 221
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 1
      DataField = 'descripcion_tp'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object kilos_tp: TBDEdit
      Left = 156
      Top = 85
      Width = 40
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 10
      TabOrder = 2
      DataField = 'kilos_tp'
      DataSource = DSMaestro
    end
    object env_comer_operador_tp: TBDEdit
      Left = 156
      Top = 129
      Width = 35
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 3
      TabOrder = 5
      OnChange = env_comer_operador_tpChange
      DataField = 'env_comer_operador_tp'
      DataSource = DSMaestro
    end
    object env_comer_producto_tp: TBDEdit
      Left = 206
      Top = 129
      Width = 52
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 5
      TabOrder = 6
      OnChange = env_comer_operador_tpChange
      DataField = 'env_comer_producto_tp'
      DataSource = DSMaestro
    end
    object des_env_comer: TStaticText
      Left = 156
      Top = 153
      Width = 221
      Height = 18
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 7
    end
    object palet_plastico_tp: TDBCheckBox
      Left = 156
      Top = 108
      Width = 97
      Height = 17
      DataField = 'palet_plastico_tp'
      DataSource = DSMaestro
      TabOrder = 4
      ValueChecked = '1'
      ValueUnchecked = '0'
      OnClick = palet_plastico_tpClick
    end
    object BDEdit1: TBDEdit
      Left = 329
      Top = 85
      Width = 48
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 5
      TabOrder = 3
      DataField = 'codigo_lpr_tp'
      DataSource = DSMaestro
    end
    object size_tp: TDBComboBox
      Left = 156
      Top = 174
      Width = 38
      Height = 21
      Style = csDropDownList
      DataField = 'size_tp'
      DataSource = DSMaestro
      ItemHeight = 13
      Items.Strings = (
        'A'
        'E'
        'O')
      TabOrder = 8
      OnChange = size_tpChange
    end
    object des_size_tp: TStaticText
      Left = 196
      Top = 175
      Width = 181
      Height = 18
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 9
    end
  end
  object RejillaFlotante: TBGrid
    Left = 338
    Top = 5
    Width = 113
    Height = 49
    Color = clInfoBk
    DataSource = DMBaseDatos.DSQDespegables
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
    DataSet = QTipoPalets
    OnDataChange = DSMaestroDataChange
    Left = 56
    Top = 8
  end
  object QTipoPalets: TQuery
    AfterOpen = QTipoPaletsAfterOpen
    AfterScroll = QTipoPaletsAfterScroll
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_tipo_palets'
      'ORDER BY codigo_tp')
    Left = 24
    Top = 8
  end
end
