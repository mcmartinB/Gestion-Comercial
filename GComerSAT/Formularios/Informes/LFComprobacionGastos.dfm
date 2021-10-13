object FLComprobacionGastos: TFLComprobacionGastos
  Left = 292
  Top = 249
  ActiveControl = eEmpresa
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = ' COMPROBACI'#211'N DE LA GRABACI'#211'N DE GASTOS'
  ClientHeight = 268
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 564
    Height = 268
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 353
      Top = 221
      Width = 89
      Height = 25
      Action = BAceptar
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000FF0000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000000FF000000FFBF0000FF00000000BFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000000FF000000FFBF0000FF00000000BFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000000FF000000FF000000FFBF0000FF000000FFBF00000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000000FF000000FFBF0000FF000000FFBF0000FF000000FFBF00000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007F7F
        7F000000FF3F0000FFBF00000000FF00FF000000FF000000FFBF0000FF000000
        00BFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007F7F7F000000
        FF3F00000000FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000
        00BFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000
        FFBF00000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000
        FFBF00000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        FF000000FF00000000BFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF007F7F7F000000FF3F00000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF007F7F7F000000FF3F000000BFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000FF000000FF00000000BFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
    end
    object SpeedButton2: TSpeedButton
      Left = 448
      Top = 221
      Width = 89
      Height = 25
      Action = BCancelar
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FFBFFF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00
        FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
        FFBF0000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
        0000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
        FFBF00000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000000000000000000000000000FFFFFF00FF00FFBFFF00
        FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FFBFFF00
        FF0000000000000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
    end
    object Label3: TLabel
      Left = 24
      Top = 73
      Width = 81
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 24
      Top = 96
      Width = 81
      Height = 19
      AutoSize = False
      Caption = ' Fecha Desde'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BCBDesde: TBCalendarButton
      Left = 180
      Top = 95
      Width = 17
      Height = 21
      Action = ADesplegarRejilla
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      NumGlyphs = 2
      Control = EDesde
      Calendar = CalendarioFlotante
      CalendarAlignment = taCenterRight
      CalendarWidth = 177
      CalendarHeigth = 140
    end
    object Label2: TLabel
      Left = 198
      Top = 96
      Width = 40
      Height = 19
      AutoSize = False
      Caption = ' Hasta'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BCBHasta: TBCalendarButton
      Left = 310
      Top = 95
      Width = 17
      Height = 21
      Action = ADesplegarRejilla
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      NumGlyphs = 2
      Control = EHasta
      Calendar = CalendarioFlotante
      CalendarAlignment = taCenterRight
      CalendarWidth = 177
      CalendarHeigth = 140
    end
    object Label4: TLabel
      Left = 24
      Top = 120
      Width = 81
      Height = 19
      AutoSize = False
      Caption = ' Cliente'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object mmoDescripcion: TMemo
      Left = 24
      Top = 145
      Width = 303
      Height = 101
      TabStop = False
      Color = clScrollBar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 9
    end
    object eEmpresa: TBEdit
      Left = 107
      Top = 72
      Width = 34
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      MaxLength = 3
      TabOrder = 3
      OnChange = eEmpresaChange
    end
    object STEmpresa: TStaticText
      Left = 144
      Top = 74
      Width = 182
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 4
    end
    object clbGastosTransito: TCheckListBox
      Left = 336
      Top = 24
      Width = 201
      Height = 185
      ItemHeight = 13
      TabOrder = 1
    end
    object cbxSeleccion: TComboBox
      Left = 24
      Top = 24
      Width = 303
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'Gastos de tr'#225'nsito (ref. n'#186'  albar'#225'n)'
      OnChange = cbxSeleccionChange
      Items.Strings = (
        'Gastos de tr'#225'nsito (ref. n'#186'  albar'#225'n)'
        'Gastos de tr'#225'nsito (ref. n'#186'  tr'#225'nsito)'
        'Gastos de transporte'
        'Gastos de aduana'
        'Gastos de Salidas'
        'Gastos de Entregas'
        'Gastos de Entregas (Transporte)')
    end
    object EDesde: TBEdit
      Left = 107
      Top = 95
      Width = 70
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itDate
      TabOrder = 5
    end
    object EHasta: TBEdit
      Left = 239
      Top = 95
      Width = 70
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itDate
      TabOrder = 6
      OnExit = EHastaExit
    end
    object cbxTipoTransito: TComboBox
      Left = 24
      Top = 48
      Width = 303
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = 'Tr'#225'nsitos de Tenerife a la Peninsula.'
      Items.Strings = (
        'Tr'#225'nsitos de Tenerife a la Peninsula.'
        'Tr'#225'nsitos de la Peninsula a Tenerife.'
        'Tr'#225'nsitos de la Peninsula a Europa (Alemania, Gran Breta'#241'a).')
    end
    object eCliente: TBEdit
      Left = 107
      Top = 119
      Width = 34
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 3
      TabOrder = 7
      OnChange = eClienteChange
    end
    object STCliente: TStaticText
      Left = 144
      Top = 121
      Width = 182
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 8
    end
  end
  object CalendarioFlotante: TBCalendario
    Left = 376
    Top = 30
    Width = 177
    Height = 140
    Date = 36717.371237349540000000
    ShowToday = False
    TabOrder = 1
    Visible = False
    WeekNumbers = True
  end
  object ListaAcciones: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 32
    Top = 220
    object BAceptar: TAction
      Caption = 'Aceptar'
      ShortCut = 112
      OnExecute = BBAceptarClick
    end
    object BCancelar: TAction
      Caption = 'Cancelar'
      ShortCut = 27
      OnExecute = BBCancelarClick
    end
    object ADesplegarRejilla: TAction
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ADesplegarRejillaExecute
    end
  end
  object QLCompGastosTransitos: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT DISTINCT '#39'X'#39' tipo, n_albaran_sl codigo, fecha_sl fecha'
      'FROM  frf_salidas_l'
      'WHERE producto_sl = '#39'E'#39
      'AND   empresa_sl = '#39'050'#39
      'AND   centro_salida_sl = '#39'1'#39
      'AND   fecha_sl BETWEEN :desde AND :hasta'
      'AND   NOT EXISTS ('
      '      SELECT * FROM frf_gastos'
      '      WHERE empresa_g = '#39'050'#39
      '      AND   centro_salida_g = '#39'1'#39
      '      AND   n_albaran_g = n_albaran_sl'
      '      AND   fecha_g = fecha_sl'
      '      AND   tipo_g IN (:tipoA, :tipoB))'
      'ORDER BY 1,2'
      ''
      '')
    Left = 32
    Top = 184
    ParamData = <
      item
        DataType = ftDate
        Name = 'desde'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'hasta'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'tipoA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'tipoB'
        ParamType = ptUnknown
      end>
  end
  object QLCompGastosTransporte: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'SELECT '#39'X'#39' tipo, n_albaran_sc codigo, fecha_sc fecha, transporte' +
        '_sc transporte,cliente_fac_sc cliente, vehiculo_sc matricula'
      'FROM  frf_salidas_c'
      'WHERE (transporte_sc IN ('#39'1'#39','#39'2'#39','#39'4'#39','#39'6'#39','#39'274'#39')'
      'OR   cliente_sal_sc[1,1] = '#39'3'#39')'
      'AND   empresa_sc = '#39'050'#39
      'AND   fecha_sc BETWEEN :desde AND :hasta'
      'AND   NOT EXISTS ('
      '      SELECT * FROM frf_gastos'
      '      WHERE empresa_g = '#39'050'#39
      '      AND   centro_salida_g = centro_salida_sc'
      '      AND   n_albaran_g = n_albaran_sc'
      '      AND   fecha_g = fecha_sc'
      '      AND   tipo_g = '#39'009'#39')'
      'ORDER BY 1, 3, 2'
      ' ')
    Left = 64
    Top = 184
    ParamData = <
      item
        DataType = ftDate
        Name = 'desde'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'hasta'
        ParamType = ptInput
      end>
  end
  object QLCompGastosAduana: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      
        'SELECT '#39'X'#39' tipo, n_albaran_sc codigo, fecha_sc fecha, cliente_sa' +
        'l_sc transporte, vehiculo_sc matricula'
      'FROM  frf_salidas_c'
      
        'WHERE cliente_sal_sc IN ('#39'BB'#39','#39'BC'#39','#39'BO'#39','#39'EU'#39','#39'HJ'#39','#39'HO'#39','#39'IS'#39','#39'NK'#39 +
        ','#39'NG'#39','#39'TA'#39','#39'SU'#39')'
      'AND   empresa_sc = '#39'050'#39
      'AND   fecha_sc BETWEEN :desde AND :hasta'
      'AND   NOT EXISTS ('
      '      SELECT * FROM frf_gastos'
      '      WHERE empresa_g = '#39'050'#39
      '      AND   centro_salida_g = centro_salida_sc'
      '      AND   n_albaran_g = n_albaran_sc'
      '      AND   fecha_g = fecha_sc'
      '      AND   tipo_g = '#39'010'#39')'
      'ORDER BY 3,2'
      '')
    Left = 96
    Top = 184
    ParamData = <
      item
        DataType = ftDate
        Name = 'desde'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'hasta'
        ParamType = ptInput
      end>
  end
  object QLCompGastosTransitos2: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT DISTINCT '#39'X'#39' tipo, referencia_tl codigo, fecha_tl fecha'
      'FROM  frf_transitos_l'
      'WHERE producto_tl = '#39'E'#39
      'AND   empresa_tl = '#39'050'#39
      'AND   centro_tl = '#39'6'#39
      'AND   fecha_tl BETWEEN :desde AND :hasta'
      'AND   NOT EXISTS ('
      '      SELECT * FROM frf_gastos_trans'
      '      WHERE empresa_gt = '#39'050'#39
      '      AND   centro_gt = '#39'6'#39
      '      AND   referencia_gt = referencia_tl '
      '      AND   fecha_gt = fecha_tl '
      '      AND   tipo_gt IN (:tipoA, :tipoB)) '
      'ORDER BY 1,2'
      '')
    Left = 128
    Top = 184
    ParamData = <
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
        Name = 'tipoA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'tipoB'
        ParamType = ptUnknown
      end>
  end
  object QLCompGastosEntregas: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT DISTINCT '#39'X'#39' tipo, referencia_tl codigo, fecha_tl fecha'
      'FROM  frf_transitos_l'
      'WHERE producto_tl = '#39'E'#39
      'AND   empresa_tl = '#39'050'#39
      'AND   centro_tl = '#39'6'#39
      'AND   fecha_tl BETWEEN :desde AND :hasta'
      'AND   NOT EXISTS ('
      '      SELECT * FROM frf_gastos_trans'
      '      WHERE empresa_gt = '#39'050'#39
      '      AND   centro_gt = '#39'6'#39
      '      AND   referencia_gt = referencia_tl '
      '      AND   fecha_gt = fecha_tl '
      '      AND   tipo_gt IN (:tipoA, :tipoB)) '
      'ORDER BY 1,2'
      '')
    Left = 192
    Top = 184
    ParamData = <
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
        Name = 'tipoA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'tipoB'
        ParamType = ptUnknown
      end>
  end
  object QLCompGastosSalidas: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT DISTINCT '#39'X'#39' tipo, referencia_tl codigo, fecha_tl fecha'
      'FROM  frf_transitos_l'
      'WHERE producto_tl = '#39'E'#39
      'AND   empresa_tl = '#39'050'#39
      'AND   centro_tl = '#39'6'#39
      'AND   fecha_tl BETWEEN :desde AND :hasta'
      'AND   NOT EXISTS ('
      '      SELECT * FROM frf_gastos_trans'
      '      WHERE empresa_gt = '#39'050'#39
      '      AND   centro_gt = '#39'6'#39
      '      AND   referencia_gt = referencia_tl '
      '      AND   fecha_gt = fecha_tl '
      '      AND   tipo_gt IN (:tipoA, :tipoB)) '
      'ORDER BY 1,2'
      '')
    Left = 160
    Top = 184
    ParamData = <
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
        Name = 'tipoA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'tipoB'
        ParamType = ptUnknown
      end>
  end
  object QLCompGastosEntregasTransportes: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT DISTINCT '#39'X'#39' tipo, referencia_tl codigo, fecha_tl fecha'
      'FROM  frf_transitos_l'
      'WHERE producto_tl = '#39'E'#39
      'AND   empresa_tl = '#39'050'#39
      'AND   centro_tl = '#39'6'#39
      'AND   fecha_tl BETWEEN :desde AND :hasta'
      'AND   NOT EXISTS ('
      '      SELECT * FROM frf_gastos_trans'
      '      WHERE empresa_gt = '#39'050'#39
      '      AND   centro_gt = '#39'6'#39
      '      AND   referencia_gt = referencia_tl '
      '      AND   fecha_gt = fecha_tl '
      '      AND   tipo_gt IN (:tipoA, :tipoB)) '
      'ORDER BY 1,2'
      '')
    Left = 232
    Top = 184
    ParamData = <
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
        Name = 'tipoA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'tipoB'
        ParamType = ptUnknown
      end>
  end
end
