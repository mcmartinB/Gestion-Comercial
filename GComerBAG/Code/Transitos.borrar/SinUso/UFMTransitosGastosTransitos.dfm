object FMTransitosGastosTransitos: TFMTransitosGastosTransitos
  Left = 292
  Top = 258
  ActiveControl = rejilla
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    SELECCIONA LAS SALIDAS DEL SERVICIO'
  ClientHeight = 384
  ClientWidth = 872
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblNombre4: TLabel
    Left = 12
    Top = 14
    Width = 221
    Height = 20
    AutoSize = False
    Caption = 'Salidas Seleccionadas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblNombre1: TLabel
    Left = 633
    Top = 183
    Width = 221
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Salidas Pendientes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblMatricula: TLabel
    Left = 357
    Top = 187
    Width = 45
    Height = 13
    Caption = 'Matr'#237'cula'
  end
  object rejilla: TDBGrid
    Left = 10
    Top = 211
    Width = 850
    Height = 155
    TabStop = False
    Color = clBtnFace
    DataSource = DSSalidasPosibles
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = rejillaDblClick
  end
  object DBGrid1: TDBGrid
    Left = 10
    Top = 41
    Width = 850
    Height = 131
    TabStop = False
    DataSource = DSEntregasSeleccionadas
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
  end
  object btnCerrar: TButton
    Left = 759
    Top = 11
    Width = 101
    Height = 25
    Caption = 'Salir'
    TabOrder = 2
    OnClick = btnCerrarClick
  end
  object btnAnyadir: TButton
    Left = 220
    Top = 181
    Width = 130
    Height = 25
    Caption = '<<-- Seleccionar Salida'
    TabOrder = 3
    OnClick = btnAnyadirClick
  end
  object btnBorrar: TButton
    Left = 220
    Top = 12
    Width = 130
    Height = 25
    Caption = 'Borrar Salida -->>'
    TabOrder = 4
    OnClick = btnBorrarClick
  end
  object edtMatricula: TEdit
    Left = 411
    Top = 183
    Width = 147
    Height = 21
    TabOrder = 5
    Text = 'edtMatricula'
  end
  object btnFiltar: TButton
    Left = 562
    Top = 181
    Width = 101
    Height = 25
    Caption = 'Filtrar Matr'#237'cula'
    TabOrder = 6
    OnClick = btnFiltarClick
  end
  object DSSalidasPosibles: TDataSource
    DataSet = QSalidasPosibles
    Left = 442
    Top = 195
  end
  object QSalidasPosibles: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT * '
      'FROM frf_compras'
      '')
    Left = 402
    Top = 196
  end
  object QSalidasSeleccionadas: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT * '
      'FROM frf_compras'
      '')
    Left = 74
    Top = 106
  end
  object DSEntregasSeleccionadas: TDataSource
    DataSet = QSalidasSeleccionadas
    Left = 106
    Top = 105
  end
  object QSBorrar: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT * '
      'FROM frf_compras'
      '')
    Left = 74
    Top = 146
  end
  object QSAnyadir: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'SELECT * '
      'FROM frf_compras'
      '')
    Left = 402
    Top = 228
  end
end
