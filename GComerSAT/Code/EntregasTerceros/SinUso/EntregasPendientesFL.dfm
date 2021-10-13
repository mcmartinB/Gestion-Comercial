object FLEntregasPendientes: TFLEntregasPendientes
  Left = 574
  Top = 283
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    Entregas pendientes de descargar.'
  ClientHeight = 259
  ClientWidth = 457
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
    457
    259)
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
    Top = 56
    Width = 100
    Height = 21
    Caption = 'Centro'
    About = 'NB 0.1/20020725'
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
    Top = 60
    Width = 114
    Height = 13
    Caption = '(Falta c'#243'digo del centro)'
  end
  object nbLabel1: TnbLabel
    Left = 32
    Top = 130
    Width = 100
    Height = 21
    Caption = 'Fecha Llegada del'
    About = 'NB 0.1/20020725'
  end
  object nbLabel3: TnbLabel
    Left = 232
    Top = 130
    Width = 33
    Height = 21
    Caption = 'Al'
    About = 'NB 0.1/20020725'
  end
  object nbLabel4: TnbLabel
    Left = 32
    Top = 105
    Width = 100
    Height = 21
    Caption = 'Semana'
    About = 'NB 0.1/20020725'
  end
  object lblSemana: TLabel
    Left = 192
    Top = 109
    Width = 257
    Height = 13
    AutoSize = False
    Caption = '(Optativo, los dos primeros d'#237'gitos campo albar'#225'n)'
  end
  object lblProducto: TnbLabel
    Left = 32
    Top = 81
    Width = 100
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object stProducto: TLabel
    Left = 192
    Top = 85
    Width = 128
    Height = 13
    Caption = '(Vacio todos los productos)'
  end
  object lblEstadoEntrega: TnbLabel
    Left = 32
    Top = 154
    Width = 100
    Height = 21
    Caption = 'Estado Entrega'
    About = 'NB 0.1/20020725'
  end
  object btnCerrar: TBitBtn
    Left = 341
    Top = 200
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cerrar (Esc)'
    TabOrder = 8
    TabStop = False
    OnClick = btnCerrarClick
    Kind = bkCancel
  end
  object btnImprimir: TBitBtn
    Left = 244
    Top = 200
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Imprimir (F1)'
    ModalResult = 1
    TabOrder = 7
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
    NumChars = 3
  end
  object centro: TnbDBSQLCombo
    Left = 136
    Top = 56
    Width = 41
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = centroChange
    TabOrder = 1
    DatabaseName = 'BDProyecto'
    OnGetSQL = centroGetSQL
    NumChars = 1
  end
  object eDesde: TnbDBCalendarCombo
    Left = 136
    Top = 130
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '30/04/2009'
    TabOrder = 4
  end
  object eHasta: TnbDBCalendarCombo
    Left = 272
    Top = 130
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '30/04/2009'
    TabOrder = 5
  end
  object eSemana: TBEdit
    Left = 136
    Top = 105
    Width = 25
    Height = 21
    MaxLength = 2
    TabOrder = 3
  end
  object edtProducto: TnbDBSQLCombo
    Left = 136
    Top = 81
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = edtProductoChange
    TabOrder = 2
    DatabaseName = 'BDProyecto'
    OnGetSQL = edtProductoGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object cbbEstadoEntrega: TComboBox
    Left = 136
    Top = 154
    Width = 226
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 6
    Text = 'PENDIENTE DESCARGA'
    Items.Strings = (
      'PENDIENTE DESCARGA'
      'DESCARGADA'
      'INDIFERENTE')
  end
end
