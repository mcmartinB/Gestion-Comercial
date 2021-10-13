object FMFacturasEntregasPlatano: TFMFacturasEntregasPlatano
  Left = 472
  Top = 306
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  FACTURAS DESPACHO PL'#193'TANO CANARIO'
  ClientHeight = 399
  ClientWidth = 764
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
    Width = 764
    Height = 399
    Align = alClient
    BevelInner = bvLowered
    Caption = 'fe '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LFecha: TLabel
      Left = 238
      Top = 36
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Fecha Factura'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BCBFecha_c: TBCalendarButton
      Left = 396
      Top = 35
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Control = fecha_fpc
      Calendar = CalendarioFlotante
      CalendarAlignment = taDownRight
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object lblNombre1: TLabel
      Left = 40
      Top = 36
      Width = 113
      Height = 19
      AutoSize = False
      Caption = ' Num. Factura'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre3: TLabel
      Left = 40
      Top = 138
      Width = 113
      Height = 19
      AutoSize = False
      Caption = ' Precio'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre6: TLabel
      Left = 40
      Top = 85
      Width = 113
      Height = 19
      AutoSize = False
      Caption = ' Receptor'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblAnyoSemana: TLabel
      Left = 40
      Top = 60
      Width = 113
      Height = 19
      AutoSize = False
      Caption = ' A'#241'o/Semana Entrega'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblAnyoSemana2: TLabel
      Left = 208
      Top = 60
      Width = 113
      Height = 19
      AutoSize = False
      Caption = ' (Formato: aaaass)'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl1: TLabel
      Left = 40
      Top = 110
      Width = 113
      Height = 19
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object fecha_fpc: TBDEdit
      Tag = 999
      Left = 321
      Top = 35
      Width = 73
      Height = 21
      ColorEdit = clMoneyGreen
      ColorDisable = cl3DLight
      Required = True
      RequiredMsg = 'La fecha de la factura es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itDate
      MaxLength = 10
      TabOrder = 2
      DataField = 'fecha_fpc'
      DataSource = DSMaestro
    end
    object n_factura_fpc: TBDEdit
      Left = 152
      Top = 35
      Width = 73
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El n'#250'mero de la compra es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 5
      TabOrder = 1
      DataField = 'n_factura_fpc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object anyo_semana_fpc: TBDEdit
      Left = 152
      Top = 59
      Width = 49
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El A'#241'o/Semana de las entregas es obligado.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -5
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TabOrder = 3
      OnChange = anyo_semana_fpcChange
      DataField = 'anyo_semana_fpc'
      DataSource = DSMaestro
    end
    object precio_fpc: TBDEdit
      Left = 152
      Top = 134
      Width = 73
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 3
      MaxLength = 6
      TabOrder = 6
      DataField = 'precio_fpc'
      DataSource = DSMaestro
    end
    object receptor_fpc: TDBComboBox
      Left = 152
      Top = 84
      Width = 400
      Height = 21
      CharCase = ecUpperCase
      DataField = 'receptor_fpc'
      DataSource = DSMaestro
      ItemHeight = 13
      TabOrder = 4
    end
    object lblIncremental: TEdit
      Left = 152
      Top = 35
      Width = 84
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
      Text = 'INCREMENTAL'
    end
    object producto_fpc: TDBComboBox
      Left = 152
      Top = 109
      Width = 400
      Height = 21
      CharCase = ecUpperCase
      DataField = 'producto_fpc'
      DataSource = DSMaestro
      ItemHeight = 13
      TabOrder = 5
    end
  end
  object PInferior: TPanel
    Left = 35
    Top = 174
    Width = 696
    Height = 204
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 29
      Width = 690
      Height = 171
      Color = clBtnFace
      DataSource = DSEntregas
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -7
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -7
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
    object btnEntregas: TButton
      Left = 3
      Top = 3
      Width = 158
      Height = 25
      Caption = 'Entregas Asociadas (Alt+E)'
      TabOrder = 0
      OnClick = btnEntregasClick
    end
    object btnAsignarPrecio: TButton
      Left = 534
      Top = 3
      Width = 158
      Height = 25
      Caption = 'Asignar Precio'
      TabOrder = 1
      OnClick = btnAsignarPrecioClick
    end
  end
  object CalendarioFlotante: TBCalendario
    Left = 638
    Top = 404
    Width = 212
    Height = 143
    AutoSize = True
    Date = 36717.535976157410000000
    ShowToday = False
    TabOrder = 2
    Visible = False
    WeekNumbers = True
  end
  object DSMaestro: TDataSource
    DataSet = QFacturasPlatano
    Left = 200
    Top = 8
  end
  object ACosecheros: TActionList
    Left = 344
    Top = 8
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QFacturasPlatano: TQuery
    AfterOpen = QFacturasPlatanoAfterOpen
    BeforeClose = QFacturasPlatanoBeforeClose
    BeforePost = QFacturasPlatanoBeforePost
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * '
      'FROM frf_compras'
      '')
    Left = 168
    Top = 9
  end
  object DSEntregas: TDataSource
    DataSet = QEntregas
    Left = 128
    Top = 272
  end
  object QEntregas: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    Left = 88
    Top = 272
  end
end
