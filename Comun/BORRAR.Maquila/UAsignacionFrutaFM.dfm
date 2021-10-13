object FMAsignacionFruta: TFMAsignacionFruta
  Left = 409
  Top = 122
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  ASIGNACION DE FRUTA EN ADUANA'
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
    Height = 240
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
      Left = 501
      Top = 30
      Width = 150
      Height = 21
      Caption = 'Contador de asignaciones'
      About = 'NB 0.1/20020725'
    end
    object lObservacion: TnbLabel
      Left = 33
      Top = 135
      Width = 100
      Height = 21
      Caption = 'Observaciones'
      About = 'NB 0.1/20020725'
    end
    object nbLabel1: TnbLabel
      Left = 33
      Top = 30
      Width = 100
      Height = 21
      Caption = 'Empresa'
      About = 'NB 0.1/20020725'
    end
    object nbLabel2: TnbLabel
      Left = 33
      Top = 56
      Width = 100
      Height = 21
      Caption = 'Proveedor'
      About = 'NB 0.1/20020725'
    end
    object lblProveedor: TnbStaticText
      Left = 187
      Top = 56
      Width = 270
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object lblEmpresa: TnbStaticText
      Left = 187
      Top = 30
      Width = 270
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object btnFecha: TBCalendarButton
      Left = 679
      Top = 81
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
      OnClick = btnFechaClick
      Control = fecha_asignacion_ac
      Calendar = Calendario
      CalendarAlignment = taDownRight
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object btnEmpresa: TBGridButton
      Left = 172
      Top = 30
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
      OnClick = btnEmpresaClick
      Control = empresa_ac
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object btnProveedor: TBGridButton
      Left = 172
      Top = 56
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
      OnClick = btnProveedorClick
      Control = proveedor_ac
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object nbLabel3: TnbLabel
      Left = 501
      Top = 106
      Width = 100
      Height = 21
      Caption = 'Estado'
      About = 'NB 0.1/20020725'
    end
    object nbLabel20: TnbLabel
      Left = 501
      Top = 81
      Width = 100
      Height = 21
      Caption = 'Fecha '
      About = 'NB 0.1/20020725'
    end
    object lblFechaHasta: TnbLabel
      Left = 692
      Top = 81
      Width = 70
      Height = 21
      Caption = 'hasta el'
      Visible = False
      About = 'NB 0.1/20020725'
    end
    object btnFechaHasta: TBCalendarButton
      Left = 842
      Top = 81
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
    object lblCodigo2: TnbLabel
      Left = 501
      Top = 56
      Width = 100
      Height = 21
      Caption = 'Almac'#233'n'
      About = 'NB 0.1/20020725'
    end
    object btnAlmacen: TBGridButton
      Left = 639
      Top = 56
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
      Control = almacen_ac
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object lblAlmacen: TnbStaticText
      Left = 653
      Top = 56
      Width = 270
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object lblCodigo3: TnbLabel
      Left = 34
      Top = 106
      Width = 100
      Height = 21
      Caption = 'Ref.Asignaci'#243'n'
      About = 'NB 0.1/20020725'
    end
    object btnProducto: TBGridButton
      Left = 172
      Top = 81
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
      Control = producto_ac
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object lblProducto: TnbStaticText
      Left = 187
      Top = 81
      Width = 270
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object etqProducto: TnbLabel
      Left = 34
      Top = 81
      Width = 100
      Height = 21
      Caption = 'Producto'
      About = 'NB 0.1/20020725'
    end
    object observaciones_ac: TDBMemo
      Left = 136
      Top = 135
      Width = 634
      Height = 73
      DataField = 'observaciones_ac'
      DataSource = DSMaestro
      TabOrder = 10
    end
    object contador_ac: TBDEdit
      Left = 653
      Top = 30
      Width = 72
      Height = 21
      TabStop = False
      ColorEdit = clBtnFace
      ColorNormal = clBtnFace
      ColorDisable = clBtnFace
      ReadOnly = True
      MaxLength = 12
      TabOrder = 1
      DataField = 'contador_ac'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object empresa_ac: TBDEdit
      Left = 136
      Top = 30
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de la empresa es de obligada inserci'#243'n.'
      OnRequiredTime = empresa_acRequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = empresa_acChange
      DataField = 'empresa_ac'
      DataSource = DSMaestro
      Modificable = False
    end
    object proveedor_ac: TBDEdit
      Left = 136
      Top = 56
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo del proveedor es de obligada inserci'#243'n.'
      OnRequiredTime = empresa_acRequiredTime
      MaxLength = 3
      TabOrder = 2
      OnChange = proveedor_acChange
      DataField = 'proveedor_ac'
      DataSource = DSMaestro
      Modificable = False
    end
    object fecha_asignacion_ac: TBDEdit
      Left = 604
      Top = 81
      Width = 74
      Height = 21
      Hint = 'Rellenar en destino.'
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'La fecha de descarga de la mercanc'#237'a es de obligada inserci'#243'n.'
      OnRequiredTime = empresa_acRequiredTime
      InputType = itDate
      MaxLength = 10
      TabOrder = 5
      DataField = 'fecha_asignacion_ac'
      DataSource = DSMaestro
    end
    object status_ac: TBDEdit
      Left = 605
      Top = 106
      Width = 22
      Height = 21
      ColorEdit = clMoneyGreen
      ColorDisable = clBtnFace
      RequiredMsg = 'El c'#243'digo del almac'#233'n del proveedor de obligada inserci'#243'n.'
      OnRequiredTime = empresa_acRequiredTime
      InputType = itInteger
      Enabled = False
      MaxLength = 1
      TabOrder = 8
      DataField = 'status_ac'
      DataSource = DSMaestro
    end
    object cbbstatus_ac: TComboBox
      Left = 626
      Top = 106
      Width = 300
      Height = 21
      Style = csDropDownList
      Color = clBtnFace
      Enabled = False
      ItemHeight = 13
      TabOrder = 9
      TabStop = False
      Items.Strings = (
        'INICIALIZADA')
    end
    object edtFechaHasta: TBEdit
      Left = 766
      Top = 81
      Width = 74
      Height = 21
      OnRequiredTime = empresa_acRequiredTime
      InputType = itDate
      Visible = False
      TabOrder = 6
    end
    object almacen_ac: TBDEdit
      Left = 604
      Top = 56
      Width = 35
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'El c'#243'digo del almac'#233'n del proveedor de obligada inserci'#243'n.'
      OnRequiredTime = empresa_acRequiredTime
      InputType = itInteger
      MaxLength = 3
      TabOrder = 3
      OnChange = almacen_acChange
      DataField = 'almacen_ac'
      DataSource = DSMaestro
      Modificable = False
    end
    object asignacion_ac: TBDEdit
      Left = 136
      Top = 106
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 12
      TabOrder = 7
      DataField = 'asignacion_ac'
      DataSource = DSMaestro
    end
    object producto_ac: TBDEdit
      Left = 136
      Top = 81
      Width = 35
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 'El producto del proveedor es de obligada inserci'#243'n.'
      OnRequiredTime = empresa_acRequiredTime
      MaxLength = 3
      TabOrder = 4
      OnChange = producto_acChange
      DataField = 'producto_ac'
      DataSource = DSMaestro
      Modificable = False
    end
  end
  object PDetalle: TPanel
    Left = 0
    Top = 240
    Width = 973
    Height = 381
    Align = alClient
    TabOrder = 3
    object PDetalle1: TPanel
      Left = 1
      Top = 1
      Width = 971
      Height = 75
      Align = alTop
      BevelInner = bvLowered
      Enabled = False
      TabOrder = 0
      Visible = False
      object nbLabel8: TnbLabel
        Left = 129
        Top = 10
        Width = 102
        Height = 21
        Caption = 'Producto'
        About = 'NB 0.1/20020725'
      end
      object btnProductoL: TBGridButton
        Left = 165
        Top = 35
        Width = 13
        Height = 21
        Enabled = False
        Glyph.Data = {
          C6000000424DC60000000000000076000000280000000A0000000A0000000100
          0400000000005000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
          0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
          0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
          0000FFFFFFFFFF000000}
        OnClick = btnProductoLClick
        Control = producto_al
        Grid = RejillaFlotante
        GridAlignment = taDownRight
        GridWidth = 280
        GridHeigth = 200
      end
      object nbLabel9: TnbLabel
        Left = 23
        Top = 10
        Width = 100
        Height = 21
        Caption = 'Linea'
        About = 'NB 0.1/20020725'
      end
      object nbLabel14: TnbLabel
        Left = 446
        Top = 10
        Width = 80
        Height = 21
        Caption = 'Palets'
        About = 'NB 0.1/20020725'
      end
      object lblCodigo1: TnbLabel
        Left = 339
        Top = 10
        Width = 102
        Height = 21
        Caption = 'Calibre'
        About = 'NB 0.1/20020725'
      end
      object btnCalibre: TBGridButton
        Left = 428
        Top = 35
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
        OnClick = btnCalibreClick
        Control = calibre_al
        Grid = RejillaFlotante
        GridAlignment = taDownRight
        GridWidth = 280
        GridHeigth = 200
      end
      object lblProductoL: TnbStaticText
        Left = 180
        Top = 35
        Width = 151
        Height = 21
        About = 'NB 0.1/20020725'
      end
      object lblCodigo4: TnbLabel
        Left = 616
        Top = 10
        Width = 80
        Height = 21
        Caption = 'Cajas'
        About = 'NB 0.1/20020725'
      end
      object lblCodigo5: TnbLabel
        Left = 701
        Top = 10
        Width = 80
        Height = 21
        Caption = 'Precio Caja'
        About = 'NB 0.1/20020725'
      end
      object lblCodigo6: TnbLabel
        Left = 786
        Top = 10
        Width = 80
        Height = 21
        Caption = 'Importe'
        About = 'NB 0.1/20020725'
      end
      object lblImporte: TLabel
        Left = 786
        Top = 39
        Width = 80
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'lblImporte'
      end
      object lblCajasPalet: TLabel
        Left = 531
        Top = 39
        Width = 80
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'lblCajasPalet'
      end
      object lblCodigo7: TnbLabel
        Left = 531
        Top = 10
        Width = 80
        Height = 21
        Caption = 'Cajas X Palet'
        About = 'NB 0.1/20020725'
      end
      object producto_al: TBDEdit
        Left = 129
        Top = 35
        Width = 35
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El producto del proveedor es de obligada inserci'#243'n.'
        OnRequiredTime = empresa_acRequiredTime
        Enabled = False
        MaxLength = 3
        TabOrder = 1
        OnChange = producto_alChange
        DataField = 'producto_al'
        DataSource = DSDetalle
        Modificable = False
      end
      object linea_al: TBDEdit
        Left = 23
        Top = 35
        Width = 35
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'La categor'#237'a es obligatoria.'
        OnRequiredTime = empresa_acRequiredTime
        InputType = itInteger
        Enabled = False
        MaxLength = 3
        TabOrder = 0
        DataField = 'linea_al'
        DataSource = DSDetalle
        Modificable = False
      end
      object palets_al: TBDEdit
        Left = 446
        Top = 35
        Width = 80
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El calibre es obligatorio.'
        OnRequiredTime = empresa_acRequiredTime
        InputType = itReal
        MaxDecimals = 2
        MaxLength = 10
        TabOrder = 3
        OnChange = palets_alChange
        DataField = 'palets_al'
        DataSource = DSDetalle
      end
      object calibre_al: TBDEdit
        Left = 340
        Top = 35
        Width = 86
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El producto del proveedor es de obligada inserci'#243'n.'
        OnRequiredTime = empresa_acRequiredTime
        InputType = itInteger
        MaxLength = 3
        TabOrder = 2
        DataField = 'calibre_al'
        DataSource = DSDetalle
      end
      object cajas_al: TBDEdit
        Left = 616
        Top = 35
        Width = 80
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El calibre es obligatorio.'
        OnRequiredTime = empresa_acRequiredTime
        InputType = itInteger
        MaxLength = 6
        TabOrder = 4
        OnChange = cajas_alChange
        DataField = 'cajas_al'
        DataSource = DSDetalle
      end
      object precio_caja_al: TBDEdit
        Left = 701
        Top = 35
        Width = 80
        Height = 21
        ColorEdit = clMoneyGreen
        RequiredMsg = 'El calibre es obligatorio.'
        OnRequiredTime = empresa_acRequiredTime
        InputType = itReal
        MaxDecimals = 2
        MaxLength = 6
        TabOrder = 5
        OnChange = precio_caja_alChange
        DataField = 'precio_caja_al'
        DataSource = DSDetalle
      end
    end
    object RVisualizacion1: TDBGrid
      Left = 1
      Top = 76
      Width = 971
      Height = 304
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
      Columns = <
        item
          Expanded = False
          FieldName = 'Linea_al'
          Title.Caption = 'Linea'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Producto_al'
          Title.Caption = 'Producto'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Calibre_al'
          Title.Caption = 'Calibre'
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'Precio_caja_al'
          Title.Alignment = taRightJustify
          Title.Caption = 'Precio Caja'
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'Palets_al'
          Title.Alignment = taRightJustify
          Title.Caption = 'Palets'
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'Cajas_al'
          Title.Alignment = taRightJustify
          Title.Caption = 'Cajas'
          Visible = True
        end>
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
    Date = 36864.4563176505
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
    Left = 49
    Top = 320
  end
  object DSGastosEntregas: TDataSource
    DataSet = MDEntregas.QGastosEntregas
    Left = 64
    Top = 624
  end
  object qryCab: TQuery
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
    DatabaseName = 'BDProyecto'
    IndexFieldNames = 'contador_al'
    MasterFields = 'contador_ac'
    MasterSource = DSMaestro
    TableName = 'frf_asignacion_l'
    Left = 17
    Top = 319
  end
end
