object FDAsignarGastosServicioVenta: TFDAsignarGastosServicioVenta
  Left = 742
  Top = 240
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    ASIGNAR GASTOS SERVICIOS DE TRANSPORTE'
  ClientHeight = 230
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
    230)
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
  object stEmpresa: TLabel
    Left = 200
    Top = 36
    Width = 133
    Height = 13
    Caption = '(Falta c'#243'digo de la empresa)'
  end
  object nbLabel1: TnbLabel
    Left = 32
    Top = 105
    Width = 100
    Height = 21
    Caption = 'Fecha Llegada del'
    About = 'NB 0.1/20020725'
  end
  object nbLabel3: TnbLabel
    Left = 232
    Top = 105
    Width = 33
    Height = 21
    Caption = 'Al'
    About = 'NB 0.1/20020725'
  end
  object nbLabel4: TnbLabel
    Left = 32
    Top = 57
    Width = 100
    Height = 21
    Caption = 'Transportista'
    About = 'NB 0.1/20020725'
  end
  object lblTransportista: TLabel
    Left = 200
    Top = 61
    Width = 161
    Height = 13
    AutoSize = False
    Caption = '(Vacio, todos los transportistas)'
  end
  object lbl1: TnbLabel
    Left = 32
    Top = 81
    Width = 100
    Height = 21
    Caption = 'Matr'#237'cula'
    About = 'NB 0.1/20020725'
  end
  object lbl2: TLabel
    Left = 264
    Top = 85
    Width = 119
    Height = 13
    AutoSize = False
    Caption = '(Vacio, todas)'
  end
  object lblCodigo1: TnbLabel
    Left = 32
    Top = 131
    Width = 100
    Height = 21
    Caption = 'Distribuir Gastos Por'
    About = 'NB 0.1/20020725'
  end
  object btnCerrar: TBitBtn
    Left = 341
    Top = 171
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cerrar (Esc)'
    TabOrder = 7
    TabStop = False
    OnClick = btnCerrarClick
    Kind = bkCancel
  end
  object btnImprimir: TBitBtn
    Left = 244
    Top = 171
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Asignar (F1)'
    ModalResult = 1
    TabOrder = 6
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
    Width = 60
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eEmpresaChange
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
  object eFechaDesde: TnbDBCalendarCombo
    Left = 136
    Top = 105
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '30/04/2009'
    TabOrder = 3
  end
  object eFechaHasta: TnbDBCalendarCombo
    Left = 272
    Top = 105
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '30/04/2009'
    TabOrder = 4
  end
  object eTransportista: TnbDBSQLCombo
    Left = 136
    Top = 57
    Width = 60
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eTransportistaChange
    TabOrder = 1
    DatabaseName = 'BDProyecto'
    OnGetSQL = eTransportistaGetSQL
    FillAuto = True
    NumChars = 3
  end
  object eMatricula: TnbCustomEdit
    Left = 136
    Top = 81
    Width = 121
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 2
  end
  object cbbUnidadDist: TComboBox
    Left = 136
    Top = 130
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 5
    Text = 'Grabado en tipo gasto'
    Items.Strings = (
      'Grabado en tipo gasto'
      'Forzar por kilos')
  end
  object QSelectServicios: TQuery
    DatabaseName = 'BDProyecto'
    Left = 384
    Top = 32
  end
end
