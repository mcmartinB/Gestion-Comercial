object FDTransitosAduana: TFDTransitosAduana
  Left = 442
  Top = 246
  Caption = '    DEPOSITO ADUANA'
  ClientHeight = 399
  ClientWidth = 801
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
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object nbLabel1: TnbLabel
    Left = 40
    Top = 61
    Width = 113
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object nbLabel2: TnbLabel
    Left = 197
    Top = 61
    Width = 113
    Height = 21
    Caption = 'Centro'
    About = 'NB 0.1/20020725'
  end
  object nbLabel3: TnbLabel
    Left = 418
    Top = 85
    Width = 113
    Height = 21
    Caption = 'Fecha'
    About = 'NB 0.1/20020725'
  end
  object nbLabel4: TnbLabel
    Left = 40
    Top = 85
    Width = 113
    Height = 21
    Caption = 'Tr'#225'nsito'
    About = 'NB 0.1/20020725'
  end
  object nbLabel5: TnbLabel
    Left = 40
    Top = 134
    Width = 113
    Height = 21
    Caption = 'DUA Llegada'
    About = 'NB 0.1/20020725'
  end
  object nbLabel7: TnbLabel
    Left = 40
    Top = 158
    Width = 113
    Height = 21
    Caption = 'Conocim. Embarque'
    About = 'NB 0.1/20020725'
  end
  object nbLabel8: TnbLabel
    Left = 40
    Top = 182
    Width = 113
    Height = 21
    Caption = 'DUA Exportaci'#243'n'
    About = 'NB 0.1/20020725'
  end
  object Concepto: TnbLabel
    Left = 245
    Top = 220
    Width = 80
    Height = 21
    Caption = 'Concepto'
    About = 'NB 0.1/20020725'
  end
  object nbLabel21: TnbLabel
    Left = 163
    Top = 220
    Width = 80
    Height = 21
    Caption = 'GASTOS'
    About = 'NB 0.1/20020725'
  end
  object nbLabel10: TnbLabel
    Left = 327
    Top = 244
    Width = 80
    Height = 21
    Caption = 'THC Manipulaci'#243'n'
    About = 'NB 0.1/20020725'
  end
  object nbLabel11: TnbLabel
    Left = 245
    Top = 244
    Width = 80
    Height = 21
    Caption = 'Dto. Rappel'
    About = 'NB 0.1/20020725'
  end
  object lblFlete: TnbLabel
    Left = 163
    Top = 244
    Width = 80
    Height = 21
    Caption = 'Flete'
    About = 'NB 0.1/20020725'
  end
  object lblEmpresa: TLabel
    Left = 160
    Top = 65
    Width = 30
    Height = 13
    AutoSize = False
    Caption = 'lblEmpresa'
  end
  object lblTransito: TLabel
    Left = 160
    Top = 89
    Width = 53
    Height = 13
    Caption = 'lblNombre1'
  end
  object lblCentro: TLabel
    Left = 312
    Top = 65
    Width = 15
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'lblCentro'
  end
  object lblFecha: TLabel
    Left = 538
    Top = 89
    Width = 40
    Height = 13
    Caption = 'lblFecha'
  end
  object nbLabel14: TnbLabel
    Left = 492
    Top = 220
    Width = 163
    Height = 21
    Caption = 'KILOS TR'#193'NSITO'
    About = 'NB 0.1/20020725'
  end
  object lblKilosTransito: TLabel
    Left = 657
    Top = 224
    Width = 80
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'lblKilosTransito'
  end
  object nbLabel15: TnbLabel
    Left = 410
    Top = 244
    Width = 80
    Height = 21
    Caption = 'T3 Mercanc'#237'a'
    About = 'NB 0.1/20020725'
  end
  object nbLabel16: TnbLabel
    Left = 492
    Top = 244
    Width = 80
    Height = 21
    Caption = 'BAF Combustible'
    About = 'NB 0.1/20020725'
  end
  object nbLabel17: TnbLabel
    Left = 575
    Top = 244
    Width = 80
    Height = 21
    Caption = 'Tasas Seguridad'
    About = 'NB 0.1/20020725'
  end
  object nbLabel18: TnbLabel
    Left = 657
    Top = 244
    Width = 80
    Height = 21
    Caption = 'Plataforma Frigo.'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo1: TnbLabel
    Left = 81
    Top = 220
    Width = 33
    Height = 46
    Caption = 'Teus'#13#10'40'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo2: TnbLabel
    Left = 117
    Top = 220
    Width = 44
    Height = 46
    Caption = 'Metros'#13#10'Lineales'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo3: TnbLabel
    Left = 418
    Top = 61
    Width = 113
    Height = 21
    Caption = 'Puerto Salida'
    About = 'NB 0.1/20020725'
  end
  object btnpuerto_salida_dac: TBGridButton
    Left = 560
    Top = 61
    Width = 13
    Height = 21
    Glyph.Data = {
      C6000000424DC60000000000000076000000280000000A0000000A0000000100
      0400000000005000000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
      0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
      0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
      0000FFFFFFFFFF000000}
    OnClick = btnpuerto_salida_dacClick
    Control = puerto_salida_dac
    Grid = bgrdRejillaFlotante
    GridAlignment = taDownRight
    GridWidth = 280
    GridHeigth = 200
  end
  object lblKilosNetos_: TnbLabel
    Left = 492
    Top = 292
    Width = 80
    Height = 21
    Caption = 'Kilos Netos'
    About = 'NB 0.1/20020725'
  end
  object lblKilosBrutos_: TnbLabel
    Left = 492
    Top = 315
    Width = 80
    Height = 21
    Caption = 'Kilos Brutos'
    About = 'NB 0.1/20020725'
  end
  object lblKilosNetos: TLabel
    Left = 657
    Top = 296
    Width = 80
    Height = 13
    AutoSize = False
    Caption = 'lblKilosNetos'
  end
  object lblKilosBrutos: TLabel
    Left = 657
    Top = 319
    Width = 80
    Height = 13
    AutoSize = False
    Caption = 'lblKilosBrutos'
  end
  object lbl1: TnbLabel
    Left = 40
    Top = 109
    Width = 113
    Height = 21
    Caption = 'Naviera'
    About = 'NB 0.1/20020725'
  end
  object lblNaviera: TLabel
    Left = 160
    Top = 113
    Width = 47
    Height = 13
    Caption = 'lblNaviera'
  end
  object lblPuertoDestino: TnbLabel
    Left = 418
    Top = 109
    Width = 113
    Height = 21
    Caption = 'Puerto Destino'
    About = 'NB 0.1/20020725'
  end
  object btnPuertoDestino: TBGridButton
    Left = 560
    Top = 109
    Width = 13
    Height = 21
    Glyph.Data = {
      C6000000424DC60000000000000076000000280000000A0000000A0000000100
      0400000000005000000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
      0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
      0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
      0000FFFFFFFFFF000000}
    OnClick = btnPuertoDestinoClick
    Control = puerto_destino_dac
    Grid = bgrdRejillaFlotante
    GridAlignment = taDownRight
    GridWidth = 280
    GridHeigth = 200
  end
  object desPuertoDestino: TLabel
    Left = 538
    Top = 113
    Width = 3
    Height = 13
  end
  object nbLabel6: TnbLabel
    Left = 44
    Top = 220
    Width = 34
    Height = 46
    Caption = 'Teus'#13#10'45'
    About = 'NB 0.1/20020725'
  end
  object nbLabel9: TnbLabel
    Left = 418
    Top = 134
    Width = 113
    Height = 21
    Caption = 'Entrada LAME'
    About = 'NB 0.1/20020725'
  end
  object naviera_dac: TBDEdit
    Left = 160
    Top = 108
    Width = 201
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 30
    TabOrder = 7
    DataField = 'naviera_dac'
    DataSource = DSDatosAduana
  end
  object btnGuardar: TButton
    Left = 547
    Top = 30
    Width = 95
    Height = 25
    Caption = 'Guardar (F1)'
    TabOrder = 2
    TabStop = False
    OnClick = btnGuardarClick
  end
  object btnSalir: TButton
    Left = 648
    Top = 29
    Width = 95
    Height = 25
    Caption = 'Salir (Esc)'
    TabOrder = 3
    TabStop = False
    OnClick = btnSalirClick
  end
  object dvd_dac: TnbDBAlfa
    Left = 160
    Top = 134
    Width = 140
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 10
    DataField = 'dvd_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumChars = 20
  end
  object embarque_dac: TnbDBAlfa
    Left = 160
    Top = 158
    Width = 201
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 13
    DataField = 'embarque_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumChars = 50
  end
  object dua_exporta_dac: TnbDBAlfa
    Left = 160
    Top = 182
    Width = 140
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 14
    DataField = 'dua_exporta_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumChars = 18
  end
  object flete_dac: TnbDBNumeric
    Left = 163
    Top = 268
    Width = 80
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 19
    DataField = 'flete_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 10
    NumDecimals = 2
  end
  object factura_dac: TnbDBAlfa
    Left = 326
    Top = 221
    Width = 162
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 15
    DataField = 'factura_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumChars = 15
  end
  object rappel_dac: TnbDBNumeric
    Left = 245
    Top = 268
    Width = 80
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 20
    DataField = 'rappel_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 10
    NumDecimals = 2
  end
  object manipulacion_dac: TnbDBNumeric
    Left = 327
    Top = 268
    Width = 80
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 21
    DataField = 'manipulacion_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 10
    NumDecimals = 2
  end
  object btnBorrar: TButton
    Left = 456
    Top = 29
    Width = 95
    Height = 25
    Caption = 'Borrar (Mayus+B)'
    TabOrder = 1
    TabStop = False
    OnClick = btnBorrarClick
  end
  object btnImprimirFicha: TButton
    Left = 40
    Top = 29
    Width = 95
    Height = 25
    Caption = 'Imprimir (Mayus+I)'
    TabOrder = 0
    TabStop = False
    OnClick = btnImprimirFichaClick
  end
  object mercancia_dac: TnbDBNumeric
    Left = 410
    Top = 268
    Width = 80
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 22
    DataField = 'mercancia_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 10
    NumDecimals = 2
  end
  object combustible_dac: TnbDBNumeric
    Left = 492
    Top = 268
    Width = 80
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 23
    DataField = 'combustible_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 10
    NumDecimals = 2
  end
  object seguridad_dac: TnbDBNumeric
    Left = 575
    Top = 268
    Width = 80
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 24
    DataField = 'seguridad_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 10
    NumDecimals = 2
  end
  object frigorifico_dac: TnbDBNumeric
    Left = 657
    Top = 268
    Width = 80
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 25
    DataField = 'frigorifico_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 10
    NumDecimals = 2
  end
  object teus40_dac: TnbDBNumeric
    Left = 81
    Top = 268
    Width = 33
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = teus40_dacChange
    TabOrder = 17
    DataField = 'teus40_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 1
  end
  object metros_lineales_dac: TnbDBNumeric
    Left = 117
    Top = 268
    Width = 44
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = metros_lineales_dacChange
    TabOrder = 18
    DataField = 'metros_lineales_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 5
    NumDecimals = 2
  end
  object puerto_salida_dac: TBDEdit
    Tag = 1
    Left = 538
    Top = 61
    Width = 22
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itInteger
    MaxLength = 2
    TabOrder = 4
    OnChange = puerto_salida_dacChange
    DataField = 'puerto_salida_dac'
    DataSource = DSDatosAduana
  end
  object stpuerto_salida_dac: TStaticText
    Left = 576
    Top = 63
    Width = 166
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 5
  end
  object bgrdRejillaFlotante: TBGrid
    Left = 752
    Top = 61
    Width = 41
    Height = 57
    Color = clInfoBk
    DataSource = DMBaseDatos.DSQDespegables
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object kilos_netos_dac: TnbDBNumeric
    Left = 575
    Top = 292
    Width = 80
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 26
    DataField = 'kilos_netos_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 10
    NumDecimals = 2
  end
  object kilos_brutos_dac: TnbDBNumeric
    Left = 575
    Top = 315
    Width = 80
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 27
    DataField = 'kilos_brutos_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 10
    NumDecimals = 2
  end
  object puerto_destino_dac: TBDEdit
    Tag = 1
    Left = 538
    Top = 109
    Width = 22
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itInteger
    MaxLength = 2
    TabOrder = 8
    OnChange = puerto_destino_dacChange
    DataField = 'puerto_destino_dac'
    DataSource = DSDatosAduana
  end
  object txtPuertoDestino: TStaticText
    Left = 576
    Top = 111
    Width = 166
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 9
  end
  object teus45_dac: TnbDBNumeric
    Left = 45
    Top = 268
    Width = 33
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = teus45_dacChange
    TabOrder = 16
    DataField = 'teus45_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 1
  end
  object cont_lame_dac: TBDEdit
    Left = 537
    Top = 134
    Width = 60
    Height = 21
    TabStop = False
    ColorEdit = clSilver
    ColorNormal = clSilver
    InputType = itInteger
    ReadOnly = True
    MaxLength = 30
    TabOrder = 28
    DataField = 'cont_lame_dac'
    DataSource = DSDatosAduana
  end
  object btnAsignarLame: TcxButton
    Left = 601
    Top = 134
    Width = 70
    Height = 21
    Hint = 'Asignar contador LAME'
    Caption = 'Asignar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = btnAsignarLameClick
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Blueprint'
  end
  object btnCancelarLame: TcxButton
    Left = 673
    Top = 134
    Width = 70
    Height = 21
    Hint = 'Cancelar asignaci'#243'n contador LAME'
    Caption = 'Cancelar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    OnClick = btnCancelarLameClick
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Blueprint'
  end
  object DSDatosAduana: TDataSource
    DataSet = DDTransitosAduana.QDatosAduana
    Left = 294
    Top = 121
  end
end
