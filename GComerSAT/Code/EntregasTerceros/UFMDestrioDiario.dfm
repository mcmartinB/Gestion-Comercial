object FMDestrioDiario: TFMDestrioDiario
  Left = 473
  Top = 351
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  DESTRIO DIARIO'
  ClientHeight = 475
  ClientWidth = 600
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
    Width = 600
    Height = 475
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label2: TLabel
      Left = 40
      Top = 58
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Centro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 40
      Top = 36
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa: TBGridButton
      Left = 159
      Top = 35
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
      Control = empresa_de
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object BGBCentro: TBGridButton
      Left = 159
      Top = 57
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
      Control = empresa_de
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object LFecha: TLabel
      Left = 40
      Top = 103
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Fecha'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BCBFecha: TBCalendarButton
      Left = 201
      Top = 102
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
      Control = fecha_de
      Calendar = CalendarioFlotante
      CalendarAlignment = taDownRight
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object lblNombre1: TLabel
      Left = 40
      Top = 148
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Destrio'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre2: TLabel
      Left = 40
      Top = 80
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Producto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBProducto: TBGridButton
      Left = 159
      Top = 79
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
      Control = empresa_de
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object lblNombre3: TLabel
      Left = 176
      Top = 125
      Width = 80
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Cantidad Total'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre6: TLabel
      Left = 258
      Top = 125
      Width = 80
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Destrio'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre7: TLabel
      Left = 340
      Top = 125
      Width = 49
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      Caption = '%'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre8: TLabel
      Left = 126
      Top = 124
      Width = 47
      Height = 19
      AutoSize = False
      Caption = 'Unidad'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object DBText1: TDBText
      Left = 340
      Top = 149
      Width = 49
      Height = 17
      Alignment = taRightJustify
      DataField = 'porcentaje_de'
      DataSource = DSMaestro
    end
    object DBGMaestro: TDBGrid
      Left = 40
      Top = 171
      Width = 526
      Height = 273
      TabStop = False
      DataSource = DSMaestro
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 11
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'empresa_de'
          Title.Alignment = taCenter
          Title.Caption = 'Empresa'
          Width = 55
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'centro_de'
          Title.Alignment = taCenter
          Title.Caption = 'Centro'
          Width = 55
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'fecha_de'
          Title.Alignment = taCenter
          Title.Caption = 'Fecha'
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'producto_de'
          Title.Alignment = taCenter
          Title.Caption = 'Poducto'
          Width = 55
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'unidades_de'
          Title.Alignment = taCenter
          Title.Caption = 'Cantidad'
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'unidad_de'
          Title.Alignment = taCenter
          Title.Caption = 'Unidad'
          Width = 55
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'destrio_de'
          Title.Alignment = taCenter
          Title.Caption = 'Destrio'
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'porcentaje_de'
          Title.Alignment = taCenter
          Title.Caption = '%'
          Width = 55
          Visible = True
        end>
    end
    object empresa_de: TBDEdit
      Left = 126
      Top = 35
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de empresa es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = empresa_deChange
      DataField = 'empresa_de'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object stEmpresa: TStaticText
      Left = 174
      Top = 37
      Width = 215
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object centro_de: TBDEdit
      Left = 126
      Top = 57
      Width = 17
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del centro es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      TabOrder = 2
      OnChange = centro_deChange
      DataField = 'centro_de'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object stCentro: TStaticText
      Left = 174
      Top = 59
      Width = 215
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 3
    end
    object fecha_de: TBDEdit
      Tag = 999
      Left = 126
      Top = 102
      Width = 73
      Height = 21
      ColorEdit = clMoneyGreen
      ColorDisable = cl3DLight
      Required = True
      RequiredMsg = 'La fecha de la compra es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itDate
      MaxLength = 10
      TabOrder = 6
      DataField = 'fecha_de'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object unidades_de: TBDEdit
      Left = 176
      Top = 147
      Width = 80
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El n'#250'mero de la compra es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 12
      TabOrder = 8
      DataField = 'unidades_de'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object producto_de: TBDEdit
      Left = 126
      Top = 79
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del centro es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 4
      OnChange = producto_deChange
      DataField = 'producto_de'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object stProducto: TStaticText
      Left = 174
      Top = 81
      Width = 215
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 5
    end
    object destrio_de: TBDEdit
      Left = 258
      Top = 147
      Width = 80
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El n'#250'mero de la compra es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 12
      TabOrder = 9
      DataField = 'destrio_de'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object unidad_de: TBDEdit
      Left = 126
      Top = 171
      Width = 47
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El n'#250'mero de la compra es de obligada inserci'#243'n.'
      OnRequiredTime = RequiredTime
      Visible = False
      ReadOnly = True
      MaxLength = 1
      TabOrder = 10
      OnChange = unidad_deChange
      DataField = 'unidad_de'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object cbxUnidad: TComboBox
      Left = 126
      Top = 147
      Width = 47
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 7
      Text = 'KGS'
      OnChange = cbxUnidadChange
      Items.Strings = (
        'KGS'
        'UND')
    end
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
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    BControl = empresa_de
  end
  object CalendarioFlotante: TBCalendario
    Left = 574
    Top = 20
    Width = 177
    Height = 136
    AutoSize = True
    Date = 36717.547034756940000000
    ShowToday = False
    TabOrder = 1
    Visible = False
    WeekNumbers = True
  end
  object DSMaestro: TDataSource
    DataSet = QDestrioDiario
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
  object QDestrioDiario: TQuery
    OnCalcFields = QDestrioDiarioCalcFields
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * '
      'FROM frf_destrio_diario'
      '')
    Left = 168
    Top = 9
    object QDestrioDiarioempresa_de: TStringField
      FieldName = 'empresa_de'
      Origin = 'COMERCIALIZACION.frf_destrio_diario.empresa_de'
      FixedChar = True
      Size = 3
    end
    object QDestrioDiariocentro_de: TStringField
      FieldName = 'centro_de'
      Origin = 'COMERCIALIZACION.frf_destrio_diario.centro_de'
      FixedChar = True
      Size = 1
    end
    object QDestrioDiarioproducto_de: TStringField
      FieldName = 'producto_de'
      Origin = 'COMERCIALIZACION.frf_destrio_diario.producto_de'
      FixedChar = True
      Size = 1
    end
    object QDestrioDiariofecha_de: TDateField
      FieldName = 'fecha_de'
      Origin = 'COMERCIALIZACION.frf_destrio_diario.fecha_de'
    end
    object QDestrioDiariounidad_de: TStringField
      FieldName = 'unidad_de'
      Origin = 'COMERCIALIZACION.frf_destrio_diario.unidad_de'
      FixedChar = True
      Size = 1
    end
    object QDestrioDiariounidades_de: TFloatField
      FieldName = 'unidades_de'
      Origin = 'COMERCIALIZACION.frf_destrio_diario.unidades_de'
    end
    object QDestrioDiariodestrio_de: TFloatField
      FieldName = 'destrio_de'
      Origin = 'COMERCIALIZACION.frf_destrio_diario.destrio_de'
    end
    object QDestrioDiarioporcentaje_de: TFloatField
      FieldKind = fkCalculated
      FieldName = 'porcentaje_de'
      Calculated = True
    end
  end
end
