object QRLCMRInyeccion: TQRLCMRInyeccion
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
    object qrmRemitente: TQRMemo
      Left = 23
      Top = 57
      Width = 171
      Height = 83
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        219.604166666666700000
        60.854166666666670000
        150.812500000000000000
        452.437500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'BONNYSA AGROALIMENTARIA'
        'PARTIDA BAYONA BAJA S/N'
        '03110 MUCHAMIEL ( ALICANTE) ')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object dirSuministro: TQRMemo
      Left = 23
      Top = 154
      Width = 173
      Height = 83
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        219.604166666666700000
        60.854166666666670000
        407.458333333333300000
        457.729166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
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
      FontSize = 8
    end
    object qrmObservaciones: TQRMemo
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
      Width = 119
      Height = 137
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        362.479166666667000000
        60.854166666666700000
        1166.812500000000000000
        314.854166666667000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'XXXXXXXXXXXX'
        'XXXXXXXXXXXX'
        'XXXXXXXXXXXX')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object qrmCajas: TQRMemo
      Left = 158
      Top = 441
      Width = 57
      Height = 137
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        362.479166666667000000
        418.041666666667000000
        1166.812500000000000000
        150.812500000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
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
      FontSize = 8
    end
    object agrupacion: TQRMemo
      Left = 244
      Top = 441
      Width = 349
      Height = 137
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        362.479166666667000000
        645.583333333333000000
        1166.812500000000000000
        923.395833333333000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = True
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'TOMATES (Q)')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object qrmPesoBruto: TQRMemo
      Left = 597
      Top = 441
      Width = 61
      Height = 137
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        362.479166666667000000
        1579.562500000000000000
        1166.812500000000000000
        161.395833333333000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
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
      FontSize = 8
    end
    object qrmNaturaleza: TQRMemo
      Left = 347
      Top = 441
      Width = 246
      Height = 137
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        362.479166666667000000
        918.104166666667000000
        1166.812500000000000000
        650.875000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'TOMATES (Q)')
      ParentFont = False
      Transparent = True
      WordWrap = False
      FontSize = 8
    end
    object LMatricula: TQRLabel
      Left = 412
      Top = 253
      Width = 58
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1090.083333333333000000
        669.395833333333300000
        153.458333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'LMatricula'
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
    object qrlLugarOrigen2: TQRLabel
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
      Top = 157
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
        415.395833333333000000
        881.062500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'Datos Transportistas')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
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
    object qrmLugarEntrega: TQRMemo
      Left = 23
      Top = 247
      Width = 173
      Height = 42
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        111.125000000000000000
        60.854166666666670000
        653.520833333333300000
        457.729166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = True
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
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
      FontSize = 8
    end
    object qrmLugarOrigen: TQRMemo
      Left = 23
      Top = 314
      Width = 196
      Height = 60
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        158.750000000000000000
        60.854166666666670000
        830.791666666666700000
        518.583333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = True
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'S.A.T.  N'#186'  9359  BONNYSA O.P.F.H.  N'#186'  345'
        'Camino de los Llanos,   22'
        '03110   MUCHAMIEL   ( Alicante )')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 7
    end
    object qrlblFecha: TQRLabel
      Left = 276
      Top = 314
      Width = 33
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        730.250000000000000000
        830.791666666666700000
        87.312500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Fecha'
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
    object qrlblFecha2: TQRLabel
      Left = 201
      Top = 914
      Width = 33
      Height = 15
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        39.687500000000000000
        531.812500000000000000
        2418.291666666667000000
        87.312500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Fecha'
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
  end
  object QDetallesCMR: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      ''
      ''
      ' '
      ' ')
    Left = 345
    Top = 24
  end
  object QPesoEnvase: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      ''
      ' '
      ' ')
    Left = 373
    Top = 24
  end
  object qNota: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      '')
    Left = 317
    Top = 24
  end
  object QPesoPalet: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      ''
      ' '
      ' ')
    Left = 405
    Top = 24
  end
end
