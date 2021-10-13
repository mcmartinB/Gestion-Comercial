object FMAjustesEnvComerciales: TFMAjustesEnvComerciales
  Left = 437
  Top = 207
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  AJUSTES ENVASES COMERCIALES'
  ClientHeight = 281
  ClientWidth = 533
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
  object pnlMaestro: TPanel
    Left = 0
    Top = 0
    Width = 533
    Height = 281
    Align = alClient
    TabOrder = 0
    object lbl1: TLabel
      Left = 49
      Top = 45
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnEmpresa: TBGridButton
      Left = 166
      Top = 44
      Width = 14
      Height = 22
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = empresa_ecc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 160
    end
    object lblLEmpresa_p: TLabel
      Left = 49
      Top = 72
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Centro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnCentro: TBGridButton
      Left = 166
      Top = 71
      Width = 14
      Height = 22
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = centro_ecc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 250
      GridHeigth = 160
    end
    object lblNombre12: TLabel
      Left = 49
      Top = 100
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Operador'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnOperador: TBGridButton
      Left = 166
      Top = 99
      Width = 14
      Height = 21
      Action = ARejillaFlotante
      Control = cod_operador_ecc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 180
      GridHeigth = 160
    end
    object btnEnvase: TBGridButton
      Left = 181
      Top = 126
      Width = 14
      Height = 21
      Action = ARejillaFlotante
      Control = cod_producto_ecc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 120
    end
    object lblEnvase: TLabel
      Left = 49
      Top = 127
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Envase'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl2: TLabel
      Left = 49
      Top = 155
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Fecha'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnFecha: TBCalendarButton
      Left = 208
      Top = 155
      Width = 14
      Height = 21
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = fecha_ecc
      Calendar = CalendarioFlotante
      CalendarAlignment = taCenterRight
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object lbl3: TLabel
      Left = 49
      Top = 182
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Cantidad'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblHasta: TLabel
      Left = 233
      Top = 155
      Width = 42
      Height = 19
      AutoSize = False
      Caption = ' Hasta'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
      Visible = False
    end
    object btnHasta: TBCalendarButton
      Left = 360
      Top = 155
      Width = 14
      Height = 21
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Visible = False
      Control = edtHasta
      Calendar = CalendarioFlotante
      CalendarAlignment = taCenterLeft
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object lblNota: TLabel
      Left = 49
      Top = 208
      Width = 78
      Height = 19
      AutoSize = False
      Caption = ' Nota'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object empresa_ecc: TBDEdit
      Tag = 1
      Left = 128
      Top = 44
      Width = 36
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = PonNombre
      DataField = 'empresa_ecc'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object txtEmpresa: TStaticText
      Left = 182
      Top = 46
      Width = 300
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object centro_ecc: TBDEdit
      Tag = 1
      Left = 128
      Top = 71
      Width = 20
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      RequiredMsg = 'El c'#243'digo de centro es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 1
      TabOrder = 2
      OnChange = PonNombre
      DataField = 'centro_ecc'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object txtCentro: TStaticText
      Left = 182
      Top = 73
      Width = 300
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 3
    end
    object cod_operador_ecc: TBDEdit
      Left = 128
      Top = 99
      Width = 36
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 4
      OnChange = PonNombre
      DataField = 'cod_operador_ecc'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object txtOperador: TStaticText
      Left = 182
      Top = 101
      Width = 300
      Height = 18
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 5
    end
    object txtEnvase: TStaticText
      Left = 197
      Top = 127
      Width = 285
      Height = 18
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 7
    end
    object cod_producto_ecc: TBDEdit
      Left = 128
      Top = 126
      Width = 51
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 5
      TabOrder = 6
      OnChange = PonNombre
      DataField = 'cod_producto_ecc'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object fecha_ecc: TBDEdit
      Left = 128
      Top = 154
      Width = 78
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'La fecha de la salida es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itDate
      MaxLength = 10
      TabOrder = 8
      OnChange = PonNombre
      DataField = 'fecha_ecc'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object cantidad_ecc: TBDEdit
      Left = 128
      Top = 181
      Width = 48
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itInteger
      MaxLength = 6
      TabOrder = 10
      DataField = 'cantidad_ecc'
      DataSource = DSMaestro
    end
    object edtHasta: TBEdit
      Left = 280
      Top = 154
      Width = 78
      Height = 21
      InputType = itDate
      Visible = False
      TabOrder = 9
    end
    object nota_ecc: TBDEdit
      Left = 128
      Top = 207
      Width = 246
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 11
      OnChange = PonNombre
      DataField = 'nota_ecc'
      DataSource = DSMaestro
    end
  end
  object RejillaFlotante: TBGrid
    Left = 511
    Top = 185
    Width = 42
    Height = 57
    Color = clInfoBk
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object CalendarioFlotante: TBCalendario
    Left = 482
    Top = 47
    Width = 212
    Height = 143
    AutoSize = True
    Date = 36748.948434201390000000
    ShowToday = False
    TabOrder = 1
    Visible = False
    WeekNumbers = True
  end
  object DSMaestro: TDataSource
    DataSet = QAjustes
    Left = 319
    Top = 14
  end
  object ACosecheros: TActionList
    Left = 351
    Top = 14
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QAjustes: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * '
      'FROM frf_centros'
      'ORDER BY centro_c')
    Left = 287
    Top = 15
  end
end
