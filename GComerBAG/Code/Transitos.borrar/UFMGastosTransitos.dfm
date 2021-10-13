object FMGastosTransitos: TFMGastosTransitos
  Left = 447
  Top = 177
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  GASTOS DE TR'#193'NSITOS'
  ClientHeight = 562
  ClientWidth = 739
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label13: TLabel
    Left = 37
    Top = 75
    Width = 90
    Height = 19
    AutoSize = False
    Caption = 'Empresa'
    Color = cl3DLight
    ParentColor = False
  end
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 739
    Height = 562
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 40
      Top = 23
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Planta'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa: TBGridButton
      Left = 161
      Top = 22
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      Control = empresa_stc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object LFecha: TLabel
      Left = 294
      Top = 71
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Fecha'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BCBFecha: TBCalendarButton
      Left = 443
      Top = 70
      Width = 13
      Height = 21
      Action = ARejillaFlotante
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00000000BFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FF00000000000000000000000000FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00000000000000000000000000000000000000
        00BFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      Control = fecha_stc
      Calendar = CalendarioFlotante
      CalendarAlignment = taDownRight
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object lblNombre1: TLabel
      Left = 40
      Top = 71
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Matr'#237'cula'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre3: TLabel
      Left = 40
      Top = 120
      Width = 661
      Height = 19
      AutoSize = False
      Caption = ' Notas del servicio'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblServico: TLabel
      Left = 40
      Top = 47
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Servicio'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblStatus: TLabel
      Left = 40
      Top = 95
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Status'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object empresa_stc: TBDEdit
      Left = 128
      Top = 22
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 1
      OnChange = empresa_stcChange
      DataField = 'empresa_stc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object stEmpresa: TStaticText
      Left = 176
      Top = 24
      Width = 280
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 2
    end
    object RejillaFlotante: TBGrid
      Left = 239
      Top = 2
      Width = 73
      Height = 33
      Color = clInfoBk
      Options = [dgRowSelect, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Visible = False
      BControl = empresa_stc
    end
    object observaciones_stc: TDBMemo
      Left = 35
      Top = 142
      Width = 661
      Height = 70
      DataField = 'observaciones_stc'
      DataSource = DSMaestro
      TabOrder = 6
    end
    object fecha_stc: TBDEdit
      Tag = 999
      Left = 368
      Top = 70
      Width = 73
      Height = 21
      ColorEdit = clMoneyGreen
      ColorDisable = cl3DLight
      Required = True
      RequiredMsg = 'La fecha de la compra es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itDate
      MaxLength = 10
      TabOrder = 5
      DataField = 'fecha_stc'
      DataSource = DSMaestro
    end
    object matricula_stc: TBDEdit
      Left = 128
      Top = 70
      Width = 151
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El n'#250'mero de la compra es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 20
      TabOrder = 4
      DataField = 'matricula_stc'
      DataSource = DSMaestro
    end
    object servicio_stc: TBDEdit
      Left = 128
      Top = 46
      Width = 73
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 6
      TabOrder = 3
      OnChange = empresa_stcChange
      DataField = 'servicio_stc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object status_stc: TBDEdit
      Left = 128
      Top = 94
      Width = 17
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 1
      TabOrder = 7
      OnChange = status_stcChange
      DataField = 'status_stc'
      DataSource = DSMaestro
      Modificable = False
    end
    object stStaus: TStaticText
      Left = 148
      Top = 96
      Width = 308
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 8
    end
  end
  object CalendarioFlotante: TBCalendario
    Left = 638
    Top = 116
    Width = 177
    Height = 136
    AutoSize = True
    Date = 36717.432890856480000000
    ShowToday = False
    TabOrder = 2
    Visible = False
    WeekNumbers = True
  end
  object pBoton: TPanel
    Left = 530
    Top = 22
    Width = 166
    Height = 94
    TabOrder = 1
    object btnAsignar: TButton
      Left = 4
      Top = 63
      Width = 158
      Height = 25
      Caption = 'Asignar Facturas a Entregas'
      TabOrder = 2
      OnClick = btnAsignarClick
    end
    object btnGastos: TButton
      Left = 4
      Top = 35
      Width = 158
      Height = 25
      Caption = 'Gastos Asociados (Alt+G)'
      TabOrder = 1
      OnClick = btnGastosClick
    end
    object btnSalidas: TButton
      Left = 4
      Top = 7
      Width = 158
      Height = 25
      Caption = 'Salidas Asociadas (Alt+S)'
      TabOrder = 0
      OnClick = btnSalidasClick
    end
  end
  object PInferior: TPanel
    Left = 21
    Top = 218
    Width = 698
    Height = 329
    TabOrder = 3
    object lblNombre7: TLabel
      Left = 9
      Top = 114
      Width = 60
      Height = 19
      AutoSize = False
      Caption = 'Salidas '
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre8: TLabel
      Left = 9
      Top = 4
      Width = 60
      Height = 19
      AutoSize = False
      Caption = 'Facturas'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl1: TLabel
      Left = 9
      Top = 18
      Width = 60
      Height = 19
      AutoSize = False
      Caption = 'Asociadas'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl2: TLabel
      Left = 9
      Top = 128
      Width = 60
      Height = 19
      AutoSize = False
      Caption = 'Asociadas'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object dbeNumPalets: TDBText
      Left = 9
      Top = 302
      Width = 55
      Height = 17
      Alignment = taRightJustify
      DataField = 'palets'
      DataSource = DSNumPalets
    end
    object lblNumPalets: TLabel
      Left = 9
      Top = 284
      Width = 60
      Height = 19
      AutoSize = False
      Caption = 'Num.Palets:'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object DBGrid1: TDBGrid
      Left = 68
      Top = 114
      Width = 620
      Height = 205
      Color = clBtnFace
      DataSource = DSSalidas
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'destino'
          Title.Caption = 'Destino'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'centro'
          Title.Caption = 'Centro'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'referencia'
          Title.Caption = 'Referencia'
          Width = 52
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fecha'
          Title.Caption = 'Fecha'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cod_transporte'
          Title.Caption = 'Cod.'
          Width = 37
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'transportista'
          Title.Caption = 'Transportista'
          Width = 174
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'matricula'
          Title.Caption = 'Matr'#237'cula'
          Width = 131
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'palets'
          Title.Caption = 'Palets'
          Width = 46
          Visible = True
        end>
    end
    object DBGrid2: TDBGrid
      Left = 68
      Top = 4
      Width = 620
      Height = 103
      Color = clBtnFace
      DataSource = DSGastos
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'tipo'
          Title.Caption = 'Tipo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'factura'
          Title.Caption = 'Factura'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fecha'
          Title.Caption = 'Fecha Factura'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'producto'
          Title.Caption = 'Producto'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'importe'
          Title.Caption = 'Importe'
          Visible = True
        end>
    end
  end
  object DSMaestro: TDataSource
    DataSet = QServicios
    Left = 200
    Top = 8
  end
  object ACosecheros: TActionList
    Left = 344
    Top = 8
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QServicios: TQuery
    AfterOpen = QServiciosAfterOpen
    BeforeClose = QServiciosBeforeClose
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * '
      'FROM frf_compras'
      '')
    Left = 168
    Top = 9
  end
  object DSSalidas: TDataSource
    DataSet = QTransitos
    Left = 152
    Top = 368
  end
  object QTransitos: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      ' select planta_destino_tc destino, '
      '        centro_destino_tc centro, '
      '        referencia_tc referencia, '
      '        fecha_tc fecha, '
      '        vehiculo_tc matricula, '
      '        transporte_tc cod_transporte,'
      
        '        ( select descripcion_t from frf_transportistas where emp' +
        'resa_t = '#39'F21'#39' and transporte_t = transporte_tc ) transportista,' +
        ' '
      '        sum(palets_tl) palets '
      ''
      '  from frf_transitos_c, frf_transitos_l '
      ''
      '  where empresa_tc = '#39'F21'#39
      ''
      '  and empresa_tl = '#39'F21'#39
      '  and centro_tl = centro_tc '
      '  and referencia_tl = referencia_tc '
      '  and fecha_tl = fecha_tc '
      ''
      '  group by 1,2,3,4,5,6,7'
      '  order by 1,2 ')
    Left = 120
    Top = 368
    object QTransitosdestino: TStringField
      FieldName = 'destino'
      FixedChar = True
      Size = 3
    end
    object QTransitoscentro: TStringField
      FieldName = 'centro'
      FixedChar = True
      Size = 1
    end
    object QTransitosreferencia: TIntegerField
      FieldName = 'referencia'
    end
    object QTransitosfecha: TDateField
      FieldName = 'fecha'
    end
    object QTransitosmatricula: TStringField
      FieldName = 'matricula'
      FixedChar = True
    end
    object QTransitoscod_transporte: TSmallintField
      FieldName = 'cod_transporte'
    end
    object QTransitostransportista: TStringField
      FieldName = 'transportista'
      FixedChar = True
      Size = 30
    end
    object QTransitospalets: TFloatField
      FieldName = 'palets'
    end
  end
  object QGastos: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'select tipo_gsv Tipo, ref_fac_gsv factura, fecha_fac_gsv fecha, '
      '        producto_gsv Producto, importe_gsv Importe '
      ' from frf_gastos_servicios_venta '
      ' where empresa_gsv = '#39'050'#39' '
      ' and servicio_gsv = 1'
      ' order by tipo_gsv, producto_gsv')
    Left = 184
    Top = 264
    object QGastostipo: TStringField
      FieldName = 'tipo'
      Origin = '"COMER.SAT".frf_gastos_servicios_venta.tipo_gsv'
      FixedChar = True
      Size = 3
    end
    object QGastosfactura: TStringField
      FieldName = 'factura'
      Origin = '"COMER.SAT".frf_gastos_servicios_venta.ref_fac_gsv'
      FixedChar = True
      Size = 10
    end
    object QGastosfecha: TDateField
      FieldName = 'fecha'
      Origin = '"COMER.SAT".frf_gastos_servicios_venta.fecha_fac_gsv'
    end
    object QGastosproducto: TStringField
      DisplayWidth = 3
      FieldName = 'producto'
      Origin = '"COMER.SAT".frf_gastos_servicios_venta.producto_gsv'
      FixedChar = True
      Size = 3
    end
    object QGastosimporte: TFloatField
      FieldName = 'importe'
      Origin = '"COMER.SAT".frf_gastos_servicios_venta.importe_gsv'
    end
  end
  object DSGastos: TDataSource
    DataSet = QGastos
    Left = 224
    Top = 264
  end
  object QNumPalets: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'select centro_salida_sc centro, n_albaran_sc albaran, '
      
        '        cliente_sal_sc cliente, dir_sum_sc suministro, vehiculo_' +
        'sc matricula, '
      
        '        ( select descripcion_t from frf_transportistas where emp' +
        'resa_t = '#39'050'#39' and transporte_t = transporte_sc ) transportista,' +
        ' '
      '        ( select sum(n_palets_sl)  '
      '         from frf_salidas_l '
      '         where empresa_sl = '#39'050'#39' '
      '         and centro_salida_sl = centro_salida_ssv '
      '         and fecha_sl = fecha_ssv '
      '         and n_albaran_sl = n_albaran_ssv ) palets '
      ''
      ' from frf_salidas_servicios_venta, frf_salidas_c '
      ''
      ' where empresa_ssv = '#39'050'#39' '
      ' and servicio_ssv = 1 '
      ''
      ' and empresa_sc = '#39'050'#39' '
      ' and centro_salida_sc = centro_salida_ssv '
      ' and n_albaran_sc = n_albaran_ssv '
      ' and fecha_sc = fecha_ssv '
      ''
      ' order by n_albaran_sc')
    Left = 120
    Top = 400
  end
  object DSNumPalets: TDataSource
    DataSet = QNumPalets
    Left = 152
    Top = 400
  end
end
