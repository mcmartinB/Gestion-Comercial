object FLValorarStockConfeccionado: TFLValorarStockConfeccionado
  Left = 507
  Top = 231
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    Valorar Stock Fruta Confeccionada - EN DESARROLLO'
  ClientHeight = 372
  ClientWidth = 561
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
    561
    372)
  PixelsPerInch = 96
  TextHeight = 13
  object lblEmpresa: TnbLabel
    Left = 32
    Top = 81
    Width = 100
    Height = 21
    Caption = 'Planta'
    About = 'NB 0.1/20020725'
  end
  object nbLabel2: TnbLabel
    Left = 32
    Top = 105
    Width = 100
    Height = 21
    Caption = 'Centro'
    About = 'NB 0.1/20020725'
  end
  object stEmpresa: TLabel
    Left = 192
    Top = 85
    Width = 153
    Height = 13
    AutoSize = False
    Caption = '(Vacio =Todas las plantas)'
  end
  object stCentro: TLabel
    Left = 192
    Top = 109
    Width = 153
    Height = 13
    AutoSize = False
    Caption = '(Vacio =Todos los centros)'
  end
  object Label3: TLabel
    Left = 62
    Top = 18
    Width = 408
    Height = 13
    Caption = 'POR FAVOR ESPERE MIENTRAS SE EXTRAEN LOS DATOS PEDIDOS'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentColor = False
    ParentFont = False
    Visible = False
  end
  object nbLabel1: TnbLabel
    Left = 32
    Top = 129
    Width = 100
    Height = 21
    Caption = 'Producto '
    About = 'NB 0.1/20020725'
  end
  object stProducto: TLabel
    Left = 192
    Top = 133
    Width = 153
    Height = 13
    AutoSize = False
    Caption = '(Vacio =Todos los productos)'
  end
  object stCliente: TLabel
    Left = 192
    Top = 157
    Width = 153
    Height = 13
    AutoSize = False
    Caption = '(Vacio =Todos los clientes)'
  end
  object lblProveedor: TnbLabel
    Left = 32
    Top = 153
    Width = 100
    Height = 21
    Caption = 'Cliente'
    About = 'NB 0.1/20020725'
  end
  object lblVariedad: TnbLabel
    Left = 32
    Top = 177
    Width = 100
    Height = 21
    Caption = 'Art'#237'culo'
    About = 'NB 0.1/20020725'
  end
  object stEnvase: TLabel
    Left = 242
    Top = 181
    Width = 153
    Height = 13
    AutoSize = False
    Caption = '(Vacio =Todas las variedades)'
  end
  object lblFechaStock: TnbLabel
    Left = 32
    Top = 57
    Width = 100
    Height = 21
    Caption = 'Fecha Stock'
    About = 'NB 0.1/20020725'
  end
  object lbl2: TLabel
    Left = 32
    Top = 287
    Width = 503
    Height = 17
    AutoSize = False
    Caption = 
      'Estos se reciben un d'#237'a despues de su grabacion en el almac'#233'n, n' +
      'o es tiempo real. '
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentColor = False
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 32
    Top = 272
    Width = 503
    Height = 16
    AutoSize = False
    Caption = 'NOTA: Se usan los datos de radiofrecuencia (RF) de la central. '
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object lbl1: TLabel
    Left = 232
    Top = 61
    Width = 252
    Height = 13
    Caption = '(Como maximo en stock un palet puede estar 30 dias)'
  end
  object lbl4: TLabel
    Left = 32
    Top = 224
    Width = 463
    Height = 13
    Caption = 
      'El precio de la fruta es el precio medio de la fruta entrada una' +
      ' semana antes de la fecha del stock.'
  end
  object btnCerrar: TBitBtn
    Left = 445
    Top = 323
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
    Left = 348
    Top = 323
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
    Left = 136
    Top = 81
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
    Left = 136
    Top = 105
    Width = 41
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eCentroChange
    TabOrder = 2
    DatabaseName = 'BDProyecto'
    OnGetSQL = eCentroGetSQL
    NumChars = 1
  end
  object eProducto: TnbDBSQLCombo
    Left = 136
    Top = 129
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eProductoChange
    TabOrder = 3
    DatabaseName = 'BDProyecto'
    OnGetSQL = eProductoGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object eCliente: TnbDBSQLCombo
    Left = 136
    Top = 153
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eClienteChange
    TabOrder = 4
    SQL.Strings = (
      'select empresa_e, nombre_e '
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    ColumnResult = 1
    OnGetSQL = eClienteGetSQL
    FillAuto = True
    OnlyNumbers = False
    NumChars = 3
  end
  object eFechaStock: TnbDBCalendarCombo
    Left = 136
    Top = 57
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '30/04/2009'
    TabOrder = 0
  end
  object chkVerDetalle: TCheckBox
    Left = 136
    Top = 203
    Width = 103
    Height = 17
    Caption = 'Ver detalle palets'
    TabOrder = 7
  end
  object eEnvase: TcxTextEdit
    Left = 136
    Top = 176
    BeepOnEnter = False
    Properties.CharCase = ecUpperCase
    Properties.MaxLength = 9
    Properties.OnChange = eEnvaseChange
    Style.BorderStyle = ebs3D
    Style.LookAndFeel.Kind = lfUltraFlat
    Style.LookAndFeel.NativeStyle = False
    Style.Shadow = False
    Style.TextStyle = []
    StyleDisabled.LookAndFeel.Kind = lfUltraFlat
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.Kind = lfUltraFlat
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.Kind = lfUltraFlat
    StyleHot.LookAndFeel.NativeStyle = False
    TabOrder = 5
    OnExit = eEnvaseExit
    Width = 75
  end
  object ssEnvase: TSimpleSearch
    Left = 211
    Top = 176
    Width = 21
    Height = 21
    TabOrder = 6
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
    Enlace = eEnvase
    Tecla = 'F2'
    AntesEjecutar = ssEnvaseAntesEjecutar
    Concatenar = False
  end
end
