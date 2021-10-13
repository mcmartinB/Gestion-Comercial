object FMFederacionSalidas: TFMFederacionSalidas
  Left = 329
  Top = 262
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  ASIGNAR FEDERACI'#211'N '
  ClientHeight = 544
  ClientWidth = 858
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 858
    Height = 121
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 42
      Top = 21
      Width = 41
      Height = 13
      Caption = 'Empresa'
    end
    object Label2: TLabel
      Left = 42
      Top = 66
      Width = 43
      Height = 13
      Caption = 'Producto'
    end
    object Label3: TLabel
      Left = 42
      Top = 89
      Width = 64
      Height = 13
      Caption = 'Fecha Desde'
    end
    object lblEmpresa: TLabel
      Left = 160
      Top = 21
      Width = 51
      Height = 13
      Caption = 'lblEmpresa'
    end
    object lblProducto: TLabel
      Left = 160
      Top = 66
      Width = 53
      Height = 13
      Caption = 'lblProducto'
    end
    object Label4: TLabel
      Left = 201
      Top = 89
      Width = 28
      Height = 13
      Caption = 'Hasta'
    end
    object BCBDesde: TBCalendarButton
      Left = 180
      Top = 85
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
      OnClick = BCBDesdeClick
      Control = eFechaDesde
      Calendar = CalendarioFlotante
      CalendarAlignment = taDownLeft
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object BCBHasta: TBCalendarButton
      Left = 315
      Top = 85
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
      OnClick = BCBDesdeClick
      Control = eFechaHasta
      Calendar = CalendarioFlotante
      CalendarAlignment = taDownLeft
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object Label5: TLabel
      Left = 42
      Top = 44
      Width = 65
      Height = 13
      Caption = 'Centro Origen'
    end
    object lblCentro: TLabel
      Left = 160
      Top = 44
      Width = 41
      Height = 13
      Caption = 'lblCentro'
    end
    object eFechaDesde: TBEdit
      Left = 114
      Top = 85
      Width = 65
      Height = 21
      InputType = itDate
      TabOrder = 3
      OnChange = eFechaDesdeChange
    end
    object eEmpresa: TBEdit
      Left = 114
      Top = 17
      Width = 35
      Height = 21
      TabStop = False
      ColorDisable = clBtnFace
      Required = True
      MaxLength = 3
      TabOrder = 0
      OnChange = eEmpresaChange
    end
    object eProducto: TBEdit
      Left = 114
      Top = 62
      Width = 35
      Height = 21
      MaxLength = 3
      TabOrder = 2
      OnChange = eProductoChange
    end
    object eFechaHasta: TBEdit
      Left = 249
      Top = 85
      Width = 65
      Height = 21
      InputType = itDate
      ReadOnly = True
      TabOrder = 4
    end
    object eCentro: TBEdit
      Left = 114
      Top = 40
      Width = 25
      Height = 21
      MaxLength = 1
      TabOrder = 1
      OnChange = eCentroChange
    end
  end
  object PBotonera: TPanel
    Left = 548
    Top = 16
    Width = 297
    Height = 41
    TabOrder = 1
    object btnSinAsignar: TSpeedButton
      Left = 12
      Top = 8
      Width = 85
      Height = 22
      GroupIndex = 1
      Down = True
      Caption = '&Sin Asignar'
      OnClick = btnSinAsignarClick
    end
    object btnAsignada: TSpeedButton
      Left = 104
      Top = 8
      Width = 85
      Height = 22
      GroupIndex = 1
      Caption = '&Asignada'
      OnClick = btnAsignadaClick
    end
    object btnTodos: TSpeedButton
      Left = 196
      Top = 8
      Width = 85
      Height = 22
      GroupIndex = 1
      Caption = '&Todos'
      OnClick = btnTodosClick
    end
  end
  object Panel1: TPanel
    Left = 548
    Top = 61
    Width = 297
    Height = 41
    TabOrder = 2
    object btnRefrescar: TButton
      Left = 196
      Top = 8
      Width = 85
      Height = 22
      Caption = '&Refrescar'
      TabOrder = 0
      TabStop = False
      OnClick = btnRefrescarClick
    end
    object rbExporta: TRadioButton
      Left = 12
      Top = 11
      Width = 85
      Height = 17
      Caption = 'Exportaci'#243'n'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = btnRefrescarClick
    end
    object rbNacional: TRadioButton
      Left = 104
      Top = 11
      Width = 85
      Height = 17
      Caption = 'Nacional'
      TabOrder = 2
      OnClick = btnRefrescarClick
    end
  end
  object PanelTotales: TPanel
    Left = 736
    Top = 121
    Width = 122
    Height = 423
    Align = alRight
    Enabled = False
    TabOrder = 4
    object lbxLeyenda: TListBox
      Left = 1
      Top = 1
      Width = 120
      Height = 192
      Align = alTop
      ItemHeight = 13
      TabOrder = 0
    end
    object lbxKilosTotales: TListBox
      Left = 1
      Top = 193
      Width = 120
      Height = 229
      Align = alClient
      ItemHeight = 13
      TabOrder = 1
    end
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 121
    Width = 736
    Height = 423
    Align = alClient
    DataSource = DSQuery
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnColEnter = DBGridColEnter
    OnEnter = DBGridColEnter
    OnTitleClick = DBGridTitleClick
    Columns = <
      item
        Alignment = taCenter
        Color = 15329769
        Expanded = False
        FieldName = 'fecha'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'FECHA'
        Width = 59
        Visible = True
      end
      item
        Alignment = taCenter
        Color = 15329769
        Expanded = False
        FieldName = 'tipo'
        ReadOnly = True
        Title.Caption = ' '
        Width = 15
        Visible = True
      end
      item
        Alignment = taCenter
        Color = 15329769
        Expanded = False
        FieldName = 'referencia'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'REF.'
        Visible = True
      end
      item
        Alignment = taCenter
        Color = 15329769
        Expanded = False
        FieldName = 'cliente'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'CLIENTE'
        Width = 48
        Visible = True
      end
      item
        Color = 15329769
        Expanded = False
        FieldName = 'desCliente'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'NOMBRE'
        Width = 195
        Visible = True
      end
      item
        Alignment = taCenter
        Color = 15329769
        Expanded = False
        FieldName = 'origen'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'ORIGEN'
        Width = 59
        Visible = True
      end
      item
        Alignment = taRightJustify
        Color = 15329769
        Expanded = False
        FieldName = 'kilos'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'KILOS'
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'federacion'
        PickList.Strings = (
          '1'
          '2')
        Title.Alignment = taCenter
        Title.Caption = 'FEDERA.'
        Visible = True
      end
      item
        Color = 15329769
        Expanded = False
        FieldName = 'vehiculo'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'VEH'#205'CULO'
        Width = 120
        Visible = True
      end>
  end
  object CalendarioFlotante: TBCalendario
    Left = 80
    Top = 192
    Width = 182
    Height = 152
    Date = 36823.508260578700000000
    ShowToday = False
    TabOrder = 5
    Visible = False
    WeekNumbers = True
  end
  object Query: TQuery
    BeforePost = QueryBeforePost
    AfterPost = QueryAfterPost
    DatabaseName = 'BDProyecto'
    Filter = 'ver = '#39'S'#39
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM FRF_CENTROS')
    Left = 8
  end
  object DSQuery: TDataSource
    DataSet = Query
    Left = 8
    Top = 32
  end
  object QTotalesFederacion: TQuery
    BeforePost = QueryBeforePost
    DatabaseName = 'BDProyecto'
    Filtered = True
    SQL.Strings = (
      'SELECT * FROM FRF_CENTROS')
    Left = 8
    Top = 64
  end
end
