object FEnvasesFob: TFEnvasesFob
  Left = 677
  Top = 194
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = '    Listado de Ventas FOB Campo.'
  ClientHeight = 467
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
    467)
  PixelsPerInch = 96
  TextHeight = 13
  object Lcategoria: TLabel
    Left = 46
    Top = 200
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
    Top = 43
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
    Top = 66
    Width = 75
    Height = 19
    AutoSize = False
    Caption = ' Centro Desde'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label4: TLabel
    Left = 254
    Top = 66
    Width = 55
    Height = 19
    AutoSize = False
    Caption = ' Hasta'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Desde: TLabel
    Left = 46
    Top = 89
    Width = 75
    Height = 19
    AutoSize = False
    Caption = ' Fecha Desde'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label14: TLabel
    Left = 254
    Top = 89
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
    Top = 175
    Width = 75
    Height = 19
    AutoSize = False
    Caption = ' Cliente Desde'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label6: TLabel
    Left = 254
    Top = 175
    Width = 55
    Height = 19
    AutoSize = False
    Caption = ' Hasta'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label7: TLabel
    Left = 166
    Top = 200
    Width = 60
    Height = 13
    Caption = '(OPTATIVO)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 10
    Top = 432
    Width = 274
    Height = 13
    Anchors = [akRight, akBottom]
    Caption = '(NOTA: Solamente las lineas con precio de los albaranes. '
    ExplicitTop = 409
  end
  object Label9: TLabel
    Left = 46
    Top = 152
    Width = 75
    Height = 19
    AutoSize = False
    Caption = ' Clientes'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label15: TLabel
    Left = 46
    Top = 111
    Width = 75
    Height = 19
    AutoSize = False
    Caption = ' Art'#237'culo '
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label16: TLabel
    Left = 127
    Top = 133
    Width = 227
    Height = 13
    Caption = '(Art'#237'culo opcional, vacio usa todos los art'#237'culos)'
  end
  object lblNombre1: TLabel
    Left = 49
    Top = 446
    Width = 318
    Height = 13
    Anchors = [akRight, akBottom]
    Caption = 
      'En importe ventas esta aplicado el descuento/comisi'#243'n del client' +
      'e.)'
    ExplicitTop = 423
  end
  object subPanel2: TPanel
    Left = 0
    Top = 304
    Width = 493
    Height = 99
    BevelOuter = bvNone
    TabOrder = 19
    DesignSize = (
      493
      99)
    object Bevel2: TBevel
      Left = 40
      Top = 16
      Width = 422
      Height = 78
    end
    object lblNombre5: TLabel
      Left = 45
      Top = 11
      Width = 101
      Height = 13
      Caption = ' Agrupar / Desglosar '
    end
    object cbxAgruparPor: TCheckBox
      Left = 89
      Top = 26
      Width = 79
      Height = 17
      Hint = 'Agrupar por Cliente y A'#241'o/Semana (aass)'
      Caption = 'Agrupar por '
      TabOrder = 0
      OnClick = cbxAgruparPorClick
    end
    object cbxAlb6Digitos: TCheckBox
      Left = 89
      Top = 42
      Width = 154
      Height = 17
      Caption = 'Solo Albaranes con 6 digitos'
      TabOrder = 1
    end
    object cbxVerAlbaran: TCheckBox
      Left = 89
      Top = 58
      Width = 110
      Height = 17
      Anchors = [akRight, akBottom]
      Caption = 'Desglosar Albar'#225'n'
      TabOrder = 2
    end
    object cbxVerCalibre: TCheckBox
      Left = 89
      Top = 74
      Width = 110
      Height = 17
      Anchors = [akRight, akBottom]
      Caption = 'Desglosar Calibre'
      TabOrder = 3
    end
    object rbAnyoSemana: TRadioButton
      Left = 171
      Top = 26
      Width = 89
      Height = 17
      Caption = 'A'#241'o/Semana'
      Checked = True
      TabOrder = 4
      TabStop = True
    end
    object rbClienteAnyoSemana: TRadioButton
      Left = 259
      Top = 26
      Width = 129
      Height = 17
      Caption = 'Cliente - A'#241'o/Semana'
      TabOrder = 5
    end
  end
  object btnCancel: TBitBtn
    Left = 397
    Top = 418
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 15
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
    Left = 316
    Top = 415
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Imprimir'
    TabOrder = 14
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
    TabOrder = 16
  end
  object STProducto: TStaticText
    Left = 184
    Top = 44
    Width = 232
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 17
  end
  object cbxNacionalidad: TComboBox
    Left = 128
    Top = 151
    Width = 115
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 9
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
    OnlyNumbers = False
    NumChars = 3
  end
  object producto: TnbDBSQLCombo
    Left = 128
    Top = 42
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = productoChange
    TabOrder = 1
    DatabaseName = 'BDProyecto'
    OnGetSQL = productoGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object centroDesde: TnbDBSQLCombo
    Left = 128
    Top = 65
    Width = 41
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 2
    DatabaseName = 'BDProyecto'
    OnGetSQL = centroDesdeGetSQL
    NumChars = 1
  end
  object centroHasta: TnbDBSQLCombo
    Left = 312
    Top = 65
    Width = 41
    Height = 21
    About = 'NB 0.1/20020725'
    Alignment = taDownRight
    CharCase = ecUpperCase
    TabOrder = 3
    DatabaseName = 'BDProyecto'
    OnGetSQL = centroDesdeGetSQL
    NumChars = 1
  end
  object clienteDesde: TnbDBSQLCombo
    Left = 128
    Top = 174
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 11
    DatabaseName = 'BDProyecto'
    OnGetSQL = clienteDesdeGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object clienteHasta: TnbDBSQLCombo
    Left = 312
    Top = 174
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    Alignment = taDownRight
    CharCase = ecUpperCase
    TabOrder = 12
    DatabaseName = 'BDProyecto'
    OnGetSQL = clienteDesdeGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object fechaDesde: TnbDBCalendarCombo
    Left = 128
    Top = 88
    Width = 98
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '26/04/2004'
    TabOrder = 4
  end
  object fechaHasta: TnbDBCalendarCombo
    Left = 312
    Top = 88
    Width = 98
    Height = 21
    About = 'NB 0.1/20020725'
    Alignment = taDownRight
    CharCase = ecUpperCase
    Text = '26/04/2004'
    TabOrder = 5
  end
  object pais: TnbDBSQLCombo
    Left = 240
    Top = 151
    Width = 45
    Height = 21
    About = 'NB 0.1/20020725'
    Alignment = taDownRight
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 10
    SQL.Strings = (
      'select pais_p, descripcion_p from frf_paises order by pais_p')
    DatabaseName = 'BDProyecto'
    OnlyNumbers = False
    NumChars = 2
  end
  object categoria: TnbDBAlfa
    Left = 128
    Top = 196
    Width = 27
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 13
    NumChars = 2
  end
  object subPanel1: TPanel
    Left = 0
    Top = 219
    Width = 493
    Height = 98
    BevelOuter = bvNone
    TabOrder = 18
    object Bevel1: TBevel
      Left = 40
      Top = 16
      Width = 422
      Height = 73
    end
    object Label13: TLabel
      Left = 45
      Top = 11
      Width = 133
      Height = 13
      Caption = ' Gastos que se descuentan '
    end
    object chkEnvase: TCheckBox
      Left = 89
      Top = 48
      Width = 209
      Height = 17
      Caption = 'Costes de envasado'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chkSecciones: TCheckBox
      Left = 89
      Top = 64
      Width = 235
      Height = 17
      Caption = 'Costes secciones almac'#233'n'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object cbxGasto: TCheckBox
      Left = 89
      Top = 32
      Width = 162
      Height = 17
      Caption = 'Gastos asociados al albar'#225'n'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object cbxNo036: TCheckBox
      Left = 345
      Top = 32
      Width = 94
      Height = 17
      Caption = 'Excluir 036'
      TabOrder = 3
    end
  end
  object envase: TcxTextEdit
    Left = 128
    Top = 111
    Properties.CharCase = ecUpperCase
    Properties.MaxLength = 9
    Properties.OnChange = envasePropertiesChange
    Style.BorderStyle = ebs3D
    Style.LookAndFeel.Kind = lfUltraFlat
    Style.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.Kind = lfUltraFlat
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.Kind = lfUltraFlat
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.Kind = lfUltraFlat
    StyleHot.LookAndFeel.NativeStyle = False
    TabOrder = 6
    OnExit = envaseExit
    Width = 75
  end
  object ssEnvase: TSimpleSearch
    Left = 203
    Top = 111
    Width = 21
    Height = 21
    TabOrder = 7
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
    Enlace = envase
    Tecla = 'F2'
    AntesEjecutar = ssEnvaseAntesEjecutar
    Concatenar = False
  end
  object stEnvase: TStaticText
    Left = 225
    Top = 113
    Width = 193
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 8
  end
end
