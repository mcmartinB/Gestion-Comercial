object FDTransitosAduanaDetalle: TFDTransitosAduanaDetalle
  Left = 555
  Top = 239
  Width = 506
  Height = 402
  Caption = '   DETALLE ADUANA DEL TRANSITO'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object nbLabel1: TnbLabel
    Left = 40
    Top = 65
    Width = 113
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object nbLabel2: TnbLabel
    Left = 40
    Top = 40
    Width = 113
    Height = 21
    Caption = 'DVD'
    About = 'NB 0.1/20020725'
  end
  object nbLabel6: TnbLabel
    Left = 41
    Top = 173
    Width = 113
    Height = 21
    Caption = 'Fecha Solicitud'
    About = 'NB 0.1/20020725'
  end
  object nbLabel7: TnbLabel
    Left = 40
    Top = 117
    Width = 113
    Height = 21
    Caption = 'Dir. Suministro'
    About = 'NB 0.1/20020725'
  end
  object nbLabel8: TnbLabel
    Left = 41
    Top = 225
    Width = 113
    Height = 21
    Caption = 'DUA Consumo'
    About = 'NB 0.1/20020725'
  end
  object lblEmpresa: TLabel
    Left = 160
    Top = 69
    Width = 51
    Height = 13
    Caption = 'lblEmpresa'
  end
  object lblDVD: TLabel
    Left = 160
    Top = 44
    Width = 33
    Height = 13
    Caption = 'lblDVD'
  end
  object nbLabel3: TnbLabel
    Left = 40
    Top = 199
    Width = 113
    Height = 21
    Caption = 'Kilos'
    About = 'NB 0.1/20020725'
  end
  object stCliente: TnbStaticText
    Left = 224
    Top = 91
    Width = 233
    Height = 21
    About = 'NB 0.1/20020725'
    OnGetDescription = stClienteGetDescription
  end
  object stDirSum: TnbStaticText
    Left = 224
    Top = 117
    Width = 233
    Height = 21
    About = 'NB 0.1/20020725'
    OnGetDescription = stDirSumGetDescription
  end
  object nbLabel4: TnbLabel
    Left = 41
    Top = 251
    Width = 113
    Height = 21
    Caption = 'Notas'
    About = 'NB 0.1/20020725'
  end
  object lblKilosFaltan: TLabel
    Left = 256
    Top = 28
    Width = 201
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Kilos Faltan'
  end
  object lbl1: TnbLabel
    Left = 61
    Top = 93
    Width = 92
    Height = 21
    Caption = 'Cliente'
    About = 'NB 0.1/20020725'
  end
  object lblCentro: TnbLabel
    Left = 61
    Top = 147
    Width = 92
    Height = 21
    Caption = 'Centro'
    About = 'NB 0.1/20020725'
  end
  object stCentro: TnbStaticText
    Left = 224
    Top = 145
    Width = 233
    Height = 21
    Caption = 'Seleccione un cliente'
    About = 'NB 0.1/20020725'
    OnGetDescription = stCentroGetDescription
  end
  object kilos_dal: TnbDBNumeric
    Left = 160
    Top = 199
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 6
    DataField = 'kilos_dal'
    DataSource = DSDetalleDatosAduana
    DBLink = True
    NumIntegers = 10
    NumDecimals = 2
  end
  object btnGuardar: TButton
    Left = 252
    Top = 318
    Width = 105
    Height = 25
    Caption = 'Guardar (F1)'
    TabOrder = 9
    TabStop = False
    OnClick = btnGuardarClick
  end
  object btnSalir: TButton
    Left = 360
    Top = 318
    Width = 105
    Height = 25
    Caption = 'Salir (Esc)'
    TabOrder = 10
    TabStop = False
    OnClick = btnSalirClick
  end
  object fecha_dal: TnbDBCalendarCombo
    Left = 160
    Top = 173
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 5
    DataField = 'fecha_dal'
    DataSource = DSDetalleDatosAduana
    DBLink = True
  end
  object dua_consumo_dal: TnbDBAlfa
    Left = 160
    Top = 225
    Width = 140
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 7
    DataField = 'dua_consumo_dal'
    DataSource = DSDetalleDatosAduana
    DBLink = True
    NumChars = 20
  end
  object cliente_dal: TnbDBSQLCombo
    Left = 160
    Top = 91
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = cliente_dalChange
    TabOrder = 0
    DataField = 'cliente_dal'
    DataSource = DSDetalleDatosAduana
    DBLink = True
    DatabaseName = 'BDProyecto'
    OnGetSQL = cliente_dalGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object dir_sum_dal: TnbDBSQLCombo
    Left = 160
    Top = 117
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = dir_sum_dalChange
    TabOrder = 2
    DataField = 'dir_sum_dal'
    DataSource = DSDetalleDatosAduana
    DBLink = True
    DatabaseName = 'BDProyecto'
    OnGetSQL = dir_sum_dalGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object DBMemo1: TDBMemo
    Left = 160
    Top = 251
    Width = 305
    Height = 40
    DataField = 'notas_dal'
    DataSource = DSDetalleDatosAduana
    TabOrder = 8
  end
  object centro_destino_dal: TnbDBSQLCombo
    Left = 160
    Top = 145
    Width = 43
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = centro_destino_dalChange
    Enabled = False
    TabOrder = 3
    DataField = 'centro_destino_dal'
    DataSource = DSDetalleDatosAduana
    DBLink = True
    DatabaseName = 'BDProyecto'
    OnGetSQL = centro_destino_dalGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object rbCliente: TRadioButton
    Left = 40
    Top = 95
    Width = 16
    Height = 17
    Checked = True
    TabOrder = 1
    TabStop = True
    OnClick = rbClienteClick
  end
  object rbCentro: TRadioButton
    Left = 40
    Top = 149
    Width = 16
    Height = 17
    TabOrder = 4
    OnClick = rbClienteClick
  end
  object DSDetalleDatosAduana: TDataSource
    DataSet = DDTransitosAduana.QDatosAduanaDetalle
    Left = 22
    Top = 26
  end
end
