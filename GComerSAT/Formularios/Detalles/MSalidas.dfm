object FMSalidas: TFMSalidas
  Left = 90
  Top = 102
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  SALIDAS DE FRUTA'
  ClientHeight = 703
  ClientWidth = 1020
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
    Width = 1020
    Height = 369
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    BevelWidth = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Bevel1: TBevel
      Left = 16
      Top = 14
      Width = 761
      Height = 52
      Style = bsRaised
    end
    object LEmpresa_p: TLabel
      Left = 407
      Top = 19
      Width = 68
      Height = 19
      AutoSize = False
      Caption = ' Centro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 47
      Top = 19
      Width = 68
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa_sc: TBGridButton
      Left = 164
      Top = 17
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = empresa_sc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 100
    end
    object Label5: TLabel
      Left = 16
      Top = 162
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Matricula'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LCliente: TLabel
      Left = 392
      Top = 70
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Cliente de Facturaci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LAno_semana_p: TLabel
      Left = 391
      Top = 139
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Operador Transporte'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBoperador_transporte_sc: TBGridButton
      Left = 550
      Top = 138
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = transporte_sc
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 300
      GridHeigth = 200
    end
    object BGBCentro_sc: TBGridButton
      Left = 514
      Top = 17
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = centro_salida_sc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 250
      GridHeigth = 100
    end
    object Label9: TLabel
      Left = 47
      Top = 42
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' N'#186' Albar'#225'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label14: TLabel
      Left = 16
      Top = 70
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Cliente de Salida'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBCliente_sal_sc: TBGridButton
      Left = 173
      Top = 68
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = cliente_sal_sc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 240
      GridHeigth = 200
    end
    object Label19: TLabel
      Left = 16
      Top = 92
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Direcci'#243'n de Suministro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBDir_sum_sc: TBGridButton
      Left = 173
      Top = 90
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = dir_sum_sc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 450
      GridHeigth = 200
    end
    object BGBCliente_fac_sc: TBGridButton
      Left = 549
      Top = 68
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = cliente_fac_sc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 240
      GridHeigth = 200
    end
    object Label20: TLabel
      Left = 392
      Top = 93
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Moneda'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBMoneda_sc: TBGridButton
      Left = 549
      Top = 91
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = moneda_sc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 180
      GridHeigth = 200
    end
    object LPedido: TLabel
      Left = 16
      Top = 116
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' N'#186' Pedido'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BCBFecha_sc: TBCalendarButton
      Left = 554
      Top = 41
      Width = 13
      Height = 21
      Hint = 'Pulse F2 para deplegar un calendario. '
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = fecha_sc
      Calendar = CalendarioFlotante
      CalendarAlignment = taDownRight
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object lblFactura: TLabel
      Left = 769
      Top = 183
      Width = 83
      Height = 20
      AutoSize = False
      Caption = ' Factura / Fecha'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label23: TLabel
      Left = 391
      Top = 162
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Transporte Bonnysa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label35: TLabel
      Left = 607
      Top = 116
      Width = 67
      Height = 19
      AutoSize = False
      Caption = ' N'#186' Orden'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label36: TLabel
      Left = 16
      Top = 230
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Observaciones Salida'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label37: TLabel
      Left = 16
      Top = 207
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Cond. Higi'#233'nicas OK'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNotaFactura: TLabel
      Left = 16
      Top = 323
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Observaciones Factura'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label38: TLabel
      Left = 16
      Top = 139
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Transportista'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBtransporte_sc: TBGridButton
      Left = 170
      Top = 137
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = operador_transporte_sc
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 300
      GridHeigth = 200
    end
    object lblNombre2: TLabel
      Left = 391
      Top = 207
      Width = 115
      Height = 19
      AutoSize = False
      Caption = 'Tipo Salida'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre1: TLabel
      Left = 566
      Top = 165
      Width = 138
      Height = 13
      Caption = '( Marcado pagamos el porte )'
    end
    object lblNombre3: TLabel
      Left = 212
      Top = 207
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Tiene Reclamaci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblAbonos: TLabel
      Left = 592
      Top = 230
      Width = 211
      Height = 19
      AutoSize = False
      Caption = 'Fact. Complementarias'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl1: TLabel
      Left = 16
      Top = 184
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Cond. Pago (Incoterm)'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBincoterm_c: TBGridButton
      Left = 173
      Top = 182
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      Control = incoterm_sc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object lbl2: TLabel
      Left = 391
      Top = 184
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Plaza Entrega'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl3: TLabel
      Left = 407
      Top = 42
      Width = 69
      Height = 19
      AutoSize = False
      Caption = ' Fecha Carga'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl4: TLabel
      Left = 569
      Top = 42
      Width = 30
      Height = 19
      AutoSize = False
      Caption = ' Hora'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblFechaDescarga: TLabel
      Left = 392
      Top = 116
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Fecha Descarga'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnFechaDescarga: TBCalendarButton
      Left = 588
      Top = 115
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = fecha_descarga_sc
      Calendar = CalendarioFlotante
      CalendarAlignment = taDownRight
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object lblCarpeta: TLabel
      Left = 902
      Top = 34
      Width = 50
      Height = 19
      AutoSize = False
      Caption = ' Carpeta'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblHasta: TLabel
      Left = 648
      Top = 42
      Width = 34
      Height = 19
      AutoSize = False
      Caption = ' Hasta'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnTipoSalida: TBGridButton
      Left = 550
      Top = 207
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = es_transito_sc
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 300
      GridHeigth = 200
    end
    object Label3: TLabel
      Left = 240
      Top = 116
      Width = 61
      Height = 19
      AutoSize = False
      Caption = 'Fec. Pedido '
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnFechaPedido: TBCalendarButton
      Left = 376
      Top = 115
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = fecha_pedido_sc
      Calendar = CalendarioFlotante
      CalendarAlignment = taDownRight
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object cbx_reclamacion_sc: TComboBox
      Left = 331
      Top = 206
      Width = 57
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 36
      Text = 'Todos'
      Visible = False
      Items.Strings = (
        'Todos'
        'Si'
        'No')
    end
    object cbx_porte_bonny_sc: TComboBox
      Left = 512
      Top = 161
      Width = 55
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 28
      Visible = False
      Items.Strings = (
        'Todos'
        'Si'
        'No')
    end
    object moneda_sc: TBDEdit
      Tag = 1
      Left = 511
      Top = 92
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de la moneda es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 14
      OnChange = PonNombre
      DataField = 'moneda_sc'
      DataSource = DSMaestro
    end
    object STCentro_salida_sc: TStaticText
      Left = 530
      Top = 20
      Width = 217
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 3
    end
    object centro_salida_sc: TBDEdit
      Tag = 1
      Left = 476
      Top = 18
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de centro es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 1
      TabOrder = 1
      OnChange = PonNombre
      OnExit = PonNumeroAlbaran
      DataField = 'centro_salida_sc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object empresa_sc: TBDEdit
      Tag = 1
      Left = 126
      Top = 18
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = PonNombre
      OnExit = PonNumeroAlbaran
      DataField = 'empresa_sc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object STEmpresa_sc: TStaticText
      Left = 180
      Top = 20
      Width = 217
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 2
    end
    object vehiculo_sc: TBDEdit
      Left = 135
      Top = 161
      Width = 220
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 27
      DataField = 'vehiculo_sc'
      DataSource = DSMaestro
    end
    object operador_transporte_sc: TBDEdit
      Left = 512
      Top = 138
      Width = 38
      Height = 21
      HelpType = htKeyword
      ColorEdit = clMoneyGreen
      RequiredMsg = 'El c'#243'digo del transportista es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 22
      OnChange = PonNombre
      DataField = 'operador_transporte_sc'
      DataSource = DSMaestro
    end
    object STOperador_transporte_sc: TStaticText
      Left = 566
      Top = 140
      Width = 200
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 25
    end
    object n_albaran_sc: TBDEdit
      Left = 126
      Top = 41
      Width = 88
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El n'#250'mero de albar'#225'n es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      TabOrder = 5
      DataField = 'n_albaran_sc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object fecha_sc: TBDEdit
      Left = 477
      Top = 41
      Width = 77
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'La fecha de la salida es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itDate
      MaxLength = 10
      TabOrder = 6
      DataField = 'fecha_sc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object hora_sc: TBDEdit
      Left = 601
      Top = 41
      Width = 47
      Height = 21
      Hint = 'Formato "HH:MM" '
      ColorEdit = clMoneyGreen
      MaxLength = 5
      TabOrder = 7
      OnEnter = EntrarEdit
      OnExit = SalirEdit
      DataField = 'hora_sc'
      DataSource = DSMaestro
    end
    object cliente_sal_sc: TBDEdit
      Tag = 1
      Left = 135
      Top = 69
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del cliente es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 9
      OnChange = PonNombre
      OnExit = RellenaClienteFacturacion
      DataField = 'cliente_sal_sc'
      DataSource = DSMaestro
    end
    object STCliente_sal_sc: TStaticText
      Left = 189
      Top = 71
      Width = 200
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 11
    end
    object dir_sum_sc: TBDEdit
      Tag = 1
      Left = 135
      Top = 91
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 
        'El c'#243'digo de la direcci'#243'n de suministro es de obligada inserci'#243'n' +
        '.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 13
      OnChange = dir_sum_scChange
      OnExit = dir_sum_scExit
      DataField = 'dir_sum_sc'
      DataSource = DSMaestro
    end
    object STDir_sum_sc: TStaticText
      Left = 189
      Top = 93
      Width = 200
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 15
    end
    object cliente_fac_sc: TBDEdit
      Tag = 1
      Left = 511
      Top = 69
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del cliente de facturaci'#243'n es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 10
      OnChange = PonNombre
      DataField = 'cliente_fac_sc'
      DataSource = DSMaestro
    end
    object STCliente_fac_sc: TStaticText
      Left = 565
      Top = 71
      Width = 200
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 12
    end
    object STMoneda_sc: TStaticText
      Left = 565
      Top = 94
      Width = 200
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 16
    end
    object n_pedido_sc: TBDEdit
      Left = 135
      Top = 115
      Width = 102
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 15
      TabOrder = 17
      DataField = 'n_pedido_sc'
      DataSource = DSMaestro
    end
    object n_factura_sc: TBDEdit
      Left = 858
      Top = 183
      Width = 64
      Height = 21
      TabStop = False
      ColorEdit = clBtnFace
      ColorNormal = clBtnFace
      ColorDisable = clBtnFace
      InputType = itInteger
      ReadOnly = True
      TabOrder = 32
      DataField = 'n_factura_sc'
      DataSource = DSMaestro
      Modificable = False
    end
    object fecha_factura_sc: TBDEdit
      Left = 925
      Top = 183
      Width = 75
      Height = 21
      TabStop = False
      ColorEdit = clBtnFace
      ColorNormal = clBtnFace
      ColorDisable = clBtnFace
      InputType = itDate
      ReadOnly = True
      MaxLength = 10
      TabOrder = 33
      OnChange = fecha_factura_scChange
      DataField = 'fecha_factura_sc'
      DataSource = DSMaestro
      Modificable = False
    end
    object porte_bonny_sc: TDBCheckBox
      Left = 512
      Top = 163
      Width = 17
      Height = 17
      DataField = 'porte_bonny_sc'
      DataSource = DSMaestro
      TabOrder = 29
      ValueChecked = '1'
      ValueUnchecked = '0'
      OnClick = porte_bonny_scClick
      OnEnter = porte_bonny_scEnter
      OnExit = porte_bonny_scExit
    end
    object cbx_higiene_sc: TComboBox
      Left = 135
      Top = 206
      Width = 57
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 35
      Visible = False
      Items.Strings = (
        'Todos'
        'Si'
        'No')
    end
    object n_orden_sc: TBDEdit
      Left = 680
      Top = 115
      Width = 85
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 10
      TabOrder = 20
      OnChange = PonNombre
      DataField = 'n_orden_sc'
      DataSource = DSMaestro
    end
    object nota_sc: TDBMemo
      Left = 135
      Top = 230
      Width = 456
      Height = 89
      DataField = 'nota_sc'
      DataSource = DSMaestro
      TabOrder = 41
    end
    object higiene_sc: TDBCheckBox
      Left = 135
      Top = 208
      Width = 17
      Height = 17
      DataField = 'higiene_sc'
      DataSource = DSMaestro
      TabOrder = 38
      ValueChecked = '1'
      ValueUnchecked = '0'
      OnEnter = porte_bonny_scEnter
      OnExit = porte_bonny_scExit
    end
    object nota_factura_sc: TDBMemo
      Left = 135
      Top = 323
      Width = 456
      Height = 35
      DataField = 'nota_factura_sc'
      DataSource = DSMaestro
      TabOrder = 42
      OnEnter = nota_factura_scEnter
    end
    object transporte_sc: TBDEdit
      Left = 135
      Top = 138
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itInteger
      MaxLength = 4
      TabOrder = 21
      OnChange = PonNombre
      DataField = 'transporte_sc'
      DataSource = DSMaestro
    end
    object STTransporte_sc: TStaticText
      Left = 189
      Top = 140
      Width = 200
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 24
    end
    object stxtTipoVenta: TStaticText
      Left = 565
      Top = 208
      Width = 200
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 40
    end
    object reclamacion_sc: TDBCheckBox
      Left = 331
      Top = 208
      Width = 17
      Height = 17
      DataField = 'reclamacion_sc'
      DataSource = DSMaestro
      TabOrder = 39
      ValueChecked = '1'
      ValueUnchecked = '0'
      OnEnter = porte_bonny_scEnter
      OnExit = porte_bonny_scExit
    end
    object incoterm_sc: TBDEdit
      Left = 135
      Top = 183
      Width = 35
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 30
      OnChange = incoterm_scChange
      DataField = 'incoterm_sc'
      DataSource = DSMaestro
    end
    object stIncoterm: TStaticText
      Left = 189
      Top = 185
      Width = 200
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 34
    end
    object plaza_incoterm_sc: TBDEdit
      Left = 512
      Top = 183
      Width = 135
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 31
      DataField = 'plaza_incoterm_sc'
      DataSource = DSMaestro
    end
    object edt_facturable_sc: TDBEdit
      Left = 943
      Top = 138
      Width = 49
      Height = 21
      DataField = 'facturable_sc'
      DataSource = DSMaestro
      TabOrder = 23
      Visible = False
      OnChange = edt_facturable_scChange
    end
    object facturable_sc: TDBCheckBox
      Left = 785
      Top = 140
      Width = 72
      Height = 17
      TabStop = False
      AllowGrayed = True
      Caption = 'Facturable'
      DataField = 'facturable_sc'
      DataSource = DSMaestro
      TabOrder = 26
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object fecha_descarga_sc: TBDEdit
      Left = 511
      Top = 115
      Width = 77
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'La fecha de la salida es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itDate
      MaxLength = 10
      TabOrder = 19
      DataField = 'fecha_descarga_sc'
      DataSource = DSMaestro
    end
    object carpeta_deposito_sc: TBDEdit
      Left = 945
      Top = 34
      Width = 55
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      MaxLength = 10
      TabOrder = 4
      OnChange = PonNombre
      DataField = 'carpeta_deposito_sc'
      DataSource = DSMaestro
    end
    object edtFechaHasta: TBEdit
      Left = 683
      Top = 41
      Width = 65
      Height = 21
      InputType = itDate
      TabOrder = 8
    end
    object es_transito_sc: TBDEdit
      Tag = 1
      Left = 511
      Top = 206
      Width = 27
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 1
      TabOrder = 37
      OnChange = es_transito_scChange
      DataField = 'es_transito_sc'
      DataSource = DSMaestro
    end
    object fecha_pedido_sc: TBDEdit
      Left = 301
      Top = 115
      Width = 77
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'La fecha de la salida es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itDate
      MaxLength = 10
      TabOrder = 18
      DataField = 'fecha_pedido_sc'
      DataSource = DSMaestro
    end
  end
  object PDetalle: TPanel
    Left = 0
    Top = 441
    Width = 1020
    Height = 192
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 19
    object Label2: TLabel
      Left = 27
      Top = 15
      Width = 72
      Height = 19
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBProducto_sl: TBGridButton
      Left = 132
      Top = 13
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = producto_sl
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 240
      GridHeigth = 200
    end
    object Label7: TLabel
      Left = 27
      Top = 161
      Width = 75
      Height = 19
      AutoSize = False
      Caption = ' Centro Origen'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBCentro_origen_sl: TBGridButton
      Left = 122
      Top = 160
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      Control = centro_origen_sl
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 250
      GridHeigth = 200
    end
    object Label6: TLabel
      Left = 313
      Top = 15
      Width = 75
      Height = 19
      AutoSize = False
      Caption = ' Art'#237'culo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label15: TLabel
      Left = 691
      Top = 15
      Width = 64
      Height = 19
      AutoSize = False
      Caption = ' Marca'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBMarca_sl: TBGridButton
      Left = 757
      Top = 13
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = marca_sl
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 220
      GridHeigth = 200
    end
    object Label16: TLabel
      Left = 313
      Top = 40
      Width = 75
      Height = 19
      AutoSize = False
      Caption = ' Categor'#237'a'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBCategoria_sl: TBGridButton
      Left = 422
      Top = 38
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = categoria_sl
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 140
      GridHeigth = 200
    end
    object Label17: TLabel
      Left = 691
      Top = 40
      Width = 64
      Height = 19
      AutoSize = False
      Caption = ' Color'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBColor_sl: TBGridButton
      Left = 757
      Top = 38
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = color_sl
      Grid = RejillaFlotante
      GridAlignment = taDownLeft
      GridWidth = 200
      GridHeigth = 200
    end
    object Label18: TLabel
      Left = 87
      Top = 65
      Width = 58
      Height = 19
      AutoSize = False
      Caption = ' Cajas'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label21: TLabel
      Left = 313
      Top = 65
      Width = 58
      Height = 19
      AutoSize = False
      Caption = ' Precio '
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label30: TLabel
      Left = 27
      Top = 40
      Width = 72
      Height = 19
      AutoSize = False
      Caption = ' Calibre'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBCalibre_sl: TBGridButton
      Left = 169
      Top = 38
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = calibre_sl
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 100
      GridHeigth = 200
    end
    object Label31: TLabel
      Left = 219
      Top = 65
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' Kilos'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label32: TLabel
      Left = 376
      Top = 65
      Width = 58
      Height = 19
      AutoSize = False
      Caption = ' Unidad'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label33: TLabel
      Left = 439
      Top = 65
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' Importe Neto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Lporc_iva_sl: TLabel
      Left = 533
      Top = 65
      Width = 58
      Height = 19
      AutoSize = False
      Caption = ' % IVA'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Liva_sl: TLabel
      Left = 596
      Top = 65
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' IVA'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LImporteTotal: TLabel
      Left = 687
      Top = 65
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' Importe Total'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label24: TLabel
      Left = 27
      Top = 112
      Width = 72
      Height = 19
      AutoSize = False
      Caption = ' N'#186' Palets'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label26: TLabel
      Left = 149
      Top = 112
      Width = 65
      Height = 19
      AutoSize = False
      Caption = ' Tipo Palets'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBtipo_palets_sl: TBGridButton
      Left = 244
      Top = 111
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Control = tipo_palets_sl
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object Label12: TLabel
      Left = 313
      Top = 161
      Width = 72
      Height = 19
      AutoSize = False
      Caption = ' Ref. Tr'#225'nsito'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label22: TLabel
      Left = 707
      Top = 136
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Emp. Procedencia'
      Color = cl3DLight
      Enabled = False
      ParentColor = False
      Layout = tlCenter
      Visible = False
    end
    object Label11: TLabel
      Left = 27
      Top = 65
      Width = 51
      Height = 19
      AutoSize = False
      Caption = 'Unds. caja'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl5: TLabel
      Left = 149
      Top = 65
      Width = 65
      Height = 19
      AutoSize = False
      Caption = ' Unidades'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblComercial: TLabel
      Left = 439
      Top = 112
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' Comercial'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnComercial: TBGridButton
      Left = 578
      Top = 111
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = comercial_sl
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 240
      GridHeigth = 200
    end
    object lbl6: TLabel
      Left = 27
      Top = 136
      Width = 72
      Height = 19
      AutoSize = False
      Caption = ' Notas Linea'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblEntrega: TLabel
      Left = 553
      Top = 161
      Width = 58
      Height = 19
      AutoSize = False
      Caption = ' N'#186' Entrega'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblAnyoSem: TLabel
      Left = 707
      Top = 161
      Width = 52
      Height = 19
      AutoSize = False
      Caption = ' A'#241'o/Sem'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object STProducto_sl: TStaticText
      Left = 146
      Top = 16
      Width = 162
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 4
    end
    object producto_sl: TBDEdit
      Tag = 1
      Left = 102
      Top = 14
      Width = 30
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del producto es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = CambioProducto
      DataField = 'producto_sl'
      DataSource = DSDetalle
      PrimaryKey = True
    end
    object centro_origen_sl: TBDEdit
      Tag = 1
      Left = 102
      Top = 160
      Width = 20
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 
        'El c'#243'digo del centro de origen del producto es de obligada inser' +
        'ci'#243'n.'
      OnRequiredTime = RequiredTime
      Enabled = False
      MaxLength = 1
      TabOrder = 30
      OnChange = PonNombre
      OnExit = centro_origen_slExit
      DataField = 'centro_origen_sl'
      DataSource = DSDetalle
      PrimaryKey = True
    end
    object STCentro_origen_sl: TStaticText
      Left = 135
      Top = 162
      Width = 173
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 36
    end
    object STEnvase_sl: TStaticText
      Left = 488
      Top = 16
      Width = 197
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 5
    end
    object marca_sl: TBDEdit
      Tag = 1
      Left = 730
      Top = 14
      Width = 25
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de la marca del producto es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 3
      OnChange = PonNombre
      DataField = 'marca_sl'
      DataSource = DSDetalle
      PrimaryKey = True
    end
    object STMarca_sl: TStaticText
      Left = 770
      Top = 16
      Width = 125
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 6
    end
    object categoria_sl: TBDEdit
      Tag = 1
      Left = 390
      Top = 39
      Width = 25
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo de la categoria del producto es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 8
      OnChange = PonNombre
      DataField = 'categoria_sl'
      DataSource = DSDetalle
      PrimaryKey = True
    end
    object STCategoria_sl: TStaticText
      Left = 435
      Top = 41
      Width = 250
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 10
      OnClick = PonNombre
    end
    object color_sl: TBDEdit
      Tag = 1
      Left = 734
      Top = 39
      Width = 20
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del color del producto es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 1
      TabOrder = 9
      OnChange = PonNombre
      DataField = 'color_sl'
      DataSource = DSDetalle
      PrimaryKey = True
    end
    object STcolor_sl: TStaticText
      Left = 770
      Top = 41
      Width = 125
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 11
    end
    object cajas_sl: TBDEdit
      Left = 86
      Top = 86
      Width = 58
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      InputType = itInteger
      TabOrder = 14
      OnChange = cajas_slChange
      DataField = 'cajas_sl'
      DataSource = DSDetalle
    end
    object precio_sl: TBDEdit
      Left = 313
      Top = 86
      Width = 58
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 4
      MaxLength = 9
      TabOrder = 16
      OnChange = CalculaImporte
      DataField = 'precio_sl'
      DataSource = DSDetalle
    end
    object calibre_sl: TBDEdit
      Tag = 1
      Left = 102
      Top = 39
      Width = 65
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El calibre del producto es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      CharCase = ecNormal
      MaxLength = 10
      TabOrder = 7
      DataField = 'calibre_sl'
      DataSource = DSDetalle
      PrimaryKey = True
    end
    object kilos_sl: TBDEdit
      Left = 219
      Top = 86
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      TabOrder = 15
      OnChange = kilos_slChange
      DataField = 'kilos_sl'
      DataSource = DSDetalle
    end
    object unidad_precio_sl: TBDEdit
      Left = 376
      Top = 86
      Width = 58
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      ColorNormal = clSilver
      ReadOnly = True
      MaxLength = 3
      TabOrder = 17
      DataField = 'unidad_precio_sl'
      DataSource = DSDetalle
    end
    object importe_neto_sl: TBDEdit
      Left = 440
      Top = 85
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      TabOrder = 12
      OnChange = importe_neto_slChange
      DataField = 'importe_neto_sl'
      DataSource = DSDetalle
    end
    object STUnidades: TStaticText
      Left = 149
      Top = 88
      Width = 65
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 22
    end
    object porc_iva_sl: TBDEdit
      Left = 533
      Top = 86
      Width = 36
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      ColorNormal = clSilver
      InputType = itReal
      MaxDecimals = 2
      ReadOnly = True
      MaxLength = 6
      TabOrder = 18
      DataField = 'porc_iva_sl'
      DataSource = DSDetalle
    end
    object iva_sl: TBDEdit
      Left = 596
      Top = 86
      Width = 89
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      ColorNormal = clSilver
      InputType = itReal
      MaxDecimals = 2
      ReadOnly = True
      MaxLength = 11
      TabOrder = 20
      DataField = 'iva_sl'
      DataSource = DSDetalle
    end
    object importe_total_sl: TBDEdit
      Left = 687
      Top = 86
      Width = 89
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      ColorNormal = clSilver
      ReadOnly = True
      MaxLength = 13
      TabOrder = 21
      DataField = 'importe_total_sl'
      DataSource = DSDetalle
    end
    object n_palets_sl: TBDEdit
      Left = 102
      Top = 111
      Width = 34
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      InputType = itInteger
      TabOrder = 23
      DataField = 'n_palets_sl'
      DataSource = DSDetalle
    end
    object tipo_palets_sl: TBDEdit
      Left = 219
      Top = 111
      Width = 25
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      MaxLength = 2
      TabOrder = 24
      OnChange = tipo_palets_slChange
      DataField = 'tipo_palets_sl'
      DataSource = DSDetalle
    end
    object tipo_iva_sl: TBDEdit
      Left = 568
      Top = 86
      Width = 23
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      ColorNormal = clSilver
      ReadOnly = True
      MaxLength = 2
      TabOrder = 19
      DataField = 'tipo_iva_sl'
      DataSource = DSDetalle
    end
    object ref_transitos_sl: TBDEdit
      Left = 388
      Top = 160
      Width = 58
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 
        'El c'#243'digo del envase que contiene al producto es de obligada ins' +
        'ercci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      Enabled = False
      MaxLength = 9
      TabOrder = 31
      OnEnter = ref_transitos_slEnter
      OnExit = ref_transitos_slExit
      DataField = 'ref_transitos_sl'
      DataSource = DSDetalle
      PrimaryKey = True
    end
    object emp_procedencia_sl: TBDEdit
      Tag = 1
      Left = 790
      Top = 135
      Width = 30
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Enabled = False
      Visible = False
      MaxLength = 3
      TabOrder = 29
      OnExit = centro_origen_slExit
      DataField = 'emp_procedencia_sl'
      DataSource = DSDetalle
      PrimaryKey = True
    end
    object stTipoPalets: TStaticText
      Left = 258
      Top = 113
      Width = 175
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 26
    end
    object edtfecha_transito_sl: TBDEdit
      Left = 448
      Top = 160
      Width = 77
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itDate
      Enabled = False
      MaxLength = 10
      TabOrder = 32
      DataField = 'fecha_transito_sl'
      DataSource = DSDetalle
    end
    object edtcentro_transito_sl: TBDEdit
      Tag = 1
      Left = 527
      Top = 160
      Width = 20
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = RequiredTime
      Enabled = False
      MaxLength = 1
      TabOrder = 33
      DataField = 'centro_transito_sl'
      DataSource = DSDetalle
    end
    object unidades_caja_sl: TBDEdit
      Left = 27
      Top = 86
      Width = 29
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 3
      TabOrder = 13
      OnChange = unidades_caja_slChange
      DataField = 'unidades_caja_sl'
      DataSource = DSDetalle
    end
    object comercial_sl: TBDEdit
      Tag = 1
      Left = 533
      Top = 111
      Width = 42
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 
        'El c'#243'digo del comercial que vende el producto es de obligada ins' +
        'ercci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 25
      OnChange = comercial_slChange
      DataField = 'comercial_sl'
      DataSource = DSDetalle
      PrimaryKey = True
    end
    object txtDesComercial: TStaticText
      Left = 596
      Top = 113
      Width = 181
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 27
    end
    object edtentrega_sl: TBDEdit
      Left = 102
      Top = 135
      Width = 601
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 90
      TabOrder = 28
      DataField = 'notas_sl'
      DataSource = DSDetalle
    end
    object entrega_sl: TBDEdit
      Left = 614
      Top = 160
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      MaxLength = 12
      TabOrder = 34
      OnChange = entrega_slChange
      DataField = 'entrega_sl'
      DataSource = DSDetalle
    end
    object anyo_semana_entrega_sl: TBDEdit
      Tag = 1
      Left = 762
      Top = 160
      Width = 58
      Height = 21
      ColorEdit = clMoneyGreen
      ColorDisable = clBtnFace
      OnRequiredTime = RequiredTime
      InputType = itInteger
      CharCase = ecNormal
      MaxLength = 6
      TabOrder = 35
      DataField = 'anyo_semana_entrega_sl'
      DataSource = DSDetalle
      PrimaryKey = True
    end
    object envase_sl: TcxDBTextEdit
      Left = 390
      Top = 14
      DataBinding.DataField = 'envase_sl'
      DataBinding.DataSource = DSDetalle
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 9
      Properties.OnChange = CambioDeEnvase
      Style.BorderStyle = ebs3D
      Style.LookAndFeel.Kind = lfUltraFlat
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.Kind = lfUltraFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.Kind = lfUltraFlat
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.Kind = lfUltraFlat
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 1
      OnExit = envase_slExit
      Width = 75
    end
    object ssEnvase: TSimpleSearch
      Left = 465
      Top = 14
      Width = 21
      Height = 21
      Hint = 'B'#250'squeda de Art'#237'culo'
      TabOrder = 2
      TabStop = False
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'MoneyTwins'
      OptionsImage.ImageIndex = 2
      OptionsImage.Images = FDM.ilxImagenes
      Titulo = 'Busqueda de Art'#237'culos'
      Tabla = 'frf_envases'
      Campos = <
        item
          Etiqueta = 'Art'#237'culo'
          Campo = 'envase_e'
          Ancho = 100
          Tipo = ctCadena
        end
        item
          Etiqueta = 'Descripci'#243'n'
          Campo = 'descripcion_e'
          Ancho = 400
          Tipo = ctCadena
        end>
      Database = 'BDProyecto'
      Join = 'fecha_baja_e is null'
      CampoResultado = 'envase_e'
      Enlace = envase_sl
      Tecla = 'F2'
      AntesEjecutar = ssEnvaseAntesEjecutar
      Concatenar = False
    end
  end
  object RVisualizacion: TDBGrid
    Left = 0
    Top = 633
    Width = 1020
    Height = 70
    Align = alClient
    BiDiMode = bdLeftToRight
    DataSource = DSDetalle
    Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    ParentBiDiMode = False
    PopupMenu = pmTransitos
    TabOrder = 20
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = RVisualizacionDblClick
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'producto_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Prod.'
        Width = 40
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'envase_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Art'#237'culo'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'desEnvase'
        Title.Caption = 'Descripci'#243'n'
        Width = 187
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'marca_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Marca'
        Width = 40
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'calibre_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Calibre'
        Width = 59
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'categoria_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Categ.'
        Width = 36
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'color_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Color'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'unidades_caja_sl'
        Title.Alignment = taRightJustify
        Title.Caption = 'Unds.'
        Width = 35
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cajas_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Cajas'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'kilos_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Kilogramos'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'precio_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Precio'
        Width = 60
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'unidad_precio_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Unidad'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'importe_neto_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Importe Neto'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'porc_iva_sl'
        Title.Alignment = taCenter
        Title.Caption = '% IVA'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'iva_sl'
        Title.Alignment = taCenter
        Title.Caption = 'IVA'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'importe_total_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Importe Total'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'n_palets_sl'
        Title.Alignment = taCenter
        Title.Caption = 'N'#186' Palets'
        Width = 52
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'tipo_palets_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Tipo'
        Width = 28
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'comercial_sl'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'id_linea_albaran_sl'
        Title.Caption = 'Lin'
        Width = 20
        Visible = True
      end>
  end
  object PCabecera: TPanel
    Left = 0
    Top = 369
    Width = 1020
    Height = 72
    Align = alTop
    TabOrder = 18
    object Label8: TLabel
      Left = 16
      Top = 17
      Width = 70
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label10: TLabel
      Left = 313
      Top = 17
      Width = 70
      Height = 18
      AutoSize = False
      Caption = ' Centro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label27: TLabel
      Left = 614
      Top = 16
      Width = 70
      Height = 19
      AutoSize = False
      Caption = ' Fecha'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label28: TLabel
      Left = 16
      Top = 41
      Width = 70
      Height = 19
      AutoSize = False
      Caption = ' Cliente'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label29: TLabel
      Left = 313
      Top = 41
      Width = 70
      Height = 19
      AutoSize = False
      Caption = ' Suministro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label34: TLabel
      Left = 614
      Top = 40
      Width = 70
      Height = 19
      AutoSize = False
      Caption = ' Albar'#225'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object STEmpresa: TStaticText
      Left = 91
      Top = 18
      Width = 218
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object STCentro: TStaticText
      Left = 389
      Top = 18
      Width = 218
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object STFecha: TStaticText
      Left = 691
      Top = 18
      Width = 92
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object STAlbaran: TStaticText
      Left = 691
      Top = 42
      Width = 92
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
    object STCliente: TStaticText
      Left = 91
      Top = 42
      Width = 218
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object STSuministro: TStaticText
      Left = 389
      Top = 42
      Width = 218
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
  end
  object SBGastos: TButton
    Left = 788
    Top = 13
    Width = 112
    Height = 20
    Caption = '&Gastos'
    TabOrder = 1
    TabStop = False
    OnClick = AGastosExecute
  end
  object sbVentas: TButton
    Left = 788
    Top = 33
    Width = 112
    Height = 20
    Caption = 'Cta. &Venta'
    TabOrder = 3
    TabStop = False
    OnClick = sbVentasClick
  end
  object btnValidar: TButton
    Left = 790
    Top = 87
    Width = 112
    Height = 20
    Caption = 'Pasar a Facturable'
    TabOrder = 7
    TabStop = False
    OnClick = btnValidarClick
  end
  object CalendarioFlotante: TBCalendario
    Left = 1022
    Top = 85
    Width = 212
    Height = 143
    AutoSize = True
    Date = 36748.833777800920000000
    ShowToday = False
    TabOrder = 6
    Visible = False
    WeekNumbers = True
    BControl = producto_sl
  end
  object RejillaFlotante: TBGrid
    Left = 1040
    Top = 247
    Width = 42
    Height = 57
    Color = clInfoBk
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 16
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object SBFacturable: TButton
    Left = 789
    Top = 108
    Width = 112
    Height = 20
    Caption = 'Ligar a Factura'
    Enabled = False
    TabOrder = 9
    TabStop = False
    Visible = False
    OnClick = SBFacturableClick
  end
  object btnVerAbonos: TButton
    Left = 896
    Top = 230
    Width = 104
    Height = 19
    Caption = 'Ver facturas'
    TabOrder = 15
    TabStop = False
    OnClick = btnVerAbonosClick
  end
  object edtImporteFacturado: TEdit
    Left = 925
    Top = 161
    Width = 75
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 12
  end
  object btnVerImpFac: TButton
    Left = 765
    Top = 162
    Width = 156
    Height = 19
    Caption = 'Ver Importe Facturado'
    TabOrder = 13
    TabStop = False
    OnClick = btnVerImpFacClick
  end
  object dbgAbonos: TDBGrid
    Left = 592
    Top = 254
    Width = 408
    Height = 103
    TabStop = False
    Color = clBtnFace
    DataSource = DSAbonos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 17
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'serie_fal'
        Title.Alignment = taCenter
        Title.Caption = 'Serie'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'factura_fal'
        Title.Alignment = taCenter
        Title.Caption = 'N'#186' Fact.'
        Width = 57
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_fal'
        Title.Alignment = taCenter
        Title.Caption = 'Fecha '
        Width = 59
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'producto_fal'
        Title.Alignment = taCenter
        Title.Caption = 'Prod.'
        Width = 21
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'importe'
        Title.Caption = 'Importe'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cod_factura_anula_fc'
        Title.Caption = 'Anula'
        Width = 92
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'n_remesa_rf'
        Title.Caption = 'Remesa'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_vencimiento_rc'
        Title.Alignment = taCenter
        Title.Caption = 'Fecha Rem.'
        Width = 80
        Visible = True
      end>
  end
  object btnDeposito: TButton
    Left = 902
    Top = 13
    Width = 98
    Height = 20
    Caption = 'Deposito Aduanas'
    TabOrder = 2
    TabStop = False
    OnClick = btnDepositoClick
  end
  object btnFacturar: TButton
    Left = 860
    Top = 139
    Width = 77
    Height = 20
    Caption = 'Facturar'
    TabOrder = 11
    TabStop = False
    Visible = False
    OnClick = btnFacturarClick
  end
  object btnEntrega: TButton
    Left = 904
    Top = 67
    Width = 96
    Height = 21
    Caption = 'Cambiar Entrega'
    TabOrder = 4
    TabStop = False
    OnClick = btnEntregaClick
  end
  object btnDesadv: TButton
    Left = 904
    Top = 87
    Width = 96
    Height = 20
    Caption = 'Desadv'
    TabOrder = 8
    TabStop = False
    OnClick = btnDesadvClick
  end
  object PanelPrecio: TPanel
    Left = 313
    Top = 209
    Width = 305
    Height = 153
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clGray
    TabOrder = 14
    Visible = False
    object SpeedButton1: TSpeedButton
      Left = 168
      Top = 90
      Width = 105
      Height = 22
      Caption = '&Cancelar'
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 32
      Top = 90
      Width = 105
      Height = 22
      Caption = '&Aceptar'
      OnClick = SpeedButton2Click
    end
    object precio: TBEdit
      Left = 112
      Top = 59
      Width = 121
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 4
      MaxLength = 10
      TabOrder = 1
      OnEnter = precioEnter
      OnExit = precioExit
      OnKeyDown = precioKeyDown
      OnKeyUp = precioKeyUp
    end
    object StaticText1: TStaticText
      Left = 32
      Top = 61
      Width = 79
      Height = 17
      BorderStyle = sbsSunken
      Caption = ' Precio Unitario '
      Color = clSilver
      ParentColor = False
      TabOrder = 2
    end
    object TextoPrecio: TStaticText
      Left = 32
      Top = 37
      Width = 238
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = '1 registro seleccionado.'
      Color = clSilver
      ParentColor = False
      TabOrder = 0
    end
    object etiquetaUnidad: TStaticText
      Left = 235
      Top = 61
      Width = 35
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = '* KGS'
      Color = clSilver
      ParentColor = False
      TabOrder = 3
    end
  end
  object btnDesglose: TButton
    Left = 904
    Top = 109
    Width = 96
    Height = 20
    Caption = 'Desglose Prod.'
    TabOrder = 10
    TabStop = False
    OnClick = btnDesgloseClick
  end
  object btnValorar: TButton
    Left = 790
    Top = 68
    Width = 112
    Height = 20
    Caption = 'Valorar Albar'#225'n'
    TabOrder = 5
    TabStop = False
    OnClick = btnValorarClick
  end
  object DSMaestro: TDataSource
    DataSet = QSalidasC
    Left = 872
    Top = 456
  end
  object ACosecheros: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 8
    Top = 112
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
    object AModificarDetalle: TAction
      Caption = 'Modificar'
    end
    object ABorrarDetalle: TAction
      Caption = 'Borrar'
    end
    object AInsertarDetalle: TAction
      Caption = 'Insertar'
    end
    object AGastos: TAction
      Caption = '&Gastos'
      Hint = 'Gastos Salidas (Alt+G)'
      OnExecute = AGastosExecute
    end
    object AMenuEmergente: TAction
      Caption = 'Precio Unitario'
      OnExecute = AMenuEmergenteExecute
    end
  end
  object DSDetalle: TDataSource
    DataSet = TSalidasL
    OnStateChange = DSDetalleStateChange
    OnDataChange = DSDetalleDataChange
    Left = 872
    Top = 488
  end
  object QSalidasC: TQuery
    AfterOpen = QSalidasCAfterOpen
    BeforeClose = QSalidasCBeforeClose
    BeforeEdit = QSalidasCBeforeEdit
    AfterScroll = QSalidasCAfterScroll
    OnNewRecord = QSalidasCNewRecord
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_salidas_c '
      
        'ORDER BY empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc, c' +
        'liente_sal_sc')
    Left = 838
    Top = 463
  end
  object TSalidasL: TTable
    BeforePost = TSalidasLBeforePost
    AfterPost = TSalidasLAfterPost
    BeforeDelete = TSalidasLBeforeDelete
    AfterDelete = TSalidasLAfterDelete
    OnCalcFields = TSalidasLCalcFields
    OnNewRecord = TSalidasLNewRecord
    DatabaseName = 'BDProyecto'
    IndexFieldNames = 'empresa_sl;centro_salida_sl;n_albaran_sl;fecha_sl'
    MasterFields = 'empresa_sc;centro_salida_sc;n_albaran_sc;fecha_sc'
    MasterSource = DSMaestro
    TableName = 'frf_salidas_l'
    Left = 824
    Top = 496
    object TSalidasLempresa_sl: TStringField
      FieldName = 'empresa_sl'
      Required = True
      FixedChar = True
      Size = 3
    end
    object TSalidasLcentro_salida_sl: TStringField
      FieldName = 'centro_salida_sl'
      Required = True
      FixedChar = True
      Size = 1
    end
    object TSalidasLn_albaran_sl: TIntegerField
      FieldName = 'n_albaran_sl'
      Required = True
    end
    object TSalidasLfecha_sl: TDateField
      FieldName = 'fecha_sl'
      Required = True
    end
    object TSalidasLid_linea_albaran_sl: TIntegerField
      FieldName = 'id_linea_albaran_sl'
      Required = True
    end
    object TSalidasLcentro_origen_sl: TStringField
      FieldName = 'centro_origen_sl'
      Required = True
      FixedChar = True
      Size = 1
    end
    object TSalidasLproducto_sl: TStringField
      FieldName = 'producto_sl'
      Required = True
      FixedChar = True
      Size = 3
    end
    object TSalidasLformato_cliente_sl: TStringField
      FieldName = 'formato_cliente_sl'
      FixedChar = True
      Size = 16
    end
    object TSalidasLenvase_sl: TStringField
      FieldName = 'envase_sl'
      FixedChar = True
      Size = 9
    end
    object TSalidasLenvaseold_sl: TStringField
      FieldName = 'envaseold_sl'
      FixedChar = True
      Size = 3
    end
    object TSalidasLmarca_sl: TStringField
      FieldName = 'marca_sl'
      Required = True
      FixedChar = True
      Size = 2
    end
    object TSalidasLcategoria_sl: TStringField
      FieldName = 'categoria_sl'
      FixedChar = True
      Size = 2
    end
    object TSalidasLcalibre_sl: TStringField
      FieldName = 'calibre_sl'
      Required = True
      FixedChar = True
      Size = 10
    end
    object TSalidasLcolor_sl: TStringField
      FieldName = 'color_sl'
      Required = True
      FixedChar = True
      Size = 1
    end
    object TSalidasLref_transitos_sl: TIntegerField
      FieldName = 'ref_transitos_sl'
    end
    object TSalidasLfecha_transito_sl: TDateField
      FieldName = 'fecha_transito_sl'
    end
    object TSalidasLcentro_transito_sl: TStringField
      FieldName = 'centro_transito_sl'
      FixedChar = True
      Size = 1
    end
    object TSalidasLunidades_caja_sl: TIntegerField
      FieldName = 'unidades_caja_sl'
    end
    object TSalidasLcajas_sl: TIntegerField
      FieldName = 'cajas_sl'
    end
    object TSalidasLkilos_sl: TFloatField
      FieldName = 'kilos_sl'
    end
    object TSalidasLkilos_reales_sl: TCurrencyField
      FieldName = 'kilos_reales_sl'
    end
    object TSalidasLkilos_posei_sl: TCurrencyField
      FieldName = 'kilos_posei_sl'
    end
    object TSalidasLprecio_sl: TFloatField
      FieldName = 'precio_sl'
    end
    object TSalidasLunidad_precio_sl: TStringField
      FieldName = 'unidad_precio_sl'
      FixedChar = True
      Size = 3
    end
    object TSalidasLimporte_neto_sl: TFloatField
      FieldName = 'importe_neto_sl'
    end
    object TSalidasLporc_iva_sl: TFloatField
      FieldName = 'porc_iva_sl'
      Required = True
    end
    object TSalidasLiva_sl: TFloatField
      FieldName = 'iva_sl'
    end
    object TSalidasLimporte_total_sl: TFloatField
      FieldName = 'importe_total_sl'
    end
    object TSalidasLn_palets_sl: TSmallintField
      FieldName = 'n_palets_sl'
    end
    object TSalidasLtipo_palets_sl: TStringField
      FieldName = 'tipo_palets_sl'
      FixedChar = True
      Size = 2
    end
    object TSalidasLtipo_iva_sl: TStringField
      FieldName = 'tipo_iva_sl'
      FixedChar = True
      Size = 2
    end
    object TSalidasLfederacion_sl: TStringField
      FieldName = 'federacion_sl'
      FixedChar = True
      Size = 1
    end
    object TSalidasLcliente_sl: TStringField
      FieldName = 'cliente_sl'
      FixedChar = True
      Size = 3
    end
    object TSalidasLemp_procedencia_sl: TStringField
      FieldName = 'emp_procedencia_sl'
      FixedChar = True
      Size = 3
    end
    object TSalidasLentrega_sl: TStringField
      FieldName = 'entrega_sl'
      FixedChar = True
      Size = 12
    end
    object TSalidasLanyo_semana_entrega_sl: TIntegerField
      FieldName = 'anyo_semana_entrega_sl'
    end
    object TSalidasLcomercial_sl: TStringField
      FieldName = 'comercial_sl'
      FixedChar = True
      Size = 3
    end
    object TSalidasLnotas_sl: TStringField
      FieldName = 'notas_sl'
      FixedChar = True
      Size = 90
    end
    object TSalidasLdesEnvase: TStringField
      FieldKind = fkCalculated
      FieldName = 'desEnvase'
      Size = 200
      Calculated = True
    end
  end
  object QAbonos: TQuery
    OnNewRecord = QSalidasCNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'SELECT *'
      'FROM frf_salidas_c '
      
        'ORDER BY empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc, c' +
        'liente_sal_sc')
    Left = 832
    Top = 231
  end
  object DSAbonos: TDataSource
    DataSet = QAbonos
    Left = 872
    Top = 224
  end
  object pmTransitos: TPopupMenu
    Left = 824
    Top = 312
    object mniAsignarTrnsito1: TMenuItem
      Caption = 'Asignar Tr'#225'nsito'
      OnClick = mniAsignarTrnsito1Click
    end
  end
end
