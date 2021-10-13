object FLVentasFobCliente: TFLVentasFobCliente
  Left = 351
  Top = 217
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = '    LISTADO FOB FACTURACI'#211'N CLIENTES'
  ClientHeight = 379
  ClientWidth = 495
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
    495
    379)
  PixelsPerInch = 96
  TextHeight = 13
  object Lcategoria: TLabel
    Left = 46
    Top = 186
    Width = 56
    Height = 13
    Caption = ' Categor'#237'a: '
  end
  object Label1: TLabel
    Left = 46
    Top = 20
    Width = 75
    Height = 19
    AutoSize = False
    Caption = ' Empresa'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label2: TLabel
    Left = 46
    Top = 91
    Width = 75
    Height = 19
    AutoSize = False
    Caption = ' Producto'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label3: TLabel
    Left = 46
    Top = 114
    Width = 75
    Height = 19
    AutoSize = False
    Caption = ' Centro Origen'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label4: TLabel
    Left = 46
    Top = 138
    Width = 77
    Height = 19
    AutoSize = False
    Caption = ' Centro Salida'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Desde: TLabel
    Left = 46
    Top = 43
    Width = 75
    Height = 19
    AutoSize = False
    Caption = ' Fecha Salida'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label14: TLabel
    Left = 254
    Top = 43
    Width = 55
    Height = 19
    AutoSize = False
    Caption = ' Hasta'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label5: TLabel
    Left = 46
    Top = 161
    Width = 51
    Height = 19
    AutoSize = False
    Caption = ' Cliente'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label7: TLabel
    Left = 166
    Top = 186
    Width = 239
    Height = 13
    Caption = '(Vacio todas las categorias comerciales 1'#170', 2'#170' y 3'#170')'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblFechaFactura: TLabel
    Left = 46
    Top = 67
    Width = 75
    Height = 19
    AutoSize = False
    Caption = ' Fecha Factura'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblFechaFacturaHasta: TLabel
    Left = 254
    Top = 67
    Width = 55
    Height = 19
    AutoSize = False
    Caption = ' Hasta'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object btnCancel: TBitBtn
    Left = 397
    Top = 341
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 18
    TabStop = False
    OnClick = btnCancelClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object btnOk: TBitBtn
    Left = 318
    Top = 341
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Imprimir'
    TabOrder = 17
    TabStop = False
    OnClick = btnOkClick
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
  object STEmpresa: TStaticText
    Left = 184
    Top = 21
    Width = 232
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 1
  end
  object STProducto: TStaticText
    Left = 184
    Top = 92
    Width = 232
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 7
  end
  object empresa: TnbDBSQLCombo
    Left = 128
    Top = 19
    Width = 55
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
    NumChars = 3
  end
  object producto: TnbDBSQLCombo
    Left = 128
    Top = 90
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = productoChange
    TabOrder = 6
    DatabaseName = 'BDProyecto'
    OnGetSQL = productoGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object edtCentroOrigen: TnbDBSQLCombo
    Left = 128
    Top = 113
    Width = 41
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = edtCentroOrigenChange
    TabOrder = 8
    DatabaseName = 'BDProyecto'
    OnGetSQL = edtCentroOrigenGetSQL
    NumChars = 1
  end
  object edtCentroSalida: TnbDBSQLCombo
    Left = 128
    Top = 137
    Width = 41
    Height = 21
    About = 'NB 0.1/20020725'
    Alignment = taDownRight
    CharCase = ecUpperCase
    OnChange = edtCentroSalidaChange
    TabOrder = 10
    DatabaseName = 'BDProyecto'
    OnGetSQL = edtCentroOrigenGetSQL
    NumChars = 1
  end
  object edtCliente: TnbDBSQLCombo
    Left = 128
    Top = 160
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = edtClienteChange
    TabOrder = 13
    DatabaseName = 'BDProyecto'
    OnGetSQL = edtClienteGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object fechaDesde: TnbDBCalendarCombo
    Left = 128
    Top = 42
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '26/04/2004'
    TabOrder = 2
  end
  object fechaHasta: TnbDBCalendarCombo
    Left = 312
    Top = 42
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    Alignment = taDownRight
    CharCase = ecUpperCase
    Text = '26/04/2004'
    TabOrder = 3
  end
  object categoria: TnbDBAlfa
    Left = 128
    Top = 182
    Width = 27
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 15
    NumChars = 2
  end
  object subPanel1: TPanel
    Left = 0
    Top = 205
    Width = 493
    Height = 118
    BevelOuter = bvNone
    TabOrder = 16
    object Bevel1: TBevel
      Left = 40
      Top = 17
      Width = 422
      Height = 91
    end
    object Label13: TLabel
      Left = 45
      Top = 11
      Width = 148
      Height = 13
      Caption = ' Costes/Gastos que se aplican '
    end
    object lbl1: TLabel
      Left = 95
      Top = 81
      Width = 126
      Height = 13
      Caption = 'Solo albaranes facturados.'
    end
    object chkEnvase: TCheckBox
      Left = 77
      Top = 64
      Width = 260
      Height = 17
      Caption = 'Costes de envasado y secciones almac'#225'n'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object cbxGasto: TCheckBox
      Left = 77
      Top = 49
      Width = 162
      Height = 17
      Caption = 'Gastos asociados al albar'#225'n'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object chkDescuento: TCheckBox
      Left = 77
      Top = 34
      Width = 379
      Height = 17
      Caption = 
        'Descuentos y comisiones albar'#225'n (Se aplica en columna de importe' +
        's bruto)'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
  end
  object stCliente: TStaticText
    Left = 184
    Top = 162
    Width = 232
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 14
  end
  object stOrigen: TStaticText
    Left = 184
    Top = 115
    Width = 232
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 9
  end
  object stSalida: TStaticText
    Left = 184
    Top = 139
    Width = 232
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 11
  end
  object cbbCliente: TComboBox
    Left = 90
    Top = 160
    Width = 37
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 12
    Text = '='
    Items.Strings = (
      '='
      '<>')
  end
  object FechaFacturaDesde: TnbDBCalendarCombo
    Left = 128
    Top = 66
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '26/04/2004'
    TabOrder = 4
  end
  object FechaFacturaHasta: TnbDBCalendarCombo
    Left = 312
    Top = 66
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    Alignment = taDownRight
    CharCase = ecUpperCase
    Text = '26/04/2004'
    TabOrder = 5
  end
end
