object FMEntregasProveedor_SAT: TFMEntregasProveedor_SAT
  Left = 482
  Top = 199
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = ' COMPRAS CON ENTRADAS ASOCIADAS'
  ClientHeight = 700
  ClientWidth = 945
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
    Width = 945
    Height = 351
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    BevelWidth = 2
    Caption = 's'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object bvl1: TBevel
      Left = 503
      Top = 167
      Width = 225
      Height = 44
    end
    object Bevel1: TBevel
      Left = 503
      Top = 123
      Width = 225
      Height = 44
    end
    object Bevel4: TBevel
      Left = 503
      Top = 17
      Width = 225
      Height = 78
    end
    object nbLabel24: TnbLabel
      Left = 518
      Top = 21
      Width = 100
      Height = 21
      Caption = 'C'#243'digo Entrega'
      About = 'NB 0.1/20020725'
    end
    object lObservacion: TnbLabel
      Left = 33
      Top = 214
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
      Top = 73
      Width = 100
      Height = 21
      Caption = 'Proveedor'
      About = 'NB 0.1/20020725'
    end
    object nbLabel5: TnbLabel
      Left = 33
      Top = 166
      Width = 100
      Height = 21
      Caption = 'Matricula'
      About = 'NB 0.1/20020725'
    end
    object nbLabel19: TnbLabel
      Left = 33
      Top = 120
      Width = 100
      Height = 21
      Caption = 'Fecha Carga'
      About = 'NB 0.1/20020725'
    end
    object lblProveedor: TnbStaticText
      Left = 187
      Top = 73
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
      Left = 212
      Top = 143
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
      Control = fecha_llegada_ec
      Calendar = Calendario
      CalendarAlignment = taDownRight
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object btnEmpresa_ec: TBGridButton
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
      OnClick = btnEmpresa_ecClick
      Control = empresa_ec
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object btnProveedor_ec: TBGridButton
      Left = 172
      Top = 73
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
      OnClick = btnProveedor_ecClick
      Control = proveedor_ec
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object nbLabel25: TnbLabel
      Left = 33
      Top = 96
      Width = 100
      Height = 21
      Caption = 'Almac'#233'n Proveedor'
      About = 'NB 0.1/20020725'
    end
    object btnAlmacen: TBGridButton
      Left = 172
      Top = 93
      Width = 13
      Height = 21
      Hint = 'Pulse F2 para ver una lista de valores validos. '
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
      Control = almacen_ec
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object lblAlmacen: TnbStaticText
      Left = 187
      Top = 96
      Width = 270
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object nbLabel4: TnbLabel
      Left = 230
      Top = 120
      Width = 100
      Height = 21
      Caption = 'Albaran Proveedor'
      About = 'NB 0.1/20020725'
    end
    object nbLabel30: TnbLabel
      Left = 33
      Top = 50
      Width = 100
      Height = 21
      Caption = 'Centro Llegada'
      About = 'NB 0.1/20020725'
    end
    object btnCentroDestino: TBGridButton
      Left = 172
      Top = 50
      Width = 13
      Height = 21
      Hint = 'Pulse F2 para ver una lista de valores validos. '
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
      Control = centro_llegada_ec
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object lblCentroDestino: TnbStaticText
      Left = 187
      Top = 50
      Width = 270
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object nbLabel31: TnbLabel
      Left = 33
      Top = 189
      Width = 100
      Height = 21
      Caption = 'Transporte'
      About = 'NB 0.1/20020725'
    end
    object btnTransporte: TBGridButton
      Left = 172
      Top = 189
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
      Control = transporte_ec
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object lblTransporte: TnbStaticText
      Left = 187
      Top = 189
      Width = 270
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object nbLabel20: TnbLabel
      Left = 33
      Top = 143
      Width = 100
      Height = 21
      Caption = 'Fecha Llegada'
      About = 'NB 0.1/20020725'
    end
    object btnFecha_Carga: TBCalendarButton
      Left = 212
      Top = 120
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
      OnClick = btnFecha_CargaClick
      Control = fecha_carga_ec
      Calendar = Calendario
      CalendarAlignment = taDownRight
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object lblNombre1: TLabel
      Left = 512
      Top = 131
      Width = 66
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'PALETS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText1: TDBText
      Left = 512
      Top = 144
      Width = 66
      Height = 14
      Alignment = taRightJustify
      DataField = 'palets'
      DataSource = DSDetalleTotales
    end
    object lblNombre2: TLabel
      Left = 655
      Top = 131
      Width = 66
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'CAJAS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText2: TDBText
      Left = 655
      Top = 144
      Width = 66
      Height = 17
      Alignment = taRightJustify
      DataField = 'cajas'
      DataSource = DSDetalleTotales
    end
    object lblNombre3: TLabel
      Left = 584
      Top = 131
      Width = 66
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'KILOS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText3: TDBText
      Left = 584
      Top = 144
      Width = 66
      Height = 17
      Alignment = taRightJustify
      DataField = 'kilos'
      DataSource = DSDetalleTotales
    end
    object lblNombre4: TLabel
      Left = 512
      Top = 182
      Width = 66
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'LINEA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText4: TDBText
      Left = 512
      Top = 193
      Width = 66
      Height = 17
      Alignment = taRightJustify
      DataField = 'importe'
      DataSource = DSDetalleTotales
    end
    object nbLabel22: TnbLabel
      Left = 518
      Top = 45
      Width = 100
      Height = 21
      Caption = 'Centro Grabaci'#243'n'
      About = 'NB 0.1/20020725'
    end
    object nbLabel36: TnbLabel
      Left = 518
      Top = 69
      Width = 100
      Height = 21
      Caption = 'Fecha Grabaci'#243'n'
      About = 'NB 0.1/20020725'
    end
    object lblTomateVerde: TnbLabel
      Left = 660
      Top = 292
      Width = 100
      Height = 21
      Caption = 'Tomate Verde'
      About = 'NB 0.1/20020725'
    end
    object lblDestrio: TnbLabel
      Left = 660
      Top = 316
      Width = 100
      Height = 21
      Caption = 'Destrio'
      About = 'NB 0.1/20020725'
    end
    object lbl1: TLabel
      Left = 825
      Top = 296
      Width = 8
      Height = 13
      Caption = '%'
    end
    object destrio_ec: TLabel
      Left = 800
      Top = 320
      Width = 21
      Height = 13
      Alignment = taRightJustify
      Caption = '0,00'
    end
    object lbl3: TnbLabel
      Left = 33
      Top = 292
      Width = 100
      Height = 21
      Caption = 'Nota Calidad'
      About = 'NB 0.1/20020725'
    end
    object lbl2: TLabel
      Left = 825
      Top = 320
      Width = 8
      Height = 13
      Caption = '%'
    end
    object lblImporte: TLabel
      Left = 509
      Top = 168
      Width = 66
      Height = 13
      AutoSize = False
      Caption = 'Importes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 584
      Top = 182
      Width = 66
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'COMPRA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dlbl1: TDBText
      Left = 638
      Top = 193
      Width = 66
      Height = 17
      Alignment = taRightJustify
      DataField = 'importe'
      DataSource = dsTotalCompra
    end
    object Label2: TLabel
      Left = 655
      Top = 182
      Width = 66
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'DIFF.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDiff: TLabel
      Left = 655
      Top = 193
      Width = 66
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'COMPRA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText5: TDBText
      Left = 584
      Top = 193
      Width = 66
      Height = 17
      Alignment = taRightJustify
      DataField = 'importe'
      DataSource = dsTotalCompra
    end
    object observaciones_ec: TDBMemo
      Left = 136
      Top = 215
      Width = 696
      Height = 73
      DataField = 'observaciones_ec'
      DataSource = DSMaestro
      TabOrder = 13
    end
    object codigo_ec: TBDEdit
      Left = 622
      Top = 21
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 12
      TabOrder = 1
      OnChange = codigo_ecChange
      DataField = 'codigo_ec'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object empresa_ec: TBDEdit
      Left = 136
      Top = 27
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de la empresa es de obligada inserci'#243'n.'
      OnRequiredTime = empresa_ecRequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = empresa_ecChange
      DataField = 'empresa_ec'
      DataSource = DSMaestro
      Modificable = False
    end
    object proveedor_ec: TBDEdit
      Left = 136
      Top = 73
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo del proveedor es de obligada inserci'#243'n.'
      OnRequiredTime = empresa_ecRequiredTime
      MaxLength = 3
      TabOrder = 4
      OnChange = proveedor_ecChange
      DataField = 'proveedor_ec'
      DataSource = DSMaestro
    end
    object vehiculo_ec: TBDEdit
      Left = 136
      Top = 166
      Width = 250
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 20
      TabOrder = 11
      DataField = 'vehiculo_ec'
      DataSource = DSMaestro
    end
    object fecha_carga_ec: TBDEdit
      Left = 136
      Top = 120
      Width = 74
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'La fecha de carga de la mercanc'#237'a es de obligada inserci'#243'n.'
      OnRequiredTime = empresa_ecRequiredTime
      InputType = itDate
      MaxLength = 10
      TabOrder = 8
      DataField = 'fecha_carga_ec'
      DataSource = DSMaestro
    end
    object almacen_ec: TBDEdit
      Left = 136
      Top = 96
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del almac'#233'n del proveedor de obligada inserci'#243'n.'
      OnRequiredTime = empresa_ecRequiredTime
      InputType = itInteger
      MaxLength = 3
      TabOrder = 6
      OnChange = almacen_ecChange
      DataField = 'almacen_ec'
      DataSource = DSMaestro
    end
    object albaran_ec: TBDEdit
      Left = 335
      Top = 120
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      RequiredMsg = 
        'El c'#243'digo del albar'#225'n es de obligada inserci'#243'n ( Si se desconoce' +
        ' ponga '#39'?'#39' ).'
      OnRequiredTime = empresa_ecRequiredTime
      MaxLength = 10
      TabOrder = 9
      DataField = 'albaran_ec'
      DataSource = DSMaestro
    end
    object centro_llegada_ec: TBDEdit
      Left = 136
      Top = 50
      Width = 22
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del cenro destino es de obligada inserci'#243'n.'
      OnRequiredTime = empresa_ecRequiredTime
      MaxLength = 1
      TabOrder = 2
      OnChange = centro_llegada_ecChange
      DataField = 'centro_llegada_ec'
      DataSource = DSMaestro
    end
    object transporte_ec: TBDEdit
      Left = 136
      Top = 189
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itInteger
      MaxLength = 4
      TabOrder = 12
      OnChange = transporte_ecChange
      DataField = 'transporte_ec'
      DataSource = DSMaestro
    end
    object fecha_llegada_ec: TBDEdit
      Left = 136
      Top = 143
      Width = 74
      Height = 21
      Hint = 'Rellenar en destino.'
      ColorEdit = clMoneyGreen
      RequiredMsg = 'La fecha de descarga de la mercanc'#237'a es de obligada inserci'#243'n.'
      OnRequiredTime = empresa_ecRequiredTime
      InputType = itDate
      MaxLength = 10
      TabOrder = 10
      DataField = 'fecha_llegada_ec'
      DataSource = DSMaestro
    end
    object centro_origen_ec: TBDEdit
      Left = 622
      Top = 45
      Width = 19
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 12
      TabOrder = 3
      OnChange = codigo_ecChange
      DataField = 'centro_origen_ec'
      DataSource = DSMaestro
    end
    object fecha_origen_ec: TBDEdit
      Left = 622
      Top = 67
      Width = 74
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itDate
      MaxLength = 12
      TabOrder = 5
      OnChange = codigo_ecChange
      DataField = 'fecha_origen_ec'
      DataSource = DSMaestro
    end
    object tomate_verde_ec: TBDEdit
      Left = 764
      Top = 292
      Width = 57
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 6
      TabOrder = 15
      DataField = 'tomate_verde_ec'
      DataSource = DSMaestro
    end
    object calidad_nota_ec: TDBMemo
      Left = 136
      Top = 292
      Width = 521
      Height = 45
      DataField = 'calidad_nota_ec'
      DataSource = DSMaestro
      TabOrder = 14
    end
    object compra_ec: TDBCheckBox
      Left = 503
      Top = 99
      Width = 193
      Height = 17
      Hint = '(Marcado = COMPRA)'
      Caption = 'COMPRA (Marcar si es compra)'
      DataField = 'compra_ec'
      DataSource = DSMaestro
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
  end
  object pMantenimientoGastos: TPanel
    Left = 746
    Top = 15
    Width = 187
    Height = 103
    TabOrder = 1
    object STTotalGastos: TLabel
      Left = 4
      Top = 28
      Width = 177
      Height = 11
      Alignment = taCenter
      AutoSize = False
      Caption = '0 '#8364' - 0 Facturas'
    end
    object btnGastos: TButton
      Left = 4
      Top = 3
      Width = 179
      Height = 25
      Caption = 'Facturas Asociadas (Alt+G)'
      TabOrder = 0
      OnClick = btnGastosClick
    end
    object btnBalance: TButton
      Left = 4
      Top = 43
      Width = 179
      Height = 27
      Caption = 'Balance Compra'
      Enabled = False
      TabOrder = 1
      OnClick = btnBalanceClick
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 351
    Width = 945
    Height = 349
    ActivePage = tsDetalle
    Align = alClient
    TabHeight = 17
    TabOrder = 4
    TabPosition = tpBottom
    TabStop = False
    TabWidth = 200
    OnChange = PageControlChange
    object tsDetalle: TTabSheet
      Caption = 'Detalle'
      object PRejilla: TPanel
        Left = 0
        Top = 0
        Width = 937
        Height = 324
        Align = alClient
        TabOrder = 0
        object SubPanel1: TPanel
          Left = 677
          Top = 97
          Width = 259
          Height = 226
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 2
          object RVisualizacion3: TDBGrid
            Left = 0
            Top = 0
            Width = 259
            Height = 226
            Align = alClient
            BorderStyle = bsNone
            Color = clScrollBar
            DataSource = DSDetalle2
            Enabled = False
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'centro_er'
                Title.Caption = 'Centro'
                Width = 36
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'numero_entrada_er'
                Title.Caption = 'N'#186' Entrada'
                Width = 72
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'fecha_entrada_er'
                Title.Caption = 'Fecha'
                Width = 63
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'producto_er'
                Title.Caption = 'Producto'
                Width = 47
                Visible = True
              end>
          end
        end
        object PDetalle1: TPanel
          Left = 1
          Top = 1
          Width = 935
          Height = 96
          Align = alTop
          BevelInner = bvLowered
          Enabled = False
          TabOrder = 0
          Visible = False
          object nbLabel10: TnbLabel
            Left = 24
            Top = 42
            Width = 100
            Height = 21
            Caption = 'N'#186' Palets'
            About = 'NB 0.1/20020725'
          end
          object nbLabelCajas: TnbLabel
            Left = 176
            Top = 42
            Width = 100
            Height = 21
            Caption = 'N'#186' Cajas'
            About = 'NB 0.1/20020725'
          end
          object nbLabelKilos: TnbLabel
            Left = 327
            Top = 42
            Width = 100
            Height = 21
            Caption = 'Kilos Albar'#225'n'
            About = 'NB 0.1/20020725'
          end
          object nbLabel8: TnbLabel
            Left = 498
            Top = 18
            Width = 102
            Height = 21
            Caption = 'C'#243'digo Proveedor'
            About = 'NB 0.1/20020725'
          end
          object lblVariedad: TLabel
            Left = 670
            Top = 22
            Width = 52
            Height = 13
            Caption = 'lblVariedad'
          end
          object nbLabel13: TnbLabel
            Left = 24
            Top = 18
            Width = 100
            Height = 21
            Caption = 'Producto'
            About = 'NB 0.1/20020725'
          end
          object btnProductoProveedor: TBGridButton
            Left = 649
            Top = 18
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
            OnClick = btnProductoProveedorClick
            Control = variedad_el
            Grid = RejillaFlotante
            GridAlignment = taDownRight
            GridWidth = 280
            GridHeigth = 200
          end
          object btnProducto: TBGridButton
            Left = 161
            Top = 18
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
            Control = producto_el
            Grid = RejillaFlotante
            GridAlignment = taDownRight
            GridWidth = 280
            GridHeigth = 200
          end
          object nbLabel9: TnbLabel
            Left = 176
            Top = 18
            Width = 100
            Height = 21
            Caption = 'Categor'#237'a'
            About = 'NB 0.1/20020725'
          end
          object nbLabel17: TnbLabel
            Left = 327
            Top = 18
            Width = 100
            Height = 21
            Caption = 'Calibre'
            About = 'NB 0.1/20020725'
          end
          object btnCategoria: TBGridButton
            Left = 305
            Top = 18
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
            OnClick = btnCategoriaClick
            Control = categoria_el
            Grid = RejillaFlotante
            GridAlignment = taDownRight
            GridWidth = 280
            GridHeigth = 200
          end
          object btnCalibre: TBGridButton
            Left = 481
            Top = 18
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
            Control = calibre_el
            Grid = RejillaFlotante
            GridAlignment = taDownRight
            GridWidth = 280
            GridHeigth = 200
          end
          object lblUnidadPrecio: TnbLabel
            Left = 667
            Top = 42
            Width = 100
            Height = 21
            Caption = 'Precio '
            About = 'NB 0.1/20020725'
          end
          object nbLabel15: TnbLabel
            Left = 498
            Top = 42
            Width = 100
            Height = 21
            Caption = 'Unidades'
            About = 'NB 0.1/20020725'
          end
          object lblPesoBruto: TLabel
            Left = 176
            Top = 65
            Width = 85
            Height = 13
            Alignment = taRightJustify
            Caption = 'Peso Bruto 0 Kgs.'
          end
          object lblAprovecha: TnbLabel
            Left = 498
            Top = 65
            Width = 100
            Height = 21
            Caption = 'Aprovechamiento'
            About = 'NB 0.1/20020725'
          end
          object lblPorcenAprovecha: TLabel
            Left = 667
            Top = 69
            Width = 96
            Height = 13
            Caption = 'lblPorcenAprovecha'
          end
          object nbLabel11: TnbLabel
            Left = 327
            Top = 65
            Width = 100
            Height = 21
            Caption = 'Peso Real'
            About = 'NB 0.1/20020725'
          end
          object producto_el: TBDEdit
            Left = 127
            Top = 18
            Width = 33
            Height = 21
            ColorEdit = clMoneyGreen
            Required = True
            RequiredMsg = 'El codigo de producto es obligatorio'
            OnRequiredTime = empresa_ecRequiredTime
            MaxLength = 3
            TabOrder = 0
            OnChange = producto_elChange
            OnEnter = producto_elEnter
            DataField = 'producto_el'
            DataSource = DSDetalle1
          end
          object cajas_el: TBDEdit
            Left = 280
            Top = 42
            Width = 39
            Height = 21
            ColorEdit = clMoneyGreen
            Required = True
            RequiredMsg = 'El n'#250'mero de cajas es obligatorio'
            InputType = itInteger
            MaxLength = 12
            TabOrder = 6
            OnChange = cajas_elChange
            DataField = 'cajas_el'
            DataSource = DSDetalle1
          end
          object palets_el: TBDEdit
            Left = 127
            Top = 42
            Width = 31
            Height = 21
            ColorEdit = clMoneyGreen
            Required = True
            RequiredMsg = 'El n'#250'mero de palets es obligatorio'
            InputType = itInteger
            TabOrder = 5
            OnChange = palets_elChange
            DataField = 'palets_el'
            DataSource = DSDetalle1
          end
          object kilos_el: TBDEdit
            Left = 431
            Top = 42
            Width = 57
            Height = 21
            ColorEdit = clMoneyGreen
            Required = True
            RequiredMsg = 'El n'#250'mero de kilos es obligatorio'
            InputType = itReal
            MaxDecimals = 2
            MaxLength = 12
            TabOrder = 7
            OnChange = kilos_elChange
            DataField = 'kilos_el'
            DataSource = DSDetalle1
          end
          object variedad_el: TBDEdit
            Left = 604
            Top = 18
            Width = 43
            Height = 21
            ColorEdit = clMoneyGreen
            Required = True
            RequiredMsg = 'El producto del proveedor es de obligada inserci'#243'n.'
            OnRequiredTime = empresa_ecRequiredTime
            InputType = itInteger
            MaxLength = 3
            TabOrder = 3
            OnChange = variedad_elChange
            DataField = 'variedad_el'
            DataSource = DSDetalle1
          end
          object categoria_el: TBDEdit
            Left = 280
            Top = 18
            Width = 23
            Height = 21
            ColorEdit = clMoneyGreen
            Required = True
            RequiredMsg = 'La categor'#237'a es obligatoria.'
            OnRequiredTime = empresa_ecRequiredTime
            MaxLength = 2
            TabOrder = 1
            DataField = 'categoria_el'
            DataSource = DSDetalle1
          end
          object calibre_el: TBDEdit
            Left = 431
            Top = 18
            Width = 49
            Height = 21
            ColorEdit = clMoneyGreen
            Required = True
            RequiredMsg = 'El calibre es obligatorio.'
            OnRequiredTime = empresa_ecRequiredTime
            MaxLength = 6
            TabOrder = 2
            DataField = 'calibre_el'
            DataSource = DSDetalle1
          end
          object precio_el: TBDEdit
            Left = 771
            Top = 42
            Width = 56
            Height = 21
            ColorEdit = clMoneyGreen
            InputType = itReal
            MaxDecimals = 5
            MaxLength = 10
            TabOrder = 9
            DataField = 'precio_el'
            DataSource = DSDetalle1
          end
          object cbxUnidad_precio_el: TComboBox
            Left = 830
            Top = 42
            Width = 81
            Height = 21
            BevelInner = bvNone
            BevelOuter = bvNone
            Style = csDropDownList
            Color = clInactiveBorder
            Ctl3D = False
            ItemHeight = 13
            ItemIndex = 0
            ParentCtl3D = False
            TabOrder = 10
            Text = 'KILOS'
            OnChange = cbxUnidad_precio_elChange
            Items.Strings = (
              'KILOS'
              'CAJAS'
              'UNIDADES')
          end
          object unidad_precio_el: TBDEdit
            Left = 757
            Top = 18
            Width = 26
            Height = 21
            ColorEdit = clMoneyGreen
            InputType = itInteger
            Enabled = False
            Visible = False
            ReadOnly = True
            MaxLength = 3
            TabOrder = 4
            OnChange = unidad_precio_elChange
            DataField = 'unidad_precio_el'
            DataSource = DSDetalle1
          end
          object unidades_el: TBDEdit
            Left = 604
            Top = 42
            Width = 43
            Height = 21
            ColorEdit = clMoneyGreen
            InputType = itInteger
            TabOrder = 8
            DataField = 'unidades_el'
            DataSource = DSDetalle1
          end
          object aprovechados_el: TBDEdit
            Left = 604
            Top = 65
            Width = 57
            Height = 21
            ColorEdit = clMoneyGreen
            InputType = itReal
            MaxDecimals = 2
            MaxLength = 12
            TabOrder = 12
            OnChange = aprovechados_elChange
            DataField = 'aprovechados_el'
            DataSource = DSDetalle1
          end
          object peso_el: TBDEdit
            Left = 431
            Top = 65
            Width = 57
            Height = 21
            ColorEdit = clMoneyGreen
            InputType = itReal
            MaxDecimals = 2
            MaxLength = 12
            TabOrder = 11
            OnChange = aprovechados_elChange
            DataField = 'peso_el'
            DataSource = DSDetalle1
          end
        end
        object RVisualizacion1: TDBGrid
          Left = 1
          Top = 97
          Width = 676
          Height = 226
          TabStop = False
          Align = alClient
          DataSource = DSDetalle1
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ReadOnly = True
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDrawColumnCell = RVisualizacion1DrawColumnCell
          OnDblClick = RVisualizacion1DblClick
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'producto_el'
              Title.Alignment = taCenter
              Title.Caption = 'Prod.'
              Width = 41
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'categoria_el'
              Title.Alignment = taCenter
              Title.Caption = 'Cat.'
              Width = 35
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'calibre_el'
              Title.Alignment = taCenter
              Title.Caption = 'Calibre'
              Width = 35
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'variedad_el'
              Title.Caption = 'Descripcion'
              Width = 141
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'palets_el'
              Title.Caption = 'Palets'
              Width = 54
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'cajas_el'
              Title.Caption = 'Cajas'
              Width = 50
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'kilos_el'
              Title.Caption = 'Kgs Albar'#225'n'
              Width = 60
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'peso_el'
              Title.Caption = 'Peso Real'
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'aprovechados_el'
              Title.Caption = 'Aprovecha.'
              Width = 60
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'unidades_el'
              Title.Caption = 'Unidades'
              Width = 51
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'precio_el'
              Title.Caption = 'Precio'
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'unidad_precio_el'
              Title.Caption = 'Fact. Por'
              Width = 50
              Visible = True
            end>
        end
      end
    end
    object tsEntradas: TTabSheet
      Caption = 'Entradas'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object PDetalle2: TPanel
        Left = 0
        Top = 0
        Width = 937
        Height = 81
        Align = alTop
        BevelInner = bvLowered
        Enabled = False
        TabOrder = 0
        Visible = False
        object nbLabel26: TnbLabel
          Left = 10
          Top = 15
          Width = 100
          Height = 21
          Caption = 'Centro Entrega'
          About = 'NB 0.1/20020725'
        end
        object nbLabel27: TnbLabel
          Left = 349
          Top = 15
          Width = 100
          Height = 21
          Caption = 'Albar'#225'n Entrada'
          About = 'NB 0.1/20020725'
        end
        object nbLabel28: TnbLabel
          Left = 526
          Top = 15
          Width = 100
          Height = 21
          Caption = 'Fecha Entrada'
          About = 'NB 0.1/20020725'
        end
        object nbLabel29: TnbLabel
          Left = 11
          Top = 39
          Width = 100
          Height = 21
          Caption = 'Cosechero'
          About = 'NB 0.1/20020725'
        end
        object nbLabel34: TnbLabel
          Left = 349
          Top = 39
          Width = 100
          Height = 21
          Caption = 'Plantaci'#243'n'
          About = 'NB 0.1/20020725'
        end
        object nbLabel35: TnbLabel
          Left = 137
          Top = 15
          Width = 100
          Height = 21
          Caption = 'Producto'
          About = 'NB 0.1/20020725'
        end
        object lblCosechero: TnbStaticText
          Left = 154
          Top = 39
          Width = 190
          Height = 21
          Caption = 'lblCosechero'
          About = 'NB 0.1/20020725'
        end
        object lblPlantacion: TnbStaticText
          Left = 490
          Top = 39
          Width = 190
          Height = 21
          Caption = 'lblPlantacion'
          About = 'NB 0.1/20020725'
        end
        object centro_er: TBDEdit
          Left = 114
          Top = 15
          Width = 17
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 1
          TabOrder = 0
          DataField = 'centro_er'
          DataSource = DSDetalle2
        end
        object numero_entrada_er: TBDEdit
          Left = 453
          Top = 15
          Width = 68
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 10
          TabOrder = 2
          DataField = 'numero_entrada_er'
          DataSource = DSDetalle2
        end
        object fecha_entrada_er: TBDEdit
          Left = 630
          Top = 15
          Width = 68
          Height = 21
          ColorEdit = clMoneyGreen
          InputType = itDate
          MaxLength = 10
          TabOrder = 3
          DataField = 'fecha_entrada_er'
          DataSource = DSDetalle2
        end
        object cosechero_er: TBDEdit
          Left = 115
          Top = 39
          Width = 33
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 3
          TabOrder = 4
          OnChange = cosechero_erChange
          DataField = 'cosechero_er'
          DataSource = DSDetalle2
        end
        object plantacion_er: TBDEdit
          Left = 453
          Top = 39
          Width = 33
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 3
          TabOrder = 5
          OnChange = plantacion_erChange
          DataField = 'plantacion_er'
          DataSource = DSDetalle2
        end
        object producto_er: TBDEdit
          Left = 241
          Top = 15
          Width = 33
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 3
          TabOrder = 1
          DataField = 'producto_er'
          DataSource = DSDetalle2
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 81
        Width = 937
        Height = 243
        Align = alClient
        TabOrder = 1
        object RVisualizacion2: TDBGrid
          Left = 1
          Top = 1
          Width = 935
          Height = 241
          TabStop = False
          Align = alClient
          DataSource = DSDetalle2
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
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
              FieldName = 'centro_er'
              Title.Caption = 'Centro'
              Width = 85
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'producto_er'
              Title.Caption = 'Producto'
              Width = 85
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'numero_entrada_er'
              Title.Caption = 'Entrada'
              Width = 85
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'fecha_entrada_er'
              Title.Caption = 'Fecha Entrada'
              Width = 85
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'cosechero_er'
              Title.Caption = 'Cosechero'
              Width = 85
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'plantacion_er'
              Title.Caption = 'Plantaci'#243'n'
              Width = 85
              Visible = True
            end>
        end
      end
    end
    object tsCalidad: TTabSheet
      Caption = 'Calidad'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlDetalleCalidad: TPanel
        Left = 0
        Top = 0
        Width = 937
        Height = 81
        Align = alTop
        BevelInner = bvLowered
        Enabled = False
        TabOrder = 0
        Visible = False
        object lblCliente: TnbLabel
          Left = 33
          Top = 17
          Width = 100
          Height = 21
          Caption = 'Cliente'
          About = 'NB 0.1/20020725'
        end
        object btnCliente: TBGridButton
          Left = 172
          Top = 17
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
          OnClick = btnClienteClick
          Control = cliente_eca
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 280
          GridHeigth = 200
        end
        object stCliente: TnbStaticText
          Left = 187
          Top = 17
          Width = 270
          Height = 21
          About = 'NB 0.1/20020725'
        end
        object lblEnvase: TnbLabel
          Left = 33
          Top = 40
          Width = 100
          Height = 21
          Caption = 'Art'#237'culo'
          About = 'NB 0.1/20020725'
        end
        object stenvase: TnbStaticText
          Left = 187
          Top = 40
          Width = 270
          Height = 21
          About = 'NB 0.1/20020725'
        end
        object lblFechaCalidad: TnbLabel
          Left = 459
          Top = 40
          Width = 100
          Height = 21
          Caption = 'Fecha Venta'
          About = 'NB 0.1/20020725'
        end
        object btnFechaCalidad: TBCalendarButton
          Left = 638
          Top = 40
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
          OnClick = btnFechaCalidadClick
          Control = fecha_eca
          Calendar = Calendario
          CalendarAlignment = taDownRight
          CalendarWidth = 197
          CalendarHeigth = 153
        end
        object lblPorcentaje: TnbLabel
          Left = 711
          Top = 40
          Width = 100
          Height = 21
          Caption = 'Porcentaje'
          About = 'NB 0.1/20020725'
        end
        object lblPorcentaje2: TLabel
          Left = 876
          Top = 44
          Width = 8
          Height = 13
          Caption = '%'
        end
        object lblProducto: TnbLabel
          Left = 459
          Top = 17
          Width = 100
          Height = 21
          Caption = 'Producto'
          About = 'NB 0.1/20020725'
        end
        object btnProducto_eca: TBGridButton
          Left = 598
          Top = 17
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
          OnClick = btnProducto_ecaClick
          Control = producto_eca
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 280
          GridHeigth = 200
        end
        object stProducto: TnbStaticText
          Left = 613
          Top = 17
          Width = 270
          Height = 21
          About = 'NB 0.1/20020725'
        end
        object cliente_eca: TBDEdit
          Left = 136
          Top = 17
          Width = 33
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 3
          TabOrder = 0
          OnChange = cliente_ecaChange
          DataField = 'cliente_eca'
          DataSource = DSDetalle3
        end
        object fecha_eca: TBDEdit
          Left = 562
          Top = 40
          Width = 74
          Height = 21
          ColorEdit = clMoneyGreen
          InputType = itDate
          MaxLength = 10
          TabOrder = 4
          DataField = 'fecha_eca'
          DataSource = DSDetalle3
        end
        object porcentaje_eca: TBDEdit
          Left = 815
          Top = 40
          Width = 57
          Height = 21
          ColorEdit = clMoneyGreen
          InputType = itReal
          MaxDecimals = 2
          MaxLength = 6
          TabOrder = 5
          DataField = 'porcentaje_eca'
          DataSource = DSDetalle3
        end
        object producto_eca: TBDEdit
          Left = 562
          Top = 17
          Width = 33
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 3
          TabOrder = 1
          OnChange = producto_ecaChange
          DataField = 'producto_eca'
          DataSource = DSDetalle3
        end
        object envase_eca: TcxDBTextEdit
          Left = 89
          Top = 40
          DataBinding.DataField = 'envase_eca'
          DataBinding.DataSource = DSDetalle3
          Properties.CharCase = ecUpperCase
          Properties.MaxLength = 9
          Properties.OnChange = envase_ecaChange
          Style.BorderStyle = ebs3D
          Style.LookAndFeel.Kind = lfUltraFlat
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.Kind = lfUltraFlat
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.Kind = lfUltraFlat
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.Kind = lfUltraFlat
          StyleHot.LookAndFeel.NativeStyle = False
          TabOrder = 2
          OnExit = envase_ecaExit
          Width = 75
        end
        object ssEnvase: TSimpleSearch
          Left = 164
          Top = 40
          Width = 21
          Height = 21
          Hint = 'B'#250'squeda de Art'#237'culo'
          TabOrder = 3
          TabStop = False
          LookAndFeel.NativeStyle = False
          LookAndFeel.SkinName = 'MoneyTwins'
          OptionsImage.ImageIndex = 2
          OptionsImage.Images = FDM.ilxImagenes
          Titulo = 'Busqueda de Art'#237'culos'
          Tabla = 'frf_envases'
          Campos = <
            item
              Etiqueta = 'Art'#237'culo'
              Campo = 'envase_e'
              Ancho = 100
              Tipo = ctCadena
            end
            item
              Etiqueta = 'Descripci'#243'n'
              Campo = 'descripcion_e'
              Ancho = 400
              Tipo = ctCadena
            end>
          Database = 'BDProyecto'
          Join = 'fecha_baja_e is null'
          CampoResultado = 'envase_e'
          Enlace = envase_eca
          Tecla = 'F2'
          AntesEjecutar = ssEnvaseAntesEjecutar
          Concatenar = False
        end
      end
      object RVisualizacionCalidad: TDBGrid
        Left = 0
        Top = 81
        Width = 937
        Height = 243
        TabStop = False
        Align = alClient
        DataSource = DSDetalle3
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
            FieldName = 'codigo_eca'
            Title.Caption = 'Entrega'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'empresa_eca'
            Title.Caption = 'Planta'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cliente_eca'
            Title.Caption = 'Cliente'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'desCliente'
            Title.Caption = 'Descripci'#243'n Cliente'
            Width = 183
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'envase_eca'
            Title.Caption = 'Art'#237'culo'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'desEnvase'
            Title.Caption = 'Descripci'#243'n Art'#237'culo'
            Width = 263
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'fecha_eca'
            Title.Caption = 'Fecha Salida'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'porcentaje_eca'
            Title.Caption = 'Porcentaje'
            Visible = True
          end>
      end
    end
    object tsMaterial: TTabSheet
      Caption = 'Material'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlDetalleMaterial: TPanel
        Left = 0
        Top = 0
        Width = 937
        Height = 69
        Align = alTop
        BevelInner = bvLowered
        Enabled = False
        TabOrder = 0
        Visible = False
        object nbLabel3: TnbLabel
          Left = 33
          Top = 17
          Width = 100
          Height = 21
          Caption = 'Operador/Envase'
          About = 'NB 0.1/20020725'
        end
        object btnOperador: TBGridButton
          Left = 172
          Top = 17
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
          OnClick = btnOperadorClick
          Control = cod_operador_em
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 280
          GridHeigth = 200
        end
        object btnEnvaseOperador: TBGridButton
          Left = 235
          Top = 17
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
          OnClick = btnEnvaseOperadorClick
          Control = cod_producto_em
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 280
          GridHeigth = 200
        end
        object stEnvaseOperador: TnbStaticText
          Left = 250
          Top = 17
          Width = 260
          Height = 21
          About = 'NB 0.1/20020725'
        end
        object nbLabel12: TnbLabel
          Left = 520
          Top = 16
          Width = 65
          Height = 21
          Caption = 'Entrada'
          About = 'NB 0.1/20020725'
        end
        object lblCodigo1: TnbLabel
          Left = 651
          Top = 16
          Width = 65
          Height = 21
          Caption = 'Salida'
          About = 'NB 0.1/20020725'
        end
        object lblCodigoNotas: TnbLabel
          Left = 33
          Top = 39
          Width = 100
          Height = 21
          Caption = 'Observaciones'
          About = 'NB 0.1/20020725'
        end
        object cod_operador_em: TBDEdit
          Left = 136
          Top = 17
          Width = 33
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 3
          TabOrder = 2
          OnChange = cod_operador_producto_emChange
          DataField = 'cod_operador_em'
          DataSource = dsMaterial
        end
        object cod_producto_em: TBDEdit
          Left = 187
          Top = 17
          Width = 47
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 5
          TabOrder = 3
          OnChange = cod_operador_producto_emChange
          DataField = 'cod_producto_em'
          DataSource = dsMaterial
        end
        object entrada_em: TBDEdit
          Left = 589
          Top = 16
          Width = 57
          Height = 21
          ColorEdit = clMoneyGreen
          InputType = itInteger
          MaxLength = 4
          TabOrder = 0
          DataField = 'entrada_em'
          DataSource = dsMaterial
        end
        object salida_em: TBDEdit
          Left = 720
          Top = 16
          Width = 57
          Height = 21
          ColorEdit = clMoneyGreen
          InputType = itInteger
          MaxLength = 4
          TabOrder = 1
          DataField = 'salida_em'
          DataSource = dsMaterial
        end
        object notas_em: TBDEdit
          Left = 136
          Top = 39
          Width = 510
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 50
          TabOrder = 4
          OnChange = cliente_ecaChange
          DataField = 'notas_em'
          DataSource = dsMaterial
        end
      end
      object RVisualizacionMaterial: TDBGrid
        Left = 0
        Top = 69
        Width = 937
        Height = 255
        TabStop = False
        Align = alClient
        DataSource = dsMaterial
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
            FieldName = 'codigo_em'
            Title.Caption = 'Albar'#225'n'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'fecha_em'
            Title.Caption = 'F.Carga'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cod_operador_em'
            Title.Caption = 'Operador'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cod_producto_em'
            Title.Caption = 'Envase'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'des_envase'
            Title.Caption = 'Des.Envase'
            Width = 214
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'entrada_em'
            Title.Caption = 'Entrada'
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'salida_em'
            Title.Caption = 'Salida'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'notas_em'
            Title.Caption = 'Observaciones'
            Width = 295
            Visible = True
          end>
      end
    end
  end
  object RejillaFlotante: TBGrid
    Left = 886
    Top = 104
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
    Left = 878
    Top = 168
    Width = 177
    Height = 153
    Date = 36864.361902847220000000
    TabOrder = 3
    Visible = False
    WeekNumbers = True
  end
  object DSMaestro: TDataSource
    DataSet = MDEntregas.QEntregasC
    Left = 8
    Top = 8
  end
  object DSDetalleTotales: TDataSource
    AutoEdit = False
    DataSet = MDEntregas.QTotalLineas
    OnDataChange = DSDetalleTotalesDataChange
    Left = 750
    Top = 127
  end
  object DSDetalle1: TDataSource
    DataSet = MDEntregas.TEntregasL
    Left = 8
    Top = 336
  end
  object DSDetalle2: TDataSource
    Left = 56
    Top = 336
  end
  object DSCompras: TDataSource
    Left = 472
    Top = 16
  end
  object DSDetalle3: TDataSource
    OnStateChange = DSDetalle3StateChange
    Left = 96
    Top = 344
  end
  object dsMaterial: TDataSource
    Left = 143
    Top = 335
  end
  object dsTotalCompra: TDataSource
    AutoEdit = False
    DataSet = MDEntregas.QTotalFacturaCompra
    OnDataChange = dsTotalCompraDataChange
    Left = 769
    Top = 152
  end
end
