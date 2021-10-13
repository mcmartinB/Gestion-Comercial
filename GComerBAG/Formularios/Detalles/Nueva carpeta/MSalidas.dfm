object FMSalidas: TFMSalidas
  Left = 352
  Top = 226
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  SALIDAS DE FRUTA'
  ClientHeight = 703
  ClientWidth = 1043
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
  object RVisualizacion: TDBGrid
    Left = 0
    Top = 580
    Width = 1043
    Height = 123
    Align = alClient
    BiDiMode = bdLeftToRight
    DataSource = DSDetalle
    Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    ParentBiDiMode = False
    TabOrder = 15
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
        Title.Caption = 'Envase'
        Width = 40
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
        Width = 40
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'categoria_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Categ.'
        Width = 40
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
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'unidades_caja_sl'
        Title.Alignment = taRightJustify
        Title.Caption = 'Unds.Caja'
        Width = 57
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
        Width = 35
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'comercial_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Comercial'
        Visible = True
      end>
  end
  object PDetalle: TPanel
    Left = 0
    Top = 413
    Width = 1043
    Height = 167
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 14
    object Label2: TLabel
      Left = 297
      Top = 17
      Width = 57
      Height = 19
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBProducto_sl: TBGridButton
      Left = 395
      Top = 15
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
    object Label6: TLabel
      Left = 591
      Top = 17
      Width = 57
      Height = 19
      AutoSize = False
      Caption = ' Envase'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEnvase_sl: TBGridButton
      Left = 685
      Top = 15
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      ParentShowHint = False
      ShowHint = True
      Control = envase_sl
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 240
      GridHeigth = 200
    end
    object Label15: TLabel
      Left = 16
      Top = 64
      Width = 57
      Height = 19
      AutoSize = False
      Caption = ' Marca'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBMarca_sl: TBGridButton
      Left = 103
      Top = 62
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
      Left = 16
      Top = 41
      Width = 57
      Height = 19
      AutoSize = False
      Caption = ' Categor'#237'a'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBCategoria_sl: TBGridButton
      Left = 103
      Top = 39
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
      Left = 591
      Top = 41
      Width = 57
      Height = 19
      AutoSize = False
      Caption = ' Color'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBColor_sl: TBGridButton
      Left = 685
      Top = 39
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
      Left = 79
      Top = 90
      Width = 58
      Height = 19
      AutoSize = False
      Caption = ' Cajas'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label21: TLabel
      Left = 310
      Top = 90
      Width = 58
      Height = 19
      AutoSize = False
      Caption = ' Precio '
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label30: TLabel
      Left = 297
      Top = 41
      Width = 57
      Height = 19
      AutoSize = False
      Caption = ' Calibre'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBCalibre_sl: TBGridButton
      Left = 439
      Top = 40
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
      Left = 216
      Top = 90
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' Kilos'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label32: TLabel
      Left = 373
      Top = 90
      Width = 58
      Height = 19
      AutoSize = False
      Caption = ' Unidad'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label33: TLabel
      Left = 436
      Top = 90
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' Importe Neto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Lporc_iva_sl: TLabel
      Left = 530
      Top = 90
      Width = 58
      Height = 19
      AutoSize = False
      Caption = ' % IVA'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Liva_sl: TLabel
      Left = 593
      Top = 90
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' IVA'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LImporteTotal: TLabel
      Left = 688
      Top = 90
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' Importe Total'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label24: TLabel
      Left = 776
      Top = 90
      Width = 58
      Height = 19
      AutoSize = False
      Caption = ' N'#186' Palets'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label26: TLabel
      Left = 297
      Top = 64
      Width = 57
      Height = 19
      AutoSize = False
      Caption = ' Tipo Palets'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBtipo_palets_sl: TBGridButton
      Left = 395
      Top = 63
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Control = tipo_palets_sl
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object lbl1: TLabel
      Left = 16
      Top = 90
      Width = 57
      Height = 19
      AutoSize = False
      Caption = ' Unds.Caja'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl2: TLabel
      Left = 140
      Top = 90
      Width = 70
      Height = 19
      AutoSize = False
      Caption = ' Unidades'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblEntrega: TLabel
      Left = 16
      Top = 17
      Width = 58
      Height = 19
      AutoSize = False
      Caption = ' N'#186' Entrega'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblAnyoSem: TLabel
      Left = 170
      Top = 17
      Width = 52
      Height = 19
      AutoSize = False
      Caption = ' A'#241'o/Sem'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblComercial: TLabel
      Left = 591
      Top = 64
      Width = 57
      Height = 19
      AutoSize = False
      Caption = ' Comercial'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnComercial: TBGridButton
      Left = 685
      Top = 63
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
    object lbl3: TLabel
      Left = 16
      Top = 135
      Width = 63
      Height = 19
      AutoSize = False
      Caption = ' Notas Linea'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object STProducto_sl: TStaticText
      Left = 409
      Top = 18
      Width = 167
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 4
    end
    object producto_sl: TBDEdit
      Tag = 1
      Left = 360
      Top = 16
      Width = 35
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del producto es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 2
      OnChange = CambioProducto
      DataField = 'producto_sl'
      DataSource = DSDetalle
      PrimaryKey = True
    end
    object envase_sl: TBDEdit
      Tag = 1
      Left = 653
      Top = 16
      Width = 30
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 
        'El c'#243'digo del envase que contiene al producto es de obligada ins' +
        'ercci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 3
      OnChange = CambioDeEnvase
      DataField = 'envase_sl'
      DataSource = DSDetalle
      PrimaryKey = True
    end
    object STEnvase_sl: TStaticText
      Left = 698
      Top = 18
      Width = 167
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 5
    end
    object marca_sl: TBDEdit
      Tag = 1
      Left = 77
      Top = 63
      Width = 25
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de la marca del producto es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 11
      OnChange = PonNombre
      DataField = 'marca_sl'
      DataSource = DSDetalle
      PrimaryKey = True
    end
    object STMarca_sl: TStaticText
      Left = 116
      Top = 65
      Width = 167
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 14
    end
    object categoria_sl: TBDEdit
      Tag = 1
      Left = 77
      Top = 40
      Width = 25
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo de la categoria del producto es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 6
      OnChange = PonNombre
      DataField = 'categoria_sl'
      DataSource = DSDetalle
      PrimaryKey = True
    end
    object STCategoria_sl: TStaticText
      Left = 116
      Top = 42
      Width = 167
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 9
      OnClick = PonNombre
    end
    object color_sl: TBDEdit
      Tag = 1
      Left = 653
      Top = 40
      Width = 20
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del color del producto es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 1
      TabOrder = 8
      OnChange = PonNombre
      DataField = 'color_sl'
      DataSource = DSDetalle
      PrimaryKey = True
    end
    object STcolor_sl: TStaticText
      Left = 698
      Top = 42
      Width = 167
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 10
    end
    object cajas_sl: TBDEdit
      Left = 79
      Top = 111
      Width = 58
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      InputType = itInteger
      TabOrder = 18
      OnChange = cajas_slChange
      DataField = 'cajas_sl'
      DataSource = DSDetalle
    end
    object precio_sl: TBDEdit
      Left = 310
      Top = 111
      Width = 58
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 3
      MaxLength = 9
      TabOrder = 20
      OnChange = CalculaImporte
      DataField = 'precio_sl'
      DataSource = DSDetalle
    end
    object calibre_sl: TBDEdit
      Tag = 1
      Left = 360
      Top = 40
      Width = 77
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
      Left = 216
      Top = 111
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      TabOrder = 19
      OnChange = kilos_slChange
      DataField = 'kilos_sl'
      DataSource = DSDetalle
    end
    object unidad_precio_sl: TBDEdit
      Left = 373
      Top = 111
      Width = 58
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      ColorNormal = clSilver
      ReadOnly = True
      MaxLength = 3
      TabOrder = 21
      DataField = 'unidad_precio_sl'
      DataSource = DSDetalle
    end
    object importe_neto_sl: TBDEdit
      Left = 436
      Top = 111
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      TabOrder = 22
      OnChange = importe_neto_slChange
      DataField = 'importe_neto_sl'
      DataSource = DSDetalle
    end
    object STUnidades: TStaticText
      Left = 140
      Top = 113
      Width = 70
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 28
    end
    object porc_iva_sl: TBDEdit
      Left = 530
      Top = 111
      Width = 36
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      ColorNormal = clSilver
      InputType = itReal
      MaxDecimals = 2
      ReadOnly = True
      MaxLength = 6
      TabOrder = 23
      DataField = 'porc_iva_sl'
      DataSource = DSDetalle
    end
    object iva_sl: TBDEdit
      Left = 593
      Top = 111
      Width = 89
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      ColorNormal = clSilver
      InputType = itReal
      MaxDecimals = 2
      ReadOnly = True
      MaxLength = 11
      TabOrder = 25
      DataField = 'iva_sl'
      DataSource = DSDetalle
    end
    object importe_total_sl: TBDEdit
      Left = 688
      Top = 111
      Width = 89
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      ColorNormal = clSilver
      ReadOnly = True
      MaxLength = 13
      TabOrder = 26
      DataField = 'importe_total_sl'
      DataSource = DSDetalle
    end
    object n_palets_sl: TBDEdit
      Left = 779
      Top = 111
      Width = 34
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      InputType = itInteger
      TabOrder = 27
      DataField = 'n_palets_sl'
      DataSource = DSDetalle
    end
    object tipo_palets_sl: TBDEdit
      Left = 360
      Top = 63
      Width = 25
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      MaxLength = 2
      TabOrder = 12
      OnChange = tipo_palets_slChange
      DataField = 'tipo_palets_sl'
      DataSource = DSDetalle
    end
    object tipo_iva_sl: TBDEdit
      Left = 565
      Top = 111
      Width = 23
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      ColorNormal = clSilver
      ReadOnly = True
      MaxLength = 2
      TabOrder = 24
      DataField = 'tipo_iva_sl'
      DataSource = DSDetalle
    end
    object stTipoPalets: TStaticText
      Left = 409
      Top = 65
      Width = 167
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 15
    end
    object unidades_caja_sl: TBDEdit
      Left = 16
      Top = 111
      Width = 32
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 3
      TabOrder = 17
      OnChange = cajas_slChange
      DataField = 'unidades_caja_sl'
      DataSource = DSDetalle
    end
    object entrega_sl: TBDEdit
      Left = 77
      Top = 16
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      MaxLength = 12
      TabOrder = 0
      OnChange = entrega_slChange
      DataField = 'entrega_sl'
      DataSource = DSDetalle
    end
    object anyo_semana_entrega_sl: TBDEdit
      Tag = 1
      Left = 225
      Top = 16
      Width = 58
      Height = 21
      ColorEdit = clMoneyGreen
      ColorDisable = clBtnFace
      OnRequiredTime = RequiredTime
      InputType = itInteger
      CharCase = ecNormal
      MaxLength = 6
      TabOrder = 1
      DataField = 'anyo_semana_entrega_sl'
      DataSource = DSDetalle
      PrimaryKey = True
    end
    object comercial_sl: TBDEdit
      Tag = 1
      Left = 653
      Top = 63
      Width = 30
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 
        'El c'#243'digo del comercial que vende el producto es de obligada ins' +
        'ercci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 13
      OnChange = comercial_slChange
      DataField = 'comercial_sl'
      DataSource = DSDetalle
      PrimaryKey = True
    end
    object txtDesComercial: TStaticText
      Left = 698
      Top = 65
      Width = 167
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 16
    end
    object edtentrega_sl: TBDEdit
      Left = 79
      Top = 135
      Width = 735
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 90
      TabOrder = 29
      OnChange = entrega_slChange
      DataField = 'notas_sl'
      DataSource = DSDetalle
    end
  end
  object PCabecera: TPanel
    Left = 0
    Top = 341
    Width = 1043
    Height = 72
    Align = alTop
    TabOrder = 12
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
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 1043
    Height = 341
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
      Left = 405
      Top = 19
      Width = 100
      Height = 19
      AutoSize = False
      Caption = ' Centro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 29
      Top = 19
      Width = 100
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa_sc: TBGridButton
      Left = 174
      Top = 17
      Width = 13
      Height = 22
      Action = ARejillaFlotante
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
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
      Left = 16
      Top = 93
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
      Control = operador_transporte_sc
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 300
      GridHeigth = 200
    end
    object BGBCentro_sc: TBGridButton
      Left = 550
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
      Left = 29
      Top = 42
      Width = 100
      Height = 19
      AutoSize = False
      Caption = ' N'#186' Albar'#225'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label11: TLabel
      Left = 405
      Top = 42
      Width = 100
      Height = 19
      AutoSize = False
      Caption = ' Fecha/Hora'
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
      Left = 392
      Top = 70
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Direcci'#243'n de Suministro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBDir_sum_sc: TBGridButton
      Left = 549
      Top = 68
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
      Left = 173
      Top = 91
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
      Left = 588
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
      Left = 781
      Top = 162
      Width = 90
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
      Left = 603
      Top = 116
      Width = 73
      Height = 19
      AutoSize = False
      Caption = ' N'#186' Orden'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label36: TLabel
      Left = 16
      Top = 208
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
      Top = 185
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
      Top = 301
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
      Left = 173
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
    object lblNombre1: TLabel
      Left = 569
      Top = 165
      Width = 192
      Height = 13
      Caption = '( Marcado el porte lo pagamos nosotros )'
    end
    object lblNombre3: TLabel
      Left = 215
      Top = 185
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Tiene Reclamaci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblAbonos: TLabel
      Left = 749
      Top = 208
      Width = 212
      Height = 19
      AutoSize = False
      Caption = 'Fact. Complementarias'
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
    object lblHasta: TLabel
      Left = 647
      Top = 41
      Width = 40
      Height = 19
      AutoSize = False
      Caption = ' Hasta'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre2: TLabel
      Left = 391
      Top = 185
      Width = 115
      Height = 19
      AutoSize = False
      Caption = 'Tipo Salida'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnTipoSalida: TBGridButton
      Left = 550
      Top = 184
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
    object cbx_reclamacion_sc: TComboBox
      Left = 332
      Top = 184
      Width = 57
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 31
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
      Width = 57
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 26
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
      TabOrder = 13
      OnChange = PonNombre
      DataField = 'moneda_sc'
      DataSource = DSMaestro
    end
    object STCentro_salida_sc: TStaticText
      Left = 566
      Top = 20
      Width = 200
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 3
    end
    object centro_salida_sc: TBDEdit
      Tag = 1
      Left = 511
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
      Left = 135
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
      Left = 190
      Top = 20
      Width = 200
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 2
    end
    object vehiculo_sc: TBDEdit
      Left = 135
      Top = 161
      Width = 174
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 20
      TabOrder = 25
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
      TabOrder = 20
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
      TabOrder = 23
    end
    object n_albaran_sc: TBDEdit
      Left = 135
      Top = 41
      Width = 88
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El n'#250'mero de albar'#225'n es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      TabOrder = 4
      DataField = 'n_albaran_sc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object fecha_sc: TBDEdit
      Left = 511
      Top = 41
      Width = 77
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'La fecha de la salida es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itDate
      MaxLength = 10
      TabOrder = 5
      DataField = 'fecha_sc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object hora_sc: TBDEdit
      Left = 600
      Top = 41
      Width = 47
      Height = 21
      Hint = 'Formato "HH:MM" '
      ColorEdit = clMoneyGreen
      MaxLength = 5
      TabOrder = 6
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
      TabOrder = 8
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
      TabOrder = 10
    end
    object dir_sum_sc: TBDEdit
      Tag = 1
      Left = 511
      Top = 69
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 
        'El c'#243'digo de la direcci'#243'n de suministro es de obligada inserci'#243'n' +
        '.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 9
      OnChange = dir_sum_scChange
      OnExit = dir_sum_scExit
      DataField = 'dir_sum_sc'
      DataSource = DSMaestro
    end
    object STDir_sum_sc: TStaticText
      Left = 565
      Top = 71
      Width = 200
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 11
    end
    object cliente_fac_sc: TBDEdit
      Tag = 1
      Left = 135
      Top = 92
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del cliente de facturaci'#243'n es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 12
      OnChange = PonNombre
      DataField = 'cliente_fac_sc'
      DataSource = DSMaestro
    end
    object STCliente_fac_sc: TStaticText
      Left = 189
      Top = 94
      Width = 200
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 14
    end
    object STMoneda_sc: TStaticText
      Left = 565
      Top = 94
      Width = 200
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 15
    end
    object n_pedido_sc: TBDEdit
      Left = 135
      Top = 115
      Width = 150
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 20
      TabOrder = 16
      DataField = 'n_pedido_sc'
      DataSource = DSMaestro
    end
    object n_factura_sc: TBDEdit
      Left = 871
      Top = 161
      Width = 65
      Height = 21
      TabStop = False
      ColorEdit = clBtnFace
      ColorNormal = clBtnFace
      ColorDisable = clBtnFace
      InputType = itInteger
      ReadOnly = True
      TabOrder = 27
      DataField = 'n_factura_sc'
      DataSource = DSMaestro
      Modificable = False
    end
    object fecha_factura_sc: TBDEdit
      Left = 940
      Top = 161
      Width = 85
      Height = 21
      TabStop = False
      ColorEdit = clBtnFace
      ColorNormal = clBtnFace
      ColorDisable = clBtnFace
      InputType = itDate
      ReadOnly = True
      MaxLength = 10
      TabOrder = 28
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
      OnEnter = porte_bonny_scEnter
      OnExit = porte_bonny_scExit
    end
    object cbx_higiene_sc: TComboBox
      Left = 135
      Top = 184
      Width = 57
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 30
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
      TabOrder = 18
      OnChange = PonNombre
      DataField = 'n_orden_sc'
      DataSource = DSMaestro
    end
    object nota_sc: TDBMemo
      Left = 135
      Top = 208
      Width = 610
      Height = 89
      DataField = 'nota_sc'
      DataSource = DSMaestro
      TabOrder = 37
    end
    object higiene_sc: TDBCheckBox
      Left = 135
      Top = 186
      Width = 17
      Height = 17
      DataField = 'higiene_sc'
      DataSource = DSMaestro
      TabOrder = 34
      ValueChecked = '1'
      ValueUnchecked = '0'
      OnEnter = porte_bonny_scEnter
      OnExit = porte_bonny_scExit
    end
    object nota_factura_sc: TDBMemo
      Left = 135
      Top = 301
      Width = 610
      Height = 35
      DataField = 'nota_factura_sc'
      DataSource = DSMaestro
      TabOrder = 38
    end
    object transporte_sc: TBDEdit
      Left = 135
      Top = 138
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itInteger
      MaxLength = 4
      TabOrder = 19
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
      TabOrder = 22
    end
    object reclamacion_sc: TDBCheckBox
      Left = 512
      Top = 186
      Width = 17
      Height = 17
      DataField = 'reclamacion_sc'
      DataSource = DSMaestro
      TabOrder = 35
      ValueChecked = '1'
      ValueUnchecked = '0'
      OnEnter = porte_bonny_scEnter
      OnExit = porte_bonny_scExit
    end
    object facturable_sc: TDBCheckBox
      Left = 781
      Top = 140
      Width = 72
      Height = 17
      TabStop = False
      AllowGrayed = True
      Caption = 'Facturable'
      DataField = 'facturable_sc'
      DataSource = DSMaestro
      TabOrder = 24
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object edt_facturable_sc: TDBEdit
      Left = 871
      Top = 138
      Width = 49
      Height = 21
      DataField = 'facturable_sc'
      DataSource = DSMaestro
      TabOrder = 21
      Visible = False
      OnChange = edt_facturable_scChange
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
      TabOrder = 17
      DataField = 'fecha_descarga_sc'
      DataSource = DSMaestro
    end
    object edtImporteFacturado: TEdit
      Left = 940
      Top = 184
      Width = 85
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 33
      Text = 'edtImporteFacturado'
    end
    object edtFechaHasta: TBEdit
      Left = 689
      Top = 41
      Width = 77
      Height = 21
      InputType = itDate
      TabOrder = 7
    end
    object es_transito_sc: TBDEdit
      Tag = 1
      Left = 511
      Top = 184
      Width = 27
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 1
      TabOrder = 32
      OnChange = es_transito_scChange
      DataField = 'es_transito_sc'
      DataSource = DSMaestro
    end
    object stxtTipoVenta: TStaticText
      Left = 566
      Top = 186
      Width = 200
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 36
    end
  end
  object PanelPrecio: TPanel
    Left = 306
    Top = 221
    Width = 305
    Height = 153
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clGray
    TabOrder = 9
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
      MaxDecimals = 3
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
  object SBGastos: TButton
    Left = 791
    Top = 13
    Width = 111
    Height = 21
    Caption = '&Gastos'
    TabOrder = 1
    TabStop = False
    OnClick = AGastosExecute
  end
  object SBFacturable: TButton
    Left = 791
    Top = 114
    Width = 112
    Height = 21
    Caption = 'Des/Asignar Fact.'
    TabOrder = 6
    TabStop = False
    OnClick = SBFacturableClick
  end
  object btnValorar: TButton
    Left = 791
    Top = 71
    Width = 112
    Height = 21
    Caption = 'Valorar Albar'#225'n'
    TabOrder = 4
    TabStop = False
    OnClick = btnValorarClick
  end
  object btnValidar: TButton
    Left = 791
    Top = 93
    Width = 112
    Height = 20
    Caption = 'Pasar a Facturable'
    TabOrder = 5
    TabStop = False
    OnClick = btnValidarClick
  end
  object btnDesadv: TButton
    Left = 791
    Top = 35
    Width = 111
    Height = 21
    Caption = 'Desadv'
    TabOrder = 3
    TabStop = False
    OnClick = btnDesadvClick
  end
  object btnEntrega: TButton
    Left = 904
    Top = 14
    Width = 121
    Height = 21
    Caption = 'Cambiar Entrega'
    TabOrder = 2
    TabStop = False
    OnClick = btnEntregaClick
  end
  object CalendarioFlotante: TBCalendario
    Left = 938
    Top = 353
    Width = 212
    Height = 143
    AutoSize = True
    Date = 36748.667477893520000000
    ShowToday = False
    TabOrder = 13
    Visible = False
    WeekNumbers = True
    BControl = producto_sl
  end
  object RejillaFlotante: TBGrid
    Left = 975
    Top = 325
    Width = 50
    Height = 50
    Color = clInfoBk
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 11
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object btnVerAbonos: TButton
    Left = 913
    Top = 208
    Width = 112
    Height = 19
    Caption = 'Ver Facturas'
    TabOrder = 8
    TabStop = False
    OnClick = btnVerAbonosClick
  end
  object btnVerImpFac: TButton
    Left = 781
    Top = 185
    Width = 156
    Height = 19
    Caption = 'Ver Importe Facturado'
    TabOrder = 7
    TabStop = False
    OnClick = btnVerImpFacClick
  end
  object dbgAbonos: TDBGrid
    Left = 749
    Top = 232
    Width = 276
    Height = 103
    TabStop = False
    Color = clBtnFace
    DataSource = DSAbonos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 10
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'factura_fal'
        Title.Alignment = taCenter
        Title.Caption = 'N'#186' Fact.'
        Width = 47
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_fal'
        Title.Alignment = taCenter
        Title.Caption = 'Fecha '
        Width = 55
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'producto_fal'
        Title.Alignment = taCenter
        Title.Caption = 'Prod.'
        Width = 26
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'importe'
        Title.Caption = 'Importe'
        Width = 49
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'remesa'
        Title.Caption = 'Remesa'
        Width = 50
        Visible = True
      end>
  end
  object DSMaestro: TDataSource
    DataSet = QSalidasC
    Left = 595
    Top = 551
  end
  object ACosecheros: TActionList
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
    Left = 653
    Top = 554
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
    Left = 563
    Top = 554
  end
  object TSalidasL: TTable
    OnNewRecord = TSalidasLNewRecord
    DatabaseName = 'BDProyecto'
    IndexFieldNames = 'empresa_sl;centro_salida_sl;n_albaran_sl;fecha_sl'
    MasterFields = 'empresa_sc;centro_salida_sc;n_albaran_sc;fecha_sc'
    MasterSource = DSMaestro
    TableName = 'frf_salidas_l'
    Left = 626
    Top = 554
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
    Left = 840
    Top = 247
  end
  object DSAbonos: TDataSource
    DataSet = QAbonos
    Left = 880
    Top = 248
  end
end
