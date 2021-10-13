object QRLTipoEntregas: TQRLTipoEntregas
  Left = 0
  Top = 0
  Width = 794
  Height = 1123
  Frame.Color = clBlack
  Frame.DrawTop = False
  Frame.DrawBottom = False
  Frame.DrawLeft = False
  Frame.DrawRight = False
  DataSet = QListado
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
    99
    2970
    99
    2100
    99.2
    99.2
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
  ReportTitle = 'Tipo de Entradas'
  SnapToGrid = True
  Units = MM
  Zoom = 100
  PrevFormStyle = fsNormal
  PreviewInitialState = wsNormal
  PrevInitialZoom = qrZoomToFit
  object PageFooterBand1: TQRBand
    Left = 37
    Top = 153
    Width = 719
    Height = 33
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
      87.3125
      1902.35416666667)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbPageFooter
    object QRSysData1: TQRSysData
      Left = 621
      Top = 8
      Width = 98
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.9791666666667
        1643.0625
        21.1666666666667
        259.291666666667)
      Alignment = taRightJustify
      AlignToBand = True
      AutoSize = True
      Color = clWhite
      Data = qrsPageNumber
      OnPrint = QRSysData1Print
      Text = 'P'#225'gina:  '
      Transparent = False
      FontSize = 10
    end
  end
  object DetailBand1: TQRBand
    Left = 37
    Top = 134
    Width = 719
    Height = 19
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
      50.2708333333333
      1902.35416666667)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbDetail
    object tipo_et: TQRDBText
      Left = 62
      Top = 1
      Width = 46
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.9791666666667
        164.041666666667
        2.64583333333333
        121.708333333333)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clNone
      DataSet = QListado
      DataField = 'tipo_et'
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
    object descripcion_et: TQRDBText
      Left = 123
      Top = 1
      Width = 262
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.9791666666667
        325.4375
        2.64583333333333
        693.208333333333)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = True
      Color = clNone
      DataSet = QListado
      DataField = 'descripcion_et'
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
    object ajuste_et: TQRDBText
      Left = 396
      Top = 1
      Width = 117
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.9791666666667
        1047.75
        2.64583333333333
        309.5625)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clNone
      DataSet = QListado
      DataField = 'ajuste_et'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      OnPrint = ajuste_etPrint
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 9
    end
    object qremerma_et: TQRDBText
      Left = 516
      Top = 1
      Width = 117
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.9791666666667
        1365.25
        2.64583333333333
        309.5625)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clNone
      DataSet = QListado
      DataField = 'merma_et'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      OnPrint = qremerma_etPrint
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 9
    end
  end
  object ColumnHeaderBand1: TQRBand
    Left = 37
    Top = 97
    Width = 719
    Height = 18
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = True
    Frame.DrawLeft = False
    Frame.DrawRight = False
    Frame.Width = 2
    AlignToBottom = False
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      47.625
      1902.35416666667)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbColumnHeader
    object QRLabel2: TQRLabel
      Left = 62
      Top = 0
      Width = 46
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.9791666666667
        164.041666666667
        0
        121.708333333333)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'C'#243'digo'
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
    object QRLabel3: TQRLabel
      Left = 123
      Top = 0
      Width = 75
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.9791666666667
        325.4375
        0
        198.4375)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Descripci'#243'n'
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
    object QRLabel5: TQRLabel
      Left = 396
      Top = 0
      Width = 66
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.9791666666667
        1047.75
        0
        174.625)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Ajuste'
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
    object QRLabel6: TQRLabel
      Left = 0
      Top = 0
      Width = 56
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.9791666666667
        0
        0
        148.166666666667)
      Alignment = taLeftJustify
      AlignToBand = True
      AutoSize = True
      AutoStretch = False
      Caption = 'Empresa'
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
    object qrl1: TQRLabel
      Left = 516
      Top = 0
      Width = 66
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.9791666666667
        1365.25
        0
        174.625)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Merma'
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
  object QRBand1: TQRBand
    Left = 37
    Top = 37
    Width = 719
    Height = 60
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    Frame.Width = 2
    AlignToBottom = False
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      158.75
      1902.35416666667)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbPageHeader
    object PsQRLabel4: TQRLabel
      Left = 241
      Top = 15
      Width = 236
      Height = 33
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        87.3125
        637.645833333333
        39.6875
        624.416666666667)
      Alignment = taCenter
      AlignToBand = True
      AutoSize = True
      AutoStretch = False
      Caption = 'TIPO DE ENTRADAS'
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
    object PsQRSysData1: TQRSysData
      Left = 636
      Top = 5
      Width = 83
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.9791666666667
        1682.75
        13.2291666666667
        219.604166666667)
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
      Text = 'Impreso el '
      Transparent = False
      FontSize = 8
    end
  end
  object qrgEmpresa: TQRGroup
    Left = 37
    Top = 115
    Width = 719
    Height = 19
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
      50.2708333333333
      1902.35416666667)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Expression = '[empresa_et]'
    Master = Owner
    ReprintOnNewPage = False
    object qreempresa_et: TQRDBText
      Left = 0
      Top = 1
      Width = 465
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.9791666666667
        0
        2.64583333333333
        1230.3125)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clNone
      DataSet = QListado
      DataField = 'empresa_et'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      OnPrint = qreempresa_etPrint
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 9
    end
  end
  object QListado: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        '--ANSI== SELECT Frf_productos.descripcion_p, Frf_envases.descrip' +
        'cion_e, Frf_marcas.descripcion_m, Frf_color.descripcion_c, Frf_s' +
        'alidas_l.calibre_sl, Frf_salidas_l.cajas_sl, Frf_salidas_l.kilos' +
        '_sl, Frf_salidas_l.precio_sl, Frf_salidas_l.unidad_precio_sl, Fr' +
        'f_salidas_l.precio_neto_sl, Frf_tipo_palets.descripcion_tp'
      
        '--ANSI== FROM frf_salidas_l Frf_salidas_l, frf_productos Frf_pro' +
        'ductos, frf_envases Frf_envases, frf_marcas Frf_marcas, frf_colo' +
        'r Frf_color'
      '--ANSI==    LEFT OUTER JOIN frf_tipo_palets Frf_tipo_palets'
      
        '--ANSI==    ON  (Frf_salidas_l.tipo_palets_sl = Frf_tipo_palets.' +
        'codigo_tp)  '
      
        '--ANSI== WHERE  (Frf_salidas_l.empresa_sl = Frf_productos.empres' +
        'a_p)  '
      
        '--ANSI==    AND  (Frf_salidas_l.producto_sl = Frf_productos.prod' +
        'ucto_p)  '
      
        '--ANSI==    AND  (Frf_salidas_l.envase_sl = Frf_envases.envase_e' +
        ')  '
      
        '--ANSI==    AND  (Frf_salidas_l.marca_sl = Frf_marcas.codigo_m) ' +
        ' '
      
        '--ANSI==    AND  (Frf_salidas_l.empresa_sl = Frf_color.empresa_c' +
        ')  '
      
        '--ANSI==    AND  (Frf_salidas_l.producto_sl = Frf_color.producto' +
        '_c)  '
      '--ANSI==    AND  (Frf_salidas_l.color_sl = Frf_color.color_c)  '
      ''
      
        'SELECT Frf_productos.descripcion_p, Frf_envases.descripcion_e, F' +
        'rf_marcas.descripcion_m, Frf_color.descripcion_c, Frf_salidas_l.' +
        'calibre_sl, Frf_salidas_l.cajas_sl, Frf_salidas_l.kilos_sl, Frf_' +
        'salidas_l.precio_sl, Frf_salidas_l.unidad_precio_sl, Frf_salidas' +
        '_l.precio_neto_sl, Frf_tipo_palets.descripcion_tp'
      
        'FROM frf_salidas_l Frf_salidas_l, frf_productos Frf_productos, f' +
        'rf_envases Frf_envases, frf_marcas Frf_marcas, frf_color Frf_col' +
        'or, OUTER frf_tipo_palets Frf_tipo_palets'
      'WHERE  (Frf_salidas_l.empresa_sl = Frf_productos.empresa_p)  '
      '   AND  (Frf_salidas_l.producto_sl = Frf_productos.producto_p)  '
      '   AND  (Frf_salidas_l.envase_sl = Frf_envases.envase_e)  '
      '   AND  (Frf_salidas_l.marca_sl = Frf_marcas.codigo_m)  '
      '   AND  (Frf_salidas_l.empresa_sl = Frf_color.empresa_c)  '
      '   AND  (Frf_salidas_l.producto_sl = Frf_color.producto_c)  '
      '   AND  (Frf_salidas_l.color_sl = Frf_color.color_c)  '
      
        '   AND  (Frf_salidas_l.tipo_palets_sl = Frf_tipo_palets.codigo_t' +
        'p)  ')
    Left = 8
    Top = 32
  end
end
