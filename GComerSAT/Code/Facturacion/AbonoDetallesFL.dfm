object FLAbonoDetalles: TFLAbonoDetalles
  Left = 336
  Top = 317
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    Detalle del Abono'
  ClientHeight = 277
  ClientWidth = 449
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
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  DesignSize = (
    449
    277)
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
    Top = 80
    Width = 100
    Height = 21
    Caption = 'Art'#237'culo'
    About = 'NB 0.1/20020725'
  end
  object stEmpresa: TLabel
    Left = 240
    Top = 36
    Width = 133
    Height = 13
    Caption = '(Falta c'#243'digo de la empresa)'
  end
  object stEnvase: TLabel
    Left = 238
    Top = 84
    Width = 161
    Height = 13
    Caption = '(Vacio muestra todos los envases)'
  end
  object Label1: TLabel
    Left = 32
    Top = 185
    Width = 340
    Height = 13
    Caption = 
      'Este listado muestra la informaci'#243'n de los albaranes asociados a' +
      'l abono.'
  end
  object nbLabel3: TnbLabel
    Left = 32
    Top = 128
    Width = 100
    Height = 21
    Caption = 'Fecha desde'
    About = 'NB 0.1/20020725'
  end
  object nbLabel1: TnbLabel
    Left = 229
    Top = 128
    Width = 41
    Height = 21
    Caption = 'hasta'
    About = 'NB 0.1/20020725'
  end
  object lblCliente: TnbLabel
    Left = 32
    Top = 104
    Width = 100
    Height = 21
    Caption = 'Cliente'
    About = 'NB 0.1/20020725'
  end
  object stCliente: TLabel
    Left = 240
    Top = 108
    Width = 157
    Height = 13
    Caption = '(Vacio muestra todos los clientes)'
  end
  object nbLabel4: TnbLabel
    Left = 32
    Top = 56
    Width = 100
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object lblProducto: TLabel
    Left = 240
    Top = 60
    Width = 168
    Height = 13
    Caption = '(Vacio muestra todos los productos)'
  end
  object lblNombre1: TLabel
    Left = 32
    Top = 198
    Width = 305
    Height = 13
    Caption = 'NOTA: Los abonos de anulaci'#243'n no tienen albaranes asociados.'
  end
  object btnCerrar: TBitBtn
    Left = 333
    Top = 228
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    TabOrder = 0
    TabStop = False
    OnClick = btnCerrarClick
    Kind = bkCancel
  end
  object btnImprimir: TBitBtn
    Left = 236
    Top = 228
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Imprimir (F1)'
    ModalResult = 1
    TabOrder = 1
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
    Top = 32
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eEmpresaChange
    TabOrder = 2
    SQL.Strings = (
      'select empresa_e, nombre_e '
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    FillAuto = True
    NumChars = 3
  end
  object eFechaDesde: TnbDBCalendarCombo
    Left = 136
    Top = 128
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '07/08/2008'
    TabOrder = 7
  end
  object eFechaHasta: TnbDBCalendarCombo
    Left = 275
    Top = 128
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '07/08/2008'
    TabOrder = 8
  end
  object eCliente: TnbDBSQLCombo
    Left = 136
    Top = 104
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eClienteChange
    TabOrder = 6
    DatabaseName = 'BDProyecto'
    OnGetSQL = eClienteGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object eProducto: TnbDBSQLCombo
    Left = 136
    Top = 56
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
  object cbxdAnulaciones: TCheckBox
    Left = 136
    Top = 154
    Width = 225
    Height = 17
    Caption = 'Mostrar Abonos de Anulacion de Factura'
    TabOrder = 9
  end
  object eEnvase: TcxTextEdit
    Left = 136
    Top = 80
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
    TabOrder = 4
    OnExit = eEnvaseExit
    Width = 75
  end
  object ssEnvase: TSimpleSearch
    Left = 211
    Top = 80
    Width = 21
    Height = 21
    TabOrder = 5
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
