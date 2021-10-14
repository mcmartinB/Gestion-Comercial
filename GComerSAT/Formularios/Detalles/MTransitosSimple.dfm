object FMTransitosSimple: TFMTransitosSimple
  Left = 502
  Top = 299
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  TR'#193'NSITOS'
  ClientHeight = 665
  ClientWidth = 1138
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
  object PRejilla: TPanel
    Left = 0
    Top = 471
    Width = 1138
    Height = 194
    Align = alClient
    TabOrder = 3
    object RVisualizacion: TDBGrid
      Left = 1
      Top = 1
      Width = 1136
      Height = 192
      TabStop = False
      Align = alClient
      DataSource = DSDetalle
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = RVisualizacionDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'producto_tl'
          Title.Caption = 'Producto'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'centro_origen_tl'
          Title.Caption = 'Centro Origen'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ref_origen_tl'
          Title.Caption = 'Referencia'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fecha_origen_tl'
          Title.Caption = 'Fecha'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'envase_tl'
          Title.Caption = 'Art'#237'culo'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'desEnvase'
          Title.Caption = 'Descripci'#243'n'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'marca_tl'
          Title.Caption = 'Marca'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'categoria_tl'
          Title.Caption = 'Categoria'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'color_tl'
          Title.Caption = 'Color'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'calibre_tl'
          Title.Caption = 'Calibre'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'unidades_caja_tl'
          Title.Alignment = taRightJustify
          Title.Caption = 'Unds.'
          Width = 42
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cajas_tl'
          Title.Alignment = taRightJustify
          Title.Caption = 'Cajas'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'kilos_tl'
          Title.Alignment = taRightJustify
          Title.Caption = 'Kilos'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'precio_tl'
          Title.Alignment = taCenter
          Title.Caption = 'Precio'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'importe_linea_tl'
          Title.Alignment = taCenter
          Title.Caption = 'Importe'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'palets_tl'
          Title.Alignment = taRightJustify
          Title.Caption = 'Palets'
          Width = 43
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'tipo_palet_tl'
          Title.Alignment = taCenter
          Title.Caption = 'Tipo Palet'
          Width = 57
          Visible = True
        end>
    end
  end
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 1138
    Height = 345
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
    object LEmpresa_p: TLabel
      Left = 17
      Top = 61
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' Centro Salida'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 17
      Top = 15
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa_tc: TBGridButton
      Left = 173
      Top = 13
      Width = 13
      Height = 22
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
      OnClick = BGBEmpresa_tcClick
      Control = empresa_tc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object Label3: TLabel
      Left = 208
      Top = 37
      Width = 88
      Height = 19
      AutoSize = False
      Caption = ' Fecha/Hora Salida'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 17
      Top = 83
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' Transporte'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 446
      Top = 83
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' Matricula'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBCentro_tc: TBGridButton
      Left = 158
      Top = 60
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BGBCentro_tcClick
      Control = centro_tc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object BGBTransporte_tc: TBGridButton
      Left = 173
      Top = 82
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BGBTransporte_tcClick
      Control = transporte_tc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object BCBCalendario: TBCalendarButton
      Left = 365
      Top = 36
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BCBCalendarioClick
      Control = fecha_tc
      Calendar = Calendario
      CalendarAlignment = taDownLeft
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object Referencia: TLabel
      Left = 17
      Top = 37
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' Referencia'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 17
      Top = 105
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' Buque'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 17
      Top = 127
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' Puerto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblStatusGastos: TLabel
      Left = 27
      Top = 247
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Asig. gastos'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label20: TLabel
      Left = 446
      Top = 61
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' Centro Destino'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBCentro_destino_tc: TBGridButton
      Left = 583
      Top = 60
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BGBCentro_destino_tcClick
      Control = centro_destino_tc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object Label24: TLabel
      Left = 17
      Top = 150
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' Transporte Bonnysa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label12: TLabel
      Left = 28
      Top = 200
      Width = 169
      Height = 19
      AutoSize = False
      Caption = ' Observaciones'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNumCMR: TLabel
      Left = 28
      Top = 225
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Num. CMR'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label8: TLabel
      Left = 446
      Top = 150
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' Fecha/Hora Entrada'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BCalendarButton1: TBCalendarButton
      Left = 627
      Top = 149
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BCBCalendarioClick
      Control = fecha_entrada_tc
      Calendar = Calendario
      CalendarAlignment = taDownLeft
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object BGBpuerto_tc: TBGridButton
      Left = 158
      Top = 126
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BGBpuerto_tcClick
      Control = puerto_tc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object lblNombre1: TLabel
      Left = 446
      Top = 127
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' Destino'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl1: TLabel
      Left = 28
      Top = 269
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Cond.Higiene.OK'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblCarpetaDeposito: TLabel
      Left = 28
      Top = 291
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' Carpeta Deposito'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object bvl1: TBevel
      Left = 28
      Top = 200
      Width = 170
      Height = 17
      Shape = bsTopLine
      Style = bsRaised
    end
    object lbl2: TLabel
      Left = 446
      Top = 105
      Width = 105
      Height = 19
      AutoSize = False
      Caption = ' Naviera'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl4: TLabel
      Left = 537
      Top = 319
      Width = 85
      Height = 16
      AutoSize = False
      Caption = ' Precio Palet Plastico'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl5: TLabel
      Left = 689
      Top = 319
      Width = 85
      Height = 16
      AutoSize = False
      Caption = ' Precio Caja Platico'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl6: TLabel
      Left = 17
      Top = 174
      Width = 115
      Height = 19
      AutoSize = False
      Caption = ' Cond. Pago (Incoterm)'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBincoterm_c: TBGridButton
      Left = 173
      Top = 172
      Width = 13
      Height = 22
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
      OnClick = BGBincoterm_cClick
      Control = incoterm_tc
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object lbl7: TLabel
      Left = 446
      Top = 174
      Width = 101
      Height = 19
      AutoSize = False
      Caption = ' Plaza Entrega'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label25: TLabel
      Left = 682
      Top = 37
      Width = 121
      Height = 19
      AutoSize = False
      Caption = 'Excluir de calculo POSEI'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object cbx_status_gastos_tc: TComboBox
      Left = 119
      Top = 246
      Width = 71
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 26
      Visible = False
      OnKeyDown = cbx_status_gastos_tcKeyDown
      Items.Strings = (
        'Todos'
        'Asignados'
        'Por Asignar')
    end
    object cbx_porte_bonny_tc: TComboBox
      Left = 136
      Top = 149
      Width = 68
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 17
      Visible = False
      OnKeyDown = cbx_porte_bonny_tcKeyDown
      Items.Strings = (
        'Todos'
        'Si'
        'No')
    end
    object eGastoAsignado: TBDEdit
      Left = 32
      Top = 313
      Width = 41
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itDate
      Enabled = False
      Visible = False
      TabOrder = 31
      DataField = 'status_gastos_tc'
      DataSource = DSMaestro
      Modificable = False
    end
    object centro_tc: TBDEdit
      Tag = 1
      Left = 134
      Top = 60
      Width = 22
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 1
      TabOrder = 5
      OnChange = centro_tcChange
      DataField = 'centro_tc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object centro_destino_tc: TBDEdit
      Tag = 1
      Left = 557
      Top = 60
      Width = 22
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 1
      TabOrder = 6
      OnChange = centro_destino_tcChange
      DataField = 'centro_destino_tc'
      DataSource = DSMaestro
      Modificable = False
    end
    object empresa_tc: TBDEdit
      Tag = 1
      Left = 134
      Top = 14
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = empresa_tcChange
      DataField = 'empresa_tc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object STEmpresa_tc: TStaticText
      Left = 189
      Top = 16
      Width = 230
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object STCentro_tc: TStaticText
      Left = 174
      Top = 62
      Width = 245
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 7
    end
    object fecha_tc: TBDEdit
      Left = 295
      Top = 36
      Width = 69
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itDate
      TabOrder = 3
      DataField = 'fecha_tc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object transporte_tc: TBDEdit
      Left = 134
      Top = 82
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 9
      OnChange = transporte_tcChange
      DataField = 'transporte_tc'
      DataSource = DSMaestro
    end
    object vehiculo_tc: TBDEdit
      Left = 557
      Top = 82
      Width = 286
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 20
      TabOrder = 10
      DataField = 'vehiculo_tc'
      DataSource = DSMaestro
    end
    object STTransporte_tc: TStaticText
      Left = 191
      Top = 83
      Width = 228
      Height = 19
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 11
    end
    object referencia_tc: TBDEdit
      Left = 134
      Top = 36
      Width = 73
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itInteger
      MaxLength = 6
      TabOrder = 2
      DataField = 'referencia_tc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object buque_tc: TBDEdit
      Left = 134
      Top = 104
      Width = 286
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 12
      DataField = 'buque_tc'
      DataSource = DSMaestro
    end
    object destino_tc: TBDEdit
      Left = 557
      Top = 126
      Width = 286
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 15
      DataField = 'destino_tc'
      DataSource = DSMaestro
    end
    object Status_gastos_tc: TDBCheckBox
      Left = 119
      Top = 248
      Width = 17
      Height = 18
      Caption = 'Status_gastos_tc'
      DataField = 'status_gastos_tc'
      DataSource = DSMaestro
      ReadOnly = True
      TabOrder = 27
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object STCentro_destino_tc: TStaticText
      Left = 598
      Top = 62
      Width = 245
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 8
    end
    object porte_bonny_tc: TDBCheckBox
      Left = 134
      Top = 151
      Width = 19
      Height = 17
      Caption = 'porte_bonny_tc'
      DataField = 'porte_bonny_tc'
      DataSource = DSMaestro
      TabOrder = 23
      ValueChecked = '1'
      ValueUnchecked = '0'
      OnEnter = porte_bonny_tcEnter
      OnExit = porte_bonny_tcExit
    end
    object nota_tc: TDBMemo
      Left = 200
      Top = 200
      Width = 643
      Height = 111
      Color = clWhite
      DataField = 'nota_tc'
      DataSource = DSMaestro
      TabOrder = 24
      OnEnter = nota_tcEnter
      OnExit = nota_tcExit
    end
    object n_cmr_tc: TBDEdit
      Left = 119
      Top = 224
      Width = 71
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itInteger
      MaxLength = 10
      TabOrder = 25
      DataField = 'n_cmr_tc'
      DataSource = DSMaestro
    end
    object fecha_entrada_tc: TBDEdit
      Left = 557
      Top = 149
      Width = 69
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itDate
      TabOrder = 18
      DataField = 'fecha_entrada_tc'
      DataSource = DSMaestro
    end
    object puerto_tc: TBDEdit
      Tag = 1
      Left = 134
      Top = 126
      Width = 22
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itInteger
      MaxLength = 2
      TabOrder = 14
      OnChange = puerto_tcChange
      DataField = 'puerto_tc'
      DataSource = DSMaestro
    end
    object stPuerto_tc: TStaticText
      Left = 174
      Top = 128
      Width = 245
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 16
    end
    object cbb_higiene_tc: TComboBox
      Left = 119
      Top = 268
      Width = 53
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 28
      Visible = False
      Items.Strings = (
        'Todos'
        'Si'
        'No')
    end
    object higiene_tc: TDBCheckBox
      Left = 119
      Top = 268
      Width = 17
      Height = 17
      DataField = 'higiene_tc'
      DataSource = DSMaestro
      TabOrder = 29
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object carpeta_deposito_tc: TBDEdit
      Left = 119
      Top = 290
      Width = 71
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itInteger
      MaxLength = 8
      TabOrder = 30
      DataField = 'carpeta_deposito_tc'
      DataSource = DSMaestro
    end
    object naviera_tc: TBDEdit
      Left = 557
      Top = 104
      Width = 286
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 13
      DataField = 'naviera_tc'
      DataSource = DSMaestro
    end
    object hora_entrada_tc: TBDEdit
      Left = 641
      Top = 149
      Width = 41
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 5
      TabOrder = 19
      DataField = 'hora_entrada_tc'
      DataSource = DSMaestro
    end
    object hora_tc: TBDEdit
      Left = 378
      Top = 37
      Width = 41
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 5
      TabOrder = 4
      DataField = 'hora_tc'
      DataSource = DSMaestro
    end
    object precio_palet_plas_tc: TBDEdit
      Left = 622
      Top = 317
      Width = 67
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itReal
      MaxDecimals = 3
      MaxLength = 5
      TabOrder = 32
      OnChange = cajas_tlChange
      DataField = 'precio_palet_plas_tc'
      DataSource = DSMaestro
    end
    object precio_caja_plas_tc: TBDEdit
      Left = 776
      Top = 317
      Width = 67
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itReal
      MaxDecimals = 3
      MaxLength = 5
      TabOrder = 33
      OnChange = cajas_tlChange
      DataField = 'precio_caja_plas_tc'
      DataSource = DSMaestro
    end
    object incoterm_tc: TBDEdit
      Left = 134
      Top = 173
      Width = 37
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 3
      TabOrder = 20
      OnChange = incoterm_tcChange
      DataField = 'incoterm_tc'
      DataSource = DSMaestro
    end
    object stIncoterm: TStaticText
      Left = 189
      Top = 175
      Width = 230
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 21
    end
    object plaza_incoterm_tc: TBDEdit
      Left = 557
      Top = 173
      Width = 135
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 30
      TabOrder = 22
      DataField = 'plaza_incoterm_tc'
      DataSource = DSMaestro
    end
    object cbx_excluir_posei_tc: TComboBox
      Left = 803
      Top = 36
      Width = 62
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 35
      Visible = False
      OnKeyDown = cbx_porte_bonny_tcKeyDown
      Items.Strings = (
        'Todos'
        'Si'
        'No')
    end
    object excluir_posei_tc: TDBCheckBox
      Left = 804
      Top = 38
      Width = 17
      Height = 18
      DataField = 'excluir_posei_tc'
      DataSource = DSMaestro
      TabOrder = 34
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
  end
  object PTenerife: TPanel
    Left = 0
    Top = 345
    Width = 1138
    Height = 126
    Align = alTop
    BevelInner = bvLowered
    Enabled = False
    TabOrder = 2
    Visible = False
    object BGBCategoria_tl: TBGridButton
      Left = 728
      Top = 53
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BGBCategoria_tlClick
      Control = categoria_tl
      Grid = RejillaFlotante
      GridAlignment = taDownLeft
      GridWidth = 280
      GridHeigth = 200
    end
    object Label7: TLabel
      Left = 65
      Top = 54
      Width = 85
      Height = 19
      AutoSize = False
      Caption = ' Marca'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label9: TLabel
      Left = 606
      Top = 54
      Width = 85
      Height = 19
      AutoSize = False
      Caption = ' Categor'#237'a'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label10: TLabel
      Left = 606
      Top = 75
      Width = 85
      Height = 19
      AutoSize = False
      Caption = ' Color'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label11: TLabel
      Left = 417
      Top = 75
      Width = 85
      Height = 19
      AutoSize = False
      Caption = ' Cajas'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object nom_gg: TLabel
      Left = 65
      Top = 75
      Width = 85
      Height = 19
      AutoSize = False
      Caption = ' Calibre'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label13: TLabel
      Left = 65
      Top = 33
      Width = 85
      Height = 19
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label14: TLabel
      Left = 606
      Top = 32
      Width = 85
      Height = 20
      AutoSize = False
      Caption = ' Art'#237'culo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBColor_tl: TBGridButton
      Left = 728
      Top = 74
      Width = 13
      Height = 21
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
      OnClick = BGBColor_tlClick
      Control = color_tl
      Grid = RejillaFlotante
      GridAlignment = taDownLeft
      GridWidth = 230
      GridHeigth = 200
    end
    object BGBProducto_tl: TBGridButton
      Left = 184
      Top = 32
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BGBProducto_tlClick
      Control = producto_tl
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object BGBMarca_tl: TBGridButton
      Left = 184
      Top = 53
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BGBMarca_tlClick
      Control = marca_tl
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object Label29: TLabel
      Left = 84
      Top = 96
      Width = 68
      Height = 19
      AutoSize = False
      Caption = ' Kilos'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBCalibre_tl: TBGridButton
      Left = 211
      Top = 74
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BGBCalibre_tlClick
      Control = calibre_tl
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object Label21: TLabel
      Left = 606
      Top = 12
      Width = 85
      Height = 19
      AutoSize = False
      Caption = ' Centro Origen '
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBCentro_origen_tl: TBGridButton
      Left = 728
      Top = 11
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BGBCentro_origen_tlClick
      Control = centro_origen_tl
      Grid = RejillaFlotante
      GridAlignment = taDownLeft
      GridWidth = 280
      GridHeigth = 200
    end
    object Label22: TLabel
      Left = 65
      Top = 12
      Width = 85
      Height = 19
      AutoSize = False
      Caption = ' Referencia'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label23: TLabel
      Left = 261
      Top = 12
      Width = 68
      Height = 19
      AutoSize = False
      Caption = ' Fecha'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BCBfecha_origen_tl: TBCalendarButton
      Left = 396
      Top = 11
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BCBfecha_origen_tlClick
      Control = fecha_origen_tl
      Calendar = Calendario
      CalendarAlignment = taDownLeft
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object Label16: TLabel
      Left = 742
      Top = 97
      Width = 60
      Height = 19
      AutoSize = False
      Caption = ' Tipo Palet'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBTipoPalet: TBGridButton
      Left = 804
      Top = 96
      Width = 13
      Height = 21
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = BGBTipoPaletClick
      Control = tipo_palet_tl
      Grid = RejillaFlotante
      GridAlignment = taDownLeft
      GridWidth = 280
      GridHeigth = 200
    end
    object Label17: TLabel
      Left = 608
      Top = 97
      Width = 85
      Height = 19
      AutoSize = False
      Caption = ' Palets'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label15: TLabel
      Left = 261
      Top = 76
      Width = 68
      Height = 19
      AutoSize = False
      Caption = ' Unds. caja'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label18: TLabel
      Left = 256
      Top = 97
      Width = 68
      Height = 19
      AutoSize = False
      Caption = ' Precio'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label19: TLabel
      Left = 417
      Top = 97
      Width = 68
      Height = 19
      AutoSize = False
      Caption = ' Importe'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object nomColorT: TStaticText
      Left = 742
      Top = 76
      Width = 271
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 17
    end
    object nomCategoriaT: TStaticText
      Left = 742
      Top = 55
      Width = 271
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 12
    end
    object nomMarcaT: TStaticText
      Left = 198
      Top = 55
      Width = 211
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 11
    end
    object nomEnvaseT: TStaticText
      Left = 769
      Top = 34
      Width = 220
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 8
    end
    object nomProductoT: TStaticText
      Left = 198
      Top = 34
      Width = 211
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 5
    end
    object producto_tl: TBDEdit
      Left = 154
      Top = 32
      Width = 30
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 3
      TabOrder = 4
      OnChange = producto_tlChange
      DataField = 'producto_tl'
      DataSource = DSDetalle2
    end
    object marca_tl: TBDEdit
      Left = 154
      Top = 53
      Width = 22
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 2
      TabOrder = 9
      OnChange = marca_tlChange
      DataField = 'marca_tl'
      DataSource = DSDetalle2
    end
    object color_tl: TBDEdit
      Left = 695
      Top = 74
      Width = 14
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 1
      TabOrder = 16
      OnChange = color_tlChange
      DataField = 'color_tl'
      DataSource = DSDetalle2
    end
    object categoria_tl: TBDEdit
      Left = 695
      Top = 53
      Width = 22
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 2
      TabOrder = 10
      OnChange = categoria_tlChange
      DataField = 'categoria_tl'
      DataSource = DSDetalle2
    end
    object calibre_tl: TBDEdit
      Left = 154
      Top = 74
      Width = 54
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      CharCase = ecNormal
      MaxLength = 6
      TabOrder = 13
      DataField = 'calibre_tl'
      DataSource = DSDetalle2
    end
    object kilos_tl: TBDEdit
      Left = 154
      Top = 100
      Width = 78
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itReal
      MaxLength = 8
      TabOrder = 18
      OnChange = kilos_tlChange
      DataField = 'kilos_tl'
      DataSource = DSDetalle2
    end
    object cajas_tl: TBDEdit
      Left = 507
      Top = 74
      Width = 67
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itInteger
      MaxLength = 5
      TabOrder = 15
      OnChange = cajas_tlChange
      DataField = 'cajas_tl'
      DataSource = DSDetalle2
    end
    object centro_origen_tl: TBDEdit
      Left = 695
      Top = 11
      Width = 14
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 1
      TabOrder = 2
      OnChange = centro_origen_tlChange
      DataField = 'centro_origen_tl'
      DataSource = DSDetalle2
    end
    object nomCentroFruta: TStaticText
      Left = 742
      Top = 13
      Width = 271
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 3
    end
    object ref_origen_tl: TBDEdit
      Left = 154
      Top = 11
      Width = 54
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itInteger
      MaxLength = 8
      TabOrder = 0
      OnExit = ref_origen_tlExit
      DataField = 'ref_origen_tl'
      DataSource = DSDetalle2
    end
    object fecha_origen_tl: TBDEdit
      Left = 331
      Top = 11
      Width = 65
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itDate
      TabOrder = 1
      DataField = 'fecha_origen_tl'
      DataSource = DSDetalle2
    end
    object tipo_palet_tl: TBDEdit
      Left = 780
      Top = 96
      Width = 22
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 2
      TabOrder = 22
      OnChange = tipo_palet_tlChange
      DataField = 'tipo_palet_tl'
      DataSource = DSDetalle2
    end
    object stTipo_palet_tl: TStaticText
      Left = 817
      Top = 98
      Width = 172
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 23
    end
    object palets_tl: TBDEdit
      Left = 695
      Top = 96
      Width = 34
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = empresa_tcRequiredTime
      MaxLength = 2
      TabOrder = 21
      OnChange = marca_tlChange
      DataField = 'palets_tl'
      DataSource = DSDetalle2
    end
    object unidades_caja_tl: TBDEdit
      Left = 331
      Top = 75
      Width = 29
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      InputType = itInteger
      TabOrder = 14
      DataField = 'unidades_caja_tl'
      DataSource = DSDetalle
    end
    object envase_tl: TcxDBTextEdit
      Left = 695
      Top = 32
      DataBinding.DataField = 'envase_tl'
      DataBinding.DataSource = DSDetalle2
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 9
      Properties.OnChange = envase_tlChange
      Style.BorderStyle = ebs3D
      Style.LookAndFeel.Kind = lfUltraFlat
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.Kind = lfUltraFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.Kind = lfUltraFlat
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.Kind = lfUltraFlat
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 6
      OnExit = envase_tlExit
      Width = 75
    end
    object ssEnvase: TSimpleSearch
      Left = 770
      Top = 31
      Width = 21
      Height = 21
      Hint = 'B'#250'squeda de Art'#237'culo'
      TabOrder = 7
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
      Enlace = envase_tl
      Tecla = 'F2'
      AntesEjecutar = ssEnvaseAntesEjecutar
      Concatenar = False
    end
    object precio_tl: TBDEdit
      Left = 331
      Top = 96
      Width = 58
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itReal
      MaxDecimals = 3
      MaxLength = 8
      TabOrder = 19
      OnChange = precio_tlChange
      DataField = 'precio_tl'
      DataSource = DSDetalle2
    end
    object importe_linea_tl: TBDEdit
      Left = 507
      Top = 96
      Width = 78
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = empresa_tcRequiredTime
      InputType = itReal
      MaxDecimals = 2
      Enabled = False
      MaxLength = 8
      TabOrder = 20
      DataField = 'importe_linea_tl'
      DataSource = DSDetalle2
      Modificable = False
    end
  end
  object pnlBotones: TPanel
    Left = 448
    Top = 6
    Width = 233
    Height = 50
    TabOrder = 1
    object btnGastos: TSpeedButton
      Left = 3
      Top = 3
      Width = 110
      Height = 21
      Caption = 'Ver &Gastos'
      OnClick = btnGastosClick
    end
    object btnSalidas: TSpeedButton
      Left = 116
      Top = 2
      Width = 110
      Height = 21
      Caption = 'Ver &Salidas'
      OnClick = btnSalidasClick
    end
    object btnAduanas: TSpeedButton
      Left = 116
      Top = 26
      Width = 110
      Height = 21
      Caption = 'Deposito Aduana'
      OnClick = btnAduanasClick
    end
    object btnActivar: TSpeedButton
      Left = 3
      Top = 27
      Width = 110
      Height = 21
      Caption = 'Activar'
      OnClick = btnActivarClick
    end
  end
  object Calendario: TBCalendario
    Left = 996
    Top = 259
    Width = 182
    Height = 158
    Date = 36864.621564363430000000
    TabOrder = 5
    Visible = False
    WeekNumbers = True
    BControl = fecha_tc
  end
  object RejillaFlotante: TBGrid
    Left = 1041
    Top = 254
    Width = 41
    Height = 57
    Color = clInfoBk
    DataSource = DMBaseDatos.DSQDespegables
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object DSDetalle: TDataSource
    DataSet = TTransitosL
    Left = 40
    Top = 416
  end
  object TTransitosL: TTable
    BeforeInsert = TTransitosLBeforeEdit
    BeforeEdit = TTransitosLBeforeEdit
    BeforePost = TTransitosLBeforePost
    OnCalcFields = TTransitosLCalcFields
    OnNewRecord = TTransitosLNewRecord
    DatabaseName = 'BDProyecto'
    IndexFieldNames = 'empresa_tl;centro_tl;referencia_tl;fecha_tl'
    MasterFields = 'empresa_tc;centro_tc;referencia_tc;fecha_tc'
    MasterSource = DSMaestro
    TableName = 'frf_transitos_l'
    Left = 8
    Top = 416
    object TTransitosLempresa_tl: TStringField
      FieldName = 'empresa_tl'
      FixedChar = True
      Size = 3
    end
    object TTransitosLcentro_tl: TStringField
      FieldName = 'centro_tl'
      FixedChar = True
      Size = 1
    end
    object TTransitosLreferencia_tl: TIntegerField
      FieldName = 'referencia_tl'
    end
    object TTransitosLfecha_tl: TDateField
      FieldName = 'fecha_tl'
    end
    object TTransitosLcentro_destino_tl: TStringField
      FieldName = 'centro_destino_tl'
      FixedChar = True
      Size = 1
    end
    object TTransitosLcentro_origen_tl: TStringField
      FieldName = 'centro_origen_tl'
      FixedChar = True
      Size = 1
    end
    object TTransitosLref_origen_tl: TIntegerField
      FieldName = 'ref_origen_tl'
    end
    object TTransitosLfecha_origen_tl: TDateField
      FieldName = 'fecha_origen_tl'
    end
    object TTransitosLproducto_tl: TStringField
      FieldName = 'producto_tl'
      FixedChar = True
      Size = 3
    end
    object TTransitosLenvase_tl: TStringField
      FieldName = 'envase_tl'
      FixedChar = True
      Size = 9
    end
    object TTransitosLenvaseold_tl: TStringField
      FieldName = 'envaseold_tl'
      FixedChar = True
      Size = 3
    end
    object TTransitosLmarca_tl: TStringField
      FieldName = 'marca_tl'
      FixedChar = True
      Size = 2
    end
    object TTransitosLcategoria_tl: TStringField
      FieldName = 'categoria_tl'
      FixedChar = True
      Size = 2
    end
    object TTransitosLcolor_tl: TStringField
      FieldName = 'color_tl'
      FixedChar = True
      Size = 1
    end
    object TTransitosLcalibre_tl: TStringField
      FieldName = 'calibre_tl'
      FixedChar = True
      Size = 10
    end
    object TTransitosLunidades_caja_tl: TIntegerField
      FieldName = 'unidades_caja_tl'
    end
    object TTransitosLcajas_tl: TIntegerField
      FieldName = 'cajas_tl'
    end
    object TTransitosLkilos_tl: TFloatField
      FieldName = 'kilos_tl'
    end
    object TTransitosLprecio_tl: TFloatField
      FieldName = 'precio_tl'
    end
    object TTransitosLimporte_linea_tl: TFloatField
      FieldName = 'importe_linea_tl'
    end
    object TTransitosLfederacion_tl: TStringField
      FieldName = 'federacion_tl'
      FixedChar = True
      Size = 1
    end
    object TTransitosLcosechero_tl: TSmallintField
      FieldName = 'cosechero_tl'
    end
    object TTransitosLplantacion_tl: TSmallintField
      FieldName = 'plantacion_tl'
    end
    object TTransitosLanyo_semana_tl: TStringField
      FieldName = 'anyo_semana_tl'
      FixedChar = True
      Size = 6
    end
    object TTransitosLtipo_palet_tl: TStringField
      FieldName = 'tipo_palet_tl'
      FixedChar = True
      Size = 2
    end
    object TTransitosLpalets_tl: TIntegerField
      FieldName = 'palets_tl'
    end
    object TTransitosLdesEnvase: TStringField
      FieldKind = fkCalculated
      FieldName = 'desEnvase'
      Calculated = True
    end
  end
  object QTransitosC: TQuery
    BeforePost = QTransitosCBeforePost
    AfterPost = QTransitosCAfterPost
    AfterScroll = QTransitosCAfterScroll
    OnNewRecord = QTransitosCNewRecord
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_transitos_c'
      'ORDER BY empresa_tc')
    Top = 296
  end
  object DSMaestro: TDataSource
    DataSet = QTransitosC
    OnStateChange = DSMaestroStateChange
    Left = 32
    Top = 312
  end
  object DSDetalle2: TDataSource
    OnStateChange = DSDetalle2StateChange
    Left = 40
    Top = 449
  end
end
