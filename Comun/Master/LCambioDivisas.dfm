object QRLCambioDivisas: TQRLCambioDivisas
  Left = 0
  Top = 0
  Width = 1123
  Height = 794
  Frame.Color = clBlack
  Frame.DrawTop = False
  Frame.DrawBottom = False
  Frame.DrawLeft = False
  Frame.DrawRight = False
  BeforePrint = QRLCambioDivisasBeforePrint
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
  Page.Orientation = poLandscape
  Page.PaperSize = A4
  Page.Values = (
    100.000000000000000000
    2100.000000000000000000
    100.000000000000000000
    2970.000000000000000000
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
  ReportTitle = 'Cambios de Divisas'
  SnapToGrid = True
  Units = MM
  Zoom = 100
  PrevFormStyle = fsNormal
  PreviewInitialState = wsNormal
  PrevInitialZoom = qrZoomToFit
  object TitleBand1: TQRBand
    Left = 38
    Top = 38
    Width = 1047
    Height = 80
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
      211.666666666666700000
      2770.187500000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbPageHeader
    object PsQRShape11: TQRShape
      Left = 926
      Top = 60
      Width = 102
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666700000
        2450.041666666670000000
        158.750000000000000000
        269.875000000000000000)
      Pen.Width = 3
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object titol9: TQRLabel
      Left = 950
      Top = 61
      Width = 57
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        2513.541666666670000000
        161.395833333333000000
        150.812500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '9.999.999,9999'
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
    object PsQRShape10: TQRShape
      Left = 825
      Top = 60
      Width = 102
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666700000
        2182.812500000000000000
        158.750000000000000000
        269.875000000000000000)
      Pen.Width = 3
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object titol8: TQRLabel
      Left = 848
      Top = 61
      Width = 57
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        2243.666666666670000000
        161.395833333333000000
        150.812500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '9.999.999,9999'
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
    object PsQRShape9: TQRShape
      Left = 724
      Top = 60
      Width = 102
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.916666666666700000
        1915.583333333330000000
        158.750000000000000000
        269.875000000000000000)
      Pen.Width = 3
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object titol7: TQRLabel
      Left = 744
      Top = 61
      Width = 57
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1968.500000000000000000
        161.395833333333000000
        150.812500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '9.999.999,9999'
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
    object QRTitulo: TQRLabel
      Left = 347
      Top = 24
      Width = 353
      Height = 30
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        79.375000000000000000
        918.104166666666700000
        63.500000000000000000
        933.979166666666700000)
      Alignment = taCenter
      AlignToBand = True
      AutoSize = True
      AutoStretch = False
      Caption = 'LISTADO CAMBIO DE DIVISAS'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 18
    end
    object QRSysData2: TQRSysData
      Left = 1016
      Top = 0
      Width = 31
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        2688.166666666667000000
        0.000000000000000000
        82.020833333333330000)
      Alignment = taRightJustify
      AlignToBand = True
      AutoSize = True
      Color = clWhite
      Data = qrsDate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      FontSize = 8
    end
    object PsQRShape1: TQRShape
      Left = 116
      Top = 60
      Width = 102
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        306.916666666667000000
        158.750000000000000000
        269.875000000000000000)
      Pen.Width = 3
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object PsQRShape2: TQRShape
      Left = 218
      Top = 60
      Width = 102
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        576.791666666667000000
        158.750000000000000000
        269.875000000000000000)
      Pen.Width = 3
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object PsQRShape5: TQRShape
      Left = 319
      Top = 60
      Width = 102
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        844.020833333334000000
        158.750000000000000000
        269.875000000000000000)
      Pen.Width = 3
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object PsQRShape6: TQRShape
      Left = 421
      Top = 60
      Width = 101
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        1113.895833333330000000
        158.750000000000000000
        267.229166666667000000)
      Pen.Width = 3
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object PsQRShape7: TQRShape
      Left = 522
      Top = 60
      Width = 101
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        1381.125000000000000000
        158.750000000000000000
        267.229166666667000000)
      Pen.Width = 3
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object PsQRShape8: TQRShape
      Left = 623
      Top = 60
      Width = 102
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        1648.354166666670000000
        158.750000000000000000
        269.875000000000000000)
      Pen.Width = 3
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object titol1: TQRLabel
      Left = 142
      Top = 62
      Width = 57
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        375.708333333333000000
        164.041666666667000000
        150.812500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '9.999.999,9999'
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
    object titol2: TQRLabel
      Left = 238
      Top = 62
      Width = 57
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        629.708333333333000000
        164.041666666667000000
        150.812500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '9.999.999,9999'
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
    object titol3: TQRLabel
      Left = 342
      Top = 62
      Width = 57
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        904.875000000000000000
        164.041666666667000000
        150.812500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '9.999.999,9999'
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
    object titol4: TQRLabel
      Left = 441
      Top = 62
      Width = 57
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1166.812500000000000000
        164.041666666667000000
        150.812500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '9.999.999,9999'
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
    object titol5: TQRLabel
      Left = 545
      Top = 62
      Width = 57
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1441.979166666670000000
        164.041666666667000000
        150.812500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '9.999.999,9999'
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
    object titol6: TQRLabel
      Left = 647
      Top = 62
      Width = 57
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1711.854166666670000000
        164.041666666667000000
        150.812500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '9.999.999,9999'
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
    object PsQRShape3: TQRShape
      Left = 16
      Top = 60
      Width = 100
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        42.333333333333300000
        158.750000000000000000
        264.583333333333000000)
      Pen.Width = 3
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object LFec: TQRLabel
      Left = 27
      Top = 62
      Width = 83
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        71.437500000000000000
        164.041666666667000000
        219.604166666667000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'FECHA'
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
  end
  object detalle: TQRBand
    Left = 38
    Top = 118
    Width = 1047
    Height = 21
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    BeforePrint = detalleBeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      55.562500000000000000
      2770.187500000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbDetail
    object cuadroFecha: TQRShape
      Left = 16
      Top = 0
      Width = 101
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        42.333333333333300000
        0.000000000000000000
        267.229166666667000000)
      Pen.Width = 3
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object cuadro2: TQRShape
      Left = 217
      Top = 0
      Width = 102
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        574.145833333333000000
        0.000000000000000000
        269.875000000000000000)
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object cuadro1: TQRShape
      Left = 116
      Top = 0
      Width = 102
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        306.916666666667000000
        0.000000000000000000
        269.875000000000000000)
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object fecha_ce: TQRDBText
      Left = 25
      Top = 3
      Width = 83
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        66.145833333333300000
        7.937500000000000000
        219.604166666667000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = DMBaseDatos.QListado
      DataField = 'fecha_ce'
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
    object cuadro4: TQRShape
      Left = 420
      Top = 0
      Width = 102
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        1111.250000000000000000
        0.000000000000000000
        269.875000000000000000)
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object cuadro3: TQRShape
      Left = 319
      Top = 0
      Width = 102
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        844.020833333334000000
        0.000000000000000000
        269.875000000000000000)
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object cuadro6: TQRShape
      Left = 622
      Top = 0
      Width = 102
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        1645.708333333330000000
        0.000000000000000000
        269.875000000000000000)
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object cuadro5: TQRShape
      Left = 521
      Top = 0
      Width = 102
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        1378.479166666670000000
        0.000000000000000000
        269.875000000000000000)
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object cuadro8: TQRShape
      Left = 825
      Top = 0
      Width = 102
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        2182.812500000000000000
        0.000000000000000000
        269.875000000000000000)
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object cuadro7: TQRShape
      Left = 724
      Top = 0
      Width = 102
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        1915.583333333330000000
        0.000000000000000000
        269.875000000000000000)
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object cuadro9: TQRShape
      Left = 926
      Top = 0
      Width = 102
      Height = 21
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        55.562500000000000000
        2450.041666666670000000
        0.000000000000000000
        269.875000000000000000)
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object campo1: TQRLabel
      Left = 120
      Top = 2
      Width = 94
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        317.500000000000000000
        5.291666666666670000
        248.708333333333000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '9.999.999,9999'
      Color = clWhite
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object campo2: TQRLabel
      Left = 222
      Top = 2
      Width = 94
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        587.375000000000000000
        5.291666666666670000
        248.708333333333000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '9.999.999,9999'
      Color = clWhite
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object campo3: TQRLabel
      Left = 321
      Top = 2
      Width = 94
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        849.312500000000000000
        5.291666666666670000
        248.708333333333000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '9.999.999,9999'
      Color = clWhite
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object campo4: TQRLabel
      Left = 424
      Top = 2
      Width = 94
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1121.833333333330000000
        5.291666666666670000
        248.708333333333000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '9.999.999,9999'
      Color = clWhite
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object campo5: TQRLabel
      Left = 525
      Top = 2
      Width = 94
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1389.062500000000000000
        5.291666666666670000
        248.708333333333000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '9.999.999,9999'
      Color = clWhite
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object campo6: TQRLabel
      Left = 627
      Top = 2
      Width = 94
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1658.937500000000000000
        5.291666666666670000
        248.708333333333000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '9.999.999,9999'
      Color = clWhite
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object campo7: TQRLabel
      Left = 728
      Top = 2
      Width = 94
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        1926.166666666670000000
        5.291666666666670000
        248.708333333333000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '9.999.999,9999'
      Color = clWhite
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object campo8: TQRLabel
      Left = 829
      Top = 2
      Width = 94
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        2193.395833333330000000
        5.291666666666670000
        248.708333333333000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '9.999.999,9999'
      Color = clWhite
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object campo9: TQRLabel
      Left = 931
      Top = 2
      Width = 94
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        2463.270833333330000000
        5.291666666666670000
        248.708333333333000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '9.999.999,9999'
      Color = clWhite
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
  end
  object PageFooterBand1: TQRBand
    Left = 38
    Top = 139
    Width = 1047
    Height = 17
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
      44.979166666666670000
      2770.187500000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbPageFooter
    object PsQRSysData1: TQRSysData
      Left = 967
      Top = 1
      Width = 80
      Height = 15
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        39.687500000000000000
        2558.520833333333000000
        2.645833333333333000
        211.666666666666700000)
      Alignment = taRightJustify
      AlignToBand = True
      AutoSize = True
      Color = clWhite
      Data = qrsPageNumber
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Text = 'P'#225'gina:  '
      Transparent = False
      FontSize = 8
    end
  end
  object QCalculoColumnas: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT Max((SELECT Count(*) FROM frf_cambios_euros MONEDA'
      '                        WHERE fecha_ce= M.fecha_ce))  As cuenta'
      'FROM frf_cambios_euros M')
    Left = 352
    Top = 40
  end
  object QCalculoFecha: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT fecha_ce,(SELECT Count(*) FROM frf_cambios_euros MONEDA'
      '             WHERE fecha_ce= M.fecha_ce)  As cuenta,moneda_ce'
      'FROM frf_cambios_euros M'
      'ORDER BY cuenta DESC,moneda_ce')
    Left = 392
    Top = 40
  end
  object QLineas: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT fecha_ce,moneda_ce,cambio_ce'
      'FROM frf_cambios_euros Frf_cambios_euros'
      'ORDER BY fecha_ce,moneda_ce')
    Left = 304
    Top = 40
    object QLineasfecha_ce: TDateField
      FieldName = 'fecha_ce'
      Origin = 'frf_cambios_euros.fecha_ce'
    end
    object QLineasmoneda_ce: TStringField
      FieldName = 'moneda_ce'
      Origin = 'frf_cambios_euros.moneda_ce'
      Size = 3
    end
    object QLineascambio_ce: TFloatField
      FieldName = 'cambio_ce'
      Origin = 'frf_cambios_euros.cambio_ce'
    end
  end
end
