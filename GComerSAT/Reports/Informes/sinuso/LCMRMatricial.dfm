object QRLCMRMatricial: TQRLCMRMatricial
  Left = 0
  Top = -233
  Width = 794
  Height = 1123
  Frame.Color = clBlack
  Frame.DrawTop = False
  Frame.DrawBottom = False
  Frame.DrawLeft = False
  Frame.DrawRight = False
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
    114.4
    2970
    45
    2100
    47.2
    47.2
    0)
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
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      2815.16666666667
      2005.54166666667)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbDetail
    object cmrObservaciones: TQRMemo
      Left = 45
      Top = 672
      Width = 660
      Height = 193
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        510.645833333333
        119.0625
        1778
        1746.25)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
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
    object LRazon: TQRMemo
      Left = 46
      Top = 1
      Width = 173
      Height = 86
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        227.541666666667
        121.708333333333
        2.64583333333333
        457.729166666667)
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
        'CIF: F03842671'
        'Camino de los Llanos,   22'
        '03110   MUCHAMIEL   ( Alicante )')
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object qrmCliente: TQRMemo
      Left = 46
      Top = 94
      Width = 173
      Height = 68
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        179.916666666667
        121.708333333333
        248.708333333333
        457.729166666667)
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
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object fecha_sc: TQRDBText
      Left = 184
      Top = 265
      Width = 73
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.9791666666667
        486.833333333333
        701.145833333333
        193.145833333333)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = DMBaseDatos.QListado
      DataField = 'fecha_sc'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object marcas: TQRMemo
      Left = 43
      Top = 393
      Width = 119
      Height = 137
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        362.479166666667
        113.770833333333
        1039.8125
        314.854166666667)
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
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object cajas: TQRMemo
      Left = 172
      Top = 393
      Width = 36
      Height = 137
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        362.479166666667
        455.083333333333
        1039.8125
        95.25)
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
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object agrupacion: TQRMemo
      Left = 240
      Top = 393
      Width = 337
      Height = 137
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        362.479166666667
        635
        1039.8125
        891.645833333333)
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
      WordWrap = True
      FontSize = 8
    end
    object volumen: TQRMemo
      Left = 548
      Top = 393
      Width = 81
      Height = 137
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        362.479166666667
        1449.91666666667
        1039.8125
        214.3125)
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
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object producto: TQRMemo
      Left = 364
      Top = 393
      Width = 73
      Height = 137
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        362.479166666667
        963.083333333333
        1039.8125
        193.145833333333)
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
        'TOMATES (Q)')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object LMatricula: TQRLabel
      Left = 448
      Top = 200
      Width = 58
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.9791666666667
        1185.33333333333
        529.166666666667
        153.458333333333)
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
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object LOrigen2: TQRLabel
      Left = 78
      Top = 875
      Width = 67
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.9791666666667
        206.375
        2315.10416666667
        177.270833333333)
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
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object fecha_sc2: TQRDBText
      Left = 216
      Top = 875
      Width = 73
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.9791666666667
        571.5
        2315.10416666667
        193.145833333333)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = DMBaseDatos.QListado
      DataField = 'fecha_sc'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 8
    end
    object qrmSuministro: TQRMemo
      Left = 46
      Top = 195
      Width = 370
      Height = 66
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        174.625
        121.708333333333
        515.9375
        978.958333333333)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = True
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Lines.Strings = (
        'S.A.T.  N'#186'  9359  BONNYSA'
        'O.P.F.H.  N'#186'  345'
        'Camino de los Llanos,   22'
        '03110   MUCHAMIEL   ( Alicante )'
        
          'LO, Lomonosovskii r-n, MO Villozskoe s.p., "Oficerskoe selo", Vo' +
          'lhonsfoe Shosse, , kvart 1, d.11 B')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 6
    end
    object qrmByBAI: TQRMemo
      Left = 230
      Top = 1
      Width = 156
      Height = 86
      Enabled = False
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        227.541666666667
        608.541666666667
        2.64583333333333
        412.75)
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
        'by order of "FRUITCOM Inc." '
        '  Contract N'#186' FC-11/06.09 '
        '  OT 01.07.2009')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object qrlblCasilla15: TQRLabel
      Left = 412
      Top = 883
      Width = 231
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.9791666666667
        1090.08333333333
        2336.27083333333
        611.1875)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Terms of delivery - CPT Saint -Petersburg'
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
    object qrmOrigen: TQRMemo
      Left = 46
      Top = 265
      Width = 135
      Height = 43
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        113.770833333333
        121.708333333333
        701.145833333333
        357.1875)
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
        'MUCHAMIEL')
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 8
    end
    object QRImgFirma: TQRImage
      Left = 303
      Top = 948
      Width = 140
      Height = 64
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        169.333333333333
        801.6875
        2508.25
        370.416666666667)
    end
  end
  object qNota: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      '')
    Left = 374
    Top = 70
  end
  object QDetallesCMR: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      ''
      ''
      ' '
      ' ')
    Left = 405
    Top = 72
  end
  object QPesoEnvase: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      ''
      ' '
      ' ')
    Left = 435
    Top = 73
  end
  object QPesoPalet: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      ''
      ' '
      ' ')
    Left = 468
    Top = 74
  end
end
