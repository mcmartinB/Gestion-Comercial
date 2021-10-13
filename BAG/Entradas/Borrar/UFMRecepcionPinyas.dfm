object FMRecepcionPinyas: TFMRecepcionPinyas
  Left = 356
  Top = 169
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  ENTREGAS DE PROVEEDORES'
  ClientHeight = 621
  ClientWidth = 973
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 973
    Height = 273
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    BevelWidth = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object nbLabel24: TnbLabel
      Left = 503
      Top = 27
      Width = 100
      Height = 21
      Caption = 'C'#243'digo Entrega'
      About = 'NB 0.1/20020725'
    end
    object lObservacion: TnbLabel
      Left = 33
      Top = 178
      Width = 100
      Height = 21
      Caption = 'Observaciones'
      About = 'NB 0.1/20020725'
    end
    object nbLabel1: TnbLabel
      Left = 33
      Top = 27
      Width = 100
      Height = 21
      Caption = 'Empresa'
      About = 'NB 0.1/20020725'
    end
    object nbLabel2: TnbLabel
      Left = 33
      Top = 77
      Width = 100
      Height = 21
      Caption = 'OPP'
      About = 'NB 0.1/20020725'
    end
    object nbLabel5: TnbLabel
      Left = 33
      Top = 128
      Width = 100
      Height = 21
      Caption = 'Vehiculo'
      About = 'NB 0.1/20020725'
    end
    object lblProveedor: TnbStaticText
      Left = 187
      Top = 77
      Width = 270
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object lblEmpresa: TnbStaticText
      Left = 187
      Top = 27
      Width = 270
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object btnFecha_llegada: TBCalendarButton
      Left = 682
      Top = 52
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = btnFecha_llegadaClick
      Control = fecha_rpc
      Calendar = Calendario
      CalendarAlignment = taDownRight
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object btnEmpresa_rpc: TBGridButton
      Left = 172
      Top = 27
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = btnEmpresa_rpcClick
      Control = empresa_rpc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object btnProveedor_rpc: TBGridButton
      Left = 172
      Top = 77
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = btnProveedor_rpcClick
      Control = proveedor_rpc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object nbLabel4: TnbLabel
      Left = 503
      Top = 77
      Width = 100
      Height = 21
      Caption = 'A'#241'o/Semana'
      About = 'NB 0.1/20020725'
    end
    object nbLabel30: TnbLabel
      Left = 33
      Top = 52
      Width = 100
      Height = 21
      Caption = 'Centro '
      About = 'NB 0.1/20020725'
    end
    object btnCentroDestino: TBGridButton
      Left = 172
      Top = 52
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = btnCentroDestinoClick
      Control = centro_rpc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object lblCentroDestino: TnbStaticText
      Left = 187
      Top = 52
      Width = 270
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object nbLabel31: TnbLabel
      Left = 503
      Top = 128
      Width = 100
      Height = 21
      Caption = 'Transporte'
      About = 'NB 0.1/20020725'
    end
    object nbLabel33: TnbLabel
      Left = 33
      Top = 153
      Width = 100
      Height = 21
      Caption = 'Jaula'
      About = 'NB 0.1/20020725'
    end
    object btnTransporte: TBGridButton
      Left = 641
      Top = 128
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = btnTransporteClick
      Control = transporte_rpc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object lblTransporte: TnbStaticText
      Left = 658
      Top = 128
      Width = 270
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object nbLabel3: TnbLabel
      Left = 503
      Top = 153
      Width = 100
      Height = 21
      Caption = 'Estado'
      About = 'NB 0.1/20020725'
    end
    object nbLabel20: TnbLabel
      Left = 503
      Top = 52
      Width = 100
      Height = 21
      Caption = 'Fecha '
      About = 'NB 0.1/20020725'
    end
    object nbLabel12: TnbLabel
      Left = 503
      Top = 102
      Width = 100
      Height = 21
      Caption = 'Peso Entrada'
      About = 'NB 0.1/20020725'
    end
    object nbLabel6: TnbLabel
      Left = 695
      Top = 102
      Width = 70
      Height = 21
      Caption = 'Peso Salida'
      About = 'NB 0.1/20020725'
    end
    object peso_carga_rpc: TLabel
      Left = 847
      Top = 106
      Width = 74
      Height = 13
      AutoSize = False
      Caption = '0,00'
    end
    object lblProducto_: TnbLabel
      Left = 33
      Top = 102
      Width = 100
      Height = 21
      Caption = 'Producto'
      About = 'NB 0.1/20020725'
    end
    object btnProducto: TBGridButton
      Left = 172
      Top = 102
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = btnProductoClick
      Control = producto_rpc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object stProducto: TnbStaticText
      Left = 187
      Top = 102
      Width = 270
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object lblFechaHasta: TnbLabel
      Left = 695
      Top = 52
      Width = 70
      Height = 21
      Caption = 'hasta el'
      Visible = False
      About = 'NB 0.1/20020725'
    end
    object btnFechaHasta: TBCalendarButton
      Left = 847
      Top = 52
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      Visible = False
      OnClick = btnFechaHastaClick
      Control = edtFechaHasta
      Calendar = Calendario
      CalendarAlignment = taDownRight
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object observaciones_rpc: TDBMemo
      Left = 136
      Top = 178
      Width = 634
      Height = 73
      DataField = 'observaciones_rpc'
      DataSource = DSMaestro
      TabOrder = 16
    end
    object codigo_rpc: TBDEdit
      Left = 607
      Top = 27
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      ColorNormal = clSkyBlue
      MaxLength = 12
      TabOrder = 1
      DataField = 'codigo_rpc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object empresa_rpc: TBDEdit
      Left = 136
      Top = 27
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de la empresa es de obligada inserci'#243'n.'
      OnRequiredTime = empresa_rpcRequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = empresa_rpcChange
      DataField = 'empresa_rpc'
      DataSource = DSMaestro
      Modificable = False
    end
    object proveedor_rpc: TBDEdit
      Left = 136
      Top = 77
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo del proveedor es de obligada inserci'#243'n.'
      OnRequiredTime = empresa_rpcRequiredTime
      MaxLength = 3
      TabOrder = 5
      OnChange = proveedor_rpcChange
      DataField = 'proveedor_rpc'
      DataSource = DSMaestro
    end
    object vehiculo_rpc: TBDEdit
      Left = 136
      Top = 128
      Width = 250
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_rpcRequiredTime
      MaxLength = 30
      TabOrder = 11
      DataField = 'vehiculo_rpc'
      DataSource = DSMaestro
    end
    object anyo_rpc: TBDEdit
      Left = 607
      Top = 77
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 
        'El c'#243'digo del albar'#225'n es de obligada inserci'#243'n ( Si se desconoce' +
        ' ponga '#39'?'#39' ).'
      OnRequiredTime = empresa_rpcRequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 6
      DataField = 'anyo_rpc'
      DataSource = DSMaestro
    end
    object centro_rpc: TBDEdit
      Left = 136
      Top = 52
      Width = 22
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del cenro destino es de obligada inserci'#243'n.'
      OnRequiredTime = empresa_rpcRequiredTime
      MaxLength = 1
      TabOrder = 2
      OnChange = centro_rpcChange
      DataField = 'centro_rpc'
      DataSource = DSMaestro
    end
    object jaula_rpc: TBDEdit
      Left = 136
      Top = 153
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_rpcRequiredTime
      MaxLength = 5
      TabOrder = 13
      DataField = 'jaula_rpc'
      DataSource = DSMaestro
    end
    object transporte_rpc: TBDEdit
      Left = 607
      Top = 128
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_rpcRequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 12
      OnChange = transporte_rpcChange
      DataField = 'transporte_rpc'
      DataSource = DSMaestro
    end
    object fecha_rpc: TBDEdit
      Left = 607
      Top = 52
      Width = 74
      Height = 21
      Hint = 'Rellenar en destino.'
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'La fecha de descarga de la mercanc'#237'a es de obligada inserci'#243'n.'
      OnRequiredTime = empresa_rpcRequiredTime
      InputType = itDate
      MaxLength = 10
      TabOrder = 3
      DataField = 'fecha_rpc'
      DataSource = DSMaestro
    end
    object semana_rpc: TBDEdit
      Left = 665
      Top = 77
      Width = 30
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      OnRequiredTime = empresa_rpcRequiredTime
      InputType = itInteger
      MaxLength = 2
      TabOrder = 7
      DataField = 'semana_rpc'
      DataSource = DSMaestro
    end
    object peso_entrada_rpc: TBDEdit
      Left = 607
      Top = 102
      Width = 73
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_rpcRequiredTime
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 10
      TabOrder = 9
      OnChange = peso_entrada_rpcChange
      DataField = 'peso_entrada_rpc'
      DataSource = DSMaestro
    end
    object peso_salida_rpc: TBDEdit
      Left = 769
      Top = 102
      Width = 73
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_rpcRequiredTime
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 10
      TabOrder = 10
      OnChange = peso_salida_rpcChange
      DataField = 'peso_salida_rpc'
      DataSource = DSMaestro
    end
    object status_rpc: TBDEdit
      Left = 607
      Top = 153
      Width = 22
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'El c'#243'digo del almac'#233'n del proveedor de obligada inserci'#243'n.'
      OnRequiredTime = empresa_rpcRequiredTime
      InputType = itInteger
      Enabled = False
      MaxLength = 1
      TabOrder = 14
      DataField = 'status_rpc'
      DataSource = DSMaestro
    end
    object cbbstatus_rpc: TComboBox
      Left = 628
      Top = 153
      Width = 300
      Height = 21
      Style = csDropDownList
      Color = clSilver
      Enabled = False
      ItemHeight = 13
      TabOrder = 15
      TabStop = False
      Items.Strings = (
        'INICIAL - PENDIENTE RECIBIR ALMACEN'
        'DOCUMENTO RECIBIDO EN EL ALMACEN'
        'ENTREGA DESCARGADA EN EL ALMACEN'
        'ENTREGA DIRECTA AL CLIENTE')
    end
    object producto_rpc: TBDEdit
      Left = 136
      Top = 102
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del producto es de obligada inserci'#243'n.'
      OnRequiredTime = empresa_rpcRequiredTime
      MaxLength = 3
      TabOrder = 8
      OnChange = producto_rpcChange
      DataField = 'producto_rpc'
      DataSource = DSMaestro
      Modificable = False
    end
    object edtFechaHasta: TBEdit
      Left = 769
      Top = 52
      Width = 74
      Height = 21
      OnRequiredTime = empresa_rpcRequiredTime
      InputType = itDate
      Visible = False
      TabOrder = 4
    end
  end
  object PDetalle: TPanel
    Left = 0
    Top = 273
    Width = 973
    Height = 348
    Align = alClient
    TabOrder = 3
    object PDetalle1: TPanel
      Left = 1
      Top = 1
      Width = 971
      Height = 79
      Align = alTop
      BevelInner = bvLowered
      Enabled = False
      TabOrder = 0
      Visible = False
      object nbLabel10: TnbLabel
        Left = 352
        Top = 38
        Width = 100
        Height = 21
        Caption = 'A'#241'o'
        About = 'NB 0.1/20020725'
      end
      object nbLabelCajas: TnbLabel
        Left = 502
        Top = 38
        Width = 100
        Height = 21
        Caption = 'Semana'
        About = 'NB 0.1/20020725'
      end
      object nbLabelKilos: TnbLabel
        Left = 674
        Top = 38
        Width = 100
        Height = 21
        Caption = 'Lote'
        About = 'NB 0.1/20020725'
      end
      object nbLabel8: TnbLabel
        Left = 352
        Top = 14
        Width = 102
        Height = 21
        Caption = 'Finca'
        About = 'NB 0.1/20020725'
      end
      object btnFinca: TBGridButton
        Left = 492
        Top = 14
        Width = 13
        Height = 21
        Glyph.Data = {
          C6000000424DC60000000000000076000000280000000A0000000A0000000100
          0400000000005000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
          0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
          0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
          0000FFFFFFFFFF000000}
        OnClick = btnFincaClick
        Control = finca_rpl
        Grid = RejillaFlotante
        GridAlignment = taDownRight
        GridWidth = 280
        GridHeigth = 200
      end
      object nbLabel9: TnbLabel
        Left = 23
        Top = 38
        Width = 100
        Height = 21
        Caption = 'Pi'#241'as'
        About = 'NB 0.1/20020725'
      end
      object nbLabel14: TnbLabel
        Left = 176
        Top = 38
        Width = 100
        Height = 21
        Caption = 'Kilos'
        About = 'NB 0.1/20020725'
      end
      object nbLabel25: TnbLabel
        Left = 25
        Top = 14
        Width = 100
        Height = 21
        Caption = 'Cosechero'
        About = 'NB 0.1/20020725'
      end
      object btnAlmacen: TBGridButton
        Left = 162
        Top = 14
        Width = 13
        Height = 21
        Glyph.Data = {
          C6000000424DC60000000000000076000000280000000A0000000A0000000100
          0400000000005000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
          0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
          0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
          0000FFFFFFFFFF000000}
        OnClick = btnAlmacenClick
        Control = almacen_rpl
        Grid = RejillaFlotante
        GridAlignment = taDownRight
        GridWidth = 280
        GridHeigth = 200
      end
      object lblAlmacen: TnbStaticText
        Left = 176
        Top = 14
        Width = 159
        Height = 21
        About = 'NB 0.1/20020725'
      end
      object lblCodigo1: TnbLabel
        Left = 674
        Top = 14
        Width = 102
        Height = 21
        Caption = 'Sector'
        About = 'NB 0.1/20020725'
      end
      object btnSector: TBGridButton
        Left = 825
        Top = 14
        Width = 13
        Height = 21
        Glyph.Data = {
          C6000000424DC60000000000000076000000280000000A0000000A0000000100
          0400000000005000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
          0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
          0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
          0000FFFFFFFFFF000000}
        OnClick = btnSectorClick
        Control = sector_rpl
        Grid = RejillaFlotante
        GridAlignment = taDownRight
        GridWidth = 280
        GridHeigth = 200
      end
      object lblFinca: TnbStaticText
        Left = 507
        Top = 14
        Width = 151
        Height = 21
        About = 'NB 0.1/20020725'
      end
      object semana_rpl: TBDEdit
        Left = 608
        Top = 38
        Width = 39
        Height = 21
        ColorEdit = clMoneyGreen
        Zeros = True
        RequiredMsg = 'El n'#250'mero de cajas es obligatorio'
        OnRequiredTime = empresa_rpcRequiredTime
        InputType = itInteger
        MaxLength = 2
        TabOrder = 6
        OnChange = semana_rplChange
        DataField = 'semana_rpl'
        DataSource = DSDetalle
      end
      object anyo_rpl: TBDEdit
        Left = 456
        Top = 38
        Width = 35
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El n'#250'mero de palets es obligatorio'
        OnRequiredTime = empresa_rpcRequiredTime
        InputType = itInteger
        MaxLength = 4
        TabOrder = 5
        OnChange = anyo_rplChange
        DataField = 'anyo_rpl'
        DataSource = DSDetalle
      end
      object lote_rpl: TBDEdit
        Left = 780
        Top = 38
        Width = 134
        Height = 21
        ColorEdit = clMoneyGreen
        Required = True
        RequiredMsg = 'El n'#250'mero de kilos es obligatorio'
        OnRequiredTime = empresa_rpcRequiredTime
        MaxLength = 9
        TabOrder = 7
        DataField = 'lote_rpl'
        DataSource = DSDetalle
      end
      object finca_rpl: TBDEdit
        Left = 456
        Top = 14
        Width = 35
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El producto del proveedor es de obligada inserci'#243'n.'
        OnRequiredTime = empresa_rpcRequiredTime
        InputType = itInteger
        MaxLength = 3
        TabOrder = 1
        OnChange = finca_rplChange
        DataField = 'finca_rpl'
        DataSource = DSDetalle
      end
      object pinyas_rpl: TBDEdit
        Left = 127
        Top = 38
        Width = 35
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'La categor'#237'a es obligatoria.'
        OnRequiredTime = empresa_rpcRequiredTime
        InputType = itInteger
        MaxLength = 3
        TabOrder = 3
        DataField = 'pinyas_rpl'
        DataSource = DSDetalle
      end
      object kilos_rpl: TBDEdit
        Left = 280
        Top = 38
        Width = 49
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El calibre es obligatorio.'
        OnRequiredTime = empresa_rpcRequiredTime
        InputType = itReal
        MaxDecimals = 2
        MaxLength = 10
        TabOrder = 4
        DataField = 'kilos_rpl'
        DataSource = DSDetalle
      end
      object almacen_rpl: TBDEdit
        Left = 127
        Top = 14
        Width = 35
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El c'#243'digo del almac'#233'n del proveedor de obligada inserci'#243'n.'
        OnRequiredTime = empresa_rpcRequiredTime
        InputType = itInteger
        MaxLength = 3
        TabOrder = 0
        OnChange = almacen_rplChange
        DataField = 'almacen_rpl'
        DataSource = DSDetalle
      end
      object sector_rpl: TBDEdit
        Left = 780
        Top = 14
        Width = 43
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El producto del proveedor es de obligada inserci'#243'n.'
        OnRequiredTime = empresa_rpcRequiredTime
        InputType = itInteger
        MaxLength = 3
        TabOrder = 2
        OnChange = sector_rplChange
        DataField = 'sector_rpl'
        DataSource = DSDetalle
      end
    end
    object RVisualizacion1: TDBGrid
      Left = 1
      Top = 80
      Width = 971
      Height = 267
      TabStop = False
      Align = alClient
      DataSource = DSDetalle
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object RejillaFlotante: TBGrid
    Left = 926
    Top = 168
    Width = 41
    Height = 57
    Color = clInfoBk
    DataSource = DMBaseDatos.DSQDespegables
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object Calendario: TBCalendario
    Left = 946
    Top = 10
    Width = 177
    Height = 153
    Date = 36864.551917442130000000
    TabOrder = 1
    Visible = False
    WeekNumbers = True
  end
  object DSMaestro: TDataSource
    DataSet = qryCab
    Left = 43
    Top = 10
  end
  object DSDetalle: TDataSource
    DataSet = tblLin
    Left = 46
    Top = 304
  end
  object DSGastosEntregas: TDataSource
    DataSet = MDEntregas.QGastosEntregas
    Left = 64
    Top = 624
  end
  object qryCab: TQuery
    AfterPost = qryCabAfterPost
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * '
      'FROM frf_entregas_c'
      'ORDER BY fecha_ec DESC')
    Left = 8
    Top = 6
  end
  object tblLin: TTable
    AfterInsert = tblLinAfterInsert
    AfterEdit = tblLinAfterEdit
    DatabaseName = 'BDProyecto'
    IndexFieldNames = 'codigo_rpl'
    MasterFields = 'codigo_rpc'
    MasterSource = DSMaestro
    TableName = 'frf_recepcion_pinyas_l'
    Left = 13
    Top = 302
  end
end
