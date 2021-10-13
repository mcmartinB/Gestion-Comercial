object FLFacturasGastosSalidas: TFLFacturasGastosSalidas
  Left = 479
  Top = 265
  ActiveControl = eEmpresa
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = ' LISTADO FACTURAS GASTOS'
  ClientHeight = 382
  ClientWidth = 499
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 499
    Height = 382
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 0
    ExplicitHeight = 357
    object SpeedButton2: TSpeedButton
      Left = 397
      Top = 333
      Width = 89
      Height = 25
      Action = BCancelar
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FFBFFF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00
        FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
        FFBF0000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
        0000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
        FFBF00000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000000000000000000000000000FFFFFF00FF00FFBFFF00
        FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FFBFFF00
        FF0000000000000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
    end
    object Label3: TLabel
      Left = 25
      Top = 38
      Width = 122
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BCBDesde: TBCalendarButton
      Left = 228
      Top = 60
      Width = 17
      Height = 21
      Action = ADesplegarRejilla
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      NumGlyphs = 2
      Control = EDesde
      Calendar = CalendarioFlotante
      CalendarAlignment = taCenterRight
      CalendarWidth = 177
      CalendarHeigth = 140
    end
    object Label2: TLabel
      Left = 246
      Top = 61
      Width = 40
      Height = 19
      AutoSize = False
      Caption = ' Hasta'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BCBHasta: TBCalendarButton
      Left = 357
      Top = 60
      Width = 17
      Height = 21
      Action = ADesplegarRejilla
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      NumGlyphs = 2
      Control = EHasta
      Calendar = CalendarioFlotante
      CalendarAlignment = taCenterRight
      CalendarWidth = 177
      CalendarHeigth = 140
    end
    object Label4: TLabel
      Left = 25
      Top = 85
      Width = 122
      Height = 19
      AutoSize = False
      Caption = ' Cliente'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre1: TLabel
      Left = 25
      Top = 131
      Width = 122
      Height = 19
      AutoSize = False
      Caption = ' Producto Venta'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblFacturas: TLabel
      Left = 25
      Top = 154
      Width = 122
      Height = 19
      AutoSize = False
      Caption = ' Tipo Factura'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl1: TLabel
      Left = 25
      Top = 177
      Width = 122
      Height = 19
      AutoSize = False
      Caption = ' Agrupacion Factura'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl2: TLabel
      Left = 25
      Top = 201
      Width = 122
      Height = 19
      AutoSize = False
      Caption = ' Con Factura Grabada'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl3: TLabel
      Left = 25
      Top = 61
      Width = 122
      Height = 19
      AutoSize = False
      Caption = ' Fecha Venta'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl4: TLabel
      Left = 25
      Top = 272
      Width = 122
      Height = 19
      AutoSize = False
      Caption = ' Tipo Factura'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblFecha: TLabel
      Left = 155
      Top = 222
      Width = 127
      Height = 19
      AutoSize = False
      Caption = ' Fecha Factura'
      Color = cl3DLight
      Enabled = False
      ParentColor = False
      Layout = tlCenter
    end
    object btnFecha: TBCalendarButton
      Left = 359
      Top = 221
      Width = 17
      Height = 21
      Action = ADesplegarRejilla
      Enabled = False
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      NumGlyphs = 2
      Control = edtFecha
      Calendar = CalendarioFlotante
      CalendarAlignment = taCenterRight
      CalendarWidth = 177
      CalendarHeigth = 140
    end
    object SpeedButton1: TSpeedButton
      Left = 307
      Top = 333
      Width = 89
      Height = 25
      Action = BAceptar
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000FF0000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000000FF000000FFBF0000FF00000000BFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000000FF000000FFBF0000FF00000000BFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000000FF000000FF000000FFBF0000FF000000FFBF00000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000000FF000000FFBF0000FF000000FFBF0000FF000000FFBF00000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007F7F
        7F000000FF3F0000FFBF00000000FF00FF000000FF000000FFBF0000FF000000
        00BFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007F7F7F000000
        FF3F00000000FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000
        00BFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000
        FFBF00000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000
        FFBF00000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        FF000000FF00000000BFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF007F7F7F000000FF3F00000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF007F7F7F000000FF3F000000BFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000FF000000FF00000000BFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
    end
    object Label1: TLabel
      Left = 25
      Top = 249
      Width = 122
      Height = 19
      AutoSize = False
      Caption = ' Gasto Facturable'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label38: TLabel
      Left = 25
      Top = 108
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Transportista'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object eEmpresa: TBEdit
      Left = 155
      Top = 37
      Width = 34
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      MaxLength = 3
      TabOrder = 0
      OnChange = eEmpresaChange
    end
    object STEmpresa: TStaticText
      Left = 192
      Top = 39
      Width = 182
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object EDesde: TBEdit
      Left = 155
      Top = 60
      Width = 70
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itDate
      TabOrder = 2
    end
    object EHasta: TBEdit
      Left = 287
      Top = 60
      Width = 70
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itDate
      TabOrder = 3
      OnExit = EHastaExit
    end
    object eCliente: TBEdit
      Left = 155
      Top = 84
      Width = 34
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 3
      TabOrder = 4
      OnChange = eClienteChange
    end
    object STCliente: TStaticText
      Left = 192
      Top = 86
      Width = 182
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 5
    end
    object edtProducto: TBEdit
      Left = 155
      Top = 130
      Width = 34
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 3
      TabOrder = 8
      OnChange = edtProductoChange
    end
    object txtProducto: TStaticText
      Left = 192
      Top = 132
      Width = 182
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 9
    end
    object chkFactura: TCheckBox
      Left = 155
      Top = 292
      Width = 113
      Height = 17
      Caption = 'Agrupar Facturas'
      TabOrder = 17
    end
    object edtTipo: TBEdit
      Left = 155
      Top = 153
      Width = 34
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      MaxLength = 3
      TabOrder = 10
      OnChange = edtTipoChange
    end
    object txtTipo: TStaticText
      Left = 192
      Top = 155
      Width = 182
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 11
    end
    object cbbAgrupacion: TComboBox
      Left = 155
      Top = 176
      Width = 221
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 12
    end
    object cbbFactura: TComboBox
      Left = 155
      Top = 200
      Width = 221
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 13
      Text = 'INDIFERENTE'
      OnChange = cbbFacturaChange
      Items.Strings = (
        'INDIFERENTE'
        'SIN FACTURA'
        'CON FACTURA'
        'CON FACTURA SIN FECHA (PREVISION)'
        'CON FACTURA CON FECHA (FINAL)'
        'SIN FACTURA O FECHA SUPERIOR A')
    end
    object cbbTipoFactura: TComboBox
      Left = 155
      Top = 270
      Width = 221
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 16
      Text = 'Todas las facturas'
      Items.Strings = (
        'Todas las facturas'
        'Cargos (Facturas con importes positivos)'
        'Abonos (Facturas con importes negativos)')
    end
    object edtFecha: TBEdit
      Left = 288
      Top = 221
      Width = 70
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itDate
      Enabled = False
      TabOrder = 14
    end
    object chKNoTransitos: TCheckBox
      Left = 155
      Top = 309
      Width = 136
      Height = 17
      Caption = 'Ignorar Gastos Tr'#225'nsitos'
      Checked = True
      State = cbChecked
      TabOrder = 18
    end
    object cbxFactutable: TComboBox
      Left = 155
      Top = 247
      Width = 221
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 15
      Text = 'Solo gastos no facturables'
      Items.Strings = (
        'Todos las gastos'
        'Solo gastos no facturables'
        'Solo gastos facturables')
    end
    object eTransporte: TBDEdit
      Left = 155
      Top = 107
      Width = 34
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itInteger
      MaxLength = 4
      TabOrder = 6
      OnChange = eTransporteChange
      DataField = 'transporte_sc'
    end
    object STTransporte: TStaticText
      Left = 192
      Top = 109
      Width = 182
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 7
    end
    object chkNoDevolucion: TCheckBox
      Left = 155
      Top = 327
      Width = 136
      Height = 17
      Caption = 'Ignorar Alb. Devolucion'
      Checked = True
      State = cbChecked
      TabOrder = 19
    end
  end
  object CalendarioFlotante: TBCalendario
    Left = 382
    Top = 59
    Width = 177
    Height = 140
    Date = 36717.415358761570000000
    ShowToday = False
    TabOrder = 1
    Visible = False
    WeekNumbers = True
  end
  object ListaAcciones: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 8
    Top = 188
    object BAceptar: TAction
      Caption = 'Aceptar'
      ShortCut = 112
      OnExecute = BBAceptarClick
    end
    object BCancelar: TAction
      Caption = 'Cancelar'
      ShortCut = 27
      OnExecute = BBCancelarClick
    end
    object ADesplegarRejilla: TAction
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ADesplegarRejillaExecute
    end
  end
  object QLCompGastosEntregas: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT DISTINCT '#39'X'#39' tipo, referencia_tl codigo, fecha_tl fecha'
      'FROM  frf_transitos_l'
      'WHERE producto_tl = '#39'E'#39
      'AND   empresa_tl = '#39'050'#39
      'AND   centro_tl = '#39'6'#39
      'AND   fecha_tl BETWEEN :desde AND :hasta'
      'AND   NOT EXISTS ('
      '      SELECT * FROM frf_gastos_trans'
      '      WHERE empresa_gt = '#39'050'#39
      '      AND   centro_gt = '#39'6'#39
      '      AND   referencia_gt = referencia_tl '
      '      AND   fecha_gt = fecha_tl '
      '      AND   tipo_gt IN (:tipoA, :tipoB)) '
      'ORDER BY 1,2'
      '')
    Left = 8
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'desde'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'hasta'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'tipoA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'tipoB'
        ParamType = ptUnknown
      end>
  end
  object aqryX3Factura: TADOQuery
    Connection = DMBaseDatos.conX3
    Parameters = <
      item
        Name = 'factura'
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = 'transporte'
        DataType = ftString
        Size = 6
        Value = Null
      end
      item
        Name = 'fecha'
        DataType = ftDateTime
        Value = Null
      end>
    Left = 432
    Top = 8
  end
  object kbmTablaTemporal: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.51'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 400
    Top = 8
    object kbmTablaTemporalempresa: TStringField
      FieldName = 'empresa'
      Size = 3
    end
    object kbmTablaTemporalagrupacion: TStringField
      FieldName = 'agrupacion'
      Size = 10
    end
    object kbmTablaTemporaltipo: TStringField
      FieldName = 'tipo'
      Size = 3
    end
    object kbmTablaTemporalcliente: TStringField
      FieldName = 'cliente'
      Size = 3
    end
    object kbmTablaTemporalfecha: TDateField
      FieldName = 'fecha'
    end
    object kbmTablaTemporalfactura: TStringField
      FieldName = 'factura'
    end
    object kbmTablaTemporaltransporte_g: TSmallintField
      FieldName = 'transporte_g'
    end
    object kbmTablaTemporalventa: TStringField
      FieldName = 'venta'
      Size = 30
    end
    object kbmTablaTemporalkilos: TFloatField
      FieldName = 'kilos'
    end
    object kbmTablaTemporalimporte: TFloatField
      FieldName = 'importe'
    end
    object kbmTablaTemporaleuro_kilo: TFloatField
      FieldKind = fkCalculated
      FieldName = 'euro_kilo'
      Calculated = True
    end
    object kbmTablaTemporalasiento: TStringField
      FieldKind = fkCalculated
      FieldName = 'asiento'
      Size = 15
      Calculated = True
    end
    object kbmTablaTemporalfecha_asiento: TDateField
      FieldKind = fkCalculated
      FieldName = 'fecha_asiento'
      Calculated = True
    end
    object kbmTablaTemporalbase_imponible: TFloatField
      FieldKind = fkCalculated
      FieldName = 'base_imponible'
      Calculated = True
    end
  end
end
