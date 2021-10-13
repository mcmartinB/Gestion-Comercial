object FDatosExcelFOB: TFDatosExcelFOB
  Left = 662
  Top = 239
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = '    LISTADO FOB - SALIDAS'
  ClientHeight = 640
  ClientWidth = 711
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
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  DesignSize = (
    711
    640)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 31
    Top = 44
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Empresa'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label2: TLabel
    Left = 31
    Top = 93
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Producto'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label3: TLabel
    Left = 31
    Top = 116
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Centro Origen'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label4: TLabel
    Left = 31
    Top = 140
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Centro Salida'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label14: TLabel
    Left = 229
    Top = 67
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Hasta'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label5: TLabel
    Left = 287
    Top = 185
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Cliente'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label7: TLabel
    Left = 156
    Top = 259
    Width = 124
    Height = 13
    Caption = 'Vacio todas las categorias'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 31
    Top = 185
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Clientes'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label15: TLabel
    Left = 31
    Top = 162
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Art'#237'culo'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblDesCalibre: TLabel
    Left = 481
    Top = 260
    Width = 111
    Height = 13
    Caption = 'Vacio todos las calibres'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 31
    Top = 257
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Categoria'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lbl3: TLabel
    Left = 287
    Top = 257
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Calibre'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lbl4: TLabel
    Left = 31
    Top = 67
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Fecha Desde'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblComercial: TLabel
    Left = 31
    Top = 231
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Comercial'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblTipoCliente: TLabel
    Left = 31
    Top = 208
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Tipo Cliente'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Calibre: TBEdit
    Left = 380
    Top = 256
    Width = 90
    Height = 21
    CharCase = ecNormal
    TabOrder = 31
  end
  object STEmpresa: TStaticText
    Left = 180
    Top = 45
    Width = 232
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 4
  end
  object STProducto: TStaticText
    Left = 180
    Top = 94
    Width = 232
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 10
  end
  object cbxNacionalidad: TComboBox
    Left = 124
    Top = 184
    Width = 115
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 20
    Text = 'Todos'
    OnChange = cbxNacionalidadChange
    OnKeyDown = cbxNacionalidadKeyDown
    Items.Strings = (
      'Todos'
      'Nacionales'
      'Extranjeros'
      'De un pais')
  end
  object empresa: TnbDBSQLCombo
    Left = 124
    Top = 43
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = empresaChange
    TabOrder = 2
    SQL.Strings = (
      'select empresa_e, nombre_e '
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    FillAuto = True
    OnlyNumbers = False
    NumChars = 3
  end
  object producto: TnbDBSQLCombo
    Left = 124
    Top = 92
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = productoChange
    TabOrder = 8
    DatabaseName = 'BDProyecto'
    OnGetSQL = productoGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object edtCentroOrigen: TnbDBSQLCombo
    Left = 124
    Top = 115
    Width = 41
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = edtCentroOrigenChange
    TabOrder = 11
    DatabaseName = 'BDProyecto'
    OnGetSQL = edtCentroOrigenGetSQL
    NumChars = 1
  end
  object edtCentroSalida: TnbDBSQLCombo
    Left = 124
    Top = 139
    Width = 41
    Height = 21
    About = 'NB 0.1/20020725'
    Alignment = taDownRight
    CharCase = ecUpperCase
    OnChange = edtCentroSalidaChange
    TabOrder = 14
    DatabaseName = 'BDProyecto'
    OnGetSQL = edtCentroOrigenGetSQL
    NumChars = 1
  end
  object edtCliente: TnbDBSQLCombo
    Left = 380
    Top = 184
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = edtClienteChange
    TabOrder = 22
    DatabaseName = 'BDProyecto'
    OnGetSQL = edtClienteGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object fechaDesde: TnbDBCalendarCombo
    Left = 124
    Top = 66
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '26/04/2004'
    TabOrder = 5
  end
  object fechaHasta: TnbDBCalendarCombo
    Left = 322
    Top = 66
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    Alignment = taDownRight
    CharCase = ecUpperCase
    Text = '26/04/2004'
    TabOrder = 6
  end
  object pais: TnbDBSQLCombo
    Left = 236
    Top = 184
    Width = 45
    Height = 21
    About = 'NB 0.1/20020725'
    Alignment = taDownRight
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 21
    SQL.Strings = (
      'select pais_p, descripcion_p from frf_paises order by pais_p')
    DatabaseName = 'BDProyecto'
    OnlyNumbers = False
    NumChars = 2
  end
  object categoria: TnbDBAlfa
    Left = 124
    Top = 256
    Width = 27
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 30
    NumChars = 2
  end
  object subPanel1: TPanel
    Left = 16
    Top = 358
    Width = 677
    Height = 223
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 33
    object Label13: TLabel
      Left = 17
      Top = 12
      Width = 148
      Height = 13
      Caption = ' Costes/Gastos que se aplican '
    end
    object lblFacturados: TLabel
      Left = 17
      Top = 149
      Width = 47
      Height = 13
      Caption = 'Albaranes'
    end
    object chkEnvase: TCheckBox
      Left = 17
      Top = 69
      Width = 162
      Height = 17
      Caption = 'Costes de envasado'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
    object chkSecciones: TCheckBox
      Left = 17
      Top = 85
      Width = 162
      Height = 17
      Caption = 'Costes secciones almac'#233'n'
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object cbxAlb6Digitos: TCheckBox
      Left = 17
      Top = 102
      Width = 154
      Height = 17
      Caption = 'Solo albaranes con 6 digitos'
      TabOrder = 8
    end
    object rbTodos: TRadioButton
      Left = 72
      Top = 147
      Width = 80
      Height = 17
      Caption = 'Todos'
      TabOrder = 10
    end
    object rbFacturados: TRadioButton
      Left = 135
      Top = 147
      Width = 80
      Height = 17
      Caption = 'Facturados'
      Checked = True
      TabOrder = 11
      TabStop = True
    end
    object rbSinFacturar: TRadioButton
      Left = 230
      Top = 147
      Width = 80
      Height = 17
      Caption = 'Sin facturar'
      TabOrder = 12
    end
    object chkAbonos: TCheckBox
      Left = 17
      Top = 180
      Width = 185
      Height = 17
      Caption = 'Incluir abonos y facturas manuales '
      Checked = True
      State = cbChecked
      TabOrder = 13
      OnClick = chkAbonosClick
    end
    object chkSoloManuales: TCheckBox
      Left = 37
      Top = 198
      Width = 185
      Height = 17
      Caption = 'Solo abonos y facturas manuales '
      TabOrder = 14
    end
    object chkDesgloseCostes: TCheckBox
      Left = 170
      Top = 10
      Width = 432
      Height = 17
      Caption = 
        'Desglosar en el listado todos los costes (Comisi'#243'n, envasado y g' +
        'astos albar'#225'n)'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = chkDesgloseCostesClick
    end
    object chkPromedios: TCheckBox
      Left = 222
      Top = 85
      Width = 432
      Height = 17
      Caption = 'Costes de envasado, usar promedio anual.'
      Checked = True
      State = cbChecked
      TabOrder = 7
      OnClick = chkDesgloseCostesClick
    end
    object cbbClienteFac: TComboBox
      Left = 17
      Top = 122
      Width = 474
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 9
      Text = 'Clientes facturables'
      Items.Strings = (
        'Todos los clientes'
        'Clientes facturables'
        
          'Clientes no facturables (RET, REA, REP, GAN, EG, BAN y empiezan ' +
          'por 0)')
    end
    object chkComisiones: TCheckBox
      Left = 17
      Top = 32
      Width = 200
      Height = 17
      Caption = 'Descuentos y comisiones facturables'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object chkDescuentos: TCheckBox
      Left = 222
      Top = 32
      Width = 379
      Height = 17
      Caption = 
        'Descuentos no facturables (Se aplica en columna de importes brut' +
        'o)'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object chkGastosFac: TCheckBox
      Left = 17
      Top = 51
      Width = 162
      Height = 17
      Caption = 'Gastos facturables del albar'#225'n'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object chkGastosNoFac: TCheckBox
      Left = 222
      Top = 51
      Width = 283
      Height = 17
      Caption = 'Gastos no facturables asociados al albar'#225'n'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object chkGastosFijos: TCheckBox
      Left = 222
      Top = 69
      Width = 283
      Height = 17
      Caption = 'Gastos fijos no facturables'
      TabOrder = 15
    end
  end
  object stCliente: TStaticText
    Left = 436
    Top = 186
    Width = 232
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 23
  end
  object stOrigen: TStaticText
    Left = 180
    Top = 117
    Width = 232
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 12
  end
  object stSalida: TStaticText
    Left = 180
    Top = 141
    Width = 232
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 15
  end
  object stEnvase: TStaticText
    Left = 222
    Top = 162
    Width = 190
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 19
  end
  object pnlTipoFactura: TPanel
    Left = 417
    Top = 66
    Width = 205
    Height = 22
    BevelOuter = bvNone
    TabOrder = 7
    object rbFechaSalidas: TRadioButton
      Left = 7
      Top = 1
      Width = 90
      Height = 20
      Caption = 'Fecha Salida'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbFechaSalidasClick
    end
    object rbFechaFacturas: TRadioButton
      Left = 114
      Top = 2
      Width = 113
      Height = 17
      Caption = 'Fecha Factura'
      TabOrder = 1
      OnClick = rbFechaSalidasClick
    end
  end
  object cbbProcedencia: TComboBox
    Left = 424
    Top = 43
    Width = 181
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 3
    TabStop = False
    Text = 'Toda la fruta'
    Items.Strings = (
      'Toda la fruta'
      'Fruta propia'
      'Fruta de terceros')
  end
  object cbbEsHortaliza: TComboBox
    Left = 424
    Top = 92
    Width = 181
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 9
    TabStop = False
    Text = 'Todos los productos'
    Items.Strings = (
      'Todos los productos'
      'Solo tomate'
      'Hortalizas'
      'Frutas')
  end
  object pnlSup: TPanel
    Left = 16
    Top = 7
    Width = 677
    Height = 28
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 0
    object lblPrecio: TLabel
      Left = 470
      Top = 5
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Precio'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object rbImportes: TRadioButton
      Left = 17
      Top = 6
      Width = 89
      Height = 17
      Caption = 'Ver Importes'
      Checked = True
      TabOrder = 2
      TabStop = True
    end
    object rbPrecios: TRadioButton
      Left = 110
      Top = 6
      Width = 113
      Height = 17
      Caption = 'Ver Precios'
      TabOrder = 3
    end
    object cbbCompPrecio: TComboBox
      Left = 563
      Top = 4
      Width = 45
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      TabStop = False
      Text = '='
      Items.Strings = (
        '='
        '<>'
        '>='
        '<='
        '>'
        '<')
    end
    object edtPrecio: TBEdit
      Left = 611
      Top = 4
      Width = 61
      Height = 21
      TabStop = False
      InputType = itReal
      MaxDecimals = 4
      CharCase = ecNormal
      MaxLength = 8
      TabOrder = 1
    end
  end
  object btnOk: TBitBtn
    Left = 536
    Top = 595
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Imprimir'
    TabOrder = 34
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
  object btnCancel: TBitBtn
    Left = 617
    Top = 595
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 35
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
  object edtComercial: TnbDBSQLCombo
    Left = 124
    Top = 230
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = edtComercialChange
    Enabled = False
    TabOrder = 28
    DatabaseName = 'BDProyecto'
    OnGetSQL = edtComercialGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object txtComercial: TStaticText
    Left = 180
    Top = 232
    Width = 232
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 29
  end
  object chkSuministro: TCheckBox
    Left = 460
    Top = 151
    Width = 189
    Height = 17
    Caption = 'Desglosar Plataforma del Cliente'
    TabOrder = 16
  end
  object btn1: TButton
    Left = 616
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Prueba'
    TabOrder = 1
    Visible = False
    OnClick = btn1Click
  end
  object edtTipoCliente: TnbDBSQLCombo
    Left = 124
    Top = 207
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = edtTipoClienteChange
    TabOrder = 24
    DatabaseName = 'BDProyecto'
    OnGetSQL = edtTipoClienteGetSQL
    OnlyNumbers = False
    NumChars = 2
  end
  object txtTipoCliente: TStaticText
    Left = 180
    Top = 209
    Width = 232
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 25
  end
  object chkExcluirTipoCliente: TCheckBox
    Left = 419
    Top = 209
    Width = 102
    Height = 17
    Caption = 'Excluir Tipo'
    TabOrder = 26
  end
  object chkNoP4H: TCheckBox
    Left = 424
    Top = 117
    Width = 189
    Height = 17
    Caption = 'Ignorar P4H'
    TabOrder = 13
  end
  object chkExcluirInterplanta: TCheckBox
    Left = 562
    Top = 209
    Width = 106
    Height = 17
    Caption = 'Excluir Interplanta'
    Checked = True
    State = cbChecked
    TabOrder = 27
  end
  object edtEnvase: TcxTextEdit
    Left = 124
    Top = 161
    Properties.CharCase = ecUpperCase
    Properties.MaxLength = 9
    Properties.OnChange = edtEnvaseChange
    Style.BorderStyle = ebs3D
    Style.LookAndFeel.Kind = lfUltraFlat
    Style.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.Kind = lfUltraFlat
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.Kind = lfUltraFlat
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.Kind = lfUltraFlat
    StyleHot.LookAndFeel.NativeStyle = False
    TabOrder = 17
    OnExit = edtEnvaseExit
    Width = 75
  end
  object ssEnvase: TSimpleSearch
    Left = 199
    Top = 162
    Width = 21
    Height = 21
    TabOrder = 18
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
    CampoResultado = 'envase_e'
    Enlace = edtEnvase
    Tecla = 'F2'
    AntesEjecutar = ssEnvaseAntesEjecutar
    Concatenar = False
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 280
    Width = 677
    Height = 72
    TabOrder = 32
    object Label8: TLabel
      Left = 297
      Top = 43
      Width = 357
      Height = 13
      Caption = 
        'Lista de tipo de gastos seperadas por coma. Vacio todas los tipo' +
        's de gastos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTipoGasto: TLabel
      Left = 12
      Top = 15
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Tipo Gasto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object grupoGasto: TnbDBAlfa
      Left = 108
      Top = 40
      Width = 183
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 1
      NumChars = 20
    end
    object eTipoGasto: TnbDBSQLCombo
      Left = 108
      Top = 13
      Width = 55
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      OnChange = eTipoGastoChange
      TabOrder = 0
      SQL.Strings = (
        
          'select tipo_tg cod, descripcion_tg gasto, unidad_dist_tg unidad,' +
          ' '
        '       case when gasto_transito_tg = 0 then '#39'SALIDAS'#39
        '            else '#39'TRANSITOS'#39
        '       end tipo'
        'from frf_tipo_gastos'
        'where gasto_transito_tg in (0,1)'
        'order by tipo_tg')
      DatabaseName = 'BDProyecto'
      OnlyNumbers = False
      NumChars = 3
    end
    object txtTipoGasto: TStaticText
      Left = 164
      Top = 14
      Width = 290
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 2
    end
    object cbxNoGasto: TCheckBox
      Left = 572
      Top = 15
      Width = 82
      Height = 17
      Caption = 'Excluir gasto seleccionado'
      TabOrder = 3
      OnClick = cbxNoGastoClick
    end
  end
  object ActionList1: TActionList
    Left = 656
    Top = 104
    object BAceptar: TAction
      Caption = 'BAceptar'
      ShortCut = 112
      OnExecute = btnOkClick
    end
    object BCancelar: TAction
      Caption = 'BCancelar'
      ShortCut = 27
      OnExecute = btnCancelClick
    end
  end
end
