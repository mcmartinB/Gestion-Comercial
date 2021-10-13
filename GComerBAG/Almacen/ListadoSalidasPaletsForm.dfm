object FListadoSalidasPaletsForm: TFListadoSalidasPaletsForm
  Left = 233
  Top = 232
  ActiveControl = fechaDesde
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    Listado Salidas por Palet.'
  ClientHeight = 268
  ClientWidth = 418
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
  OnKeyUp = FormKeyUp
  DesignSize = (
    418
    268)
  PixelsPerInch = 96
  TextHeight = 13
  object lblEmpresa: TnbLabel
    Left = 32
    Top = 32
    Width = 100
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object nbLabel2: TnbLabel
    Left = 32
    Top = 81
    Width = 100
    Height = 21
    Caption = 'Centro'
    About = 'NB 0.1/20020725'
  end
  object nbLabel1: TnbLabel
    Left = 32
    Top = 56
    Width = 100
    Height = 21
    Caption = 'Fecha Desde'
    About = 'NB 0.1/20020725'
  end
  object nbLabel4: TnbLabel
    Left = 232
    Top = 56
    Width = 42
    Height = 21
    Caption = 'hasta'
    About = 'NB 0.1/20020725'
  end
  object nbLabel3: TnbLabel
    Left = 32
    Top = 105
    Width = 100
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object nbLabel6: TnbLabel
    Left = 32
    Top = 157
    Width = 100
    Height = 21
    Caption = 'Cliente'
    About = 'NB 0.1/20020725'
  end
  object stCliente: TLabel
    Left = 192
    Top = 159
    Width = 149
    Height = 13
    Caption = '(Opcional, vacio muestra todos)'
  end
  object stProducto: TLabel
    Left = 192
    Top = 109
    Width = 149
    Height = 13
    Caption = '(Opcional, vacio muestra todos)'
  end
  object nbLabel7: TnbLabel
    Left = 32
    Top = 131
    Width = 100
    Height = 21
    Caption = 'Tipo Palet'
    About = 'NB 0.1/20020725'
  end
  object stTipoPalet: TLabel
    Left = 192
    Top = 135
    Width = 149
    Height = 13
    Caption = '(Opcional, vacio muestra todos)'
  end
  object stEmpresa: TLabel
    Left = 192
    Top = 36
    Width = 133
    Height = 13
    Caption = '(Falta c'#243'digo de la empresa)'
  end
  object stCentro: TLabel
    Left = 192
    Top = 85
    Width = 149
    Height = 13
    Caption = '(Opcional, vacio muestra todos)'
  end
  object lblTransportista: TnbLabel
    Left = 32
    Top = 183
    Width = 100
    Height = 21
    Caption = 'Transporte'
    About = 'NB 0.1/20020725'
  end
  object txtTransportista: TLabel
    Left = 193
    Top = 187
    Width = 149
    Height = 13
    Caption = '(Opcional, vacio muestra todos)'
  end
  object fechaDesde: TnbDBCalendarCombo
    Left = 136
    Top = 56
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '26/04/2004'
    TabOrder = 1
  end
  object fechaHasta: TnbDBCalendarCombo
    Left = 278
    Top = 56
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '26/04/2004'
    TabOrder = 2
  end
  object btnCerrar: TBitBtn
    Left = 302
    Top = 227
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
    Left = 205
    Top = 227
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
  object empresa: TnbDBSQLCombo
    Left = 136
    Top = 32
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = empresaChange
    TabOrder = 0
    SQL.Strings = (
      'select empresa_e, nombre_e '
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    FillAuto = True
    OnlyNumbers = False
    NumChars = 3
  end
  object centro: TnbDBSQLCombo
    Left = 136
    Top = 81
    Width = 41
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = centroChange
    TabOrder = 4
    DatabaseName = 'BDProyecto'
    OnGetSQL = centroGetSQL
    NumChars = 1
  end
  object producto: TnbDBSQLCombo
    Left = 136
    Top = 105
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = productoChange
    TabOrder = 5
    DatabaseName = 'BDProyecto'
    OnGetSQL = productoGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object cliente: TnbDBSQLCombo
    Left = 136
    Top = 157
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    Alignment = taUpLeft
    CharCase = ecUpperCase
    OnChange = clienteChange
    TabOrder = 7
    DatabaseName = 'BDProyecto'
    OnGetSQL = clienteGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object tipoPalet: TnbDBSQLCombo
    Left = 136
    Top = 131
    Width = 46
    Height = 21
    About = 'NB 0.1/20020725'
    Alignment = taUpLeft
    CharCase = ecUpperCase
    OnChange = tipoPaletChange
    TabOrder = 6
    DatabaseName = 'BDProyecto'
    OnGetSQL = tipoPaletGetSQL
    FillAuto = True
    NumChars = 2
  end
  object RejillaFlotante: TBGrid
    Left = 369
    Top = 63
    Width = 137
    Height = 135
    Color = clInfoBk
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object edtTransportista: TnbDBSQLCombo
    Left = 136
    Top = 183
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    Alignment = taUpLeft
    CharCase = ecUpperCase
    OnChange = edtTransportistaChange
    TabOrder = 10
    DatabaseName = 'BDProyecto'
    OnGetSQL = edtTransportistaGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
end
