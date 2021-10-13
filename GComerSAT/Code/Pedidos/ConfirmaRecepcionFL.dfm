object FLConfirmaRecepcion: TFLConfirmaRecepcion
  Left = 427
  Top = 170
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    Confirmaci'#243'n de Recepci'#243'n de Mercancias'
  ClientHeight = 220
  ClientWidth = 431
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
    431
    220)
  PixelsPerInch = 96
  TextHeight = 13
  object lblEmpresa: TnbLabel
    Left = 32
    Top = 32
    Width = 76
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object nbLabel2: TnbLabel
    Left = 32
    Top = 104
    Width = 76
    Height = 21
    Caption = 'Pedido'
    About = 'NB 0.1/20020725'
  end
  object stEmpresa: TLabel
    Left = 167
    Top = 36
    Width = 133
    Height = 13
    Caption = '(Falta c'#243'digo de la empresa)'
  end
  object stCentro: TLabel
    Left = 205
    Top = 108
    Width = 118
    Height = 13
    Caption = '(Vacio todos los pedidos)'
  end
  object nbLabel1: TnbLabel
    Left = 32
    Top = 80
    Width = 76
    Height = 21
    Caption = 'Fecha desde'
    About = 'NB 0.1/20020725'
  end
  object nbLabel3: TnbLabel
    Left = 32
    Top = 56
    Width = 76
    Height = 21
    Caption = 'Cliente'
    About = 'NB 0.1/20020725'
  end
  object stCliente: TLabel
    Left = 167
    Top = 60
    Width = 133
    Height = 13
    Caption = '(Falta c'#243'digo de la empresa)'
  end
  object nbLabel4: TnbLabel
    Left = 205
    Top = 80
    Width = 41
    Height = 21
    Caption = 'hasta'
    About = 'NB 0.1/20020725'
  end
  object nbLabel5: TnbLabel
    Left = 32
    Top = 128
    Width = 76
    Height = 21
    Caption = 'Albar'#225'n'
    About = 'NB 0.1/20020725'
  end
  object lblNombre1: TLabel
    Left = 205
    Top = 132
    Width = 127
    Height = 13
    Caption = '(Vacio todos los albaranes)'
  end
  object btnCerrar: TBitBtn
    Left = 315
    Top = 171
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cerrar (Esc)'
    TabOrder = 0
    TabStop = False
    OnClick = btnCerrarClick
    Kind = bkCancel
  end
  object btnImprimir: TBitBtn
    Left = 218
    Top = 171
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
  object empresa: TnbDBSQLCombo
    Left = 111
    Top = 32
    Width = 54
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
    NumChars = 3
  end
  object fechaDesde: TnbDBCalendarCombo
    Left = 111
    Top = 80
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '09/11/2007'
    TabOrder = 4
  end
  object cliente: TnbDBSQLCombo
    Left = 111
    Top = 56
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = clienteChange
    TabOrder = 3
    DatabaseName = 'BDProyecto'
    OnGetSQL = clienteGetSQL
    FillAuto = True
    OnlyNumbers = False
    NumChars = 3
  end
  object fechaHasta: TnbDBCalendarCombo
    Left = 249
    Top = 80
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '09/11/2007'
    TabOrder = 5
  end
  object pedido: TnbDBAlfa
    Left = 111
    Top = 104
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 6
  end
  object albaran: TnbDBNumeric
    Left = 111
    Top = 128
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 7
  end
end
