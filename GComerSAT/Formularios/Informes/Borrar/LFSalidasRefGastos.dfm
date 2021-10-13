object FLSalidasRefGastos: TFLSalidasRefGastos
  Left = 277
  Top = 461
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'SALIDAS POR REFERENCIA DE GASTOS'
  ClientHeight = 581
  ClientWidth = 800
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
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 581
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 671
      Top = 29
      Width = 74
      Height = 25
      Action = BAceptar
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C00001F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C007C007C00001F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C007C007C00001F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C007C007C007C007C007C00001F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C007C007C007C007C007C007C00001F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7CEF3D007C007C00001F7C007C007C007C00001F7C1F7C1F7C
        1F7C1F7C1F7CEF3D007C00001F7C1F7C1F7C1F7C007C007C00001F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C007C007C00001F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C007C00001F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C007C00001F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CEF3D007C0000
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CEF3D007C
        00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        007C007C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      ParentShowHint = False
      ShowHint = True
    end
    object SpeedButton2: TSpeedButton
      Left = 671
      Top = 53
      Width = 74
      Height = 25
      Action = BCancelar
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C0000FF7F1F7C1F7C1F7C1F7C0000FF7F1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C000000000000FF7F1F7C1F7C1F7C1F7C1F7C1F7C
        0000FF7F1F7C1F7C1F7C1F7C000000000000FF7F1F7C1F7C1F7C1F7C1F7C0000
        FF7F1F7C1F7C1F7C1F7C1F7C1F7C000000000000FF7F1F7C1F7C1F7C00000000
        FF7F1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000000000FF7F1F7C00000000FF7F
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000000000000000FF7F1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000000000FF7F1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000000000000000FF7F1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000000000FF7F1F7C0000FF7F1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C0000000000000000FF7F1F7C1F7C1F7C00000000
        FF7F1F7C1F7C1F7C1F7C0000000000000000FF7F1F7C1F7C1F7C1F7C1F7C0000
        0000FF7F1F7C1F7C1F7C00000000FF7F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        00000000FF7F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      ParentShowHint = False
      ShowHint = True
    end
    object SpeedButton3: TSpeedButton
      Left = 671
      Top = 77
      Width = 74
      Height = 25
      Action = AImprimir
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C000000000000000000000000000000000000000000000000
        000000001F7C0000F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
        F75EF75E00000000F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
        F75EF75E00000000000000000000000000000000000000000000000000000000
        0000000000000000FF7FF75EFF7FF75EFF7FF75EFF7FF75EFF7FF75EFF7FF75E
        FF7FF75E00000000F75EFF7FF75EFF7FF75EFF7FF75EFF7FF75EFF7FF75EFF7F
        007CFF7F00000000FF7FF75EFF7FF75EFF7FF75EFF7FF75EFF7FF75EFF7FF75E
        FF7FF75E00000000000000000000000000000000000000000000000000000000
        0000000000001F7C1F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
        1F7C1F7C1F7C1F7C1F7C1F7C0000FF7F0000000000000000FF7F0000FF7F0000
        1F7C1F7C1F7C1F7C1F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
        1F7C1F7C1F7C1F7C1F7C1F7C0000FF7F00000000FF7F00000000000000000000
        1F7C1F7C1F7C1F7C1F7C1F7C0000FF7FFF7FFF7FFF7F0000FF7FFF7F00001F7C
        1F7C1F7C1F7C1F7C1F7C1F7C0000FF7F0000F75EFF7F0000FF7F00001F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C0000FF7FFF7FFF7FFF7F000000001F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C0000000000000000000000001F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      ParentShowHint = False
      ShowHint = True
    end
    object Label1: TLabel
      Left = 35
      Top = 62
      Width = 59
      Height = 13
      Caption = 'Ordenar por '
    end
    object LRegistros: TLabel
      Left = 132
      Top = 86
      Width = 48
      Height = 13
      Caption = '0 registros'
    end
    object Bevel1: TBevel
      Left = 314
      Top = 31
      Width = 353
      Height = 72
    end
    object ERef: TBEdit
      Left = 35
      Top = 31
      Width = 89
      Height = 21
      MaxLength = 10
      TabOrder = 0
    end
    object ComboBox: TComboBox
      Left = 132
      Top = 31
      Width = 171
      Height = 21
      Style = csDropDownList
      DropDownCount = 3
      ItemHeight = 13
      TabOrder = 1
      OnChange = ComboBoxChange
      Items.Strings = (
        'Referencia Factura de Gastos'
        'Numero de Albaran')
    end
    object DBGrid: TDBGrid
      Left = 2
      Top = 128
      Width = 796
      Height = 451
      TabStop = False
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = DataSource
      DefaultDrawing = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clNavy
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      OnCellClick = DBGridCellClick
      OnDrawColumnCell = DBGridDrawColumnCell
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'fecha_rg'
          Title.Alignment = taCenter
          Title.Caption = 'Fecha'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'albaran_rg'
          Title.Alignment = taCenter
          Title.Caption = 'Albar'#225'n'
          Width = 81
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'referencia_rg'
          Title.Alignment = taCenter
          Title.Caption = 'Referencia'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'matricula_rg'
          Title.Alignment = taCenter
          Title.Caption = 'Matr'#237'cula Cami'#243'n'
          Width = 148
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'tipo_rg'
          Title.Alignment = taCenter
          Title.Caption = 'Tipo'
          Width = 49
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'des_tipo_rg'
          Title.Alignment = taCenter
          Title.Caption = 'Descripci'#243'n'
          Width = 228
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'importe_rg'
          Title.Alignment = taCenter
          Title.Caption = 'Importe'
          Visible = True
        end>
    end
    object ComboBoxOrden: TComboBox
      Left = 132
      Top = 58
      Width = 171
      Height = 21
      Style = csDropDownList
      DropDownCount = 5
      ItemHeight = 13
      TabOrder = 4
      OnChange = ComboBoxOrdenChange
      Items.Strings = (
        'Fecha'
        'Albar'#225'n'
        'Referencia'
        'Matr'#237'cula'
        'Tipo')
    end
    object Periodo: TCheckBox
      Left = 317
      Top = 36
      Width = 97
      Height = 17
      Caption = 'Periodo Albar'#225'n'
      TabOrder = 2
      OnClick = PeriodoClick
      OnKeyPress = PeriodoKeyPress
    end
    object Panel1: TPanel
      Left = 317
      Top = 56
      Width = 345
      Height = 44
      TabOrder = 3
      object BCBHasta: TBCalendarButton
        Left = 308
        Top = 13
        Width = 13
        Height = 21
        Glyph.Data = {
          42020000424D4202000000000000420000002800000010000000100000000100
          1000030000000002000000000000000000000000000000000000007C0000E003
          00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000000000000000001F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000000000000000000000001F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C}
        OnClick = MuestraCalendario
        Control = Hasta
        Calendar = BCalendario1
        CalendarAlignment = taCenterLeft
        CalendarWidth = 197
        CalendarHeigth = 153
      end
      object BCBDesde: TBCalendarButton
        Left = 154
        Top = 13
        Width = 13
        Height = 21
        Glyph.Data = {
          42020000424D4202000000000000420000002800000010000000100000000100
          1000030000000002000000000000000000000000000000000000007C0000E003
          00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000000000000000001F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000000000000000000000001F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C}
        OnClick = MuestraCalendario
        Control = Desde
        Calendar = BCalendario1
        CalendarAlignment = taCenterLeft
        CalendarWidth = 197
        CalendarHeigth = 153
      end
      object StaticText3: TStaticText
        Left = 23
        Top = 15
        Width = 48
        Height = 17
        AutoSize = False
        Caption = ' Desde'
        Color = cl3DLight
        ParentColor = False
        TabOrder = 2
      end
      object Desde: TBDEdit
        Left = 73
        Top = 13
        Width = 81
        Height = 21
        InputType = itDate
        Enabled = False
        TabOrder = 0
        OnKeyUp = EventoKeyUp
      end
      object StaticText4: TStaticText
        Left = 175
        Top = 15
        Width = 48
        Height = 17
        AutoSize = False
        Caption = ' Hasta'
        Color = cl3DLight
        ParentColor = False
        TabOrder = 3
      end
      object Hasta: TBDEdit
        Left = 227
        Top = 13
        Width = 81
        Height = 21
        InputType = itDate
        Enabled = False
        TabOrder = 1
        OnKeyUp = EventoKeyUp
      end
    end
  end
  object BCalendario1: TBCalendario
    Left = 312
    Top = 256
    Width = 197
    Height = 153
    Date = 37077.5525971296
    TabOrder = 1
    Visible = False
  end
  object ListaAcciones: TActionList
    Images = DMBaseDatos.ImgBarraHerramientas
    Left = 69
    Top = 1
    object BAceptar: TAction
      Caption = 'Buscar'
      ImageIndex = 1
      ShortCut = 112
      OnExecute = BBAceptarClick
    end
    object BCancelar: TAction
      Caption = 'Salir'
      ImageIndex = 2
      ShortCut = 27
      OnExecute = BBCancelarClick
    end
    object DesplegarLista: TAction
      Caption = 'DesplegarLista'
      ShortCut = 113
      OnExecute = DesplegarListaExecute
    end
    object AImprimir: TAction
      Caption = 'Imprimir'
      ImageIndex = 19
      ShortCut = 16464
      OnExecute = AImprimirExecute
    end
  end
  object Table: TTable
    DatabaseName = 'BDProyecto'
    IndexFieldNames = 'albaran_rg'
    ReadOnly = True
    Left = 32
    Top = 184
    object Tablereferencia_rg: TStringField
      FieldName = 'referencia_rg'
      Size = 10
    end
    object Tablealbaran_rg: TIntegerField
      FieldName = 'albaran_rg'
    end
    object Tablefecha_rg: TDateField
      FieldName = 'fecha_rg'
    end
    object Tablematricula_rg: TStringField
      FieldName = 'matricula_rg'
      Size = 15
    end
    object Tabletipo_rg: TStringField
      FieldName = 'tipo_rg'
      Size = 3
    end
    object Tabledes_tipo_rg: TStringField
      FieldKind = fkLookup
      FieldName = 'des_tipo_rg'
      LookupDataSet = TableTipoGastos
      LookupKeyFields = 'tipo_tg'
      LookupResultField = 'descripcion_tg'
      KeyFields = 'tipo_rg'
      Size = 30
      Lookup = True
    end
    object Tableimporte_rg: TFloatField
      FieldName = 'importe_rg'
    end
  end
  object DataSource: TDataSource
    DataSet = Table
    Left = 72
    Top = 184
  end
  object TableTipoGastos: TTable
    DatabaseName = 'BDProyecto'
    TableName = 'frf_tipo_gastos'
    Left = 32
    Top = 224
  end
end
