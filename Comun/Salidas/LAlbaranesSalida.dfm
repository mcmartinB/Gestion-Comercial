object QRAlbaranesSalida: TQRAlbaranesSalida
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
  AfterPrint = QRAlbaranesSalidaAfterPrint
  BeforePrint = QRAlbaranesSalidaBeforePrint
  DataSet = QAlbaran
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  Functions.Strings = (
    'PAGENUMBER'
    'COLUMNNUMBER'
    'REPORTTITLE'
    'QRLOOPBAND1'
    'QRSTRINGSBAND1')
  Functions.DATA = (
    '0'
    '0'
    #39#39
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
    100.000000000000000000
    100.000000000000000000
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
  ReportTitle = 'Albar'#225'n de Salida'
  SnapToGrid = True
  Units = MM
  Zoom = 100
  PrevFormStyle = fsNormal
  PreviewInitialState = wsNormal
  PrevInitialZoom = qrZoomToFit
  object BonnyBand: TQRBand
    Left = 38
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
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      219.604166666666700000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbPageHeader
    object QRImageCab: TQRImage
      Left = 0
      Top = 0
      Width = 30
      Height = 30
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        79.375000000000000000
        0.000000000000000000
        0.000000000000000000
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
  end
  object ChildBand1: TQRChildBand
    Left = 38
    Top = 391
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
    ParentBand = BandaDireccion
    object QRLabel22: TQRLabel
      Left = 4
      Top = 4
      Width = 123
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        10.583333333333330000
        10.583333333333330000
        325.437500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Producto'
      Color = 15395562
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
    object QRShape29: TQRShape
      Left = 127
      Top = 0
      Width = 3
      Height = 26
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        68.791666666666670000
        336.020833333333300000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLabel23: TQRLabel
      Left = 130
      Top = 4
      Width = 184
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        343.958333333333300000
        10.583333333333330000
        486.833333333333300000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Art'#237'culo'
      Color = 15395562
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
    object QRShape30: TQRShape
      Left = 316
      Top = 0
      Width = 3
      Height = 26
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        68.791666666666670000
        836.083333333333300000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLabel24: TQRLabel
      Left = 322
      Top = 4
      Width = 56
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        851.958333333333300000
        10.583333333333330000
        148.166666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Marca'
      Color = 15395562
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
    object QRShape31: TQRShape
      Left = 381
      Top = 0
      Width = 3
      Height = 26
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        68.791666666666670000
        1008.062500000000000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLabel25: TQRLabel
      Left = 383
      Top = 4
      Width = 31
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        1013.354166666667000000
        10.583333333333330000
        82.020833333333330000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Color'
      Color = 15395562
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
    object QRShape32: TQRShape
      Left = 413
      Top = 0
      Width = 3
      Height = 26
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        68.791666666666670000
        1092.729166666667000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object pslCalibre: TQRLabel
      Left = 415
      Top = 4
      Width = 56
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        1098.020833333333000000
        10.583333333333330000
        148.166666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Calibre'
      Color = 15395562
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
    object QRShape33: TQRShape
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
    object QRLabel27: TQRLabel
      Left = 475
      Top = 0
      Width = 39
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666700000
        1256.770833333330000000
        0.000000000000000000
        103.187500000000000000)
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
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object QRShape34: TQRShape
      Left = 515
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
        1362.604166666670000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLabel28: TQRLabel
      Left = 519
      Top = 4
      Width = 52
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666700000
        1373.187500000000000000
        10.583333333333300000
        137.583333333333000000)
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
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object QRShape35: TQRShape
      Left = 573
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
        1516.062500000000000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLabel29: TQRLabel
      Left = 578
      Top = 4
      Width = 61
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666700000
        1529.291666666670000000
        10.583333333333300000
        161.395833333333000000)
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
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object QRShape36: TQRShape
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
    object QRLabel30: TQRLabel
      Left = 647
      Top = 4
      Width = 66
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666700000
        1711.854166666670000000
        10.583333333333300000
        174.625000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Importe'
      Color = 15395562
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
    object QRLabel1: TQRLabel
      Left = 475
      Top = 11
      Width = 39
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666700000
        1256.770833333330000000
        29.104166666666700000
        103.187500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Unidad'
      Color = 15395562
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
  end
  object BandaPieDetalle: TQRBand
    Left = 38
    Top = 470
    Width = 718
    Height = 124
    Frame.Color = clBlack
    Frame.DrawTop = True
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    BeforePrint = BandaPieDetalleBeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = BandaObserbaciones
    Size.Values = (
      328.083333333333300000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupFooter
    object psMemoCajas: TQRMemo
      Left = 208
      Top = 40
      Width = 245
      Height = 73
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        193.145833333333000000
        550.333333333333000000
        105.833333333333000000
        648.229166666667000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = True
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object psMemoPalets: TQRMemo
      Left = 1
      Top = 40
      Width = 200
      Height = 73
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        193.145833333333000000
        2.645833333333330000
        105.833333333333000000
        529.166666666667000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = True
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object Rtotal: TQRShape
      Left = 589
      Top = 73
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
        193.145833333333000000
        341.312500000000000000)
      Brush.Style = bsClear
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object Riva: TQRShape
      Left = 589
      Top = 48
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
        127.000000000000000000
        341.312500000000000000)
      Brush.Style = bsClear
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object Rneto: TQRShape
      Left = 589
      Top = 23
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
        60.854166666666700000
        341.312500000000000000)
      Brush.Style = bsClear
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object ImporteAcum: TQRExpr
      Left = 636
      Top = 4
      Width = 79
      Height = 17
      Enabled = False
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1682.750000000000000000
        10.583333333333300000
        209.020833333333000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Color = clWhite
      Master = Owner
      ParentFont = False
      ResetAfterPrint = True
      Transparent = False
      WordWrap = True
      Expression = 'SUM(QAlbaran.importe_neto)'
      FontSize = 8
    end
    object psImporte: TQRLabel
      Left = 657
      Top = 28
      Width = 58
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1738.312500000000000000
        74.083333333333330000
        153.458333333333300000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'psImporte'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object psIva: TQRLabel
      Left = 685
      Top = 53
      Width = 30
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1812.395833333333000000
        140.229166666666700000
        79.375000000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'psIva'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object psTotal: TQRLabel
      Left = 672
      Top = 78
      Width = 43
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1778.000000000000000000
        206.375000000000000000
        113.770833333333300000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'psTotal'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object moneda1: TQRLabel
      Left = 590
      Top = 87
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
        230.187500000000000000
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
    object moneda2: TQRLabel
      Left = 590
      Top = 62
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
        164.041666666666700000
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
    object moneda3: TQRLabel
      Left = 590
      Top = 37
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
        97.895833333333330000
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
    object Lneto: TQRLabel
      Left = 496
      Top = 26
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
        68.791666666666670000
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
    object LIva: TQRLabel
      Left = 496
      Top = 51
      Width = 54
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        1312.333333333333000000
        134.937500000000000000
        142.875000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Total IVA'
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
    object Ltotal: TQRLabel
      Left = 496
      Top = 76
      Width = 81
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        1312.333333333333000000
        201.083333333333300000
        214.312500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Total Albar'#225'n '
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
    object LPalets: TQRLabel
      Left = 1
      Top = 19
      Width = 40
      Height = 17
      Enabled = False
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        2.645833333333333000
        50.270833333333330000
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
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object LLogifruit: TQRLabel
      Left = 208
      Top = 19
      Width = 36
      Height = 17
      Enabled = False
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        550.333333333333300000
        50.270833333333330000
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
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
  end
  object BandaDireccion: TQRGroup
    Left = 38
    Top = 121
    Width = 718
    Height = 270
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    BeforePrint = BandaDireccionBeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = True
    Size.Values = (
      714.375000000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Expression = 
      '[cod_empresa] + [cod_centro_salida] + [cod_cliente_salida] + [co' +
      'd_suministro] + [albaran] + [fecha_albaran]'
    FooterBand = BandaPieDetalle
    Master = Owner
    ReprintOnNewPage = True
    object QRDBText2: TQRDBText
      Left = 52
      Top = 228
      Width = 59
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        137.583333333333300000
        603.250000000000000000
        156.104166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Color = clWhite
      DataSet = QAlbaran
      DataField = 'transporte'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRDBText1: TQRDBText
      Left = 146
      Top = 177
      Width = 78
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        386.291666666666700000
        468.312500000000000000
        206.375000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Color = clWhite
      DataSet = QAlbaran
      DataField = 'centro_salida'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object LClienteSalida: TQRLabel
      Left = 37
      Top = 20
      Width = 77
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        97.895833333333330000
        52.916666666666670000
        203.729166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'ClienteSalida'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object LDireccionSuministro: TQRLabel
      Left = 37
      Top = 38
      Width = 114
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        97.895833333333330000
        100.541666666666700000
        301.625000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'DireccionSuminstro'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object LDomicilio: TQRLabel
      Left = 37
      Top = 56
      Width = 54
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        97.895833333333330000
        148.166666666666700000
        142.875000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Domicilio'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object Lpoblacion: TQRLabel
      Left = 37
      Top = 74
      Width = 58
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        97.895833333333330000
        195.791666666666700000
        153.458333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Poblacion'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object LProvincia: TQRLabel
      Left = 37
      Top = 92
      Width = 79
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        97.895833333333330000
        243.416666666666700000
        209.020833333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'ProvinciaPais'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object LPais: TQRLabel
      Left = 37
      Top = 110
      Width = 27
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        97.895833333333330000
        291.041666666666700000
        71.437500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Pais'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape16: TQRShape
      Left = 38
      Top = 149
      Width = 645
      Height = 25
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        66.145833333333300000
        100.541666666667000000
        394.229166666667000000
        1706.562500000000000000)
      Brush.Color = 15395562
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object QRShape17: TQRShape
      Left = 38
      Top = 199
      Width = 645
      Height = 25
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        66.145833333333300000
        100.541666666667000000
        526.520833333333000000
        1706.562500000000000000)
      Brush.Color = 15395562
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object QRLabel6: TQRLabel
      Left = 45
      Top = 152
      Width = 82
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        119.062500000000000000
        402.166666666666700000
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
    object QRLabel7: TQRLabel
      Left = 232
      Top = 152
      Width = 53
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        613.833333333333300000
        402.166666666666700000
        140.229166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
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
    object QRLabel8: TQRLabel
      Left = 422
      Top = 152
      Width = 48
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        1116.541666666667000000
        402.166666666666700000
        127.000000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Fecha'
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
    object QRLabel9: TQRLabel
      Left = 520
      Top = 152
      Width = 38
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        1375.833333333333000000
        402.166666666666700000
        100.541666666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
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
    object QRLabel10: TQRLabel
      Left = 596
      Top = 152
      Width = 77
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        1576.916666666667000000
        402.166666666666700000
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
    object QRDBText14: TQRDBText
      Left = 598
      Top = 177
      Width = 89
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1582.208333333333000000
        468.312500000000000000
        235.479166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Color = clWhite
      DataSet = QAlbaran
      DataField = 'numero_pedido'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRDBText13: TQRDBText
      Left = 504
      Top = 177
      Width = 75
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1333.500000000000000000
        468.312500000000000000
        198.437500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Color = clWhite
      DataSet = QAlbaran
      DataField = 'hora_albaran'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRDBText12: TQRDBText
      Left = 412
      Top = 177
      Width = 81
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1090.083333333333000000
        468.312500000000000000
        214.312500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Color = clWhite
      DataSet = QAlbaran
      DataField = 'fecha_albaran'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrdbtxtalbaran: TQRDBText
      Left = 42
      Top = 177
      Width = 73
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        111.125000000000000000
        468.312500000000000000
        193.145833333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = QAlbaran
      DataField = 'albaran'
      OnPrint = qrdbtxtalbaranPrint
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRLabel11: TQRLabel
      Left = 155
      Top = 202
      Width = 85
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        410.104166666666700000
        534.458333333333300000
        224.895833333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
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
    object QRLabel12: TQRLabel
      Left = 487
      Top = 202
      Width = 68
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666670000
        1288.520833333333000000
        534.458333333333300000
        179.916666666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
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
    object QRDBText16: TQRDBText
      Left = 373
      Top = 228
      Width = 47
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        986.895833333333300000
        603.250000000000000000
        124.354166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Color = clWhite
      DataSet = QAlbaran
      DataField = 'vehiculo'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape20: TQRShape
      Left = 37
      Top = 174
      Width = 3
      Height = 25
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        66.145833333333300000
        97.895833333333300000
        460.375000000000000000
        7.937500000000000000)
      Brush.Style = bsClear
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape23: TQRShape
      Left = 131
      Top = 149
      Width = 3
      Height = 50
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        132.291666666667000000
        346.604166666667000000
        394.229166666667000000
        7.937500000000000000)
      Brush.Style = bsClear
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape24: TQRShape
      Left = 397
      Top = 149
      Width = 3
      Height = 50
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        132.291666666667000000
        1050.395833333330000000
        394.229166666667000000
        7.937500000000000000)
      Brush.Style = bsClear
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape25: TQRShape
      Left = 490
      Top = 149
      Width = 3
      Height = 50
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        132.291666666667000000
        1296.458333333330000000
        394.229166666667000000
        7.937500000000000000)
      Brush.Style = bsClear
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape26: TQRShape
      Left = 584
      Top = 149
      Width = 3
      Height = 50
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        132.291666666667000000
        1545.166666666670000000
        394.229166666667000000
        7.937500000000000000)
      Brush.Style = bsClear
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape22: TQRShape
      Left = 681
      Top = 174
      Width = 3
      Height = 25
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        66.145833333333300000
        1801.812500000000000000
        460.375000000000000000
        7.937500000000000000)
      Brush.Style = bsClear
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape21: TQRShape
      Left = 681
      Top = 224
      Width = 3
      Height = 27
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        71.437500000000000000
        1801.812500000000000000
        592.666666666667000000
        7.937500000000000000)
      Brush.Style = bsClear
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape27: TQRShape
      Left = 358
      Top = 200
      Width = 3
      Height = 50
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        132.291666666667000000
        947.208333333333000000
        529.166666666667000000
        7.937500000000000000)
      Brush.Style = bsClear
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape19: TQRShape
      Left = 37
      Top = 224
      Width = 3
      Height = 26
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        68.791666666666700000
        97.895833333333300000
        592.666666666667000000
        7.937500000000000000)
      Brush.Style = bsClear
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape18: TQRShape
      Left = 38
      Top = 249
      Width = 644
      Height = 3
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        7.937500000000000000
        100.541666666667000000
        658.812500000000000000
        1703.916666666670000000)
      Brush.Style = bsClear
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object qrdbtxtalbaran2: TQRDBText
      Left = 116
      Top = 177
      Width = 13
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        306.916666666666700000
        468.312500000000000000
        34.395833333333330000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = QAlbaran
      DataField = 'albaran'
      OnPrint = qrdbtxtalbaran2Print
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
  end
  object CabGrupoDetalles: TQRGroup
    Left = 38
    Top = 416
    Width = 718
    Height = 18
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = True
    Frame.DrawRight = True
    AlignToBottom = False
    BeforePrint = CabGrupoDetallesBeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      47.625000000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Expression = 
      '[cod_producto] + [cod_envase] +  [cod_marca] + [cod_color] + [ca' +
      'libre] + [precio] + [unidad_precio]'
    FooterBand = BandaDatosDetalle
    Master = Owner
    ReprintOnNewPage = False
  end
  object BandaDatosDetalle: TQRBand
    Left = 38
    Top = 452
    Width = 718
    Height = 18
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = True
    Frame.DrawRight = True
    AlignToBottom = False
    BeforePrint = BandaDatosDetalleBeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      47.625000000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupFooter
    object LCajas: TQRExpr
      Left = 475
      Top = 1
      Width = 39
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1256.770833333330000000
        2.645833333333330000
        103.187500000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Color = clWhite
      Master = Owner
      ParentFont = False
      ResetAfterPrint = True
      Transparent = False
      WordWrap = True
      Expression = 'SUM(QAlbaran.cajas)'
      Mask = '#,#00'
      FontSize = 8
    end
    object LKilos: TQRExpr
      Left = 519
      Top = 1
      Width = 52
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1373.187500000000000000
        2.645833333333330000
        137.583333333333000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Color = clWhite
      Master = Owner
      ParentFont = False
      ResetAfterPrint = True
      Transparent = False
      WordWrap = True
      Expression = 'SUM(QAlbaran.kilos)'
      Mask = '#,#00.00'
      FontSize = 8
    end
    object LImporte: TQRExpr
      Left = 647
      Top = 1
      Width = 66
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1711.854166666670000000
        2.645833333333330000
        174.625000000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Color = clWhite
      Master = Owner
      ParentFont = False
      ResetAfterPrint = True
      Transparent = False
      WordWrap = True
      Expression = 'SUM(QAlbaran.importe_neto)'
      Mask = '#,#00.00'
      FontSize = 8
    end
    object psdCalibre: TQRDBText
      Left = 415
      Top = 1
      Width = 56
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1098.020833333333000000
        2.645833333333333000
        148.166666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = QAlbaran
      DataField = 'calibre'
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
    object color: TQRDBText
      Left = 383
      Top = 1
      Width = 31
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1013.354166666667000000
        2.645833333333333000
        82.020833333333330000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = QAlbaran
      DataField = 'cod_color'
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
    object marca: TQRDBText
      Left = 322
      Top = 1
      Width = 56
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        851.958333333333300000
        2.645833333333333000
        148.166666666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = QAlbaran
      DataField = 'marca'
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
    object LEnvase: TQRLabel
      Left = 130
      Top = 1
      Width = 184
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        343.958333333333300000
        2.645833333333333000
        486.833333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Envase'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object LProducto: TQRLabel
      Left = 4
      Top = 1
      Width = 123
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        10.583333333333330000
        2.645833333333333000
        325.437500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Producto'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      OnPrint = LProductoPrint
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object PrecioUnidad: TQRDBText
      Left = 577
      Top = 1
      Width = 42
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1526.645833333330000000
        2.645833333333330000
        111.125000000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = QAlbaran
      DataField = 'precio'
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
      Left = 620
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
        1640.416666666667000000
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
      Left = 625
      Top = 1
      Width = 20
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1653.645833333330000000
        2.645833333333330000
        52.916666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = QAlbaran
      DataField = 'unidad_precio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 6
    end
    object lin1: TQRShape
      Left = 127
      Top = 0
      Width = 3
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        336.020833333333300000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lin2: TQRShape
      Left = 316
      Top = 0
      Width = 3
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        836.083333333333300000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lin3: TQRShape
      Left = 381
      Top = 0
      Width = 3
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        1008.062500000000000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lin4: TQRShape
      Left = 413
      Top = 0
      Width = 3
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        1092.729166666667000000
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
      Left = 515
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
        1362.604166666670000000
        0.000000000000000000
        7.937500000000000000)
      Brush.Color = clBlack
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lin7: TQRShape
      Left = 573
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
        1516.062500000000000000
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
  end
  object QRBand1: TQRBand
    Left = 38
    Top = 434
    Width = 718
    Height = 18
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = True
    Frame.DrawRight = True
    AlignToBottom = False
    Color = clWhite
    Enabled = False
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      47.625000000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbDetail
    object QRExpr3: TQRExpr
      Left = 647
      Top = 1
      Width = 66
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1711.854166666670000000
        2.645833333333330000
        174.625000000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Color = clWhite
      Master = Owner
      ParentFont = False
      ResetAfterPrint = False
      Transparent = False
      WordWrap = True
      Expression = 'QAlbaran.importe_neto'
      Mask = '#,#00.00'
      FontSize = 8
    end
    object QRExpr2: TQRExpr
      Left = 519
      Top = 1
      Width = 52
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1373.187500000000000000
        2.645833333333330000
        137.583333333333000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Color = clWhite
      Master = Owner
      ParentFont = False
      ResetAfterPrint = False
      Transparent = False
      WordWrap = True
      Expression = 'QAlbaran.kilos'
      Mask = '#,#00.00'
      FontSize = 8
    end
    object QRExpr1: TQRExpr
      Left = 475
      Top = 1
      Width = 39
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1256.770833333330000000
        2.645833333333330000
        103.187500000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Color = clWhite
      Master = Owner
      ParentFont = False
      ResetAfterPrint = True
      Transparent = False
      WordWrap = True
      Expression = 'SUM(QAlbaran.cajas)'
      Mask = '#,#00'
      FontSize = 8
    end
  end
  object BandaObserbaciones: TQRChildBand
    Left = 38
    Top = 594
    Width = 718
    Height = 108
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    BeforePrint = BandaObserbacionesBeforePrint
    Color = clWhite
    TransparentBand = True
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = BandaCalidad
    Size.Values = (
      285.750000000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = BandaPieDetalle
    object LObservaciones: TQRLabel
      Left = 13
      Top = 2
      Width = 102
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        34.395833333333330000
        5.291666666666667000
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
    object QRNotas: TQRMemo
      Left = 13
      Top = 21
      Width = 692
      Height = 81
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        214.312500000000000000
        34.395833333333300000
        55.562500000000000000
        1830.916666666670000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
  end
  object BandaCalidad: TQRChildBand
    Left = 38
    Top = 702
    Width = 718
    Height = 29
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AfterPrint = BandaCalidadAfterPrint
    AlignToBottom = True
    BeforePrint = BandaCalidadBeforePrint
    Color = clWhite
    TransparentBand = True
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      76.729166666666670000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = BandaObserbaciones
    object psMemoCalidad: TQRMemo
      Left = -7
      Top = 5
      Width = 732
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        -18.520833333333330000
        13.229166666666670000
        1936.750000000000000000)
      Alignment = taCenter
      AlignToBand = True
      AutoSize = False
      AutoStretch = True
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'Times New Roman'
      Font.Style = []
      Lines.Strings = (
        
          'Toda la producci'#243'n de tomate comercializada por S.A.T. N'#186'9359 BO' +
          'NNYSA est'#225' certificada conforme a las normas UNE 155001-1 (1997)' +
          ' y UNE 155001-2.')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 6
    end
  end
  object QAlbaran: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT'
      '       Frf_salidas_c.empresa_sc cod_empresa,'
      '       Frf_empresas.nombre_e empresa,'
      ''
      '       Frf_salidas_c.centro_salida_sc cod_centro_salida,'
      '       Frf_centros_1.descripcion_c centro_salida,'
      ''
      '       Frf_salidas_c.n_albaran_sc albaran,'
      '       Frf_salidas_c.fecha_sc fecha_albaran,'
      '       Frf_salidas_c.hora_sc hora_albaran,'
      ''
      '       Frf_salidas_c.cliente_sal_sc cod_cliente_salida,'
      '       Frf_clientes_1.nombre_c cliente_salida,'
      '       Frf_clientes_1.tipo_via_c via_cli,'
      '       Frf_clientes_1.domicilio_c domicilio_cli,'
      '       Frf_clientes_1.poblacion_c poblacion_cli,'
      '       Frf_clientes_1.cod_postal_c cod_postal_cli,'
      '       Frf_provincias.nombre_p provincia_cli,'
      '       Frf_clientes_1.pais_c cod_pais_cli,'
      '       Frf_paises1.descripcion_p pais_cli,'
      ''
      '       Frf_clientes_1.albaran_valor_c valorar_albaran,'
      ''
      '       Frf_salidas_c.dir_sum_sc cod_suministro,'
      '       Frf_dir_sum.nombre_ds suministro,'
      '       Frf_dir_sum.tipo_via_ds via_sum,'
      '       Frf_dir_sum.domicilio_ds domicilio_sum,'
      '       Frf_dir_sum.cod_postal_ds cod_postal_sum,'
      '       Frf_dir_sum.poblacion_ds poblacion_sum,'
      '       Frf_dir_sum.provincia_ds provincia_sum_ext,'
      '       Frf_provincias2.nombre_p provincia_sum_esp,'
      '       Frf_dir_sum.pais_ds cod_pais_sum,'
      '       Frf_paises2.descripcion_p pais_sum,'
      ''
      '       Frf_salidas_c.moneda_sc cod_moneda,'
      '       Frf_salidas_c.n_pedido_sc numero_pedido,'
      '       Frf_salidas_c.transporte_sc cod_transporte,'
      '       Frf_transportistas.descripcion_t transporte,'
      '       Frf_salidas_c.vehiculo_sc vehiculo,'
      ''
      '       Frf_salidas_l.producto_sl cod_producto,'
      '       Frf_productos.descripcion_p producto_castellan,'
      '       Frf_productos.descripcion2_p producto_ingles,'
      ''
      '       Frf_salidas_l.marca_sl cod_marca,'
      '       Frf_marcas.descripcion_m marca,'
      ''
      '       Frf_salidas_l.envase_sl cod_envase,'
      '       Frf_envases.descripcion_e envase_castellano,'
      '       Frf_envases.descripcion2_e envase_ingles,'
      '       Frf_envases.unidades_e unidades_envase,'
      ''
      '       Frf_salidas_l.calibre_sl calibre,'
      '       Frf_salidas_l.color_sl cod_color,'
      ''
      '       Frf_salidas_l.cajas_sl cajas,'
      '       Frf_salidas_l.kilos_sl kilos,'
      '       Frf_salidas_l.precio_sl precio,'
      '       Frf_salidas_l.unidad_precio_sl unidad_precio,'
      '       Frf_salidas_l.porc_iva_sl porcentaje_iva,'
      ''
      '       Frf_salidas_l.importe_neto_sl importe_neto,'
      '       Frf_salidas_l.iva_sl iva,'
      '       Frf_salidas_l.importe_total_sl importe_total,'
      ''
      '       Frf_salidas_l.tipo_iva_sl cod_iva,'
      '       Frf_impuestos.tipo_i iva_descrip_corta,'
      '       Frf_impuestos.descripcion_i iva_descrip_larga'
      ''
      'FROM'
      '       frf_empresas Frf_empresas,'
      '       frf_salidas_c Frf_salidas_c,'
      '       frf_centros Frf_centros_1,'
      '       frf_transportistas Frf_transportistas,'
      '       frf_salidas_l Frf_salidas_l,'
      '       frf_productos Frf_productos,'
      '       frf_clientes Frf_clientes_1,'
      '       frf_marcas Frf_marcas,'
      '       frf_envases Frf_envases,'
      '       frf_paises Frf_paises1,'
      '       frf_impuestos Frf_impuestos,'
      '       OUTER (frf_dir_sum Frf_dir_sum,'
      '       OUTER frf_paises Frf_paises2,'
      '       OUTER frf_provincias Frf_provincias2),'
      '       OUTER frf_provincias Frf_provincias'
      ''
      ''
      'WHERE'
      '   (Frf_empresas.empresa_e = :empresa)'
      ''
      '   AND  (Frf_salidas_c.empresa_sc=:empresa)'
      '   AND  (Frf_salidas_c.fecha_sc BETWEEN :desde AND :hasta)'
      '   AND  (Frf_salidas_c.cliente_sal_sc=:cliente)'
      ''
      '   AND  (Frf_centros_1.empresa_c = :empresa)'
      
        '   AND  (Frf_centros_1.centro_c = Frf_salidas_c.centro_salida_sc' +
        ')'
      ''
      '   AND  (Frf_transportistas.empresa_t = :empresa)'
      
        '   AND  (Frf_transportistas.transporte_t = Frf_salidas_c.transpo' +
        'rte_sc)'
      ''
      '   AND  (Frf_salidas_l.empresa_sl = :empresa)'
      
        '   AND  (Frf_salidas_l.centro_salida_sl = Frf_salidas_c.centro_s' +
        'alida_sc)'
      
        '   AND  (Frf_salidas_l.n_albaran_sl = Frf_salidas_c.n_albaran_sc' +
        ')'
      '   AND  (Frf_salidas_l.fecha_sl = Frf_salidas_c.fecha_sc)'
      ''
      '   AND  (Frf_productos.empresa_p = :empresa)'
      '   AND  (Frf_productos.producto_p = Frf_salidas_l.producto_sl)'
      ''
      '   AND  (Frf_clientes_1.empresa_c = :empresa)'
      
        '   AND  (Frf_clientes_1.cliente_c = Frf_salidas_c.cliente_sal_sc' +
        ')'
      ''
      '   AND  (Frf_marcas.codigo_m = Frf_salidas_l.marca_sl)'
      ''
      '   AND  (Frf_envases.envase_e = Frf_salidas_l.envase_sl)'
      ''
      '   AND  (Frf_paises1.pais_p = Frf_clientes_1.pais_c)'
      ''
      '   AND  (Frf_impuestos.codigo_i = Frf_salidas_l.tipo_iva_sl)'
      ''
      '   AND  (Frf_dir_sum.empresa_ds = :empresa)'
      '   AND  (Frf_dir_sum.cliente_ds = :cliente)'
      '   AND  (Frf_dir_sum.dir_sum_ds = Frf_salidas_c.dir_sum_sc)'
      ''
      '   AND  (Frf_paises2.pais_p = Frf_dir_sum.pais_ds)'
      ''
      
        '   AND  (Frf_provincias2.codigo_p = Frf_dir_sum.cod_postal_ds[1,' +
        '2])'
      ''
      
        '   AND  (Frf_provincias.codigo_p = Frf_clientes_1.cod_postal_c[1' +
        ',2])'
      ''
      
        '   --a'#241'adido por mario para que no se envien los albaranes que e' +
        'sten en la tabla de albaranes enviados'
      
        '   AND  n_albaran_sc NOT IN (SELECT n_albaran_ae FROM frf_alb_en' +
        'viados'
      '                             WHERE empresa_ae = empresa_sc'
      
        '                             AND   cliente_sal_ae = cliente_sal_' +
        'sc'
      '                             AND   n_albaran_ae = n_albaran_sc'
      '                             AND   fecha_ae = fecha_sc)'
      ''
      'ORDER BY'
      '       Frf_salidas_c.empresa_sc , Frf_salidas_c.cliente_sal_sc ,'
      
        '       Frf_salidas_c.dir_sum_sc , Frf_salidas_c.centro_salida_sc' +
        ' ,'
      '       Frf_salidas_c.n_albaran_sc , Frf_salidas_c.fecha_sc ,'
      ''
      '       Frf_salidas_l.producto_sl , Frf_salidas_l.envase_sl ,'
      '       Frf_salidas_l.marca_sl , Frf_salidas_l.color_sl ,'
      '       Frf_salidas_l.calibre_sl , Frf_salidas_l.precio_sl,'
      '       Frf_salidas_l.unidad_precio_sl'
      ''
      ''
      '')
    Left = 16
    Top = 64
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'desde'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'hasta'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'cliente'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'cliente'
        ParamType = ptUnknown
      end>
    object QAlbarancod_empresa: TStringField
      FieldName = 'cod_empresa'
      Size = 3
    end
    object QAlbaranempresa: TStringField
      FieldName = 'empresa'
      Size = 30
    end
    object QAlbarancod_centro_salida: TStringField
      FieldName = 'cod_centro_salida'
      Size = 1
    end
    object QAlbarancentro_salida: TStringField
      FieldName = 'centro_salida'
      Size = 30
    end
    object QAlbaranalbaran: TIntegerField
      FieldName = 'albaran'
    end
    object QAlbaranfecha_albaran: TDateField
      FieldName = 'fecha_albaran'
    end
    object QAlbaranhora_albaran: TStringField
      FieldName = 'hora_albaran'
      Size = 5
    end
    object QAlbarancod_cliente_salida: TStringField
      FieldName = 'cod_cliente_salida'
      Size = 3
    end
    object QAlbarancliente_salida: TStringField
      FieldName = 'cliente_salida'
      Size = 30
    end
    object QAlbaranvia_cli: TStringField
      FieldName = 'via_cli'
      Size = 2
    end
    object QAlbarandomicilio_cli: TStringField
      FieldName = 'domicilio_cli'
      Size = 50
    end
    object QAlbaranpoblacion_cli: TStringField
      FieldName = 'poblacion_cli'
      Size = 50
    end
    object QAlbarancod_postal_cli: TStringField
      DisplayWidth = 10
      FieldName = 'cod_postal_cli'
      Size = 10
    end
    object QAlbaranprovincia_cli: TStringField
      FieldName = 'provincia_cli'
      Size = 30
    end
    object QAlbarancod_pais_cli: TStringField
      FieldName = 'cod_pais_cli'
      Size = 2
    end
    object QAlbaranpais_cli: TStringField
      FieldName = 'pais_cli'
      Size = 30
    end
    object QAlbaranvalorar_albaran: TStringField
      FieldName = 'valorar_albaran'
      Size = 1
    end
    object QAlbarancod_suministro: TStringField
      FieldName = 'cod_suministro'
      Size = 3
    end
    object QAlbaransuministro: TStringField
      DisplayWidth = 40
      FieldName = 'suministro'
      Size = 40
    end
    object QAlbaranvia_sum: TStringField
      FieldName = 'via_sum'
      Size = 2
    end
    object QAlbarandomicilio_sum: TStringField
      FieldName = 'domicilio_sum'
      Size = 40
    end
    object QAlbarancod_postal_sum: TStringField
      DisplayWidth = 8
      FieldName = 'cod_postal_sum'
      Size = 8
    end
    object QAlbaranpoblacion_sum: TStringField
      FieldName = 'poblacion_sum'
      Size = 30
    end
    object QAlbaranprovincia_sum_ext: TStringField
      FieldName = 'provincia_sum_ext'
      Size = 30
    end
    object QAlbaranprovincia_sum_esp: TStringField
      FieldName = 'provincia_sum_esp'
      Size = 30
    end
    object QAlbarancod_pais_sum: TStringField
      FieldName = 'cod_pais_sum'
      Size = 2
    end
    object QAlbaranpais_sum: TStringField
      FieldName = 'pais_sum'
      Size = 30
    end
    object QAlbarancod_moneda: TStringField
      FieldName = 'cod_moneda'
      Size = 3
    end
    object QAlbarannumero_pedido: TStringField
      FieldName = 'numero_pedido'
      Size = 15
    end
    object QAlbarancod_transporte: TSmallintField
      FieldName = 'cod_transporte'
    end
    object QAlbarantransporte: TStringField
      FieldName = 'transporte'
      Size = 30
    end
    object QAlbaranvehiculo: TStringField
      FieldName = 'vehiculo'
    end
    object QAlbarancod_producto: TStringField
      DisplayWidth = 3
      FieldName = 'cod_producto'
      Size = 3
    end
    object QAlbaranproducto_castellan: TStringField
      FieldName = 'producto_castellan'
      Size = 30
    end
    object QAlbaranproducto_ingles: TStringField
      FieldName = 'producto_ingles'
      Size = 30
    end
    object QAlbarancod_marca: TStringField
      FieldName = 'cod_marca'
      Size = 2
    end
    object QAlbaranmarca: TStringField
      FieldName = 'marca'
      Size = 30
    end
    object QAlbarancod_envase: TStringField
      FieldName = 'cod_envase'
      Size = 3
    end
    object QAlbaranenvase_castellano: TStringField
      FieldName = 'envase_castellano'
      Size = 30
    end
    object QAlbaranenvase_ingles: TStringField
      FieldName = 'envase_ingles'
      Size = 30
    end
    object QAlbaranunidades_envase: TSmallintField
      FieldName = 'unidades_envase'
    end
    object QAlbarancalibre: TStringField
      DisplayWidth = 10
      FieldName = 'calibre'
      Size = 6
    end
    object QAlbarancod_color: TStringField
      FieldName = 'cod_color'
      Size = 1
    end
    object QAlbarancajas: TIntegerField
      FieldName = 'cajas'
    end
    object QAlbarankilos: TFloatField
      FieldName = 'kilos'
    end
    object QAlbaranprecio: TFloatField
      FieldName = 'precio'
    end
    object QAlbaranunidad_precio: TStringField
      FieldName = 'unidad_precio'
      Size = 3
    end
    object QAlbaranporcentaje_iva: TFloatField
      FieldName = 'porcentaje_iva'
    end
    object QAlbaranimporte_neto: TFloatField
      FieldName = 'importe_neto'
    end
    object QAlbaraniva: TFloatField
      FieldName = 'iva'
    end
    object QAlbaranimporte_total: TFloatField
      FieldName = 'importe_total'
    end
    object QAlbarancod_iva: TStringField
      FieldName = 'cod_iva'
      Size = 2
    end
    object QAlbaraniva_descrip_corta: TStringField
      FieldName = 'iva_descrip_corta'
      Size = 4
    end
    object QAlbaraniva_descrip_larga: TStringField
      FieldName = 'iva_descrip_larga'
      Size = 50
    end
  end
  object DataSource1: TDataSource
    DataSet = QAlbaran
    Left = 8
    Top = 105
  end
  object QPalets: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DataSource1
    SQL.Strings = (
      
        'SELECT descripcion_tp, Trim(descripcion_tp)||'#39': '#39'||SUM(n_palets_' +
        'sl) as palets'
      'FROM frf_salidas_l , frf_tipo_palets '
      'WHERE   (tipo_palets_sl = codigo_tp) '
      'AND  (empresa_sl = :cod_empresa) '
      'AND  (centro_salida_sl = :cod_centro_salida) '
      'AND  (n_albaran_sl = :albaran) '
      'AND  (fecha_sl = :fecha_albaran)'
      'GROUP BY descripcion_tp  '
      'ORDER BY descripcion_tp'
      ' ')
    Left = 6
    Top = 166
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cod_empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'cod_centro_salida'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'albaran'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha_albaran'
        ParamType = ptUnknown
      end>
  end
  object QLogifruit: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DataSource1
    SQL.Strings = (
      
        'SELECT codigo_caja_e, texto_caja_e, Trim(texto_caja_e)||'#39': '#39'||SU' +
        'M(cajas_sl) as logifruit'
      'FROM frf_salidas_l , frf_envases '
      'WHERE   (envase_sl = envase_e) '
      'AND  ((codigo_caja_e <>"")AND(codigo_caja_e IS NOT NULL)) '
      'AND  (empresa_sl = :cod_empresa) '
      'AND  (centro_salida_sl = :cod_centro_salida) '
      'AND  (n_albaran_sl = :albaran) '
      'AND  (fecha_sl = :fecha_albaran) '
      'GROUP BY codigo_caja_e, texto_caja_e  '
      'ORDER BY codigo_caja_e')
    Left = 6
    Top = 195
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cod_empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'cod_centro_salida'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'albaran'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha_albaran'
        ParamType = ptUnknown
      end>
  end
  object QNotas: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DataSource1
    SQL.Strings = (
      'SELECT nota_sc'
      'FROM frf_salidas_c'
      'WHERE (empresa_sc = :cod_empresa)'
      'AND  (centro_salida_sc = :cod_centro_salida)'
      'AND  (n_albaran_sc = :albaran)'
      'AND  (fecha_sc = :fecha_albaran)'
      ' ')
    Left = 6
    Top = 134
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cod_empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'cod_centro_salida'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'albaran'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha_albaran'
        ParamType = ptUnknown
      end>
  end
end
