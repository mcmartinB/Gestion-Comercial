object QRLCMREdeka: TQRLCMREdeka
  Left = 0
  Top = 0
  Width = 794
  Height = 1123
  Frame.Color = clBlack
  Frame.DrawTop = False
  Frame.DrawBottom = False
  Frame.DrawLeft = False
  Frame.DrawRight = False
  BeforePrint = QuickRepBeforePrint
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
    114.400000000000000000
    2970.000000000000000000
    45.000000000000000000
    2100.000000000000000000
    47.200000000000000000
    47.200000000000000000
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
  ReportTitle = 'Carta de Transporte Internacional de Mercanc'#237'as por Carretera'
  SnapToGrid = True
  Units = MM
  Zoom = 100
  PrevFormStyle = fsNormal
  PreviewInitialState = wsNormal
  PrevInitialZoom = qrZoomToFit
  object detalles: TQRBand
    Left = 18
    Top = 17
    Width = 758
    Height = 1064
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    BeforePrint = detallesBeforePrint
    Color = clWhite
    TransparentBand = True
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      2815.166666666667000000
      2005.541666666667000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbDetail
    object QRImage: TQRImage
      Left = 0
      Top = 24
      Width = 758
      Height = 1040
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        2751.666666666667000000
        0.000000000000000000
        63.500000000000000000
        2005.541666666667000000)
      Stretch = True
    end
    object qrmSalida: TQRMemo
      Left = 23
      Top = 316
      Width = 300
      Height = 49
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        129.645833333333000000
        60.854166666666700000
        836.083333333333000000
        793.750000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'S.A.T.  N'#186'  9359  BONNYSA'
        'O.P.F.H.  N'#186'  345'
        'Camino de los Llanos,   22'
        '03110   MUCHAMIEL   ( Alicante )')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 7
    end
    object qrmSuministro: TQRMemo
      Left = 23
      Top = 243
      Width = 300
      Height = 56
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        148.166666666667000000
        60.854166666666700000
        642.937500000000000000
        793.750000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'S.A.T.  N'#186'  9359  BONNYSA'
        'O.P.F.H.  N'#186'  345'
        'Camino de los Llanos,   22'
        '03110   MUCHAMIEL   ( Alicante )')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 7
    end
    object qrmRazon: TQRMemo
      Left = 23
      Top = 57
      Width = 300
      Height = 73
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        193.145833333333000000
        60.854166666666700000
        150.812500000000000000
        793.750000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'BONNYSA AGROALIMENTARIA'
        'PARTIDA BAYONA BAJA S/N'
        '03110 MUCHAMIEL ( ALICANTE) ')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 7
    end
    object qrmCliente: TQRMemo
      Left = 23
      Top = 151
      Width = 300
      Height = 75
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        198.437500000000000000
        60.854166666666700000
        399.520833333333000000
        793.750000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'S.A.T.  N'#186'  9359  BONNYSA'
        'O.P.F.H.  N'#186'  345'
        'Camino de los Llanos,   22'
        '03110   MUCHAMIEL   ( Alicante )')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 7
    end
    object cmrObservaciones: TQRMemo
      Left = 23
      Top = 716
      Width = 482
      Height = 173
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        457.729166666667000000
        60.854166666666700000
        1894.416666666670000000
        1275.291666666670000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = False
      FontSize = 7
    end
    object marcas: TQRMemo
      Left = 23
      Top = 441
      Width = 77
      Height = 137
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        362.479166666666700000
        60.854166666666670000
        1166.812500000000000000
        203.729166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'XXXXXXXXXXXX'
        'XXXXXXXXXXXX'
        'XXXXXXXXXXXX')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 7
    end
    object cajas: TQRMemo
      Left = 506
      Top = 441
      Width = 57
      Height = 137
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        362.479166666666700000
        1338.791666666667000000
        1166.812500000000000000
        150.812500000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        '99999'
        '99999'
        '99999'
        '99999')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 7
    end
    object agrupacion: TQRMemo
      Left = 147
      Top = 441
      Width = 96
      Height = 137
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        362.479166666666700000
        388.937500000000000000
        1166.812500000000000000
        254.000000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = True
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'TOMATES (Q)')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 7
    end
    object qrmPesoBruto: TQRMemo
      Left = 570
      Top = 441
      Width = 82
      Height = 137
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        362.479166666666700000
        1508.125000000000000000
        1166.812500000000000000
        216.958333333333300000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'BRUTTOGEWICHT'
        '99999'
        '99999'
        '99999'
        '99999')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 7
    end
    object producto: TQRMemo
      Left = 244
      Top = 441
      Width = 121
      Height = 137
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        362.479166666666700000
        645.583333333333300000
        1166.812500000000000000
        320.145833333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'TOMATES (Q)')
      ParentFont = False
      Transparent = True
      WordWrap = False
      FontSize = 7
    end
    object LMatricula: TQRLabel
      Left = 412
      Top = 243
      Width = 48
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1090.083333333333000000
        642.937500000000000000
        127.000000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'LMatricula'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 7
    end
    object lblNumeroPagina: TQRLabel
      Left = 4
      Top = 4
      Width = 13
      Height = 25
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        66.145833333333330000
        10.583333333333330000
        10.583333333333330000
        34.395833333333330000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = '1'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 16
    end
    object lblDescripcionHoja: TQRLabel
      Left = 21
      Top = 4
      Width = 404
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        55.562500000000000000
        10.583333333333330000
        1068.916666666667000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 
        'Ejemplar para el remitente - Exemplaire de l'#39'exp'#233'diteur - Copy f' +
        'or Sender'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object lblCodigoCmr: TQRLabel
      Left = 634
      Top = 4
      Width = 111
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        1677.458333333333000000
        10.583333333333330000
        293.687500000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'N'#186': C106012'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 12
    end
    object QRMTransportista: TQRMemo
      Left = 412
      Top = 151
      Width = 333
      Height = 71
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        187.854166666667000000
        1090.083333333330000000
        399.520833333333000000
        881.062500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'Datos Transportistas')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 7
    end
    object QRMClausulas: TQRMemo
      Left = 412
      Top = 695
      Width = 325
      Height = 77
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        203.729166666667000000
        1090.083333333330000000
        1838.854166666670000000
        859.895833333333000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'Clausulas Transportistas')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 7
    end
    object qrlFormalizadoEn: TQRLabel
      Left = 97
      Top = 914
      Width = 67
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        256.645833333333300000
        2418.291666666667000000
        177.270833333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'MUCHAMIEL'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object qrlFormalizadoFecha: TQRLabel
      Left = 209
      Top = 914
      Width = 67
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        552.979166666666700000
        2418.291666666667000000
        177.270833333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'MUCHAMIEL'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object qrmTransporte2: TQRMemo
      Left = 275
      Top = 958
      Width = 333
      Height = 71
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        187.854166666667000000
        727.604166666667000000
        2534.708333333330000000
        881.062500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'Datos Transportistas')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 6
    end
    object QRImgFirma: TQRImage
      Left = 393
      Top = 1000
      Width = 140
      Height = 64
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        169.333333333333300000
        1039.812500000000000000
        2645.833333333333000000
        370.416666666666700000)
    end
    object categoria: TQRMemo
      Left = 417
      Top = 441
      Width = 47
      Height = 137
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        362.479166666666700000
        1103.312500000000000000
        1166.812500000000000000
        124.354166666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'XXXXXXXXXXXX'
        'XXXXXXXXXXXX'
        'XXXXXXXXXXXX')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 7
    end
    object pais: TQRMemo
      Left = 367
      Top = 441
      Width = 50
      Height = 137
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        362.479166666666700000
        971.020833333333300000
        1166.812500000000000000
        132.291666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'TOMATES (Q)')
      ParentFont = False
      Transparent = True
      WordWrap = False
      FontSize = 7
    end
    object calibre: TQRMemo
      Left = 464
      Top = 441
      Width = 40
      Height = 137
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        362.479166666666700000
        1227.666666666667000000
        1166.812500000000000000
        105.833333333333300000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'TOMATES (Q)')
      ParentFont = False
      Transparent = True
      WordWrap = False
      FontSize = 7
    end
    object lote: TQRMemo
      Left = 103
      Top = 441
      Width = 41
      Height = 137
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        362.479166666666700000
        272.520833333333300000
        1166.812500000000000000
        108.479166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'XXXXXXXXXXXX'
        'XXXXXXXXXXXX'
        'XXXXXXXXXXXX')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 7
    end
    object qrmPalets: TQRMemo
      Left = 23
      Top = 382
      Width = 300
      Height = 13
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        34.395833333333330000
        60.854166666666670000
        1010.708333333333000000
        793.750000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'S.A.T.  N'#186'  9359  BONNYSA'
        'O.P.F.H.  N'#186'  345'
        'Camino de los Llanos,   22'
        '03110   MUCHAMIEL   ( Alicante )')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 7
    end
  end
  object QDetallesCMR: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      ''
      ''
      ' '
      ' ')
    Left = 337
    Top = 56
  end
  object QPesoEnvase: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      ''
      ' '
      ' ')
    Left = 365
    Top = 56
  end
  object QPesoPalet: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      ''
      ' '
      ' ')
    Left = 397
    Top = 56
  end
end
