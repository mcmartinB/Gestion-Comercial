object FLCosteFrutaProveedor: TFLCosteFrutaProveedor
  Left = 593
  Top = 295
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    RESUMEN COSTE ENTREGAS POR PROVEEDOR'
  ClientHeight = 355
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
    355)
  PixelsPerInch = 96
  TextHeight = 13
  object lblEmpresa: TnbLabel
    Left = 32
    Top = 51
    Width = 115
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object lblCentro: TnbLabel
    Left = 32
    Top = 123
    Width = 115
    Height = 21
    Caption = 'Centro Llegada'
    About = 'NB 0.1/20020725'
  end
  object stEmpresa: TLabel
    Left = 211
    Top = 55
    Width = 133
    Height = 13
    Caption = '(Falta c'#243'digo de la empresa)'
  end
  object stCentro: TLabel
    Left = 211
    Top = 127
    Width = 126
    Height = 13
    Caption = '(Vacio =Todos los centros)'
  end
  object lblMsg1: TLabel
    Left = 32
    Top = 264
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
    Top = 147
    Width = 115
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object stProducto: TLabel
    Left = 211
    Top = 151
    Width = 138
    Height = 13
    Caption = '(Vacio =Todos los productos)'
  end
  object lblFechaDesde: TnbLabel
    Left = 32
    Top = 99
    Width = 115
    Height = 21
    Caption = 'Fecha Llegada Desde'
    About = 'NB 0.1/20020725'
  end
  object lblFechaHasta: TnbLabel
    Left = 240
    Top = 99
    Width = 42
    Height = 21
    Caption = 'Hasta'
    About = 'NB 0.1/20020725'
  end
  object lblProveedor: TnbLabel
    Left = 32
    Top = 75
    Width = 115
    Height = 21
    Caption = 'Proveedor'
    About = 'NB 0.1/20020725'
  end
  object stProveedor: TLabel
    Left = 211
    Top = 79
    Width = 130
    Height = 13
    Caption = '(Falta c'#243'digo de proveedor)'
  end
  object lblEntrega: TnbLabel
    Left = 32
    Top = 171
    Width = 115
    Height = 21
    Caption = 'Entrega'
    About = 'NB 0.1/20020725'
  end
  object lblNombre1: TLabel
    Left = 247
    Top = 175
    Width = 132
    Height = 13
    Caption = '(Vacio =Todas las entregas)'
  end
  object lblMsg2: TLabel
    Left = 32
    Top = 276
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
  object nbLabel1: TnbLabel
    Left = 32
    Top = 198
    Width = 115
    Height = 21
    Caption = 'Tipo Gasto/Factura'
    About = 'NB 0.1/20020725'
  end
  object lblTipos: TLabel
    Left = 247
    Top = 202
    Width = 113
    Height = 13
    Caption = '(Vacio =Todos los tipos)'
  end
  object eFechaHasta: TnbDBCalendarCombo
    Left = 284
    Top = 99
    Width = 85
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '04/09/2008'
    TabOrder = 4
  end
  object eFechaDesde: TnbDBCalendarCombo
    Left = 155
    Top = 99
    Width = 85
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '04/09/2008'
    TabOrder = 3
  end
  object btnCerrar: TBitBtn
    Left = 343
    Top = 306
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cerrar (Esc)'
    TabOrder = 11
    TabStop = False
    OnClick = btnCerrarClick
    Kind = bkCancel
  end
  object btnImprimir: TBitBtn
    Left = 246
    Top = 306
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Imprimir (F1)'
    ModalResult = 1
    TabOrder = 10
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
    Top = 51
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
    NumChars = 3
  end
  object eCentro: TnbDBSQLCombo
    Left = 155
    Top = 123
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
  object cbxVariedad: TCheckBox
    Left = 32
    Top = 227
    Width = 145
    Height = 17
    Caption = 'Agrupar por variedad.'
    TabOrder = 8
    OnClick = cbxVariedadClick
  end
  object cbxCalibre: TCheckBox
    Left = 50
    Top = 243
    Width = 145
    Height = 17
    Caption = 'Agrupar por calibre.'
    Enabled = False
    TabOrder = 9
  end
  object eProducto: TnbDBSQLCombo
    Left = 155
    Top = 147
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
    Top = 75
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
    Top = 171
    Width = 85
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 7
    NumChars = 12
  end
  object cbbDetalle: TComboBox
    Left = 155
    Top = 28
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
  object eTipoGasto: TnbDBSQLCombo
    Left = 155
    Top = 198
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eTipoGastoChange
    TabOrder = 12
    SQL.Strings = (
      'select tipo_tg, descripcion_tg '
      'from frf_tipo_gastos'
      'where gasto_transito_tg = 2'
      'order by tipo_tg')
    DatabaseName = 'BDProyecto'
    FillAuto = True
    NumChars = 3
  end
  object chkImporteFruta: TCheckBox
    Left = 247
    Top = 219
    Width = 206
    Height = 17
    Caption = 'A'#241'adir al gasto el importe de la fruta'
    Enabled = False
    TabOrder = 13
    OnClick = cbxVariedadClick
  end
end
