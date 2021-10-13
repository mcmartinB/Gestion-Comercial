object FDTransitosAduana: TFDTransitosAduana
  Left = 453
  Top = 176
  Width = 741
  Height = 647
  ActiveControl = dvd_fa
  Caption = '    DEPOSITO ADUANA'
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
    Left = 365
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
    Top = 122
    Width = 113
    Height = 21
    Caption = 'DVD'
    About = 'NB 0.1/20020725'
  end
  object nbLabel6: TnbLabel
    Left = 365
    Top = 122
    Width = 113
    Height = 21
    Caption = 'Fecha Entrada DDA'
    About = 'NB 0.1/20020725'
  end
  object nbLabel7: TnbLabel
    Left = 40
    Top = 146
    Width = 113
    Height = 21
    Caption = 'Conocim. Embarque'
    About = 'NB 0.1/20020725'
  end
  object nbLabel8: TnbLabel
    Left = 365
    Top = 146
    Width = 113
    Height = 21
    Caption = 'DUA Exportaci'#243'n'
    About = 'NB 0.1/20020725'
  end
  object Concepto: TnbLabel
    Left = 204
    Top = 178
    Width = 80
    Height = 21
    Caption = 'Concepto'
    About = 'NB 0.1/20020725'
  end
  object nbLabel21: TnbLabel
    Left = 122
    Top = 178
    Width = 80
    Height = 21
    Caption = 'GASTOS'
    About = 'NB 0.1/20020725'
  end
  object nbLabel10: TnbLabel
    Left = 286
    Top = 202
    Width = 80
    Height = 21
    Caption = 'THC Manipulaci'#243'n'
    About = 'NB 0.1/20020725'
  end
  object nbLabel11: TnbLabel
    Left = 204
    Top = 202
    Width = 80
    Height = 21
    Caption = 'Dto. Rappel'
    About = 'NB 0.1/20020725'
  end
  object lblFlete: TnbLabel
    Left = 122
    Top = 202
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
    Left = 485
    Top = 89
    Width = 40
    Height = 13
    Caption = 'lblFecha'
  end
  object nbLabel9: TnbLabel
    Left = 565
    Top = 263
    Width = 150
    Height = 21
    Caption = 'DETALLE'
    About = 'NB 0.1/20020725'
  end
  object nbLabel13: TnbLabel
    Left = 565
    Top = 392
    Width = 150
    Height = 21
    Caption = 'SALIDAS'
    About = 'NB 0.1/20020725'
  end
  object nbLabel14: TnbLabel
    Left = 451
    Top = 178
    Width = 163
    Height = 21
    Caption = 'KILOS TR'#193'NSITO'
    About = 'NB 0.1/20020725'
  end
  object lblKilosTransito: TLabel
    Left = 616
    Top = 182
    Width = 80
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'lblKilosTransito'
  end
  object nbLabel15: TnbLabel
    Left = 369
    Top = 202
    Width = 80
    Height = 21
    Caption = 'T3 Mercanc'#237'a'
    About = 'NB 0.1/20020725'
  end
  object nbLabel16: TnbLabel
    Left = 451
    Top = 202
    Width = 80
    Height = 21
    Caption = 'BAF Combustible'
    About = 'NB 0.1/20020725'
  end
  object nbLabel17: TnbLabel
    Left = 534
    Top = 202
    Width = 80
    Height = 21
    Caption = 'Tasas Seguridad'
    About = 'NB 0.1/20020725'
  end
  object nbLabel18: TnbLabel
    Left = 616
    Top = 202
    Width = 80
    Height = 21
    Caption = 'Plataforma Frigo.'
    About = 'NB 0.1/20020725'
  end
  object lblFaltaConsumo: TLabel
    Left = 569
    Top = 365
    Width = 146
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
  end
  object lblFaltaAlbaranesTotal: TLabel
    Left = 565
    Top = 497
    Width = 150
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
  end
  object lblFaltaAlbaranesSalida: TLabel
    Left = 565
    Top = 520
    Width = 150
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
  end
  object lblCodigo1: TnbLabel
    Left = 40
    Top = 178
    Width = 33
    Height = 46
    Caption = 'Teus'#13#10'40'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo2: TnbLabel
    Left = 76
    Top = 178
    Width = 44
    Height = 46
    Caption = 'Metros'#13#10'Lineales'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo3: TnbLabel
    Left = 365
    Top = 61
    Width = 113
    Height = 21
    Caption = 'Puerto Salida'
    About = 'NB 0.1/20020725'
  end
  object btnpuerto_salida_dac: TBGridButton
    Left = 507
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
  object btnGuardar: TButton
    Left = 499
    Top = 29
    Width = 95
    Height = 25
    Caption = 'Guardar (F1)'
    TabOrder = 4
    TabStop = False
    OnClick = btnGuardarClick
  end
  object btnSalir: TButton
    Left = 595
    Top = 29
    Width = 95
    Height = 25
    Caption = 'Salir (Esc)'
    TabOrder = 5
    TabStop = False
    OnClick = btnSalirClick
  end
  object dvd_fa: TnbDBAlfa
    Left = 160
    Top = 122
    Width = 140
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 8
    DataField = 'dvd_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumChars = 20
  end
  object fecha_entrada_dda_dac: TnbDBCalendarCombo
    Left = 485
    Top = 122
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 9
    DataField = 'fecha_entrada_dda_dac'
    DataSource = DSDatosAduana
    DBLink = True
  end
  object embarque_dac: TnbDBAlfa
    Left = 160
    Top = 146
    Width = 140
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 10
    DataField = 'embarque_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumChars = 20
  end
  object dua_exporta_dac: TnbDBAlfa
    Left = 485
    Top = 146
    Width = 140
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 11
    DataField = 'dua_exporta_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumChars = 20
  end
  object flete_dac: TnbDBNumeric
    Left = 122
    Top = 226
    Width = 80
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 15
    DataField = 'flete_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 10
    NumDecimals = 2
  end
  object factura_dac: TnbDBAlfa
    Left = 285
    Top = 179
    Width = 162
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 12
    DataField = 'factura_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumChars = 15
  end
  object rappel_dac: TnbDBNumeric
    Left = 204
    Top = 226
    Width = 80
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 16
    DataField = 'rappel_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 10
    NumDecimals = 2
  end
  object manipulacion_dac: TnbDBNumeric
    Left = 286
    Top = 226
    Width = 80
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 17
    DataField = 'manipulacion_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 10
    NumDecimals = 2
  end
  object btnBorrar: TButton
    Left = 403
    Top = 29
    Width = 95
    Height = 25
    Caption = 'Borrar (Mayus+B)'
    TabOrder = 3
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
  object DBGDetalle: TDBGrid
    Left = 16
    Top = 263
    Width = 540
    Height = 120
    TabStop = False
    DataSource = DSDetalle
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 22
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = DBGDetalleCellClick
    OnDrawColumnCell = DBGDetalleDrawColumnCell
    OnDblClick = DBGDetalleDblClick
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'centro_destino_dal'
        Title.Alignment = taCenter
        Title.Caption = 'Centro'
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'cliente_dal'
        Title.Alignment = taCenter
        Title.Caption = 'Cliente'
        Width = 67
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'dir_sum_dal'
        Title.Alignment = taCenter
        Title.Caption = 'Suministro'
        Width = 67
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'fecha_dal'
        Title.Alignment = taCenter
        Title.Caption = 'Fecha'
        Width = 67
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'kilos_dal'
        Title.Alignment = taCenter
        Title.Caption = 'Kilos'
        Width = 67
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'dua_consumo_dal'
        Title.Alignment = taCenter
        Title.Caption = 'DUA Consumo'
        Width = 179
        Visible = True
      end>
  end
  object DBGSalidas: TDBGrid
    Left = 16
    Top = 391
    Width = 540
    Height = 211
    TabStop = False
    DataSource = DSSalidas
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 27
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = DBGSalidasDrawColumnCell
    OnDblClick = DBGSalidasDblClick
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'centro_salida_das'
        Title.Alignment = taCenter
        Title.Caption = 'Centro'
        Width = 50
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'n_albaran_das'
        Title.Alignment = taCenter
        Title.Caption = 'N'#186' Albar'#225'n'
        Width = 69
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'fecha_das'
        Title.Alignment = taCenter
        Title.Caption = 'Fecha'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'n_pedido_das'
        Title.Alignment = taCenter
        Title.Caption = 'Pedido'
        Width = 82
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'kilos_das'
        Title.Alignment = taCenter
        Title.Caption = 'Kilos'
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'frigorifico_das'
        Title.Alignment = taCenter
        Title.Caption = 'Coste Frigo.'
        Width = 67
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'n_factura_das'
        Title.Alignment = taCenter
        Title.Caption = 'Factura'
        Width = 73
        Visible = True
      end>
  end
  object btnAltaDetalle: TButton
    Left = 565
    Top = 283
    Width = 150
    Height = 25
    Caption = 'A'#241'adir (Ctr+A)'
    Enabled = False
    TabOrder = 23
    TabStop = False
    OnClick = btnAltaDetalleClick
  end
  object btnEditarDetalle: TButton
    Left = 565
    Top = 308
    Width = 150
    Height = 25
    Caption = 'Modificar (Ctr+M)'
    Enabled = False
    TabOrder = 24
    TabStop = False
    OnClick = btnEditarDetalleClick
  end
  object btnBorrarDetalle: TButton
    Left = 565
    Top = 333
    Width = 150
    Height = 25
    Caption = 'Borrar (Ctr+B)'
    Enabled = False
    TabOrder = 25
    TabStop = False
    OnClick = btnBorrarDetalleClick
  end
  object btnAltaSalida: TButton
    Left = 565
    Top = 413
    Width = 150
    Height = 25
    Caption = 'A'#241'adir (Alt+A)'
    Enabled = False
    TabOrder = 28
    TabStop = False
    OnClick = btnAltaSalidaClick
  end
  object btnEditarSalida: TButton
    Left = 565
    Top = 438
    Width = 150
    Height = 25
    Caption = 'Modificar (Alt+M)'
    Enabled = False
    TabOrder = 29
    TabStop = False
    OnClick = btnEditarSalidaClick
  end
  object btnBorrarSalida: TButton
    Left = 565
    Top = 464
    Width = 150
    Height = 25
    Caption = 'Borrar (Alt+B)'
    Enabled = False
    TabOrder = 30
    TabStop = False
    OnClick = btnBorrarSalidaClick
  end
  object mercancia_dac: TnbDBNumeric
    Left = 369
    Top = 226
    Width = 80
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 18
    DataField = 'mercancia_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 10
    NumDecimals = 2
  end
  object combustible_dac: TnbDBNumeric
    Left = 451
    Top = 226
    Width = 80
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 19
    DataField = 'combustible_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 10
    NumDecimals = 2
  end
  object seguridad_dac: TnbDBNumeric
    Left = 534
    Top = 226
    Width = 80
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 20
    DataField = 'seguridad_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 10
    NumDecimals = 2
  end
  object frigorifico_dac: TnbDBNumeric
    Left = 616
    Top = 226
    Width = 80
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 21
    DataField = 'frigorifico_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 10
    NumDecimals = 2
  end
  object dbedtkilos_dal: TDBEdit
    Left = 569
    Top = 360
    Width = 33
    Height = 21
    DataField = 'kilos_dal'
    DataSource = DSKilosDetalle
    TabOrder = 26
    Visible = False
    OnChange = dbedtkilos_dalChange
  end
  object dbedt1: TDBEdit
    Left = 569
    Top = 496
    Width = 33
    Height = 21
    DataField = 'kilos_das'
    DataSource = DSKilosSalidas
    TabOrder = 31
    Visible = False
    OnChange = dbedt1Change
  end
  object eKilosSalidasDetalle: TDBEdit
    Left = 577
    Top = 519
    Width = 33
    Height = 21
    DataField = 'linea_dal'
    DataSource = DSDetalle
    TabOrder = 32
    Visible = False
  end
  object btnFactura: TButton
    Left = 136
    Top = 29
    Width = 95
    Height = 25
    Caption = 'Factura (Mayus+F)'
    TabOrder = 1
    TabStop = False
    OnClick = btnFacturaClick
  end
  object btnPrecios: TButton
    Left = 232
    Top = 29
    Width = 95
    Height = 25
    Caption = 'Importes Factura'
    TabOrder = 2
    TabStop = False
    OnClick = btnPreciosClick
  end
  object teus40_dac: TnbDBNumeric
    Left = 40
    Top = 226
    Width = 33
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = teus40_dacChange
    TabOrder = 13
    DataField = 'teus40_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 1
  end
  object metros_lineales_dac: TnbDBNumeric
    Left = 76
    Top = 226
    Width = 44
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = metros_lineales_dacChange
    TabOrder = 14
    DataField = 'metros_lineales_dac'
    DataSource = DSDatosAduana
    DBLink = True
    NumIntegers = 5
    NumDecimals = 2
  end
  object puerto_salida_dac: TBDEdit
    Tag = 1
    Left = 485
    Top = 61
    Width = 22
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itInteger
    MaxLength = 2
    TabOrder = 6
    OnChange = puerto_salida_dacChange
    DataField = 'puerto_salida_dac'
    DataSource = DSDatosAduana
  end
  object stpuerto_salida_dac: TStaticText
    Left = 523
    Top = 63
    Width = 166
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 7
  end
  object bgrdRejillaFlotante: TBGrid
    Left = 668
    Top = 82
    Width = 41
    Height = 57
    Color = clInfoBk
    DataSource = DMBaseDatos.DSQDespegables
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 33
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object DSDatosAduana: TDataSource
    DataSet = DDTransitosAduana.QDatosAduana
    Left = 294
    Top = 109
  end
  object DSDetalle: TDataSource
    DataSet = DDTransitosAduana.QDatosAduanaDetalle
    Left = 24
    Top = 279
  end
  object DSSalidas: TDataSource
    DataSet = DDTransitosAduana.QDatosAduanaSalidas
    Left = 24
    Top = 447
  end
  object DSKilosDetalle: TDataSource
    DataSet = DDTransitosAduana.QKilosDetalle
    Left = 609
    Top = 351
  end
  object DSKilosSalidas: TDataSource
    DataSet = DDTransitosAduana.QKilosSalidas
    Left = 609
    Top = 479
  end
end
