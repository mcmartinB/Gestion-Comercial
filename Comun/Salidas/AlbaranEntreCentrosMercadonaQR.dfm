object QRAlbaranEntreCentrosMercadona: TQRAlbaranEntreCentrosMercadona
  Tag = 1
  Left = 0
  Top = 0
  Width = 794
  Height = 1123
  Frame.Color = clBlack
  Frame.DrawTop = False
  Frame.DrawBottom = False
  Frame.DrawLeft = False
  Frame.DrawRight = False
  BackImageControl = 'QRImageCab'
  BeforePrint = QuickReport1BeforePrint
  DataSet = DMBaseDatos.QListado
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  Functions.Strings = (
    'PAGENUMBER'
    'COLUMNNUMBER'
    'REPORTTITLE')
  Functions.DATA = (
    '0'
    '0'
    #39#39)
  Options = [FirstPageHeader, LastPageFooter]
  Page.Columns = 1
  Page.Orientation = poPortrait
  Page.PaperSize = A4
  Page.Values = (
    100.000000000000000000
    2970.000000000000000000
    100.000000000000000000
    2100.000000000000000000
    120.000000000000000000
    80.000000000000000000
    0.000000000000000000)
  PrinterSettings.Copies = 1
  PrinterSettings.OutputBin = Auto
  PrinterSettings.Duplex = False
  PrinterSettings.FirstPage = 0
  PrinterSettings.LastPage = 0
  PrinterSettings.UseStandardprinter = False
  PrinterSettings.UseCustomBinCode = False
  PrinterSettings.CustomBinCode = 0
  PrinterSettings.ExtendedDuplex = 0
  PrinterSettings.UseCustomPaperCode = False
  PrinterSettings.CustomPaperCode = 0
  PrinterSettings.PrintMetaFile = False
  PrinterSettings.PrintQuality = 0
  PrinterSettings.Collate = 0
  PrinterSettings.ColorOption = 0
  PrintIfEmpty = True
  ReportTitle = 'Albaran_de_Salida'
  SnapToGrid = True
  Units = MM
  Zoom = 100
  PrevFormStyle = fsNormal
  PreviewInitialState = wsNormal
  PrevInitialZoom = qrZoomToFit
  object BonnyBand: TQRBand
    Left = 45
    Top = 38
    Width = 718
    Height = 83
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = clWhite
    TransparentBand = True
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      219.604166666666700000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbPageHeader
    object QRImageCab: TQRImage
      Left = 1
      Top = 1
      Width = 30
      Height = 30
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        79.375000000000000000
        2.645833333333330000
        2.645833333333330000
        79.375000000000000000)
      Stretch = True
    end
    object PsEmpresa: TQRLabel
      Left = 38
      Top = 1
      Width = 170
      Height = 47
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        124.354166666666700000
        100.541666666666700000
        2.645833333333333000
        449.791666666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Empresa'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 30
    end
    object PsDireccion: TQRLabel
      Left = 666
      Top = 52
      Width = 52
      Height = 15
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        39.687500000000000000
        1762.125000000000000000
        137.583333333333300000
        137.583333333333300000)
      Alignment = taRightJustify
      AlignToBand = True
      AutoSize = True
      AutoStretch = False
      Caption = 'Direccion'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object PsNif: TQRLabel
      Left = 38
      Top = 47
      Width = 22
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        100.541666666666700000
        124.354166666666700000
        58.208333333333330000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Nif'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 12
    end
    object qrimgLogoBargosa: TQRImage
      Left = 37
      Top = 1
      Width = 250
      Height = 64
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        169.333333333333000000
        97.895833333333300000
        2.645833333333330000
        661.458333333333000000)
      Stretch = True
    end
  end
  object BandaDatos: TQRBand
    Left = 45
    Top = 363
    Width = 718
    Height = 18
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = True
    Frame.DrawRight = True
    AlignToBottom = False
    BeforePrint = BandaDatosBeforePrint
    Color = clWhite
    TransparentBand = True
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      47.625000000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbDetail
    object producto: TQRDBText
      Left = 2
      Top = 1
      Width = 130
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        5.291666666666670000
        2.645833333333330000
        343.958333333333000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = DMBaseDatos.QListado
      DataField = 'descripcion_p'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object marca: TQRDBText
      Left = 329
      Top = 1
      Width = 59
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        870.479166666667000000
        2.645833333333330000
        156.104166666667000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = DMBaseDatos.QListado
      DataField = 'descripcion_m'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = False
      FontSize = 8
    end
    object color: TQRDBText
      Left = 395
      Top = 1
      Width = 25
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1045.104166666670000000
        2.645833333333330000
        66.145833333333300000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = DMBaseDatos.QListado
      DataField = 'color_sl'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = False
      FontSize = 8
    end
    object PsQRDBText28: TQRDBText
      Left = 426
      Top = 1
      Width = 45
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1127.125000000000000000
        2.645833333333330000
        119.062500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = DMBaseDatos.QListado
      DataField = 'calibre_sl'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object cajas: TQRLabel
      Left = 476
      Top = 1
      Width = 37
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1259.416666666670000000
        2.645833333333330000
        97.895833333333300000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'cajas'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      OnPrint = cajasPrint
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object psKilos: TQRDBText
      Left = 523
      Top = 1
      Width = 51
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1383.770833333330000000
        2.645833333333330000
        134.937500000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = DMBaseDatos.QListado
      DataField = 'kilos_sl'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Mask = '#,##0.00'
      OnPrint = psKilosPrint
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object PrecioUnidad: TQRDBText
      Left = 588
      Top = 1
      Width = 38
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1555.750000000000000000
        2.645833333333330000
        100.541666666667000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = DMBaseDatos.QListado
      DataField = 'precio_sl'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Mask = '#,##0.000'
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object LPor: TQRLabel
      Left = 627
      Top = 4
      Width = 6
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1658.937500000000000000
        10.583333333333330000
        15.875000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = '*'
      Color = clWhite
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object UnidadCobro: TQRDBText
      Left = 632
      Top = 3
      Width = 9
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1672.166666666670000000
        7.937500000000000000
        23.812500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = DMBaseDatos.QListado
      DataField = 'unidad_precio_sl'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = []
      OnPrint = UnidadCobroPrint
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 6
    end
    object precioNeto: TQRDBText
      Left = 645
      Top = 1
      Width = 69
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1706.562500000000000000
        2.645833333333330000
        182.562500000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = DMBaseDatos.QListado
      DataField = 'importe_neto_sl'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Mask = '#,##0.00'
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object lin1: TQRShape
      Left = 134
      Top = 0
      Width = 3
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333300000
        354.541666666667000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lin2: TQRShape
      Left = 325
      Top = 0
      Width = 3
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333300000
        859.895833333333000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lin3: TQRShape
      Left = 390
      Top = 0
      Width = 3
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333300000
        1031.875000000000000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lin4: TQRShape
      Left = 422
      Top = 0
      Width = 3
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333300000
        1116.541666666670000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lin5: TQRShape
      Left = 471
      Top = 0
      Width = 3
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333300000
        1246.187500000000000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lin6: TQRShape
      Left = 522
      Top = 0
      Width = 3
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333300000
        1381.125000000000000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lin7: TQRShape
      Left = 582
      Top = 0
      Width = 3
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333300000
        1539.875000000000000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lin8: TQRShape
      Left = 642
      Top = 0
      Width = 3
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333300000
        1698.625000000000000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object descripcion2_e: TQRDBText
      Left = 139
      Top = 1
      Width = 185
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        367.770833333333000000
        2.645833333333330000
        489.479166666667000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = DMBaseDatos.QListado
      DataField = 'envase_e'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      OnPrint = descripcion2_ePrint
      ParentFont = False
      Transparent = True
      WordWrap = False
      FontSize = 8
    end
    object QRDBText1: TQRDBText
      Left = 576
      Top = 3
      Width = 7
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1524.000000000000000000
        7.937500000000000000
        18.520833333333300000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = DMBaseDatos.QListado
      DataField = 'unidad_precio_sl'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = []
      OnPrint = QRDBText1Print
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 6
    end
    object QRDBText2: TQRDBText
      Left = 515
      Top = 3
      Width = 7
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1362.604166666670000000
        7.937500000000000000
        18.520833333333300000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = DMBaseDatos.QListado
      DataField = 'unidad_precio_sl'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = []
      OnPrint = QRDBText2Print
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 6
    end
  end
  object CabeceraTabla: TQRBand
    Left = 45
    Top = 381
    Width = 718
    Height = 86
    Frame.Color = clBlack
    Frame.DrawTop = True
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    BeforePrint = CabeceraTablaBeforePrint
    Color = clWhite
    TransparentBand = True
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      227.541666666666700000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupFooter
    object qrsTotal: TQRShape
      Left = 589
      Top = 53
      Width = 129
      Height = 26
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        68.791666666666700000
        1558.395833333330000000
        140.229166666667000000
        341.312500000000000000)
      Brush.Style = bsClear
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object qrsIva: TQRShape
      Left = 589
      Top = 28
      Width = 129
      Height = 26
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        68.791666666666700000
        1558.395833333330000000
        74.083333333333300000
        341.312500000000000000)
      Brush.Style = bsClear
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object Rneto: TQRShape
      Left = 589
      Top = 5
      Width = 129
      Height = 26
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        68.791666666666700000
        1558.395833333330000000
        13.229166666666700000
        341.312500000000000000)
      Brush.Style = bsClear
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object LPalets: TQRLabel
      Left = 1
      Top = 1
      Width = 40
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        2.645833333333333000
        2.645833333333333000
        105.833333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Palets'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      OnPrint = LPaletsPrint
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object LCajas: TQRLabel
      Left = 215
      Top = 1
      Width = 36
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        568.854166666666700000
        2.645833333333333000
        95.250000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Cajas'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      OnPrint = LCajasPrint
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object Lneto: TQRLabel
      Left = 496
      Top = 8
      Width = 60
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        1312.333333333333000000
        21.166666666666670000
        158.750000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Total Neto'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object MemoCajas: TQRMemo
      Left = 215
      Top = 22
      Width = 271
      Height = 64
      Frame.Color = clBlue
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        169.333333333333000000
        568.854166666667000000
        58.208333333333300000
        717.020833333333000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = True
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 7
    end
    object MemoPalets: TQRMemo
      Left = 1
      Top = 22
      Width = 207
      Height = 64
      Frame.Color = 15395562
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        169.333333333333000000
        2.645833333333330000
        58.208333333333300000
        547.687500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = True
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 7
    end
    object moneda3: TQRLabel
      Left = 590
      Top = 19
      Width = 20
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1561.041666666667000000
        50.270833333333330000
        52.916666666666670000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'EUR'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 7
    end
    object cantNeta: TQRExpr
      Left = 579
      Top = 8
      Width = 131
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1531.937500000000000000
        21.166666666666670000
        346.604166666666700000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Color = clWhite
      Master = Owner
      ParentFont = False
      ResetAfterPrint = False
      Transparent = True
      WordWrap = True
      Expression = 'Sum([importe_neto_sl])'
      Mask = '#,##0.00'
      FontSize = 9
    end
    object qrlLblIva: TQRLabel
      Left = 496
      Top = 31
      Width = 22
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        1312.333333333333000000
        82.020833333333330000
        58.208333333333330000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'IVA'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      OnPrint = qrlLblIvaPrint
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrlMonedaIva: TQRLabel
      Left = 590
      Top = 42
      Width = 20
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1561.041666666667000000
        111.125000000000000000
        52.916666666666670000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'EUR'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 7
    end
    object qrxIva: TQRExpr
      Left = 637
      Top = 32
      Width = 73
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1685.395833333333000000
        84.666666666666670000
        193.145833333333300000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Color = clWhite
      Master = Owner
      ParentFont = False
      ResetAfterPrint = False
      Transparent = True
      WordWrap = True
      Expression = 'Sum([iva_sl])'
      Mask = '#,##0.00'
      FontSize = 9
    end
    object qrlLblTotal: TQRLabel
      Left = 496
      Top = 56
      Width = 29
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        1312.333333333333000000
        148.166666666666700000
        76.729166666666670000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Total'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrlMonedaTotal: TQRLabel
      Left = 590
      Top = 67
      Width = 20
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1561.041666666667000000
        177.270833333333300000
        52.916666666666670000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'EUR'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 7
    end
    object qrxTotal: TQRExpr
      Left = 580
      Top = 56
      Width = 130
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1534.583333333333000000
        148.166666666666700000
        343.958333333333300000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Color = clWhite
      Master = Owner
      ParentFont = False
      ResetAfterPrint = False
      Transparent = True
      WordWrap = True
      Expression = 'Sum([importe_total_sl])'
      Mask = '#,##0.00'
      FontSize = 9
    end
  end
  object QRBand1: TQRBand
    Left = 45
    Top = 216
    Width = 718
    Height = 122
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = clWhite
    TransparentBand = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ForceNewColumn = False
    ForceNewPage = False
    ParentFont = False
    Size.Values = (
      322.791666666666700000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbColumnHeader
    object LTransporte: TQRLabel
      Left = 6
      Top = 76
      Width = 423
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        15.875000000000000000
        201.083333333333300000
        1119.187500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'LTransporte'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object LVehiculo: TQRLabel
      Left = 437
      Top = 82
      Width = 275
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1156.229166666667000000
        216.958333333333300000
        727.604166666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'LVehiculo'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 9
    end
    object LPedido: TQRLabel
      Left = 596
      Top = 28
      Width = 119
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1576.916666666667000000
        74.083333333333330000
        314.854166666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'LPedido'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object LHoraCarga: TQRLabel
      Left = 436
      Top = 28
      Width = 67
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1153.583333333333000000
        74.083333333333330000
        177.270833333333300000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'LHoraCarga'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object LFecha: TQRLabel
      Left = 327
      Top = 28
      Width = 98
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        865.187500000000000000
        74.083333333333330000
        259.291666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'LFecha'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object LCentro: TQRLabel
      Left = 101
      Top = 28
      Width = 213
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        267.229166666666700000
        74.083333333333330000
        563.562500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'LCentro'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrlNAlbaran: TQRLabel
      Left = 4
      Top = 28
      Width = 73
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        10.583333333333330000
        74.083333333333330000
        193.145833333333300000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'qrlNAlbaran'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object PsQRShape18: TQRShape
      Left = 1
      Top = 105
      Width = 717
      Height = 5
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        13.229166666666670000
        2.645833333333333000
        277.812500000000000000
        1897.062500000000000000)
      Brush.Style = bsClear
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object PsQRShape16: TQRShape
      Left = 1
      Top = 0
      Width = 716
      Height = 25
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        66.145833333333330000
        2.645833333333333000
        0.000000000000000000
        1894.416666666667000000)
      Brush.Color = 15395562
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object PsQRShape17: TQRShape
      Left = 1
      Top = 50
      Width = 716
      Height = 25
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        66.145833333333330000
        2.645833333333333000
        132.291666666666700000
        1894.416666666667000000)
      Brush.Color = 15395562
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object PsQRLabel6: TQRLabel
      Left = 8
      Top = 3
      Width = 82
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        21.166666666666670000
        7.937500000000000000
        216.958333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'N'#186' Albar'#225'n'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 12
    end
    object PsQRLabel7: TQRLabel
      Left = 101
      Top = 3
      Width = 213
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        267.229166666666700000
        7.937500000000000000
        563.562500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Centro'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 12
    end
    object PsQRLabel8: TQRLabel
      Left = 327
      Top = 3
      Width = 98
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        865.187500000000000000
        7.937500000000000000
        259.291666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Fecha Carga'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 12
    end
    object PsQRLabel9: TQRLabel
      Left = 436
      Top = 3
      Width = 67
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        1153.583333333333000000
        7.937500000000000000
        177.270833333333300000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Hora'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 12
    end
    object PsQRLabel10: TQRLabel
      Left = 617
      Top = 3
      Width = 77
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        1632.479166666667000000
        7.937500000000000000
        203.729166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'N'#186' Pedido'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 12
    end
    object PsQRLabel11: TQRLabel
      Left = 6
      Top = 53
      Width = 423
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        15.875000000000000000
        140.229166666666700000
        1119.187500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Transporte'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 12
    end
    object PsQRLabel12: TQRLabel
      Left = 437
      Top = 53
      Width = 275
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        1156.229166666667000000
        140.229166666666700000
        727.604166666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Veh'#237'culo'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 12
    end
    object PsQRShape20: TQRShape
      Left = 0
      Top = 25
      Width = 3
      Height = 25
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        66.145833333333330000
        0.000000000000000000
        66.145833333333330000
        7.937500000000000000)
      Brush.Style = bsClear
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object PsQRShape23: TQRShape
      Left = 94
      Top = 0
      Width = 3
      Height = 50
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        132.291666666666700000
        248.708333333333300000
        0.000000000000000000
        7.937500000000000000)
      Brush.Style = bsClear
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object PsQRShape24: TQRShape
      Left = 321
      Top = 0
      Width = 3
      Height = 50
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        132.291666666666700000
        849.312500000000000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Style = bsClear
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object PsQRShape25: TQRShape
      Left = 429
      Top = 0
      Width = 3
      Height = 50
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        132.291666666666700000
        1135.062500000000000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Style = bsClear
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object PsQRShape26: TQRShape
      Left = 591
      Top = 0
      Width = 3
      Height = 50
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        132.291666666666700000
        1563.687500000000000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Style = bsClear
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object PsQRShape22: TQRShape
      Left = 715
      Top = 25
      Width = 3
      Height = 25
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        66.145833333333330000
        1891.770833333333000000
        66.145833333333330000
        7.937500000000000000)
      Brush.Style = bsClear
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object PsQRShape21: TQRShape
      Left = 715
      Top = 75
      Width = 3
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        1891.770833333333000000
        198.437500000000000000
        7.937500000000000000)
      Brush.Style = bsClear
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object PsQRShape27: TQRShape
      Left = 429
      Top = 51
      Width = 3
      Height = 56
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        148.166666666666700000
        1135.062500000000000000
        134.937500000000000000
        7.937500000000000000)
      Brush.Style = bsClear
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object PsQRShape19: TQRShape
      Left = 0
      Top = 75
      Width = 3
      Height = 33
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        87.312500000000000000
        0.000000000000000000
        198.437500000000000000
        7.937500000000000000)
      Brush.Style = bsClear
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object LTransporteDir1: TQRLabel
      Left = 6
      Top = 91
      Width = 424
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        15.875000000000000000
        240.770833333333300000
        1121.833333333333000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'LTransporteDir1'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object qrlNAlbaran2: TQRLabel
      Left = 78
      Top = 27
      Width = 9
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        206.375000000000000000
        71.437500000000000000
        23.812500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'LAlbaran'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrlbl1: TQRLabel
      Left = 512
      Top = 3
      Width = 74
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        1354.666666666667000000
        7.937500000000000000
        195.791666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Descarga'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 12
    end
    object qrshp1: TQRShape
      Left = 506
      Top = 0
      Width = 3
      Height = 50
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        132.291666666666700000
        1338.791666666667000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Style = bsClear
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object LDescarga: TQRLabel
      Left = 512
      Top = 28
      Width = 74
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1354.666666666667000000
        74.083333333333330000
        195.791666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'LDescarga'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
  end
  object QRGroup1: TQRGroup
    Left = 45
    Top = 338
    Width = 718
    Height = 25
    Frame.Color = clBlack
    Frame.DrawTop = True
    Frame.DrawBottom = False
    Frame.DrawLeft = True
    Frame.DrawRight = True
    AlignToBottom = False
    Color = 15395562
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      66.145833333333330000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Expression = '[n_albaran_sc]'
    FooterBand = CabeceraTabla
    Master = Owner
    ReprintOnNewPage = True
    object PsQRLabel22: TQRLabel
      Left = 37
      Top = 3
      Width = 51
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        97.895833333333330000
        7.937500000000000000
        134.937500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Producto'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object PsQRLabel23: TQRLabel
      Left = 208
      Top = 3
      Width = 44
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        550.333333333333300000
        7.937500000000000000
        116.416666666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Art'#237'culo'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object PsQRLabel24: TQRLabel
      Left = 343
      Top = 3
      Width = 34
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        907.520833333333300000
        7.937500000000000000
        89.958333333333330000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Marca'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object PsQRLabel25: TQRLabel
      Left = 392
      Top = 3
      Width = 31
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        1037.166666666667000000
        7.937500000000000000
        82.020833333333330000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Color'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object PsQRLabel26: TQRLabel
      Left = 429
      Top = 3
      Width = 40
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        1135.062500000000000000
        7.937500000000000000
        105.833333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Calibre'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object PsQRLabel27: TQRLabel
      Left = 475
      Top = 2
      Width = 46
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666700000
        1256.770833333330000000
        5.291666666666670000
        121.708333333333000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Caja/'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      OnPrint = PsQRLabel27Print
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object PsQRLabel28: TQRLabel
      Left = 524
      Top = 3
      Width = 58
      Height = 22
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        58.208333333333300000
        1386.416666666670000000
        7.937500000000000000
        153.458333333333000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Kgs'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      OnPrint = PsQRLabel28Print
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object PsQRLabel29: TQRLabel
      Left = 585
      Top = 3
      Width = 56
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666700000
        1547.812500000000000000
        7.937500000000000000
        148.166666666667000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Precio'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object PsQRLabel30: TQRLabel
      Left = 656
      Top = 3
      Width = 45
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        1735.666666666667000000
        7.937500000000000000
        119.062500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Importe'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object PsQRShape29: TQRShape
      Left = 134
      Top = 0
      Width = 3
      Height = 26
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        68.791666666666700000
        354.541666666667000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object PsQRShape30: TQRShape
      Left = 325
      Top = 0
      Width = 3
      Height = 26
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        68.791666666666700000
        859.895833333333000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object PsQRShape31: TQRShape
      Left = 390
      Top = 0
      Width = 3
      Height = 26
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        68.791666666666700000
        1031.875000000000000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object PsQRShape32: TQRShape
      Left = 422
      Top = 0
      Width = 3
      Height = 26
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        68.791666666666700000
        1116.541666666670000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object PsQRShape33: TQRShape
      Left = 471
      Top = 0
      Width = 3
      Height = 26
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        68.791666666666700000
        1246.187500000000000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object PsQRShape34: TQRShape
      Left = 522
      Top = 0
      Width = 3
      Height = 26
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        68.791666666666700000
        1381.125000000000000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object PsQRShape35: TQRShape
      Left = 582
      Top = 0
      Width = 3
      Height = 26
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        68.791666666666700000
        1539.875000000000000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object PsQRShape36: TQRShape
      Left = 642
      Top = 0
      Width = 3
      Height = 26
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        68.791666666666700000
        1698.625000000000000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object PsQRLabel18: TQRLabel
      Left = 475
      Top = 12
      Width = 46
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666700000
        1256.770833333330000000
        31.750000000000000000
        121.708333333333000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Unds'
      Color = 15395562
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      OnPrint = PsQRLabel18Print
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
  end
  object ChildBand2: TQRChildBand
    Left = 45
    Top = 467
    Width = 718
    Height = 47
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    BeforePrint = ChildBand2BeforePrint
    Color = clWhite
    TransparentBand = True
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      124.354166666666700000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = CabeceraTabla
    object LObservaciones: TQRLabel
      Left = 1
      Top = 1
      Width = 102
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        2.645833333333333000
        2.645833333333333000
        269.875000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Observaciones :'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object mmoObservaciones: TQRMemo
      Left = 1
      Top = 18
      Width = 710
      Height = 28
      Frame.Color = clBlue
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        74.083333333333300000
        2.645833333333330000
        47.625000000000000000
        1878.541666666670000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = True
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Lines.Strings = (
        'Observaciones'
        '')
      ParentFont = False
      Transparent = False
      WordWrap = False
      FontSize = 8
    end
  end
  object ChildBand1: TQRChildBand
    Left = 45
    Top = 514
    Width = 718
    Height = 31
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    BeforePrint = ChildBand1BeforePrint
    Color = clWhite
    TransparentBand = True
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      82.020833333333330000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = ChildBand2
    object mmoResumen: TQRMemo
      Left = 101
      Top = 2
      Width = 509
      Height = 28
      Frame.Color = clBlue
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        74.083333333333300000
        267.229166666667000000
        5.291666666666670000
        1346.729166666670000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = True
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      Lines.Strings = (
        '  Cajas  Unid.      Kilos      Bruto'
        
          'X XXXXX XXXXXX XXXXXXXXXXX XXXXXXXXXXX XXXXXXXXXX M TOMATE MUCHA' +
          'MIEL')
      ParentFont = False
      Transparent = False
      WordWrap = False
      FontSize = 8
    end
  end
  object QRBand2: TQRBand
    Left = 45
    Top = 121
    Width = 718
    Height = 95
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = clWhite
    TransparentBand = True
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      251.354166666666700000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbTitle
    object qrmDireccion: TQRMemo
      Left = 39
      Top = 0
      Width = 402
      Height = 95
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        251.354166666667000000
        103.187500000000000000
        0.000000000000000000
        1063.625000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = False
      FontSize = 9
    end
  end
  object ChildBand3: TQRChildBand
    Left = 45
    Top = 576
    Width = 718
    Height = 119
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = True
    BeforePrint = ChildBand3BeforePrint
    Color = clWhite
    TransparentBand = True
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      314.854166666666700000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = bndPaletsMercadona
    object PsQRShape9: TQRShape
      Left = 114
      Top = 48
      Width = 300
      Height = 53
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        140.229166666666700000
        301.625000000000000000
        127.000000000000000000
        793.750000000000000000)
      Brush.Style = bsClear
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object PsQRShape10: TQRShape
      Left = 418
      Top = 48
      Width = 300
      Height = 53
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        140.229166666666700000
        1105.958333333333000000
        127.000000000000000000
        793.750000000000000000)
      Brush.Style = bsClear
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object psEtiqueta: TQRLabel
      Left = 114
      Top = 101
      Width = 67
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        301.625000000000000000
        267.229166666666700000
        177.270833333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'psEtiqueta'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object PsQRSysData1: TQRSysData
      Left = 649
      Top = 101
      Width = 69
      Height = 15
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        39.687500000000000000
        1717.145833333333000000
        267.229166666666700000
        182.562500000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = True
      Color = clWhite
      Data = qrsPageNumber
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Text = 'Hoja : '
      Transparent = True
      FontSize = 8
    end
    object PsQRLabel19: TQRLabel
      Left = 418
      Top = 101
      Width = 177
      Height = 15
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        39.687500000000000000
        1105.958333333333000000
        267.229166666666700000
        468.312500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Cod. Proveedor: xxxxxxxxxxxxxx'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      OnPrint = PsQRLabel19Print
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object PsQRLabel1: TQRLabel
      Left = 119
      Top = 49
      Width = 87
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        314.854166666666700000
        129.645833333333300000
        230.187500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Firma Empresa:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object PsQRLabel2: TQRLabel
      Left = 421
      Top = 49
      Width = 113
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1113.895833333333000000
        129.645833333333300000
        298.979166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Firma Transportista:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object QRImgFirma: TQRImage
      Left = 560
      Top = 50
      Width = 123
      Height = 48
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        127.000000000000000000
        1481.666666666667000000
        132.291666666666700000
        325.437500000000000000)
    end
    object qrmGarantia: TQRMemo
      Left = 0
      Top = 0
      Width = 715
      Height = 15
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        39.687500000000000000
        0.000000000000000000
        0.000000000000000000
        1891.770833333333000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = True
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Times New Roman'
      Font.Style = []
      Lines.Strings = (
        
          'Las incidencias deben ser comunicadas y cuantificadas  por escri' +
          'to dentro del plazo de 48 horas posteriores a la descarga de la ' +
          'mercanc'#237'a.')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 7
    end
    object qrmReponsabilidadEnvase: TQRMemo
      Left = 0
      Top = 15
      Width = 718
      Height = 33
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        87.312500000000000000
        0.000000000000000000
        39.687500000000000000
        1899.708333333333000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = []
      Lines.Strings = (
        
          '"De conformidad con lo establecido en la ley 11/1997,  de 24 de ' +
          'abril, de envases y residuos de envases y,  el art'#237'culo 18.1 del' +
          '  Real Decreto 782/1998,  de 30 de Abril  que desarrolla la Ley ' +
          '11/1997; '
        
          'el responsable de la entrega del residuo de envase o envase usad' +
          'o para su correcta  gesti'#243'n ambiental de aquellos envases no ide' +
          'ntificados mediante el Punto Verde (sistema integrado de gesti'#243'n' +
          ' '
        'de Ecoembes), ser'#225' el poseedor final del mismo".')
      ParentFont = False
      Transparent = False
      WordWrap = False
      FontSize = 6
    end
  end
  object bndPaletsMercadona: TQRChildBand
    Left = 45
    Top = 545
    Width = 718
    Height = 31
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    BeforePrint = bndPaletsMercadonaBeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      82.020833333333330000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = ChildBand1
    object mmoPaletsMercadona: TQRMemo
      Left = 33
      Top = 1
      Width = 652
      Height = 28
      Frame.Color = clBlue
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        74.083333333333330000
        87.312500000000000000
        2.645833333333333000
        1725.083333333333000000)
      Alignment = taCenter
      AlignToBand = True
      AutoSize = False
      AutoStretch = True
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      Lines.Strings = (
        
          'TIPO PALETA                         ENVASE                      ' +
          '   PALETS   CAJAS      KILOS')
      ParentFont = False
      Transparent = False
      WordWrap = False
      FontSize = 8
    end
  end
end
