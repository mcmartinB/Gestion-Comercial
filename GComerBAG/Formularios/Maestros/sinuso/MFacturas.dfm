object FMFacturas: TFMFacturas
  Left = 354
  Top = 221
  ActiveControl = empresa_f
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '   MANTENIMIENTO DE FACTURAS'
  ClientHeight = 451
  ClientWidth = 771
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
  OnDestroy = FormDestroy
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
    Width = 771
    Height = 217
    Align = alTop
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LEmpresa_f: TLabel
      Left = 39
      Top = 35
      Width = 81
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LCliente_fac_f: TLabel
      Left = 39
      Top = 59
      Width = 81
      Height = 19
      AutoSize = False
      Caption = ' Cliente factura'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BCBFecha_factura_f: TBCalendarButton
      Left = 363
      Top = 107
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
      Control = fecha_factura_f
      Calendar = CalendarioFlotante
      CalendarAlignment = taDownLeft
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object LCliente_sal_f: TLabel
      Left = 393
      Top = 60
      Width = 81
      Height = 19
      AutoSize = False
      Caption = 'Cliente salida'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBCliente_sal_f: TBGridButton
      Left = 507
      Top = 59
      Width = 13
      Height = 22
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
      Control = cliente_sal_f
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 280
      GridHeigth = 200
    end
    object LN_Factura_f: TLabel
      Left = 39
      Top = 108
      Width = 81
      Height = 19
      AutoSize = False
      Caption = ' N'#186' Factura'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LFecha_factura_f: TLabel
      Left = 194
      Top = 108
      Width = 97
      Height = 19
      AutoSize = False
      Caption = ' Fecha factura'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LMoneda_f: TLabel
      Left = 393
      Top = 83
      Width = 81
      Height = 19
      AutoSize = False
      Caption = 'Moneda'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LImporte_neto_f: TLabel
      Left = 38
      Top = 150
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' Importe neto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LTipo_impuesto_f: TLabel
      Left = 39
      Top = 83
      Width = 81
      Height = 19
      AutoSize = False
      Caption = ' Impuesto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LPorc_impuesto_f: TLabel
      Left = 138
      Top = 150
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' % Impuesto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LTotal_impuesto_f: TLabel
      Left = 238
      Top = 150
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' Total impuestos'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LImporte_total_f: TLabel
      Left = 338
      Top = 150
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' Importe Total'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LPrevision_cobro_f: TLabel
      Left = 538
      Top = 150
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' Previsi'#243'n de cobro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBMoneda_f: TBGridButton
      Left = 507
      Top = 82
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
      Control = moneda_f
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object BGBEmpresa_f: TBGridButton
      Left = 162
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
      Control = empresa_f
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object BGBCliente_fac_f: TBGridButton
      Left = 162
      Top = 59
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
      Control = cliente_fac_f
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object BGBTipo_impuesto_f: TBGridButton
      Left = 162
      Top = 83
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
      Control = tipo_impuesto_f
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object BCBPrevision_cobro_f: TBCalendarButton
      Left = 620
      Top = 174
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = ARejillaFlotanteExecute
      Control = prevision_cobro_f
      Calendar = CalendarioFlotante
      CalendarAlignment = taUpLeft
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object Label1: TLabel
      Left = 438
      Top = 150
      Width = 95
      Height = 19
      AutoSize = False
      Caption = ' Total Euros'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblFacturaAbono: TLabel
      Left = 393
      Top = 38
      Width = 60
      Height = 13
      Caption = 'Tipo Factura'
      Visible = False
    end
    object lblManualAutomatica: TLabel
      Left = 393
      Top = 110
      Width = 56
      Height = 13
      Caption = 'Facturaci'#243'n'
      Visible = False
    end
    object lblAbonoEnNegativo01: TLabel
      Left = 393
      Top = 110
      Width = 265
      Height = 13
      Caption = 'ATENCI'#211'N: Todos los importes de los abonos '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lblAbonoEnNegativo02: TLabel
      Left = 465
      Top = 125
      Width = 153
      Height = 13
      Caption = 'se introducen en negativo.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lblTipoFactura: TStaticText
      Left = 568
      Top = 16
      Width = 153
      Height = 24
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvNone
      BorderStyle = sbsSingle
      Caption = 'FACTURA'
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 0
    end
    object empresa_f: TBDEdit
      Left = 122
      Top = 35
      Width = 40
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo de la empresa es necesario'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 3
      OnChange = PonNombre
      DataField = 'empresa_f'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object cliente_fac_f: TBDEdit
      Left = 122
      Top = 59
      Width = 40
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del cliente es necesario.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 5
      OnChange = PonNombre
      DataField = 'cliente_fac_f'
      DataSource = DSMaestro
      Modificable = False
    end
    object cliente_sal_f: TBDEdit
      Tag = 1
      Left = 468
      Top = 59
      Width = 40
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del cliente es necesario.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 6
      OnChange = PonNombre
      DataField = 'cliente_sal_f'
      DataSource = DSMaestro
      Modificable = False
    end
    object STCliente_sal_f: TStaticText
      Left = 521
      Top = 61
      Width = 200
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 7
    end
    object n_factura_f: TBDEdit
      Left = 122
      Top = 107
      Width = 60
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El n'#250'mero de factura es obligatorio.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      TabOrder = 14
      OnExit = n_factura_fExit
      DataField = 'n_factura_f'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object fecha_factura_f: TBDEdit
      Left = 294
      Top = 107
      Width = 68
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'La fecha de la factura es obligatorio.'
      OnRequiredTime = RequiredTime
      InputType = itDate
      TabOrder = 15
      DataField = 'fecha_factura_f'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object tipo_factura_f: TBDEdit
      Left = 420
      Top = 19
      Width = 29
      Height = 21
      ColorEdit = clMoneyGreen
      Visible = False
      MaxLength = 3
      TabOrder = 1
      OnChange = tipo_factura_fChange
      DataField = 'tipo_factura_f'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object moneda_f: TBDEdit
      Left = 468
      Top = 82
      Width = 40
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 9
      OnChange = CambiarMoneda
      DataField = 'moneda_f'
      DataSource = DSMaestro
      Modificable = False
    end
    object importe_neto_f: TBDEdit
      Left = 38
      Top = 174
      Width = 95
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      TabOrder = 18
      OnChange = CalcularTotal
      DataField = 'importe_neto_f'
      DataSource = DSMaestro
      Modificable = False
    end
    object tipo_impuesto_f: TBDEdit
      Left = 122
      Top = 83
      Width = 40
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El tipo de impuesto es necesario.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 10
      OnChange = PorcentajeImpuesto
      DataField = 'tipo_impuesto_f'
      DataSource = DSMaestro
      Modificable = False
    end
    object porc_impuesto_f: TBDEdit
      Left = 138
      Top = 174
      Width = 95
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      InputType = itReal
      MaxDecimals = 2
      ShowDecimals = True
      MaxLength = 6
      TabOrder = 19
      OnChange = CalculaImpuestos
      DataField = 'porc_impuesto_f'
      DataSource = DSMaestro
      Modificable = False
    end
    object total_impuesto_f: TBDEdit
      Left = 238
      Top = 174
      Width = 95
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      TabOrder = 20
      OnChange = CalcularTotal2
      DataField = 'total_impuesto_f'
      DataSource = DSMaestro
      Modificable = False
    end
    object importe_total_f: TBDEdit
      Left = 338
      Top = 174
      Width = 95
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 10
      TabOrder = 21
      DataField = 'importe_total_f'
      DataSource = DSMaestro
      Modificable = False
    end
    object prevision_cobro_f: TBDEdit
      Left = 538
      Top = 174
      Width = 81
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itDate
      TabOrder = 23
      DataField = 'prevision_cobro_f'
      DataSource = DSMaestro
    end
    object STEmpresa_f: TStaticText
      Left = 176
      Top = 36
      Width = 200
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 4
    end
    object STCliente_fac_f: TStaticText
      Left = 176
      Top = 62
      Width = 200
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 8
    end
    object STMoneda_f: TStaticText
      Left = 521
      Top = 84
      Width = 200
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 12
    end
    object STTipo_impuesto_f: TStaticText
      Left = 176
      Top = 84
      Width = 200
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 11
    end
    object importe_euros_f: TBDEdit
      Left = 438
      Top = 174
      Width = 95
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 10
      TabOrder = 22
      DataField = 'importe_euros_f'
      DataSource = DSMaestro
      Modificable = False
    end
    object cbxFacturaAbono: TComboBox
      Left = 468
      Top = 34
      Width = 146
      Height = 21
      Style = csDropDownList
      Color = clScrollBar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemHeight = 13
      ItemIndex = 0
      ParentFont = False
      TabOrder = 2
      TabStop = False
      Text = 'Todos (380/381)'
      Visible = False
      OnChange = cbxFacturaAbonoChange
      Items.Strings = (
        'Todos (380/381)'
        'Factura (380)'
        'Abonos (381)')
    end
    object cbxManualAutomatica: TComboBox
      Left = 468
      Top = 105
      Width = 146
      Height = 21
      Style = csDropDownList
      Color = clScrollBar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemHeight = 13
      ItemIndex = 0
      ParentFont = False
      TabOrder = 13
      TabStop = False
      Text = 'Todas (Auto/Manual)'
      Visible = False
      OnChange = cbxManualAutomaticaChange
      Items.Strings = (
        'Todas (Auto/Manual)'
        'Automatica'
        'Manual')
    end
    object concepto_f: TBDEdit
      Left = 316
      Top = 131
      Width = 29
      Height = 21
      ColorEdit = clMoneyGreen
      Visible = False
      MaxLength = 3
      TabOrder = 17
      DataField = 'concepto_f'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object lblAnulacionFactura: TStaticText
      Left = 393
      Top = 115
      Width = 328
      Height = 21
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvNone
      BorderStyle = sbsSingle
      Caption = 'FACTURA'
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 16
    end
  end
  object pgFactura: TPageControl
    Left = 0
    Top = 217
    Width = 696
    Height = 234
    ActivePage = tsAbono
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    TabPosition = tpBottom
    TabWidth = 200
    OnChange = pgFacturaChange
    object tsRemesa: TTabSheet
      Caption = 'Remesa / Contabilizaci'#243'n'
      object LContabilizado_f: TLabel
        Left = 56
        Top = 12
        Width = 125
        Height = 19
        AutoSize = False
        Caption = ' Factura Contabilizada'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label2: TLabel
        Left = 56
        Top = 33
        Width = 125
        Height = 19
        AutoSize = False
        Caption = ' REMESAS'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label3: TLabel
        Left = 320
        Top = 12
        Width = 125
        Height = 19
        AutoSize = False
        Caption = ' Fichero Contabilizaci'#243'n'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label4: TLabel
        Left = 192
        Top = 129
        Width = 215
        Height = 19
        AutoSize = False
        Caption = ' IMPORTE COBRADO TOTAL'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lblRemesaGiro: TLabel
        Left = 55
        Top = 172
        Width = 125
        Height = 19
        AutoSize = False
        Caption = ' Remesa Giro'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lblGiro: TLabel
        Left = 482
        Top = 172
        Width = 85
        Height = 19
        AutoSize = False
        Caption = ' N'#250'mero Giro'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lbl1: TLabel
        Left = 283
        Top = 172
        Width = 109
        Height = 19
        AutoSize = False
        Caption = ' Fecha Remesa Giro'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Contabilizado_f: TDBCheckBox
        Left = 38
        Top = 11
        Width = 17
        Height = 20
        Caption = 'Contabilizado_f'
        Color = clBtnFace
        DataField = 'contabilizado_f'
        DataSource = DSMaestro
        ParentColor = False
        ReadOnly = True
        TabOrder = 0
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnEnter = Contabilizado_fEnter
        OnExit = Contabilizado_fExit
      end
      object filename_conta_f: TBDEdit
        Left = 456
        Top = 11
        Width = 179
        Height = 21
        ColorEdit = clMoneyGreen
        ColorDisable = clBtnFace
        MaxLength = 30
        TabOrder = 1
        DataField = 'filename_conta_f'
        DataSource = DSMaestro
      end
      object cbxContabilizado_f: TComboBox
        Left = 192
        Top = 12
        Width = 121
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 2
        Text = 'Todas'
        Visible = False
        Items.Strings = (
          'Todas'
          'Contabilizada'
          'No Contabilizada')
      end
      object DBGRemesas: TDBGrid
        Left = 192
        Top = 37
        Width = 441
        Height = 89
        DataSource = DSRemesas
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 3
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'remesa_fr'
            Title.Alignment = taCenter
            Title.Caption = 'Remesa'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'fecha_remesa_fr'
            Title.Alignment = taCenter
            Title.Caption = 'Fecha Remesa'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'importe_cobrado_fr'
            Title.Alignment = taCenter
            Title.Caption = 'Importe Cobrado Remesa'
            Width = 130
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'moneda_fr'
            Title.Alignment = taCenter
            Title.Caption = 'Moneda'
            Visible = True
          end>
      end
      object importe_cobrado: TBDEdit
        Left = 411
        Top = 129
        Width = 130
        Height = 21
        ColorDisable = clBtnFace
        TabOrder = 4
        DataField = 'importe_cobrado'
        DataSource = DSImporteCobrado
      end
      object edtRemesaGiro: TBDEdit
        Left = 191
        Top = 171
        Width = 60
        Height = 21
        ColorEdit = clMoneyGreen
        ColorDisable = clBtnFace
        Required = True
        InputType = itInteger
        MaxLength = 6
        TabOrder = 5
        DataField = 'n_remesa_fgc'
        DataSource = dsGiros
        Modificable = False
      end
      object edtGiro: TBDEdit
        Left = 573
        Top = 171
        Width = 60
        Height = 21
        ColorEdit = clMoneyGreen
        ColorDisable = clBtnFace
        Required = True
        InputType = itInteger
        ShowDecimals = True
        MaxLength = 6
        TabOrder = 7
        DataField = 'n_giro_fgd'
        DataSource = dsGiros
        Modificable = False
      end
      object edtFechaRemesa: TBDEdit
        Left = 396
        Top = 171
        Width = 70
        Height = 21
        ColorEdit = clMoneyGreen
        ColorDisable = clBtnFace
        Required = True
        InputType = itDate
        ShowDecimals = True
        MaxLength = 10
        TabOrder = 6
        DataField = 'fecha_remesa_fgc'
        DataSource = dsGiros
        Modificable = False
      end
    end
    object tsTexto: TTabSheet
      Caption = 'Texto'
      ImageIndex = 1
      object mmoTextoFacutura: TDBMemo
        Left = 0
        Top = 0
        Width = 688
        Height = 208
        TabStop = False
        Align = alClient
        DataField = 'texto_fm'
        DataSource = DSFacturaManual
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object tsAbono: TTabSheet
      Caption = 'Detalle Abono'
      ImageIndex = 2
      object grdAbonos: TDBGrid
        Left = 0
        Top = 128
        Width = 688
        Height = 80
        TabStop = False
        Align = alClient
        DataSource = DSDetalleAbono
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'centro_salida_fal'
            Title.Alignment = taCenter
            Title.Caption = 'Salida'
            Width = 48
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'n_albaran_fal'
            Title.Alignment = taCenter
            Title.Caption = 'Albar'#225'n'
            Width = 48
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'fecha_albaran_fal'
            Title.Alignment = taCenter
            Title.Caption = 'Fecha'
            Width = 66
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'producto_fal'
            Title.Alignment = taCenter
            Title.Caption = 'Prod.'
            Width = 48
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'centro_origen_fal'
            Title.Caption = 'Origen'
            Width = 48
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'categoria_fal'
            Title.Alignment = taCenter
            Title.Caption = 'Cat.'
            Width = 48
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'envase_fal'
            Title.Alignment = taCenter
            Title.Caption = 'Envase'
            Width = 48
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'unidad_fal'
            Title.Alignment = taCenter
            Title.Caption = 'Unidad'
            Width = 48
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'unidades_fal'
            Title.Alignment = taCenter
            Title.Caption = 'Cantidad'
            Width = 48
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'precio_fal'
            Title.Alignment = taCenter
            Title.Caption = 'Precio'
            Width = 55
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'importe_fal'
            Title.Alignment = taCenter
            Title.Caption = 'Importe'
            Width = 74
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'cosechero_fal'
            Title.Alignment = taCenter
            Title.Caption = 'Cosec.'
            Width = 48
            Visible = True
          end>
      end
      object pnlAbono: TPanel
        Left = 0
        Top = 0
        Width = 688
        Height = 128
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Bevel1: TBevel
          Left = 352
          Top = 37
          Width = 289
          Height = 86
        end
        object nbLabel2: TnbLabel
          Left = 29
          Top = 4
          Width = 70
          Height = 21
          Caption = 'Centro Salida'
          About = 'NB 0.1/20020725'
        end
        object nbLabel1: TnbLabel
          Left = 354
          Top = 4
          Width = 70
          Height = 21
          Caption = 'N'#186' Albar'#225'n'
          About = 'NB 0.1/20020725'
        end
        object nbLabel3: TnbLabel
          Left = 485
          Top = 4
          Width = 70
          Height = 21
          Caption = 'Fecha'
          About = 'NB 0.1/20020725'
        end
        object btnFechaAlbaran: TBCalendarButton
          Left = 624
          Top = 4
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
          Control = fecha_albaran_fal
          Calendar = CalendarioFlotante
          CalendarAlignment = taDownLeft
          CalendarWidth = 197
          CalendarHeigth = 153
        end
        object nbLabel4: TnbLabel
          Left = 29
          Top = 28
          Width = 70
          Height = 21
          Caption = 'Prod.'
          About = 'NB 0.1/20020725'
        end
        object nbLabel5: TnbLabel
          Left = 29
          Top = 76
          Width = 70
          Height = 21
          Caption = 'Cat.'
          About = 'NB 0.1/20020725'
        end
        object nbLabel6: TnbLabel
          Left = 575
          Top = 41
          Width = 60
          Height = 15
          Caption = 'Imp. Neto'
          About = 'NB 0.1/20020725'
        end
        object nbLabel8: TnbLabel
          Left = 29
          Top = 100
          Width = 70
          Height = 21
          Caption = 'Env.'
          About = 'NB 0.1/20020725'
        end
        object nbLabel9: TnbLabel
          Left = 362
          Top = 41
          Width = 81
          Height = 15
          Caption = 'Unidad'
          About = 'NB 0.1/20020725'
        end
        object nbLabel10: TnbLabel
          Left = 454
          Top = 41
          Width = 55
          Height = 15
          Caption = 'Unidades'
          About = 'NB 0.1/20020725'
        end
        object nbLabel11: TnbLabel
          Left = 514
          Top = 41
          Width = 55
          Height = 15
          Caption = 'Precio'
          About = 'NB 0.1/20020725'
        end
        object nbLabel12: TnbLabel
          Left = 29
          Top = 52
          Width = 70
          Height = 21
          Caption = 'Centro Origen'
          About = 'NB 0.1/20020725'
        end
        object stCentroSalida: TnbStaticText
          Left = 152
          Top = 4
          Width = 186
          Height = 21
          About = 'NB 0.1/20020725'
        end
        object stProducto: TnbStaticText
          Left = 152
          Top = 28
          Width = 186
          Height = 21
          About = 'NB 0.1/20020725'
        end
        object stEnvase: TnbStaticText
          Left = 152
          Top = 100
          Width = 186
          Height = 21
          About = 'NB 0.1/20020725'
        end
        object stCentroOrigen: TnbStaticText
          Left = 152
          Top = 52
          Width = 186
          Height = 21
          About = 'NB 0.1/20020725'
        end
        object stCategoria: TnbStaticText
          Left = 152
          Top = 76
          Width = 186
          Height = 21
          About = 'NB 0.1/20020725'
        end
        object btnCentroSalida: TBGridButton
          Left = 136
          Top = 3
          Width = 13
          Height = 22
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
          ParentShowHint = False
          ShowHint = True
          OnClick = ARejillaFlotanteExecute
          Control = centro_salida_fal
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 230
          GridHeigth = 100
        end
        object btnProducto: TBGridButton
          Left = 136
          Top = 27
          Width = 13
          Height = 22
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
          ParentShowHint = False
          ShowHint = True
          OnClick = ARejillaFlotanteExecute
          Control = producto_fal
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 230
          GridHeigth = 100
        end
        object btnEnvase: TBGridButton
          Left = 136
          Top = 99
          Width = 13
          Height = 22
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
          ParentShowHint = False
          ShowHint = True
          OnClick = ARejillaFlotanteExecute
          Control = envase_fal
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 230
          GridHeigth = 100
        end
        object btnCentroOrigen: TBGridButton
          Left = 136
          Top = 51
          Width = 13
          Height = 22
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
          ParentShowHint = False
          ShowHint = True
          OnClick = ARejillaFlotanteExecute
          Control = centro_origen_fal
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 230
          GridHeigth = 100
        end
        object btnCategoria: TBGridButton
          Left = 136
          Top = 75
          Width = 13
          Height = 22
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
          ParentShowHint = False
          ShowHint = True
          OnClick = ARejillaFlotanteExecute
          Control = categoria_fal
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 230
          GridHeigth = 100
        end
        object lblCodigo1: TnbLabel
          Left = 514
          Top = 79
          Width = 55
          Height = 15
          Caption = 'Descuento'
          About = 'NB 0.1/20020725'
        end
        object lblCodigo2: TnbLabel
          Left = 575
          Top = 79
          Width = 60
          Height = 15
          Caption = 'Imp. Neto'
          About = 'NB 0.1/20020725'
        end
        object centro_salida_fal: TBDEdit
          Left = 101
          Top = 4
          Width = 16
          Height = 21
          Hint = 'Centro de salida del albar'#225'n'
          ColorEdit = clMoneyGreen
          RequiredMsg = 'Este dato es de obligada inserci'#243'n.'
          OnRequiredTime = RequiredTime
          MaxLength = 1
          TabOrder = 0
          OnChange = PonNombreDetalle
          DataField = 'centro_salida_fal'
          DataSource = DSDetalleAbono
        end
        object n_albaran_fal: TBDEdit
          Left = 426
          Top = 4
          Width = 50
          Height = 21
          Hint = 'N'#250'mero del albar'#225'n'
          ColorEdit = clMoneyGreen
          RequiredMsg = 'Este dato es de obligada inserci'#243'n.'
          OnRequiredTime = RequiredTime
          InputType = itInteger
          MaxLength = 6
          TabOrder = 1
          DataField = 'n_albaran_fal'
          DataSource = DSDetalleAbono
        end
        object fecha_albaran_fal: TBDEdit
          Left = 558
          Top = 4
          Width = 64
          Height = 21
          Hint = 'Fecha del albar'#225'n.'
          ColorEdit = clMoneyGreen
          RequiredMsg = 'Este dato es de obligada inserci'#243'n.'
          OnRequiredTime = RequiredTime
          InputType = itDate
          TabOrder = 2
          DataField = 'fecha_albaran_fal'
          DataSource = DSDetalleAbono
        end
        object producto_fal: TBDEdit
          Left = 101
          Top = 28
          Width = 35
          Height = 21
          Hint = 'C'#243'digo del producto.'
          ColorEdit = clMoneyGreen
          RequiredMsg = 'Este dato es de obligada inserci'#243'n.'
          OnRequiredTime = RequiredTime
          MaxLength = 3
          TabOrder = 3
          OnChange = PonNombreDetalle
          DataField = 'producto_fal'
          DataSource = DSDetalleAbono
        end
        object categoria_fal: TBDEdit
          Left = 101
          Top = 76
          Width = 27
          Height = 21
          Hint = 'Categor'#237'a del producto'
          ColorEdit = clMoneyGreen
          RequiredMsg = 'Este dato es de obligada inserci'#243'n.'
          OnRequiredTime = RequiredTime
          MaxLength = 2
          TabOrder = 9
          OnChange = PonNombreDetalle
          DataField = 'categoria_fal'
          DataSource = DSDetalleAbono
        end
        object neto_fal: TBDEdit
          Left = 575
          Top = 57
          Width = 60
          Height = 21
          TabStop = False
          ColorEdit = clMoneyGreen
          ColorNormal = clSilver
          InputType = itReal
          MaxDecimals = 2
          ReadOnly = True
          MaxLength = 10
          TabOrder = 8
          DataField = 'neto_fal'
          DataSource = DSDetalleAbono
        end
        object envase_fal: TBDEdit
          Left = 101
          Top = 100
          Width = 33
          Height = 21
          Hint = 'C'#243'digo del envase'
          ColorEdit = clMoneyGreen
          RequiredMsg = 'Este dato es de obligada inserci'#243'n.'
          OnRequiredTime = RequiredTime
          MaxLength = 3
          TabOrder = 14
          OnChange = PonNombreDetalle
          DataField = 'envase_fal'
          DataSource = DSDetalleAbono
        end
        object unidad_fal: TComboBox
          Left = 362
          Top = 57
          Width = 81
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 5
          Text = 'IMPORTE'
          OnChange = unidad_falChange
          Items.Strings = (
            'IMPORTE'
            'UNIDADES'
            'CAJAS'
            'KILOS')
        end
        object unidades_fal: TBDEdit
          Left = 453
          Top = 57
          Width = 55
          Height = 21
          Hint = 'Unidades de producto'
          ColorEdit = clMoneyGreen
          RequiredMsg = 'Este dato es de obligada inserci'#243'n.'
          OnRequiredTime = RequiredTime
          InputType = itReal
          MaxDecimals = 2
          MaxLength = 10
          TabOrder = 6
          OnChange = unidades_falChange
          DataField = 'unidades_fal'
          DataSource = DSDetalleAbono
        end
        object precio_fal: TBDEdit
          Left = 514
          Top = 57
          Width = 55
          Height = 21
          Hint = 'Precio de la unidad'
          ColorEdit = clMoneyGreen
          RequiredMsg = 'Este dato es de obligada inserci'#243'n.'
          OnRequiredTime = RequiredTime
          InputType = itReal
          MaxDecimals = 3
          MaxLength = 11
          TabOrder = 7
          OnChange = unidades_falChange
          DataField = 'precio_fal'
          DataSource = DSDetalleAbono
        end
        object centro_origen_fal: TBDEdit
          Left = 101
          Top = 52
          Width = 16
          Height = 21
          Hint = 'Centro de salida del albar'#225'n'
          ColorEdit = clMoneyGreen
          RequiredMsg = 'Este dato es de obligada inserci'#243'n.'
          OnRequiredTime = RequiredTime
          MaxLength = 1
          TabOrder = 4
          OnChange = PonNombreDetalle
          DataField = 'centro_origen_fal'
          DataSource = DSDetalleAbono
        end
        object chkDescuento: TCheckBox
          Left = 362
          Top = 97
          Width = 121
          Height = 17
          Caption = 'Descuento'
          TabOrder = 13
          OnClick = chkDescuentoClick
        end
        object importe_fal: TBDEdit
          Left = 575
          Top = 95
          Width = 60
          Height = 21
          TabStop = False
          ColorEdit = clMoneyGreen
          ColorNormal = clSilver
          InputType = itReal
          MaxDecimals = 2
          ReadOnly = True
          MaxLength = 10
          TabOrder = 12
          DataField = 'importe_fal'
          DataSource = DSDetalleAbono
        end
        object descuento_fal: TBDEdit
          Left = 514
          Top = 95
          Width = 55
          Height = 21
          ColorEdit = clMoneyGreen
          ColorNormal = clSilver
          RequiredMsg = 'Este dato es de obligada inserci'#243'n.'
          OnRequiredTime = RequiredTime
          InputType = itReal
          MaxDecimals = 3
          ReadOnly = True
          MaxLength = 11
          TabOrder = 11
          DataField = 'descuento_fal'
          DataSource = DSDetalleAbono
        end
        object porc_descuento_fal: TBDEdit
          Left = 486
          Top = 95
          Width = 23
          Height = 21
          ColorEdit = clMoneyGreen
          ColorNormal = clSilver
          RequiredMsg = 'Este dato es de obligada inserci'#243'n.'
          OnRequiredTime = RequiredTime
          InputType = itReal
          MaxDecimals = 3
          Visible = False
          ReadOnly = True
          MaxLength = 11
          TabOrder = 10
          DataField = 'porc_descuento_fal'
          DataSource = DSDetalleAbono
        end
      end
    end
  end
  object pBotonera: TPanel
    Left = 696
    Top = 217
    Width = 75
    Height = 234
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 4
    object BtnUno: TButton
      Left = 2
      Top = 2
      Width = 70
      Height = 25
      Caption = '...'
      Enabled = False
      TabOrder = 0
      OnClick = BtnUnoClick
    end
    object btnDos: TButton
      Left = 2
      Top = 28
      Width = 70
      Height = 25
      Caption = '...'
      Enabled = False
      TabOrder = 1
      OnClick = btnDosClick
    end
    object btnTres: TButton
      Left = 2
      Top = 54
      Width = 70
      Height = 25
      Caption = '...'
      Enabled = False
      TabOrder = 2
      OnClick = btnTresClick
    end
  end
  object pBuscarRemesa: TPanel
    Left = 59
    Top = 274
    Width = 125
    Height = 41
    TabOrder = 5
    Visible = False
    object btnBuscarRemesa: TButton
      Left = 7
      Top = 8
      Width = 112
      Height = 25
      Caption = 'Facturas Remesa'
      TabOrder = 0
      OnClick = btnBuscarRemesaClick
    end
  end
  object RejillaFlotante: TBGrid
    Left = 538
    Top = 69
    Width = 169
    Height = 25
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
    Left = 714
    Top = 27
    Width = 182
    Height = 152
    Date = 36717.671456539350000000
    ShowToday = False
    TabOrder = 1
    Visible = False
    WeekNumbers = True
  end
  object DSMaestro: TDataSource
    DataSet = QFacturas
    OnStateChange = DSMaestroStateChange
    Left = 159
    Top = 9
  end
  object ACosecheros: TActionList
    Left = 7
    Top = 82
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
  object TImpuestos: TTable
    DatabaseName = 'BDProyecto'
    IndexFieldNames = 'codigo_i'
    TableName = 'frf_impuestos'
    Left = 40
    Top = 8
  end
  object QFacturas: TQuery
    AfterOpen = QFacturasAfterOpen
    BeforeClose = QFacturasBeforeClose
    BeforeInsert = QFacturasBeforeInsert
    AfterEdit = QFacturasAfterEdit
    AfterPost = QFacturasAfterPost
    AfterCancel = QFacturasAfterCancel
    AfterScroll = QFacturasAfterScroll
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_facturas'
      'ORDER BY n_factura_f')
    Left = 128
    Top = 8
  end
  object QFacturaManual: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'select texto_fm'
      'from frf_fac_manual'
      'where empresa_fm = :empresa_f'
      'and factura_fm = :n_factura_f'
      'and fecha_fm = :fecha_factura_f')
    Left = 320
    Top = 408
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa_f'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'n_factura_f'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha_factura_f'
        ParamType = ptUnknown
      end>
  end
  object DSFacturaManual: TDataSource
    AutoEdit = False
    DataSet = QFacturaManual
    Left = 344
    Top = 424
  end
  object QDetalleAbono: TQuery
    AfterEdit = QDetalleAbonoAfterEdit
    BeforePost = QDetalleAbonoBeforePost
    OnNewRecord = QDetalleAbonoNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      'select *'
      'from frf_fac_abonos_l'
      'where empresa_fal = :empresa_f'
      'and factura_fal = :n_factura_f'
      'and fecha_fal = :fecha_factura_f')
    Left = 544
    Top = 384
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa_f'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'n_factura_f'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha_factura_f'
        ParamType = ptUnknown
      end>
  end
  object DSDetalleAbono: TDataSource
    AutoEdit = False
    DataSet = QDetalleAbono
    Left = 568
    Top = 400
  end
  object DSRemesas: TDataSource
    DataSet = QRemesas
    Left = 280
    Top = 280
  end
  object QRemesas: TQuery
    OnCalcFields = QRemesasCalcFields
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'select remesa_fr, fecha_remesa_fr, importe_cobrado_fr '
      'from frf_facturas_remesa')
    Left = 248
    Top = 272
    object QRemesasremesa_fr: TIntegerField
      FieldName = 'remesa_fr'
      Origin = 'BDPROYECTO.frf_facturas_remesa.remesa_fr'
    end
    object QRemesasfecha_remesa_fr: TDateField
      FieldName = 'fecha_remesa_fr'
      Origin = 'BDPROYECTO.frf_facturas_remesa.fecha_remesa_fr'
    end
    object QRemesasimporte_cobrado_fr: TFloatField
      FieldName = 'importe_cobrado_fr'
      Origin = 'BDPROYECTO.frf_facturas_remesa.importe_cobrado_fr'
    end
    object QRemesasmoneda_fr: TStringField
      FieldKind = fkCalculated
      FieldName = 'moneda_fr'
      Size = 3
      Calculated = True
    end
  end
  object QImporteCobrado: TQuery
    OnCalcFields = QRemesasCalcFields
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'select remesa_fr, fecha_remesa_fr, importe_cobrado_fr '
      'from frf_facturas_remesa')
    Left = 248
    Top = 312
  end
  object DSImporteCobrado: TDataSource
    DataSet = QImporteCobrado
    Left = 288
    Top = 312
  end
  object qryGiros: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'select remesa_fr, fecha_remesa_fr, importe_cobrado_fr '
      'from frf_facturas_remesa')
    Left = 352
    Top = 320
  end
  object dsGiros: TDataSource
    DataSet = qryGiros
    Left = 384
    Top = 320
  end
end
