object FDServiciosEntregaAsignarGastos: TFDServiciosEntregaAsignarGastos
  Left = 613
  Top = 231
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    ASIGNAR GASTOS SERVICIOS DE TRANSPORTE'
  ClientHeight = 230
  ClientWidth = 584
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
    584
    230)
  PixelsPerInch = 96
  TextHeight = 13
  object nbLabel1: TnbLabel
    Left = 46
    Top = 82
    Width = 100
    Height = 21
    Caption = 'Fecha Llegada del'
    About = 'NB 0.1/20020725'
  end
  object nbLabel3: TnbLabel
    Left = 246
    Top = 82
    Width = 33
    Height = 21
    Caption = 'Al'
    About = 'NB 0.1/20020725'
  end
  object lbl1: TnbLabel
    Left = 46
    Top = 58
    Width = 100
    Height = 21
    Caption = 'Matr'#237'cula'
    About = 'NB 0.1/20020725'
  end
  object lbl2: TLabel
    Left = 278
    Top = 62
    Width = 119
    Height = 13
    AutoSize = False
    Caption = '(Vacio, todas)'
  end
  object lblCodigo1: TnbLabel
    Left = 46
    Top = 108
    Width = 100
    Height = 21
    Caption = 'Distribuir Gastos Por'
    About = 'NB 0.1/20020725'
  end
  object lbl3: TLabel
    Left = 46
    Top = 23
    Width = 492
    Height = 13
    Caption = 
      'NOTA: Todas las estimaciones de gastos grabadas en las entregas ' +
      'se sobreescribiran.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 46
    Top = 36
    Width = 427
    Height = 13
    Caption = 
      'Una estimacion es un gasto grabado de forma manual en la entrega' +
      ' sin n'#250'mero de factura.'
  end
  object btnCerrar: TBitBtn
    Left = 468
    Top = 171
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cerrar (Esc)'
    TabOrder = 5
    TabStop = False
    OnClick = btnCerrarClick
    Kind = bkCancel
  end
  object btnImprimir: TBitBtn
    Left = 371
    Top = 171
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Asignar (F1)'
    ModalResult = 1
    TabOrder = 4
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
  object eFechaDesde: TnbDBCalendarCombo
    Left = 150
    Top = 82
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '30/04/2009'
    TabOrder = 1
  end
  object eFechaHasta: TnbDBCalendarCombo
    Left = 286
    Top = 82
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '30/04/2009'
    TabOrder = 2
  end
  object eMatricula: TnbCustomEdit
    Left = 150
    Top = 58
    Width = 121
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 0
  end
  object cbbUnidadDist: TComboBox
    Left = 150
    Top = 107
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 3
    Text = 'Grabado en tipo gasto'
    Items.Strings = (
      'Grabado en tipo gasto'
      'Por palets'
      'Por cajas'
      'Por kilos'
      'Por importe')
  end
  object QSelectServicios: TQuery
    DatabaseName = 'BDProyecto'
    Left = 35
    Top = 9
  end
end
