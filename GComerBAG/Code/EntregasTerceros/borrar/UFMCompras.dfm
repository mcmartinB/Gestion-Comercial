object FMCompras: TFMCompras
  Left = 320
  Top = 152
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  ASIGNAR FACTURAS A COMPRAS'
  ClientHeight = 496
  ClientWidth = 843
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
    Width = 843
    Height = 496
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 432
      Top = 36
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Centro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 40
      Top = 36
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa_c: TBGridButton
      Left = 161
      Top = 35
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      Control = empresa_c
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object BGBCentro_c: TBGridButton
      Left = 553
      Top = 35
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      Control = centro_c
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object LFecha: TLabel
      Left = 240
      Top = 60
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Fecha'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BCBFecha_c: TBCalendarButton
      Left = 403
      Top = 59
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
      Control = fecha_c
      Calendar = CalendarioFlotante
      CalendarAlignment = taDownRight
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object lblNombre1: TLabel
      Left = 40
      Top = 60
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Num. Compra'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre2: TLabel
      Left = 432
      Top = 85
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Proveedor'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBProveedor_c: TBGridButton
      Left = 553
      Top = 84
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      Control = proveedor_c
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object lblNombre3: TLabel
      Left = 40
      Top = 130
      Width = 590
      Height = 19
      AutoSize = False
      Caption = ' Notas de la Compra'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre4: TLabel
      Left = 478
      Top = 8
      Width = 115
      Height = 13
      Alignment = taRightJustify
      Caption = 'NOMBRE CARPETA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Visible = False
    end
    object lblCarpeta: TLabel
      Left = 516
      Top = 6
      Width = 77
      Height = 13
      Alignment = taRightJustify
      Caption = 'Nombre Carpeta'
      Visible = False
    end
    object lblNombre5: TLabel
      Left = 386
      Top = 4
      Width = 207
      Height = 13
      Alignment = taRightJustify
      Caption = '(Empresa-Centro-A'#241'o-Proveedor-Contador)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -8
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
      Visible = False
    end
    object lblNombre6: TLabel
      Left = 40
      Top = 85
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Ref. Proveedor'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre9: TLabel
      Left = 432
      Top = 60
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Quien Compra'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnQuienCompra: TBGridButton
      Left = 553
      Top = 59
      Width = 13
      Height = 21
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      Enabled = False
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      Control = quien_compra_c
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object empresa_c: TBDEdit
      Left = 128
      Top = 35
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 1
      OnChange = empresa_cChange
      DataField = 'empresa_c'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object stEmpresa_c: TStaticText
      Left = 176
      Top = 37
      Width = 235
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 3
    end
    object centro_c: TBDEdit
      Left = 520
      Top = 35
      Width = 17
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del centro es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      TabOrder = 2
      OnChange = centro_cChange
      DataField = 'centro_c'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object stCentro_c: TStaticText
      Left = 568
      Top = 37
      Width = 235
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 4
    end
    object observaciones_c: TDBMemo
      Left = 40
      Top = 150
      Width = 585
      Height = 97
      DataField = 'observaciones_c'
      DataSource = DSMaestro
      TabOrder = 12
    end
    object fecha_c: TBDEdit
      Tag = 999
      Left = 328
      Top = 59
      Width = 73
      Height = 21
      ColorEdit = clMoneyGreen
      ColorDisable = cl3DLight
      Required = True
      RequiredMsg = 'La fecha de la compra es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itDate
      MaxLength = 10
      TabOrder = 6
      OnChange = fecha_cChange
      DataField = 'fecha_c'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object numero_c: TBDEdit
      Left = 128
      Top = 59
      Width = 73
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El n'#250'mero de la compra es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 5
      TabOrder = 5
      OnChange = numero_cChange
      DataField = 'numero_c'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object proveedor_c: TBDEdit
      Left = 520
      Top = 84
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo del proveedor es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 10
      OnChange = proveedor_cChange
      DataField = 'proveedor_c'
      DataSource = DSMaestro
    end
    object stProveedor_c: TStaticText
      Left = 568
      Top = 86
      Width = 235
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 11
    end
    object ref_compra_c: TBDEdit
      Left = 128
      Top = 84
      Width = 151
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El n'#250'mero de la compra es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 20
      TabOrder = 9
      OnChange = numero_cChange
      DataField = 'ref_compra_c'
      DataSource = DSMaestro
    end
    object status_gastos_c: TDBEdit
      Left = 399
      Top = 8
      Width = 121
      Height = 21
      DataField = 'status_gastos_c'
      DataSource = DSMaestro
      ReadOnly = True
      TabOrder = 0
      Visible = False
      OnChange = status_gastos_cChange
    end
    object quien_compra_c: TBDEdit
      Left = 520
      Top = 59
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de quien compra es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      Enabled = False
      MaxLength = 3
      TabOrder = 7
      OnChange = quien_compra_cChange
      DataField = 'quien_compra_c'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object stQuienCompra: TStaticText
      Left = 568
      Top = 61
      Width = 235
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 8
    end
  end
  object pBoton: TPanel
    Left = 637
    Top = 131
    Width = 166
    Height = 94
    TabOrder = 2
    object btnAsignar: TButton
      Left = 4
      Top = 63
      Width = 158
      Height = 25
      Caption = 'Asignar Facturas a Entregas'
      TabOrder = 2
      OnClick = btnAsignarClick
    end
    object btnFacturas: TButton
      Left = 4
      Top = 35
      Width = 158
      Height = 25
      Caption = 'Facturas Asociadas (Alt+F)'
      TabOrder = 1
      OnClick = btnFacturasClick
    end
    object btnEntregas: TButton
      Left = 4
      Top = 7
      Width = 158
      Height = 25
      Caption = 'Entregas Asociadas (Alt+E)'
      TabOrder = 0
      OnClick = btnEntregasClick
    end
  end
  object PInferior: TPanel
    Left = 35
    Top = 267
    Width = 770
    Height = 190
    TabOrder = 3
    object lblNombre7: TLabel
      Left = 2
      Top = 4
      Width = 380
      Height = 19
      Alignment = taCenter
      AutoSize = False
      Caption = 'Entregas Proveedor'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre8: TLabel
      Left = 383
      Top = 4
      Width = 380
      Height = 19
      Alignment = taCenter
      AutoSize = False
      Caption = 'Facturas Asociadas'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object DBGrid1: TDBGrid
      Left = 2
      Top = 26
      Width = 380
      Height = 158
      Color = clBtnFace
      DataSource = DSEntregas
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
    object DBGrid2: TDBGrid
      Left = 383
      Top = 26
      Width = 380
      Height = 158
      Color = clBtnFace
      DataSource = DSFacturas
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object RejillaFlotante: TBGrid
    Left = 239
    Top = 2
    Width = 73
    Height = 33
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
    BControl = empresa_c
  end
  object CalendarioFlotante: TBCalendario
    Left = 638
    Top = 404
    Width = 177
    Height = 136
    AutoSize = True
    Date = 36717.4336315625
    ShowToday = False
    TabOrder = 4
    Visible = False
    WeekNumbers = True
  end
  object DSMaestro: TDataSource
    DataSet = QCompras
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
  object QCompras: TQuery
    AfterOpen = QComprasAfterOpen
    BeforeClose = QComprasBeforeClose
    BeforePost = QComprasBeforePost
    AfterPost = QComprasAfterPost
    BeforeDelete = QComprasBeforeDelete
    OnPostError = QComprasPostError
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
    Top = 368
  end
  object QEntregas: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    Left = 96
    Top = 368
  end
  object QFacturas: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    Left = 376
    Top = 368
  end
  object DSFacturas: TDataSource
    DataSet = QFacturas
    Left = 408
    Top = 368
  end
end
