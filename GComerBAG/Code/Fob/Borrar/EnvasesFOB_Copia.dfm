object FEnvasesFob_Copia: TFEnvasesFob_Copia
  Left = 444
  Top = 194
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = '    Listado de Ventas FOB por Envases.'
  ClientHeight = 388
  ClientWidth = 493
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
    493
    388)
  PixelsPerInch = 96
  TextHeight = 13
  object Lcategoria: TLabel
    Left = 46
    Top = 182
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
    Top = 157
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
    Top = 157
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
    Top = 182
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
    Left = 8
    Top = 353
    Width = 274
    Height = 13
    Anchors = [akRight, akBottom]
    Caption = '(NOTA: Solamente las lineas con precio de los albaranes. '
  end
  object Label9: TLabel
    Left = 46
    Top = 134
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
    Caption = ' Envase '
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label16: TLabel
    Left = 186
    Top = 113
    Width = 225
    Height = 13
    Caption = '(Envase opcional, vacio usa todos los envases)'
  end
  object lblNombre1: TLabel
    Left = 47
    Top = 367
    Width = 318
    Height = 13
    Anchors = [akRight, akBottom]
    Caption = 
      'En importe ventas esta aplicado el descuento/comisi'#243'n del client' +
      'e.)'
  end
  object btnCancel: TBitBtn
    Left = 395
    Top = 339
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 14
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
    Top = 339
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Imprimir'
    TabOrder = 13
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
    TabOrder = 15
  end
  object STProducto: TStaticText
    Left = 168
    Top = 44
    Width = 195
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 16
  end
  object cbxNacionalidad: TComboBox
    Left = 128
    Top = 133
    Width = 115
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 8
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
    NumChars = 3
  end
  object producto: TnbDBSQLCombo
    Left = 128
    Top = 42
    Width = 41
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = productoChange
    TabOrder = 1
    DatabaseName = 'BDProyecto'
    OnGetSQL = productoGetSQL
    OnlyNumbers = False
    NumChars = 1
  end
  object centroDesde: TnbDBSQLCombo
    Left = 128
    Top = 65
    Width = 41
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 3
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
    TabOrder = 4
    DatabaseName = 'BDProyecto'
    OnGetSQL = centroDesdeGetSQL
    NumChars = 1
  end
  object clienteDesde: TnbDBSQLCombo
    Left = 128
    Top = 156
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 10
    DatabaseName = 'BDProyecto'
    OnGetSQL = clienteDesdeGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object clienteHasta: TnbDBSQLCombo
    Left = 312
    Top = 156
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    Alignment = taDownRight
    CharCase = ecUpperCase
    TabOrder = 11
    DatabaseName = 'BDProyecto'
    OnGetSQL = clienteDesdeGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object fechaDesde: TnbDBCalendarCombo
    Left = 128
    Top = 88
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '26/04/2004'
    TabOrder = 5
  end
  object fechaHasta: TnbDBCalendarCombo
    Left = 312
    Top = 88
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    Alignment = taDownRight
    CharCase = ecUpperCase
    Text = '26/04/2004'
    TabOrder = 6
  end
  object pais: TnbDBSQLCombo
    Left = 240
    Top = 133
    Width = 45
    Height = 21
    About = 'NB 0.1/20020725'
    Alignment = taDownRight
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 9
    SQL.Strings = (
      'select pais_p, descripcion_p from frf_paises order by pais_p')
    DatabaseName = 'BDProyecto'
    OnlyNumbers = False
    NumChars = 2
  end
  object cbxJuntarTE: TnbCheckBox
    Left = 368
    Top = 42
    Width = 57
    Height = 21
    Cursor = crHandPoint
    Caption = 'T y E'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = cbxJuntarTEClick
  end
  object categoria: TnbDBAlfa
    Left = 128
    Top = 178
    Width = 27
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 12
    NumChars = 2
  end
  object subPanel: TPanel
    Left = 0
    Top = 203
    Width = 493
    Height = 121
    BevelOuter = bvNone
    TabOrder = 17
    object Bevel1: TBevel
      Left = 40
      Top = 16
      Width = 422
      Height = 73
    end
    object Label10: TLabel
      Left = 90
      Top = 50
      Width = 69
      Height = 13
      Caption = ' Coste Envase'
    end
    object Label11: TLabel
      Left = 90
      Top = 66
      Width = 81
      Height = 13
      Caption = ' Coste Envasado'
    end
    object Label12: TLabel
      Left = 90
      Top = 34
      Width = 36
      Height = 13
      Caption = ' Gastos'
    end
    object Label13: TLabel
      Left = 45
      Top = 11
      Width = 107
      Height = 13
      Caption = 'Marcar para descontar'
    end
    object cbxEnvase: TCheckBox
      Left = 177
      Top = 48
      Width = 209
      Height = 17
      Caption = 'Material + Obra Mano Directa'
      TabOrder = 0
    end
    object cbxEnvasado: TCheckBox
      Left = 177
      Top = 64
      Width = 235
      Height = 17
      Caption = 'Gastos Secciones (S) Grupo Bonnysa '
      TabOrder = 1
    end
    object cbxGasto: TCheckBox
      Left = 177
      Top = 32
      Width = 162
      Height = 17
      Caption = 'Gastos asociados al albar'#225'n'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object cbxNuevo: TCheckBox
      Left = 41
      Top = 90
      Width = 186
      Height = 17
      Caption = 'Agrupar por Cliente y A'#241'o/Semana (aass)'
      TabOrder = 3
      OnClick = cbxNuevoClick
    end
    object cbxNo036: TCheckBox
      Left = 345
      Top = 32
      Width = 94
      Height = 17
      Caption = 'Excluir 036'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object cbxAlb6Digitos: TCheckBox
      Left = 265
      Top = 90
      Width = 154
      Height = 17
      Caption = 'Solo Albaranes con 6 digitos'
      TabOrder = 5
    end
  end
  object envase: TnbDBSQLCombo
    Left = 128
    Top = 110
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 7
    DatabaseName = 'BDProyecto'
    OnGetSQL = envaseGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object cbxVerAlbaran: TCheckBox
    Left = 12
    Top = 335
    Width = 110
    Height = 17
    Anchors = [akRight, akBottom]
    Caption = 'Desglosar Albar'#225'n'
    TabOrder = 18
  end
  object cbxVerCalibre: TCheckBox
    Left = 136
    Top = 335
    Width = 110
    Height = 17
    Anchors = [akRight, akBottom]
    Caption = 'Desglosar Calibre'
    TabOrder = 19
  end
end
