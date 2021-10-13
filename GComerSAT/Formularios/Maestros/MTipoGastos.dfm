object FMTipogastos: TFMTipogastos
  Left = 583
  Top = 249
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  TIPOS DE GASTOS'
  ClientHeight = 267
  ClientWidth = 481
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
    Width = 481
    Height = 267
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LTipo_pago: TLabel
      Left = 40
      Top = 32
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Tipo de Gasto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LDescripcion_tg: TLabel
      Left = 40
      Top = 57
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 40
      Top = 109
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Uni. Distribuci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 40
      Top = 83
      Width = 98
      Height = 19
      AutoSize = False
      Caption = ' Facturable'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblCuentaVenta: TLabel
      Left = 40
      Top = 186
      Width = 98
      Height = 19
      AutoSize = False
      Caption = ' Cta. Venta'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblDescontarFob: TLabel
      Left = 40
      Top = 212
      Width = 98
      Height = 19
      AutoSize = False
      Caption = ' Descontar FOB'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblAgrupacion: TLabel
      Left = 40
      Top = 160
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' Agrupaci'#243'n Contable'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblTipIva: TLabel
      Left = 170
      Top = 86
      Width = 39
      Height = 13
      Caption = 'Tipo Iva'
    end
    object lblDesTipoIva: TLabel
      Left = 273
      Top = 86
      Width = 39
      Height = 13
      Caption = 'Tipo Iva'
    end
    object lblNombre1: TLabel
      Left = 40
      Top = 134
      Width = 108
      Height = 19
      AutoSize = False
      Caption = ' Agrupaci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnAgrupacion: TBGridButton
      Left = 228
      Top = 133
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Control = agrupacion_tg
      Grid = RejillaFlotante
      GridAlignment = taDownLeft
      GridWidth = 100
      GridHeigth = 200
    end
    object cbUnidad_dist_tg: TComboBox
      Left = 147
      Top = 108
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 6
      Items.Strings = (
        'TODOS'
        'IMPORTE'
        'KILOS'
        'CAJAS')
    end
    object tipo_tg: TBDEdit
      Tag = 1
      Left = 147
      Top = 31
      Width = 36
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'Introduce el c'#243'digo del tipo de Pago. '
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      DataField = 'tipo_tg'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object descripcion_tg: TBDEdit
      Left = 147
      Top = 56
      Width = 260
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce la descripci'#243'n del tipo de Pago.'
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 3
      DataField = 'descripcion_tg'
      DataSource = DSMaestro
    end
    object unidad_dist_tg: TDBComboBox
      Left = 147
      Top = 108
      Width = 89
      Height = 21
      Style = csDropDownList
      DataField = 'unidad_dist_tg'
      DataSource = DSMaestro
      ItemHeight = 13
      Items.Strings = (
        'IMPORTE'
        'KILOS'
        'CAJAS')
      TabOrder = 7
    end
    object facturable_tg: TDBCheckBox
      Left = 147
      Top = 84
      Width = 17
      Height = 17
      Caption = 'facturable_tg'
      DataField = 'facturable_tg'
      DataSource = DSMaestro
      TabOrder = 5
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object cta_venta_tg: TDBCheckBox
      Left = 147
      Top = 187
      Width = 17
      Height = 17
      DataField = 'cta_venta_tg'
      DataSource = DSMaestro
      TabOrder = 10
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object descontar_fob_tg: TDBCheckBox
      Left = 147
      Top = 213
      Width = 17
      Height = 17
      DataField = 'descontar_fob_tg'
      DataSource = DSMaestro
      TabOrder = 11
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object cbGasto_Transito_tg: TComboBox
      Left = 188
      Top = 31
      Width = 220
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnChange = cbGasto_Transito_tgChange
      Items.Strings = (
        'Gasto Salida'
        'Gasto Tr'#225'nsito'
        'Gasto Entrega')
    end
    object gasto_transito_tg: TDBEdit
      Left = 407
      Top = 31
      Width = 24
      Height = 21
      DataField = 'gasto_transito_tg'
      DataSource = DSMaestro
      Enabled = False
      ReadOnly = True
      TabOrder = 2
      Visible = False
      OnChange = gasto_transito_tgChange
    end
    object agrupacion_contable_tg: TBDEdit
      Left = 147
      Top = 159
      Width = 260
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Introduce la descripci'#243'n del tipo de Pago.'
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 9
      DataField = 'agrupacion_contable_tg'
      DataSource = DSMaestro
    end
    object tipo_iva_tg: TDBComboBox
      Left = 230
      Top = 82
      Width = 38
      Height = 21
      Style = csDropDownList
      DataField = 'tipo_iva_tg'
      DataSource = DSMaestro
      ItemHeight = 13
      Items.Strings = (
        '0'
        '1'
        '2')
      TabOrder = 4
      OnChange = tipo_iva_tgChange
    end
    object agrupacion_tg: TBDEdit
      Left = 147
      Top = 133
      Width = 81
      Height = 21
      ColorEdit = clMoneyGreen
      ReadOnly = True
      TabOrder = 8
      DataField = 'agrupacion_tg'
      DataSource = DSMaestro
    end
  end
  object RejillaFlotante: TBGrid
    Left = 368
    Top = 218
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
    DataSet = QTiposGastos
    Left = 48
    Top = 8
  end
  object ACosecheros: TActionList
    Left = 336
    Top = 8
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QTiposGastos: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT tipo_tg, descripcion_tg, facturable_tg'
      'FROM frf_tipo_gastos Frf_tipo_gastos'
      'ORDER BY tipo_tg, descripcion_tg')
    Left = 16
    Top = 8
  end
end
