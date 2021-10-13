object FLCosteFrutaProveedor: TFLCosteFrutaProveedor
  Left = 765
  Top = 243
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    RESUMEN COSTE ENTREGAS POR PROVEEDOR'
  ClientHeight = 437
  ClientWidth = 456
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  DesignSize = (
    456
    437)
  PixelsPerInch = 96
  TextHeight = 13
  object lblEmpresa: TnbLabel
    Left = 32
    Top = 32
    Width = 115
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object lblCentro: TnbLabel
    Left = 32
    Top = 104
    Width = 115
    Height = 21
    Caption = 'Centro Llegada'
    About = 'NB 0.1/20020725'
  end
  object stEmpresa: TLabel
    Left = 211
    Top = 36
    Width = 133
    Height = 13
    Caption = '(Falta c'#243'digo de la empresa)'
  end
  object stCentro: TLabel
    Left = 211
    Top = 108
    Width = 126
    Height = 13
    Caption = '(Vacio =Todos los centros)'
  end
  object lblMsg1: TLabel
    Left = 32
    Top = 232
    Width = 408
    Height = 13
    Caption = 'POR FAVOR ESPERE MIENTRAS SE EXTRAEN LOS DATOS PEDIDOS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object lblProducto: TnbLabel
    Left = 32
    Top = 128
    Width = 115
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object stProducto: TLabel
    Left = 211
    Top = 132
    Width = 138
    Height = 13
    Caption = '(Vacio =Todos los productos)'
  end
  object lblFechaDesde: TnbLabel
    Left = 32
    Top = 80
    Width = 115
    Height = 21
    Caption = 'Fecha Llegada Desde'
    About = 'NB 0.1/20020725'
  end
  object lblFechaHasta: TnbLabel
    Left = 240
    Top = 80
    Width = 42
    Height = 21
    Caption = 'Hasta'
    About = 'NB 0.1/20020725'
  end
  object lblProveedor: TnbLabel
    Left = 32
    Top = 56
    Width = 115
    Height = 21
    Caption = 'Proveedor'
    About = 'NB 0.1/20020725'
  end
  object stProveedor: TLabel
    Left = 211
    Top = 60
    Width = 130
    Height = 13
    Caption = '(Falta c'#243'digo de proveedor)'
  end
  object lblEntrega: TnbLabel
    Left = 32
    Top = 152
    Width = 115
    Height = 21
    Caption = 'Entrega'
    About = 'NB 0.1/20020725'
  end
  object lblNombre1: TLabel
    Left = 247
    Top = 156
    Width = 132
    Height = 13
    Caption = '(Vacio =Todas las entregas)'
  end
  object lblMsg2: TLabel
    Left = 32
    Top = 244
    Width = 200
    Height = 13
    Caption = 'PROCESANDO ENTRADA X DE Y'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object lbl1: TLabel
    Left = 26
    Top = 285
    Width = 404
    Height = 13
    Caption = 
      'Siempre que las lineas de las entregas tengan precio no se tiene' +
      ' en cuenta los gastos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 33
    Top = 305
    Width = 109
    Height = 13
    Caption = '001 Factura Proveedor'
  end
  object lbl3: TLabel
    Left = 165
    Top = 305
    Width = 109
    Height = 13
    Caption = '005 Abono Devoluci'#243'n'
  end
  object lbl4: TLabel
    Left = 297
    Top = 305
    Width = 39
    Height = 13
    Caption = '021 Tria'
  end
  object lbl5: TLabel
    Left = 33
    Top = 319
    Width = 73
    Height = 13
    Caption = '022 Forfait Logi'
  end
  object lbl6: TLabel
    Left = 165
    Top = 319
    Width = 75
    Height = 13
    Caption = '110 Coste Fruta'
  end
  object lbl7: TLabel
    Left = 26
    Top = 335
    Width = 334
    Height = 13
    Caption = 
      'El precio por kilo del detalle de la compra debe incluir estos c' +
      'onceptos.'
  end
  object bvl1: TBevel
    Left = 18
    Top = 274
    Width = 421
    Height = 89
  end
  object eFechaHasta: TnbDBCalendarCombo
    Left = 284
    Top = 80
    Width = 85
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '04/09/2008'
    TabOrder = 4
  end
  object eFechaDesde: TnbDBCalendarCombo
    Left = 155
    Top = 80
    Width = 85
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '04/09/2008'
    TabOrder = 3
  end
  object btnCerrar: TBitBtn
    Left = 343
    Top = 388
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cerrar (Esc)'
    TabOrder = 9
    TabStop = False
    OnClick = btnCerrarClick
    Kind = bkCancel
  end
  object btnImprimir: TBitBtn
    Left = 246
    Top = 388
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Imprimir (F1)'
    ModalResult = 1
    TabOrder = 8
    TabStop = False
    OnClick = btnImprimirClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object eEmpresa: TnbDBSQLCombo
    Left = 155
    Top = 32
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eEmpresaChange
    TabOrder = 1
    SQL.Strings = (
      'select empresa_e, nombre_e '
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    FillAuto = True
    OnlyNumbers = False
    NumChars = 3
  end
  object eCentro: TnbDBSQLCombo
    Left = 155
    Top = 104
    Width = 41
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eCentroChange
    TabOrder = 5
    DatabaseName = 'BDProyecto'
    OnGetSQL = eCentroGetSQL
    NumChars = 1
  end
  object eProducto: TnbDBSQLCombo
    Left = 155
    Top = 128
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eProductoChange
    TabOrder = 6
    DatabaseName = 'BDProyecto'
    OnGetSQL = eProductoGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object eProveedor: TnbDBSQLCombo
    Left = 155
    Top = 56
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eProveedorChange
    TabOrder = 2
    DatabaseName = 'BDProyecto'
    OnGetSQL = eProveedorGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object eEntrega: TnbDBAlfa
    Left = 155
    Top = 152
    Width = 85
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 7
    NumChars = 12
  end
  object cbbDetalle: TComboBox
    Left = 155
    Top = 9
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    TabStop = False
    Text = 'Ver Detalle'
    Items.Strings = (
      'Ver Detalle'
      'Ocultar Detalle')
  end
  object rbVariedad: TRadioButton
    Left = 177
    Top = 198
    Width = 130
    Height = 17
    Caption = 'Agrupar por variedad.'
    TabOrder = 10
    TabStop = True
  end
  object rbCalibre: TRadioButton
    Left = 315
    Top = 198
    Width = 130
    Height = 17
    Caption = 'Variedad/Calibre.'
    TabOrder = 11
    TabStop = True
  end
  object rbSinAgrupar: TRadioButton
    Left = 155
    Top = 179
    Width = 101
    Height = 17
    Caption = 'Sin Agrupar'
    Checked = True
    TabOrder = 12
    TabStop = True
  end
end
